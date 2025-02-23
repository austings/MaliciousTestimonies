

U0 InteractActor(I64 npc)
{
 Actor *aAtLoc= GetNPC(npc);
 if(aAtLoc->ai_script==1&&aAtLoc->dead==FALSE)//combat
 {
  mc->combatON=TRUE;
 }
 else
 {
  mc->dialogName = aAtLoc->name;
  
  if(aAtLoc->dead==TRUE)
  {
    if(mc->lootedSwitch==LOOTED) //already looted
    {
     //mc->talkieScene = GetTalkie(13);//empty corpse message
    }
    else
    {
     if(mc->lootedSwitch==LOOTABLE)
     {
      mc->loot = "..........";
      switch(npc)
      {
        case 6://wolf fang
        mc->loot = "wolf fang";
        AddItemToInventory(0,3);
        break;
      }
      mc->lootedSwitch=LOOTING;
     }

     //mc->talkieScene = 12;  
    }

  }
  else
  {
   //AdamLog("Peace"); AdamLog(3);
   mc->talkieScene = GetTalkie(npc);
  }
 }

} 
CDC *RenderInventory(Actor *p)
{ 
 if(mc->reRenderInv)
 {
  I64 i,j;
  CDC *newInventoryRender = DCNew(640,480);
  DCFill(newInventoryRender, TRANSPARENT);
  //items
  static I16 scanned[44] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
  U16 scanWriteIndex = 0;
  for(i=0;i<11;i++)
  {
   for(j=0;j<4;j++)
   {
    I8 occupied= p->myInv->mtrx[j][i].occupied;
    if(occupied!=-1)
    {
     Bool alreadyScanned = FALSE;
     U8 scanIndex = 0;
     while(scanIndex<scanWriteIndex)
     {
      if(scanned[scanIndex]==occupied)
       alreadyScanned=TRUE;
      scanIndex++;
     }
     if(!alreadyScanned)
     {
      scanned[scanWriteIndex] = occupied;
      scanWriteIndex++;
      I64 currentItemID = RetrieveItemID(0,occupied); 
           
      switch(currentItemID)
      {
       case 1://dagger   
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM1I);
       break;
       case 2://harpoon   
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM2I);
       break;
       case 3://wolfteeth
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM3I);
       break;
      }
      //Free(&retrieved);
     }
    }
   }
  }
  mc->inventoryRender = newInventoryRender;
  mc->reRenderInv=FALSE;
 }
 
 return mc->inventoryRender;

}


U0 MoveActor(Actor *p, U8 dir)
{
 
 /*if(p->race>=4)
 {
  switch(dir)
  {
    case 0:
     if(!CheckSolid(world->level,(p->x)-1,p->y,world->currentZ))
     {
      RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
      SetTensorNPC(world->level,p->id,(p->x)-1,p->y,world->currentZ);
      UpdateActorCoords(p->id,(p->x)-1,p->y);
     }
    break;
    case 1:
     if(!CheckSolid(world->level,(p->x)+1,p->y,world->currentZ))
     {  
      RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
      SetTensorNPC(world->level,p->id,(p->x)+1,p->y,world->currentZ);
      UpdateActorCoords(p->id,(p->x)+1,p->y);
     }
    break;
    case 2:
     if(!CheckSolid(world->level,p->x,(p->y)-1,world->currentZ))
     {  
      RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
      SetTensorNPC(world->level,p->id,p->x,(p->y)-1,world->currentZ);
      UpdateActorCoords(p->id,p->x,(p->y)-1);
     }
    break;
    case 3:
     if(!CheckSolid(world->level,p->x,(p->y)+1,world->currentZ))
     {  
      RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
      SetTensorNPC(world->level,p->id,p->x,(p->y)+1,world->currentZ);
      UpdateActorCoords(p->id,p->x,(p->y)+1);
     }
    
    break;
  }
  return;

 }else{*/


 //actors with anim

 I64 npc;

 if(p->walking==0)
 {
  switch(dir)
  {
  case 0://left
    p->walkingSubFrame=3;

   if(p->x-1>=0&&!
      CheckSolid(world->level,p->x-1,p->y,world->currentZ))
   {
    npc = GetTensorNPC(world->level,p->x-1,p->y,world->currentZ);
    if(npc!=-1)
    {
      if(p->id==0){
       InteractActor(npc);
      }
    
    }
    else
    {
     
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}
     if(camera->topLR!=0&&p->x<wX-5)
      camera->topLR--;
     p->walking=1;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,(p->x)-1,p->y,world->currentZ);
     UpdateActorCoords(0,(p->x)-1,p->y); 

    }
   }
  break;
  case 1://right
   p->walkingSubFrame=2;


   if(p->x+1!=wX&&!CheckSolid(world->level,p->x+1,p->y,world->currentZ))
   {
    npc =GetTensorNPC(world->level,p->x+1,p->y,world->currentZ); 
    if(npc!=-1)
    {  

      if(p->id==0){
       InteractActor(npc);
      }
     
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}

     if(camera->topLR!=wX-11&&p->x>=5)
       camera->topLR++;
     p->walking=2;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,(p->x)+1,p->y,world->currentZ);
     UpdateActorCoords(0,(p->x)+1,p->y); 
    }
   }
  break;
  case 2://up
   p->walkingSubFrame=1;

   if(p->y-1>=0&&!CheckSolid(world->level,p->x,p->y-1,world->currentZ))
   {
    npc =GetTensorNPC(world->level,p->x,p->y-1,world->currentZ); 
    if(npc!=-1)
    {

      if(p->id==0){
       InteractActor(npc);
      }
    
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}

     if(camera->topUD!=0&&p->y<wY-5){
      camera->topUD--;
     }
     p->walking=3;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,p->x,(p->y)-1,world->currentZ);
     UpdateActorCoords(0,p->x,(p->y)-1); 
    }
   }
  break;
  case 3://down
   p->walkingSubFrame=0;

   if(p->y+1!=wY&&!CheckSolid(world->level,p->x,p->y+1,world->currentZ))
   {
    npc = GetTensorNPC(world->level,p->x,p->y+1,world->currentZ);
    if(npc!=-1)
    {

      if(p->id==0){
       InteractActor(npc);
      }
    
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(mc->lootedSwitch==LOOTING){
       mc->lootedSwitch=LOOTED;}

     if(camera->topUD!=wY-11&&p->y>=5){
      camera->topUD++;
     }
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     p->walking=4;
     p->walkingSubFrame=0;
     SetTensorNPC(world->level,0,p->x,(p->y)+1,world->currentZ);
     UpdateActorCoords(0,p->x,(p->y)+1); 
    }
   }
  break;
  }
 }//if not walking
 //}//else

}


