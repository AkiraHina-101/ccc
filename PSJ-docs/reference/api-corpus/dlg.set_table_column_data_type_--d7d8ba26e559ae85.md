# dlg.set_table_column_data_type()

dlg.set_table_column_data_type()

Description​

Set data type validation of cell of Table.

Syntax​

dlg.set_table_column_data_type(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

col​

An Integer specifying the order of column (starts from 0).

This is a required input.

data_type​

A String specifying the data type validation for the column of Table.

Support 3 types: "String", "Integer" and "Double"

This is a required input.

precision​

An Integer specifying number of digits after floating point displayed inside a Double column.

The default value is 2.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=260,height=260)    
    dlg.set_table_column_data_type(name="Table1",
        col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",
        col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",
        col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Ok",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
