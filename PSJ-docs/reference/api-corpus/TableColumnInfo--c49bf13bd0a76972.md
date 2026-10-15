# TableColumnInfo

TableColumnInfo

Description​

An instance of a TableColumnInfo class, represents attributes of a target column inside table.

Input​

To create a TableColumnInfo object, defines a variable with TableColumnInfo(...).

name​

A String specifying the name of column.

This is a required input.

type​

An Integer A String specifying the data type validation for the column of table.

Support 3 types: "String", "Integer" and "Double".

This is a required input.

precision​

An Integer specifying number of digits after floating point displayed inside a Double column.

The default value is 2.

filter​

A Boolean specifying the state of filter mode of column of table.
True: filter mode will be shown.

False: filter mode will be hidden.

The default value is False.

Attributes​

Get attributes of TableColumnInfo.

column_name​

A String specifying the name of column.

column_type​

An Integer specifying the data type validation for the column of table.

column_precision​

An Integer specifying number of digits after floating point displayed inside a Double column.

The default value is 2.

column_filter​

An Integer specifying the state of filter mode of column of table.
1: filter mode is using.

0: filter mode is not using.

The default value is 0.

Remarks​

Based on the specifying data type of type, all cells of that column accept only that type.

If precision is specified to the column which is "String" or "Integer" type, the data type of that column and value of cells will not change.
To use filter option, user can set True state to shows filter mode; set False state or ignore this option in script - the both ways will trigger the same action that hides filter mode.

Sample Code​

from pyjdg import *

def on_button_check(dlg):
    #To create an instance of TableColumnInfo
    column_1 = TableColumnInfo(name="Heading1",type="String")
    column_2 = TableColumnInfo(name="Heading2",type="Integer")
    column_3 = TableColumnInfo(name="Heading3",type="Double",precision=4)
    column_4 = TableColumnInfo(name="Heading4",type="String",filter=True)
    #To check attributes of object
    print("Column Name: {}, Column Type: {}, Column Precision: {} (Default value), Column_Filter: {}"
        .format(column_1.column_name,column_1.column_type,column_1.column_precision,column_1.column_filter))
    print("Column Name: {}, Column Type: {}, Column Precision: {} (Default value), Column_Filter: {}"
        .format(column_2.column_name,column_2.column_type,column_2.column_precision,column_2.column_filter))
    print("Column Name: {}, Column Type: {}, Column Precision: {}, Column_Filter: {}"
        .format(column_3.column_name,column_3.column_type,column_3.column_precision,column_3.column_filter))
    print("Column Name: {}, Column Type: {}, Column Precision: {}, Column_Filter: {}"
        .format(column_4.column_name,column_4.column_type,column_4.column_precision,column_4.column_filter))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCheck",text="Check",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ButtonCheck",callfunc=on_button_check)

if __name__=='__main__':
    main()
