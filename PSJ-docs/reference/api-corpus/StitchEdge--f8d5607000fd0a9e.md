# StitchEdge

StitchEdge StitchEdge Description Stitch Edge Syntax StitchEdge(double dTolerance, bool keepSlave, cursor[] taMaster, cursor[] taSlave) Inputs Double Tolerance for stitch (m) Bool Whether keep slave or not True = 1, False = 0 Cursor[] Master edge for stitch -> edge cursor([5:Edge ID]) Cursor[] Slave edge for stitch -> edge cursor([5:Edge ID]) Return Code 1 Succeeded 0 Failed Sample Code StitchEdge(0.0003, 1, [5:18], [5:57])
