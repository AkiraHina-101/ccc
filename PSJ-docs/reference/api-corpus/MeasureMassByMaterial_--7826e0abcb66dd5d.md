# MeasureMassByMaterial()

MeasureMassByMaterial()

Description​

Measure Mass By Material.

Syntax​

MeasureMassByMaterial. (Cursor[] parts, Cursor[] massConditions, double dMaterialDensity, String strTarget, Bool bGravityCenter, Cursor crRefCoord, int iPrecision)

Inputs​

1. Cursor[]​

A List of Cursor specifying the list of parts to measure the mass. This argurment could be in Part type and/or Bar type. If this parameter is [], massConditions must be specified.

2. Cursor[]​

A List of Cursor specifying the list of mass conditions. If this is [], parts must be specified.

3. double[]​

A String specifying the material density (default unit: kg/m3).

4. String​

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

5. Bool​

A Boolean specifying the use of gravity center Coordinate System to measure the mass.

6. Cursor​

A Cursor specifying the Coordinate System to measure the mass. This parameter cannot be used when bGravityCenter is True.

The default value is None (Global Coordinate).

7. int​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of mass value can be measured.

The default value is 6.

Return Code​

A Double specifying the value of Mass information.

Sample Code​

MeasureMassByMaterial([3:1], [], 2300, "Mass", 0, 0:0, 6)
