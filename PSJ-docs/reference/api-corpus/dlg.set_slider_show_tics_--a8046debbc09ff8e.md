# dlg.set_slider_show_tics()

dlg.set_slider_show_tics()

Description​

Show tick marks of the SliderBar.

Syntax​

dlg.set_slider_show_tics(...)

Inputs​

name​

A String specifying the name of the SliderBar.

This is a required input.

enabled​

A Boolean specifying the state of the slider's tick mark:
True: show all the tick mark.

False: hide all the tick mark.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_slider(name="Slider3",width=100,height=30,min=0,max=100,pos=0,layout="Layout1")
    dlg.set_slider_show_tics(name="Slider3",enabled=False)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
