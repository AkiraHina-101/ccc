# Table

Table

Create a table.

Preview dialog:

Parameters​

Name​

Enter name of the table.

Enable​

Specify whether to enable it or not.

Check On : Available

Check Off : Unavailable (grayed out)

Show Grid Line​

Display of the grid line or not.

Check On : Display the grid lines

Check Off : Do not display the grid lines

Show Row Number​

Display of the row header or not.

Check On : Display the row header

Check Off : Do not display the row header

Show Column Header​

Display of the column header or not.

Check On : Display the column header

Check Off : Do not display the column header

Size​

Width : Specifying the minimum width of the table. (in pixels)

Height : Specifying the minimum height of the table. (in pixels)

Behavior​

Specify the the behavior state of table to flexibly control size itself.

Greedy : set the displaying table based on the user input width and height, allow resizing table size according to dialog size

Fixed : set the displaying table based on the user input width and height, and won't resize table size according to dialog size

Horizontal : set the displaying table with fixing height based on user input and allow resizing table only horizontally

Vertical : set the displaying table with fixing width based on user input and allow resizing table only vertically

Pop Menu Options​

Display the right click menu.

Supported Options:
Cut, Copy, Paste, Insert Row, Delete Row, Clear Content, Read From File, Write To File

Total Rows Count​

Specify the number of rows.

Total Columns Count​

Specify the number of columns.

Column Setting​

Specify type of the column.

Heading*：Specify the content type of column.

API associated with​

dlg.add_table : Add a Table to the creating dialog.

dlg.add_table_right_menu : Add options to the context menu (Right click event) of Table.

dlg.enable_table_column_filter : Add filter option of column of Table.

dlg.get_cell_label : Get label of a button cell, checkbox cell or combobox cell in the Table.

dlg.get_cell_value : Get value of a specific cell of Table.

dlg.get_table_column_width : Get the width of the specified column in the Table.

dlg.get_table_sel_cell : Get the information and attributes of the selected cells.

dlg.get_table_sel_range : Get the information and attributes of the selected ranges (multi cells).

dlg.get_total_row : Get the total number of rows of the Table.

dlg.get_total_column : Get the total number of columns of the Table.

dlg.insert_table_rows : Insert row(s) at a specific position in the Table.

dlg.insert_table_columns : Insert column(s) at a specific position in the Table.

dlg.delete_table_row : Delete row at a specific position in the Table.

dlg.delete_table_column : Delete column at a specific position in the Table.

dlg.is_table_cell_button : Check the input cell is a button cell or not.

dlg.is_table_cell_checkbox : Check the input cell is a checkbox cell or not.

dlg.is_table_cell_combobox : Check the input cell is a combobox cell or not.

dlg.is_table_cell_checked : Check the state of checkbox cell.

dlg.on_table_right_menu : Set event when opening/executing context menu.

dlg.on_table_sel_changed : Set event when selecting a cell.

dlg.on_table_button_clicked : Set event when selecting a button cell.

dlg.set_cell_value : Set a value for a specific cell.

dlg.set_table_cell_fill_color : Set fill color to the selected/specified cells.

dlg.set_table_cell_text_color : Set color to text in the selected/specified cells.

dlg.set_table_cell_alignment : Set text alignment of cell.

dlg.set_table_column_width : Set the width of the specified column in the Table.

dlg.set_table_column_data_type : Set data type validation of cell of Table.

dlg.set_table_cell_button : Set button cell in the Table.

dlg.set_table_cell_checkbox : Set checkbox cell in the Table.

dlg.select_table_range : Select a specific range by position in the Table.

dlg.clear_table_range : Clear content of the specific range by position in the Table.

dlg.clear_table_all : Clear all content of the Table.
