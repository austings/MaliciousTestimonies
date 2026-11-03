
CDC *GetActorAnimationJob(Actor *a,I64 wlvl){
 CDC *completeActor = DCNew(500,500);
 DCFill(completeActor, TRANSPARENT);

 if(HasStatus(a,LIFE_DEAD)||HasStatus(a,LIFE_DYING)){
   DrawDead(completeActor,a);
   return completeActor;
 }
 switch(a->face){
   case T_JUDA...T_BENJ:
    completeActor = GetWalkAnimation(a,completeActor);
   break;
   case T_DOG:
    Sprite3B(completeActor,0,32,10,GetDog);
   break;
   case T_FOWL:
    Sprite3B(completeActor,0,32,10,GetFowl);
   break;
   case T_OX:
    Sprite3B(completeActor,0,32,10,GetOx);
   break;
   default:
    completeActor = GetWalkAnimation(a,completeActor);
   break;
 } 

 OverlayArmor(completeActor,a);
 //todo make status effects?
 if(wlvl>0)
 {
  a->screenY+=(wlvl+a->walking);
  completeActor->color = TRANSPARENT;
  GrRect3(completeActor,0,60,0,100,100);
 }
 return completeActor;

}



I64 GetActorScreenX(Actor *a, I64 npcox, I64 i, Bool Player=TRUE){
 if(Player){
  if(camera->topLR==0||camera->topLR==wX-11)
   npcox =GetWalkOffsetX(a->walking);
  a->screenX = i*camera->dividX-13+
                          npcox+camera->cameraOffSetX;
  return a->screenX;
 }else
 {
   npcox=GetWalkOffsetX(a->walking), 
   a->screenX = i*camera->dividX-13+npcox+(2*camera->cameraOffSetX);
  return a->screenX;
 }
}

I64 GetActorScreenY(Actor *a, I64 npcoy, I64 j,Bool Player=TRUE){
 if(Player){
  if(camera->topUD==0||camera->topUD==wY-11)
   npcoy =GetWalkOffsetY(a->walking);
  a->screenY = j*camera->dividY-42+
                          npcoy+camera->cameraOffSetY;
  return a->screenY;
 }else
 {
  npcoy=GetWalkOffsetY(a->walking);
  a->screenY = j*camera->dividY-42+npcoy+camera->cameraOffSetY;
  return a->screenY;
 }
}

