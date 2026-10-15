# dlg.set_cell_value()

dlg.set_cell_value()

説明​

テーブルの特定のセルの値を設定します。

構文​

dlg.set_cell_value(...)

入力​

name​

テーブルコンポーネントの名前を指定する String です。

この入力は必須です。

row​

水平方向のセルの位置を指定する Integer です（0から開始）。

この入力は必須です。

col​

垂直方向のセルの位置を指定する Integer です（0から開始）。

この入力は必須です。

cell​

テーブル内のセルの位置を指定する TableCellID オブジェクトです。この引数は、row および col が指定されていない場合にのみ使用されます。

TableCellID(row,col) はセルオブジェクトを定義します

TableCellID.row_number はセルの行番号を返します

TableCellID.col_number はセルの列番号を返します

この入力は必須です。

index​

コンボボックスで表示されるデフォルトオプションを指定する Integer です。開始値は0です（最初のオプション > index = 0）。

この入力は必須です。

value​

選択したセルに表示されるコンテンツを指定する String、List of String、List of Integer、List of Double 型です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def get_table_cell_value(dlg,name,cell):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if cellvector.size()>0:
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number)
        dlg.set_item_text(name="Textbox4",text=value_cell)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Get Value",layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",
        col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",
        col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",
        col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")   
    dlg.generate_window()
    dlg.on_table_sel_changed(name="Table1",callfunc=get_table_cell_value)
    dlg.set_cell_value(name="Table1",row=0,col=0,value="Option1")
    dlg.set_cell_value(name="Table1",
        row=1,col=0,value=["Option2","Option3"])
    dlg.set_cell_value(name="Table1",row=0,col=1,value="1")
    dlg.set_cell_value(name="Table1",row=1,col=1,value=[2,3])
    dlg.set_cell_value(name="Table1",row=0,col=2,value="1.5")
    dlg.set_cell_value(name="Table1",cell=TableCellID(1,2),value=[2.5,3.5,4.5], index=1) 

if __name__=='__main__':
    main()
