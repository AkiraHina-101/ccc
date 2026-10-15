# ImportSpatial()

ImportSpatial()

説明​

Spatial インタフェースを使用して CAD ファイルをインポートします

構文​

ImportSpatial(string[] vecPath, double surface_plane_tolerance, double suface_plane_angle,
    double max_facet_width, int NX_multibody, int healing, int isNXDirect, int setFaceColor,
    String facetParamCsvFile)

入力​

1. String[]​

複数の CAD ファイルパス

2. Double​

表面平面許容オプション

3. Double​

表面平面角度オプション

4. Double​

最大フェース幅オプション

5. Int​

NX マルチ パートのフラグ

6. Int​

ヒーリングオプションのフラグ

7. Int​

NXDirect のフラグ

8. Int​

フェースカラーオプションの設定フラグ

9. String​

フェースパラメータ CSV ファイルのパス

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportSpatial(["D:/Test.sat"], 0, 20, 0.1, 1, 1, 0, 1, "")
