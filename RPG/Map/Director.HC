
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


U0 FreeMyTask(Actor *a)
{
 Director *task = direct.next;

 I64 i,cnt = QueCnt(direct);

 for(i=0;i<cnt;i++)
 {

  if(a->id == task->a->id)
  {
   i=9999;
   break;
  }
  task = task->next;

 }

 if(i=9999)
 {
   ResetDirective(task);
   //QueRem(task);
   //Free(task);
 }

}

Director *HasAnyDirective(Actor *a)
{
 Director *task = direct.next;
 I64 i =0; Bool free=FALSE;
 for(i=0;i!=QueCnt(direct);i++){
   if(task->a->id==a->id&&task->cQueDirective!=NoDirective)
   { free = TRUE;
     break;}
  task = task->next;
 }
 if(!free)
  return NULL;
 return task;
}
