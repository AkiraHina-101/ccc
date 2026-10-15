# dlg.set_groupbox_orientation()

dlg.set_groupbox_orientation()

Description​

Set the layout of all the components inside the GroupBox component to be aligned in the horizontal or vertical direction.

Syntax​

dlg.set_groupbox_orientation(...)

Inputs​

name​

A String specifying the name of the component using for setting the orientation option.

This is a required input.

orientation​

A String specifying the orientation option of the GroupBox:

"vertical": align all the inside components in the vertical direction.

"horizontal": align all the inside components in the horizontal direction.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.set_groupbox_orientation(name="GroupBox1",orientation="vertical")
    dlg.add_label(name="Label2",text="Label",layout="GroupBox1")
    dlg.add_textbox(name="TextBox3",layout="GroupBox1")
    dlg.add_label(name="Label4",text="Label",layout="GroupBox1")
    dlg.add_textbox(name="TextBox5",layout="GroupBox1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
