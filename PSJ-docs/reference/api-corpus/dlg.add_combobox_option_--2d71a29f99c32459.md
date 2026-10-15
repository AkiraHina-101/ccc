# dlg.add_combobox_option()

dlg.add_combobox_option()

説明​

ComboBoxコンポーネントにオプションを追加します。

構文​

dlg.add_combobox_option(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String 。

この入力は必須です。

option_text​

追加されるオプションを指定する String 。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],layout="Layout1")
    dlg.add_combobox_option(name="ComboBox2",option_text="new_item")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")

    dlg.generate_window()
if __name__=='__main__':
    main()
