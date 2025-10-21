//
//Current Directory
//

CDirEntry *loadRoot;

//serialize options
#define OPT_MC_FX_OFF   0
#define OPT_MC_FX_ON    1
#define OPT_MC_MUS_OFF  2
#define OPT_MC_MUS_ON   3

#define SCREENX 480
#define SCREENY 480
#define SIDEX 160
#define SIDEY 480

#define MAX_WRITTEN_ACTORS 999999
#define MAXACTORCOUNT	11 //on screen

//Loaded Map
class World
{
 I64 currentZ;
 Tensor3D *level;
 I64 timer;
};

//Keyboard configuration
class Keys
{
 I64 pressed;
} keys;

#define NUM_HOTKEYS 9
I64 hotkeys[NUM_HOTKEYS] ;

//
// Cached Combat queue
//
class CombatTurn:CQue
{
  Actor *ready;
} combatCQue;

#define AGGRO_DIS	2
#define MOVEMENT_COST		5

//looting constants for 
//looting previous corpse check
#define LOOTED		0
#define LOOTING		1
#define LOOTABLE	2


//combat menu stage
#define STAGE_0                 0
#define STAGE_1                 1
#define STAGE_2                 2
#define STAGE_3                 3


//combat Menu Selection

#define CMS_MOVE		0
#define CS_MOVE			10
#define CMS_MOVE_DONE		100

#define CMS_STRIKE		1
#define CS_STRIKE		11
#define CMS_STRIKE_DONE		111

#define CMS_PRAYER		2
#define CS_PRAYER		12
#define CS_PRAYER2		122
#define CMS_PRAYER_DONE		112
#define DELIMITER -9348934

#define CMS_FLEE		3
#define CS_FLEE			13
#define CMS_FLEE_DONE		113

#define CMS_ENE1                 4
#define CMS_ENE2                 5
#define CMS_ENE3                 6


//global settings class for game session
class MenuControl{
  //Narrative Control
  Bool fxMuted,musicMuted;
  I32 currentSong,//for draw and song threads
      currentMenu,
      cutsceneTarget;//switch cutscene frames
  I64 cutsceneTimer,cutsceneIndex;

  //Dialog
  I64 talkieScene;//dialogID
  U8* dialogName;//dialog actor name

  //Looting
  Bool lootedSwitch;
  I64 lootTarget;
  Inventory *lootInv;

  //combat preferences
  Bool combatON;//determines if combat is initiated
  U16 combatMenuStage; //switches between characters in a combat queue
  U8 combatMenuSelection; //affects combat dialog options
  U8 turnIndex;//used for specific world tick timers
  U8 combatTurn;//whose turn it is

  Actor *target;I64 targetCTPIndex, tarposx,tarposy;//players current target

  //prayerSelection
  I64 prayerToCast, dragPrayer, prayerListIndex, prayerListSize;
  I64 *prayerList;
  Bool isItem, isItemSelector;

  //inventory menus render
  I64 draggingID;//inventory mouse item
  Item *draggingItem;
  CDC *inventoryRender;

  //submenu display toggles
  Bool displayInventory,reRenderInv,draggingInv, 
       displayStats,
       displayPrayers,prayerPage,prayerDragging,
       displayShop,
       displayEquipment,
       displayDev,
       displaySave;

};

class Camera{
  F64 dividX, dividY;//ratio tile to screen h/w
  I64 cursorX, cursorY,//cursor positions 
      topLR,topUD,//for preventing pan at map corners
      cameraOffSetX,cameraOffSetY;//offset for smooth
                            //animation transition on underlying matrix
  
};

MenuControl *mc;
CombatTurn *ctp;
Prayers *prayers;
Camera *camera;
World *world;//world
Vector *worldSz;//world size, with values wX,wY,wZ
//
//Global variables
//

I64 wX,wY,wZ;

