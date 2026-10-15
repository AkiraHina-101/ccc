# dlg.on_dlg_cancel()

dlg.on_dlg_cancel()

説明​

[Cancel] ボタンがクリックされた時に作成された関数を実行します。

構文​

dlg.on_dlg_cancel(...)

入力​

callfunc​

バインドしたい関数の名前です。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_Cancel_clicked(dlg):
    print("Cancelボタンがクリックされました")

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True,include_apply=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Cancelボタンをクリックしてください！",layout="Layout1")
    dlg.generate_window()
    dlg.on_dlg_cancel(callfunc=on_button_Cancel_clicked)

if __name__=='__main__':
    main()
