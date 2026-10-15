# ResultOutputList()

ResultOutputList()

Description​

Export List.

Syntax​

ResultOutputList(string FilePath, cursor[] taBody, int ResultType, int Output, bool OutPutType, int Target, bool MidNode, int[] PostResultKeyAnalysis, int[] PostResultKeyResultSet, int[] PostResultKeyTimeStep, int[] PostResultKeyCatType)

Inputs​

1. string ​

Export file path.

2. cursor[] ​

Target entity list.

3. int ​

Result Type.

4. int ​

Output type.

5. bool ​

All parts flag.

6. int ​

Target

7. bool ​

Mid Node flag.

8. int [] ​

Post Result Key Analysis

9. int [] ​

Post Result Key Result Set

9. int [] ​

Post Result Key Time Step

9. int [] ​

Post Result Key Cat Type

Return Code​

Nothing.

Sample Code​

ResultOutputList("C:/temp/file.csv", [3:7, 3:8, 3:9, 3:2], 7, 0, 0, 0, 1, [1, 1, 1], [0, 0, 0], [0, 2, 4], [0, 0, 0])
