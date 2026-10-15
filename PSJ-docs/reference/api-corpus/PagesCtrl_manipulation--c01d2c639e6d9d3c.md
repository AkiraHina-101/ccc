# PagesCtrl manipulation

PagesCtrl manipulation

🎯 Introduction​

In this tutorial, you'll learn how to manipulate PagesCtrl and PageItem components:

Create a PagesCtrl component.

Select a PageItem.

Based on selected PageItem, we can trigger events to get name or to show the information of PageItem.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_pageitem_changed(dlg,name,old_page):
    current_page=dlg.get_pagesctrl_current_page(name="PagesCtrl1")
    current_page_name=dlg.get_pagesctrl_page_name(name="PagesCtrl1",
        page_index=current_page)
    old_page_name=dlg.get_pagesctrl_page_name(name="PagesCtrl1",
        page_index=old_page)
    print("Selected page name : " + current_page_name)
    print("Previous selected page : " + old_page_name)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_pagesctrl(name="PagesCtrl1",width=200,height=200,layout="Window")
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
