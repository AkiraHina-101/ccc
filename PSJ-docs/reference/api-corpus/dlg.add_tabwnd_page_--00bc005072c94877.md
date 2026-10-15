# dlg.add_tabwnd_page()

dlg.add_tabwnd_page()

Description​

Add a TabItem (page) to the TabWnd component.

Syntax​

dlg.add_tabwnd_page(...)

Inputs​

name​

A String specifying the name of the TabWnd component in which the creating TabItem will be put added to.

This is a required input.

page_name​

A String specifying the name of the created component.

This is a required input.

page_text​

A String specifying text which will be displayed as a title.

The default value is "".

page_orientation​

A String specifying the orientation of the creating tab page. It has 2 options:
"vertical": aligning all the inside components in the vertical direction.

"horizontal": aligning all the inside components in the horizontal direction.

The default value is "vertical".

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_tabwnd(name="TabWnd2",width=200,height=200,layout="Window")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem3",page_text="TabItem",page_orientation="vertical")
    dlg.add_label(name="Label5",text="Label",text_halign="left",text_valign="top",layout="TabItem3")
    dlg.add_textbox(name="TextBox6",layout="TabItem3")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem4",page_text="TabItem",page_orientation="horizontal")
    dlg.add_label(name="Label7",text="Label",text_halign="left",text_valign="top",layout="TabItem4")
    dlg.add_textbox(name="TextBox8",layout="TabItem4")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
