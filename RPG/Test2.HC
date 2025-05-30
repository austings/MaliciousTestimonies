// Construct Graphics from WAD
#include "Data/Wad.HC";
#include "Data/Frames.HC";

// Load built-in Graphics
#include "Sprites/SS1.HC"; 
#include "Sprites/SpriteSheet2.HC";
#include "Sprites/SpriteSheet3.HC";
#include "Sprites/SpriteSheet4.HC";
// Loading Map
#include "Map/Map.HC";
#include "Map/Tensor3D.HC";
// Loading Data Into Map
#include "Map/Actors.HC";
#include "Map/Level.HC";
#define NoDirective "None"
//static CDC* AAE110 = FramePtr("AAE110");
//static CDC* AAE111 = FramePtr("AAE111");

class Animation:CQue{
  CDC *frame;
  I8 frameDuration,
     frameDurationIndex,
     xOffset, yOffset;
  U8 *name;
  I8 frameIndex;
} allAnimations;

class Director{
  U8 *cQueDirective;
  I32 animIndex;
  I64 x; I64 y; I64 z;

} direct;

Animation *AddFrame(CDC *frame,U8* key,I8 fIndex; 
                    I8 xO=0,I8 yO=0,I8 sfd=3)
{
  Animation *createdFrame = CAlloc(sizeof(Animation));
  createdFrame->frame = frame;
  createdFrame->frameDuration = sfd;
  createdFrame->frameDurationIndex = 0;
  createdFrame->frameIndex = fIndex;
  createdFrame->xOffset=xO;
  createdFrame->yOffset=yO;
  createdFrame->name = key;  
  return createdFrame;
}



Animation *CreateAnimation(U8* wadFrameName){
 if(!StrCmp(wadFrameName,T1FISH)){
   QueIns(AddFrame(AAE110,T1FISH,0),allAnimations.last);  
   QueIns(AddFrame(AAE111,T1FISH,1),allAnimations.last);
 } else if(!StrCmp(wadFrameName,T2FISH)){
   QueIns(AddFrame(AAE164,T2FISH,0),allAnimations.last);   
   QueIns(AddFrame(AAE165,T2FISH,1),allAnimations.last);
 } else if(!StrCmp(wadFrameName,T3FISH)){
   QueIns(AddFrame(AAE2,T3FISH,0),allAnimations.last);  
   QueIns(AddFrame(AAE3,T3FISH,1),allAnimations.last);
 } else if(!StrCmp(wadFrameName,T4FISH)){
   QueIns(AddFrame(AAE56,T4FISH,0),allAnimations.last); 
   QueIns(AddFrame(AAE57,T4FISH,1),allAnimations.last);


 }/*
 if(!StrCmp(wadFrameName,T1READY)){
   QueIns(AddFrame(AAE60),allAnimations.last);
   QueIns(AddFrame(AAE61),allAnimations.last);
   QueIns(AddFrame(AAE62),allAnimations.last);    
  
 } else if(StrCmp(wadFrameName,T2READY)){
   QueIns(AddFrame(AAE115),(*job).last);
   QueIns(AddFrame(AAE116),(*job).last);
   QueIns(AddFrame(AAE117),(*job).last);    
  
 } else if(StrCmp(wadFrameName,T3READY)){
   QueIns(AddFrame(AAE169),(*job).last);
   QueIns(AddFrame(AAE170),(*job).last);
   QueIns(AddFrame(AAE171),(*job).last);    
  
 } else if(StrCmp(wadFrameName,T4READY)){
   QueIns(AddFrame(AAE7),(*job).last);
   QueIns(AddFrame(AAE8),(*job).last);
   QueIns(AddFrame(AAE9),(*job).last);    
  
 } else if(StrCmp(wadFrameName,T1PUNCH)){
 } else if(StrCmp(wadFrameName,T2PUNCH)){
 } else if(StrCmp(wadFrameName,T3PUNCH)){
 } else if(StrCmp(wadFrameName,T4PUNCH)){
 */

}
U0 ResetDirective()
{
  direct.cQueDirective = NoDirective;
  direct.animIndex = 0;
  direct.x = 0;
  direct.y = 0;
}

U0 PlayAnimation(CDC *dc){ 
 Animation *ajc = allAnimations.next;
 while(StrCmp(direct.cQueDirective,ajc->name)){//if anim call this one
  ajc = ajc->next;
 } 
 
 while(direct.animIndex=0&&ajc->frameIndex!=0){
  ajc = ajc->last;
 }
 if(ajc->frameDurationIndex<ajc->frameDuration){
  ajc->frameDurationIndex++;
 }
 else{
  ajc->frameDurationIndex=0;
  Animation *tmp = ajc->next;
  direct.animIndex++;
  if(tmp->frameIndex<=ajc->frameIndex)
  {
    ResetDirective;
  }
 }
 GrBlot3(dc,direct.x+ajc->xOffset,
             direct.y+ajc->yOffset,
             direct.z+100,
             ajc->frame);
  
}


U0 InitializeAnimator(){
  //initialize empty job queue
  QueInit(&allAnimations);
  ResetDirective;
  CreateAnimation(T1FISH);
  CreateAnimation(T2FISH);
  CreateAnimation(T3FISH);
  CreateAnimation(T4FISH);
  //load all animations into the hashtable 
}


U0 CheckAnimQueue(CDC *dc)
{
  if(StrCmp(direct.cQueDirective,NoDirective))
  {
   PlayAnimation(dc);
  }
 
}




U0 DrawIt(CTask *task, CDC *dc)
{
 CheckAnimQueue(dc); //Sleep(30);
 
}

InitializeAnimator;
direct.cQueDirective = T1FISH;
Animation *ajc = allAnimations.next;

"\nName;%s\n",ajc->name;
Fs->draw_it=&DrawIt;
Sleep(1000);
Sleep(10);

Sleep(10);
Sleep(10);

direct.cQueDirective = T2FISH;
Sleep(10);
Sleep(1000);

direct.cQueDirective = T3FISH;
Sleep(1000);

direct.cQueDirective = T4FISH;
Sleep(1000);
direct.cQueDirective = NoDirective;


