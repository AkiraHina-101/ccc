# dlg.set_groupbox_checked()

dlg.set_groupbox_checked()

Description​

Set the initial state of the GroupBox's checkbox to show/hide. In case of showing, the initial state of the checkbox is checked.

Syntax​

dlg.set_groupbox_checked(...)

Inputs​

name​

A String specifying the name of the component in which will be used for setting the state of its checkbox to show/hide.

This is a required input.

checked​

A Boolean specifying the state of the GroupBox:
True: Show the checkbox of the GroupBox component with its state is checked.

False: Hide the checkbox of the GroupBox component.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.set_groupbox_checked(name="GroupBox1",checked=True)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="GroupBox1")
    dlg.add_label(name="Label3",text="Label",layout="Layout2")
    dlg.add_textbox(name="TextBox4",layout="Layout2")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
