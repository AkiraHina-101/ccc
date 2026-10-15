# JPT.GetProgramVersion()

JPT.GetProgramVersion()

Description​

Get all the version information of the current Jupiter application.

Syntax​

JPT.GetProgramVersion()

Inputs​

This utility function does not require any input value.

Return Code​

A VersionInfo object specifying a List containing the version, revision information of the current Jupiter application, including:

Major

Minor

Sub

Build.

Sample Code​

# Get the version information of the current Jupiter
version = JPT.GetProgramVersion()
print(f"Jupiter {version.major}.{version.minor}.{version.sub}")
print(f"Revision {version.build}")
