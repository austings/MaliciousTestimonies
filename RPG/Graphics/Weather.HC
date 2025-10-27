

//
//
U0 PlayWeather(CDC *dc, I64 i, I64 j){

 CDC *weatherLayer = DCNew(480,480);
 F64 fallProgress = (mc->tickWeather / ToF64(W_T)) * 480.0;
 DCFill(weatherLayer,TRANSPARENT);
 F64 driftAmp = 32.0;
 F64 driftFreq = 0.20;
 for (i = 0; i < 480; i += 128) {        // leaves every 128 px horizontally
  for (j = 0; j < 480; j += 128) {    // spaced evenly down the screen

   // Checkerboard pattern: offset alternate rows
   I64 xBase = i + ((j / 128) % 2) * 64;

            // Wrap leaves when tick resets (so motion loops cleanly)
   F64 yBase = fmod((j + fallProgress), 480.0) - 60.0;

            // Add sine-based horizontal drift
   F64 xDrift = driftAmp * Sin((mc->tickWeather * driftFreq) + j * 0.2);

   Sprite3B(weatherLayer, ToI64(xBase + xDrift), ToI64(yBase), 0, GetLeaf);
  }
 }

 GrBlot3(dc,0,0,0,weatherLayer);
 DCDel(weatherLayer);

}