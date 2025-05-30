


Item *MakeItem(I64 id){
 Item * build = CAlloc(sizeof(Item));
 build->id=id;
 build->invID = -1;
 build->visible = TRUE;
 build->wOff=0;
 build->hOff=0;
  
 switch(id){
  case 0://not used
  build->name = "Bag";
  build->w=1,build->h=1;
  build->equip_slot=3;
  build->usable=FALSE;
  break;
  case IT_DAGGER:
  build->name = "Dagger";
  build->w=1,build->h=2;
  build->wOff=15;
  build->hOff=50;
  build->equip_slot=1;
  build->usable=FALSE;
  break;
  case IT_HARPOON:
  build->name = "Harpoon";
  build->w=1,build->h=3;
  build->wOff=25;
  build->hOff=25;
  build->equip_slot=1;
  build->usable=FALSE;
  break;
  case IT_TOOTH:
  build->name = "Wolf fang";
  build->w=1,build->h=1;
  build->equip_slot=0;
  build->usable=FALSE;
  break;
  case IT_FISH1:
  build->name = "Trout";
  build->w=1,build->h=2;
  build->hOff=32;
  build->equip_slot=0;
  build->usable=TRUE;
  break;
  case 999:
  build->name = "FISHINGSPOT";
  build->w=0,build->h=0;
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
  for(i=0;i<INVWIDTH;i++)
  {
   for(j=0;j<INVHEIGHT;j++)
   {
     newInv->mtrx[j][i].occupied =IT_NULL;
   }
  }

 //QueInit(p->myInv->collection);

 return newInv;
}