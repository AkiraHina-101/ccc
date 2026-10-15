# TableCellRangeVector

TableCellRangeVector

説明​

TableCellRangeVectorクラスのインスタンスもしくはセル範囲メソッドを指定するTableCellRangeのリスト。

入力​

TableCellRangeVectorオブジェクトを作成するには、TableCellRangeVector()で変数を定義します。

メソッド​

 | メソッド | 説明

 | append() | リストの末尾に要素を追加します。

 | clear() | リストからすべての要素を削除し、空にします。

 | size() | リストのサイズを返します。

 | extend() | 指定されたベクトルのすべての要素をリストの末尾に追加します。

サンプルコード​

from pyjdg import *

def on_right_click_menu(dlg,name,menu):
    JPT.ClearLog()
    # TableCellRangeVectorのインスタンス作成
    range_vector = TableCellRangeVector()
    range_vector_2 = TableCellRangeVector()
    range_1 = TableCellRange(left=1,top=2,right=3,bottom=4)
    # メソッド
    if menu == "Append":
        print("Append()前のTableCellRangeVectorのサイズ:", range_vector.size()) #サイズ: 0
        range_vector.append(range_1)
        print("Append()後のTableCellRangeVectorのサイズ:",range_vector.size()) #サイズ: 1
    elif menu == "Extend":
        range_vector.append(range_1)
        range_vector_2.append(TableCellRange(left=1,top=3,right=4,bottom=5))
        print("Extend()前のTableCellRangeVectorのサイズ:", range_vector.size()) #サイズ: 1
        range_vector.extend(range_vector_2)
        print("Extend()後のTableCellRangeVectorのサイズ:", range_vector.size()) #サイズ: 2
    elif menu == "Clear":
        range_vector.append(range_1)
        range_vector_2.append(TableCellRange(left=1,top=3,right=4,bottom=5))
        range_vector.extend(range_vector_2)
        print("Clear()前のTableCellRangeVectorのサイズ:", range_vector.size()) #サイズ: 2
        range_vector.clear()
        print("Clear()後のTableCellRangeVectorのサイズ:", range_vector.size()) #サイズ: 0

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=10,
        columns=["Heading1","Heading2","Heading3","Heading4","Heading5","Heading6"],
        layout="Window",width=700,height=260)
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
