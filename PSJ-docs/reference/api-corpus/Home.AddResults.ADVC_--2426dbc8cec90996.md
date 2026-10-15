# Home.AddResults.ADVC()

Home.AddResults.ADVC()

Description​

Add ADVC results to the current Jupiter Database.

Syntax​

Home.AddResults.ADVC(...)

Macro: AddResultsADVC

Ribbon: Home » AddResults » ADVC

Inputs​

strlPaths​

A List of String specifying a list of the ADVC files which will be used for importing.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

bADVCProcessNameRule​

A Boolean specifying whether or not ADVC process IDs defined on the ADVC side are displayed.

The default value is False.

bDisplayNAResult​

A Boolean specifying whether or not the "NA Result Display" option in ADVC is enabled. When set to true, it shows "Data: ---" for missing data and "No data available" in watch data notes, applicable only to nodal output results. When set to false, standard data display rules apply.

The default value is False.

strPathSelectResultFile​

A String specifying

The default value is "".

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The ADVC result is added to the document successfully.

False: The ADVC result is not added to the document.

Sample Code​

#Please set path to your sample ADVC folder.
meshfile='C:/Sample/mesh.adx'
folderpath="C:/Temp/SampleADVC"

Home.ImportResults.ImportMesh.ADVC(folderpath)
Home.AddResults.ADVC(strlPaths=[folderpath], bMergeTree=False, bADVCProcessNameRule=False, bDisplayNAResult=False)
