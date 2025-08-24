Cd(__DIR__);;
// Construct Graphics from WAD
#include "Data/Wad.HC";
#include "Data/Frames.HC";
#include "Data/Ids.HC";
// Loading Map
#include "Map/Map.HC";
#include "Map/Tensor3D.HC";
// Load built-in Graphics
#include "Sprites/SS1.HC"; 
#include "Sprites/SpriteSheet1.HC";
#include "Sprites/SpriteSheet2.HC";
#include "Sprites/SpriteSheet3.HC";
#include "Sprites/SpriteSheet4.HC";
// Loading Data Into Map
#include "Map/Actors.HC";
#include "Gameplay/Markov/Markov.HC";
#include "Map/Director.HC";
#include "Map/Level.HC";

//Pathfinding
#include "Gameplay/AI.HC";
// Loading Player
#include "Globals.HC";
#include "Gameplay/Item.HC";
#include "Map/Objects.HC";
#include "Gameplay/Player.HC";
#include "Gameplay/Equipment.HC";
#include "Gameplay/Save.HC";

// Loading Narrative
#include "Graphics/Dialog.HC";
#include "Graphics/Buttons.HC";
#include "Graphics/Menu.HC";
#include "Graphics/Sidebar.HC";
#include "Graphics/Drag.HC";
#include "Graphics/Walk.HC";
#include "Graphics/Anim.HC";
#include "Graphics/Interact.HC";
#include "Music.HC";

// Loading Combat Scenarios
#include "Graphics/Attacks.HC";
#include "Graphics/Prayers.HC";
#include "Gameplay/Combat.HC";
//Console
#include "Dev/Dev.HC";
#include "Graphics/Render.HC";
#include "Graphics/Draw.HC";

// Loading Skills
#include "Gameplay/Fishing.HC";
#include "Gameplay/Inputs.HC";
// Controller
#include "Map/World.HC";

U0 InitMenuControl()
{

 InitSprites;
 //narrative
 mc->currentSong=1;
 mc->currentMenu=0;
 mc->cutsceneTarget=0;//switch cutscene frames
 mc->cutsceneTimer =0;
 mc->cutsceneIndex=0;
 mc->talkieScene = -1;//dialogID
 mc->dialogName = "???";//dialog actor name

 //display
 mc->displayInventory=FALSE;
 mc->displayStats=FALSE;
 mc->displayShop=FALSE;
 mc->displayEquipment=FALSE;
 mc->displayPrayers=FALSE;
 mc->displayDev=FALSE;

 //prayers
 mc->prayerPage=0;
 mc->dragPrayer=-1;
 mc->prayerToCast=-1;
 mc->prayerListSize =0;
 mc->prayerListIndex =0;
 mc->prayerDragging=FALSE;

 //inventory
 mc->reRenderInv=TRUE;
 mc->draggingInv=FALSE;
 mc->draggingItem=MakeItem(0);
 mc->draggingID=0;
 mc->inventoryRender = DCNew(640,480);
 DCFill(mc->inventoryRender, TRANSPARENT);

 //chest
 mc->lootedSwitch=FALSE;
 mc->lootTarget=PLAYER;
 ObjQueInit;

 //combat
 mc->combatON = FALSE;
 mc->combatMenuStage =STAGE_0;
 mc->combatMenuSelection=CMS_MOVE;
 mc->combatQueId=PLAYER;
 mc->target = GetNPC(0);
 mc->tarposx = 0;
 mc->tarposy = 0;


}

U0 InitHotKeys()
{
 I64 a;
 for(a=0;a<9;a++) {
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
 world->level = CreateTensor(worldSz);
 world->timer = 0; 
 InitMenuControl;
 InitCamera;       
 InitHotKeys;
 InitDev;
 //prayers
 InitializePrayers;

 //keys
 keys.pressed=0;
 //Level and NPCS

 SetTensorNPC(world->level,0,5,5,0);//player
 SMFT(world->level,MakeCastle(GetMatrixFromTensor(world->level,0)),0);//castle
 InitActors(0);



 InitializeAnimator;
}
#include "RPG";
