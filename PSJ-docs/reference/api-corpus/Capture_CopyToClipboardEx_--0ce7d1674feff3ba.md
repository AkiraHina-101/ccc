# Capture_CopyToClipboardEx()

Capture_CopyToClipboardEx()

Description​

Copy image of Main Window to clip board.

Syntax​

Capture_CopyToClipboardEx(bool WhiteBG, bool TransparentBG, bool FixedSize, int exportWidth, int exportHeight)

Inputs​

1. Bool​

White background bool flag true = 1, false = 0

2. Bool​

Transparent background flag true = 1, false = 0

3. Bool​

Fixed Size flag true = 1, false = 0

4. Int​

Export Width

5. Int​

Export Height

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Capture_CopyToClipboardEx( 0, 0, 0, 1200, 900)
