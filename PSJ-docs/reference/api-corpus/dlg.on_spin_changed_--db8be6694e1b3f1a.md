# dlg.on_spin_changed()

dlg.on_spin_changed()

Description​

Run a created function after a spin value is changed.

Syntax​

dlg.on_spin_changed(...)

Inputs​

name​

A String specifying the name of the Spin component using for binding a created def function.

This is a required input.

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_spin_changed(dlg,old_value,new_value):
    total_rows=dlg.get_total_row(name="Table6")
    if new_value is None:
        new_rows=int(dlg.get_item_text(name="Spin4"))
    elif new_value >= 0:
        new_rows=new_value
    if new_rows >= total_rows:
        dlg.insert_table_rows(name="Table6",row_num=int(new_rows-total_rows))
    else:
        if new_rows >= 1:
            for idx in range (new_rows, total_rows):
                dlg.delete_table_row(name="Table6",position=new_rows)
    if new_value >= 1:
        print("Current number of rows is: "+ str(new_value))
    else:
        print("Current number of rows is: "+ str(new_value+1))

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Number of Rows",width=80,
        text_halign="left",text_valign="top",layout="Layout2")
    dlg.add_spin(name="Spin4",min=1,max=10,pos=5,increment=1,layout="Layout2")
    dlg.add_layout(name="Layout5",orientation=orientation.vertical,layout="Window")
    dlg.add_table(name="Table6",width=350,height=300,columns=["Heading1","Heading2","Heading3"],
        rows=5,layout="Layout5")
    dlg.generate_window()
    dlg.on_spin_changed(name="Spin4",callfunc=on_spin_changed)

if __name__=='__main__':
    main()
