class Actor{

  //persistent
  U8 name[15];

  U8  tribe,face,hair;
  
  I64 id,x,y,screenX,screenY,
      health,mana,
      currentHealth,currentMana,
      str,int,con,wis,
      hat,armor,legs,boot,
      sword,ring1,
      exp,maxExp,lvl;

  Inventory *myInv;
  Bool visible;

  U16 status1,
      //volatile
      status2,status3,
      ai_script,dir,walking,
      walkingSubFrame,clock;



};

Actor *player;
Actor *loaded1,*loaded2,*loaded3,
*loaded4,*loaded5,*loaded6,*loaded7,
*loaded8,*loaded9,*loaded10;
U8 loaded = 0;

U8 *ACTOR_FILE = MStrPrint("%s%s",DirCur,"/Data/Actor.TXT");

U0 SetActorDir(Actor *a, I64 dir)
{
 a->dir = dir;
}
 
Actor *MakeActor(I64 id,U8 tribe,U8 hair,U8 face, 
I64 hat,I64 armor, I64 sword, I64 ring1,
U64 x, U64 y, 
U64 str=1,U64 int=1, U64 con=1, U64 wis=1, U8 ai=0)
{
 Actor *me = MAlloc(sizeof(Actor));
 me->id=id;
 me->tribe = tribe;
 me->face=face;
 me->hair=hair;
 me->hat=hat;
 me->armor=armor;
 me->sword=sword;
 me->ring1=ring1;
 me->x=x;
 me->y=y;
 me->health=con*5;
 me->currentHealth = me->health;
 me->mana=wis*5;
 me->currentMana = me->mana;
 me->maxExp = 20;
 me->exp = 0;
 me->lvl = 1;
 me->str=str;
 me->int=int;
 me->con=con;
 me->wis=wis;
 me->ai_script=ai;
 me->status1=NRML_STATUS;
 me->status2=NRML_STATUS;
 me->status3=NRML_STATUS;
 SetActorDir(me,DIR_DOWN);
 me->screenX = 0;
 me->screenY = 0;
 me->visible = TRUE;
 Inventory *newInv = MakeInventory();
 me->myInv = newInv;
 me->walking = DIR_IDLE,me->walkingSubFrame=DIR_IDLE;
 return me;

}


Actor *DeserializeNPC(I64 npcid)
{
 I64 i,j;
 if(npcid==-1)
  return NULL;
 U8 *fptr =FileRead(ACTOR_FILE);
 U8 *lnptr,*ln,*temp;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 name[15],*nameptr=name;
 U8 id[8],*idptr=id;
 U8 tribe[8],*tribeptr=tribe;
 U8 hair[8],*hairptr=hair;
 U8 face[8],*faceptr=face;
 U8 hat[8],*hatptr=hat;
 U8 armor[8],*armorptr=armor;
 U8 sword[8],*swordptr=sword;
 U8 ring1[8],*ring1ptr=ring1;
 U8 x[8],*xptr=x;
 U8 y[8],*yptr=y;
 U8 str[8],*strptr=str;
 U8 int[8],*intptr=int;
 U8 con[8],*conptr=con;
 U8 wis[8],*wisptr=wis;
 U8 ai[8],*aiptr=ai;
 U8 inv1[8],*inv1ptr=inv1;
 U8 inv2[8],*inv2ptr=inv2;
 U8 inv3[8],*inv3ptr=inv3;
 U8 inv4[8],*inv4ptr=inv4;
 U8 inv5[8],*inv5ptr=inv5;
 lnptr=fptr;

 I32 count = 0;
 while(ln=ReadALine(&lnptr))
 {
  if(count!=npcid||*ln=='#'||*ln==0)
   goto skip;

  StrScan(ln,"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
   &nameptr,&idptr,&tribeptr,&hairptr,
   &faceptr,&hatptr,&armorptr,
   &swordptr,&ring1ptr,
   &xptr,&yptr,&strptr,
   &intptr,&conptr,&wisptr,&aiptr,&inv1ptr,
   &inv2ptr,&inv3ptr,&inv4ptr,&inv5ptr);

  Actor *p = 
   MakeActor(Str2I64(id),Str2I64(tribe),Str2I64(hair),Str2I64(face), 
             Str2I64(hat),Str2I64(armor), Str2I64(sword), Str2I64(ring1),
             Str2I64(x),Str2I64(y), 
             Str2I64(str),Str2I64(int),Str2I64(con),Str2I64(wis),Str2I64(ai)
            );  

  for(i=0;i<15;i++)
   p->name[i] = nameptr[i];//null term..?

  Free(fptr);
  return p;
  skip:;
  Free(ln);
  count++;
 }
 Free(fptr);

 

 return p;


}

