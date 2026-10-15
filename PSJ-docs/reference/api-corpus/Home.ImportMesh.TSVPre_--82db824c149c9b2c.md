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

import os

VDB_file_path = os.path.join(
    JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH), 
    "SampleData/PSJ/PSJ-Utility/VDBSample/sample.vdb")

export_file_path = os.environ["Temp"] + "/TechnoStar/"
Home.ImportMesh.TSVPre(strImportPath=VDB_file_path, strExportPath=export_file_path)
