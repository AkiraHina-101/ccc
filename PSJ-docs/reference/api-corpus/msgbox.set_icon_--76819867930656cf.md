# msgbox.set_icon()

msgbox.set_icon()

説明​

メッセージボックスで使用されるアイコンのタイプを指定するPSJMessageBoxクラスのインスタンスです。

構文​

msgbox.set_icon(...)

入力​

icon_type​

メッセージボックスで使用されるmsgbox_iconを指定する_Enum_です。

この入力は必須です。

path​

メッセージボックスのアイコンを設定するために使用されるアイコンファイルのフルパスを指定する_String_です。

この引数は、_icon_type_が "user" アイコンタイプに設定されている場合にのみ使用されます。

これは必須の入力です。

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
