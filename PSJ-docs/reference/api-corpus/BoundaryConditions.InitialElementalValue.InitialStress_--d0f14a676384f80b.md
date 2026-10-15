# BoundaryConditions.InitialElementalValue.InitialStress()

BoundaryConditions.InitialElementalValue.InitialStress()

Description​

Create mapping stress.

Syntax​

BoundaryConditions.InitialElementalValue.InitialStress(...)

Ribbon: BoundaryConditions » InitialElementalValue » InitialStress

Inputs​

strName​

A String specifying the name.

The default value is "InitialStress1".

iDimension​

An Integer specifying the dimension.

The default value is 2.

iElemCs​

An Integer specifying the element cs.

The default value is 0.

dSXX​

A Double specifying the s x x.

The default value is DFLT_DBL.

dSYY​

A Double specifying the s y y.

The default value is DFLT_DBL.

dSXY​

A Double specifying the s x y.

The default value is DFLT_DBL.

crTable​

A Cursor specifying the table.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.InitialElementalValue.InitialStress(strName="InitialStress1", iDimension=2, iElemCs=0, dSXX=DFLT_DBL, dSYY=DFLT_DBL, dSXY=DFLT_DBL, crTable=None, crlTargets=[], crEdit=None)