U0 ReadNPC(I64 id)
{
 //Actor *toR;

 switch(loaded)
 {
  case 0:
   loaded1 = DeserializeNPC(id);
   loaded++;
//   return loaded1;
  break;
  case 1:
   loaded2 = DeserializeNPC(id);
   loaded++;
 //  return loaded2;
  break;
  case 2:
   loaded3 = DeserializeNPC(id);
   loaded++;
 //  return loaded3;
  break;
  case 3:
   loaded4 = DeserializeNPC(id);
   loaded++;
//   return loaded4;
  break;
  case 4:
   loaded5 = DeserializeNPC(id);
   loaded++;
 //  return loaded5;
  break;
  case 5:
   loaded6 = DeserializeNPC(id);
   loaded++;
 //  return loaded6;
  break;
  case 6:
   loaded7 = DeserializeNPC(id);
   loaded++;
 //  return loaded7;
  break;
  case 7:
   loaded8 = DeserializeNPC(id);
   loaded++;
 //  return loaded8;
  break;
  case 8:
   loaded9 = DeserializeNPC(id);
   loaded++;
 //  return loaded9;
  break;
  case 9:
   loaded10= DeserializeNPC(id);
   loaded++;
 //  return loaded10;
  break;
  case 10://max 10
  loaded1 = DeserializeNPC(id);
  loaded=1;
  break;
 }

// return toR;

}


U8 GetNPCC()
{
 return loaded;
}

U0 ResetNPCC()
{
 loaded =0;
}


U0 SetNPC(Actor *a)
{
  switch(a->id)
  {
   case 0:
    player=a;
    break;
   case 1:
    break;
  }
}



Actor *GetNPC(I64 id)
{
  I64 i = 0;
  if(id==0)
  {
    return player;
  }
  
  for(i=0;i<2;i++)
  {   
   if(loaded1->id==id)
   {
     return loaded1;
   }else if(loaded2->id==id)
   {
     return loaded2;
   } else if(loaded3->id==id)
   {
     return loaded3;
   } else if(loaded4->id==id)
   {
     return loaded4;
   } else if(loaded5->id==id)
   {
     return loaded5;
   } else if(loaded6->id==id)
   {
     return loaded6;
   } else if(loaded7->id==id)
   {
     return loaded7;
   } else if(loaded8->id==id)
   {
     return loaded8;
   } else if(loaded9->id==id)
   {
     return loaded9;
   } else if(loaded10->id==id)
   {
     return loaded10;
   }
   ReadNPC(id);

  }
 return loaded2;

}

//FACE CODES
#define T_JUDA  0
#define T_LEVI  1
#define T_EPHR  2
#define T_BENJ  3
#define T_DOG   4
#define T_FOWL  5
#define T_OX    6
//NPC IDs
#define PLAYER  00
#define A_KING  01
#define A_JEZEBEL 02
#define A_ELIJAH 03
#define A_CAPTAIN 04
#define A_GUARD 05
#define A_WILD_DOG 06
#define A_OX_CART 07
#define A_FOWL 08
#define A_WD2 09 //wild dog
#define A_MAKABEE 10 
#define A_WD3 11
#define A_WD4 12
#define A_WD5 13
#define A_WD6 14
#define A_WD7 15
#define A_WD8 16
#define A_WD9 17
#define A_WD10 18
#define A_WD11 19
#define A_WD12 20
#define A_FOWL6 21
#define A_FOWL5 22
#define A_FOWL4 23
#define A_FOWL3 24
#define A_FOWL2 25
#define A_GUEST 26
#define A_GUEST2 27
#define A_GUEST3 28
#define A_GUEST4 29
#define A_GUEST5 30
#define A_GUEST6 31
#define A_GUEST7 32
#define A_GUEST8 33
#define A_GUEST9 34
#define A_GUEST10 35
#define A_GUEST11 36
#define A_GUEST12 37


//Actor Walk Frames
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

I64 DetermineDirection(Actor *startA, I64 tX, I64 tY)
{
    I64 dir = DIR_IDLE;

    if (startA->x < tX) {
        dir |= DIR_RIGHT;
    } else if (startA->x > tX) {
        dir |= DIR_LEFT;
    }
    if (startA->y < tY) {
        dir |= DIR_DOWN;
    } else if (startA->y > tY) {
        dir |= DIR_UP;
    }

    return dir;
}