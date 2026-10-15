# Calculation.RotateMapping()

Calculation.RotateMapping()

Description​

Copy (mapping) stress to create continuous stress data in the direction of rotation.

Syntax​

Calculation.RotateMapping(...)

Macro: PostRotateMapping

Ribbon: Calculation » RotateMapping

Inputs​

dAngleInterval​

A Double specifying the rotation angle in degree.

The default value is 7.5.

iRotateAxis​

An Integer specifying the selection of rotation axis.

The default value is 3.

iCoordinate​

An Integer specifying the coordinate reference.

The default value is 0.

iInterpolateType​

An Integer specifying the interpolation type when mapping.

0: Nearest Node Interpolation

1: Element Inside Interpolation

The default value is 1.

dAreaTolerance​

A Double specifying the value of area tolerance.

The default value is 1.

dMeshTolerance​

A Double specifying value of mesh tolerance.

The default value is 0.05.

iRegionType​

An Integer specifying the region type to map the result.

0: By Part

1: By Group

The default value is 0.

crTarget​

A Cursor specifying the target to map the result. The target can be part if RegionType = By Part, or solid element if RegionType = By Group.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Please set path to your sample universal file and the exported file.
filePath="C:/Temp/Sample.unv"
exportPath = "C:/Temp/Unv_Export.unv"

# Import result file
Home.ImportResults.Universal(filePath)

# Rotate mapping
Calculation.RotateMapping(dAngleInterval=90.0, iRotateAxis=1, crTarget=Part(1))
# Export Unv file
Calculation.RotateMappingExportUnv(strPath=exportPath, 
                                    veclResultSet=[[105, 1001, 0], [105, 1001, 1], [105, 1001, 2], [105, 1001, 3]], 
                                    ilComponentUnv=[0, 2, 5, 1, 4, 3])
