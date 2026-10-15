# dlg.set_groupbox_collapsed()

dlg.set_groupbox_collapsed()

Description​

Set the initial state of the GroupBox's collapse feature to show/hide GroupBox's components.

Syntax​

dlg.set_groupbox_collapsed(...)

Inputs​

name​

A String specifying the name of GroupBox which will be used for setting the state of its collapse feature.

This is a required input.

collapsed​

A Boolean specifying the state of the GroupBox's collapse feature:
True: Enable the collapse with its state is collapsed (hide all GroupBox's components).

False: Enable the collapse with its state is expanded (show all GroupBox's components).

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.set_groupbox_collapsed(name="GroupBox1",collapsed=True)
    dlg.set_groupbox_orientation(name="GroupBox1",orientation="horizontal")
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
