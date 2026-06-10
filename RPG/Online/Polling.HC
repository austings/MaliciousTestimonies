//test
//15 Max dialgoue chat window new


U0 CopyName(U8 *dst,U8 *src)
{
 I64 i;

 for(i=0;i<14 && src[i];i++)
  dst[i]=src[i];

 dst[i]=0;
}

U0 SpawnRemotePlayer(I64 fd, U8 *msg)
{
 U8 name[15],*nameptr=name;
 U8 id[8],*idptr=id;
 U8 tribe[8],*tribeptr=tribe;
 U8 hair[8],*hairptr=hair;
 U8 face[8],*faceptr=face;
 U8 hat[8],*hatptr=hat;
 U8 armor[8],*armorptr=armor;
 U8 sword[8],*swordptr=sword;
 U8 ring1[8],*ring1ptr=ring1;
 U8 x[8],*xptr=x;
 U8 y[8],*yptr=y;

 StrScan(msg,
  "JOIN\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
  &nameptr,
  &idptr,
  &tribeptr,
  &hairptr,
  &faceptr,
  &hatptr,
  &armorptr,
  &swordptr,
  &ring1ptr,
  &xptr,
  &yptr
 );

 Actor *remote=
  MakeActor(
   -mc->clientCount,
   Str2I64(tribe),
   Str2I64(hair),
   Str2I64(face),
   Str2I64(hat),
   Str2I64(armor),
   Str2I64(sword),
   Str2I64(ring1),
   Str2I64(x),
   Str2I64(y)
  );

 I64 i;

 CopyName(remote->name,nameptr);

 QueIns(remote,actors->last);

 SetTensorNPC(
  world->level,
  remote->id,
  remote->x,
  remote->y,
  world->currentZ
 );

 PrintDevMessage(
  MStrPrint("Spawned %s (%d)",
            remote->name,
            remote->id)
 );

 SendRemoteHeaders(fd, remote);
}
U0 HandlePacket(I64 fd, U8 *msg)
{
 if(!StrNCmp(msg,"JOIN ",5))
 {
  PrintDevMessage("User spawning");
  mc->clientCount++;
  SpawnRemotePlayer(fd, msg);
 }
}


U0 HandleClientPacket(U8 *msg)
{
 if(!StrNCmp(msg,"ASSIGNID",8))
 {
  ValidateJoin(msg);
 }
}


U0 PollHostConnections()
{
 I64 fd;
 U8 buf[STR_LEN];
 U8 *line;
 U8 *ptr;
 I64 len;
 if(NetPollForRead(1,&mc->hostSocket)!=-1) {
  fd=NetAccept(mc->hostSocket,NULL);
  PrintDevMessage(MStrPrint("Client Connected"));
  while(NetPollForRead(1,&fd)==-1)
   Sleep(1);
  len=NetRead(fd,buf,STR_LEN-1); 
  if(len>0) {
   buf[len]=0;
   PrintDevMessage(
    MStrPrint("Received: %s",buf)
   );
   ptr = buf;
   while(line = ReadALine(&ptr))
   {
    HandlePacket(fd, line);
    Free(line);
   }
  }
 }
}

U0 PollServerMessages()
{
 U8 buf[STR_LEN];
 I64 len;
 //PrintDevMessage(MStrPrint("About to Read"));
 
 if(NetPollForRead(1,&mc->serverSocket)!=-1)
 {
  PrintDevMessage(MStrPrint("Reading"));
  len=NetRead(mc->serverSocket,buf,STR_LEN-1);

  if(len>0)
  {
   buf[len]=0;

   HandleClientPacket(buf);
  }
 }
}