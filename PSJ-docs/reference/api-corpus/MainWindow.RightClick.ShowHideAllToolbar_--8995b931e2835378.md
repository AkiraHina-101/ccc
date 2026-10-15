# MainWindow.RightClick.ShowHideAllToolbar()

MainWindow.RightClick.ShowHideAllToolbar()

Description​

Show/hide the toolbar on working document.

Syntax​

MainWindow.RightClick.ShowHideAllToolbar(...)

Macro: ShowHideAllToolbar

Ribbon: MainWindow » RightClick » ShowHideAllToolbar

Inputs​

iType​

An Integer specifying toolbar type to be shown/hidden.

0: View selection toolbar.

1: Main window toolbar.

The default value is 0.

bShow​

A Boolean specifying whether to show/hide the toolbar.

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

MainWindow.RightClick.ShowHideAllToolbar(bShow=True)
