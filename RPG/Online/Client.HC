//test
U8 *SerializeActor(Actor *a)
{
 return MStrPrint(
  "JOIN\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",
  a->name,
  a->id,
  a->tribe,
  a->hair,
  a->face,
  a->hat,
  a->armor,
  a->sword,
  a->ring1,
  a->x,
  a->y
 );
}

U0 ConnectToHost(){
 CNetAddr *addr;

 mc->serverSocket=NetSocketNew;
 addr=NetAddrNew("127.0.0.1",8000);

 if(NetConnect(mc->serverSocket,addr)==0) {
  
  U8* msg = SerializeActor(GetPlayer());

  NetWrite(mc->serverSocket,msg,StrLen(msg));
 }

 NetAddrDel(addr);
}

U0 ClientTick(){
 if(!mc->clientInitialized)
 {
  if(mc->currentMenu==1){
   ConnectToHost();
   mc->clientInitialized=TRUE;
  }
  goto skip;
 }
 PollServerMessages();
 skip:
}
