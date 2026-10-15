# PSJMessageBox

PSJMessageBox

説明​

PSJMessageBoxクラスのインスタンスで、メッセージボックスのメソッドを指定します。

入力​

PSJMessageBoxオブジェクトを作成するには、PSJMessageBox（）で変数を定義します。

メソッド​

 | メソッド | 説明

 | set_caption() | メッセージボックスのキャプションを設定します

 | set_header() | メッセージボックスのヘッダーを設定します

 | set_icon() | メッセージボックスで使用するアイコンのタイプを設定します

 | set_message() | メッセージボックスのメッセージ内容を設定します

 | enable_checkbox() | メッセージボックスにチェックボックスを設定します

 | set_buttons() | メッセージボックスでサポートされている利用可能なボタンのセットを設定します

 | add_button() | ボタンを追加し、ボタン名をユーザーが定義できるように設定します

 | show() | メッセージボックスを表示します

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJメッセージボックス")
    msgbox.set_header(text="エラー")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="これはエラーメッセージボックスです")
    msgbox.enable_checkbox(text="再表示しない", checked=True)
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("クリック："+msgbox.show())  

if __name__=='__main__':
    main()
