Bool IsInStrikeRange(Actor *attacker, Actor *target)
{
 if(!attacker || !target)
  return FALSE;
 ItemTemplate *weapon = GetItemTemplate(attacker->sword);
 I64 distance = GetActorDistance(attacker, target);
 // Fist
 if(!weapon){
  return distance == 1;
 }
 if(distance < weapon->min_range)
  return FALSE;

 if(distance > weapon->max_range)
  return FALSE;
 return TRUE;
}

Bool CanStrikeTarget(Actor *attacker, Actor *target)
{
 if(!attacker || !target)
  return FALSE;

 if(attacker->id == target->id)
  return FALSE;

 if(target->ai_script != AI_ENEMY)
  return FALSE;

 if(HasStatus(target, LIFE_DEAD) ||
    HasStatus(target, LIFE_DYING))
  return FALSE;

 return TRUE;
}

Bool CanPrayerTarget(Actor *p, Actor *target)
{
 if(!p || !target)
  return FALSE;

 // Must be a living target
 if(HasStatus(target, LIFE_DEAD) ||
    HasStatus(target, LIFE_DYING))
  return FALSE;

 switch(mc->prayerToCast)
 {
  case SP_HEAL:
  {
   // Heal can target allies.
   if(target->ai_script==AI_ENEMY)
    return FALSE;

   return TRUE;
  }

  default:
   return FALSE;
 }
}

Bool CanItemTarget(Actor *p, Actor *target)
{
 if(!p || !target)
  return FALSE;

 if(HasStatus(target, LIFE_DEAD) ||
    HasStatus(target, LIFE_DYING))
  return FALSE;

 switch(mc->prayerToCast)
 {
  case IT_HPPOT:
   if(target->ai_script ==AI_ENEMY)
    return FALSE;

   return TRUE;

  default:
   return FALSE;
 }
}

Bool CanTargetForAction(Actor *p, Actor *target)
{
 if(!p || !target)
  return FALSE;
 switch(mc->combatMenuSelection){
  case CS_STRIKE:
   return CanStrikeTarget(p, target);
  case CS_PRAYER2:
   if(mc->isItem)
    return CanItemTarget(p, target);
   return CanPrayerTarget(p, target);
 }
 return FALSE;
}

Bool CheckTarget(Actor *toRender, I64 mouseX, I64 mouseY)
{
    if(!toRender)
        return FALSE;

    if(mc->combatMenuSelection != CS_STRIKE &&
       mc->combatMenuSelection != CS_PRAYER2)
        return FALSE;

    Actor *p = GetPlayer;

    // Target must be valid for the currently selected action.
    if(!CanTargetForAction(p, toRender))
        return FALSE;

    // --- MOUSE MODE ---
    if(mc->mouseTargetingActive)
    {
        if(InRect(mouseX, mouseY,
                  toRender->screenX,
                  toRender->screenY + 50,
                  toRender->screenX + 50,
                  toRender->screenY + 90))
        {
            return TRUE;
        }

        return FALSE;
    }

    // --- KEYBOARD MODE ---
    if(targetCTP && targetCTP->ready)
    {
        if(toRender->id == targetCTP->ready->id)
            return TRUE;
    }

    return FALSE;
}

Bool CheckTargetOld(Actor *toRender, I64 mouseX, I64 mouseY)
{
 Bool highlight = FALSE;
 if(!toRender)
  return FALSE;

 if(mc->combatMenuSelection != CS_STRIKE &&
    mc->combatMenuSelection != CS_PRAYER2)
  return FALSE;

 // --- MOUSE MODE (visual only, no state mutation) ---
 if(mc->mouseTargetingActive){
  if(InRect(mouseX, mouseY,
            toRender->screenX,
            toRender->screenY + 50,
            toRender->screenX + 50,
            toRender->screenY + 90))
  {
   return TRUE;
  }

  return FALSE;
 }
 Actor *p = GetPlayer;
   
 // --- KEYBOARD MODE (authoritative) ---
 if(targetCTP && targetCTP->ready){
  if(toRender->id == targetCTP->ready->id 
     &&CanTargetForAction(p,toRender)){
   highlight = TRUE;
   //p->target = toRender;
  }
 }

 return highlight;
}

//called after combatMenuSelection==11
U0 HighlightTarget(CDC *dc, I64 hX, I64 hY,I64 hZ)
{
 dc->color=RED;
 dc->thick=3;
    //GrRect3(dc,hX+25,hY+45,0,50,50);
 GrCircle3(dc,hX+25,hY+45,0,15);
    //GrFloodFill(dc,hX+13,hY+13,TRUE);   
 dc->thick = 1;   
}

U0 PlayStrikeAnim(Actor *p){
 I64 anim = T1PUNCH;
 I64 i;
 for(i = 0;i<STRIKETYPES;++i) {
  if(StrikeAnimMap[i].face  == p->face &&
     StrikeAnimMap[i].sword == p->sword) {
   anim = StrikeAnimMap[i].anim;
   break;
  }
 }

 AddDirective(anim,p); 
}
