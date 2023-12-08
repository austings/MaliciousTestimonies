
//
// Classes
//


class World
{
 I64 currentZ;
 Tensor3D *level;
};


class Keys
{
 Bool left,right,up,down,enter;
} keys;

class MenuControl
{
  I32 currentSong,//for draw and song threads
      currentMenu,
      cutsceneTarget;//switch cutscene frames

  I64 talkieScene;//dialogID
  U8* dialogName;//dialog actor name

  //combat preferences
  Bool combatON;
  U16 combatMenuStage;
  U8 combatMenuSelection;

  //inventory render
  Bool displayInventory,reRenderInv;
  CDC *inventoryRender;

};

class Camera
{
  F64 dividX, dividY;//ratio tile to screen h/w
  I64 cursorX, cursorY,//cursor positions 
      topLR,topUD,//for preventing pan at map corners
      cameraOffSetX,cameraOffSetY;//offset for smooth transition

};

MenuControl *mc;
Camera *camera;
World *world;//world
Vector *worldSz;//world size, with values wX,wY,wZ

I64 wX,wY,wZ;

//
//Constants and Precompiler
//

#include "Menu.HC";


#define SCREENX 480
#define SCREENY 480
#define FRAMERULE 3
//
//Global variables
//
static CDC*		ITEM1;
static CDC*		ITEM1I;

static CDC*		A1L1;
static CDC*		A1L2;
static CDC*		A1L3;
static CDC*		A1U1;
static CDC*		A1U2;
static CDC*		A1U3;
static CDC*		A1D1;
static CDC*		A1D2;
static CDC*		A1D3;
static CDC*		A1R1;
static CDC*		A1R2;
static CDC*		A1R3;

static CDC*		A2L1;
static CDC*		A2L2;
static CDC*		A2L3;
static CDC*		A2U1;
static CDC*		A2U2;
static CDC*		A2U3;
static CDC*		A2D1;
static CDC*		A2D2;
static CDC*		A2D3;
static CDC*		A2R1;
static CDC*		A2R2;
static CDC*		A2R3;

static CDC*		A3L1;
static CDC*		A3L2;
static CDC*		A3L3;
static CDC*		A3U1;
static CDC*		A3U2;
static CDC*		A3U3;
static CDC*		A3D1;
static CDC*		A3D2;
static CDC*		A3D3;
static CDC*		A3R1;
static CDC*		A3R2;
static CDC*		A3R3;

static CDC*		A4L1;
static CDC*		A4L2;
static CDC*		A4L3;
static CDC*		A4U1;
static CDC*		A4U2;
static CDC*		A4U3;
static CDC*		A4D1;
static CDC*		A4D2;
static CDC*		A4D3;
static CDC*		A4R1;
static CDC*		A4R2;
static CDC*		A4R3;


/*

F64 dividX, dividY;//ratio tile to screen h/w
I64 cursorX = ms.pos.x, cursorY = ms.pos.y;//cursor positions
   
I64 talkieScene = -1;//dialogID
U8* dialogName = "???";//dialog actor name

//combat preferences
Bool combatON;
U16 combatMenuStage;
U8 combatMenuSelection;
*/



U0 Quit()
{
  //free everything
 
  //free player
  FreeActor(0);
}


U0 SongTask(CTask *task, CDC *dc)
{
  Fs->task_end_cb=&SndTaskEndCB;
  MusicSettingsRst;
  while(TRUE){
   if(mc->currentSong==0)
   {
    //Town Song
     Play("3qCet2EG3.q2BetDF3.qDet2FA3.qCet2EG3.2qGet1GB2D1G2CE1G2D2GA#3D.");//I am heading home
     if(mc->currentSong!=0)
     goto loop;

     Play("3qCet2EG3.q2BetDF3.qDet2FA3.qCet2EG3.2.hA.et1AF#GEFGAC.");//I am heading home
     if(mc->currentSong!=0)
     goto loop;

     Play("3qCtt2EG3..q2Bett1B2D#F#3..q3Dett1A2C#E3..q2Gett1GA#2D3..q2AGett1GA#2D..q2Bett1B2D#F#..q2Eett1FG#2C..q3Eett1FG#2C..q3DF2Bett1B2D#F#..q3hCq");//I am heading I am heading I am heading home
     if(mc->currentSong!=0)
     goto loop;

     Play("3Gett1GA#2D3..qEett1FG#2C3..qFett1F#A2C#3..qDett1A2C#E3..qEett1FG#2C3..qCett2EG3..qCett2EG3..qCett2EG3..q");//What should we expect of you?
     if(mc->currentSong!=0)
     goto loop;

     Play("3Gett1GA#2D3..qEett1FG#2C3..qFett1F#A2C#3..qCtt2EG3..wDett1A2C#E3..q");//When you've headed home?
     if(mc->currentSong!=0)
     goto loop;

     Play("3Gett1GA#2D3..qEett1FG#2C3..qFett1F#A2C#3..qDett1A2C#E3..qEett1FG#2C3..qCett2EG3..qCett2EG3..qCett2EG3..q");//What things shall we do with you?
     if(mc->currentSong!=0)
     goto loop;

     Play("3Gett1GA#2D3..qEett1FG#2C3..qFett1F#A2C#3..qDett1A2C#E3..wCtt2EG3..4qC");//Once you're safe at home?
  
     if(mc->currentSong!=0)
     goto loop;
    
   }
   if(mc->currentSong==1)
   {
    //Main Menu
    Play("t5G4B");
    if(mc->currentSong!=1)
     goto loop;
    Play("DED");
    if(mc->currentSong!=1)
     goto loop;
    Play("B5G");
    if(mc->currentSong!=1)
     goto loop;
    Play("4ACD");
    if(mc->currentSong!=1)
     goto loop;
    Play("A3G");
    if(mc->currentSong!=1)
     goto loop;
    Play("4BD");
    if(mc->currentSong!=1)
     goto loop;
    Play("BA");
    if(mc->currentSong!=1)
     goto loop;
    Play("EAA");
    if(mc->currentSong!=1)
     goto loop;
    Play("3G5AC");
    if(mc->currentSong!=1)
     goto loop;
    Play("ACD.");

   }
   if(mc->currentSong==2)
   {//character select
    Play("q3#F4A#C");
    if(mc->currentSong!=2)
     goto loop;
    Play("3#F4AD3");
    if(mc->currentSong!=2)
     goto loop;
    Play("#F4A");
    if(mc->currentSong!=2)
     goto loop;
    Play("3E4A#C");   
    if(mc->currentSong!=2)
     goto loop;
    Play("3E4AD"); 
    if(mc->currentSong!=2)
     goto loop;
    Play("3E4A");
    if(mc->currentSong!=2)
     goto loop;
    Play("3D#F4A");
    if(mc->currentSong!=2)
     goto loop;
    Play("3D#F4rh#C");
    if(mc->currentSong!=2)
     goto loop;

   }
   if(mc->currentSong==3)
   {//wedding Theme
    Play("5FrErt4B5D");
    if(mc->currentSong!=3)
     goto loop;
    Play("C4BG");
    if(mc->currentSong!=3)
     goto loop;
    Play("FrGCG");
    if(mc->currentSong!=3)
     goto loop;
    Play("AFA");
    if(mc->currentSong!=3)
     goto loop;
    Play("CFA5C.Fr");
    if(mc->currentSong!=3)
     goto loop;
     Play("Ert4B5DC4BG");
    if(mc->currentSong!=3)
     goto loop;
     Play("FEFAGA");
    if(mc->currentSong!=3)
     goto loop;
     Play("GFrFrFrFr");
    if(mc->currentSong!=3)
     goto loop;
     Play("3FGAG");
    if(mc->currentSong!=3)
     goto loop;
     Play("FEFD.");
    if(mc->currentSong!=3)
     goto loop;
    
   
   }
   if(mc->currentSong==4)//load theme
   {
    Play("4CrEFrrr");
    if(mc->currentSong!=4)
     goto loop;
    Play("CrEFrErr");
    if(mc->currentSong!=4)
     goto loop;
    Play("4CrEFrrr");
    if(mc->currentSong!=4)
     goto loop;
    Play("4CEFGFEDr");
    if(mc->currentSong!=4)
     goto loop;
        
   }
   if(mc->currentSong==5)//combat
   {
     Play("4CrEFrrr");
    
   }
  loop:
  SndRst;
  music.note_len =.75;
  }
}


