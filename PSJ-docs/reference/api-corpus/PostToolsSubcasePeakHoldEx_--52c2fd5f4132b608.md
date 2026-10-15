# PostToolsSubcasePeakHoldEx()

PostToolsSubcasePeakHoldEx()

Description​

Subcase - Peak Hold.

Syntax​

PostToolsSubcasePeakHoldEx(int analysisType, bool Fatigue, float Qb, float Qw, float Qy, string SubcaseName, int SubcaseID, map[] SubcaseMap)

Inputs​

1. int ​

Analysis type.

2. bool ​

Fatigue parameter flag.

3. float ​

Qy

4. float ​

Qb

5. float ​

Qw

6. string ​

Name

7. int​

ID

8. map[] ​

Source results.

Map contents are: 

int - Result Set, 

SubcaseItem.
2-1. int - ID
2-1. string - Name,
2-2. int - Status,
2-4. bool - Enabled / Disabled. 

Return Code​

Nothing.

Sample Code​

PostToolsSubcasePeakHoldEx(1, 0, 270, 130, 165, "Subcase 101 Peak Hold", 101, [(0, [(0, "Step=0, Time=1.000000e-02", 1,1), (1, "Step=1, Time=2.000000e-02", 1,1), (2, "Step=2, Time=3.000000e-02", 1,1), (3, "Step=3, Time=4.000000e-02", 1,1), (4, "Step=4, Time=5.000000e-02", 1,1), (5, "Step=5, Time=6.000000e-02", 1,0)])])
