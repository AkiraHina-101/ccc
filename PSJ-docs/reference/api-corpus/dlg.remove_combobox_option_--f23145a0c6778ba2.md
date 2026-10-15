# dlg.remove_combobox_option()

dlg.remove_combobox_option()

説明​

ComboBoxで指定されたオプションを削除します。

構文​

dlg.remove_combobox_option(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String 。

これは必須の入力です。

position​

ComboBox内の削除するオプションの位置を指定する Integer 。

これは必須の入力です。

戻り値​

この関数には出力値はありません。

サンプルコード​

from pyjdg import *

def on_button_clicked(dlg):
    option_idx=dlg.get_combobox_sel(name="ComboBox2")
    option_name=dlg.get_combobox_option(name="ComboBox2",index=option_idx)
    dlg.remove_combobox_option(name="ComboBox2",position=option_idx)
    print(option_name + " オプションが削除されました")

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],width=80,height=25,
        index=0,layout="Layout1")
    dlg.add_button(name="Button3",text="オプションを削除",width=90,height=25,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button3",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
