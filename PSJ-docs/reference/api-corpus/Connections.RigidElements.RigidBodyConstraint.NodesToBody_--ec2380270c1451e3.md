# Connections.RigidElements.RigidBodyConstraint.NodesToBody()

Connections.RigidElements.RigidBodyConstraint.NodesToBody()

説明​

剛体拘束を作成します (LS-DYNA)

構文​

Connections.RigidElements.RigidBodyConstraint.NodesToBody(...)

マクロ:

リボン: Connections » RigidElements » RigidBodyConstraint » NodesToBody

入力​

strName​

剛体拘束の名前を指定する String。

デフォルト値は "RBC" です。

iMethod​

タイプを指定する Integer。

1: 節点。

2: 節点セット。

デフォルト値は 0 です。

crlMasters​

マスターエンティティを指定する Cursor のリスト。

デフォルト値は [] です。

crlSlaves​

スレーブエンティティを指定する Cursor のリスト。

デフォルト値は [] です。

crEdit​

既存の剛体拘束を指定する Cursor。

デフォルト値は None です。

戻り値​

成功時は "1"、失敗時は "0" の文字列。

サンプルコード​

Geometry.Part.Cube()
Connections.RigidElements.RigidBodyConstraint.NodesToBody(
    strName="RBC_1", 
    iMethod=1, 
    crlMasters=[Part(1)], 
    crlSlaves=[Node(460)])
