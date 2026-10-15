# Properties.Gasket()

Properties.Gasket()

Description​

Create property 3d gasket

Syntax​

Properties.Gasket(strName, crMaterial, dThickX, dThickY, dThickZ, crlTargets, crEdit=None, iStData=0, iFLG=0)

Macro: Prop3DGasket

Ribbon: Properties » Gasket

Inputs​

strName​

A String specifying the name.

This is a required input.

crMaterial​

A Cursor specifying the material.

This is a required input.

dThickX​

A Double specifying the thickness x.

This is a required input.

dThickY​

A Double specifying the thickness y.

This is a required input.

dThickZ​

A Double specifying the thickness z.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

crEdit​

A Cursor specifying the edit.

The default value is None.

iStData​

An Integer specifying the st data.

The default value is 0.

iFLG​

An Integer specifying the value FLG.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Properties.Gasket(strName, crMaterial, dThickX, dThickY, dThickZ, crlTargets, crEdit=None, iStData=0, iFLG=0)
