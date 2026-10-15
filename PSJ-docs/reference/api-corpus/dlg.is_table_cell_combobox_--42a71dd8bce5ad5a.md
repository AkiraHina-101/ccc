# dlg.is_table_cell_combobox()

dlg.is_table_cell_combobox()

Description​

Check the input cell is a combobox cell or not.

Syntax​

dlg.is_table_cell_combobox(...)

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

True: The inputted cell is a combobox cell.

False: The inputted cell is not a combobox cell.

Sample Code​

from pyjdg import *

def on_cell_button_clicked(dlg,name,cell):
    JPT.ClearLog()
    cellvector=dlg.get_table_sel_cell(name="Table2")
    if cellvector.size() > 0:
       check_cell_combobox = \
            dlg.is_table_cell_combobox(name="Table2",
                cell=cellvector[0])
       print("Is combobox cell: " + str(check_cell_combobox))

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
    dlg.set_cell_value(name="Table2",row=0,col=0,
        value=["Option1","Option2","Option3"])
    dlg.on_table_sel_changed(name="Table2",
        callfunc=on_cell_button_clicked)

if __name__=='__main__':
    main()
