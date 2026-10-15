# CadProject_Face()

CadProject_Face()

説明​

CADパートに向けてメッシュ化されたフェースのプロジェクト節点を行います

構文​

CadProject_Face(int method, cursor taCadBody, cursor[] meshedFaces, bool bForceProject,
    bool bProjectCornerNodes, bool bProjectMidNodes, bool bIDCheck)

入力​

1. Int​

Method = 2

2. Cursor​

対象のCAD パートを参照（12:RefPart ID）

3. Cursor[]​

対象のメッシュフェース（[6:Face ID]）

4. Bool​

Force project = 0

5. Bool​

コーナー節点をプロジェクトするブールフラグ True = 1, False = 0

6. Bool​

ミッド節点をプロジェクトするブールフラグ True = 1, False = 0

7. Bool​

IDチェックを行うブールフラグ True = 1, False = 0

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CadProject_Face(2, 12:1, [6:5], 0, 0, 1, 1)
