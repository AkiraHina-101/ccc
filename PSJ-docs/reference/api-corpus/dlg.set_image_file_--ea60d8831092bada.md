# dlg.set_image_file()

dlg.set_image_file()

Description​

Set an image to the ImageCtrl.

Syntax​

dlg.set_image_file(...)

Inputs​

name​

A String specifying the name of the ImageCtrl component.

This is a required input.

image_path​

A String specifying the full path of the image.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def onChangeButtonClicked(dlg):
    new_pic = JPT.GetProgramPath() + r"SampleData\PSJ\PSJ-GUI\CreateBolt\CreatingBolt_Pics\M4.JPG"
    dlg.set_image_file(name="ImageCtrl",image_path=new_pic)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    image = JPT.GetProgramPath() + \
        r"SampleData\PSJ\PSJ-GUI\CreateBolt\CreatingBolt_Pics\M3.JPG"
    dlg.add_imagectrl(name="ImageCtrl",image_file=image,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ChangePic",text="Change",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ChangePic",callfunc=onChangeButtonClicked)

if __name__=='__main__':
    main()
