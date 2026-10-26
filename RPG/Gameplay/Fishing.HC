#define FISHING_RANGE 4
#define FISHING_CYCLE_TICKS 24
#define FISHING_RIPPLE_START 8

Bool IsFishingWater(I64 x,I64 y)
{
 if(x<0 || x>=wX || y<0 || y>=wY)
  return FALSE;
 if(GetTensorWaterLevel(world->level,x,y,world->currentZ)<=0)
  return FALSE;
 return TRUE;
}

Bool IsFishingTargetTile(I64 x,I64 y)
{
 if(Abs(x-world->fishingOriginX)+Abs(y-world->fishingOriginY)>
    FISHING_RANGE)
  return FALSE;
 return IsFishingWater(x,y);
}

Bool ChooseFishingWater(I64 *outX,I64 *outY,Bool excludeFish=FALSE)
{
 I64 x,y,count=0,index;
 I64 candidatesX[81],candidatesY[81];
 for(y=world->fishingOriginY-FISHING_RANGE;
     y<=world->fishingOriginY+FISHING_RANGE;y++){
  for(x=world->fishingOriginX-FISHING_RANGE;
      x<=world->fishingOriginX+FISHING_RANGE;x++){
   if(IsFishingTargetTile(x,y) &&
      (!excludeFish || x!=world->fishingFishX ||
       y!=world->fishingFishY)){
    candidatesX[count]=x;
    candidatesY[count]=y;
    count++;
   }
  }
 }
 if(count==0)
  return FALSE;
 index=RandU16()%count;
 *outX=candidatesX[index];
 *outY=candidatesY[index];
 return TRUE;
}

U0 MoveFishingFish()
{
 I64 x[4],y[4],count=0,index;
 if(IsFishingTargetTile(world->fishingFishX-1,world->fishingFishY)){
  x[count]=world->fishingFishX-1;
  y[count++]=world->fishingFishY;
 }
 if(IsFishingTargetTile(world->fishingFishX+1,world->fishingFishY)){
  x[count]=world->fishingFishX+1;
  y[count++]=world->fishingFishY;
 }
 if(IsFishingTargetTile(world->fishingFishX,world->fishingFishY-1)){
  x[count]=world->fishingFishX;
  y[count++]=world->fishingFishY-1;
 }
 if(IsFishingTargetTile(world->fishingFishX,world->fishingFishY+1)){
  x[count]=world->fishingFishX;
  y[count++]=world->fishingFishY+1;
 }
 if(count>0){
  index=RandU16()%count;
  world->fishingFishX=x[index];
  world->fishingFishY=y[index];
 }
}

U0 MoveFishingCursor(I64 dx,I64 dy)
{
 I64 x=world->fishingCursorX+dx;
 I64 y=world->fishingCursorY+dy;
 if(IsFishingTargetTile(x,y)){
  world->fishingCursorX=x;
  world->fishingCursorY=y;
 }
}

U0 ThrowFishingHarpoon()
{
 Actor *p=GetPlayer();
 I64 splashX,splashY;
 SetActorDir(p,DIR_DOWN);
 if(!FindDirective(p)){
  switch(p->face){
   case T_JUDA: AddDirective(T1FISH,p); break;
   case T_LEVI: AddDirective(T2FISH,p); break;
   case T_EPHR: AddDirective(T3FISH,p); break;
   case T_BENJ: AddDirective(T4FISH,p); break;
  }
 }
 splashX=(world->fishingCursorX-camera->topLR)*camera->dividX+
         camera->cameraOffSetX-25;
 splashY=(world->fishingCursorY-camera->topUD)*camera->dividY+
         camera->cameraOffSetY+35;
 if(!HasDirective(EFFFISH,p))
  AddDirective(EFFFISH,p,splashX,splashY);
 if(world->fishingRipple &&
    world->fishingCursorX==world->fishingFishX &&
    world->fishingCursorY==world->fishingFishY){
  if(AddItemToInventory(GetPlayer()->myInv,IT_FISH1)){
   world->fishingCaught=TRUE;
   world->fishingFeedbackTicks=8;
   world->fishingRipple=FALSE;
   world->fishingTimer=FISHING_CYCLE_TICKS-1;
  }else{
   world->fishingCaught=FALSE;
   world->fishingFeedbackTicks=8;
  }
 }else{
  world->fishingCaught=FALSE;
  world->fishingFeedbackTicks=8;
 }
}

