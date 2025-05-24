#include "Data/Frames.HC"

class Animation:CQue{
    CDC *frame;
    I8 frameDuration,
       durationIndex,
       xOffset, yOffset;
};


class AnimationJob:CQue{
  Animation *sequence;
  U8 *name;
  I32 index;
  I32 frameCount;
  I32 x;
  I32 y;
  I32 z;
} animationQue;

CHashTable *allAnimations = HashTableNew(4096);

Animation *AddFrame( CDC *frame,I32 xO=0,I32 yO=0,I8 sfd=3)
{
  Animation *createdFrame = CAlloc(sizeof(Animation));
  createdFrame->frame = frame;
  createdFrame->frameDuration = sfd;
  createdFrame->durationIndex = 0;
  createdFrame->xOffset=xO;
  createdFrame->yOffset=yO;
  return createdFrame;
}


Animation *CreateAnimation(U8* wadFrameName)
{
 Animation *job = CAlloc(sizeof(Animation));

 QueInit(job);

 if(       StrCmp(wadFrameName,"T1Ready")){
   QueIns(AddFrame(AAE60),(*job).last);
   QueIns(AddFrame(AAE61),(*job).last);
   QueIns(AddFrame(AAE62),(*job).last);    
  
 } else if(StrCmp(wadFrameName,"T2Ready")){
   QueIns(AddFrame(AAE115),(*job).last);
   QueIns(AddFrame(AAE116),(*job).last);
   QueIns(AddFrame(AAE117),(*job).last);    
  
 } else if(StrCmp(wadFrameName,"T3Ready")){
   QueIns(AddFrame(AAE169),(*job).last);
   QueIns(AddFrame(AAE170),(*job).last);
   QueIns(AddFrame(AAE171),(*job).last);    
  
 } else if(StrCmp(wadFrameName,"T4Ready")){
   QueIns(AddFrame(AAE7),(*job).last);
   QueIns(AddFrame(AAE8),(*job).last);
   QueIns(AddFrame(AAE9),(*job).last);    
  
 } else if(StrCmp(wadFrameName,"T1Punch")){
 }

 return job;
}


U0 AddToHashTable(U8 *string)
{
  CHashGeneric *entry =CAlloc(sizeof(CHashGeneric));
  entry->str = string;
  entry->user_data0= CreateAnimation(entry->str);
  entry->type = HTT_FRAME_PTR;
  HashAdd(entry,allAnimations);

}

U0 InitializeAnimator(){
  //initialize empty job queue
  QueInit(&animationQue);
  //load all animations into the hashtable  
  AddToHashTable("T1Ready");
  AddToHashTable("T2Ready");
  AddToHashTable("T3Ready");
  AddToHashTable("T4Ready");
}


U0 PlayAnimation(AnimationJob *cur)
{ 
   Animation *ajc = cur->sequence;
   //DCFill(animContext, TRANSPARENT);
   GrBlot3(gr.dc,0+ajc->xOffset,
                 0+ajc->yOffset,10,
                 ajc->frame);
   ajc->durationIndex++;
   
   //TODO
   //print to gr.dc

}

U0 AddAnimJobToQue(U8 *key)
{
  AnimationJob *newJob = FramePtr(key);
  QueIns(newJob, animationQue.last);
}

U0 FreeAnimJobFromQue()
{
  //QueDel(&active_job->sequence);
  //Free(&active_job->sequence); do at end?
  QueRem(animationQue);
}

//needs to be a subprocess/on its own thread
U0 CheckAnimQueue()
{
  //run one frame in every animation in the que
  I8 numberToPlay= QueCnt(animationQue); 
  while(numberToPlay!=0)
  {
   animationQue = animationQue.next;
   PlayAnimation(animationQue);
    //check if frame is done
   if(animationQue.sequence->durationIndex==
      animationQue.sequence->frameDuration)
   {
    //check if animation is done
    if(animationQue.index==animationQue.frameCount)
    {
  
     FreeAnimJobFromQue();
    }
    else
    {
     animationQue.sequence = animationQue.sequence->next;
     animationQue.index++;
    } 
    
   }
   else
   {
    animationQue.sequence->durationIndex++;
   }
   //move on to the next job
   numberToPlay--;
  }
  //reset to head
  animationQue = animationQue.next;
  
}

CDC *GetActorAnimationJob(Actor *a)
{
 CDC *completeActor = DCNew(100,100);
 DCFill(completeActor, TRANSPARENT);

  if(a->race<4)
  {
   completeActor = GetWalkAnimation(a,completeActor);
  }

  if(a->race==4)
  {
   Sprite3B(completeActor,0,32,10,GetDog);

  }
  return completeActor;

}
U0 EndAnimator(){
  QueDel(&animationQue);
  Free(&animationQue);

}
