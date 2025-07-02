

Animation *AddFrame(CDC *frame,I64 key,I8 fIndex; 
                    I8 xO=0,I8 yO=0,I8 sfd=4)
{
  Animation *createdFrame = CAlloc(sizeof(Animation));
  createdFrame->frame = frame;
  createdFrame->frameDuration = sfd;
  createdFrame->frameDurationIndex = 0;
  createdFrame->frameIndex = fIndex;
  createdFrame->xOffset=xO;
  createdFrame->yOffset=yO;
  createdFrame->key = key;  
  return createdFrame;
}



Animation *CreateAnimation(I64 wadFrameName){
 switch(wadFrameName)
 {
  case T1FISH:
   QueIns(AddFrame(AAE110,T1FISH,0,5,2,24),allAnimations.last);  
   QueIns(AddFrame(AAE111,T1FISH,1,5,2,24),allAnimations.last);
  break;
  case T2FISH:
   QueIns(AddFrame(AAE164,T2FISH,0,5,2,24),allAnimations.last);   
   QueIns(AddFrame(AAE165,T2FISH,1,5,2,24),allAnimations.last);
  break;
  case T3FISH:
   QueIns(AddFrame(AAE2,T3FISH,0,5,2,24),allAnimations.last);  
   QueIns(AddFrame(AAE3,T3FISH,1,5,2,24),allAnimations.last);
  break;
  case T4FISH:
   QueIns(AddFrame(AAE56,T4FISH,0,5,2,24),allAnimations.last); 
   QueIns(AddFrame(AAE57,T4FISH,1,5,2,24),allAnimations.last);
  break;
  case T1READY:
   QueIns(AddFrame(AAE60,T1READY,0,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE61,T1READY,1,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE62,T1READY,2,0,0,24),allAnimations.last);    
  break;
  case T2READY:
   QueIns(AddFrame(AAE115,T2READY,0,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE116,T2READY,1,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE117,T2READY,2,0,0,24),allAnimations.last);    
  break;
  case T3READY:
   QueIns(AddFrame(AAE169,T3READY,0,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE170,T3READY,1,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE171,T3READY,2,0,0,24),allAnimations.last);    
  break;
  case T4READY:
   QueIns(AddFrame(AAE7,T4READY,0,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE8,T4READY,1,0,0,24),allAnimations.last);
   QueIns(AddFrame(AAE9,T4READY,2,0,0,24),allAnimations.last);    
  break;
  case T1PUNCH:
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
  break;
  case T2PUNCH:
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
  break;
  case T3PUNCH:
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
  break;
  case T4PUNCH:
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
  break;
  case T1DAGGER:
   QueIns(AddFrame(AAE7,T1DAGGER,0),allAnimations.last);
  break;
  case T2DAGGER:
   QueIns(AddFrame(AAE7,T2DAGGER,0),allAnimations.last);
  break;
  case T3DAGGER:
   QueIns(AddFrame(AAE7,T3DAGGER,0),allAnimations.last);
  break;
  case T4DAGGER:
   QueIns(AddFrame(AAE7,T4DAGGER,0),allAnimations.last);
  break;
  case T1SPEAR:
   QueIns(AddFrame(AAE7,T1SPEAR,0),allAnimations.last);
  break;
  case T2SPEAR:
   QueIns(AddFrame(AAE7,T2SPEAR,0),allAnimations.last);
  break;
  case T3SPEAR:
   QueIns(AddFrame(AAE7,T3SPEAR,0),allAnimations.last);
  break;
  case T4SPEAR:
   QueIns(AddFrame(AAE7,T4SPEAR,0),allAnimations.last);
  break;
  case BOUNCE:
   QueIns(AddFrame(AAE7,BOUNCE,0),allAnimations.last);
  break;
 }
}

U0 ResetDirective(Director *task)
{
  task->cQueDirective = NoDirective;
  task->animIndex = 0;
  task->x = 999;
  task->y = 999;
  task->z = 0;
  task->flip = FALSE;
  
}


U0 FreeTask(Director *task)
{
 QueRem(task);
// Free(task);
}

U0 ProceduralAnimate(CDC *dc,Director *task)
{
    task->a->visible =TRUE;  
    // Animate: back and forth horizontally and sinusoidal bounce vertically
    task->z++;

    F64 time = task->z / 10.0; // adjust speed
    F64 amplitudeX = 10;       // horizontal distance
    F64 amplitudeY = 4;       // vertical arc height

    task->a->screenX = task->x + (amplitudeX * Sin(time));
    task->a->screenY = task->y - (amplitudeY * Abs(Sin(time))); // bounce upward only

    // Optional: reset loop every full cycle (approx 2π)
    if (time > 2 * pi) {
      task->z = 0;
    }

}

