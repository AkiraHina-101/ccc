# dlg.insert_table_columns()

dlg.insert_table_columns()

説明​

テーブル内の特定の位置に列を挿入します。

構文​

dlg.insert_table_columns(...)

入力​

name​

テーブルの名前を指定する String です。

この入力は必須です。

columns​

列の方法を指定する TableColumnInfoVector オブジェクトまたは TableColumnInfo のリストです。

この入力は必須です。

position​

挿入する行の位置を指定する Integer です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_click_insert_col(dlg):
    num_col=int(dlg.get_item_text(name="Col"))
    col_header_name=dlg.get_item_text(name="ColHeader")
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    header_vector=TableColumnInfoVector()
    for i in range(num_col):
        if sel_ranges.size()>0:
            position=sel_ranges[0].left+i
            header_vector.append(
                TableColumnInfo(name=col_header_name+"{}".format(i+1),
                type="Double",precision=2))
            dlg.insert_table_columns(name="Table1",
                columns=header_vector,position=position)
            header_vector.clear()
        else:
            position=int(dlg.get_total_column(name="Table1"))
            header_vector.append(
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
    dlg.on_command(name="InsertCol",callfunc=on_click_insert_col)

if __name__=='__main__':
    main()
