# dlg.get_dlg_selector_selected_entities()

dlg.get_dlg_selector_selected_entities()

説明​

現在の選択リストで選択された DItem を取得します。

構文​

dlg.get_dlg_selector_selected_entities(...)

入力​

selid​

セレクタのインデックスを指定する Integer です。

この入力は必須です。

戻り値​

選択した項目のリストを指定する DItemVector オブジェクトです。

サンプルコード​

from pyjdg import *

def display_selected_entities(dlg):
    str_nodes = ""
    for n in dlg.get_dlg_selector_selected_entities(selid=0):
        str_nodes += '選択された節点のID: ' + (str(n.id)) + ',\n'
        dlg.set_item_text(name="selected_nodes",text=str_nodes)

def main():
    dlg=JDGCreator(title="Picking Sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="選択されたすべての節点を表示",layout="Window")
    dlg.add_label(name="Label2",text="節点を選択して「節点を表示」ボタンをクリックしてください",layout="GroupBox1")
    dlg.add_button(name="display_nodes",text="節点を表示",layout="GroupBox1")
    dlg.add_richeditbox(name="selected_nodes",text="",width=200,height=200,layout="GroupBox1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_node_selector()
    dlg.add_node_selector()
    dlg.generate_window()
    dlg.on_command(name="display_nodes",callfunc=display_selected_entities)

if __name__=='__main__':
    main()
