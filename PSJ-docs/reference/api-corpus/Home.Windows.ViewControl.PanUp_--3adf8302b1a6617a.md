# Home.Windows.ViewControl.PanUp()

Home.Windows.ViewControl.PanUp()

Description​

Move the view up by the entered amount of movement.

Syntax​

Home.Windows.ViewControl.PanUp(...)

Macro:

Ribbon: Home » Windows » ViewControl » PanUp

Inputs​

dDistance​

A Double specifying the relative movement amounts on the screen that the view will move up.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanUp(dDistance=50)
