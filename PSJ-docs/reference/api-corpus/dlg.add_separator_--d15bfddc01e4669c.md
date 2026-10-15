# dlg.add_separator()

dlg.add_separator()

説明​

作成ダイアログに区切り線を追加します。

構文​

dlg.add_separator(...)

入力​

name​

作成されたコンポーネントの名前を指定する String です。

この入力は必須です。

layout​

作成されたレイアウトの名前を指定する String です。
作成されたレイアウトは、GroupBoxコンポーネント、Layoutコンポーネントなどです。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout18",orientation=orientation.vertical,layout="Window")
    dlg.add_label(name="Label19",text="Label",text_valign="top",layout="Layout18")
    dlg.add_separator(name="Separator20",layout="Layout18")
    dlg.add_textbox(name="TextBox21",layout="Layout18")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
