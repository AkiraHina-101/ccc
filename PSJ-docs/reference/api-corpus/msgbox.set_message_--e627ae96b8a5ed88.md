# msgbox.set_message()

msgbox.set_message()

説明​

メッセージボックスのメッセージコンテンツを設定するPSJMessageBoxクラスのインスタンス。

構文​

msgbox.set_message(...)

入力​

text​

メッセージボックスのメッセージコンテンツを指定する String です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.exclamation)
    msgbox.set_message(text="This is a warning message box")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("clicked:"+msgbox.show())

if __name__=='__main__':
    main()
