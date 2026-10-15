# CmdPostAnimationSettings()

CmdPostAnimationSettings()

Description​

Animation setting.

Syntax​

CmdPostAnimationSettings(int Mode, int FPS, int DivideNum, int DivideType, int LoopType, int AnimationResType, bool ApplyDeform, bool Locus, bool PhaseAngleAni, bool AcousticCombineAni, string[] SubcaseIds, bool MultiAnalysis, bool MemCache, bool FixContour, bool SectionMode, bool SetTime, float StartTime, float EndTime)

Inputs​

1. int  ​

Animation mode

2. int  ​

Animation speed (FPS)

3. int  ​

No. of Frame

4. int  ​

Dividing Method

5. int  ​

Looping Type

6. bool  ​

Animation Res Type

7. bool  ​

Apply Deform

8. bool  ​

Locus

9. bool  ​

Animation setting for Phase Angle Ani

10. bool  ​

Animation setting for Acoustic Combine Ani

11. string []  ​

Subcase IDs

12. bool  ​

MultiAnalysis flag

13. bool  ​

Mem Cache flag

14. bool  ​

Fix Contour flag

15. bool  ​

Section display method,

16. bool  ​

Set Time flag

17. float  ​

Start Time

18. float  ​

End Time

Returint Code​

Nothing.

Sample Code​

CmdPostAnimationSettings(0, 8, 8, 1, 2, 0, 1, 0, 0, 0, [], 0, 1, 0, 0, 0, 0.000000, 0.000000)
