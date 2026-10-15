# CmdShowPostContour()

CmdShowPostContour()

説明​

モデルの結果を読み込み、輪郭として表示します。

構文​

CmdShowPostContour(TCursor crPostJob,
	PostResultKey& resKey, PostDataOp& opOut,
	bool hasResult2, PostResultKey& resKey2, PostDataOp& opOut2,
	bool hasResult3, PostResultKey& resKey3, PostDataOp& opOut3,
	bool enableMidNode, bool bApplyAll = false, bool bLogMacro = true)

入力​

1. TCursor​

ポスト ジョブを示します = 183:1

2. PostResultKey:: ​

キー ID

3. PostDataOp::​

グループ作成オプション

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプル コード​

CmdShowPostContour(183:1, 1, 0, 9, NodalStrain, Mises, 1, 1, 0, 0, 0, 1, 8, 0, 0.000000, 0, 0, 0, 0, 0, , , 0, 0, 0, 0, 0, 0, 0, 0, 0.000000, 0, 0, 0, 0, 0, , , 0, 0, 0, 0, 0, 0, 0, 0, 0.000000, 0, 0, 0)
