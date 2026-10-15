# dlg.get_cell_label()

dlg.get_cell_label()

Description​

Get label of a button cell, checkbox cell or combobox cell in the Table.

Syntax​

dlg.get_cell_label(...)

Inputs​

name​

A String specifying the name of the Table component.

This is a required input.

row​

An Integer specifying the position in the horizontal direction of the cell (starts from 0).

This is a required input.

column​

An Integer specifying the position in the vertical direction of the cell (starts from 0).

This is a required input.

Return Code​

A String specifying the label of the inputted cell.

Sample Code​

from pyjdg import *

def on_cell_button_clicked(dlg,name,cell):
    JPT.ClearLog()
    cellvector=dlg.get_table_sel_cell(name="Table2")
    if cellvector.size() > 0:
        if dlg.is_table_cell_combobox(name="Table2",cell=cellvector[0]):
            combobox_label= dlg.get_cell_label(name="Table2",
                row=cellvector[0].row_number,col=cellvector[0].col_number)
            print("The label of the selected combobox is: " + combobox_label)
        elif dlg.is_table_cell_button(name="Table2",cell=cellvector[0]):
            button_label= dlg.get_cell_label(name="Table2",
                row=cellvector[0].row_number,col=cellvector[0].col_number)
            print("The label of the selected button is: " + button_label)
        elif dlg.is_table_cell_checkbox(name="Table2",cell=cellvector[0]):
            checkbox_label= dlg.get_cell_label(name="Table2",
                row=cellvector[0].row_number,col=cellvector[0].col_number)
            print("The label of the selected checkbox is: " + checkbox_label)
        else:
            print("Selected cell do not have label")

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
    dlg.set_cell_value(name="Table2",
        row=0,col=0,
        value=["Option1","Option2","Option3"])
    dlg.set_table_cell_button(name="Table2",
        row=0,col=1,text="Button")
    dlg.set_table_cell_checkbox(name="Table2",row=1,
        col=0,text="Checkbox",checked=True)
    dlg.on_table_sel_changed(name="Table2",
        callfunc=on_cell_button_clicked)

if __name__=='__main__':
    main()
