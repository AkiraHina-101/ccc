# POST_DATA_VIZ_OPT_ANIMATION

POST_DATA_VIZ_OPT_ANIMATION

Description​

A data type is used to set up the result settings for displaying the animation.

Attributes​

iMode​

An Integer specifying the animation mode.

0: Single

1: Multiple

2: Multi-Analysis

The default value is 0.

iFPS​

An Integer specifying specifying the animation speed.

The default value is 8.

iFrameNumber​

An Integer specifying the number of frames between initial state and deformed state.

The default value is 8.

iDivideMethod​

An Integer specifying the dividing method between initial state and maximum deformation.

0: Linear

1: Sine

The default value is 1.

iLoopType​

An Integer specifying the behavior type of the animation.

0: One Way

1: Go & Return

2: Cycle

The default value is 1.

iAnimationResultType​

An Integer specifying the animation result type.

The default value is 0.

bApplyDeform​

A Boolean specifying to apply the deformation when playing the animation.

The default value is True.

bLocus​

A Boolean specifying whether to use locus option.

The default value is False.

bPhaseAngle​

A Boolean specifying whether to modify phase angle value.

The default value is False.

bAcousticCombine​

A Boolean specifying whether to use acoustic combination.

The default value is False.

ilSubcaseIds​

A List of Integer specifying the subcase IDs.

The default value is [].

bMultiAnalysis​

A Boolean specifying whether to use multi-analysis mode.

The default value is False.

bMemCache​

A Boolean specifying whether to use memcache option.

The default value is True.

bFixContour​

A Boolean specifying whether to fix the contour at the last result during animation playback.

The default value is False.

iSectionMode​

An Integer specifying the animation type during cross section display.

0: Euler Display

1: Lagrange display

The default value is 0.

bSetTime​

A Boolean specifying whether to set the animation playback range by time.

The default value is False.

dStartTime​

A Double specifying the start time of the animation playback

The default value is 0.0.

dEndTime​

A Double specifying the end time of the animation playback

The default value is 0.0.
