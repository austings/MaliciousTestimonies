

static CDC *loadedAttackFrame= FramePtr("WINV013");

I64 CalculateAngle(I64 x1 , I64 y1 , I64 x2 ,I64 y2)
{
  I64 dx = x2 -x1;
  I64 dy = y2-y1;
  if(dx ==0 && dy > 0){
    return 180;}
  else if( dx >0 &&dy ==0){
    return 90;}
  else if(dx == 0 && dy < 0){
   return 0;}
  else if(dx <0 && dy == 0){
   return 270;}
  else{ 
  return 90;}
}

U0 PunchMove(CDC *screen,Actor *tar,I64 sX,I64 sY, I64 theta)
{

 DCDepthBufRst(loadedAttackFrame);
 loadedAttackFrame->z=GR_Z_ALL;
 Mat4x4IdentEqu(loadedAttackFrame->r);
 Mat4x4RotX(loadedAttackFrame->r,theta+180);
 GrBlot3(screen,sX,sY,10, loadedAttackFrame);

 //hp bar
 //CDC *newFill = DCNew(100,100);
 //GrRect(newFill,0,0,((tar->currentHealth)/tar->health)*100,20);
 //GrBlot3(screen,sX,sY,10,newFill);
 
}


U0 CombatQueInit(Actor *toInsert){ //parameter encounter file?
  mc->combatON=TRUE;
  mc->loot = "";
  mc->lootedSwitch=FALSE;
  mc->combatMenuStage=CMS_MOVE;
  mc->currentSong=5;
  QueInit(&combatCQue);
  
  CombatTurn *ctn;
  // Limit for one
  ctn = CAlloc(sizeof(CombatTurn));
  ctn->ready = GetNPC(PLAYER); 
  //AddDirective(T1READY,ctn->ready);
  QueIns(ctn,combatCQue.last);

  ctn = CAlloc(sizeof(CombatTurn));
  ctn->ready = toInsert; 
  QueIns(ctn,combatCQue.last);
  //combatCQue
  
  ctp = combatCQue.next;
  mc->turnIndex = 1;

  AddDirective(BOUNCE,toInsert);
 
}

U0 RenderCombatVersion(Actor *toRender){
 //COMBATCYCLEENEMIES
 if(mc->combatON==TRUE){
  if(mc->combatMenuStage==STAGE_1)
    //stage 1 is the end of player's turn
  {
   mc->combatMenuStage=STAGE_2;//go to stage 2, creature's turn 
   mc->turnIndex= 2;   
   ctp = combatCQue.next;//reset que pointers
   ctp = ctp->next;//now pointer is to the first creature in the que
   if(ctp->ready->dead==FALSE){
    mc->combatON=TRUE;
   }//move it randomly}
   else{
    player->exp+=(ctp->ready->str+ ctp->ready->con+ 
                  ctp->ready->int+ ctp->ready->wis);
    if(player->exp>=player->maxExp){
     Play("3wC#D#E#F#G#");
     LvlUp(player);
    }
    mc->combatON=FALSE;
    mc->currentSong=0;
   }
  }
  //attack
  if(mc->combatMenuStage==STAGE_2) {
   //reset back to stage 0, start of player's turn
   mc->combatMenuStage=STAGE_0;
   mc->combatMenuSelection=CMS_MOVE;      

      //return que pointer to player
   if(mc->turnIndex==QueCnt(combatCQue))
   {
    //ctp = ctp->next;
    ctp = combatCQue.next;
    mc->turnIndex = 1;
   }
  }
 }
}

Bool CheckTarget(Actor *toRender){
 //optionally highlight targets for strikes
 Bool highlight= FALSE;
 if((mc->combatMenuSelection==CS_STRIKE||
     mc->combatMenuSelection==CS_PRAYER2)&&
    toRender->id==ctp->ready->id)
 {
  highlight = TRUE;
  mc->target = toRender;
  mc->tarposx = toRender->screenX;
  mc->tarposy = toRender->screenY;//change default target
 }

 return highlight;
}

//called after combatMenuSelection==11
U0 HighlightTarget(CDC *dc, I64 hX, I64 hY,I64 hZ)
{
 dc->color=RED;
 dc->thick=3;
    //GrRect3(dc,hX+25,hY+45,0,50,50);
 GrCircle3(dc,hX+25,hY+45,0,15);
    //GrFloodFill(dc,hX+13,hY+13,TRUE);   
 dc->thick = 1;   
}

U0 PlayStrikeAnim(Actor *p)
{
 AddDirective(T1PUNCH,p); 
}
