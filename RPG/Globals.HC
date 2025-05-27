CDirEntry *loadRoot;

class World
{
 I64 currentZ;
 Tensor3D *level;
};

class Keys
{
 I64 pressed;
} keys;


#define DIR_LEFT	1
#define DIR_RIGHT	2
#define DIR_UP		3
#define DIR_DOWN	4
#define DIR_ENTER       5
#define DIR_ESC         6

class CombatTurn:CQue
{
  Actor *ready;
} combatCQue;


//looting contants for looting previous corpse check
#define LOOTED		0
#define LOOTING		1
#define LOOTABLE	2

//serialize options
#define OPT_MC_FX_OFF   0
#define OPT_MC_FX_ON    1
#define OPT_MC_MUS_OFF  2
#define OPT_MC_MUS_ON   3

#define SCREENX 480
#define SCREENY 480
#define FRAMERULE 3


//ai scripts
#define AI_DEFAULT	1
#define AI_FISHING	10

//combat menu stage
#define CMS_MOVE		0
#define CS_MOVE			1
#define CMS_MOVE_DONE		10
#define MOVEMENT_COST		5

//combat Menu Selection

#define CMS_STRIKE		1
#define CS_STRIKE		11
#define CMS_STRIKE_DONE		111

#define CMS_PRAYER		2
#define CS_PRAYER		12

#define CMS_FLEE		3
#define CS_FLEE			13



class MenuControl{
  //Narrative Control
  Bool fxMuted,musicMuted;
  I32 currentSong,//for draw and song threads
      currentMenu,
      cutsceneTarget;//switch cutscene frames

  //Dialog
  I64 talkieScene;//dialogID
  U8* dialogName;//dialog actor name

  //Combat preferences
  Bool lootedSwitch;
  U8* loot;
  Bool combatON;
  U16 combatMenuStage;
  U8 combatMenuSelection;
  U8 turnIndex;
  Actor *target;I64 tarposx,tarposy;

  //menus render
  I64 draggingID;//inventory mouse item
  Item *draggingItem;
  Bool displayInventory,reRenderInv,draggingInv, 
       displayStats,
       displayEquipment;
  CDC *inventoryRender;

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
Camera *camera;
World *world;//world
Vector *worldSz;//world size, with values wX,wY,wZ
//
//Global variables
//
static CDC*		ITEM1; //dagger
static CDC*		ITEM1I;
static CDC*		ITEM2; //harpoon
static CDC*		ITEM2I;
static CDC*		ITEM3; //wolf tooth
static CDC*		ITEM3I;

I64 wX,wY,wZ;


//
