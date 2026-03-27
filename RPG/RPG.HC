
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
   Actor *p = GetPlayer;
   MapNode *pin = GetTensorItem(world->level,
                    p->x,p->y,world->currentZ);

   
   world->timer = world->timer + FRAMERULE;
   if(world->timer>=FRAMERULE_CAP)
   {
    WorldTick(i,j,p);
    world->timer = 0;
    world->gameTicks++;
   }
   
   //Draw world and extra for preload on either side        
   ReDrawWorld(dc,i,j);
   DrawActorsAndItems(dc,p,i,j,l); 

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
 InputBeginFrame; // copy is_down -> was_down
 switch(mc->currentMenu){    
  case 0://main menu
   if(MainMenuControls(arg1,arg2,msg_code))
    goto fs_end;
  break; 
  case 1://main game
   U8 input = GetMsg(&arg1,&arg2,
      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN
      |1<<MSG_MS_L_UP|1<<MSG_MS_MOVE|1<<MSG_KEY_UP);

    if(world->gameTicks>10&&!mc->controlLock){
     switch (input) {
     case MSG_KEY_UP:
      if(arg1 != 0) {
       HandleCharKeyUp(arg1);
      }else{
       HandleScanKeyUp(arg2.u8[0]);
      }
     break;
     case MSG_KEY_DOWN:
      if(arg1!=0){
       HandleCharKeyDown(arg1);
      }else{
       HandleScanKeyDown(arg2.u8[0]);
      }
     break;
     case MSG_MS_L_DOWN:
      HandleMouse(camera->cursorX,camera->cursorY,i,j);
     break;
     case MSG_MS_R_DOWN:
      HandleRMouse(camera->cursorX,camera->cursorY,i,j);
     break;
     }
    }
   break;
  case 2://character creation
   switch (msg_code=GetMsg(&arg1,&arg2,
           1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) {
    case MSG_MS_L_DOWN:
     CharacterCreator();
    break;
   }
  break;
  case 3://cutscene        
   switch (msg_code=GetMsg(&arg1,&arg2,
          1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
   {
    case MSG_MS_L_DOWN:
     ProgressCutscene();
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