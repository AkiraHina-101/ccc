# CadProject_Part()

CadProject_Part()

説明​

メッシュ化されたパートをCADパートに対してプロジェクトします

構文​

CadProject_Part(int method, cursor taCadBody, cursor meshedBody, bool bForceProject,
    bool bProjectCornerNodes, bool bProjectMidNodes, bool bIDCheck)

入力​

1. Int​

Method = 1

2. Cursor​

ターゲット参照CAD パート（12:参照パートID）

3. Cursor​

ターゲットメッシュ パート（3:パートID）

4. Bool​

Force project = 0

5. Bool​

角節点をプロジェクトするブールフラグ True = 1、False = 0

6. Bool​

中間節点をプロジェクトするブールフラグ True = 1、False = 0

7. Bool​

IDチェックを行うブールフラグ True = 1、False = 0

戻り値​

"1": 関数は実行可能です

"0": 関数は実行不可能です

サンプルコード​

CadProject_Part(1, 12:1, 3:1, 0, 0, 1, 1)
