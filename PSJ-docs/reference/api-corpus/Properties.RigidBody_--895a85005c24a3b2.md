# Properties.RigidBody()

Properties.RigidBody()

説明​

パートに剛体プロパティを割り当てます。

構文​

Properties.RigidBody(...)

リボン：Properties » Rigid Body

入力​

strName​

新しいプロパティの名前を指定する String です。

デフォルト値は "RigidBody1" です。

iPID​

プロパティ識別番号を指定する Integer です。
この番号は、他のすべてのプロパティの識別番号とは異なる値である必要があります。

デフォルト値は 1 です。

iRefNodeId​

参照節点 ID を指定する Integer です。

デフォルト値は 0 です。

crlTargets​

剛体プロパティを適用するエンティティを指定する Cursor リストです。
ターゲットは、フェースエンティティまたは要素エンティティです。

crlTargets と crRigidBodyProperty 引数は相互に排他的です（いずれかを指定する必要があります）。

デフォルト値は [] です。

crRigidBodyProperty​

既存の剛体プロパティを指定する Cursor です。

この引数が None でない場合、指定した剛体プロパティが変更されます。

それ以外の場合、新しい剛体プロパティが作成されます。

crlTargets と crRigidBodyProperty 引数は相互に排他的です（いずれかを指定する必要があります）。

デフォルト値は None です。

戻り値​

新しく作成されたか変更された剛体プロパティを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
Properties.RigidBody(crlTargets=[Face(26)])