U8 GetWalkOffsetX(U8 walkdir)
{
 U8 XOffset = 0;
 switch(walkdir)
 {
  case 0://not walking
  break;
  case 1://left straight start
   XOffset=40;
  break;
  case 2://right straight start
   XOffset=-40;
  break;
  case 3://up straight start
  break;
  case 4://down straight start
  break;
  case 5://left left leg
   XOffset=30;
  break;
  case 6://right left leg
   XOffset=-30;
  break;
  case 7://up left leg
  break;
  case 8://down left leg
  break;
  case 9://left straight mid
   XOffset=20;
  break;
  case 10://right straight mid
   XOffset=-20;
  break;
  case 11://up straight mid
  break;
  case 12://down straight mid
  break;
  case 13://left right leg
   XOffset=10;
  break;
  case 14://right right leg
   XOffset=-10;
  break;
  case 15://up right leg
  break;
  case 16://down right leg 
  break;
 } 
 return XOffset; 
}

U8 GetWalkOffsetY(U8 walkdir)
{
 U8 YOffset = 0;
 switch(walkdir)
 {
  case 0://not walking
  break;
  case 1://left straight start
  break;
  case 2://right straight start
  break;
  case 3://up straight start
   YOffset=40;
  break;
  case 4://down straight start
   YOffset=-40;
  break;
  case 5://left left leg
  break;
  case 6://right left leg
  break;
  case 7://up left leg
   YOffset=30;
  break;
  case 8://down left leg
   YOffset=-30;
  break;
  case 9://left straight mid
  break;
  case 10://right straight mid
  break;
  case 11://up straight mid
   YOffset=20;
  break;
  case 12://down straight mid
   YOffset=-20;
  break;
  case 13://left right leg
  break;
  case 14://right right leg
  break;
  case 15://up right leg
   YOffset=10;
  break;
  case 16://down right leg 
   YOffset=-10;
  break;
 }
 return YOffset; 
}

//Combat Functions

#include "Attacks.HC";

U0 CombatQueInit(Actor *toInsert) //parameter encounter file?
{
  mc->combatON=TRUE;
  mc->loot = "";
  mc->lootedSwitch=FALSE;
  mc->combatMenuStage=0;
  mc->currentSong=5;
  QueInit(&combatCQue);
  
  CombatTurn *ctn;
  // Limit for one
  ctn = CAlloc(sizeof(CombatTurn));
  ctn->ready = GetNPC(0); //GetNPC(maxChars);
  QueIns(ctn,combatCQue.last);

  ctn = CAlloc(sizeof(CombatTurn));
  ctn->ready = toInsert; //GetNPC(maxChars);
  QueIns(ctn,combatCQue.last);
  //combatCQue
  
  ctp = combatCQue.next;
  mc->turnIndex = 1;

}

