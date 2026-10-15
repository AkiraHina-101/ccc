# TemperatureLoad()

TemperatureLoad()

説明​

温度荷重を作成します。

構文​

TemperatureLoad(string m_strName,int nType,double fTemp,string strFilePathName,
    Cursor crTable,Cursor[] m_taTarget,Cursor m_crEdit,bool bUseAsMaterialReferenceTemp)

入力​

1. String​

温度荷重の名前

2. Int​

タイプ[0：一定; 1：Nastran Punch]

3. Double​

温度の値

4. String​

ファイルパス

5. Cursor​

テーブルを選択

6. Cursor[]​

対象

7. Cursor​

編集カーソル

8. Bool​

材料参照温度として使用する場合

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TemperatureLoad("Test",1,0.001,"Test",1:11,[1:11,2:12],1:11,1)
