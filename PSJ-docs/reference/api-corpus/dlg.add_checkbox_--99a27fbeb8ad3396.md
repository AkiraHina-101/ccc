# dlg.add_checkbox()

dlg.add_checkbox()

説明​

作成ダイアログにCheckBoxを追加します。

構文​

dlg.add_checkbox(...)

入力​

name​

作成されたコンポーネントの名前を指定する String です。

この入力は必須です。

layout​

作成されたレイアウトの名前を指定する String です。
作成されたレイアウトは、GroupBoxコンポーネント、Layoutコンポーネントなどが該当します。

この入力は必須です。

text​

CheckBoxの隣に表示されるテキストを指定する String です。

デフォルト値は "" です。

checked​

このコンポーネントのデフォルト状態を指定する Boolean 型です：

True: このコンポーネントのデフォルト状態はチェックされています。

False: このコンポーネントのデフォルト状態はチェックされていません。

デフォルト値は False です。

lefttext​

テキストがCheckBoxの左側にあるかを指定する Boolean 型です：

True: テキストがCheckBoxの左側にあります。

False: テキストがCheckBoxの右側にあります。

デフォルト値は False です。

width​

CheckBoxの幅を指定する Integer です。

デフォルト値は 0 です。

height​

CheckBoxの高さを指定する Integer です。

デフォルト値は 0 です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_checkbox(name="CheckBox2",text="チェックボックス",lefttext=True,checked=True,layout="Window")
    dlg.add_checkbox(name="CheckBox3",text="チェックボックス",lefttext=False,checked=True,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
