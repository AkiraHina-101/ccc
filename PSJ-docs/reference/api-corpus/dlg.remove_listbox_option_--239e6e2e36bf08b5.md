# dlg.remove_listbox_option()

dlg.remove_listbox_option()

説明​

ListBox内の指定されたオプションを削除します。

構文​

dlg.remove_listbox_option(...)

入力​

name​

ComboBoxコンポーネントの名前を指定する String です。

この入力は必須です。

position​

削除するListBox内のオプションの位置を指定する Integer です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_clicked (dlg):
# 1つずつまたは複数のオプションを同時に削除することが可能です
    options_idx=list(dlg.get_listbox_sels(name="ListBox2"))
    for idx in options_idx:
        option_name=dlg.get_listbox_option(name="ListBox2",option_index=options_idx[0])
        dlg.remove_listbox_option(name="ListBox2",position=options_idx[0])
        print("The option " + option_name + " is removed")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox2",multisel=True,
      options=["item1","item2","item3"],width=100,height=150,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Button3",text="Remove Option",width=100,height=30,bk_color=15790320,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button3",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
