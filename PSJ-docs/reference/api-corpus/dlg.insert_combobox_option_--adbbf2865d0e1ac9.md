# dlg.insert_combobox_option()

dlg.insert_combobox_option()

説明​

ComboBoxコンポーネントの特定の位置にオプションを挿入します。

構文​

dlg.insert_combobox_option(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String 。

この項目は必須です。

position​

新しいオプションを配置するComboBox内の位置を指定する Integer 。

この項目は必須です。

option​

ComboBoxオプションとして使用されるテキストを指定する String 。

この項目は必須です。

戻り値​

この機能には出力値がありません。

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
    dlg.insert_combobox_option(name="ComboBox2",position=2,option="item_New")

if __name__=='__main__':
    main()
