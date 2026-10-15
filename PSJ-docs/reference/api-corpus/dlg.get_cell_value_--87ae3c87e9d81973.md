# dlg.get_cell_value()

dlg.get_cell_value()

説明​

テーブルの特定のセルの値を取得します。

構文​

dlg.get_cell_value(...)

入力​

name​

テーブルコンポーネントの名前を指定する String です。

これは必須入力です。

row​

セルの水平方向の位置を指定する Integer です（0から始まります）。

これは必須入力です。

col​

セルの垂直方向の位置を指定する Integer です（0から始まります）。

これは必須入力です。

option​

コンボボックスセル内のインデックス番号を指定する Integer です。

デフォルト値は -1 です（セルの表示内容を取得します）。

戻り値​

入力されたセルの値を指定する String です。

サンプルコード​

from pyjdg import *

def get_table_cell_value(dlg,name,cell):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if cellvector.size()>0:
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number)
        dlg.set_item_text(name="Textbox4",text=value_cell)
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number,option=1)
        dlg.set_item_text(name="Textbox5",text=value_cell)
        value_cell=dlg.get_cell_value(name="Table1",
            row=cellvector[0].row_number,
            col=cellvector[0].col_number,option=2)
        dlg.set_item_text(name="Textbox6",text=value_cell)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="表示される値を取得",width=100,layout="Layout1")
    dlg.add_textbox(name="Textbox4",layout="Layout1")
    dlg.add_layout(name="Layout2",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label4",text="値を取得（option=1）",width=100,layout="Layout2")
    dlg.add_textbox(name="Textbox5",layout="Layout2")
    dlg.add_layout(name="Layout3",margin=[0,0,200,0],
        orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label5",text="値を取得（option=2）",width=100,layout="Layout3")
    dlg.add_textbox(name="Textbox6",layout="Layout3")
    dlg.add_table(name="Table1",rows=5,
        columns=["String","Integer","Double"],
        layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_table_sel_changed(name="Table1",callfunc=get_table_cell_value)
    dlg.set_cell_value(name="Table1",row=0,col=0,
        value=["Option1","Option2","Option3"])

if __name__=='__main__':
    main()
