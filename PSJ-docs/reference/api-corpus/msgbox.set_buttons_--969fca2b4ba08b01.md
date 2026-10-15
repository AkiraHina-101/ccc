# msgbox.set_buttons()

msgbox.set_buttons()

説明​

PSJMessageBoxクラスのインスタンスで、メッセージボックスでサポートされている利用可能なボタンのセットを指定します。

構文​

msgbox.set_buttons(...)

入力​

button_type​

メッセージボックスでサポートされているmsgbox_buttonsのセットを指定する Enum です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJメッセージボックス")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="これはエラーメッセージボックスです")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("クリック:"+msgbox.show())

if __name__=='__main__':
    main()
