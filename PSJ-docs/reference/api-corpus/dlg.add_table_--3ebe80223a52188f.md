# dlg.add_table()

dlg.add_table()

Description​

Add a Table to the creating dialog.

Syntax​

dlg.add_table(...)

Inputs​

rows​

An Integer specifying the number of rows.

This is a required input.

columns​

A List of String specifying the number of columns and heading name of each column or a TableColumnInfoVector object specifying the information of columns in Table.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

name​

A String specifying the name of the created component.

The default value is "".

menus​

A List of String specifying the context menu options (right mouse click):
"clear": clear all the existing data.

"cut": cut the content of the selected cell.

"copy": copy the content of the selected cell.

"paste": paste a value/values which has been copied/cut to a selected cell/select cells.

"insert row": insert a single row to the bottom of the selected cell.

"delete row": delete a selected row/selected rows.

"from file": load the data from csv file into the Table.

"to file": export the data from the Table to a specific csv file.

The default value is [].

width​

An Integer specifying the width of the Table.

The default value is 260.

height​

An Integer specifying the height of the Table.

The default value is 260.

show_grid_line​

A Boolean specifying the display state of grid lines:
True: show Table grid lines.

False: hide Table grid lines.

The default value is True.

show_row_number​

A Boolean specifying the state of showing/hiding row header:
True: show row header.

False: hide row header.

The default value is True.

show_col_header​

A Boolean specifying the state of showing/hiding column header:
True: show column header.

False: hide column header.

The default value is True.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",rows=6,
        columns=["Heading1","Heading2","Heading3"],layout="Window",
        menus=["clear","cut","copy",
                "paste","insert row",
                "delete row","from file","to file"],
        width=200,height=200,
        show_grid_line=False,show_row_number=True,show_col_header=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
