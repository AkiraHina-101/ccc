# dlg.get_table_sel_range()

dlg.get_table_sel_range()

説明​

選択された範囲（複数のセル）の情報と属性を取得します。

構文​

dlg.get_table_sel_range(...)

入力​

name​

テーブルの名前を指定する String です。

これは必須の入力です。

戻り値​

TableCellRangeVector オブジェクトもしくは範囲のメソッドを指定する TableCellRange のリストです。

サンプルコード​

from pyjdg import *

def on_context_click(dlg,name,menu):
    rangevector=dlg.get_table_sel_range(name="Table1")
    for i in range(rangevector.size()):
        print("範囲番号 {} の情報を取得".format(i+1))
        print("範囲の位置（左） = "+str(rangevector[0].left))
        print("範囲の位置（上） = "+str(rangevector[0].top))
        print("範囲の位置（右） = "+str(rangevector[0].right))
        print("範囲の位置（下） = "+str(rangevector[0].bottom))
        print("---------------------------")

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=16,
        columns=["見出し1","見出し2","見出し3","見出し4","見出し5"],
        layout="Window",width=550,height=300)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",menus=["セル情報を確認"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_context_click)

if __name__=='__main__':
    main()
