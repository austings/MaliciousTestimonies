//test

U0 InitializePrayers()
{
 prayers = CAlloc(sizeof(Prayers));
 prayers->list = CAlloc(sizeof(Prayer)*MAX_PRAYERS);
 I64 i;
 for(i=0;i<MAX_PRAYERS;i++)
 {
  prayers->list[i] = CAlloc(sizeof(Prayer));
  prayers->list[i]->id = i;
  prayers->list[i]->unlocked = FALSE;
  switch(i)
  {
   case 0:
    prayers->list[i]->name ="Heal";
    prayers->list[i]->cost = 10;
    prayers->list[i]->type = TYPE_M;

   break;
   default:
    prayers->list[i]->name = "";
    prayers->list[i]->cost = 10;
    prayers->list[i]->type = TYPE_M;
   break;
      
 
  }
 }
 prayers->points = 0;
 prayers->filter = TYPE_M;
 prayers->unlocked = 0;
}

U0 CycleInv()
{
 mc->displayInventory=TRUE;
}

U0 MakeOffering()
{

}

U0 CastPrayer()
{
}