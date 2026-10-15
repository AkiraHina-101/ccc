# dlg.enable_table_cell()

dlg.enable_table_cell()

Description​

Set to enable/disable the cell in the table.

Syntax​

dlg.enable_table_cell(...)

Inputs​

name​

A String specifying the name of the Table.

This is a required input.

row​

A Integer specifying the position in the horizontal direction of the cell (starts from 0).

This is a required input.

col​

A Integer specifying the position in the vertical direction of the cell (starts from 0).

This is a required input.

cell​

A TableCellID object specifying the location of cell in Table. This argument is only used when row and col are not specified.

TableCellID(row,col) defines a cell object

TableCellID.row_number returns row number of the cell

TableCellID.col_number returns column number of the cell

This is a required input.

enable​

A Boolean specifying whether to enable/disable cell:

True: Enable to cell.

False: Disable to cell.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_menu(dlg,name,menu):
    table_cell = dlg.get_table_sel_cell(name)
    if menu == "Disable Cells":
        for cell in table_cell:
            dlg.enable_table_cell(name="Table1",cell=cell,enable=False)
    elif menu == "Enable Cells":
        for cell in table_cell:
            dlg.enable_table_cell(name="Table1",cell=cell,enable=True)

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
        menus=["Disable Cells","Enable Cells"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
