# dlg.isbutton_checked()

dlg.isbutton_checked()

説明​

入力されたコンポーネントの状態（選択されているかどうか）を確認します。
現在、チェックボックスとラジオボタンコンポーネントをサポートしています。

構文​

dlg.isbutton_checked(...)

入力​

name​

選択状態を確認するために使用するコンポーネントの名前を指定する String です。

この入力は必須です。

戻り値​

入力されたコンポーネントの状態を指定する Boolean です。:

True: 入力されたコンポーネントはチェックされています（選択されています）。

False: 入力されたコンポーネントはチェックされていません（選択されていません）。

サンプルコード​

from pyjdg import *

def check_status(dlg):
    isChecked = dlg.isbutton_checked(name="CheckBox2")
    print(isChecked)

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
    dlg.on_command(name="CheckBox2",callfunc=check_status)

if __name__=='__main__':
    main()
