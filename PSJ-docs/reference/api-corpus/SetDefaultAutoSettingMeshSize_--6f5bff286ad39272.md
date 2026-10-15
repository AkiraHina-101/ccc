# SetDefaultAutoSettingMeshSize()

SetDefaultAutoSettingMeshSize()

Description​

Turn ON/OFF Data Validation.

Syntax​

SetDefaultAutoSettingMeshSize(int Selection, float Maximum, float Minimum)

Inputs​

1. int​

Select setting type

0: Average

1: Minimum

2: Maximum

2. float​

Coefficent for Maximum mesh size.

3. float​

Coefficent for Minimum mesh size.

Return Code​

No return code.

Sample Code​

SetDefaultAutoSettingMeshSize(1, 2, 0.2)
