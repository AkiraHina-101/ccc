# dlg.add_separator()

dlg.add_separator()

Description​

Add a Separator to the creating dialog.

Syntax​

dlg.add_separator(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout18",orientation=orientation.vertical,layout="Window")
    dlg.add_label(name="Label19",text="Label",text_valign="top",layout="Layout18")
    dlg.add_separator(name="Separator20",layout="Layout18")
    dlg.add_textbox(name="TextBox21",layout="Layout18")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
