
class DevConsole{

 CDC *cmd;
 U8 *line0;
 U8 *line1;
 U8 *line2;
 U8 *line3;
 U8 *line4;
 U8 *line5;
 U8 *line6;
 U8 *line7;

} devc;

U0 InitDev()
{
 devc.line0 = StrNew("ÿ"); 
 devc.line1 = StrNew("V"); 
 devc.line2 = StrNew("|"); 
 devc.line3 = StrNew("|"); 
 devc.line4 = StrNew("you're debugging; in that case, good job!"); 
 devc.line5 = StrNew("Note this is technically cheating... unless"); 
 devc.line6 = StrNew("Please type in your command to begin."); 
 devc.line7 = StrNew("Welcome to the dev console"); 

}

CDC *RenderDev()
{ 
 // blink
 // devc.line0 = MStrPrint("%s%s",devc.line0);
 // devc.line0[StrLen(devc.line0)-1]=char; 
 // devc.line0 = MStrPrint("%s%s",devc.line0); 
// DCClear(devc.cmd);
// DCRst(devc.cmd);
// DCDepthBufRst(devc.cmd);
 devc.cmd = DCNew(400,140);
 DCFill(devc.cmd, WHITE);
 devc.cmd->color=BLACK;
 PrintLine(devc.cmd,devc.line0,10,88,1); 
 PrintLine(devc.cmd,devc.line1,10,76,1); 
 PrintLine(devc.cmd,devc.line2,10,64,1); 
 PrintLine(devc.cmd,devc.line3,10,52,1); 
 PrintLine(devc.cmd,devc.line4,10,40,1); 
 PrintLine(devc.cmd,devc.line5,10,28,1); 
 PrintLine(devc.cmd,devc.line6,10,16,1);
 PrintLine(devc.cmd,devc.line7,10,4,1);  

 return devc.cmd; 

}

U0 DevKeyEnter()
{

 Free(devc.line7);
 devc.line7 = devc.line6;
 devc.line6 = devc.line5;
 devc.line5 = devc.line4;
 devc.line4 = devc.line3;
 devc.line3 = devc.line2;
 devc.line2 = devc.line1;

 I64 newLen = StrLen(devc.line0);//minus new char (keep null char)
 U8 *myNewStr= MAlloc(newLen);
 MemCpy(myNewStr,devc.line0,newLen-1);
 myNewStr[newLen-1] = '\0'; 
 devc.line0 = MStrPrint("%s",myNewStr);
 Free(myNewStr);

 devc.line1 = devc.line0;
 devc.line0 = StrNew("ÿ");//MStrPrint("",);
}

U0 AddDevChar(I64 buffer)
{
 I64 newLen = StrLen(devc.line0)+2;//plus new char and null char
 I64 insertLoc = StrLen(devc.line0);
 U8 *myNewStr= MAlloc(newLen);
 U8 convChar = ((U8)buffer);
 
 MemCpy(myNewStr,devc.line0,insertLoc);
 myNewStr[insertLoc-1] = convChar;
 myNewStr[insertLoc] = 'ÿ';
 myNewStr[insertLoc+1] = '\0';
 
 Free(devc.line0);
 devc.line0 = MStrPrint("%s",myNewStr);
 Free(myNewStr);

}

U0 DelDevChar()
{
 devc.line0[StrLen(devc.line0)-2]=0;
}

U0 PrintDevMessage(U8 *msg)
{
 Free(devc.line0);
 devc.line0 = MStrPrint("%s ",msg);
 Free(msg);
 DevKeyEnter;
}