# Assemble_Faces_MatingStep

Assemble_Faces_MatingStep Assemble_Faces_MatingStep Description Find mating faces Syntax Assemble_Faces_MatingStep([6:face_id_master_list], [6:face_id_slave_list], [3:body_id_list], double tol) Inputs Cursor[] List ID master faces. Empty is okay Cursor[] List ID slave faces. Empty is okay Cursor[] List ID bodies. Empty is okay double Tolerance to find mating faces Return Code 1 Succeeded, id[] list mating faces 0 Failed, [] Sample Code Assemble_Faces_MatingStep([6:50, 6:47], [6:23, 6:21], [3:1, 3:2], 0.00022222)
