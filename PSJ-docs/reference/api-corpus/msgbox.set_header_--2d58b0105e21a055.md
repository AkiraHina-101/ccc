# msgbox.set_header()

msgbox.set_header()

説明​

PSJMessageBoxクラスのインスタンスで、メッセージボックスの見出しを設定します。

構文​

msgbox.set_header(...)

入力​

text​

メッセージボックスの見出しを指定する String です。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ メッセージボックス")
    msgbox.set_header(text="エラー")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="これはエラーメッセージボックスです")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("クリック:"+msgbox.show())

if __name__=='__main__':
    main()
