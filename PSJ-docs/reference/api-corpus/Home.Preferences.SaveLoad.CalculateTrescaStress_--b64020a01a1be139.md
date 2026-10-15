# Home.Preferences.SaveLoad.CalculateTrescaStress()

Home.Preferences.SaveLoad.CalculateTrescaStress()

Description​

Calculate the Tresca Stress automatically when the result file is opened.

Syntax​

Home.Preferences.SaveLoad.CalculateTrescaStress(...)

Macro: SetDisplayPostAssemblyTree

Ribbon: Home » Preferences » SaveLoad » CalculateTrescaStress

Inputs​

bUseTrescaStress​

A Boolean specifying whether to use Tresca Stress calculation.

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Home.Preferences.SaveLoad.CalculateTrescaStress(bUseTrescaStress = False)
