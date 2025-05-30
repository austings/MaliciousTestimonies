


U0 FishingHoleTrigger(Actor *p)
{
 if(!StrCmp(direct.cQueDirective,NoDirective))
 {
  direct.x = p->screenX;//(p->x)*camera->dividX;
  direct.y = p->screenY;//(p->y)*camera->dividY;
  direct.a = p;
 
  switch(p->race){
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
  p->visible=FALSE;
  

  AddItemToInventory(PLAYER,IT_FISH1);
 }
}