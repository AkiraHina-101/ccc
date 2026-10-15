# AttachTemplateCrossSection()

AttachTemplateCrossSection()

説明​

指定されたテンプレートに断面形状の設定をアタッチします。

構文​

AttachTemplateCrossSection(string NewTemplateName, bool Capping, bool CuttingEdge, bool SectionElem, bool Meshline, bool Show, bool Flip, bool BoxView, bool Tranparency, double PercentTranparency, color Tranparncy, float [] Matrix, vector Pos, vector PrevPos, vector RotationCenter, vector DirectAngle, float Size, float PlnSize, float BoxSize)

入力​

1 string ​

テンプレート名

2 bool ​

キャップフラグ。

3 bool ​

切断エッジフラグ

4 bool ​

セクション要素フラグ

5 bool ​

メッシュラインフラグ

6 bool ​

表示フラグ

7 bool ​

反転フラグ

8 bool ​

ボックス表示フラグ

9 bool ​

透明度フラグ

10 double ​

透明度の割合

11 color ​

透明度の色

12 float [] ​

断面の変換行列

13 vector ​

位置 x、y、z

14 vector ​

前の位置 x、y、z

15 vector ​

回転中心 x、y、z

16 vector ​

直角度

17 float ​

サイズ

18 float ​

Planサイズ

19 float ​

Boxサイズ

戻り値​

"1"：成功

"0"：失敗

サンプルコード​

AttachTemplateCrossSection("My Template", 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, [-1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1], [1e-10, 1e-10, 1e-10], [0, 0, 0], [1e-10, 1e-10, 1e-10], [0, 0, 0], 0.25, 0.2, 0.025)
