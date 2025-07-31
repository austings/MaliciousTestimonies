
class Object:CQue{
  I64 objID,chestID;
  Inventory *myInv;

} obj_que;

#define MAX_CHESTS 10

U0 ObjQueInit()
{
 QueInit(&obj_que);
 Object *listItem;
 Inventory *newInv;
 I64 i;
 for(i=0;i<MAX_CHESTS;i++){
  listItem = CAlloc(sizeof(Object));
  listItem->objID = i;
  listItem->chestID = 0; 
  newInv = MakeInventory();
  listItem->myInv = newInv;

 }
}
