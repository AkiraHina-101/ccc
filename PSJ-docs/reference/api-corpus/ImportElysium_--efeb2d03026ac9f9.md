# ImportElysium()

ImportElysium()

Description​

Import CAD file by Elysium interface

Syntax​

ImportElysium(string[] vecPath, double height_tol, double angle_tolerance_degree,
    double iso_cur, double iges_fixedCurevePreference, double iges_autoStitch,
    double iges_stitchTolerance, double catia_convertNotShowedElement,
    double catia_convertNotShowedInstance, double catia_convertAxis, double step_createSeam,
    double step_pointTolerance, double acis_healAcisBeforeVersion, double jt_convertGeometryType,
    double jt_convertGeneralBody, double jt_convertAxis, double jt_convertCenterLine, bool m_setFaceColor,
    double dek_cleanSelfIntersectingLoop, double point_coincident_tolerance, double dek_volumeToBody)

Inputs​

1. String[]​

Path directory

2. Double​

Height tolerance option

3. Double​

Angle tolerance degree option

4. Double​

Isolated curve

5. Double​

Iges fixedCurvePreference option

6. Double​

Iges autoStitch option

7. Double​

Iges stitchTolerance option

8. Double​

Catia convertNotShowedElement option

9. Double​

Catia convertNotShowedInstance option

10. Double​

Catia convertAxis option

11. Double​

Step createSeam option

12. Double​

Step pointTolerance option

13. Double​

Acis healAcisBeforeVersio option

14. Double​

jt convertGeometryType option

15. Double​

jt convertGeneralBody option

16. Double​

jt convertAxis option

17. Double​

jt convertCenterLine option

18. Bool​

M_setFaceColor option

19. Double​

dek_cleanSelfIntersectingLoop option

20. Double​

Point coincident tolerance option

21. Double​

dek_volumToBody option

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportElysium(["D:/Test.sat"], 1, 5, 0, 0, 1, 0.1, 0, 0, 1, 1, 0, 0, 2, 1, 1, 0, 1, 2, 0.01, 4)
