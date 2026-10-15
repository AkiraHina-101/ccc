# JPT.EnableLicenseFeature()

JPT.EnableLicenseFeature()

Description​

Enable/Disable a license feature which is existing in the current Jupiter.

Syntax​

JPT.EnableLicenseFeature("licenseFeatureName", BoolType)

Inputs​

licenseFeatureName​

A String specifying the name of Jupiter license which is existing in the current Jupiter.

The Jupiter license's name can be found at Home » Preference » License.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the enable state of license:

True: Enable the license.

False: Disable the license.

This is a required input.

ヒント

You also can input 1 instead of inputting JPT.BoolType.TRUE_VAL,
or input 0 instead of inputting JPT.BoolType.FALSE_VAL.

Return Code​

This utility function does not have output value.

Sample Code​

# Disable license JPT_BASE
JPT.EnableLicenseFeature("JPT_BASE",
                         JPT.BoolType.FALSE_VAL)
# Or
# JPT.EnableLicenseFeature("JPT_BASE", 0)

# Enable license JPT_BASE
JPT.EnableLicenseFeature("JPT_BASE",
                         JPT.BoolType.TRUE_VAL)
# Or
# JPT.EnableLicenseFeature("JPT_BASE", 1)
