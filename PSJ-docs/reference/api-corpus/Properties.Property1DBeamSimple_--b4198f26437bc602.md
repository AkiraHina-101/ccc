# Properties.Property1DBeamSimple()

Properties.Property1DBeamSimple()

Description​

Syntax​

Properties.Property1DBeamSimple(strName, iId, crSection=None, crMat=None, vecOrient=[DFLT_DBL,DFLT_DBL,DFLT_DBL], crlTargets=[], crEdit=None)

Macro: Property1DBeamSimple

Ribbon: Properties » Property1DBeamSimple

Inputs​

strName​

A String specifying the name.

This is a required input.

iId​

An Integer specifying the ID.

This is a required input.

crSection​

A Cursor specifying the section.

The default value is None.

crMat​

A Cursor specifying the material.

The default value is None.

vecOrient​

A Vector specifying the orient.

The default value is [DFLT_DBL,DFLT_DBL,DFLT_DBL].

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Properties.Property1DBeamSimple(strName, iId, crSection=None, crMat=None, vecOrient=[DFLT_DBL,DFLT_DBL,DFLT_DBL], crlTargets=[], crEdit=None)
