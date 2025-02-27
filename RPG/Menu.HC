#include "BMP/FileBMP.HC";
#include "BMP/BMPView.HC";

U8 currentSelection = 0, currentHair=0,currentEyes=0;
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


class SaveFormat
{
U8  saveFile[32]	format "$$DA-P,A=\"FileName:%s\"$$\n";
} saveFileFormat;  

class SaveFileData
{
 World *world;
 Actor *player;
};


#assert sizeof(SaveFileData)<=BLK_SIZE

U0 IncSelect(U8 type)
{
 switch(type)
 {
  case 0:
  currentSelection++;
  if(currentSelection==4)
   currentSelection=0;
  break;
  case 1:
  currentHair=currentHair+4;;
  if(currentHair==20)
   currentHair=0;
  break;
  case 2:
  currentEyes++;
  if(currentEyes==4)
   currentEyes=0;
  break;
 }
}

U0 MenuQuit()
{

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
  return currentEyes;
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
  for(i=0;i<StrLen(loadT);i++)
  {     
    GrChar(dc,loadT[i],240+i*15,10,2);
  }
  for(cur=root;cur!=NULL;cur=cur->next)
  {
    dc->color=LTGRAY;
    GrRect(dc,190,yInc,400,25);
    dc->color=PURPLE;
    
    U8* edit = cur->name;
    edit =MStrPrint("%s%s","Saves/",edit);
    for(i=0;i<StrLen(edit);i++)
    {
      GrChar(dc,edit[i],200+(i)*7,10+yInc,1);
    }
    yInc+=40;
  }
  

}


