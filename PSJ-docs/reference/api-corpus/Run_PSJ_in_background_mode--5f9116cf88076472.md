# Run PSJ in background mode

Run PSJ in background mode

🎯 Introduction​

In this tutorial, you'll learn how to run PSJ script in background mode (command line):

Open Jupiter with UI and run PSJ (foreground mode), with UTF-8 or SJIS encoding.

Open Jupiter without UI and run PSJ (background mode), with UTF-8 or SJIS encoding.

Operations related to view, graphic, log cannot work in background mode.

📖 Tutorial​

From Command Prompt window, you can use following command to display all Jupiter command line options:

"C:\Program Files\TechnoStar\Jupiter_5.0\Start_It.bat" -help

The result should be displayed as below:

---

Jupiter Command Line
(c) TechnoStar Co. Ltd.

---

--[ Help ]--
Syntax: Start_it.bat [drive:][path][filename(.jpl/.py)] [-help/-?] [-b] [-mcr] [-py] [-t] [-sjis]
[-help] [-?] : Displays Jupiter Command Line Help
[-b] : Runs Jupiter on the background (No GUI)
[-mcr] : Runs Jupiter .JPL macro file
[-py] : Runs Jupiter .PY Python script file
[-t] : Displays the total execution time
[-sjis] : Read macro/python file as sjis

To run a Python script file (*.py) with Jupiter UI launching (foreground mode), you can use the following command:

"C:\Program Files\TechnoStar\Jupiter_5.0\Start_It.bat" -py "\path_to_file\file.py"

To run with SJIS encoding:

"C:\Program Files\TechnoStar\Jupiter_5.0\Start_It.bat" -py -sjis "\path_to_file\file.py"

To run a Python script file (*.py) without Jupiter UI launching (background mode), you can use the following command:

"C:\Program Files\TechnoStar\Jupiter_5.0\Start_It.bat" -b -py "\path_to_file\file.py"

To run with SJIS encoding:

"C:\Program Files\TechnoStar\Jupiter_5.0\Start_It.bat" -b -py -sjis "\path_to_file\file.py"
