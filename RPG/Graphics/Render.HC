


I64 GetActorScreenX(Actor *a, I64 npcox, I64 i, Bool Player=TRUE)
{
 if(Player){
  if(camera->topLR==0||camera->topLR==wX-11)
   npcox =GetWalkOffsetX(a->walking);
  a->screenX = i*camera->dividX-13+
                          npcox+camera->cameraOffSetX;
  return a->screenX;
 }else
 {
   npcox=GetWalkOffsetX(a->walking), 
   a->screenX = i*camera->dividX-13+npcox+(2*camera->cameraOffSetX);
  return a->screenX;
 }
}

I64 GetActorScreenY(Actor *a, I64 npcoy, I64 j,Bool Player=TRUE)
{
 if(Player){
  if(camera->topUD==0||camera->topUD==wY-11)
   npcoy =GetWalkOffsetY(a->walking);
  a->screenY = j*camera->dividY-42+
                          npcoy+camera->cameraOffSetY;
  return a->screenY;
 }else
 {
  npcoy=GetWalkOffsetY(a->walking);
  a->screenY = j*camera->dividY-42+npcoy+camera->cameraOffSetY;
  return a->screenY;
 }
}



U0 StartCameraPan(CDC *dc,Actor *p)
{
 // background world x pan
 if(camera->topLR==0||camera->topLR==wX-11){
  if(camera->cameraOffSetX!=0){
   if(camera->cameraOffSetX>0){
    camera->cameraOffSetX=Max(0,camera->cameraOffSetX-1);
   }
   else{
    camera->cameraOffSetX=Min(0,camera->cameraOffSetX+1); 
   }
  }
 }
 else{
  camera->cameraOffSetX=-GetWalkOffsetX(p->walking);
 }
 //y pan
 if(camera->topUD==0||camera->topUD==wY-11){
  if(camera->cameraOffSetY!=0){
   if(camera->cameraOffSetY>0)
    camera->cameraOffSetY=Max(0,camera->cameraOffSetY-1);
   else
    camera->cameraOffSetY=Min(0,camera->cameraOffSetY+1);
  }
 }
 else{
  camera->cameraOffSetY=-GetWalkOffsetY(p->walking);
 }
}

U0 CombatQueInit(Actor *toInsert){ //parameter encounter file
  mc->combatON=TRUE;
  mc->loot = "";
  mc->lootedSwitch=FALSE;
  mc->combatMenuStage=CMS_MOVE;
  mc->currentSong=5;
  QueInit(&combatCQue);
  
  CombatTurn *ctn;
  // Limit for one
  ctn = CAlloc(sizeof(CombatTurn));
  ctn->ready = GetNPC(PLAYER); 
  //AddDirective(T1READY,ctn->ready);
  QueIns(ctn,combatCQue.last);

  ctn = CAlloc(sizeof(CombatTurn));
  ctn->ready = toInsert; 
  QueIns(ctn,combatCQue.last);
  //combatCQue
  
  ctp = combatCQue.next;
  mc->turnIndex = 1;

  AddDirective(BOUNCE,toInsert);
 
}

U0 CombatQueFree() {
  CombatTurn *ctn = combatCQue.last;
  QueRem(ctn);
  ctn = combatCQue.last;
  QueRem(ctn);
  
// QueDel(combatCQue);
// Free(combatCQue);
}

U0 RenderCharacter(CDC *dc,I64 iFinalX, I64 iFinalY,I64 iFinalZ,
           CDC *character,Bool highlight=FALSE)
{

    if(highlight){
       HighlightTarget(dc, iFinalX, iFinalY+24,iFinalZ+10);
    }
    GrBlot3(dc,iFinalX,iFinalY,iFinalZ,character);

}

