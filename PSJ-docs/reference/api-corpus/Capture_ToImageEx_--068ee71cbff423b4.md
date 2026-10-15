# Capture_ToImageEx()

Capture_ToImageEx()

Description​

Capture to Image File.

Syntax​

Capture_ToImageEx(string strNamePath, bool WhiteBG, bool TransparentBG,
    bool FixedSize, int exportWidth, int exportHeight, bool bAutoCapture, int[] listAdjust)

Inputs​

1. String​

Import file path

2. Bool​

White background bool flag true = 1, false = 0

3. Bool​

Transparent background flag true = 1, false = 0

4. Bool​

Fixed Size flag true = 1, false = 0

5. Int​

Export Width

6. Int​

Export Height

7. Bool​

Specify whether crop image to the displayed entity range.

8. int[]​

Specify the left, top, right and bottom margins from the minimized area.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Capture_ToImageEx("D:/Test.jpg", 0, 0, 0, 1200, 900, 0, [0, 0, 0, 0])
