# dlg.add_groupbox()

dlg.add_groupbox()

説明​

作成ダイアログにGroupBoxを追加します。

構文​

dlg.add_groupbox(...)

入力​

name​

作成したコンポーネントの名前を指定する String です。

この入力は必須です。

layout​

作成したレイアウトの名前を指定する String です。
作成したレイアウトは、GroupBoxコンポーネント、レイアウトコンポーネントなどです。

この入力は必須です。

text​

表示されるテキストを指定する String です。

デフォルト値は "" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Jupiter",layout="Window")
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
