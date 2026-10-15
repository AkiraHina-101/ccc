# CreateAbaqusJob()

CreateAbaqusJob()

説明​

Abaqus ジョブを作成します。

構文​

CreateAbaqusJob(string m_strName,bool m_bRBE2toMPC,bool m_bRenameProcess,
    int m_iCodeType,int m_iSurfDefType,int m_iUnit,int m_iWriteType,
    string m_strDescription,cursor[] m_taStepSequence,cursor m_crEditCursor)

入力​

1. String​

ジョブ名

2. Bool​

REB3 を MPC として出力します

3. Bool​

ステップ名を変更するかどうか

4. Int​

REB3 を MPC として出力します

5. Int​

サーフェス定義 [0: 要素セットで 1: 要素で]

6. Int​

単位系

7. Int​

出力タイプ [0: モデルで 1: 選択した パートで]

8. String​

このジョブの説明

9. Cursor[]​

このジョブに適用されるステップ

10. Cursor​

ジョブの編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateAbaqusJob("Abaqus", 0, 0, 0, 0, 1, 0, "", [], 0:0, [], 0, 0, 0, 0, 1, 22:2)
