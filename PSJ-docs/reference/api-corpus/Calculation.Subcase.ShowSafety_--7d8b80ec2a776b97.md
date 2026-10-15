# Calculation.Subcase.ShowSafety()

Calculation.Subcase.ShowSafety()

説明​

各パートの許容値に基づいて選択されたサブケースから安全率を計算して、サブケースを作成します。

構文​

Calculation.Subcase.ShowSafety(...)

マクロ: PostToolsSubcaseSafetyFactor

リボン: Calculation » Subcase » ShowSafety

入力​

iAnalysisType​

解析タイプを指定する Integer 。

デフォルト値は1です。

iResultSet​

結果セットを指定する Integer 。

デフォルト値は1です。

listSubcaseIDs​

選択されたサブケースのIDを指定する Integer のリスト。

デフォルト値は[]です。

listSafetyItems​

各選択されたターゲットの安全情報を指定する SAFETY_ITEM のリスト。

デフォルト値は SAFETY_ITEM です。

iSafetyType​

安全計算のタイプを指定する Integer 。

0: 許容応力

1: 破壊応力

2: 疲労限界

デフォルト値は0です。

strResultName​

作成されるサブケースの名前を指定する String 。

デフォルト値は "SafetyYield" です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# サブケース.相対オフセット
showSafety = Calculation.Subcase.ShowSafety(iAnalysisType=2, 
                                            listSubcaseIDs=[1, 2, 3, 4, 5],
                                            listSafetyItems=[SafetyItem(crPart=Part(1), \
                                            dThreshold=1), \
                                            SafetyItem(crPart=Part(2), \
                                            dThreshold=1), \
                                            SafetyItem(crPart=Part(3), \
                                            dThreshold=1)], 
                                            iSafetyType=1, 
                                            strResultName="Safety Break2")
JPT.Debugger(showSafety)
