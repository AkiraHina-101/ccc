# DMaterialLib

DMaterialLib

説明​

これは、Jupiter内のライブラリ材料アイテムを表すDMaterialLibクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | name | 材料の名前。
戻り値は文字列名（str）です。

 | description | 材料の説明。
戻り値は文字列説明（str）です。

 | isComposite | 複合材料であるかどうかを判断します。

 | id | 材料の外部ID。
IDは重複できません。
IDは、再ナンバリング機能を使用して変更できます。
戻り値はID（int）です。

 | color* 1 | 材料の色情報。
この値は調整できます。
戻り値はRGB色です。

 | matStandard | 材料の標準を決定します。
戻り値はSD_JIS、SD_ISO、SD_AISI、SD_SAE、SD_BS、SD_DIN、SD_EN、SD_NF、またはSD_OCTの標準です。

 | dictMatProps | すべての材料特性情報です。
戻り値は辞書です。

 | GetValues | 材料特性値を取得および変換します。
戻り値は材料値のリスト（double）です。

 | SetValues | 新しい材料特性値を設定および変換します。
戻り値は辞書です。

属性​

GetValues​

keys​

材料特性のキーを指定する String のリストです。

これは必須の入力です。

unit​

変換される unit of material の Enum です。

単位がある材料特性の場合、単位を指定する必要があります。

単位がない材料特性の場合、単位はNone、-1、または空で設定する必要があります。

デフォルト値は-1です。

サンプルコード

mat0 = JPT.GetAllLibraryMaterials()[0]
dict1 = mat0.dictMatProps
list_keys=['Density', 'density', 'DENSITY']
unit=JPT.DensityUnit.Density_kg_m3
pprint(mat0.GetValues(keys=list_keys, unit=unit))

注意​

Footnotes​

属性は、現在の値から新しい値に変更/割り当てることができます。 ↩
