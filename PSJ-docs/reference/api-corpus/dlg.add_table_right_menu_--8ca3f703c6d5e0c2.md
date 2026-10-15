# dlg.add_table_right_menu()

dlg.add_table_right_menu()

説明​

テーブルのコンテキストメニュー（右クリックイベント）にオプションを追加します。

構文​

dlg.add_table_right_menu(...)

入力​

name​

テーブルの名前を指定する String 。

この入力は必須です。

menus​

テーブル上で右クリックボタンイベントを実行した後に表示されるメニューを指定する String のリスト。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

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
        menus=["セルの色を設定",
            "テキストの色を設定",
            "列の幅を設定",
            "カスタムメニュー"])
    dlg.generate_window()

if __name__=='__main__':
    main()
