# dlg.get_item_text()

dlg.get_item_text()

説明​

コンポーネント内のテキストを取得します。

構文​

dlg.get_item_text(...)

入力​

name​

ユーザーがテキストを取得したいコンポーネントの名前を指定する String です。

この入力は必須です。

戻り値​

コンポーネント内のテキストを指定する String です。

サンプルコード​

from pyjdg import *
def onGetButtonClicked(dlg):
    print(dlg.get_item_text(name="TextBox1"))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_textbox(name="TextBox1",layout="Window")
    dlg.add_button(name="Button2",text="Get text",width=60,height=22,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="Button2",callfunc=onGetButtonClicked)

if __name__=='__main__':
    main()
