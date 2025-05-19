

class GameMenu
{
  GraphicObject *buttons[10];
  TextObject *texts[10];
  U8 X, Y;
  
};


class GraphicObject
{
  U8 *title;
  I64 relX, relY;
  I64 screenX, screenY; 
  U8 *onClickFunctionPtr;
  U8 *onReleaseFunctionPtr;
  U8 *sprite; 

};

class TextObject
{
  U8 *title;
  I64 relX, relY;
  I64 screenX, screenY;
  I64 fontSize; 
  U8 *value; 

};