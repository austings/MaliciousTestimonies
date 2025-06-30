#define MAXACTORCOUNT	11
#define ACTOR_FILE "/Data/Actor.TXT"

Actor *player;
Actor *loaded1,*loaded2,*loaded3,
*loaded4,*loaded5,*loaded6,*loaded7,
*loaded8,*loaded9,*loaded10;
U8 loaded = 0;

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

//StatusEffects

U0 Die(Actor *a)
{
  a->dead = TRUE;
}

U0 IndicatorText(I64 realX, I64 realY, I64 magnitude, U8* currency)
{
  U8* indicator = "+";
  if(magnitude<1)
   indicator = MStrPrint("-%d%s",Abs(magnitude),currency);
  else 
    indicator= MStrPrint("%s%d%s",indicator,magnitude,currency);
  
  I64 i  =0 ;
//  PrintLine(dc,indicator,realX,realY);

}

U0 LvlUp(Actor *a)
{
  a->exp = a->exp - a->maxExp;
  a->lvl = a->lvl+1;
  a->maxExp = Pow(0.05*a->lvl,4)+Pow(2*a->lvl,3)
                      +Pow(5*a->lvl,2)+10*a->lvl+3; 
}
U0 RemoveMana(Actor *a, I64 magnitude)
{
  IndicatorText(a->x,a->y,magnitude,"Spirit");
  if(a->currentMana<=magnitude)
  {
    a->currentMana=0;
  }
  else
  {
   a->currentMana = a->currentMana- magnitude;

   if(a->currentMana>a->mana)
   {
    a->currentMana=a->mana;
   }
  }

}

U0 RemoveHealth(Actor *a, I64 magnitude)
{
  IndicatorText(a->x,a->y,magnitude,"Health");
  if(a->currentHealth<=magnitude)
  {
    a->currentHealth=0;
    Die(a);
  }
  else
  {
    a->currentHealth = a->currentHealth - magnitude;
    if(a->currentHealth>a->health)
    {
     a->currentHealth = a->health;
    }

  }
 
}



U8 *ReadALine(U8 **fbuf) {
  U8 *en,*st=*fbuf,*buf;
  if(!*st) return NULL;
  if(en=StrFirstOcc(st,"\n")) {
    buf=MAlloc(en-st+2);
    MemCpy(buf,st,en-st+1);
    buf[en-st+1]=0;
    *fbuf=en+1;
    return buf;
  }
  *fbuf+=StrLen(st);
  return StrNew(st);
}


