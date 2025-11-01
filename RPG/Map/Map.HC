
//Ground Nodes and their Player, Item, Object,Background Arrays


class NodeStuff:CQue
{
  I64 id;
};

class MapNode
{
 F64 bg;
 Bool isSolid, hasNPC, hasObj;
 I64 idNPC,idObj,idInv;
 I64 waterLvl, len;
 NodeStuff *items;
  
};


#define INVWIDTH	11
#define INVHEIGHT	4
//items
#define IT_NULL		-1
#define IT_FIST		0 //nothing
#define IT_DAGGER 	1
static CDC*		ITEM1= FramePtr("ITEM008"); //dagger
static CDC*		ITEM1I = FramePtr("WINV001");

#define IT_HARPOON	2
static CDC*	        ITEM2 = FramePtr("ITEM004");// harpoon
static CDC*		ITEM2I = FramePtr("WINV015");

#define IT_TOOTH 	3
static CDC*		ITEM3=DCNew(100,100); //wolf tooth
static CDC*		ITEM3I=DCNew(100,100);

#define IT_FISH1        4
static CDC*		ITEM4I = FramePtr("ITEM164");//fish

#define IT_HELM         5
static CDC*             ITEM5= FramePtr("ITEM032");
static CDC*             ITEM5I= FramePtr("ARMR012");

#define IT_SHIRT        6
static CDC*             ITEM6= FramePtr("ITEM044");
static CDC*             ITEM6I= FramePtr("CLOT012");

#define IT_BULB 	7
static CDC*		ITEM7=DCNew(100,100); //poppy bulb
static CDC*		ITEM7I=DCNew(100,100);

#define IT_POT	 	8
static CDC*		ITEM8=DCNew(100,100); 
static CDC*		ITEM8I=DCNew(100,100);

#define IT_WPOT 	9
static CDC*		ITEM9=DCNew(100,100); 
static CDC*		ITEM9I=DCNew(100,100);

#define IT_HPPOT 	10
static CDC*		ITEM10= FramePtr("ITEM070");
static CDC*		ITEM10I=DCNew(100,100);

#define IT_OLIVEBRANCH  11
//special
#define SP_FISHING_SPOT 999
static CDC*		SPECIAL1 = FramePtr("EFF075");//special point
static CDC*		SPECIAL2 = FramePtr("EFF076");


//prayers
#define SP_HEAL	0
static CDC* ITEM050= FramePtr("ITEM050");


//ITEM4 = FramePtr("");

//Tile Codes
#define BG_GREEN	0
#define BG_BLUE		1
#define BG_CYAN		2
#define BG_BROWN	3
#define BG_YELLOW	4
#define BG_LT_GRAY	16
#define BG_DK_GRAY	17
#define BG_LT_RED	18
#define BG_ROCK_WALL    19
#define BG_BUSH_WALL    20
#define BG_GRASS        21
#define SOLID_BG_GREEN	110

class Item:CQue
{
  U8* name;
  //name appears in tooltip
  I16 equip_slot, id, invID,value;
  //equip slot determines equippable helm, body, ring, wep (or none)
  //id is the item id (generic)
  //invID is for differentiating the same item in players inv
  //value refers to silver cost
  Bool usable, visible;
  //usable determines selection option from prayer menu 
  //visible is used to toggle item when dragging
  U8 w, h, wOff,hOff;
  //w and h are in inventory boxes width and height
  //wOff and hOff refer to screen location offset relative to inventory position
  U8* v1,*v2,*v3;
  //these variables optionally appear in tooltip description
};

class ItemNode
{
 I8 occupied;

};


class Inventory
{
  I64 count;  
  Item *collection;
  ItemNode mtrx[4][11]; 
};


//
//Prayer Globals
//
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



//		  //
// End Tile Codes //
//		  //


U8 *GetBG(I64 id)
{
  U8 *color = BLUE; 
  switch(id)
  {
   case BG_BUSH_WALL:
   case SOLID_BG_GREEN:
   case BG_GREEN:
   case BG_GRASS:
    color = GREEN;
   break;
   case BG_BLUE:
    color = BLUE;
   break;
   case BG_CYAN:
    color = CYAN;
   break;
   case BG_BROWN:
    color = BROWN;
   break;
   case BG_YELLOW:
    color = YELLOW;
   break;
   case BG_LT_GRAY:
    color = LTGRAY;
   break;
   case BG_DK_GRAY:
    color = DKGRAY;
   break;
   case BG_LT_RED:
    color = LTRED;
   break;
   default:
    color = BLACK;
   break;


  }
  return color;
}

F64 map_range(F64 w, F64 a, F64 b, F64 newWL, F64 newWU) {
    return newWL + (w - a) * (newWU - newWL) / (b - a);
}


I64 ScreenPToTile(I64 sx, I64 lb, I64 ub)
{ 
 return ToI64(map_range(ToF64(sx), 0.0, 480.0, ToF64(lb+1),ToF64(ub-5)));
}


