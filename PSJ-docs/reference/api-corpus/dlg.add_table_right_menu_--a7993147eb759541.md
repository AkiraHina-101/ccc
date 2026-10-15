# dlg.add_table_right_menu()

dlg.add_table_right_menu()

Description​

Add options to the context menu (Right click event) of Table.

Syntax​

dlg.add_table_right_menu(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

menus​

A List of String specifying the menus which will be appeared after executing the right click button event on the Table.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",
        menus=["Set Cell Color",
            "Set Text Color",
            "Set Column Width",
            "Custom Menu"])
    dlg.generate_window()

if __name__=='__main__':
    main()
