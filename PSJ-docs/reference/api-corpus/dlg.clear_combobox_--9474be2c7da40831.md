# dlg.clear_combobox()

dlg.clear_combobox()

説明​

指定されたComboBoxのすべてのオプションをクリアします。

構文​

dlg.clear_combobox(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String 。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_clicked (dlg):
    dlg.clear_combobox(name="ComboBox2")
    print("すべてのComboBoxのオプションがクリアされました")

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],index=1,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Button3",text="Clear ComboBox",width=100,height=30,bk_color=15790320,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button3",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
