# Post.ResultSettings.FFT3DDisplay()

Post.ResultSettings.FFT3DDisplay()

Description​

Set up the result settings for displaying the FFT3D.

Syntax​

Post.ResultSettings.FFT3DDisplay(...)

Macro: CmdPostFFT3DDisplaySettings

Ribbon: Post » ResultSettings » FFT3DDisplay

Inputs​

postDataVizOptBDPP​

A POST_DATA_VIZ_OPT_BDPP specifying all settings of the FFT3D display.

The default value is POST_DATA_VIZ_OPT_BDPP.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.FFT3DDisplay(postDataVizOptBDPP=PostDataVizOptBDPP(
                                dLayerPointSize=2.0, 
                                dLineWidth=2.0, 
                                dPointSize=2.0, 
                                dDotDistance=0.05))
