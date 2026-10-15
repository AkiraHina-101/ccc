# dlg.on_dlg_selector_changed()

dlg.on_dlg_selector_changed()

Description​

Run a created function after an item is selected.

Syntax​

dlg.on_dlg_selector_changed(...)

Inputs​

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def display_selected_entities(dlg,sel_list):
    str_node=''
    for n in sel_list:
        str_node += 'Node:' + str(n.id) + ', '
    dlg.set_item_text(name="node",text=str_node)

def main():
    dlg=JDGCreator(title="Picking Sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.add_label(name="infor1",text="This sample illustrates that when you pick an item,",layout="GroupBox1")
    dlg.add_label(name="infor2",text="you can receive it right after that by your own function.",layout="GroupBox1")
    dlg.add_label(name="infor3",text="The function must have 2 parameters, "\
        "one is dlg and another is a list that returned by selection; ",layout="GroupBox1")
    dlg.add_label(name="infor4",text="such as : def displaySelectedEntity(dlg,selList):",layout="GroupBox1")
    dlg.add_groupbox(name="GroupBox2",text="Selected node will be shown here",layout="Window")
    dlg.add_richeditbox(name="node",width=100,height=200,layout="GroupBox2")
    dlg.add_node_selector()
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_dlg_selector_changed(callfunc=display_selected_entities)

if __name__=='__main__':
    main()
