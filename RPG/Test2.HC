Cd(__DIR__);;
//#include "Map.HC";
//#include "Vector.HC";

class NodeStuff:CQue
{
  I64 id;
  Bool isSolid;
};

class MapNode
{
 F64 bg;
 Bool hasNPC;
 I64 idNPC;
 I64 len;
 NodeStuff *items;
  
};

//Vector Objection Declaration
public class Vector
{
 I32 size;
 MapNode **data;
};

class Actor
{
  U8  race,eye,hair;
  I64 id,hat,armor,legs,boot,
      sword,offhand,
      ring1,ring2,necklace;
  U64 x,y,health,mana,
      str,int,con,wis;
  Bool dead;
  U8 ai_script;
  U8 *name;
};

class Nigger
{
   U8 ass;
   U8 *poop;
};

 

U0 Serialize2()
{

 U8 *fileName = "Saves/TEST.BIN";
 CFile *file=FOpen(fileName,"w");
 Nigger *newSave= MAlloc(sizeof(Nigger));
 newSave->ass = 8;
 newSave->poop = 16;

 
 U8 buffer[BLK_SIZE];
 U8 *ptr = buffer;
 I64 i,k, u8=sizeof(U8);

 //Try(file,buffer,ptr,newSave,u8);
 MemCpy(ptr,&(newSave->ass),sizeof(U8));
 ptr+=u8; 
 MemCpy(ptr,&(newSave->poop),sizeof(U8));
 ptr+=u8;
 
 FBlkWrite(file,buffer,0,BLK_SIZE);
 
 
 FClose(file);
 //DestroyVector(newSave->v);
 Free(newSave);

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

U0 Serialize3()
{
 U8 *fileName = "Actors.TXT";
 CFile *file = FOpen(fileName,"r");
 
 U8 buffer[BLK_SIZE];
 U8 *ptr = buffer;
 I64 i=0;
 U8 *name;// = MAlloc(sizeof(U8)*18);
 U8 val1=0; 
 while(FBlkRead(file,buffer,BLK_SIZE*i,1))
 {
   ptr+=sizeof(U8)*218;//ahab
   ptr+=sizeof(U8)*217;
   ptr+=sizeof(U8)*40;
   //ptr+=sizeof(U8)*340; //jezebel 213 dif
   //ptr+=sizeof(U8)*550;//elijah
   //ptr+=sizeof(U8)*299;
   //MemCpy(&name,ptr,sizeof(U8)*15);
   //ptr+=sizeof(U8)*15;
   MemCpy(&name,ptr,sizeof(U8)*180);
   //MemCpy(val1,ptr,sizeof(U8)*4);
   Print("\n"); //name = 
 //temp= Str2I64(&name);
   Print(&name); 
 //Print("\n%d",temp);
   Print("\n\n");
   break;
   i++;
 }

 FClose(file);
 //DestroyVector(newSave->v);
 //Free(newSave);

}

U0 Serialize4()
{
 Actor *p = MAlloc(sizeof(Actor));
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
  if(count==0||*ln=='#'||*ln==0)
   goto skip;

  StrScan(ln,"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
   &nameptr,&idptr,&tribeptr,&hairptr,
   &eyesptr,&hatptr,&armorptr,&legsptr,
   &bootptr,&swordptr,&offhandptr,&ring1ptr,
   &ring2ptr,&neckptr,&xptr,&yptr,&strptr,
   &intptr,&conptr,&wisptr,&aiptr,&inv1ptr,
   &inv2ptr,&inv3ptr,&inv4ptr,&inv5ptr);
  

  p->name = name;
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
  //p->id = Str2I64(id); todo inv
  Print(p->name);
  Print("\n");
  Print(id);
  Print("\n");
  skip:;
  Free(ln);
  count++;
 }
 Free(fptr);

 Print("\n\n");


}


U0 Serialize5()
{
 U8 *fileName = "Actors.TXT";
 CFile *file = FOpen(fileName,"r");
 
 U8 buffer[BLK_SIZE];
 U8 *ptr = buffer;
 I64 i=0;
 U8 *name;// = MAlloc(sizeof(U8)*18);
 U8 val1=0; 
 while(FBlkRead(file,buffer,BLK_SIZE*i,1))
 {
   ptr+=sizeof(U8)*218;//ahab
   ptr+=sizeof(U8)*217;
   ptr+=sizeof(U8)*40;
   //ptr+=sizeof(U8)*340; //jezebel 213 dif
   //ptr+=sizeof(U8)*550;//elijah
   //ptr+=sizeof(U8)*299;
   //MemCpy(&name,ptr,sizeof(U8)*15);
   //ptr+=sizeof(U8)*15;
   MemCpy(&name,ptr,sizeof(U8)*180);
   //MemCpy(val1,ptr,sizeof(U8)*4);
   Print("\n"); //name = 
 //temp= Str2I64(&name);
   Print(&name); 
 //Print("\n%d",temp);
   Print("\n\n");
   break;
   i++;
 }

 FClose(file);
 //DestroyVector(newSave->v);
 //Free(newSave);

}
U8 myDialog[120];

U0 DeserializeDialog(I64 textID)
{
 U8 *fptr = FileRead("T:/RPG/Dialog.TXT"), *lnptr,*ln;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 *nameptr = myDialog;
 U8 id[8], *idptr=id;

 lnptr = fptr;
 I64 count = 0;

 while(ln=ReadALine(&lnptr))
 {
 
  if(count!=textID || *ln=='#' || *ln==0)
   goto skip;
  StrScan(ln,"%s\t%s",&idptr,&nameptr);
  "%s",myDialog;
  break;
  skip:;
  Free(ln);
  count++;
 }
 Free(fptr);

}
U0 Niggafart()
{
 I64 count = 0;

  "\n";
 for(count=0;count<120;count++)
 {
   U8 cha = myDialog[count];
   "%c",cha;
   //cha = '';
 
 }
 "\n";
}

U0 PrintActorShit()
{
}

//Print(FileNameAbs("Dialog.TXT"));
//Print("\n");
//DeserializeDialog(2);
//Niggafart();
PrintActorShit();
//Serialize2;
//Serialize4;
$BK,1$$BK,0$$BK,0$$BK,0$$BK,1$$BK,0$//Serialize4;$BK,0$$BK,0$