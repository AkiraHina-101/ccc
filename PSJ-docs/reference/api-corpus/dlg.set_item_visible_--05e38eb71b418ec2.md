# dlg.set_item_visible()

dlg.set_item_visible()

説明​

作成したコンポーネントの状態を表示または非表示に設定します。すべてのToolBoxタイプに使用できます。

構文​

dlg.dlg.set_item_visible(...)

入力​

name​

コンポーネントの名前を指定する String です。表示または非表示にするコンポーネントの名前です。

この入力は必須です。

visible​

指定されたコンポーネントの状態を指定する Boolean 型です：

True: コンポーネントを表示します。

False: コンポーネントを非表示にします。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_combobox_changed(dlg):
    combobox_sel = dlg.get_combobox_sel(name="ComboBox4")
    if combobox_sel == 1:
        dlg.set_item_visible(name="PageItem8",visible=False)
        dlg.set_item_visible(name="PageItem9",visible=False)
        dlg.set_item_visible(name="Table14",visible=False)
    if combobox_sel == 0:
        dlg.set_item_visible(name="PageItem8",visible=True)
        dlg.set_item_visible(name="PageItem9",visible=True)
        dlg.set_item_visible(name="Table14",visible=True)

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Select Layout",text_halign="left",text_valign="top",layout="Layout2")
    dlg.add_combobox(name="ComboBox4",options=["Layout1","Layout2"],index=0,layout="Layout2")
    dlg.add_layout(name="Layout5",orientation=orientation.horizontal,layout="Window")
    dlg.add_pagesctrl(name="PagesCtrl6",width=260,height=160,current_page=2,layout="Layout5")
    dlg.add_pageitem(name="PagesCtrl6",page_name="PageItem7",page_header="First page")
    dlg.add_groupbox(name="GroupBox10",text="GroupBox",layout="PageItem7")
    dlg.add_layout(name="Layout11",orientation=orientation.horizontal,layout="GroupBox10")
    dlg.add_label(name="Label12",text="Label",text_halign="left",text_valign="top",layout="Layout11")
    dlg.add_browser(name="Browser13",mode="file",file_filter="All Files(*.*)",layout="Layout11")
    dlg.add_table(name="Table14",width=260,height=160,columns=["Heading1","Heading2"],rows=5,layout="GroupBox10")
    dlg.add_pageitem(name="PagesCtrl6",page_name="PageItem8",page_header="Second page")
    dlg.add_pageitem(name="PagesCtrl6",page_name="PageItem9",page_header="Third page")
    dlg.generate_window()
    dlg.set_pagesctrl_current_page(name="PagesCtrl6",page_index=0)
    dlg.on_combobox_sel(name="ComboBox4",callfunc=on_combobox_changed)

if __name__=='__main__':
    main()