//
//Save and Load
//

U0 SaveForm()
{
 //Save user input
 StrCpy(&saveFileFormat,"LastGameSave");
 if(DocForm(&saveFileFormat)){
 "Enter File Name:%s",saveFileFormat.saveFile;
 }
 else{"\n";}
 DocClear;

 //allocate file
 U8 *fileName = MStrPrint("%s%s%s","Saves/",saveFileFormat.saveFile,".BIN");
 CFile *file=FOpen(fileName,"w");
 SaveFileData *newSave= MAlloc(sizeof(SaveFileData));
 newSave->world = world;
 newSave->player = GetNPC(0);
 
 //prepare buffer
 U8 buffer[BLK_SIZE];
 U8 *ptr = buffer;
 I64 i,k,bytesWritten=0,sector=0,currentSize=sizeof(I64),currentStep=0;

 while(currentStep==0)
 {
  if(bytesWritten+currentSize<BLK_SIZE)
  {
    switch(currentStep)
    {
     case 0://player data
      //write currentZ
      MemCpy(ptr,&(newSave->world->currentZ),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
     
      //write player
      MemCpy(ptr,&(newSave->player->race),sizeof(U8)); 
      ptr+=sizeof(U8); bytesWritten+=sizeof(U8);
      MemCpy(ptr,&(newSave->player->eye),sizeof(U8)); 
      ptr+=sizeof(U8); bytesWritten+=sizeof(U8);
      MemCpy(ptr,&(newSave->player->hair),sizeof(U8)); 
      ptr+=sizeof(U8); bytesWritten+=sizeof(U8);
      MemCpy(ptr,&(newSave->player->id),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->hat),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->armor),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->legs),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->boot),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->sword),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->offhand),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->ring1),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->ring2),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->necklace),sizeof(I64)); 
      ptr+=sizeof(I64); bytesWritten+=sizeof(I64);
      MemCpy(ptr,&(newSave->player->x),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->y),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->health),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->mana),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->str),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->int),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->con),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->wis),sizeof(U64)); 
      ptr+=sizeof(U64); bytesWritten+=sizeof(U64);
      MemCpy(ptr,&(newSave->player->dead),sizeof(Bool)); 
      ptr+=sizeof(Bool); bytesWritten+=sizeof(Bool);
      MemCpy(ptr,&(newSave->player->ai_script),sizeof(U8)); 
      ptr+=sizeof(U8); bytesWritten+=sizeof(U8);
//      MemCpy(ptr,&(newSave->player->myInv->maxWeight),sizeof(I32)); 
 //     ptr+=sizeof(I32); bytesWritten+=sizeof(I32);
      
      FBlkWrite(file,buffer,sector,BLK_SIZE);
      ptr-=bytesWritten; bytesWritten=0;
      sector++;
      currentStep++;
      break;/*
     case 1://write player inventory
      Item *toWrite = newSave->player->myInv->collection->next;
      
      for(i=0;i<InvNPCCount(&newSave->player);i++)
      {
       MemCpy(ptr,&(toWrite->name),sizeof(U8));//error? 
       ptr+=sizeof(U8); bytesWritten+=sizeof(U8);
       MemCpy(ptr,&(toWrite->weight),sizeof(F64)); 
       ptr+=sizeof(F64); bytesWritten+=sizeof(F64);
       MemCpy(ptr,&(toWrite->equip_slot),sizeof(I16)); 
       ptr+=sizeof(I16); bytesWritten+=sizeof(I16);
       MemCpy(ptr,&(toWrite->usable),sizeof(Bool));//error 
       ptr+=sizeof(Bool); bytesWritten+=sizeof(Bool);
       toWrite = toWrite->next;
      }
      FBlkWrite(file,buffer,sector,BLK_SIZE);
      ptr-=bytesWritten; bytesWritten=0;
      sector++;
      currentStep++;       
      break;*/
     case 2://TODOwrite world to save
      break;
    }
    

  }
  else
  {
   FBlkWrite(file,buffer,sector,BLK_SIZE);
   sector++;
   ptr-=bytesWritten;
   bytesWritten=0;
  }
 }

 //write and close
 //FBlkWrite(file,buffer,sector,1);
 FClose(file);
 Free(newSave);
 //Quit;
}


U0 LoadGame(U8 *file)
{
 CFile *load = FOpen(file,"r");
                                            
		      
 SaveFileData *newSave = MAlloc(sizeof(SaveFileData));
 newSave->world = world;
 newSave->player = GetNPC(0);

 U8 buffer[BLK_SIZE];
 U8 *ptr = buffer;
 I64 i=0, step=0,bytesRead=0;

 while(FBlkRead(load,buffer,BLK_SIZE*i,1)){
  switch(step)
  {
   case 0:
      MemCpy(&(newSave->world->currentZ),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      
      //write player
      MemCpy(&(newSave->player->race),ptr,sizeof(U8)); 
      ptr+=sizeof(U8); bytesRead+=sizeof(U8);
      MemCpy(&(newSave->player->eye),ptr,sizeof(U8)); 
      ptr+=sizeof(U8); bytesRead+=sizeof(U8);
      MemCpy(&(newSave->player->hair),ptr,sizeof(U8)); 
      ptr+=sizeof(U8); bytesRead+=sizeof(U8);
      MemCpy(&(newSave->player->id),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->hat),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->armor),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->legs),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->boot),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->sword),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->offhand),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->ring1),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->ring2),ptr,sizeof(I64)); 
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->necklace),ptr,sizeof(I64)); //
      ptr+=sizeof(I64); bytesRead+=sizeof(I64);
      MemCpy(&(newSave->player->x),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->y),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->health),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->mana),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->str),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->int),ptr,sizeof(U64));// 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->con),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->wis),ptr,sizeof(U64)); 
      ptr+=sizeof(U64); bytesRead+=sizeof(U64);
      MemCpy(&(newSave->player->dead),ptr,sizeof(Bool)); 
      ptr+=sizeof(Bool); bytesRead+=sizeof(Bool);
      MemCpy(&(newSave->player->ai_script),ptr,sizeof(U8)); 
      ptr+=sizeof(U8); bytesRead+=sizeof(U8);
      //MemCpy(&(newSave->player->myInv->maxWeight),ptr,sizeof(I32)); 
      //ptr+=sizeof(I32); bytesRead+=sizeof(I32);
      SetNPC(MakeActor(newSave->player->id,
      newSave->player->race,
      newSave->player->hair,
      newSave->player->eye, 
      newSave->player->hat,
      newSave->player->armor,
      newSave->player->legs,
      newSave->player->boot,
      newSave->player->sword,
      newSave->player->offhand,
      newSave->player->ring1,
      newSave->player->ring2,
      newSave->player->necklace,
      newSave->player->x,
      newSave->player->y,
      newSave->player->str,
      newSave->player->int,
      newSave->player->con,
      newSave->player->wis,
      newSave->player->ai_script));
      ptr-=bytesRead; bytesRead=0;
      i++;
      step++;
   break;
   default:
    i++;
   break;
  }
 }

 FClose(load);
 mc->currentMenu=1;
 mc->currentSong=0;
 
}

