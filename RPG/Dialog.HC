#define MAX_D 120


I32 currLetter =-1,yInc=0,xInc=0,nIndex=0,n2Index=0;
U8 *myDialog;

U0GrChar(CDC*dc=gr.dc,U8 ch,I64 x,I64 y,I64 scale)
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



U0 DeserializeDialog(I64 textID)
{
 U8 *fptr = FileRead("C:/Home/RPG/Dialog.TXT"),
    *lnptr,*ln,*temp;
 StrUtil(fptr,SUF_REM_CTRL_CHARS);
 U8 name[MAX_D],*nameptr=name;
 U8 id[8],*idptr=id;

 lnptr=fptr;

 I32 count = 0;
 while(ln=ReadALine(&lnptr))
 {
  if(count!=textID||*ln=='#'||*ln==0)
   goto skip;
  StrScan(ln,"%s\t%s",
   &idptr,&nameptr);
  skip:;
  Free(ln);
  count++;
 }
 Free(fptr);

 for(count=0;count<MAX_D;count++)
 {
  myDialog[count] = nameptr[count];
 }

}

U0 GetDialogMsg(U8 textID)
{
  if(currLetter==0)
   DeserializeDialog(textID);
}

I64 GetTalkie(I64 id)
{
  I64 talkie =0;
  switch(id)
  {
   case 1://king
   talkie = 10;
   break;
   case 2://jezebel
   talkie = 9;
   break;
   case 3://elijah
   talkie = 11;
   break;
   case 4://guard
   talkie = 2;
   break;
   case 5://captain
   talkie = 3;
   break;
  }
  return talkie;
}

U0 ClearDialog()
{
 currLetter =-1;yInc=0;xInc=0;nIndex=0;n2Index=0;
}


U0 Chatbox(U8 *name, CDC*dc, CTask *task,U8 textID)
{
 I64 i,nL,xInc,yInc;
 U8 c;
 dc->color=BLACK;
 Sprite3B(dc,0,375,0,GetDialogBox);
 if(currLetter<MAX_D)
   currLetter++;
 GetDialogMsg(textID);


 for(i=0;i<currLetter;i++)
 {
  c = myDialog[i];
  //if(i==0)
  // AdamLog((&myDialog));
  if(c=='#')
  {
   if(nIndex!=0&&i!=nIndex)
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
   if(i>nIndex&&nIndex!=0)
   {
    if(i>n2Index&&n2Index!=0)
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


U0 CombatDialog1(CDC*dc, CTask *task, U8 selection)
{
 U8 *cOption1 = "Move";
 U8 *cOption2 = "Strike";
 U8 *cOption3 = "Prayer";
 U8 *cOption4 = "Item";

 U8 c,i;
 dc->color=BLACK;
 Sprite3B(dc,0,375,0,GetDialogBox);
 
 switch(selection)
 {
   case 0:
   Sprite3B(dc,12+5*13,385,0,GetCross);
   break;
   case 1:
   Sprite3B(dc,12+7*13,405,0,GetCross);
   break;
   case 2:
   Sprite3B(dc,12+7*13,425,0,GetCross);
   break;
   case 3:
   Sprite3B(dc,12+5*13,445,0,GetCross);
   break;
 }
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

}