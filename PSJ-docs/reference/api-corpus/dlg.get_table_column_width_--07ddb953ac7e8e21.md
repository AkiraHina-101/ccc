# dlg.get_table_column_width()

dlg.get_table_column_width()

説明​

テーブル内の指定された列の幅を取得します。

構文​

dlg.get_table_column_width(...)

入力​

name​

テーブルの名前を指定する String 。

この入力は必須です。

col​

列の順序を指定する Integer （0から始まる）。

この入力は必須です。

戻り値​

入力されたテーブル内の指定されたセルの幅の値を示す Integer 。

サンプルコード​

from pyjdg import *

def on_menu(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if menu=="Set Column Width using Dialog":
        dlg.set_table_column_width(name="Table1",
            col=cellvector[0].col_number)
    if menu=="Set Column Width equal 400":
        dlg.set_table_column_width(name="Table1",
            col=cellvector[0].col_number,width=400)
    elif menu=="Get Column Width":
        col_width = dlg.get_table_column_width(name="Table1",
            col=cellvector[0].col_number)
        print("Column "+str(cellvector[0].col_number)+
            " width is: "+str(col_width))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",
        menus=["Set Column Width using Dialog",
        "Set Column Width equal 400","Get Column Width"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
