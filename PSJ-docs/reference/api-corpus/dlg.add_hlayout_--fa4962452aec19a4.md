# dlg.add_hlayout()

dlg.add_hlayout()

説明​

作成ダイアログに水平レイアウトを追加します。

構文​

dlg.add_hlayout(...)

入力​

name​

作成したコンポーネントの名前を指定する String 。

この入力は必須です。

layout​

作成したレイアウトの名前を指定する String 。
作成したレイアウトは、GroupBoxコンポーネント、Layoutコンポーネントなどです。

この入力は必須です。

margin​

作成したレイアウトの位置を定義するすべての値を指定する List 型。
位置のリストは[left, top, right, bottom]の順に定義されます。

デフォルト値は[]です。

戻り値​

この機能には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Jupiter",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_hlayout(name="footer",margin=[0,10,0,10],layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
