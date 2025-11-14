
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
   Actor *p = GetPlayer(PLAYER);
   MapNode *pin = GetTensorItem(world->level,
                    p->x,p->y,world->currentZ);

   
   world->timer = world->timer + FRAMERULE;
   if(world->timer>=FRAMERULE_CAP)
   {
    WorldTick(i,j,p);
    world->timer = 0;

   }
   
   //Draw world and extra for preload on either side        
   ReDrawWorld(dc,i,j);
   DrawActorsAndItems(dc,p,i,j,l); // former leak

   DrawRoofs(dc,p,i,j);
  
   //Keyboard
   HandleKeyboard(p,pin);
   StartCameraPan(dc,p);   
   //Game Menus
   
   RPGSideBar(dc);
   RenderMenus(dc,p);
   RPGInvLogic(i,j,dc,p);
   DragPrayer(dc);
   DrawHealthMana(dc,p,i,j);
   
   //Dialog   
   if(mc->talkieScene!=IT_NULL){
    mc->displayInventory=FALSE;
    Chatbox(mc->dialogName,dc,task,mc->talkieScene);
   }
   //Combat
   else if(mc->combatON){
     CombatDialogs(task, dc,p);
   }
   ShowToolTips(dc);

   
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
   U8 input = GetMsg(&arg1,&arg2,
      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN
      |1<<MSG_MS_L_UP|1<<MSG_MS_MOVE);
    switch (input) {
     case MSG_KEY_UP:
      switch(arg1){
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
      }
     break;
     case MSG_KEY_DOWN:
      if(mc->displayDev&&arg1>65&&arg1<126&&arg1!=96){//within char range and not dev key
       AddDevChar(arg1);}else if(mc->displaySave&&arg1>65&&arg1<126){
       ModifySaveBuffer(arg1);}else {
      switch(arg1){
        case 'I':
        case 'i':
         InvButton();
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
        case '~':
        case '`':
         keys.pressed=DIR_DEV;
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
          case SC_SHIFT:
           keys.pressed = DIR_SHIFT; 
          break;
         }
        break;
      }
      }
      break;
      case MSG_MS_L_DOWN:
       HandleMouse(camera->cursorX,camera->cursorY,i,j);
      break;
      case MSG_MS_R_DOWN:
       HandleRMouse(camera->cursorX,camera->cursorY,i,j);
      break;

     }
   break;
  case 2://character creation
   switch (msg_code=GetMsg(&arg1,&arg2,
           1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) {
    case MSG_MS_L_DOWN:
     if(camera->cursorX>=386&&
        camera->cursorX<=429) {
      if(camera->cursorY>300
         &&camera->cursorY<336){ //tribe
       IncSelect(0);
      } else if(camera->cursorY>348&&
                camera->cursorY<382) {//hair
       IncSelect(1);
      } else if(camera->cursorY>400&&
                camera->cursorY<432){//face
	IncSelect(2);
      }
     }
     if(camera->cursorX>=476&&
        camera->cursorX<=603&&
        camera->cursorY>=370&&
        camera->cursorY<=434){//next scene
      U8 tribe = GetSelectedStats(0);
      U8 str,con,int,wis;
      switch(tribe){
       case T_JUDA:
        str=10;con=10;int=10;wis=10;
       break;
       case T_LEVI:
        str=5;con=5;int=15;wis=15;
       break;
       case T_EPHR:
        str=5;con=15;int=5;wis=15;
       break;
       case T_BENJ:
        str=15;con=15;int=5;wis=5;
       break;
      }
      ResetCurrLetter;
      mc->cutsceneTarget=0;
      FreeActor(GetPlayer);
      QueIns(MakeActor(0,tribe,GetSelectedStats(1),GetSelectedStats(2), 
                       0,0,0,0,
                       5,5,
		       str,int,con,wis,0),actors->last);
      mc->currentMenu=1;
      mc->currentSong=0;
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