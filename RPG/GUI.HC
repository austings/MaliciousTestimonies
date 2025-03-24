

class GameMenu
{
  GraphicObject *buttons[10];
  TextObject *texts[10];
  
};


class GraphicObject
{
  U8 *title;
  I64 relX, relY;
  I64 absX, absY; 
  U8 *onClickFunctionPtr;
  U8 *onReleaseFunctionPtr;
  U8 *sprite; 

};

class TextObject
{
  U8 *title;
  I64 relX, relY;
  I64 absX, absY; 
  U8 *value; 

};