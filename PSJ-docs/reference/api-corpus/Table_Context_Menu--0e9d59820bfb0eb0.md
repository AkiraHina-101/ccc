# Table Context Menu

Table Context Menu

🎯 Introduction​

In this tutorial, you'll learn how a table support context Menu functions and how to trigger event on them:

Add Context Menu: Add context Menu functions.

Event of context Menu: Trigger an event on context Menu functions.

Add Context Menu

Event of context Menu

📖 Tutorial​

Add Context Menu

Event of context Menu

# Encoding for Japanese
# coding: cp932

from pyjdg import *

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
        menus=["Set Cell Color",
            "Set Text Color",
            "Set Column Width",
            "Custom Menu"])
    dlg.generate_window()

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_menu(dlg,name,menu):
    print("Table name: "+ name)
    print("Clicked menu: "+ menu)
    cellvector = dlg.get_table_sel_cell(name="Table1")
    if menu == "Set Column Width":
        dlg.set_table_column_width(name="Table1",
        col=cellvector[0].col_number)
    elif menu == "Set Text Color":
        dlg.set_table_cell_text_color(name="Table1",
        cell=cellvector[0])
    elif menu == "Set Cell Color":
        dlg.set_table_cell_fill_color(name="Table1")
    elif menu == "Custom Menu":
        print("You can put your function here")

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
        menus=["Set Cell Color","Set Text Color",
        "Set Column Width","Custom Menu"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
