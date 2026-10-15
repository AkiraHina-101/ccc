# PostExportToTxt()

PostExportToTxt()

Description​

Export results to .txt file.

Syntax​

PostExportToTxt(str strFileName, int iSpliterType, bool bAppend, cursor[] crlJobs, int[] ilAnalysisTypes, int[] ilResultSets, int[] ilTimeSteps, int[] ilResultTypes, int[] ilResultPos, str[] strlResultNames, str[] strlCompNames, str[] strlNames, str[] strlTypes, cursor[] crlEdit)

Inputs​

1. str​

A string specifying file name.

2. int​

An integer specifying the type of delimiter.

3. bool​

A boolean specifying whether to append the data.

4. cursor[]​

A list of cursor specifying the jobs.

5. int[]​

A list of integers specifying the types of analysis.

6. int[]​

A list of integers specifying the result sets.

7. int[]​

A list of integers specifying the time steps.

8. int[]​

An list of integers specifying the types of results.

9. int[]​

A list of integers specifying the positions of the results.

10. str[]​

A list of strings specifying the names of the results.

11. str[]​

A list of strings specifying the names of the components.

12. str[]​

A list of strings specifying names.

13. str[]​

A list of strings specifying types.

14. cursor[]​

A list of cursor specifying edit.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

PostExportToTxt("strFileName", 0, 0, [], [], [], [], [], [], [], [], [], [], [])
