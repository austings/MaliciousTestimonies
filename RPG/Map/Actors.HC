class Actor
{
  U8  race,eye,hair,points;
  I64 id,hat,armor,legs,boot,
      sword,offhand,
      ring1,ring2,necklace, maxExp;
  U64 x,y,health,mana, currentHealth, currentMana,
      str,int,con,wis,
      screenX, screenY;
  Bool dead,visible;
  U8 ai_script,walking, exp, lvl;
  U16 walkingSubFrame;
  Inventory *myInv;
  U8 name[15];
};


#define T_JUDA  0
#define T_LEVI  1
#define T_EPHR  2
#define T_BENJ  3

#define PLAYER  00
#define A_KING_ 01
#define A_JEZEBEL 02
#define A_ELIJAH 03
#define A_CAPTAIN 04
#define A_GUARD 05
#define A_WILD_DOG 06
