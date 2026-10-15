# PostToolsSubcaseFatigueEx()

PostToolsSubcaseFatigueEx()

Description​

Subcase - Fatigue.

Syntax​

PostToolsSubcaseFatigueEx(int AnaType, string Name, bool FromMaterial, float Qb, float Qw, float Qy, float Angle, string SubcaseName, int SubcaseID, Smap[] SubcaseMap, cursor[] target)

Inputs​

1. int ​

Analysis type.

2. string ​

Name

3. bool ​

From Material flag.

4. float ​

Qy

5. float ​

Qb

6. float ​

Qw

7. float ​

Angle

8. string ​

New Subcase name.

9. int ​

New subcase ID

10. SubcaseItem [] ​

Target subcases. SubcaseItem contents are:

int - ID,

string - name,

double - coefficient,

bool - status.

11. cursor [] ​

Target.

Return Code​

Nothing.

Sample Code​

PostToolsSubcaseFatigueEx(1, "Subcase Fatigue", 0, 270, 130, 165, 15, "Subcase Fatigue", 104, [(0, [(0, "Process= 0-Step=0, Time=1.000000e-02", 1,1), (1, "Process= 0-Step=1, Time=2.000000e-02", 1,1), (2, "Process= 0-Step=2, Time=3.000000e-02", 1,1), (3, "Process= 0-Step=3, Time=4.000000e-02", 1,1), (4, "Process= 0-Step=4, Time=5.000000e-02", 1,0), (5, "Process= 0-Step=5, Time=6.000000e-02", 1,0)])], [3:1])
