# CmdImportTSVBdfPost()

CmdImportTSVBdfPost()

説明​

Nastranメッシュファイルを Jupiter データベースにインポートし、結果をメッシュに追加するためのポストドキュメントを追加します。

構文​

CmdImportTSVBdfPost(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bReadNX)

入力​

1. str​

インポートに使用されるNastranファイルを指定する文字列です。

2. int​

インポートタイプを指定する整数です。

3. double​

インポートタイプを指定する整数です。ここでは常に 1 に設定されています。

4. double​

エッジの分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定された値よりも大きな角度をもつ隣接エッジ要素に頂点を作成します）。

5. bool​

荷重と拘束条件を読み込むかどうかを指定するブール値です。

6. bool​

接続を読み込むかどうかを指定するブール値です。

7. bool​

NX を読み込むかどうかを指定するブール値です。

戻り値​

"1": 関数を実行できる状態

"0": 関数を実行できない状態

サンプルコード​

CmdImportTSVBdfPost("ファイルへのパス", 1, 60.0, 60.0, 1, 1, 1)
