# dlg.show_dlg_help_button()

dlg.show_dlg_help_button()

説明​

作成ダイアログ内でヘルプボタンを表示または非表示にします。

構文​

dlg.show_dlg_help_button(...)

入力​

shown​

ヘルプボタンの表示を指定する Boolean 型の入力:

True: ヘルプボタンを表示

False: ヘルプボタンを非表示

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Label",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.show_dlg_help_button(shown=False)
    dlg.generate_window()

if __name__=='__main__':
    main()
