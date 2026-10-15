# ImportSpatial()

ImportSpatial()

説明​

Spatialインターフェースを使用してCADファイルをインポートします

構文​

ImportSpatial(String[] vecPath, double surface_plane_tolerance, double surface_plane_angle,
    double max_facet_width, int isNXDirect)

入力​

1. String[]​

複数のCADファイルパス

2. Double​

表面平面許容オプション

3. Double​

表面平面角度オプション

4. Double​

最大フェース幅オプション

5. Int​

NXDirectのフラグ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportSpatial(["D:/assy1.sat"], 0.002, 30, 0, 0)
