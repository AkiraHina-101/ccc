# DYNAMIC_FREQ_ANALYSIS_LOADCASE()

DYNAMIC_FREQ_ANALYSIS_LOADCASE()

Description​

Create Load Case of Frequency Analysis

Syntax​

DYNAMIC_FREQ_ANALYSIS_LOADCASE(int AnalysisType, cursor ParentAnalysis, string Name, double Factor, int newID, cursor[] SelLoad, double[] targetFactor, cursor EditTarget)

Inputs​

1. int  ​

Analysis type

2. cursor  ​

Parent analysis

3. string  ​

Name

4. double  ​

Coefficient

5. int  ​

ID

6. cursor[]  ​

Selected Loads

7. double[]  ​

Coefficients of each selected load.

8. cursor  ​

Target load case when modify.

Return Code​

Nothing.

Sample Code​

DYNAMIC_FREQ_ANALYSIS_LOADCASE(1, 195:1, "LoadCase1", 3, 2, [197:3, 197:4], [1, 4], 0:0)
