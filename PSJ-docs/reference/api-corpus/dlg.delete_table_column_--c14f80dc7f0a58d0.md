# dlg.delete_table_column()

dlg.delete_table_column()

Description​

Delete column at a specific position in the Table.

Syntax​

dlg.delete_table_column(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

position​

An Integer specifying the position of column to be deleted.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_menu(dlg,name,menu):
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    if sel_ranges.size()>0:
        position=sel_ranges[0].left
    dlg.delete_table_column(name="Table1",position=position)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",menus=["Delete Column"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
