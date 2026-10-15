# POST_DATA_VIZ_OPT_CONTOUR

POST_DATA_VIZ_OPT_CONTOUR

Description​

A data type is used to set up the result settings for displaying the contour.

Attributes​

iColorDivision​

An Integer specifying the number of contour range divisions.

The default value is 10.

iContourType​

An Integer specifying the contour type.

0: Continuous

1: Step

2: Iso Surface

The default value is 1.

iMaxMinType​

An Integer specifying the Max/Min type to display by contour.

0: Visible Entity

1: Total Entity

2: User Define

3: Multiple Result

The default value is 0.

dMaxUser​

A Double specifying the maximum value of contour by user.

The default value is 1000.0.

dMinUser​

A Double specifying the minimum value of contour by user.

The default value is -1000.0.

dMaxTotal​

A Double specifying the maximum value of contour in total

The default value is 1000.0.

dMinTotal​

A Double specifying the minimum value of contour in total.

The default value is -1000.0.

dIsoVolumeScalar​

A Double specifying the .

The default value is 0.0.

iSpectrumType​

An Integer specifying the color pattern of the contour.

The default value is 2 (Rainbow Spectrum).

iUpperColor​

An Integer specifying the upper color of contour.

The default value is 255.

iLowerColor​

An Integer specifying the lower color of contour.

The default value is 16711680.

iFrameColor​

An Integer specifying the frame color of contour.

The default value is 65535.

dlCustomColors​

A List of Double specifying the custom colors.

The default value is [].

dlCustomColorValues​

A List of Double specifying the custom color values.

The default value is [100,90,80,70,60,50,40,30,20,10,0].

iLogType​

An Integer specifying the log type for displaying.

0: None

1: LogE

2: Log10

3: SPL

The default value is 0.

bShowBlankValueAs0​

A Boolean specifying whether to show blank value as 0 or a specified color.

The default value is False.

bOptimizedShape​

A Boolean specifying whether to use optimization toolkit.

The default value is False.

bGururiContour​

A Boolean specifying whether to display Gururi contour.

The default value is False.

bAutoSetAmplitudeValue​

A Boolean specifying whether to set amplitude value in automatically.

The default value is False.

iBlankValueColor​

An Integer specifying the color to show for blank value.

The default value is 8421504.

iInterpolateMethod​

An Integer specifying the interpolation method.

0: Fixed

1: Interpolate

The default value is 0.

ilInterpolateInfo​

An List of Integer specifying the interpolation information.

The default value is [-1, -1, -1].
