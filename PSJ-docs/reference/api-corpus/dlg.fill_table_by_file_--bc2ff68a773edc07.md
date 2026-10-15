# dlg.fill_table_by_file()

dlg.fill_table_by_file()

説明​

CSVファイルでテーブルにデータを書き込みます。

構文​

dlg.fill_table_by_file(...)

入力​

name​

テーブルの名前を指定する String です。

この入力は必須です。

file​

CSVファイルへのパスリンクを指定する String です。

この入力は必須です。

delimiter​

CSVファイル内の値（またはフィールド）を区切るのに使用する文字を指定する String です。

デフォルト値は ',' です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_command(dlg):
    filePath=dlg.get_item_text(name="Browser3")
    dlg.fill_table_by_file(name="Table5",file=filePath,delimiter=" ")

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_layout(name="Layout2",orientation=orientation.vertical,layout="Window")
    samplePath = JPT.GetProgramPath() + \
        "SampleData\\PSJ\\PSJ-GUI\\RenumberID\\RenumberID_Sample\\RenumberID.csv"
    dlg.add_browser(name="Browser3",mode="file",file_filter=".csv",default=samplePath,layout="Layout2")
    dlg.add_button(name="Button4",text="Fill Table Data",width=80,height=22,bk_color=15790320,layout="Layout2")
    dlg.add_table(name="Table5",width=350,height=250,columns=["Heading1","Heading2","Heading3"],
        rows=10,layout="Layout2")
    dlg.add_label(name="Label6",text="Specify a CSV file and click Fill Table Data button to fill data to Table",
        width=350,text_halign="left",text_valign="top",layout="Window")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button4",callfunc=on_command)

if __name__=='__main__':
    main()
