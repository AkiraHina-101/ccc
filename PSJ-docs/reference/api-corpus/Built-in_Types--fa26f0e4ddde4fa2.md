# Built-in Types

Built-in Types

すべてのPSJ-Commands関数で使用される列挙型です。

 | Jupiter マクロ/APIデータ型 | 略語 | 接頭語 + 変数名 | 説明

 | Integer | int | iVariableName | 小数点を持たない正または負の値を表します。
2147483647は整数値フィールドのデフォルト値（「空白=入力なし」）です

 | Boolean | bool | bVariableName | ブール値 False(0) と True(1) を表します

 | Double | double | dVariableName | コンピューターレベルの倍精度浮動小数点数を表します。
1.79769e+308は実数フィールドのデフォルト値（「空白=入力なし」）です

 | String | str | strVariableName | 文字列を表します。二重引用符 "" で囲んでください

 | Cursor | cursor | crVariableName | TypeID: IDの形でエンティティを表します。
例:
3:1 
CADパートを除いて、IDとキーの2つのパラメータを取ります。
例:
3:1-1

 | Position | position | posVariableName | n/a

 | Vector | vector | vecVariableName | n/a

 | List of Integer | int list | ilVariableName | n/a

 | List of Double | double list | dlVariableName | n/a

 | List of String | string list | strlVariableName | n/a

 | List of Cursor | List of Cursor | crlVariableName | TypeID: カーソルのリストを表します。
例:
[3:1,3:2]

 | List of Position | position list | poslVariableName | n/a

 | List of Vector | vector list | veclVariableName | n/a

 | List of Boolean | bool list | blVariableName | n/a

 | Pair of Cursor | cursor pair | crpVariableName | n/a

 | List of Cursor Pair | cursor pair list | crplVariableName | n/a

 | TSheetd | TSheetd | tshVariableName | n/a

 | CursorStr | n/a | crVariableName | 1つまたは複数のカーソルをカンマで区切って表します。カーソルの代わりに使用したり、カーソルのリストの内容として使用することができます。
