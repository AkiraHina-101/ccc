# NASTRAN_NONLINEAR

NASTRAN_NONLINEAR

Description​

A data type uses to defines a set of parameters for nonlinear static analysis iteration strategy.

Attributes​

iNINC​

An Integer specifying the Number of increments.

The default value is 1.

iKMETHOD​

An Integer specifying the method for controlling stiffness updates.

0: AUTO.

1: ITER.

2: SEMI.

3: FNT.

4: PFNT.

The default value is 3.

iMAXITER​

An Integer specifying the Limit on number of iterations for each load increment.

The default value is 1.

bUseEPSU​

A Boolean enable/disable the error tolerance for displacement (U) criterion.

The default value is False.

bUseEPSP​

A Boolean enable/disable the Error tolerance for load (P) criterion.

The default value is False.

bUseEPSW​

A Boolean enable/disable the Error tolerance for work (W) criterion.

The default value is False.

dEPSU​

A Double specifying the error tolerance for displacement (U) criterion value.

The default value is 1.0E-2.

dEPSP​

A Double specifying the Error tolerance for load (P) criterion value.

The default value is 1.0E-2.

dEPSW​

A Double specifying the Error tolerance for work (W) criterion value.

The default value is 1.0E-2.
