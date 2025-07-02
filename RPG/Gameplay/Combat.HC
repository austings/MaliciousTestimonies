
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
 mc->displayInventory=FALSE;   
 mc->displayEquipment=FALSE;
 switch(mc->combatMenuStage){
  case 0:  
   CombatDialog1(dc,task, mc->combatMenuSelection);     
     break;
  case 1:
     //Actor *attacker = ct->ready;    
     break;
  case 2:
     // mc->combatMenuStage=1;
     // mc->combatMenuStage=0;
     break;
  case 3:
     break;
 }

}

U0 CombatTurnArrows(Actor *p)
{
 switch(mc->combatMenuSelection){
     case 0:
      if(keys.pressed==DIR_UP){break;}
      if(keys.pressed==DIR_DOWN){mc->combatMenuSelection++;}
     break;
     case 1:
     case 2: 
      if(keys.pressed==DIR_DOWN){
       mc->combatMenuSelection++;
      }
      if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
     break;
     case 3:
     if(keys.pressed==DIR_DOWN){
      break;
     }
     if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
     break;
     case 4...9:
      if(keys.pressed==DIR_UP){mc->combatMenuSelection--;}
     break;
     case CMS_MOVE_DONE: 
      if(p->currentMana>=MOVEMENT_COST&&p->walking==W_NOTWALKING){
       MoveActor(p,keys.pressed);
       RemoveMana(p,MOVEMENT_COST);
      } 
      else{mc->combatMenuStage=CS_MOVE;}
     break;
     case CS_STRIKE://select target
      ctp = ctp->next;
      mc->turnIndex++;
      //return to player from head
      if(mc->turnIndex>QueCnt(combatCQue)){
       ctp = combatCQue.next;
       mc->turnIndex = 1;
      } 
     break;
     case CS_PRAYER://select item
      CycleInv();
     break;
 }//switch end
}