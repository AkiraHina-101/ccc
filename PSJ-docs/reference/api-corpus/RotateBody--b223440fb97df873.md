# RotateBody

RotateBody RotateBody Description Rotate Body Syntax RotateBody(Cursor[] body, double[3] rotate_centre, double[3] rotate_axis, double rotate_angle, bool create_new, bool copy_lbc, int copy_count, bool merge_node, double tolerance) Inputs Cursor[] Body List double[3] Rotate Centre double[3] Rotate Axis double Rotate Angle(Radian) bool Create New Body 1=Yes,0=No bool Copy LBC 1=Yes,0=No int Copy Count bool Merge Node 1=Yes,0=No double Merge Node Tolerance Return Code 1 Succeeded 0 Failed Sample Code RotateBody([3:1], [0.005, 0, 0.01], [0.001, 0, 0], 0.785398, 0, 0, 0, 0, 0)
