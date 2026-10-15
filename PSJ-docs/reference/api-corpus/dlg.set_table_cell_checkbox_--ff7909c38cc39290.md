# dlg.set_table_cell_checkbox()

dlg.set_table_cell_checkbox()

説明​

テーブル内のチェックボックスセルを設定します。

構文​

dlg.set_table_cell_checkbox(...)

入力​

name​

テーブルコンポーネントの名前を指定する String 。

これは必須入力です。

row​

行の順序を指定する Integer （0から開始）。

これは必須入力です。

col​

列の順序を指定する Integer （0から開始）。

これは必須入力です。

text​

チェックボックスの横に表示されるテキストを指定する String 。

これは必須入力です。

checked​

チェックボックスの状態を指定する Boolean 型。

True: チェックされています。

False: チェックされていません。

デフォルト値は False です。

戻り値​

この関数には出力値はありません。

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
    dlg.set_table_cell_checkbox(name="Table2",row=0,
        col=0,text="Checkbox",checked=True)

if __name__=='__main__':
    main()
