# Insert/Delete row and column of table

Insert/Delete row and column of table

🎯 Introduction​

In this tutorial, you'll learn how to add/remove cells of table:

Insert Row: Insert rows into table.

Insert Column: Insert column into table.

Delete Row: Delete row of table.

Delete Column: Delete row of table.

Insert Row

Insert Column

Delete Row

Delete Column

Please input value of inserting row(s) to the textbox before clicking 'Insert Row' button.

Please input value of inserting column(s) and column header name to the textbox before clicking 'Insert Column' button.

📖 Tutorial​

Insert Row

Insert Column

Delete Row

Delete Column

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_click_insert_row(dlg):
    num_row=int(dlg.get_item_text(name="Row"))
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    position=int(dlg.get_total_row(name="Table1"))
    if sel_ranges.size()>0:
        if sel_ranges[0].top == 0:
            position=sel_ranges[0].top
            dlg.insert_table_rows(name="Table1",
                row_num=num_row,position=position)
        elif sel_ranges[0].top > 0:
            position=sel_ranges[0].top
            dlg.insert_table_rows(name="Table1",
                row_num=num_row,position=position)
    else:
        dlg.insert_table_rows(name="Table1",row_num=num_row)
def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Insert Rows",layout="Window")
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,
        layout="GroupBox1")
    dlg.add_label(name="Label1",text="Number of Rows",layout="Layout2")
    dlg.add_textbox(name="Row",layout="Layout2")
    dlg.add_button(name="InsertRow",text="Insert Row",
        width=100,height=22,layout="GroupBox1")
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    for i in range(5):
        for j in range(3):
            dlg.set_cell_value(name="Table1",row=i,col=j,value=str(i+j))
    dlg.on_button_clicked(name="InsertRow",callfunc=on_click_insert_row)

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_click_insert_col(dlg):
    num_col=int(dlg.get_item_text(name="Col"))
    col_header_name=dlg.get_item_text(name="ColHeader")
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    header_vector=TableColumnInfoVector()
    for i in range(num_col):
        if sel_ranges.size()>0:
            position=sel_ranges[0].left+i
            header_vector.add(
                TableColumnInfo(name=col_header_name+"{}".format(i+1),
                type="Double",precision=2))
            dlg.insert_table_columns(name="Table1",
                columns=header_vector,position=position)
            header_vector.clear()
        else:
            position=int(dlg.get_total_column(name="Table1"))
            header_vector.add(
            TableColumnInfo(name=col_header_name+"{}".format(i+1),
                type="Double",precision=2))
            dlg.insert_table_columns(name="Table1",
                columns=header_vector,position=position)
            header_vector.clear()
def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Insert Columns",layout="Window")
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,
        layout="GroupBox1")
    dlg.add_label(name="Label1",text="Number of Col",width=120,layout="Layout1")
    dlg.add_textbox(name="Col",layout="Layout1")
    dlg.add_layout(name="Layout9",orientation=orientation.horizontal,
        layout="GroupBox1")
    dlg.add_label(name="Col_header",text="Column header name",
        width=120,layout="Layout9")
    dlg.add_textbox(name="ColHeader",layout="Layout9")
    dlg.add_button(name="InsertCol",text="Insert Column",
        width=100,height=22,layout="GroupBox1")
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=600,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    for i in range(5):
        for j in range(3):
            dlg.set_cell_value(name="Table1",row=i,col=j,value=str(i+j))
    dlg.on_button_clicked(name="InsertCol",callfunc=on_click_insert_col)

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_menu(dlg,name,menu):
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    position=int(dlg.get_total_row(name="Table1"))-1
    if sel_ranges.size()>0:
        position=sel_ranges[0].top
    dlg.delete_table_row(name="Table1",position=position)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",menus=["Delete Row"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def on_menu(dlg,name,menu):
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    position=int(dlg.get_total_column(name="Table1"))-1
    if sel_ranges.size()>0:
        position=sel_ranges[0].left
    dlg.delete_table_column(name="Table1",position=position)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",menus=["Delete Column"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
