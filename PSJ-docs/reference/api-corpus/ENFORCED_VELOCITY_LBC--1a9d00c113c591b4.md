# ENFORCED_VELOCITY_LBC

ENFORCED_VELOCITY_LBC

Description​

A data type uses to control parameters of Enforced Velocity LBC

Attributes​

iDwDof​

An Integer specifying the degree of freedom (dof). This value is calculated by using OR operator between the following options:

For example, if x, y, z translation must be constrained, then the iDwDof = 1 |2 |4 = 7.

The default value is 0.

dVelocityTX​

A Double specifying the enforced velocity value for translation X direction.

The default value is DFLT_DBL.

dVelocityTY​

A Double specifying the enforced velocity value for translation Y direction.

The default value is DFLT_DBL.

dVelocityTZ​

A Double specifying the enforced velocity value for translation Z direction.

The default value is DFLT_DBL.

dVelocityRX​

A Double specifying the enforced velocity value for rotation X direction.

The default value is DFLT_DBL.

dVelocityRY​

A Double specifying the enforced velocity value for rotation Y direction.

The default value is DFLT_DBL.

dVelocityRZ​

A Double specifying the enforced velocity value for rotation Z direction.

The default value is DFLT_DBL.

crCurCoord​

A Cursor specifying the load direction of the reference coordinate system of the load.

The default value is None.

iEndArrowDir​

An Integer specifying the drawing position of marker display.
0: Start at Node. The marker is displayed starting from a node.

1: End at Node. The marker is displayed ending at a node.

The default value is 0.

crTable​

A Cursor specifying the table which refers to frequency and time history.

The default value is None.

crNodeSet​

A Cursor specifying the node cursor.

The default value is None.

dPhase​

A Double specifying the phase of the load.

The default value is DFLT_DBL.

dDelay​

A Double specifying the delay value of the load.

The default value is DFLT_DBL.

crPhaseTable​

A Cursor specifying the phase table of load.

The default value is None.

iVelocityUnit​

An Integer specifying the translation velocity input unit.

The default value is 0.

iRotUnit​

An Integer specifying the rotation velocity input unit.

The default value is 0.

bExport​

A Boolean enable/disable the multi-excitation load export.

The default value is False.

crExportDataTX​

A Cursor specifying the table of Plural point input for X translational direction.

The default value is None.

crExportDataTY​

A Cursor specifying the table of Plural point input for Y translational direction.

The default value is None.

crExportDataTZ​

A Cursor specifying the table of Plural point input for Z translational direction.

The default value is None.

crExportDataRX​

A Cursor specifying the table of Plural point input for X rotational direction.

The default value is None.

crExportDataRY​

A Cursor specifying the table of Plural point input for Y rotational direction.

The default value is None.

crExportDataRZ​

A Cursor specifying the table of Plural point input for Z rotational direction.

The default value is None.
