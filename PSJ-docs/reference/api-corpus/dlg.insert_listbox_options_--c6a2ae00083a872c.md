# dlg.insert_listbox_options()

dlg.insert_listbox_options()

説明​

ListBoxコンポーネントの特定位置に複数のオプションを挿入します。

構文​

dlg.insert_listbox_options(...)

入力​

name​

ListBoxコンポーネントの名前を指定する String 。

この入力は必須です。

position​

新しいオプションを挿入するListBox内の位置を指定する Integer 。

この入力は必須です。

options​

新しいオプションを指定する String のリスト。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,0,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_listbox(name="ListBox2",options=["item1","item2","item3","item4","item5"],
        width=100,height=150,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.insert_listbox_options(name="ListBox2",position=2,options=["item_New_2","item_New_1"])

if __name__=='__main__':
    main()
