

U0 RenderCharacter(CDC *dc,I64 iFinalX, I64 iFinalY,I64 iFinalZ,
           CDC *character,Bool highlight=FALSE)
{
    GrBlot3(dc,iFinalX,iFinalY,iFinalZ,character);

    if(highlight){
       //HighlightTarget(dc, iFinalX, iFinalY+24,iFinalZ+10);
    }
}



U0 StartCameraPan(CDC *dc,Actor *p)
{
 dc->thick=1;
 // background world x pan
 if(camera->topLR==0||camera->topLR==wX-11){
  if(camera->cameraOffSetX!=0){
   if(camera->cameraOffSetX>0){
    camera->cameraOffSetX=Max(0,camera->cameraOffSetX-1);
   }
   else{
    camera->cameraOffSetX=Min(0,camera->cameraOffSetX+1); 
   }
  }
 }
 else{
  camera->cameraOffSetX=-GetWalkOffsetX(p->walking);
 }
 //y pan
 if(camera->topUD==0||camera->topUD==wY-11){
  if(camera->cameraOffSetY!=0){
   if(camera->cameraOffSetY>0)
    camera->cameraOffSetY=Max(0,camera->cameraOffSetY-1);
   else
    camera->cameraOffSetY=Min(0,camera->cameraOffSetY+1);
  }
 }
 else{
  camera->cameraOffSetY=-GetWalkOffsetY(p->walking);
 }
}

U0 ReDrawWorld(CDC *dc, I64 i, I64 j)
{
  for(i=-1;i<12;i++){
    if(camera->topLR+i<wX&&camera->topLR+i>=0){
     for(j=-1;j<12;j++){
      if(camera->topUD+j<wY&&camera->topUD+j>=0){
       I16 c =  GetTensor(world->level,camera->topLR+i,camera->topUD+j,world->currentZ);
       dc->color = GetBG(c);
       GrRect3(dc,i*camera->dividX+camera->cameraOffSetX, 
                j*camera->dividY+camera->cameraOffSetY, -1,
                camera->dividX, camera->dividY);
       if(c>16){
        switch(c){
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

}

U0 DrawActorsAndItems(CDC *dc,Actor *p, I64 i, I64 j, I64 l)
{//draw npcs and items
 for(j=-1;j<12;j++){
  if(camera->topUD+j<wX&&camera->topUD+j>=0){
    for(i=-1;i<12;i++){
     if(camera->topLR+i<wY&&camera->topLR+i>=0){//ITEMS
      MapNode *mn = GetTensorItem(world->level,
                    camera->topLR+i,camera->topUD+j, 
                    world->currentZ);
      for(l=0;l<mn->len;l++){
       I64 item = (GetItem(mn,l))->id;
       switch(item){
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
     //Actors start by converting matrix x,y position to screen X,Y
     I64 convertedToScreenX,convertedToScreenY;
     if(npc!=-1){
      Actor *toRender;
      I64 npcOffsetX=-camera->cameraOffSetX, npcOffsetY=-camera->cameraOffSetY;
      if(npc!=0){
       toRender = GetNPC(npc);
       npcOffsetX=GetWalkOffsetX(toRender->walking), 
       npcOffsetY=GetWalkOffsetY(toRender->walking);
       convertedToScreenX = i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX;
       convertedToScreenY = j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY;
      }
      else {
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
       if(mc->combatON==FALSE   && toRender->ai_script==1&&
          toRender->dead==FALSE && //(enemy)
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


}


U0 DrawHealthMana(CDC *dc,Actor *p,I64 i, I64 j){
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

}


U0 PickUpItemTrigger(Actor *p,MapNode *puin)
{

 if(puin->len>0)
 {
  I64 pui = (PickUpItem(puin,0))->id;
  mc->reRenderInv=TRUE;       
  if(!AddItemToInventory(0,pui))
  {
   Play("ArE"); 
  }
 }

}