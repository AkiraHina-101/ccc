# dlg.on_browse()

dlg.on_browse()

説明​

作成した関数をファイル/フォルダーブラウザコンポーネントにバインドします。

構文​

dlg.on_browse(...)

入力​

name​

作成された def 関数をバインドするファイル/フォルダーブラウザコンポーネントの名前を指定する String 。

これは必須の入力です。

callfunc​

バインドしたい関数の名前です。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_browse_clicked(dlg,path_list):
    print(path_list[0])

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_browser(name="Browser2",mode="file",file_filter="All Files(*.*)",layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_browse(name="Browser2",callfunc=on_browse_clicked)

if __name__=='__main__':
    main()
