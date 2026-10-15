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
    dlg.set_pagesctrl_current_page(name='pages_ctrl_item_5',page_index=page)

def main():

    dlg=JDGCreator(title="Switch page sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Set current page from combobox",layout="Window")
    dlg.set_groupbox_orientation("GroupBox1","horizontal")
    dlg.add_label(name="Label2",text="Select current page",layout="GroupBox1")
    dlg.add_combobox(name="switcher",options=["First page","Second page","Third page"],layout="GroupBox1")
    dlg.add_pagesctrl(name="pages_ctrl_item_5",show_header=False,layout="Window")
    dlg.add_pagesctrl_page(name="pages_ctrl_item_5",page_name="PageItem6",page_header="PageItem")
    dlg.add_groupbox(name="GroupBox8",text="GroupBox 1",layout="PageItem6")
    dlg.add_richeditbox(name="RichEditBox9",text="This is first page",width=200,height=200,layout="GroupBox8")
    dlg.add_pagesctrl_page(name="pages_ctrl_item_5",page_name="PageItem7",page_header="PageItem")
    dlg.add_groupbox(name="GroupBox10",text="GroupBox 2",layout="PageItem7")
    dlg.add_richeditbox(name="RichEditBox11",text="This is second page",width=200,height=200,layout="GroupBox10")
    dlg.add_pagesctrl_page(name="pages_ctrl_item_5",page_name="PageItem12",page_header="PageItem")
    dlg.add_groupbox(name="GroupBox13",text="GroupBox 3",layout="PageItem12")
    dlg.add_richeditbox(name="RichEditBox14",text="This is third page",width=200,height=200,layout="GroupBox13")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="switcher",callfunc=switch_page)

if __name__=='__main__':
    main()
