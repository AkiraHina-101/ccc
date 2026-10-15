# GeometryDeform()

GeometryDeform()

説明​

フェースを変形します。

構文​

GeometryDeform(cursor[] taFaceSrcObverse, cursor[] taFaceDstReverse, cursor[] taFaceSrcReverse, cursor[] crlFaceDstObverse, cursor[] crlFaceFixed, double dDistEffect)

入力​

1. Cursor[]​

フェースソースの表を指定する Cursor のリスト。

2. Cursor[]​

フェース DST リバースを指定する Cursor のリスト。

3. Cursor[]​

フェースソースリバースを指定する Cursor のリスト。

4. Cursor[]​

フェース DST の表を指定する Cursor のリスト。

5. Cursor[]​

フェースの固定を指定する Cursor のリスト。

6. double​

距離効果を指定する Double。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

GeometryDeform([6:26], [6:21], [6:22], [6:24], [], 0.02)
