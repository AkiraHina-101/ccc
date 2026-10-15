# Select cell/range event

Select cell/range event

🎯 Introduction​

In this tutorial, you'll learn how to get event when selecting Cell/Range:

Get Cell: Get the event when select a Cell in Table.

Get Range: Get the event when select a Range in Table.

Get Cell Event

Get Range Event

📖 Tutorial​

Get Cell Event

Get Range Event

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_context_click(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    for i in range(cellvector.size()):
        print("The cell number {} has information".format(i+1))
        print("Cell's position (row) = "+str(cellvector[0].row_number))
        print("Cell's position (column) = "+str(cellvector[0].col_number))
        print("---------------------------")

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
    dlg.add_table_right_menu(name="Table1",menus=["Check cell info"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_context_click)

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_context_click(dlg,name,menu):
    rangevector=dlg.get_table_sel_range(name="Table1")
    for i in range(rangevector.size()):
        print("The range number {} has information".format(i+1))
        print("Range's position (left) = "+str(rangevector[0].left))
        print("Range's position (top) = "+str(rangevector[0].top))
        print("Range's position (right) = "+str(rangevector[0].right))
        print("Range's position (bottom) = "+str(rangevector[0].bottom))
        print("---------------------------")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=16,
        columns=["Heading1","Heading2","Heading3","Heading4","Heading5"],
        layout="Window",width=550,height=300)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",menus=["Check cell info"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_context_click)

if __name__=='__main__':
    main()
