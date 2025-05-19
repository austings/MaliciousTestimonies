Cd(__DIR__);;
//Print(MStrPrint("%s%s",DirCur,DIALOG_FILE));
/*
#define MAX_D 120
#define DIALOG_FILE "Data/Dialog.TXT" 

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
 U8 *lnptr,*ln;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 *nameptr=myDialog;
 U8 id[8],*idptr=id;
 lnptr=fptr;

 I32 count = 0;
 while(ln=ReadATextLine(&lnptr))
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
 Print(ln);

}
U0 DeserializeOpts()
{
 
 U8 *fptr =FileRead("Data/OPTIONS.TXT");
 U8 *lnptr,*ln,*temp;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 id[8],*idptr=id;
 U8 val[8],*valptr=val;

 lnptr=fptr;

 //I32 count = 0;
 ln=ReadATextLine(&lnptr);
 //{
  //"%s",ln;
  //if(count!=textID||*ln=='#'||*ln==0)
  // goto skip;
 StrScan(ln,"%s\t%s",&idptr,&valptr);
 Bool ta = valptr;
 "\n%s\n",ta;
 ln=ReadATextLine(&lnptr);
 StrScan(ln,"%s\t%s",&idptr,&valptr);
 //"%s",ln;
 "%s", val;
 Free(ln);
 //}
 Free(fptr);

}



//PrintErr(MStrPrint("%s%s",DirCur,DIALOG_FILE));
DeserializeOpts;
//Print(myDialog)

I64 a= 85;
//U8* ab = Str2I64(a);
Print(MStrPrint("%d",a));
//DbgPutS("You crashed the window manager,Ill try to restart it\n");


*/


class Animation:CQue{
    CDC *frame;
    I8 subFrameDuration,
       subFrameDurationIndex,
       subFrameIndex,
       xOffset, yOffset;
};

Animation *test = CAlloc(sizeof(Animation));
QueInit(&test);
QueDel(&test);
Free(&test);