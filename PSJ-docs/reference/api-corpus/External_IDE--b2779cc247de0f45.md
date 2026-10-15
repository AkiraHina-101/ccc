# External IDE

External IDE

To develop PSJ, user can use Jupiter built-in IDE, other text editor, or Visual Studio Code from Microsoft (called VSCode for short).

Visual Studio Code for PSJ​

Introduction​

VSCode is an open-source text editor, with the ability to install various extensions to make your Python development faster and easier.
Besides all the features of the current Jupiter built-in IDE, VSCode also provides:

A debugger

An AI co-pilot

Linkage to online/local Scripting API document

Linting (Hint for fixing the code)

caution

This is beta version, please do not use for real application.
If you have any feedback or question, please contact us.

Install instruction​

Install VSCode extension for code highlight, suggestion and snippet via this link

Install a Python library for Jupiter-Connection/Debugger using below command (change the link in double quote below if Jupiter was installed in different location):

python -m pip install "C:\Program Files\TechnoStar\Jupiter_5.1.0\tools\jupiterutils-4.0.tar.gz"

In VSCode, before writing PSJ script, remember to import the installed module using from jupiterutils import *
