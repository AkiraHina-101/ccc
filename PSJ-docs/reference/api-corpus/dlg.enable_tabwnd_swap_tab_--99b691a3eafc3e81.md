# dlg.enable_tabwnd_swap_tab()

dlg.enable_tabwnd_swap_tab()

Description​

Set to enable/disable swap the tab items in a tabwnd.

Syntax​

dlg.dlg.set_item_visible(...)

Inputs​

name​

A String specifying the name of the TabWnd.

This is a required input.

enable​

A Boolean specifying whether to enable/disable swap the tab items:

True: Enable to swap.

False: Disable to swap.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *
def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_tabwnd(name="TabWnd10",width=200,height=200,layout="Window")
    dlg.enable_tabwnd_swap_tab(name="TabWnd10", enable=False)
    dlg.add_tabwnd_page(name="TabWnd10",page_name="TabItem11",page_text="TabItem1")
    dlg.add_tabwnd_page(name="TabWnd10",page_name="TabItem12",page_text="TabItem2")
    dlg.add_tabwnd_page(name="TabWnd10",page_name="TabItem13",page_text="TabItem3")
    dlg.generate_window()
if __name__=='__main__':
    main()
