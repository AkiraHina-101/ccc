# dlg.clear_table_cell()

dlg.clear_table_cell()

説明​

テーブルの特定のセルの内容をクリアします。

構文​

dlg.clear_table_cell(...)

入力​

name​

テーブルの名前を指定する String です。

これは必須の入力です。

row​

セルの水平方向の位置を指定する Integer です（0から開始）。

これは必須の入力です。

col​

セルの垂直方向の位置を指定する Integer です（0から開始）。

これは必須の入力です。

text​

クリアされたセルの新しい内容を指定する String です（必要な場合）。

デフォルト値は[]です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

# 特定のセルを右クリックしてクリア
# 特定のセルの内容がクリアされます
# 入力された場合、テキスト変更のデータがクリアされたセルの新しい内容になります
def set_table_read_from_file(dlg,name,menu):
    table_cell = dlg.get_table_sel_cell(name)
    if table_cell.size()>0:
        text_change=dlg.get_item_text(name="Textbox4")
        if menu == "Clear Cell":
            dlg.clear_table_cell(name,
                row=table_cell[0].row_number,
                col=table_cell[0].col_number,
                text=text_change)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Text Change",layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",
        col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",
        col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",
        col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")  
    dlg.add_table_right_menu(name="Table1",
        menus=["Clear Cell"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=set_table_read_from_file)
    dlg.set_table_cell_checkbox(name="Table1",row=0,col=0,text="Checkbox",
        checked=True)
    dlg.set_cell_value(name="Table1",
        row=1,col=0,value=["Option2","Option3"])
    dlg.set_cell_value(name="Table1",row=0,col=1,value="1")
    dlg.set_cell_value(name="Table1",row=1,col=1,value=[2,3])
    dlg.set_table_cell_button(name="Table1",row=0,col=2,text="Button")
    dlg.set_cell_value(name="Table1",row=1,col=2,value=[2.5,3.5]) 

if __name__=='__main__':
    main()
