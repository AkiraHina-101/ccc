# Home.Windows.ViewControl.PanRight()

Home.Windows.ViewControl.PanRight()

Description​

Move the view to the right by the entered amount of movement.

Syntax​

Home.Windows.ViewControl.PanRight(...)

Macro:

Ribbon: Home » Windows » ViewControl » PanRight

Inputs​

dDistance​

A Double specifying the relative movement amounts on the screen that the view will move to the right.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanRight(dDistance=50)
