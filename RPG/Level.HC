Matrix *MakeCastle(Matrix *toAdd)
{

  I64 i,j;
  //four walls 
  for(i=11;i<27;i++)
  {
   SetMatrix(toAdd,17,i,0);//17 for castlewall
  }
  for(i=1;i<15;i++)
  {
   SetMatrix(toAdd,17,12,i);
   SetMatrix(toAdd,17,11,i);
  }
  for(i=1;i<15;i++)
  {
   SetMatrix(toAdd,17,25,i);
   SetMatrix(toAdd,17,26,i);
  }
  for(i=12;i<26;i++)
  {
   if(i!=18&&i!=19&&i)
    SetMatrix(toAdd,17,i,14);
  }
  //floor
  for(i=13;i<25;i++)
  {
   for(j=1;j<14;j++)
   {
    if(j==10&&i>15&&i<22)
     SetMatrix(toAdd,17,i,j);//entrance hall wall
    else
     SetMatrix(toAdd,18,i,j);
   }
  }
  
  //Other buildings

  //NPCS
  SetMatrixNPC(toAdd,2,19,3);//jezebel
  SetMatrixNPC(toAdd,1,18,3);//king
  SetMatrixNPC(toAdd,3,23,25);//elijah
  SetMatrixNPC(toAdd,4,20,15);//guard
  SetMatrixNPC(toAdd,5,17,15);//captain
  SetMatrixNPC(toAdd,6,8,8);//wild dog
  //Items
  SetMatrixItem(toAdd,1,1,1);
  SetMatrixItem(toAdd,1,2,1);
  SetMatrixItem(toAdd,1,3,1);
  SetMatrixItem(toAdd,1,4,1);
  SetMatrixItem(toAdd,2,5,20);
  //water and sand
  for(i=0;i<50;i++)
  {
   for(j=22;j<34;j++)
   {
    if((i<4&&j==22)||(i<6&&i>0&&j==23)||(i>2&&i<13&&j==24)||
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
  SetMatrix(toAdd,3,6,25);
  SetMatrix(toAdd,3,6,26);


  return toAdd;
 
}