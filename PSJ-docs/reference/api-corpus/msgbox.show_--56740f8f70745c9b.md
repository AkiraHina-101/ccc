# msgbox.show()

msgbox.show()

説明​

PSJMessageBoxクラスのインスタンス、メッセージボックスを表示するために使用されます。

構文​

msgbox.show()

入力​

この関数は入力値を必要としません。

戻り値​

クリックしたボタンの名前を指定する String です。

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="This is an error message box")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("clicked:"+ msgbox.show())

if __name__=='__main__':
    main()
