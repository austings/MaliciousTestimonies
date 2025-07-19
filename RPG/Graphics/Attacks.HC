

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





Bool CheckTarget(Actor *toRender){
 //optionally highlight targets for strikes
 Bool highlight= FALSE;
 if((mc->combatMenuSelection==CS_STRIKE||
     mc->combatMenuSelection==CS_PRAYER2)&&
    toRender->id==ctp->ready->id)
 {
  highlight = TRUE;
  mc->target = toRender;
  mc->tarposx = toRender->screenX;
  mc->tarposy = toRender->screenY;//change default target
 }

 return highlight;
}

//called after combatMenuSelection==11
U0 HighlightTarget(CDC *dc, I64 hX, I64 hY,I64 hZ)
{
 dc->color=RED;
 dc->thick=3;
    //GrRect3(dc,hX+25,hY+45,0,50,50);
 GrCircle3(dc,hX+25,hY+45,0,15);
    //GrFloodFill(dc,hX+13,hY+13,TRUE);   
 dc->thick = 1;   
}

U0 PlayStrikeAnim(Actor *p)
{
 AddDirective(T1PUNCH,p); 
}
