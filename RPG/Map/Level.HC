U0 SerializeMatrix()
{

}


#define CAMPCHEST   7

U0 BuildHouse(Matrix *toAdd, I64 startX, I64 endX, 
              I64 startY, I64 endY, I64 door){
 //begin blank house
 I64 i,j;
 //four walls 
 for(i=startX;i<=endX;i++){
   SetMatrix(toAdd,BG_DK_GRAY,i,startY);//back wall
   SetMatrix(toAdd,BG_DK_GRAY,i,endY);//south wall
 }
 for(i=startY;i<=endY;i++){
  if(i==door){
   SetMatrix(toAdd,BG_LT_RED,startX,i);
   SetMatrix(toAdd,BG_DK_GRAY,endX,i);//right wall

  }
  else{
   SetMatrix(toAdd,BG_DK_GRAY,startX,i);//left entrance wall   
   SetMatrix(toAdd,BG_DK_GRAY,endX,i);//right wall
  }
 }
 //floor
 for(i=startX+1;i<endX;i++){
  for(j=startY+1;j<endY;j++){
    SetMatrix(toAdd,BG_LT_RED,i,j);
  }
 }
}

Matrix *MakeCastle(Matrix *toAdd){

 I64 i,j;
  
 for(j=0;j<100;j++)
 {    
  SetMatrix(toAdd,BG_BUSH_WALL,100,j);
  SetMatrix(toAdd,BG_BUSH_WALL,0,j);
 }
  //left hand start

 //path
 Bool alt = TRUE;
  for(i=6;i<=8;i++){
   for(j=0;j<15;j++){
    if(alt)
     SetMatrix(toAdd,BG_BROWN,i,j);
    else
     SetMatrix(toAdd,BG_YELLOW,i,j);
    alt = !alt;
   }
  }
 //campsite
 SetMatrixObj(toAdd,OBJ_TENT,2,1);
 SetMatrixObj(toAdd,OBJ_WOOD,2,2);
 SetMatrixObj(toAdd,OBJ_CHEST,1,4,TRUE,CAMPCHEST);
 
 //Items
 SetMatrixItem(toAdd,IT_DAGGER,3,2);

 /*
 SetMatrix(toAdd,BG_GRASS,5,4);//,FALSE);
 SetMatrix(toAdd,BG_GRASS,5,3);//,FALSE);
 SetMatrix(toAdd,BG_GRASS,3,4);//,FALSE);
 SetMatrix(toAdd,BG_GRASS,3,3);//,FALSE);
 SetMatrix(toAdd,BG_GRASS,4,4);//,FALSE);
 SetMatrix(toAdd,BG_GRASS,4,3);//,FALSE);
 */

 SetMatrixObj(toAdd,OBJ_OLIVETREE,3,8);

 //rock walls
 for(i=0;i<11;i++)
 {
  SetMatrix(toAdd,BG_ROCK_WALL,i,0);
 }  

 for(i=0;i<7;i++)
 {
  SetMatrix(toAdd,BG_ROCK_WALL,i,10);
  SetMatrix(toAdd,BG_ROCK_WALL,i,11);
  SetMatrix(toAdd,BG_ROCK_WALL,i,12);

 }  

// SetMatrixObj(toAdd,OBJ_CROOFNE,26,0);
 //SetMatrixObj(toAdd,OBJ_CROOFNW,11,0);
// SetMatrixObj(toAdd,OBJ_CROOFSW,11,14);
// SetMatrixObj(toAdd,OBJ_CROOFSE,26,14);

 //begin castle
 //four walls 
 for(i=11;i<27;i++){
   SetMatrix(toAdd,BG_DK_GRAY,i,0);//back wall
 }
 for(i=1;i<15;i++){
   SetMatrix(toAdd,BG_DK_GRAY,12,i);//left wall
   SetMatrix(toAdd,BG_DK_GRAY,11,i);
 }
 for(i=1;i<15;i++){
   SetMatrix(toAdd,BG_DK_GRAY,25,i);//right wall
   SetMatrix(toAdd,BG_DK_GRAY,26,i);
 }
 for(i=12;i<26;i++){     //entrance wall
   if(i!=18&&i!=19)
    SetMatrix(toAdd,BG_DK_GRAY,i,14);
   else
    SetMatrix(toAdd,BG_LT_RED,i,14);
 }

  //floor
 for(i=13;i<25;i++){
   for(j=1;j<14;j++)
   {
    if(j==10&&i>15&&i<22)
     SetMatrix(toAdd,BG_DK_GRAY,i,j);//entrance hall wall
    else
     SetMatrix(toAdd,BG_LT_RED,i,j);
   }
 }
 SetMatrixObj(toAdd,OBJ_TABLE,14,1);
 SetMatrixObj(toAdd,OBJ_TABLE,14,4);
 SetMatrixObj(toAdd,OBJ_TABLE,14,7);
 SetMatrixObj(toAdd,OBJ_TABLE,23,1);
 SetMatrixObj(toAdd,OBJ_TABLE,23,4);
 SetMatrixObj(toAdd,OBJ_TABLE,23,7);
 SetMatrixItem(toAdd,IT_POT,14,1);
 SetMatrixItem(toAdd,IT_POT,14,4);
 SetMatrixItem(toAdd,IT_POT,14,7);
 SetMatrixItem(toAdd,IT_POT,23,1);
 SetMatrixItem(toAdd,IT_POT,23,4);
 SetMatrixItem(toAdd,IT_POT,23,7);

 SetMatrixObj(toAdd,OBJ_THRONE,18,2);
 SetMatrixObj(toAdd,OBJ_THRONE,19,2);


  //street
 for(i=0;i<51;i++){
   for(j=15;j<19;j++){
    SetMatrix(toAdd,BG_LT_GRAY,i,j);
   }
 }

 SetMatrixObj(toAdd,OBJ_POPPY,10,2,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,10,4,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,10,6,FALSE);

 //ne poppy field
 SetMatrixObj(toAdd,OBJ_OLIVETREE,28,2);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,35,3);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,37,9);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,28,12);


 SetMatrixObj(toAdd,OBJ_POPPY,28,4,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,29,3,FALSE);

 SetMatrixObj(toAdd,OBJ_POPPY,30,2,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,31,3,FALSE);
  
 SetMatrixObj(toAdd,OBJ_POPPY,32,2,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,32,3,FALSE);
  
 SetMatrixObj(toAdd,OBJ_POPPY,33,4,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,33,3,FALSE);
  
 SetMatrixObj(toAdd,OBJ_POPPY,34,2,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,34,3,FALSE);
  

 SetMatrixObj(toAdd,OBJ_POPPY,9,3,FALSE);

 SetMatrixObj(toAdd,OBJ_POPPY,9,3,FALSE);

  //NPCS
 SetMatrixNPC(toAdd,A_JEZEBEL,19,3);//jezebel
 SetMatrixNPC(toAdd,A_KING,18,3);//king

 SetMatrixNPC(toAdd,A_GUEST,16,6);//guest
 SetMatrixNPC(toAdd,A_GUEST2,20,6);//guest
 SetMatrixNPC(toAdd,A_GUEST3,18,7);//guest
 SetMatrixNPC(toAdd,A_GUEST4,23,5);//guest
 SetMatrixNPC(toAdd,A_GUEST5,22,7);//guest
 SetMatrixNPC(toAdd,A_GUEST6,19,8);//guest
 SetMatrixNPC(toAdd,A_GUEST7,16,8);//guest
 SetMatrixNPC(toAdd,A_GUEST8,21,8);//guest
 SetMatrixNPC(toAdd,A_GUEST9,35,17);//villager
 SetMatrixNPC(toAdd,A_GUEST10,41,17);//villager
 SetMatrixNPC(toAdd,A_GUEST11,4,19);//druid
 SetMatrixNPC(toAdd,A_GUEST12,51,18);//villager

 SetMatrixObj(toAdd,OBJ_OLIVETREE,14,23);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,9,20);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,26,25);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,24,29);

 SetMatrixNPC(toAdd,A_ELIJAH,23,25);//elijah
 SetMatrixNPC(toAdd,A_GUARD,20,15);//guard
 SetMatrixNPC(toAdd,A_CAPTAIN,17,15);//captain
 SetMatrixObj(toAdd,OBJ_WFRAME,16,15);
 SetMatrixObj(toAdd,OBJ_WFRAME,21,15);

 SetMatrixNPC(toAdd,6,8,8);//wild dog
 SetMatrixNPC(toAdd,9,90,90);//wild dog
 SetMatrixNPC(toAdd,11,6,13);//wild dog
 SetMatrixNPC(toAdd,12,9,12);//wild dog
 SetMatrixNPC(toAdd,13,50,13);//wild dog
 SetMatrixNPC(toAdd,14,50,15);//wild dog
 SetMatrixNPC(toAdd,15,49,14);//wild dog
 SetMatrixNPC(toAdd,16,30,8);//wild dog
 SetMatrixNPC(toAdd,17,40,8);//wild dog
 SetMatrixNPC(toAdd,18,35,7);//wild dog
 SetMatrixNPC(toAdd,19,45,7);//wild dog
 SetMatrixNPC(toAdd,20,47,9);//wild dog

 //sw poppy field
 SetMatrixObj(toAdd,OBJ_OLIVETREE,5,36);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,11,46);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,4,45);
 SetMatrixObj(toAdd,OBJ_OLIVETREE,9,33);

 SetMatrixObj(toAdd,OBJ_POPPY,5,37,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,8,38,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,4,39,FALSE);
 SetMatrixObj(toAdd,OBJ_POPPY,2,38,FALSE);
 
 SetMatrixNPC(toAdd,A_OX_CART,1,21);
 FlipMatrixSolid(toAdd,0,0);  FlipMatrixSolid(toAdd,1,1);
 SetMatrixNPC(toAdd,A_SHAMIR,6,19);
 SetMatrixObj(toAdd,OBJ_BARREL,4,20);
 SetMatrixObj(toAdd,OBJ_BARREL,3,19);

 SetMatrixNPC(toAdd,A_FOWL,22,22);
 //SetMatrixNPC(toAdd,21,20,24);
 //SetMatrixNPC(toAdd,22,21,25);
 //SetMatrixNPC(toAdd,23,19,19);
 //SetMatrixNPC(toAdd,24,19,25);  

 //beach
 SetMatrixItem(toAdd,IT_HARPOON,5,23);

 //water and sand
 for(i=0;i<50;i++){
   for(j=22;j<34;j++){
    if((i<4&&j==22)||(i<6&&i>0&&j==23)||(i>2&&i<13&&j==24)||
       (i>4&&i<14&&j==25)||(i>12&&i<16&&j==26)||(i==15&&(j==27||j==28)))
    {
     SetMatrix(toAdd,BG_YELLOW,i,j);//sand
    }
    else{
     if((i==6&&(j==26||j==25))||(j==22)||(i>1&&j==23)||(i>2&&j==24)||(i>4&&j==25)||(i>12&&j==26)||
        (i>14&&j<30)||((i==9||i==10||i>14)&&j==30)||(j==31&&i>7&&i<11)||
        (i>7&&i<12&&j==32)||(i>3&&i<12&&j==33)||
        ((i<12||(i>19&&i<35)||(i>43))&&j==34)||(j==35&&(i<13||i>17)))
     {
      //leave as grass

     }
     else{
      SetMatrix(toAdd,BG_CYAN,i,j);//water
     }
    }
   }
 }

 //bridge to castle
 for(i=18;i<20;i++){
   for(j=15;j<100;j++){
    SetMatrix(toAdd,BG_LT_GRAY,i,j);
   }
 }
 for(j=30;j<35;j++){
  SetMatrix(toAdd,BG_DK_GRAY,17,j);
  SetMatrix(toAdd,BG_DK_GRAY,20,j);
 }
 

 //fishing area
 SetMatrix(toAdd,BG_BROWN,6,25);
 SetMatrix(toAdd,BG_BROWN,6,26);
 SetMatrixObj(toAdd,SP_FISHING_SPOT,6,26,FALSE);
 FlipMatrixSolid(toAdd,2,21);  FlipMatrixSolid(toAdd,3,21);
 FlipMatrixSolid(toAdd,4,21);  FlipMatrixSolid(toAdd,5,21);
 //TODO fix flip matrix doesnt work for some reason so i made this
 //alternative grass.
 /* 
 SetMatrix(toAdd,SOLID_BG_GREEN,5,21);
 SetMatrix(toAdd,SOLID_BG_GREEN,2,21);
 SetMatrix(toAdd,SOLID_BG_GREEN,3,21);
 SetMatrix(toAdd,SOLID_BG_GREEN,4,21);
*/
 //market area
 for(i=12;i<18;i++){
  for(j=35;j<41;j++){
   SetMatrix(toAdd,BG_LT_GRAY,i,j);
  }
 }
 SetMatrixObj(toAdd,OBJ_STALL,13,35);
 FlipMatrixSolid(toAdd,13,24);  //FlipMatrixSolid(toAdd,13,25);
 FlipMatrixSolid(toAdd,14,25);  FlipMatrixSolid(toAdd,14,24);
 FlipMatrixSolid(toAdd,15,25);  FlipMatrixSolid(toAdd,15,24);

 SetMatrixObj(toAdd,OBJ_WFRAME,15,35);
 SetMatrixObj(toAdd,OBJ_BARREL,3,19);
 SetMatrixObj(toAdd,OBJ_BARREL,14,39);
 SetMatrixObj(toAdd,OBJ_BARREL,15,39);
 SetMatrixObj(toAdd,OBJ_WBARREL,15,40);

