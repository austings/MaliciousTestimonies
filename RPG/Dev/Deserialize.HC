//test

U0 PrintInventory(Inventory *myInv){
 U8 *str1 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[0][0].occupied, myInv->mtrx[0][1].occupied, myInv->mtrx[0][2].occupied,
    myInv->mtrx[0][3].occupied, myInv->mtrx[0][4].occupied, myInv->mtrx[0][5].occupied,
    myInv->mtrx[0][6].occupied, myInv->mtrx[0][7].occupied, myInv->mtrx[0][8].occupied,
    myInv->mtrx[0][9].occupied, myInv->mtrx[0][10].occupied);

 U8 *str2 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[1][0].occupied, myInv->mtrx[1][1].occupied, myInv->mtrx[1][2].occupied,
    myInv->mtrx[1][3].occupied, myInv->mtrx[1][4].occupied, myInv->mtrx[1][5].occupied,
    myInv->mtrx[1][6].occupied, myInv->mtrx[1][7].occupied, myInv->mtrx[1][8].occupied,
    myInv->mtrx[1][9].occupied, myInv->mtrx[1][10].occupied);

 U8 *str3 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[2][0].occupied, myInv->mtrx[2][1].occupied, myInv->mtrx[2][2].occupied,
    myInv->mtrx[2][3].occupied, myInv->mtrx[2][4].occupied, myInv->mtrx[2][5].occupied,
    myInv->mtrx[2][6].occupied, myInv->mtrx[2][7].occupied, myInv->mtrx[2][8].occupied,
    myInv->mtrx[2][9].occupied, myInv->mtrx[2][10].occupied);
 
 U8 *str4 = MStrPrint("%d %d %d %d %d %d %d %d %d %d %d",
    myInv->mtrx[3][0].occupied, myInv->mtrx[3][1].occupied, myInv->mtrx[3][2].occupied,
    myInv->mtrx[3][3].occupied, myInv->mtrx[3][4].occupied, myInv->mtrx[3][5].occupied,
    myInv->mtrx[3][6].occupied, myInv->mtrx[3][7].occupied, myInv->mtrx[3][8].occupied,
    myInv->mtrx[3][9].occupied, myInv->mtrx[3][10].occupied);

 PrintDevMessage(str1);
 PrintDevMessage(str2);
 PrintDevMessage(str3);
 PrintDevMessage(str4);

}

Bool AddItemToInventory(Inventory *myInv, I64 itemID){
 I64 i,j,x,y,area;
 Item *item = MakeItem(itemID);
 
 for(i=0;i<INVWIDTH;i++){
  for(j=0;j<INVHEIGHT;j++){
   area=0;
   for(x=item->w-1;x>=0;x--){
    if(i+x>=11)
     goto skip_num;
 
    for(y=item->h-1;y>=0;y--){
     if(j+y>=4)
      goto skip_num;
     if(myInv->mtrx[j+y][i+x].occupied<0)
       area++;  
    }
   }

   if(area==(item->h)*(item->w)){
    QueIns(item,myInv->collection->last);
    I64 cnt = ++myInv->count;
    
    for(x=item->w-1;x>=0;x--){  
     for(y=item->h-1;y>=0;y--){
      myInv->mtrx[j+y][i+x].occupied = cnt;
     }
    }
    item->invID = cnt;

    return TRUE;
   }
  }
  skip_num:
 }
 return FALSE;

}

//convert walk animation frame to cardinal direction
I64 GetDir(Actor *a){
 if(a->dir==DELIMITER){
  U8 walkDir = a->walking;
  U8 subWalk = a->walkingSubFrame;
  switch(walkDir){
   case W_NOTWALKING:
    switch(subWalk){
     case W_IDLEDOWN:
      return DIR_DOWN;
     break; 
     case W_IDLEUP:
      return DIR_UP;
     break;
     case W_IDLERIGHT:
      return DIR_RIGHT;
     break;
     case W_IDLELEFT:
      return DIR_LEFT;
     break;
    }
   break;
   case W_UPSTRAIGHT   :
   case W_UPMID        :    
   case W_UPLEFT       :
   case W_UPRIGHT      :
    return DIR_UP;
   break;    
   case W_DOWNSTRAIGHT :
   case W_DOWNLEFT     :
   case W_DOWNRIGHT    :    
   case W_DOWNMID      : 
    return DIR_DOWN;   
   break;
   case W_LEFTLEFT     :
   case W_LEFTSTRAIGHT : 
   case W_LEFTMID      :
   case W_LEFTRIGHT    :
    return DIR_LEFT;    
   break;
   case W_RIGHTSTRAIGHT:
   case W_RIGHTLEFT    :
   case W_RIGHTMID     :   
   case W_RIGHTRIGHT   :
    return DIR_RIGHT;    
   break;
  }
  return DIR_DOWN;
 }else{
  return a->dir;
 }
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

  if(Str2I64(inv1)!=0)
   AddItemToInventory(p->myInv,inv1);

  if(Str2I64(inv2)!=0)
   AddItemToInventory(p->myInv,inv2);

  if(Str2I64(inv3)!=0)
   AddItemToInventory(p->myInv,inv3);

  if(Str2I64(inv4)!=0)
   AddItemToInventory(p->myInv,inv4);

  if(Str2I64(inv5)!=0)
   AddItemToInventory(p->myInv,inv5);

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