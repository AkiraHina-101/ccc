# Geometry.Transform.Translation()

Geometry.Transform.Translation()

Description​

Move the parts along a given vector. The direction and magnitude of the vector are arbitrary or along the specific axis in the Cartesian coordinate system.

Syntax​

Geometry.Transform.Translation(...)

Macro: TranslateBody

Ribbon: Geometry » Transform » Translation

Inputs​

crlParts​

A List of Cursor specifying the parts to be moved.

This is a required input.

dlTranslationVector​

A List of Position specifying the translation vector in crLocalCoordinate coordinate system defining the direction and magnitude of the particular translation.

The default value is [].

crLocalCoordinate​

A Cursor specifying the local coordinate system using for the definition of the dlTranslationVector.

The default value is None.

bCreateNewPart​

A Boolean specifying whether to keep the original parts and create new parts in the moved positions or not.

The default value is False.

bCopyLBC​

A Boolean specifying whether to copy boundary conditions from the existing part to the created parts or not.

The default value is False.

bCopyProperty​

A Boolean specifying whether to copy properties from the existing part to the created parts or not.

The default value is False.

bCopyReference​

A Boolean specifying whether to copy references from the existing part to the created parts or not.

The default value is False.

iCopyCount​

An Integer specifying the number of copies (Creating parts).

The default value is 1.

Return Code​

A List of Cursor specifying the new parts if success, or empty if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=8124407)
translated_part = Geometry.Transform.Translation(crlParts=[Part(1)],
                                                 dlTranslationVector=[[-0.00666, 0.00222, 0]])
JPT.Debugger(translated_part)
