# dlg.add_group_selector()

dlg.add_group_selector()

説明​

"Group"を選択リストに追加し、ユーザーがグループを選択して選択リストに保存できるようにします。

構文​

dlg.add_group_selector(...)

入力​

text​

セレクターのタイトルを指定する String 。

デフォルト値は "Group" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Value",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_group_selector(text="Group 1")
    dlg.generate_window()

if __name__=='__main__':
    main()
