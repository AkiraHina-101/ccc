# dlg.add_tabwnd()

dlg.add_tabwnd()

Description​

Add a TabWnd (tab window) to the creating dialog.

Syntax​

dlg.add_tabwnd(...)

Inputs​

name​

A String specifying the name of the tab window component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

width​

An Integer specifying the width of the tab window.

The default value is 60.

height​

An Integer specifying the height of the tab window.

The default value is 22.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_tabwnd(name="TabWnd1",width=200,height=200,layout="Window")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem2",page_text="TabItem",page_orientation="horizontal")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem3",page_text="TabItem")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
