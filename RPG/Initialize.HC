Cd(__DIR__);;

// Constructing Graphics from WAD
#include "Data/Wad.HC";
#include "Data/Frames.HC";
#include "Data/Ids.HC";

// Loading Map
#include "Map/Map.HC";
#include "Map/Tensor3D.HC";
// Loading Graphics
#include "Sprites/SS1.HC"; 
#include "Sprites/SpriteSheet1.HC";
#include "Sprites/SpriteSheet2.HC";
#include "Sprites/SpriteSheet3.HC";
#include "Sprites/SpriteSheet4.HC";

// Loading Game Data
#include "Gameplay/Item.HC";
#include "Map/Actors.HC";
#include "Gameplay/Markov/Markov.HC";
#include "Map/Director.HC";
#include "Map/Level.HC";
#include "Globals.HC";
#include "Gameplay/AI.HC";

// Loading Workflows
#include "Dev/Dev.HC";
#include "Gameplay/InvLogic.HC";
#include "Dev/Deserialize.HC";
#include "Gameplay/TurnOrder.HC";
#include "Data/GUI.HC";

// Loading World
#include "Gameplay/Equipment.HC";
#include "Map/Objects.HC";
#include "Graphics/Dialog.HC";
#include "Gameplay/Player.HC";
#include "Gameplay/Save.HC";
#include "Online/Handshake.HC";

// Loading Animations
#include "Graphics/Walk.HC";
#include "Graphics/Anim.HC";
#include "Graphics/Armor.HC";
#include "Graphics/Buttons.HC";
#include "Graphics/Menu.HC";
#include "Graphics/Sidebar.HC";
#include "Graphics/Drag.HC";
#include "Gameplay/Fishing.HC";
#include "Graphics/Interact.HC";
#include "Music.HC";

//Loading Routing
#include "Gameplay/Target.HC";
#include "Graphics/Attacks.HC";
#include "Graphics/Prayers.HC";
#include "Gameplay/Combat.HC";
#include "Graphics/Render.HC";
#include "Graphics/Weather.HC";
#include "Graphics/Draw.HC";

// Handle Keys
#include "Gameplay/Inputs.HC";
#include "Dev/Keyboard.HC";

// Finalize World
#include "Map/World.HC";

// Multiplayer
#include "Online/Headers.HC";
#include "Online/Remote.HC";
#include "Online/Polling.HC";
#include "Online/Client.HC";
#include "Online/Server.HC";
#include "Online/Glowie_Artifact.HC";
#include "Online/Multiplayer.HC";

U0 InitMenuControl()
{
 I64 i;
 InitSprites;
 //narrative
 mc->currentSong=1;
 mc->currentMenu=0;
 mc->cutsceneTarget=0;//switch cutscene frames
 mc->cutsceneTimer =0;
 mc->cutsceneIndex=0;
 mc->talkieScene = IT_NULL;//dialogID
 mc->dialogName = "???";//dialog actor name
 mc->dialogID = 0;
 mc->controlLock =FALSE;

 //display
 mc->displayInventory=FALSE;
 mc->displayStats=FALSE;
 mc->displayWorld=FALSE;
 mc->displayShop=FALSE;
 mc->displayEquipment=FALSE;
 mc->displayPrayers=FALSE;
 mc->displayDev=FALSE;
 mc->displaySave=FALSE;
 mc->tickWeather=0;
 mc->screenXL=0;
 mc->screenYL=0;
 mc->smoothScreenX = 0;
 mc->smoothScreenY = 0;
 mc->clip=FALSE;
 mc->dialogSelection=0;

 //prayers
 mc->prayerPage=0;
 mc->dragPrayer=-1;
 mc->prayerToCast=DELIMITER;
 mc->isItem = FALSE;
 mc->isItemSelector = FALSE;
 mc->prayerListSize =0;
 mc->prayerList =MAlloc(sizeof(I64));
 mc->prayerListIndex =0;
 mc->prayerDragging=FALSE;

 //inventory
 mc->draggingInv=FALSE;
 mc->dragInvIsPlayer=TRUE;
 mc->draggingItem=MakeItem(0);
 mc->draggingID=0;

 //chest
 mc->lootedSwitch=FALSE;
 mc->lootInv=NULL;// player->myInv;
 ObjQueInit;

 //combat
 mc->combatON = FALSE;
 mc->combatMenuStage =STAGE_0;
 mc->combatMenuSelection=CMS_MOVE;
 mc->mouseTargetingActive=FALSE;
 mc->targetCTPIndex = 0;
 mc->running =  FALSE;
 mc->strikeApproach = FALSE;

 //network
 mc->netMode = NET_SINGLEPLAYER;
 mc->hostInitialized = FALSE;
 mc->clientInitialized = FALSE;
 mc->localPlayerId = PLAYER;
 mc->nextClientId = -1;
 for(i=0;i<MAX_PLAYERS;i++)
  mc->clients[i] = NULL;
}

