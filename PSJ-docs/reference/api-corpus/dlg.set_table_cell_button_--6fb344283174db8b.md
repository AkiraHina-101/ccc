# dlg.set_table_cell_button()

dlg.set_table_cell_button()

説明​

テーブル内のボタンセルを設定します。

構文​

dlg.set_table_cell_button(...)

入力​

name​

テーブルコンポーネントの名前を指定する String です。

この入力は必須です。

row​

行の順序を指定する Integer です（0から開始）。

この入力は必須です。

col​

列の順序を指定する Integer です（0から開始）。

この入力は必須です。

text​

ボタンに表示されるテキストを指定する String です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",width=260,height=260,
        columns=["Heading1","Heading2"],
        rows=5,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",
        layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_table_cell_button(name="Table2",row=0,
        col=0,text="Button")

if __name__=='__main__':
    main()
