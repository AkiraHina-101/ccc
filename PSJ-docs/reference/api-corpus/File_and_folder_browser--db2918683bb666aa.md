# File and folder browser

File and folder browser

🎯 Introduction​

In this tutorial, you'll learn how to make a file and folder browser using dlg.add_browser():

The dialog has 3 browsers:

File browser with default path "C:\Program Files (x86)".

Folder browser.

File browser with extension filter.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

def main():
    dlg=JDGCreator(title="Browser Sample",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox1",text="File Browser",layout="Window")
    dlg.add_label(name="Label2",text="File browser with default path",layout="GroupBox1")
    dlg.add_browser(name="Open File/Folder3",mode="file",file_filter="All Files(*.*)", \
        default="C:\Program Files (x86)",layout="GroupBox1")
    dlg.add_groupbox(name="GroupBox4",text="Folder Browser",layout="Window")
    dlg.add_browser(name="Open File/Folder5",mode="folder",file_filter="All Files(*.*)",layout="GroupBox4")
    dlg.add_groupbox(name="GroupBox6",text="File Browser with Filter",layout="Window")
    dlg.add_label(name="Label7",text="Filter format: description(extension;extension). " \
        "For example: InpFiles(*.inp), txt files(*.txt;*.text)",layout="GroupBox6")
    dlg.add_browser(name="Open File/Folder8",mode="file",
        file_filter="Inp Files(*.inp),Txt Files(*.txt;*.text), All Files(*.*)",layout="GroupBox6")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
