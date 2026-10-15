# TableCellRange

TableCellRange

Description​

An instance of a TableCellRange class, represents attributes of a target range (multi cells) inside table.

Input​

To create a TableCellRange object, defines a variable with TableCellRange(...).

left​

An Integer specifying left position of range (starts from 0).

The default value is -1.

top​

An Integer specifying top position of range (starts from 0).

The default value is -1.

right​

An Integer specifying right position of range (starts from 0).

The default value is -1.

bottom​

An Integer specifying bottom position of range (starts from 0).

The default value is -1.

Attributes​

Get attributes of TableCellRange.

left​

An Integer specifying left position of specified range.

The default value is -1.

top​

An Integer specifying top position of specified range.

The default value is -1.

right​

An Integer specifying right position of specified range.

The default value is -1.

bottom​

An Integer specifying bottom position of specified range.

The default value is -1.

Remarks​

Index number of left, top, right and bottom of TableCellRange can not be out of range of the existing table when creating object.

Sample Code​

from pyjdg import *

def on_button_check(dlg):
    #To create an instance of TableCellRange
    range_1 = TableCellRange()
    range_2 = TableCellRange(left=1,top=2,right=3,bottom=4)
    #To check attributes of object
    print("Default Range has position: Left={}, Top={}, Right={}, Bottom={}"
        .format(range_1.left, range_1.top, range_1.right, range_1.bottom))
    print("Specified Range has position: Left={}, Top={}, Right={}, Bottom={}"
        .format(range_2.left, range_2.top, range_2.right, range_2.bottom))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=10,
        columns=["Heading1","Heading2","Heading3","Heading4"],
        layout="Window",width=420,height=260)
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
