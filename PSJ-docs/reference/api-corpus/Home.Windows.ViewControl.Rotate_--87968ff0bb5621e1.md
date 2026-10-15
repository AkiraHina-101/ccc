# Home.Windows.ViewControl.Rotate()

Home.Windows.ViewControl.Rotate()

Description​

Rotate the entire models around each axis by the entered angle.

Syntax​

Home.Windows.ViewControl.Rotate(...)

Macro:

Ribbon: Home » Windows » ViewControl » Rotate

Inputs​

dlAngle​

A List of Double specifying the angle (degree) in each axis (X, Y, Z) to rotate the entire model.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.Rotate(dlAngle=[0, 20, 20])
