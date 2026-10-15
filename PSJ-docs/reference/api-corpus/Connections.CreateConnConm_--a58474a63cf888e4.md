# Connections.CreateConnConm()

Connections.CreateConnConm()

Description​

Syntax​

Connections.CreateConnConm(strName, iEType, iMethod, iCoordSys, iConmId, crMatCoord, dMass, dlX=[0, 0, 0], dlVintertia0=[0, 0, 0], dlVintertia1=[0, 0, 0])

Ribbon: Connections » CreateConnConm

Inputs​

strName​

A String specifying the name.

This is a required input.

iEType​

An Integer specifying the e type.

This is a required input.

iMethod​

An Integer specifying the method.

This is a required input.

iCoordSys​

An Integer specifying the coordinate system.

This is a required input.

iConmId​

An Integer specifying the conm ID.

This is a required input.

crMatCoord​

A Cursor specifying the material coordinate.

This is a required input.

dMass​

A Double specifying the mass.

This is a required input.

dlX​

A Double List specifying the x.

The default value is [0, 0, 0].

dlVintertia0​

A Double List specifying the vintertia0.

The default value is [0, 0, 0].

dlVintertia1​

A Double List specifying the vintertia1.

The default value is [0, 0, 0].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.CreateConnConm(strName, iEType, iMethod, iCoordSys, iConmId, crMatCoord, dMass, dlX=[0, 0, 0], dlVintertia0=[0, 0, 0], dlVintertia1=[0, 0, 0])
