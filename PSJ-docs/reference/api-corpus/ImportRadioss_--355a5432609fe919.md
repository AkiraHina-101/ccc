# ImportRadioss()

ImportRadioss()

説明​

選択された物理量を使用して変形、輪郭色、およびベクトルをアニメーション化します。

構文​

ImportRadioss(str[] strlPaths, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bCreateResultsAtMidNode)

入力​

1. str[]​

nastran結果ファイルパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。

3. double​

面分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定された値より小さい角度で隣接要素間にエッジを作成することによる）。

4. double​

エッジ分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定された値より大きい角度で隣接するエッジ要素に頂点を作成することによる）。

5. bool​

読み込む負荷と拘束を指定するブール値です。

6. bool​

接続を読み込むかどうかを指定するブール値です。

7. bool​

中間節点で結果を作成するかどうかを指定するブール値です。

戻り値​

"1": 関数は実行可能です。

"0": 関数は実行できません。

サンプルコード​

ImportRadioss("path/to/the/file", 1, 60.0, 60.0, 0, 0, 0)
