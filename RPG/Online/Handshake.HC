

U0 ValidateJoin(U8 *msg)
{
 U8 id[16],*idptr=id;
 U8 x[16],*xptr=x;
 U8 y[16],*yptr=y;

 StrScan(
  msg,
  "ASSIGNID\t%s\t%s\t%s",
  &idptr,
  &xptr,
  &yptr
 );

 Actor *p = GetPlayer();

 p->id = Str2I64(id);
 p->x  = Str2I64(x);
 p->y  = Str2I64(y);
 mc->localPlayerId = p->id;

 SetTensorNPC(
  world->level,
  p->id,
  p->x,
  p->y,
  world->currentZ
 );

 PrintDevMessage(
  MStrPrint(
   "Assigned ID=%d X=%d Y=%d",
   p->id,
   p->x,
   p->y
  )
 );
}