# BoundaryConditions.ThermalAttributes()

BoundaryConditions.ThermalAttributes()

Description​

Create a thermal attribute.

Syntax​

BoundaryConditions.ThermalAttributes(...)

Macro: LbcThermalAttributes

Ribbon: BoundaryConditions » ThermalAttributes

Inputs​

dStefanBoltzmannConstant​

A Double specifying Stefan Boltzmann Constant

The default value is 5.670000E-8.

dAbsoluteZero​

A Double specifying  Absolute Zero.

The default value is 0 (degC).

crEdit​

A Cursor specifying existing thermal attribute.

The default value is None (create new).

Return Code​

A Cursor specifying the created thermal attribute.

Sample Code​

BoundaryConditions.ThermalAttributes(dStefanBoltzmannContact=5.67037e-08)
