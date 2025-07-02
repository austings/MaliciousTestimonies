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
    prayers->list[i]->name ="Lay On Hands";
    prayers->list[i]->cost = 10;
    prayers->list[i]->type = TYPE_M;
    prayers->list[i]->wOff = 0;
    prayers->list[i]->hOff = 15;

   break;
   default:
    prayers->list[i]->name = "Unknown";
    prayers->list[i]->cost = 0;
    prayers->list[i]->type = TYPE_M;
    prayers->list[i]->wOff = 0;
    prayers->list[i]->hOff = 0;

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



Bool FindPrayer()
{ I64 i,j,localIndex=0;
 Bool found = FALSE;
 for(i=490;i<640;i=i+50){
  for(j=102;j<201;j=j+50){
   if(camera->cursorX>=i&&camera->cursorX<=i+50
     &&camera->cursorY>j&&camera->cursorY<j+50){
    mc->prayer = localIndex+mc->prayerPage;
    found=TRUE;
    goto quit;
   }
   localIndex++;
  }
  localIndex++;
 }
 quit:
 if(found){
  return TRUE;
 }
 mc->prayer=-1;
 return FALSE;

}
U0 MakeOffering()
{

}

U0 CastPrayer()
{
}