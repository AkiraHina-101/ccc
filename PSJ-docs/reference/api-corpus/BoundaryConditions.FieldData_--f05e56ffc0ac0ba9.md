# BoundaryConditions.FieldData()

BoundaryConditions.FieldData()

説明​

荷重や境界条件を設定する際に使用できるフィールドデータテーブルを作成します。

構文​

BoundaryConditions.FieldData(...)

マクロ：

リボン：BoundaryConditions » FieldData

入力​

strName​

作成するテーブルの名前を指定する String です。

デフォルト値は "" です。

iType​

作成するテーブルの種類を指定する Integer です。

デフォルト値は 0 です。

ilSheet​

テーブルデータを指定する Integer のリスト です。

デフォルト値は [] です。

crEdit​

既存のフィールドデータを指定する Cursor です。このパラメータを使用すると、指定されたフィールドデータが変更されます。None のままにすると、新しいフィールドデータが作成されます。

デフォルト値は None です。

bAbaqusAmp​

Abaqus振幅が有効化されているかどうかを指定する Boolean です。

デフォルト値は False（無効）です。

iAmpType​

振幅の種類を指定する Integer です。

デフォルト値は 0 です。

bFrequencyPSJLogX​

Frequency-PSD テーブルに対して対数X軸（LogX）でのデータ補間を有効にするかどうかを指定する Boolean です。

デフォルト値は False です。

bFrequencyPSJLogY​

Frequency-PSD テーブルに対して対数Y軸（LogY）でのデータ補間を有効にするかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

作成されたLBCを指定する Cursor です。

サンプルコード​

created_lbc = BoundaryConditions.FieldData(strName="XYZ1",
                                           iType=1,
                                           ilSheet=[2,
                                                    4,
                                                    1,
                                                    1,
                                                    1,
                                                    10,
                                                    1,
                                                    2,
                                                    1,
                                                    20])

JPT.Debugger(created_lbc)