CDirEntry *loadRoot;

//
// Utility Functions
//
 

//grabs the current backwardTrack from the stack
U0 GetBT()
{
  //backwardTrack=backwardTrack->last;
  //Vector *nextV = backwardTrack->data;
  camera->topLR--;
  
}
//grabs the current forwardTrack from the stack
U0 GetFT()
{
  //forwardTrack=forwardTrack->last;
  //Vector *nextV = forwardTrack->data;
  camera->topUD--;
  
}

U8 *GetBG(I64 id)
{
  U8 *color = BLUE; //= GREEN;
  switch(id)
  {
   case 0:
    color = GREEN;
    break;
   case 1:
    color = BLUE;
    break;
   case 17:
    color = DKGRAY;
    break;
   case 18:
    color = LTRED;
    break;


  }
  return color;
}

U0 LevelDesign()
{
  SetTensorNPC(world->level,0,5,5,0);//player
  SMFT(world->level,MakeCastle(GetMatrixFromTensor(world->level,0)),0);//castle
  InitActors(0);
}

U0 Init()
{
 //world
 world = CAlloc(sizeof(World));
 mc = CAlloc(sizeof(MenuControl));
 camera= CAlloc(sizeof(Camera));
 worldSz = CreateVector(3);
 wX = 100; wY = 100; wZ = 1;
 SetVector(worldSz,wX,0);
 SetVector(worldSz,wY,1);
 SetVector(worldSz,wZ,2);
 world->level = CreateTensor(worldSz);
 mc->currentSong=1;
 mc->currentMenu=0;
 mc->cutsceneTarget=0;//switch cutscene frames
 mc->talkieScene = -1;//dialogID
 mc->dialogName = "???";//dialog actor name

 mc->displayInventory=FALSE;
 mc->reRenderInv=TRUE;
 mc->inventoryRender = DCNew(640,480);
 DCFill(mc->inventoryRender, TRANSPARENT);

 //camera;    
 camera->dividX = SCREENX/(11);
 camera->dividY = SCREENY/(11);
 camera->topLR=0; camera->topUD=0;
 camera->cameraOffSetX = 0,  
 camera->cameraOffSetY = 0; 

 //keys
 keys.left=FALSE;
 keys.right=FALSE;
 keys.up=FALSE;
 keys.down=FALSE;
 keys.enter=FALSE;
 //Level and NPCS
 LevelDesign;

 ITEM1 = FramePtr("ITEM008");
 ITEM1I = FramePtr("WINV001");

 A1L1 = FramePtr("ACTOR065");
 A1L2 = FramePtr("ACTOR066");
 A1L3 = FramePtr("ACTOR067");
 A1U1 = FramePtr("ACTOR091");
 A1U2 = FramePtr("ACTOR092");
 A1U3 = FramePtr("ACTOR093");
 A1D1 = FramePtr("ACTOR052");
 A1D2 = FramePtr("ACTOR053");
 A1D3 = FramePtr("ACTOR054");
 A1R1 = FramePtr("ACTOR078");
 A1R2 = FramePtr("ACTOR079");
 A1R3 = FramePtr("ACTOR080");

 A2L1 = FramePtr("ACTOR068");
 A2L2 = FramePtr("ACTOR069");
 A2L3 = FramePtr("ACTOR070");
 A2U1 = FramePtr("ACTOR094");
 A2U2 = FramePtr("ACTOR095");
 A2U3 = FramePtr("ACTOR096");
 A2D1 = FramePtr("ACTOR055");
 A2D2 = FramePtr("ACTOR056");
 A2D3 = FramePtr("ACTOR057");
 A2R1 = FramePtr("ACTOR081");
 A2R2 = FramePtr("ACTOR082");
 A2R3 = FramePtr("ACTOR083");

 A3L1 = FramePtr("ACTOR071");
 A3L2 = FramePtr("ACTOR072");
 A3L3 = FramePtr("ACTOR073");
 A3U1 = FramePtr("ACTOR097");
 A3U2 = FramePtr("ACTOR098");
 A3U3 = FramePtr("ACTOR099");
 A3D1 = FramePtr("ACTOR058");
 A3D2 = FramePtr("ACTOR059");
 A3D3 = FramePtr("ACTOR060");
 A3R1 = FramePtr("ACTOR084");
 A3R2 = FramePtr("ACTOR085");
 A3R3 = FramePtr("ACTOR086");

 A4L1 = FramePtr("ACTOR074");
 A4L2 = FramePtr("ACTOR075");
 A4L3 = FramePtr("ACTOR076");
 A4U1 = FramePtr("ACTOR100");
 A4U2 = FramePtr("ACTOR101");
 A4U3 = FramePtr("ACTOR102");
 A4D1 = FramePtr("ACTOR061");
 A4D2 = FramePtr("ACTOR062");
 A4D3 = FramePtr("ACTOR063");
 A4R1 = FramePtr("ACTOR087");
 A4R2 = FramePtr("ACTOR088");
 A4R3 = FramePtr("ACTOR089");

 //combat
 mc->combatON = FALSE;
 mc->combatMenuStage =0;
 mc->combatMenuSelection=0;

}

CDC *RenderInventory(Actor *p)
{ 
 if(mc->reRenderInv)
 {
  I64 i,j;
  CDC *newInventoryRender = DCNew(640,480);
  DCFill(newInventoryRender, TRANSPARENT);
  //items
  static I16 scanned[44] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                       -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
  U16 scanWriteIndex = 0;
  for(i=0;i<11;i++)
  {
   for(j=0;j<4;j++)
   {
    I8 occupied= p->myInv->mtrx[j][i].occupied;
    if(occupied!=-1)
    {
     Bool alreadyScanned = FALSE;
     U8 scanIndex = 0;
     while(scanIndex<scanWriteIndex)
     {
      if(scanned[scanIndex]==occupied)
       alreadyScanned=TRUE;
      scanIndex++;
     }
     if(!alreadyScanned)
     {
      scanned[scanWriteIndex] = occupied;
      scanWriteIndex++;
      I64 currentItemID = RetrieveItemID(0,occupied); 
           
      switch(currentItemID)
      {
       case 1://dagger   
        GrBlot3(newInventoryRender,i*camera->dividX-2,j*camera->dividY+270,0,ITEM1I);
       break;
      }
      //Free(&retrieved);
     }
    }
   }
  }
  mc->inventoryRender = newInventoryRender;
  mc->reRenderInv=FALSE;
 }
 //GrBlot3(mc->inventoryRender,100,300,0,ITEM1);
 
 return mc->inventoryRender;

}

