# HexModeling.Linear()

HexModeling.Linear()

Description​

Linear hex mesh creation

Syntax​

HexModeling.Linear(crlFaces=[], dLength=10, iLayer=10, vecSweepDirection=[], bInterfaceElemFlag=False, iLinearMethod=0, bDeleteOriginalParts=False, bDeleteTargetParts=False, iMethodBias=0, dFactor=2.0, iProgression=0)

Ribbon: HexModeling » Linear

Inputs​

crlFaces​

A List of Cursor specifying the face.

The default value is [].

dLength​

A Double specifying the length.

The default value is 10.

iLayer​

An Integer specifying the layer.

The default value is 10.

vecSweepDirection​

A Vector specifying the sweep direction.

The default value is [].

bInterfaceElemFlag​

A Boolean specifying the interface element flag.

The default value is False.

iLinearMethod​

An Integer specifying the linear method.

The default value is 0.

bDeleteOriginalParts​

A Boolean specifying the delete original parts.

The default value is False.

bDeleteTargetParts​

A Boolean specifying the delete target parts.

The default value is False.

iMethodBias​

An Integer specifying the method bias.

The default value is 0.

dFactor​

A Double specifying the factor.

The default value is 2.0.

iProgression​

An Integer specifying the progression.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

HexModeling.Linear(crlFaces=[], dLength=10, iLayer=10, vecSweepDirection=[], bInterfaceElemFlag=False, iLinearMethod=0, bDeleteOriginalParts=False, bDeleteTargetParts=False, iMethodBias=0, dFactor=2.0, iProgression=0)
