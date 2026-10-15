# dlg.add_textbox()

dlg.add_textbox()

Description​

Add a Textbox to the creating dialog.

Syntax​

dlg.add_textbox(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

text​

A String specifying text which will be displayed.

The default value is "".

readonly​

A Boolean specifying the read-only state of Textbox is used or not.
True: The text is read-only state. It can't be editable.

False: The text can be edited manually.

The default value is False.

width​

An Integer specifying the width of the Textbox.

The default value is 0.

height​

An Integer specifying the height of the Textbox.

The default value is 0.

text_align​

A String specifying the text position which will be displayed.
"Left": align text to left side.

"Center": center text to the middle.

"Right": align text to right side.

The default value is "Left".

type​

A String specifying the data type for the Textbox:
"string": input values are in the String format.

"double": input values are in the Double format.

"integer": input values are in the Integer format.

The default value is "string".

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="String Type",width=100,text_halign="left",text_valign="top",layout="Layout2")
    dlg.add_textbox(name="TextBox4",width=150,height=25,readonly=True,
        text="TechnoStar",type="string",text_align="left",layout="Layout2")
    dlg.add_layout(name="Layout6",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label7",text="String Type",width=100,text_halign="left",text_valign="top",layout="Layout6")
    dlg.add_textbox(name="TextBox8",width=150,height=25,readonly=False,
        text="12345",type="string",text_align="left",layout="Layout6")
    dlg.add_layout(name="Layout9",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label10",text="Integer Type",width=100,text_halign="left",text_valign="top",layout="Layout9")
    dlg.add_textbox(name="TextBox11",width=150,height=25,readonly=False,
        text="TechnoStar",type="integer",text_align="center",layout="Layout9")
    dlg.add_layout(name="Layout12",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label13",text="Integer Type",width=100,text_halign="left",text_valign="top",layout="Layout12")
    dlg.add_textbox(name="TextBox14",width=150,height=25,readonly=True,
        text="12345",type="integer",text_align="center",layout="Layout12")
    dlg.add_layout(name="Layout15",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label16",text="Double Type",width=100,text_halign="left",text_valign="top",layout="Layout15")
    dlg.add_textbox(name="TextBox17",width=150,height=25,readonly=False,
        text="TechnoStar",type="double",text_align="right",layout="Layout15")
    dlg.add_layout(name="Layout18",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label19",text="Double Type",width=100,text_halign="left",text_valign="top",layout="Layout18")
    dlg.add_textbox(name="TextBox20",width=150,height=25,readonly=True,
        text="12345.123",type="double",text_align="right",layout="Layout18")
    dlg.generate_window()

if __name__=='__main__':
    main()
