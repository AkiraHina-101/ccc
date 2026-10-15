# dlg.add_slider()

dlg.add_slider()

Description​

Add a SliderBar to the creating dialog.

Syntax​

dlg.add_slider(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

width​

An Integer specifying the width of the SliderBar.

The default value is 60.

height​

An Integer specifying the height of the SliderBar.

The default value is 22.

min​

An Integer specifying the minimum value of the SliderBar.

The default value is 0.

max​

An Integer specifying the maximum value of the SliderBar.

The default value is 100.

pos​

An Integer specifying the initial position of the scroller.

The default value is 0.

vertical​

A Boolean specifying the direction of the SliderBar:
True: creating SliderBar will be put in the vertical direction.

False: creating SliderBar will be put in the horizontal direction.

The default value is False.

show_ticks​

A Boolean specifying the state of the slider's tick mark:
True: show all the tick mark.

False: hide all the tick mark.

The default value is True.

show_border​

A Boolean specifying the state of the slider's border:
True: show outside border of the creating SliderBar.

False: hide outside border of the creating SliderBar.

The default value is False.

show_bothticks​

A Boolean specifying the way to display tick mark:
True: show tick mark on both side of the SliderBar.

False: show tick mark on one side only of the SliderBar.

The default value is False.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_slider(name="Slider21",width=100,height=100,min=0,max=100,pos=4,
      vertical=True,show_bothticks=True,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
