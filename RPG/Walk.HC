
static CDC*		A1L1;//light
static CDC*		A1L2;
static CDC*		A1L3;
static CDC*		A1U1;
static CDC*		A1U2;
static CDC*		A1U3;
static CDC*		A1D1;
static CDC*		A1D2;
static CDC*		A1D3;
static CDC*		A1R1;
static CDC*		A1R2;
static CDC*		A1R3;

static CDC*		A2L1;//tan
static CDC*		A2L2;
static CDC*		A2L3;
static CDC*		A2U1;
static CDC*		A2U2;
static CDC*		A2U3;
static CDC*		A2D1;
static CDC*		A2D2;
static CDC*		A2D3;
static CDC*		A2R1;
static CDC*		A2R2;
static CDC*		A2R3;

static CDC*		A3L1;//dark
static CDC*		A3L2;
static CDC*		A3L3;
static CDC*		A3U1;
static CDC*		A3U2;
static CDC*		A3U3;
static CDC*		A3D1;
static CDC*		A3D2;
static CDC*		A3D3;
static CDC*		A3R1;
static CDC*		A3R2;
static CDC*		A3R3;

static CDC*		A4L1;//black
static CDC*		A4L2;
static CDC*		A4L3;
static CDC*		A4U1;
static CDC*		A4U2;
static CDC*		A4U3;
static CDC*		A4D1;
static CDC*		A4D2;
static CDC*		A4D3;
static CDC*		A4R1;
static CDC*		A4R2;
static CDC*		A4R3;

 A1L1 = FramePtr("ACTOR065");
 A1L2 = FramePtr("ACTOR066");
 A1L3 = FramePtr("ACTOR067");
 A1U1 = FramePtr("ACTOR091");
 A1U2 = FramePtr("ACTOR092");
 A1U3 = FramePtr("ACTOR093");
 A1D1 = FramePtr("ACTOR052");
 A1D2 = FramePtr("ACTOR053");
 A1D3 = FramePtr("ACTOR054");
 A1R1 = FramePtr("ACTOR078");
 A1R2 = FramePtr("ACTOR079");
 A1R3 = FramePtr("ACTOR080");

 A2L1 = FramePtr("ACTOR068");
 A2L2 = FramePtr("ACTOR069");
 A2L3 = FramePtr("ACTOR070");
 A2U1 = FramePtr("ACTOR094");
 A2U2 = FramePtr("ACTOR095");
 A2U3 = FramePtr("ACTOR096");
 A2D1 = FramePtr("ACTOR055");
 A2D2 = FramePtr("ACTOR056");
 A2D3 = FramePtr("ACTOR057");
 A2R1 = FramePtr("ACTOR081");
 A2R2 = FramePtr("ACTOR082");
 A2R3 = FramePtr("ACTOR083");

 A3L1 = FramePtr("ACTOR071");
 A3L2 = FramePtr("ACTOR072");
 A3L3 = FramePtr("ACTOR073");
 A3U1 = FramePtr("ACTOR097");
 A3U2 = FramePtr("ACTOR098");
 A3U3 = FramePtr("ACTOR099");
 A3D1 = FramePtr("ACTOR058");
 A3D2 = FramePtr("ACTOR059");
 A3D3 = FramePtr("ACTOR060");
 A3R1 = FramePtr("ACTOR084");
 A3R2 = FramePtr("ACTOR085");
 A3R3 = FramePtr("ACTOR086");

 A4L1 = FramePtr("ACTOR074");
 A4L2 = FramePtr("ACTOR075");
 A4L3 = FramePtr("ACTOR076");
 A4U1 = FramePtr("ACTOR100");
 A4U2 = FramePtr("ACTOR101");
 A4U3 = FramePtr("ACTOR102");
 A4D1 = FramePtr("ACTOR061");
 A4D2 = FramePtr("ACTOR062");
 A4D3 = FramePtr("ACTOR063");
 A4R1 = FramePtr("ACTOR087");
 A4R2 = FramePtr("ACTOR088");
 A4R3 = FramePtr("ACTOR089");


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

