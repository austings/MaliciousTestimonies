
U0 KeyEnter(Actor *p, MapNode *puin)
{
 if(mc->displayDev)
 {DevKeyEnter(); }
 else if(MerchantList(mc->talkieScene)){
  switch(mc->combatMenuSelection){
   case CMS_MOVE://move
   //todo show tradewindow
    mc->talkieScene = IT_NULL;
    mc->lootedSwitch = TRUE;
    mc->lootInv = GetNPC(mc->dialogID)->myInv;
    break;
   case CMS_STRIKE://strike
    mc->talkieScene = IT_NULL; 
    break;
  }
 } else if(mc->combatON){
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
      I64 itemID = RetrieveItemID(p->myInv,mc->prayerToCast);
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

U0 KeyArrow(Actor *p,I64 dir){
 //corresponds to DIR left, right, up, down
 SetActorDir(p,DELIMITER);//in progress

 if(mc->talkieScene==IT_NULL){
  if(mc->combatON){
   CombatTurnArrows(p,dir);
  }else{
   MoveActor(p,dir);
  }
 } else if(MerchantList(mc->talkieScene)){
  switch(mc->combatMenuSelection){
   case CMS_MOVE:
    if(KeyPressed(&keyboard.up)){mc->combatMenuSelection=CMS_STRIKE;}
    else if(KeyPressed(&keyboard.down)){mc->combatMenuSelection++;}
  break;
  case CMS_STRIKE:
   if(KeyPressed(&keyboard.down)){
    mc->combatMenuSelection=CMS_MOVE;
   }
   else if(KeyPressed(&keyboard.up)){mc->combatMenuSelection--;}
  break;
  }
 }else{
  MoveActor(p,dir);
 }
} 


U0 KeyEsc()
{

}

U0 KeyShift(){
 mc->running = !mc->running;
}

U0 AnyKey(){
 Actor *player = GetPlayer(PLAYER);
 if(mc->combatMenuStage==STAGE_1){//enemy turn
  switch(mc->combatMenuSelection){
   case CMS_ENE1:
    if(mc->turnIndex>2){
     mc->combatMenuSelection = CMS_ENE2;//move complete
     if(HasStatus(ctp->ready,ATTK_STATUS)&&ctp->ready->id!=PLAYER){
      player->currentHealth-=(ctp->ready->str);
      AddStatus(ctp->ready,NRML_STATUS);
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
     GetPlayer()->currentHealth-=(ctp->ready->str);
     AddStatus(ctp->ready,NRML_STATUS);
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
  }else if(M_X>494&&M_X<549&&
           M_Y>=160&&M_Y<220){
   KeyShift;
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
   mc->lootedSwitch=FALSE;         
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

U0 HandleMouse(I64 M_X, I64 M_Y, I64 i, I64 j){ 
 //Begin SideBar
 HandleMouseSideBar(M_X,M_Y,i,j);
 //End SideBar

 Actor *player = GetPlayer;

 //Begin GameArea
 if(M_X>=0&&M_X<480&&
    M_Y>=0&&M_Y<480)
 {
  if(M_Y<480-(42*4)&&mc->draggingInv==TRUE)
  {  
   I64 wlvl= GetTensorWaterLevel(world->level,player->x,player->y,world->currentZ);     
   if(UseItem(wlvl))
    goto handlemend;
  }
  //Equip wep slot
  HandleMouseEquipRelease(M_X,M_Y,i,j);
  //check repository region
  if(mc->lootedSwitch){
   for(i=0;i<INVWIDTH;i++){
    for(j=0;j<INVHEIGHT;j++){
     if(M_X>=(i*43)+2   &&
       M_X< (i+1)*43+2 &&
       M_Y>=(j*42) &&
       M_Y< (j+1)*42&&!mc->prayerDragging){
      InvDrag(i,j,mc->lootInv,FALSE);
     }//end inventory if
    }//end inventory height
   }//end inventory width
  }//end lootedswitch

  if(mc->displayInventory==TRUE){  
   //check inventory region
   for(i=0;i<INVWIDTH;i++){
    for(j=0;j<INVHEIGHT;j++){
     if(M_X>=(i*43)+2   &&
       M_X< (i+1)*43+2 &&
       M_Y>=(j*42)+310 &&
       M_Y< (j+1)*42+310&&!mc->prayerDragging){
      InvDrag(i,j,player->myInv,TRUE);

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
 Inventory *me;
 Actor *player = GetPlayer;
 if(mc->displayInventory||mc->lootedSwitch){
 //check inventory region
  for(i=0;i<INVWIDTH;i++){
   for(j=0;j<INVHEIGHT;j++){
    Bool tipme = FALSE;
    if(mc->lootedSwitch&& camera->cursorX>=(i*43)+2    &&
       camera->cursorX< (i+1)*43+2&&
       camera->cursorY>=(j*42)  &&
       camera->cursorY< (j+1)*42){
     tipme = TRUE;
     me = mc->lootInv;
    }
    if(tipme||(camera->cursorX>=(i*43)+2    &&
       camera->cursorX< (i+1)*43+2&&
       camera->cursorY>=(j*42)+310  &&
       camera->cursorY< (j+1)*42+310)){
     if(!tipme)
      me = player->myInv;
     Item *item= RetrieveItem(me,me->mtrx[j][i].occupied);
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
     dc->color = LTGRAY;
     PrintLine(dc,MStrPrint("%d%s",item->value," Silver"),
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

