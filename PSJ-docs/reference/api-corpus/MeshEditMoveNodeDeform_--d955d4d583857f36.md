# MeshEditMoveNodeDeform()

MeshEditMoveNodeDeform()

説明​

節点を変形して移動します。

構文​

MeshEditMoveNodeDeform(int m_solverType,String m_strFilePath,int m_iStep,double m_dScale)

入力​

1. Int​

ソルバーの種類

2. String​

ファイルのパス

3. Int​

ステップ

4. Double​

スケールの値

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeshEditMoveNodeDeform(1,"Test",1,0.001)
