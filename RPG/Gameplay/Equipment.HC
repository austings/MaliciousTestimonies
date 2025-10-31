U0 PrintInventory(Inventory *myInv)
{
 U8 *str1 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[0][0].occupied, myInv->mtrx[0][1].occupied, myInv->mtrx[0][2].occupied,
    myInv->mtrx[0][3].occupied, myInv->mtrx[0][4].occupied, myInv->mtrx[0][5].occupied,
    myInv->mtrx[0][6].occupied, myInv->mtrx[0][7].occupied, myInv->mtrx[0][8].occupied,
    myInv->mtrx[0][9].occupied, myInv->mtrx[0][10].occupied);

 U8 *str2 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[1][0].occupied, myInv->mtrx[1][1].occupied, myInv->mtrx[1][2].occupied,
    myInv->mtrx[1][3].occupied, myInv->mtrx[1][4].occupied, myInv->mtrx[1][5].occupied,
    myInv->mtrx[1][6].occupied, myInv->mtrx[1][7].occupied, myInv->mtrx[1][8].occupied,
    myInv->mtrx[1][9].occupied, myInv->mtrx[1][10].occupied);

 U8 *str3 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[2][0].occupied, myInv->mtrx[2][1].occupied, myInv->mtrx[2][2].occupied,
    myInv->mtrx[2][3].occupied, myInv->mtrx[2][4].occupied, myInv->mtrx[2][5].occupied,
    myInv->mtrx[2][6].occupied, myInv->mtrx[2][7].occupied, myInv->mtrx[2][8].occupied,
    myInv->mtrx[2][9].occupied, myInv->mtrx[2][10].occupied);
 
 U8 *str4 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[3][0].occupied, myInv->mtrx[3][1].occupied, myInv->mtrx[3][2].occupied,
    myInv->mtrx[3][3].occupied, myInv->mtrx[3][4].occupied, myInv->mtrx[3][5].occupied,
    myInv->mtrx[3][6].occupied, myInv->mtrx[3][7].occupied, myInv->mtrx[3][8].occupied,
    myInv->mtrx[3][9].occupied, myInv->mtrx[3][10].occupied);


 PrintDevMessage(str1);
 PrintDevMessage(str2);
 PrintDevMessage(str3);
 PrintDevMessage(str4);

}

//convert walk animation frame to cardinal direction
I64 GetDir(Actor *a)
{
 if(a->dir==DELIMITER)
 {
  U8 walkDir = a->walking;
  U8 subWalk = a->walkingSubFrame;
  switch(walkDir){
   case W_NOTWALKING:
    switch(subWalk)
    {
     case W_IDLEDOWN:
      return DIR_DOWN;
     break; 
     case W_IDLEUP:
      return DIR_UP;
     break;
     case W_IDLERIGHT:
      return DIR_RIGHT;
     break;
     case W_IDLELEFT:
      return DIR_LEFT;
     break;
    }
   break;
   case W_UPSTRAIGHT   :
   case W_UPMID        :    
   case W_UPLEFT       :
   case W_UPRIGHT      :
    return DIR_UP;
   break;    
   case W_DOWNSTRAIGHT :
   case W_DOWNLEFT     :
   case W_DOWNRIGHT    :    
   case W_DOWNMID      : 
    return DIR_DOWN;   
   break;
   case W_LEFTLEFT     :
   case W_LEFTSTRAIGHT : 
   case W_LEFTMID      :
   case W_LEFTRIGHT    :
    return DIR_LEFT;    
   break;
   case W_RIGHTSTRAIGHT:
   case W_RIGHTLEFT    :
   case W_RIGHTMID     :   
   case W_RIGHTRIGHT   :
    return DIR_RIGHT;    
   break;
  }
  return DIR_DOWN;

 }else{
  return a->dir;
 }
}
//convert inv id to item id
I64 *RetrieveItemID(Inventory *myInv, I64 index,  Bool select=FALSE){
 Item *toBeRetrieved = myInv->collection->next;
 I64 i;
 for(i=0;i<QueCnt(toBeRetrieved);i++){
  toBeRetrieved = toBeRetrieved->next;
  if(toBeRetrieved->invID==index)
   break;
 }
 if(select){//move to mouse
  toBeRetrieved->visible = FALSE;
  return toBeRetrieved->id;
 }else{  
  toBeRetrieved->visible = TRUE;
  return toBeRetrieved->id;
 }
}


