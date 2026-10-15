# dlg.add_1delement_selector()

dlg.add_1delement_selector()

Description​

Add "1D element" to the selection list, allowing user to select 1D elements and store the selected 1D elements to the selection list.

Syntax​

dlg.add_1delement_selector(...)

Inputs​

text​

A String specifying the title of selector.

The default value is "1D element".

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Length in X",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_layout(name="Layout6",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label7",text="Length in Y",layout="Layout6")
    dlg.add_textbox(name="TextBox8",layout="Layout6")
    dlg.add_layout(name="Layout9",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label10",text="Length in Z",layout="Layout9")
    dlg.add_textbox(name="TextBox11",layout="Layout9")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_1delement_selector(text="1D Element 1")
    dlg.generate_window()

if __name__=='__main__':
    main()
