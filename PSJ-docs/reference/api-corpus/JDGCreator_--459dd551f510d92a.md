# JDGCreator()

JDGCreator()

Description​

A Class to generate Dialog in Jupiter.

Syntax​

dlg=JDGCreator(...)

Inputs​

title​

A String specifying the title of the dialog.

This is a required input.

resizable​

A Boolean specifying whether or not the dialog is resizable by user.

True: Dialog is resizable.

False: Dialog is not resizable.

The default value is True.

validation​

A Boolean specifying whether or not the dialog is using validated option.

True: Dialog will check the children components whether or not they are validated by user input. For example, if a character is inputted into TextBox with datatype is Double, then the dialog will yellow out the TextBox and prevent clicking on Apply/OK buttons to execute the next action.

False: Dialog won't check the validation of children components.

The default value is True.

include_apply​

A Boolean specifying whether Apply button is displayed at the bottom of dialog.

True: Apply button is used.

False: Apply button is disabled.

The default value is True.

include_ok​

A Boolean specifying whether OK button is displayed at the bottom of dialog.

True: OK button is used.

False: OK button is disabled.

The default value is True.

include_cancel​

A Boolean specifying whether Cancel button is displayed at the bottom of dialog.

True: Cancel button is used.

False: Cancel button is disabled.

The default value is True.

description​

A String specifying the description text of the dialog.

The default value is "".

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Jupiter Dialog",description="This is a dialog")
    dlg.generate_window()

if __name__=='__main__':
    main()
