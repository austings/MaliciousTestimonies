// Construct Graphics from WAD
#include "Data/Wad.HC";
#include "Data/Frames.HC";
#include "Data/Ids.HC";

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
#include "Equipment.HC";

#include "Dialog.HC";

PrintLine(gr.dc,"Fishing Tool",10,10);
PrintLine(gr.dc,"Fishing Tool",10,40);
PrintLine(gr.dc,"Fishing Tool",10,50);