
U0 CombatQueFree() {  
 QueDel(&combatCQue);
}

U0 CombatDialogs(CTask *task, CDC *dc,Actor *p){

 mc->displayEquipment=FALSE;
 switch(mc->combatMenuStage){
  case STAGE_0:  
   switch(mc->combatMenuSelection) {
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
   switch(mc->combatMenuSelection) {
 case CMS_ENE1:
  CombatDialog4(dc,task,p);
 break;
 case CMS_ENE2:
  SetActorDir(p,DELIMITER);//ene move complete
  CombatDialog5(dc,task,p);
 break;
 default:
 break;
   }
  break;
 }

}
/*
U0 SwitchTarget_Old(){
 I64 count = QueCnt(combatCQue);
 mc->targetCTPIndex++;
 if(mc->targetCTPIndex >= count)
  mc->targetCTPIndex = 0;

 CombatTurn *it = combatCQue.next;
 I64 i;

 for(i = 0; i < mc->targetCTPIndex; i++)
  it = it->next;

 targetCTP = it;
 Actor *p = GetPlayer;
 p->target = targetCTP->ready;

}
*/

U0 SwitchTarget()
{
 Actor *p = GetPlayer;
 I64 count = QueCnt(combatCQue);

 if(count <= 0)
  return;

 I64 startIndex = mc->targetCTPIndex;

 // Try every combatant, starting with the next one.
 I64 i;

 for(i = 1; i <= count; i++)
 {
  I64 index = startIndex + i;

  if(index >= count)
   index -= count;

  CombatTurn *it = combatCQue.next;
  I64 j;

  for(j = 0; j < index; j++)
   it = it->next;

  if(it->ready && CanTargetForAction(p, it->ready))
  {
   mc->targetCTPIndex = index;
   targetCTP = it;
   p->target = it->ready;
   return;
  }
 }
}
U0 SetTargetFromActor(Actor *a)
{
 I64 index = 0;
 CombatTurn *it = combatCQue.next;
 Actor *p = GetPlayer;
 while(it != &combatCQue){
  if(it->ready && it->ready->id == a->id){
   targetCTP = it;
   mc->targetCTPIndex = index;
   p->target = a;
   return;
  }

  it = it->next;
  index++;
 }
}

U0 CombatTurnArrows(Actor *p,I64 dir){
 I64 i;
 switch(mc->combatMenuSelection){
  case CMS_MOVE:
   if(KeyPressed(&keyboard.down)||KeyPressed(&keyboard.up)){
 mc->combatMenuSelection=CMS_PRAYER;}
   if(KeyPressed(&keyboard.left)||KeyPressed(&keyboard.right)){
 mc->combatMenuSelection=CMS_STRIKE;}
  break;
  case CMS_STRIKE:
   if(KeyPressed(&keyboard.down)||KeyPressed(&keyboard.up)){
 mc->combatMenuSelection=CMS_FLEE;}
   if(KeyPressed(&keyboard.left)||KeyPressed(&keyboard.right)){
 mc->combatMenuSelection=CMS_MOVE;}
  break;
  case CMS_PRAYER:
   if(KeyPressed(&keyboard.down)||KeyPressed(&keyboard.up)){
 mc->combatMenuSelection=CMS_MOVE;}
   if(KeyPressed(&keyboard.left)||KeyPressed(&keyboard.right)){
 mc->combatMenuSelection=CMS_FLEE;}
  break;
  case CMS_FLEE:
   if(KeyPressed(&keyboard.down)||KeyPressed(&keyboard.up)){
 mc->combatMenuSelection=CMS_STRIKE;}
   if(KeyPressed(&keyboard.left)||KeyPressed(&keyboard.right)){
 mc->combatMenuSelection=CMS_PRAYER;}
  break;
  case CS_MOVE: 
   if(p->currentMana>=MOVEMENT_COST){
 if(p->walking==DIR_IDLE){
  if(MoveActor(p,dir))
   RemoveMana(p,MOVEMENT_COST);
 }
   } else{mc->combatMenuSelection=CMS_MOVE_DONE;}
  break;
  case CS_STRIKE://select target
   if(KeyPressed(&keyboard.down)||KeyPressed(&keyboard.right))
 SwitchTarget;
   if(KeyPressed(&keyboard.left)||KeyPressed(&keyboard.up))
 SwitchTarget();//integrate otherway
  break;
  case CS_PRAYER://select prayer/item
   if(KeyPressed(&keyboard.down)||KeyPressed(&keyboard.right))
 CycleInv();
   if(KeyPressed(&keyboard.left)||KeyPressed(&keyboard.up))
 CycleInv(TRUE);   
  break;
  case CS_PRAYER2://select target
 SwitchTarget;
  break;
  default:
  break;
 }//switch end
}


Bool PlayerInAggroRange(Actor *player)
{
 CombatTurn *it = combatCQue.next;

 while(it != &combatCQue){
  Actor *a = it->ready;

  if(a && a != player){
   // hostile only
   if(a->ai_script ==AI_ENEMY){

 I64 dx = Abs(a->x - player->x);
 I64 dy = Abs(a->y - player->y);

 // Chebyshev distance (grid-based, includes diagonals)
 I64 dist;

 if(dx > dy){
  dist = dx;
 }
 else{
  dist = dy;
 }
 if(dist <= 2){
  return TRUE; // inside aggro zone
 }
   }
  }

  it = it->next;
 }

 return FALSE;
}
U0 SelectValidTarget(){
 CombatTurn *cur = combatCQue.next;
 I64 index = 0;

 targetCTP = NULL;
 Actor *p = GetPlayer;
 p->target = GetPlayer;
 mc->targetCTPIndex = 0;

 while(cur != &combatCQue){
  if(cur->ready &&
  !HasStatus(cur->ready,LIFE_DEAD) && !HasStatus(cur->ready,LIFE_DYING)&&
  cur->ready->id != mc->localPlayerId) {
   targetCTP = cur;
   p->target = cur->ready;
   mc->targetCTPIndex = index;

   return;
  }

  cur = cur->next;
  index++;
 }
}

U0 ExecuteStrike(Actor *p)
{
    I64 attackX, attackY;

    mc->strikeApproach = FALSE;

    if(!p->target)
        return;

    if(!CanStrikeTarget(p, p->target))
        return;

    if(IsInStrikeRange(p, p->target))
    {
        mc->combatMenuSelection = CMS_STRIKE_DONE;
        PlayStrikeAnim(p);
        return;
    }

    if(FindStrikePosition(p, p->target, &attackX, &attackY))
    {
        mc->strikeApproach = TRUE;
        mc->combatMenuSelection = CS_STRIKE;
        return;
    }

    // No reachable attack position.
    ClearActorPath(p);
    mc->strikeApproach = FALSE;
    mc->combatMenuSelection = CMS_MOVE_DONE;
}

//i = iterable
//p = player
U0 EndCombatTurn(I64 i, Actor *p){
 mc->turnIndex++;
 // Update after two world ticks
 if(mc->turnIndex <= 2)
  return;
 SetActorDir(p, DELIMITER); // End previous animations
 mc->turnIndex = 0;
 /*
  Clear target references BEFORE RemoveDeadCombatants()
  can free the CombatTurn node.
 */
 if(p->target &&
   !HasStatus(p->target, LIFE_DEAD)&&!HasStatus(p->target,LIFE_DYING))
 {
  p->target = GetPlayer;
  targetCTP = NULL;
  mc->targetCTPIndex = 0;
 }
 RemoveDeadCombatants();
 
 if(!HasLivingEnemies()){
  mc->combatON = FALSE;
  return;
 }
 //if(!p->target) TODO: check if this works
 // SelectValidTarget();

 mc->combatON = TRUE;
 
 CTPProgress;
 
 if(ctp->ready->id == mc->localPlayerId)
 {
  //regain spirit;
  RemoveMana(p,-(p->wis/2)); 

  mc->combatMenuStage = STAGE_0;
  mc->combatMenuSelection = CMS_MOVE;
 }
 else
 {
  SetCombatStage1;
 }


}