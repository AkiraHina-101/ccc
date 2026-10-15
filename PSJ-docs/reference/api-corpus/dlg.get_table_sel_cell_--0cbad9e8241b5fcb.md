# dlg.get_table_sel_cell()

dlg.get_table_sel_cell()

Description​

Get the information and attributes of the selected cells.

Syntax​

dlg.get_table_sel_cell(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

Return Code​

A TableCellVector object or List of TableCellID specifying the methods of cells.

Sample Code​

from pyjdg import *

def on_context_click(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    for i in range(cellvector.size()):
        print("The cell number {} has information".format(i+1))
        print("Cell's position (row) = "+str(cellvector[0].row_number))
        print("Cell's position (column) = "+str(cellvector[0].col_number))
        print("---------------------------")

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
    dlg.add_table_right_menu(name="Table1",menus=["Check cell info"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_context_click)

if __name__=='__main__':
    main()
