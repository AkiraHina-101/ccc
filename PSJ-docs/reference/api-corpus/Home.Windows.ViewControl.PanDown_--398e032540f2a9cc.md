# Home.Windows.ViewControl.PanDown()

Home.Windows.ViewControl.PanDown()

Description​

Move the view down by the entered amount of movement.

Syntax​

Home.Windows.ViewControl.PanDown(...)

Macro:

Ribbon: Home » Windows » ViewControl » PanDown

Inputs​

dDistance​

A Double specifying the relative movement amounts on the screen that the view will move down.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanDown(dDistance=50)
