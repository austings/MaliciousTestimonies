#define MAX_D 120
U8 *DIALOG_FILE = MStrPrint("%s%s",DirCur,"/Data/Dialog.TXT"); 

I32 currLetter =-1,yInc=0,xInc=0,nIndex=0,n2Index=0;
U8 myDialog[MAX_D];

U0 GrChar(CDC *dc=gr.dc,U8 ch,I64 x,I64 y,I64 scale)
{
  I64 i,j,k=0;
  for(i=0;i<FONT_HEIGHT;i++){
    for(j=0;j<FONT_WIDTH;j++){
      if(Bt(&text.font[ch],k++)){
        GrRect(dc,x+j*scale,y+i*scale,scale,scale);
      }
    }
  }
}
U8 *ReadATextLine(U8 **fbuf) {
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


U0 DeserializeDialog(I64 textID)
{
 
 U8 *fptr =FileRead(DIALOG_FILE);
 U8 *lnptr,*ln,*temp;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 *nameptr=myDialog;
 U8 id[8],*idptr=id;
 lnptr=fptr;

 I32 count = 0;
 while(ln=ReadALine(&lnptr))
 {
  //"%s",ln;
  if(count!=textID||*ln=='#'||*ln==0)
   goto skip;
  StrScan(ln,"%s\t%s",&idptr,&nameptr);
  break;
  skip:;
  Free(ln);
  count++;
 }
 Free(fptr);

}


U0 GetDialogMsg(U8 textID,U8 *mctext)
{

  if(currLetter==0)
   DeserializeDialog(textID);
}

I64 GetTalkie(I64 id)
{
  I64 talkie =0;
  switch(id)
  {
   case SV_KING_1://king
   talkie = 10;
   break;
   case SV_JEZ_1://jezebel
   talkie = 9;
   break;
   case SV_ELI_1://elijah
   talkie = 11;
   break;
   case SV_GUARD1://guard
   talkie = 2;
   break;
   case SV_GUARD2://captain
   talkie = 3;
   break;
   case SV_WOLF1://wolf
   talkie = 12;
   break;
   case SV_MISS_FISH_EQUIP://missing fish equip
   talkie = 15;
   break;
  }
  return talkie;
}

U0 ClearDialog()
{
 currLetter =-1;yInc=0;xInc=0;nIndex=0;n2Index=0;
}


U0 Chatbox(U8 *name, CDC *dc, CTask *task,U8 textID,U8 *mctext="")
{
 I64 i,nL,xInc,yInc;
 U8 c;
 dc->color=BLACK;
 Sprite3B(dc,0,375,0,GetDialogBox);
 if(currLetter<MAX_D)
   currLetter++;

 GetDialogMsg(textID,mctext);
 //currLetter=0;
 for(i=0;i<currLetter;i++)
 {
  c = myDialog[i];
  //if(i==0)
  // AdamLog((&myDialog));
  if(c=='#')
  {
   if(nIndex!=0 && i!=nIndex)
   {
    n2Index=i;
   }
   else
   {
    nIndex= i;
   }   
  }
  else
  {
   if(i>nIndex && nIndex!=0)
   {
    if(i>n2Index && n2Index!=0)
    {
     yInc=30;
     xInc=n2Index+1;
    }
    else
    {
     yInc=15;
     xInc=nIndex+1;
    }
    
   }
   else
   {
    yInc=0;
    xInc=0;
   }

   GrChar(dc,c,Max(0,(i-xInc))*13+12,390+yInc,2);

  }
 }
 
 for(i=0;i<15;i++)
 {
  c = name[i];
  GrChar(dc,c,i*14+12,360,2);

 }
   

}


U0 CombatDialog1(CDC *dc, CTask *task, U8 selection)
{
 U8 *cOption1 = "Move";
 U8 *cOption2 = "Strike";
 U8 *cOption3 = "Prayer";
 U8 *cOption4 = "Item";

 U8 c,i;
 dc->color=BLACK;
 
 switch(selection)
 {
  case 10: break;
  case 11: break;
  case 12: break;
  case 13: break;
  start:
   Sprite3B(dc,0,375,0,GetDialogBox);
   case 0:
   Sprite3B(dc,12+5*13,385,0,GetCross);
   break;
   case 1:
   Sprite3B(dc,12+7*13,405,0,GetCross);
   break;
   case 2:
   Sprite3B(dc,12+7*13,425,0,GetCross);
   break;
   case 3:
   Sprite3B(dc,12+5*13,445,0,GetCross);
   break;
  end:
   for(i=0;i<6;i++)
   {
    c=cOption2[i];
    GrChar(dc,c,12+i*13,405,2);
  
    c=cOption3[i];
    GrChar(dc,c,12+i*13,425,2);

    if(i<=3){
     c=cOption1[i];
     GrChar(dc,c,12+i*13,385,2);

     c=cOption4[i];
     GrChar(dc,c,12+i*13,445,2);
    }
   } 
  break;  

 }
}

U0 CombatDialog2(CDC *DC, CTask *Task, I64 target, U8 selection)
{

}