#include "BMP/FileBMP.HC";
#include "BMP/BMPView.HC";
U8 *OPTS_FILE = MStrPrint("%s%s",DirCur,"/Data/OPTIONS.TXT"); 


U8 currentSelection = 0, currentHair=0,currentFace=0;
U8 animationCounter = 0;

//Cutscene Control
U8*curImg;
U32 currLetter =0,yInc=0,xInc=0,nIndex=0;
Bool newLine=FALSE;
U8 *text1 = "You are hereby invited to the wedding of\nKing Ahab and Princess Jezebel.";
U8 *text2 = "This union symbolizes peace between\nZidonia and Israel.";
U8 *text3 = "Noblemen from all the tribes of Israel\nare called to this special occasion.";

U8 *img1 = MStrPrint("%s%s",DirCur,"/BMP/jezebel1.bmp"); 
U8 *img2 = MStrPrint("%s%s",DirCur,"/BMP/jezebel2.bmp"); 
U8 *img3 = MStrPrint("%s%s",DirCur,"/BMP/jezebel3.bmp"); 



U0 IncSelect(U8 type)
{
 switch(type)
 {
  case 0:
  currentSelection++;
  if(currentSelection==4)
   currentSelection=0;
  break;
  case 1:
  currentHair++;;
  if(currentHair==4)
   currentHair=0;
  break;
  case 2:
  currentFace++;
  if(currentFace==4)
   currentFace=0;
  break;
 }
}

U0 MenuQuit()
{

}

