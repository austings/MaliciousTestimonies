

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
  case T1DIE:
   QueIns(AddFrame(AAE74,T$ER$1DIE,0),allAnimations.last);
   QueIns(AddFrame(AAE75,T$ER$1DIE,1),allAnimations.last);
   QueIns(AddFrame(AAE85,T$ER$1DIE,2),allAnimations.last);
   QueIns(AddFrame(AAE86,T$ER$1DIE,3),allAnimations.last);
   QueIns(AddFrame(AAE87,T$ER$1DIE,4),allAnimations.last);
   QueIns(AddFrame(AAE112,T$ER$1DIE,5),allAnimations.last);
   QueIns(AddFrame(AAE113,T$ER$1DIE,6),allAnimations.last);
   QueIns(AddFrame(AAE114,T$ER$1DIE,7),allAnimations.last);
  break;
  case T2DIE:
   QueIns(AddFrame(AAE115,T$ER$2DIE,0),allAnimations.last);
   QueIns(AddFrame(AAE121,T$ER$2DIE,1),allAnimations.last);
   QueIns(AddFrame(AAE146,T$ER$2DIE,2),allAnimations.last);
   QueIns(AddFrame(AAE148,T$ER$2DIE,3),allAnimations.last);
   QueIns(AddFrame(AAE149,T$ER$2DIE,4),allAnimations.last);
   QueIns(AddFrame(AAE158,T$ER$2DIE,5),allAnimations.last);
   QueIns(AddFrame(AAE166,T$ER$2DIE,6),allAnimations.last);
   QueIns(AddFrame(AAE167,T$ER$2DIE,7),allAnimations.last);
  break;
  case T3DIE:
   QueIns(AddFrame(AAE181,T$ER$3DIE,0),allAnimations.last);
   QueIns(AddFrame(AAE182,T$ER$3DIE,1),allAnimations.last);
   QueIns(AddFrame(AAE184,T$ER$3DIE,2),allAnimations.last);
   QueIns(AddFrame(AAE189,T$ER$3DIE,3),allAnimations.last);
   QueIns(AddFrame(AAE194,T$ER$3DIE,4),allAnimations.last);
   QueIns(AddFrame(AAE204,T$ER$3DIE,5),allAnimations.last);
   QueIns(AddFrame(AAE4,T$ER$3DIE,6),allAnimations.last);
   QueIns(AddFrame(AAE6,T$ER$3DIE,7),allAnimations.last);
  break;
  case T4DIE:
   QueIns(AddFrame(AAE29,T$ER$4DIE,0),allAnimations.last);
   QueIns(AddFrame(AAE30,T$ER$4DIE,1),allAnimations.last);
   QueIns(AddFrame(AAE31,T$ER$4DIE,2),allAnimations.last);
   QueIns(AddFrame(AAE32,T$ER$4DIE,3),allAnimations.last);
   QueIns(AddFrame(AAE33,T$ER$4DIE,4),allAnimations.last);
   QueIns(AddFrame(AAE58,T$ER$4DIE,5),allAnimations.last);
   QueIns(AddFrame(AAE59,T$ER$4DIE,6),allAnimations.last);
   QueIns(AddFrame(AAE60,T$ER$4DIE,7),allAnimations.last);
  break;
  case T1CAST:
   QueIns(AddFrame(AAE75,T$ER$1CAST,0),allAnimations.last);
   QueIns(AddFrame(AAE76,T$ER$1CAST,1),allAnimations.last);
   QueIns(AddFrame(AAE80,T$ER$1CAST,2),allAnimations.last);
   QueIns(AddFrame(AAE77,T$ER$1CAST,3),allAnimations.last);
   QueIns(AddFrame(AAE78,T$ER$1CAST,4),allAnimations.last);
   QueIns(AddFrame(AAE78,T$ER$1CAST,5),allAnimations.last);
   QueIns(AddFrame(AAE78,T$ER$1CAST,6),allAnimations.last);
  break;
  case T2CAST:
   QueIns(AddFrame(AAE128,T$ER$2CAST,0),allAnimations.last);
   QueIns(AddFrame(AAE129,T$ER$2CAST,1),allAnimations.last);
   QueIns(AddFrame(AAE133,T$ER$2CAST,2),allAnimations.last);
   QueIns(AddFrame(AAE130,T$ER$2CAST,3),allAnimations.last);
   QueIns(AddFrame(AAE131,T$ER$2CAST,4),allAnimations.last);
   QueIns(AddFrame(AAE132,T$ER$2CAST,5),allAnimations.last);
   QueIns(AddFrame(AAE132,T$ER$2CAST,6),allAnimations.last);

  break;
  case T3CAST:
   QueIns(AddFrame(AAE210,T$ER$3CAST,0),allAnimations.last);
   QueIns(AddFrame(AAE183,T$ER$3CAST,1),allAnimations.last);
   QueIns(AddFrame(AAE187,T$ER$3CAST,2),allAnimations.last);
   QueIns(AddFrame(AAE185,T$ER$3CAST,3),allAnimations.last);
   QueIns(AddFrame(AAE186,T$ER$3CAST,4),allAnimations.last);
   QueIns(AddFrame(AAE186,T$ER$3CAST,5),allAnimations.last);
   QueIns(AddFrame(AAE186,T$ER$3CAST,6),allAnimations.last);

  break;
  case T4CAST:
   QueIns(AddFrame(AAE20,T$ER$4CAST,0),allAnimations.last);
   QueIns(AddFrame(AAE21,T$ER$4CAST,1),allAnimations.last);
   QueIns(AddFrame(AAE25,T$ER$4CAST,2),allAnimations.last);
   QueIns(AddFrame(AAE22,T$ER$4CAST,3),allAnimations.last);
   QueIns(AddFrame(AAE23,T$ER$4CAST,4),allAnimations.last);
   QueIns(AddFrame(AAE24,T$ER$4CAST,5),allAnimations.last);
   QueIns(AddFrame(AAE24,T$ER$4CAST,6),allAnimations.last);
  break;
  case T1EFFHEAL:
   QueIns(AddFrame(EFF075,T1EFFHEAL,0),allAnimations.last);
   QueIns(AddFrame(EFF076,T1EFFHEAL,1),allAnimations.last);
   QueIns(AddFrame(EFF036,T1EFFHEAL,2),allAnimations.last);
   QueIns(AddFrame(EFF037,T1EFFHEAL,3),allAnimations.last);
   QueIns(AddFrame(EFF034,T1EFFHEAL,4),allAnimations.last);
   QueIns(AddFrame(EFF033,T1EFFHEAL,5),allAnimations.last);
   QueIns(AddFrame(EFF031,T1EFFHEAL,6),allAnimations.last);
  break;
  case EFFFISH:
   QueIns(AddFrame(EFF121,EFFFISH,0),allAnimations.last);
   QueIns(AddFrame(EFF122,EFFFISH,1),allAnimations.last);
   QueIns(AddFrame(EFF123,EFFFISH,2),allAnimations.last);
   QueIns(AddFrame(EFF169,EFFFISH,3),allAnimations.last);
   QueIns(AddFrame(EFF170,EFFFISH,4),allAnimations.last);
   QueIns(AddFrame(EFF171,EFFFISH,5),allAnimations.last);
   QueIns(AddFrame(EFF172,EFFFISH,6),allAnimations.last);
   QueIns(AddFrame(EFF173,EFFFISH,7),allAnimations.last);
   QueIns(AddFrame(EFF174,EFFFISH,8),allAnimations.last);
  break;
  case EFFFIRE:
   QueIns(AddFrame(EFF288,EFFFIRE,0),allAnimations.last);
   QueIns(AddFrame(EFF289,EFFFIRE,1),allAnimations.last);
   QueIns(AddFrame(EFF321,EFFFIRE,2),allAnimations.last);
   QueIns(AddFrame(EFF322,EFFFIRE,3),allAnimations.last);
   QueIns(AddFrame(EFF323,EFFFIRE,4),allAnimations.last);
   QueIns(AddFrame(EFF324,EFFFIRE,5),allAnimations.last);
   QueIns(AddFrame(EFF360,EFFFIRE,6),allAnimations.last);
   QueIns(AddFrame(EFF361,EFFFIRE,7),allAnimations.last);
   QueIns(AddFrame(EFF362,EFFFIRE,8),allAnimations.last);
   QueIns(AddFrame(EFF363,EFFFIRE,9),allAnimations.last);
   QueIns(AddFrame(EFF364,EFFFIRE,10),allAnimations.last);
  break;
  case EFFSCRATCH:
   QueIns(AddFrame(EFF059,EFFSCRATCH,0),allAnimations.last);
   QueIns(AddFrame(EFF060,EFFSCRATCH,0),allAnimations.last);
   QueIns(AddFrame(EFF061,EFFSCRATCH,0),allAnimations.last);
   QueIns(AddFrame(EFF060,EFFSCRATCH,0),allAnimations.last);
  break; 
  case ARCSTRIKE:
   QueIns(AddFrame(EFF059,ARCSTRIKE,0),allAnimations.last);
  break;
 }
}