//convert inv id to item
Item *RetrieveItem(Inventory *myInv, I64 index,Bool select=FALSE)
{
 Item *toBeRetrieved = myInv->collection->next;
 I64 i;
 if(index<=0) return toBeRetrieved;
 for(i=0;i<QueCnt(toBeRetrieved);i++){
  toBeRetrieved = toBeRetrieved->next;
  PrintDevMessage(MStrPrint("%d%s",toBeRetrieved->invID,toBeRetrieved->name));
  if(toBeRetrieved->invID==index)
   break;
 }
 if(select){//move to mouse
  toBeRetrieved->visible = FALSE;
  return toBeRetrieved;
 }

 return toBeRetrieved;
}

Bool AddItemToInv(Inventory *inv, I64 iID){
 I64 i,j,x,y,area;
 Item *item = MakeItem(iID); 
 for(i=0;i<INVWIDTH;i++){
  for(j=0;j<INVHEIGHT;j++){
   area=0;
   for(x=item->w-1;x>=0;x--){
    if(i+x>=11)
     goto skip_num; 
    for(y=item->h-1;y>=0;y--){
     if(j+y>=4)
      goto skip_num;
     if(inv->mtrx[j+y][i+x].occupied<0)
       area++;  
    }
   }
   if(area==(item->h)*(item->w)){
    QueIns(item,inv->collection->last);
    I64 cnt = ++inv->count;
    
    for(x=item->w-1;x>=0;x--){  
     for(y=item->h-1;y>=0;y--){
      inv->mtrx[j+y][i+x].occupied = cnt;
     }
    }
    item->invID = cnt;

    return TRUE;
   }
  }
  skip_num:
 }
 return FALSE;

}


Bool AddItemToInventory(Inventory *myInv, I64 itemID){
 I64 i,j,x,y,area;
 Item *item = MakeItem(itemID);
 
 for(i=0;i<INVWIDTH;i++){
  for(j=0;j<INVHEIGHT;j++){
   area=0;
   for(x=item->w-1;x>=0;x--){
    if(i+x>=11)
     goto skip_num;
 
    for(y=item->h-1;y>=0;y--){
     if(j+y>=4)
      goto skip_num;
     if(myInv->mtrx[j+y][i+x].occupied<0)
       area++;  
    }
   }

   if(area==(item->h)*(item->w)){
    QueIns(item,myInv->collection->last);
    //PopUpPrint( "item added");
    I64 cnt = ++myInv->count;
    
    for(x=item->w-1;x>=0;x--){  
     for(y=item->h-1;y>=0;y--){
      myInv->mtrx[j+y][i+x].occupied = cnt;
     }
    }
    item->invID = cnt;

    return TRUE;
   }
  }
  skip_num:
 }
 return FALSE;

}

//usually used for populating equipment slots
//item is a Item class instance
//removes inventory item by Item class reference
U0 RemoveItemLoc(Item *item, Bool delete =FALSE){
 Actor *p = GetNPC(PLAYER);

 I64 i,j;

 //remove old loc,update other items index in rendered matrix
 for(i=0;i<INVWIDTH;i++){
  for(j=0;j<INVHEIGHT;j++){
   I64 valueToUpdate = p->myInv->mtrx[j][i].occupied;
   if(valueToUpdate==item->invID){
    valueToUpdate = IT_NULL;
   }
   if(valueToUpdate>item->invID){
    valueToUpdate = valueToUpdate-1;
   } 
   p->myInv->mtrx[j][i].occupied = valueToUpdate;
  }
 }

 //update player array
 if(delete){
  Item *cur = p->myInv->collection->next;//head container memory loc
  for(i=0;i<=item->invID;i++)//increment by i where i=0 is the first item
   cur = cur->next;//run once where item to remove=0
  for(i=item->invID;i<p->myInv->count;i++){
   cur->invID--;
   cur = cur->next;
  }
  p->myInv->count--; 
  QueRem(item);
  Free(item);
 }

}

