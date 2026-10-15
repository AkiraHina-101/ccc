# JPT.DrawLine()

JPT.DrawLine()

Description​

Draw a line in Main Window

Syntax​

JPT.DrawLine()

Inputs​

listStartPoint​

A list specifying the coordinates of the the starting point of the line (e.g., [x1, y1, z1]).

The value is in SI units [meters].

listEndPoint​

A list specifying the coordinates of the the ending point of the line (e.g., [x2, y2, z2]).

The value is in SI units [meters].

color​

An Int in hexadecimal format representing the arrow's color.

The default color is cyan (RGB(0, 255, 255)).

width​

An Int specifying the width of the arrow's shaft in pixels.

The default is 1.

Return Code​

A Boolean specifying Succeeded or Failed.

True: Succeeded.

False: Failed.

Sample Code​

#Prepare a model for view
Geometry.Part.Cube(dlLength=[10.0, 10.0, 10.0])
JPT.ViewFitToModel()

# Draw a white line from [0, 0, 0] to [10, 20, 30] with the default color and width:
JPT.DrawLine([0, 0, 0], [10, 20, 30])

# Draw a red line from [5, 5, 5] to [15, 15, 15] with a width of 2.5:
JPT.DrawLine([5, 5, 5], [15, 15, 15], 255, 2.5)

# Draw a green line from [1, 1, 1] to [2, 2, 2] with a width of 1.5:
JPT.DrawLine([1, 1, 1], [2, 2, 2], 65280, 1.5)
