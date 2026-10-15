# dlg.get_cell_value()

dlg.get_cell_value()

Description​

Get value of a specific cell of Table.

Syntax​

dlg.get_cell_value(...)

Inputs​

name​

A String specifying the name of the Table component.

This is a required input.

row​

An Integer specifying the position in the horizontal direction of the cell (starts from 0).

This is a required input.

col​

An Integer specifying the position in the vertical direction of the cell (starts from 0).

This is a required input.

option​

An Integer specifying the index number inside of combobox cell.

The default value is -1 (get the displayed content of cell).

Return Code​

A String specifying the value of the inputted cell.

Sample Code​

from pyjdg import *

def get_table_cell_value(dlg,name,cell):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if cellvector.size()>0:
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number)
        dlg.set_item_text(name="Textbox4",text=value_cell)
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number,option=1)
        dlg.set_item_text(name="Textbox5",text=value_cell)
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number,option=2)
        dlg.set_item_text(name="Textbox6",text=value_cell)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Get Displayed Value",width=100,layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_layout(name="Layout2",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label4",text="Get Value option=1",width=100,layout="Layout2")
    dlg.add_textbox(name="Textbox5",layout="Layout2")
    dlg.add_layout(name="Layout3",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label5",text="Get Value option=2",width=100,layout="Layout3")
    dlg.add_textbox(name="Textbox6",layout="Layout3")
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_table_sel_changed(name="Table1",callfunc=get_table_cell_value)
    dlg.set_cell_value(name="Table1",row=0,col=0,
        value=["Option1","Option2","Option3"])

if __name__=='__main__':
    main()
