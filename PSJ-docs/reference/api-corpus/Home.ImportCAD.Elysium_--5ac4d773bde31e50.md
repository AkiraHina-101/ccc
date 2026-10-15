# Home.ImportCAD.Elysium()

Home.ImportCAD.Elysium()

Description​

Import a CAD file by using Elysium interface to the Jupiter Database.

Syntax​

Home.ImportCAD.Elysium(...)

Ribbon: Home » Import CAD » Elysium

Inputs​

strlPaths​

A List of String specifying a list of the CAD files which will be used for importing.

This is a required input.

dChordHeightTolerance​

A Double specifying the maximum distance from the actual surface to the facet face. The smaller the Chord Height, the smaller the facets the more accurate the curvature of the surface is represented.

The default value is 1.0.

dAngleToleranceDegree​

A Double specifying the angle tolerance which influences the tessellation of curves with relatively small radii in comparison to the overall size of the CAD model.

The default value is 5.0.

dPointCoincidentTolerance​

A Double specifying the tolerance which influences the detection of coincident (connected) parts.

The default value is 0.01.

iConvertIsolatedCurve​

An Integer specifying the convert isolated curve option.
0: Off

1: On

The default value is 0.

iDekCleanselfintersectingloop​

An Integer specifying the option that detects and eliminates loops that are self-intersecting at vertex locations.
0: Disable cleaning.

2: Detect and eliminate self-intersecting loops at vertex locations.

3: Detect and eliminate self-intersecting loops.

The default value is 2.

iDekVolumetopart​

An Integer specifying the number of volumes to part.

The default value is 4.

iIgesFixedCurvePreference​

An Integer specifying the calculation method of the trim curve. Using for IGES CAD type.
0: Value in IGES file

1: 2D Curve

2: 3D Curve

The default value is 0.

iIgesAutostitch​

An Integer specifying the option that control (on/off) filling the gaps of the IGES file without a topology. Using for IGES CAD type.
0: Off

1: On

The default value is 1.

dIgesStitchtolerance​

A Double specifying the tolerance for filling the gaps. Using for IGES CAD type.

The default value is 0.1.

iCatiaConvertNotShownElement​

An Integer specifying the option that controls the conversion of hidden elements. Using for CATIA CAD type.
0: Off

1: On

The default value is 0.

iCatiaConvertNotShownInstance​

An Integer specifying the option that controls the conversion of hidden instances. Using for CATIA CAD type.
0: Off

1: On

The default value is 0.

iCatiaConvertaxis​

An Integer specifying the option that controls the conversion of coordinate systems. Using for CATIA CAD type.
0: Off

1: On

The default value is 1.

iStepCreateseam​

An Integer specifying the option that creates seam to topologies without an outer loop. Using for STEP CAD type.
0: No Seam

1: Dependent on CAD

2: Add Seam

The default value is 1.

dStepPointtolerance​

A Double specifying the tolerance to check the same point. Using for STEP CAD type.

The default value is 0.0.

iAcisHealacisbeforeversion​

An Integer specifying the option using healing function. Using for ACIS CAD type.
0: Off

1: On

The default value is 0.

iJtConvertgeometrytype​

An Integer specifying the target element type for conversion. Using for JT CAD type.
0: Off

1: Brep

The default value is 1.

bFaceColor​

A Boolean specifying the color information option.

The default value is False.

iJtConvertgeneralpart​

An Integer specifying the option that control the conversion of the General Part types. Using for JT CAD type.
0: Off

1: On

The default value is 1.

iJtConvertaxis​

An Integer specifying the option that control the conversion of coordinate systems. Using for JT CAD type.
0: Off

1: On

The default value is 1.

iJtConvertcenterline​

An Integer specifying the option that control the conversion of the center line. Using for JT CAD type.
0: Off

1: On

The default value is 0.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The CAD file (IGES file, STEP file, etc.) is imported successfully.

False: The CAD file (IGES file, STEP file, etc.) cannot be imported.

Sample Code​

imported_status = Home.ImportCAD.Elysium(strlPaths=[JPT.GetProgramPath() +
                                                    "SampleData/CAD_Model/IGES/A400MA.igs"],
                                         dAngleToleranceDegree=3.0,
                                         dPointCoincidentTolerance=1e-05,
                                         dIgesStitchtolerance=0.01)
JPT.Debugger(imported_status)
