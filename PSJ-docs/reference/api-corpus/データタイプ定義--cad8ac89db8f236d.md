# データタイプ定義

データタイプ定義 table, th, td { border: 1px solid black; border-collapse: collapse; padding: 10px; } 基本データ型 Jupiter マクロ / APIで使用している基本的なデータ型です。 ※Python APIをご利用の際は、Pythonの全てのデータ型をご利用になれます。 Jupiter マクロ/API データ型 略称 説明 整数（Integer） int 小数点を持たない正または負の値を表します。 2147483647は整数値フィールドでのデフォルト値（空白＝入力なし）を意味します。 ブール値（Boolean） bool 真偽値の False(0) と True(1) を表します。 実数（Float） float 計算機レベルの倍精度浮動小数点数を表現します。 1.79769e+308は実数値フィールドでのデフォルト値（空白＝入力なし）を意味します。 文字列型（String） str 文字列を表現します。""で囲みます。 カーソル型（Cursor） cursor TypeID:IDの形式で、エンティティを表現します。 例） 3:1 [3:1,3:2]
