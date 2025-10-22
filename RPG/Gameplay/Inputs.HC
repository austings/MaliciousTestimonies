U0 PickUpItemTrigger(Actor *p, MapNode *puin)
{
 if(puin->len>0)
 {
  I64 pui = (PickUpItem(puin,0))->id;
  if(!AddItemToInventory(PLAYER,pui)){
   Play("ArE"); 
  } 
 }

}

U0 ObjectTrigger(Actor *p, MapNode *puin)
{
 I64 pui = puin->idObj;
 switch(pui)
 {
  case SP_FISHING_SPOT:
   if(p->sword==IT_HARPOON)
   {
    FishingHoleTrigger(p); Play("ArE");
   }
   else
   {
    mc->dialogName = "Missing Proper Weapon";
    mc->talkieScene = GetTalkie(SV_MISS_FISH_EQUIP);

   }
  break;
  case OBJ_POPPY:
   puin->idObj = OBJ_POPHV;
   AddItemToInventory(PLAYER,IT_BULB);
   //animate
   Play("ArE");
  break;
 } 
}

U0 KeyEnter(Actor *p, MapNode *puin)
{
 if(mc->displayDev)
 {DevKeyEnter(); }
 else if(mc->combatON){
  switch(mc->combatMenuSelection){
   case CMS_MOVE://move
    mc->combatMenuSelection =CS_MOVE; 
    break;
   case CMS_STRIKE://strike
    mc->combatMenuSelection =CS_STRIKE; 
    break;
   case CMS_PRAYER://prayer
    GatherSelections(); 
    mc->combatMenuSelection =CS_PRAYER;
    break;
   case CMS_FLEE://flee
    mc->combatMenuSelection =CS_FLEE; 
    break;
   case CS_MOVE://move completion
    mc->combatMenuSelection =CMS_MOVE_DONE;
    break;
   case CS_STRIKE://strike completion
    mc->combatMenuSelection=CMS_STRIKE_DONE;
    PlayStrikeAnim(p);
    break;
   case CS_PRAYER://select which prayer
    if(mc->prayerToCast!=DELIMITER)
    {
     if(mc->isItemSelector){
      mc->isItem=TRUE;
      I64 itemID = RetrieveItemID(p,mc->prayerToCast);
      RemoveItemLocID(mc->prayerToCast,TRUE);
      mc->prayerToCast = itemID; 

     }     
     mc->combatMenuSelection=CS_PRAYER2;
    }
    else{
     mc->combatMenuSelection=CMS_PRAYER;//go back
     mc->prayerListIndex = 0;
    }
   break;
   case CS_PRAYER2://select target (prayer completion)
    mc->combatMenuSelection=CMS_PRAYER_DONE;
    break;

  }//end switch
 }else{
  if(mc->displaySave)
  { mc->currentMenu=0;
    mc->currentSong=1;
    SaveFormReturn(p); 
  }
  if(puin->hasObj)
   ObjectTrigger(p,puin);
  PickUpItemTrigger(p,puin);
 }
}

U0 KeyArrow(Actor *p)
{ //corresponds to DIR left, right, up, down
 SetActorDir(p,DELIMITER);//in progress
 if(!mc->combatON){
  if(p->walking==W_NOTWALKING){
   MoveActor(p,keys.pressed);
  }
 }
 else{ 
  CombatTurnArrows(p);     
 } 
}

U0 KeyEsc()
{

}
U0 AnyKey()
{
 if(mc->combatMenuStage==STAGE_1)//enemy turn
 {
  switch(mc->combatMenuSelection)
  {
   case CMS_ENE1:
    if(mc->turnIndex>2){
     mc->combatMenuSelection = CMS_ENE2;//move complete
     if(HasStatus(ctp->ready,ATTK_STATUS)&&ctp->ready->id!=PLAYER){
      player->currentHealth-=(ctp->ready->str);
      RemoveStatus(ctp->ready);
     }
     mc->turnIndex=0;
    }
   break;
   case CMS_ENE2:
    if(mc->turnIndex>2){
     mc->combatMenuSelection = CMS_ENE3;
     mc->turnIndex=0;
    }
   break;
   case CMS_ENE3:
   break;
   default:
    mc->combatMenuSelection = CMS_ENE1;
   break;
  }
 }
}

U0 AutoTurnEnd()
{
 if(mc->combatMenuStage==STAGE_1)//enemy turn
 {
  switch(mc->combatMenuSelection)
  {
   case CMS_ENE1:
    mc->combatMenuSelection = CMS_ENE2;//move complete
    if(HasStatus(ctp->ready,ATTK_STATUS)&&ctp->ready->id!=PLAYER){
     player->currentHealth-=(ctp->ready->str);
     RemoveStatus(ctp->ready);
    }
    mc->turnIndex=0;
   break;
   case CMS_ENE2:
    mc->combatMenuSelection = CMS_ENE3;
    mc->turnIndex=0;
   break;
   case CMS_ENE3:
   break;
   default:
    mc->combatMenuSelection = CMS_ENE1;
   break;
  }
 }
}

