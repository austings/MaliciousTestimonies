#define NoDirective -1

class Animation:CQue{
  CDC *frame;
  I8 frameDuration,
     frameDurationIndex,
     xOffset, yOffset;
  I64 key;
  I8 frameIndex;
} allAnimations;



class Director:CQue{
  I64 cQueDirective;
  I32 animIndex;
  I64 x; I64 y; I64 z;
  Bool flip;
  Actor *a;

} direct;


U0 SetActorHairLeft(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0L;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1L;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2L;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3L;
  break;
 }

}

U0 SetActorHairUp(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0U;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1U;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2U;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3U;
  break;
 }

}

U0 SetActorHairRight(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0R;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1R;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2R;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3R;
  break;
 }

}

U0 SetActorHairDown(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0D;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1D;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2D;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3D;
  break;
 }

}

U0 SetActorSubFrameRule(Actor *a,I64 wsf,I64 w )
{
 a->walkingSubFrame++;

 if(a->walkingSubFrame== FRAMERULE)
 {
  a->walkingSubFrame=wsf;       
  a->walking = w;
 }

}

#define W_IDLEDOWN      0
#define W_IDLEUP        1
#define W_IDLERIGHT     2
#define W_IDLELEFT      3

#define W_NOTWALKING       00
#define W_LEFTSTRAIGHT     01
#define W_RIGHTSTRAIGHT    02
#define W_UPSTRAIGHT       03
#define W_DOWNSTRAIGHT     04
#define W_LEFTLEFT         05
#define W_RIGHTLEFT        06
#define W_UPLEFT           07
#define W_DOWNLEFT         08
#define W_LEFTMID          09
#define W_RIGHTMID         10
#define W_UPMID            11
#define W_DOWNMID          12
#define W_LEFTRIGHT        13
#define W_RIGHTRIGHT       14
#define W_UPRIGHT          15
#define W_DOWNRIGHT        16

CDC *HandleWalkSubFrame(Actor *a, CDC *completeActor,
                        CDC *L1,CDC *L2,CDC *L3,
                        CDC *R1,CDC *R2,CDC *R3,
                        CDC *U1,CDC *U2,CDC *U3,
                        CDC *D1,CDC *D2,CDC *D3, 
                        I64 xOffset=0)
//xOffset to correct for .WAD graphics being slightly off origin 
{
  U8 walkDir = a->walking;
  U8 subWalk = a->walkingSubFrame;
 
 switch(walkDir){
     case W_NOTWALKING:
       switch(subWalk)
       {
        case W_IDLEDOWN://down
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D2);
          if(QueCnt(direct)==0)
           SetActorHairDown(a);
        break;
        case W_IDLEUP://up
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U2);
          if(QueCnt(direct)==0)
           SetActorHairUp(a);
        break;
        case W_IDLERIGHT://right
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R2);
          if(QueCnt(direct)==0)
           SetActorHairRight(a);
        break;
        case W_IDLELEFT://left
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L2);
          if(QueCnt(direct)==0)
           SetActorHairLeft(a);
        break;
       }
     break;
     case W_LEFTSTRAIGHT://left straight start
       SetActorSubFrameRule(a,0,5);
       SetActorHairLeft(a);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L1);
     break;
     case W_RIGHTSTRAIGHT://right straight start
       SetActorSubFrameRule(a,0,6);
       SetActorHairRight(a);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R1);
     break;
     case W_UPSTRAIGHT://up straight start
       SetActorSubFrameRule(a,0,7);
       SetActorHairUp(a);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U1);
     break;
     case W_DOWNSTRAIGHT://down straight start
       SetActorSubFrameRule(a,0,8); 
       SetActorHairDown(a);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D1);
     break;
     case W_LEFTLEFT://left left leg
       SetActorSubFrameRule(a,0,9);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L2);
     break;
     case W_RIGHTLEFT://right left leg
       SetActorSubFrameRule(a,0,10);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R2);
     break;
     case W_UPLEFT://up left leg
       SetActorSubFrameRule(a,0,11);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U2);
     break;
     case W_DOWNLEFT://down left leg
       SetActorSubFrameRule(a,0,12);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D2);
     break;
     case W_LEFTMID://left straight mid
       SetActorSubFrameRule(a,0,13);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L3);
     break;
     case W_RIGHTMID://right straight mid
       SetActorSubFrameRule(a,0,14);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R3);
     break;
     case W_UPMID://up straight mid
       SetActorSubFrameRule(a,0,15);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U3);
     break;
     case W_DOWNMID://down straight mid
       SetActorSubFrameRule(a,0,16);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D3); 
     break;
     case W_LEFTRIGHT://left right leg
       SetActorSubFrameRule(a,3,0);
       if(a->visible)
        GrBlot3(completeActor,0+xOffset,0,10,L2);
     break;
     case W_RIGHTRIGHT://right right leg
       SetActorSubFrameRule(a,2,0);
       if(a->visible)
        GrBlot3(completeActor,0+xOffset,0,10,R2);
     break;
     case W_UPRIGHT://up right leg
       SetActorSubFrameRule(a,1,0);
       if(a->visible)
        GrBlot3(completeActor,0+xOffset,0,10,U2);
     break;
     case W_DOWNRIGHT://down right leg 
       SetActorSubFrameRule(a,0,0);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D2);
     break;
  }

 return completeActor;

}


