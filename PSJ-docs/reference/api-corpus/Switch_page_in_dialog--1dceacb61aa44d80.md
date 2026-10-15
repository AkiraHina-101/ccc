# Switch page in dialog

Switch page in dialog

🎯 Introduction​

In this tutorial, you'll learn how to use dlg.set_pagesctrl_current_page() to switch between 2 pages in Page Controls:

Create 2 pages with different UI components.

Use a ComboBox to switch between 2 pages.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def switch_page(dlg):
    page = dlg.get_combobox_sel(name='switcher')
    dlg.set_pagesctrl_current_page(name='pages_ctrl_item_5',page_index=page)

def main():
    dlg=JDGCreator(title="Switch page sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Set current page from combobox",layout="Window")
    dlg.set_groupbox_orientation(name="GroupBox1",orientation="horizontal")
    dlg.add_label(name="Label2",text="Select current page",layout="GroupBox1")
    dlg.add_combobox(name="switcher",options=["First page","Second page"],index=0,layout="GroupBox1")
    dlg.add_pagesctrl(name="pages_ctrl_item_5",show_header=False,height=300,width=300,layout="Window")
    dlg.add_pagesctrl_page(name="pages_ctrl_item_5",page_name="PageItem6",page_header="PageItem")
    dlg.add_groupbox(name="GroupBox8",text="GroupBox",layout="PageItem6")
    dlg.add_richeditbox(name="RichEditBox9",text="This is first page",width=200,height=200,layout="GroupBox8")
    dlg.add_pagesctrl_page(name="pages_ctrl_item_5",page_name="PageItem7",page_header="PageItem")
    dlg.add_groupbox(name="GroupBox10",text="GroupBox",layout="PageItem7")
    dlg.add_textbox(name="TextBox13",text="This is second page",layout="GroupBox10")
    dlg.add_hlayout(name="Layout14",layout="GroupBox10")
    dlg.add_table(name="Table11",rows=5,columns=["X direction","Y direction"],width=160,layout="Layout14")
    dlg.add_table(name="Table12",rows=5,columns=["X plot","Y plot"],width=160,layout="Layout14")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_combobox_sel(name="switcher",callfunc=switch_page)

if __name__=='__main__':
    main()
