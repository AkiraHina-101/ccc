# NASTRAN_FREQ_TIMESTEP

NASTRAN_FREQ_TIMESTEP

Description​

A data type uses to control parameters of Nastran Freq Timestep

Attributes​

iNumberOfSteps​

An Integer specifying the Number time steps of value DTi.

The default value is DFLT_INT.

dTimeIncrement​

A Double specifying the time increment.

The default value is DFLT_DBL.

iOutputInterval​

An Integer specifying the Skip factor for output. Every NOi-th step will be
saved for output.

The default value is DFLT_INT.

iDampingType​

An Integer specifying the Modal Damping Table type.

0: None type.

1: CRIT type (Critical damping ratio) .

2: G type (Structural damping coefficient).

3: Q type (Q factor).

The default value is 2.

iModalDampingTableId​

An Integer specifying the modal damping table ID..

The default value is 0.
