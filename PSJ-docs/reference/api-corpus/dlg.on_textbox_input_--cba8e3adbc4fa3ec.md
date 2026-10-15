# dlg.on_textbox_input()

dlg.on_textbox_input()

説明​

テキストボックスのテキストが変更されたときに作成した関数をテキストボックスコンポーネントにバインドします。

構文​

dlg.on_textbox_input(...)

入力​

name​

バインドする作成したdef関数のTextBoxコンポーネントの名前を指定する String です。

この入力は必須です。

callfunc​

バインドしたい関数の名前です。

この入力は必須です。

bool​

テキストボックスを検証するかどうかを指定する Boolean です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *
def on_input(dlg):
    text=dlg.get_item_text("TextBox2")
    if text=="1":
        return False
    else :
        print("Hello")
        return True
def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_textbox(name="TextBox2",layout="Window")
    dlg.generate_window()
    dlg.on_textbox_input("TextBox2",on_input,True)
if __name__=='__main__':
    main()
