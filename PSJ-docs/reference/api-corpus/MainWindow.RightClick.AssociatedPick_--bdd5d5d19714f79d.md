# MainWindow.RightClick.AssociatedPick()

MainWindow.RightClick.AssociatedPick()

Description​

Pick associated entity

Syntax​

MainWindow.RightClick.AssociatedPick(crlInput, strTarget, strConnect="UNKNOWN")

Ribbon: MainWindow » RightClick » AssociatedPick

Inputs​

crlInput​

A List of Cursor specifying the input.

This is a required input.

strTarget​

A String specifying the target.

This is a required input.

strConnect​

A String specifying the connect.

The default value is "UNKNOWN".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MainWindow.RightClick.AssociatedPick(crlInput, strTarget, strConnect="UNKNOWN")
