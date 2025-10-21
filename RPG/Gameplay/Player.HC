
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
  if(a->currentMana<=magnitude)
  {
    a->currentMana=0;
  }
  else
  {
   a->currentMana = a->currentMana- magnitude;

   if(a->currentMana>a->mana)
   {
    a->currentMana=a->mana;
   }
  }

}

U0 RemoveHealth(Actor *a, I64 magnitude)
{
  IndicatorText(a->x,a->y,magnitude,"Health");
  if(a->currentHealth<=magnitude)
  {
    a->currentHealth=0;
    AddStatus(a,DEAD_STATUS);
  }
  else
  {
    a->currentHealth = a->currentHealth - magnitude;
    if(a->currentHealth>a->health)
    {
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



U0 InitActors(I64 currentZ)
{
  SetNPC(MakeActor(1,0,0,0, 
	         0,0,0,0,
	         0,0,
	         5,5,5,5,0));//player

  ResetNPCC;
  while(GetNPCC!=10)
  {
   switch(currentZ)
   {
     case 0://town level
     ReadNPC(1);
     ReadNPC(2);
     ReadNPC(3);
     ReadNPC(4);
     ReadNPC(5);
     ReadNPC(6);
     ReadNPC(7);
     ReadNPC(8);
     ReadNPC(9);
     ReadNPC(10);
     break;
   }
  }

}


U0 FreeActor(I64 id)
{
 Actor *a= GetNPC(id);
 QueDel(&(a->myInv->collection));
 Free(&(a->myInv->collection));
 Free(&(a->myInv));
 Free(&(a));
}

//Inventory

I64 InvNPCCount(Actor *a)
{
  switch(a->id)
  {
   case 0:
    return QueCnt(a->myInv->collection);
    break;
   case 1:
    break;
  }
  return 0;
}

