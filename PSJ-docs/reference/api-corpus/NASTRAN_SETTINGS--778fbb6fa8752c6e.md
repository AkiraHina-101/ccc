# NASTRAN_SETTINGS

NASTRAN_SETTINGS

Description​

A data type uses to control parameters of Nastran Settings

Attributes​

iPOST​

An Integer specifying the output type for the post-processing results file.
0: Create XDB file.

-1: Create OP2 file (for Patran).

-2: Create OP2 file (for I-Deas).

The default value is -1.

iOGEOM​

An Integer specifying Controls the output of geometry data blocks to the Nastran Binary Results File.
0: input not thing.

1: enable the output of geometry data blocks to the Nastran Binary Results File.

2: disable the output of geometry data blocks to the Nastran Binary Results File.

The default value is 0.

iAUTOSPC​

An Integer specifying the Automatic single point constraint option. AUTOSPC specifying the action to take when singularities exist in the stiffness matrix Setting AUTOSPC to ON means that singularities will be constrained automatically.
0: input not thing.

1: turn on the automatic single point constraint option.

2: turn off the  automatic single point constraint option.

The default value is 0.

strGRDPNT​

A String specifying the Control the weight information output.

The default value is "".

strWTMASS​

A String specifying the global mass matrix scaling factor.The terms of the global mass matrix are multiplied by the value of WTMASS when they are generated. This parameter is used when material density is input in weight instead of mass units

The default value is "".

strK6ROT​

A String specifying the load factor for rotational stiffness of shell elements normal.

The default value is "".

strMAXRATIO​

A String specifying the matrix pseudo-singularity determination ratio.

The default value is "".

iBAILOUT​

An Integer specifying the control of execution against the pseudo-singularity.
0: continue run.

-1: end run.

The default value is DFLT_INT.

iPRGPST​

An Integer specifying the controls the printout of singularities.
0: input not thing.

1: turn on the controls the printout of singularities option.

2: turn off the controls the printout of singularities option.

The default value is 2.

iRESVEC​

An Integer specifying the Residual Vector Selection.
0: input not thing.

1: Enables the calculation of residual vectors.

2: Disables the calculation of residual vectors.

The default value is 0.

dG​

A Double specifying the uniform structural damping coefficient in the formulation of
dynamics problems. If PARAM,G is used in transient analysis PARAM,W3 must be greater than zero or PARAM,G will be ignored.

The default value is DFLT_DBL.

dHFREQ​

A Double specifying the upper frequency range for calculation of rigid body modes in
static analysis with inertia relief.

The default value is DFLT_DBL.

dLFREQ​

A Double specifying the lower frequency range for calculation of rigid body modes in
static analysis with inertia relief.

The default value is DFLT_DBL.

dW3​

A Double specifying The damping matrix for transient analysis is assembled from the equation.
Bdd=Bdd1+Bdd2+GW3Kdd1+1W4Kdd4B_{dd} = B_{dd}^{1} + B_{dd}^{2} + {G\over W3}K_{dd}^{1} + {1\over W4}K_{dd}^{4}Bdd​=Bdd1​+Bdd2​+W3G​Kdd1​+W41​Kdd4​

The default value is DFLT_DBL.

dW4​

A Double specifying The damping matrix for transient analysis is assembled from the equation.
Bdd=Bdd1+Bdd2+GW3Kdd1+1W4Kdd4B_{dd} = B_{dd}^{1} + B_{dd}^{2} + {G\over W3}K_{dd}^{1} + {1\over W4}K_{dd}^{4}Bdd​=Bdd1​+Bdd2​+W3G​Kdd1​+W41​Kdd4​

The default value is DFLT_DBL.

iMEFFMASS​

An Integer specifying The terms of the structural mass matrix are multiplied by the value of WTMASS when they are generated.

The default value is 0.

MEFFMASS_GRID_ID​

A MEFFMASS_GRID_ID specifying efficience mass grid ID.

The default value is DFLT_INT.

iMLDS​

An Integer specifying the MLDS(Multi-Level Dynamic Substructuring).
0: NO.

1: YES [Multi Level Dynamic Substructuring].

The default value is 1.
