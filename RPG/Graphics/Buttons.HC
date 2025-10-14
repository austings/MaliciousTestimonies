
U0 SaveButton()
{
 SaveForm;
}


U0 EquipButton()
{
 if(mc->displayEquipment==TRUE)
  mc->displayEquipment=FALSE;
 else
  mc->displayEquipment=TRUE;
}

U0 InvButton()
{
 if(mc->displayInventory==TRUE)
  mc->displayInventory=FALSE;
 else
  mc->displayInventory=TRUE;

}

U0 MusicButton()
{
 if(mc->musicMuted==FALSE)
  mc->musicMuted=TRUE;
 else
  mc->musicMuted=FALSE; 
}

U0 PrayerButton()
{
 if(mc->displayPrayers==FALSE)
  mc->displayPrayers=TRUE;
 else
  mc->displayPrayers=FALSE; 

}

U0 FxButton()
{
 if(mc->fxMuted==FALSE)
  mc->fxMuted=TRUE;
 else
  mc->fxMuted=FALSE; 
}

U0 IncPrayerPage(I64 i)
{
 mc->prayerPage = mc->prayerPage + i;
 if(mc->prayerPage<1)
 {
  mc->prayerPage = MAX_PRAYERS-(MAX_PRAYERS%9);
 }
 if(mc->prayerPage>MAX_PRAYERS)
 {
  mc->prayerPage=0;
 }
}

U0 PrayerCycleButton(Bool left)
{
 if(left)
  IncPrayerPage(-9);
 else
  IncPrayerPage(9);
}

U0 SetHotKey(I64 i , I64 v)
{
 I64 iter;
 for(iter = 0;iter<NUM_HOTKEYS;iter++)
 {
  if(hotkeys[iter] ==v)//only one prayer of each kind on the hotbar
   hotkeys[iter] =-1;
 }
 hotkeys[i] = v;               

}

U0 PrayerFilters(I64 M_X, I64 M_Y,I64 i, I64 j)
{
 if(M_X>=490&&M_X<415&&
    M_Y>=81&&M_Y<102){
   PrayerCycleButton(TRUE);
 }else if(M_X>590&&M_X<615&&
          M_Y>=81&&M_Y<102){
   PrayerCycleButton(FALSE);
 }else if(mc->prayerDragging==TRUE){
  I64 index=0;
  for(i=10;i<490;i=i+50)
  {
   if(M_X>=i&&M_X<=i+50&&
      M_Y>=0&&M_Y<=50)
   {
    SetHotKey(index,mc->dragPrayer);
    mc->prayerDragging=FALSE;
    mc->dragPrayer = -1;
    break;
   }
   index++;
  }
 }else{
  for(i=490;i<640;i=i+50)
  {
   for(j=102;j<252;j=j+50)
   {
    if(M_X>=i&&M_X<=i+50&&M_Y>j&&M_Y<j+50&&mc->prayerDragging==FALSE)
    {
     mc->prayerDragging=TRUE;
    }
   }
  }
 }

}

U0 ReleaseSword()
{
 if(mc->draggingItem->equip_slot!=EQ_SLOT_WEP){
  //this should just cancel the drag but its a bit more complicated than that
  //AddItemToInventory(0,mc->draggingID);        
  //mc->reRenderInv=TRUE;
  //mc->draggingInv=FALSE; 

 }
 //switch from inv to sword, del from inv
 I64 equip =  GetNPC(0)->sword;
 if(equip!=0){
  AddItemToInventory(0,GetNPC(0)->sword);
 }
 GetNPC(0)->sword =mc->draggingID;

 mc->reRenderInv=TRUE;
 mc->draggingInv=FALSE; 
 RemoveItemLoc(mc->draggingItem);                 

}

U0 ReleaseBody()
{
 if(mc->draggingItem->equip_slot!=EQ_SLOT_BDY){
  //AddItemToInventory(0,mc->draggingID);        
  //mc->reRenderInv=TRUE;
  //mc->draggingInv=FALSE; 
  return;
 }

 //switch from inv to body, del from inv
 I64 equip =  GetNPC(0)->armor;
 if(equip!=0){
  AddItemToInventory(0,GetNPC(0)->armor);
 }
 GetNPC(0)->armor =mc->draggingID;

 mc->reRenderInv=TRUE;
 mc->draggingInv=FALSE; 
 RemoveItemLoc(mc->draggingItem);                 

}