I64 MainMenuControls(I64 arg1, I64 arg2,I64 msg_code){
 switch(GetMsg(&arg1,&arg2,
      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN
      |1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) //msg_code=GetMsg(&arg1,&arg2,//1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|//1<<MSG_MS_L_UP|1<<MSG_MS_MOVE))
 {
  case MSG_MS_L_DOWN:
   if(camera->cursorX>=229&&camera->cursorX<=397){//menu buttons
    if(camera->cursorY>258&&camera->cursorY<298){//new game
     mc->currentMenu=3;mc->currentSong=3;
    } else if(camera->cursorY>307&&camera->cursorY<349){//load game
     loadRoot = FilesFind("Saves/*",FUF_JUST_FILES);
     mc->currentMenu=4;mc->currentSong=4;
    } else if(camera->cursorY>358&&camera->cursorY<399){//options
    } else if(camera->cursorY>408&&camera->cursorY<448){//exit
     return 1;
    }
   }//end menu buttons
   else if(camera->cursorX>=494&&camera->cursorX<=549&&//music 
           camera->cursorY>=220&&camera->cursorY<=280){
    if(mc->musicMuted==FALSE){
     mc->musicMuted=TRUE; 
    }else { mc->musicMuted=FALSE;  }
    } else if(camera->cursorX>=550&&camera->cursorX<=610&&//fx
              camera->cursorY>=220&&camera->cursorY<=280){	      
     if(mc->fxMuted==FALSE){
      mc->fxMuted=TRUE; 
     }else { mc->fxMuted=FALSE; }
    }
   break;
 }
 return 0;
  
}

U8 GetSelectedStats(U8 id)
{
 switch(id)
 {
  case 0:
  return currentSelection;
  break;
  case 1:
  return currentHair;
  break;
  case 2:
  return currentFace;
  break;
 }

}

U0 MainMenu(CDC*dc, CTask *task)
{
  dc->color = BLUE;
  GrLine3(dc,0, 240, 0, 640, 240, 0);
   
  GrFloodFill(dc,15,15,FALSE,0,0);

  dc->color = GREEN;
  GrFloodFill(dc,15,300,FALSE,0,0);
  
  Sprite3B(dc,140,50,10,GetTitle());
  
  Sprite3B(dc,220,250,10,GetButton(0));
  Sprite3B(dc,220,300,10,GetButton(1));
  Sprite3B(dc,220,350,10,GetButton(2));
  Sprite3B(dc,220,400,10,GetButton(3));

  //music button
  Sprite3B(dc,494,220,0,GetMenuSprite(0));    
  Sprite3B(dc,493,222,0,GetMenuSprite(7));
  if(mc->musicMuted)   
    Sprite3B(dc,500,230,0,GetMenuSprite(6));

  //fx button
  Sprite3B(dc,554,220,0,GetMenuSprite(0));    
  Sprite3B(dc,546,230,0,GetMenuSprite(5));
  if(mc->fxMuted)
    Sprite3B(dc,558,230,0,GetMenuSprite(6));
 
   
}



U0 LoadMenu(CDC*dc, CTask *task,CDirEntry *root)
{
  CDirEntry*cur;
  U8* loadT = "Load a File";
  I64 i,yInc=0;
  dc->color = BLUE;
  GrLine3(dc,0, 240, 0, 640, 240, 0);
   
  GrFloodFill(dc,15,15,FALSE,0,0);

  dc->color = GREEN;
  GrFloodFill(dc,15,300,FALSE,0,0);
  
  Sprite3B(dc,10,10,10,GetButton(3));

  dc->color = PURPLE;
  PrintLine(dc,loadT,240,10,1.25);
  
  for(cur=root;cur!=NULL;cur=cur->next)
  {
    dc->color=LTGRAY;
    GrRect(dc,190,yInc,400,25);
    dc->color=PURPLE;
    
    U8* edit = cur->name;
    edit =MStrPrint("%s%s","Saves/",edit);
    PrintLine(dc,edit,200,10+yInc,.583);
    //for(i=0;i<StrLen(edit);i++)
    //{
    //  GrChar(dc,edit[i],200+(i)*7,10+yInc,1);
    //}
    yInc+=40;
  }
  

}


U0 CharMenu(CDC *dc, CTask *task, CDC *r1, CDC *r2, CDC *r3, CDC *r4)
{
  I64 i=0,yInc=0,xInc=-7;
  U8 *t1 = "Tribe"; U8 *t2 = "Hair"; U8 *t3 = "Face";
  U8 *t4 = "Tribe of Levi"; U8 *t5 = "Tribe of Judah";
  U8 *t6 = "Tribe of Ephraim"; U8 *t7 = "Tribe of Benjamin";
  U8 *t8 = "Although the Levites did not receive a specific\nterritorial inheritance, they were designated as\nthe priestly tribe and had a central role in\nreligious life, serving as priests and temple workers.";
  U8 *t9 = "As part of the greater tribe ofJoseph,\nthe Ephraim settled in the northern kingdom of Israel.\nThe stalwart tribe played a central role as\nkey defenders of the political and religious order.";  
  U8 *t10= "Heirs of the Davidic monarchy and King Solomon's\nlegacy, the tribe of Judah played a central role\nin the formation of the Kingdom ofJudah\nand development of Judaism.";
  U8 *t11= "A relatively small tribe, the descendants of\nBenjamin were made significant by the first\nKing of Israel, Saul. They are mighty warriors\nthat control the key city of Jerusalem.";
  U8 *t12= "STRENGTH: Base Attack Damage"; U8 *t13= "CONSTITUTION: Base Attack Defense";
  U8 *t14= "INTELLIGENCE: Special Attack Damage";U8 *t15= "WISDOM: Special Attack Defense";
  U8 *t16= "5"; U8 *t17= "10"; U8 *t18= "15";
  U8 *t19= "Choose Your Tribe";

  dc->color = BLACK;
  GrLine3(dc,0, 240, 0, 640, 240, 0);
   
  GrFloodFill(dc,15,15,FALSE,0,0);

  dc->color = DKGRAY;
  GrFloodFill(dc,15,300,FALSE,0,0);
  
  Sprite3B(dc,250,300,10,GetShadow());
  dc->color = WHITE;
  for(i=0;i<StrLen(t19);i++){     
   GrChar(dc,t19[i],10+i*15,10,2);
  }
  switch(currentSelection){
   case T_JUDA:
    PrintLine(dc,t5,10,40,2);
    for(i=0;i<StrLen(t10);i++){
     if(t10[i]!='\n'){
      xInc = xInc+7;
      GrChar(dc,t10[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }
    PrintLine(dc,t17,390,20,2);
    PrintLine(dc,t17,390,70,2);
    PrintLine(dc,t17,390,120,2);
    PrintLine(dc,t17,390,170,2);    
   break;
   case T_LEVI:
    PrintLine(dc,t4,10,40,2);
    for(i=0;i<StrLen(t8);i++){
     if(t8[i]!='\n'){
      xInc = xInc+7;
      GrChar(dc,t8[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }
    PrintLine(dc,t16,390,20,2);
    PrintLine(dc,t16,390,70,2);
    PrintLine(dc,t18,390,120,2);
    PrintLine(dc,t18,390,170,2); 
   break;
   case T_EPHR:
    PrintLine(dc,t6,10,40,2);
    for(i=0;i<StrLen(t9);i++){
     if(t9[i]!='\n'){
      xInc = xInc+7;
      GrChar(dc,t9[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }
    PrintLine(dc,t16,390,20,2);
    PrintLine(dc,t18,390,70,2);
    PrintLine(dc,t16,390,120,2);
    PrintLine(dc,t18,390,170,2);
   break;
   case T_BENJ:
    PrintLine(dc,t7,10,40,2);
    for(i=0;i<StrLen(t11);i++){
     if(t11[i]!='\n'){
      xInc = xInc+7;
      GrChar(dc,t11[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }
    PrintLine(dc,t18,390,20,2);
    PrintLine(dc,t18,390,70,2);
    PrintLine(dc,t16,390,120,2);
    PrintLine(dc,t16,390,170,2);   
   break;
  }
  yInc=0;
  xInc=-7;
  //ABILITYPOINTS
  PrintLine(dc,t12,390,10,1);
  PrintLine(dc,t13,390,60,1);
  PrintLine(dc,t14,390,110,1);
  PrintLine(dc,t15,390,160,1);
  

  switch(currentFace)
  {
   case 0:
    GrBlot3(dc,270,280,10,r1);
   break;
   case 1:
    GrBlot3(dc,268,280,10,r2);
   break;
   case 2:
    GrBlot3(dc,266,280,10,r3);
   break;
   case 3:
    GrBlot3(dc,264,280,10,r4);
   break;
  }  

  CDC *hair = DCNew(100,100);
  DCFill(hair,TRANSPARENT);
  switch(currentHair)
  {
   case HAIR0:
    GrBlot3(dc,270,280,10,GetHair0(hair, DIR_DOWN));
   break;
   case HAIR1:
    GrBlot3(dc,270,280,10,GetHair1(hair, DIR_DOWN));
   break;
   case HAIR2:
    GrBlot3(dc,270,280,10,GetHair2(hair, DIR_DOWN));
   break;
   case HAIR3:
    GrBlot3(dc,270,280,10,GetHair3(hair, DIR_DOWN));
   break;
  }
  DCDel(hair);
  //ARROWSANDARROWLABEL  
  Sprite3B(dc,450,370,10,GetArrow());
  Sprite3B(dc,375,300,10,GetLilArrow());
  Sprite3B(dc,375,350,10,GetLilArrow());
  Sprite3B(dc,375,400,10,GetLilArrow());
  PrintLine(dc,t1,380,310,1); 
  PrintLine(dc,t2,380,360,1);
  PrintLine(dc,t3,380,410,1);


  //Sprite3B(dc,220,300,10,GetButton(1));
  //Sprite3B(dc,220,350,10,GetButton(2));
  //Sprite3B(dc,220,400,10,GetButton(3));
  
   
}


 
//CleanUpImage;
//Free(img1);

U0 AddCurrLetter(I64 i,I32 textID)
{
 switch(textID)
 {
  case 0:
  currLetter=Min(StrLen(text1),currLetter+i);
  break;
  case 1:
  currLetter=Min(StrLen(text2),currLetter+i);
  break;
  case 2:
  currLetter=Min(StrLen(text3),currLetter+i);
  break;
 }
 
}

U0 ResetCurrLetter()
{
 currLetter=0;
 yInc=0;
 xInc=0;
 newLine=FALSE;
}

U32 GetCurrLetter()
{
 return currLetter;
}

U0 IntroCutscene(CDC *dc, CTask *task,U8 textID)
{

 I64 i;
 dc->color=BLACK;
   GrFloodFill(dc,15,15,FALSE,0,0);
 curImg=img2;
 animationCounter++;
 if(animationCounter>=1&&animationCounter<=13){  
  curImg=img2;
 }
 if(animationCounter>=14&&animationCounter<=20){
  
  curImg=img3;
 }
 if(animationCounter>=21&&animationCounter<=27){
  //CleanUpImage;
  curImg=img2;
 }
 if(animationCounter>=28&&animationCounter<=34){
  //CleanUpImage;
  curImg=img1;
 }
 if(animationCounter==35){
  animationCounter=0;
  //CleanUpImage;
 }
 InitImage(curImg,.8);
 BMP24View(curImg,0.8,dc,task);
 dc->color=WHITE;
 for(i=0;i<currLetter;i++)
 {
   switch(textID)
   {
    case 0:

     if(text1[i]=='\n')
     {
      newLine=TRUE;
      nIndex= i;
      
     }
     else
     {
      if(i>nIndex&&nIndex!=0)
      {
       yInc=20;
       xInc=nIndex+1;
      }
      else
      {
       yInc=0;
       xInc=0;
      }
      GrChar(dc,text1[i],(i-xInc)*14+12,420+yInc,2);
     }
     break;
    case 1:
     if(text2[i]=='\n')
     {
      newLine=TRUE;
      nIndex= i;
      
     }
     else
     {
      if(i>nIndex&&nIndex!=0)
      {
       yInc=20;
       xInc=nIndex+1;
      }
      else
      {
       yInc=0;
       xInc=0;
      }
      GrChar(dc,text2[i],(i-xInc)*14+12,420+yInc,2);
     }
     break;
    case 2:
     if(text3[i]=='\n')
     {
      newLine=TRUE;
      nIndex= i;
      
     }
     else
     {
      if(i>nIndex&&nIndex!=0)
      {
       yInc=20;
       xInc=nIndex+1;
      }
      else
      {
       yInc=0;
       xInc=0;
      }
      GrChar(dc,text3[i],(i-xInc)*14+12,420+yInc,2);
     }
     break;
   }
  
 }
 AddCurrLetter(1,textID);
 CleanUpImage;
}
