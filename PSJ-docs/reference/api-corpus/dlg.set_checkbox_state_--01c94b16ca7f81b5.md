# dlg.set_checkbox_state()

dlg.set_checkbox_state()

説明​

CheckBoxの状態をチェック済みまたは未チェックに設定します。

構文​

dlg.set_checkbox_state(...)

入力​

name​

コンポーネントの名前を指定する String の入力です。状態をチェック/未チェックに設定するために使用されます。

この入力は必須です。

checked​

CheckBoxの状態を指定する Boolean 型の入力です:

True: CheckBoxコンポーネントの初期状態がチェックされています。

False: CheckBoxコンポーネントの初期状態がチェックされていません。

この入力は必須です。

戻り値​

この関数には出力値はありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,100,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_checkbox(name="CheckBox2",text="Jupiter",checked=True,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_checkbox_state(name="CheckBox2",checked=False)
    isChecked = dlg.isbutton_checked(name="CheckBox2")
    print(isChecked)

if __name__=='__main__':
    main()
