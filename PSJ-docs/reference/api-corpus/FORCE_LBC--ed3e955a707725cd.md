# FORCE_LBC

FORCE_LBC

Description​

A data type uses to control parameters of Force and moment load.

Attributes​

vecForce​

A Vector specifying the force value in X,Y,Z direction.

The default value is DFLT_DBL.

vecMoment​

A Vector specifying the momenent value in X,Y,Z direction.

The default value is DFLT_DBL.

iEndArrowDir​

An Integer specifying the drawing position of marker display.

0: Start at Node. The marker is displayed starting from a node.

1: End at Node. The marker is displayed ending at a node.

The default value is 0.

iEndDistribute​

An Integer specifying the load distribution.

0: Per Selected Entity. Apply the load value for each of the selected Entity.

1: Per Node. Apply equal load value to the node on the selected Entity.

2: Total of Select. The total value of the load for the selected Entities.

The default value is 0.

crCurCoord​

A Cursor specifying the load direction of the reference coordinate system of the load.

The default value is None.

crTable​

A Cursor specifying the table which refers to Field Data.

The default value is None.

crNodeSet​

A Cursor specifying the node cursor.

The default value is None.

dPhase​

A Double specifying the phase of the load.

The default value is 0.0.

dDelay​

A Double specifying the delay value of the load.

The default value is 0.0.

crPhaseTable​

A Cursor specifying the phase table of load.

The default value is None.

strFormulaTX​

A String specifying the load formular for X translational direction.

The default value is "".

strFormulaTY​

A String specifying the load formular for Y translational direction.

The default value is "".

strFormulaTZ​

A String specifying the load formular for Z translational direction.

The default value is "".

strFormulaRX​

A String specifying the load formular for X rotational direction.

The default value is "".

strFormulaRY​

A String specifying the load formular for Y rotational direction.

The default value is "".

strFormulaRZ​

A String specifying the load formular for Z rotational direction.

The default value is "".
