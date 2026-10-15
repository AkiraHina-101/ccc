# dlg.add_pagesctrl()

dlg.add_pagesctrl()

Description​

Add a PagesCtrl (wizard type) to the creating dialog.

Syntax​

dlg.add_pagesctrl(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created layout name.
The created layout can be a GroupBox component, Layout component, etc.

This is a required input.

show_header​

A Boolean specifying the state of the PageItem's header:

True: PageItem's header will be shown.

False: PageItem's header will be hidden.

The default value is True.

current_page​

An Integer specifying the PageItem shown by default (starts from 0).

The default value is 0.

sel_color​

An Integer specifying the highlight color when selecting a PageItem.

The default value is 13158460.

show_separator​

A Boolean specifying the stage of separator:

True: Show the separate border.

False: Do not show the separate border.

The default value is True.

width​

An Integer specifying the width of the PagesCtrl.

The default value is 0.

height​

An Integer specifying the height of the PagesCtrl.

The default value is 0.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_pagesctrl(name="PagesCtrl4",current_page=2,width=300,height=300,layout="Window")
    dlg.add_pageitem(name="PagesCtrl4",page_name="PageItem5",page_header="PageItem 1")
    dlg.add_pageitem(name="PagesCtrl4",page_name="PageItem6",page_header="PageItem 2")
    dlg.add_pageitem(name="PagesCtrl4",page_name="PageItem7",page_header="PageItem 3")
    dlg.add_pageitem(name="PagesCtrl4",page_name="PageItem8",page_header="PageItem 4")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
