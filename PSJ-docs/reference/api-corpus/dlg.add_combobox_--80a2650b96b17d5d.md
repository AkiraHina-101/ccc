# dlg.add_combobox()

dlg.add_combobox()

説明​

ダイアログにComboBoxコンポーネントを追加します。

構文​

dlg.add_combobox(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String .

この入力は必須です。

layout​

レイアウト名を指定する String .
作成されるレイアウトは、GroupBoxコンポーネント、Layoutコンポーネントなどになります.

この入力は必須です。

index​

ComboBoxで表示されるデフォルトのオプションを指定する Integer .

開始値は0です（最初のオプション -> index=0）.

この入力は必須です。

options​

ComboBoxのオプションを指定する String のリスト 型.

デフォルト値は[]です.

width​

ComboBoxの幅を指定する Integer .

デフォルト値は0です.

height​

ComboBoxの高さを指定する Integer .

デフォルト値は0です.

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],index=1,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
