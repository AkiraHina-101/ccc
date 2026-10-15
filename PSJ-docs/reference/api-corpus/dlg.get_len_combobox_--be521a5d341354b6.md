# dlg.get_len_combobox()

dlg.get_len_combobox()

説明​

ComboBoxのサイズ（アイテム数）を取得します。

構文​

dlg.get_len_combobox(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String 。

これは必須の入力です。

戻り値​

ComboBoxコンポーネントのサイズを指定する Integer 。

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
    comboBoxLen=dlg.get_len_combobox(name="ComboBox2")
    print(comboBoxLen)

if __name__=='__main__':
    main()
