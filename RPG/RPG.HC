
//
// Task Functions
U0 DrawIt(CTask *task, CDC *dc){
 I64 i,j,l,colis;//iterables
 U8 sprite;
 switch(mc->currentMenu){//main menu
  case 0:
   MainMenu(dc,task);
   break;
  //Main Game
  case 1:
   Actor *p = GetNPC(0);
   MapNode *puin = GetTensorItem(world->level,p->x,p->y,world->currentZ);
   //Keyboard
   HandleKeyboard(p,puin);
   StartCameraPan(dc,p);   
   //Draw world and one column and row extra for either side        
   ReDrawWorld(dc,i,j);
   CheckAnimQueue(dc);
   DrawActorsAndItems(dc,p,i,j,l);
   //Game Menus
   RPGSideBar(dc);
   if(mc->displayStats){
    GrBlot3(dc,12*camera->dividX-25,-4,0,RenderStats(p));
   }
   if(mc->displayEquipment){
    GrBlot3(dc,10,10,0,RenderEquipment(p));
   }
   RPGInvLogic(dc,p);
   DrawHealthMana(dc,p,i,j);
   //Dialog   
   if(mc->talkieScene!=-1){
    mc->displayInventory=FALSE;
    Chatbox(mc->dialogName,dc,task,mc->talkieScene,mc->loot);
   }
   //Combat
   else if(mc->combatON){
     HandleCombatLoop(task, dc);
   }
   ShowToolTips(dc);
  /*
   if(keys.esc==TRUE){
    dc->color=WHITE;      
    GrRect(gr.dc,0,0,480,100);//dev console
    GetChar;
   }
  */   
   break;
   //character select
   case 2:
  // SetCharMenuSprites();
   CharMenu(dc,task,A1D1,A2D1,A3D1,A4D1);   
   break;
   case 3:
   IntroCutscene(dc,task,mc->cutsceneTarget);
   break;
   case 4:
   LoadMenu(dc,task,loadRoot);
   break;
 }   
}

U0 CleanUp()
{
 DocClear;
 SettingsPop;
 DestroyTensor(world->level);
 Free(world);
 
 MenuPop;
 GetChar;
}

//
// Main
//