CDC *GetWalkAnimation(Actor *a, CDC *completeActor)
{
  switch(a->race)
  {
   case T_JUDA://Judah
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A1L1, A1L2, A1L3,
                        A1R1, A1R2, A1R3,
                        A1U1, A1U2, A1U3,
                        A1D1, A1D2, A1D3);

   break;
   case T_LEVI://Levi
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A2L1, A2L2, A2L3,
                        A2R1, A2R2, A2R3,
                        A2U1, A2U2, A2U3,
                        A2D1, A2D2, A2D3, -2);

   break;
   case T_EPHR://Ephraim
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A3L1, A3L2, A3L3,
                        A3R1, A3R2, A3R3,
                        A3U1, A3U2, A3U3,
                        A3D1, A3D2, A3D3, -4);

   break;
   case T_BENJ://Benjamin
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A4L1, A4L2, A4L3,
                        A4R1, A4R2, A4R3,
                        A4U1, A4U2, A4U3,
                        A4D1, A4D2, A4D3, -6);

   break;

  }

 GrBlot3(completeActor,0,0,10,GetHair(a->hair));

 
 return completeActor; 
       

}


U0 AddDirective(I64 directive, Actor *p)
{
 //TODO:this sucks
 Director *task = direct.next;
 I64 i =0; Bool free=FALSE;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective==NoDirective)
  {
   free = TRUE;
   break;
  }
  task = task->next;
 }
 if(!free){
  task = MAlloc(sizeof(Director));
  task->a = MAlloc(sizeof(Actor));
 }
 //while(StrCmp(direct.cQueDirective,NoDirective))
// {
 // direct = direct.next;
 //}
 task->x = p->screenX;//(p->x)*camera->dividX;
 task->y = p->screenY;//(p->y)*camera->dividY;
 task->a = p;
 switch(directive)
 {
  case T1FISH...T4FISH:
   switch(p->race){
    case T_JUDA:
     task->cQueDirective = T1FISH;
    break;
    case T_LEVI:
     task->cQueDirective = T2FISH;
    break;
    case T_EPHR:
     task->cQueDirective = T3FISH;
    break;
    case T_BENJ:
     task->cQueDirective = T4FISH;
    break;
   }
  break;
  case T1READY...T4READY:
   switch(p->race){
    case T_JUDA:
     task->cQueDirective = T1READY;  
    break;
    case T_LEVI:
     task->cQueDirective = T2READY;
    break;
    case T_EPHR:
     task->cQueDirective = T3READY;
    break;
    case T_BENJ:
     task->cQueDirective = T4READY;
    break;
   }
  break;
  case T1PUNCH...T4PUNCH:
  if(p->x<=mc->target->x){
   task->flip = TRUE;
   SetActorHairRight(p);
  }else {SetActorHairLeft(p);}
  switch(p->race){
   case T_JUDA:
    switch(p->sword){
     case 0: //fist
      task->cQueDirective = T1PUNCH;
     break;
    }  
   break;
   case T_LEVI:
    switch(p->sword){
     case 0: //fist
      task->cQueDirective = T2PUNCH;
     break;
    }   break;
   case T_EPHR:
    switch(p->sword){
     case 0: //fist
      task->cQueDirective = T3PUNCH;
     break;
    }
   break;
   case T_BENJ:
    switch(p->sword){
     case 0: //fist
      task->cQueDirective = T4PUNCH;
     break;
    }
   break;
  }
  break;
 }
 if(!free)
  QueIns(task,direct.last); 
 p->visible=FALSE;

}
