# dlg.is_table_cell_checkbox()

dlg.is_table_cell_checkbox()

Description​

Check the input cell is a checkbox cell or not.

Syntax​

dlg.is_table_cell_checkbox(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

cell​

A TableCellID object specifying the location of cell in Table.
TableCellID(row,col) defines a cell object

TableCellID.row_number returns row number of the cell

TableCellID.col_number returns column number of the cell

This is a required input.

Return Code​

A Boolean specifying the type of inputted cell:

True: The inputted cell is a checkbox cell.

False: The inputted cell is not a checkbox cell.

Sample Code​

from pyjdg import *

def on_cell_button_clicked(dlg,name,cell):
    JPT.ClearLog()
    cellvector=dlg.get_table_sel_cell(name="Table2")
    if cellvector.size() > 0:
       check_cell_checkbox = \
            dlg.is_table_cell_checkbox(name="Table2",
                cell=cellvector[0])
       print("Is checkbox cell: " + str(check_cell_checkbox))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",width=260,height=260,
        columns=["Heading1","Heading2"],
        rows=5,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",
        layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_table_cell_checkbox(name="Table2",row=0,
        col=0,text="Checkbox",checked=True)
    dlg.on_table_sel_changed(name="Table2",
        callfunc=on_cell_button_clicked)

if __name__=='__main__':
    main()
