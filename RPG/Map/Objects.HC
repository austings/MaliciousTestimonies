
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
  listItem->chestID = i; 
  newInv = MakeInventory();
  listItem->myInv = newInv;
  QueIns(listItem,obj_que.last);
 }
 listItem=obj_que.next;
}


Inventory *GrabChest(I64 chestID)
{
 I64 i;
 Object *myObject= obj_que.next;
 for(i=0;i!=QueCnt(obj_que);i++)
 {
  if(myObject->chestID==chestID)
  {
   return myObject->myInv;
   //break;
  }
  myObject = myObject->next;
 }

 return NULL;//player->myInv; 
}

U0 FreeObjQue()
{
 QueDel(&obj_que);
 Free(&obj_que);
}
