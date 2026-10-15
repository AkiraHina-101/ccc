# dlg.add_3delement_selector()

dlg.add_3delement_selector()

説明​

"ソリッド要素" を選択リストに追加し、ユーザーが固体要素を選択して選択された固体要素を選択リストに保存できるようにします。

構文​

dlg.add_3delement_selector(...)

入力​

text​

セレクターのタイトルを指定する String 。

デフォルト値は "Solid Element" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Length in X",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_layout(name="Layout6",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label7",text="Length in Y",layout="Layout6")
    dlg.add_textbox(name="TextBox8",layout="Layout6")
    dlg.add_layout(name="Layout9",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label10",text="Length in Z",layout="Layout9")
    dlg.add_textbox(name="TextBox11",layout="Layout9")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_3delement_selector(text="3D Element 1")
    dlg.generate_window()

if __name__=='__main__':
    main()
