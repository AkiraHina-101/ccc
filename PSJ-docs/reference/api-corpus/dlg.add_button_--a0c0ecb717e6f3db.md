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

text_color​

An Integer specifying the text color.

The default value is 0.

bk_color​

An Integer specifying the background color.

The default value is 15790320.

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
    font_Button3=PSJFont()
    font_Button3.size=10
    font_Button3.bold=True
    font_Button3.italic=False
    font_Button3.underline=False
    font_Button3.strikeout=False
    dlg.set_item_font(name="Button3",font=font_Button3)
    dlg.add_button(name="Button4",text="Button",width=60,height=22,bk_color=65535,
        text_color=255,img=TechnoStarImage,location="left",layout="Layout2")
    font_Button4=PSJFont()
    font_Button4.size=10
    font_Button4.bold=False
    font_Button4.italic=True
    font_Button4.underline=False
    font_Button4.strikeout=False
    dlg.set_item_font(name="Button4",font=font_Button4)
    dlg.add_button(name="Button5",text="Button",width=60,height=22,bk_color=65535,
        text_color=255,img=TechnoStarImage,location="right",layout="Layout2")
    font_Button5=PSJFont()
    font_Button5.size=10
    font_Button5.bold=False
    font_Button5.italic=False
    font_Button5.underline=True
    font_Button5.strikeout=False
    dlg.set_item_font(name="Button5",font=font_Button5)
    dlg.add_button(name="Button6",text="Button",width=60,height=22,bk_color=65535,
        text_color=255,img=TechnoStarImage,location="top",layout="Layout2")
    font_Button6=PSJFont()
    font_Button6.size=10
    font_Button6.bold=True
    font_Button6.italic=True
    font_Button6.underline=True
    font_Button6.strikeout=False
    dlg.set_item_font(name="Button6",font=font_Button6)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
