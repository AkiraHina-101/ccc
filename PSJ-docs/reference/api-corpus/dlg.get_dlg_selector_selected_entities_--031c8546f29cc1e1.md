# dlg.get_dlg_selector_selected_entities()

dlg.get_dlg_selector_selected_entities()

Description​

Get selected DItem in current Selection List.

Syntax​

dlg.get_dlg_selector_selected_entities(...)

Inputs​

selid​

A Integer specifying the index of the selector.

This is a required input.

Return Code​

A DItemVector object specifying the list of picked items.

Sample Code​

from pyjdg import *

def display_selected_entities(dlg):
    str_nodes = ""
    for n in dlg.get_dlg_selector_selected_entities(selid=0):
        str_nodes += 'Selected Node ID: ' + (str(n.id)) + ',\n'
        dlg.set_item_text(name="selected_nodes",text=str_nodes)

def main():
    dlg=JDGCreator(title="Picking Sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Display all selected nodes",layout="Window")
    dlg.add_label(name="Label2",text="Please select nodes and click Display Nodes button",layout="GroupBox1")
    dlg.add_button(name="display_nodes",text="Display Nodes",layout="GroupBox1")
    dlg.add_richeditbox(name="selected_nodes",text="",width=200,height=200,layout="GroupBox1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_node_selector()
    dlg.add_node_selector()
    dlg.generate_window()
    dlg.on_command(name="display_nodes",callfunc=display_selected_entities)

if __name__=='__main__':
    main()
