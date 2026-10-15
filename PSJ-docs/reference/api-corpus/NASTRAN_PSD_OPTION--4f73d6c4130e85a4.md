# NASTRAN_PSD_OPTION

NASTRAN_PSD_OPTION

Description​

A data type uses for curve plotter output request setting

Attributes​

iNodeSetID​

An Integer specifying the group node ID.

The default value is 0.

bDofT1​

A Boolean enable/disable the output of displacement, velocity and acceleration with translation X.

The default value is False.

bDofT2​

A Boolean enable/disable the output of displacement, velocity and acceleration with translation Y.

The default value is False.

bDofT3​

A Boolean enable/disable the output of displacement, velocity and acceleration with translation Z.

The default value is False.

bDofR1​

A Boolean enable/disable the output of displacement, velocity and acceleration with Rotation X.

The default value is False.

bDofR2​

A Boolean enable/disable the output of displacement, velocity and acceleration with Rotation Y.

The default value is False.

bDofR3​

A Boolean enable/disable the output of displacement, velocity and acceleration with Rotation Z.

The default value is False.

iOutputType​

An Integer specifying the output type.
0: PSDF.

1: Auto Correlation.

2: PSDF and Auto Correlation.

The default value is 0.

iDispType​

An Integer specifying the displacement output type.
0: XYPUNCH.

1: XYPLOT.

2: XYPUNCH & XYPLOT.

3: input nothing.

The default value is 0.

iVelocityType​

An Integer specifying the velocity output type.
0: XYPUNCH.

1: XYPLOT.

2: XYPUNCH & XYPLOT.

3: input nothing.

The default value is 0.

iAcceType​

An Integer specifying the acceleration output type.
0: XYPUNCH.

1: XYPLOT.

2: XYPUNCH & XYPLOT.

3: input nothing.

The default value is 0.

dStartFreq​

A Double specifying the start frequency value.

The default value is 0.0.

dEndFreq​

A Double specifying the ending frequency value.

The default value is 0.0.
