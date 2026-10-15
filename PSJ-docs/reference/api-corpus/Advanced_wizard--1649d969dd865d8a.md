# Advanced wizard

Advanced wizard

🎯 Introduction​

In this tutorial, you'll learn how to create an advanced Wizard (PagesCtrl) dialog with 3 pages:

First page contains GroupBox, Table and Tabs.

Second page contains RichEditBox.

Third page contains ListBox and Table.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def main():
    dlg=JDGCreator(title="Wizard sample",resizable=True,validation=True)
    dlg.add_pagesctrl(name="PagesCtrl1",width=450,height=300,layout="Window")
    dlg.add_pagesctrl_page(name="PagesCtrl1",page_name="PageItem2",page_header="SamplePage1")
    dlg.add_hlayout(name="Layout5",layout="PageItem2")
    dlg.add_groupbox(name="GroupBox6",text="GroupBox",layout="Layout5")
    dlg.add_label(name="Label7",text="Label",layout="GroupBox6")
    dlg.add_textbox(name="TextBox8",layout="GroupBox6")
    dlg.add_groupbox(name="GroupBox9",text="GroupBox",layout="Layout5")
    dlg.add_radiobutton(name="RadioButton10",text="RadioButton",layout="GroupBox9")
    dlg.add_radiobutton(name="RadioButton11",text="RadioButton",layout="GroupBox9")
    dlg.add_radiobutton(name="RadioButton12",text="RadioButton",layout="GroupBox9")
    dlg.add_groupbox(name="GroupBox13",text="GroupBox",layout="PageItem2")
    dlg.add_hlayout(name="Layout14",layout="GroupBox13")
    dlg.add_checkbox(name="CheckBox15",text="CheckBox",layout="Layout14")
    dlg.add_checkbox(name="CheckBox16",text="CheckBox",layout="Layout14")
    dlg.add_checkbox(name="CheckBox17",text="CheckBox",layout="Layout14")
    dlg.add_table(name="Table18",rows=5,columns=["X","Y"],layout="GroupBox13")
    dlg.add_groupbox(name="GroupBox19",text="GroupBox",layout="GroupBox13")
    dlg.add_textbox(name="TextBox20",layout="GroupBox19")
    dlg.add_spin(name="Spin21",layout="GroupBox19")
    dlg.add_tabwnd(name="TabCtrl36",width=200,height=200,layout="GroupBox19")
    dlg.add_tabwnd_page(name="TabCtrl36",page_name="TabItem37",page_text="TabItem")
    dlg.add_textbox(name="TextBox39",layout="TabItem37")
    dlg.add_textbox(name="TextBox40",layout="TabItem37")
    dlg.add_textbox(name="TextBox41",layout="TabItem37")
    dlg.add_textbox(name="TextBox42",layout="TabItem37")
    dlg.add_tabwnd_page(name="TabCtrl36",page_name="TabItem38",page_text="TabItem")
    dlg.add_radiobutton(name="RadioButton43",text="RadioButton",layout="TabItem38")
    dlg.add_radiobutton(name="RadioButton44",text="RadioButton",layout="TabItem38")
    dlg.add_radiobutton(name="RadioButton45",text="RadioButton",layout="TabItem38")
    dlg.add_pagesctrl_page(name="PagesCtrl1",page_name="PageItem3",page_header="SamplePage2")
    dlg.add_groupbox(name="GroupBox22",text="GroupBox",layout="PageItem3")
    dlg.add_hlayout(name="Layout24",layout="GroupBox22")
    dlg.add_textbox(name="TextBox25",layout="Layout24")
    dlg.add_button(name="Button26",text="Button",layout="Layout24")
    dlg.add_groupbox(name="GroupBox23",text="GroupBox",layout="PageItem3")
    dlg.add_richeditbox(name="RichEditBox27",text="RichEditBox",width=200,height=200,layout="GroupBox23")
    dlg.add_pagesctrl_page(name="PagesCtrl1",page_name="PageItem4",page_header="SamplePage3")
    dlg.add_groupbox(name="GroupBox28",text="GroupBox",layout="PageItem4")
    dlg.add_hlayout(name="Layout29",layout="GroupBox28")
    dlg.add_listbox(name="ListBox30",options=["item1","item2","item3","item4"],width=100,height=100,layout="Layout29")
    dlg.add_separator(layout="Layout29")
    dlg.add_groupbox(name="GroupBox31",text="GroupBox",layout="Layout29")
    dlg.add_hlayout(name="Layout32",layout="GroupBox31")
    dlg.add_label(name="Label33",text="Label",layout="Layout32")
    dlg.add_textbox(name="TextBox34",layout="Layout32")
    dlg.add_table(name="Table35",rows=5,columns=["X direction","Y direction"],layout="GroupBox31")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
