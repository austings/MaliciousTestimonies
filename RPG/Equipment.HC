//test


Bool AddItemToInventory(I64 actorID, I64 itemID)
{
 I64 i,j,x,y,area;
 Actor *p = GetNPC(actorID);
 Item *item = MakeItem(itemID);
 
 for(i=0;i<11;i++)
 {
  for(j=0;j<4;j++)
  {
   area=0;
   for(x=item->w-1;x>=0;x--)
   {
    if(i+x>=11)
     goto skip_num;
 
    for(y=item->h-1;y>=0;y--)
    {
     if(j+y>=4)
      goto skip_num;
     if(p->myInv->mtrx[j+y][i+x].occupied<0)
       area++;
  
    }
   }

   if(area==(item->h)*(item->w))
   {
    QueIns(item,p->myInv->collection->last);
    //PopUpPrint( "item added");
    I64 cnt = ++p->myInv->count;
    
    for(x=item->w-1;x>=0;x--)
    {  
     for(y=item->h-1;y>=0;y--)
     {
      p->myInv->mtrx[j+y][i+x].occupied = cnt;
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
U0 RemoveItemLoc(Item *item)
{
 Actor *p = GetNPC(0);

 I64 i,j,x,y;

 //remove old loc
 for(i=0;i<11;i++)
 {
  for(j=0;j<4;j++)
  {
    if(p->myInv->mtrx[j][i].occupied==item->invID)
    {  p->myInv->mtrx[j][i].occupied=-1; }
   
      
  }
 }
}

U0 ChangeItemLoc(U8 newI, U8 newJ, Item *item)
{
 Actor *p = GetNPC(0);

 I64 i,j,x,y;

 //remove old loc
 for(i=0;i<11;i++)
 {
  for(j=0;j<4;j++)
  {
    if(p->myInv->mtrx[j][i].occupied==item->invID)
    {  p->myInv->mtrx[j][i].occupied=-1; }
   
      
  }
 }
 item->visible=TRUE;
 //add new loc
 for(i=0;i<11;i++)
 {
  for(j=0;j<4;j++)
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


}

I64 *RetrieveItemID(I64 aID, I64 index, Bool select=FALSE)
{
  Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
  I64 i;
  for(i=0;i<index;i++)
  {
    toBeRetrieved = toBeRetrieved->next;
  }
  //DocPrint("%d",toBeRetrieved->id);
  if(select)//move to mouse
  {
   toBeRetrieved->visible = FALSE;
   return toBeRetrieved->id;
  }
  if(toBeRetrieved->visible==TRUE)
   return toBeRetrieved->id;

}

Item *RetrieveItem(I64 aID, I64 index, Bool select=FALSE)
{
  Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
  I64 i;
  for(i=0;i<index;i++)
  {
    toBeRetrieved = toBeRetrieved->next;
  }
  return toBeRetrieved;
}


