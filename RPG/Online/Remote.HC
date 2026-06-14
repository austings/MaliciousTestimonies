
U0 CopyName(U8 *dst,U8 *src)
{
 I64 i;

 for(i=0;i<14 && src[i];i++)
  dst[i]=src[i];

 dst[i]=0;
}

Actor *SpawnRemotePlayer( U8 *msg)
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
 I64 spawnX, spawnY;
PrintDevMessage(
 MStrPrint("RAW=[%s]",msg)
);

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

PrintDevMessage(
 MStrPrint(
  "JOIN name=%s tribe=%s hair=%s face=%s",
  nameptr,
  tribeptr,
  hairptr,
  faceptr
 )
);
 FindFreeSpawnTile(&spawnX,&spawnY);

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
   spawnX,
   spawnY
  );

 I64 i;
PrintDevMessage(
 MStrPrint("About To Copy Name")
);
 CopyName(remote->name,nameptr);
PrintDevMessage(
 MStrPrint("Copied Name")
);

PrintDevMessage(
 MStrPrint("Actors=%X",actors)
);
 QueIns(remote,actors->last);
PrintDevMessage(
 MStrPrint("Setting Tensor")
);
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

 return remote;
}
