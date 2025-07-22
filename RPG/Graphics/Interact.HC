
U0 InteractActor(I64 npc)
{
 Actor *aAtLoc= GetNPC(npc);
 if(aAtLoc->ai_script==1&&aAtLoc->status1!=DEAD_STATUS) {//combat
  mc->combatON=TRUE;
 }
 else{
  mc->dialogName = aAtLoc->name;  
  if(aAtLoc->status1==DEAD_STATUS){
    if(mc->lootedSwitch==LOOTED){ //already looted
     //mc->talkieScene = GetTalkie(13);//empty corpse message
    }
    else{
     if(mc->lootedSwitch==LOOTABLE){
      mc->loot = "..........";
      switch(npc){
        case 6://wolf fang
        mc->loot = "wolf fang";
        AddItemToInventory(PLAYER,3);
        break;
        default:
        break;
      }
      mc->lootedSwitch=LOOTING;
     }
     //mc->talkieScene = 12;  
    }
  }
  else
  {
   mc->talkieScene = GetTalkie(npc);
  }
 }
}

U0 InteractChest()
{

}

U0 InteractTile(Actor *p, U8 dir,
                I64 xOff=0, I64 yOff=0, 
                I64 walkingSubFrameKey,
                I64 walkingFrameKey)
{
 p->walkingSubFrame=walkingSubFrameKey;

 if(p->x+xOff!=WEST_MAX&& p->x+xOff!=wX&&
    p->y+yOff!=NORTH_MAX&&p->y+yOff!=wY){

  I64 npc = GetTensorNPC(world->level,p->x+xOff,p->y+yOff,world->currentZ);
  I64 obj = GetTensorObj(world->level,p->x+xOff,p->y+yOff,world->currentZ);

  if(obj!=IT_NULL){
   switch(obj)
   {
    case OBJ_CHEST:
     mc->lootedSwitch = TRUE;
    break;
   }
  }   
  if(!CheckSolid(world->level,p->x+xOff,p->y+yOff,world->currentZ)){

   if(npc!=IT_NULL){
    if(p->id==PLAYER){
     InteractActor(npc);
    }    
   }else{
   //clear any dialog 
   mc->talkieScene = IT_NULL;
   ClearDialog;
   //check for loot
   if(mc->lootedSwitch==LOOTING){
    mc->lootedSwitch=LOOTED;}

   //camera bounding
   if(camera->topLR!=0&&p->x<wX-5&&dir==DIR_LEFT)
    camera->topLR--;
   if(camera->topLR!=wX-11&&p->x>=5&&dir==DIR_RIGHT)
    camera->topLR++;
   if(camera->topUD!=0&&p->y<wY-5&&dir==DIR_UP)
    camera->topUD--;
   if(camera->topUD!=wY-11&&p->y>=5&&dir==DIR_DOWN)
    camera->topUD++;
 

   //reset subframes   
   p->walking=walkingFrameKey;
   p->walkingSubFrame=0;

   //update model
   RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
   SetTensorNPC(world->level,0,p->x+xOff,p->y+yOff,world->currentZ);
   UpdateActorCoords(0,p->x+xOff,p->y+yOff); 
   }
  }
 } 
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
U0 MoveActor(Actor *p, U8 dir){
 //begin walk from idle
 if(p->walking==DIR_IDLE){
  
  switch(dir){
  case DIR_LEFT://left
   InteractTile(p,dir,leftXOff,0,
                leftSubFrame,leftFrame);
  break;
  case DIR_RIGHT://right
   InteractTile(p,dir,rightXOff,0,
                rightSubFrame,rightFrame);
  break;
  case DIR_UP://up
   InteractTile(p,dir,0,upYOff,
                upSubFrame,upFrame);
  break;
  case DIR_DOWN://down
   InteractTile(p,dir,0,downYOff,
                downSubFrame,downFrame);
  break;
  }
 }//if not walking
 //}//else

}
