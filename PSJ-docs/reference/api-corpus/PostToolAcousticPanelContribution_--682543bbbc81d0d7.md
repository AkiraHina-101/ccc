# PostToolAcousticPanelContribution()

PostToolAcousticPanelContribution()

Description​

Create a plot line for each panel property based on Actran's element contribution results.

Syntax​

PostToolAcousticPanelContribution(int[] ilLoadCase, cursor[] crlProperty, int iDocumentAreaUnit, bool bCalSum)

Inputs​

1. int[]​

A List of Integer specifying the selected loadcases for the element contribution plot line.

2. cursor[]​

A List of Cursor specifying the property panels for the element contribution plot line.

3. int​

An Integer specifying the area unit.

4. bool​

A Boolean specifying whether to sum the element contributions (True = 1, False = 0).

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

PostToolAcousticPanelContribution([], [0:0], 0, 1)
