# dlg.on_dlg_cancel()

dlg.on_dlg_cancel()

Description​

Execute a created function when Cancel button is clicked.

Syntax​

dlg.on_dlg_cancel(...)

Inputs​

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_button_Cancel_clicked(dlg):
    print("Cancel button is clicked")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True,include_apply=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Please click on Cancel button!",layout="Layout1")
    dlg.generate_window()
    dlg.on_dlg_cancel(callfunc=on_button_Cancel_clicked)

if __name__=='__main__':
    main()
