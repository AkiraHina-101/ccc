# Make use of picking selection

Make use of picking selection

🎯 Introduction​

In this tutorial, you'll learn how to use Selection list for picking items in Jupiter visualization window:

Type 1: Display all being-picked nodes right after picking.

Type 2: Display some being-picked nodes after pressing a button.

Type 1

Type 2

📖 Tutorial​

Type 1

Type 2

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def display_selected_entities(dlg, sel_list):
    selected = JPT.GetSelectedNodes()
    if selected.sizeVec()>0:
        str_node=''
        for n in sel_list:
            str_node += 'Node:' + str(n.id) + ','
        dlg.set_item_text(name="node",text=str_node)
    else:
        dlg.set_item_text(name="node",text="")

def main():
    dlg=JDGCreator(title="Picking Sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="GroupBox",layout="Window")
    dlg.add_label(name="infor1",text="This sample illustrates that when you pick an item,",layout="GroupBox1")
    dlg.add_label(name="infor2",text="you can receive it right now by your own function.",layout="GroupBox1")
    dlg.add_label(name="infor3",text="The function must have 2 parameters, one is dlg and another is a list that returned by selection,",layout="GroupBox1")
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

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def displace_selected_entities(dlg):
    str_nodes = ""
    for n in dlg.get_selected_entities(0):
        str_nodes += 'Selected Node ID: ' + (str(n.id)) + ',\n'
    str_nodes = str_nodes[:-3]
    dlg.set_item_text(name="selected_nodes",text=str_nodes)

def main():
    dlg=JDGCreator(title="Picking Sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="Display all selected nodes",layout="Window")
    dlg.add_label(name="Label2",text="Please select nodes and click Display Nodes button",layout="GroupBox1")
    dlg.add_button(name="display_nodes",text="Display Nodes",layout="GroupBox1")
    dlg.add_richeditbox(name="selected_nodes",text="",width=200,height=200,layout="GroupBox1")
    dlg.add_node_selector()
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="display_nodes",callfunc=displace_selected_entities)

if __name__=='__main__':
    main()
