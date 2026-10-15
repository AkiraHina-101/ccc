# Call and get log from external process

Call and get log from external process

🎯 Introduction​

In this tutorial, you'll learn how to call and get log messages from external process:

Call Jupiter-Post.

Call and get log message from OpenFOAM.

You need to have the applications (Jupiter-Post, OpenFOAM) installed before running below script

📖 Tutorial

import subprocess

# Clear the log message in Python API window
JPT.ClearLog()

# open Jupiter Post
subprocess.call(["C:\Program Files\TechnoStar\Jupiter-Post_4.1.7\PCAD_main.exe"])

# or open by cmd
#import os
#os.system('""C:\Program Files\TechnoStar\Jupiter-Post_4.1.7\PCAD_main.exe""')

# get log messages from exe, you can use it for openfoam application, be noticed at administration problem
process = subprocess.Popen(r"blockMesh.exe -case D:\OpenFoamCase -dict system/blockMeshDict_JPT",
                         stdout=subprocess.PIPE,
                         stderr=subprocess.STDOUT)
openfoam_log = ""
for line in iter(process.stdout.readline, b''):
    openfoam_log += str(line.rstrip()) + "\n";

print(openfoam_log)
