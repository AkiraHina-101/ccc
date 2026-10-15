# PostToolsSubcaseSafetyFactor()

PostToolsSubcaseSafetyFactor()

Description​

Subcase - Safety Factor.

Syntax​

PostToolsSubcaseSafetyFactor(int AnaType, int RltSet, SubcaseItem[] SubCases, SafetyItem[] SafetyItems, int ThresholdType, string RltName)

Inputs​

1. int ​

Analysis type.

2. int ​

Result Set.

3. SubcaseItem [] ​

Target subcases. SubcaseItem contents are: 

int - ID, 

string - name, 

double - coefficient, 

bool - status.

4. SafetyItem [] ​

Target item. SafetyItem contents are: 

cursor - parts, 

double - threshold.

5. int ​

Threshold Type

6. string ​

Result name.

Return Code​

Nothing.

Sample Code​

PostToolsSubcaseSafetyFactor(1, 0, [(0, "Step=0, Time=1.000000e-02", 1,1), (1, "Step=1, Time=2.000000e-02", 1,1), (2, "Step=2, Time=3.000000e-02", 1,1)], [(3:1, 0)], 0, "Safety Yield")