U0 InitHotKeys()
{
 I64 a;
 for(a=0;a<NUM_HOTKEYS;a++) {
  hotkeys[a] = -1;               
 }
}

U0 InitCamera()
{
 //camera;    
 camera->dividX = SCREENX/(11);
 camera->dividY = SCREENY/(11);
 camera->topLR=0; camera->topUD=0;
 camera->cameraOffSetX = 0,  
 camera->cameraOffSetY = 0;
 camera->cameraMovedThisStep = FALSE; 

}
U0 InitKeyboard()
{
 keyboard.up.isDown=FALSE;
 keyboard.down.isDown=FALSE;
 keyboard.left.isDown=FALSE;
 keyboard.right.isDown=FALSE;
 keyboard.inv.isDown=FALSE;
 keyboard.equipment.isDown=FALSE;
 keyboard.stats.isDown=FALSE;
 keyboard.developer.isDown=FALSE;
 keyboard.esc.isDown=FALSE;
 keyboard.enter.isDown=FALSE;
 keyboard.shift.isDown=FALSE;

}

Territory *MakeTerritory(I64 id, I64 mapId, U8 *name,
                         U8 *settlement, I64 owner,
                         I64 width=100, I64 height=100)
{
 Territory *t = CAlloc(sizeof(Territory));
 t->id=id;
 t->localMapId=mapId;
 t->name=name;
 t->settlement=settlement;
 t->ownerFaction=owner;
 t->width=width;
 t->height=height;
 t->north=t->south=t->east=t->west=-1;
 return t;
}

Tensor3D *CreateLocalMap(I64 localMapId, I64 width, I64 height)
{
 Vector *shape=CreateVector(3);
 Tensor3D *level;
 Matrix *ground;
 I64 x,y,roadY=height/2;
 if(localMapId<1 || localMapId>9 || width<11 || height<11)
  return NULL;
 SetVector(shape,width,0);
 SetVector(shape,height,1);
 SetVector(shape,1,2);
 level=CreateTensor(shape);
 ground=GetMatrixFromTensor(level,0);
 for(y=0;y<height;y++)
  for(x=0;x<width;x++)
   SetMatrix(ground,BG_GREEN,x,y);

 // The original starting map is assigned to Samaria (local map ID 2).
 // Keep its authored castle, routes, actors, and items as the start region.
 if(localMapId==2){
  SMFT(level,MakeCastle(ground),0);
  return level;
 }

 // Other regional maps are lightweight authored prototypes with a road and
 // settlement landmark; each is built only when that local region is loaded.
 for(x=8;x<width-8;x++)
  SetMatrix(ground,BG_LT_GRAY,x,roadY);
 SetMatrixObj(ground,OBJ_TENT,width/2,roadY);
 return level;
}

