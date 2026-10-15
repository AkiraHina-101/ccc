# Analysis.Abaqus()

Analysis.Abaqus()

Description​

Create an Abaqus job.

Syntax​

Analysis.Abaqus(...)

Macro: CreateAbaqusJob

Ribbon: Analysis » Abaqus

Inputs​

strName​

A String specifying the Abaqus job name.

This is a required input.

abaqusAnalysis​

A JOB_ABAQUS_DATA specifying the Abaqus Analysis input parameter.

The default value is JOB_ABAQUS_DATA.

crlStepSequence​

A List of Cursor specifying the list of Abaqus step defined in sequence.

The default value is [].

crEdit​

A Cursor specifying an existing Abaqus job.

If this parameter is used, the specified job will be modified.

If it is left None, a new job will be created.

The default value is None.

Return Code​

A Cursor specifying the created jobs.

Sample Code​

Geometry.Part.Cube(iPartColor=5619133)
Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=12, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

Properties.Material.Add("Concrete", 
                        [Density([(DENSITY, 2.3e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 30000.0), 
                                 (POISSONS_RATIO, 0.18)])])

Properties.Solid(crlTargets=[Part(1)], 
                 strName="Solid Property 1", 
                 iPropertyColor=12275404, 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 iFLG=-1)

created_job = Analysis.Abaqus("Job_1", 
                              abaqusAnalysis=JOB_ABAQUS_DATA(iUnit=1))

JPT.Debugger(created_job)
