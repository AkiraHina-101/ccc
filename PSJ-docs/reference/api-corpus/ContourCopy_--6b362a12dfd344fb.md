# ContourCopy()

ContourCopy()

Description​

Display the contour of the current Post document in the specified Pre document.

Syntax​

ContourCopy(string PostDocName, string PreDocName)

Inputs​

1. String​

A String specifying the Post document name to copy the contour.

2. String​

A String specifying the Pre document name to be copied the contour.

Return Code​

"1": The function can be executed.

"0": The function cannot be executed.

Sample Code​

ContourCopy("101_solid", "101_solid_Converted_Pre")