U0 RenderCombatVersion(Actor *toRender)
{
      //COMBATCYCLEENEMIES
  if(mc->combatON==TRUE&&toRender->id!=0&&toRender->ai_script==1)
  {
    //good enough for now
    if(mc->combatMenuStage==1)//stage 1 is the end of player's turn
    {
      mc->combatMenuStage=2;//go to stage 2, creature's turn 
      mc->turnIndex= 2;   
      ctp = combatCQue.next;//reset que pointers
      ctp = ctp->next;//now pointer is to the first creature in the que
      if(ctp->ready->dead==FALSE){
       //MoveActor(ctp->ready,RandU64%(4));
       mc->combatON=TRUE;
      }//move it randomly}
      else
      {
       mc->combatON=FALSE;
       mc->currentSong=0;
      }
    }
    //attack
    if(mc->combatMenuStage==2)
    {
      //reset back to stage 0, start of player's turn
      mc->combatMenuStage=0;
      mc->combatMenuSelection=0;      

      //return que pointer to player
      if(mc->turnIndex==QueCnt(combatCQue))
      {
        //ctp = ctp->next;
        ctp = combatCQue.next;
        mc->turnIndex = 1;


      }
    }
  }
        

}


//called after combatMenuSelection==11
U0 HighlightTarget(CDC *dc, I64 hX, I64 hY,I64 hZ)
{
    dc->color=RED;
    dc->thick=5;
    GrCircle(dc,hX+25,hY+45,15);
    //GrFloodFill(dc,hX+13,hY+13,TRUE);   
   
}


U0 RenderCharacter(CDC *dc,I64 iFinalX, I64 iFinalY,I64 iFinalZ,
           CDC *character,Bool highlight=FALSE)
{
    GrBlot3(dc,iFinalX,iFinalY,iFinalZ,character);

    if(highlight){
       HighlightTarget(dc, iFinalX, iFinalY+24,iFinalZ+10);
    }
}

//
// Task Functions
//

