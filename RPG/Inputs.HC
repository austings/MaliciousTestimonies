U0 PickUpItemTrigger(Actor *p, MapNode *puin)
{
 if(puin->len>0)
 {
  I64 pui = (PickUpItem(puin,0))->id;
  mc->reRenderInv=TRUE;
  if(pui==SP_FISHING_SPOT)
  {
   if(p->sword==IT_HARPOON)
   {
    FishingHoleTrigger(p); Play("ArE");
   }
   else
   {
    mc->dialogName = "Missing Proper Weapon";
    mc->talkieScene = GetTalkie(SV_MISS_FISH_EQUIP);

   }
  }else if(!AddItemToInventory(PLAYER,pui)){
   Play("ArE"); 
  }
 }

}

U0 KeyEnter(Actor *p, MapNode *puin)
{
 if(mc->combatON){
  switch(mc->combatMenuSelection){
   case CMS_MOVE://move
    mc->combatMenuSelection =CMS_MOVE_DONE; 
    break;
   case CMS_STRIKE://strike
    mc->combatMenuSelection =CS_STRIKE; 
    break;
   case CMS_PRAYER://prayer
    mc->combatMenuSelection =CS_PRAYER; 
    break;
   case CMS_FLEE://flee
    mc->combatMenuSelection =CS_FLEE; 
    break;
   case CMS_MOVE_DONE://move completion
    mc->combatMenuStage=CS_MOVE;
    break;
   case CS_STRIKE://strike completion
    mc->combatMenuSelection=CMS_STRIKE_DONE;
    PlayStrikeAnim(p);
    break;
  }//end switch
 }else
 {
  PickUpItemTrigger(p,puin);
 }
}

U0 KeyArrow(Actor *p)
{ //corresponds to DIR left, right, up, down
 if(!mc->combatON){
  MoveActor(p,keys.pressed);
 }
 else{ 
  switch(mc->combatMenuStage){
   case CMS_MOVE:
    CombatTurnArrows(p);     
   break; 
 }
 } 
}

U0 KeyEsc()
{

}

U0 HandleKeyboard(Actor *p, MapNode *puin)
{
 if(keys.pressed){
 
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
  }
  keys.pressed = 0;  

 }
}


U0 HandleMouse(I64 M_X, I64 M_Y, I64 i, I64 j)
{
 if(M_X>=496&&M_X<=619&& //save button
    M_Y>=421&&M_Y<=458){
   SaveButton;
 }else if(M_X>=496&&M_X<=549&& //equip button
          M_Y>=40&&M_Y<100
          &&mc->displayStats==FALSE){
   EquipButton; 
 }else if(M_X>=140&&M_X<=180&&//equip x
          M_Y>=10&&M_Y<=40
          &&mc->displayEquipment==TRUE){
   mc->displayEquipment=FALSE;
 }else if(M_X>=450&&M_X<=480&&//inv x
          M_Y>=290&&M_Y<=310
          &&mc->displayInventory==TRUE){
   mc->displayInventory=FALSE;          
 }else if(M_X>=550&&M_X<=610&&//stats on
          M_Y>=40&&M_Y<100&&
          mc->displayStats==FALSE){
   mc->displayStats=TRUE;
 }else if(M_X>=580&&M_X<=641&&//stats x
          M_Y>=0&&M_Y<=40&&
          mc->displayStats==TRUE){
   mc->displayStats=FALSE;
 }else if(M_X>=496&&M_X<=549&& //inv button
          M_Y>=100&&M_Y<=160&&
          mc->displayStats==FALSE){
   InvButton;
 }else if(mc->displayInventory==TRUE||
           mc->displayEquipment==TRUE){
  //if release on equip wep slot
  if(mc->displayEquipment==TRUE&&mc->draggingInv){
   if(M_X>=8 &&
      M_X< 60  &&
      M_Y>=116  &&
      M_Y< 116+(3*camera->dividY)){
    ReleaseSword;
   }
  }
  //check inventory region
  for(i=0;i<INVWIDTH;i++){
   for(j=0;j<INVHEIGHT;j++){
    if(M_X>=(i*45)+2   &&
       M_X< (i+1)*45+2 &&
       M_Y>=(j*42)+310 &&
       M_Y< (j+1)*42+310){
     InvDrag(i,j);

    }//end inventory if
   }//end inventory height
  }//end inventory width
      
 }else if(M_X>=494&&M_X<=549&&//music 
          M_Y>=220&&M_Y<=280&&
          mc->displayStats==FALSE){
  MusicButton;
 }else if(M_X>=550&&M_X<=610&&//fx
          M_Y>=220&&M_Y<=280&&
          mc->displayStats==FALSE){
  FxButton;   
 }
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
     Item *item= RetrieveItem(0,GetNPC(0)->myInv->mtrx[j][i].occupied);
     if(StrCmp(item->name,"Bag")==0){break;}                 
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
     dc->color = RED;
   
     if(item->v1!=NULL)
      PrintLine(dc,item->v1,camera->cursorX+2,camera->cursorY+24+2);
     if(item->v2!=NULL)
      PrintLine(dc,item->v2,camera->cursorX+2,camera->cursorY+36+2);
     if(item->v3!=NULL)
      PrintLine(dc,item->v3,camera->cursorX+2,camera->cursorY+48+2);
    
    }//end inventory if
   }//end inventory height
  }//end inventory width
 }
      
  
}
