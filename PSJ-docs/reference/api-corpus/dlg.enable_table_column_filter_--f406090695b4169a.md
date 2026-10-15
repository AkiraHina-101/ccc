# dlg.enable_table_column_filter()

dlg.enable_table_column_filter()

説明​

テーブルの列のフィルターオプションを追加します。

構文​

dlg.enable_table_column_filter(...)

入力​

name​

テーブルの名前を指定する String です。

この入力は必須です。

col​

列の順序を指定する Integer です（0から開始）。

この入力は必須です。

enable​

テーブルの列のフィルターモードの状態を指定する Boolean です。

True: フィルターモードが表示されます

False: フィルターモードが非表示になります

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.enable_table_column_filter(name="Table2",col=0,enable=True)
    dlg.generate_window()

if __name__=='__main__':
    main()
