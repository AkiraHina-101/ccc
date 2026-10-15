# DPostResultCurve

DPostResultCurve

Description​

This is an instance of a DPostResultCurve class, represents a Post Result Curve inside Jupiter.

Properties​

 | Attribute | Description

 | allData | The curve data table. The table data is represented by columns and the column titles are in order: frequency, amplitude, phase, real and imagine.
The return value is list double vector.

 | id | The ID of the curve.
The return value is ID (int).

 | rowCount | The number of row of the curve data table.
The return value is number of row (int).

 | colCount | The number of column of the curve data table.
The return value is number of column (int).

 | typeID | The type ID of response curve.
The return value is an int notation of PostResultCurve.

 | curveType | The type of response curve .
The return value is a string of response curve type (str).

 | frequency | The column data of frequency. This attribute is only used for Frequency response.
The return value is a double vector of frequency.

 | amplitude | The column data of amplitude corresponds to the frequency column. This attribute can be used for both Frequency response and Transient response.
The return value is a double vector of amplitude.

 | phase | The column data of phase corresponds to the frequency column. This attribute is only used for Frequency response.
The return value is a double vector of phase.

 | real | The column data of real corresponds to the frequency column. This attribute is only used for Frequency response.
The return value is a double vector of real.

 | imagine | The column data of imagine corresponds to the frequency column. This attribute is only used for Frequency response.
The return value is a double vector of imagine.

 | time | The column data of time corresponds to the frequency column. This attribute is only used for Transient response.
The return value is a double vector of time.
