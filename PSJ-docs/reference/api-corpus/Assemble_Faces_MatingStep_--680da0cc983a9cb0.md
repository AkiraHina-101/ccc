# Assemble_Faces_MatingStep()

Assemble_Faces_MatingStep()

説明​

フェースの対応関係を見つけます

構文​

Assemble_Faces_MatingStep(cursor[] face_id_master_list, cursor[] face_id_slave_list, cursor[] body_id_list, double tol)

入力​

1. Cursor[]​

リスト ID マスターフェース。空白でも問題ありません

2. Cursor[]​

リスト ID スレーブフェース。空白でも問題ありません

3. Cursor[]​

リスト ID  パート。空白でも問題ありません

4. Double​

対応するフェースを見つけるための許容差

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Assemble_Faces_MatingStep([6:50, 6:47], [6:23, 6:21], [3:1, 3:2], 0.00022222)
