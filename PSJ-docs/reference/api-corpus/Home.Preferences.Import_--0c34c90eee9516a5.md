# Home.Preferences.Import()

Home.Preferences.Import()

Description​

Export settings of Preferences (.json file).

Syntax​

Home.Preferences.Import(...)

Macro: ImportPreferenceSettings

Ribbon: Home » Preferences » Import

Inputs​

strPath​

A String specifying import file path.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Home.Preferences.Import("C:/temp/DCADPreference.json")
