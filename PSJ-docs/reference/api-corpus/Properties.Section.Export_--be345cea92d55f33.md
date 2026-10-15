# Properties.Section.Export()

Properties.Section.Export()

Description​

Export the created 1D section to the XML file.

Syntax​

Properties.Section.Export(...)

Ribbon: Properties » Section » Export

Inputs​

strPath​

A String specifying the path to save the exported file.

This is a require input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

from os import environ

Properties.Section.AddGeneral(strName="Section_1", 
                              iSecGenType=2, 
                              dDsecGensizeT1=0.02)

path = environ["Temp"] + r"\TechnoStar\Section_Export_File.xml"

exporting_status = Properties.Section.Export(strPath = path)

JPT.Debugger(exporting_status)
