# DYNAMIC_FREQ_ANALYSIS_RESPONSE()

DYNAMIC_FREQ_ANALYSIS_RESPONSE()

Description​

Create response for Frequency response analysis

Syntax​

DYNAMIC_FREQ_ANALYSIS_RESPONSE(cursor ParentAnalysis, cursor Coord, bool AllModesUsed, string[] ModesSelect, bool DampingFactor, double DampingFactor, cursor DampingFactor, int CurStyle, double StyleParamTop, double StyleParamMid, double StyleParamBot, bool IncludeEigenValue, bool CreateNewResult, int ResultType, string[] SelectedResultName, int ResultPos, bool AllCase, cursor SelectedLoadCase, bool SeparateLoad, cursor[] Target, cursor Edit )

1. cursor  ​

Parent analysis

2. cursor  ​

Coordinate

3. int  ​

All Modes Used flag

4. string[]  ​

Selected modes.

5. bool  ​

Damping Factor flag

6. double  ​

Damping Factor.

7. cursor  ​

Damping Factor table

8. int  ​

Input Style

9. double  ​

Analysis Start

10. double  ​

Step Size

11. double  ​

Analysis End

12. bool  ​

Include Value on the Eigen Value position flag

13. bool  ​

Create New Result flag

14. int  ​

Result Type

15. string[]  ​

Names of selected results.

16. int  ​

Result Position

17. cursor  ​

Load case

18. bool  ​

Separate Calculation For Unit Load

19. bool  ​

Target nodes

20. cursor  ​

Target response when modify

Return Code​

Nothing.

Sample Code​

DYNAMIC_FREQ_ANALYSIS_RESPONSE(195:1, 0:0, 1, [], 1, 0.01, 0:0, 1, 0, 1, 100, 0, 0, 1, ["Normal"], 0, 1, 0:0, 0, [10:8432], 0:0)
