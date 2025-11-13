

U0 LvlUp(Actor *a)
{
  a->exp = a->exp - a->maxExp;
  a->lvl = a->lvl+1;
  a->maxExp = Pow(0.05*a->lvl,4)+Pow(2*a->lvl,3)
                      +Pow(5*a->lvl,2)+10*a->lvl+3; 
}

U0 RemoveMana(Actor *a, I64 magnitude)
{
  IndicatorText(a->x,a->y,magnitude,"Spirit");
  if(a->currentMana<=magnitude){
    a->currentMana=0;
  }
  else
  {
   a->currentMana = a->currentMana- magnitude;
   if(a->currentMana>a->mana){
    a->currentMana=a->mana;
   }
  }

}

U0 RemoveHealth(Actor *a, I64 magnitude)
{
 IndicatorText(a->x,a->y,magnitude,"Health");
 if(a->currentHealth<=magnitude){
  a->currentHealth=0;
  AddStatus(a,DEAD_STATUS);
 }
 else{
  a->currentHealth = a->currentHealth - magnitude;
  if(a->currentHealth>a->health){
   a->currentHealth = a->health;
  }
 } 
}

U0 AddHealth(Actor *a,I64 magnitude)
{
 IndicatorText(a->x,a->y,magnitude,"Health");
 a->currentHealth = a->currentHealth + magnitude;
 if(a->currentHealth>a->health){
    a->currentHealth = a->health;
 }
}


U0 UpdateActorCoords(I64 id, U64 x, U64 y)
{
  switch(id)
  {
   case 0:
    Actor *player = GetPlayer;
    player->x = x;
    player->y = y;
    break;
   default:
    Actor *p = GetNPC(id);
    p->x = x;
    p->y = y;
    break;
  }
}



U0 InitActors(I64 currentZ){
 actors = MAlloc(sizeof(Actor));
 QueInit(actors);
 Actor *newPlayer = MakeActor(0,0,0,0, 
	         0,0,0,0,
	         0,0,
	         5,5,5,5,0));//new player
 loaded++;
 QueIns(newPlayer,actors->last);

}

U0 FreeActor(Actor *a){
 FreeInventory(a->myInv);
 QueRem(a);
 Free(a);
}


U0 ClearActors(){
 I64 i;
 Actor *rm = actors->next;
 while(rm != actors){
  Actor *temp = rm;
  rm = rm->next;
  FreeActor(temp);
 }
 QueDel(actors);
 Free(actors);
 loaded = 0;
}