U0 SaveLocalMapState(Territory *territory, Tensor3D *level)
{
 I64 x,y,k,cellCount,bytes;
 U8 *fileName;
 TerritorySnapshotHeader *header;
 TerritorySnapshotCell *cells,*cell;
 MapNode *node;
 NodeStuff *item;
 cellCount=territory->width*territory->height;
 bytes=sizeof(TerritorySnapshotHeader)+
       cellCount*sizeof(TerritorySnapshotCell);
 U8 *snapshot=CAlloc(bytes);
 header=(TerritorySnapshotHeader *)snapshot;
 header->magic=TERRITORY_SNAPSHOT_MAGIC;
 header->width=territory->width;
 header->height=territory->height;
 cells=(TerritorySnapshotCell *)(snapshot+sizeof(TerritorySnapshotHeader));
 for(y=0;y<territory->height;y++){
  for(x=0;x<territory->width;x++){
   cell=&cells[y*territory->width+x];
   node=GetTensorNode(level,x,y,world->currentZ);
   cell->bg=node->bg;
   cell->isSolid=node->isSolid;
   cell->hasNPC=node->hasNPC && node->idNPC!=mc->localPlayerId;
   cell->hasObj=node->hasObj;
   if (cell->hasNPC)
    cell->idNPC = node->idNPC;
   else
    cell->idNPC = IT_NULL;
   cell->idObj=node->idObj;
   cell->idInv=node->idInv;
   cell->waterLvl=node->waterLvl;
   item=node->items->next;
   while(item!=node->items &&
         cell->itemCount<TERRITORY_SNAPSHOT_ITEMS){
    cell->items[cell->itemCount++]=item->id;
    item=item->next;
   }
  }
 }
 fileName=MStrPrint("%s/territory_%d.bin",DirCur,territory->id);
 FileWrite(fileName,snapshot,bytes);
 territory->mapStateSaved=TRUE;
 Free(fileName);
 Free(snapshot);
}

Bool LoadLocalMapState(Territory *territory, Tensor3D *level)
{
 I64 x,y,i;
 U8 *fileName,*snapshot;
 TerritorySnapshotHeader *header;
 TerritorySnapshotCell *cells,*cell;
 MapNode *node;
 if(!territory->mapStateSaved) return FALSE;
 fileName=MStrPrint("%s/territory_%d.bin",DirCur,territory->id);
 snapshot=FileRead(fileName);
 Free(fileName);
 if(!snapshot) return FALSE;
 header=(TerritorySnapshotHeader *)snapshot;
 if(header->magic!=TERRITORY_SNAPSHOT_MAGIC ||
    header->width!=territory->width ||
    header->height!=territory->height){
  Free(snapshot);
  territory->mapStateSaved=FALSE;
  return FALSE;
 }
 cells=(TerritorySnapshotCell *)(snapshot+sizeof(TerritorySnapshotHeader));
 for(y=0;y<territory->height;y++){
  for(x=0;x<territory->width;x++){
   cell=&cells[y*territory->width+x];
   node=GetTensorNode(level,x,y,world->currentZ);
   node->bg=cell->bg;
   node->isSolid=cell->isSolid;
   node->hasNPC=cell->hasNPC;
   node->hasObj=cell->hasObj;
   node->idNPC=cell->idNPC;
   node->idObj=cell->idObj;
   node->idInv=cell->idInv;
   node->waterLvl=cell->waterLvl;
   while(node->len>0) ClearItem(node,0);
   for(i=0;i<cell->itemCount && i<TERRITORY_SNAPSHOT_ITEMS;i++)
    AddItem(node,cell->items[i]);
  }
 }
 Free(snapshot);
 return TRUE;
}

