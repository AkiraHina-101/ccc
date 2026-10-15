# dlg.add_spin()

dlg.add_spin()

Description​

Add a Spin to the creating dialog.

Syntax​

dlg.add_spin(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

min​

An Double specifying the minimum value of the Spin range.
If type is spin.double, the value will be rounded up.

This is a required input.

max​

An Double specifying the maximum value of the Spin range.
If type is spin.double, the value will be rounded up.

This is a required input.

pos​

An Double specifying the initial value (starting position) of the Spin range.
If type is spin.double, the value will be rounded up.

This is a required input.

increment​

An Double specifying the increment step of the Spin.
If type is spin.double, the value will be rounded up.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

type​

An Enum specifying type of Spin:
spin.integer: Integer type

spin.double: Double type

The default value is spin.integer.

precision​

An Integer specifying the precision (number of digits after zero) of the input value.
If type is spin.integer, this input will be ignored.

The default value is 1.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_spin(name="Spin2",min=1,max=100,pos=2,increment=2,layout="Window")
    dlg.add_spin(name="Spin3",type=spin.double,min=0.000000,max=50.000000,pos=1.500000,
        increment=1.500000,precision=3,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