Actor *DeserializeNPC(I64 npcid)
{
 I64 i,j;
 Actor *p = MAlloc(sizeof(Actor));
 //p->myInv = MAlloc(sizeof(Inventory));
 p->myInv = MakeInventory();
 if(npcid==-1)
  return p;
 U8 *fptr = FileRead(MStrPrint("%s%s",DirCur,ACTOR_FILE)),
    *lnptr,*ln,*temp;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 name[15],*nameptr=name;
 U8 id[8],*idptr=id;
 U8 tribe[8],*tribeptr=tribe;
 U8 hair[8],*hairptr=hair;
 U8 eyes[8],*eyesptr=eyes;
 U8 hat[8],*hatptr=hat;
 U8 armor[8],*armorptr=armor;
 U8 legs[8],*legsptr=legs;
 U8 boot[8],*bootptr=boot;
 U8 sword[8],*swordptr=sword;
 U8 offhand[8],*offhandptr=offhand;
 U8 ring1[8],*ring1ptr=ring1;
 U8 ring2[8],*ring2ptr=ring2;
 U8 neck[8],*neckptr=neck;
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

  StrScan(ln,"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
   &nameptr,&idptr,&tribeptr,&hairptr,
   &eyesptr,&hatptr,&armorptr,&legsptr,
   &bootptr,&swordptr,&offhandptr,&ring1ptr,
   &ring2ptr,&neckptr,&xptr,&yptr,&strptr,
   &intptr,&conptr,&wisptr,&aiptr,&inv1ptr,
   &inv2ptr,&inv3ptr,&inv4ptr,&inv5ptr);
  

  for(i=0;i<15;i++)
   p->name[i] = nameptr[i];
  p->id = Str2I64(id);
  p->race = Str2I64(tribe);
  p->eye = Str2I64(eyes);
  p->hair = Str2I64(hair);
  p->hat = Str2I64(hat);
  p->armor = Str2I64(armor);
  p->legs = Str2I64(legs);
  p->boot = Str2I64(boot);
  p->sword = Str2I64(sword);
  p->offhand = Str2I64(offhand);
  p->ring1 = Str2I64(ring1);
  p->ring2 = Str2I64(ring2);
  p->necklace = Str2I64(neck);
  p->x = Str2I64(x);
  p->y = Str2I64(y);
  p->str = Str2I64(str);
  p->int = Str2I64(int);
  p->con = Str2I64(con);
  p->wis = Str2I64(wis);
  p->ai_script = Str2I64(ai);
  p->dead = FALSE;
  p->walking = 0; p->walkingSubFrame=0;
  p->health= Str2I64(con)*5;
  p->currentHealth = p->health;
  p->mana=Str2I64(wis)*5;
  p->currentMana = p->mana;
  p->exp = 0;
  p->lvl = 1;
  p->maxExp = 20;
  p->visible=TRUE;

  return p;
  //p->id = Str2I64(id); todo inv
  //Print(p->name);
  //Print("\n");
  //Print(id);
  //Print("\n");
  skip:;
  Free(ln);
  count++;
 }
 Free(fptr);

  p->dead = FALSE;
  p->walking = 0; p->walkingSubFrame=0;
  p->health= Str2I64(con)*5;
  p->currentHealth = p->health;
  p->mana=Str2I64(wis)*5;
  p->currentMana = p->mana;


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
  loaded =1;
  loaded2 = DeserializeNPC(id);
  loaded++;
  break;
 }

// return toR;

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
   if(loaded2->id==id)
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

U0 UpdateActorCoords(I64 id, U64 x, U64 y)
{
  switch(id)
  {
   case 0:
    player->x = x;
    player->y = y;
    break;
   default:
    Actor *p = GetNPC(id);
    p->x = x;
    p->y = y;
    break;
  }
}


Actor *MakeActor(I64 id,U8 race,U8 hair,U8 eye, 
I64 hat,I64 armor, I64 legs, I64 boot, I64 sword,
I64 offhand,I64 ring1, I64 ring2, I64 necklace, 
U64 x, U64 y, U64 str=1, U64 int=1, U64 con=1, U64 wis=1, U8 ai=0)
{
 Actor *me = MAlloc(sizeof(Actor));
 me->id=id;
 me->race = race;
 me->eye=eye;
 me->hair=hair;
 me->hat=hat;
 me->armor=armor;
 me->legs=legs;
 me->boot=boot;
 me->sword=sword;
 me->offhand=offhand;
 me->ring1=ring1;
 me->ring2=ring2;
 me->necklace=necklace;
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
 me->dead=FALSE;
 me->screenX = 0;
 me->screenY = 0;
 me->visible = TRUE;
 Inventory *newInv = MakeInventory();
 me->myInv = newInv;
 me->walking = 0,me->walkingSubFrame=0;
 return me;

}

U0 InitActors(I64 currentZ)
{
SetNPC(MakeActor(1,0,0,0, 
	         0,0,0,0,0,
	         0,0,0,0,
	         5,5,5,5,5,5,0));//player

  ResetNPCC;
  while(GetNPCC!=10)
  {
   switch(currentZ)
   {
     case 0://town level
     ReadNPC(1);
     ReadNPC(2);
     ReadNPC(3);
     ReadNPC(4);
     ReadNPC(5);
     ReadNPC(6);
     ReadNPC(7);
     ReadNPC(8);
     ReadNPC(9);
     ReadNPC(10);
     break;
   }
  }

}


U0 FreeActor(I64 id)
{
 Actor *a= GetNPC(id);
 QueDel(&(a->myInv->collection));
 Free(&(a->myInv->collection));
 Free(&(a->myInv));
 Free(&(a));
}

//Inventory

I64 InvNPCCount(Actor *a)
{
  switch(a->id)
  {
   case 0:
    return QueCnt(a->myInv->collection);
    break;
   case 1:
    break;
  }
  return 0;
}