U0 ConnectTerritories(I64 from, I64 direction, I64 to)
{
 Territory *a=world->territories[from];
 Territory *b=world->territories[to];
 I64 i,reverseDirection;
 if(direction==DIR_UP){a->north=to;b->south=from;}
 else if(direction==DIR_DOWN){a->south=to;b->north=from;}
 else if(direction==DIR_LEFT){a->west=to;b->east=from;}
 else if(direction==DIR_RIGHT){a->east=to;b->west=from;}

 if(direction==DIR_UP) reverseDirection=DIR_DOWN;
 else if(direction==DIR_DOWN) reverseDirection=DIR_UP;
 else if(direction==DIR_LEFT) reverseDirection=DIR_RIGHT;
 else reverseDirection=DIR_LEFT;
 for(i=0;i<a->neighborCount;i++)
  if(a->neighborIds[i]==to) goto addReverseNeighbor;
 if(a->neighborCount<8){
  a->neighborIds[a->neighborCount]=to;
  a->neighborDirections[a->neighborCount]=direction;
  a->neighborCount++;
 }
 addReverseNeighbor:
 for(i=0;i<b->neighborCount;i++)
  if(b->neighborIds[i]==from) return;
 if(b->neighborCount<8){
  b->neighborIds[b->neighborCount]=from;
  b->neighborDirections[b->neighborCount]=reverseDirection;
  b->neighborCount++;
 }
}

U0 InitTerritories()
{
 world->territoryCount=9;
 world->currentTerritory=0; // Start in the northern Kingdom of Israel.
 world->selectedTerritory=-1;
 world->mapPanX=100;
 world->mapPanY=70;
 world->travelPending=FALSE;
 world->mapLoadFailed=FALSE;
 world->strategicEnterHandled=FALSE;
 world->territories[0]=MakeTerritory(0,2,"Israel","Samaria",FACTION_ISRAEL);
 world->territories[1]=MakeTerritory(1,1,"Judah","Jerusalem",FACTION_JUDAH);
 world->territories[2]=MakeTerritory(2,3,"Philistia","Gaza",FACTION_PHILISTIA);
 world->territories[3]=MakeTerritory(3,7,"Edom","Bozrah",FACTION_EDOM);
 world->territories[4]=MakeTerritory(4,4,"Phoenicia","Tyre",FACTION_PHOENICIA);
 world->territories[5]=MakeTerritory(5,5,"Galilee","Hazor",FACTION_ISRAEL);
 world->territories[6]=MakeTerritory(6,6,"Aram","Damascus",FACTION_ARAM);
 world->territories[7]=MakeTerritory(7,8,"Ammon","Rabbath-Ammon",FACTION_AMMON);
 world->territories[8]=MakeTerritory(8,9,"Moab","Dibon",FACTION_MOAB);

 ConnectTerritories(0,DIR_UP,5);    // Samaria - Galilee
 ConnectTerritories(0,DIR_DOWN,1);  // Samaria - Judah
 ConnectTerritories(0,DIR_LEFT,2);  // Samaria - Philistia
 ConnectTerritories(0,DIR_RIGHT,7); // Samaria - Ammon
 ConnectTerritories(5,DIR_UP,4);    // Galilee - Phoenicia
 ConnectTerritories(5,DIR_RIGHT,6);// Galilee - Aram-Damascus
 ConnectTerritories(1,DIR_RIGHT,8);// Judah - Moab
 ConnectTerritories(1,DIR_LEFT,2); // Judah - Philistia
 ConnectTerritories(1,DIR_DOWN,3);// Judah - Edom
 ConnectTerritories(7,DIR_UP,6);// Ammon - Aram
 ConnectTerritories(8,DIR_DOWN,3);// Moab - Edom

 Territory *start=world->territories[world->currentTerritory];
 world->level=CreateLocalMap(start->localMapId,start->width,start->height);
 if(world->level)
  LoadLocalMapState(start,world->level);
}

Bool SetTerritoryOwner(I64 territoryId, I64 factionId)
{
 if(territoryId<0 || territoryId>=world->territoryCount)
  return FALSE;
 if(factionId<FACTION_ISRAEL || factionId>FACTION_EDOM)
  return FALSE;
 world->territories[territoryId]->ownerFaction=factionId;
 return TRUE;
}

