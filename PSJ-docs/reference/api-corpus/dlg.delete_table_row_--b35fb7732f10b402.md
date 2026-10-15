# dlg.delete_table_row()

dlg.delete_table_row()

説明​

表内の特定の位置にある行を削除します。

構文​

dlg.delete_table_row(...)

入力​

name​

表の名前を指定する String です。

この入力は必須です。

position​

削除する行の位置を指定する Integer です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

コード例​

from pyjdg import *

def on_menu(dlg,name,menu):
    sel_ranges=dlg.get_table_sel_range(name="Table1")
    if sel_ranges.size()>0:
        position=sel_ranges[0].top
    dlg.delete_table_row(name="Table1",position=position)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",menus=["Delete Row"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
