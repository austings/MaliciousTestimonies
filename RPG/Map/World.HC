
U0 SetCombatStage1(){
 mc->turnIndex=1;
 mc->combatMenuStage=STAGE_1;
 mc->combatMenuSelection=CMS_ENE1;

}

U0 TickTile(I64 i,I64 j, Actor *p)
{
 if(camera->topLR+i<wY&&camera->topLR+i>=0){
  I64 screenX = i*camera->dividX+camera->cameraOffSetX;

  I64 obj= GetTensorObj(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
  I64 npc =GetTensorNPC(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);
  I64 wlvl= GetTensorWaterLevel(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
  if(npc!=-1){
   Actor *toUpdate = GetNPC(npc);    
   if(npc!=PLAYER){
    if(mc->combatON==FALSE   && 
    toUpdate->ai_script==AI_DEFAULT&&
    toUpdate->status1!=DEAD_STATUS && //(enemy)
    Abs((p->x)-(toUpdate->x))<=AGGRO_DIS&& //(aggro distance)
    Abs((p->y)-(toUpdate->y))<=AGGRO_DIS  )
    {
     PrintDevMessage("NOTDEAD");
     CombatQueInit(toUpdate);
    }
   }
  }
 }
}

U0 TickCombat(I64 i,I64 j,Actor *p)
{
 //Tick Combat
 switch(mc->combatMenuStage){
  case STAGE_0:
   switch(mc->combatMenuSelection){
    case CMS_MOVE_DONE:
     mc->turnIndex++;
     if(mc->turnIndex>1){
       SetCombatStage1;
      }
    break;
    case CMS_STRIKE_DONE:
     switch(p->sword){
      case IT_FIST:
      default: //fist
       mc->turnIndex++;
       if(mc->turnIndex>3){
        RemoveHealth(mc->target,p->str);
        SetCombatStage1;
       }//mc turnindex
      break;
     }//switch p sword    break;
    case CMS_PRAYER_DONE:
     switch(mc->prayerToCast){
      case SP_HEAL: //lay on hands
       if(mc->turnIndex==1) { CastPrayer(p);}
       mc->turnIndex++;
       if(mc->turnIndex>3){
        AddHealth(mc->target,p->int);
        RemoveMana(p,prayers->list[mc->prayerToCast]->cost);
        SetCombatStage1;
       }
      break;
     }//switch prayer
    break;
    case CS_FLEE:
     mc->turnIndex++;
     if(mc->turnIndex>3){
      U16 r = RandU16();
      mc->turnIndex=1;
      // 80% chance-returns a number from 0 to 65535 (inclusive).
      // 80% of 65536 = 52428.8, so comparing like this
      if (r < 0.8 * 65536){
       CombatQueFree();
       mc->combatON=FALSE;
       mc->combatMenuStage=STAGE_2;
 
      } 
      else{
       SetCombatStage1;
      }
     }
    break;
   }
  break;
  case STAGE_1:
   switch(mc->combatMenuSelection){
    case CMS_ENE1:
     mc->turnIndex++;
//     AddDirective(ARCSTRIKE,p);
    break;
    case CMS_ENE2:
     mc->turnIndex++;
    break;
    case CMS_ENE3:
    EnemyEndTurn(i, p);
    break;
   }
  break;
  case STAGE_2:
    mc->combatMenuStage=STAGE_0;
    mc->combatMenuSelection=CMS_MOVE;
    mc->combatQueId=PLAYER; 
   //return que pointer to player
  
  break;
 }

 //if(mc->combatON==FALSE)
 // EndProceduralAnimations; 

}

U0 TickInteract(I64 i, I64 j, Actor *p)
{
 if(mc->lootedSwitch)
 {
  mc->displayInventory=TRUE;
 }
}

//updates the matrix model based on taken actions
U0 WorldTick(I64 i, I64 j, Actor *p){

 TickCombat(i,j,p);

 TickInteract(i,j,p);
 //Tick World
 for(j=-1;j<12;j++){
  if(camera->topUD+j<wX&&camera->topUD+j>=0){
   I64 screenY = j*camera->dividY+camera->cameraOffSetY; 
   for(i=-1;i<12;i++){
    TickTile(i,j,p);
   }
  }
 }
 player = p;


}

