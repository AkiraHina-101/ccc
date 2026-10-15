# dlg.show_dlg_help_button()

dlg.show_dlg_help_button()

Description​

Show or hide the help button in the creating dialog.

Syntax​

dlg.show_dlg_help_button(...)

Inputs​

shown​

A Boolean specifying the visibility of the help button:
True: show the help button

False: hide the help button

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Label",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.show_dlg_help_button(shown=False)
    dlg.generate_window()

if __name__=='__main__':
    main()