U0 ProceduralAnimate1(CDC *dc,Director *task)
{
    task->a->visible =TRUE;  
    // Animate: back and forth horizontally and sinusoidal bounce vertically
    task->z++;

    F64 time = task->z / 10.0; // adjust speed
    F64 amplitudeX = 10;       // horizontal distance
    F64 amplitudeY = 4;       // vertical arc height

    task->a->screenX = task->x + (amplitudeX * Sin(time));
    task->a->screenY = task->y - (amplitudeY * Abs(Sin(time))); // bounce upward only

    if (time > 2 * pi) {
      task->z = 0;
    }

}

U0 ProceduralAnimateArc(CDC *dc, Director *task)
{
    task->a->visible = TRUE;  
    task->z++;
    // Interpolation progress (0.0 to 1.0)
    F64 duration = 120.0; // number of frames for full traversal
    F64 t = task->z / duration;
    if (t > 1.0) {
        // Reverse direction by swapping start/target and resetting progress
        F64 tmpX = task->x;
        F64 tmpY = task->y;
        task->x = player->screenX;
        task->y = player->screenY;
        task->z = 0;
        return;
    }

    // Linear interpolation between points
    F64 sx = task->x;
    F64 sy = task->y;
    F64 ex = player->screenX;
    F64 ey = player->screenY;

    // Interpolated horizontal position
    F64 interpX = sx + (ex - sx) * t;
    F64 interpY = sy + (ey - sy) * t;

    // Apply vertical arc using a sine wave (peak at t=0.5)
    F64 arcHeight = 20.0; // height of the arc in pixels
    F64 arcOffset = arcHeight * Sin(pi * t); // Sin(pi * t) peaks at t=0.5

    task->a->screenX = interpX;
    task->a->screenY = interpY - arcOffset; // negative = upward arc
}

