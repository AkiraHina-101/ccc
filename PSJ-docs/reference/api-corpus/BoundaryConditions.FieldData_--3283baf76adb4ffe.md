# BoundaryConditions.FieldData()

BoundaryConditions.FieldData()

Description​

Create a field data table that can be used when you set load, the boundary conditions, etc.

Syntax​

BoundaryConditions.FieldData(...)

Macro:

Ribbon: BoundaryConditions » FieldData

Inputs​

strName​

A String specifying the name of the table to be created.

The default value is "".

iType​

An Integer specifying the type of table to be created.

The default value is 0.

ilSheet​

A List of Integer specifying the table data.

The default value is [].

crEdit​

A Cursor specifying an existing Field Data. If this parameter is used, the specified Field Data will be modified. If it is left None, a new Field Data will be created.

The default value is None.

bAbaqusAmp​

A Boolean specifying whether the Abaqus amplitude is enabled or not.

The default value is False (Disabled).

iAmpType​

An Integer specifying the amplitude type.

The default value is 0.

bFrequencyPSDLogX​

A Boolean specifying whether or not enable data interplation of LogX for Frequency-PSD table.

The default value is False.

bFrequencyPSDLogY​

A Boolean specifying whether or not enable data interplation of LogY for Frequency-PSD table.

The default value is False.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

created_lbc = BoundaryConditions.FieldData(strName="XYZ1",
                                           iType=1,
                                           ilSheet=[2,
                                                    4,
                                                    1,
                                                    1,
                                                    1,
                                                    10,
                                                    1,
                                                    2,
                                                    1,
                                                    20])

JPT.Debugger(created_lbc)
