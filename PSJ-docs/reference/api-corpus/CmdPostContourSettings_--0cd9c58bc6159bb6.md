# CmdPostContourSettings()

CmdPostContourSettings()

説明​

コンター設定。

構文​

CmdPostContourSettings(int Contour, int ContourType, int MaxMinType, float MaxUser, float MinUser, float MaxTotal, float MinTotal, 
int SpectrumType, color UpperColor, color LowerColor, color FrameColor, string strColors, int Log, bool ShowBlankValueAs0, bool OptimizedShape, , float contours, color NoResult)

入力​

1. int​

ステップ番号

2. int​

コンタータイプ

3. int​

最大最小タイプ
0: 見えるエンティティ、1: 合計エンティティ、2: ユーザー定義、3: 複数の結果

4. float​

最大値。

5. float​

最小値。

6. float​

合計最大値。

7. float​

合計最小値。

8. int​

スペクトルタイプ

9. color​

最大色

10. color​

最小色

11. color​

コンターフレームの色

12. string​

色

13. int​

ログタイプ

14. bool​

空白値を0として表示するフラグ。

15. bool​

最適化ツールキットフラグ。

16. float []​

コンターステップ値。

17. color []​

結果なしの色。

戻り値​

なし。

サンプルコード​

CmdPostContourSettings(10, 1, 0, 3.8698804379, 0.0000000000, 3.8698804379, 0.0000000000, 2, 255, 16711680, 65535, [], 0, 0, 0, [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0], 8421504)
