# Home.RectangularCapture()

Home.RectangularCapture()

Description​

Save the specified range of Jupiter's display window to the clipboard.

Syntax​

Home.RectangularCapture(...)

Ribbon: Home » RectangularCapture

Inputs​

iLeft​

An Integer specifying the left position. This is the position of the starting point in horizontal axis of the screen coordinate. The screen coordinate is a coordinate whose origin is at the top left corner of the view window. Its horizontal axis expands rightward and the vertical axis expands downward.

The default value is 0.

iTop​

An Integer specifying the top position. This is the position of the starting point in vertical axis of the screen coordinate.

The default value is 0.

iRight​

An Integer specifying the right position. This is the position of the ending point in horizontal axis of the screen coordinate.

The default value is 0.

iBottom​

An Integer specifying the bottom position. This is the position of the ending point in vertical axis of the screen coordinate.

The default value is 0.

Return Code​

A Boolean specifying the status of the process:

True: The specified range of display window of Jupiter is saved to clipboard.

False: The specified range of display window cannot be saved to clipboard.

Sample Code​

Geometry.Part.Cube()

copy = Home.RectangularCapture(iLeft=477,
                               iTop=159,
                               iRight=900,
                               iBottom=562)

JPT.Debugger(copy)
