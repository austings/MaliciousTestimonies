



I64 GetActorScreenX(Actor *a, I64 npcox, I64 i, Bool Player=TRUE)
{
 if(Player){
  if(camera->topLR==0||camera->topLR==wX-11)
   npcox =GetWalkOffsetX(a->walking);
  a->screenX = i*camera->dividX-13+
                          npcox+camera->cameraOffSetX;
  return a->screenX;
 }else
 {
   npcox=GetWalkOffsetX(a->walking), 
   a->screenX = i*camera->dividX-13+npcox+(2*camera->cameraOffSetX);
  return a->screenX;
 }
}

I64 GetActorScreenY(Actor *a, I64 npcoy, I64 j,Bool Player=TRUE)
{
 if(Player){
  if(camera->topUD==0||camera->topUD==wY-11)
   npcoy =GetWalkOffsetY(a->walking);
  a->screenY = j*camera->dividY-42+
                          npcoy+camera->cameraOffSetY;
  return a->screenY;
 }else
 {
  npcoy=GetWalkOffsetY(a->walking);
  a->screenY = j*camera->dividY-42+npcoy+camera->cameraOffSetY;
  return a->screenY;
 }
}



U0 StartCameraPan(CDC *dc,Actor *p)
{
 // background world x pan
 if(camera->topLR==0||camera->topLR==wX-11){
  if(camera->cameraOffSetX!=0){
   if(camera->cameraOffSetX>0){
    camera->cameraOffSetX=Max(0,camera->cameraOffSetX-1);
   }
   else{
    camera->cameraOffSetX=Min(0,camera->cameraOffSetX+1); 
   }
  }
 }
 else{
  camera->cameraOffSetX=-GetWalkOffsetX(p->walking);
 }
 //y pan
 if(camera->topUD==0||camera->topUD==wY-11){
  if(camera->cameraOffSetY!=0){
   if(camera->cameraOffSetY>0)
    camera->cameraOffSetY=Max(0,camera->cameraOffSetY-1);
   else
    camera->cameraOffSetY=Min(0,camera->cameraOffSetY+1);
  }
 }
 else{
  camera->cameraOffSetY=-GetWalkOffsetY(p->walking);
 }
}

U0 CombatQueInit(Actor *toInsert){ //parameter encounter file
  mc->combatON=TRUE;
  mc->lootedSwitch=FALSE;
  mc->combatMenuStage=STAGE_0;
  mc->combatMenuSelection=CMS_MOVE;
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
  mc->combatQueId = PLAYER;

  AddDirective(BOUNCE,toInsert);
 
}


U0 RenderCharacter(CDC *dc,I64 iFinalX, I64 iFinalY,I64 iFinalZ,
           CDC *character,Bool highlight=FALSE)
{

    if(highlight){
       HighlightTarget(dc, iFinalX, iFinalY+24,iFinalZ+10);
    }
    GrBlot3(dc,iFinalX,iFinalY,iFinalZ,character);

}
