# Home.RectangularCapture.Single()

Home.RectangularCapture.Single()

Description​

Create a frame for Single capture and save it in the “User Frame” tree of the ViewPoint window. The created frame will be used with the "To PPT" and "To Image" command.

Syntax​

Home.RectangularCapture.Single(...)

Macro: ViewMakeUserFrame

Ribbon: Home » RectangularCapture » Single

Inputs​

strFrameName​

A String specifying the name of frame to be captured.

This is a required input.

iStartPointX​

An Integer specifying the x-coordinate of the start point of the frame.

This is a required input.

iStartPointY​

An Integer specifying the x-coordinate of the start point of the frame.

This is a required input.

iWidth​

An Integer specifying the width of the frame size.

This is a required input.

iHeight​

An Integer specifying the height of the frame size.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)

# Create a single frame
Home.RectangularCapture.Single(strFrameName="New_Frame_1 (Single)", iStartPointX=459, iStartPointY=212, 
                                iWidth=460, iHeight=214)
Home.ToPPTX()
