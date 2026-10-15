# TableCellVector

TableCellVector

Description​

An instance of a TableCellVector class or List of TableCellID specifying the methods of cells.

Input​

To create a TableCellVector object, defines a variable with TableCellVector().

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
    #To create an instance of TableCellVector
    cell_vector = TableCellVector()
    cell_vector_2 = TableCellVector()
    cell_1 = TableCellID(row=1,col=2)
    #Methods
    if menu == "Append":
        print("Size of TableCellVector before Append():", cell_vector.size()) #Size: 0
        cell_vector.append(cell_1)
        print("Size of TableCellVector after Append():",cell_vector.size()) #Size: 1
    elif menu == "Extend":
        cell_vector.append(cell_1)
        cell_vector_2.append(TableCellID(row=3,col=3))
        print("Size of TableCellVector before Extend():", cell_vector.size()) #Size: 1
        cell_vector.extend(cell_vector_2)
        print("Size of TableCellVector after Extend():", cell_vector.size()) #Size: 2
    elif menu == "Clear":
        cell_vector.append(cell_1)
        cell_vector_2.append(TableCellID(row=3,col=3))
        cell_vector.extend(cell_vector_2)
        print("Size of TableCellVector before Clear():", cell_vector.size()) #Size: 2
        cell_vector.clear()
        print("Size of TableCellVector after Clear():", cell_vector.size()) #Size: 0

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
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