Actor *GetActorAtMouseOld(I64 mx, I64 my){
 CombatTurn *ct = combatCQue.next;
 I64 index = 0;
 while(ct != &combatCQue){
  Actor *it = ct->ready;    
  if(it->visible){
   I64 ax = it->screenX;
   I64 ay = it->screenY;
   U8 *msg = MStrPrint("ACTOR:%d,%d - MOUSE:%d,%d",ax,ay,mx,my);
   // same offset used in HighlightTarget
   if(InRect(mx, my, ax, ay, ax+50, ay+70)){
    mc->targetCTPIndex = index;
    return it;
   }
  }

  ct = ct->next;
  index++;
 }

 return NULL;
}
Actor *GetActorAtMouse(I64 mx, I64 my)
{
    CombatTurn *ct = combatCQue.next;
    I64 index = 0;
    Actor *p = GetPlayer;

    while(ct != &combatCQue)
    {
        Actor *it = ct->ready;

        if(it && it->visible)
        {
            I64 ax = it->screenX;
            I64 ay = it->screenY;

            if(InRect(mx, my, ax, ay, ax+50, ay+70))
            {
                if(CanTargetForAction(p, it))
                {
                    mc->targetCTPIndex = index;
                    return it;
                }
            }
        }

        ct = ct->next;
        index++;
    }

    return NULL;
}
U0 StartCameraPan(CDC *dc,Actor *p){
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
 else if(camera->cameraMovedThisStep){
  camera->cameraOffSetX = -GetWalkOffsetX(p->walking);
 }
 else{
   camera->cameraOffSetX = 0;
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
 else if(camera->cameraMovedThisStep){
  camera->cameraOffSetY=-GetWalkOffsetY(p->walking);
 }
 else{
  camera->cameraOffSetY=0;
 }
}

U0 CombatQueInit(Actor **enemies,I64 count)
{
 CombatTurn *ctn;
 I64 i;

 mc->combatON = TRUE;
 mc->lootedSwitch = FALSE;
 mc->combatMenuStage = STAGE_0;
 mc->combatMenuSelection = CMS_MOVE;
 mc->turnIndex = 1;
 mc->currentSong = 5;
 mc->combatTurn=0;

 QueInit(&combatCQue);

 ctn = CAlloc(sizeof(CombatTurn));
 ctn->ready = GetPlayer();
 QueIns(ctn,combatCQue.last);

 for(i=0;i<count;i++){
  if(HasStatus(enemies[i],LIFE_DYING)||HasStatus(enemies[i],LIFE_DEAD))
   goto skipcount;

  ctn=CAlloc(sizeof(CombatTurn));
  ctn->ready=enemies[i];
  QueIns(ctn,combatCQue.last);

  AddDirective(BOUNCE,enemies[i]);
  skipcount:
 }

 ctp=combatCQue.next;
 targetCTP=combatCQue.next;
 CombatTurn *it = combatCQue.next;
 PrintDevMessage("=== Combat Queue Init ===",FALSE);

 i = 0;

 while(it != &combatCQue){
  PrintDevMessage(MStrPrint("QUEUE[%d] actor=%d name=%s",
  i,
  it->ready->id,
  it->ready->name
  ));

  it = it->next;
  i++;
 }
  it = it->next;

}


U0 RenderCharacter(CDC *dc,I64 iFinalX, I64 iFinalY,I64 iFinalZ,
           CDC *character,Bool highlight=FALSE)
{
 if(highlight){
  HighlightTarget(dc, iFinalX, iFinalY+24,iFinalZ+10);
 }
 GrBlot3(dc,iFinalX,iFinalY,iFinalZ,character);

}


I64 TerritoryColor(I64 faction)
{
 switch(faction){
  case FACTION_ISRAEL: return GREEN;
  case FACTION_JUDAH: return RED;
  case FACTION_PHILISTIA: return BLUE;
  case FACTION_PHOENICIA: return CYAN;
  case FACTION_ARAM: return LTRED;
  case FACTION_AMMON: return YELLOW;
  case FACTION_MOAB: return LTGRAY;
  case FACTION_EDOM: return BROWN;
  default: return YELLOW;
 }
}

#define STRATEGIC_MAP_TOP 50
#define STRATEGIC_MAP_VIEW_H 360
#define STRATEGIC_MAP_WORLD_W 900
#define STRATEGIC_MAP_WORLD_H 700

U0 GetTerritoryPolygon(I64 id,I64 *px,I64 *py,I64 *pointCount)
{
 *pointCount=0;
 switch(id){
  case 0: // Kingdom of Israel, centered on Samaria
   *pointCount=10;
   px[0]=345;py[0]=265; px[1]=405;py[1]=238;
   px[2]=485;py[2]=245; px[3]=535;py[3]=280;
   px[4]=520;py[4]=330; px[5]=505;py[5]=378;
   px[6]=455;py[6]=397; px[7]=390;py[7]=377;
   px[8]=350;py[8]=340; px[9]=332;py[9]=300;
  break;
  case 1: // Judah
   *pointCount=8;
   px[0]=365;py[0]=375; px[1]=415;py[1]=388;
   px[2]=460;py[2]=398; px[3]=510;py[3]=370;
   px[4]=548;py[4]=408; px[5]=552;py[5]=462;
   px[6]=520;py[6]=505; px[7]=463;py[7]=525;
   px[8]=405;py[8]=500; px[9]=374;py[9]=452;
   *pointCount=10;
  break;
  case 2: // Philistine coastal cities
   *pointCount=7;
   px[0]=292;py[0]=355; px[1]=340;py[1]=345;
   px[2]=370;py[2]=372; px[3]=365;py[3]=425;
   px[4]=338;py[4]=462; px[5]=300;py[5]=440;
   px[6]=280;py[6]=398;
  break;
  case 3: // Edom south of Moab
   *pointCount=8;
   px[0]=510;py[0]=500; px[1]=555;py[1]=470;
   px[2]=620;py[2]=490; px[3]=650;py[3]=540;
   px[4]=642;py[4]=610; px[5]=610;py[5]=665;
   px[6]=555;py[6]=650; px[7]=515;py[7]=600;
  break;
  case 4: // Phoenician coast
   *pointCount=9;
   px[0]=285;py[0]=65; px[1]=365;py[1]=55;
   px[2]=425;py[2]=68; px[3]=445;py[3]=110;
   px[4]=425;py[4]=158; px[5]=390;py[5]=192;
   px[6]=330;py[6]=180; px[7]=288;py[7]=140;
   px[8]=270;py[8]=100;
  break;
  case 5: // Galilee
   *pointCount=8;
   px[0]=330;py[0]=178; px[1]=380;py[1]=160;
   px[2]=440;py[2]=175; px[3]=493;py[3]=192;
   px[4]=520;py[4]=223; px[5]=505;py[5]=263;
   px[6]=480;py[6]=281; px[7]=425;py[7]=261;
   px[8]=375;py[8]=275; px[9]=335;py[9]=238;
   *pointCount=10;
  break;
  case 6: // Aram-Damascus, east of the Jordan
   *pointCount=10;
   px[0]=425;py[0]=60; px[1]=540;py[1]=38;
   px[2]=670;py[2]=50; px[3]=760;py[3]=92;
   px[4]=790;py[4]=145; px[5]=770;py[5]=202;
   px[6]=720;py[6]=250; px[7]=660;py[7]=278;
   px[8]=595;py[8]=252; px[9]=525;py[9]=225;
   px[10]=480;py[10]=185; px[11]=445;py[11]=145;
   *pointCount=12;
  break;
  case 7: // Ammon
   *pointCount=8;
   px[0]=535;py[0]=275; px[1]=595;py[1]=250;
   px[2]=665;py[2]=270; px[3]=715;py[3]=310;
   px[4]=730;py[4]=355; px[5]=708;py[5]=400;
   px[6]=667;py[6]=430; px[7]=610;py[7]=420;
   px[8]=565;py[8]=390; px[9]=530;py[9]=350;
   *pointCount=10;
  break;
  case 8: // Moab
   *pointCount=9;
   px[0]=530;py[0]=420; px[1]=570;py[1]=390;
   px[2]=620;py[2]=420; px[3]=665;py[3]=435;
   px[4]=680;py[4]=485; px[5]=650;py[5]=520;
   px[6]=615;py[6]=550; px[7]=565;py[7]=530;
   px[8]=530;py[8]=490;
  break;
 }
}

Bool StrategicPointInPolygon(I64 *px,I64 *py,I64 pointCount,
                             I64 pointX,I64 pointY)
{
 I64 i,j,crossX;
 Bool inside=FALSE;
 j=pointCount-1;
 for(i=0;i<pointCount;i++){
  if((py[i]>pointY)!=(py[j]>pointY)){
   crossX=px[i]+(px[j]-px[i])*(pointY-py[i])/(py[j]-py[i]);
   if(pointX<crossX) inside=!inside;
  }
  j=i;
 }
 return inside;
}

U0 FillStrategicPolygon(CDC *dc,I64 *px,I64 *py,I64 pointCount,
                        I64 color)
{
 I64 i,j,y,minY,maxY,intersectionCount,temp,xLeft,xRight;
 I64 intersections[16];
 minY=py[0]; maxY=py[0];
 for(i=1;i<pointCount;i++){
  if(py[i]<minY) minY=py[i];
  if(py[i]>maxY) maxY=py[i];
 }
 minY=Max(minY,world->mapPanY);
 maxY=Min(maxY,world->mapPanY+STRATEGIC_MAP_VIEW_H);
 dc->color=color;
 for(y=minY;y<maxY;y++){
  intersectionCount=0;
  j=pointCount-1;
  for(i=0;i<pointCount;i++){
   if((py[i]<=y && py[j]>y) || (py[j]<=y && py[i]>y)){
    intersections[intersectionCount++]=
      px[i]+(px[j]-px[i])*(y-py[i])/(py[j]-py[i]);
   }
   j=i;
  }
  for(i=0;i<intersectionCount;i++){
   for(j=i+1;j<intersectionCount;j++){
    if(intersections[j]<intersections[i]){
     temp=intersections[i];
     intersections[i]=intersections[j];
     intersections[j]=temp;
    }
   }
  }
  for(i=0;i+1<intersectionCount;i+=2){
   xLeft=intersections[i]-world->mapPanX;
   xRight=intersections[i+1]-world->mapPanX;
   if(xRight>xLeft)
    GrRect3(dc,xLeft,STRATEGIC_MAP_TOP+y-world->mapPanY,
            0,xRight-xLeft,1);
  }
 }
}

U0 OutlineStrategicPolygon(CDC *dc,I64 *px,I64 *py,I64 pointCount,
                           I64 color)
{
 I64 i,j;
 dc->color=color;
 for(i=0;i<pointCount;i++){
  j=i+1;
  if(j>=pointCount) j=0;
  GrLine(dc,px[i]-world->mapPanX,
         STRATEGIC_MAP_TOP+py[i]-world->mapPanY,
         px[j]-world->mapPanX,
         STRATEGIC_MAP_TOP+py[j]-world->mapPanY);
 }
}

Bool SelectTerritoryOnStrategicMap(I64 mx,I64 my)
{
 I64 i,worldX,worldY,pointCount,px[16],py[16];
 world->selectedTerritory=-1;
 if(my<STRATEGIC_MAP_TOP || my>=STRATEGIC_MAP_TOP+STRATEGIC_MAP_VIEW_H)
  return FALSE;
 worldX=mx+world->mapPanX;
 worldY=my-STRATEGIC_MAP_TOP+world->mapPanY;
 for(i=0;i<world->territoryCount;i++){
  GetTerritoryPolygon(i,px,py,&pointCount);
  if(TerritoryDirectionTo(world->currentTerritory,i) &&
     StrategicPointInPolygon(px,py,pointCount,worldX,worldY)){
   world->selectedTerritory=i;
   world->mapLoadFailed=FALSE;
   return TRUE;
  }
 }
 return FALSE;
}

U0 PanStrategicMap(I64 dx,I64 dy)
{
 world->mapPanX=Min(Max(world->mapPanX+dx,0),
                     STRATEGIC_MAP_WORLD_W-SCREENX-SIDEX);
 world->mapPanY=Min(Max(world->mapPanY+dy,0),
                     STRATEGIC_MAP_WORLD_H-STRATEGIC_MAP_VIEW_H);
}

U0 DrawStrategicFeatures(CDC *dc)
{
 I64 x1,y1,x2,y2;
 dc->color=CYAN;
 GrLine(dc,505-world->mapPanX,STRATEGIC_MAP_TOP+185-world->mapPanY,
            520-world->mapPanX,STRATEGIC_MAP_TOP+275-world->mapPanY);
 GrLine(dc,520-world->mapPanX,STRATEGIC_MAP_TOP+275-world->mapPanY,
            535-world->mapPanX,STRATEGIC_MAP_TOP+360-world->mapPanY);
 GrLine(dc,535-world->mapPanX,STRATEGIC_MAP_TOP+360-world->mapPanY,
            550-world->mapPanX,STRATEGIC_MAP_TOP+430-world->mapPanY);

 I64 lakeX[8],lakeY[8];
 lakeX[0]=500;lakeY[0]=184; lakeX[1]=514;lakeY[1]=176;
 lakeX[2]=528;lakeY[2]=184; lakeX[3]=532;lakeY[3]=198;
 lakeX[4]=519;lakeY[4]=207; lakeX[5]=505;lakeY[5]=202;
 FillStrategicPolygon(dc,lakeX,lakeY,6,BLUE);
 lakeX[0]=535;lakeY[0]=420; lakeX[1]=550;lakeY[1]=408;
 lakeX[2]=565;lakeY[2]=430; lakeX[3]=565;lakeY[3]=458;
 lakeX[4]=552;lakeY[4]=482; lakeX[5]=540;lakeY[5]=460;
 FillStrategicPolygon(dc,lakeX,lakeY,6,BLUE);
 dc->color=LTGRAY;
 x1=85-world->mapPanX;
 y1=STRATEGIC_MAP_TOP+260-world->mapPanY;
 PrintLine(dc,"MEDITERRANEAN",x1,y1);
 dc->color=CYAN;
 x1=548-world->mapPanX;
 y1=STRATEGIC_MAP_TOP+470-world->mapPanY;
 PrintLine(dc,"Dead Sea",x1,y1);
}

static CDC *STRATEGIC_CAS1=FramePtr("CAS1");
static CDC *STRATEGIC_VIL1=FramePtr("VIL1");
static CDC *STRATEGIC_CAS1_SMALL=NULL;
static CDC *STRATEGIC_VIL1_SMALL=NULL;

CDC *GetStrategicMapIcon(CDC *source,CDC **scaled)
{
 F64 scale;
 if(!source || source->width<=0 || source->height<=0) return NULL;
 if(!*scaled){
  // Keep more of the WAD sprite's native detail while fitting comfortably
  // beside the settlement labels on the strategic map.
  scale=40.0/source->width;
  if(source->height*scale>40.0)
   scale=40.0/source->height;
  *scaled=DCScaled(source,scale,scale);
 }
 return *scaled;
}

Bool TerritoryUsesCastleIcon(I64 id)
{
 // Samaria is the starting stronghold; the other fortified regional
 // capitals use the same castle marker.
 if(id==0 || id==1 || id==4 || id==5 || id==6 || id==7)
  return TRUE;
 return FALSE;
}

U0 TerritoryLabelPosition(I64 id,I64 *regionX,I64 *regionY,
                          I64 *cityX,I64 *cityY)
{
 switch(id){
  case 0: *regionX=385; *regionY=285; *cityX=428; *cityY=319; break;
  case 1: *regionX=420; *regionY=415; *cityX=458; *cityY=452; break;
  case 2: *regionX=296; *regionY=379; *cityX=305; *cityY=417; break;
  case 3: *regionX=552; *regionY=560; *cityX=574; *cityY=608; break;
  case 4: *regionX=300; *regionY=91; *cityX=320; *cityY=128; break;
  case 5: *regionX=365; *regionY=194; *cityX=422; *cityY=224; break;
  case 6: *regionX=555; *regionY=78; *cityX=603; *cityY=150; break;
  case 7: *regionX=594; *regionY=289; *cityX=628; *cityY=349; break;
  default:*regionX=555; *regionY=438; *cityX=588; *cityY=486; break;
 }
}

U0 DrawStrategicSettlementIcons(CDC *dc)
{
 I64 i,regionX,regionY,cityX,cityY;
 CDC *settlementIcon;
 Territory *t;
 for(i=0;i<world->territoryCount;i++){
  t=world->territories[i];
  TerritoryLabelPosition(i,&regionX,&regionY,&cityX,&cityY);
  if(TerritoryUsesCastleIcon(i))
   settlementIcon=GetStrategicMapIcon(STRATEGIC_CAS1,
                                     &STRATEGIC_CAS1_SMALL);
  else
   settlementIcon=GetStrategicMapIcon(STRATEGIC_VIL1,
                                     &STRATEGIC_VIL1_SMALL);
  if(settlementIcon){
   // Draw with the 2D blitter after map fills and features, avoiding reliance
   // on depth-buffer ordering for the strategic symbols.
   GrBlot(dc,cityX-settlementIcon->width/2-world->mapPanX,
          STRATEGIC_MAP_TOP+cityY-settlementIcon->height/2-world->mapPanY,
          settlementIcon);
   dc->color=WHITE;
   PrintLine(dc,t->settlement,
             cityX+settlementIcon->width/2+4-world->mapPanX,
             STRATEGIC_MAP_TOP+cityY-4-world->mapPanY);
  } else {
   dc->color=YELLOW;
   GrRect3(dc,cityX-world->mapPanX,
           STRATEGIC_MAP_TOP+cityY-world->mapPanY,0,5,5);
   dc->color=WHITE;
   PrintLine(dc,t->settlement,cityX+8-world->mapPanX,
             STRATEGIC_MAP_TOP+cityY-2-world->mapPanY);
  }
 }
}

U0 RenderWorldMap(CDC *dc)
{
 I64 i,pointCount,connected,regionX,regionY,cityX,cityY;
 I64 px[16],py[16],landX[16],landY[16];
 U8 *currentLocation;
 DCFill(dc,BLACK);
 GrRect3(dc,0,STRATEGIC_MAP_TOP,0,SCREENX+SIDEX,
         STRATEGIC_MAP_VIEW_H);
 dc->color=BLUE;
 landX[0]=270;landY[0]=0; landX[1]=900;landY[1]=0;
 landX[2]=900;landY[2]=700; landX[3]=370;landY[3]=700;
 landX[4]=345;landY[4]=630; landX[5]=320;landY[5]=560;
 landX[6]=300;landY[6]=470; landX[7]=288;landY[7]=380;
 landX[8]=278;landY[8]=285; landX[9]=285;landY[9]=190;
 landX[10]=268;landY[10]=120; landX[11]=275;landY[11]=65;
 FillStrategicPolygon(dc,landX,landY,12,DKGRAY);
 Territory *t;
 for(i=0;i<world->territoryCount;i++){
  t=world->territories[i];
  GetTerritoryPolygon(i,px,py,&pointCount);
  FillStrategicPolygon(dc,px,py,pointCount,
                       TerritoryColor(t->ownerFaction));
 }
 for(i=0;i<world->territoryCount;i++){
  t=world->territories[i];
  GetTerritoryPolygon(i,px,py,&pointCount);
  connected=TerritoryDirectionTo(world->currentTerritory,i)!=0;
  if(i==world->selectedTerritory)
   OutlineStrategicPolygon(dc,px,py,pointCount,YELLOW);
  else if(i==world->currentTerritory)
   OutlineStrategicPolygon(dc,px,py,pointCount,WHITE);
  else if(connected)
   OutlineStrategicPolygon(dc,px,py,pointCount,LTGRAY);
  else
   OutlineStrategicPolygon(dc,px,py,pointCount,BLACK);

  TerritoryLabelPosition(i,&regionX,&regionY,&cityX,&cityY);
  dc->color=WHITE;
  PrintLine(dc,t->name,regionX-world->mapPanX,
            STRATEGIC_MAP_TOP+regionY-world->mapPanY);
 }
 DrawStrategicFeatures(dc);
 DrawStrategicSettlementIcons(dc);

 GrRect3(dc,0,0,0,SCREENX+SIDEX,STRATEGIC_MAP_TOP);
 dc->color=WHITE;
 PrintLine(dc,"ISRAEL AND ITS NEIGHBORS - 9TH CENTURY BCE",92,12);
 dc->color=LTGRAY;
 PrintLine(dc,"North is up | borders show regional political control",112,32);
 currentLocation=MStrPrint("Current location: %s",
   world->territories[world->currentTerritory]->settlement);
 dc->color=YELLOW;
 PrintLine(dc,currentLocation,455,32);
 Free(currentLocation);
 GrRect3(dc,0,STRATEGIC_MAP_TOP+STRATEGIC_MAP_VIEW_H,
         0,SCREENX+SIDEX,70);
 dc->color=WHITE;
 PrintLine(dc,"FACTIONS",28,416);
 dc->color=TerritoryColor(FACTION_ISRAEL); PrintLine(dc,"Israel",28,436);
 dc->color=TerritoryColor(FACTION_JUDAH); PrintLine(dc,"Judah",91,436);
 dc->color=TerritoryColor(FACTION_PHILISTIA); PrintLine(dc,"Philistia",151,436);
 dc->color=TerritoryColor(FACTION_PHOENICIA); PrintLine(dc,"Phoenicia",226,436);
 dc->color=TerritoryColor(FACTION_ARAM); PrintLine(dc,"Aram",308,436);
 dc->color=TerritoryColor(FACTION_AMMON); PrintLine(dc,"Ammon",355,436);
 dc->color=TerritoryColor(FACTION_MOAB); PrintLine(dc,"Moab",413,436);
 dc->color=TerritoryColor(FACTION_EDOM); PrintLine(dc,"Edom",462,436);
 dc->color=LTGRAY;
 PrintLine(dc,"Arrows: pan | click neighbor + Enter: travel | Escape: return",28,458);
 if(world->mapLoadFailed){
  dc->color=RED;
  PrintLine(dc,"Destination load failed; choose another region or press Escape",28,474);
 }
}

U0 ClampMiniMapPan()
{
 I64 maxPanX=wX-MINIMAP_VIEW_TILES_X;
 I64 maxPanY=wY-MINIMAP_VIEW_TILES_Y;
 if(maxPanX<0) maxPanX=0;
 if(maxPanY<0) maxPanY=0;
 mc->miniMapPanX=Min(Max(mc->miniMapPanX,0),maxPanX);
 mc->miniMapPanY=Min(Max(mc->miniMapPanY,0),maxPanY);
}

U0 PanMiniMap(I64 dx,I64 dy)
{
 mc->miniMapPanX+=dx;
 mc->miniMapPanY+=dy;
 ClampMiniMapPan;
}

U0 HandleMiniMapClick(I64 mx,I64 my)
{
 I64 viewX=MINIMAP_WINDOW_X+MINIMAP_VIEW_X;
 I64 viewY=MINIMAP_WINDOW_Y+MINIMAP_VIEW_Y;
 I64 tileX,tileY;
 if(InRect(mx,my,MINIMAP_CLOSE_X1,MINIMAP_CLOSE_Y1,
           MINIMAP_CLOSE_X2,MINIMAP_CLOSE_Y2)){
  mc->displayMiniMap=FALSE;
  return;
 }
 if(!InRect(mx,my,viewX,viewY,viewX+MINIMAP_VIEW_W,
            viewY+MINIMAP_VIEW_H))
  return;
 tileX=mc->miniMapPanX+(mx-viewX)/MINIMAP_TILE_SIZE;
 tileY=mc->miniMapPanY+(my-viewY)/MINIMAP_TILE_SIZE;
 mc->miniMapPanX=tileX-MINIMAP_VIEW_TILES_X/2;
 mc->miniMapPanY=tileY-MINIMAP_VIEW_TILES_Y/2;
 ClampMiniMapPan;
}

U0 DrawMiniMap(CDC *dc,Actor *player)
{
 I64 i,j,tile,tileX,tileY,screenX,screenY;
 I64 pathX,pathY,k;
 MapNode *node;
 I64 winX=MINIMAP_WINDOW_X,winY=MINIMAP_WINDOW_Y;
 I64 viewX=winX+MINIMAP_VIEW_X,viewY=winY+MINIMAP_VIEW_Y;

 ClampMiniMapPan;
 dc->color=BLACK;
 GrRect(dc,winX,winY,winX+MINIMAP_WINDOW_W,winY+MINIMAP_WINDOW_H);
 dc->color=LTGRAY;
 GrRect(dc,winX,winY,winX+MINIMAP_WINDOW_W,winY+2);
 GrRect(dc,winX,winY+MINIMAP_WINDOW_H-2,
        winX+MINIMAP_WINDOW_W,winY+MINIMAP_WINDOW_H);
 GrRect(dc,winX,winY,winX+2,winY+MINIMAP_WINDOW_H);
 GrRect(dc,winX+MINIMAP_WINDOW_W-2,winY,
        winX+MINIMAP_WINDOW_W,winY+MINIMAP_WINDOW_H);

 dc->color=DKGRAY;
 GrRect(dc,winX+3,winY+3,winX+MINIMAP_WINDOW_W-3,viewY-4);
 dc->color=WHITE;
 PrintLine(dc,"MINIMAP",winX+12,winY+15);
 dc->color=DKGRAY;
 GrRect(dc,MINIMAP_CLOSE_X1,MINIMAP_CLOSE_Y1,
        MINIMAP_CLOSE_X2,MINIMAP_CLOSE_Y2);
 dc->color=WHITE;
 PrintLine(dc,"X",MINIMAP_CLOSE_X1+7,MINIMAP_CLOSE_Y1+5);

 dc->color=BLACK;
 GrRect(dc,viewX,viewY,viewX+MINIMAP_VIEW_W,
        viewY+MINIMAP_VIEW_H);
 for(j=0;j<MINIMAP_VIEW_TILES_Y;j++){
  tileY=mc->miniMapPanY+j;
  if(tileY>=0 && tileY<wY){
   for(i=0;i<MINIMAP_VIEW_TILES_X;i++){
    tileX=mc->miniMapPanX+i;
    if(tileX>=0 && tileX<wX){
     tile=ToI64(GetTensor(world->level,tileX,tileY,world->currentZ));
     screenX=viewX+i*MINIMAP_TILE_SIZE;
     screenY=viewY+j*MINIMAP_TILE_SIZE;
     dc->color=GetBG(tile);
     GrRect(dc,screenX,screenY,
            screenX+MINIMAP_TILE_SIZE,screenY+MINIMAP_TILE_SIZE);

     node=GetTensorNode(world->level,tileX,tileY,world->currentZ);
     if(node && node->hasObj){
      if(node->idObj==SP_FISHING_SPOT)
       dc->color=CYAN;
      else if(node->isSolid)
       dc->color=LTRED;
      else
       dc->color=YELLOW;
      GrRect(dc,screenX+1,screenY+1,screenX+5,screenY+5);
     }
     if(node && node->len>0){
      dc->color=WHITE;
      GrRect(dc,screenX+4,screenY+4,screenX+6,screenY+6);
     }
     if(node && node->hasNPC){
      dc->color=RED;
      GrRect(dc,screenX+2,screenY+2,screenX+4,screenY+4);
     }
    }
   }
  }
 }

 // Draw the player's existing queued movement path as small waypoint dots.
 if(player && player->hasPath){
  pathX=player->x;
  pathY=player->y;
  for(k=player->pathIndex;k<player->pathLen;k++){
   switch(player->pathDirs[k]){
    case DIR_UP: pathY--; break;
    case DIR_DOWN: pathY++; break;
    case DIR_LEFT: pathX--; break;
    case DIR_RIGHT: pathX++; break;
   }
   if(pathX>=mc->miniMapPanX &&
      pathX<mc->miniMapPanX+MINIMAP_VIEW_TILES_X &&
      pathY>=mc->miniMapPanY &&
      pathY<mc->miniMapPanY+MINIMAP_VIEW_TILES_Y){
    screenX=viewX+(pathX-mc->miniMapPanX)*MINIMAP_TILE_SIZE;
    screenY=viewY+(pathY-mc->miniMapPanY)*MINIMAP_TILE_SIZE;
    dc->color=LTBLUE;
    GrRect(dc,screenX+2,screenY+2,screenX+4,screenY+4);
   }
  }
 }

 if(player && player->x>=mc->miniMapPanX &&
    player->x<mc->miniMapPanX+MINIMAP_VIEW_TILES_X &&
    player->y>=mc->miniMapPanY &&
    player->y<mc->miniMapPanY+MINIMAP_VIEW_TILES_Y){
  screenX=viewX+(player->x-mc->miniMapPanX)*MINIMAP_TILE_SIZE;
  screenY=viewY+(player->y-mc->miniMapPanY)*MINIMAP_TILE_SIZE;
  dc->color=WHITE;
  GrRect(dc,screenX+1,screenY+1,screenX+5,screenY+5);
  dc->color=RED;
  GrRect(dc,screenX+2,screenY+2,screenX+4,screenY+4);
 }

 dc->color=LTGRAY;
 GrRect(dc,winX+3,viewY+MINIMAP_VIEW_H+4,
        winX+MINIMAP_WINDOW_W-3,winY+MINIMAP_WINDOW_H-3);
 dc->color=WHITE;
 PrintLine(dc,"Arrows: pan | Click map: center | Esc/X: close",
           winX+12,winY+MINIMAP_WINDOW_H-15);
}

U0 RenderMenus(CDC *dc, Actor *p)
{
 CDC *render;
   if(mc->displayDev){
    render = RenderDev();
    GrBlot3(dc,0,0,0,render); DCDel(render);
   }
   if(mc->displayStats){ 
    render = RenderStats(p); 
    GrBlot3(dc,12*camera->dividX-25,-4,0,render); DCDel(render);
   } else if(mc->displayPrayers){ 
    render = RenderPrayers(p); 
    GrBlot3(dc,12*camera->dividX-25,-4,0,render); DCDel(render);
   }

   if(mc->displayEquipment){
    render = RenderEquipment(p);
    GrBlot3(dc,10,10,0,render); DCDel(render);
   }
   if(mc->displaySave){
    render = RenderSaveForm();
    GrBlot3(dc,100,100,0,render); DCDel(render);
   }
}