U0 InteractActor(I64 npc)
{
 Actor *aAtLoc= GetNPC(npc);
 if(aAtLoc->ai_script==1)//combat
 {
  mc->combatON=TRUE;
 }
 else
 {
    mc->dialogName = aAtLoc->name;
    mc->talkieScene = GetTalkie(npc);
 }

} 


U0 MovePlayer(U8 dir)
{
 Actor *p = GetNPC(0);
 //Actor *aAtLoc;
 I64 npc;
 if(p->walking==0)
 {
  switch(dir)
  {
  case 0://left
   p->walking=0;
   p->walkingSubFrame=3;

   if(p->x-1>=0&&!CheckSolid(world->level,p->x-1,p->y,world->currentZ))
   {
    npc = GetTensorNPC(world->level,p->x-1,p->y,world->currentZ);
    if(npc!=-1)
    {
       InteractActor(npc);
    }
    else
    {
     if(mc->combatON)
     {
     }

     mc->talkieScene = -1;
     ClearDialog;
     if(camera->topLR!=0&&p->x<wX-5)
      camera->topLR--;
     p->walking=1;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,(p->x)-1,p->y,world->currentZ);
     UpdateActorCoords(0,(p->x)-1,p->y); 

    }
   }
  break;
  case 1://right
   p->walking=0;
   p->walkingSubFrame=2;

   if(p->x+1!=wX&&!CheckSolid(world->level,p->x+1,p->y,world->currentZ))
   {
    npc =GetTensorNPC(world->level,p->x+1,p->y,world->currentZ); 
    if(npc!=-1)
    {  
        InteractActor(npc); 
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(camera->topLR!=wX-11&&p->x>=5)
       camera->topLR++;
     p->walking=2;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,(p->x)+1,p->y,world->currentZ);
     UpdateActorCoords(0,(p->x)+1,p->y); 
    }
   }
  break;
  case 2://up
   p->walking=0;
   p->walkingSubFrame=1;

   if(p->y-1>=0&&!CheckSolid(world->level,p->x,p->y-1,world->currentZ))
   {
    npc =GetTensorNPC(world->level,p->x,p->y-1,world->currentZ); 
    if(npc!=-1)
    {
       InteractActor(npc);
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(camera->topUD!=0&&p->y<wY-5){
      camera->topUD--;
     }
     p->walking=3;
     p->walkingSubFrame=0;
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     SetTensorNPC(world->level,0,p->x,(p->y)-1,world->currentZ);
     UpdateActorCoords(0,p->x,(p->y)-1); 
    }
   }
  break;
  case 3://down
   p->walking=0;
   p->walkingSubFrame=0;

   if(p->y+1!=wY&&!CheckSolid(world->level,p->x,p->y+1,world->currentZ))
   {
    npc = GetTensorNPC(world->level,p->x,p->y+1,world->currentZ);
    if(npc!=-1)
    {
        InteractActor(npc);
    }
    else
    {
     mc->talkieScene = -1;
     ClearDialog;
     if(camera->topUD!=wY-11&&p->y>=5){
      camera->topUD++;
     }
     RemoveTensorNPC(world->level,p->x,p->y,world->currentZ);
     p->walking=4;
     p->walkingSubFrame=0;
     SetTensorNPC(world->level,0,p->x,(p->y)+1,world->currentZ);
     UpdateActorCoords(0,p->x,(p->y)+1); 
    }
   }
  break;
  }
 }//if not walking

}

CDC *GetWalkAnimation(Actor *a)
{
  CDC *completeActor = DCNew(100,100);
  DCFill(completeActor, TRANSPARENT);

  U8 walkdir = a->walking;
  switch(a->race)
  {
   case 0://Judah
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,0,0,10,A1D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }
        break;
        case 1://up
         GrBlot3(completeActor,0,0,10,A1U2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }
        break;
        case 2://right
         GrBlot3(completeActor,0,0,10,A1R2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
        break;
        case 3://left
         GrBlot3(completeActor,0,0,10,A1L2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }
        break;
       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,0,0,10,A1D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,0,0,10,A1L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,0,0,10,A1R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,0,0,10,A1U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,0,0,10,A1D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,0,0,10,A1L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,0,0,10,A1R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,0,0,10,A1U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,0,0,10,A1D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,0,0,10,A1D2);
     break;

    }
   break;
   case 1://Levi
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
         GrBlot3(completeActor,-2,0,10,A2D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }

        break;
        case 1://up
         GrBlot3(completeActor,-2,0,10,A2U2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }

        break;
        case 2://right
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
  
         GrBlot3(completeActor,-2,0,10,A2R2);
        break;
        case 3://left
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }

         GrBlot3(completeActor,-2,0,10,A2L2);
        break;

       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,-2,0,10,A2D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,-2,0,10,A2L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,-2,0,10,A2R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,-2,0,10,A2U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,-2,0,10,A2D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,-2,0,10,A2L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,-2,0,10,A2R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,-2,0,10,A2U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,-2,0,10,A2D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,-2,0,10,A2D2);
     break;

    }
   break;

   case 2://Ephraim
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
        GrBlot3(completeActor,-4,0,10,A3D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }

        break;
        case 1://up
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }

        GrBlot3(completeActor,-4,0,10,A3U2);
        break;
        case 2://right
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
  
        GrBlot3(completeActor,-4,0,10,A3R2);
        break;
        case 3://left
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }

        GrBlot3(completeActor,-4,0,10,A3L2);
        break;

       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,-4,0,10,A3D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,-4,0,10,A3L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,-4,0,10,A3R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,-4,0,10,A3U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,-4,0,10,A3D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,-4,0,10,A3L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,-4,0,10,A3R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,-4,0,10,A3U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,-4,0,10,A3D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,-4,0,10,A3D2);
     break;

    }
   break;
   case 3://Benjamin
    switch(walkdir)
    {
     case 0://not walking
       switch(a->walkingSubFrame)
       {
        case 0://down
        GrBlot3(completeActor,-6,0,10,A4D2);
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=0;
 	  break;
          case 4...7:
   	  a->hair=4;
 	  break;
          case 8...11:
   	  a->hair=8;
 	  break;
          case 12...15:
   	  a->hair=12;
 	  break;
 	 }

        break;
        case 1://up
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=3;
 	  break;
          case 4...7:
   	  a->hair=7;
 	  break;
          case 8...11:
   	  a->hair=11;
 	  break;
          case 12...15:
   	  a->hair=15;
 	  break;

 	 }

        GrBlot3(completeActor,-6,0,10,A4U2);
        break;
        case 2://right
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=2;
 	  break;
          case 4...7:
   	  a->hair=6;
 	  break;
          case 8...11:
   	  a->hair=10;
 	  break;
          case 12...15:
   	  a->hair=14;
 	  break;
 	 }
  
        GrBlot3(completeActor,-6,0,10,A4R2);
        break;
        case 3://left
         switch(a->hair)
	 {
    	  case 0...3:
   	  a->hair=1;
 	  break;
          case 4...7:
   	  a->hair=5;
 	  break;
          case 8...11:
   	  a->hair=9;
 	  break;
          case 12...15:
   	  a->hair=13;
 	  break;
 	 }

        GrBlot3(completeActor,-6,0,10,A4L2);
        break;

       }
     break;
     case 1://left straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;       
        a->walking = 5;
       }
       switch(a->hair)
       {
        case 0...3:
        a->hair=1;
        break;
        case 4...7:
   	a->hair=5;
 	break;
        case 8...11:
   	a->hair=9;
 	break;
        case 12...15:
   	a->hair=13;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4L1);
     break;
     case 2://right straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 6;
       }
       switch(a->hair)
       {	
    	case 0...3:
   	a->hair=2;
 	break;
        case 4...7:
   	a->hair=6;
 	break;
        case 8...11:
   	a->hair=10;
 	break;
        case 12...15:
   	a->hair=14;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4R1);
     break;
     case 3://up straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 7;
       }
       switch(a->hair)
       {
    	case 0...3:
   	a->hair=3;
 	break;
        case 4...7:
   	a->hair=7;
 	break;
        case 8...11:
   	a->hair=11;
 	break;
        case 12...15:
   	a->hair=15;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4U1);
     break;
     case 4://down straight start
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 8;
       }
       switch(a->hair)
       {
    	case 0...3:
        a->hair=0;
        break;
        case 4...7:
        a->hair=4;
        break;
        case 8...11:
   	a->hair=8;
 	break;
        case 12...15:
   	a->hair=12;
 	break;
       }

       GrBlot3(completeActor,-6,0,10,A4D1);
     break;
     case 5://left left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 9;
       }

       GrBlot3(completeActor,-6,0,10,A4L2);
     break;
     case 6://right left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 10;
       }
       GrBlot3(completeActor,-6,0,10,A4R2);
     break;
     case 7://up left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 11;
       }
       GrBlot3(completeActor,-6,0,10,A4U2);
     break;
     case 8://down left leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 12;
       }
       GrBlot3(completeActor,-6,0,10,A4D2);
     break;
     case 9://left straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 13;
       }
       GrBlot3(completeActor,-6,0,10,A4L3);
     break;
     case 10://right straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 14;
       }
       GrBlot3(completeActor,-6,0,10,A4R3);
     break;
     case 11://up straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 15;
       }
       GrBlot3(completeActor,-6,0,10,A4U3);
     break;
     case 12://down straight mid
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 16;
       }
       GrBlot3(completeActor,-6,0,10,A4D3); 
     break;
     case 13://left right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=3;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4L2);
     break;
     case 14://right right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=2;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4R2);
     break;
     case 15://up right leg
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=1;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4U2);
     break;
     case 16://down right leg 
       a->walkingSubFrame++;

       if(a->walkingSubFrame== FRAMERULE)
       {
        a->walkingSubFrame=0;
        a->walking = 0;
       }
       GrBlot3(completeActor,-6,0,10,A4D2);
     break;

    }
   break;
   case 4:
    //Sprite3B(completeActor,-6,0,10,GetDog);

   break;
  }

 GrBlot3(completeActor,0,0,10,GetHair(a->hair));

 
 return completeActor; 
       

}

