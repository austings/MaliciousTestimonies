U0 SetActorSubFrameRule(Actor *a,I64 wsf,I64 w )
{
 a->walkingSubFrame++;

 if(a->walkingSubFrame== FRAMERULE)
 {
  a->walkingSubFrame=wsf;       
  a->walking = w;
 }

}


CDC *HandleWalkSubFrame(Actor *a, CDC *completeActor,
                        CDC *L1,CDC *L2,CDC *L3,
                        CDC *R1,CDC *R2,CDC *R3,
                        CDC *U1,CDC *U2,CDC *U3,
                        CDC *D1,CDC *D2,CDC *D3, 
                        I64 xOffset=0)
//xOffset to correct for .WAD graphics being slightly off origin 
{
  U8 walkDir = a->walking;
  U8 subWalk = a->walkingSubFrame;
 
 switch(walkDir){
     case W_NOTWALKING:
       switch(subWalk)
       {
        case W_IDLEDOWN://down
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D2);
        break;
        case W_IDLEUP://up
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U2);
        break;
        case W_IDLERIGHT://right
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R2);
        break;
        case W_IDLELEFT://left
         if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L2);
        break;
       }
     break;
     case W_LEFTSTRAIGHT://left straight start
       SetActorSubFrameRule(a,0,5);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L1);
     break;
     case W_RIGHTSTRAIGHT://right straight start
       SetActorSubFrameRule(a,0,6);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R1);
     break;
     case W_UPSTRAIGHT://up straight start
       SetActorSubFrameRule(a,0,7);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U1);
     break;
     case W_DOWNSTRAIGHT://down straight start
       SetActorSubFrameRule(a,0,8); 
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D1);
     break;
     case W_LEFTLEFT://left left leg
       SetActorSubFrameRule(a,0,9);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L2);
     break;
     case W_RIGHTLEFT://right left leg
       SetActorSubFrameRule(a,0,10);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R2);
     break;
     case W_UPLEFT://up left leg
       SetActorSubFrameRule(a,0,11);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U2);
     break;
     case W_DOWNLEFT://down left leg
       SetActorSubFrameRule(a,0,12);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D2);
     break;
     case W_LEFTMID://left straight mid
       SetActorSubFrameRule(a,0,13);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,L3);
     break;
     case W_RIGHTMID://right straight mid
       SetActorSubFrameRule(a,0,14);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,R3);
     break;
     case W_UPMID://up straight mid
       SetActorSubFrameRule(a,0,15);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,U3);
     break;
     case W_DOWNMID://down straight mid
       SetActorSubFrameRule(a,0,16);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D3); 
     break;
     case W_LEFTRIGHT://left right leg
       SetActorSubFrameRule(a,3,0);
       if(a->visible)
        GrBlot3(completeActor,0+xOffset,0,10,L2);
     break;
     case W_RIGHTRIGHT://right right leg
       SetActorSubFrameRule(a,2,0);
       if(a->visible)
        GrBlot3(completeActor,0+xOffset,0,10,R2);
     break;
     case W_UPRIGHT://up right leg
       SetActorSubFrameRule(a,1,0);
       if(a->visible)
        GrBlot3(completeActor,0+xOffset,0,10,U2);
     break;
     case W_DOWNRIGHT://down right leg 
       SetActorSubFrameRule(a,0,0);
       if(a->visible)
          GrBlot3(completeActor,0+xOffset,0,10,D2);
     break;
  }

 return completeActor;

}


CDC *GetWalkAnimation(Actor *a, CDC *completeActor)
{
  switch(a->face)
  {
   case T_JUDA://Judah
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A1L1, A1L2, A1L3,
                        A1R1, A1R2, A1R3,
                        A1U1, A1U2, A1U3,
                        A1D1, A1D2, A1D3);

   break;
   case T_LEVI://Levi
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A2L1, A2L2, A2L3,
                        A2R1, A2R2, A2R3,
                        A2U1, A2U2, A2U3,
                        A2D1, A2D2, A2D3, -2);

   break;
   case T_EPHR://Ephraim
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A3L1, A3L2, A3L3,
                        A3R1, A3R2, A3R3,
                        A3U1, A3U2, A3U3,
                        A3D1, A3D2, A3D3, -4);

   break;
   case T_BENJ://Benjamin
    completeActor = HandleWalkSubFrame(a, 
                        completeActor,
                        A4L1, A4L2, A4L3,
                        A4R1, A4R2, A4R3,
                        A4U1, A4U2, A4U3,
                        A4D1, A4D2, A4D3, -6);

   break;

  }


 
 return completeActor; 
       

}

Bool HasDirective(I64 directive,Actor *a)
{
 Director *task = direct.next;
 I64 i =0; Bool free=FALSE;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective==directive)
  {
   if(task->a->id==a->id)
    free = TRUE;
   break;
  }
  task = task->next;
 }
 return free;
}

U0 EndProceduralAnimations(){
 Director *task = direct.next;
 I64 i =0; 
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective==BOUNCE)
  {
    ResetDirective(task);  
  }
 }
}
//update directive id by actor and directive
//inherently checks Has
Bool UpdateDirective(I64 directive,Actor *p,
                     I64 x, I64 y, I64 z,Bool explicitRemoval=FALSE)
{
 Director *task = direct.next;
 I64 i =0; Bool free=FALSE;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective==directive)
  {
   if(task->a->id==p->id)
   {
    if(p->status1==DEAD_STATUS||explicitRemoval)
    //update if actor dies mid animate
    {
     FreeMyTask(p);
     return FALSE;
    }

    task->x = x; task->y = y; task->z = z;
    free = TRUE;
   }
   break;
  }
  task = task->next;
 }
 return free;
 
}


