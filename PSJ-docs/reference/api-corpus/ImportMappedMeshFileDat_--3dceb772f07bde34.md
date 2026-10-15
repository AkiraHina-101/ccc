# ImportMappedMeshFileDat()

ImportMappedMeshFileDat()

説明​

マップされたメッシュファイル（*.dat）をJupiterデータベースにPostドキュメントとしてインポートして、メッシュに結果を追加します。

構文​

ImportMappedMeshFileDat(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

マップされたメッシュファイルのパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。マップされたメッシュファイルの場合、常に 1 に設定されています。

3. double​

フェースの分割を決定するための角度許容値を指定する倍精度です（指定値より小さい角度で隣接要素の間にエッジを作成します）。

4. double​

エッジの分割を決定するための角度許容値を指定する倍精度です（指定値より大きい角度で隣接エッジ要素に頂点を作成します）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportMappedMeshFileDat("ファイルへのパス", 1, 60.0, 60.0)
