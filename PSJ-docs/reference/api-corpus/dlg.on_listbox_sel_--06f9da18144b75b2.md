# dlg.on_listbox_sel()

dlg.on_listbox_sel()

Description​

Run a created function after a ListBox item is selected.

Syntax​

dlg.on_listbox_sel(...)

Inputs​

name​

A String specifying the name of the ListBox component using for binding a created def function.

This is a required input.

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_listbox_item_changed(dlg):
    JPT.ClearLog()
    listBoxPos=dlg.get_listbox_sel(name="ListBox2")
    listBoxName=dlg.get_listbox_option(name="ListBox2", option_index=listBoxPos)
    dlg.set_item_text(name="TextBox5", text=listBoxName)
    print('The selected list box item is: ', str(listBoxName))

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_listbox(name="ListBox2",options=["item1","item2","item3","item4","item5"],width=100,height=120,
        layout="Window")
    dlg.set_item_size_behavior(name="ListBox2",behavior=size_behavior.fixed)
    dlg.add_layout(name="Layout3",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label4",text="Selected Item",width=70,text_halign="left",text_valign="top",
        layout="Layout3")
    dlg.add_textbox(name="TextBox5",width=100,layout="Layout3")
    dlg.generate_window()
    dlg.on_listbox_sel(name="ListBox2", callfunc=on_listbox_item_changed)
if __name__=='__main__':
    main()
