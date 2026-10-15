# dlg.enable_table_column_filter()

dlg.enable_table_column_filter()

Description​

Add filter option of column of Table.

Syntax​

dlg.enable_table_column_filter(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

col​

An Integer specifying the order of the column (starts from 0).

This is a required input.

enable​

A Boolean specifying the state of filter mode of column of Table.

True: filter mode will be shown

False: filter mode will be hidden

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.enable_table_column_filter(name="Table2",col=0,enable=True)
    dlg.generate_window()

if __name__=='__main__':
    main()
