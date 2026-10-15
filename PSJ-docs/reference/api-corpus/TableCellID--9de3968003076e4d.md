# TableCellID

TableCellID

Description​

An instance of a TableCellID class, represents attributes of a target cell inside table.

Input​

To create a TableCellID object, defines a variable with TableCellID(...).

row​

An Integer specifying the order of row (starts from 0).

The default value is -1.

col​

An Integer specifying the order of column (starts from 0).

The default value is -1.

Attributes​

Get attributes of TableCellID.

row_number​

An Integer specifying row number of the cell (starts from 0).

The default value is -1.

col_number​

An Integer specifying col number of the cell (starts from 0).

The default value is -1.

Remarks​

Index number of row and col of TableCellID can not be out of range of the existing table.

Index number of row_number and col_number of TableCellID can not be out of range of the existing table.

Sample Code​

from pyjdg import *

def on_button_check(dlg):
    #To create an instance of TableCellID
    cell_1 = TableCellID()
    cell_2 = TableCellID(row=2,col=2)
    #To check attributes of object
    print("Default Cell has position: Row={}, Column={}"
        .format(cell_1.row_number, cell_1.col_number))
    print("Specified Cell has position: Row={}, Column={}"
        .format(cell_2.row_number, cell_2.col_number))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCheck",text="Check",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ButtonCheck",callfunc=on_button_check)

if __name__=='__main__':
    main()
