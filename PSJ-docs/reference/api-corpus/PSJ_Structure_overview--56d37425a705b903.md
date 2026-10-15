# PSJ Structure overview

PSJ Structure overview

PSJ is fully featured with tools and utilities, supports user write Python API script for Jupiter with ease:

After Jupiter built-in dialog functions execution, Jupiter will also log out a set of Macro and PSJ-Command to represent the same operations, but in a kind of command language. User can use these commands to rerun the same Jupiter operations.

In case user wants to query model's database information (e.g. model's name, IDs, color, etc.), he/she can make use of PSJ-Utility.

While writing PSJ, user can take advantage of PSJ Customized Shell and Customized IDE to help debug code easier.

The final code can run without a GUI, but if user wants to make it friendlier, PSJ-GUI then can be implemented.

Macro

PSJ-Command

PSJ-Utility

PSJ-GUI

Customized shell

Customized IDE

Macro is equivalent to Jupiter built-in dialog function, but without GUI.

For example:

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0) : Make a cube with default input values

ImprintLineS([[7.8, 0, 10], [2.2, 10, 10]], [6:26], 1) : Imprint a line on a face between 2 points

It is generated right after a dialog function successfully runs.

Macro can be recorded, run, save and reload using the Macro window.
🡆 Read more about Macro

Equivalent to Macro, but PSJ-Command is polished to be compact, easy to write and fully Python compatible.
This new PSJ feature is introduced from Jupiter version 5.

For example:

 | Macro | PSJ-Command

 | CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0) | Geometry.Part.Cube()

 | ImprintLineS([[7.8, 0, 10], [2.2, 10, 10]], [6:26], 1) | Geometry.Edge.Line(dllPoints=[[0.0078, 0, 0.01], [0.0023, 0.01, 0.01]], crlFaces=[Face(26)])

In detail, PSJ-Command has special features:

Functions are named after Class-based format and Jupiter’s ribbon.

Parameters are neglected if the default values are taken.

Easier to read thanks to its explicit definitions.

Has return value which can make the code looks more Pythonic.

Has error handling built-in which can help developer found the bug faster and easier.

Fully supported by our customized IDE or VSCode extensions.

🡆 Read more about PSJ-Command

PSJ-Utility is used for querying model’s information. It is used to complement what is missing from the Macro or PSJ-Command.

For example:

JPT.Debugger(): Console debugger for PSJ. This utility will show all the related information of the inputted value to the Python API window.

JPT.Exec(): Run Jupiter macro

JPT.GetAllParts(): Get information of all parts

PSJ-Utility is written in the form of: JPT.Function_Name(parameters)
🡆 Read more about PSJ-Utility

PSJ-GUI is an UI library supporting user making dialog fast and easily.

For example:

dlg.add_label(name="Label30",text="Average Size",width=100,text_halign="left",text_valign="top",layout="Layout29") : Add a text label

dlg.add_textbox(name="Aver_size",layout="Layout29") : Add a text edit box

Different from other Python UI packages (e.g. PyQT, Tkinter, PySide, etc.), PSJ-GUI is fully integrating into Jupiter’s UI framework,
help making user’s function same look & feel as Jupiter’s built-in dialog function.

PSJ-GUI also supports 2-ways connection, e.g. picking, table, tab/wizard, etc.

GUI Command Builder

is an interactive builder of PSJ-GUI, help making Jupiter dialog or wizard by Drag & Drop operations.
User hence does not need to know Python programming language to make UI components in Jupiter.
🡆 Read more about PSJ-GUI

Customized shell is a Jupiter window displays PSJ output and information, with:

Python API Window: Python commands and execution results are displayed.

Command Line Interface (CLI): user can run Python scripts directly here.
Command input is possible by Copy & Paste.

🡆 Read more about Customized Shell

To write PSJ easier, we developed a Customized IDE with:

Code highlighter

Auto completion

Tooltip for built in function or user-defined function

Group block of script (Collapse/Expand)

🡆 Read more about Customized IDE

 

Built in Python (version 3) compiler

PSJ also including useful Python libraries from Python, e.g. pandas, numpy, matplotlib, pptx, scikit-learn, numba, etc.
And ability to be integrated to Visual Studio Code using our customized extension.
