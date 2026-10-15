# BOLT_TYPE_C

BOLT_TYPE_C

Description​

A data type uses to control parameters of bolt type C

Attributes​

iTopConType​

An Int specifying Connection.

0 : Create RBE2

1 : Create RBE3

The default value is 0.

iBotConType​

An Int specifying which connection is created if iCenterType is Spring.

0 : Create RBE2

1 : Create RBE3

The default value is 0.

iCenterType​

An Int specifying center connection type.

0 : None

1 : Spring

The default value is 0.

dlStiffness​

A Double Vector specifying stiffness of spring.

The default value is [0.0, 0.0, 0.0].

iUnit​

An Int specifying Input Unit for dlStiffness.

The default value is 0.

dDampCoef​

A Double specifying Damping Coef of spring.

The default value is 0.0.

crCoord​

A Cursor specifying Local Coordinate.

The default value is None.

dlRStiffness​

A Double Vector specifying rotational stiffness of spring.

The default value is [0.0, 0.0, 0.0].

iRUnit​

An Int specifying Input Unit for dlRStiffness.

The default value is 0.

dStressCoef​

A Double specifying Stress Coef of spring.

The default value is 0.

pretension​

A PRETENSION_LOAD specifying Pre Tension Load.
