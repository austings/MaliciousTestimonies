
class Object:CQue{
  I64 objID,chestID;
  Inventory *myInv;

} obj_que;

#define MAX_CHESTS 10

U0 GetItemScreenLoc(I64 invIDToFetch, I64 *x, I64 *y){
 I64 i,j; 
 Actor *p = GetNPC(0);
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
   if(p->myInv->mtrx[j][i].occupied==invIDToFetch)
   { 
    *x = i*45+2+15;
    *y = j*42+310;
    goto please_clap;
    
   }         
  }
 }
 please_clap:
}

U0 BuildChests(Inventory *inv, I64 id){
  switch(id){
   case CAMPCHEST:
    AddItemToInv(inv,IT_POT);
    AddItemToInv(inv,IT_POT);
    AddItemToInv(inv,IT_POT);   
   break; 

  }
}

U0 ObjQueInit()
{
 QueInit(&obj_que);
 Object *listItem;
 Inventory *newInv;
 I64 i;
 for(i=CAMPCHEST;i<MAX_CHESTS;i++){
  listItem = CAlloc(sizeof(Object));
  listItem->objID = i;
  listItem->chestID = i; 
  newInv = MakeInventory();
  BuildChests(newInv, i);
  listItem->myInv = newInv;
  QueIns(listItem,obj_que.last);
 }
 listItem=obj_que.next;
}


Inventory *GrabChest(I64 chestID){
 I64 i;
   
 Object *myObject= obj_que.next;
 for(i=0;i!=QueCnt(obj_que);i++){
  if(myObject->chestID==chestID){
   return myObject->myInv;
  }
  myObject = myObject->next;
 }

 return player->myInv; 
}

U0 FreeObjQue()
{
 QueDel(&obj_que);
 Free(&obj_que);
}
