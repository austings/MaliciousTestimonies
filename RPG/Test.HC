Cd(__DIR__);;

// Construct Graphics from WAD
#include "Data/Wad.HC";

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
  I64 x; I64 y; I64 z;
} animationQue;

#define T1FISH "T1Fish"
AnimationJob *allAnimations = CAlloc(sizeof(AnimationJob));
QueInit(allAnimations);

Animation *AddFrame(CDC *frame,I32 xO=0,I32 yO=0,I8 sfd=3)
{
  Animation *createdFrame = CAlloc(sizeof(Animation));
  createdFrame->frame = frame;
  createdFrame->frameDuration = sfd;
  createdFrame->durationIndex = 0;
  createdFrame->xOffset=xO;
  createdFrame->yOffset=yO;
  return createdFrame;
}

static CDC* AAE110 = FramePtr("AAE110");
static CDC* AAE111 = FramePtr("AAE111");

AnimationJob *CreateAnimation(U8* wadFrameName)
{
 Animation *job = CAlloc(sizeof(Animation));
 QueInit(job);
 if(StrCmp(wadFrameName,T1FISH)){
   QueIns(AddFrame(AAE110),(*job).last);  
   QueIns(AddFrame(AAE111),(*job).last);
 }
 AnimationJob *jobDone = CAlloc(sizeof(AnimationJob));
 jobDone->sequence = job;
 jobDone->name = wadFrameName;
 jobDone->x = 240;
 jobDone->y = 320;
 jobDone->z = 10; 
 return jobDone;
}

U0 AddToTotalQue(U8 *string)
{
 AnimationJob *selection = CreateAnimation(string);
 QueIns(selection,allAnimations->last);
   
}

U0 InitializeAnimator(){
  //initialize empty job queue
  QueInit(&animationQue);
  AddToTotalQue(T1FISH);
  //load all animations into the hashtable 
}


U0 PlayAnimation(AnimationJob *cur, CDC *dc)
{ 
   Animation *ajc = cur->sequence;
   //DCFill(animContext, TRANSPARENT);
   GrBlot3(dc,cur->x+ajc->xOffset,
                 cur->y+ajc->yOffset,10,
                 ajc->frame);
   ajc->durationIndex++;
   Sleep(5000);
   
}

U0 InvokeAnim(U8 *key,I64 run_x, I64 run_y)
{ 
  I64 max =64,i=0;
  AnimationJob *selection = allAnimations->next;
  "\nSelectionFrameDuration %s \n",(selection->name);//->frameDuration;
  while(i<QueCnt(allAnimations)){
   if(!StrCmp(selection->name,key)){
    selection->x = run_x;
    selection->y = run_y;
    QueIns(selection,animationQue.last);
    "\nName:%s.\nKey:%s.\n",selection->name,key;
    AnimationJob *theLast = animationQue.last;
    "\nQueName:%s.\nQueDur:%d.\n",theLast->name,theLast->sequence->frameDuration;
  
    break;
   }
   else { selection = selection->next;}
   
   i++;
  }
}

U0 FreeAnimJobFromQue()
{
  //QueDel(&active_job->sequence);
  //Free(&active_job->sequence); do at end?
  QueRem(animationQue);
}

//needs to be a subprocess/on its own thread
U0 CheckAnimQueue(CDC *dc)
{
  
  //run one frame in every animation in the que
  I8 numberToPlay= QueCnt(animationQue);
  AnimationJob *j = animationQue.last;
  Animation *a = j->sequence;

  CDC *frame = DCNew(100,100);
  if(numberToPlay==0){
   GrBlot3(dc,100,100,10,frame);
  
  }else{
   GrBlot3(dc,100,100,10,a->frame);
  }
  
  // PlayAnimation(animationQue,dc);
  // "Finish Playing.";
  //}
   /*
    //check if frame is done
   if(animationQue.sequence->durationIndex==
      animationQue.sequence->frameDuration){
    //check if animation is done
    if(animationQue.index==animationQue.frameCount){  
     FreeAnimJobFromQue();
    }
    else{
     animationQue.sequence = animationQue.sequence->next;
     animationQue.index++;
    } 
    
   }
   else{
    animationQue.sequence->durationIndex++;
   }
   //move on to the next job
   numberToPlay--;
  }
  //reset to head
  animationQue = animationQue.next;*/
  
}

U0 PrintAnimeQue()
{
//run one frame in every animation in the que
  I8 numberToPlay= QueCnt(animationQue);
  AnimationJob *j = animationQue.last;
  Animation *a = j->sequence;

  CDC *frame = DCNew(100,100);
  if(numberToPlay==0){
   //GrBlot3(dc,100,100,10,frame);
  
  }else{
   "\nQue:%d\n",a->frameDuration;
  }

}


U0 DrawIt(CTask *task, CDC *dc)
{
 CheckAnimQueue(dc); //Sleep(30);
 
}

U0 EndAnimator(){
  QueDel(&animationQue);
  Free(&animationQue);

}
InitializeAnimator;
InvokeAnim(T1FISH,100,100);
PrintAnimeQue;
//Fs->draw_it=&DrawIt;
//while(TRUE)
//{
//}  
"Hello World.";

