
class World
{
 I64 currentZ;
 Tensor3D *level;
};


class Keys
{
 Bool left,right,up,down,enter;
} keys;

class CombatTurn:CQue
{
  Actor *ready;
} combatCQue;


#define LOOTED		0
#define LOOTING		1
#define LOOTABLE	2

#define SCREENX 480
#define SCREENY 480
#define FRAMERULE 3

class MenuControl
{
  //Narrative Control
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


  //inventory render
  Bool displayInventory,reRenderInv;
  CDC *inventoryRender;

};

class Camera
{
  F64 dividX, dividY;//ratio tile to screen h/w
  I64 cursorX, cursorY,//cursor positions 
      topLR,topUD,//for preventing pan at map corners
      cameraOffSetX,cameraOffSetY;//offset for smooth transition
  
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
