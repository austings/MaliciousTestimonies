class Item:CQue
{
  U8* name;
  I16 equip_slot, id;
  Bool usable;
  U8 w, h;
};

class ItemNode
{
 I8 occupied;

};

class Inventory
{
  I64 count;  
  Item *collection;
  ItemNode mtrx[4][11]; 
};


class Actor
{
  U8  race,eye,hair;
  I64 id,hat,armor,legs,boot,
      sword,offhand,
      ring1,ring2,necklace;
  U64 x,y,health,mana, currentHealth, currentMana,
      str,int,con,wis;
  Bool dead;
  U8 ai_script,walking;
  U16 walkingSubFrame;
  Inventory *myInv;
  U8 name[15];
};

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

Item *MakeItem(I64 id)
{
 Item * build = CAlloc(sizeof(Item));
 build->id=id;
 switch(id)
 {
  case 0://not used
  build->name = "Bag";
  build->w=1,build->h=1;
  build->equip_slot=3;
  build->usable=FALSE;
  break;
  case 1:
  build->name = "Dagger";
  build->w=1,build->h=2;
  build->equip_slot=1;
  build->usable=FALSE;
  break;
  case 2:
  build->name = "Harpoon";
  build->w=1,build->h=4;
  build->equip_slot=1;
  build->usable=FALSE;
  break;

 }
 return build;
}

Inventory *MakeInventory()
{
  I64 i,j;
  Inventory *newInv = MAlloc(sizeof(Inventory));
  //newInv->maxWeight = weight;
  Item *item_que = MAlloc(sizeof(Item));
  QueInit(item_que);
  QueIns(MakeItem(0),item_que->last);
  newInv->collection = item_que;
  newInv->count = 0;
  for(i=0;i<11;i++)
  {
   for(j=0;j<4;j++)
   {
     newInv->mtrx[j][i].occupied =-1;
   }
  }

 //QueInit(p->myInv->collection);

 return newInv;
}


U0 UpdateActorCoords(I64 id, U64 x, U64 y)
{
  switch(id)
  {
   case 0:
    player->x = x;
    player->y = y;
    break;
   case 1:
    break;
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
 U8 *fptr = FileRead("Actor.TXT"),
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
  p->walking = 0,p->walkingSubFrame=0;
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
 }

// return toR;

}

Actor *GetNPC(I64 id)
{
  Actor *NPC; //= GREEN;
  if(id==0)
  {
    NPC = player;
  }
  else
  {
   if(loaded1->id==id)
   {
     return loaded1;
   } else if(loaded2->id==id)
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
  }
  return NPC;
}



Actor *MakeActor(I64 id,U8 race,U8 hair,U8 eye, 
I64 hat,I64 armor, I64 legs, I64 boot, I64 sword,
I64 offhand,I64 ring1, I64 ring2, I64 necklace, 
U64 x, U64 y, U64 str, U64 int, U64 con, U64 wis, U8 ai)
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
 me->str=str;
 me->int=int;
 me->con=con;
 me->wis=wis;
 me->ai_script=ai;
 me->dead=FALSE;
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
     loaded7 = loaded1;
     loaded8 = loaded1;
     loaded9 = loaded1;
     loaded10 = loaded1;
     loaded=10;
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

Bool AddItemToInventory(I64 actorID, I64 itemID)
{
 I64 i,j,x,y,area;
 Actor *p = GetNPC(actorID);
 Item *item = MakeItem(itemID);
 
 for(i=0;i<4;i++)
 {
  for(j=0;j<11;j++)
  {
   area=0;
   for(x=item->w-1;x>=0;x--)
   {
    if(j+x>=11)
     goto skip_num;
 
    for(y=item->h-1;y>=0;y--)
    {
     if(i+y>=4)
      goto skip_num;
     if(p->myInv->mtrx[i+y][j+x].occupied<0)
       area++;
  
    }
   }

   if(area==(item->h)*(item->w))
   {
    QueIns(item,p->myInv->collection->last);
    //PopUpPrint( "item added");
    I64 cnt = ++p->myInv->count;
    
    for(x=item->w-1;x>=0;x--)
    {  
     for(y=item->h-1;y>=0;y--)
     {
      p->myInv->mtrx[i+y][j+x].occupied = cnt;
     }
    }
   return TRUE;


   }



  }
  skip_num:
 }

 return FALSE;

}

I64 *RetrieveItemID(I64 aID, I64 index)
{
  Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
  I64 i;
  for(i=0;i<index;i++)
  {
    toBeRetrieved = toBeRetrieved->next;
  }
  //DocPrint("%d",toBeRetrieved->id);
  return toBeRetrieved->id;

}