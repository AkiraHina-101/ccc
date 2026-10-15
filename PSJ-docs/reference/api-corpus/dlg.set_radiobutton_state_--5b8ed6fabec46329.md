# dlg.set_radiobutton_state()

dlg.set_radiobutton_state()

説明​

ラジオボタンの状態を選択または非選択に設定します。

構文​

dlg.set_radiobutton_state(...)

入力​

name​

_String_型で、状態を選択または非選択に設定するコンポーネントの名前を指定します。

この入力は必須です。

checked​

_Boolean_型で、チェックボックスの状態を指定します:

True: チェックボックスコンポーネントの初期状態は選択されています。

False: チェックボックスコンポーネントの初期状態は非選択です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,100,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_radiobutton(name="RadioButton2",text="Jupiter",checked=True,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_radiobutton_state(name="RadioButton2",checked=False)
    isChecked = dlg.isbutton_checked(name="RadioButton2")
    print(isChecked)

if __name__=='__main__':
    main()
