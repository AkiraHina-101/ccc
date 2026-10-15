# TableColumnInfoVector

TableColumnInfoVector

説明​

テーブル列情報クラスのインスタンス、または列のメソッドを指定する TableColumnInfo のリストの TableColumnInfoVector クラスのインスタンスです。

入力​

TableColumnInfoVector オブジェクトを作成するには、TableColumnInfoVector() で変数を定義します。

メソッド​

 | メソッド | 説明

 | append() | リストの末尾に要素を追加します

 | clear() | リストからすべての要素を削除し、空にします

 | size() | リストのサイズを返します

 | extend() | 指定されたベクターのすべての要素をリストの末尾に追加します

サンプルコード​

from pyjdg import *

def on_right_click_menu(dlg,name,menu):
    JPT.ClearLog()
    #TableColumnInfoVector のインスタンスを作成
    col_vector = TableColumnInfoVector()
    col_vector_2 = TableColumnInfoVector()
    col_1 = TableColumnInfo(name="Heading1",type="String")
    #メソッド
    if menu == "Append":
        print("Append() 呼び出し前の TableColumnInfoVector のサイズ:", col_vector.size()) #サイズ: 0
        col_vector.append(col_1)
        print("Append() 呼び出し後の TableColumnInfoVector のサイズ:",col_vector.size()) #サイズ: 1
    elif menu == "Extend":
        col_vector.append(col_1)
        col_vector_2.append(TableColumnInfo(name="Heading2",type="Integer"))
        print("Extend() 呼び出し前の TableColumnInfoVector のサイズ:", col_vector.size()) #サイズ: 1
        col_vector.extend(col_vector_2)
        print("Extend() 呼び出し後の TableColumnInfoVector のサイズ:", col_vector.size()) #サイズ: 2
    elif menu == "Clear":
        col_vector.append(col_1)
        col_vector_2.append(TableColumnInfo(name="Heading2",type="Integer"))
        col_vector.extend(col_vector_2)
        print("Clear() 呼び出し前の TableColumnInfoVector のサイズ:", col_vector.size()) #サイズ: 2
        col_vector.clear()
        print("Clear() 呼び出し後の TableColumnInfoVector のサイズ:", col_vector.size()) #サイズ: 0

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
