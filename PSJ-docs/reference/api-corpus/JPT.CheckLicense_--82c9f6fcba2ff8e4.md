# JPT.CheckLicense()

JPT.CheckLicense()

Description​

Check whether the inputted license is activated or not.

Syntax​

JPT.CheckLicense("Feature")

Inputs​

Feature​

A String specifying the Jupiter license's name.

The Jupiter license's name can be found at Home » Preference » License.

This is a required input.

Return Code​

A Boolean specifying the status of license:

True: License feature is activated.

False: License feature is deactivated.

Sample Code​

# Get the status of the JPT_BASE feature license and print to the screen
lic = JPT.CheckLicense("JPT_BASE")
print(lic)
