# Meshing.SolidMeshing()

Meshing.SolidMeshing()

Description​

Do 3D meshing (Tetrahedral) for the selected parts.

注記

In case the total number of selected parts = 0, all the existing parts will be used as an input.

Syntax​

Meshing.SolidMeshing(...)

Macro: VolMeshing

Ribbon: Meshing » SolidMeshing

Inputs​

crlParts​

A List of Cursor specifying the target Parts.

This is a required input.

bTet10​

A Boolean to enable (True) or disable (False) the Tet10 creation. If enabled, solid elements Tet4 will be converted to Tet10.

The default value is False.

dGradingFactor​

A Double specifying the grading factor. This parameter affects the change of mesh size from small mesh area to large mesh area.

The default value is 0.

dStretchLimit​

A Double specifying the stretch limit of the result mesh. Created mesh will be adjusted in order to reduce the amount of elements whose stretch is greater than this parameter.

The default value is 0.

iSpeedVsQual​

An Integer specifying the priority between mesh quality and mesh generation speed.
If 0: Speed is prioritized (Fastest).

If 1: Mesh quality is prioritized (Optimized).

The default value is 0.

iSpeedVsMem​

An Integer specifying the priority between memory usage and mesh generation speed.
If 0: Speed is prioritized (Standard).

If 1: The reduction of memory usage is prioritized (Low Memory).

The default value is 0.

iRegion​

An Integer specifying the region where mesh will be generated.
If 0: Create the solid elements in only the main area of part (Main region).

If 1: Create solid element to all the area of the part (All Region).

The default value is 0.

bInternalNodes​

A Boolean to enable (True) or disable (False) the creation of extra nodes. If disabled, nodes on surfaces will be modified. If enabled, only nodes will only be created inside target parts.

The default value is True.

bSafeMode​

A Boolean to enable (True) or disable (False) safe mode. This mode is used to enhance very small element's quality.

The default value is True.

iParallel​

An Integer specifying the number of CPU threads for parallel meshing. This parameter must be smaller than the maximum number of CPU cores.

The default value is 0.

bSurfaceNodes​

A Boolean to enable (True) or disable (False) the cleaning of surface nodes. This parameter is for clean-up step. If enabled, surface nodes will be slightly moved to improve mesh quality.

The default value is True.

bEdgeNodes​

A Boolean to enable (True) or disable (False) the cleaning of edge nodes. This parameter is for clean-up step. If enabled, edge nodes will be slightly moved to improve mesh quality.

The default value is True.

bPreservation​

A Boolean to enable (True) or disable (False) the preservation of nodes. This parameter is for clean-up step. If disabled, nodes can be moved to improve mesh quality.

The default value is True.

bInternalMeshOnly​

A Boolean to enable (True) or disable (False) the correction of internal mesh only. This parameter is for clean-up step.

The default value is True.

bMeshColor​

A Boolean to enable (True) or disable (False) the use of mesh color. If enabled, target parts' color will be changed according to iPartColor.

The default value is False.

iPartColor​

An Integer specifying the color of the result mesh parts.

The default value is 2763429.

Return Code​

A Boolean of True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()

meshing_status = Meshing.SolidMeshing(crlParts=[Part(1)], 
                                      bTet10=True, 
                                      dGradingFactor=1.05, 
                                      dStretchLimit=0.1,
                                      iSpeedVsQual=1, 
                                      iRegion=1, 
                                      bSafeMode=False, 
                                      iParallel=24, 
                                      bSurfaceNodes=False, 
                                      bEdgeNodes=False,
                                      bInternalMeshOnly=False,
                                      iPartColor=65280)

JPT.Debugger(meshing_status)
