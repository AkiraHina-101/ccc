# BoundaryConditions.Pressure.SurfaceMapping()

BoundaryConditions.Pressure.SurfaceMapping()

Description​

Create mapping pressure.

Syntax​

BoundaryConditions.Pressure.SurfaceMapping(...)

Ribbon: BoundaryConditions » Pressure » SurfaceMapping

Inputs​

strName​

A String specifying the name.

The default value is "MappingPressure".

crlTargets​

A List of Cursor specifying the target.

The default value is [].

iMAPPos​

An Integer specifying the m a p position.

The default value is 0.

iViewCp​

An Integer specifying the view component.

The default value is 0.

iCp​

An Integer specifying the component.

The default value is 1.

iSrcType​

An Integer specifying the source type.

The default value is 0.

iMappedCpIndexArr​

An Integer specifying the mapped component index arr.

The default value is 0.

dScaleFactor​

A Double specifying the scale factor.

The default value is 1.

posOffset​

A Position specifying the offset.

The default value is [0,0,0].

posRotate​

A Position specifying the rotate.

The default value is [0,0,0].

dCorScale​

A Double specifying the cor scale.

The default value is 1.

dSearchRange​

A Double specifying the search range.

The default value is 0.

iUnit​

An Integer specifying the unit.

The default value is 0.

strPath​

A String specifying the path.

The default value is "".

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Pressure.SurfaceMapping(strName="MappingPressure", crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr=0, dScaleFactor=1, posOffset=[0,0,0], posRotate=[0,0,0], dCorScale=1, dSearchRange=0, iUnit=0, strPath="", crEdit=None)
