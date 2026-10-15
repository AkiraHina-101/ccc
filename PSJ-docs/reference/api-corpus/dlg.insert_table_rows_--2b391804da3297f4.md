# dlg.insert_table_rows()

dlg.insert_table_rows()

説明​

テーブル内の特定位置に1つ以上の行を挿入します。

構文​

dlg.insert_table_rows(...)

入力​

name​

テーブルの名前を指定する String です。

この入力は必須です。

row_num​

挿入する行の数を示す Integer です。

この入力は必須です。

position​

挿入する行の位置を指定する Integer です。

指定した場合、入力した位置の前に行が挿入されます（位置-1）。

指定しなかった場合、行はテーブルの最後に挿入されます。

これはデフォルトの入力です。

戻り値​

この機能には出力値がありません。

サンプルコード​

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
    dlg.add_groupbox(name="GroupBox1",text="行の挿入",layout="Window")
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,
        layout="GroupBox1")
    dlg.add_label(name="Label1",text="行数",layout="Layout2")
    dlg.add_textbox(name="Row",layout="Layout2")
    dlg.add_button(name="InsertRow",text="行を挿入",
        width=100,height=22,layout="GroupBox1")
    dlg.add_table(name="Table1",rows=5,
        columns=["見出し1","見出し2","見出し3"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    for i in range(5):
        for j in range(3):
            dlg.set_cell_value(name="Table1",row=i,col=j,value=str(i+j))
    dlg.on_command(name="InsertRow",callfunc=on_click_insert_row)
if __name__=='__main__':
    main()
