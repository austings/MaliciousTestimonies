
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
Item *RetrieveItem(Inventory *myInv, I64 index,Bool select=FALSE){
 Item *toBeRetrieved = myInv->collection->next;
 I64 i;
 if(index<=0) return toBeRetrieved;
 for(i=0;i<QueCnt(toBeRetrieved);i++){
  toBeRetrieved = toBeRetrieved->next;
  if(toBeRetrieved->invID==index)
   break;
 }
 if(select){//move to mouse
  toBeRetrieved->visible = FALSE;
  return toBeRetrieved;
 }
 return toBeRetrieved;
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
U0 RemoveItemLocID(I64 invID, Bool delete =FALSE){
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



U0 ChangeItemLoc(U8 newI, U8 newJ, Item *item, 
                 Inventory *myInv, Bool isPlayer){
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
 for(i=0;i<INVWIDTH;i++){
  for(j=0;j<INVHEIGHT;j++){
   if(src->mtrx[j][i].occupied==item->invID){  
    for(x=0;x<item->w;x++){  
     for(y=0;y<item->h;y++){
      src->mtrx[j+y][i+x].occupied = IT_NULL;
     }
    }
    goto move;    
   }   
  }
 }

 move:
 if((!mc->dragInvIsPlayer&&isPlayer)||
    (mc->dragInvIsPlayer&&!isPlayer)){
  I64 value = item->value;

  AddItemToInventory(dest,item->id);
 }else{
  item->visible=TRUE;
  for(x=0;x<item->w;x++){  
   for(y=0;y<item->h;y++){
    dest->mtrx[newJ+y][newI+x].occupied = item->invID;
   }
  }
 }
}


U0 RecolorShirt(CDC *ap, I64 dir)
{
 if(dir!=DIR_LEFT){
  GrFloodFill(ap,27,46,FALSE);//right downdir, left rightdir
  if(dir==DIR_RIGHT)
  {
  GrFloodFill(ap,41,46,FALSE);//right rightdir   
  }
 }
 else{
  GrFloodFill(ap,30,46,FALSE);//right part of shirt
  GrFloodFill(ap,24,46,FALSE);//left part of shirt  
 }
 if(dir==DIR_DOWN){ 
  GrFloodFill(ap,38,46,FALSE);//right downdir part of shirt
 }
 //pants
 GrFloodFill(ap,38,66,FALSE);

}


CDC *ShowBody(I64 armor,I64 dir )
{
 CDC *armorPiece = DCNew(100,100);
 DCFill(armorPiece,TRANSPARENT);
 switch(armor)
 { 
  case IT_SHIRT:
   Sprite3B(armorPiece,10,20,0,GetClothArmor(dir));
  break;
  case IT_SHIRTR:
   Sprite3B(armorPiece,10,20,0,GetClothArmor(dir));
   armorPiece->color=RED;
   RecolorShirt(armorPiece,dir); 
  break;
  case IT_SHIRTG:
   Sprite3B(armorPiece,10,20,0,GetClothArmor(dir));
   armorPiece->color=GREEN;
   RecolorShirt(armorPiece,dir); 
  break;
  case IT_SHIRTB:
   Sprite3B(armorPiece,10,20,0,GetClothArmor(dir));
   armorPiece->color=BLUE;
   RecolorShirt(armorPiece,dir); 
  break;
  case IT_SHIRTP:
   Sprite3B(armorPiece,10,20,0,GetClothArmor(dir));
   armorPiece->color=PURPLE;
   RecolorShirt(armorPiece,dir); 
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

