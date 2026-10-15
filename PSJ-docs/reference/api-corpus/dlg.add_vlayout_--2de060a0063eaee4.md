# dlg.add_vlayout()

dlg.add_vlayout()

Description​

Add a vertical Layout to the creating dialog.

Syntax​

dlg.add_vlayout(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

margin​

A List specifying all the value defining the positions of the creating layout.
The list of positions is defined in the order of [left,top,right,bottom].

The default value is [].

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_vertex_selector()
    dlg.add_vlayout(name="footer",margin=[0,0,0,20],layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