U0 HandleKeyboard(Actor *p, MapNode *puin)
{
 if(keys.pressed){
  AnyKey;
 
  switch(keys.pressed)
  {
   case DIR_LEFT:
   case DIR_UP:
   case DIR_DOWN:
   case DIR_RIGHT:
    KeyArrow(p);
   break;
   case DIR_ENTER:
    KeyEnter(p,puin);
   break;
   case DIR_ESC:
   break;
   case DIR_DEV:
    if(mc->displayDev){
     mc->displayDev = FALSE;
    }else{
     mc->displayDev = TRUE;
    }
   break;
  }
  keys.pressed = 0;  

 }
}

U0 HandleMouseSideBar(I64 M_X, I64 M_Y, I64 i,I64 j){
 //SideBar
 Bool subMenu = mc->displayPrayers || mc->displayStats;
 if(!subMenu)
 { if(M_X>=496&&M_X<=549&& //equip button
          M_Y>=40&&M_Y<100
          &&mc->displayStats==FALSE){
   EquipButton; 
  }else if(M_X>=550&&M_X<=610&&//stats on
          M_Y>=40&&M_Y<100&&
          mc->displayStats==FALSE){
   mc->displayStats=TRUE;
  }else if(M_X>=496&&M_X<=549&& //inv button
          M_Y>=100&&M_Y<=160&&
          mc->displayStats==FALSE){
   InvButton;
  }else if(M_X>=550&&M_X<=603&& //pray button
          M_Y>=100&&M_Y<=160&&
          mc->displayPrayers==FALSE){
   PrayerButton;
  }else if(M_X>=494&&M_X<=549&&//music button
          M_Y>=220&&M_Y<=280&&
          mc->displayStats==FALSE){
   MusicButton;
  }else if(M_X>=550&&M_X<=610&&//fx button
          M_Y>=220&&M_Y<=280&&
          mc->displayStats==FALSE){
   FxButton;   
  }
 }else if(mc->displayPrayers) {
  PrayerFilters(M_X,M_Y,i,j); //prayer submenu
  
 }

 //pop up menu Xs
 if(M_X>=140&&M_X<=180&&//equip x
          M_Y>=10&&M_Y<=40
          &&mc->displayEquipment==TRUE){
   mc->displayEquipment=FALSE;
 }else if(M_X>=450&&M_X<=480&&//inv x
          M_Y>=290&&M_Y<=310
          &&mc->displayInventory==TRUE){
   mc->displayInventory=FALSE;          
 }

 //x button for submenus
 if(M_X>=580&&M_X<=641&&
          M_Y>=0&&M_Y<=40&&(mc->displayPrayers==TRUE||
          mc->displayStats==TRUE)){
   mc->displayStats=FALSE;  mc->displayPrayers=FALSE;
 }


 if(M_X>=496&&M_X<=619&& //save button
    M_Y>=421&&M_Y<=458){
   SaveButton;
 }

}

U0 HandleMouseEquipRelease(I64 M_X, I64 M_Y, I64 i, I64 j)
{
 if(mc->draggingInv){
  if(mc->displayEquipment==TRUE){
   if(M_X>=8 &&
      M_X< 60  &&
      M_Y>=116  &&
      M_Y< 116+(3*camera->dividY)){
    ReleaseSword;
   }
   if(M_X>=18 &&
      M_X< 102  &&
      M_Y>=44  &&
      M_Y< 127){
    ReleaseHelm;
   }
   if(M_X>=71 &&
      M_X< 154  &&
      M_Y>=159  &&
      M_Y< 284){
    ReleaseBody;
   }
   if(M_X>=117 &&
      M_X< 157  &&
      M_Y>=52  &&
      M_Y< 91){
    ReleaseRing;
   }
  }
 }
}

