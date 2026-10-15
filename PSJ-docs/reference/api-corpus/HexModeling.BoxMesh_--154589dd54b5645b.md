# HexModeling.BoxMesh()

HexModeling.BoxMesh()

説明​

モデルを包含するようにヘキサ要素で構成された直方体を作成します。

構文​

HexModeling.BoxMesh(...)

リボン: HexModeling » BoxMesh

入力​

ilPartIds​

パートIDを指定する Integer のリスト。

この入力は必須です。

dMeshSize​

メッシュサイズを指定する Double 。

この入力は必須です。

strMaterialName​

マテリアル名を指定する String 。

この入力は必須です。

戻り値​

成功した場合は1の文字列、失敗した場合は0の文字列。

サンプルコード​

Geometry.Part.Cube()
HexModeling.BoxMesh(ilPartIds=[1], dMeshSize=0.002, strMaterialName="")
