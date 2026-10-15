# ExportContactPairData()

ExportContactPairData()

Description​

Export content of show contact dialog into csv file.

Syntax​

ExportContactPairData(string strCSVFile, int iResultSet, int iTimeStep, string strResultTypeName, string strResultCompName, int iResultPosition, string[] contactPairs)

Inputs​

1. string ​

Path of csv file to export.

2. int ​

Result set.

3. int ​

Time step.

4. string ​

Name of result type.

5. string ​

Name of component.

6. int ​

Data Location.

7. string[]​

Names of export contact pair.

Return Code​

Nothing.

Sample Code​

ExportContactPairData("C:/Users/Admin/Downloads/contact_f2/contact_f2/321123.csv", 1, 0, 0, ContactForceShear, Translational, 1, ["c10", "c7", "c8", "c9"])