//item is a invID
//removes inventory item by invID reference
U0 RemoveItemLocID(I64 invID, Bool delete =FALSE)
{

 Actor *p = GetNPC(PLAYER);

 I64 i,j;
 Item *torm = RetrieveItem(p->myInv,invID);
 
 //remove old loc,update other items index in rendered matrix
 for(i=0;i<INVWIDTH;i++){
  for(j=0;j<INVHEIGHT;j++){
   I64 valueToUpdate = p->myInv->mtrx[j][i].occupied;
   if(valueToUpdate==invID){
    valueToUpdate = IT_NULL;
   }
   if(valueToUpdate>invID){
    valueToUpdate = valueToUpdate-1;
   } 
   p->myInv->mtrx[j][i].occupied = valueToUpdate;
  }
 }

 if(delete){
  Item *cur = p->myInv->collection->next;
  for(i=0;i<=invID;i++)
   cur = cur->next;
  for(i=invID;i<p->myInv->count;i++){
   cur->invID--;
   cur = cur->next;
  }
  p->myInv->count--; 

  QueRem(torm);
  Free(torm);

 }

}



U0 ChangeItemLoc(U8 newI, U8 newJ, Item *item, Inventory *myInv, Bool isPlayer)
{

 I64 i,j,x,y;
 Inventory *src = myInv;
 Inventory *dest = myInv;
 if(!mc->dragInvIsPlayer){//start merchant 
  src = mc->lootInv;
 }else {
  src = player->myInv;
 }
 if(isPlayer){ 
  dest  = myInv;
 }else{
  dest = mc->lootInv;
 }
 //remove old loc
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
   if(src->mtrx[j][i].occupied==item->invID){  
     for(x=0;x<item->w;x++)
     {  
      for(y=0;y<item->h;y++)
      {
       src->mtrx[j+y][i+x].occupied = IT_NULL;
      }
     }
     goto move;    
   }   
  }
 }
 move:
 item->visible=TRUE;
 //add new loc
 //for(i=0;i<INVWIDTH;i++)
 //{
 // for(j=0;j<INVHEIGHT;j++)
 // {
    //if(i==newI&&j==newJ){
     for(x=0;x<item->w;x++)
     {  
      for(y=0;y<item->h;y++)
      {
       dest->mtrx[newJ+y][newI+x].occupied = item->invID;
      }
     }
    //}

 // }
 //}
 

}




CDC *ShowBody(I64 armor,I64 dir )
{
 CDC *armorPiece = DCNew(100,100);
 DCFill(armorPiece,TRANSPARENT);
 switch(armor)
 { 
  case IT_SHIRT:
   Sprite3B(armorPiece,10,20,10,GetClothArmor(dir));
  break;
 }
 return armorPiece;
}

CDC *ShowHelm(I64 armor,I64 dir )
{
 CDC *armorPiece = DCNew(100,100);
 DCFill(armorPiece,TRANSPARENT);
 switch(armor)
 { 
  case IT_HELM:
   Sprite3B(armorPiece,10,20,10,GetHelmArmor(dir));
  break;
 }
 return armorPiece;
}


CDC *ShowHair(I64 hairID, I8 dir)
{
 CDC *hairDC = DCNew(100,100);
 DCFill(hairDC,TRANSPARENT);

 switch(hairID)
 {
  case HAIR0:
   return GetHair0(hairDC,dir);
  break;
  case HAIR1:
   return GetHair1(hairDC,dir);
  break;
  case HAIR2:
   return GetHair2(hairDC,dir);
  break;
  case HAIR3:
   return GetHair3(hairDC,dir);
  break;
  default:
   return hairDC;
  break;
 }

}

