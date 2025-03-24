/*

class Animation:CQue{
    CDC *frame;
    I8 subFrameDuration;
    I8 subFrameIndex;
    I32 xOffset;
    I32 yOffset;
};


class AnimationJob:CQue{
  Animation *sequence;
  I32 num_frames_left;
  I32 x;
  I32 y;
  I32 z;
} anim_jobs;

AnimationJob *active_job;


Animation *CreateFrame(CDC*frame,I8 sfd=3,I32 xO=0,I32 yO=0)
{
  Animation *createdFrame = CAlloc(sizeof(Animation));
  createdFrame->subFrameDuration = sfd;
  createdFrame->subFrameIndex=0;
  createdFrame->xOffset=xO;
  createdFrame->yOffset=yO;
  return createdFrame;
}

U0 PlayAnimation(Animation *cur, I32 numFrames,I32 x,I32 y, I32 z)
{
  //if(cur->subFrameIndex==0)
  //{
   CDC *animContext = DCNew(100,100);
   DCFill(animContext, TRANSPARENT);
   GrBlot3(animContext,0+cur->xOffset,0+cur->yOffset,10,cur->frame);
  //}
  //else
  //{
   
  //}


}

U0 AddAnimJobToQue(AnimationJob *newJob)
{
  QueIns(newJob, anim_jobs.last);
}

U0 FreeAnimJobFromQue()
{
  QueDel(&active_job->sequence);
  Free(&active_job->sequence);
  QueRem(anim_jobs);
}

U0 CheckAnimQueue()
{ 
  if(QueCnt(anim_jobs)!=0)
  {
   active_job = anim_jobs.next;
   PlayAnimation(active_job->sequence,
                 QueCnt(active_job->sequence),
                 active_job->x,active_job->y,active_job->z);
   //decrement
   active_job->num_frames_left=active_job->num_frames_left--;
   //check if job is done
   if(active_job->num_frames_left==0)
   { 
    FreeAnimJobFromQue();
   }
   
  }
}
*/
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

/*
U0 InitializeAnimator(){
  QueInit(&anim_jobs);

}*/