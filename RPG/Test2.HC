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

Animation *AddFrame(CDC *frame,U8* key,I8 fIndex; 
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
 if(StrCmp(wadFrameName,T1FISH)==0){
   QueIns(AddFrame(AAE110,T1FISH,0,5,2),allAnimations.last);  
   QueIns(AddFrame(AAE111,T1FISH,1,5,2),allAnimations.last);

 } else if(StrCmp(wadFrameName,T2FISH)==0){
   QueIns(AddFrame(AAE164,T2FISH,0,5,2),allAnimations.last);   
   QueIns(AddFrame(AAE165,T2FISH,1,5,2),allAnimations.last);

 } else if(StrCmp(wadFrameName,T3FISH)==0){
   QueIns(AddFrame(AAE2,T3FISH,0,5,2),allAnimations.last);  
   QueIns(AddFrame(AAE3,T3FISH,1,5,2),allAnimations.last);

 } else if(StrCmp(wadFrameName,T4FISH)==0){
   QueIns(AddFrame(AAE56,T4FISH,0,5,2),allAnimations.last); 
   QueIns(AddFrame(AAE57,T4FISH,1,5,2),allAnimations.last);

 } else if(StrCmp(wadFrameName,T1READY)==0){
   QueIns(AddFrame(AAE60,T1READY,0),allAnimations.last);
   QueIns(AddFrame(AAE61,T1READY,1),allAnimations.last);
   QueIns(AddFrame(AAE62,T1READY,2),allAnimations.last);    
  
 } else if(StrCmp(wadFrameName,T2READY)==0){
   QueIns(AddFrame(AAE115,T2READY,0),allAnimations.last);
   QueIns(AddFrame(AAE116,T2READY,1),allAnimations.last);
   QueIns(AddFrame(AAE117,T2READY,2),allAnimations.last);    
  
 } else if(StrCmp(wadFrameName,T3READY)==0){
   QueIns(AddFrame(AAE169,T3READY,0),allAnimations.last);
   QueIns(AddFrame(AAE170,T3READY,1),allAnimations.last);
   QueIns(AddFrame(AAE171,T3READY,2),allAnimations.last);    
  
 } else if(StrCmp(wadFrameName,T4READY)==0){
   QueIns(AddFrame(AAE7,T4READY,0),allAnimations.last);
   QueIns(AddFrame(AAE8,T4READY,1),allAnimations.last);
   QueIns(AddFrame(AAE9,T4READY,2),allAnimations.last);    
  
 } else if(StrCmp(wadFrameName,T1PUNCH)==0){
   QueIns(AddFrame(AAE61,T1PUNCH,0),allAnimations.last);
   QueIns(AddFrame(AAE62,T1PUNCH,1),allAnimations.last);
   QueIns(AddFrame(AAE63,T1PUNCH,2),allAnimations.last);    
   QueIns(AddFrame(AAE64,T1PUNCH,3),allAnimations.last);
   QueIns(AddFrame(AAE65,T1PUNCH,4),allAnimations.last);
   QueIns(AddFrame(AAE66,T1PUNCH,5),allAnimations.last);    
   QueIns(AddFrame(AAE67,T1PUNCH,6),allAnimations.last);
   QueIns(AddFrame(AAE68,T1PUNCH,7),allAnimations.last);
   QueIns(AddFrame(AAE69,T1PUNCH,8),allAnimations.last);    
   QueIns(AddFrame(AAE70,T1PUNCH,9),allAnimations.last);
   QueIns(AddFrame(AAE71,T1PUNCH,10),allAnimations.last);
   QueIns(AddFrame(AAE72,T1PUNCH,11),allAnimations.last);    
  
 } else if(StrCmp(wadFrameName,T2PUNCH)==0){
   QueIns(AddFrame(AAE115,T2PUNCH,0),allAnimations.last);
   QueIns(AddFrame(AAE116,T2PUNCH,1),allAnimations.last);
   QueIns(AddFrame(AAE117,T2PUNCH,2),allAnimations.last);    
   QueIns(AddFrame(AAE118,T2PUNCH,3),allAnimations.last);
   QueIns(AddFrame(AAE119,T2PUNCH,4),allAnimations.last);
   QueIns(AddFrame(AAE120,T2PUNCH,5),allAnimations.last);    
   QueIns(AddFrame(AAE121,T2PUNCH,6),allAnimations.last);
   QueIns(AddFrame(AAE122,T2PUNCH,7),allAnimations.last);
   QueIns(AddFrame(AAE123,T2PUNCH,8),allAnimations.last);    
   QueIns(AddFrame(AAE124,T2PUNCH,9),allAnimations.last);
   QueIns(AddFrame(AAE125,T2PUNCH,10),allAnimations.last);
   QueIns(AddFrame(AAE126,T2PUNCH,11),allAnimations.last);
    
 } else if(StrCmp(wadFrameName,T3PUNCH)==0){
   QueIns(AddFrame(AAE169,T3PUNCH,0),allAnimations.last);
   QueIns(AddFrame(AAE170,T3PUNCH,1),allAnimations.last);
   QueIns(AddFrame(AAE171,T3PUNCH,2),allAnimations.last);    
   QueIns(AddFrame(AAE172,T3PUNCH,3),allAnimations.last);
   QueIns(AddFrame(AAE173,T3PUNCH,4),allAnimations.last);
   QueIns(AddFrame(AAE174,T3PUNCH,5),allAnimations.last);    
   QueIns(AddFrame(AAE175,T3PUNCH,6),allAnimations.last);
   QueIns(AddFrame(AAE176,T3PUNCH,7),allAnimations.last);
   QueIns(AddFrame(AAE177,T3PUNCH,8),allAnimations.last);    
   QueIns(AddFrame(AAE178,T3PUNCH,9),allAnimations.last);
   QueIns(AddFrame(AAE179,T3PUNCH,10),allAnimations.last);
   QueIns(AddFrame(AAE180,T3PUNCH,11),allAnimations.last);
    
 } else if(StrCmp(wadFrameName,T4PUNCH)==0){
   QueIns(AddFrame(AAE7,T4PUNCH,0),allAnimations.last);
   QueIns(AddFrame(AAE8,T4PUNCH,1),allAnimations.last);
   QueIns(AddFrame(AAE9,T4PUNCH,2),allAnimations.last);    
   QueIns(AddFrame(AAE10,T4PUNCH,3),allAnimations.last);
   QueIns(AddFrame(AAE11,T4PUNCH,4),allAnimations.last);
   QueIns(AddFrame(AAE12,T4PUNCH,5),allAnimations.last);    
   QueIns(AddFrame(AAE13,T4PUNCH,6),allAnimations.last);
   QueIns(AddFrame(AAE14,T4PUNCH,7),allAnimations.last);
   QueIns(AddFrame(AAE15,T4PUNCH,8),allAnimations.last);    
   QueIns(AddFrame(AAE16,T4PUNCH,9),allAnimations.last);
   QueIns(AddFrame(AAE17,T4PUNCH,10),allAnimations.last);
   QueIns(AddFrame(AAE18,T4PUNCH,11),allAnimations.last);     
 }
 
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

 while(StrCmp(direct.cQueDirective,ajc->name)!=0)
 {
  ajc = ajc->next;
 } 
 while(direct.animIndex!=ajc->frameIndex)
 {
  ajc = ajc->next;
 }
 
 

 if(ajc->frameDurationIndex<ajc->frameDuration){
  ajc->frameDurationIndex++;
 }
 else{
  ajc->frameDurationIndex=0;
  Animation *tmp = ajc->next;
  direct.animIndex = direct.animIndex+1;
  if(StrCmp(direct.cQueDirective,tmp->name)!=0)
  {
     ResetDirective;
     //direct.a->visible = TRUE;
 
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

  CreateAnimation(T1READY);
  CreateAnimation(T2READY);
  CreateAnimation(T3READY);
  CreateAnimation(T4READY);

  CreateAnimation(T1PUNCH);
  CreateAnimation(T2PUNCH);
  CreateAnimation(T3PUNCH);
  CreateAnimation(T4PUNCH);
  //load all animations into the hashtable 
}


U0 CheckAnimQueue(CDC *dc)
{
  if(StrCmp(direct.cQueDirective,NoDirective)!=0)
  {
   PlayAnimation(dc);
  }
 
}




U0 DrawIt(CTask *task, CDC *dc)
{
 CheckAnimQueue(dc); //Sleep(30);
 
}

InitializeAnimator;

//direct.cQueDirective = T4FISH;
direct.cQueDirective = T1PUNCH;
//direct.cQueDirective = T4PUNCH;

Fs->draw_it=&DrawIt;
Sleep(10000);
Sleep(1000);

Sleep(1000);

Sleep(1);

Sleep(1);

Sleep(1);

Sleep(1);

Sleep(10000);


