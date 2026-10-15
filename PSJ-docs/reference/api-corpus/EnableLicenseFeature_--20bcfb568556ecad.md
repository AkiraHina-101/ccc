# EnableLicenseFeature()

EnableLicenseFeature()

Description​

Turn ON / OFF indicated license.

Syntax​

EnableLicenseFeature(String License, int Status)

Inputs​

1. String​

License feature shown in Home > Preference > License.

2. Int​

1: Turn ON the license feature.

0: Turn OFF the license feature.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

EnableLicenseFeature("JPT_ANNAS", 0)
