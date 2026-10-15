# dlg.clear_table_all()

dlg.clear_table_all()

Description​

Clear all content of the Table.

Syntax​

dlg.clear_table_all(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_click_clear_all(dlg):
    dlg.clear_table_all(name="Table1")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=14,
        columns=["Heading1","Heading2","Heading3","Heading4","Heading5"],
        layout="Window",width=560,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Clear",text="Clear Value",
        width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    for i in range(14):
        for j in range(5):
            dlg.set_cell_value(name="Table1",cell_row_id=i,
                cell_column_id=j,value=str(i+j))
    dlg.on_command(name="Clear",callfunc=on_click_clear_all)

if __name__=='__main__':
    main()
