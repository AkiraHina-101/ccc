# Capture_ToImageEx()

Capture_ToImageEx()

Description​

Capture to Image File.

Syntax​

Capture_ToImageEx(string strNamePath, bool WhiteBG, bool TransparentBG,
    bool FixedSize, int exportWidth, int exportHeight)

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

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Capture_ToImageEx("D:/Test.jpg", 0, 0, 0, 1200, 900)
