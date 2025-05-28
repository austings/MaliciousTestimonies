
// Construct Graphics from WAD
#include "Data/Wad.HC";

// Load built-in Graphics
#include "Sprites/SS1.HC"; 
#include "Sprites/SpriteSheet2.HC";
#include "Sprites/SpriteSheet3.HC";
#include "Sprites/SpriteSheet4.HC";
// Loading Map
#include "Map/Map.HC";
#include "Map/Tensor3D.HC";
// Loading Data Into Map
#include "Map/Actors.HC";
#include "Map/Level.HC";

// Loading Player
#include "Globals.HC";
#include "Inventory.HC";
#include "Player.HC";

// Loading Narrative
#include "Dialog.HC";
#include "Menu.HC";
#include "Walk.HC";
#include "Anim.HC";
#include "Music.HC";
#include "Save.HC";

// Loading Combat Scenarios

#include "Attacks.HC";
#include "Combat.HC";
#include "Render.HC";

// Loading Skills
#include "Fishing.HC";
#include "Inputs.HC";

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
 mc->currentSong=1;
 mc->currentMenu=0;
 mc->cutsceneTarget=0;//switch cutscene frames
 mc->talkieScene = -1;//dialogID
 mc->dialogName = "???";//dialog actor name

 mc->displayInventory=FALSE;
 mc->displayStats=FALSE;
 mc->displayEquipment=FALSE;
 mc->reRenderInv=TRUE;
 mc->draggingInv=FALSE;
 mc->draggingItem=MakeItem(0);
 mc->draggingID=0;
 mc->lootedSwitch=LOOTABLE;
 mc->inventoryRender = DCNew(640,480);
 DCFill(mc->inventoryRender, TRANSPARENT);

 //camera;    
 camera->dividX = SCREENX/(11);
 camera->dividY = SCREENY/(11);
 camera->topLR=0; camera->topUD=0;
 camera->cameraOffSetX = 0,  
 camera->cameraOffSetY = 0; 
       
 //keys
 keys.pressed=0;
 //Level and NPCS

 SetTensorNPC(world->level,0,5,5,0);//player
 SMFT(world->level,MakeCastle(GetMatrixFromTensor(world->level,0)),0);//castle
 InitActors(0);

 ITEM1 = FramePtr("ITEM008");// dagger
 ITEM1I = FramePtr("WINV001");
 ITEM2 = FramePtr("ITEM004");// harpoon
 ITEM2I = FramePtr("WINV015");
 //Sprite3B(ITEM3I,0,0,10,GetFang);
 //ITEM4 = FramePtr("");
 ITEM4I = FramePtr("ITEM164");//fish
 SPECIAL1 = FramePtr("EFF075");//special point
 SPECIAL2 = FramePtr("EFF076");

 //combat
 mc->combatON = FALSE;
 mc->combatMenuStage =0;
 mc->combatMenuSelection=0;
 mc->target = GetNPC(0);
 mc->tarposx = 0;
 mc->tarposy = 0;

 InitializeAnimator;
}

#include "RPG";
