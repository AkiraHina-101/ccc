# Properties.Material.Add()

Properties.Material.Add()

説明​

現在のユーザーデータベースライブラリに新しい材料を作成します。

このコマンドはV5.0シリーズと互換性がありません。V5.1でV5.0.1-V5.0.4で実行中のスクリプトを使用したい場合は、スクリプトを修正してください。

構文​

Properties.Material.Add(...)

リボン: Properties » Material » Add

入力​

strMaterialName​

材料名を指定する String です。

これは必須の入力項目です。

dictMaterialProperty​

dictMatProps を指定する dictionary です。

これは必須の入力項目です。

listMaterialProperty​

MATERIAL PROPERTYのリスト を指定し、density, elasticity などのプロパティのすべての属性を指定します。

:::注意
この入力はV5.1から廃止されました。代わりに dictMaterialProperty を使用してください。
:::

iMaterialID​

追加する材料の NasID を指定する Integer です。

NasID は *.mlib 材料ライブラリファイルで参照できます。

これは必須の入力項目です。

iMaterialColor​

カラーのIDを指定する Integer です。

デフォルト値は0です。

strDescription​

材料の説明を指定する String です。

デフォルト値は""です。

戻り値​

作成された新しい材料を指定する Cursor です。

サンプルコード​

# 単位付きの材料を準備する
dict_mat_prop = {
    'Density': {
        'density': {
            'DENSITY': [8.3e-9],
        },
    },
    'Elastic': {
        'elastic': {
            'POISSONS_RATIO': [0.3],
            'YOUNGS_MODULUS': [1.1e+5],
            'SHEAR_MODULUS': [5.2e+3],
        }
    },
    'Unit': {
        'Density': {
            'density': {  
                'DENSITY': JPT.DensityUnit.Density_t_mm3
            }
        },
        'Elastic': {
            'elastic': {  
                'YOUNGS_MODULUS': JPT.ModulusUnit.Modulus_N_mm2
            }
        }
    }
}

# ドキュメントに新しい材料を追加
new_material=Properties.Material.Add(
    strMaterialName="NewMaterial", 
    dictMaterialProperty=dict_mat_prop,
    iMaterialID=1, 
    iMaterialColor=9614382)

JPT.Debugger(new_material) # 戻り値の確認のため
