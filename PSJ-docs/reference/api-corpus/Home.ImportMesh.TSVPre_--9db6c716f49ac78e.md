# Home.ImportMesh.TSVPre()

Home.ImportMesh.TSVPre()

Description​

Convert a old TSV-Pre/Designer file into one or more jtdb files.

Syntax​

Home.ImportMesh.TSVPre(...)

Macro: ImportVDB

Ribbon: Home » ImportMesh » TSVPre

Inputs​

strImportPath​

A String specifying the import path.

The default value is "".

strExportPath​

A String specifying the export path.

The default value is "".

ilModelIndex​

A List of Integer specifying the model index.

The default value is None.

iMerge​

An Integer specifying the merge.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Home.ImportMesh.TSVPre(strImportPath="", strExportPath="", ilModelIndex=None, iMerge=None)
