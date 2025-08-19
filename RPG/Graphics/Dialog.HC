#define MAX_D 140
U8 *DIALOG_FILE = MStrPrint("%s%s",DirCur,"/Data/Dialog.TXT"); 
U8 *MARKOV_FILE = MStrPrint("%s%s",DirCur,"/Gameplay/Markov/Data.DD"); 

I32 currLetter =-1,yInc=0,xInc=0,nIndex=0,n2Index=0;
U8 myDialog[MAX_D];

U0 GrChar(CDC *dc=gr.dc,U8 ch,I64 x,I64 y,I64 scale){
  I64 i,j,k=0;
  for(i=0;i<FONT_HEIGHT;i++){
    for(j=0;j<FONT_WIDTH;j++){
      if(Bt(&text.font[ch],k++)){
        GrRect(dc,x+j*scale,y+i*scale,scale,scale);
      }
    }
  }
}

U0 PrintLine(CDC*dc=gr.dc,U8 *line,I64 startx,I64 starty,F64 scale=1){
 I64 factor = ToI64(scale*7);
 I64 i;
 for(i=0;i<StrLen(line);i++)
 {
  GrChar(dc,line[i],startx+(i*factor),
                    starty,scale);
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

#define GENERATED_TEXT 19

U0 DeserializeDialog(I64 textID){
 U8 *nameptr=myDialog;
  //id for sorting purpose only
  U8 id[8],*idptr=id;

 if(textID==GENERATED_TEXT)//generated text
 {
  U8 *speech =MarkovGenerate(DocPut,MARKOV_FILE,25,"THE");  
  I64 dialogLen = 0; 
  I64 strLen = StrLen(speech);
  for(dialogLen=0;dialogLen<strLen;dialogLen++){
   if(dialogLen<MAX_D-1)
   {
    myDialog[dialogLen] = speech[dialogLen];
   }
  }
  myDialog[dialogLen] = '\0'; 

 }else{
 
  U8 *fptr =FileRead(DIALOG_FILE);
  U8 *lnptr,*ln,*temp;
  StrUtil(fptr,SUF_REM_CTRL_CHARS);
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
}


//textID = dialog from Dialog.TXT
U0 GetDialogMsg(U8 textID)
{
  if(currLetter==0)
   DeserializeDialog(textID);
}

I64 GetTalkie(I64 id){
 I64 talkie =0;
 switch(id){
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
  case 9:
  case 11...20:
   talkie = 12;
  break;
  case SV_MISS_FISH_EQUIP://missing fish equip
   talkie = 15;
  break;
  case SV_COW://ox
   talkie = 17;
  break;
  case SV_FOWL://fowl
   talkie = 18;
  break;
  case 10://SV_MAKABEE://shop
   talkie = SV_MAKABEE_SHOP;
  break;
  case SV_GENERIC_START...SV_GENERIC_END:
   talkie = 19;
  break; 
  default:
   talkie=1;
  break; 
 }
 return talkie;
}

U0 ClearDialog()
{
 currLetter =-1;yInc=0;xInc=0;nIndex=0;n2Index=0;
}


Bool MerchantList(I64 textID)
{
 if(textID==SV_MAKABEE_SHOP)
 {
  return TRUE;
 }
 return FALSE;
}

U0 MerchantMenu(CDC *dc){

}

//name = Name of the NPC ==mc->dialogName
//dc = current device context
//task = current ctask
//textID = mc->talkieScene = Dialog.TXT
U0 Chatbox(U8 *name, CDC *dc, CTask *task,U8 textID)
{
 I64 i,xInc=0,yInc=0;
 U8 c;
 dc->color=BLACK;
 Sprite3B(dc,0,375,0,GetDialogBox);
 if(currLetter<MAX_D)
   currLetter++;

 if(MerchantList(textID))
  MerchantMenu(dc);
 
 
 GetDialogMsg(textID);

 for(i=0;i<currLetter;i++)
 {
  c = myDialog[i];
  if(c=='#'){
   c = myDialog[++i];
   yInc+=16;
   xInc=0;
  }
  GrChar(dc,c,6+xInc,386+yInc,2);
  xInc+=14;
   
 }
 PrintLine(dc,name,26,360,2);

}

//select combat action
U0 CombatDialog1(CDC *dc, CTask *task, U8 selection)
{
 U8 *cOption1 = "Move";
 U8 *cOption2 = "Strike";
 U8 *cOption3 = "Prayer";
 U8 *cOption4 = "Flee";

 U8 c,i;
 dc->color=BLACK;
 
 switch(selection)
 {
  case 10: break;
  case 11: break;
  case 12: break;
  case 13: break;
  start:
   Sprite3B(dc,0,DIALOG_BOX_Y,0,GetDialogBox);
   case CMS_MOVE:
   Sprite3B(dc,12+5*13,385,0,GetCross);
   break;
   case CMS_STRIKE:
   Sprite3B(dc,12+7*13,405,0,GetCross);
   break;
   case CMS_PRAYER:
   Sprite3B(dc,12+7*13,425,0,GetCross);
   break;
   case CMS_FLEE:
   Sprite3B(dc,12+5*13,445,0,GetCross);
   break;
  end:
   PrintLine(dc,cOption1,12,385,2);
   PrintLine(dc,cOption2,12,405,2);
   PrintLine(dc,cOption3,12,425,2);
   PrintLine(dc,cOption4,12,445,2);

  break;  

 }
}

//select prayer/item
U0 CombatDialog2(CDC *dc, CTask *task)
{
 Sprite3B(dc,300,250,0,GetButton(5));
 I64 i,j,x=280,y=250;
 Bool isItem = FALSE;
 mc->prayerToCast = mc->prayerList[mc->prayerListIndex];

 for(i=0;i<mc->prayerListSize;i++){
  if(mc->prayerList[i]==mc->prayerToCast){
   //delimiter indicates player selected back button
   if(mc->prayerToCast==DELIMITER){
    Sprite3B(dc,x,y,0,GetCross);
    goto found;
   }
   if(isItem){
     GetItemScreenLoc(mc->prayerToCast,&x,&y);
     Sprite3B(dc,x,y,0,GetCross);
     goto found;
   }
   else
   {//player selecting prayer from hotbar
    if(!isItem){
     for(j=0;j<NUM_HOTKEYS;j++)
     {
      if(hotkeys[j]==mc->prayerToCast){
       x = 10+(50*j);
       y = 26;
       Sprite3B(dc,x,y,0,GetCross);
       goto found;
      }
     }      
    }
   }
  }
  else
  {//if we have passed delimiter, then we enter the inventory space
   if(mc->prayerList[i]==DELIMITER)
    isItem=TRUE;
  }  
 }
 found:
}

//Flee box
U0 CombatDialog3(CDC *dc, CTask *task)
{
 U8 *fleeText = "Attempting to run away!";
 dc->color = BLACK;
 Sprite3B(dc,0,DIALOG_BOX_Y,0,GetDialogBox);
 PrintLine(dc,fleeText,12,385,2);


}

//Enemy attack     
U0 CombatDialog4(CDC *dc, CTask *task, Actor *p)
{
 U8 *prefix = "star";
 switch(ctp->ready->status1)
 {
  case DEAD_STATUS:
   prefix = "dy";
  break;
  default:
   prefix = "attack";
  break;
 }
 U8 *action = MStrPrint(" is %sing!",prefix);
 U8 *eText = MStrPrint("%s%s",ctp->ready->name,action);
 dc->color = BLACK;
 Sprite3B(dc,0,DIALOG_BOX_Y,0,GetDialogBox);
 PrintLine(dc,eText,12,385,2);


}
//Enemy result     
U0 CombatDialog5(CDC *dc, CTask *task, Actor *p)
{
 U8 *eText = "The enemy move was made!";
 dc->color = BLACK;
 Sprite3B(dc,0,DIALOG_BOX_Y,0,GetDialogBox);
 PrintLine(dc,eText,12,385,2);


}
