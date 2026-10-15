# Property1DBar()

Property1DBar()

説明​

1D バーのプロパティ

構文​

Property1DBar(string 名前, int Id, color プロパティの色, Cursor セクション, int 形状データ型, Cursor 材料,
    double 面積, double[3] 方向, double[3] 慣性, double トルク定数, double NSM,
    double シア面積係数1, double シア面積係数2, double 応力回復係数_サイ,
    double 応力回復係数_ズィー, double 応力回復係数_ディー,
    double 応力回復係数_ズィー, double 応力回復係数_イー,
    double 応力回復係数_ズィー, double 応力回復係数_エル,
    double 応力回復係数_ズィー, double 応力回復係数_エフ,
    bool ピンA0, bool ピンA1, bool ピンA2, bool ピンA3,
    bool ピンA4, bool ピンA5, bool ピンB0, bool ピンB1, bool ピンB2, bool ピンB3, bool ピンB4,
    bool ピンB5, double[3] ポイントA, double[3] ポイントB, int ローカル長さ単位, int ローカル質量単位,
    Cursor[] ターゲット, Cursor crEdit)

入力​

1. string​

名前

2. Int​

ID

3. Color​

プロパティの色。

4. Int​

形状データ型 [SHAPE_TYPE_UNKNOWN = 0, SHAPE_TYPE_M3 = 1, SHAPE_TYPE_M4 =2, SHAPE_TYPE_M6 = 3, SHAPE_TYPE_M8 = 4, SHAPE_TYPE_M10 = 5, SHAPE_TYPE_M12 = 6, SHAPE_TYPE_M14 = 7, SHAPE_TYPE_M16 = 8, SHAPE_TYPE_M18 = 9, SHAPE_TYPE_M20 = 10, SHAPE_TYPE_M22 = 11, SHAPE_TYPE_M24 = 12, SHAPE_TYPE_M26 = 13, SHAPE_TYPE_M28 = 14, SHAPE_TYPE_M30 = 15, SHAPE_TYPE_M32 = 16, SHAPE_TYPE_M34 = 17, SHAPE_TYPE_M36 = 18, SHAPE_TYPE_CIRC = 19]

5. Cursor​

材料

6. Double​

面積

7. Double[3]​

方向ベクトルの double リスト [x、y、z]

8. Double[3]​

慣性の double リスト [Izz、Iyy、Izy]

9. Double​

トルク定数

10 Double​

NSM

11. Double​

シア面積係数 K1

12. Double​

シア面積係数 K2

13. Double​

応力回復係数 サイ

14. Double​

応力回復係数 ズィー

15. Double​

応力回復係数 ディー

16. Double​

応力回復係数 ズィー

17. Double​

応力回復係数 イー

18. Double​

応力回復係数 ズィー

19. Double​

応力回復係数 エル

20. Double​

応力回復係数 ズィー

21. Bool​

A0 におけるピンフラグ true = 1、false = 0

22. Bool​

A1 におけるピンフラグ true = 1、false = 0

23. Bool​

A2 におけるピンフラグ true = 1、false = 0

24. Bool​

A3 におけるピンフラグ true = 1、false = 0

25. Bool​

A4 におけるピンフラグ true = 1、false = 0

26. Bool​

A5 におけるピンフラグ true = 1、false = 0

27. Bool​

B0 におけるピンフラグ true = 1、false = 0

28. Bool​

B1 におけるピンフラグ true = 1、false = 0

29. Bool​

B2 におけるピンフラグ true = 1、false = 0

30. Bool​

B3 におけるピンフラグ true = 1、false = 0

31. Bool​

B4 におけるピンフラグ true = 1、false = 0

32. Bool​

B5 におけるピンフラグ true = 1、false = 0

33. Double[3]​

オフセットポイントA の double リスト

34. Double[3]​

オフセットポイントB の double リスト

35. Int​

ローカル単位の長さ

36. Int​

ローカル単位の質量

37. Cursor[]​

ターゲットリスト

38. Cursor​

1D バーを編集

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

Property1DBar("BAR3", 1, 14572863, 93:1, 0, 22:2, 3.14159e-06, [0, 1, 0], [7.85398e-13, 7.85398e-13, 0],
    1.5708e-12, 1.79769e+308, 0.9, 0.9, 0.001, -0, 0, 0.001, -0.001, 0, -0, -0.001, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, [5:1], 0:0)
