U0 CombatQueFree() {
  //CombatTurn *ctn = combatCQue.last;
  //QueRem(&ctn);
  //ctn = combatCQue.last;
  //QueRem(&ctn);
  
 QueDel(&combatCQue);
 //Free(&combatCQue);
}

U0 CombatDialogs(CTask *task, CDC *dc,Actor *p){
 mc->displayEquipment=FALSE;
 switch(mc->combatMenuStage){
  case STAGE_0:  
   switch(mc->combatMenuSelection)
   {
    case CS_PRAYER:
     mc->displayInventory=TRUE;   
     CombatDialog2(dc,task);     
    break;
    case CS_FLEE:
     CombatDialog3(dc,task);
    break;
    default:
     mc->displayInventory=FALSE;
     CombatDialog1(dc,task, mc->combatMenuSelection);     

    break;
   }
  break;
  case STAGE_1:
   switch(mc->combatMenuSelection)
   {
    case CMS_ENE1:
     SetActorDir(p,DELIMITER);//modified dir complete
     CombatDialog4(dc,task,p);
    break;
    case CMS_ENE2:
     SetActorDir(p,DELIMITER);//modified dir complete
     CombatDialog5(dc,task,p);
    break;
    default:
    break;
   }
  break;
  case STAGE_2:
     SetActorDir(p,DELIMITER);//modified dir complete
  break;
  case STAGE_3:
     SetActorDir(p,DELIMITER);//modified dir complete
  break;
 }

}

U0 SwitchTarget()
{
 ctp = ctp->next;
 mc->combatQueId++;//return to player from head
 if(mc->combatQueId>=QueCnt(combatCQue)){
   ctp = combatCQue.next;
   mc->combatQueId = 0;
 }   

}

U0 CombatTurnArrows(Actor *p)
{
 I64 i;
 switch(mc->combatMenuSelection){
  case CMS_MOVE:
   if(keys.pressed==DIR_UP){mc->combatMenuSelection=CMS_FLEE;}
   if(keys.pressed==DIR_DOWN){mc->combatMenuSelection++;}
  break;
  case CMS_STRIKE:
  case CMS_PRAYER:
   ctp = combatCQue.next;  
   if(keys.pressed==DIR_DOWN){
    mc->combatMenuSelection++;
   }
   if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
  break;
  case CMS_FLEE:
   if(keys.pressed==DIR_DOWN){
    mc->combatMenuSelection=CMS_MOVE;
   }
   if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
  break;
  //case 4...9:
  // if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
  break;
  case CS_MOVE: 
   if(p->currentMana>=MOVEMENT_COST&&
      p->walking==W_NOTWALKING){
    MoveActor(p,keys.pressed);
    RemoveMana(p,MOVEMENT_COST);
   } else{mc->combatMenuSelection=CMS_MOVE_DONE;}
  break;
  case CS_STRIKE://select target
   SwitchTarget;
  break;
  case CS_PRAYER://select prayer/item
   if(keys.pressed==DIR_DOWN||keys.pressed==DIR_RIGHT)
    CycleInv();
   if(keys.pressed==DIR_LEFT||keys.pressed==DIR_UP)
    CycleInv(TRUE);   
  break;
  case CS_PRAYER2://select target
    SwitchTarget;
  break;
  default:
  break;
 }//switch end
}

U0 CalculateExp(Actor *p)
{
 p->exp+=(ctp->ready->str+ ctp->ready->con+ 
           ctp->ready->int+ ctp->ready->wis);
 if(p->exp>=p->maxExp){
  Play("3wC#D#E#F#G#");
  LvlUp(p);
 }

}

U0 EnemyEndTurn(I64 i, Actor *p){
 mc->turnIndex++;
 //update after two world ticks
 if(mc->turnIndex>2){

  SetActorDir(p,DELIMITER);//end prev anims
  mc->turnIndex= 0;   

  //reset que pointers
  ctp = combatCQue.next;
  //check every actor for updates
  for(i=0;i<QueCnt(combatCQue);i++){
   if(ctp->ready->id==PLAYER)
   {
   }
   else
   {
    if(ctp->ready->status1!=DEAD_STATUS){
     mc->combatON=TRUE;//continue combat
    }else{
     CalculateExp(p);
     mc->combatON=FALSE;
     CombatQueFree();
     goto enemyend;
    }

   }
    ctp = ctp->next;
  }
  ctp = combatCQue.next;
  enemyend:
  mc->combatMenuStage=STAGE_2;
 }      
}