U8 GetWalkOffsetX(U8 walkdir)
{
 U8 XOffset = 0;
 switch(walkdir)
 {
  case 0://not walking
  break;
  case 1://left straight start
   XOffset=40;
  break;
  case 2://right straight start
   XOffset=-40;
  break;
  case 3://up straight start
  break;
  case 4://down straight start
  break;
  case 5://left left leg
   XOffset=30;
  break;
  case 6://right left leg
   XOffset=-30;
  break;
  case 7://up left leg
  break;
  case 8://down left leg
  break;
  case 9://left straight mid
   XOffset=20;
  break;
  case 10://right straight mid
   XOffset=-20;
  break;
  case 11://up straight mid
  break;
  case 12://down straight mid
  break;
  case 13://left right leg
   XOffset=10;
  break;
  case 14://right right leg
   XOffset=-10;
  break;
  case 15://up right leg
  break;
  case 16://down right leg 
  break;
 } 
 return XOffset; 
}

U8 GetWalkOffsetY(U8 walkdir)
{
 U8 YOffset = 0;
 switch(walkdir)
 {
  case 0://not walking
  break;
  case 1://left straight start
  break;
  case 2://right straight start
  break;
  case 3://up straight start
   YOffset=40;
  break;
  case 4://down straight start
   YOffset=-40;
  break;
  case 5://left left leg
  break;
  case 6://right left leg
  break;
  case 7://up left leg
   YOffset=30;
  break;
  case 8://down left leg
   YOffset=-30;
  break;
  case 9://left straight mid
  break;
  case 10://right straight mid
  break;
  case 11://up straight mid
   YOffset=20;
  break;
  case 12://down straight mid
   YOffset=-20;
  break;
  case 13://left right leg
  break;
  case 14://right right leg
  break;
  case 15://up right leg
   YOffset=10;
  break;
  case 16://down right leg 
   YOffset=-10;
  break;
 }
 return YOffset; 
}


I64 test =0;
//
// Task Functions
//

