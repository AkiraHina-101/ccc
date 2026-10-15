# Simple wizard

Simple wizard

🎯 Introduction​

In this tutorial, you'll learn how to make a simple Wizard (PagesCtrl) dialog with:

First page contains a Label and TextBox.

Second page contains a ComboBox and a ListBox.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def main():
    dlg=JDGCreator(title="PagesCtrl",resizable=True,validation=True)
    dlg.add_pagesctrl(name="PagesCtrl1",width=300,height=300,layout="Window")
    dlg.add_pagesctrl_page(name="PagesCtrl1",page_name="PageItem2",page_header="PageItem")
    dlg.add_label(name="Label4",text="Label",layout="PageItem2")
    dlg.add_textbox(name="TextBox5",layout="PageItem2")
    dlg.add_pagesctrl_page(name="PagesCtrl1",page_name="PageItem3",page_header="PageItem")
    dlg.add_combobox(name="ComboBox6",layout="PageItem3")
    dlg.add_listbox(name="ListBox7",width=100,height=100,layout="PageItem3")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
