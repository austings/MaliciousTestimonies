

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
 switch(mc->combatMenuStage){
  case 0:  
   CombatDialog1(dc,task, mc->combatMenuSelection);
     
     break;
  case 1:
      //Actor *attacker = ct->ready;    
     break;
  case 2:
      //mc->combatMenuStage=1;
      //mc->combatMenuStage=0;
     break;
  case 3:
     break;
 }

}