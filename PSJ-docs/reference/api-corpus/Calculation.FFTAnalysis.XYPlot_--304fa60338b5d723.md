# Calculation.FFTAnalysis.XYPlot()

Calculation.FFTAnalysis.XYPlot()

Description​

Display the circularity XY plot graph and export it to a specified file.

Syntax​

Calculation.FFTAnalysis.XYPlot(...)

Macro: CmdFFTXYPlot

Ribbon: Calculation » FFTAnalysis » XYPlot

Inputs​

iFFTCondition​

An Integer specifying the ID of the specified FFT condition.

The default value is 1.

bDefineOA​

A Boolean specifying whether to display the OA result.

The default value is False.

strDefineOA​

A String specifying the mode to display the graph of OA result.

The default value is "2-4".

strDefineMode​

A String specifying the mode to display the circularity XY plot graph.

The default value is "2, 3, 4".

b3DPlot​

A Boolean specifying whether to display the circularity plot graph in 3D space.

The default value is False.

bExportData​

A Boolean specifying whether to save the FFT analysis result to file.

The default value is False.

strPath​

A String specifying the path of CSV file to save the FFT analysis results.

The default value is "".

bOriginalShift​

A Boolean specifying whether to shift the values of all layers when outputting amplitude data (except for the 0th order mode).

The default value is False.

bExportAllPlot​

A Boolean specifying whether to save all resulting roundness XY plots and deformation plots to a CSV file.

The default value is False.

b2DPlot​

A Boolean specifying whether to display the circularity plot graph in 3D space.

The default value is False.

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
                                    dBoreHeight=170.13, dlAxisDefined=[0.0, 0.71, -0.71], iDepthDirection=-1, 
                                    iNumOfLayerPoint=20, dlLayers=[0.0, 56.71, 113.42, 170.13], 
                                    dlAxisX=[0.14, 0.7, 0.7])

# Show translational displacement results
Post.ShowContour(crPostJob=TSVPostJob(1), lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                    iAnalysisType=1, strResultName="Displacement", strResultCompName="Translational", 
                    iResultPos=1), postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), postResultKey=PostResultKey(iAnalysisType=1, 
                    strResultName="Displacement", strResultCompName="Translational"))
Post.EnableMiddleNodes()

# XY plot and export result to file 
XYPlot = Calculation.FFTAnalysis.XYPlot(bDefineOA=True, strPath=fileExport, bExportData=True, 
                                        bExportAllPlot=True, b2DPlot=True)
JPT.Debugger(XYPlot)