Bool FishingHandleKeyboard(Actor *p)
{
 if(!mc->fishingMode)
  return FALSE;
 if(KeyPressed(&keyboard.esc)){
  mc->fishingMode=FALSE;
  world->fishingRipple=FALSE;
  return TRUE;
 }
 if(KeyPressed(&keyboard.up)) MoveFishingCursor(0,-1);
 else if(KeyPressed(&keyboard.down)) MoveFishingCursor(0,1);
 else if(KeyPressed(&keyboard.left)) MoveFishingCursor(-1,0);
 else if(KeyPressed(&keyboard.right)) MoveFishingCursor(1,0);
 if(KeyPressed(&keyboard.enter))
  ThrowFishingHarpoon;
 return TRUE;
}

U0 FishingWorldTick()
{
 if(!mc->fishingMode)
  return;
 if(world->fishingFeedbackTicks>0)
  world->fishingFeedbackTicks--;
 world->fishingTimer++;
 if(world->fishingTimer>=FISHING_CYCLE_TICKS){
  world->fishingTimer=0;
  world->fishingRipple=FALSE;
  MoveFishingFish;
 }else if(world->fishingTimer>=FISHING_RIPPLE_START){
  world->fishingRipple=TRUE;
 }
}

U0 RenderFishingOverlay(CDC *dc)
{
 I64 x,y,phase,radius;
 if(!mc->fishingMode)
  return;
 if(world->fishingRipple){
  x=(world->fishingFishX-camera->topLR)*camera->dividX+
     camera->cameraOffSetX;
  y=(world->fishingFishY-camera->topUD)*camera->dividY+
     camera->cameraOffSetY;
  dc->color=WHITE;
  phase=world->fishingTimer%8;
  radius=5+phase*2;
  GrCircle(dc,x+21,y+21,radius);
  GrCircle(dc,x+21,y+21,Max(radius-7,3));
 }
 x=(world->fishingCursorX-camera->topLR)*camera->dividX+
    camera->cameraOffSetX;
 y=(world->fishingCursorY-camera->topUD)*camera->dividY+
    camera->cameraOffSetY;
 dc->color=YELLOW;
 GrLine(dc,x+2,y+2,x+40,y+2);
 GrLine(dc,x+2,y+40,x+40,y+40);
 GrLine(dc,x+2,y+2,x+2,y+40);
 GrLine(dc,x+40,y+2,x+40,y+40);
 if(world->fishingFeedbackTicks>0){
  if(world->fishingCaught)
   dc->color=YELLOW;
  else
   dc->color=LTGRAY;
  GrCircle(dc,x+21,y+21,12);
 }
 dc->color=WHITE;
 PrintLine(dc,"HARPOON FISHING: arrows aim | Enter throws | Escape leaves",
           12,440);
 if(world->fishingFeedbackTicks>0){
  if(world->fishingCaught){
   dc->color=YELLOW;
   PrintLine(dc,"SPLASH! Fish caught.",12,458);
  }else{
   dc->color=LTGRAY;
   PrintLine(dc,"Splash. No catch; watch for the next ripple.",12,458);
  }
 }
}

U0 FishingHoleTrigger(Actor *p)
{
 I64 x,y;
 if(p->sword!=IT_HARPOON)
  return;
 world->fishingOriginX=p->x;
 world->fishingOriginY=p->y;
 world->fishingCursorX=p->x;
 world->fishingCursorY=p->y;
 world->fishingFishX=-1;
 world->fishingFishY=-1;
 if(!ChooseFishingWater(&x,&y,FALSE)){
  mc->dialogName="No water in harpoon range";
  return;
 }
 world->fishingFishX=x;
 world->fishingFishY=y;
 if(!ChooseFishingWater(&world->fishingCursorX,
                        &world->fishingCursorY,TRUE)){
  world->fishingCursorX=x;
  world->fishingCursorY=y;
 }
 world->fishingTimer=1;
 world->fishingFeedbackTicks=0;
 world->fishingRipple=FALSE;
 world->fishingCaught=FALSE;
 p->hasPath=FALSE;
 p->pathLen=0;
 p->pathIndex=0;
 p->walking=DIR_IDLE;
 p->walkingSubFrame=DIR_IDLE;
 mc->fishingMode=TRUE;
}
