
#define NoDirective -1

class Animation:CQue{
 CDC *frame;
 I8 frameDuration,//how many times to show 
    frameDurationIndex,
    xOffset, yOffset, xAOff, yAOff;
 I64 key;
 I8 frameIndex;//frame pos in anim
} allAnimations;

class Director:CQue{
 I64 cQueDirective;
 I32 animIndex;//cur pos in anim
 I64 x, y, z, xAOff, yAOff; //x/y/z to render; x/y armor frame Offset
 Bool flip, isEffect;
 Actor *a;
} direct;

U0 ResetDirective(Director *task){
 task->cQueDirective = NoDirective;
 task->animIndex = 0;
 task->x = 999;
 task->y = 999;
 task->z = 0;
 task->flip = FALSE;
 task->xAOff = 0;
 task->yAOff = 0;
}

U0 FreeTask(Director *task){
 PrintDevMessage("BEGIN",FALSE);
 PrintDevMessage(MStrPrint("LOG:%d,%s",task->cQueDirective,task->a->name));
 //QueRem(task);
 //Free(task);
 PrintDevMessage("FREED!",FALSE);
}

Director *HasAnyDirective(Actor *a){
 Director *task = direct.next;
 I64 i =0; Bool free=TRUE;
 for(i=0;i!=QueCnt(direct);i++){
  if(task->a->id==a->id&&task->cQueDirective!=NoDirective){
   free = FALSE;
   break;
  }
  task = task->next;
 }
 if(free)
  return NULL;
 return task;
}
