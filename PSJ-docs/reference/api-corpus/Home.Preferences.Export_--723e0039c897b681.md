# Home.Preferences.Export()

Home.Preferences.Export()

Description​

Export settings of Preferences (.json file).

Syntax​

Home.Preferences.Export(...)

Macro: ExportPreferenceSettings

Ribbon: Home » Preferences » Export

Inputs​

strPath​

A String specifying export file path.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Home.Preferences.Export("C:/temp/DCADPreference.json")
