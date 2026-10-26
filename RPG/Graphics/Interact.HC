U0 PickUpItemTrigger(Actor *p, MapNode *puin)
{
 if(puin->len>0){
  I64 pui = (PickUpItem(puin,0))->id;
  if(!AddItemToInventory(p->myInv,pui)){
   I64 i=0;
   //Play("ArE"); 
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
    FishingHoleTrigger(p); 
   }
   else
   {
    mc->dialogName = "Missing Proper Weapon";
    mc->talkieScene = GetTalkie(SV_MISS_FISH_EQUIP);

   }
  break;
  case OBJ_POPPY:
   puin->idObj = OBJ_POPHV;
   AddItemToInventory(p->myInv,IT_BULB);
   //animate
  break;
 } 
}

//InteractCorpse
//param npc- the npc id of the corpse
U0 InteractCorpse(I64 npc){

 Actor *player = GetPlayer;
 if(mc->lootedSwitch==LOOTED){ //already looted
 }
 else{
  if(mc->lootedSwitch==LOOTABLE){
   //mc->loot = "..........";
   switch(npc){
    case 6://wolf fang
        AddItemToInventory(player->myInv,3);
        break;
        default:
        break;
   }
   mc->lootedSwitch=LOOTING;
  }
 }

}

//InteractActor
//param npc- the npc id of the actor player is interacting with
U0 InteractActor(I64 npc){
 Actor *aAtLoc= GetNPC(npc);
 if(aAtLoc->ai_script==AI_ENEMY&&!HasStatus(aAtLoc, LIFE_DEAD)) {//combat
  mc->combatON=TRUE;
 }
 else{
  mc->dialogName = aAtLoc->name;
  mc->dialogID = npc;  
  if(HasStatus(aAtLoc, LIFE_DEAD)){
   InteractCorpse(npc);
  }
  else
  {
   mc->talkieScene = GetTalkie(npc);
  }
 }
}

U0 InteractChest(I64 inv){
 mc->lootedSwitch = TRUE;
 mc->lootInv =  GrabChest(inv);
}

Bool TransitionTerritory(Actor *p, U8 dir, I64 edgeX, I64 edgeY,
                         I64 walkingSubFrameKey, I64 walkingFrameKey)
{
 I64 tangent;

 if (dir == DIR_LEFT || dir == DIR_RIGHT)
    tangent = edgeY;
 else
    tangent = edgeX;
 // A boundary opens the strategic travel selector. Keep the single active
 // local map resident until a valid destination is explicitly confirmed.
 world->selectedTerritory=-1;
 world->travelPending=TRUE;
 world->travelOffset=tangent;
 world->mapLoadFailed=FALSE;
 world->strategicEnterHandled=FALSE;
 p->walking=DIR_IDLE;
 p->walkingSubFrame=0;
 p->hasPath=FALSE;
 p->pathLen=0;
 p->pathIndex=0;
 SetActorDir(p,dir);
 mc->displayWorld=TRUE;
 return FALSE;
}

//Returns if Moved this turn
Bool InteractTile(Actor *p, U8 dir,
                I64 xOff=0, I64 yOff=0, 
                I64 walkingSubFrameKey,
                I64 walkingFrameKey){
 p->walkingSubFrame=walkingSubFrameKey;

 I64 iactX = p->x+xOff;
 I64 iactY = p->y+yOff;

 // Crossing an edge is a successful movement only when a linked region
 // exists and its entry tile is available.
 if(iactX<0 || iactX>=wX || iactY<0 || iactY>=wY)
  return TransitionTerritory(p,dir,iactX,iactY,
                             walkingSubFrameKey,walkingFrameKey);

 if(iactX>=WEST_MAX&&iactX<wX&&
    iactY>=NORTH_MAX&&iactY<wY){
  I64 npc = GetTensorNPC(world->level,iactX,iactY,world->currentZ);
  I64 obj = GetTensorObj(world->level,iactX,iactY,world->currentZ);

  if(obj!=IT_NULL){
   switch(obj){
    case OBJ_CHEST:
     I64 inv = GetTensorInv(world->level,iactX,iactY,world->currentZ);
     InteractChest(inv);
    break;
    case OBJ_TABLE:
    case OBJ_STALL:
     PickUpItemTrigger(p,GetTensorNode(world->level,iactX,iactY,world->currentZ));
    break;
   }
  }   
  // Keep collision reliable for leafy terrain even if a map-building path
  // only assigned its visual tile code and did not preserve the solid flag.
  Bool blocked=CheckSolid(world->level,iactX,iactY,world->currentZ);
  I64 bg=GetTensor(world->level,iactX,iactY,world->currentZ);
  if(bg==BG_BUSH_WALL || bg==BG_ROCK_WALL || bg==BG_DK_GRAY)
   blocked=TRUE;
  if(!blocked||mc->clip){
   if(npc!=IT_NULL){
    if(p->id==mc->localPlayerId){
     InteractActor(npc);
    }    
   }else{
   //clear any dialog 
   ClearDialog;
   //check for loot
   if(mc->lootedSwitch==LOOTING){
    mc->lootedSwitch=LOOTED;}

 
   Bool camMoved = FALSE;

   if(camera->topLR!=0 && p->x<wX-5 && dir==DIR_LEFT){
    camera->topLR--;
    camMoved = TRUE;
   }
   if(camera->topLR!=wX-11 && p->x>=5 && dir==DIR_RIGHT){
    camera->topLR++;
    camMoved = TRUE;
   }
   if(camera->topUD!=0 && p->y<wY-5 && dir==DIR_UP){
    camera->topUD--;
    camMoved = TRUE;
   }
   if(camera->topUD!=wY-11 && p->y>=5 && dir==DIR_DOWN){
    camera->topUD++;
    camMoved = TRUE;
   }

   camera->cameraMovedThisStep = camMoved;
   //reset subframes   
   p->walking=walkingFrameKey;
   p->walkingSubFrame=0;
   //update model
   I64 newX = p->x + xOff;
   I64 newY = p->y + yOff;
   RemoveTensorNPC(world->level, p->x, p->y, world->currentZ);
   SetTensorNPC(world->level, p->id, newX, newY, world->currentZ);
   UpdateActorCoords(p->id, newX, newY);
   if(mc->running&&p->currentMana>0)
    RemoveMana(p,1);
   }
   return TRUE;
  }
 }
 return FALSE; 
}

#define leftXOff -1
#define leftSubFrame 3
#define leftFrame    1

#define rightXOff 1
#define rightSubFrame 2
#define rightFrame    2

#define upYOff   -1
#define upSubFrame 1
#define upFrame    3

#define downYOff 1
#define downSubFrame 0
#define downFrame    4

//actors with anim
//use move actor on the new dir to move
Bool MoveActor(Actor *p, U8 dir){
 if(p->currentHealth>0){
 switch(dir){
  case DIR_LEFT://left
   return InteractTile(p,dir,leftXOff,0,
                leftSubFrame,leftFrame);
  break;
  case DIR_RIGHT://right
    return InteractTile(p,dir,rightXOff,0,
                rightSubFrame,rightFrame);
  break;
  case DIR_UP://up
    return InteractTile(p,dir,0,upYOff,
                upSubFrame,upFrame);
  break;
  case DIR_DOWN://down
   return InteractTile(p,dir,0,downYOff,
                downSubFrame,downFrame);
  break;
 }}
 return FALSE;
}
