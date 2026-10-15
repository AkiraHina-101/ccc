# Home.Windows.ViewControl.PanLeft()

Home.Windows.ViewControl.PanLeft()

Description​

Move the view to the left by the entered amount of movement.

Syntax​

Home.Windows.ViewControl.PanLeft(...)

Macro:

Ribbon: Home » Windows » ViewControl » PanLeft

Inputs​

dDistance​

A Double specifying the relative movement amounts on the screen that the view will move to the left.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanLeft(dDistance=50)
