# dlg.enable_drag_table_row()

dlg.enable_drag_table_row()

Description​

Enable to drag table rows to upward/downward.

Syntax​

dlg.enable_drag_table_row(...)

Inputs​

name​

A String specifying the name of the Table component.

This is a required input.

enable​

A Boolean specifying the state of dragging table row (upward/downward).

True: enable to drag the table row

False: disable to drag the table row

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,columns=["String","Integer","Double"],
                layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")   
    dlg.generate_window()
    dlg.set_cell_value(name="Table1",row=0,col=0,value="Option1")
    dlg.set_cell_value(name="Table1",row=1,col=0,value=["Option2","Option3"])
    dlg.set_cell_value(name="Table1",row=0,col=1,value="1")
    dlg.set_cell_value(name="Table1",row=1,col=1,value=[2,3])
    dlg.set_cell_value(name="Table1",row=0,col=2,value="1.5")
    dlg.set_cell_value(name="Table1",row=1,col=2,value=[2.5,3.5])
    dlg.enable_drag_table_row(name="Table1",enable=True)
if __name__=='__main__':
    main()
