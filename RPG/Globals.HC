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

#define NUM_HOTKEYS 9
I64 hotkeys[NUM_HOTKEYS] ;


class CombatTurn:CQue
{
  Actor *ready;
} combatCQue;

class Prayer
{
  U8 *name,*desc;
  I64 id, type, cost, wOff, hOff;
  Bool unlocked;
};

#define MAX_PRAYERS	42

class Prayers
{
  Prayer **list;
  I64 points,filter,unlocked; 
};

#define TYPE_M		0
#define TYPE_W		1
#define TYPE_P		2
#define TYPE_A		3

#define AGGRO_DIS	2

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
#define DIALOG_BOX_Y	375

//ai scripts
#define AI_DEFAULT	1
#define AI_FISHING	10

//combat menu stage
#define STAGE_0                 0
#define STAGE_1                 1
#define STAGE_2                 2
#define STAGE_3                 3

//combat Menu Selection

#define MOVEMENT_COST		5

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

  //prayerSelection
  I64 prayerToCast, dragPrayer, prayerListIndex, prayerListSize;
  I64 *prayerList;

  //menus render
  I64 draggingID;//inventory mouse item
  Item *draggingItem;
  Bool displayInventory,reRenderInv,draggingInv, 
       displayStats,
       displayPrayers,prayerPage,prayerDragging,
       displayShop,
       displayEquipment;
  CDC *inventoryRender;
  I64 inventoryPointer;

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

