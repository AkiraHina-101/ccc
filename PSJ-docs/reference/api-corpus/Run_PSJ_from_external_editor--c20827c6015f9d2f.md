# Run PSJ from external editor

Run PSJ from external editor

🎯 Introduction​

In this tutorial, you'll learn how to run PSJ code from an external Python editor/IDE when Jupiter interface is running:

From external editor, connect Jupiter to run PSJ.

Directly run PSJ from Notepad++.

This function requires library jupiterutils installed in advance, therefore please install it using pip install psutil

📖 Tutorial​

Sample PSJ script to connect with Jupiter.

# Encoding for Japanese
# coding: cp932

# import PSJ Interpreter
import Utils.PSJ_Interpreter as PSJ

import pathlib

curDir = pathlib.Path(__file__).parent.absolute()

# your python file
psjFilePath = str(curDir) + '/Jupiter_Path_Information.py'

# activeJupiter : set foreground Jupiter GUI
activeJupiter = False

# run a file python
PSJ.RUN_FILE(psjFilePath, False)

# run a block code
PSJ.RUN_CODE('msg = "hello world"\nprint(msg)', True)

If you want to use Notepad++, set this command line to Run function:

"[Jupiter_Installation_Location]]\SampleData\PSJ\PSJ-Utility\Utils\PSJ_Interpreter.bat" False
