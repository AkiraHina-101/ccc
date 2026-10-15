# Home.ImportResults.WAON()

Home.ImportResults.WAON()

Description​

Import WAON result file to the Jupiter Database.

Syntax​

Home.ImportResults.WAON(...)

Macro: CmdImportTSVWAONPost

Ribbon: Home » ImportResults » WAON

Inputs​

strPath​

A String specifying BEM file (.bdf).

This is a required input.

strFPMFilePath​

A String specifying FPM file (.bdf).

This is a required input.

strResultFolderPath​

A String specifying result folder.

This is a required input.

iImportType​

An Integer specifying import type. For WAON file, it is always set to 1.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

bReadLoadAndConstraint​

-A Boolean specifying whether or not

The default value is False.

bReadConnection​

-A Boolean specifying whether or not

The default value is False.

bCreateResultsAtMidNode​

-A Boolean specifying whether or not

The default value is False.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The WAON result is imported successfully.

False: The WAON result cannot be imported.

Sample Code​

#Please set path to your sample WAON file.
filepath="C:/Temp/"
bem_file = filepath + "BEM.bdf"
fpm_file = filepath + "FPM.bdf"
result = base_FILEPATH + "result/"
Home.ImportResults.WAON(bem_file, 
                        fpm_file, 
                        result, 
                        bReadLoadAndConstraint=True, 
                        bReadConnection=True, 
                        bCreateResultsAtMidNode=True)
