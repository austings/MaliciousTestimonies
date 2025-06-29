
U0 SaveButton()
{
 SaveForm;
 mc->currentMenu=0;
 mc->currentSong=1; 
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

U0 ReleaseSword()
{
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

//check if user click or release for each 'button' of inventory
//i: inv width
//j: inv height
U0 InvDrag(I64 i, I64 j)
{
 Bool marked = FALSE;                 
 I8 occupied= GetNPC(0)->myInv->mtrx[j][i].occupied;                 
 if(mc->draggingInv==FALSE)//start dragging
 {
  if(occupied!=-1)//if there is an item underneath
  {
   mc->draggingID = RetrieveItemID(0,occupied,TRUE);
   mc->draggingItem = RetrieveItem(0,occupied,TRUE);
   mc->reRenderInv=TRUE;
   mc->draggingInv=TRUE;
  }
 }else{//release
  //if there is an item underneath
  if(occupied!=-1&&occupied!=mc->draggingItem->invID){
   //continue drag
   marked = TRUE;
  }else{
   //if open space, drop and release w=1 h=2
   U8 itemW, itemH;
   U8 invHMax= mc->draggingItem->h;
   U8 invWMax = mc->draggingItem->w;
   for(itemW=0;itemW<invWMax;itemW++) {
    for(itemH=0;itemH<invHMax;itemH++) {
     I8 tempOccupied = GetNPC(0)->myInv->mtrx[j+(itemH)][i+(itemW)].occupied;
     if(tempOccupied!=-1&& tempOccupied!=mc->draggingItem->invID){
      marked=TRUE;break;
     }
    }
    if(marked){break;}
   }
  }
  if(!marked){
   ChangeItemLoc(i, j, mc->draggingItem);                 
   mc->reRenderInv=TRUE;
   mc->draggingInv=FALSE; 
  }
 }//end release
}