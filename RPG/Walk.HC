
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
                        CDC *D1,CDC *D2,CDC *D3)
{
  U8 walkDir = a->walking;
  U8 subWalk = a->walkingSubFrame;
 
 switch(walkDir){
     case W_NOTWALKING:
       switch(subWalk)
       {
        case W_IDLEDOWN://down
         GrBlot3(completeActor,0,0,10,D2);
         SetActorHairDown(a);
        break;
        case W_IDLEUP://up
         GrBlot3(completeActor,0,0,10,U2);
         SetActorHairUp(a);
        break;
        case W_IDLERIGHT://right
         GrBlot3(completeActor,0,0,10,R2);
         SetActorHairRight(a);
        break;
        case W_IDLELEFT://left
         GrBlot3(completeActor,0,0,10,L2);
         SetActorHairLeft(a);
        break;
       }
     break;
     case W_LEFTSTRAIGHT://left straight start
       SetActorSubFrameRule(a,0,5);
       SetActorHairLeft(a);
       GrBlot3(completeActor,0,0,10,L1);
     break;
     case W_RIGHTSTRAIGHT://right straight start
       SetActorSubFrameRule(a,0,6);
       SetActorHairRight(a);
       GrBlot3(completeActor,0,0,10,R1);
     break;
     case W_UPSTRAIGHT://up straight start
       SetActorSubFrameRule(a,0,7);
       SetActorHairUp(a);
       GrBlot3(completeActor,0,0,10,U1);
     break;
     case W_DOWNSTRAIGHT://down straight start
       SetActorSubFrameRule(a,0,8); 
       SetActorHairDown(a);
       GrBlot3(completeActor,0,0,10,D1);
     break;
     case W_LEFTLEFT://left left leg
       SetActorSubFrameRule(a,0,9);
       GrBlot3(completeActor,0,0,10,L2);
     break;
     case W_RIGHTLEFT://right left leg
       SetActorSubFrameRule(a,0,10);
       GrBlot3(completeActor,0,0,10,R2);
     break;
     case W_UPLEFT://up left leg
       SetActorSubFrameRule(a,0,11);
       GrBlot3(completeActor,0,0,10,U2);
     break;
     case W_DOWNLEFT://down left leg
       SetActorSubFrameRule(a,0,12);
       GrBlot3(completeActor,0,0,10,D2);
     break;
     case W_LEFTMID://left straight mid
       SetActorSubFrameRule(a,0,13);
       GrBlot3(completeActor,0,0,10,L3);
     break;
     case W_RIGHTMID://right straight mid
       SetActorSubFrameRule(a,0,14);
       GrBlot3(completeActor,0,0,10,R3);
     break;
     case W_UPMID://up straight mid
       SetActorSubFrameRule(a,0,15);
       GrBlot3(completeActor,0,0,10,U3);
     break;
     case W_DOWNMID://down straight mid
       SetActorSubFrameRule(a,0,16);
       GrBlot3(completeActor,0,0,10,D3); 
     break;
     case W_LEFTRIGHT://left right leg
       SetActorSubFrameRule(a,3,0);
       GrBlot3(completeActor,0,0,10,L2);
     break;
     case W_RIGHTRIGHT://right right leg
       SetActorSubFrameRule(a,2,0);
       GrBlot3(completeActor,0,0,10,R2);
     break;
     case W_UPRIGHT://up right leg
       SetActorSubFrameRule(a,1,0);
       GrBlot3(completeActor,0,0,10,U2);
     break;
     case W_DOWNRIGHT://down right leg 
       SetActorSubFrameRule(a,0,0);
       GrBlot3(completeActor,0,0,10,D2);
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
                        A2D1, A2D2, A2D3);

   break;
   case T_EPHR://Ephraim
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A3L1, A3L2, A3L3,
                        A3R1, A3R2, A3R3,
                        A3U1, A3U2, A3U3,
                        A3D1, A3D2, A3D3);

   break;
   case T_BENJ://Benjamin
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A4L1, A4L2, A4L3,
                        A4R1, A4R2, A4R3,
                        A4U1, A4U2, A4U3,
                        A4D1, A4D2, A4D3);

   break;
   case 4:
    Sprite3B(completeActor,0,32,10,GetDog);
    return completeActor;

   break;
  }

 GrBlot3(completeActor,0,0,10,GetHair(a->hair));

 
 return completeActor; 
       

}
