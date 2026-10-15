# dlg.get_cell_label()

dlg.get_cell_label()

説明​

テーブル内のボタンセル、チェックボックスセル、またはコンボボックスセルのラベルを取得します。

構文​

dlg.get_cell_label(...)

入力​

name​

テーブルコンポーネントの名前を指定する String です。

必須入力です。

row​

セルの水平方向の位置を指定する Integer です（0から開始）。

必須入力です。

column​

セルの垂直方向の位置を指定する Integer です（0から開始）。

必須入力です。

戻り値​

入力されたセルのラベルを指定する String です。

サンプルコード​

from pyjdg import *

def on_cell_button_clicked(dlg,name,cell):
    JPT.ClearLog()
    cellvector=dlg.get_table_sel_cell(name="Table2")
    if cellvector.size() > 0:
        if dlg.is_table_cell_combobox(name="Table2",cell=cellvector[0]):
            combobox_label= dlg.get_cell_label(name="Table2",
                row=cellvector[0].row_number,col=cellvector[0].col_number)
            print("選択したコンボボックスのラベルは：" + combobox_label)
        elif dlg.is_table_cell_button(name="Table2",cell=cellvector[0]):
            button_label= dlg.get_cell_label(name="Table2",
                row=cellvector[0].row_number,col=cellvector[0].col_number)
            print("選択したボタンのラベルは：" + button_label)
        elif dlg.is_table_cell_checkbox(name="Table2",cell=cellvector[0]):
            checkbox_label= dlg.get_cell_label(name="Table2",
                row=cellvector[0].row_number,col=cellvector[0].col_number)
            print("選択したチェックボックスのラベルは：" + checkbox_label)
        else:
            print("選択したセルにはラベルがありません")

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
    dlg.set_cell_value(name="Table2",
        row=0,col=0,
        value=["Option1","Option2","Option3"])
    dlg.set_table_cell_button(name="Table2",
        row=0,col=1,text="Button")
    dlg.set_table_cell_checkbox(name="Table2",row=1,
        col=0,text="Checkbox",checked=True)
    dlg.on_table_sel_changed(name="Table2",
        callfunc=on_cell_button_clicked)

if __name__=='__main__':
    main()
