

//
//depcreated full layer weather
U0 PlayWeather(CDC *dc, I64 i, I64 j, I64 screenX, I64 screenY){

 CDC *weatherLayer = DCNew(480,480);
 F64 fallProgress = (mc->tickWeather / ToF64(W_T)) * 480.0;
 DCFill(weatherLayer,TRANSPARENT);
 F64 parallaxFactor = 0.1;
 F64 driftAmp = 32.0;
 F64 driftFreq = 0.20;
 for (i = 0; i < 480; i += 128) {        // leaves every 128 px horizontally
  for (j = 0; j < 480; j += 128) {    // spaced evenly down the screen

    F64 xBase = fmod(i + ((j / 128) % 2) * 64 - (mc->smoothScreenX * parallaxFactor), 480.0);
    F64 yBase = fmod((j + fallProgress) - (mc->smoothScreenY * parallaxFactor), 480.0) - 60.0;

    F64 xDrift = driftAmp * Sin((mc->tickWeather * driftFreq) + j * 0.2);
    Sprite3B(weatherLayer, ToI64(xBase + xDrift), ToI64(yBase), 0, GetLeaf);


//   F64 xBase = fmod(i - (screenX * parallaxFactor), 480.0);
 //  F64 yBase = fmod((j + fallProgress) - (screenY * parallaxFactor), 480.0) - 60.0;
//   F64 xDrift = driftAmp * Sin((mc->tickWeather * driftFreq) + j * 0.2);
//   Sprite3B(weatherLayer, ToI64(xBase + xDrift), ToI64(yBase), 0, GetLeaf);
  }
 }

 GrBlot3(dc,0,0,0,weatherLayer);
 DCDel(weatherLayer); 

}


//tile perfect weather
//device context to draw on
//i, j converted tile x coordinate
//i2, j2 current tile x,y
//lower bound and upper tile bound
//
U0 PlayWeather2(CDC *dc, I64 i2, I64 j2, I64 i, I64 j,
                   I64 hlb, I64 hub, I64 wlb, I64 wub)
{
 CDC *weatherLayer = DCNew(480,480);
 F64 fallProgress = (mc->tickWeather / ToF64(W_T)) * 480.0;
 DCFill(weatherLayer,TRANSPARENT);
 F64 parallaxFactor = 0.1;
 F64 driftAmp = 32.0;
 F64 driftFreq = 0.20;

 F64 xBase = fmod(i + ((i / 128) % 2) * 64 - 
                 (mc->smoothScreenX * parallaxFactor), 480.0);
 F64 yBase = fmod((j + fallProgress) - 
                 (mc->smoothScreenY * parallaxFactor), 480.0) - 60.0;
 F64 xDrift = driftAmp * Sin((mc->tickWeather * driftFreq) + j * 0.2);

 I64 finalX = ToI64(xBase - xDrift);
 I64 finalY = ToI64(yBase);
 Bool col = FALSE;
 for(i=hlb+2;i<hub-5;i++)
 {  
  I16 c =  GetTensor(world->level,i2,i,world->currentZ); 
  if(c>BG_LT_GRAY){
   col = TRUE; 
   break;
  }
   

 }
 if(!col)
  Sprite3B(weatherLayer, finalX-140, ToI64(yBase)+j2, 0, GetLeaf); 
 GrBlot3(dc,0,0,0,weatherLayer);
 DCDel(weatherLayer);


}
