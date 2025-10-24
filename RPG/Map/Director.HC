
#define NoDirective -1

class Animation:CQue{
  CDC *frame;
  I8 frameDuration,//how many times to show 
     frameDurationIndex,
     xOffset, yOffset;
  I64 key;
  I8 frameIndex;//frame pos in anim
} allAnimations;



class Director:CQue{
  I64 cQueDirective;
  I32 animIndex;//cur pos in anim
  I64 x, y, z, xFOff, yFOff; //x/y/z to render; x/y armor frame Offset
  Bool flip, isEffect;
  Actor *a;
} direct;


U0 ResetDirective(Director *task)
{
  task->cQueDirective = NoDirective;
  task->animIndex = 0;
  task->x = 999;
  task->y = 999;
  task->z = 0;
  task->flip = FALSE;
  //task->a = NULL;
  
}


U0 FreeMyTask(I64 name, Actor *a)
{
 Director *task = direct.next;

 I64 i,cnt = QueCnt(direct);

 for(i=0;i<cnt;i++)
 {

  if(a->id == task->a->id&&task->cQueDirective==name)
  {
   i=9999;
   break;
  }
  task = task->next;

 }

 if(i=9999)
 {
   QueRem(task);
   Free(task);
 }

}

U0 FreeTask(Director *task)
{
 QueRem(task);
 Free(task);
}



Director *HasAnyDirective(Actor *a)
{
 Director *task = direct.next;
 I64 i =0; Bool free=TRUE;
 for(i=0;i!=QueCnt(direct);i++){
   if(task->a->id==a->id&&task->cQueDirective!=NoDirective)
   {free = FALSE;
     break;
   }
  task = task->next;
 }
 if(free)
  return NULL;
 return task;
}
