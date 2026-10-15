# TemperatureLoad

TemperatureLoad TemperatureLoad Description create temperature load Syntax TemperatureLoad(String m_strName,int nType,double fTemp,String strFilePathName,Cursor crTable,Cursor[] m_taTarget,Cursor m_crEdit,BOOL bUseAsMaterialReferenceTemp) Inputs String name of temperature load int type[0:Constant; 1:Nastran Punch] double value of temperature String file path Cursor select table Cursor[] targets Cursor edit cursor BOOL if use as material reference temperature Return Code 1 Succeeded 0 Failed Sample Code TemperatureLoad("Test",1,0.001,"Test",1:11,[1:11,2:12],1:11,1)
