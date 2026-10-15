# MainWindow.RightClick.FlipElement()

MainWindow.RightClick.FlipElement()

Description​

Flip normal of surface (face or element).

Syntax​

MainWindow.RightClick.FlipElement(...)

Ribbon: MainWindow » RightClick » FlipElement

Inputs​

crlTargets​

A List of Cursor specifying the target.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
MainWindow.RightClick.FlipElement(crlTargets=[Face(21, 23, 26)])
MainWindow.RightClick.FlipElement(crlTargets=[Elem(1009, 1025, 968)])
