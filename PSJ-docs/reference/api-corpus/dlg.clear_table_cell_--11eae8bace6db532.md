# dlg.clear_table_cell()

dlg.clear_table_cell()

Description​

Clear content of a specific cell of Table.

Syntax​

dlg.clear_table_cell(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

row​

An Integer specifying the position in the horizontal direction of the cell (starts from 0).

This is a required input.

col​

An Integer specifying the position in the vertical direction of the cell (starts from 0).

This is a required input.

text​

A String specifying the new content of the cleared cell (if needed).

The default value is [].

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

# Clear a specific cell by using right-click > Clear Cell
# The content of specific cell will be cleared
# Text Change's data will be new content of cleared cell if it is entered  
def set_table_read_from_file(dlg,name,menu):
    table_cell = dlg.get_table_sel_cell(name)
    if table_cell.size()>0:
        text_change=dlg.get_item_text(name="Textbox4")
        if menu == "Clear Cell":
            dlg.clear_table_cell(name,
                row=table_cell[0].row_number,
                col=table_cell[0].col_number,
                text=text_change)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Text Change",layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",
        col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",
        col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",
        col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")  
    dlg.add_table_right_menu(name="Table1",
        menus=["Clear Cell"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=set_table_read_from_file)
    dlg.set_table_cell_checkbox(name="Table1",row=0,col=0,text="Checkbox",
        checked=True)
    dlg.set_cell_value(name="Table1",
        row=1,col=0,value=["Option2","Option3"])
    dlg.set_cell_value(name="Table1",row=0,col=1,value="1")
    dlg.set_cell_value(name="Table1",row=1,col=1,value=[2,3])
    dlg.set_table_cell_button(name="Table1",row=0,col=2,text="Button")
    dlg.set_cell_value(name="Table1",row=1,col=2,value=[2.5,3.5]) 

if __name__=='__main__':
    main()
