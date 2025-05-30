#define NoDirective "None"

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
  Actor *a;

} direct;



Animation *AddFrame(CDC *frame,U8* key,I8 fIndex; 
                    I8 xO=0,I8 yO=0,I8 sfd=16)
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
   QueIns(AddFrame(AAE110,T1FISH,0,5,2),allAnimations.last);  
   QueIns(AddFrame(AAE111,T1FISH,1,5,2),allAnimations.last);
 } else if(!StrCmp(wadFrameName,T2FISH)){
   QueIns(AddFrame(AAE164,T2FISH,0,5,2),allAnimations.last);   
   QueIns(AddFrame(AAE165,T2FISH,1,5,2),allAnimations.last);
 } else if(!StrCmp(wadFrameName,T3FISH)){
   QueIns(AddFrame(AAE2,T3FISH,0,5,2),allAnimations.last);  
   QueIns(AddFrame(AAE3,T3FISH,1,5,2),allAnimations.last);
 } else if(!StrCmp(wadFrameName,T4FISH)){
   QueIns(AddFrame(AAE56,T4FISH,0,5,2),allAnimations.last); 
   QueIns(AddFrame(AAE57,T4FISH,1,5,2),allAnimations.last);

 }

/*
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
  direct.x = 999;
  direct.y = 999;
  direct.z = 0;
  
}

U0 PlayAnimation(CDC *dc){ 

 Animation *ajc = allAnimations.next;

 while(!StrCmp(direct.cQueDirective,ajc->name)){//if anim call this one
  ajc = ajc->next;
 } 
 
 while(direct.animIndex==ajc->frameIndex){
  ajc = ajc->last;
 }

 if(ajc->frameDurationIndex<ajc->frameDuration){
  ajc->frameDurationIndex++;
 }

 else{
  ajc->frameDurationIndex=0;
  Animation *tmp = ajc->next;
  direct.animIndex = direct.animIndex+1;
  if(tmp->frameIndex<=ajc->frameIndex)
  {
    ResetDirective;
    direct.a->visible = TRUE;
 
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
  direct.a = MAlloc(sizeof(Actor));
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




CDC *GetActorAnimationJob(Actor *a)
{
 CDC *completeActor = DCNew(100,100);
 DCFill(completeActor, TRANSPARENT);

  if(a->race<=T_BENJ)
  {
   completeActor = GetWalkAnimation(a,completeActor);
  }

  if(a->race==4)
  {
   Sprite3B(completeActor,0,32,10,GetDog);

  }
  return completeActor;

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
   mc->talkieScene = GetTalkie(npc);
  }
 }
}

U0 MoveActor(Actor *p, U8 dir){
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
