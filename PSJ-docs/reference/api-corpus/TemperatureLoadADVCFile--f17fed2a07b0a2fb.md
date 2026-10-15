# TemperatureLoadADVCFile

TemperatureLoadADVCFile TemperatureLoadADVCFile Description create temperature load by advc file Syntax TemperatureLoadADVCFile(string strName, string strFilePathName, cursor crTable, cursor[] taTarget, cursor crEdit) Inputs String name of temperature load String file path Cursor select table Cursor[] targets Cursor edit cursor Return Code 1 Succeeded 0 Failed Sample Code TemperatureLoadGeneral("TemperatureLoadsConstant1", 303.15, 0:0, [6:21], 0:0, 0)
