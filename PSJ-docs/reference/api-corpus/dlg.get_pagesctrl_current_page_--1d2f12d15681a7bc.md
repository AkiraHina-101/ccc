# dlg.get_pagesctrl_current_page()

dlg.get_pagesctrl_current_page()

Description​

Get the index order of current selected PageItem of the PagesCtrl.

Syntax​

dlg.get_pagesctrl_current_page(...)

Inputs​

name​

A String specifying the name of PagesCtrl.

This is a required input.

Return Code​

An Integer specifying the index order of the current selected PageItem of the PagesCtrl.

Sample Code​

from pyjdg import *

def on_pageitem_changed(dlg,name,oldpage):
    current_page=dlg.get_pagesctrl_current_page(name="PagesCtrl1")
    print("Selected page ID:"+str(current_page))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_pagesctrl(name="PagesCtrl1",layout="Window")
    dlg.add_pageitem(name="PagesCtrl1",page_name="PageItem2",
        page_header="PageItem1")
    dlg.add_pageitem(name="PagesCtrl1",page_name="PageItem3",
        page_header="PageItem2")
    dlg.add_pageitem(name="PagesCtrl1",page_name="PageItem4",
        page_header="PageItem3")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Ok",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_pagesctrl_active_page(name="PagesCtrl1",callfunc=on_pageitem_changed)

if __name__=='__main__':
    main()
