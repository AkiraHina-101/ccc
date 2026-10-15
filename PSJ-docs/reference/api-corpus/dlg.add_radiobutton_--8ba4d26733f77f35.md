# dlg.add_radiobutton()

dlg.add_radiobutton()

説明​

作成ダイアログに RadioButton を追加します。

構文​

dlg.add_radiobutton(...)

入力​

name​

作成されるコンポーネントの名前を指定する String 。

これは必須の入力です。

layout​

作成されるレイアウトの名前を指定する String 。
作成されるレイアウトは、GroupBox コンポーネント、レイアウトコンポーネントなどです。

これは必須の入力です。

text​

表示されるテキストを指定する String 。

デフォルト値は「""」です。

width​

RadioButton の幅を指定する Integer 。

デフォルト値は 0 です。

height​

RadioButton の高さを指定する Integer 。

デフォルト値は 0 です。

checked​

このコンポーネントのデフォルト状態を指定する Boolean 型:

True: このコンポーネントのデフォルト状態はチェックされています。

False: このコンポーネントのデフォルト状態はチェックされていません。

デフォルト値は False です。

group​

この RadioButton が追加されるグループを指定する Boolean 型:

True: 作成した RadioButton は既存の RadioButton とは別のグループに追加されます（異なるボタングループ）。したがって、作成した RadioButton を選択したとき、選択されている RadioButton は選択解除されません。

False: 作成した RadioButton は前の RadioButton と同じグループに追加されます。したがって、作成した RadioButton を選択したとき、選択されている RadioButton は選択解除されます。

デフォルト値は False です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_radiobutton(name="RadioButton16",text="RadioButton",layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
