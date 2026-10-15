# dlg.add_layout()

dlg.add_layout()

説明​

作成ダイアログにレイアウトを追加します。

構文​

dlg.add_layout(...)

入力​

name​

作成されたコンポーネントの名前を指定する String 。

これは必須入力です。

layout​

作成されたレイアウトの名前を指定する String 。
作成されたレイアウトは、GroupBox コンポーネント、Layout コンポーネントなどとなります。

これは必須入力です。

orientation​

内部コンポーネントの配置方向を指定する Orientation object 型:

orientation.horizontal: 内部のすべてのコンポーネントが水平に配置されます。

orientation.vertical: 内部のすべてのコンポーネントが垂直に配置されます。

これは必須入力です。

margin​

作成されたレイアウトの位置を定義するすべての値を指定する List 型。
位置のリストは [left, top, right, bottom] の順番で定義されます。

デフォルト値は [] です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg = JDGCreator(title="TechnoStar", resizable=True, validation=True)
    dlg.add_layout(name="Layout1", orientation=orientation.horizontal, margin=[0, 10, 0, 10], layout="Window")
    dlg.add_label(name="Label2", text="Jupiter", layout="Layout1")
    dlg.add_textbox(name="TextBox3", layout="Layout1")
    dlg.add_hlayout(name="footer", layout="Window")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_button(name="ButtonOk", text="Ok", layout="footer")
    dlg.add_button(name="ButtonCancel", text="Cancel", layout="footer")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.generate_window()

if __name__ == '__main__':
    main()
