


U0 FishingHoleTrigger(Actor *p)
{
 AddDirective(T1FISH,p);
 AddDirective(EFFFISH,p,p->screenX-25,p->screenY+35);
 AddItemToInventory(PLAYER,IT_FISH1);
 
}