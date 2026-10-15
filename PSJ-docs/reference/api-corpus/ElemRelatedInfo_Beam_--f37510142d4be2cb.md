# ElemRelatedInfo_Beam()

ElemRelatedInfo_Beam()

説明​

バー/ビームパラメーターを設定します

構文​

ElemRelatedInfo_Beam(int[] ends, int[] orientVecs, int[] orientationVecsByNode,
    int[] offsetVecAs, int[] offsetVecBs, int[] pinAs, int[] pinBs, int[] warps)

入力​

1. Int[]​

終点節点IDパラメータ

2. Int[]​

向きベクトルパラメータ

3. Int[]​

節点ごとの向きベクトルパラメータ

4. Int[]​

オフセットAベクトルパラメータ

5. Int[]​

オフセットBベクトルパラメータ

6. Int[]​

pinAフラグパラメータ

7. Int[]​

pinBフラグパラメータ

8. Int[]​

ワープフラグパラメータ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ElemRelatedInfo_Beam([], [[3, 795, 0, 1, 0], [3, 796, 0, 1, 0], [3, 797, 0, 1, 0]], [], [], [], [], [], [])
