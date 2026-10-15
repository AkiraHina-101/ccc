# dlg.on_table_sel_changed()

dlg.on_table_sel_changed()

説明​

セルを選択したときのイベントを設定します。

構文​

dlg.on_table_sel_changed(...)

入力​

name​

テーブルの名前を指定する String です。

これは必須の入力です。

callfunc​

バインドされる関数の名前です。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_sel_change(dlg,name,cell):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if cellvector.size() > 0:
       print("セルの位置（行） = "+str(cellvector[0].row_number))
       print("セルの位置（列） = "+str(cellvector[0].col_number))
       print("---------------------------")

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
    dlg.add_table_right_menu(name="Table1",menus=["セル情報を確認"])
    dlg.generate_window()
    dlg.on_table_sel_changed(name="Table1",callfunc=on_sel_change)

if __name__=='__main__':
    main()
