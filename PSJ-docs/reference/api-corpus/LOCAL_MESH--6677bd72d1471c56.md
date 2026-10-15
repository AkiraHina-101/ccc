# LOCAL_MESH

LOCAL_MESH

説明​

ローカルメッシュのパラメータを制御するために使用されるデータ型です。

属性​

iEntityType​

選択されたエンティティのタイプを指定する Integer で、次のいずれかである必要があります：

1: パート

2: フェース

3: エッジ

8: フェースポイント

9: エッジポイント

10: ソリッドポイント

デフォルト値は 0（指定されていないタイプ）です。

bEnableSizeParams​

ローカルサイズパラメータを設定するかどうかを指定する Boolean です。このパラメータがTrueの場合、dAvgElemSize、dMaxElemSize、dMinElemSizeが使用されます。

デフォルト値は False です。

dAvgElemSize​

選択されたエンティティの平均メッシュサイズを指定する Double です。このパラメータは、bEnableSizeParams がTrueの場合にのみ使用されます。

デフォルト値は0.0です。

... （以下省略）
