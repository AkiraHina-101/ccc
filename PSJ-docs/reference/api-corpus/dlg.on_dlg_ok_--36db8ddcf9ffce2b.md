# dlg.on_dlg_ok()

dlg.on_dlg_ok()

説明​

OKボタンがクリックされたときに作成した関数を実行します。

構文​

dlg.on_dlg_ok(...)

入力​

callfunc​

バインドされたい関数の名前です。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_OK_clicked(dlg):
    print("OKボタンがクリックされました")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True,include_apply=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="OKボタンをクリックしてください！",layout="Layout1")
    dlg.generate_window()
    dlg.on_dlg_ok(callfunc=on_button_OK_clicked)

if __name__=='__main__':
    main()
