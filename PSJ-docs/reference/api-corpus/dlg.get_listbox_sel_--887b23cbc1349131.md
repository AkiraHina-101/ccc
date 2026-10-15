# dlg.get_listbox_sel()

dlg.get_listbox_sel()

Description​

Get the index of the selecting ListBox option.

Syntax​

dlg.get_listbox_sel(...)

Inputs​

name​

A String specifying the name of the ListBox component.

This is a required input.

Return Code​

An Integer specifying the index of the being selected ListBox option.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,0,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_listbox(name="ListBox2",options=["item1","item2","item3","item4","item5"],
        width=100,height=150,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_listbox_sel(name="ListBox2",option=3)
    listBoxPos=dlg.get_listbox_sel(name="ListBox2")
    print(listBoxPos)

if __name__=='__main__':
    main()
