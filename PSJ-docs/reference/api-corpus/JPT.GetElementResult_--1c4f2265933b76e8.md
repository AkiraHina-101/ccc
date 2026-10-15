# JPT.GetElementResult()

JPT.GetElementResult()

説明​

条件を満たす結果を読み込んだ要素を取得します。

構文​

JPT.GetElementResult(PostDataRangeType,
                     resultValue,
                     adjustment)

入力​

PostDataRangeType​

要素結果を取得する条件を示す PostDataRangeType を指定する Enum です。

この入力は必須です。

resultValue​

参照値を指定する Double です。

この入力は必須です。

adjustment​

参照値に対する調整を指定する Double 型です:

PostDataRangeType がスカラー型（EQ、NE、LT、GT、LE、GE）の場合、結果を取得する範囲は（resultValue - adjustment）から（resultValue + adjustment）までです。

PostDataRangeType が範囲型（IR、OR、IRE、ORE）の場合、結果を取得する範囲は（resultValue）から（adjustment）までです。

デフォルト値は1E-5です。

戻り値​

条件を満たす要素の結果を含む Cursor リストが含まれています。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, Max Principal Stress, 2}, {2, 1, 0, 0, 0, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, \
                             0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# 要素結果が1より大きい（許容誤差=10E-3）要素グループを作成
list_element_1= JPT.GetElementResult(JPT.PostDataRangeType.GT,1,10E-3)
Tools.Group.CreateGroup(strGroupName="Group_Element_1", crlTargets=list_element_1)

# 要素結果が範囲（1,5）内の要素グループを作成
list_element_2= JPT.GetElementResult(JPT.PostDataRangeType.IR,1,5)
Tools.Group.CreateGroup(strGroupName="Group_Element_2", crlTargets=list_element_2)
