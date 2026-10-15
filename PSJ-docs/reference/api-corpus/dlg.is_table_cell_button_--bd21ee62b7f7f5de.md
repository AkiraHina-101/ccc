# dlg.is_table_cell_button()

dlg.is_table_cell_button()

説明​

入力セルがボタンセルであるかどうかを確認します。

構文​

dlg.is_table_cell_button(...)

入力​

name​

テーブルの名前を指定する String です。

この入力は必須です。

cell​

テーブル内のセルの位置を指定する TableCellID オブジェクトです。

TableCellID(row,col) はセルオブジェクトを定義します

TableCellID.row_number はセルの行番号を返します

TableCellID.col_number はセルの列番号を返します

この入力は必須です。

戻り値​

入力されたセルの種類を指定する Boolean です：

True: 入力されたセルはボタンセルです。

False: 入力されたセルはボタンセルではありません。

サンプルコード​

from pyjdg import *

def on_cell_button_clicked(dlg,name,cell):
    JPT.ClearLog()
    cellvector=dlg.get_table_sel_cell(name="Table2")
    if cellvector.size() > 0:
       check_cell_button = \
            dlg.is_table_cell_button(name="Table2",
                cell=cellvector[0])
       print("Is button cell: " + str(check_cell_button))

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
    dlg.on_table_sel_changed(name="Table2",
        callfunc=on_cell_button_clicked)

if __name__=='__main__':
    main()
