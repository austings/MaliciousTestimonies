

class NodeStuff:CQue
{
  I64 id;
};

class MapNode
{
 F64 bg;
 Bool isSolid;
 Bool hasNPC;
 I64 idNPC;
 I64 len;
 NodeStuff *items;
  
};


#define INVWIDTH	11
#define INVHEIGHT	4
//items
#define IT_NULL		-1
#define IT_DAGGER 	1
static CDC*		ITEM1= FramePtr("ITEM008"); //dagger
static CDC*		ITEM1I = FramePtr("WINV001");


#define IT_HARPOON	2
static CDC*	        ITEM2 = FramePtr("ITEM004");// harpoon
static CDC*		ITEM2I = FramePtr("WINV015");


#define IT_TOOTH 	3
static CDC*		ITEM3; //wolf tooth
static CDC*		ITEM3I;

#define IT_FISH1        4
static CDC*		ITEM4I = FramePtr("ITEM164");//fish


//special
#define SP_FISHING_SPOT 999
static CDC*		SPECIAL1 = FramePtr("EFF075");//special point
static CDC*		SPECIAL2 = FramePtr("EFF076");


//prayers
#define LAY_ON_HANDS	0
static CDC* ITEM050= FramePtr("ITEM050");

//Sprite3B(ITEM3I,0,0,10,GetFang);
//ITEM4 = FramePtr("");

//Tile Codes
#define BG_GREEN	0
#define BG_BLUE		1
#define BG_CYAN		2
#define BG_BROWN	3
#define BG_YELLOW	4
#define BG_DK_GRAY	17
#define BG_LT_RED	18

class Item:CQue
{
  U8* name;
  I16 equip_slot, id, invID,value;
  Bool usable, visible;
  U8 w, h, wOff,hOff;
  U8* v1,*v2,*v3;
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



//		  //
// End Tile Codes //
//		  //


U8 *GetBG(I64 id)
{
  U8 *color = BLUE; 
  switch(id)
  {
   case BG_GREEN:
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
   case BG_DK_GRAY:
    color = DKGRAY;
    break;
   case BG_LT_RED:
    color = LTRED;
    break;


  }
  return color;
}


