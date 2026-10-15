# dlg.get_table_cell_fill_color()

dlg.get_table_cell_fill_color()

説明​

選択された/指定されたセルの塗りつぶし色を取得します。

構文​

dlg.get_table_cell_fill_color(...)

入力​

name​

テーブルの名前を指定する String です。

これは必須の入力です。

row​

セルの水平方向の位置を指定する Integer です（0から開始）。

これは必須の入力です。

col​

セルの垂直方向の位置を指定する Integer です（0から開始）。

これは必須の入力です。

戻り値​

Jupiterでの色コードを指定する Integer です。

サンプルコード​

from pyjdg import *

def on_menu(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name="Table1")
    if menu=="Get cell color":
        colorCell = dlg.get_table_cell_fill_color(name="Table1", 
            row=cellvector[0].row_number,
            col=cellvector[0].col_number)
        print("選択されたセルの塗りつぶし色は次の通りです： " + str(colorCell))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2","Heading3"],
        layout="Window",show_row_number=True,width=350,height=160)
    dlg.add_label(name="Labe2",text="右クリックして選択したセルから「セルの色を取得」を選択してください",
        width=350,layout="Window")
    for i in range(3):
        dlg.set_table_column_width("Table2", i, 100)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_table_right_menu(name="Table1",
        menus=["Get cell color"])
    dlg.generate_window()
    dlg.set_table_cell_fill_color(name="Table1",
            cell=TableCellID(row=0,col=0),color=7105764)
    dlg.set_table_cell_fill_color(name="Table1",
            cell=TableCellID(row=0,col=1),color=255)
    dlg.set_table_cell_fill_color(name="Table1",
            cell=TableCellID(row=0,col=2),color=0)
    colorValue=JPT.ConvertRGBToJPTColor(255,255,0)
    for i in range(1,3):
        for j in range(0,3):
            dlg.set_table_cell_fill_color(name="Table1",
                cell=TableCellID(row=i,col=j),color=colorValue)
            colorValue+=100000
    dlg.on_table_right_menu(name="Table1",callfunc=on_menu)

if __name__=='__main__':
    main()
