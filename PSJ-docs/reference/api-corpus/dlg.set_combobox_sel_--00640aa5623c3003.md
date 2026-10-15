# dlg.set_combobox_sel()

dlg.set_combobox_sel()

説明​

現在の選択をコンボボックスコンポーネントに設定します。

構文​

dlg.set_combobox_sel(...)

入力​

name​

コンボボックスコンポーネントの名前を指定する String 。

この入力は必須です。

option​

コンボボックスコンポーネントの値の順序または選択されたアイテムの名前を指定する Integer または String 。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,100,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4","item5"],width=70,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_combobox_sel(name="ComboBox2",option=3)

if __name__=='__main__':
    main()
