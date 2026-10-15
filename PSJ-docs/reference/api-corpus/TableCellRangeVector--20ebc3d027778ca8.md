# TableCellRangeVector

TableCellRangeVector

Description​

An instance of a TableCellRangeVector class or List of TableCellRange specifying the methods of cell ranges.

Input​

To create a TableCellRangeVector object, defines a variable with TableCellRangeVector().

Methods​

 | Method | Description

 | append() | Adds an element to the end of list.

 | clear() | Removes all the elements from the list and make it empty.

 | size() | Returns size of list.

 | extend() | Adds all the elements of the specified vector to the end of the list.

Sample Code​

from pyjdg import *

def on_right_click_menu(dlg,name,menu):
    JPT.ClearLog()
    #To create an instance of TableCellRangeVector
    range_vector = TableCellRangeVector()
    range_vector_2 = TableCellRangeVector()
    range_1 = TableCellRange(left=1,top=2,right=3,bottom=4)
    #Methods
    if menu == "Append":
        print("Size of TableCellRangeVector before Append():", range_vector.size()) #Size: 0
        range_vector.append(range_1)
        print("Size of TableCellRangeVector after Append():",range_vector.size()) #Size: 1
    elif menu == "Extend":
        range_vector.append(range_1)
        range_vector_2.append(TableCellRange(left=1,top=3,right=4,bottom=5))
        print("Size of TableCellRangeVector before Extend():", range_vector.size()) #Size: 1
        range_vector.extend(range_vector_2)
        print("Size of TableCellRangeVector after Extend():", range_vector.size()) #Size: 2
    elif menu == "Clear":
        range_vector.append(range_1)
        range_vector_2.append(TableCellRange(left=1,top=3,right=4,bottom=5))
        range_vector.extend(range_vector_2)
        print("Size of TableCellRangeVector before Clear():", range_vector.size()) #Size: 2
        range_vector.clear()
        print("Size of TableCellRangeVector after Clear():", range_vector.size()) #Size: 0

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=10,
        columns=["Heading1","Heading2","Heading3","Heading4","Heading5","Heading6"],
        layout="Window",width=700,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",
        menus=["Append","Extend","Clear"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_right_click_menu)

if __name__=='__main__':
    main()
