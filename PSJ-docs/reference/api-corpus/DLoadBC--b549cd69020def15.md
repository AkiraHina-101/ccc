# DLoadBC

DLoadBC

Description​

This is an instance of a DLoadBC class, represents LBC item inside Jupiter.

Properties​

 | Attribute | Description

 | isValid | Determine the validation of the LBC.
 The return value is True if the LBC is valid, False if not (invalid).

 | type | Type name of the LBC.
The return value is Type (string).

 | typeID | Type ID of the LBC.
The return value is an Int notation of DItem Types (int).

 | tableID | Table ID of the LBC.
The return value is an Int notation of DTable Types (int).

 | id | External ID of the LBC.
It can be duplicated, but not recommended.
ID can be changed using the renumbering function.
The return value is ID (int)

 | targets | Hold the contents of the LBC.
The return value is a list of DItem.

 | masters | Master face/edge/node of the LBC.
The return value is a list of DItem.

 | slaves | Slave face/edge/node of the LBC.
The return value is a list of DItem.

 | parent | A sub-assembly that is the parent of LBC in the assembly tree.
The return value is a list of DItem.

 | isHidden | Determine display state of the LBC.
The return value is True if the LBC is hidden, False if the LBC is displayed.

 | name | Name of the LBC.

 | lbcAnalysisType | Type of the analysis solver of LBC.
The return value is lbcAnalysisType (string).

 | lbcCoord | Reference Coordinate System of LBC. 
The return value is DCoord (object).

 | color* 1 | LBC color information.
This value can be adjusted.
The return value is a RGB color.

Attribute​

lbcAnalysisType​

 | Name | Description

 | FOR_BOTH | Both Structure and Thermal Analyses.

 | FOR_STRUCT | Structure Analysis.

 | FOR_THERMAL | Thermal Analysis.

Notice​

Footnotes​

An asterisk symbol * in attribute name means that attribute can be changed/assigned from the current to the new value. ↩
