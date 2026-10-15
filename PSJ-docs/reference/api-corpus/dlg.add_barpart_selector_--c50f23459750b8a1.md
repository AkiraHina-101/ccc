# dlg.add_barpart_selector()

dlg.add_barpart_selector()

Description​

Add "Bar" to the selection list, allowing user to select bar parts and store the selected bar parts to the selection list.

Syntax​

dlg.add_barpart_selector(...)

Inputs​

text​

A String specifying the title of selector.

The default value is "Bar".

A String specifying text which will be displayed as button label.

The default value is "Bar".
Bar

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Mesh Count",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_barpart_selector(text="Bar 1")
    dlg.generate_window()

if __name__=='__main__':
    main()
