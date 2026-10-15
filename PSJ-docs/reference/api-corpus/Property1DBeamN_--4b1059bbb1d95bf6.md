# Property1DBeamN()

Property1DBeamN()

説明​

1次元ビームプロパティ

構文​

Property1DBeam(string Name, int Id, color propertyColor, Cursor Section, int ShapeDataType,
    Cursor Material, double Area, double[3] Orient, double[3] Inertia,
    double TorConst, double NSM, double NSM_A, double NSM_B, double NSM_NodeAy,
    double NSM_NodeAz, double NSM_NodeBy, double NSM_NodeBz, double ShearStiffnessK1,
    double ShearStiffnessK2, double AreaReliefS1, double AreaReliefS2,
    double WrapCoefficientA, double WrapCoefficientB, double Y_NA_NodeA,
    double Z_NA_NodeA, double Y_NA_NodeB, double Z_NA_NodeB, double StressRevoceryCoeff_Cy,
    double StressRevoceryCoeff_Cz, double StressRevoceryCoeff_Dy,
    double StressRevoceryCoeff_Dz, double StressRevoceryCoeff_Ey,
    double StressRevoceryCoeff_Ez, double StressRevoceryCoeff_Fy,
    double StressRevoceryCoeff_Fz, bool PinA0, bool PinA1, bool PinA2, bool PinA3,
    bool PinA4, bool PinA5, bool PinB0, bool PinB1, bool PinB2, bool PinB3, bool PinB4,
    bool PinB5, double[3] OffsetPointA, double[3] OffsetPointB, int LocalLengthUnit,
    int LocalMassUnit, Cursor[] Target, Cursor credit, bool Tapped, int IntePtNum)

入力​

1. string​

名前

2. Int​

ID

3. Color​

プロパティの色。

4. Cursor​

セクション

5. int​

形状データタイプ [SHAPE_TYPE_UNKNOWN = 0, SHAPE_TYPE_M3 = 1, SHAPE_TYPE_M4 =2, SHAPE_TYPE_M6 = 3, SHAPE_TYPE_M8 = 4, SHAPE_TYPE_M10 = 5, SHAPE_TYPE_M12 = 6, SHAPE_TYPE_M14 = 7, SHAPE_TYPE_M16 = 8, SHAPE_TYPE_M18 = 9, SHAPE_TYPE_M20 = 10, SHAPE_TYPE_M22 = 11, SHAPE_TYPE_M24 = 12, SHAPE_TYPE_M26 = 13, SHAPE_TYPE_M28 = 14, SHAPE_TYPE_M30 = 15, SHAPE_TYPE_M32 = 16, SHAPE_TYPE_M34 = 17, SHAPE_TYPE_M36 = 18, SHAPE_TYPE_CIRC = 19]

6. cursor​

材料

7. double​

面積

8. double[3]​

方向ベクトル（x、y、z）の double リスト

9. Double[3]​

慣性モーメントの double リスト（Izz、Iyy、Izy）

10. double​

Tor 定数

11. double​

NSM

12. double​

NSM_A

13. double​

NSM_B

14. Double​

NSM_NodeAy

15. Double​

NSM_NodeAz

16. Double​

NSM_NodeBy

17. Double​

NSM_NodeBz

18. Double​

せん断剛性 K1

19. Double​

せん断剛性 K2

20. Double​

せん断面積リリーフ S1

21. Double​

せん断面積リリーフ S2

22. Double​

ラップ係数 A【Wrap Coefficient A】

23. Double​

ラップ係数 B【Wrap Coefficient B】

24. double​

Y_NA@NodeA

25. double​

Y_NA@NodeA

26. double​

Z_NA@NodeB

27. double​

Z_NA@NodeB

28. double​

応力回復係数 Cy

29. Double​

応力回復係数 Cz

30. Double​

応力回復係数 Dy

31. Double​

応力回復係数 Dz

32. Double​

応力回復係数 Ey

33. Double​

応力回復係数 Ez

34. Double​

応力回復係数 Fy

35. Double​

応力回復係数 Fz

36. Bool​

A1にピンフラグ true = 1、false = 0

37. Bool​

A2にピンフラグ true = 1、false = 0

38. Bool​

A3にピンフラグ true = 1、false = 0

39. Bool​

A4にピンフラグ true = 1、false = 0

40. Bool​

A5にピンフラグ true = 1、false = 0

41. Bool​

A6にピンフラグ true = 1、false = 0

42. Bool​

B1にピンフラグ true = 1、false = 0

43. Bool​

B2にピンフラグ true = 1、false = 0

44. Bool​

B3にピンフラグ true = 1、false = 0

45. Bool​

B4にピンフラグ true = 1、false = 0

46. Bool​

B5にピンフラグ true = 1、false = 0

47. Bool​

B6にピンフラグ true = 1、false = 0

48. Double[3]​

オフセットポイントA（Double リスト）

49. Double[3]​

オフセットポイントB（Double リスト）

50. Int​

ローカル単位長さ

51. Int​

ローカル質量単位

52. Cursor[]​

対象リスト

53. Cursor​

1次元ビームを編集

54. Bool​

テーパー フラグ true = 1、false = 0

55. double​

テーパー面積

56. double[3]​

テーパー慣性[Izz に対する慣性 I1、Iyy に対する慣性 I2、I1、2 の慣性]

57. double​

テーパーねじれ定数

58. double​

テーパー非構造質量L

59. double​

テーパー応力回復係数 Cy

60. double​

テーパー応力回復係数 Cz

61. double​

テーパー応力回復係数 Dy

62. double​

テーパー応力回復係数 Dz

63. double​

テーパー応力回復係数 Ey

64. double​

テーパー応力回復係数 Ez

65. double​

テーパー応力回復係数 Fy

66. double​

テーパー応力回復係数 Fz

67. int​

積分ポイントの数

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Property1DBeamN("BEAM1", 5, 13478620, 0:0, 0, 22:1, 1e-06, [0, 1, 0], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, [5:19], 0:0, 0, 1.79769e+308, 
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647)
