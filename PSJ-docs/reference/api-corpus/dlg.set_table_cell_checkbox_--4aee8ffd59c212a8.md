# dlg.set_table_cell_checkbox()

dlg.set_table_cell_checkbox()

Description​

Set checkbox cell in the Table.

Syntax​

dlg.set_table_cell_checkbox(...)

Inputs​

name​

A String specifying the name of the Table component.

This is a required input.

row​

An Integer specifying the order of row (starts from 0).

This is a required input.

col​

An Integer specifying the order of column (starts from 0).

This is a required input.

text​

A String specifying text which will be displayed next to the checkbox.

This is a required input.

checked​

A Boolean specifying the state of checkbox.
True: the checkbox is checked.

False: the checkbox is unchecked.

The default value is False.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",width=260,height=260,
        columns=["Heading1","Heading2"],
        rows=5,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",
        layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_table_cell_checkbox(name="Table2",row=0,
        col=0,text="Checkbox",checked=True)

if __name__=='__main__':
    main()
