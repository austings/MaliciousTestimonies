
//updated for dynamic sprite loading
//each sprite can have up to four animations
//3 frames for each animation (coded left, up, down, right)
//12 frames total
CDC*		AL1;
CDC*		AL2;
CDC*		AL3;
CDC*		AU1;
CDC*		AU2;
CDC*		AU3;
CDC*		AD1;
CDC*		AD2;
CDC*		AD3;
CDC*		AR1;
CDC*		AR2;
CDC*		AR3;
static CDC* AC1;
U0 SetCharMenuSprites()
{
  AC1 = FramePtr("ACTOR065");
  AU1 = FramePtr("ACTOR068");
  AD1 = FramePtr("ACTOR071");
  AR1 = FramePtr("ACTOR074");
}

CDC *GetWalkAnimationV2(Actor *a)
{
  CDC *completeActor = DCNew(100,100);
  DCFill(completeActor, TRANSPARENT);

  U8 walkdir = a->walking;
  switch(a->race)
  {
   case 0://Judah
   AL1 = FramePtr("ACTOR065");//Judah
   AL2 = FramePtr("ACTOR066");
   AL3 = FramePtr("ACTOR067");
   AU1 = FramePtr("ACTOR091");
   AU2 = FramePtr("ACTOR092");
   AU3 = FramePtr("ACTOR093");
   AD1 = FramePtr("ACTOR052");
   AD2 = FramePtr("ACTOR053");
   AD3 = FramePtr("ACTOR054");
   AR1 = FramePtr("ACTOR078");
   AR2 = FramePtr("ACTOR079");
   AR3 = FramePtr("ACTOR080");
   break;
   case 1:
   AL1 = FramePtr("ACTOR068");
   AL2 = FramePtr("ACTOR069");
   AL3 = FramePtr("ACTOR070");
   AU1 = FramePtr("ACTOR094");
   AU2 = FramePtr("ACTOR095");
   AU3 = FramePtr("ACTOR096");
   AD1 = FramePtr("ACTOR055");
   AD2 = FramePtr("ACTOR056");
   AD3 = FramePtr("ACTOR057");
   AR1 = FramePtr("ACTOR081");
   AR2 = FramePtr("ACTOR082");
   AR3 = FramePtr("ACTOR083");
   break;
   case 2:
   AL1 = FramePtr("ACTOR071");
   AL2 = FramePtr("ACTOR072");
   AL3 = FramePtr("ACTOR073");
   AU1 = FramePtr("ACTOR097");
   AU2 = FramePtr("ACTOR098");
   AU3 = FramePtr("ACTOR099");
   AD1 = FramePtr("ACTOR058");
   AD2 = FramePtr("ACTOR059");
   AD3 = FramePtr("ACTOR060");
   AR1 = FramePtr("ACTOR084");
   AR2 = FramePtr("ACTOR085");
   AR3 = FramePtr("ACTOR086");
   break;
   case 3:
   AL1 = FramePtr("ACTOR074");
   AL2 = FramePtr("ACTOR075");
   AL3 = FramePtr("ACTOR076");
   AU1 = FramePtr("ACTOR100");
   AU2 = FramePtr("ACTOR101");
   AU3 = FramePtr("ACTOR102");
   AD1 = FramePtr("ACTOR061");
   AD2 = FramePtr("ACTOR062");
   AD3 = FramePtr("ACTOR063");
   AR1 = FramePtr("ACTOR087");
   AR2 = FramePtr("ACTOR088");
   AR3 = FramePtr("ACTOR089");
   break;
   case 4:
   AL1 = FramePtr("ACTOR074");//wolf dog
   AL2 = FramePtr("ACTOR075");
   AL3 = FramePtr("ACTOR076");
   AU1 = FramePtr("ACTOR100");
   AU2 = FramePtr("ACTOR101");
   AU3 = FramePtr("ACTOR102");
   AD1 = FramePtr("ACTOR061");
   AD2 = FramePtr("ACTOR062");
   AD3 = FramePtr("ACTOR063");
   AR1 = FramePtr("ACTOR087");
   AR2 = FramePtr("ACTOR088");
   AR3 = FramePtr("ACTOR089"); 
   break;
  }

  switch(walkdir)
  {
   case 0://not walking
    switch(a->walkingSubFrame)
    {
     case 0://down
      GrBlot3(completeActor,0,0,10,AD2);
      switch(a->hair){
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
      GrBlot3(completeActor,0,0,10,AU2);
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
      GrBlot3(completeActor,0,0,10,AR2);
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
      GrBlot3(completeActor,0,0,10,AL2);
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

    //animation
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

     GrBlot3(completeActor,0,0,10,AL1);
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
     GrBlot3(completeActor,0,0,10,AR1);
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

     GrBlot3(completeActor,0,0,10,AU1);
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

     GrBlot3(completeActor,0,0,10,AD1);
    break;
    case 5://left left leg
     a->walkingSubFrame++;

     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 9;
     }
     GrBlot3(completeActor,0,0,10,AL2);
    break;
    case 6://right left leg
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 10;
     }
     GrBlot3(completeActor,0,0,10,AR2);
    break;
    case 7://up left leg
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 11;
     }
     GrBlot3(completeActor,0,0,10,AU2);
    break;
    case 8://down left leg
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 12;
     }
     GrBlot3(completeActor,0,0,10,AD2);
    break;
    case 9://left straight mid
     a->walkingSubFrame++;

     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 13;
     }
     GrBlot3(completeActor,0,0,10,AL3);
    break;
    case 10://right straight mid
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 14;
     }
     GrBlot3(completeActor,0,0,10,AR3);
    break;
    case 11://up straight mid
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 15;
     }
     GrBlot3(completeActor,0,0,10,AU3);
    break;
    case 12://down straight mid
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 16;
     }
     GrBlot3(completeActor,0,0,10,AD3); 
    break;
    case 13://left right leg
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=3;
      a->walking = 0;
     }
     GrBlot3(completeActor,0,0,10,AL2);
    break;
    case 14://right right leg
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=2;
      a->walking = 0;
     }
     GrBlot3(completeActor,0,0,10,AR2);
    break;
    case 15://up right leg
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=1;
      a->walking = 0;
     }
     GrBlot3(completeActor,0,0,10,AU2);
    break;
    case 16://down right leg 
     a->walkingSubFrame++;
     if(a->walkingSubFrame== FRAMERULE)
     {
      a->walkingSubFrame=0;
      a->walking = 0;
     }
     GrBlot3(completeActor,0,0,10,AD2);
    break;
  }
   //break;
   //case 4:
   // Sprite3B(completeActor,0,32,10,GetDog);
//
  // break;
 // }

 GrBlot3(completeActor,0,0,10,GetHair(a->hair));

 
 return completeActor; 

  //end of animation
}



