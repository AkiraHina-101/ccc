# JPT.DisableMessageBox()

JPT.DisableMessageBox()

Description​

Disable and set default value of the pop-up message box on screen.

Syntax​

JPT.DisableMessageBox(messageOptionType)

Inputs​

messageOptionType​

An Enum specifying the MessageBoxOptionType describing the message option type to be the default value.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Disable pop-up message and set the default value of message box to be YES
JPT.DisableMessageBox(JPT.MsgBoxOptionType.MB_OPTION_YES)
returnValue = JPT.MessageBoxPSJ("Test dialog",JPT.MsgBoxType.MB_INFORMATION_YESNO)
print(returnValue) # Return a string object with value = YES

# Disable pop-up message and set the default value of message box to be NO
JPT.DisableMessageBox(JPT.MsgBoxOptionType.MB_OPTION_NO)
returnValue = JPT.MessageBoxPSJ("Test dialog",JPT.MsgBoxType.MB_INFORMATION_YESNO)
print(returnValue) # Return a string object with value = NO

# Disable pop-up message and set the default value of message box to be CANCEL
JPT.DisableMessageBox(JPT.MsgBoxOptionType.MB_OPTION_CANCEL)
returnValue = JPT.MessageBoxPSJ("Test dialog",JPT.MsgBoxType.MB_INFORMATION_YESNOCANCEL)
print(returnValue) # Return a string object with value = CANCEL

# Disable pop-up message and set the default value of message box to be OK
JPT.DisableMessageBox(JPT.MsgBoxOptionType.MB_OPTION_OK)
returnValue = JPT.MessageBoxPSJ("Test dialog",JPT.MsgBoxType.MB_INFORMATION_OKCANCEL)
print(returnValue) # Return a string object with value = OK
