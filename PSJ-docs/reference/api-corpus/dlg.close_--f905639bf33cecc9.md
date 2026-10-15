# dlg.close()

dlg.close()

説明​

ダイアログを閉じます。

構文​

dlg.close(...)

入力​

この関数は入力値を必要としません。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_button_clicked(dlg):
    dlg.close()

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,
        layout="Window")
    dlg.add_label(name="Label2",
        text="Click any button to close this dialog!",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="ButtonApply",callfunc=on_button_clicked)
    dlg.on_button_clicked(name="ButtonOk",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
