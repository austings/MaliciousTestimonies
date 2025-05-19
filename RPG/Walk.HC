
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

CDC *GetWalkAnimation(Actor *a, CDC *completeActor)
{
  U8 walkdir = a->walking;
  switch(a->race)
  {
   case 0://Judah
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,0,0,10,A1D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }
        break;
        case 1://up
         GrBlot3(completeActor,0,0,10,A1U2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }
        break;
        case 2://right
         GrBlot3(completeActor,0,0,10,A1R2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
        break;
        case 3://left
         GrBlot3(completeActor,0,0,10,A1L2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }
        break;
       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,0,0,10,A1L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,0,0,10,A1R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,0,0,10,A1U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,0,0,10,A1D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,0,0,10,A1L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,0,0,10,A1R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,0,0,10,A1U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,0,0,10,A1D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1D2);
     break;

    }
   break;
   case 1://Levi
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,-2,0,10,A2D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }

        break;
        case 1://up
         GrBlot3(completeActor,-2,0,10,A2U2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }

        break;
        case 2://right
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
  
         GrBlot3(completeActor,-2,0,10,A2R2);
        break;
        case 3://left
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }

         GrBlot3(completeActor,-2,0,10,A2L2);
        break;

       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,-2,0,10,A2L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,-2,0,10,A2R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,-2,0,10,A2U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,-2,0,10,A2D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,-2,0,10,A2L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,-2,0,10,A2R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,-2,0,10,A2U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,-2,0,10,A2D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2D2);
     break;

    }
   break;

   case 2://Ephraim
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
        GrBlot3(completeActor,-4,0,10,A3D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }

        break;
        case 1://up
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }

        GrBlot3(completeActor,-4,0,10,A3U2);
        break;
        case 2://right
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
  
        GrBlot3(completeActor,-4,0,10,A3R2);
        break;
        case 3://left
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }

        GrBlot3(completeActor,-4,0,10,A3L2);
        break;

       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,-4,0,10,A3L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,-4,0,10,A3R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,-4,0,10,A3U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,-4,0,10,A3D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,-4,0,10,A3L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,-4,0,10,A3R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,-4,0,10,A3U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,-4,0,10,A3D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3D2);
     break;

    }
   break;
   case 3://Benjamin
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
        GrBlot3(completeActor,-6,0,10,A4D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }

        break;
        case 1://up
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }

        GrBlot3(completeActor,-6,0,10,A4U2);
        break;
        case 2://right
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
  
        GrBlot3(completeActor,-6,0,10,A4R2);
        break;
        case 3://left
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }

        GrBlot3(completeActor,-6,0,10,A4L2);
        break;

       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,-6,0,10,A4L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,-6,0,10,A4R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,-6,0,10,A4U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,-6,0,10,A4D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,-6,0,10,A4L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,-6,0,10,A4R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,-6,0,10,A4U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,-6,0,10,A4D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
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