U0 DrawIt(CTask *task,CDC*dc)
{
 I64 i,j,l,colis;
 U8 sprite;

 switch(mc->currentMenu)
 {
//main menu
  case 0:
   MainMenu(dc,task);
   break;
//Main game
  case 1:
   Actor *p = GetNPC(0);

   if(keys.enter==TRUE)
   {
     if(mc->combatON)
     {
      switch(mc->combatMenuSelection)
      {
       case 0://move
       break;
       case 1://strike
       break;
       case 2://prayer
       break;
       case 3://flee
       break;
      }
     }
     else
     {
       MapNode *puin =GetTensorItem(world->level,p->x,
                     p->y,world->currentZ);
       if(puin->len>0)
       {
        I64 pui = (PickUpItem(puin,0))->id;
        mc->reRenderInv=TRUE;       
        if(!AddItemToInventory(0,pui))
        {
         Play("ArE"); 
        }
       }
     }
      
     keys.enter=FALSE;
   }
   if(keys.left==TRUE)
   {
     if(!mc->combatON)
     {
      MovePlayer(0);
     }
     keys.left=FALSE;

   }

   if(keys.right==TRUE)
   {
    if(!mc->combatON)
    {
     MovePlayer(1);
    }
    keys.right=FALSE;

   }
   if(keys.up==TRUE)
   {
     if(mc->combatON)
     {
      if(mc->combatMenuSelection!=0) 
       mc->combatMenuSelection--;
     }
     else{
      MovePlayer(2);
     }
      keys.up=FALSE;

   }
   if(keys.down==TRUE)
   {
     if(mc->combatON)
     {
      if(mc->combatMenuSelection!=3) 
       mc->combatMenuSelection++;
     }
     else{
      MovePlayer(3);
     }
      keys.down=FALSE;

   }

   dc->thick=1;
   
   //
   // background world
   //
   //x pan
   if(camera->topLR==0||camera->topLR==wX-11)
   {
    if(camera->cameraOffSetX!=0)
    {
      if(camera->cameraOffSetX>0)
       camera->cameraOffSetX=Max(0,camera->cameraOffSetX-1);
      else
       camera->cameraOffSetX=Min(0,camera->cameraOffSetX+1);

    }
   }
   else
   {
      camera->cameraOffSetX=-GetWalkOffsetX(p->walking);
   }

   //y pan
   if(camera->topUD==0||camera->topUD==wY-11)
   {
     if(camera->cameraOffSetY!=0)
     {
       if(camera->cameraOffSetY>0)
         camera->cameraOffSetY=Max(0,camera->cameraOffSetY-1);
       else
         camera->cameraOffSetY=Min(0,camera->cameraOffSetY+1);
     }
   }
   else
   {
      camera->cameraOffSetY=-GetWalkOffsetY(p->walking);
   }

   //draw world and one column and row extra for either side        
   for(i=-1;i<12;i++)
   {
    if(camera->topLR+i<wX&&camera->topLR+i>=0)
    {
     for(j=-1;j<12;j++)
     {
      if(camera->topUD+j<wY&&camera->topUD+j>=0)
      {
       I16 c =  GetTensor(world->level,camera->topLR+i,camera->topUD+j,world->currentZ);
       dc->color = GetBG(c);
       GrRect3(dc,i*camera->dividX+camera->cameraOffSetX, j*camera->dividY+camera->cameraOffSetY, -1,
                camera->dividX, camera->dividY);
       if(c>16)
       {
        switch(c)
        {
        case 17:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetWall1());
        break;
        case 18:
         Sprite3B(dc,i*camera->dividX+camera->cameraOffSetX,
                  j*camera->dividY+camera->cameraOffSetY,0,GetCarpet());
        break;
        } 
       }
  

      }
     }
    }
   }

   //draw npcs and items
   for(j=-1;j<12;j++)
   {
    if(camera->topUD+j<wX&&camera->topUD+j>=0)
    {
    for(i=-1;i<12;i++)
    {
     if(camera->topLR+i<wY&&camera->topLR+i>=0)
     {
      //ITEMS
      MapNode *mn = GetTensorItem(world->level,
                        camera->topLR+i,camera->topUD+j, 
                        world->currentZ);
 
      for(l=0;l<mn->len;l++)
      {
       I64 item = (GetItem(mn,l))->id;
       
       switch(item)
       {
         case 1:
         GrBlot3(dc,i*camera->dividX-13+camera->cameraOffSetX,
              j*camera->dividY+camera->cameraOffSetY,10,
              ITEM1);

         break;
         default:
         break;
       }
      } 
                

  
     I64 npc= GetTensorNPC(world->level,
              camera->topLR+i,camera->topUD+j,world->currentZ);     
   
     //NPCS
     if(npc!=-1)
     {
      Actor *toRender;
      I64 npcOffsetX=-camera->cameraOffSetX, npcOffsetY=-camera->cameraOffSetY;
      
      if(npc!=0){
      toRender = GetNPC(npc);

      npcOffsetX=GetWalkOffsetX(toRender->walking), 
      npcOffsetY=GetWalkOffsetY(toRender->walking);
      }
      else
      {
        toRender = p;
        if(camera->topLR==0||camera->topLR==wX-11)
         npcOffsetX=GetWalkOffsetX(toRender->walking);
        if(camera->topUD==0||camera->topUD==wY-11)
         npcOffsetY=GetWalkOffsetY(toRender->walking);
      
      }
      GrBlot3(dc,i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX,
              j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY,10,
              GetWalkAnimation(toRender));

      /*
      switch(toRender->race)
      { 
       case 0:
       GrBlot3(dc,i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX,
              j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY,10,
              GetWalkAnimation(toRender));
     
       //Sprite3B(dc,i*camera->dividX+4,j*camera->dividY+2,10,A1D2);     
       break;       
       case 1:
       GrBlot3(dc,i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX,
              j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY,10,
              GetWalkAnimation(toRender));

       //Sprite3B(dc,i*camera->dividX+4+camera->cameraOffSetX,
       //         j*camera->dividY+2+camera->cameraOffSetY,10,GetLevi());
       break;     
       case 2:
       GrBlot3(dc,i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX,
              j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY,10,
              GetWalkAnimation(toRender));

       //Sprite3B(dc,i*camera->dividX+4+camera->cameraOffSetX,
       //         j*camera->dividY+2+camera->cameraOffSetY,10,GetEphraim());
       break;       
       case 3:
       GrBlot3(dc,i*camera->dividX-13+npcOffsetX+camera->cameraOffSetX,
              j*camera->dividY-42+npcOffsetY+camera->cameraOffSetY,10,
              GetWalkAnimation(toRender));

       //Sprite3B(dc,i*camera->dividX+4+camera->cameraOffSetX,
       //            j*camera->dividY+2+camera->cameraOffSetY,10,GetBenjamin());
       break;
       case 4:
       Sprite3B(dc,i*camera->dividX+4+camera->cameraOffSetX,
                   j*camera->dividY+2+camera->cameraOffSetY,10,GetDog());
       break;
       
      }
      switch(toRender->eye)
      {
       case 0:
       Sprite3B(dc,i*camera->dividX+12,j*camera->dividY-34,10,GetEyes(0));
       break;
       case 1:
       Sprite3B(dc,i*camera->dividX+12,j*camera->dividY-34,10,GetEyes(1));
       break;
       case 2:
       Sprite3B(dc,i*camera->dividX+12,j*camera->dividY-34,10,GetEyes(2));
       break;
       case 3:
       Sprite3B(dc,i*camera->dividX+12,j*camera->dividY-34,10,GetEyes(3));
       break;
       case 4:
       break;
      }  
      switch(toRender->hair)
      {
       case 0:
       Sprite3B(dc,i*camera->dividX+10,j*camera->dividY-40,10,GetHair(0));
       break;
       case 1:
       Sprite3B(dc,i*camera->dividX+10,j*camera->dividY-40,10,GetHair(1));
       break;
       case 2:
       Sprite3B(dc,i*camera->dividX+10,j*camera->dividY-40,10,GetHair(2));
       break;
       case 3:
       Sprite3B(dc,i*camera->dividX+10,j*camera->dividY-40,10,GetHair(3));
       break; 
       case 4:
       break;     
      }*/
      if(mc->combatON==FALSE&&toRender->ai_script==1&&
         Abs((p->x)-(toRender->x))<=2&&
         Abs((p->y)-(toRender->y))<=2)
      {
        mc->combatON=TRUE;
        //mc->currentMenu=5;
        mc->currentSong=5;


      }
     }//if npc

     
     }//if too large y
    }//for y
    }//if too large x
   }//for x

   //Game Menus
   dc->color = DKGRAY;
   GrRect3(dc,12*camera->dividX+camera->cameraOffSetX,0,0,200,480);

   Sprite3B(dc,11*camera->dividX-25,-4,0,GetSideMenu); 
   Sprite3B(dc,494,420,0,GetButton(4));

   //Inventory button
   Sprite3B(dc,494,50,0,GetMenuSprite(0));    
   Sprite3B(dc,510,62,0,GetMenuSprite(1));

   //Current Spirit and Health 
   dc->color=BLUE;

   GrCircle(dc,518,344,36);
   

   I64 fillValue= ToI64((ToF64(p->currentMana)/ToF64(p->mana))*100);
  
 
   switch(fillValue)
   {
    case 1...5:
     GrLine(dc,512,380,525,380);         
     //GrFloodFill(dc,521,381,TRUE);
     dc->color=BLACK;         
     break;
    case 6...10:
     GrLine(dc,508,378,530,378);         
     GrFloodFill(dc,519,379,TRUE);
     dc->color=BLACK;         
     break;
    case 11...15:
     GrLine(dc,499,375,534,375);         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 16...20:
     GrLine(dc,495,373,540,373);//3         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 21...25:
     GrLine(dc,490,370,542,370);//1         
     GrFloodFill(dc,521,378,TRUE); 
     dc->color=BLACK;        
     break;
    case 26...30:
     GrLine(dc,490,367,544,367);         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 31...35: 
     GrLine(dc,488,365,546,365);        
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 36...40:
     GrLine(dc,485,363,546,363);         
     GrFloodFill(dc,521,378,TRUE);
     dc->color=BLACK;         
     break;
    case 41...45:
     GrLine(dc,480,355,550,355);         
     GrFloodFill(dc,521,378,TRUE);//12
     dc->color=BLACK;         
     break;
    case 46...50:
     GrLine(dc,480,350,553,350);    
     GrFloodFill(dc,521,378,TRUE);//11
     dc->color=BLACK;         
     break;
    case 51...55:
     GrLine(dc,480,347,553,347);         
     GrFloodFill(dc,521,378,TRUE);//10
     dc->color=WHITE;
         
     break;
    case 56...60:
     GrLine(dc,482,344,553,344);         
     GrFloodFill(dc,521,378,TRUE);//9
     dc->color=WHITE;
     break;
    case 61...65:
     GrLine(dc,483,340,552,340);
     GrFloodFill(dc,521,342,TRUE);//8
     dc->color=WHITE;
         
     break;
    case 66...70:
     GrLine(dc,484,335,552,335);
     GrFloodFill(dc,521,342,TRUE);//7
     dc->color=WHITE;
         
     break;
    case 71...75:
     GrLine(dc,484,330,550,330);
     GrFloodFill(dc,521,342,TRUE);//6
     dc->color=WHITE;
                       
     break;
    case 76...80:
     GrLine(dc,486,325,547,325);
     GrFloodFill(dc,521,342,TRUE);//5 
     dc->color=WHITE;             
              
     break;
    case 81...85:
     GrLine(dc,490,320,543,320); 
     GrFloodFill(dc,521,342,TRUE); //4 
     dc->color=WHITE;
            
     break;
    case 86...90:
     GrLine(dc,495,315,538,315);
     GrFloodFill(dc,521,342,TRUE);//3 
     dc->color=WHITE;
                
     break;
    case 91...95:
     GrLine(dc,506,310,530,310);
     GrFloodFill(dc,521,342,TRUE);//2 
     dc->color=WHITE;
    
              
     break;
    case 96...1000:
     GrFloodFill(dc,521,342,TRUE);//1
     dc->color=WHITE;
     
     break;
   }

   U8 *t1 = MStrPrint("%d/%d",p->currentMana,p->mana);
   for(i=0;i<StrLen(t1);i++)
   {
     GrChar(dc,t1[i],500+i*7,347,1);
   }


   dc->color=RED;
   GrCircle(dc,597,344,36);
   
   fillValue= ToI64((ToF64(p->currentHealth)/ToF64(p->health))*100);
  
   switch(fillValue)
   {
    case 1...5:     
     GrLine(dc,586,377,610,377);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;
     break;
    case 6...10:     
     GrLine(dc,582,375,616,375);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;
     break;
    case 11...15:     
     GrLine(dc,575,373,619,373);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;  
     break;
    case 16...20:
     GrLine(dc,573,370,621,370);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;       
     break;
    case 21...25: 
     GrLine(dc,570,367,625,367);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;      
     break;
    case 26...30:
     GrLine(dc,567,365,625,365);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;  
     break;
    case 31...35:
     GrLine(dc,565,363,627,363);
     GrFloodFill(dc,596,378,TRUE);      
     dc->color=BLACK;  
     break;
    case 36...40:
     GrLine(dc,563,360,629,360);
     GrFloodFill(dc,610,362,TRUE);      
     dc->color=BLACK;  
     break;
    case 41...45:
     GrLine(dc,562,355,629,355);     
     GrFloodFill(dc,610,362,TRUE);      
     dc->color=BLACK;
     break;
    case 46...50:
     GrLine(dc,560,350,631,350);    
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=BLACK;
     break;
    case 51...55:
     GrLine(dc,560,347,631,347);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 56...60:
     GrLine(dc,560,344,631,344);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 61...65:
     GrLine(dc,560,340,631,340);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 66...70:
     GrLine(dc,560,335,631,335);     
     GrFloodFill(dc,610,352,TRUE);      
     dc->color=WHITE;
     break;
    case 71...75:
     GrLine(dc,561,330,629,330);     
     GrFloodFill(dc,610,332,TRUE);      
     dc->color=WHITE;
     break;
    case 76...80:
     GrLine(dc,565,325,627,325);     
     GrFloodFill(dc,610,332,TRUE);      
     dc->color=WHITE;
     break;
    case 81...85:
     GrLine(dc,569,320,625,320);
     GrFloodFill(dc,610,332,TRUE);      
     dc->color=WHITE;          
     break;
    case 86...90:
     GrLine(dc,575,315,618,315);
     GrFloodFill(dc,610,332,TRUE);
     dc->color=WHITE;                
     break;
    case 91...95:
     GrLine(dc,585,310,606,310);
     GrFloodFill(dc,610,332,TRUE); 
     dc->color=WHITE;     
     break;
    case 96...1000:
     GrFloodFill(dc,610,332,TRUE); 
     dc->color=WHITE;    
     break;
   }
   
   t1 = MStrPrint("%d/%d",p->currentHealth,p->health);
   for(i=0;i<StrLen(t1);i++)
   {
     GrChar(dc,t1[i],580+i*7,347,1);
   }
   
   if(mc->talkieScene!=-1)//dialog
   {
    mc->displayInventory=FALSE;
    Chatbox(mc->dialogName,dc,task,mc->talkieScene);
   }
   else if(mc->combatON)//combat
   {
    mc->displayInventory=FALSE;
    switch(mc->combatMenuStage)
    {
     case 0:
      CombatDialog1(dc,task, mc->combatMenuSelection);
     break;
     case 1:
     break;
     case 2:
     break;
     case 3:
     break;
    } 
   }
   else if(mc->displayInventory)//inventory
   {
    dc->color = LTGRAY;
    GrRect3(dc,0,300,0,480,180);
    //background
    for(i=0;i<11;i++)
    {
     for(j=0;j<4;j++)
     {   
     Sprite3B(dc,i*camera->dividX+2,j*camera->dividY+300,
              0,GetMenuSprite(2));
     }
    }
    GrBlot3(dc,0,0,10,RenderInventory(p));
 
    Sprite3B(dc,460,280,0,GetMenuSprite(3));
    
   }
   
   break;
   //character select
   case 2:
   CharMenu(dc,task,A1D2,A2D2,A3D2,A4D2);   
   break;
   case 3:
   IntroCutscene(dc,task,mc->cutsceneTarget);
   break;
   case 4:
   LoadMenu(dc,task,loadRoot);
   break;
 }   
}

