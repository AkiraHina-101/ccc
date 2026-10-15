# ImportFrontISTR()

ImportFrontISTR()

説明​

FrontISTRの結果ファイルをインポートします。

構文​

ImportFrontISTR(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

FrontISTR結果フォルダーパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。

3. double​

フェース分割を決定するための角度許容度を指定する倍精度浮動小数です（指定値より小さい角度の隣接要素間にエッジを作成します）。

4. double​

エッジ分割を決定するための角度許容度を指定する倍精度浮動小数です（指定値より大きい角度の隣接エッジ要素上に頂点を作成します）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportFrontISTR("ファイルへのパス", 1, 60.0, 60.0)
