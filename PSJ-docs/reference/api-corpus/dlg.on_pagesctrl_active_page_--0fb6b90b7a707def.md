# dlg.on_pagesctrl_active_page()

dlg.on_pagesctrl_active_page()

説明​

PageItem を選択したときのイベントを設定します。

構文​

dlg.on_pagesctrl_active_page(...)

入力​

name​

PagesCtrl の名前を指定する String です。

この入力は必須です。

callfunc​

バインドしたい関数の名前です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_pageitem_changed(dlg, name, old_page):
    current_page = dlg.get_pagesctrl_current_page(name="PagesCtrl1")
    current_page_name = dlg.get_pagesctrl_page_name(name="PagesCtrl1", page_index=current_page)
    old_page_name = dlg.get_pagesctrl_page_name(name="PagesCtrl1", page_index=old_page)
    print("選択したページの名前: " + current_page_name)
    print("以前に選択したページ: " + old_page_name)

def main():
    dlg = JDGCreator(title="Dialog", resizable=True, validation=True)
    dlg.add_pagesctrl(name="PagesCtrl1", layout="Window")
    dlg.add_pageitem(name="PagesCtrl1", page_name="PageItem2", page_header="PageItem1")
    dlg.add_pageitem(name="PagesCtrl1", page_name="PageItem3", page_header="PageItem2")
    dlg.add_pageitem(name="PagesCtrl1", page_name="PageItem4", page_header="PageItem3")
    dlg.add_hlayout(name="footer", layout="Window")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_button(name="Ok", text="Ok", layout="footer")
    dlg.add_button(name="ButtonCancel", text="Cancel", layout="footer")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.generate_window()
    dlg.on_pagesctrl_active_page(name="PagesCtrl1", callfunc=on_pageitem_changed)

if __name__ == '__main__':
    main()
