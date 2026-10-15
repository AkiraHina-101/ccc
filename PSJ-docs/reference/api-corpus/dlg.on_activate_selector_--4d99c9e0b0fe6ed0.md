# dlg.on_activate_selector()

dlg.on_activate_selector()

Description​

Run a created function after a selector is activated.

Syntax​

dlg.activate_selector(...)

Inputs​

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_node_selector_clicked(dlg):
    dlg.activate_selector(0)

def on_part_selector_clicked(dlg):
    dlg.activate_selector(1)

def on_activate_selector(dlg,selector_id):
    if selector_id==0:
       dlg.set_radiobutton_state("RadioButton3",True)
       dlg.set_radiobutton_state("RadioButton4",False)
    else :
       dlg.set_radiobutton_state("RadioButton4",True)
       dlg.set_radiobutton_state("RadioButton3",False)

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_label(
            name="Label2",width=200,height=80,
            text="Open the selection list.\n" 
                 "Confirm that selector focus changes when radio buttons are selected,"
                 "and conversely, that radio button selection changes when selectors are focused.",
            text_halign="left",text_valign="top",layout="Window")
    dlg.add_node_selector()
    dlg.add_part_selector()
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_radiobutton(name="RadioButton3",text="Node",layout="Layout2",checked=True)
    dlg.add_radiobutton(name="RadioButton4",text="Part",layout="Layout2")
    dlg.generate_window()
    dlg.on_button_clicked("RadioButton3",on_node_selector_clicked)
    dlg.on_button_clicked("RadioButton4",on_part_selector_clicked)
    dlg.on_activate_selector(on_activate_selector)

if __name__=='__main__':
    main()
