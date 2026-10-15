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

3. int​

Result set 

4. int​

Time step 

5. int  ​

opComplex

6. float  ​

phaseAngle

7. int  ​

scaling method

8. float  ​

Display ratio

9. bool  ​

Each direction ratio flag

10. float  ​

Deformation X

11. float  ​

Deformation Y

12. float  ​

Deformation Z

13. bool  ​

Apply all flag

Return Code​

Nothing.

Sample Code​

CmdShowPostDeformation(183:1, 1, 1, 1, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)
