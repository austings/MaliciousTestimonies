
U0 Death()
{
//Player action select
      /*I64 deathloop,deathcounter;
      ctp = combatCQue.next; 
      for(deathloop=0;deathloop<QueCnt(combatCQue)-1;deathloop++)
      {
        if(ctp->ready->dead){
         deathcounter++;}
        ctp = ctp->next;
      }
      if(deathcounter==1)
      {//enemies killed
       mc->combatON = FALSE;
       mc->currentSong =0;
       
      }
      else{ */
 
}

U0 HandleCombatLoop(CTask *task, CDC *dc){
 mc->displayEquipment=FALSE;
 switch(mc->combatMenuStage){
  case STAGE_0:  
   switch(mc->combatMenuSelection)
   {
    case CS_PRAYER:
     mc->displayInventory=TRUE;   
     CombatDialog2(dc,task);     

    break;
    default:
     mc->displayInventory=FALSE;
     CombatDialog1(dc,task, mc->combatMenuSelection);     

    break;
   }
  break;
  case STAGE_1:
  break;
  case STAGE_2:
  break;
  case STAGE_3:
  break;
 }

}

U0 CombatTurnArrows(Actor *p)
{
 switch(mc->combatMenuSelection){
  case CMS_MOVE:
   if(keys.pressed==DIR_UP){break;}
   if(keys.pressed==DIR_DOWN){mc->combatMenuSelection++;}
  break;
  case CMS_STRIKE:
  case CMS_PRAYER: 
   if(keys.pressed==DIR_DOWN){
    mc->combatMenuSelection++;
   }
   if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
  break;
  case CMS_FLEE:
   if(keys.pressed==DIR_DOWN){
    break;
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
   } else{mc->combatMenuStage=CMS_MOVE_DONE;}
  break;
  case CS_STRIKE://select target
   ctp = ctp->next;
   mc->turnIndex++;//return to player from head
   if(mc->turnIndex>QueCnt(combatCQue)){
    ctp = combatCQue.next;
    mc->turnIndex = 1;
   } 
  break;
  case CS_PRAYER://select item
   if(keys.pressed==DIR_DOWN||keys.pressed==DIR_RIGHT)
    CycleInv();
   if(keys.pressed==DIR_LEFT||keys.pressed==DIR_UP)
    CycleInv(TRUE);
   
  break;
 }//switch end
}