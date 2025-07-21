
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

U0 CombatTurnArrows(Actor *p)
{
 switch(mc->combatMenuSelection){
  case CMS_MOVE:
   if(keys.pressed==DIR_UP){mc->combatMenuSelection=CMS_FLEE;}
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
   } else{mc->combatMenuStage=CMS_MOVE_DONE;}
  break;
  case CS_STRIKE://select target
    ctp = combatCQue.next;
  break;
  case CS_PRAYER://select prayer/item
   if(keys.pressed==DIR_DOWN||keys.pressed==DIR_RIGHT)
    CycleInv();
   if(keys.pressed==DIR_LEFT||keys.pressed==DIR_UP)
    CycleInv(TRUE);   
  break;
  case CS_PRAYER2://select target
    ctp = combatCQue.next;
  break;
  default:
  break;
 }//switch end
}