I64 TerritoryDirectionTo(I64 fromId, I64 toId)
{
 I64 i;
 if(fromId<0 || fromId>=world->territoryCount ||
    toId<0 || toId>=world->territoryCount)
  return 0;
 Territory *from=world->territories[fromId];
 for(i=0;i<from->neighborCount;i++)
  if(from->neighborIds[i]==toId)
   return from->neighborDirections[i];
 return 0;
}

Bool FindTerritoryEntry(Tensor3D *level, I64 direction,
                        I64 width, I64 height, I64 offset,
                        I64 *entryX, I64 *entryY)
{
 I64 i,depth,depthLimit,limit,tryX,tryY,delta;
 if(direction==DIR_LEFT || direction==DIR_RIGHT){
  limit=height;
  depthLimit=Min(9,width);
  offset=Min(Max(offset,0),height-1);
  for(depth=0;depth<depthLimit;depth++){
   for(i=0;i<limit;i++){
    delta=(i+1)/2;
    if(!(i&1)) delta=-delta;
    if(direction==DIR_RIGHT)
     tryX=depth;
    else
     tryX=width-1-depth;
    tryY=offset+delta;
    if(tryY>=0 && tryY<height &&
       !CheckSolid(level,tryX,tryY,world->currentZ) &&
       GetTensorNPC(level,tryX,tryY,world->currentZ)==IT_NULL){
     *entryX=tryX; *entryY=tryY; return TRUE;
    }
   }
  }
 }else{
  limit=width;
  depthLimit=Min(9,height);
  offset=Min(Max(offset,0),width-1);
  for(depth=0;depth<depthLimit;depth++){
   for(i=0;i<limit;i++){
    delta=(i+1)/2;
    if(!(i&1)) delta=-delta;
    tryX=offset+delta;
    if(direction==DIR_DOWN)
     tryY=depth;
    else
     tryY=height-1-depth;
    if(tryX>=0 && tryX<width &&
       !CheckSolid(level,tryX,tryY,world->currentZ) &&
       GetTensorNPC(level,tryX,tryY,world->currentZ)==IT_NULL){
     *entryX=tryX; *entryY=tryY; return TRUE;
    }
   }
  }
 }
 return FALSE;
}

Bool TravelToTerritory(Actor *p, I64 destinationId)
{
 I64 sourceId,direction;
 I64 entryX,entryY,offsett;
 Territory *source,*destination;
 Tensor3D *nextLevel;
 if(!p || destinationId<0 || destinationId>=world->territoryCount ||
    world->currentTerritory<0 ||
    world->currentTerritory>=world->territoryCount){
  world->mapLoadFailed=TRUE;
  return FALSE;
 }
 sourceId=world->currentTerritory;
 direction=TerritoryDirectionTo(sourceId,destinationId);
 if(!direction){
  world->mapLoadFailed=TRUE;
  return FALSE;
 }
 source=world->territories[sourceId];
 destination=world->territories[destinationId];
 if(!source || !destination || destination->localMapId<1 ||
    destination->localMapId>9 || destination->width<11 ||
    destination->height<11){
  world->mapLoadFailed=TRUE;
  return FALSE;
 }
 if (world->travelPending)
    offsett = world->travelOffset;
 else if (direction == DIR_LEFT || direction == DIR_RIGHT)
    offsett = destination->height / 2;
 else
    offsett = destination->width / 2;
 // The source tensor is destroyed before allocating the destination tensor.
 SaveLocalMapState(source,world->level);
 nextLevel=world->level;
 world->level=NULL;
 DestroyTensor(nextLevel);
 nextLevel=CreateLocalMap(destination->localMapId,
                          destination->width,destination->height);
 if(nextLevel)
  LoadLocalMapState(destination,nextLevel);
 if(!nextLevel || !FindTerritoryEntry(nextLevel,direction,
       destination->width,destination->height,offsett,&entryX,&entryY)){
  if(nextLevel) DestroyTensor(nextLevel);
  world->level=CreateLocalMap(source->localMapId,source->width,source->height);
  if(world->level){
   LoadLocalMapState(source,world->level);
   SetTensorNPC(world->level,p->id,p->x,p->y,world->currentZ);
  }
  world->mapLoadFailed=TRUE;
  return FALSE;
 }

 world->level=nextLevel;
 world->currentTerritory=destinationId;
 wX=destination->width;
 wY=destination->height;
 SetTensorNPC(world->level,p->id,entryX,entryY,world->currentZ);
 UpdateActorCoords(p->id,entryX,entryY);
 p->hasPath=FALSE;
 p->pathLen=0;
 p->pathIndex=0;
 p->walking=DIR_IDLE;
 p->walkingSubFrame=DIR_IDLE;
 SetActorDir(p,DIR_DOWN);
 camera->topLR=Min(Max(entryX-5,0),wX-11);
 camera->topUD=Min(Max(entryY-5,0),wY-11);
 camera->cameraOffSetX=0;
 camera->cameraOffSetY=0;
 camera->cameraMovedThisStep=FALSE;
 mc->smoothScreenX=0;
 mc->smoothScreenY=0;
 ClearDialog;
 world->travelPending=FALSE;
 world->selectedTerritory=-1;
 world->mapLoadFailed=FALSE;
 mc->displayWorld=FALSE;
 return TRUE;
}

