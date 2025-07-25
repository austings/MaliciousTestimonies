
U8 *ACTOR_FILE = MStrPrint("%s%s",DirCur,"/Data/Actor.TXT");
 
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

U0 AddStatus(Actor *a,U16 statusCode)
{
  a->status1 = statusCode;
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
    AddStatus(a,DEAD_STATUS);
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

U0 AddHealth(Actor *a,I64 magnitude)
{
 IndicatorText(a->x,a->y,magnitude,"Health");
 a->currentHealth = a->currentHealth + magnitude;
 if(a->currentHealth>a->health){
    a->currentHealth = a->health;
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
  loaded1 = DeserializeNPC(id);
  loaded=1;
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



U0 InitActors(I64 currentZ)
{
  SetNPC(MakeActor(1,0,0,0, 
	         0,0,0,0,
	         0,0,
	         5,5,5,5,0));//player

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

