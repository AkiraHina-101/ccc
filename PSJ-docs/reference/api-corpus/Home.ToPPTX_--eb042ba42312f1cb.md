# Home.ToPPTX()

Home.ToPPTX()

Description​

Save the display window of Jupiter to an image file in pptx.

Syntax​

Home.ToPPTX(...)

Ribbon: Home » ToImage

Inputs​

bAutoCapture​

A Boolean to specify whether crop image to the displayed entity range.

The default value is False.

listAdjust​

A list of Integer specifying the left, top, right and bottom margins from the minimized area.

The default value is [0,0,0,0]

Return Code​

A Boolean specifying the status of the process:

True: The display window of Jupiter is saved to an image file in pptx.

False: The display window of Jupiter cannot be saved to an image file in pptx.

Sample Code​

Geometry.Part.Cube()
JPT.DisableScreenAnimation()
JPT.ViewFitToModel()

copy_paste = Home.ToPPTX()

JPT.Debugger(copy_paste)

export_status = Home.ToPPTX(bAutoCapture=True, 
                            listAdjust=[10,20,10,20])

JPT.Debugger(copy_paste)