U0 DrawIt(CTask *task, CDC *dc)
{
 I64 i,j,l,colis;
 U8 sprite;

 switch(mc->currentMenu)
 {
//main menu
  case 0:
   MainMenu(dc,task);
   break;
//Main game
  case 1:
   Actor *p = GetNPC(0);

   if(keys.enter==TRUE)
   {
     if(mc->combatON)
     {
      switch(mc->combatMenuSelection)
      {
       case 0://move
        mc->combatMenuSelection =10; 
       break;
       case 1://strike
       mc->combatMenuSelection =11; 
       break;
       case 2://prayer

        mc->combatMenuSelection =12; 
       break;
       case 3://flee

        mc->combatMenuSelection =13; 
       break;
       case 10://move completion
        mc->combatMenuStage=1;
       break;
       case 11://strike completion
        mc->combatMenuSelection=111;
       break;
      }
     }
     else
     {
       MapNode *puin =GetTensorItem(world->level,p->x,
                     p->y,world->currentZ);
       if(puin->len>0)
       {
        I64 pui = (PickUpItem(puin,0))->id;
        mc->reRenderInv=TRUE;       
        if(!AddItemToInventory(0,pui))
        {
         Play("ArE"); 
        }
       }
     }
      
     keys.enter=FALSE;
   }
   if(keys.left==TRUE)
   {
     if(!mc->combatON)
     {
      MoveActor(p,0);
     }
     else
     {
      switch(mc->combatMenuStage)
      {
       case 0:
       switch(mc->combatMenuSelection)
       {
        case 10: //move menu
         if(p->currentMana>=5){
          MoveActor(p,0);
          RemoveMana(p, 5);}
         else{ 
          mc->combatMenuStage=1;}
        break;
        case 11://strike menu
          ctp = ctp->next;
          mc->turnIndex++;
          //return to player from head
          if(mc->turnIndex>QueCnt(combatCQue))
          {
           ctp = combatCQue.next;
           mc->turnIndex = 1;

           }

        break;

       }
       break;
       case 1:
       break;
      }
     }
     keys.left=FALSE;

   }

   if(keys.right==TRUE)
   {
    if(!mc->combatON)
    {
     MoveActor(p,1);
    }
    else
    {
     switch(mc->combatMenuStage)
     {
      case 0:
      switch(mc->combatMenuSelection)
      {
       case 10: //move menu
        if(p->currentMana>=5){
         MoveActor(p,1);
         RemoveMana(p, 5);}
        else{
         mc->combatMenuStage=1;}
        break;
       case 11://strike menu
          ctp = ctp->last;
          mc->turnIndex--;
          if(mc->turnIndex==0)
          {
           ctp = combatCQue.last;
           mc->turnIndex = QueCnt(combatCQue);

          }

        break;


      }
      break;
      case 1:
      break;
     }
    }

    keys.right=FALSE;
   }
   if(keys.up==TRUE)
   {
    if(mc->combatON)
    {
     switch(mc->combatMenuStage)
     {
      case 0:
      switch(mc->combatMenuSelection)
      {
        case 0: break;
        case 1...9:
         mc->combatMenuSelection--;
        break; 
        case 10: //move menu
         if(p->currentMana>=5&&p->walking==0){
          MoveActor(p,2); RemoveMana(p, 5);}
         else{
          mc->combatMenuStage=1;}
        
        break;
        
      }
      break;
      case 1:
      break;
     }
    }else{
      MoveActor(p,2);
    }
    keys.up=FALSE;
   }
   if(keys.down==TRUE)
   {
    if(mc->combatON)
    {
     switch(mc->combatMenuStage)
     {
      case 0:
      switch(mc->combatMenuSelection)
      {
        case 0...2: mc->combatMenuSelection++;
        case 3: break;
        case 10: //move menu
         if(p->currentMana>=5&&p->walking==0){
          MoveActor(p,3); RemoveMana(p, 5);
         }else{
         mc->combatMenuStage=1;}
        break;
        
      }
      break;
      case 1:
      break;
     }
    }else{
      MoveActor(p,3);
    }
    keys.down=FALSE;
   }

   dc->thick=1;
   
   //
   // background world
   //
   //x pan
   if(camera->topLR==0||camera->topLR==wX-11)
   {
    if(camera->cameraOffSetX!=0)
    {
      if(camera->cameraOffSetX>0)
      {
        camera->cameraOffSetX=Max(0,camera->cameraOffSetX-1);
      }
      else
      {
        camera->cameraOffSetX=Min(0,camera->cameraOffSetX+1);
       
      }
    }
   }
   else
   {
     
     camera->cameraOffSetX=-GetWalkOffsetX(p->walking);
   }

   //y pan
   if(camera->topUD==0||camera->topUD==wY-11)
   {
     if(camera->cameraOffSetY!=0)
     {
       if(camera->cameraOffSetY>0)
         camera->cameraOffSetY=Max(0,camera->cameraOffSetY-1);
       else
         camera->cameraOffSetY=Min(0,camera->cameraOffSetY+1);
     }
   }
   else
   {
      camera->cameraOffSetY=-GetWalkOffsetY(p->walking);
   }
   
   //draw world and one column and row extra for either side        
   for(i=-1;i<12;i++)
   {
    if(camera->topLR+i<wX&&camera->topLR+i>=0)
    {
     for(j=-1;j<12;j++)
     {
      if(camera->topUD+j<wY&&camera->topUD+j>=0)
      {
       I16 c =  GetTensor(world->level,camera->topLR+i,camera->topUD+j,world->currentZ);
       dc->color = GetBG(c);
       GrRect3(dc,i*camera->dividX+camera->cameraOffSetX, 
                j*camera->dividY+camera->cameraOffSetY, -1,
                camera->dividX, camera->dividY);
       if(c>16)
       {
        switch(c)
        {
        case 17:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetWall1());
        break;
        case 18:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetCarpet());
        break;
        } 
       }
  

      }
     }
    }
   }

   //draw npcs and items
   for(j=-1;j<12;j++)
   {
    if(camera->topUD+j<wX&&camera->topUD+j>=0)
    {
    for(i=-1;i<12;i++)
    {
     if(camera->topLR+i<wY&&camera->topLR+i>=0)
     {
      //ITEMS
      MapNode *mn = GetTensorItem(world->level,
                        camera->topLR+i,camera->topUD+j, 
                        world->currentZ);
 
      for(l=0;l<mn->len;l++)
      {
       I64 item = (GetItem(mn,l))->id;
       
       switch(item)
       {
         case 1:
         GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM1);
         break;
         case 2:
         GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM2);

         default:
         break;
       }
      } 
                

  
     I64 npc= GetTensorNPC(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
   
     //Actors
     //start by converting matrix x,y position to screen X,Y
     I64 convertedToScreenX,convertedToScreenY;
     if(npc!=-1)
     {
      Actor *toRender;
      I64 npcOffsetX=-camera->cameraOffSetX, npcOffsetY=-camera->cameraOffSetY;
      
      if(npc!=0){
       toRender = GetNPC(npc);
       

       npcOffsetX=GetWalkOffsetX(toRender->walking), 
       npcOffsetY=GetWalkOffsetY(toRender->walking);
       convertedToScreenX = i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX;
       convertedToScreenY = j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY;
      }
      else
      {
        toRender = p;
        if(camera->topLR==0||camera->topLR==wX-11)
         npcOffsetX=GetWalkOffsetX(toRender->walking);
        if(camera->topUD==0||camera->topUD==wY-11)
         npcOffsetY=GetWalkOffsetY(toRender->walking);
        convertedToScreenX = i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX;
        convertedToScreenY = j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY;
        //render attack from player
        if(mc->combatMenuSelection==111)
        {
         switch(p->sword)
         {
          case 0: //fist
           PunchMove(dc,toRender, mc->tarposx,
                        mc->tarposy-mc->turnIndex,
                        CalculateAngle(mc->tarposx,mc->tarposy,
                         convertedToScreenX,convertedToScreenY));
           mc->turnIndex++;
           if(mc->turnIndex>50)
           {
            RemoveHealth(mc->target,p->str);
            mc->turnIndex=1;
            mc->combatMenuStage=1;
           }//mc turnindex
          break;
         }//switch p sword
        }//combat render phase
      
      }//if player or not
      
      //COMBAT start initializations
      //move enemy during combat turn 
      if(toRender->ai_script==1)
      { 

       if(mc->combatON==FALSE&&toRender->ai_script==1&&toRender->dead==FALSE&& //(enemy)
          Abs((p->x)-(toRender->x))<=2&& //(aggro distance)
          Abs((p->y)-(toRender->y))<=2)
       {
         CombatQueInit(toRender);
       }
       RenderCombatVersion(toRender);
      }
      //optionally highlight targets for strikes
      Bool highlight= FALSE;
      if(mc->combatMenuSelection==11&&toRender->id==ctp->ready->id)
      {
        highlight = TRUE;
        mc->target = toRender;

        mc->tarposx = convertedToScreenX;
        mc->tarposy = convertedToScreenY;//change default target
      }
    
      RenderCharacter(dc,convertedToScreenX,convertedToScreenY,
      10, GetActorAnimationJob(toRender), highlight);     
     }//if npc
     }//if too large y
    }//for y
    }//if too large
   }//for x

   //Game Menus
   dc->color = DKGRAY;
   GrRect3(dc,12*camera->dividX+camera->cameraOffSetX,0,0,200,480);
   Sprite3B(dc,11*camera->dividX-25,-4,0,GetSideMenu);
   Sprite3B(dc,494,420,0,GetButton(4));//save button 

   RPGSideBar(dc);
   if(mc->displayStats)
   {
    GrBlot3(dc,12*camera->dividX-25,-4,0,RenderStats(p));
   }
   //Current Spirit and Health 
   dc->color=BLUE;
   GrCircle(dc,518,344,36);
   I64 fillValue= ToI64((ToF64(p->currentMana)/ToF64(p->mana))*100);
   switch(fillValue)
   {
    case 1...5:
     GrLine(dc,512,380,525,380);         
     //GrFloodFill(dc,521,381,TRUE);
     dc->color=BLACK;         
     break;
    case 6...10:
     GrLine(dc,508,378,530,378);         
     GrFloodFill(dc,519,379,TRUE);
     dc->color=BLACK;         
     break;
    case 11...15:
     GrLine(dc,499,375,534,375);         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 16...20:
     GrLine(dc,495,373,540,373);//3         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 21...25:
     GrLine(dc,490,370,542,370);//1         
     GrFloodFill(dc,521,378,TRUE); 
     dc->color=BLACK;        
     break;
    case 26...30:
     GrLine(dc,490,367,544,367);         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 31...35: 
     GrLine(dc,488,365,546,365);        
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 36...40:
     GrLine(dc,485,363,546,363);         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 41...45:
     GrLine(dc,480,355,550,355);         
     GrFloodFill(dc,521,378,TRUE);//12
     dc->color=BLACK;         
     break;
    case 46...50:
     GrLine(dc,480,350,553,350);    
     GrFloodFill(dc,521,378,TRUE);//11
     dc->color=BLACK;         
     break;
    case 51...55:
     GrLine(dc,480,347,553,347);         
     GrFloodFill(dc,521,378,TRUE);//10
     dc->color=WHITE;
         
     break;
    case 56...60:
     GrLine(dc,482,344,553,344);         
     GrFloodFill(dc,521,378,TRUE);//9
     dc->color=WHITE;
     break;
    case 61...65:
     GrLine(dc,483,340,552,340);
     GrFloodFill(dc,521,342,TRUE);//8
     dc->color=WHITE;
         
     break;
    case 66...70:
     GrLine(dc,484,335,552,335);
     GrFloodFill(dc,521,342,TRUE);//7
     dc->color=WHITE;
         
     break;
    case 71...75:
     GrLine(dc,484,330,550,330);
     GrFloodFill(dc,521,342,TRUE);//6
     dc->color=WHITE;
                       
     break;
    case 76...80:
     GrLine(dc,486,325,547,325);
     GrFloodFill(dc,521,342,TRUE);//5 
     dc->color=WHITE;             
              
     break;
    case 81...85:
     GrLine(dc,490,320,543,320); 
     GrFloodFill(dc,521,342,TRUE); //4 
     dc->color=WHITE;
            
     break;
    case 86...90:
     GrLine(dc,495,315,538,315);
     GrFloodFill(dc,521,342,TRUE);//3 
     dc->color=WHITE;
                
     break;
    case 91...95:
     GrLine(dc,506,310,530,310);
     GrFloodFill(dc,521,342,TRUE);//2 
     dc->color=WHITE;
    
              
     break;
    case 96...1000:
     GrFloodFill(dc,521,342,TRUE);//1
     dc->color=WHITE;
     
     break;
   }

   U8 *t1 = MStrPrint("%d/%d",p->currentMana,p->mana);
   for(i=0;i<StrLen(t1);i++)
   {
     GrChar(dc,t1[i],500+i*7,347,1);
   }


   dc->color=RED;
   GrCircle(dc,597,344,36);
   
   fillValue= ToI64((ToF64(p->currentHealth)/ToF64(p->health))*100);
  
   switch(fillValue)
   {
    case 1...5:     
     GrLine(dc,586,377,610,377);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;
     break;
    case 6...10:     
     GrLine(dc,582,375,616,375);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;
     break;
    case 11...15:     
     GrLine(dc,575,373,619,373);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;  
     break;
    case 16...20:
     GrLine(dc,573,370,621,370);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;       
     break;
    case 21...25: 
     GrLine(dc,570,367,625,367);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;      
     break;
    case 26...30:
     GrLine(dc,567,365,625,365);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;  
     break;
    case 31...35:
     GrLine(dc,565,363,627,363);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;  
     break;
    case 36...40:
     GrLine(dc,563,360,629,360);
     GrFloodFill(dc,610,362,TRUE);      
     dc->color=BLACK;  
     break;
    case 41...45:
     GrLine(dc,562,355,629,355);     
     GrFloodFill(dc,610,362,TRUE);      
     dc->color=BLACK;
     break;
    case 46...50:
     GrLine(dc,560,350,631,350);    
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=BLACK;
     break;
    case 51...55:
     GrLine(dc,560,347,631,347);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 56...60:
     GrLine(dc,560,344,631,344);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 61...65:
     GrLine(dc,560,340,631,340);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 66...70:
     GrLine(dc,560,335,631,335);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 71...75:
     GrLine(dc,561,330,629,330);     
     GrFloodFill(dc,610,332,TRUE);      
     dc->color=WHITE;
     break;
    case 76...80:
     GrLine(dc,565,325,627,325);     
     GrFloodFill(dc,610,332,TRUE);      
     dc->color=WHITE;
     break;
    case 81...85:
     GrLine(dc,569,320,625,320);
     GrFloodFill(dc,610,332,TRUE);      
     dc->color=WHITE;          
     break;
    case 86...90:
     GrLine(dc,575,315,618,315);
     GrFloodFill(dc,610,332,TRUE);
     dc->color=WHITE;                
     break;
    case 91...95:
     GrLine(dc,585,310,606,310);
     GrFloodFill(dc,610,332,TRUE); 
     dc->color=WHITE;     
     break;
    case 96...1000:
     GrFloodFill(dc,610,332,TRUE); 
     dc->color=WHITE;    
     break;
   }
   
   t1 = MStrPrint("%d/%d",p->currentHealth,p->health);
   for(i=0;i<StrLen(t1);i++)
   {
     GrChar(dc,t1[i],580+i*7,347,1);
   }
   
   if(mc->talkieScene!=-1)//dialog
   {
    mc->displayInventory=FALSE;
    Chatbox(mc->dialogName,dc,task,mc->talkieScene,mc->loot);
   }
   else if(mc->combatON)//combat
   {
    mc->displayInventory=FALSE;
      
    switch(mc->combatMenuStage)
    {
     case 0://Player action select
      /*I64 deathloop,deathcounter;
      ctp = combatCQue.next; 
      for(deathloop=0;deathloop<QueCnt(combatCQue)-1;deathloop++)
      {
        if(ctp->ready->dead){
         deathcounter++;}
        ctp = ctp->next;
      }
      if(deathcounter==1)
      {//enemies killed
       mc->combatON = FALSE;
       mc->currentSong =0;
       
      }
      else{ */
       CombatDialog1(dc,task, mc->combatMenuSelection);
      //}
     break;
     case 1:
      //Actor *attacker = ct->ready;    
     break;
     case 2:
      //mc->combatMenuStage=1;
      //mc->combatMenuStage=0;
     break;
     case 3:
     break;
    }
   }
   else if(mc->displayInventory)//inventory
   {
    dc->color = LTGRAY;
    GrRect3(dc,0,300,0,480,180);
    //background
    for(i=0;i<11;i++)
    {
     for(j=0;j<4;j++)
     {   
     Sprite3B(dc,i*camera->dividX+2,j*camera->dividY+300,
              0,GetMenuSprite(2));
     }
    }
    GrBlot3(dc,0,0,10,RenderInventory(p));
 
    Sprite3B(dc,460,280,0,GetMenuSprite(3));
    
   }
   
   break;
   //character select
   case 2:
  // SetCharMenuSprites();
   CharMenu(dc,task,A1D1,A2D1,A3D1,A4D1);   
   break;
   case 3:
   IntroCutscene(dc,task,mc->cutsceneTarget);
   break;
   case 4:
   LoadMenu(dc,task,loadRoot);
   break;
 }   
}

