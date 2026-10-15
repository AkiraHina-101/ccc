# Advanced sample 2 - Set cell alignment and check input value data type

Advanced sample 2 - Set cell alignment and check input value data type

🎯 Introduction​

In this tutorial, you'll learn how a table set cell alignment and check if the value of input value is String/Integer/Double and trigger an event:

For column "String" and “Double”: Check if cell is empty or not, if it is empty, JPT will fill the cell with yellow color.

For column “Integer”: Check if cell value is negative or not, if it is negative number, JPT will set color to text with red color.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_button_check(dlg):
    '''
    Loops all cells in String and Double column to execute empty cell check and negative value check for Integer column:
    1. Check the cell is empty or not, if the cell is empty, returns the yellow fill cell and ask to input
        Parameters:
            None
        Returns:
            Yellow fill cell that is empty
    2. Check data validation of cell in Integer Column, returns the colored font text of cell if value is < 0 (negative value).
        Parameters:
            None
        Returns:
            Returns the colored font text of cell if value is < 0
    '''
    for row in range(5):
        value_cell = dlg.get_cell_value(name="Table1",cell_row_id=row,cell_column_id=0)
        if not value_cell:
            dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=0),color=65535)
        else:
            dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=0),color=16777215)
    for row in range(5):
        value_cell = dlg.get_cell_value(name="Table1",cell_row_id=row,cell_column_id=1)
        if int(float(value_cell)) == 0:
            dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=1),color=65535)
        else:
            dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=1),color=16777215)
    for row in range(5):
        value_cell = dlg.get_cell_value(name="Table1",cell_row_id=row,cell_column_id=2)
        if int(value_cell)<0:
            dlg.set_table_cell_text_color(name="Table1",cell=TableCellID(row=row,col=2),color=255)
        else:
            dlg.set_table_cell_text_color(name="Table1",cell=TableCellID(row=row,col=2),color=0)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,columns=["String","Double","Integer"],layout="Window",width=350,height=150)
    dlg.set_table_column_data_type(name="Table1",
        col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",
        col=1,data_type="Double",precision=3)
    dlg.set_table_column_data_type(name="Table1",
        col=2,data_type="Integer")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCheck",text="Check",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    for row in range(5):
        dlg.set_table_cell_alignment(name="Table1",row=row,col=0,
            alignment="Left")
        dlg.set_table_cell_alignment(name="Table1",row=row,col=1,
            alignment="Right")
        dlg.set_table_cell_alignment(name="Table1",row=row,col=2,
            alignment="Right")
    for i in range(5):
        if i!=3:
            dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=0,value="This is String {}".format(i))
    for i in range(5):
        if i!=3:
            dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=1,value=[1.123+i])
    for i in range(5):
        if i==1:
            dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=2,value=[-5])
        else:
            dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=2,value=[i+3])
    dlg.on_button_clicked(name="ButtonCheck",callfunc=on_button_check)

if __name__=='__main__':
    main()
