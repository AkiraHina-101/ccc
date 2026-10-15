# Get/Set a value of cell in Table

Get/Set a value of cell in Table

🎯 Introduction​

In this tutorial, you'll learn how to get and set a value of cell in Table:

Get Value: Get a value of specific cell in the Table.

Set Value: Set the value to a specific cell in the Table.

Get Value

Set Value

📖 Tutorial​

Get Value

Set Value

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def get_table_cell_value(dlg,name,cell):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if cellvector.size()>0:
        if dlg.is_table_cell_combobox(name="Table1",
                cell=cellvector[0]) == False:
            value_cell=dlg.get_cell_value(name="Table1",
                cell_row_id=cellvector[0].row_number,
                cell_column_id=cellvector[0].col_number)
            dlg.set_item_text(name="Textbox4",text=value_cell)
            dlg.set_item_text(name="Textbox5",text="")
            dlg.set_item_text(name="Textbox6",text="")

def get_table_cell_value_2(dlg,name,cell):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if cellvector.size()>0:
        if dlg.is_table_cell_combobox(name="Table1",
                cell=cellvector[0]) == True:
            value_cell=dlg.get_cell_value(name="Table1",
                cell_row_id=cellvector[0].row_number,
                cell_column_id=cellvector[0].col_number)
            dlg.set_item_text(name="Textbox4",text=value_cell)
            value_cell=dlg.get_cell_value(name="Table1",
                cell_row_id=cellvector[0].row_number,
                cell_column_id=cellvector[0].col_number,option=1)
            dlg.set_item_text(name="Textbox5",text=value_cell)
            value_cell=dlg.get_cell_value(name="Table1",
                cell_row_id=cellvector[0].row_number,
                cell_column_id=cellvector[0].col_number,option=2)
            dlg.set_item_text(name="Textbox6",text=value_cell)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Get Displayed Value",width=100,layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_layout(name="Layout2",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label4",text="Get Value option=1",width=100,layout="Layout2")
    dlg.add_textbox(name="Textbox5",layout="Layout2")
    dlg.add_layout(name="Layout3",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label5",text="Get Value option=2",width=100,layout="Layout3")
    dlg.add_textbox(name="Textbox6",layout="Layout3")
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_cell_value(name="Table1",
        cell_row_id=1,cell_column_id=0,value=["Jupiter","TSV-Pre","SunShine"])
    dlg.on_table_sel_changed(name="Table1",callfunc=get_table_cell_value)
    dlg.on_table_button_clicked(name="Table1",callfunc=get_table_cell_value_2)
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=0,value="TechnoStar")

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def set_table_cell_value(dlg):
    cell_value=dlg.get_item_text(name="Textbox4")
    row = int(dlg.get_item_text(name="Textbox5"))
    col = int(dlg.get_item_text(name="Textbox6"))
    dlg.set_cell_value(name="Table1",cell_row_id=row,cell_column_id=col,value=cell_value)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Set Value",layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_layout(name="Layout2",
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label4",text="Row",layout="Layout2",width=61)
    dlg.add_textbox(name="Textbox5",layout="Layout2")
    dlg.add_label(name="Label5",text="Column",layout="Layout2",width=61)
    dlg.add_textbox(name="Textbox6",layout="Layout2")
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=360,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_item_text(name="Textbox4",text="TechnoStar")
    dlg.set_item_text(name="Textbox5",text="0")
    dlg.set_item_text(name="Textbox6",text="0")
    dlg.on_button_clicked(name="ButtonApply",callfunc=set_table_cell_value)

if __name__=='__main__':
    main()
