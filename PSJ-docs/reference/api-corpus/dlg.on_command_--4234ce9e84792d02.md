# dlg.on_command()

dlg.on_command()

Description​

Bind a created function to a component.

Syntax​

dlg.on_command(...)

Inputs​

name​

A String specifying the name of the component using for binding a created def function.

This is a required input.

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def onApplyButtonClicked(dlg):
    Geometry.Part.Cube()
    print("--- Cube created! ---")

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[80,0,50,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Click on Apply button!",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ButtonApply",callfunc=onApplyButtonClicked)

if __name__=='__main__':
    main()
