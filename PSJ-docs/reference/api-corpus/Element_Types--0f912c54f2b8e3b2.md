# Element Types

Element Types

要素の種類を表す列挙体です。

関数内で主に使用される ElemKind および ElemType のIDは、Int Notation列で参照できます。

ただし、IDの意味を明示的に説明するために、IDを指定する代わりに、ユーザーは JPT.ElemKind.ElemKind または JPT.ElemType.ElemType を使用できます。

例：

JPT.ElemKind.ELEMKIND_2D は ID = 3 に等しいです。

JPT.ElemType.ELEMTYPE_QUAD4 は ID = 6 に等しいです。

 | ElemKind Int Notation | 要素の種類 | 説明 | ElemType Int Notation | 要素の種類 | 定義

 | 1 | ELEMKIND_0D | 節点用の準備ができた要素。 | 1 | ELEMTYPE_POINT | 頂点要素。

 | 2 | ELEMKIND_1D | 1次元の要素（バー要素）。 | 2 | ELEMTYPE_LINE2 | 1次元の要素（一次要素）

 |  |  |  | 3 | ELEMTYPE_LINE3 | 1次元の要素（二次要素）

 | 3 | ELEMKIND_2D | 2次元の要素（シェル要素） | 4 | ELEMTYPE_TRI3 | 3節点三角形要素（一次要素）

 |  |  |  | 5 | ELEMTYPE_TRI6 | 6節点三角形要素（二次要素）

 |  |  |  | 6 | ELEMTYPE_QUAD4 | 4節点長方形要素（一次要素）

 |  |  |  | 7 | ELEMTYPE_QUAD8 | 8節点長方形要素（二次要素）

 |  |  |  | 17 | ELEMTYPE_QUAD6 | 6節点長方形要素（一次要素） 1

 |  |  |  | 18 | ELEMTYPE_QUAD9 | 9節点長方形要素（二次要素） 1

 | 4 | ELEMKIND_3D | 3次元の要素（ソリッド要素） | 8 | ELEMTYPE_TET4 | 4節点四面体要素（一次要素）

 |  |  |  | 9 | ELEMTYPE_TET10 | 10節点四面体要素（二次要素）

 |  |  |  | 10 | ELEMTYPE_HEX8 | 8節点六面体要素（一次要素）

 |  |  |  | 11 | ELEMTYPE_HEX20 | 20節点六面体要素（二次要素）

 |  |  |  | 12 | ELEMTYPE_PRISM6 | 6節点五面体要素（一次要素）

 |  |  |  | 13 | ELEMTYPE_PRISM15 | 15節点五面体要素（二次要素）

 |  |  |  | 14 | ELEMTYPE_PYRAMID5 | 5節点ピラミッド要素（一次要素）

 |  |  |  | 15 | ELEMTYPE_PYRAMID13 | 13節点ピラミッド要素（二次要素）

 |  |  |  | 19 | ELEMTYPE_PRISM12 | 12節点五面体要素（二次要素） 2

 |  |  |  | 20 | ELEMTYPE_HEX18 | 18節点六面体要素（二次要素） 3

 | 5 | ELEMKIND_SP | 特殊な要素の種類 4 | 16 | ELEMTYPE_PLOT | プロット要素

 |  |  |  | 21 | ELEMTYPE_RBE | RBE要素

 |  |  |  | 22 | ELEMTYPE_MASS | 質量要素

 |  |  |  | 23 | ELEMTYPE_VIRTUAL | 仮想要素（IDのみ）

注意:​

Footnotes​

これはMARCSソフトウェアの軸対称の半無限の熱伝達要素です。 ↩ ↩2

上部と下部の表面に中央節点を持つ五面体要素です。 ↩

上部と下部の表面に中央節点と中央節点がある六面体要素です。 ↩

特別な要素タイプは処理要素と異なり、接続要素を表すために使用されます。たとえば：RBE、プロット、マスなど ↩
