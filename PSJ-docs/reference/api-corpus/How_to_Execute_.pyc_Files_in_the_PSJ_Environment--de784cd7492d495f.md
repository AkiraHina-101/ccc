# How to Execute .pyc Files in the PSJ Environment

How to Execute .pyc Files in the PSJ Environment

1. Prepare the .py File​

Import all necessary PSJ modules.

Example: check.py

import JPT
import Geometry

Geometry.Part.Cube()
JPT.ViewFitToModel()
faces = JPT.GetAllFaces()
for face in faces:
    JPT.SelectionByID(JPT.EntityType.FACE, face.id, True)

2. Compile the .py File to .pyc​

Example command:

"C:\Program Files\TechnoStar\Jupiter_5.0.3\python.exe" -m py_compile C:\Temp\check.py

A folder named __pycache__ will be created in the same location as check.py, and a file named check.cpython-39.pyc will be generated inside it.

3. Create a Script (Exec.py) to Execute the .pyc​

# Load and execute the .pyc file
import importlib.util
spec = importlib.util.spec_from_file_location("module", r"C:\Temp\__pycache__\check.cpython-39.pyc")

module = importlib.util.module_from_spec(spec)
# Execute the module using exec_module
try:
    spec.loader.exec_module(module)
except Exception as e:
    print(f"An error occurred: {e}")

4. Run Exec.py​

It can be executed from an IDE, batch file, launcher, or the Jupiter ribbon.

5. Notes​

Use the python.exe located directly under the Jupiter installation directory to compile .py → .pyc.

Standard output is overridden, so print statements do not work after .pyc compilation. In such cases, use JPT.MsgOut().

Example: check_print.py

import JPT
import Geometry

Geometry.Part.Cube()
JPT.ViewFitToModel()
faces = JPT.GetAllFaces()
for face in faces:
    JPT.SelectionByID(JPT.EntityType.FACE, face.id, True)

JPT.MsgOut(f'A cube is created and all the {len(faces)} faces are selected.')

Exec.py

import importlib.util
import sys

# Load and execute the .pyc file
spec = importlib.util.spec_from_file_location("module", r"C:\Temp\__pycache__\check_print.cpython-39.pyc")
module = importlib.util.module_from_spec(spec)

# Execute the module using exec_module
try:
    spec.loader.exec_module(module)

except AttributeError as e:
    print(f"Error during module execution: {e}")
except Exception as e:
    print(f"An unexpected error occurred: {e}")

The if __name__ == '__main__': block will not be executed. If necessary, explicitly call module.main().

Example: Exec.py

try:
    spec.loader.exec_module(module)
    module.main()
except Exception as e:
    print(f"An error occurred: {e}")

For importing PSJ Command modules, ensure to import each module used in your script. For example, if using a PSJ Command for surface meshing:

import Meshing

Note that some functions may not work properly when compiled to .pyc.
