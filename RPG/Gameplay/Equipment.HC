
#define NoDirective -1

class Animation:CQue{
  CDC *frame;
  I8 frameDuration,
     frameDurationIndex,
     xOffset, yOffset;
  I64 key;
  I8 frameIndex;
} allAnimations;



class Director:CQue{
  I64 cQueDirective;
  I32 animIndex;
  I64 x; I64 y; I64 z;
  Bool flip;
  Actor *a;

} direct;


#define W_IDLEDOWN      0
#define W_IDLEUP        1
#define W_IDLERIGHT     2
#define W_IDLELEFT      3

#define W_NOTWALKING       00
#define W_LEFTSTRAIGHT     01
#define W_RIGHTSTRAIGHT    02
#define W_UPSTRAIGHT       03
#define W_DOWNSTRAIGHT     04
#define W_LEFTLEFT         05
#define W_RIGHTLEFT        06
#define W_UPLEFT           07
#define W_DOWNLEFT         08
#define W_LEFTMID          09
#define W_RIGHTMID         10
#define W_UPMID            11
#define W_DOWNMID          12
#define W_LEFTRIGHT        13
#define W_RIGHTRIGHT       14
#define W_UPRIGHT          15
#define W_DOWNRIGHT        16


//convert walk animation frame to cardinal direction
I64 GetDir(Actor *a)
{
  U8 walkDir = a->walking;
  U8 subWalk = a->walkingSubFrame;
  switch(walkDir){
   case W_NOTWALKING:
    switch(subWalk)
    {
     case W_IDLEDOWN:
      return DIR_DOWN;
     break; 
     case W_IDLEUP:
      return DIR_UP;
     break;
     case W_IDLERIGHT:
      return DIR_RIGHT;
     break;
     case W_IDLELEFT:
      return DIR_LEFT;
     break;
    }
   break;
   case W_UPSTRAIGHT   :
   case W_UPMID        :    
   case W_UPLEFT       :
   case W_UPRIGHT      :
    return DIR_UP;
   break;    
   case W_DOWNSTRAIGHT :
   case W_DOWNLEFT     :
   case W_DOWNRIGHT    :    
   case W_DOWNMID      : 
    return DIR_DOWN;   
   break;
   case W_LEFTLEFT     :
   case W_LEFTSTRAIGHT : 
   case W_LEFTMID      :
   case W_LEFTRIGHT    :
    return DIR_LEFT;    
   break;
   case W_RIGHTSTRAIGHT:
   case W_RIGHTLEFT    :
   case W_RIGHTMID     :   
   case W_RIGHTRIGHT   :
    return DIR_RIGHT;    
   break;
  }
 return DIR_DOWN;
}


Bool AddItemToInventory(I64 actorID, I64 itemID)
{
 I64 i,j,x,y,area;
 Actor *p = GetNPC(actorID);
 Item *item = MakeItem(itemID);
 
 for(i=0;i<11;i++)
 {
  for(j=0;j<4;j++)
  {
   area=0;
   for(x=item->w-1;x>=0;x--)
   {
    if(i+x>=11)
     goto skip_num;
 
    for(y=item->h-1;y>=0;y--)
    {
     if(j+y>=4)
      goto skip_num;
     if(p->myInv->mtrx[j+y][i+x].occupied<0)
       area++;
  
    }
   }

   if(area==(item->h)*(item->w))
   {
    QueIns(item,p->myInv->collection->last);
    //PopUpPrint( "item added");
    I64 cnt = ++p->myInv->count;
    
    for(x=item->w-1;x>=0;x--)
    {  
     for(y=item->h-1;y>=0;y--)
     {
      p->myInv->mtrx[j+y][i+x].occupied = cnt;
     }
    }
    item->invID = cnt;
    return TRUE;

   }

  }
  skip_num:
 }

 return FALSE;

}


//usually used for populating equipment slots
U0 RemoveItemLoc(Item *item)
{
 Actor *p = GetNPC(0);

 I64 i,j,x,y;

 //remove old loc
 for(i=0;i<11;i++)
 {
  for(j=0;j<4;j++)
  {
    if(p->myInv->mtrx[j][i].occupied==item->invID)
    {  p->myInv->mtrx[j][i].occupied=-1; }
   
      
  }
 }
}

