# JPT.GetJTDBVersion()

JPT.GetJTDBVersion()

Description​

Get all the version information of the current Jupiter file.

Syntax​

JPT.GetJTDBVersion()

Inputs​

This utility function does not require any input value.

Return Code​

A VersionInfo object specifying a List containing the version information of the current Jupiter file, including:

Build

Major

Minor

Sub

Sample Code​

# Get the version information of the current Jupiter
version = JPT.GetJTDBVersion()
JPT.Debugger(version)
