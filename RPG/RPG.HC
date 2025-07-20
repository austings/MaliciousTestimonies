
//updates the matrix model based on taken actions
U0 WorldTick(I64 i, I64 j, Actor *p)
{
 //Tick Combat
 switch(mc->combatMenuStage){
  case STAGE_0:
   switch(mc->combatMenuSelection){
    case CMS_MOVE_DONE:
     mc->turnIndex++;
     if(mc->turnIndex>1){
        mc->turnIndex=1;
        mc->combatMenuStage=STAGE_1;
      }
    break;
    case CMS_STRIKE_DONE:
     switch(p->sword){
      case IT_FIST:
      default: //fist
       mc->turnIndex++;
       if(mc->turnIndex>3){
        RemoveHealth(mc->target,p->str);
        mc->turnIndex=1;
        mc->combatMenuStage=STAGE_1;
       }//mc turnindex
      break;
     }//switch p sword    break;
    case CMS_PRAYER_DONE:
     switch(mc->prayerToCast){
      case SP_HEAL: //lay on hands
       if(mc->turnIndex==1) { CastPrayer(p);}
       mc->turnIndex++;
       if(mc->turnIndex>3){
        AddHealth(mc->target,p->int);
        RemoveMana(p,prayers->list[mc->prayerToCast]->cost);
        mc->turnIndex=1;
        mc->combatMenuStage=STAGE_1;
       }
      break;
     }//switch prayer
    break;
    case CS_FLEE:
     mc->turnIndex++;
     if(mc->turnIndex>3){
      U16 r = RandU16();
      mc->turnIndex=1;

      // 80% chance-returns a number from 0 to 65535 (inclusive).
      // 80% of 65536 = 52428.8, so comparing like this
      if (r < 0.8 * 65536){
       CombatQueFree();
       mc->combatON=FALSE;
       mc->combatMenuStage=STAGE_2;
 
      } 
      else{
       mc->turnIndex=1;
       mc->combatMenuStage=STAGE_1;
      }
     }
    break;
   }
  break;
  case STAGE_1:
   switch(mc->combatMenuSelection){
    case CMS_ENE1:
    default:
     mc->turnIndex++;
     if(mc->turnIndex>3){
      SetActorDir(p,DELIMITER);//modified dir complete
      mc->turnIndex= 2;   
      ctp = combatCQue.next;//reset que pointers
      ctp = ctp->next;//now pointer is to the first creature in the que
      if(ctp->ready->status1!=DEAD_STATUS){
       mc->combatON=TRUE;
      }//move it randomly}
      else{
       player->exp+=(ctp->ready->str+ ctp->ready->con+ 
                  ctp->ready->int+ ctp->ready->wis);
       if(player->exp>=player->maxExp){
        Play("3wC#D#E#F#G#");
        LvlUp(player);
       }
       CombatQueFree();
       mc->combatON=FALSE;
      }
      mc->combatMenuStage=STAGE_2;
     }
    break;
    //case CMS_ENE2:
    //case CMS_ENE3:
    //default:
    // mc->combatMenuStage=STAGE_2;//go to stage 2, creature's turn 
    //break;  
   }
  break;
  case STAGE_2:
   mc->combatMenuStage=STAGE_0;
   mc->combatMenuSelection=CMS_MOVE;      

      //return que pointer to player
   if(mc->turnIndex==QueCnt(combatCQue))
   {
    //ctp = ctp->next;
    ctp = combatCQue.next;
    mc->turnIndex = 1;
   }

  break;
 }

 //Tick World
 for(j=-1;j<12;j++){
  if(camera->topUD+j<wX&&camera->topUD+j>=0){
   I64 screenY = j*camera->dividY+camera->cameraOffSetY; 
   for(i=-1;i<12;i++){
    if(camera->topLR+i<wY&&camera->topLR+i>=0){
     I64 screenX = i*camera->dividX+camera->cameraOffSetX;

     I64 obj= GetTensorObj(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
     I64 npc =GetTensorNPC(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);
     I64 wlvl= GetTensorWaterLevel(world->level,
               camera->topLR+i,camera->topUD+j,world->currentZ);     
     if(npc!=-1)
     {
      Actor *toUpdate = GetNPC(npc);
  
      
     if(npc!=PLAYER){
      if(mc->combatON==FALSE   && 
       toUpdate->ai_script==AI_DEFAULT&&
       toUpdate->status1!=DEAD_STATUS && //(enemy)
       Abs((p->x)-(toUpdate->x))<=AGGRO_DIS&& //(aggro distance)
       Abs((p->y)-(toUpdate->y))<=AGGRO_DIS  )
      {
       CombatQueInit(toUpdate);

      } else if(mc->combatON==FALSE &&
            HasDirective(BOUNCE,toUpdate))
      {
       I64 npcOffsetX=-camera->cameraOffSetX; 
       I64 npcOffsetY=-camera->cameraOffSetY;

       UpdateDirective(BOUNCE,toUpdate,    
        GetActorScreenX(toUpdate,npcOffsetX,toUpdate->x,FALSE),
        GetActorScreenY(toUpdate,npcOffsetY,toUpdate->y,FALSE),0,TRUE);
 
      }
     }

     }
    }
   }
  }
 }
 player = p;
}

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
   Actor *p = GetNPC(PLAYER);
   MapNode *pin = GetTensorItem(world->level,
                    p->x,p->y,world->currentZ);


   world->timer = world->timer + FRAMERULE;
   if(world->timer>=FRAMERULE_CAP)
   {
    WorldTick(i,j,p);
    world->timer = 0;
   }

   //Keyboard
   HandleKeyboard(p,pin);
   StartCameraPan(dc,p);   
   //Draw world and one column and row extra for either side        
   ReDrawWorld(dc,i,j);
   DrawActorsAndItems(dc,p,i,j,l);
   //Game Menus
   RPGSideBar(dc);
   if(mc->displayStats){
    GrBlot3(dc,12*camera->dividX-25,-4,0,RenderStats(p));
   } else if(mc->displayPrayers){
    GrBlot3(dc,12*camera->dividX-25,-4,0,RenderPrayers(p));
   }

   if(mc->displayEquipment){
    GrBlot3(dc,10,10,0,RenderEquipment(p));
   }
   RPGInvLogic(dc,p);
   DragPrayer(dc);
   DrawHealthMana(dc,player,i,j);
   //Dialog   
   if(mc->talkieScene!=-1){
    mc->displayInventory=FALSE;
    Chatbox(mc->dialogName,dc,task,mc->talkieScene,mc->loot);
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
      SetNPC(MakeActor(0,tribe,GetSelectedStats(1),GetSelectedStats(2), 
                       0,0,0,0,
                       5,5,
		       str,int,con,wis,0));
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