# NASTRAN_SUBCASE

NASTRAN_SUBCASE

Description​

A data type uses to control parameters of Nastran Subcase

Attributes​

iId​

An Integer specifying the subcase ID.

The default value is 0.

strTitle​

A String specifying the subcase title.

The default value is "".

strArbitraryText​

A String specifying the arbitrary text input.

The default value is "".

iSubcaseIdForLoad​

An Integer specifying the subcase ID for load.

The default value is 0.

iSubcaseIdForDload​

An Integer specifying the subcase ID for dynamic  load.

The default value is 0.

iSubcaseIdForSpc​

An Integer specifying the subcase ID for spc(single point contraint).

The default value is 0.

iSubcaseIdForMpc​

An Integer specifying the subcase ID for mpc(multi point contraint).

The default value is 0.

iSubcaseIdForBcontact​

An Integer specifying the contact table ID for 3D contact.

The default value is 0.

iSubcaseIdForTempInit​

An Integer specifying the subcase ID for temperature initiation.

The default value is 0.

iSubcaseIdForTempLoad​

An Integer specifying the subcase ID for temperature load.

The default value is 0.

iOutputreqDisplacement​

An Integer specifying the displacement output request.
0: NONE.

DFLT_INT: ALL.

The default value is 0.

iOutputreqStress​

An Integer specifying the element stress output request.
0: NONE.

DFLT_INT: ALL.

The default value is 0.

iOutputreqStrain​

An Integer specifying the element strain output request.
0: NONE.

DFLT_INT: ALL.

The default value is 0.

iOutputreqAcceleration​

An Integer specifying the acceleration output request.
0: NONE.

DFLT_INT: ALL.

The default value is 0.

iOutputreqVelocity​

An Integer specifying the velocity output request.
0: NONE.

DFLT_INT: ALL.

The default value is 0.

iNlparm​

An Integer specifying the Nonlinear Static Analysis Parameter Selection.

The default value is 0.
