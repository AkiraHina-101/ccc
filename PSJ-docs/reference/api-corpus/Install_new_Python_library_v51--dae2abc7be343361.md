# Install new Python library v51

Install new Python library v51

🎯 Introduction​

In this tutorial, you'll learn how to extend PSJ capability by installing new Python library which is not installed by default:

Install new Python library using pip.

Check if new library is already installed.

Try running PSJ using new installed library.

📖 Tutorial​

Prepare below .bat file and execute it on your machine:

set PYTHONLIB=%APPDATA%\TechnoStar\JPT5.1.0\PythonLib\Lib
set PYTHONPACKAGE=%PYTHONLIB%\site-packages
set PYTHONDLL=%APPDATA%\TechnoStar\JPT5.1.0\PythonLib\DLLs

set PYTHONHOME=C:\Program Files\TechnoStar\Jupiter_5.1
set PYTHONPATH=%PYTHONHOME%;%PYTHONLIB%;%PYTHONPACKAGE%;%PYTHONDLL%
"%PYTHONHOME%\python.exe" -m pip install -t "%PYTHONPACKAGE%" <package_name>

For example, if you want to install plotly library to Jupiter v5.1, prepare below .bat file and double click the file.

set PYTHONLIB=%APPDATA%\TechnoStar\JPT5.1.0\PythonLib\Lib
set PYTHONPACKAGE=%PYTHONLIB%\site-packages
set PYTHONDLL=%APPDATA%\TechnoStar\JPT5.1.0\PythonLib\DLLs

set PYTHONHOME=C:\Program Files\TechnoStar\Jupiter_5.1
set PYTHONPATH=%PYTHONHOME%;%PYTHONLIB%;%PYTHONPACKAGE%;%PYTHONDLL%
"%PYTHONHOME%\python.exe" -m pip install -t "%PYTHONPACKAGE%" -U plotly

You can check if plotly has been installed by using below command in Jupiter built-in IDE.

import plotly
print(plotly.__version__)

You can also try testing PSJ with plotly using below sample:

import plotly.graph_objects as go
from plotly.subplots import make_subplots

# Equation of ring cyclide
# see https://en.wikipedia.org/wiki/Dupin_cyclide
import numpy as np
a, b, d = 1.32, 1., 0.8
c = a**2 - b**2
u, v = np.mgrid[0:2*np.pi:100j, 0:2*np.pi:100j]
x = (d * (c - a * np.cos(u) * np.cos(v)) + b**2 * np.cos(u)) / (a - c * np.cos(u) * np.cos(v))
y = b * np.sin(u) * (a - d*np.cos(v)) / (a - c * np.cos(u) * np.cos(v))
z = b * np.sin(v) * (c*np.cos(u) - d) / (a - c * np.cos(u) * np.cos(v))

fig = make_subplots(rows=1, cols=2,
                    specs=[[{'is_3d': True}, {'is_3d': True}]],
                    subplot_titles=['Color corresponds to z', 'Color corresponds to distance to origin'],
                    )

fig.add_trace(go.Surface(x=x, y=y, z=z, colorbar_x=-0.07), 1, 1)
fig.add_trace(go.Surface(x=x, y=y, z=z, surfacecolor=x**2 + y**2 + z**2), 1, 2)
fig.update_layout(title_text="Ring cyclide")
fig.show()
