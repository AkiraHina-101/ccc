# Set cell value alignment

Set cell value alignment

🎯 Introduction​

In this tutorial, you'll learn how to control the alignment of value of cell:

Create a new table.

Set the alignment of value to be left/right/center of cell.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

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
    dlg.on_button_clicked(name="ButtonSetAlignment",
        callfunc=on_click_set_alignment)

if __name__=='__main__':
    main()
