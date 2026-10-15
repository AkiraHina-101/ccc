# dlg.add_tabwnd()

dlg.add_tabwnd()

説明​

作成ダイアログに TabWnd（タブウィンドウ）を追加します。

構文​

dlg.add_tabwnd(...)

入力​

name​

タブウィンドウコンポーネントの名前を指定する String です。

この入力は必須です。

layout​

作成したレイアウトの名前を指定する String です。
作成したレイアウトは、GroupBoxコンポーネント、Layoutコンポーネントなどが含まれます。

この入力は必須です。

width​

タブウィンドウの幅を指定する Integer です。

デフォルト値は60です。

height​

タブウィンドウの高さを指定する Integer です。

デフォルト値は22です。

戻り値​

この機能には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_tabwnd(name="TabWnd1",width=200,height=200,layout="Window")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem2",page_text="TabItem",page_orientation="horizontal")
    dlg.add_tabwnd_page(name="TabWnd1",page_name="TabItem3",page_text="TabItem")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
