# Properties.Section.Import()

Properties.Section.Import()

Description​

Import 1D Section from the XML file into the section library.

Syntax​

Properties.Section.Import(...)

Ribbon: Properties » Section » Import

Inputs​

strPath​

A String specifying the path leads to the 1D section file will be imported.

The is a require input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

from os import environ

Properties.Section.AddGeneral(strName="Section_1", 
                              iSecGenType=2, 
                              dDsecGensizeT1=0.02)

path = environ["Temp"] + r"/TechnoStar/Section_Export_File.xml"

Properties.Section.Export(strPath = path)
Properties.Section.Delete(crlSections=[SectionGeneral(1)])

result = Properties.Section.Import(strPath=path)

JPT.Debugger(result)
