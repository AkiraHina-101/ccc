# CadProject_FaceToFace()

CadProject_FaceToFace()

説明​

CADフェースに対してメッシュ化されたフェースの節点をプロジェクトします。

構文​

CadProject_Face(int method, cursor[] taCadFaces, cursor[] meshedFaces, bool bForceProject,
    bool bProjectCornerNodes, bool bProjectMidNodes, bool bIDCheck)

入力​

1. Int​

method = 3

2. Cursor[]​

対象の参照CADフェース（[15:RefFace ID]）

3. Cursor[]​

対象のメッシュ化されたフェース（[6:Face ID]）

4. Bool​

force project = 0

5. Bool​

プロジェクトの角の節点を指定するブールフラグ True = 1、False = 0

6. Bool​

プロジェクトの中間節点を指定するブールフラグ True = 1、False = 0

7. Bool​

IDチェックを行うかを指定するブールフラグ True = 1、False = 0

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

CadProject_FaceToFace(3, [15:5], [6:5], 1, 0, 1, 1)
