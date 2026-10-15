# dlg.set_table_cell_alignment()

dlg.set_table_cell_alignment()

Description​

Set text alignment of cell.

Syntax​

dlg.set_table_cell_alignment(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

row​

An Integer specifying the order of row (starts from 0).

This is a required input.

col​

An Integer specifying the order of column (starts from 0).

This is a required input.

alignment​

A String specifying alignment position of content inside a cell.

"Left": Align content to the left

"Center": Center the content

"Right": Align content to the right

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_click_set_alignment(dlg):
    dlg.set_table_cell_alignment(name="Table1",row=0,col=0,
        alignment="Left")
    dlg.set_table_cell_alignment(name="Table1",row=1,col=0,
        alignment="Center")
    dlg.set_table_cell_alignment(name="Table1",row=2,col=0,
        alignment="Right")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=360,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonSetAlignment",width=70,height=30,
        text="Set Alignment",layout="footer")
    dlg.add_button(name="Ok",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_table_column_width(name="Table1",col=0,width=200)
    dlg.set_cell_value(name="Table1",row=0,col=0,
        value="Left Alignment")
    dlg.set_cell_value(name="Table1",row=1,col=0,
        value="Center Alignment")
    dlg.set_cell_value(name="Table1",row=2,col=0,
        value="Right Alignment")
    dlg.on_command(name="ButtonSetAlignment",callfunc=on_click_set_alignment)

if __name__=='__main__':
    main()
