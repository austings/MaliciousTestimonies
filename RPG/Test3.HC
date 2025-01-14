#include "Player.HC"



Actor *dog = DeserializeNPC(6);

//dog->health = dog->con*5;
Print("%d Dog Con, %d Dog health,%d dog dead",dog->con, dog->health,dog->dead);