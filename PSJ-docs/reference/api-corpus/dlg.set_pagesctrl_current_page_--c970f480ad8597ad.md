# dlg.set_pagesctrl_current_page()

dlg.set_pagesctrl_current_page()

Description​

Set current displayed PageItem in PagesCtrl.

Syntax​

dlg.set_pagesctrl_current_page(...)

Inputs​

name​

A String specifying the name the PagesCtrl.

This is a required input.

page_index​

An Integer specifying the index position of the PageItem (starts from 0).

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def switch_page(dlg):
    page = dlg.get_combobox_sel(name="switcher")
    dlg.set_pagesctrl_current_page(name='PagesCtrl2',page_index=page)

def main():

    dlg=JDGCreator(title="Switch page sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Set current page from combobox",layout="Window")
    dlg.set_groupbox_orientation("GroupBox1","horizontal")
    dlg.add_label(name="Label2",text="Select current page",layout="GroupBox1")
    dlg.add_combobox(name="switcher",options=["First page","Second page","Third page"],layout="GroupBox1")
    dlg.add_groupbox(name="GroupBox2",text="Current page display",layout="Window")
    dlg.set_groupbox_orientation("GroupBox2","horizontal")
    dlg.add_pagesctrl(name="PagesCtrl2",width=260,height=160,layout="GroupBox2")
    dlg.add_pageitem(name="PagesCtrl2",page_name="PageItem3",page_header="First page")
    dlg.add_pageitem(name="PagesCtrl2",page_name="PageItem4",page_header="Second page")
    dlg.add_pageitem(name="PagesCtrl2",page_name="PageItem5",page_header="Third page")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_combobox_sel(name="switcher",callfunc=switch_page)

if __name__=='__main__':
    main()
