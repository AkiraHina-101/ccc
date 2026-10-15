# dlg.on_table_right_menu()

dlg.on_table_right_menu()

説明​

コンテキストメニューを開く／実行する際にイベントを設定します。

構文​

dlg.on_table_right_menu(...)

入力​

name​

テーブルの名前を指定する String です。

この入力は必須です。

callfunc​

バウンドしたい関数の名前です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_menu(dlg,name,menu):
    print("テーブルの名前: "+ name)
    print("クリックされたメニュー: "+ menu)
    table_cell = dlg.get_table_sel_cell(name)
    if menu == "Set Column Width":
        dlg.set_table_column_width(name,table_cell[0].col_number)
    elif menu == "Set Text Color":
        dlg.set_table_cell_text_color(name,table_cell[0])
    elif menu == "Set Cell Color":
        dlg.set_table_cell_fill_color(name)
    elif menu == "Custom Menu":
        print("ここに関数を入れることができます")

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
        menus=["Set Cell Color","Set Text Color",
        "Set Column Width","Custom Menu"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
