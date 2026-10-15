# dlg.set_groupbox_collapsed()

dlg.set_groupbox_collapsed()

説明​

グループボックスの折りたたみ機能の初期状態を表示/非表示に設定します。

構文​

dlg.set_groupbox_collapsed(...)

入力​

name​

グループボックスの名前を指定する String です。これは折りたたみ機能の状態を設定するために使用されます。

この入力は必須です。

collapsed​

グループボックスの折りたたみ機能の状態を指定する Boolean 型です：

True: その状態が折りたたまれている場合（全てのグループボックスのコンポーネントが非表示）に折りたたみを有効にします。

False: その状態が展開されている場合（全てのグループボックスのコンポーネントが表示）に折りたたみを有効にします。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.set_groupbox_collapsed(name="GroupBox1",collapsed=True)
    dlg.set_groupbox_orientation(name="GroupBox1",orientation="horizontal")
    dlg.add_label(name="Label2",text="Label",layout="GroupBox1")
    dlg.add_textbox(name="TextBox3",layout="GroupBox1")
    dlg.add_label(name="Label4",text="Label",layout="GroupBox1")
    dlg.add_textbox(name="TextBox5",layout="GroupBox1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