U0 RPGMain()
{
//Set Device context, iterables, peripheral arguments
CDC *dc=DCAlias; I64 arg1,arg2,msg_code,i,j;
//Default Window settings
SettingsPush;WinMax;WinBorder;
DocCursor;DocClear;MenuPush("");Init;
//Set Current Task Threads  
Fs->draw_it=&DrawIt;Fs->song_task=Spawn(&SongTask,mc,"Song",,Fs);
//Main Game Loop, set mouse context
while(TRUE){ 
 //Switch on Main Window Context
 camera->cursorX = ms.pos.x, camera->cursorY = ms.pos.y;
 switch(mc->currentMenu){    
  case 0://main menu
   if(MainMenuControls(arg1,arg2,msg_code))
    goto fs_end;
  break; 
  case 1://main game
     switch (GetMsg(&arg1,&arg2,
     1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN
     |1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) {
      case MSG_KEY_UP:
      case '\n':
       keys.pressed=0;
      break;
      case 0:
       switch(arg2.u8[0]){
	case SC_CURSOR_LEFT:
	case SC_CURSOR_RIGHT:
	case SC_CURSOR_DOWN:
	case SC_CURSOR_UP:
	 keys.pressed=0;
	break;
       }
      break;
      case MSG_KEY_DOWN:
      switch(arg1){
        case 'I':
        case 'i':
         if(mc->displayInventory){
          mc->displayInventory=FALSE;} 
         else{
          mc->displayInventory=TRUE;} 
         break;
        case 'W':
        case 'w': keys.pressed=DIR_UP;
        break;
        case 'A':
        case 'a': keys.pressed=DIR_LEFT;
        break;
        case 'S': 
        case 's': keys.pressed=DIR_DOWN;
        break;
        case 'D':
        case 'd': keys.pressed=DIR_RIGHT;
        break;
        case 'E':
        case 'e': 
         if(mc->displayEquipment){ 
          mc->displayEquipment=FALSE;
         }else{
          mc->displayEquipment=TRUE;}
        break;
        case 'C':
        case 'c':
        if(mc->displayStats){ 
          mc->displayStats=FALSE;}
         else{
          mc->displayStats=TRUE;}
         break;           
        case CH_ESC:
         keys.pressed=DIR_ESC; 
              break;
        case CH_SHIFT_ESC:
         goto fs_end;
        break;
        case '\n':
         keys.pressed=DIR_ENTER;
        break;
        case 0:
         switch(arg2.u8[0]){
          case SC_ENTER:
           keys.pressed=DIR_ENTER;
          break;
          case SC_CURSOR_LEFT:
           keys.pressed=DIR_LEFT;
          break;
          case SC_CURSOR_RIGHT:
           keys.pressed=DIR_RIGHT;
          break;
          case SC_CURSOR_UP:
           keys.pressed=DIR_UP;
          break;
          case SC_CURSOR_DOWN:
           keys.pressed=DIR_DOWN;
          break;
         }
        break;
      }
      break;
      case MSG_MS_L_DOWN:
       HandleMouse(camera->cursorX,camera->cursorY,i,j);
      break;
     }
   break;
  case 2://character creation
   switch (msg_code=GetMsg(&arg1,&arg2,
    1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) {
	      case MSG_MS_L_DOWN:
	        if(camera->cursorX>=386&&camera->cursorX<=429)
		  {
		  if(camera->cursorY>300&&camera->cursorY<336)
		    { //tribe
		    IncSelect(0);
		  } else if(camera->cursorY>348&&camera->cursorY<382)
		    {//hair
		    IncSelect(1);
		  } else if(camera->cursorY>400&&camera->cursorY<432)
		    {//face
		    IncSelect(2);
		  }
	        }
	        if(camera->cursorX>=476&&camera->cursorX<=603)
		  {
		  if(camera->cursorY>=370&&camera->cursorY<=434)
		    {//next scene
		    U8 tribe = GetSelectedStats(0);
		    U8 str,con,int,wis;
		    switch(tribe)
		      {
		      case 0:
		        str=10;con=10;int=10;wis=10;
		        break;
		      case 1:
		        str=5;con=5;int=15;wis=15;
		        break;
		      case 2:
		        str=5;con=15;int=5;wis=15;
		        break;
		      case 3:
		        str=15;con=15;int=5;wis=5;
		        break;
		    }
		    ResetCurrLetter;
		    mc->cutsceneTarget=0;
		    SetNPC(MakeActor(0,tribe,GetSelectedStats(1),GetSelectedStats(2), 
			  0,0,0,0,0,
			  0,0,0,0,
			  5,5,str,int,con,wis,0));
		    mc->currentMenu=1;
                    mc->currentSong=0;
		  }
	        }
	        break;
	    }
	    break;
	  case 3://cutscene
           
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        mc->cutsceneTarget++;
	        ResetCurrLetter;
	        if(mc->cutsceneTarget>2)
		  {
		  mc->currentMenu=2;
                  mc->currentSong=2;
	        }
	        break;
	    }

  break;
  case 4://load menu
   CDirEntry *cur;
   I64 yInc=0;
   switch (msg_code=GetMsg(&arg1,&arg2,
	  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
   {
    case MSG_MS_L_DOWN:
     if(camera->cursorX>=19&&camera->cursorX<=187&&camera->cursorY>=18&&
        camera->cursorY<=58)
     {
      mc->currentMenu=0;
     }
     for(cur=loadRoot;cur!=NULL;cur=cur->next)
     {
      if(camera->cursorX>=190&&camera->cursorX<=590&&
        camera->cursorY>=yInc&&camera->cursorY<=yInc+25)
      {
       U8* edit = cur->name;
       edit =MStrPrint("%s%s","Saves/",edit);                                                                         
       LoadGame(edit);
      }
      yInc+=40; 
      
     }
    break;
   }//switch
  break;  
 }//switch
 Refresh;
}  
fs_end:
 //DCFill;
 DCDel(dc);
 CleanUp;

}
  RPGMain;