

Matrix *MakeCastle(Matrix *toAdd)
{

  I64 i,j;
  //four walls 
  for(i=11;i<27;i++)
  {
   SetMatrix(toAdd,BG_DK_GRAY,i,0);//17 for castlewall
  }
  for(i=1;i<15;i++)
  {
   SetMatrix(toAdd,BG_DK_GRAY,12,i);
   SetMatrix(toAdd,BG_DK_GRAY,11,i);
  }
  for(i=1;i<15;i++)
  {
   SetMatrix(toAdd,BG_DK_GRAY,25,i);
   SetMatrix(toAdd,BG_DK_GRAY,26,i);
  }
  for(i=12;i<26;i++)
  {
   if(i!=18&&i!=19&&i)
    SetMatrix(toAdd,BG_DK_GRAY,i,14);
  }
  //floor
  for(i=13;i<25;i++)
  {
   for(j=1;j<14;j++)
   {
    if(j==10&&i>15&&i<22)
     SetMatrix(toAdd,BG_DK_GRAY,i,j);//entrance hall wall
    else
     SetMatrix(toAdd,BG_LT_RED,i,j);
   }
  }
  
  //Other buildings

  //NPCS
  SetMatrixNPC(toAdd,A_JEZEBEL,19,3);//jezebel
  SetMatrixNPC(toAdd,A_KING,18,3);//king
  SetMatrixNPC(toAdd,A_ELIJAH,23,25);//elijah
  SetMatrixNPC(toAdd,A_GUARD,20,15);//guard
  SetMatrixNPC(toAdd,A_CAPTAIN,17,15);//captain
  SetMatrixNPC(toAdd,A_WILD_DOG,8,8);//wild dog
  SetMatrixNPC(toAdd,A_OX_CART,1,21);
 // FlipMatrixSolid(toAdd,0,0);  FlipMatrixSolid(toAdd,1,1);
  SetMatrixNPC(toAdd,A_MAKABEE,6,19);
  SetMatrixNPC(toAdd,A_FOWL,22,22);

  //Items
  SetMatrixItem(toAdd,IT_DAGGER,1,1);
  SetMatrixItem(toAdd,IT_DAGGER,2,1);
  SetMatrixItem(toAdd,IT_DAGGER,3,1);
  SetMatrixItem(toAdd,IT_DAGGER,4,1);
  SetMatrixItem(toAdd,IT_HARPOON,5,23);
  //water and sand
  for(i=0;i<50;i++)
  {
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
      SetMatrix(toAdd,2,i,j);//water
     }
    }
   }
  }
  //add dock
  SetMatrix(toAdd,BG_BROWN,6,25);
  SetMatrix(toAdd,BG_BROWN,6,26);
  SetMatrixItem(toAdd,SP_FISHING_SPOT,6,26);

  //FlipMatrixSolid(toAdd,2,21);  FlipMatrixSolid(toAdd,3,21);
  //FlipMatrixSolid(toAdd,4,21);  FlipMatrixSolid(toAdd,5,21);
  //TODO fix flip matrix doesnt work for some reason so i made this
 //alternative grass. 
   SetMatrix(toAdd,SOLID_BG_GREEN,5,21);
   SetMatrix(toAdd,SOLID_BG_GREEN,2,21);
   SetMatrix(toAdd,SOLID_BG_GREEN,3,21);
   SetMatrix(toAdd,SOLID_BG_GREEN,4,21);



  return toAdd;
 
}