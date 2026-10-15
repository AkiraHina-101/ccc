# Calculation.FFTAnalysis.SetCondition()

Calculation.FFTAnalysis.SetCondition()

Description​

Perform a FFT analysis.

Syntax​

Calculation.FFTAnalysis.SetCondition(...)

Macro: PostFFTConditionOut

Ribbon: Calculation » FFTAnalysis » SetCondition

Inputs​

strName​

A String specifying the name of bore cylinder.

The default value is "BORE_1".

crlTargets​

A List of Cursor specifying the target parts to perform FFT analysis.

The default value is [].

crl2DElems​

A List of Cursor specifying the selected 2D elements.

The default value is [].

dAngle​

A Double specifying the angle to extract the target cylinder surface.

The default value is 20.0.

crTopNode​

A Cursor specifying the node to determine the top end of the bore cylinder surface.

The default value is None.

crBottomNode​

A Cursor specifying the node to determine the bottom end of the bore cylinder surface. To define the bore height also.

The default value is None.

dlCenterPoint​

A List of Double specifying the center coordinate of the bore coordinate system.

The default value is [0.0,0.0,0.0].

dBoreRadius​

A Double specifying the radius of the bore cylinder.

The default value is 0.0.

dBoreHeight​

A Double specifying the height of the bore cylinder.

The default value is 0.0.

iAxisDirection​

An Integer specifying the bore cylinder axial direction in global coordinate system X, Y, Z or arbitrary direction (user defined).

The default value is 3.

dlAxisDefined​

A Double List specifying the defined bore cylinder axial direction.

The default value is [0.0,0.0,0.0].

iDepthDirection​

An Integer specifying the depth direction.

The default value is 0.

iNumOfLayerPoint​

An Integer specifying the number of calculation points in one layer.

The default value is 36.

dlLayers​

A List of Double specifying the number of layers and depth value at each layer.

The default value is [].

iCalculationMethod​

An Integer specifying the calculation method.

0: Best Fit Circle

1: Best Fit Cylinder

The default value is 0.

dlAxisX​

A List of Double specifying X axial direction of the the bore cylinder.

The default value is [0.0,0.0,0.0].

crEdit​

A Cursor specifying an existing FFT condition

If this parameter is used, the specified FFT condition will be modified.

If it is left None, a new FFT condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created FFT condition.

Sample Code​

# Please set path to your sample file.
filePath="C:/Temp/Sample..."

# Prepare result model
Home.ImportResults.ADVC(filePath, iImportType=1, dFaceAngle=60, dEdgeAngle=60)

# Set FFT condition
FFTCondition = Calculation.FFTAnalysis.SetCondition(crlTargets=[Elem(...)], crl2DElems=[Elem(...)], 
                                    crTopNode=RONode(7584), crBottomNode=RONode(9717), 
                                    dlCenterPoint=[207.65, -190.85, 191.06], dBoreRadius=49.8668, 
                                    dBoreHeight=170.105, dlAxisDefined=[0.0, 0.71, -0.71], 
                                    iDepthDirection=-1, iNumOfLayerPoint=20, 
                                    dlLayers=[0.0, 56.7015, 113.403, 170.105], dlAxisX=[0.14, 0.7, 0.7])
JPT.Debugger(FFTCondition)
