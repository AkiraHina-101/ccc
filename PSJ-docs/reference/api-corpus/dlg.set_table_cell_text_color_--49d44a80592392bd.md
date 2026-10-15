# dlg.set_table_cell_text_color()

dlg.set_table_cell_text_color()

Description​

Set color to text in the selected/specified cells.

Syntax​

dlg.set_table_cell_text_color(...)

Inputs​

name​

A String specifying the name of Table.

This is a required input.

cell​

A TableCellID object specifying the location of cell in Table.

If not specified, all the selected cells will be used.

color​

An Integer specifying the color.

If not specified, a color picker dialog is opened for user to select.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_menu(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name)
    if menu=="Set Text Color for all selected cells using color picker":
        dlg.set_table_cell_text_color(name="Table1")
    elif menu=="Set Text Color only for a selected cell using color picker":
         dlg.set_table_cell_text_color(name="Table1",
            cell=cellvector[0])
    elif menu=="Set Text Color only for a selected cell with red color":
        dlg.set_table_cell_text_color(name="Table1",
            cell=cellvector[0],color=7105764)
    elif menu=="Set Text Color only for the first cell with red color":
        dlg.set_table_cell_text_color(name="Table1",
            cell=TableCellID(row=0,col=0),color=7105764)
    elif menu=="Set Text Color only for the first 2x2 cells with red color":
        [[dlg.set_table_cell_text_color(name="Table1",
            cell=TableCellID(row=i,col=j),color=7105764)
            for i in (0,1)] for j in (0,1)]

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
        menus=["Set Text Color for all selected cells using color picker",
        "Set Text Color only for a selected cell using color picker",
        "Set Text Color only for a selected cell with red color",
        "Set Text Color only for the first cell with red color",
        "Set Text Color only for the first 2x2 cells with red color"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
