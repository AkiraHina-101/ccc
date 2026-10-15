# Calculation.TransResp.LoadCondition()

Calculation.TransResp.LoadCondition()

説明​

瞬時反応のための任意の励起入力を設定します。

構文​

Calculation.TransResp.LoadCondition(...)

マクロ：DYNAMIC_TRANS_ANALYSIS_LOAD

リボン：Calculation » TransResp » LoadCondition

入力​

crTargetAnalysis​

ターゲット解析を指定する Cursor。このパラメータが None と設定されている場合、新しい解析が作成されます。

デフォルト値は None です。

crCoordinate​

座標系を指定する Cursor。

デフォルト値は None です。

strName​

作成する負荷条件の名前を指定する String。

デフォルト値は "TRNLoad1" です。

iLoadType​

負荷タイプを指定する Integer。

0: テーブル (TLOAD1)

1: コサイン (TLOAD2)

デフォルト値は 0 です。

iLoadDirection​

振動の方向を指定する Integer。

0: X

1: Y

2: Z

3: RX

4: RY

5: RZ

6: 法線

デフォルト値は 0 です。

dlForce​

振動力のベクトルを指定する Double 型のリスト。

デフォルト値は [1,0,0] です。

dAmplitude​

振動負荷の振幅を指定する Double。

デフォルト値は 1.0 です。

dDelay​

時間遅れの値 (秒) を指定する Double。

デフォルト値は 0.0 です。

dPhase​

負荷タイプ Cosine (TLOAD2) の位相遅れ (角度) の値を指定する Double。

デフォルト値は 0.0 です。

bFt​

時間履歴負荷を入力された値またはテーブルとして使用するかどうかを指定する Boolean。

デフォルト値は False です。

dFt​

時間履歴負荷の値を指定する Double。

デフォルト値は 1.0 です。

crFtCurve​

時間履歴負荷のフィールドデータを指定する Cursor。

デフォルト値は None です。

dT1​

負荷タイプ Cosine (TLOAD2) の振動開始時間を指定する Double。

デフォルト値は 0.0 です。

dT2​

負荷タイプ Cosine (TLOAD2) の振動終了時間を指定する Double。

デフォルト値は 1.0 です。

dFrequency​

負荷タイプ Cosine (TLOAD2) の周波数の値を指定する Double。

デフォルト値は 0.0 です。

dExponent​

負荷タイプ Cosine (TLOAD2) の指数関数の値を指定する Double。

デフォルト値は 0.0 です。

dPower​

負荷タイプ Cosine (TLOAD2) の成長係数の値を指定する Double。

デフォルト値は 0.0 です。

crlTargets​

ロード条件を割り当てることができる選択された節点を指定する List of Cursor。

これは必須の入力です。

crEdit​

既存の負荷条件を指定する Cursor

このパラメータを使用すると、指定された負荷条件が変更されます。

None の場合、新しい負荷条件が作成されます。

デフォルト値は None です。

戻り値​

作成された瞬時負荷条件を指定する Cursor。

サンプルコード​

# 結果モデルを準備します
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# ロード条件を作成します
loadcondition = Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, 
                                                    dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])
JPT.Debugger(loadcondition)