// SetMatrixObj(toAdd,OBJ_STALL,25,41);
// SetMatrixObj(toAdd,OBJ_STALL,28,41);


 //begin blacksmith
 //forge area 
 SetMatrix(toAdd,BG_LT_GRAY,20,45);
 SetMatrix(toAdd,BG_LT_GRAY,21,45);
 SetMatrix(toAdd,BG_LT_GRAY,22,45); 
 SetMatrix(toAdd,BG_LT_GRAY,22,44);
 SetMatrixObj(toAdd,OBJ_FORGE,21,42);
 SetMatrix(toAdd,BG_LT_GRAY,22,43);
 SetMatrix(toAdd,BG_LT_GRAY,22,42);
 SetMatrix(toAdd,BG_LT_GRAY,21,43);
 SetMatrix(toAdd,BG_LT_GRAY,21,42);

 //four walls
 BuildHouse(toAdd,23,30,40,50,45);
 SetMatrixObj(toAdd,OBJ_TABLE,25,41);
 SetMatrixObj(toAdd,OBJ_BED1,26,41);
 SetMatrixObj(toAdd,OBJ_TABLE,28,41);
 SetMatrixItem(toAdd,IT_SHEKEL10,25,41);
 SetMatrixItem(toAdd,IT_SHEKEL2,28,41);
 SetMatrixObj(toAdd,OBJ_BARREL,22,48);
 SetMatrixObj(toAdd,OBJ_BARREL,22,47);
 SetMatrixObj(toAdd,OBJ_WBARREL,31,49);

 
 BuildHouse(toAdd,23,32,54,60,56); 
 BuildHouse(toAdd,24,31,64,70,69); 
 BuildHouse(toAdd,24,31,73,79,78); 

 return toAdd;
 
}