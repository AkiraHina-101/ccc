# NASTRAN_PSD_DATA

NASTRAN_PSD_DATA

Description​

A data type uses to Defines load set power spectral density factors for use in random analysis having the frequency dependent form.
Sjk=(X+iY)G(F)S_{jk} = (X + iY)G(F)Sjk​=(X+iY)G(F)

Attributes​

iMasterID​

An Integer specifying the Subcase identification number of the excited load set.

The default value is 0.

iSlaveID​

An Integer specifying the Subcase identification number of the applied load set.

The default value is 0.

dRealX​

A Double specifying the real part of the complex number.

The default value is 1.0.

dImagY​

A Double specifying the imaginary part of the complex number.

The default value is 0.0.

iTableID​

An Integer specifying the Identification number of a TABRNDi entry that defines G(F).

The default value is 0.0.
