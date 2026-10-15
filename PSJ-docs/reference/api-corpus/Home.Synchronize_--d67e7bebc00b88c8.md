# Home.Synchronize()

Home.Synchronize()

Description​

Enable/Disable the synchronize function between documents.

Syntax​

Home.Synchronize(...)

Ribbon: Home » Synchronize

Inputs​

This function does not contains any input values.

Return Code​

A Boolean specifying the status of the process:

True: The windows are synchronized.

False: Synchronizing mode is disabled.

Sample Code​

synchronize = Home.Synchronize()

JPT.Debugger(synchronize)
