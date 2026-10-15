# Capture image without screen effect

Capture image without screen effect

🎯 Introduction​

In this tutorial, you'll learn how to capture model image without screen effect:

Take a screenshot of the current viewed model and output to a *.jpg file.

Disable screen update, screen animation and message output to Macro/Python API window to improve PSJ performance.

Notice

Avoid using JPT.Disable... functions in a loop.

Once disabled, it will affect until it is enabled again.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

import time
import os
start = time.time()

# Turn off output message to Macro and Python API windows
# It will be automatically enabled again after PSJ finishes running
JPT.DisableOutputMessage()

# Disable screen animation (It is necessary when you capture model on the Visualization window)
# It will be automatically enabled again after PSJ finishes running
JPT.DisableScreenAnimation()

# Prepare a cube
Geometry.Part.Cube()

# Capture model image and output it to your local folder
JPT.ViewFitToModel()
strDesktopPath = os.path.join(os.path.join(os.environ['USERPROFILE']), 'Desktop')
strImagePath = strDesktopPath + "/cube_image.jpg"
Home.ToImage(strImgPath=strImagePath)

# Collapse assembly tree window to avoid GUI update
JPT.CollapseAssemblyTree()

# Start transaction point
JPT.BeginDatabaseTransaction("Change element color operation")

# Change color of all elements
for elem in JPT.GetAllElems():
    elem.color = JPT.GetRandomJPTColor()

# End transaction point
JPT.EndDatabaseTransaction()

# Capture the current model image and output it to your local folder
strNewImagePath = strDesktopPath + "/cube_new_image.jpg"
Home.ToImage(strImgPath=strNewImagePath)

# Enable screen animation
JPT.EnableScreenAnimation()

# Turn on output message to Macro and Python API windows
JPT.EnableOutputMessage()

# Get the execution time
elapsed_time = time.time() - start
print('Time Total: ' + str(elapsed_time) +'s')