U0 CleanUp()
{
 DocClear;
 SettingsPop;
 DestroyTensor(world->level);
 Free(world);
 
 MenuPop;
 GetChar;
}

//
// Main
//

U0 RPGMain()
{
  CDC *dc=DCAlias;//Device Context
  I64 arg1,arg2,msg_code;
  SettingsPush;
  WinMax;
  WinBorder;
  DocCursor;
  DocClear;
  MenuPush("");


  Init;
//PrintTensor(world->level);

  Fs->draw_it=&DrawIt;
  Fs->song_task=
        Spawn(&SongTask,mc,"Song",,Fs);

  while(TRUE)
  {

    camera->cursorX = ms.pos.x, camera->cursorY = ms.pos.y;
    switch(mc->currentMenu)
      {
      case 0://main menu
        switch (msg_code=GetMsg(&arg1,&arg2,
	      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	  {
	  case MSG_MS_L_DOWN:
	    if(camera->cursorX>=229&&camera->cursorX<=397)
	    {
	      if(camera->cursorY>258&&camera->cursorY<298)
	        {//new game
	        mc->currentMenu=3;
                mc->currentSong=3;
	      } else if(camera->cursorY>307&&camera->cursorY<349)
	        {//load game
	        loadRoot = FilesFind("Saves/*",FUF_JUST_FILES);
	        mc->currentMenu=4;
                mc->currentSong=4;
	      } else if(camera->cursorY>358&&camera->cursorY<399)
	        {//options

	      } else if(camera->cursorY>408&&camera->cursorY<448)
	        {//exit

	        goto fs_end;
	      }
            }
            else if(camera->cursorX>=494&&camera->cursorX<=549&&//music 
               camera->cursorY>=220&&camera->cursorY<=280
               )
            {
 	       if(mc->musicMuted==FALSE)
               {
                 mc->musicMuted=TRUE;
               }else { mc->musicMuted=FALSE; }
  
            }
            else if(camera->cursorX>=550&&camera->cursorX<=610&&//fx
               camera->cursorY>=220&&camera->cursorY<=280)
              {
 	      
 	       if(mc->fxMuted==FALSE)
               {
                 mc->fxMuted=TRUE;
               }else { mc->fxMuted=FALSE; }
            }
 
	    break;
        }
        break;
      case 1://main game
        switch (msg_code=GetMsg(&arg1,&arg2,
	      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	  {
	  case MSG_MS_L_DOWN:
	    if(camera->cursorX>=496&&camera->cursorX<=619&& //save button
               camera->cursorY>=421&&camera->cursorY<=458)
	    {
	      SaveForm;
	      mc->currentMenu=0;
              mc->currentSong=1;
	    }
            else if(camera->cursorX>=496&&camera->cursorX<=549&& //inv button
               camera->cursorY>=40&&camera->cursorY<=100
               &&mc->displayStats==FALSE)
	    {
              if(mc->displayInventory==TRUE)
 		mc->displayInventory=FALSE;
              else
	       mc->displayInventory=TRUE;
	    }
            else if(camera->cursorX>=460&&camera->cursorX<=480&&//inv x
               camera->cursorY>=290&&camera->cursorY<=310
               &&mc->displayInventory==TRUE)
            {
 	      mc->displayInventory=FALSE;
            }  
            else if(camera->cursorX>=550&&camera->cursorX<=610&&//stats on
               camera->cursorY>=40&&camera->cursorY<=100
               &&mc->displayStats==FALSE)
            {
 	      mc->displayStats=TRUE;
            }
            else if(camera->cursorX>=580&&camera->cursorX<=641&&//stats x
               camera->cursorY>=0&&camera->cursorY<=40
               &&mc->displayStats==TRUE)
            {
 	      mc->displayStats=FALSE;
            }

            else if(camera->cursorX>=494&&camera->cursorX<=549&&//music 
               camera->cursorY>=220&&camera->cursorY<=280
               &&mc->displayStats==FALSE)
            {
 	      if(mc->musicMuted==FALSE)
              {
                mc->musicMuted=TRUE;
              }else { mc->musicMuted=FALSE; }
  
            }
            else if(camera->cursorX>=550&&camera->cursorX<=610&&//fx
               camera->cursorY>=220&&camera->cursorY<=280
               &&mc->displayStats==FALSE)
            {
 	      
 	      if(mc->fxMuted==FALSE)
              {
                mc->fxMuted=TRUE;
              }else { mc->fxMuted=FALSE; }
            }
           
  
	    break;
	  case MSG_KEY_UP:
	   case '\n':
            keys.enter=FALSE;
       	    break;
	   case 0:
	    switch(arg2.u8[0])
	      {
                break;
	      case SC_CURSOR_LEFT:
	        keys.left=FALSE;
	        break;
	      case SC_CURSOR_RIGHT:
	        keys.right=FALSE;
	        break;
	      case SC_CURSOR_UP:
	        keys.up=FALSE;
	        break;
	      caseSC_CURSOR_DOWN:
	        keys.down=FALSE;
	        break;
	    }
	   break;
	  case MSG_KEY_DOWN:
	    switch(arg1)
	      {
	      case 'I':
              case 'i':
                mc->displayInventory=TRUE; 
                break;
           
	      //case CH_ESC:
	      case CH_SHIFT_ESC:
	        goto fs_end;
	        break;
              case '\n':
                keys.enter=TRUE;
       		break;
	      case 0:
	        switch(arg2.u8[0])
		  {
		  case SC_CURSOR_LEFT:
		    keys.left=TRUE;
		    break;
		  case SC_CURSOR_RIGHT:
		    keys.right=TRUE;
		    break;
		  case SC_CURSOR_UP:
		    keys.up=TRUE;
		    break;
		  case SC_CURSOR_DOWN:
		    keys.down=TRUE;
		    break;
	        }
	        break;
	    }
	    break;
          }
	  break;
	  case 2://character creation
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        if(camera->cursorX>=386&&camera->cursorX<=429)
		  {
		  if(camera->cursorY>300&&camera->cursorY<336)
		    { //tribe
		    IncSelect(0);
		  } else if(camera->cursorY>348&&camera->cursorY<382)
		    {//hair
		    IncSelect(1);
		  } else if(camera->cursorY>400&&camera->cursorY<432)
		    {//face
		    IncSelect(2);
		  }
	        }
	        if(camera->cursorX>=476&&camera->cursorX<=603)
		  {
		  if(camera->cursorY>=370&&camera->cursorY<=434)
		    {//next scene
		    U8 tribe = GetSelectedStats(0);
		    U8 str,con,int,wis;
		    switch(tribe)
		      {
		      case 0:
		        str=10;con=10;int=10;wis=10;
		        break;
		      case 1:
		        str=5;con=5;int=15;wis=15;
		        break;
		      case 2:
		        str=5;con=15;int=5;wis=15;
		        break;
		      case 3:
		        str=15;con=15;int=5;wis=5;
		        break;
		    }
		    ResetCurrLetter;
		    mc->cutsceneTarget=0;
		    SetNPC(MakeActor(0,tribe,GetSelectedStats(1),GetSelectedStats(2), 
			  0,0,0,0,0,
			  0,0,0,0,
			  5,5,str,int,con,wis,0));
		    mc->currentMenu=1;
                    mc->currentSong=0;
		  }
	        }
	        break;
	    }
	    break;
	  case 3://cutscene
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        mc->cutsceneTarget++;
	        ResetCurrLetter;
	        if(mc->cutsceneTarget>2)
		  {
		  mc->currentMenu=2;
                  mc->currentSong=2;
	        }
	        break;
	    }

	    break;
	  case 4://load menu
	    CDirEntry *cur;
	    I64 yInc=0,i;
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        if(camera->cursorX>=19&&camera->cursorX<=187&&camera->cursorY>=18&&camera->cursorY<=58)
		  {
		  mc->currentMenu=0;
	        }
	        for(cur=loadRoot;cur!=NULL;cur=cur->next)
		  {
		  if(camera->cursorX>=190&&camera->cursorX<=590)
		  {
		    if(camera->cursorY>=yInc&&camera->cursorY<=yInc+25)
		    {
                      U8* edit = cur->name;
                      edit =MStrPrint("%s%s","Saves/",edit);
                                                               
		      LoadGame(edit);

		    }
		  }
		  yInc+=40;
	        }

	        break;
	    }
	    break;

        }
        Refresh;

    }
fs_end:
    //DCFill;
    DCDel(dc);
    CleanUp;

}
  RPGMain;