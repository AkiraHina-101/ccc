# TemperatureLoadNastran

TemperatureLoadNastran TemperatureLoadNastran Description create temperature load by nastran punch file Syntax TemperatureLoadNastran(string strName, string strFilePathName, cursor crTable, cursor[] taTarget, cursor crEdit, bool bUseAsMaterialReferenceTemp) Inputs String name of temperature load String file path Cursor select table Cursor[] targets Cursor edit cursor Bool if use as material reference temperature Return Code 1 Succeeded 0 Failed Sample Code TemperatureLoadNastran("TemperatureLoadsPunch1", "D:/ImportFile/1_heat.pch", 0:0, [], 0:0, 0)
