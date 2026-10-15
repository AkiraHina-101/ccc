# Properties.Section.Delete()

Properties.Section.Delete()

Description​

Delete the create property sections in 1D properties section library.

Syntax​

Properties.Section.Delete(...)

Ribbon: Properties » Section » Delete

Inputs​

crlSections​

A List of Cursor specifying the list of property sections will be deleted.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Properties.Section.AddGeneral(strName="abc", 
                              iSecGenType=2, 
                              dDsecGensizeT1=0.02)

creating_status = Properties.Section.Delete(crlSections=[SectionGeneral(1)])

JPT.Debugger(creating_status)
