# Calculation.RotateMappingExportUnv()

Calculation.RotateMappingExportUnv()

Description​

Save the mapped result to file (*unv).

Syntax​

Calculation.RotateMappingExportUnv(...)

Macro:

Ribbon: Calculation » RotateMappingExportUnv

Inputs​

strPath​

A String specifying the path of *unv file to be saved.

This is a required input.

veclResultSet​

A List of Vector specifying the attribute of the results to be exported.

This is a required input.

ilComponentUnv​

A List of Integer specifying the universal components.

The default value is [0, 2, 5, 1, 4, 3].

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
