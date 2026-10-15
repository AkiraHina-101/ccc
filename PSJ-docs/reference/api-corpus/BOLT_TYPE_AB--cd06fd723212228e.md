# BOLT_TYPE_AB

BOLT_TYPE_AB

Description​

A data type uses to control parameters of bolt type A and B

Attributes​

iSeatType​

An Int specifying Connection.

0 : Create RBE2

1 : Create RBE3

The default value is 0.

iSeatCase​

An Int specifying seat setting.

0: By diameter.

1: By Layer.

The default value is 1.

dSeatDiameter​

A Double specifying Seat Diameter.

The default value is 0.02.

iSeatLayer​

An Int specifying Num of Layer.

The default value is 1.

iShaftType​

An Int specifying which shaft type is selected.

0 : Bar

1 : RBE2

The default value is 1.

crBarProp​

A Cursor specifying bar property if shaft type is Bar.

The default value is None.

iBotConType​

An Int specifying which connection is created if iCenterType is Spring.

0 : Create RBE2

1 : Create RBE3

The default value is 0.

iCenterType​

An Int specifying center connection type.

0 : None

1 : Spring

2 : PreTension

The default value is 0.

iCenterPos​

An Int specifying center position of Bottom Settings.

0 : Upper

1 : Middle

2 : Bottom

The default value is 0.

dlStiffness​

A Double Vector specifying stiffness of spring.

The default value is [0.0, 0.0, 0.0].

iUnit​

An Int specifying Input Unit for dlStiffness.

The default value is 0.

dDampCoef​

A Double specifying Damping Coef of spring.

The default value is 0.

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

The default value is 0.0.

pretension​

A PRETENSION_LOAD specifying Pre Tension Load.
