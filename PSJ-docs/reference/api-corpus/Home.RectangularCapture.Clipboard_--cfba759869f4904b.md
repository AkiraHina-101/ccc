# Home.RectangularCapture.Clipboard()

Home.RectangularCapture.Clipboard()

Description​

Capture specified area in Main Window to clipboard.

Syntax​

Home.RectangularCapture.Clipboard(...)

Macro: Capture_Rectangular()

Ribbon: Home » RectangularCapture » Clipboard

Inputs​

iLeft​

An Integer specifying pixel position of image left.

The default value is 0.

iTop​

An Integer specifying pixel position of image top.

The default value is 0.

iRight​

An Integer specifying pixel position of image right.

The default value is 0.

iBottom​

An Integer specifying pixel position of image bottom.

The default value is 0.

Return Code​

A Boolean specifying whether the function is successfully executed or not.

Sample Code​

Geometry.Part.Cube()
JPT.ViewFitToModel
Home.RectangularCapture.Clipboard(
    iLeft=157, 
    iTop=175, 
    iRight=408, 
    iBottom=297)
