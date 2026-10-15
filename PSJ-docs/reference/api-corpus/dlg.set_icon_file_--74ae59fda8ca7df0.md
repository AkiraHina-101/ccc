# dlg.set_icon_file()

dlg.set_icon_file()

説明​

GUI ダイアログのアイコンを設定します。

構文​

dlg.set_icon_file(...)

入力​

file​

GUI ダイアログのアイコンを設定するために使用するアイコンファイルのフルパスを指定する String の入力です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    sel_ico = JPT.GetProgramPath() + \
        r"Lib\site-packages\win32\test\win32rcparser\python.ico"

    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.set_icon_file(file=sel_ico)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
