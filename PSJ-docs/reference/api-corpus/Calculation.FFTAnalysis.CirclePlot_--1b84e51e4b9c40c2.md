# Calculation.FFTAnalysis.CirclePlot()

Calculation.FFTAnalysis.CirclePlot()

Description​

Display the deformation plot graph.

Syntax​

Calculation.FFTAnalysis.CirclePlot(...)

Macro: CmdFFTCirclePlot

Ribbon: Calculation » FFTAnalysis » CirclePlot

Inputs​

iFFTCondition​

An Integer specifying the ID of the specified FFT condition.

The default value is 1.

bOACircle​

A Boolean specifying whether to use the OA Circle option.

The default value is False.

strOACircle​

A String specifying the number of layers to display the deformation plot graph of the OA results.

The default value is "2".

bDefineOA​

A Boolean specifying whether to use the Define OA Circle option.

The default value is False.

strDefineOA​

A String specifying the mode to be used for the OA curve.

The default value is "2-4".

strDefineMode​

A String specifying the mode in which deformation plots are displayed graphically.

The default value is "2".

strModeLayer​

A String specifying the layer to be displayed graphically in each mode.

The default value is "2".

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Please set path to your result sample file.
filePath="C:/Temp/Sample..."

# Please set path to your exported CSV file.
fileExport="C:/Temp/ExportFile.csv"

# Prepare result model
Home.ImportResults.ADVC(filePath, iImportType=1, dFaceAngle=60, dEdgeAngle=60)

# Set FFT condition
Calculation.FFTAnalysis.SetCondition(crlTargets=[Elem(...)], crl2DElems=[Elem(...)], dAngle=0.349066, 
                                    crTopNode=RONode(7663), crBottomNode=RONode(9606), 
                                    dlCenterPoint=[332.71, -191.12, 190.81], dBoreRadius=50.0001, 
                                    dBoreHeight=170.13, dlAxisDefined=[0.0, 0.71, -0.71], 
                                    iDepthDirection=-1, iNumOfLayerPoint=20, dlLayers=[0.0, 56.71, 113.42, 170.13], 
                                    dlAxisX=[0.14, 0.7, 0.7])

# Show translational displacement results
Post.ShowContour(crPostJob=TSVPostJob(1), lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                    iAnalysisType=1, strResultName="Displacement", strResultCompName="Translational", 
                    iResultPos=1), postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), postResultKey=PostResultKey(iAnalysisType=1, 
                    strResultName="Displacement", strResultCompName="Translational"))
Post.EnableMiddleNodes()

# Circle plot
circlePlot = Calculation.FFTAnalysis.CirclePlot(bOACircle=True, bDefineOA=True)
JPT.Debugger(circlePlot)
