


U0 FishingHoleTrigger(Actor *p)
{
 switch(p->race)
 {
  case T_JUDA:
   AddAnimJobToQue("T1Fish",(p->x)*camera->dividX,(p->y)*camera->dividY);
  break;
  case T_LEVI:
   AddAnimJobToQue("T2Fish",(p->x)*camera->dividX,(p->y)*camera->dividY);
  break;
  case T_EPHR:
   AddAnimJobToQue("T3Fish",(p->x)*camera->dividX,(p->y)*camera->dividY);
  break;
  case T_BENJ:
   AddAnimJobToQue("T4Fish", (p->x)*camera->dividX,(p->y)*camera->dividY);
  break;
 }
}