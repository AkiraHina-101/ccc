# Property1DSectionAdd_General()

Property1DSectionAdd_General()

説明​

断面の一般的な特性が作成されます。

構文​

Property1DSectionAdd_General(string strName, int iSecType, int iSecGenType, double dDsecGensizeA, double dDsecGensizeB, double dDsecGensizeH, double dDsecGensizeT1, double dDsecGensizeT2, double dDsecGensizeT3, bool bBsecTapered, double dDsecGensizeATap, double dDsecGensizeBTap, double dDsecGensizeHTap, double dDsecGensizeT1Tap, double dDsecGensizeT2Tap, double dDsecGensizeT3Tap, int iDirType)

入力​

1. String​

プロパティ名

2. Int​

断面タイプ

3. Int​

一般的な断面タイプ

4.Double​

一般的な断面寸法 a

5.Double​

一般的な断面寸法 b

6.Double​

一般的な断面寸法 h

7.Double​

一般的な断面寸法 t1

8.Double​

一般的な断面寸法 t2

9.Double​

一般的な断面寸法 t3

10.Bool​

断面がテーパ形状かどうか

11.Double​

テーパ部の断面寸法 a

12.Double​

テーパ部の断面寸法 b

13.Double​

テーパ部の断面寸法 h

14.Double​

テーパ部の断面寸法 t1

15.Double​

テーパ部の断面寸法 t2

16.Double​

テーパ部の断面寸法 t3

17.Int​

Y方向のタイプ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません
.

サンプルコード​

Property1DSectionAdd_General("NewSection", 0, 2, 0, 0, 0, 0.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