//sX,sY optional; use p for x and y by default
U0 AddDirective(I64 directive, Actor *p,//npc must own animation
                I64 sX=DELIMITER,I64 sY=DELIMITER)
{
 //TODO: this sucks
 Director *task = direct.next;
 I64 i =0; Bool free=FALSE; Bool isEffect = FALSE;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->cQueDirective==NoDirective)
  {
   free = TRUE;
   break;
  }
  task = task->next;
 }
 if(!free){
  task = MAlloc(sizeof(Director));
  task->a = MAlloc(sizeof(Actor));
 }

 task->x = p->screenX;task->y = p->screenY;
 if(sX!=DELIMITER){task->x = sX; task->y = sY;}

 task->a = p;
 task->flip = FALSE;

 //sometimes we reference t1fish directive 
 //as general trigger without checking face
 switch(directive){
  case T1FISH...T4FISH:
   SetActorDir(p,DIR_DOWN);
   switch(p->face){
    case T_JUDA:// T1FISH;
     task->cQueDirective =T1FISH;
    break;
    case T_LEVI:
     task->cQueDirective = T2FISH;
    break;
    case T_EPHR:
     task->cQueDirective = T3FISH;
    break;
    case T_BENJ:
     task->cQueDirective = T4FISH;
    break;
   }
  break;
  case T1READY...T4READY:
   switch(p->face){
    case T_JUDA:
     task->cQueDirective = T1READY;  
    break;
    case T_LEVI:
     task->cQueDirective = T2READY;
    break;
    case T_EPHR:
     task->cQueDirective = T3READY;
    break;
    case T_BENJ:
     task->cQueDirective = T4READY;
    break;
   }
  break;
  case T1PUNCH...T4PUNCH:
  if(p->x<=mc->target->x){
   task->flip = TRUE;
   SetActorDir(p,DIR_RIGHT);
  }else {SetActorDir(p,DIR_LEFT);}
  switch(p->face){
   case T_JUDA:
    switch(p->sword){
     case IT_FIST: //fist
      task->cQueDirective = T1PUNCH;
     break;
     case IT_DAGGER: 
      task->cQueDirective = T1PUNCH;//T1DAGGER;
     break;
     case IT_HARPOON: 
      task->cQueDirective = T1PUNCH;//T1SPEAR;
     break;
    }  
   break;
   case T_LEVI:
    switch(p->sword){
     case IT_FIST: //fist
      task->cQueDirective = T2PUNCH;//T2PUNCH;
     break;
     case IT_DAGGER: 
      task->cQueDirective = T2PUNCH;//T2DAGGER;
     break;
     case IT_HARPOON: 
      task->cQueDirective = T2PUNCH;//T2SPEAR;
     break;
    }  
   break;
   case T_EPHR:
    switch(p->sword){
     case IT_FIST: //fist
      task->cQueDirective = T3PUNCH;
     break;
     case IT_DAGGER: 
      task->cQueDirective = T3PUNCH;//T3DAGGER;
     break;
     case IT_HARPOON: 
      task->cQueDirective = T3PUNCH;//T3SPEAR;
     break;
    }
   break;
   case T_BENJ:
    switch(p->sword){
     case IT_FIST: //fist
      task->cQueDirective = T4PUNCH;//T4PUNCH;
     break;
     case IT_DAGGER: 
      task->cQueDirective = T4PUNCH;//T4DAGGER;
     break;
     case IT_HARPOON: 
      task->cQueDirective = T4PUNCH;//T4SPEAR;
     break;
    }
   break;
  }
  break;
  case BOUNCE:
   task->cQueDirective = BOUNCE;
  break;
  case ARCSTRIKE:
   task->cQueDirective = ARCSTRIKE;
  break;
  case T1DIE...T4DIE:
   switch(p->face){
    case T_JUDA:
     task->cQueDirective = T1DIE;  
    break;
    case T_LEVI:
     task->cQueDirective = T2DIE;
    break;
    case T_EPHR:
     task->cQueDirective = T3DIE;
    break;
    case T_BENJ:
     task->cQueDirective = T4DIE;
    break;
   }
  break;
  case T1CAST...T4CAST:
   SetActorDir(p,DIR_DOWN);
   switch(p->face){
    case T_JUDA:
     task->cQueDirective = T1CAST;  
    break;
    case T_LEVI:
     task->cQueDirective = T2CAST;
    break;
    case T_EPHR:
     task->cQueDirective = T3CAST;
    break;
    case T_BENJ:
     task->cQueDirective = T4CAST;
    break;
   }
  break;
  case T1EFFHEAL:
  case EFFFISH:
  case EFFFIRE:
  //case EFFSCRATCH:
   task->cQueDirective = directive;
   isEffect = TRUE;
  break;
  //default://dont enable this i know you want to
  // task->cQueDirective = directive;
  //break;

 }
 if(!free)
  QueIns(task,direct.last);
 if(!isEffect) 
  p->visible=FALSE;

}
