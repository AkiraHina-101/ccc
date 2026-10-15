# dlg.set_groupbox_checked()

dlg.set_groupbox_checked()

説明​

GroupBoxのチェックボックスの初期状態を有効/無効に設定します。

構文​

dlg.set_groupbox_checked(...)

入力​

name​

GroupBoxの名前を指定する String 。

チェックボックスの状態を設定するために使用されます。

この入力は必須です。

checked​

GroupBoxのチェックボックスの状態を指定する Boolean 型：

True: チェックボックスを有効にし、チェックが付いている状態にします（内部のすべてのコンポーネントが使用可能）。

False: チェックボックスを有効にし、チェックが外れている状態にします（内部のすべてのコンポーネントが使用不可）。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.set_groupbox_checked(name="GroupBox1",checked=True)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="GroupBox1")
    dlg.add_label(name="Label3",text="Label",layout="Layout2")
    dlg.add_textbox(name="TextBox4",layout="Layout2")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
