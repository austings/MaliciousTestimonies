

static CDC *loadedAttackFrame= FramePtr("WINV013");

I64 CalculateAngle(I64 x1 , I64 y1 , I64 x2 ,I64 y2)
{
  I64 dx = x2 -x1;
  I64 dy = y2-y1;
  if(dx ==0 && dy > 0){
    return 180;}
  else if( dx >0 &&dy ==0){
    return 90;}
  else if(dx == 0 && dy < 0){
   return 0;}
  else if(dx <0 && dy == 0){
   return 270;}
  else{ 
  return 90;}
}

U0 PunchMove(CDC *screen,Actor *tar,I64 sX,I64 sY, I64 theta)
{

 DCDepthBufRst(loadedAttackFrame);
 loadedAttackFrame->z=GR_Z_ALL;
 Mat4x4IdentEqu(loadedAttackFrame->r);
 Mat4x4RotX(loadedAttackFrame->r,theta+180);
 GrBlot3(screen,sX,sY,10, loadedAttackFrame);

 //hp bar
 //CDC *newFill = DCNew(100,100);
 //GrRect(newFill,0,0,((tar->currentHealth)/tar->health)*100,20);
 //GrBlot3(screen,sX,sY,10,newFill);
 
}