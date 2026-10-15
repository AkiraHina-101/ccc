# IntelliSense

IntelliSense

Introduction​

IntelliSense is a code-completion aid that includes a number of features: List Members, Parameter Info, Quick Info, and Complete Word. These features help you to learn more about the code you're using, keep track of the parameters you're typing, and add calls to properties and methods with only a few keystrokes.

You can use IntelliSense for PSJ modules by setting up environment of VSCode.

Setting instruction​

Install Python extension for Visual Studio Code. It can installed via Extension

Prepare a workspace for your python environment.

Create a folder and open it by VSCode.

Prepare a file below with name psjsetting, and put it under your python workspace.

Modify <user> to your user name.

PYTHONPATH=C:\Users\<user>\AppData\Roaming\TechnoStar\JPT5.1.0\PythonLib\Lib;C:\Users\<user>\AppData\Roaming\TechnoStar\JPT5.1.0\PythonLib\Lib\site-packages;C:\Users\<user>\AppData\Roaming\TechnoStar\JPT5.1.0\PythonLib\DLLs;

Create .vscode folder under your workspace folder. Place a file below with name settings.json, and put it in there.

{
     "python.envFile": "${workspaceFolder}/psjsetting"
 }

Then the work space will be:

Your Folder/
├── .vscode/
│   └──settings.json
├── psjsetting
├── Test.py

Create your script under your folder. Write "import JPT" at top of python file enables to use IntelliSense.