U0 CleanUp()
{
 DocClear;
 SettingsPop;
 DestroyTensor(world->level);
 Free(world);
 
 MenuPop;
 GetChar;
}

//
// Main
//

U0 RPGMain()
{
  CDC*dc=DCAlias;//Device Context
  I64 arg1,arg2,msg_code;
  SettingsPush;
  WinMax;
  WinBorder;
  DocCursor;
  DocClear;
  MenuPush("");


  Init;
//PrintTensor(world->level);

  Fs->draw_it=&DrawIt;
  Fs->song_task=
        Spawn(&SongTask,NULL,"Song",,Fs);

  while(TRUE)
  {

    camera->cursorX = ms.pos.x, camera->cursorY = ms.pos.y;
    switch(mc->currentMenu)
      {
      case 0://main menu
        switch (msg_code=GetMsg(&arg1,&arg2,
	      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	  {
	  case MSG_MS_L_DOWN:
	    if(camera->cursorX>=229&&camera->cursorX<=397)
	      {
	      if(camera->cursorY>258&&camera->cursorY<298)
	        {//new game
	        mc->currentMenu=3;
                mc->currentSong=3;
	      } else if(camera->cursorY>307&&camera->cursorY<349)
	        {//load game
	        loadRoot = FilesFind("Saves/*",FUF_JUST_FILES);
	        mc->currentMenu=4;
                mc->currentSong=4;
	      } else if(camera->cursorY>358&&camera->cursorY<399)
	        {//options

	      } else if(camera->cursorY>408&&camera->cursorY<448)
	        {//exit

	        goto fs_end;
	      }
	    }
	    break;
        }
        break;
      case 1://main game
        switch (msg_code=GetMsg(&arg1,&arg2,
	      1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	  {
	  case MSG_MS_L_DOWN:
	    if(camera->cursorX>=496&&camera->cursorX<=619&&
               camera->cursorY>=421&&camera->cursorY<=458)
	    {
	      SaveForm;
	      mc->currentMenu=0;
              mc->currentSong=1;
	    }
            else if(camera->cursorX>=496&&camera->cursorX<=543&&
               camera->cursorY>=60&&camera->cursorY<=120)
	    {
              if(mc->displayInventory==TRUE)
 		mc->displayInventory=FALSE;
              else
	       mc->displayInventory=TRUE;
	    }
            else if(camera->cursorX>=460&&camera->cursorX<=480&&
               camera->cursorY>=290&&camera->cursorY<=310
               &&mc->displayInventory==TRUE)
            {
 	      mc->displayInventory=FALSE;
            }
  
	    break;
	  case MSG_KEY_UP:
	   case '\n':
            keys.enter=FALSE;
       	    break;
	   case 0:
	    switch(arg2.u8[0])
	      {
                break;
	      case SC_CURSOR_LEFT:
	        keys.left=FALSE;
	        break;
	      case SC_CURSOR_RIGHT:
	        keys.right=FALSE;
	        break;
	      case SC_CURSOR_UP:
	        keys.up=FALSE;
	        break;
	      caseSC_CURSOR_DOWN:
	        keys.down=FALSE;
	        break;
	    }
	   break;
	  case MSG_KEY_DOWN:
	    switch(arg1)
	      {
	      case 'I':
              case 'i':
                mc->displayInventory=TRUE; 
                break;
           
	      //case CH_ESC:
	      case CH_SHIFT_ESC:
	        goto fs_end;
	        break;
              case '\n':
                keys.enter=TRUE;
       		break;
	      case 0:
	        switch(arg2.u8[0])
		  {
		  case SC_CURSOR_LEFT:
		    keys.left=TRUE;
		    break;
		  case SC_CURSOR_RIGHT:
		    keys.right=TRUE;
		    break;
		  case SC_CURSOR_UP:
		    keys.up=TRUE;
		    break;
		  case SC_CURSOR_DOWN:
		    keys.down=TRUE;
		    break;
	        }
	        break;
	    }
	    break;
          }
	  break;
	  case 2://character creation
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        if(camera->cursorX>=386&&camera->cursorX<=429)
		  {
		  if(camera->cursorY>300&&camera->cursorY<336)
		    { //tribe
		    IncSelect(0);
		  } else if(camera->cursorY>348&&camera->cursorY<382)
		    {//hair
		    IncSelect(1);
		  } else if(camera->cursorY>400&&camera->cursorY<432)
		    {//face
		    IncSelect(2);
		  }
	        }
	        if(camera->cursorX>=476&&camera->cursorX<=603)
		  {
		  if(camera->cursorY>=370&&camera->cursorY<=434)
		    {//next scene
		    U8 tribe = GetSelectedStats(0);
		    U8 str,con,int,wis;
		    switch(tribe)
		      {
		      case 0:
		        str=10;con=10;int=10;wis=10;
		        break;
		      case 1:
		        str=5;con=5;int=15;wis=15;
		        break;
		      case 2:
		        str=5;con=15;int=5;wis=15;
		        break;
		      case 3:
		        str=15;con=15;int=5;wis=5;
		        break;
		    }
		    ResetCurrLetter;
		    mc->cutsceneTarget=0;
		    SetNPC(MakeActor(0,tribe,GetSelectedStats(1),GetSelectedStats(2), 
			  0,0,0,0,0,
			  0,0,0,0,
			  5,5,str,int,con,wis,0));
		    mc->currentMenu=1;
                    mc->currentSong=0;
		  }
	        }
	        break;
	    }
	    break;
	  case 3://cutscene
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        mc->cutsceneTarget++;
	        ResetCurrLetter;
	        if(mc->cutsceneTarget>2)
		  {
		  mc->currentMenu=2;
                  mc->currentSong=2;
	        }
	        break;
	    }

	    break;
	  case 4://load menu
	    CDirEntry *cur;
	    I64 yInc=0,i;
	    switch (msg_code=GetMsg(&arg1,&arg2,
		  1<<MSG_KEY_DOWN|1<<MSG_MS_L_DOWN|1<<MSG_MS_L_UP|1<<MSG_MS_MOVE)) 
	      {
	      case MSG_MS_L_DOWN:
	        if(camera->cursorX>=19&&camera->cursorX<=187&&camera->cursorY>=18&&camera->cursorY<=58)
		  {
		  mc->currentMenu=0;
	        }
	        for(cur=loadRoot;cur!=NULL;cur=cur->next)
		  {
		  if(camera->cursorX>=190&&camera->cursorX<=590)
		  {
		    if(camera->cursorY>=yInc&&camera->cursorY<=yInc+25)
		    {
                      U8* edit = cur->name;
                      edit =MStrPrint("%s%s","Saves/",edit);
                                                               
		      LoadGame(edit);

		    }
		  }
		  yInc+=40;
	        }

	        break;
	    }
	    break;

        }
        Refresh;

    }
fs_end:
    //DCFill;
    DCDel(dc);
    CleanUp;

}
  RPGMain;