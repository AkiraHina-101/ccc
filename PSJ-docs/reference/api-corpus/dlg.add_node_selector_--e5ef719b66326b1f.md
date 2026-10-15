# dlg.add_node_selector()

dlg.add_node_selector()

説明​

"Node" を選択リストに追加し、ユーザーが節点を選択して選択した節点を選択リストに保存できるようにします。

構文​

dlg.add_node_selector(...)

入力​

text​

セレクターのタイトルを指定する String 。

デフォルト値は "" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg = JDGCreator(title="ダイアログ", resizable=True, validation=True)
    dlg.add_listbox(name="ListBox3", multisel=True, options=["item1", "item2", "item3"], width=100, height=100, layout="Window")
    dlg.add_hlayout(name="footer", layout="Window")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_button(name="ButtonOk", text="OK", layout="footer")
    dlg.add_button(name="ButtonCancel", text="キャンセル", layout="footer")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_node_selector()
    dlg.generate_window()

if __name__ == '__main__':
    main()
