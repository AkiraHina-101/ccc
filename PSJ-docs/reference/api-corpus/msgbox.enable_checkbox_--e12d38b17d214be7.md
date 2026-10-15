# msgbox.enable_checkbox()

msgbox.enable_checkbox()

説明​

PSJMessageBoxクラスのインスタンスで、メッセージボックス内のチェックボックスを指定します。

構文​

msgbox.enable_checkbox(...)

入力​

text​

チェックボックスの内容を指定する String です。

こちらは必須入力です。

checked​

このコンポーネントのデフォルト状態を指定する Boolean 型です：

True: このコンポーネントのデフォルト状態はチェックされています。

False: このコンポーネントのデフォルト状態はチェックされていません。

デフォルト値は False です。

戻り値​

この関数には出力値はありません。

サンプルコード​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJメッセージボックス")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="これはエラーメッセージボックスです")
    msgbox.enable_checkbox(text="次回表示しない", checked=True)
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("クリック:"+msgbox.show())  

if __name__=='__main__':
    main()
