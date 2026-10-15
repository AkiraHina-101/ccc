# CmdShowPostDeformation()

CmdShowPostDeformation()

Description​

Show deformation.

Syntax​

CmdShowPostDeformation(Cursor crPostJob,
    int analysisType, int resultSet, int timeStep, int opComplex, float phaseAngle, int scaleMethod, float dispRatio, bool eachDispComp, 
    float dispRatioEachX,  float dispRatioEachY, float dispRatioEachZ, bool bApplyAll)

Inputs​

1. Cursor​

Cursor of post job.

2. int​

Analysis type.

3. PostResultKey::int​

Analysis ID.

4. int​

Result set 

5. int​

Time step 

6. string  ​

Name of result

7. string  ​

Name of component

8. int  ​

opComplex

9. float  ​

phaseAngle

10. int  ​

scaling method

11. float  ​

Display ratio

12. bool  ​

Each direction ratio flag

13. float  ​

Deformation X

14. float  ​

Deformation Y

15. float  ​

Deformation Z

16. bool  ​

Apply all flag

Return Code​

Nothing.

Sample Code​

CmdShowPostDeformation(183:1, 2, 0, 1, 1, Displacement, Translational, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)