U0 HandleMouse(I64 M_X, I64 M_Y, I64 i, I64 j)
{ 
 //Begin SideBar
 HandleMouseSideBar(M_X,M_Y,i,j);
 //End SideBar

 //Begin GameArea
 if(M_X>=0&&M_X<480&&
    M_Y>=0&&M_Y<480)
 {
  if(M_Y<480-(42*4)&&mc->draggingInv==TRUE)
  {  
   I64 wlvl= GetTensorWaterLevel(world->level,player->x,player->y,world->currentZ);     
   if(FillItemIfOnWater(wlvl))
    goto handlemend;
  }
  //Equip wep slot
  HandleMouseEquipRelease(M_X,M_Y,i,j);
  //check repository region
  if(mc->lootedSwitch){
   for(i=0;i<INVWIDTH;i++){
    for(j=0;j<INVHEIGHT;j++){
     if(M_X>=(i*45)+2   &&
       M_X< (i+1)*45+2 &&
       M_Y>=(j*42) &&
       M_Y< (j+1)*42&&!mc->prayerDragging){
      InvDrag(i,j,mc->lootTarget);

     }//end inventory if
    }//end inventory height
   }//end inventory width
  }//end lootedswitch

  if(mc->displayInventory==TRUE){  
   //check inventory region
   for(i=0;i<INVWIDTH;i++){
    for(j=0;j<INVHEIGHT;j++){
     if(M_X>=(i*45)+2   &&
       M_X< (i+1)*45+2 &&
       M_Y>=(j*42)+310 &&
       M_Y< (j+1)*42+310&&!mc->prayerDragging){
      InvDrag(i,j,PLAYER);

     }//end inventory if
    }//end inventory height
   }//end inventory width     
  }//end invdisplay
 } //End game area
 handlemend:
}

U0 HandleRMouse(I64 M_X, I64 M_Y, I64 i, I64 j)
{
}
//possibily make global to prevent refetch
//U8 *tooltip
U0 ShowToolTips(CDC *dc = gr.dc)
{
 I64 i,j;
 if(mc->displayInventory){
 //check inventory region
  for(i=0;i<INVWIDTH;i++){
   for(j=0;j<INVHEIGHT;j++){
    if(camera->cursorX>=(i*45)+2    &&
       camera->cursorX< (i+1)*45+2&&
       camera->cursorY>=(j*42)+310  &&
       camera->cursorY< (j+1)*42+310){
     Item *item= RetrieveItem(PLAYER,
                  GetNPC(PLAYER)->myInv->mtrx[j][i].occupied);
     //TODOfix this defensive programming
     //inventory item not properly referenced/ old items removed
     if(!item || !item->name ||StrCmp(item->name,"Bag")==0){break;}                 
     dc->color = DKGRAY;
     I8 yinc = 0;
     if(item->v1!=NULL)
     {
      yinc =yinc+12;
      if(item->v2!=NULL)
      {
       yinc = yinc+12;
       if(item->v3!=NULL)
       {
         yinc = yinc+12;
       }
      }
     }
     dc->color = DKGRAY;
     GrRect3(dc,camera->cursorX+1,camera->cursorY+1,900,100,24+yinc);
     dc->color = LTBLUE;
     PrintLine(dc,item->name,camera->cursorX+2,camera->cursorY+2);
     dc->color = YELLOW;
     PrintLine(dc,MStrPrint("%d%s",item->value," Gold"),
                            camera->cursorX+2,camera->cursorY+12+2);
     dc->color = WHITE;
   
     if(item->v1!=NULL)
      PrintLine(dc,item->v1,camera->cursorX+2,camera->cursorY+24+2);
     if(item->v2!=NULL)
      PrintLine(dc,item->v2,camera->cursorX+2,camera->cursorY+36+2);
     if(item->v3!=NULL)
      PrintLine(dc,item->v3,camera->cursorX+2,camera->cursorY+48+2);
    
    }//end inventory if
   }//end inventory height
  }//end inventory width
 }

 if(mc->displayPrayers&&!mc->prayerDragging&&!mc->draggingInv)
 {//mc->dragPrayer is set in FindPrayer
  if(FindPrayer()){
   i = mc->dragPrayer;

   U8* name = prayers->list[i]->name;  
   U8* cost = MStrPrint("%s%d%s","Cost:",prayers->list[i]->cost," Spirit"); 
   //U8* desc = StrSplit(prayers->list[i]->desc,'#');  
   
   dc->color = DKGRAY;
   GrRect3(dc,camera->cursorX+1,camera->cursorY+1,900,100,32);
   switch(prayers->list[i]->type)
   {
    case TYPE_A:   dc->color = GREEN;break;
    case TYPE_M:   dc->color = YELLOW;break;
    case TYPE_W:   dc->color = RED;break;
    case TYPE_P:   dc->color = LTBLUE;break;
   }
   PrintLine(dc,name,camera->cursorX+2,camera->cursorY+2);
   dc->color = LTCYAN;
   PrintLine(dc,cost,camera->cursorX+2,camera->cursorY+12+2);
   //dc->color = WHITE;
   //PrintLine(dc,desc,camera->cursorX+2,camera->cursorY+24+2);
  }
 }
}
