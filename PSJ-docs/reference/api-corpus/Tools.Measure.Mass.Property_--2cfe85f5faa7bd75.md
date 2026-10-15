# Tools.Measure.Mass.Property()

Tools.Measure.Mass.Property()

Description​

Measure mass by using the applied property.

Syntax​

Tools.Measure.Mass.Property(...)

Ribbon: Tools » Measure » Mass » Property

Inputs​

crlParts​

A List of Cursor specifying the list of parts to measure the mass. This argurment could be in Part type and/or Bar type. If this parameter is [], crlMassConditions must be specified.

If the measurement is applied to crlParts only, then crlParts is a required input.

If the measurement is applied to crlMassConditions only, then crlParts would have the default value is [].

crlMassConditions​

A List of Cursor specifying the list of mass conditions created by Connections.MassElements. If this is [], crlParts must be specified.

If the measurement is applied to crlMassConditions only, then crlMassConditions is a required input.

If the measurement is applied to crlParts only, then crlMassConditions would have the default value is [].

strTarget​

A String specifying the target value of mass information to be outputted. Depending on the target information, this parameter can be one of the following:

If strTarget="Mass": Return the mass value.

If strTarget="Gravity Center X": Return the X position of Gravity Center.

If strTarget="Gravity Center Y": Return the Y position of Gravity Center.

If strTarget="Gravity Center Z": Return the Z position of Gravity Center.

If strTarget="Moment Inertial XX": Return the Moment of Inertia about X axis.

If strTarget="Moment Inertial YY": Return the Moment of Inertia about Y axis.

If strTarget="Moment Inertial ZZ": Return the Moment of Inertia about Z axis.

If strTarget="Moment Inertial XY": Return the product of Moment of Inertia on XY.

If strTarget="Moment Inertial YZ": Return the product of Moment of Inertia on YZ.

If strTarget="Moment Inertial XZ": Return the product of Moment of Inertia on XZ.

If strTarget="Principal Moment X": Return the Moment of Inertia about Principal axis 11.

If strTarget="Principal Moment Y": Return the Moment of Inertia about Principal axis 22.

If strTarget="Principal Moment Z": Return the Moment of Inertia about Principal axis 33.

If strTarget="Traits Vector XX": Return the X direction of Principal axis 11.

If strTarget="Traits Vector XY": Return the Y direction of Principal axis 11.

If strTarget="Traits Vector XZ": Return the Z direction of Principal axis 11.

If strTarget="Traits Vector YX": Return the X direction of Principal axis 22.

If strTarget="Traits Vector YY": Return the Y direction of Principal axis 22.

If strTarget="Traits Vector YZ": Return the Z direction of Principal axis 22.

If strTarget="Traits Vector ZX": Return the X direction of Principal axis 33.

If strTarget="Traits Vector ZY": Return the Y direction of Principal axis 33.

If strTarget="Traits Vector ZZ": Return the Z direction of Principal axis 33.

If strTarget="Euler Angle X": Return the rotation angle of main axis with X axis.

If strTarget="Euler Angle Y": Return the rotation angle of main axis with Y axis.

If strTarget="Euler Angle Z": Return the rotation angle of main axis with Z axis.

The default value is "Mass".

bGravityCenter​

A Boolean specifying the use of gravity center Coordinate System to measure the mass.

If True, crCoord will not be disable. All information will be outputted based on referring to Gravity Center Coordinate System.

If False, crCoord will be defined. All information will be outputted based on referring to Coordinate System that the crCoord specified.

The default value is False.

crCoord​

A Cursor specifying the Coordinate System to measure the mass. This parameter cannot be used when bGravityCenter is True.

The default value is None (Global Coordinate).

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of mass value can be measured.

The default value is 6.

Return Code​

A Double specifying the value of Mass information.

Sample Code​

Geometry.Part.Cube()
Properties.Material.Add("Copper_Alloy", 
                        [Density([(DENSITY, 
                                   8.3e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 
                                  110000.0), 
                                 (POISSONS_RATIO, 
                                  0.34)])])
Properties.Shell(strName="Shell Property 1", 
                 crMatMembrane=Material(1), 
                 crMatBend=Material(1), 
                 crMatShear=Material(1), 
                 dMatOrient1=DFLT_DBL, 
                 dThickness=0.001, 
                 dBendStiff=DFLT_DBL, 
                 dThickRatio=DFLT_DBL, 
                 dNSM=DFLT_DBL, 
                 dFiberDist1=DFLT_DBL, 
                 dFiberDist2=DFLT_DBL,
                 dPlateOff=DFLT_DBL, 
                 iItgPts=DFLT_INT, 
                 crlTargets=[Part(1)])

mass = Tools.Measure.Mass.Property(crlParts=[Part(1)])

JPT.Debugger(mass)
