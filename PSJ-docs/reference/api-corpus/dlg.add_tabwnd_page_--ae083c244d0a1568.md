# dlg.add_tabwnd_page()

dlg.add_tabwnd_page()

説明​

TabWndコンポーネントにTabItem（ページ）を追加します。

構文​

dlg.add_tabwnd_page(...)

入力​

name​

作成されるTabItemが追加されるTabWndコンポーネントの名前を指定する String です。

この入力は必須です。

page_name​

作成されたコンポーネントの名前を指定する String です。

この入力は必須です。

page_text​

タイトルとして表示されるテキストを指定する String です。

デフォルト値は "" です。

page_orientation​

作成されるタブページの向きを指定する String です。2つのオプションがあります:

"vertical": 内部コンポーネントを縦方向に配置します。

"horizontal": 内部コンポーネントを横方向に配置します。

デフォルト値は "vertical" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_tabwnd(name="TabWnd2",width=200,height=200,layout="Window")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem3",page_text="TabItem",page_orientation="vertical")
    dlg.add_label(name="Label5",text="Label",text_halign="left",text_valign="top",layout="TabItem3")
    dlg.add_textbox(name="TextBox6",layout="TabItem3")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem4",page_text="TabItem",page_orientation="horizontal")
    dlg.add_label(name="Label7",text="Label",text_halign="left",text_valign="top",layout="TabItem4")
    dlg.add_textbox(name="TextBox8",layout="TabItem4")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
```  ​​​