U0 CharMenu(CDC*dc, CTask *task, CDC *r1, CDC *r2, CDC *r3, CDC *r4)
{
  I64 i=0,yInc=0,xInc=-7;
  U8 *t1 = "Tribe";
  U8 *t2 = "Hair";
  U8 *t3 = "Face";
  U8 *t4 = "Tribe of Levi";
  U8 *t5 = "Tribe of Judah";
  U8 *t6 = "Tribe of Ephraim";
  U8 *t7 = "Tribe of Benjamin";
  U8 *t8 = "Although the Levites did not receive a specific\nterritorial inheritance, they were designated as\nthe priestly tribe and had a central role in\nreligious life, serving as priests and temple workers.";
  U8 *t9 = "As part of the greater tribe ofJoseph,\nthe Ephraim settled in the northern kingdom of Israel.\nThe stalwart tribe played a central role as\nkey defenders of the political and religious order.";  
  U8 *t10= "Heirs of the Davidic monarchy and King Solomon's\nlegacy, the tribe of Judah played a central role\nin the formation of the Kingdom ofJudah\nand development of Judaism.";
  U8 *t11= "A relatively small tribe, the descendants of\nBenjamin were made significant by the first\nKing of Israel, Saul. They are mighty warriors\nthat control the key city of Jerusalem.";
  U8 *t12= "STRENGTH:Base Attack Damage";
  U8 *t13= "CONSTITUTION:Base Attack Defense";
  U8 *t14= "INTELLIGENCE:Special Attack Damage";
  U8 *t15= "WISDOM:Special Attack Defense";
  U8 *t16= "5";
  U8 *t17= "10";
  U8 *t18= "15";
  U8 *t19= "Choose Your Tribe";

  dc->color = BLACK;
  GrLine3(dc,0, 240, 0, 640, 240, 0);
   
  GrFloodFill(dc,15,15,FALSE,0,0);

  dc->color = DKGRAY;
  GrFloodFill(dc,15,300,FALSE,0,0);
  
  Sprite3B(dc,250,300,10,GetShadow());
  dc->color = WHITE;
  for(i=0;i<StrLen(t19);i++)
  {     
      GrChar(dc,t19[i],10+i*15,10,2);
  }
  switch(currentSelection)
  {
   case 0:
    for(i=0;i<StrLen(t5);i++)
    {     
      GrChar(dc,t5[i],10+i*18,40,2);
    }
    for(i=0;i<StrLen(t10);i++)
    {
     if(t10[i]!='\n')
     {
      xInc = xInc+7;
      GrChar(dc,t10[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }
    for(i=0;i<StrLen(t17);i++)
    {
     GrChar(dc,t17[i],390+i*18,20,2);
    }
    for(i=0;i<StrLen(t17);i++)
    {
     GrChar(dc,t17[i],390+i*18,70,2);
    }
    for(i=0;i<StrLen(t17);i++)
    {
     GrChar(dc,t17[i],390+i*18,120,2);
    }
    for(i=0;i<StrLen(t17);i++)
    {
     GrChar(dc,t17[i],390+i*18,170,2);
    }

    GrBlot3(dc,270,280,10,r1);

   break;
   case 1:
    for(i=0;i<StrLen(t4);i++)
    {     
      GrChar(dc,t4[i],10+i*18,40,2);
    }
    for(i=0;i<StrLen(t8);i++)
    {
     if(t8[i]!='\n')
     {
      xInc = xInc+7;
      GrChar(dc,t8[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }

    for(i=0;i<StrLen(t16);i++)
    {
     GrChar(dc,t16[i],390+i*18,20,2);
    }
    for(i=0;i<StrLen(t16);i++)
    {
     GrChar(dc,t16[i],390+i*18,70,2);
    }
    for(i=0;i<StrLen(t18);i++)
    {
     GrChar(dc,t18[i],390+i*18,120,2);
    }
    for(i=0;i<StrLen(t18);i++)
    {
     GrChar(dc,t18[i],390+i*18,170,2);
    }    

    GrBlot3(dc,268,280,10,r2);

   break;
   case 2:
    for(i=0;i<StrLen(t6);i++)
    {     
      GrChar(dc,t6[i],10+i*18,40,2);
    }
    for(i=0;i<StrLen(t9);i++)
    {
     if(t9[i]!='\n')
     {
      xInc = xInc+7;
      GrChar(dc,t9[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }

    for(i=0;i<StrLen(t16);i++)
    {
     GrChar(dc,t16[i],390+i*18,20,2);
    }
    for(i=0;i<StrLen(t18);i++)
    {
     GrChar(dc,t18[i],390+i*18,70,2);
    }
    for(i=0;i<StrLen(t16);i++)
    {
     GrChar(dc,t16[i],390+i*18,120,2);
    }
    for(i=0;i<StrLen(t18);i++)
    {
     GrChar(dc,t18[i],390+i*18,170,2);
    }
    
    GrBlot3(dc,266,280,10,r3);

   break;
   case 3:
    for(i=0;i<StrLen(t7);i++)
    {     
      GrChar(dc,t7[i],10+i*18,40,2);
    }
    for(i=0;i<StrLen(t11);i++)
    {
     if(t11[i]!='\n')
     {
      xInc = xInc+7;
      GrChar(dc,t11[i],10+xInc,80+yInc,1);
     }
     else{
      yInc+=10;
      xInc=-7;
     }
    }

    for(i=0;i<StrLen(t18);i++)
    {
     GrChar(dc,t18[i],390+i*18,20,2);
    }
    for(i=0;i<StrLen(t18);i++)
    {
     GrChar(dc,t18[i],390+i*18,70,2);
    }
    for(i=0;i<StrLen(t16);i++)
    {
     GrChar(dc,t16[i],390+i*18,120,2);
    }
    for(i=0;i<StrLen(t16);i++)
    {
     GrChar(dc,t16[i],390+i*18,170,2);
    }
    
    GrBlot3(dc,264,280,10,r4);

   break;
  }
  yInc=0;
  xInc=-7;
  //ABILITYPOINTS
  for(i=0;i<StrLen(t12);i++)
  {
   GrChar(dc,t12[i],390+i*7,10,1);
  }
  for(i=0;i<StrLen(t13);i++)
  {
   GrChar(dc,t13[i],390+i*7,60,1);
  }
  for(i=0;i<StrLen(t14);i++)
  {
   GrChar(dc,t14[i],390+i*7,110,1);
  }
  for(i=0;i<StrLen(t15);i++)
  {
   GrChar(dc,t15[i],390+i*7,160,1);
  }
  

  switch(currentEyes)
  {
   case 0:
    //Sprite3B(dc,295,285,10,GetEyes(0));
   break;
   case 1:
    //Sprite3B(dc,295,301,10,GetEyes(1));
   break;
   case 2:
    //Sprite3B(dc,295,301,10,GetEyes(2));
   break;
   case 3:
    //Sprite3B(dc,295,301,10,GetEyes(3));
   break;
  }  

  switch(currentHair)
  {
   case 0:
    GrBlot3(dc,270,280,10,GetHair(0));
   break;
   case 4:
    GrBlot3(dc,270,280,10,GetHair(4));
   break;
   case 8:
    GrBlot3(dc,270,280,10,GetHair(8));
   break;
   case 12:
    GrBlot3(dc,270,280,10,GetHair(12));
   break;
  }
  //ARROWSANDARROWLABEL  
  Sprite3B(dc,450,370,10,GetArrow());
  Sprite3B(dc,375,300,10,GetLilArrow());
  Sprite3B(dc,375,350,10,GetLilArrow());
  Sprite3B(dc,375,400,10,GetLilArrow());
  for(i=0;i<StrLen(t1);i++)
  {
   GrChar(dc,t1[i],380+i*7,310,1);
  }
  for(i=0;i<StrLen(t2);i++)
  {
   GrChar(dc,t2[i],380+i*7,360,1);
  }
  for(i=0;i<StrLen(t3);i++)
  {
   GrChar(dc,t3[i],380+i*7,410,1);
  }


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



//Main game side bar
U0 RPGSideBar(CDC *dc)
{

   //equipment button
   Sprite3B(dc,494,40,0,GetMenuSprite(0));    
   Sprite3B(dc,510,52,0,GetMenuSprite(8));

   //stats button
   Sprite3B(dc,554,40,0,GetMenuSprite(0));    
   Sprite3B(dc,562,48,0,GetMenuSprite(4));

   //inventory button
   Sprite3B(dc,494,100,0,GetMenuSprite(0));    
   Sprite3B(dc,510,112,0,GetMenuSprite(1));    


   Sprite3B(dc,554,100,0,GetMenuSprite(0));    

   Sprite3B(dc,494,160,0,GetMenuSprite(0));    

   Sprite3B(dc,554,160,0,GetMenuSprite(0));    


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

//stats menu bar

CDC *RenderStats(Actor *player)
{
  I64 i;
  U8 *t0a = "Tribe of Judah";
  U8 *t0b = "Tribe of Levi";
  U8 *t0c = "Tribe of Ephraim";
  U8 *t0d = "Tribe of Benjamin";

  U8 *t1 = "STR:";
  U8 *t1a= "Base Attack Damage";
  U8 *v1 = MStrPrint("%d",player->str);
  U8 *t2= "CON:";
  U8 *t2a= "Base Attack Defense";
  U8 *v2 =  MStrPrint("%d",player->con);
  U8 *t3= "INT:";
  U8 *t3a="Special Attack Damage";
  U8 *v3 =  MStrPrint("%d",player->int);
  U8 *t4= "WIS:";
  U8 *t4a= "Special Attack Defense";
  U8 *v4 =  MStrPrint("%d",player->wis);

  U8 *t5= "Experience:";
  U8 *v5a= MStrPrint("%d",player->exp);
  U8 *v5b= MStrPrint("%d",player->maxExp);
  U8 *v5c= "/";
  U8 *t6= "Current Level:";
  U8 *v6= MStrPrint("%d",player->lvl);

  CDC *completeMenu = DCNew(140,300);
  DCFill(completeMenu, BLACK);

  completeMenu->color=WHITE;

  switch(player->race)
  {
    case 0:  
     for(i=0;i<StrLen(t0a);i++)
     {
      GrChar(completeMenu,t0a[i],i*7,20,1);
     }
    break;
    case 1:
     for(i=0;i<StrLen(t0b);i++)
     {
      GrChar(completeMenu,t0b[i],i*7,20,1);
     }
    break;
    case 2:  
     for(i=0;i<StrLen(t0c);i++)
     {
      GrChar(completeMenu,t0c[i],i*7,20,1);
     }
    break;
    case 3:
     for(i=0;i<StrLen(t0d);i++)
     {
      GrChar(completeMenu,t0d[i],i*7,20,1);
     }
    break;
  }

  for(i=0;i<StrLen(t1);i++)
  {
   GrChar(completeMenu,t1[i],i*7,40,1);
  }
  for(i=0;i<StrLen(v1);i++)
  {
   GrChar(completeMenu,v1[i],(4*7)+i*7,40,1);
  }

  for(i=0;i<StrLen(t2);i++)
  {
   GrChar(completeMenu,t2[i],i*7,60,1);
  }
  for(i=0;i<StrLen(v2);i++)
  {
   GrChar(completeMenu,v2[i],(4*7)+i*7,60,1);
  }

  for(i=0;i<StrLen(t3);i++)
  {
   GrChar(completeMenu,t3[i],i*7,80,1);
  }
  for(i=0;i<StrLen(v3);i++)
  {
   GrChar(completeMenu,v3[i],(4*7)+i*7,80,1);
  }

  for(i=0;i<StrLen(t4);i++)
  {
   GrChar(completeMenu,t4[i],i*7,100,1);
  }
  for(i=0;i<StrLen(v4);i++)
  {
   GrChar(completeMenu,v4[i],(4*7)+i*7,100,1);
  }

  for(i=0;i<StrLen(t5);i++)
  {
   GrChar(completeMenu,t5[i],i*7,120,1);
  }
  for(i=0;i<StrLen(v5a);i++)
  {
   GrChar(completeMenu,v5a[(StrLen(v5a)-i)-1],(5*7)-(i*7),140,1);
  }

  GrChar(completeMenu,v5c[0],(5*7)+i*7,140,1);

  for(i=0;i<StrLen(v5b);i++)
  {
   GrChar(completeMenu,v5b[i],(7*7)+(i*7),140,1);
  }

  for(i=0;i<StrLen(t6);i++)
  {
   GrChar(completeMenu,t6[i],i*7,160,1);
  }
  for(i=0;i<StrLen(v6);i++)
  {
   GrChar(completeMenu,v6[i],(5*7)+i*7,180,1);
  }


 Sprite3B(completeMenu,120,0,1,GetMenuSprite(3));//xbutton    
 return completeMenu;

}

 
CDC *RenderInventory(Actor *p)
{ 
 if(mc->reRenderInv)
 {
  I64 i,j;
  CDC *newInventoryRender = DCNew(640,480);
  DCFill(newInventoryRender, TRANSPARENT);
  //items
  static I16 scanned[44] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
  U16 scanWriteIndex = 0;
  for(i=0;i<11;i++)
  {
   for(j=0;j<4;j++)
   {
    I8 occupied= p->myInv->mtrx[j][i].occupied;
    if(occupied!=-1)
    {
     Bool alreadyScanned = FALSE;
     U8 scanIndex = 0;
     while(scanIndex<scanWriteIndex)
     {
      if(scanned[scanIndex]==occupied)
       alreadyScanned=TRUE;
      scanIndex++;
     }
     if(!alreadyScanned)
     {
      scanned[scanWriteIndex] = occupied;
      scanWriteIndex++;
      I64 currentItemID = RetrieveItemID(0,occupied); 
           
      switch(currentItemID)
      {
       case 1://dagger   
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM1I);
       break;
       case 2://harpoon   
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM2I);
       break;
       case 3://wolfteeth
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM3I);
       break;
      }
      //Free(&retrieved);
     }
    }
   }
  }
  mc->inventoryRender = newInventoryRender;
  mc->reRenderInv=FALSE;
 }
 
 return mc->inventoryRender;

}


CDC *RenderEquipment(Actor *player){

  CDC *completeMenu = DCNew(160,300);

  DCFill(completeMenu, BLACK);

  completeMenu->color=LTGRAY;
  GrRect3(completeMenu,0,0,0,160,3);
  GrRect3(completeMenu,0,0,0,3,300);
  GrRect3(completeMenu,0,297,0,160,3);
  GrRect3(completeMenu,157,0,0,3,300);

  completeMenu->color=WHITE;
  I64 i;
  U8 *title = "Equipment";
 
  U8 *a = "HELM";
  U8 *b = "WEPN";
  U8 *c = "BODY";
  U8 *d = "RING";

  for(i=0;i<StrLen(title);i++)
  {
   GrChar(completeMenu,title[i],7+i*7,7,1);
  }
 

  //helm
  Sprite3B(completeMenu,8,25,10,GetMenuSprite(2));
  Sprite3B(completeMenu,8+camera->dividX,25,10,GetMenuSprite(2));
  Sprite3B(completeMenu,8,25+camera->dividY,10,GetMenuSprite(2));
  Sprite3B(completeMenu,8+camera->dividX,25+camera->dividY,10,GetMenuSprite(2));
  for(i=0;i<StrLen(a);i++)
  {
   GrChar(completeMenu,a[i],26+i*7,60,1);
  }
 
  //wepn
  Sprite3B(completeMenu,8,116,10,GetMenuSprite(2));
  Sprite3B(completeMenu,8,116+camera->dividY,10,GetMenuSprite(2));
  Sprite3B(completeMenu,8,116+2*camera->dividY,10,GetMenuSprite(2));
  Sprite3B(completeMenu,8,116+3*camera->dividY,10,GetMenuSprite(2));
  for(i=0;i<StrLen(b);i++)
  {
   GrChar(completeMenu,b[i],14+i*7,180,1);
  }
   
  //body
  Sprite3B(completeMenu,60,140,10,GetMenuSprite(2));
  Sprite3B(completeMenu,60+camera->dividX,140,10,GetMenuSprite(2));
  Sprite3B(completeMenu,60,140+camera->dividY,10,GetMenuSprite(2));
  Sprite3B(completeMenu,60+camera->dividX,140+camera->dividY,10,GetMenuSprite(2));
  Sprite3B(completeMenu,60,140+2*camera->dividY,10,GetMenuSprite(2));
  Sprite3B(completeMenu,60+camera->dividX,140+2*camera->dividY,10,GetMenuSprite(2));
 
  for(i=0;i<StrLen(c);i++)
  {
   GrChar(completeMenu,c[i],75+i*7,190,1);
  }
   
  //ring
  Sprite3B(completeMenu,106,35,10,GetMenuSprite(2));
  for(i=0;i<StrLen(d);i++)
  {
   GrChar(completeMenu,d[i],112+i*7,48,1);
  }
    

 Sprite3B(completeMenu,140,0,1,GetMenuSprite(3));//xbutton
    
 return completeMenu;   
  

}