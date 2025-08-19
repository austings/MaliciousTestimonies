U8 *GetWord(U8 **_ptr) {
  U8 *ptr=*_ptr;
  U8 buf[STR_LEN];
  buf[0]=0;
  while(*ptr&&!(Bt(char_bmp_alpha,*ptr)||StrOcc(",.",*ptr)))
    ++ptr;
  if(StrOcc(",.'",*ptr))
    buf[0](U16)=*ptr++;
  else while(Bt(char_bmp_alpha,*ptr))
   CatPrint(buf,"%c",ToUpper(*ptr++));
  *_ptr=ptr;
  return StrNew(buf);
}

U8 *MarkovGenerate(CDoc *to=NULL,U8 *file,I64 cnt=300,U8 *start_word) {
 U8 *dialog = "";
 I64 linecounter = 0;
  if(!FileFind(file))
    return;
  U8 buf[STR_LEN*2],*a,*b;
  CHashTable *t=HashTableNew(0x1000);
  CHashGeneric *gen;
  I64 idx,idx2;
  F64 *probs,sum,coin;
  U8 *optr=file=FileRead(file);
  file=optr;
  t->next=Fs->hash_table;
  Fs->hash_table=t;
  a=GetWord(&file);
  b=GetWord(&file);

  while(*file) {
    for(idx=1;gen=HashSingleTableFind(a,t,HTT_FRAME_PTR,idx);++idx) {
      if(!StrCmp(gen->user_data0,b)) {
        ++gen->user_data1;
        goto skip;
      }
    }
    FramePtrAdd(a,StrNew(b));
skip:;
    Free(a);
    a=StrNew(b);
    b=GetWord(&file);
  }
  Free(a),Free(b);
  if(gen=HashSingleTableFind(start_word,t,HTT_FRAME_PTR))    {
    a=start_word;
    while(--cnt>=0) {
      for(idx=1;gen=HashSingleTableFind(a,t,HTT_FRAME_PTR,idx);++idx)
        ;
      probs=CAlloc(8*idx);
      for(idx=1;gen=HashSingleTableFind(a,t,HTT_FRAME_PTR,idx);++idx) {
        probs[idx-1]=gen->user_data1+1;
        sum+=gen->user_data1+1;
      }
      for(idx2=1;idx2<idx;++idx2)
        probs[idx2-1]/=sum;
      coin=Rand;
      sum=0;
      for(idx2=1;idx2<idx;++idx2) {
        sum+=probs[idx2-1];
        if(sum+.0001>=coin) {
	  gen=HashSingleTableFind(a,t,HTT_FRAME_PTR,idx2);
	  U8 *dialogWord = MStrPrint("%s ",a=gen->user_data0);
          linecounter = linecounter+StrLen(dialogWord);
          if(linecounter>25){
           dialog = MStrPrint("%s#%s",dialog,dialogWord);
           linecounter = 0; 
          }else{
           dialog = MStrPrint("%s%s",dialog,dialogWord);
          } 
	  break;
        }
      }
      Free(probs);

    }
  }
  Fs->hash_table=t->next;
  HashTableDel(t);
  Free(optr);
 return dialog;
}
