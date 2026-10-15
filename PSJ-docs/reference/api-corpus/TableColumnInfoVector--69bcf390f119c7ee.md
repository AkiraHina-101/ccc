# TableColumnInfoVector

TableColumnInfoVector

Description​

An instance of a TableColumnInfoVector class or List of TableColumnInfo specifying the methods of columns.

Input​

To create a TableColumnInfoVector object, defines a variable with TableColumnInfoVector()

Methods​

 | Method | Description

 | append() | Adds an element to the end of list

 | clear() | Removes all the elements from the list and make it empty

 | size() | Returns size of list

 | extend() | Adds all the elements of the specified vector to the end of the list

Sample Code​

from pyjdg import *

def on_right_click_menu(dlg,name,menu):
    JPT.ClearLog()
    #To create an instance of TableColumnInfoVector
    col_vector = TableColumnInfoVector()
    col_vector_2 = TableColumnInfoVector()
    col_1 = TableColumnInfo(name="Heading1",type="String")
    #Methods
    if menu == "Append":
        print("Size of TableColumnInfoVector before Append():", col_vector.size()) #Size: 0
        col_vector.append(col_1)
        print("Size of TableColumnInfoVector after Append():",col_vector.size()) #Size: 1
    elif menu == "Extend":
        col_vector.append(col_1)
        col_vector_2.append(TableColumnInfo(name="Heading2",type="Integer"))
        print("Size of TableColumnInfoVector before Extend():", col_vector.size()) #Size: 1
        col_vector.extend(col_vector_2)
        print("Size of TableColumnInfoVector after Extend():", col_vector.size()) #Size: 2
    elif menu == "Clear":
        col_vector.append(col_1)
        col_vector_2.append(TableColumnInfo(name="Heading2",type="Integer"))
        col_vector.extend(col_vector_2)
        print("Size of TableColumnInfoVector before Clear():", col_vector.size()) #Size: 2
        col_vector.clear()
        print("Size of TableColumnInfoVector after Clear():", col_vector.size()) #Size: 0

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
