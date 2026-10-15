# dlg.set_table_cell_text_color()

dlg.set_table_cell_text_color()

説明​

選択した/指定したセルのテキストに色を設定します。

構文​

dlg.set_table_cell_text_color(...)

入力​

name​

テーブルの名前を指定する String 。

この入力は必須です。

cell​

テーブル内のセルの位置を指定する TableCellID オブジェクト。

指定しない場合、選択したすべてのセルが使用されます。

color​

色を指定する Integer 。

指定しない場合、ユーザーが選択するためのカラーピッカーダイアログが開きます。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_menu(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name)
    if menu=="Set Text Color for all selected cells using color picker":
        dlg.set_table_cell_text_color(name="Table1")
    elif menu=="Set Text Color only for a selected cell using color picker":
         dlg.set_table_cell_text_color(name="Table1",
            cell=cellvector[0])
    elif menu=="Set Text Color only for a selected cell with red color":
        dlg.set_table_cell_text_color(name="Table1",
            cell=cellvector[0],color=7105764)
    elif menu=="Set Text Color only for the first cell with red color":
        dlg.set_table_cell_text_color(name="Table1",
            cell=TableCellID(row=0,col=0),color=7105764)
    elif menu=="Set Text Color only for the first 2x2 cells with red color":
        [[dlg.set_table_cell_text_color(name="Table1",
            cell=TableCellID(row=i,col=j),color=7105764)
            for i in (0,1)] for j in (0,1)]

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
        menus=["Set Text Color for all selected cells using color picker",
        "Set Text Color only for a selected cell using color picker",
        "Set Text Color only for a selected cell with red color",
        "Set Text Color only for the first cell with red color",
        "Set Text Color only for the first 2x2 cells with red color"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
