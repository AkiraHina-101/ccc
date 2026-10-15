# dlg.set_item_text()

dlg.set_item_text()

説明​

コンポーネント内に表示されるテキストを設定します。

構文​

dlg.set_item_text(...)

入力​

name​

コンポーネントの名前を指定する String です。

この入力は必須です。

text​

表示されるコンテンツを指定する String です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *
def onSetButtonClicked(dlg):
    dlg.set_item_text(name="TextBox1",text="This is sample text")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_textbox(name="TextBox1",layout="Window")
    dlg.add_button(name="Button2",text="Set text",width=60,height=22,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="Button2",callfunc=onSetButtonClicked)

if __name__=='__main__':
    main()
