# Enable/disable Jupiter's license

Enable/disable Jupiter's license

🎯 Introduction​

In this tutorial, you'll learn how to enable/disable Jupiter's license:

Check status of a specific license JPT_BASE is enable or disable.

Enable license JPT_BASE.

Disable license JPT_BASE.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

# Clear the log message in Python API window
JPT.ClearLog()

# Check status of license JPT_BASE is enable or not
isEnable = JPT.CheckLicense('JPT_BASE')
if isEnable == True:
    print('license JPT_BASE is enable')
else:
    print('license JPT_BASE is disable')

# Enable license JPT_BASE
JPT.EnableLicenseFeature("JPT_BASE", 1)

# Disable license JPT_BASE
JPT.EnableLicenseFeature("JPT_BASE", 0)
