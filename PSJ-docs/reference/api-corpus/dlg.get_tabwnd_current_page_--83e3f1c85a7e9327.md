# dlg.get_tabwnd_current_page()

dlg.get_tabwnd_current_page()

Description​

Get the selecting page of the inputted TabWnd.

Syntax​

dlg.get_tabwnd_current_page(...)

Inputs​

name​

A String specifying the name of the TabWnd component using for getting selected page order.

This is a required input.

Return Code​

An Integer specifying the order of the selected page of the inputted TabWnd.

Sample Code​

from pyjdg import *

def get_current_tab(dlg):
    selected_page = dlg.get_tabwnd_current_page(name="TabWnd1")
    JPT.Debugger(selected_page)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_tabwnd(name="TabWnd1",width=400,height=200,layout="Window")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem2",page_text="TabItem")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem3",page_text="TabItem")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem4",page_text="TabItem")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem5",page_text="TabItem")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem6",page_text="TabItem")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ButtonApply",callfunc=get_current_tab)

if __name__=='__main__':
    main()
