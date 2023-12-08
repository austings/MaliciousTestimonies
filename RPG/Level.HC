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
  
  SetMatrixNPC(toAdd,2,19,3);//jezebel
  SetMatrixNPC(toAdd,1,18,3);//king
  SetMatrixNPC(toAdd,3,23,25);//elijah
  SetMatrixNPC(toAdd,4,20,15);//guard
  SetMatrixNPC(toAdd,5,17,15);//captain
  SetMatrixNPC(toAdd,6,8,8);//wild dog
  SetMatrixItem(toAdd,1,1,1);
  SetMatrixItem(toAdd,1,2,1);
  SetMatrixItem(toAdd,1,3,1);
  SetMatrixItem(toAdd,1,4,1);

  return toAdd;
 
}