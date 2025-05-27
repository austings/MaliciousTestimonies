


Item *MakeItem(I64 id){
 Item * build = CAlloc(sizeof(Item));
 build->id=id;
 build->invID = -1;
 build->visible = TRUE;
 build->wOff=0;
 build->hOff=0;
  
 switch(id)
 {
  case 0://not used
  build->name = "Bag";
  build->w=1,build->h=1;
  build->equip_slot=3;
  build->usable=FALSE;
  break;
  case 1:
  build->name = "Dagger";
  build->w=1,build->h=2;
  build->wOff=15;
  build->hOff=50;
  build->equip_slot=1;
  build->usable=FALSE;
  break;
  case 2:
  build->name = "Harpoon";
  build->w=1,build->h=3;
  build->wOff=25;
  build->hOff=25;
  build->equip_slot=1;
  build->usable=FALSE;
  break;
  case 3:
  build->name = "Wolf fang";
  build->w=1,build->h=1;
  build->equip_slot=0;
  build->usable=FALSE;
  break;

 }
 return build;
}

Inventory *MakeInventory()
{
  I64 i,j;
  Inventory *newInv = MAlloc(sizeof(Inventory));
  //newInv->maxWeight = weight;
  Item *item_que = MAlloc(sizeof(Item));
  QueInit(item_que);
  QueIns(MakeItem(0),item_que->last);
  newInv->collection = item_que;
  newInv->count = 0;
  for(i=0;i<11;i++)
  {
   for(j=0;j<4;j++)
   {
     newInv->mtrx[j][i].occupied =-1;
   }
  }

 //QueInit(p->myInv->collection);

 return newInv;
}