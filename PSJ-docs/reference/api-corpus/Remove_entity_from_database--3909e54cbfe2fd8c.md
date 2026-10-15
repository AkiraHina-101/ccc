# Remove entity from database

Remove entity from database

🎯 Introduction​

In this tutorial, you'll learn how to remove entity from database by multiple ways:

Load sample model at installed Jupiter path into Jupiter.

Remove all Loads and Boundary Conditions from database.

Remove 'LOCAL SETTING' entity by name.

Remove 'BODY' entity by id.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get installed jupiter, sample path. Load sample model into Jupiter.
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
samplePath = jupiterPath + '/SampleData/PSJ/PSJ-Utility/JtdbSample/EntityModel.jtdb'
FileMenu.LoadJTDB(samplePath)

# Fit view of model on display view
JPT.ViewFitToModel()

# Remove all Load and Boundary Conditions from database
JPT.RemoveAllLoadsBCs()

# Get list of all 'LOCAL_SETTING' entity in model
# Remove local mesh setting by specific name
listLocalSetting = JPT.GetAllByType(JPT.DItemType.LOCAL_SETTING)
for localSetting in listLocalSetting:
    if localSetting.name == "MeshParam_1":
        JPT.RemoveEntitiesByID(JPT.DItemType.LOCAL_SETTING, localSetting.id)

# Remove 'BODY' entity / part by id 1
JPT.RemoveEntitiesByID(JPT.DItemType.BODY, 1)
