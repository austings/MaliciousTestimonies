//test
#define SP_LIGHT   1
#define SP_SWARM   2
#define SP_SONG    3

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
   case SP_HEAL:
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

U0 CycleInv(Bool backward = FALSE)
{
 //mc->displayInventory=TRUE;
 I64 i;
 if(backward){
  mc->prayerListIndex--;
  if(mc->prayerListIndex==-1)
   mc->prayerListIndex = mc->prayerListSize-1;
  
 }
 else{
  mc->prayerListIndex++;
  if(mc->prayerListIndex==mc->prayerListSize)
   mc->prayerListIndex = 0;

 }

}



Bool FindPrayer()
{ I64 i,j,localIndex=0;
 Bool found = FALSE;
 for(i=490;i<640;i=i+50){
  for(j=102;j<201;j=j+50){
   if(camera->cursorX>=i&&camera->cursorX<=i+50
     &&camera->cursorY>j&&camera->cursorY<j+50){
    mc->dragPrayer = localIndex+mc->prayerPage;
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
 mc->dragPrayer=-1;
 return FALSE;

}

U0 GatherSelections()
{
 Free(mc->prayerList);
 I64 i,,j,selectI=0; 
 I64 totalItems = NUM_HOTKEYS+(INVWIDTH*INVHEIGHT);
 I64 *selections = MAlloc(sizeof(I64)*totalItems);

 //scower hotkeys
 for(i=0;i<NUM_HOTKEYS;i++)
 {
  I64 prayer = hotkeys[i];
  if(prayer!=-1)
  {
   selections[selectI] = prayer;
   selectI++;

  } 
 }
 //add delimiter
 selections[selectI] = DELIMITER;
 selectI++;
 I64 itemStart = selectI;
 
 //add any usables

 Item *candidate = (GetNPC(0))->myInv->collection->next;
 for(i=0;i<INVWIDTH*INVHEIGHT;i++)
 {
  if(candidate->usable)
  {
   Bool exists = FALSE;
   // check if already added
   for (j = itemStart;j<selectI; j++){
    if (selections[j] == candidate->invID){
     exists = TRUE;
     break;
    }
   }
   if(!exists){
    selections[selectI] = candidate->invID;
    selectI++;
   }
  }
  candidate= candidate->next;
 }

 // Resize array to exact used size
 I64 *trimmed = MAlloc(sizeof(I64) * selectI);
 for (i = 0; i < selectI; i++)
 {
  trimmed[i] = selections[i];
 }
 mc->prayerListSize = selectI;
 mc->prayerList = trimmed;
 mc->prayerToCast =DELIMITER;
 Free(selections); 

}


U0 MakeOffering()
{

}

U0 CastPrayer(Actor *a)
{
 switch(mc->prayerToCast)
 {
  case SP_HEAL:
   AddDirective(T1CAST,a);
   AddDirective(T1EFFHEAL,mc->target);
  break;
  default:
   AddDirective(T1CAST,a);
  break;
 }
}

