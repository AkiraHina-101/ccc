# dlg.add_imagectrl()

dlg.add_imagectrl()

Description​

Add a frame to put an image to the creating dialog.

Syntax​

dlg.add_imagectrl(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

image_file​

A String specifying the location of an image to display as default.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    image = JPT.GetProgramPath() + \
        r"SampleData\PSJ\PSJ-GUI\CreateBolt\CreatingBolt_Pics\M30.JPG"
    dlg.add_imagectrl(name="ImageCtrl",image_file=image,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
