# Write selected entities to CSV

Write selected entities to CSV

🎯 Introduction​

In this tutorial, you'll learn how to write information of selected faces from Jupiter model to CSV file:

Import csv module.

Get list of selected faces entity from user selection in Jupiter.

Write related information of selected faces to CSV file.

Before running the script, you need to prepare the model and select some faces in the model

📖 Tutorial​

# Import csv module
import csv

# Clear the log message in Python API window
JPT.ClearLog()

# Get list of selected faces entity from user selection in Jupiter
listFaces = JPT.GetSelectedFaces()

# Write related information of selected faces to CSV file
with open(r"D:/facelist.csv", "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["No.", "ID", "Entity", "Part", "Information", "X", "Y", "Z"])
    i = 0
    for face in listFaces:
        i = i + 1
        listPart = JPT.GetEntitiesByAssociation(JPT.DItemType.FACE, JPT.AssociateType.AS_BODY, face.id)
        writer.writerow([i, str(face.id), "Face", listPart[0].name])
    print("Finished")
