# Property1DSectionModify_General()

Property1DSectionModify_General()

説明​

既存の断面を編集します。

構文​

Property1DSectionModify_General(string strName, cursor crSection,int iSecType, int iGeneralType, double dA, double dB, double dH, double dT1, double dT2, double dT3, bool bTapered, double dDaTap, double dDbTap, double dDhTap, double dDt1Tap, double dDt2Tap, double dDt3Tap, int iDirType)

入力​

1. String​

プロパティ名

2.Cursor​

変更する既存の断面

3.Int​

断面タイプ

4.Int​

一般断面タイプ

5.Double​

一般断面寸法 a

6.Double​

一般断面寸法 b

7.Double​

一般断面寸法 h

8.Double​

一般断面寸法 t1

9.Double​

一般断面寸法 t2

10.Double​

一般断面寸法 t3

11.Bool​

テーパー有無。

12.Double​

テーパ部の断面寸法 a

13.Double​

テーパ部の断面寸法 b

14.Double​

テーパ部の断面寸法 h

15.Double​

テーパ部の断面寸法 t1

16.Double​

テーパ部の断面寸法 t2

17.Double​

テーパ部の断面寸法 t3

18.Int​

Y方向タイプ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Property1DSectionModify_General("Modified", 93:1, 0, 0, 0, 0.002, 0.003, 0.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
