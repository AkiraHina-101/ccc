# dlg.get_total_column()

dlg.get_total_column()

説明​

テーブルの列の総数を取得します。

構文​

dlg.get_total_column(...)

入力​

name​

テーブルコンポーネントの名前を指定する String 。

この入力は必須です。

戻り値​

テーブルの列の総数を示す Integer 。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=14,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    total_cols = dlg.get_total_column(name="Table1")
    JPT.Debugger(total_cols)

if __name__=='__main__':
    main()
