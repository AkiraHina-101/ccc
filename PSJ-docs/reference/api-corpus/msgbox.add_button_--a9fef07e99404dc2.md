# msgbox.add_button()

msgbox.add_button()

説明​

ユーザーが定義することができるボタンのボタン名を追加した PSJMessageBox クラスのインスタンスです。

構文​

msgbox.add_button(...)

入力​

pos​

追加するボタンの msgbox_position を指定する Enum です。

この入力は必須です。

text​

追加されるボタンの名前を指定する String です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="This is an error message box")
    msgbox.add_button(pos=msgbox_position.first, text="First")
    msgbox.add_button(pos=msgbox_position.second, text="Second")
    msgbox.add_button(pos=msgbox_position.third, text="Third")
    print("clicked:"+msgbox.show())

if __name__=='__main__':
    main()
