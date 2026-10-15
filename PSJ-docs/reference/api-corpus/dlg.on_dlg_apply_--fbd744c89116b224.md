# dlg.on_dlg_apply()

dlg.on_dlg_apply()

説明​

Apply ボタンがクリックされたときに作成された関数を実行します。

構文​

dlg.on_dlg_apply(...)

入力​

callfunc​

バインドされる関数の名前です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_Apply_clicked(dlg):
    print("Applyボタンがクリックされました")

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True,include_apply=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Applyボタンをクリックしてください！",layout="Layout1")
    dlg.generate_window()
    dlg.on_dlg_apply(callfunc=on_button_Apply_clicked)

if __name__=='__main__':
    main()
