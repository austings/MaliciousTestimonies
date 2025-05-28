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
  
 } else if(StrCmp(wadFrameName,"T1Punch")){
 } else if(StrCmp(wadFrameName,"T2Punch")){
 } else if(StrCmp(wadFrameName,"T3Punch")){
 } else if(StrCmp(wadFrameName,"T4Punch")){
 } else if(StrCmp(wadFrameName,"T1Fish")){
   QueIns(AddFrame(AAE110),(*job).last);  
   QueIns(AddFrame(AAE111),(*job).last);


 } else if(StrCmp(wadFrameName,"T2Fish")){
   QueIns(AddFrame(AAE164),(*job).last);   
   QueIns(AddFrame(AAE165),(*job).last);


 } else if(StrCmp(wadFrameName,"T3Fish")){
   QueIns(AddFrame(AAE2),(*job).last);  
   QueIns(AddFrame(AAE3),(*job).last);


 } else if(StrCmp(wadFrameName,"T4Fish")){
   QueIns(AddFrame(AAE56),(*job).last); 
   QueIns(AddFrame(AAE57),(*job).last);


 } else if(StrCmp(wadFrameName,"T1")){
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


U0 PlayAnimation(AnimationJob *cur)
{ 
   Animation *ajc = cur->sequence;
   //DCFill(animContext, TRANSPARENT);
   GrBlot3(gr.dc,cur->x+ajc->xOffset,
                 cur->y+ajc->yOffset,10,
                 ajc->frame);
   ajc->durationIndex++;
   
}

U0 AddAnimJobToQue(U8 *key,I64 run_x, I64 run_y)
{
  AnimationJob *newJob = FramePtr(key);
  newJob->x = run_x; newJob->y = run_y;
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
  while(numberToPlay!=0){
   animationQue = animationQue.next;
   PlayAnimation(animationQue);
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




U0 InteractActor(I64 npc)
{
 Actor *aAtLoc= GetNPC(npc);
 if(aAtLoc->ai_script==1&&aAtLoc->dead==FALSE)//combat
 {
  mc->combatON=TRUE;
 }
 else
 {
  mc->dialogName = aAtLoc->name;
  
  if(aAtLoc->dead==TRUE)
  {
    if(mc->lootedSwitch==LOOTED) //already looted
    {
     //mc->talkieScene = GetTalkie(13);//empty corpse message
    }
    else
    {
     if(mc->lootedSwitch==LOOTABLE)
     {
      mc->loot = "..........";
      switch(npc)
      {
        case 6://wolf fang
        mc->loot = "wolf fang";
        AddItemToInventory(0,3);
        break;
      }
      mc->lootedSwitch=LOOTING;
     }

     //mc->talkieScene = 12;  
    }

  }
  else
  {
   //AdamLog("Peace"); AdamLog(3);
   mc->talkieScene = GetTalkie(npc);
  }
 }

}

U0 MoveActor(Actor *p, U8 dir)
{
 //actors with anim
 I64 npc;
 if(p->walking==0){
  switch(dir){
  case DIR_LEFT://left
    p->walkingSubFrame=3;
   if(p->x-1>=0&&!
      CheckSolid(world->level,p->x-1,p->y,world->currentZ)){
    npc = GetTensorNPC(world->level,p->x-1,p->y,world->currentZ);
    if(npc!=-1){
      if(p->id==0){
       InteractActor(npc);
      }    
    }
    else{
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}
     if(camera->topLR!=0&&p->x<wX-5)
      camera->topLR--;
     p->walking=1;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,(p->x)-1,p->y,world->currentZ);
     UpdateActorCoords(0,(p->x)-1,p->y); 
    }
   }
  break;
  case DIR_RIGHT://right
   p->walkingSubFrame=2;
   if(p->x+1!=wX&&!CheckSolid(world->level,p->x+1,p->y,world->currentZ)){
    npc =GetTensorNPC(world->level,p->x+1,p->y,world->currentZ); 
    if(npc!=-1){  
      if(p->id==0){
       InteractActor(npc);
      }
    }
    else{
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}

     if(camera->topLR!=wX-11&&p->x>=5)
       camera->topLR++;
     p->walking=2;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,(p->x)+1,p->y,world->currentZ);
     UpdateActorCoords(0,(p->x)+1,p->y); 
    }
   }
  break;
  case DIR_UP://up
   p->walkingSubFrame=1;

   if(p->y-1>=0&&!CheckSolid(world->level,p->x,p->y-1,world->currentZ))
   {
    npc =GetTensorNPC(world->level,p->x,p->y-1,world->currentZ); 
    if(npc!=-1)
    {

      if(p->id==0){
       InteractActor(npc);
      }
    
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}

     if(camera->topUD!=0&&p->y<wY-5){
      camera->topUD--;
     }
     p->walking=3;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,p->x,(p->y)-1,world->currentZ);
     UpdateActorCoords(0,p->x,(p->y)-1); 
    }
   }
  break;
  case DIR_DOWN://down
   p->walkingSubFrame=0;

   if(p->y+1!=wY&&!CheckSolid(world->level,p->x,p->y+1,world->currentZ))
   {
    npc = GetTensorNPC(world->level,p->x,p->y+1,world->currentZ);
    if(npc!=-1)
    {

      if(p->id==0){
       InteractActor(npc);
      }
    
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}

     if(camera->topUD!=wY-11&&p->y>=5){
      camera->topUD++;
     }
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     p->walking=4;
     p->walkingSubFrame=0;
     SetTensorNPC(world->level,0,p->x,(p->y)+1,world->currentZ);
     UpdateActorCoords(0,p->x,(p->y)+1); 
    }
   }
  break;
  }
 }//if not walking
 //}//else

}


U8 GetWalkOffsetX(U8 walkdir)
{
 U8 XOffset = 0;
 switch(walkdir)
 {
  case 0://not walking
  break;
  case 1://left straight start
   XOffset=40;
  break;
  case 2://right straight start
   XOffset=-40;
  break;
  case 3://up straight start
  break;
  case 4://down straight start
  break;
  case 5://left left leg
   XOffset=30;
  break;
  case 6://right left leg
   XOffset=-30;
  break;
  case 7://up left leg
  break;
  case 8://down left leg
  break;
  case 9://left straight mid
   XOffset=20;
  break;
  case 10://right straight mid
   XOffset=-20;
  break;
  case 11://up straight mid
  break;
  case 12://down straight mid
  break;
  case 13://left right leg
   XOffset=10;
  break;
  case 14://right right leg
   XOffset=-10;
  break;
  case 15://up right leg
  break;
  case 16://down right leg 
  break;
 } 
 return XOffset; 
}

U8 GetWalkOffsetY(U8 walkdir)
{
 U8 YOffset = 0;
 switch(walkdir)
 {
  case 0://not walking
  break;
  case 1://left straight start
  break;
  case 2://right straight start
  break;
  case 3://up straight start
   YOffset=40;
  break;
  case 4://down straight start
   YOffset=-40;
  break;
  case 5://left left leg
  break;
  case 6://right left leg
  break;
  case 7://up left leg
   YOffset=30;
  break;
  case 8://down left leg
   YOffset=-30;
  break;
  case 9://left straight mid
  break;
  case 10://right straight mid
  break;
  case 11://up straight mid
   YOffset=20;
  break;
  case 12://down straight mid
   YOffset=-20;
  break;
  case 13://left right leg
  break;
  case 14://right right leg
  break;
  case 15://up right leg
   YOffset=10;
  break;
  case 16://down right leg 
   YOffset=-10;
  break;
 }
 return YOffset; 
}
