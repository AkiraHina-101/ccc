# dlg.set_table_column_data_type()

dlg.set_table_column_data_type()

説明​

テーブルのセルのデータ型検証を設定します。

構文​

dlg.set_table_column_data_type(...)

入力​

name​

テーブルの名前を指定する String 。

これは必須入力です。

col​

列の順番を指定する Integer （0から始まる）。

これは必須入力です。

data_type​

テーブルの列のデータ型検証を指定する String 。

サポートする3つのタイプ: "String", "Integer" および "Double"

これは必須入力です。

precision​

Double 列内の浮動小数点後の桁数を指定する Integer 。

デフォルト値は2です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=260,height=260)    
    dlg.set_table_column_data_type(name="Table1",
        col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",
        col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",
        col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Ok",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
