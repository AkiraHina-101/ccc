# Export_Post_Viewer_File()

Export_Post_Viewer_File()

Description​

Export PV file

Syntax​

Export_Post_Viewer_File(int group, string ExportFilePath)

Inputs​

1. int​

Output group

0 : None

1 : Element

2 : Material

3 : Property

2. String​

Path of file to export

Return Code​

"SUCCEED": The function can be executed

"FAILED": The function cannot be executed

Sample Code​

Export_Post_Viewer_File(0, "C:/temp/pvfile.tsv")
