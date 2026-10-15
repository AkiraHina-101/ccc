# ダイアログ内のページ切り替え

ダイアログ内のページ切り替え

🎯 はじめに​

このチュートリアルでは、dlg.set_pagesctrl_current_page()を使用して、ページコントロール内で2ページを切り替える方法を学びます：

異なるUIコンポーネントを持つ2ページを作成します。

コンボボックスを使用して2ページ間を切り替えます。

📖 チュートリアル​

# Python APIウィンドウのエンコーディング
# coding: cp932

from pyjdg import *

def switch_page(dlg):
    page = dlg.get_combobox_sel(name='switcher')
    dlg.set_pagesctrl_current_page(name='pages_ctrl_item_5', page_index=page)

def main():
    dlg=JDGCreator(title="ページ切り替えサンプル", resizable=True, validation=True)
    dlg.add_groupbox(name="GroupBox1", text="コンボボックスから現在のページを設定", layout="Window")
    dlg.set_groupbox_orientation(name="GroupBox1", orientation="horizontal")
    dlg.add_label(name="Label2", text="現在のページを選択", text_halign="left", text_valign="top", layout="GroupBox1")
    dlg.add_combobox(name="switcher", options=["最初のページ", "第二のページ"], index=0, layout="GroupBox1")
    dlg.add_pagesctrl(name="pages_ctrl_item_5", show_header=False, height=300, width=300, layout="Window")
    dlg.add_pageitem(name="pages_ctrl_item_5", page_name="PageItem6", page_header="ページアイテム")
    dlg.add_groupbox(name="GroupBox8", text="グループボックス", layout="PageItem6")
    dlg.add_richeditbox(name="RichEditBox9", text="これは最初のページです", width=200, height=200, layout="GroupBox8")
    dlg.add_pageitem(name="pages_ctrl_item_5", page_name="PageItem7", page_header="ページアイテム")
    dlg.add_groupbox(name="GroupBox10", text="グループボックス", layout="PageItem7")
    dlg.add_textbox(name="TextBox13", text="これは第二のページです", layout="GroupBox10")
    dlg.add_hlayout(name="Layout14", layout="GroupBox10")
    dlg.add_table(name="Table11", rows=5, columns=["X方向", "Y方向"], width=160, layout="Layout14")
    dlg.add_table(name="Table12", rows=5, columns=["Xプロット", "Yプロット"], width=160, layout="Layout14")
    dlg.add_hlayout(name="footer", layout="Window")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_button(name="ButtonOk", text="Ok", layout="footer")
    dlg.add_button(name="ButtonCancel", text="Cancel", layout="footer")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.generate_window()
    dlg.on_combobox_sel(name="switcher", callfunc=switch_page)

if __name__=='__main__':
    main()
