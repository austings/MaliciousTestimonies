//test

U0 SendRemoteHeaders(I64 fd, Actor *remote)
{
 U8 *msg;

 remote->id = mc->nextClientId;
 mc->nextClientId--;

 // Spawn near host for now
 Actor *host = GetPlayer();

 remote->x = host->x + 1;
 remote->y = host->y;

 msg = MStrPrint(
  "ASSIGNID\t%d\t%d\t%d",
  remote->id,
  remote->x,
  remote->y
 );

 NetWrite(fd,msg,StrLen(msg));
 Free(msg);

 SetTensorNPC(
  world->level,
  remote->id,
  remote->x,
  remote->y,
  world->currentZ
 );
}


