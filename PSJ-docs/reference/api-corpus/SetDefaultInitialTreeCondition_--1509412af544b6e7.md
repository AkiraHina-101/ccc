# SetDefaultInitialTreeCondition()

SetDefaultInitialTreeCondition()

説明​

ツリーアイテムの初期表示設定を設定します。

構文​

SetDefaultInitialTreeCondition(bool AllParts, bool AllItems, bool LoadBCs, bool LocalMeshSettings, bool Connections, bool Coordinates, bool Contacts)

入力​

1. bool​

ドキュメントが開かれたときにすべてのパートを表示/非表示にします。

0: 非表示

1: 表示

2. bool​

ドキュメントが開かれたときにすべてのアイテムを表示/非表示にします。

0: 非表示

1: 表示

3. bool​

ドキュメントが開かれたときに荷重とBCを表示/非表示にします。

0: 非表示

1: 表示

4. bool​

ドキュメントが開かれたときにローカルメッシュ設定を表示/非表示にします。

0: 非表示

1: 表示

5. bool​

ドキュメントが開かれたときに接続を表示/非表示にします。

0: 非表示

1: 表示

6. bool​

ドキュメントが開かれたときに座標を表示/非表示にします。

0: 非表示

1: 表示

7. bool​

ドキュメントが開かれたときに接触を表示/非表示にします。

0: 非表示

1: 表示

戻り値​

戻り値なし。

サンプルコード​

SetDefaultInitialTreeCondition(0, 1, 0, 0, 0, 1, 1)
