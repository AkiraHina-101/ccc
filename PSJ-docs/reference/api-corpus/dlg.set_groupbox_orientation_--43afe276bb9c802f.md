# dlg.set_groupbox_orientation()

dlg.set_groupbox_orientation()

説明​

GroupBoxコンポーネント内のすべてのコンポーネントのレイアウトを、水平または垂直方向に整列させます。

構文​

dlg.set_groupbox_orientation(...)

入力​

name​

コンポーネントの名前を指定する String の入力です。

レイアウトオプションを設定するために使用します。

この入力は必須です。

orientation​

GroupBoxの方向オプションを指定する String の入力です：

"vertical": 内部コンポーネントを垂直方向に整列します。

"horizontal": 内部コンポーネントを水平方向に整列します。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.set_groupbox_orientation(name="GroupBox1",orientation="vertical")
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