U0 ReleaseHelm()
{
 if(mc->draggingItem->equip_slot!=EQ_SLOT_HLM){
  //AddItemToInventory(0,mc->draggingID);
  //mc->reRenderInv=TRUE;
  //mc->draggingInv=FALSE; 
  return;
 }

 //switch from inv to helm, del from inv
 I64 equip =  GetNPC(0)->hat;
 if(equip!=0){
  AddItemToInventory(PLAYER,GetNPC(PLAYER)->hat);
 }
 GetNPC(0)->hat =mc->draggingID;

 mc->reRenderInv=TRUE;
 mc->draggingInv=FALSE; 
 RemoveItemLoc(mc->draggingItem);                 

}
U0 ReleaseRing()
{
 if(mc->draggingItem->equip_slot!=EQ_SLOT_RNG){
  //AddItemToInventory(0,mc->draggingID);       
  //mc->reRenderInv=TRUE;
  //mc->draggingInv=FALSE; 
  return;
 }         

 //switch from inv to helm, del from inv
 I64 equip =  GetNPC(0)->ring1;
 if(equip!=0){
  AddItemToInventory(0,GetNPC(0)->ring1);
 }
 GetNPC(0)->ring1 =mc->draggingID;

 mc->reRenderInv=TRUE;
 mc->draggingInv=FALSE; 
 RemoveItemLoc(mc->draggingItem);                 

}

Bool FillItemIfOnWater(I64 wlvl=0){
 if(wlvl>0){
  switch(mc->draggingID){
   case IT_POT:
    RemoveItemLoc(mc->draggingItem);
    AddItemToInventory(PLAYER,IT_WPOT);
    mc->reRenderInv=TRUE;
    mc->draggingInv=FALSE; 
    return TRUE;
   break;
  }
 }
 return FALSE;
}

U0 CombineIfPossible(I64 pItem)
{
 Item *item= RetrieveItem(PLAYER,pItem);

 switch(mc->draggingID)
 {
  case IT_WPOT:
   if(item->id==IT_BULB){
    RemoveItemLocID(pItem);
    RemoveItemLoc(mc->draggingItem);
    AddItemToInventory(PLAYER,IT_HPPOT);
    mc->reRenderInv=TRUE;
    mc->draggingInv=FALSE; 

   }
  break;  
  case IT_BULB:
   if(item->id==IT_WPOT)
   {
    RemoveItemLocID(pItem);
    RemoveItemLoc(mc->draggingItem);
    AddItemToInventory(PLAYER,IT_HPPOT);
    mc->reRenderInv=TRUE;
    mc->draggingInv=FALSE; 

   }
  break;
  
  
 }
}

#define CHESTIDSBEGIN  MAX_WRITTEN_ACTORS+1

//check if user click or release for each 'button' of inventory
//i: inv width
//j: inv height
U0 InvDrag(I64 i, I64 j,I64 actor){
 Bool marked = FALSE;                 
 I8 occupied;
 if(actor <=CHESTIDSBEGIN){
  occupied= GetNPC(actor)->myInv->mtrx[j][i].occupied;                 
 }
 else{
  occupied = mc->lootInv->mtrx[j][i].occupied;
 }
 if(mc->draggingInv==FALSE){//start dragging
  if(occupied!=-1){//if there is an item underneath
   mc->draggingID = RetrieveItemID(actor,occupied,TRUE);
   mc->draggingItem = RetrieveItem(actor,occupied,TRUE);
   mc->reRenderInv=TRUE;
   mc->draggingInv=TRUE;
  }
 }else{//release
  I64 wlvl= GetTensorWaterLevel(world->level,player->x,player->y,world->currentZ);     
  if(FillItemIfOnWater(wlvl))
   marked=TRUE;
  //if there is an item underneath
  if(occupied!=-1&&occupied!=mc->draggingItem->invID){//continue drag
   marked = TRUE;
   CombineIfPossible(occupied);

  }else{//if open space, drop and release w=1 h=2
   U8 itemW, itemH;
   U8 invHMax= mc->draggingItem->h;
   U8 invWMax = mc->draggingItem->w;
   for(itemW=0;itemW<invWMax;itemW++) {
    for(itemH=0;itemH<invHMax;itemH++) {
     I64 tempOccupied;
     if(actor <= CHESTIDSBEGIN){
      tempOccupied = 
         GetNPC(actor)->myInv->mtrx[j+(itemH)][i+(itemW)].occupied;
     }else { 
      tempOccupied = 
         mc->lootInv->mtrx[j+(itemH)][i+(itemW)].occupied;
     }
     if(tempOccupied!=-1&& tempOccupied!=mc->draggingItem->invID){
      marked=TRUE;break;
     }
    }
    if(marked){//check if we can combine
     CombineIfPossible(occupied);
     break;
    }
   }
  }
  if(!marked){
   ChangeItemLoc(i, j, mc->draggingItem);                 
   mc->reRenderInv=TRUE;
   mc->draggingInv=FALSE; 
  }
 }//end release
}

