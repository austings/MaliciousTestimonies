//test

class NetClient {
    I64 fd;
    I64 actorId;
};


U0 StartHost(){
 NetClient *clients[MAX_PLAYERS];
 mc->clientCount=0;

 mc->hostSocket=NetSocketNew;

 mc->hostAddr=NetAddrNew("127.0.0.1",8000);
 NetBindIn(mc->hostSocket,mc->hostAddr);
 NetListen(mc->hostSocket,8);

}


U0 HostTick()
{
 if(!mc->hostInitialized&&mc->currentMenu = 1){
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
