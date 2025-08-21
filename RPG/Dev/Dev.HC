
class DevConsole{

 CDC *cmd;
 U8 *line0;
 U8 *line1;
 U8 *line2;
 U8 *line3;
 U8 *line4;
} devc;

U0 InitDev()
{
 devc.cmd = DCNew(400,140);
 DCFill(devc.cmd, WHITE);
 devc.cmd->color=BLACK;

 devc.line0 = StrNew("ÿ"); 
 devc.line1 = StrNew("you're debugging; in that case, good job!"); 
 devc.line2 = StrNew("Note this is technically cheating... unless"); 
 devc.line3 = StrNew("Please type in your command to begin."); 
 devc.line4 = StrNew("Welcome to the dev console."); 
}

CDC *RenderDev(Actor *p)
{ 
//blink
// devc.line0 = MStrPrint("%s%s",devc.line0);
// devc.line0[StrLen(devc.line0)-1]=char; 
// devc.line0 = MStrPrint("%s%s",devc.line0); 

 PrintLine(devc.cmd,devc.line0,10,52,1); 
 PrintLine(devc.cmd,devc.line1,10,40,1); 
 PrintLine(devc.cmd,devc.line2,10,28,1); 
 PrintLine(devc.cmd,devc.line3,10,16,1);
 PrintLine(devc.cmd,devc.line4,10,4,1);  

 return devc.cmd; 

}

U0 DevKeyEnter()
{
// devc.
}
//ZerpRedgrave
//https://github.com/ZerpRedgrave/LibHC/blob/main/LibHC/Str/StrIns.HC
U64 *StrIns(U8 *str,U8 *part,I64 i){
        //Insert Str in Index Location then Return Overwrite Str
        U64 pl=StrLen(part);
        U8 *st=MStrPrint("%h*c%s",pl,32,str);

        if(StrLen(str)<i || i < -1) throw('OutIndex');

        MemCpy(st,str,i);
        MemCpy(st+i,part,pl);

        return st;
}
U0 AddDevChar(U8 char)
{
 devc.line0= MStrPrint("%s%c",devc.line0,char);

 //U64 *res =StrIns(devc.line0,cs,StrLen(devc.line0)-2);
 //devc.line0 = MStrPrint("%s ",res);
 
}

U0 DelDevChar()
{
 devc.line0[StrLen(devc.line0)-2]=0;
}