CDC *GetWalkAnimation(Actor *a, CDC *completeActor)
{
  U8 walkdir = a->walking;
  switch(a->race)
  {
   case T_JUDA://Judah
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,0,0,10,A1D2);
         SetActorHairDown(a);
        break;
        case 1://up
         GrBlot3(completeActor,0,0,10,A1U2);
         SetActorHairUp(a);
        break;
        case 2://right
         GrBlot3(completeActor,0,0,10,A1R2);
         SetActorHairRight(a);
        break;
        case 3://left
         GrBlot3(completeActor,0,0,10,A1L2);
         SetActorHairLeft(a);
        break;
       }
     break;
     case 1://left straight start
       SetActorSubFrameRule(a,0,5);
       SetActorHairLeft(a);
       GrBlot3(completeActor,0,0,10,A1L1);
     break;
     case 2://right straight start
       SetActorSubFrameRule(a,0,6);
       SetActorHairRight(a);
       GrBlot3(completeActor,0,0,10,A1R1);
     break;
     case 3://up straight start
       SetActorSubFrameRule(a,0,7);
       SetActorHairUp(a);
       GrBlot3(completeActor,0,0,10,A1U1);
     break;
     case 4://down straight start
       SetActorSubFrameRule(a,0,8); 
       SetActorHairDown(a);
       GrBlot3(completeActor,0,0,10,A1D1);
     break;
     case 5://left left leg
       SetActorSubFrameRule(a,0,9);
       GrBlot3(completeActor,0,0,10,A1L2);
     break;
     case 6://right left leg
       SetActorSubFrameRule(a,0,10);
       GrBlot3(completeActor,0,0,10,A1R2);
     break;
     case 7://up left leg
       SetActorSubFrameRule(a,0,11);
       GrBlot3(completeActor,0,0,10,A1U2);
     break;
     case 8://down left leg
       SetActorSubFrameRule(a,0,12);
       GrBlot3(completeActor,0,0,10,A1D2);
     break;
     case 9://left straight mid
       SetActorSubFrameRule(a,0,13);
       GrBlot3(completeActor,0,0,10,A1L3);
     break;
     case 10://right straight mid
       SetActorSubFrameRule(a,0,14);
       GrBlot3(completeActor,0,0,10,A1R3);
     break;
     case 11://up straight mid
       SetActorSubFrameRule(a,0,15);
       GrBlot3(completeActor,0,0,10,A1U3);
     break;
     case 12://down straight mid
       SetActorSubFrameRule(a,0,16);
       GrBlot3(completeActor,0,0,10,A1D3); 
     break;
     case 13://left right leg
       SetActorSubFrameRule(a,3,0);
       GrBlot3(completeActor,0,0,10,A1L2);
     break;
     case 14://right right leg
       SetActorSubFrameRule(a,2,0);
       GrBlot3(completeActor,0,0,10,A1R2);
     break;
     case 15://up right leg
       SetActorSubFrameRule(a,1,0);
       GrBlot3(completeActor,0,0,10,A1U2);
     break;
     case 16://down right leg 
       SetActorSubFrameRule(a,0,0);
       GrBlot3(completeActor,0,0,10,A1D2);
     break;

    }
   break;
   case T_LEVI://Levi
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,-2,0,10,A2D2);
         SetActorHairDown(a);

        break;
        case 1://up
         GrBlot3(completeActor,-2,0,10,A2U2);
         SetActorHairUp(a);
        break;
        case 2://right
         SetActorHairRight(a);  
         GrBlot3(completeActor,-2,0,10,A2R2);
        break;
        case 3://left
         SetActorHairLeft(a);
         GrBlot3(completeActor,-2,0,10,A2L2);
        break;

       }
     break;
     case 1://left straight start
       SetActorSubFrameRule(a,0,5);
       SetActorHairLeft(a);
       GrBlot3(completeActor,-2,0,10,A2L1);
     break;
     case 2://right straight start

       SetActorSubFrameRule(a,0,6);
       SetActorHairRight(a);
       GrBlot3(completeActor,-2,0,10,A2R1);
     break;
     case 3://up straight start
       SetActorSubFrameRule(a,0,7);
       SetActorHairUp(a);
       GrBlot3(completeActor,-2,0,10,A2U1);
     break;
     case 4://down straight start
       SetActorSubFrameRule(a,0,8);
       SetActorHairDown(a);
       GrBlot3(completeActor,-2,0,10,A2D1);
     break;
     case 5://left left leg
       SetActorSubFrameRule(a,0,9);
       GrBlot3(completeActor,-2,0,10,A2L2);
     break;
     case 6://right left leg
       SetActorSubFrameRule(a,0,10);
       GrBlot3(completeActor,-2,0,10,A2R2);
     break;
     case 7://up left leg
       SetActorSubFrameRule(a,0,11);
       GrBlot3(completeActor,-2,0,10,A2U2);
     break;
     case 8://down left leg
       SetActorSubFrameRule(a,0,12);
      GrBlot3(completeActor,-2,0,10,A2D2);
     break;
     case 9://left straight mid
       SetActorSubFrameRule(a,0,13);
       GrBlot3(completeActor,-2,0,10,A2L3);
     break;
     case 10://right straight mid
       SetActorSubFrameRule(a,0,14);
       GrBlot3(completeActor,-2,0,10,A2R3);
     break;
     case 11://up straight mid
       SetActorSubFrameRule(a,0,15);
       GrBlot3(completeActor,-2,0,10,A2U3);
     break;
     case 12://down straight mid
       SetActorSubFrameRule(a,0,16);
       GrBlot3(completeActor,-2,0,10,A2D3); 
     break;
     case 13://left right leg
       SetActorSubFrameRule(a,3,0);
       GrBlot3(completeActor,-2,0,10,A2L2);
     break;
     case 14://right right leg
       SetActorSubFrameRule(a,2,0);
       GrBlot3(completeActor,-2,0,10,A2R2);
     break;
     case 15://up right leg
       SetActorSubFrameRule(a,1,0);
       GrBlot3(completeActor,-2,0,10,A2U2);
     break;
     case 16://down right leg 
       SetActorSubFrameRule(a,0,0);
       GrBlot3(completeActor,-2,0,10,A2D2);
     break;
    }
   break;
   case T_EPHR://Ephraim
    switch(walkdir){
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
        GrBlot3(completeActor,-4,0,10,A3D2);
        SetActorHairDown(a);
        break;
        case 1://up
         SetActorHairUp(a);
         GrBlot3(completeActor,-4,0,10,A3U2);
        break;
        case 2://right
         SetActorHairRight(a);  
         GrBlot3(completeActor,-4,0,10,A3R2);
        break;
        case 3://left
         SetActorHairLeft(a);
         GrBlot3(completeActor,-4,0,10,A3L2);
        break;

       }
     break;
     case 1://left straight start
       SetActorSubFrameRule(a,0,5);
       SetActorHairLeft(a);
       GrBlot3(completeActor,-4,0,10,A3L1);
     break;
     case 2://right straight start
       SetActorSubFrameRule(a,0,6);
       SetActorHairRight(a);
       GrBlot3(completeActor,-4,0,10,A3R1);
     break;
     case 3://up straight start
       SetActorSubFrameRule(a,0,7);
       SetActorHairUp(a);
       GrBlot3(completeActor,-4,0,10,A3U1);
     break;
     case 4://down straight start
       SetActorSubFrameRule(a,0,8);
       SetActorHairDown(a);
       GrBlot3(completeActor,-4,0,10,A3D1);
     break;
     case 5://left left leg
       SetActorSubFrameRule(a,0,9);
       GrBlot3(completeActor,-4,0,10,A3L2);
     break;
     case 6://right left leg
       SetActorSubFrameRule(a,0,10);
       GrBlot3(completeActor,-4,0,10,A3R2);
     break;
     case 7://up left leg
       SetActorSubFrameRule(a,0,11);
       GrBlot3(completeActor,-4,0,10,A3U2);
     break;
     case 8://down left leg
       SetActorSubFrameRule(a,0,12);
       GrBlot3(completeActor,-4,0,10,A3D2);
     break;
     case 9://left straight mid
       SetActorSubFrameRule(a,0,13);
       GrBlot3(completeActor,-4,0,10,A3L3);
     break;
     case 10://right straight mid
       SetActorSubFrameRule(a,0,14);
       GrBlot3(completeActor,-4,0,10,A3R3);
     break;
     case 11://up straight mid
       SetActorSubFrameRule(a,0,15);
       GrBlot3(completeActor,-4,0,10,A3U3);
     break;
     case 12://down straight mid
       SetActorSubFrameRule(a,0,16);
       GrBlot3(completeActor,-4,0,10,A3D3); 
     break;
     case 13://left right leg
       SetActorSubFrameRule(a,3,0);
       GrBlot3(completeActor,-4,0,10,A3L2);
     break;
     case 14://right right leg
       SetActorSubFrameRule(a,2,0);
       GrBlot3(completeActor,-4,0,10,A3R2);
     break;
     case 15://up right leg
       SetActorSubFrameRule(a,1,0,);
       GrBlot3(completeActor,-4,0,10,A3U2);
     break;
     case 16://down right leg 
       SetActorSubFrameRule(a,0,0);
       GrBlot3(completeActor,-4,0,10,A3D2);
     break;

    }
   break;
   case T_BENJ://Benjamin
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,-6,0,10,A4D2);
         SetActorHairDown(a);
        break;
        case 1://up
         SetActorHairUp(a);
         GrBlot3(completeActor,-6,0,10,A4U2);
        break;
        case 2://right
         SetActorHairRight(a);  
        GrBlot3(completeActor,-6,0,10,A4R2);
        break;
        case 3://left
         SetActorHairLeft(a);
        GrBlot3(completeActor,-6,0,10,A4L2);
        break;

       }
     break;
     case 1://left straight start
       SetActorSubFrameRule(a,0,5);
       SetActorHairLeft(a);
       GrBlot3(completeActor,-6,0,10,A4L1);
     break;
     case 2://right straight start
       SetActorSubFrameRule(a,0,6);
       SetActorHairRight(a);
       GrBlot3(completeActor,-6,0,10,A4R1);
     break;
     case 3://up straight start
       SetActorSubFrameRule(a,0,7);
       SetActorHairUp(a);
       GrBlot3(completeActor,-6,0,10,A4U1);
     break;
     case 4://down straight start
       SetActorSubFrameRule(a,0,8);
       SetActorHairDown(a);
       GrBlot3(completeActor,-6,0,10,A4D1);
     break;
     case 5://left left leg
       SetActorSubFrameRule(a,0,9);
       GrBlot3(completeActor,-6,0,10,A4L2);
     break;
     case 6://right left leg
       SetActorSubFrameRule(a,0,10);
       GrBlot3(completeActor,-6,0,10,A4R2);
     break;
     case 7://up left leg
       SetActorSubFrameRule(a,0,11);
       GrBlot3(completeActor,-6,0,10,A4U2);
     break;
     case 8://down left leg
       SetActorSubFrameRule(a,0,12);
       GrBlot3(completeActor,-6,0,10,A4D2);
     break;
     case 9://left straight mid
       SetActorSubFrameRule(a,0,13);
       GrBlot3(completeActor,-6,0,10,A4L3);
     break;
     case 10://right straight mid
       SetActorSubFrameRule(a,0,14);
       GrBlot3(completeActor,-6,0,10,A4R3);
     break;
     case 11://up straight mid
       SetActorSubFrameRule(a,0,15);
       GrBlot3(completeActor,-6,0,10,A4U3);
     break;
     case 12://down straight mid
       SetActorSubFrameRule(a,0,16);
       GrBlot3(completeActor,-6,0,10,A4D3); 
     break;
     case 13://left right leg
       SetActorSubFrameRule(a,3,0);
       GrBlot3(completeActor,-6,0,10,A4L2);
     break;
     case 14://right right leg
       SetActorSubFrameRule(a,2,0);
       GrBlot3(completeActor,-6,0,10,A4R2);
     break;
     case 15://up right leg
       SetActorSubFrameRule(a,1,0);
       GrBlot3(completeActor,-6,0,10,A4U2);
     break;
     case 16://down right leg 
       SetActorSubFrameRule(a,0,0);
       GrBlot3(completeActor,-6,0,10,A4D2);
     break;

    }
   break;
   case 4:
    Sprite3B(completeActor,0,32,10,GetDog);
    return completeActor;

   break;
  }

 GrBlot3(completeActor,0,0,10,GetHair(a->hair));

 
 return completeActor; 
       

}
