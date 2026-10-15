# Home.CopyToClipboard()

Home.CopyToClipboard()

Description​

Save the current display window of Jupiter to the clipboard.

Syntax​

Home.CopyToClipboard(...)

Ribbon: Home » CopyToClipboard

Inputs​

bWhiteBG​

A Boolean specifying whether to set background color to white.

The default value is False.

bTransparentBG​

A Boolean specifying whether to set background color to transparent.
This option can only takes effect when export image is .png extension. Also, it cannot be used when bWhiteBG is set to True.

The default value is False.

bFixedSize​

A Boolean specifying whether to make the size of export image fixed.
If this parameter is True, the image will be exported with size specified in iExportWidth and iExportHeight.
If this parameter is False, the size of the export image is the same as the size of the view window.

The default value is False.

iWidth​

An Integer specifying the width of the export image.

The default value is 1200.

iHeight​

An Integer specifying the height of the export image.

The default value is 900.

Return Code​

A Boolean specifying the status of the process:

True: The current display window of Jupiter is saved to clipboard.

False: The current display window cannot be saved to clipboard.

Sample Code​

copy = Home.CopyToClipboard(bWhiteBG=False,
                            bTransparentBG=False,
                            bFixedSize=False,
                            iWidth=1200,
                            iHeight=900)

JPT.Debugger(copy)
