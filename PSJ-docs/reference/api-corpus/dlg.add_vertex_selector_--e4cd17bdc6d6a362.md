# dlg.add_vertex_selector()

dlg.add_vertex_selector()

Description​

Add "Vertex" to the selection list, allowing user to select vertexes and store the selected vertexes to the selection list.

Syntax​

dlg.add_vertex_selector(...)

Inputs​

This function does not require any input value.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_vertex_selector()
    dlg.generate_window()

if __name__=='__main__':
    main()
