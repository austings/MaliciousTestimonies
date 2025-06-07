
I64 glbl_r[4][4];

U0 DrawIt(CTask *,CDC *dc)
{
  I64 *old_r=dc->r;
  dc->thick=2;
  dc->color=RED;
  dc->x=200;
  dc->y=200;
  dc->flags|=DCF_TRANSFORMATION;
  DCMat4x4Set(dc,glbl_r); //This assigns to dc->r and sets r_norm.
  GrLine3(dc,-100,-100,-100, -100, 100,-100);
  GrLine3(dc,-100, 100,-100,  100, 100,-100);
  GrLine3(dc, 100, 100,-100,  100,-100,-100);
  GrLine3(dc, 100,-100,-100, -100,-100,-100);
  GrLine3(dc,-100,-100, 100, -100, 100, 100);
  GrLine3(dc,-100, 100, 100,  100, 100, 100);
  GrLine3(dc, 100, 100, 100,  100,-100, 100);
  GrLine3(dc,-100,50,100, 100, 50, 100);
  GrLine3(dc, 100,-100, 100, -100,-100, 100);
  GrLine3(dc,-100,-100, 100, -100,-100,-100);
  GrLine3(dc,-100, 100, 100, -100, 100,-100);
  GrLine3(dc, 100, 100, 100,  100, 100,-100);
  GrLine3(dc, 100,-100, 100,  100,-100,-100);
  dc->r=old_r;
}

U0 Box()
{
  F64 a1=0,a2=0,a3=0,s=1,s1=1.05;
  SettingsPush; //See $LK,"SettingsPush",A="MN:SettingsPush"$
  DocClear;
  Fs->draw_it=&DrawIt;
  while (!ScanChar) {
    Mat4x4IdentEqu(glbl_r);
    //Mat4x4RotX(glbl_r,a1);
    //Mat4x4RotY(glbl_r,s);
    Mat4x4RotX(glbl_r,90);
    //Mat4x4Scale(glbl_r,s);

    Sleep(20);
    a1+=2*a3/70;
    a2+=2*a3/90;
    a3+=2*a3/110;
    s*=s1;
    if ( !(0.2<s<1.4) ) s1=1/s1;
  }
  SettingsPop;
}

Box;
/*

$WW,1$$LK,"CDC",A="MN:CDC"$'s have a 4x4 matrix for rotating, scaling, skewing and shifting in 3 dimensions.  To make the graphics routines use the transform, you must set the $LK,"DCF_TRANSFORMATION",A="MN:DCF_TRANSFORMATION"$ flag.

The matrix consists of ints that have been scaled 32 bits ($LK,"GR_SCALE",A="MN:GR_SCALE"$).  See $LK,"::/Demo/Lectures/FixedPoint.HC"$ to learn why.

See $LK,"Mat4x4IdentEqu",A="MN:Mat4x4IdentEqu"$(), $LK,"Mat4x4IdentNew",A="MN:Mat4x4IdentNew"$(), $LK,"Mat4x4Equ",A="MN:Mat4x4Equ"$() and $LK,"Mat4x4New",A="MN:Mat4x4New"$().  See $LK,"Mat4x4RotX",A="MN:Mat4x4RotX"$(), $LK,"Mat4x4RotY",A="MN:Mat4x4RotY"$(), $LK,"Mat4x4RotZ",A="MN:Mat4x4RotZ"$() and $LK,"Mat4x4Scale",A="MN:Mat4x4Scale"$() to rotate about axes and scale.  Combine them with $LK,"Mat4x4MulMat4x4Equ",A="MN:Mat4x4MulMat4x4Equ"$()/$LK,"Mat4x4MulMat4x4New",A="MN:Mat4x4MulMat4x4New"$() $LK,"::/Demo/Graphics/Box.HC"$.

You can rotate single points using $LK,"Mat4x4MulXYZ",A="MN:Mat4x4MulXYZ"$().

The 4th dimension allows a neat trick where you can place pos shifts (translations), into the matrix and $LK,"Mat4x4MulMat4x4Equ",A="MN:Mat4x4MulMat4x4Equ"$/$LK,"Mat4x4MulMat4x4New",A="MN:Mat4x4MulMat4x4New"$ them to combine rotation/shift operations.  Normally, you can't combine pos shift operations.  See $LK,"Mat4x4TranslationEqu",A="MN:Mat4x4TranslationEqu"$() and $LK,"::/Demo/Graphics/Transform.HC"$.

Finally, $LK,"CDC",A="MN:CDC"$'s have an $FG,2$x$FG$, $FG,2$y$FG$ and $FG,2$z$FG$ which is an additional shift (translation).

The transformation is implemented as a callback on the $LK,"CDC",A="MN:CDC"$'s $FG,2$transform()$FG$ member.  The default $FG,2$transform()$FG$ callback is $LK,"DCTransform",A="MN:DCTransform"$().  See $LK,"::/Demo/Games/Talons.HC"$ or $LK,"::/Demo/Games/CastleFrankenstein.HC"$ to see how to change the $FG,2$transform()$FG$ callback for foreshortening.