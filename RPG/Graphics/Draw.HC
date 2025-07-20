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
       if(c>BG_LT_GRAY){
        switch(c){
        case BG_DK_GRAY:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetWall1());
        break;
        case BG_LT_RED:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetCarpet());
        break;
        case BG_ROCK_WALL:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetRockWall());
        break;
        case BG_BUSH_WALL:
        Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetBushWall());
 
        break;
        } 
       }
      }
     }
    }
   }

}

//i - x coordinate of node
//j - y coordinate of node
//l - size of item array on layer (multidraw)
U0 DrawItemsOnLayer(CDC *dc, I64 i,I64 j,I64 l)
{

 MapNode *mn = GetTensorItem(world->level,
                    camera->topLR+i,camera->topUD+j, 
                    world->currentZ);
 for(l=0;l<mn->len;l++){
  I64 item = (GetItem(mn,l))->id;
  switch(item){
   case IT_DAGGER:
    GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM1);
    break;
   case IT_HARPOON:
    GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM2);
    break;
   case IT_HELM:
    GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM5);
   break;
   case IT_SHIRT:
    GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM6);
    break;
   default:
    break;
  }
 } 
}



U0 DrawObjsOnLayer(CDC *dc, I64 obj, 
                   I64 screenX, I64 screenY, Actor *p)
{
 switch(obj)
 {
  case OBJ_WOOD:
   Sprite3(dc,screenX, screenY,20,GetFurniture(obj));
   if(!HasDirective(EFFFIRE,p))
   {
    AddDirective(EFFFIRE,p,screenX-32,screenY-25);
   }
   else
   {
    UpdateDirective(EFFFIRE,p,screenX-32,screenY-25,30);
   }
  break;
  case SP_FISHING_SPOT:
   if(world->timer<FRAMERULE_CAP/2){ 
    GrBlot3(dc,screenX-6-13,screenY-16,10,SPECIAL1);
   }else{
    GrBlot3(dc,screenX-6-13, screenY-16,10, SPECIAL2);
  
   } 
  break;
  case OBJ_CHEST:
  Sprite3(dc, screenX-16, screenY-12, 10, GetFurniture(obj));
  break;
 
  default:
  Sprite3(dc,screenX, screenY,10,GetFurniture(obj));
  break;
 }
}

U0 DrawActorsOnLayer(CDC *dc,I64 npc, 
 I64 i, I64 j, 
 Actor *p, I64 wlvl)
{
 //Actors start by converting matrix x,y position to screen X,Y
 Actor *toRender;
 I64 npcOffX=-camera->cameraOffSetX; 
 I64 npcOffY=-camera->cameraOffSetY;


 Bool isPlayer=FALSE;
 if(npc==PLAYER){
  isPlayer=TRUE;
  toRender = p; 
 }else {  toRender = GetNPC(npc); }

 Bool isAnimated = HasDirective(BOUNCE,toRender);

 if(isPlayer||(!isAnimated)){
  GetActorScreenX(toRender,npcOffX,i,isPlayer);
  GetActorScreenY(toRender,npcOffY,j,isPlayer);
 }

 if(isAnimated&&GetNPC(PLAYER)->walking!=DIR_IDLE){
  UpdateDirective(BOUNCE,toRender,    
   GetActorScreenX(toRender,npcOffX,i,isPlayer),
   GetActorScreenY(toRender,npcOffY,j,isPlayer),0);
 }

 switch(mc->combatMenuStage)
 {
  case STAGE_0:
   switch(mc->combatMenuSelection)
   {
    case CS_PRAYER:
     DrawPrayerHotbar(dc);
     break;
   }
  break;
 }   
 Bool isHighlight =FALSE;  
 isHighlight = CheckTarget(toRender);
      
 RenderCharacter(dc,toRender->screenX,toRender->screenY,
 10, GetActorAnimationJob(toRender,wlvl), isHighlight);
}   

U0 DrawActorsAndItems(CDC *dc,Actor *p, I64 i, I64 j, I64 l)
{//draw npcs and items
 for(j=-1;j<12;j++){
  if(camera->topUD+j<wX&&camera->topUD+j>=0){
   I64 screenY = j*camera->dividY+camera->cameraOffSetY; 
   for(i=-1;i<12;i++){
    if(camera->topLR+i<wY&&camera->topLR+i>=0){
     I64 screenX = i*camera->dividX+camera->cameraOffSetX;

     I64 obj= GetTensorObj(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
     I64 npc= GetTensorNPC(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
     I64 wlvl= GetTensorWaterLevel(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     

     if(obj!=IT_NULL)
      DrawObjsOnLayer(dc,obj,screenX,screenY,p);
     DrawItemsOnLayer(dc,i,j,l);
     if(npc!=IT_NULL)
      DrawActorsOnLayer(dc,npc,i,j,p,wlvl); 
          
    }//if too large x
   }//for x
   CheckAnimQueue(dc,screenY);//compute animations by row 
  }//if too large y
 }//for y
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
   PrintLine(dc,t1,500,347,1);
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
   PrintLine(dc,t1,580,347,1);
}