U0 PlayAnimation(CDC *dc,Director *task){ 
 
  if(task->cQueDirective==BOUNCE)
  {
   ProceduralAnimate(dc,task);
   goto taskend;
  } 

  Animation *ajc = allAnimations.next;

  while(task->cQueDirective!=ajc->key){
   ajc = ajc->next;
  }
  
  while(task->animIndex!=ajc->frameIndex){
   ajc = ajc->next;
  }
 
  if(ajc->frameDurationIndex<ajc->frameDuration){
   ajc->frameDurationIndex++;
  }
  else{
   ajc->frameDurationIndex=0;
   Animation *tmp = ajc->next;
   task->animIndex = task->animIndex+1;
   if(tmp->frameIndex<=ajc->frameIndex)
   {
     ResetDirective(task);
     task->a->visible = TRUE; 
     //FreeTask(task);
     goto taskend; 
   }
  }
  if(task->flip){
   GrBlot3(dc,task->x+ajc->xOffset,
             task->y+ajc->yOffset,
             task->z+100,
             DCFlippedX(ajc->frame));
    
  }else{
  
   GrBlot3(dc,task->x+ajc->xOffset,
             task->y+ajc->yOffset,
             task->z+100,
             ajc->frame);
  }

  taskend:
  //task = task->next;
  
}



U0 InitializeAnimator(){
  //initialize empty job queue
  QueInit(&allAnimations);
  QueInit(&direct);
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

  CreateAnimation(T1DAGGER);
  CreateAnimation(T2DAGGER);
  CreateAnimation(T3DAGGER);
  CreateAnimation(T4DAGGER);
 
  CreateAnimation(T1SPEAR);
  CreateAnimation(T2SPEAR);
  CreateAnimation(T3SPEAR);
  CreateAnimation(T4SPEAR);
  
  CreateAnimation(BOUNCE);
 //load all animations into the hashtable 
}


U0 CheckAnimQueue(CDC *dc)
{
 Director *task = direct.next;
 I64 i =0;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective!=NoDirective)
  {
   PlayAnimation(dc,task);
  }
  task = task->next;
 }
 
}




CDC *GetActorAnimationJob(Actor *a)
{
 CDC *completeActor = DCNew(500,500);
 DCFill(completeActor, TRANSPARENT);

 if(a->race<=T_BENJ){
  completeActor = GetWalkAnimation(a,completeActor);
 }

 if(a->race==T_DOG){
   Sprite3B(completeActor,0,32,10,GetDog);
 }

 if(a->race==T_FOWL){
   Sprite3B(completeActor,0,32,10,GetFowl);
 }

 if(a->race==T_OX){
   Sprite3B(completeActor,0,32,10,GetOx);
 }

 OverlayArmor(completeActor,a);
 return completeActor;

}


U0 InteractActor(I64 npc)
{
 Actor *aAtLoc= GetNPC(npc);
 if(aAtLoc->ai_script==1&&aAtLoc->dead==FALSE) {//combat
  mc->combatON=TRUE;
 }
 else{
  mc->dialogName = aAtLoc->name;
  
  if(aAtLoc->dead==TRUE){
    if(mc->lootedSwitch==LOOTED){ //already looted
     //mc->talkieScene = GetTalkie(13);//empty corpse message
    }
    else{
     if(mc->lootedSwitch==LOOTABLE){
      mc->loot = "..........";
      switch(npc){
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
//actors with anim
//use move actor on the new dir to move
U0 MoveActor(Actor *p, U8 dir){
 I64 npc;

 //begin walk from idle
 if(p->walking==DIR_IDLE){
  
  switch(dir){
  case DIR_LEFT://left
    p->walkingSubFrame=3;
   if(p->x-1>=WEST_MAX&&!
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

   if(p->y-1>=NORTH_MAX&&
      !CheckSolid(world->level,p->x,p->y-1,world->currentZ))
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

   if(p->y+1!=wY&&!CheckSolid(world->level,p->x,p->y+1,world->currentZ)){
    npc = GetTensorNPC(world->level,p->x,p->y+1,world->currentZ);
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


U8 GetWalkOffsetX(U8 walkdir){
 U8 XOffset = 0;
 switch(walkdir){
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

U8 GetWalkOffsetY(U8 walkdir){
 U8 YOffset = 0;
 switch(walkdir){
  case 0://not walking
  break;
  case 1://left straight start
  break;
  case 2://right straight start
  break;
  case 3://up straight start
   YOffset=40;
  break;
  case 4://down straight start
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


