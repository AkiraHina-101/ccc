# FieldData()

FieldData()

説明​

フィールドデータテーブルを作成します。

構文​

FieldData(String m_strName,int m_iType,TSheetd m_Sheet,Cursor m_crEdit, bool bAbaqusAmp, int iChartType, bool bFrequencyPSJLogX, bool bFrequencyPSJLogY)

入力​

1. String​

テーブルの名前

2. Int​

テーブルの種類

3. TSheetd​

テーブルのデータ

4. Cursor​

編集フィールドテーブルカーソル（81：FieldData ID）

5. Bool​

Abaqus Amp ブールフラグ True = 1、False = 0

6. Int​

スムースステップ

7. Bool​

Frequency-PSD テーブルに対して対数X軸（LogX）でのデータ補間を有効にするかどうかを指定する Boolean です。

8. Bool​

Frequency-PSD テーブルに対して対数Y軸（LogY）でのデータ補間を有効にするかどうかを指定する Boolean です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

FieldData("Test", 15, [1, 2, 1000, 1e+08], 0:0, 0, 0)
