# Properties.RigidBody()

Properties.RigidBody()

Description​

Assign a rigid property to a body.

Syntax​

Properties.RigidBody(...)

Ribbon: Properties » Rigid Body

Inputs​

strName​

A String specifying name of the new property.

The default value is "RigidBody1".

iPID​

An Integer specifying the property identification number.
This number must be unique with respect to all other property's identification numbers.

The default value is 1.

iRefNodeId​

An Integer specifying the reference node ID.

The default value is 0.

crlTargets​

A List of Cursor specifying the entities to be applied the rigid body property.
The target can be Face entities or Element entities.

The crlTargets and crRigidBodyProperty arguments are mutually exclusive (one of them must be specified).

The default value is [].

crRigidBodyProperty​

A Cursor specifying the existing Rigid Body Property.
If this argument is not None, the specified Rigid Body Property will be modified.

Otherwise, a new Rigid Body Property will be created.

The crlTargets and crRigidBodyProperty arguments are mutually exclusive (one of them must be specified).

The default value is None.

Return Code​

A Cursor specifying the newly created or the modified Rigid Body Property.

Sample Code​

Geometry.Part.Cube()
Properties.RigidBody(crlTargets=[Face(26)])
