# dlg.add_pageitem()

dlg.add_pageitem()

Description​

Add a new PageItem to the created/selected PagesCtrl.

Syntax​

dlg.add_pageitem(...)

Inputs​

name​

A String specifying the name of the created PagesCtrl component.

This is a required input.

page_name​

A String specifying the name of the created component.

This is a required input.

page_header​

A String specifying text which will be displayed as PageItem header.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_pagesctrl(name="PagesCtrl4",layout="Window")
    dlg.add_pageitem(name="PagesCtrl4",page_name="PageItem5",page_header="Page header 1")
    dlg.add_node_selector()
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
