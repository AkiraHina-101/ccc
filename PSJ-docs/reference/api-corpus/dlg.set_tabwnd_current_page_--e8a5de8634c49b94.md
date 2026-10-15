# dlg.set_tabwnd_current_page()

dlg.set_tabwnd_current_page()

説明​

TabWndの現在のページを特定のTabItemの順序に設定します。

構文​

dlg.set_tabwnd_current_page(...)

入力​

name​

タブページを設定するために使用するTabWndコンポーネントの名前を指定する String です。

この入力は必須です。

page_index​

タブの順序を指定する Integer です。

この入力は必須です。

戻り値​

この関数には出力値はありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_tabwnd(name="TabWnd2",width=300,height=300,layout="Layout1")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem3",page_text="Jupiter-Pre",page_orientation="horizontal")
    dlg.add_label(name="Label7",text="ラベル",layout="TabItem3")
    dlg.add_textbox(name="TextBox8",layout="TabItem3")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem4",page_text="Jupiter-Post")
    dlg.add_radiobutton(name="RadioButton9",text="ラジオボタン",layout="TabItem4")
    dlg.add_radiobutton(name="RadioButton10",text="ラジオボタン",layout="TabItem4")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem5",page_text="Sunshine")
    dlg.add_slider(name="Slider11",width=100,height=30,min=0,max=100,pos=0,layout="TabItem5")
    dlg.add_tabwnd_page(name="TabWnd2",page_name="TabItem6",page_text="PSJ")
    dlg.add_listbox(name="ListBox12",width=100,height=100,layout="TabItem6")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_tabwnd_current_page(name="TabWnd2",page_index=2)

if __name__=='__main__':
    main()
