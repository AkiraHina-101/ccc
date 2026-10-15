# Properties.Rod()

Properties.Rod()

Description​

Create 1D rod property

Syntax​

Properties.Rod(strName="", iPID=1, crSection=None, crMat=None, dArea=DFLT_DBL, dTorConst=DFLT_DBL, dTorStressCoeff=DFLT_DBL, dNSM=DFLT_DBL, iLocalLengthUnit=0, iLocalMassUnit=0, crlTargets=[], crEdit=None)

Macro: Property1DRod

Ribbon: Properties » Rod

Inputs​

strName​

A String specifying the name.

The default value is "".

iPID​

An Integer specifying the ID.

The default value is 1.

crSection​

A Cursor specifying the section.

The default value is None.

crMat​

A Cursor specifying the material.

The default value is None.

dArea​

A Double specifying the area.

The default value is DFLT_DBL.

dTorConst​

A Double specifying the tor const.

The default value is DFLT_DBL.

dTorStressCoeff​

A Double specifying the tor stress coeff.

The default value is DFLT_DBL.

dNSM​

A Double specifying the n s m.

The default value is DFLT_DBL.

iLocalLengthUnit​

An Integer specifying the local length unit.

The default value is 0.

iLocalMassUnit​

An Integer specifying the local mass unit.

The default value is 0.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Properties.Rod(strName="", iPID=1, crSection=None, crMat=None, dArea=DFLT_DBL, dTorConst=DFLT_DBL, dTorStressCoeff=DFLT_DBL, dNSM=DFLT_DBL, iLocalLengthUnit=0, iLocalMassUnit=0, crlTargets=[], crEdit=None)
