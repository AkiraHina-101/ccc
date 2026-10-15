# SZOnepushReliability.Assembly.CreateWeld()

SZOnepushReliability.Assembly.CreateWeld()

Description​

Create welding

Syntax​

SZOnepushReliability.Assembly.CreateWeld(crlWelds, dMeshSize, iRrate, dFilletRadius)

Ribbon: SZOnepushReliability » Assembly » CreateWeld

Inputs​

crlWelds​

A List of Cursor specifying the welds.

This is a required input.

dMeshSize​

A Double specifying the mesh size.

This is a required input.

iRrate​

An Integer specifying the rrate.

This is a required input.

dFilletRadius​

A Double specifying the fillet radius.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

SZOnepushReliability.Assembly.CreateWeld(crlWelds, dMeshSize, iRrate, dFilletRadius)
