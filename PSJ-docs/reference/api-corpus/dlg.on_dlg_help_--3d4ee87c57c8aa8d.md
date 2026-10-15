# dlg.on_dlg_help()

dlg.on_dlg_help()

説明​

ヘルプボタンがクリックされたときに作成した関数を実行します。

構文​

dlg.on_dlg_help(...)

入力​

callfunc​

バインドしたい関数の名前です。

これは必須入力です。

戻り値​

この機能には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_Help_clicked(dlg):
    print("ヘルプボタンがクリックされました")

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True,include_apply=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="ヘルプボタンをクリックしてください！",layout="Layout1")
    dlg.generate_window()
    dlg.on_dlg_help(callfunc=on_button_Help_clicked)

if __name__=='__main__':
    main()
