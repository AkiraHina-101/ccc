# Calculation.SurfaceDistance.DistanceCalculate()

Calculation.SurfaceDistance.DistanceCalculate()

Description​

Display the distance between parts as a contour.

Syntax​

Calculation.SurfaceDistance.DistanceCalculate(...)

Macro: ACCombineSurfaceDistanceDistanceCalculatedAnimation

Ribbon: Calculation » SurfaceDistance » DistanceCalculate

Inputs​

strResultTitle​

A String specifying the name of the result to be created.

The default value is 'Untitled'.

iCompareRegionType​

An Integer specifying the region type to make the comparison.

0: by Parts

1: by Groups

The default value is 0.

dEdgeTolerance​

A Double specifying the tolerance between edges.

The default value is 0.0.

iMeshOfTwoSurfaces​

An Integer specifying the position of mesh nodes.

0: Same

1: Different

The default value is 0.

iAxisDirection​

An Integer specifying the axis direction.

0: X

1: Y

2: Z

3: Arbitrary direction

The default value is 0.

dlDirection​

A List of Double specifying the direction vector to be calculated.

The default value is [1.0,0.0,0.0].

crReferenceNode​

A Cursor specifying the reference node.

The default value is None.

crFirstTarget​

A Cursor specifying the first target. The target can be Part or Group Element depend on the selection of iCompareRegionType.

The default value is None.

crSecondTarget​

A Cursor specifying the second target. The target can be Part or Group depend on the selection of iCompareRegionType.

The default value is None.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# Plot the displacement result
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=1, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=1, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))
Post.EnableMiddleNodes()

# Surface distance
Calculation.SurfaceDistance.DistanceCalculate(dEdgeTolerance=2.0, crReferenceNode=Node(124), crFirstTarget=Part(4), 
                                            crSecondTarget=Part(6))
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=1, 
                iAnalysisID=1, 
                iResultSet=1000, 
                strResultName="Untitled", 
                strResultCompName="SurfaceDistance", 
                iResultPos=1), 
                postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])
Post.EnableMiddleNodes()
