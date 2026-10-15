# DYNAMIC_FREQ_ANALYSIS_LOAD()

DYNAMIC_FREQ_ANALYSIS_LOAD()

Description​

Create Load for Frequency response analysis

Syntax​

DYNAMIC_FREQ_ANALYSIS_LOAD(int AnalysisType, cursor ParentAnalysis, cursor	Coord, string Name, int LoadPtn, vector Force, 
donble Amplitude,double Delay, double Phase, bool Bf, double Bf, cursor BfCurve, bool Ff, double Ff, cursor FfCurve, bool UnitLoad, 
bool CentripetalForce, cursor[] Target, cursor Edit)

Inputs​

1. string  ​

Analysis type

2. int  ​

Parent analysis

3. cursor  ​

Coordinate

4. string  ​

Load Name

5. int  ​

Direction
0: X
1: Y
2: Z
3: RX
4: RY
5: RZ
6: Normal

6. vector  ​

Force direction in vector format.

7. double  ​

Amplitude

8. double  ​

Delay

9. double  ​

Phase

10. bool  ​

Check flag of B(f) table input

11. double  ​

B(f) value without table = 1.0

12. cursor  ​

Cursor to B(f) table

13. bool  ​

Check flag of F(f) table input

14. double  ​

F(f) value without table = 0.0

15. cursor  ​

Cursor to F(f) table

16. bool  ​

Unit Load flag

17. bool  ​

mr*omega^2 flag

18. cursor[]  ​

Target nodes

12. cursor  ​

Target Load when modify

Return Code​

Nothing.

Sample Code​

DYNAMIC_FREQ_ANALYSIS_LOAD(0, 0:0, 0:0, "FRQLOAD10", 2, [0, 0, 1], 1, 1, 1, 0, 1, 0:0, 0, 0, 0:0, 0, 0, [10:9513], 0:0)
