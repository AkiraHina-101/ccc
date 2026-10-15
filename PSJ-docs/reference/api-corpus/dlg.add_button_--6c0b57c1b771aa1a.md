# dlg.add_button()

dlg.add_button()

Description​

Add a Button to the creating dialog. The Button can be an image Button.

Syntax​

dlg.add_button(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

text​

A String specifying text which will be displayed on the Button.

The default value is "".

width​

An Integer specifying the width of the Button.

The default value is 0.

height​

An Integer specifying the height of the Button.

The default value is 0.

img​

A String specifying the path of an image to be displayed on the Button.

The default value is "".

location​

A String specifying the location of an image to be displayed on the Button.

The default value is "left".

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

TechnoStarImage = JPT.GetProgramPath() + "SampleData/PSJ/PSJ-Utility/Utils/TechnoStar.ico"

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_button(name="Button3",text="Button",width=60,height=22,layout="Layout2")
    dlg.add_button(name="Button4",text="Button",width=60,height=22,img=TechnoStarImage,
        location="left",layout="Layout2")
    dlg.add_button(name="Button5",text="Button",width=60,height=22,img=TechnoStarImage,
        location="right",layout="Layout2")
    dlg.add_button(name="Button6",text="Button",width=60,height=22,img=TechnoStarImage,
        location="top",layout="Layout2")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
