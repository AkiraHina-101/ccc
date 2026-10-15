# JPT.MessageBoxPSJ()

JPT.MessageBoxPSJ()

Description​

Show a Jupiter dialog (Information, Warning).

Syntax​

JPT.MessageBoxPSJ(messageContent, messageBoxType)

Inputs​

messageContent​

A String specifying the message which will be shown on the created message box.

This is a required input.

messageBoxType​

An Enum specifying the MsgBoxType describing the type of creating message box in Jupiter.

This is a required input.

Return Code​

The selected option (YES, NO, OK, CANCEL).

Sample Code​

# Show an information message box
returnValue = JPT.MessageBoxPSJ("Test dialog",JPT.MsgBoxType.MB_INFORMATION_OK)
JPT.Debugger(returnValue) # Return a string object with value = OK
