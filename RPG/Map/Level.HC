
U0 SerializeMatrix()
{
}

Matrix *MakeCastle(Matrix *toAdd)
{

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
 SetMatrixObj(toAdd,OBJ_CHEST,1,4);
 
  //Items
  SetMatrixItem(toAdd,IT_DAGGER,3,2);
  SetMatrixItem(toAdd,IT_HELM,5,8);
  SetMatrixItem(toAdd,IT_SHIRT,4,8);


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
   if(i!=18&&i!=19&&i)
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

 SetMatrixObj(toAdd,OBJ_THRONE,18,2);
 SetMatrixObj(toAdd,OBJ_THRONE,19,2);


  //street
 for(i=0;i<51;i++){
   for(j=15;j<19;j++){
    SetMatrix(toAdd,BG_LT_GRAY,i,j);
   }
 }

  
  //Other buildings

  //NPCS
 SetMatrixNPC(toAdd,A_JEZEBEL,19,3);//jezebel
 SetMatrixNPC(toAdd,A_KING,18,3);//king
 SetMatrixNPC(toAdd,A_ELIJAH,23,25);//elijah
 SetMatrixNPC(toAdd,A_GUARD,20,15);//guard
 SetMatrixNPC(toAdd,A_CAPTAIN,17,15);//captain
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

 
 SetMatrixNPC(toAdd,A_OX_CART,1,21);
 FlipMatrixSolid(toAdd,0,0);  FlipMatrixSolid(toAdd,1,1);
 SetMatrixNPC(toAdd,A_MAKABEE,6,19);
 SetMatrixNPC(toAdd,A_FOWL,22,22);
 //SetMatrixNPC(toAdd,21,20,24);
 //SetMatrixNPC(toAdd,22,21,25);
 //SetMatrixNPC(toAdd,23,19,19);
 //SetMatrixNPC(toAdd,24,19,25);
  


 SetMatrixItem(toAdd,IT_HARPOON,5,23);
 //water and sand
 for(i=0;i<50;i++){
   for(j=22;j<34;j++)
   {
    if((i<4&&j==22)||(i<6&&i>0&&j==23)||(i>2&&i<13&&j==24)||
       (i>4&&i<14&&j==25)||(i>12&&i<16&&j==26)||(i==15&&(j==27||j==28)))
    {
     SetMatrix(toAdd,4,i,j);//sand
    }
    else{
     if((j==22)||(i>1&&j==23)||(i>2&&j==24)||(i>4&&j==25)||(i>12&&j==26)||
        (i>14&&j<30)||((i==9||i==10||i>14)&&j==30)||(j==31&&i>7&&i<11)||
        (i>7&&i<12&&j==32)||(i>3&&i<12&&j==33)||
        ((i<12||(i>19&&i<35)||(i>43))&&j==34)||(j==35&&(i<13||i>17)))
     {//||((i>7&&i<11)||(i>14&&i<26)||(i>33&&i<46)&&j==31)
      //(i>0&&j==23)||
      //leave as grass
     }
     else
     {
      SetMatrix(toAdd,BG_CYAN,i,j);//water
     }
    }
   }
 }
 //add dock
 SetMatrix(toAdd,BG_BROWN,6,25);
 SetMatrix(toAdd,BG_BROWN,6,26);
 SetMatrixObj(toAdd,SP_FISHING_SPOT,6,26,FALSE);
 //FlipMatrixSolid(toAdd,3,21);
 //FlipMatrixSolid(toAdd,4,21);  FlipMatrixSolid(toAdd,5,21);
 //TODO fix flip matrix doesnt work for some reason so i made this
 //alternative grass. 
 SetMatrix(toAdd,SOLID_BG_GREEN,5,21);
 SetMatrix(toAdd,SOLID_BG_GREEN,2,21);
 SetMatrix(toAdd,SOLID_BG_GREEN,3,21);
 SetMatrix(toAdd,SOLID_BG_GREEN,4,21);



  return toAdd;
 
}