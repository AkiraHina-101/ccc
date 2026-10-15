# Advanced sample 1 - Control the data type of input value

Advanced sample 1 - Control the data type of input value

🎯 Introduction​

In this tutorial, you'll learn how a table control the data type of input value then triggering an event:

Check empty cell: any empty cell will fill with red color and show error message.

Check data type of cell: Column “String” should be input with character, column “Integer” should be input with number.

If a cell of column “String” is input with number, JPT will fill with red color and show error message.

If a cell of column “Integer” is input with character, JPT will fill with orange color and show error message.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

# Import 'sys' module of Python
import sys

# Clear the log message in Python API window
JPT.ClearLog()

from pyjdg import *

def on_click_check(dlg):
    '''
    Loops all cells and executes 2 checks for each cell:
    1. Check the cell is empty or not, if the cell is empty, returns the red fill cell and ask to input
        Parameters:
            None
        Returns:
            Red fill cell that is empty
    2. Check data validation of cell, returns the colored fill cell if the data type is not correct.
        Parameters:
            None
        Returns:
            Returns the red fill cell if the value of cell is not String
            Returns the orange fill cell if the value of cell is not Integer
    '''
    JPT.ClearLog()
    total_rows = dlg.get_total_row(name="Table1")
    total_cols = dlg.get_total_column(name="Table1")
    i = 0
    j = 0
    k = 0
    #Check required input
    for row in range(total_rows):
        for col in range(total_cols):
            value_cell = dlg.get_cell_value(name="Table1",cell_row_id=row,cell_column_id=col)
            if value_cell:
                dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=col),color=16777215)
            elif not value_cell:
                dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=col),color=7105764)
                k+=1
                continue
    if k!=0:
        JPT.MsgOut("Red cell required input")
        return
    else:
        #Check data validation
        for row in range(total_rows):
            for col in range(total_cols):
                value_cell = dlg.get_cell_value(name="Table1",cell_row_id=row,cell_column_id=col)
                dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=col),color=16777215)
                if col == 0:
                    if value_cell.isnumeric() == True:
                        dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=col),color=7105764)
                        i+=1

                elif col == 1:
                    if value_cell.isnumeric() == False:
                        dlg.set_table_cell_fill_color(name="Table1",cell=TableCellID(row=row,col=col),color=42495)
                        j+=1

    if i != 0 and j !=0:
        JPT.MsgOut("Red cell requires String type")
        JPT.MsgOut("Orange cell requires Integer type")
    elif i != 0 and j ==0:
        JPT.MsgOut("Red cell requires String type")
    elif i == 0 and j !=0:
        JPT.MsgOut("Orange cell requires Integer type")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer"],
        layout="Window",menus=["clear"],width=260,height=260)
    dlg.set_table_column_data_type(name="Table1", col=0, data_type="String")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="ButtonApply",callfunc=on_click_check)

if __name__=='__main__':
    main()
