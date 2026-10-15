# TemperatureLoadGeneral

TemperatureLoadGeneral TemperatureLoadGeneral Description create temperature load by constant value Syntax TemperatureLoadGeneral(string strName, double dTemperature, cursor crTable, cursor[] taTarget, cursor crEdit, bool bUseAsMaterialReferenceTemp) Inputs String Name of temperature load Double Temperature value Cursor Select table Cursor[] Targets Cursor Edit cursor Bool Use as material reference temperature bool flag True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code TemperatureLoadGeneral("TemperatureLoadsConstant1", 303.15, 0:0, [6:21], 0:0, 0)
