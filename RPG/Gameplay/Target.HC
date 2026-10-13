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

Bool FindStrikePosition(
  Actor *p,
  Actor *target,
  I64 *attackX,
  I64 *attackY)
{
  I64 minRange = 1;
  I64 maxRange = 1;
  I64 dx, dy;
  I64 x, y;
  I64 z = world->currentZ;

  if(!p || !target)
    return FALSE;

  // Get the weapon's range.
  if(p->sword != 0)
  {
    ItemTemplate *weapon = GetItemTemplate(p->sword);

    if(!weapon)
      return FALSE;

    minRange = weapon->min_range;
    maxRange = weapon->max_range;
  }

  // Search tiles around the target.
  for(dy = -maxRange; dy <= maxRange; dy++)
  {
    for(dx = -maxRange; dx <= maxRange; dx++)
    {
      x = target->x + dx;
      y = target->y + dy;

      if(x < 0 || y < 0 || x >= wX || y >= wY)
        goto nextTile;

      // Don't choose the target's own tile.
      if(x == target->x && y == target->y)
        goto nextTile;

      // The candidate must be within weapon range.
      I64 targetDistance = Abs(target->x - x) +
                 Abs(target->y - y);

      if(targetDistance < minRange ||
        targetDistance > maxRange)
        goto nextTile;

      // Don't choose solid or NPC-occupied tiles.
      if(CheckSolid(world->level, x, y, z))
        goto nextTile;

      if(GetTensorNPC(world->level, x, y, z) != IT_NULL)
        goto nextTile;

      // A successful call builds the path to this tile.
      if(AStarMoveActorTo(p, x, y, z))
      {
        *attackX = x;
        *attackY = y;
        return TRUE;
      }
     nextTile:
    }
  }

  return FALSE;
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
 if(StrikeAnimMap[i].face == p->face &&
   StrikeAnimMap[i].sword == p->sword) {
  anim = StrikeAnimMap[i].anim;
  break;
 }
 }

 AddDirective(anim,p); 
}
