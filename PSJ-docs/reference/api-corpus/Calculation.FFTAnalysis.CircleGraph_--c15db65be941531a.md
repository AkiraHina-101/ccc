# Calculation.FFTAnalysis.CircleGraph()

Calculation.FFTAnalysis.CircleGraph()

Description​

Display the circle graph.

Syntax​

Calculation.FFTAnalysis.CircleGraph(...)

Macro: CmdFFTCircleGraph

Ribbon: Calculation » FFTAnalysis » CircleGraph

Inputs​

iNewLayer​

An Integer specifying the layer of mode to make the circle graph.

The default value is 1.

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

# XY plot
Calculation.FFTAnalysis.XYPlot(bDefineOA=True,strPath=fileExport,bExportData=True,bExportAllPlot=True,b2DPlot=True)

# Circle graph
graph = Calculation.FFTAnalysis.CircleGraph(iNewLayer=2)
JPT.Debugger(graph)
