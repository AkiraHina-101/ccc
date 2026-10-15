# ImportElysium()

ImportElysium()

説明​

Elysiumインタフェースを通じてCADファイルをインポートします。

構文​

ImportElysium(string[] vecPath, double height_tol, double angle_tolerance_degree,
    double iso_cur, double iges_fixedCurevePreference, double iges_autoStitch,
    double iges_stitchTolerance, double catia_convertNotShowedElement,
    double catia_convertNotShowedInstance, double catia_convertAxis, double step_createSeam,
    double step_pointTolerance, double acis_healAcisBeforeVersion, double jt_convertGeometryType,
    double jt_convertGeneralBody, double jt_convertAxis, double jt_convertCenterLine, bool m_setFaceColor,
    double dek_cleanSelfIntersectingLoop, double point_coincident_tolerance, double dek_volumeToBody)

入力​

1. String[]​

ディレクトリパス

2. Double​

高さ許容オプション

3. Double​

角度許容度オプション

4. Double​

孤立曲線

5. Double​

Iges fixedCurvePreferenceオプション

6. Double​

Iges autoStitchオプション

7. Double​

Iges stitchToleranceオプション

8. Double​

Catia convertNotShowedElementオプション

9. Double​

Catia convertNotShowedInstanceオプション

10. Double​

Catia convertAxisオプション

11. Double​

Step createSeamオプション

12. Double​

Step pointToleranceオプション

13. Double​

Acis healAcisBeforeVersioオプション

14. Double​

jt convertGeometryTypeオプション

15. Double​

jt convertGeneralBodyオプション

16. Double​

jt convertAxisオプション

17. Double​

jt convertCenterLineオプション

18. Bool​

M_setFaceColorオプション

19. Double​

dek_cleanSelfIntersectingLoopオプション

20. Double​

点の一致許容度オプション

21. Double​

dek_volumToBodyオプション

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportElysium(["D:/Test.sat"], 1, 5, 0, 0, 1, 0.1, 0, 0, 1, 1, 0, 0, 2, 1, 1, 0, 1, 2, 0.01, 4)
