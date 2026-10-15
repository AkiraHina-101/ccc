# AttachTemplateAnimation()

AttachTemplateAnimation()

Description​

Attach animation setting to specified template.

Syntax​

AttachTemplateAnimation(string templateName, int Mode, int FPS, int DivideNum, int DivideType, int LoopType, int AnimationResType, bool ApplyDeform, bool Locus, bool PhaseAngleAni, bool AcousticCombineAni, string[] SubcaseIds, bool MultiAnalysis, bool MemCache, bool FixContour, bool SectionMode, bool SetTime, float StartTime, float EndTime))

Inputs​

1. string ​

Template name.

2. int  ​

Animation mode

3. int  ​

Animation speed (FPS)

4. int  ​

No. of Frame

5. int  ​

Dividing Method

6. int  ​

Looping Type

7. bool  ​

Animation Res Type

8. bool  ​

Apply Deform

9. bool  ​

Locus

10. bool  ​

Animation setting for Phase Angle Ani

11. bool  ​

Animation setting for Acoustic Combine Ani

12. string []  ​

Subcase IDs

13. bool  ​

MultiAnalysis flag

14. bool  ​

Mem Cache flag

15. bool  ​

Fix Contour flag

16. bool  ​

Section display method,

17. bool  ​

Set Time flag

18. float  ​

Start Time

19. float  ​

End Time

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateAnimation("My Template", 0, 8, 8, 1, 1, 0, 1, 0, 0, 0, [], 0, 1, 0, 0, 0, 0.01, 1)
