# dlg.on_dlg_help()

dlg.on_dlg_help()

Description​

Execute a created function when Help button is clicked.

Syntax​

dlg.on_dlg_help(...)

Inputs​

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_button_Help_clicked(dlg):
    print("Help button is clicked")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True,include_apply=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Please click on Help button!",layout="Layout1")
    dlg.generate_window()
    dlg.on_dlg_help(callfunc=on_button_Help_clicked)

if __name__=='__main__':
    main()