U0 ChangeItemLoc(U8 newI, U8 newJ, Item *item)
{
 Actor *p = GetNPC(0);

 I64 i,j,x,y;

 //remove old loc
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
    if(p->myInv->mtrx[j][i].occupied==item->invID)
    {  p->myInv->mtrx[j][i].occupied=-1; }
   
      
  }
 }
 item->visible=TRUE;
 //add new loc
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
    if(i==newI&&j==newJ){
     for(x=0;x<item->w;x++)
     {  
      for(y=0;y<item->h;y++)
      {
       p->myInv->mtrx[j+y][i+x].occupied = item->invID;
      }
     }
    }

  }
 }
}

U0 GetItemScreenLoc(I64 invIDToFetch, I64 *x, I64 *y){
 I64 i,j; 
 Actor *p = GetNPC(0);
 for(i=0;i<INVWIDTH;i++)
 {
  for(j=0;j<INVHEIGHT;j++)
  {
   if(p->myInv->mtrx[j][i].occupied==invIDToFetch)
   { 
    *x = i*45+2+15;
    *y = j*42+310;
    goto please_clap;
    
   }         
  }
 }
 please_clap:
}


I64 *RetrieveItemID(I64 aID, I64 index, Bool select=FALSE)
{
  Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
  I64 i;
  for(i=0;i<index;i++)
  {
    toBeRetrieved = toBeRetrieved->next;
  }
  //DocPrint("%d",toBeRetrieved->id);
  if(select)//move to mouse
  {
   toBeRetrieved->visible = FALSE;
   return toBeRetrieved->id;
  }
  if(toBeRetrieved->visible==TRUE)
   return toBeRetrieved->id;

}

Item *RetrieveItem(I64 aID, I64 index, Bool select=FALSE)
{
  Item *toBeRetrieved = (GetNPC(aID))->myInv->collection->next;
  I64 i;
  for(i=0;i<index;i++)
  {
    toBeRetrieved = toBeRetrieved->next;
  }
  return toBeRetrieved;
}


U0 SetActorHairLeft(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0L;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1L;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2L;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3L;
  break;
 }

}

U0 SetActorHairUp(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0U;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1U;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2U;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3U;
  break;
 }

}

U0 SetActorHairRight(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0R;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1R;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2R;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3R;
  break;
 }

}

U0 SetActorHairDown(Actor *a)
{
 switch(a->hair)
 {
  case HAIR0D...HAIR0U:
   a->hair=HAIR0D;
  break;
  case HAIR1D...HAIR1U:
   a->hair=HAIR1D;
  break;
  case HAIR2D...HAIR2U:
   a->hair=HAIR2D;
  break;
  case HAIR3D...HAIR3U:
   a->hair=HAIR3D;
  break;
 }

}



CDC *ShowBody(I64 armor,I64 dir )
{
 CDC *armorPiece = DCNew(100,100);
 DCFill(armorPiece,TRANSPARENT);
 switch(armor)
 { 
  case IT_SHIRT:
   Sprite3B(armorPiece,10,20,10,GetClothArmor(dir));
  break;
 }
 return armorPiece;
}

CDC *ShowHelm(I64 armor,I64 dir )
{
 CDC *armorPiece = DCNew(100,100);
 DCFill(armorPiece,TRANSPARENT);
 switch(armor)
 { 
  case IT_HELM:
   Sprite3B(armorPiece,10,20,10,GetHelmArmor(dir));
  break;
 }
 return armorPiece;
}


U0 OverlayArmor(CDC *dc, Actor *toRender)
{
/*
 switch(toRender->hat)
 {
  case IT_HELM:
  break;
 }
*/

 //this is a switch statement to animate the armor based on
//the world timer status
 I64 dir = GetDir(toRender);
 I64 yOff = 0;
 I64 xOff = 0;
 if(toRender->walking!=W_NOTWALKING){
  // Create a value based on timer (cycle every 30 ticks)
  F64 t = (world->timer % 30) / 30.0 * 2.0 * pi;
  I64 groffset = ToI64(Sin(t) * 3.0); // values from -3 to +3
  if(dir == DIR_RIGHT || dir == DIR_LEFT){
   xOff += (groffset/2);
   yOff += (groffset/2);
  } else {
   yOff += groffset;
  }
 }
 GrBlot3(dc,0+xOff,0+yOff,0,ShowBody(toRender->armor,dir));
 GrBlot3(dc,0+xOff,0+yOff,10,GetHair(toRender->hair));
 GrBlot3(dc,0+xOff,0+yOff,0,ShowHelm(toRender->hat,dir));
 

}