Bool IsStrategicTravelKey(I64 ch,I64 scan)
{
 if(ch=='\n' || ch=='\r' || scan==SC_ENTER)
  return TRUE;
 return FALSE;
}

U0 HandleStrategicMapEnter(Actor *p)
{
 if(!mc->displayWorld || !keyboard.enter.isDown)
  return;
 if(world->strategicEnterHandled)
  return;
 world->strategicEnterHandled=TRUE;
 if(world->selectedTerritory<0){
  world->mapLoadFailed=TRUE;
  return;
 }
 TravelToTerritory(p,world->selectedTerritory);
}

U0 ProcessGameplayKeyDown(I64 ch,I64 scan)
{
 if(mc->displayWorld && IsStrategicTravelKey(ch,scan)){
  SetKey(&keyboard.enter,TRUE);
  HandleStrategicMapEnter(GetPlayer());
  return;
 }
 if(ch)
  HandleCharKeyDown(ch);
 else
  HandleScanKeyDown(scan);
 if(mc->displayWorld)
  SetKey(&keyboard.enter,FALSE);
 else if(ch=='\n' || ch=='\r' || scan==SC_ENTER)
  SetKey(&keyboard.enter,TRUE);
}

U0 ProcessGameplayKeyUp(I64 ch,I64 scan)
{
 if(mc->displayWorld && IsStrategicTravelKey(ch,scan)){
  SetKey(&keyboard.enter,FALSE);
  world->strategicEnterHandled=FALSE;
  return;
 }
 if(ch)
  HandleCharKeyUp(ch);
 else
  HandleScanKeyUp(scan);
 if(ch=='\n' || ch=='\r' || scan==SC_ENTER){
  SetKey(&keyboard.enter,FALSE);
  world->strategicEnterHandled=FALSE;
 }
}

U0 Init(){ //world
 world = CAlloc(sizeof(World));
 mc = CAlloc(sizeof(MenuControl));
 camera= CAlloc(sizeof(Camera));
 worldSz = CreateVector(3);
 wX = 100; wY = 100; wZ = 1;
 SetVector(worldSz,wX,0);
 SetVector(worldSz,wY,1);
 SetVector(worldSz,wZ,2);
 world->timer = 0;
 world->gameTicks=0; 
 InitActors(0);
 InitMenuControl;
 InitCamera;       
 InitHotKeys;
 InitDev;
 InitKeyboard;
 //prayers
 InitializePrayers;

 //World regions and player
 InitTerritories;
 SetTensorNPC(world->level,0,3,2,0);//player



 InitializeAnimator;
}

U0 FreeEverything(){

}

#include "RPG";
