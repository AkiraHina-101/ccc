# DCoord

DCoord

Description​

This is an instance of a DCoord class, represents Coordinate item inside Jupiter.

Properties​

 | Attribute | Description

 | isValid | Determine the validation of the Coordinate.
 The return value is True if the Coordinate is valid, False if not (invalid).

 | type | Type name of the Coordinate.
The return value is Type (string).

 | typeID | Type ID of the Coordinate (ID = 27).
The return value is an Int notation of DItem Types (int).

 | tableID | Table ID of the Coordinate.
The return value is an Int notation of DTable Types (int).

 | id | External ID of the Coordinate.
It can be duplicated, but not recommended.
ID can be changed using the renumbering function.
The return value is ID (int).

 | targets | Hold the contents of the Coordinate.
The return value is a list of DItem.

 | masters | Master face/edge/node of the Coordinate.
The return value is a list of DItem.

 | slaves | Slave face/edge/node of the Coordinate.
The return value is a list of DItem.

 | parent | A sub-assembly that is the parent of Coordinate in the assembly tree.
The return value is a list of DItem.

 | isHidden | Determine display state of the Coordinate.
The return value is True if the Coordinate is hidden, False if the Coordinate is displayed.

 | name | Name of the Coordinate.

 | coordType | Type of the Coordinate.
The return value is Type (string).

 | coordPoints | A list of defined Points for Coordinate.
The return value is TVector3d.

Attribute​

coordType​

 | Name | Description

 | COORDINATE_RECT | Cartesian Coordinate System (Oxyz).

 | COORDINATE_CYLIN | Cylindrical Coordinate - (r, φ, z) Coordinate System, where (r, φ, z) are (radial distance, azimuth angle, axial Coordinate or height z) respectively.

 | COORDINATE_SPHERE | Spherical Coordinate - (r, θ, φ) Coordinate System, where (r, θ, φ) are (radial distance, azimuth angle, polar angle) respectively.
