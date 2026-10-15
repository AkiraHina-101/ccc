# dlg.enable_tabwnd_swap_tab()

dlg.enable_tabwnd_swap_tab()

説明​

タブウィンドウ内のタブ項目の入れ替えを有効化/無効化するように設定します。

構文​

dlg.dlg.set_item_visible(...)

入力​

name​

タブウィンドウの名前を指定する String 。

この入力は必須です。

enable​

タブ項目の入れ替えを有効化/無効化するかを指定する Boolean 型:

True: 入れ替えを有効化します。

False: 入れ替えを無効化します。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *
def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_tabwnd(name="TabWnd10",width=200,height=200,layout="Window")
    dlg.enable_tabwnd_swap_tab(name="TabWnd10", enable=False)
    dlg.add_tabwnd_page(name="TabWnd10",page_name="TabItem11",page_text="TabItem1")
    dlg.add_tabwnd_page(name="TabWnd10",page_name="TabItem12",page_text="TabItem2")
    dlg.add_tabwnd_page(name="TabWnd10",page_name="TabItem13",page_text="TabItem3")
    dlg.generate_window()
if __name__=='__main__':
    main()
