


U0 FishingHoleTrigger(Actor *p)
{
// I64 i = p.x;
 //I64 j = p.y;
// I64 convertedToScreenX = i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX;
// I64 convertedToScreenY = j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY;
 
 switch(p->race)
 {
  case T_JUDA:
   direct.cQueDirective = T1FISH;
  break;
  case T_LEVI:
   direct.cQueDirective = T2FISH;
  break;
  case T_EPHR:
   direct.cQueDirective = T3FISH;
  break;
  case T_BENJ:
   direct.cQueDirective = T4FISH;
  break;
 }
 direct.x = p->screenX;//(p->x)*camera->dividX;
 direct.y = p->screenY;//(p->y)*camera->dividY;
 direct.a = p;
 p->visible=FALSE;
}