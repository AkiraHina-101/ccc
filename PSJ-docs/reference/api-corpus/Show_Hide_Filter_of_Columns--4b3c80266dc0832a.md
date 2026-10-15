# Show/Hide Filter of Columns

Show/Hide Filter of Columns

🎯 Introduction​

In this tutorial, you'll learn how to show hide filter option of columns in table:

Show/Hide Filter by TableColumnInfo(): Show and hide filter of columns in table by controling TableColumnInfo() object.

Show/Hide Filter by dlg.enable_table_column_filter(): Show and hide filter of columns in table by using API dlg.enable_table_column_filter().

Show/Hide Filter by TableColumnInfo()

Show/Hide Filter by dlg.enable_table_column_filter()

📖 Tutorial​

Show/Hide Filter by TableColumnInfo()

Show/Hide Filter by dlg.enable_table_column_filter()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    column_vector=TableColumnInfoVector()
    column_vector.add(TableColumnInfo(name="Heading1",type="string",filter=True))
    column_vector.add(TableColumnInfo(name="Heading2",type="string",filter=True))
    dlg.add_table(name="Table2",rows=5,
        columns=column_vector,
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table2",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.enable_table_column_filter(name="Table2",col=0,enable=True)
    dlg.enable_table_column_filter(name="Table2",col=1,enable=True)
    dlg.generate_window()

if __name__=='__main__':
    main()
