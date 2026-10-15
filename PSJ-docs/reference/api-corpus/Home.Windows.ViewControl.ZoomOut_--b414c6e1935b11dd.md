# Home.Windows.ViewControl.ZoomOut()

Home.Windows.ViewControl.ZoomOut()

Description​

Zoom out the view by the zoom ratio.

Syntax​

Home.Windows.ViewControl.ZoomOut(...)

Macro:

Ribbon: Home » Windows » ViewControl » ZoomOut

Inputs​

dZoom​

A Double specifying the zoom out ratio. The zoom ratio should be larger than 1.

If the inputted value is in range (0:1), then the  zoom ratio = 1/(inputted value).

The default value is 1.2.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.ZoomOut(dZoom=1.15)
