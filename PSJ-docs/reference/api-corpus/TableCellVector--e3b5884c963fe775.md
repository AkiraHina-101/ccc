# TableCellVector

TableCellVector

説明​

TableCellVector クラスのインスタンス、またはセルのメソッドを指定する [TableCellID](TableCellID) のリストです。

入力​

TableCellVector オブジェクトを作成するには、 TableCellVector() で変数を定義します。

メソッド​

 | メソッド | 説明

 | append() | リストの末尾に要素を追加します。

 | clear() | リストからすべての要素を削除して空にします。

 | size() | リストのサイズを返します。

 | extend() | 指定したベクトルのすべての要素をリストの末尾に追加します。

サンプルコード​

from pyjdg import *

def on_right_click_menu(dlg,name,menu):
    JPT.ClearLog()
    #TableCellVector のインスタンスを作成するため
    cell_vector = TableCellVector()
    cell_vector_2 = TableCellVector()
    cell_1 = TableCellID(row=1,col=2)
    #メソッド
    if menu == "Append":
        print("Append() 呼び出し前の TableCellVector のサイズ:", cell_vector.size()) #サイズ: 0
        cell_vector.append(cell_1)
        print("Append() 呼び出し後の TableCellVector のサイズ:",cell_vector.size()) #サイズ: 1
    elif menu == "Extend":
        cell_vector.append(cell_1)
        cell_vector_2.append(TableCellID(row=3,col=3))
        print("Extend() 呼び出し前の TableCellVector のサイズ:", cell_vector.size()) #サイズ: 1
        cell_vector.extend(cell_vector_2)
        print("Extend() 呼び出し後の TableCellVector のサイズ:", cell_vector.size()) #サイズ: 2
    elif menu == "Clear":
        cell_vector.append(cell_1)
        cell_vector_2.append(TableCellID(row=3,col=3))
        cell_vector.extend(cell_vector_2)
        print("Clear() 呼び出し前の TableCellVector のサイズ:", cell_vector.size()) #サイズ: 2
        cell_vector.clear()
        print("Clear() 呼び出し後の TableCellVector のサイズ:", cell_vector.size()) #サイズ: 0

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
        menus=["Append","Extend","Clear"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="Table1",callfunc=on_right_click_menu)

if __name__=='__main__':
    main()
