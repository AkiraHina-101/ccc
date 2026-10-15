# Create Table

Create Table

🎯 Introduction​

In this tutorial, you'll learn how to create a table and use its own built-in functions.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",rows=6,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",
        menus=["clear","cut","copy",
                "paste","insert row",
                "delete row","from file","to file"],
        width=350,height=250,
        show_grid_line=False,show_row_number=True,show_col_header=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
