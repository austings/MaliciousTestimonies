U0 PrintInventory()
{
 Actor *p = GetNPC(PLAYER);
 U8 *str1 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    p->myInv->mtrx[0][0].occupied, p->myInv->mtrx[0][1].occupied, p->myInv->mtrx[0][2].occupied,
    p->myInv->mtrx[0][3].occupied, p->myInv->mtrx[0][4].occupied, p->myInv->mtrx[0][5].occupied,
    p->myInv->mtrx[0][6].occupied, p->myInv->mtrx[0][7].occupied, p->myInv->mtrx[0][8].occupied,
    p->myInv->mtrx[0][9].occupied, p->myInv->mtrx[0][10].occupied);

 U8 *str2 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    p->myInv->mtrx[1][0].occupied, p->myInv->mtrx[1][1].occupied, p->myInv->mtrx[1][2].occupied,
    p->myInv->mtrx[1][3].occupied, p->myInv->mtrx[1][4].occupied, p->myInv->mtrx[1][5].occupied,
    p->myInv->mtrx[1][6].occupied, p->myInv->mtrx[1][7].occupied, p->myInv->mtrx[1][8].occupied,
    p->myInv->mtrx[1][9].occupied, p->myInv->mtrx[1][10].occupied);

 U8 *str3 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    p->myInv->mtrx[2][0].occupied, p->myInv->mtrx[2][1].occupied, p->myInv->mtrx[2][2].occupied,
    p->myInv->mtrx[2][3].occupied, p->myInv->mtrx[2][4].occupied, p->myInv->mtrx[2][5].occupied,
    p->myInv->mtrx[2][6].occupied, p->myInv->mtrx[2][7].occupied, p->myInv->mtrx[2][8].occupied,
    p->myInv->mtrx[2][9].occupied, p->myInv->mtrx[2][10].occupied);
 
 U8 *str4 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    p->myInv->mtrx[3][0].occupied, p->myInv->mtrx[3][1].occupied, p->myInv->mtrx[3][2].occupied,
    p->myInv->mtrx[3][3].occupied, p->myInv->mtrx[3][4].occupied, p->myInv->mtrx[3][5].occupied,
    p->myInv->mtrx[3][6].occupied, p->myInv->mtrx[3][7].occupied, p->myInv->mtrx[3][8].occupied,
    p->myInv->mtrx[3][9].occupied, p->myInv->mtrx[3][10].occupied);


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
I64 *RetrieveItemID(I64 aID, I64 index, Bool select=FALSE){
 Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
 I64 i;
 for(i=0;i<INVWIDTH*INVHEIGHT;i++){
  if(toBeRetrieved->invID!=index)
   toBeRetrieved = toBeRetrieved->next;
  else
   break;
 }
 if(select){//move to mouse
  toBeRetrieved->visible = FALSE;
  return toBeRetrieved->id;
 }
 if(toBeRetrieved->visible==TRUE)
  return toBeRetrieved->id;
}

//convert inv id to item
Item *RetrieveItem(I64 aID, I64 index)
{
 Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
 I64 i;
 for(i=0;i<INVWIDTH*INVHEIGHT;i++)
 {
  if(toBeRetrieved->invID!=index)
   toBeRetrieved = toBeRetrieved->next;
  else
   break;
 }

 return toBeRetrieved;
}




Bool AddItemToInventory(I64 actorID, I64 itemID){
 I64 i,j,x,y,area;
 Actor *p = GetNPC(actorID);
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
     if(p->myInv->mtrx[j+y][i+x].occupied<0)
       area++;  
    }
   }

   if(area==(item->h)*(item->w)){
    QueIns(item,p->myInv->collection->last);
    //PopUpPrint( "item added");
    I64 cnt = ++p->myInv->count;
    
    for(x=item->w-1;x>=0;x--){  
     for(y=item->h-1;y>=0;y--){
      p->myInv->mtrx[j+y][i+x].occupied = cnt;
     }
    }
    item->invID = cnt;
    mc->reRenderInv=TRUE;

    return TRUE;
   }
  }
  skip_num:
 }
 mc->reRenderInv=TRUE;
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
 PrintInventory;
 mc->reRenderInv=TRUE;

}

//item is a invID
//removes inventory item by invID reference
U0 RemoveItemLocID(I64 invID, Bool delete =FALSE)
{

 Actor *p = GetNPC(PLAYER);

 I64 i,j;
 Item *torm = RetrieveItem(PLAYER,invID);
 
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

 PrintInventory;
 mc->reRenderInv=TRUE;

}



U0 ChangeItemLoc(U8 newI, U8 newJ, Item *item)
{
 Actor *p = GetNPC(0);

 I64 i,j,x,y;

 //remove old loc
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
    if(p->myInv->mtrx[j][i].occupied==item->invID){  
     for(x=0;x<item->w;x++)
     {  
      for(y=0;y<item->h;y++)
      {
       p->myInv->mtrx[j+y][i+x].occupied = IT_NULL;
      }
     }

    
    }
   
      
  }
 }
 item->visible=TRUE;
 //add new loc
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
    if(i==newI&&j==newJ){
     for(x=0;x<item->w;x++)
     {  
      for(y=0;y<item->h;y++)
      {
       p->myInv->mtrx[j+y][i+x].occupied = item->invID;
      }
     }
    }

  }
 }
 mc->reRenderInv=TRUE;

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


U0 ComputeArmorOffsets(Actor *toRender, I64 dir,I64 *xOff, I64 *yOff)
{
 // Create a value based on timer (cycle every 30 ticks)
 if(toRender->walking!=W_NOTWALKING){
  F64 t = (world->timer % 30) / 30.0 * 2.0 * pi;
  I64 groffset = ToI64(Sin(t) * 3.0); // values from -3 to +3
  if(dir == DIR_RIGHT || dir == DIR_LEFT){
   *xOff += (groffset/2);
   *yOff += (groffset/2);
  } else {
   *yOff += groffset;
  }
 }

// Director *task =FindDirective(toRender);  
// if(!task)
//  return;
// else{
//  *xOff += task->xAOff;
//  *yOff += task->yAOff;
// }
}

U0 OverlayArmor(CDC *dc, Actor *toRender)
{

 //this is a switch statement to animate the armor based on
 //the world timer status
 I64 dir = GetDir(toRender);

 I64 yOff = 0;
 I64 xOff = 0;
 ComputeArmorOffsets(toRender, dir,&xOff,&yOff);
 CDC *armor = ShowBody(toRender->armor,dir);
 CDC *hair = ShowHair(toRender->hair,dir);
 CDC *hat = ShowHelm(toRender->hat,dir);
 GrBlot3(dc,0+xOff,0+yOff,0, armor);
 GrBlot3(dc,0+xOff,0+yOff,10,hair);
 GrBlot3(dc,0+xOff,0+yOff,0, hat);

 DCDel(armor); 
 DCDel(hair); 
 DCDel(hat); 
}

