
U0 KeyEnter(Actor *p, MapNode *puin)
{
 if(mc->combatON){
  switch(mc->combatMenuSelection){
   case CMS_MOVE://move
    mc->combatMenuSelection =CMS_MOVE_DONE; 
    break;
   case CMS_STRIKE://strike
    mc->combatMenuSelection =CS_STRIKE; 
    break;
   case CMS_PRAYER://prayer
    mc->combatMenuSelection =CS_PRAYER; 
    break;
   case CMS_FLEE://flee
    mc->combatMenuSelection =CS_FLEE; 
    break;
   case CMS_MOVE_DONE://move completion
    mc->combatMenuStage=CS_MOVE;
    break;
   case CS_STRIKE://strike completion
    mc->combatMenuSelection=CMS_STRIKE_DONE;
    break;
  }//end switch
 }
}

U0 KeyArrow(Actor *p,I64 dir)
{ //corresponds to DIR left, right, up, down

 if(mc->displayEquipment){ 
  mc->displayEquipment=FALSE;
 }else{
 mc->displayEquipment=TRUE;}
 if(!mc->combatON){
  MoveActor(p,dir);
 }
 else{ 
  switch(mc->combatMenuStage){
   case CMS_MOVE:
    switch(mc->combatMenuSelection){
     case CMS_MOVE_DONE: 
      if(p->currentMana>=MOVEMENT_COST){
       MoveActor(p,dir);
       RemoveMana(p,MOVEMENT_COST);
      } 
      else{mc->combatMenuStage=CS_MOVE;}
     break;
     case CMS_STRIKE:
      ctp = ctp->next;
      mc->turnIndex++;
      //return to player from head
      if(mc->turnIndex>QueCnt(combatCQue)){
       ctp = combatCQue.next;
       mc->turnIndex = 1;
      }
     break;
    }//switch end     
    break; 
  }
 }   
}

U0 KeyEsc()
{

}

U0 HandleKeyboard(Actor *p, MapNode *puin)
{
 I64 pressed = DumpKey(&keys);

 if(pressed){
  mc->displayEquipment=TRUE;

  switch(pressed)
  {
   case DIR_LEFT:
   case DIR_UP:
   case DIR_DOWN:
   case DIR_RIGHT:
    KeyArrow(p,pressed);
   break;
   case DIR_ENTER:
    KeyEnter(p,puin);
   break;
   case DIR_ESC:
   break;
 }
 }

 
  

}