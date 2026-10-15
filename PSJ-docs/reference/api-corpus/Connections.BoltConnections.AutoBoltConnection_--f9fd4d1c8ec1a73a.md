# Connections.BoltConnections.AutoBoltConnection()

Connections.BoltConnections.AutoBoltConnection()

Description​

Create bolt connection for all the detected bolt holes at one time

Syntax​

Connections.BoltConnections.AutoBoltConnection(...)

Macro: AutoBoltConnection

Ribbon: Connections » BoltConnections » AutoBoltConnection

Inputs​

strName​

A String specifying the bolt connection name.

This is a required input.

listBoltHoles​

A list of BOLT_HOLE_FACE specifying data of bolt hole face.

This is a required input.

crlMatingFaces​

A List of Cursor specifying mating faces target.

This is a required input.

boltTypeA​

A BOLT_TYPE_AB specifying an instance of BOLT_TYPE_AB class specifying the information of bolt type A and B

The default value is BOLT_TYPE_AB().

boltTypeB​

A BOLT_TYPE_AB specifying an instance of BOLT_TYPE_AB class specifying the information of bolt type A and B

The default value is BOLT_TYPE_AB().

boltTypeC​

A Boolean specifying an instance of BOLT_TYPE_C class specifying the information of bolt type C

The default value is BOLT_TYPE_C().

boltTypeD​

A Boolean specifying an instance of BOLT_TYPE_D class specifying the information of bolt type D

The default value is BOLT_TYPE_D().

bLocalSettingFace​

A Boolean specifying the local setting face option

The default value is False.

dLocalSettingSize​

A Double specifying the local setting size.

The default value is 0.003.

Return Code​

A Boolean specifying the function succeeded or not.

True: Succeeded

False: Failed

Sample Code​

<Type here>
