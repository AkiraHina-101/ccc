# MainWindow.ViewPoint.SetUserViewPoint()

MainWindow.ViewPoint.SetUserViewPoint()

Description​

Set the user ViewPoint

Syntax​

MainWindow.ViewPoint.SetUserViewPoint(...)

Macro:

Ribbon: MainWindow » ViewPoint » SetUserViewPoint

Inputs​

strName​

A String specifying the name of ViewPoint.

This is a required input.

bRotate​

A Boolean specifying whether to rotate the view.

The default value is True.

bPan​

A Boolean specifying whether to pan the view.

The default value is True.

bScale​

A Boolean specifying whether to scale the view.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

JPT.Exec('ViewReset()')
JPT.Exec('ViewControl_Rotate([0, -60, 0])')
JPT.Exec('ViewControl_SetCenter([0.005, 0.005, 0.005])')
JPT.Exec('AddUserViewPoint("New View Point")')
JPT.Exec('ViewReset()')
MainWindow.ViewPoint.SetUserViewPoint(strName="New View Point")
