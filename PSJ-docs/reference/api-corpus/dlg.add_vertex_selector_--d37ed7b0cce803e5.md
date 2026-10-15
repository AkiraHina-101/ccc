# dlg.add_vertex_selector()

dlg.add_vertex_selector()

説明​

「Vertex」を選択リストに追加し、ユーザーが頂点を選択できるようにし、選択した頂点を選択リストに保存します。

構文​

dlg.add_vertex_selector(...)

入力​

text​

選択ダイアログのタイトルを指定する String です。

デフォルト値は「」です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_vertex_selector()
    dlg.generate_window()

if __name__=='__main__':
    main()
