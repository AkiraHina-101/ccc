# ConcentrateFlux()

ConcentrateFlux()

説明​

集束フラックスを作成します

構文​

ConcentrateFlux(String m_strName,double fflux,Cursor crTable,Cursor[] m_taTarget,Cursor m_crEdit)

入力​

1. String​

集束フラックスの名前

2. Double​

集束フラックスの値

3. Cursor​

テーブルを選択します

4. Cursor[]​

対象

5. Cursor​

編集カーソル

戻り値​

"1": 関数は実行できます

"0": 関数は実行できません

サンプルコード​

ConcentrateFlux("Test",0.001,1:11,[1:11,2:12],1:11)
