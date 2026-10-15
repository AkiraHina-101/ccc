# ResultOutputList()

ResultOutputList()

Description​

Export the selected results to a CSV file or a universal format.

Syntax​

ResultOutputList(string PathFile, cursor[] Bodies, int ResultType, int Output, int OutPutType, int Target, bool MidNode, int[] PostResultKeyAnalysis, int[] PostResultKeyResultSet, int[] PostResultKeyTimeStep, int[] PostResultKeyCatType)

Inputs​

1. String​

A String specifying the file path to be exported.

2. Cursor[]​

A Cursor List specifying the selected parts to be exported data.

3. Int​

An Integer specifying the result type to be exported.

4. Int​

An Integer specifying to output all selected subcases in one file or in separated files for each selected subcase.

5. Int​

An Integer specifying the format of the output file.

6. Int​

An Integer specifying the output position of the result.

7. Bool​

A Boolean specifying whether to enable/disable middle node for the exported results.

8. Int[]​

A List specifying the attributes of the selected result.

9. Int[]​

A List specifying the attributes for the set of the selected results.

10. Int[]​

A List specifying the attributes for the time step of the selected results.

11. Int[]​

A List specifying the attributes for the cat type of the selected results.

Return Code​

"1": The function can be executed.

"0": The function cannot be executed.

Sample Code​

ResultOutputList("C:/temp/file.csv", [3:7, 3:8, 3:9, 3:2], 7, 0, 0, 0, 1, [1, 1, 1], [0, 0, 0], [0, 2, 4], [0, 0, 0])
