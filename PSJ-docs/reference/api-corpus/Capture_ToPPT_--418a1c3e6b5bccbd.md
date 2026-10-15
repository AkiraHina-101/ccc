# Capture_ToPPT()

Capture_ToPPT()

Description​

Save the display window of Jupiter to an image file in pptx.

Syntax​

Capture_CopyToClipboardEx(bool bAutoCapture, int[] listAdjust)

Inputs​

1. Bool​

Specify whether crop image to the displayed entity range.

2. int[]​

Specify the left, top, right and bottom margins from the minimized area.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Capture_ToPPT(0, [0,0,0,0])
