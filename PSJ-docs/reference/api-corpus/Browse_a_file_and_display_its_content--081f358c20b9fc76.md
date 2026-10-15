# Browse a file and display its content

Browse a file and display its content

🎯 Introduction​

In this tutorial, you'll learn how to use dlg.add_browser() to select a file and display the selected file's content inside a RichEditCtrl:

Create an Open File/Folder and a RichEditCtrl.

Display the file's content to the RichEditCtrl after user selects a file.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def set_to_rich_text(dlg, path_list):
    write_to_rich_text = ""
    for path in path_list:
        write_to_rich_text += path + "\n"
    dlg.set_item_text(name='selected_files',text=write_to_rich_text)

def main():
    dlg=JDGCreator(title="BrowserDemo",resizable=True,validation=True)
    dlg.add_browser(name="select_files",mode="file",file_filter="All Files(*.*)",
        multisel=True,layout="Window")
    dlg.add_richeditbox(name="selected_files",text="",width=200,height=200,layout="Window")
    dlg.add_label(name="Label3",text="Browser accepts a function that has 2 parameters: " \
        "one is dlg and another is a string list, which returns selected files",width=600,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_browse(name="select_files",callfunc=set_to_rich_text)

if __name__=='__main__':
    main()
