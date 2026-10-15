# Home.Windows.ViewControl.ZoomIn()

Home.Windows.ViewControl.ZoomIn()

Description​

Zoom in the view by the zoom ratio.

Syntax​

Home.Windows.ViewControl.ZoomIn(...)

Macro:

Ribbon: Home » Windows » ViewControl » ZoomIn

Inputs​

dZoom​

A Double specifying the zoom in ratio. The zoom ratio should be in range (0:1).

If the inputted larger than 1, then the  zoom ratio = 1/(inputted value).

The default value is 0.83333333.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.ZoomIn(dZoom=0.3)
