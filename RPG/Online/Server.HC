//test

class NetClient {
    I64 fd;
    I64 actorId;
};


U0 StartHost()
{
 mc->hostSocket=NetSocketNew;

 PrintDevMessage(
  MStrPrint("Host Socket=%d",mc->hostSocket)
 );

 CNetAddr *addr=
  NetAddrNew("127.0.0.1",8000);

 PrintDevMessage(
  MStrPrint("Binding")
 );

 NetBindIn(mc->hostSocket,addr);

 PrintDevMessage(
  MStrPrint("Listening")
 );

 NetListen(mc->hostSocket,4);
}

U0 HostTick()
{
 if(!mc->hostInitialized&&mc->currentMenu==1){
  StartHost();
  mc->hostInitialized=TRUE;
 }

 PollHostConnections();
}


U0 NetTask()
{
 while(TRUE)
 {
  switch(mc->netMode)
  {
   case NET_HOST:
    HostTick();
   break;
   case NET_CLIENT:
    ClientTick();
   break;
   //todo; break out in singleplayer
  }
  Sleep(10);
 }
}

U0 ServerClean()
{

 //
 // Cleanup
 //
 /*
 for(i=0;i<mc->clientCount;i++)
 {
  NetClose(mc->clients[i]->fd);
  Free(mc->clients[i]);
 }

 NetClose(s);
 NetAddrDel(addr);*/
}
