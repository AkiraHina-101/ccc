# Home.Windows.ViewControl.SetCenter()

Home.Windows.ViewControl.SetCenter()

Description​

Set the center of rotation of the model.

Syntax​

Home.Windows.ViewControl.SetCenter(...)

Macro:

Ribbon: Home » Windows » ViewControl » SetCenter

Inputs​

dlCenter​

A List of Double specifying the rotation center coordinate of the model. The unit of the rotation center coordinate  is taken according to the current document unit.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.SetCenter(dlCenter=[0.0, 0.01, 0.0])
