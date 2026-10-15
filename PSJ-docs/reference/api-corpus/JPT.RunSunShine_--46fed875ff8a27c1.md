# JPT.RunSunShine()

JPT.RunSunShine()

Description​

Run SunShine to solve an analysis problem.

Syntax​

JPT.RunSunShine(...)

Inputs​

InputFile​

A String specifying the path of solver input file will be solved.

This is a required input.

OutputFolder​

A String specifying the path of folder to store the result files.

The default value is "" (the folder where the input file is located).

Memory​

A Double specifying the size of memory in GB to be used in execution.

The default value is 2.0 (GB).

Threads​

A Integer specifying the number of threads to be used in execution.

The default value is 1.

KeepTemp​

A Boolean specifying whether to keep the temporary files after termination of execution.

The default value is False.

WriteDatabase​

A Boolean specifying whether to keep the temporary files after termination of execution.

The default value is False.

ShowProgress​

A Boolean specifying whether to keep the temporary files after termination of execution.

The default value is False.

Return Code​

Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare model
Geometry.Part.Cube(dlLength=[0.01, 0.01, 0.1], iPartColor=7463537)
Meshing.SetMeshAttribute(crlParts=[Part(1)], 
                        surfaceMesh=SURFACE_MESH(dMaxElemSize=0.4, 
                          dGeomAngle=0.7853981634, 
                          iPerformanceMode=1, 
                          dAutoMergeTinyFacesAngle=0.5235987756, 
                          bGeomApprox=True, 
                          iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                      surfaceMesh=SURFACE_MESH(dMaxElemSize=0.4, 
                        dGeomAngle=0.7853981634, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0), 
                      iThreadNum=16)
Meshing.SolidMeshing(crlParts=[Part(1)], 
                    dGradingFactor=1.05, 
                    dStretchLimit=0.1, 
                    iSpeedVsQual=1, 
                    iRegion=1, 
                    bSafeMode=False, 
                    iParallel=16, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)
BoundaryConditions.FixedConstraint(strName="Constraint_1", crlTargets=[Face(25)])
BoundaryConditions.Force.General(strName="Force_1", 
                                forceLBC=FORCE_LBC(vecForce=[DFLT_DBL, DFLT_DBL, 100.0]), 
                                  crlTargets=[Face(26)])
Properties.Material.Add(strMaterialName="Structural_Steel",
                       dictMaterialProperty={
                        'Density': {'density': {'DENSITY': [7850.000000000001]}}, 
                        'Elastic': {'elastic': {'YOUNGS_MODULUS': [200000000000.0], 
                        'POISSONS_RATIO': [0.3]}}, 
                        'Expansion': {'expansion': {'ALPHA': [1.2e-05]}}, 
                        'Conductivity': {'conductivity': {'CONDUCTIVITY': [59.0]}}, 
                        'SpecificHeat': {'specificHeat': {'SPECIFIC_HEAT': [461.0]}}}, 
                      iMaterialID=5, 
                      iMaterialColor=10264731)
Properties.Solid(crlTargets=[Part(1)], 
                strName="SolidProperty_1",
                iPropertyColor=959547, 
                crMaterial=Material(5), 
                iCordM=-2, 
                dDynaRemeshVal1=DFLT_DBL, 
                dDynaRemeshVal2=DFLT_DBL, 
                dDispHG=DFLT_DBL, 
                iFLG=-1)
Analysis.TSSS.LinearStatic(
                          nastranAnalysis=NASTRAN_ANALYSIS(
                            iSolverType=6, 
                            iGridFormatType=1, 
                            dEpsilon=DFLT_DBL, 
                            iMaxNumOfIter=DFLT_INT, 
                            iNumberOfThreads=1, 
                            iMemory=2, 
                            iNcpu=DFLT_INT, 
                            iSolNo=101, 
                            nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStrain=0)), 
                          strPath="C:/temp/SOL_101.bdf")
# Run SunShine to solve the problem
progress = JPT.RunSunShine(r"C:\\temp\\SOL_101.bdf",
                          "",
                          2,
                          1,
                          False,
                          True,
                          False)
if progress == True:
  print("SunShine succeeded, can start a new document and import the result...")
else:
  print("SunShine failed")