U0 PlayAnimation(CDC *dc,Director *task){ 
  switch(task->cQueDirective)   
  {
   case BOUNCE:
    ProceduralAnimate1(dc,task);
    goto taskend;
   break;  
   case ARCSTRIKE:
    ProceduralAnimateArc(dc,task);
    goto taskend;
   break;
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
    switch(task->cQueDirective)
    {
     case T1DIE...T4DIE:
      task->animIndex=task->animIndex-1;
      tmp = ajc->last;
      //repeat last frame forever
     break;
     case EFFFIRE:
      task->animIndex=0;//this might leak memory after awhile
     break;
     default:
      ResetDirective(task);
      task->a->visible = TRUE;  
      goto taskend;
     break;
    
    }
   }
  }
  if(task->flip){
   GrBlot3(dc,task->x+ajc->xOffset,
             task->y+ajc->yOffset,
             task->z,
             DCFlippedX(ajc->frame));
    
  }else{
  
   GrBlot3(dc,task->x+ajc->xOffset,
             task->y+ajc->yOffset,
             task->z,
             ajc->frame);
  }

  taskend:
 
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
  CreateAnimation(ARCSTRIKE);

  CreateAnimation(T1DIE);
  CreateAnimation(T2DIE);
  CreateAnimation(T3DIE);
  CreateAnimation(T4DIE);

  CreateAnimation(T1CAST);
  CreateAnimation(T2CAST);
  CreateAnimation(T3CAST);
  CreateAnimation(T4CAST);

  CreateAnimation(T1EFFHEAL);
  CreateAnimation(EFFFISH);
  CreateAnimation(EFFFIRE);
  CreateAnimation(EFFSCRATCH);
 //load all animations into the hashtable 
}


U0 CheckAnimQueue(CDC *dc,I64 y)
{
 Director *task = direct.next;
 I64 i =0;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective!=NoDirective)
  {
   //estimate this task row to account for drawing offsets
   //this is necessary to ensure foreground draws properly
   if(task->y<=y+10&&task->y >= y-35)
    PlayAnimation(dc,task);
  }
  task = task->next;
 }
 
}


U0 DrawDead(CDC * dc, Actor *a)
{
 switch(a->face)
 {
  case 0...T_BENJ:
   AddDirective(T1DIE,a);
  break;
  case T_DOG:
   Sprite3B(dc,0,32,10,GetDog(TRUE));
  break;
 } 
}

CDC *GetActorAnimationJob(Actor *a,I64 wlvl)
{
 CDC *completeActor = DCNew(500,500);
 DCFill(completeActor, TRANSPARENT);

 if(a->status1==DEAD_STATUS)
 {
  DrawDead(completeActor,a);
  return completeActor;
 }else{
  switch(a->face)
  {
   case T_JUDA...T_BENJ:
    completeActor = GetWalkAnimation(a,completeActor);
   break;
   case T_DOG:
    Sprite3B(completeActor,0,32,10,GetDog);
   break;
   case T_FOWL:
    Sprite3B(completeActor,0,32,10,GetFowl);
   break;
   case T_OX:
    Sprite3B(completeActor,0,32,10,GetOx);
   break;
   default:
    completeActor = GetWalkAnimation(a,completeActor);
   break;
  } 

  OverlayArmor(completeActor,a);
  //todo make status effects?
  if(wlvl>0)
  {
   a->screenY+=(wlvl+a->walking);
   completeActor->color = TRANSPARENT;
   GrRect3(completeActor,0,60,0,100,100);
  }
 }

 return completeActor;

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


