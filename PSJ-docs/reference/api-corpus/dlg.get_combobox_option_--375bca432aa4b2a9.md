# dlg.get_combobox_option()

dlg.get_combobox_option()

説明​

選択されたComboBoxオプションの文字列値を取得します。

構文​

dlg.get_combobox_option(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String 。

これは必須の入力です。

index​

ComboBoxコンポーネントの値の順序を指定する Integer 。

これは必須の入力です。

戻り値​

選択されたComboBoxオプションを指定する String 。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_combobox(name="ComboBox1",options=["item1","item2","item3","item4","item5","item6"],layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_combobox_sel(name="ComboBox1",option=2)
    print(dlg.get_combobox_option(name="ComboBox1",index=2))

if __name__=='__main__':
    main()
