


U0 FishingHoleTrigger(Actor *p)
{
 mc->reRenderInv=TRUE;
 AddDirective(T1FISH,p);
 AddItemToInventory(PLAYER,IT_FISH1);
 mc->reRenderInv=TRUE;
 
}