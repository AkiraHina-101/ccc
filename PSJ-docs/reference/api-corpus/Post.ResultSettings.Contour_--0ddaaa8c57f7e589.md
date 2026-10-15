# Post.ResultSettings.Contour()

Post.ResultSettings.Contour()

Description​

Set up the result settings for displaying the contour.

Syntax​

Post.ResultSettings.Contour(...)

Macro: CmdPostContourSettings

Ribbon: Post » ResultSettings » Contour

Inputs​

postDataVizOptContour​

A POST_DATA_VIZ_OPT_CONTOUR specifying all settings of the contour display.

The default value is POST_DATA_VIZ_OPT_CONTOUR.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Contour(postDataVizOptContour=PostDataVizOptContour(
                            dMaxUser=1696.404297, 
                            dMinUser=0.0, 
                            dMaxTotal=1696.404297, 
                            dMinTotal=0.0, 
                            iInterpolateMethod=-1))
