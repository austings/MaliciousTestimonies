

I64 CalculateAngle(I64 x1 , I64 y1 , I64 x2 ,I64 y2)
{
  I64 dx = x2 -x1;
  I64 dy = y2-y1;
  if(dx ==0 && dy > 0){
    return 180;}
  else if( dx >0 &&dy ==0){
    return 90;}
  else if(dx == 0 && dy < 0){
   return 0;}
  else if(dx <0 && dy == 0){
   return 270;}
  else{ 
  return 90;}
}

I64 GetCTPIndexFromActor(Actor *a)
{
 Actor *it = combatCQue.next;
 I64 index = 0;

 while(it != &combatCQue){
  if(it->id == a->id){
   return index;
  }
  it = it->next;
  index++;
 }

 return -1; // not found (shouldnt happen)
}

U0 HandleDeathScreen(CDC *dc)
{
 Actor *p = GetPlayer;

 if(!p)
  return;

 // Start death screen timer once
 if(!deathScreenActive &&
    (HasStatus(p,LIFE_DYING) ||
     HasStatus(p,LIFE_DEAD)))
 {
  //CombatQueFree();
  mc->combatON = FALSE;
  mc->combatMenuStage = STAGE_0;

  deathScreenActive = TRUE;
  deathScreenShown = FALSE;
  deathScreenStart = tS();
 }

 if(!deathScreenActive)
  return;

 // Wait 3 seconds after death
 if(!deathScreenShown &&
    tS() >= deathScreenStart + 3.0)
 {
  deathScreenShown = TRUE;
 }

 if(deathScreenShown)
 {
  GrBlot3(
   dc,
   0,
   0,
   0,
   DIESCREEN
  );

  // Quit seconds after death screen appears
  if(tS() >= deathScreenStart + 7.0)
  {
   Quit();
  }
 }
}