U0 RenderCombatVersion(Actor *toRender){
 //COMBAT CYCLE ENEMIES
 if(mc->combatON==TRUE){
  //
  //STAGE 1 is the end of player's turn
  //
  if(mc->combatMenuStage==STAGE_1)
  {
   mc->combatMenuStage=STAGE_2;//go to stage 2, creature's turn 
   mc->turnIndex= 2;   
   ctp = combatCQue.next;//reset que pointers
   ctp = ctp->next;//now pointer is to the first creature in the que
   if(ctp->ready->status1!=DEAD_STATUS){
    mc->combatON=TRUE;
   }//move it randomly}
   else{
    player->exp+=(ctp->ready->str+ ctp->ready->con+ 
                  ctp->ready->int+ ctp->ready->wis);
    if(player->exp>=player->maxExp){
     Play("3wC#D#E#F#G#");
     LvlUp(player);
    }
    CombatQueFree();
    mc->combatON=FALSE;
    mc->currentSong=0;
    goto combatOver;
   }
  }
  //
  //STAGE 2 is the end of the round
  //
  if(mc->combatMenuStage==STAGE_2) {
   //reset back to stage 0, start of player's turn
   mc->combatMenuStage=STAGE_0;
   mc->combatMenuSelection=CMS_MOVE;      

      //return que pointer to player
   if(mc->turnIndex==QueCnt(combatCQue))
   {
    //ctp = ctp->next;
    ctp = combatCQue.next;
    mc->turnIndex = 1;
   }
  }

 }
 combatOver:
}

U0 ConfigureCombatPose(Actor *toRender, Actor *p)
{
 I64 i,j;
 //COMBAT start initializations
 //move enemy during combat turn 
 if(toRender->ai_script==1){ 
  if(mc->combatON==FALSE   && 
     toRender->ai_script==1&&
     toRender->status1!=DEAD_STATUS && //(enemy)
     Abs((p->x)-(toRender->x))<=AGGRO_DIS&& //(aggro distance)
     Abs((p->y)-(toRender->y))<=AGGRO_DIS  )
  {
   CombatQueInit(toRender);
  } else if(mc->combatON==FALSE &&
            HasDirective(BOUNCE,toRender))
  {
   I64 npcOffsetX=-camera->cameraOffSetX; 
   I64 npcOffsetY=-camera->cameraOffSetY;

    UpdateDirective(BOUNCE,toRender,    
     GetActorScreenX(toRender,npcOffsetX,toRender->x,FALSE),
     GetActorScreenY(toRender,npcOffsetY,toRender->y,FALSE),0,TRUE);

  }
  RenderCombatVersion(toRender);
 }

}

Actor *RenderPlayer(CDC *dc, Actor *p,
                    I64 npcox,I64 npcoy,I64 i,I64 j)
{
 if(!HasDirective(BOUNCE,p))
 {
  GetActorScreenX(p,npcox,i);
  GetActorScreenY(p,npcoy,j);
 }

 if(mc->combatMenuStage==STAGE_0){
  switch(mc->combatMenuSelection)
  {
  case CMS_MOVE_DONE:
   mc->combatMenuStage=STAGE_1;
  break;
  case CMS_STRIKE_DONE:
   switch(p->sword){
    case IT_FIST:
    default: //fist
     mc->turnIndex++;
     if(mc->turnIndex==50){
      RemoveHealth(mc->target,p->str);
      mc->turnIndex=1;
      mc->combatMenuStage=STAGE_1;
     }//mc turnindex
    break;
   }//switch p sword
  break;
  case CS_PRAYER:
   DrawPrayerHotbar(dc);
  break;
  case CMS_PRAYER_DONE:
   switch(mc->prayerToCast)
   {
    case SP_HEAL: //lay on hands
     if(mc->turnIndex==1) { CastPrayer(p);}
     mc->turnIndex++;
     if(mc->turnIndex==50){
      AddHealth(mc->target,p->int);
      RemoveMana(p,prayers->list[mc->prayerToCast]->cost);
      mc->turnIndex=1;
      mc->combatMenuStage=STAGE_1;
     }
    break;
   }//switch prayer

  break;
  case CS_FLEE:
   mc->turnIndex++;
   if(mc->turnIndex>50){
    U16 r = RandU16();
    // 80% chance-returns a number from 0 to 65535 (inclusive).
    // 80% of 65536 = 52428.8, so comparing like this
    if (r < 0.8 * 65536){
     mc->combatON = FALSE;
     mc->combatMenuStage =STAGE_0;
     mc->combatMenuSelection=CMS_MOVE;

    } 
    else{
     mc->turnIndex=1;
     mc->combatMenuStage=STAGE_1;
    }

   }
  break;
  }
 }
 return p;
}

