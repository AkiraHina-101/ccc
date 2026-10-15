# Assemble_Faces

Assemble_Faces Assemble_Faces Description Create assemble faces Syntax Assemble_Faces([id_mating_faces_list], double tol, int at_pos, double snap_tol, bool fit_edge) Inputs int[] List id mating faces. Not empty doube Tolerance to find mating faces int Connect position: 0 is mid-position, 1 is master position double Snap tolerance to boundary edges bool Fit edge: to keep circle edge shape: flag 0 : false, 1 : true Return Code 1 Succeeded, id[] list mating faces, id[] list new shared faces 0 Failed, [] Sample Code Assemble_Faces([24, 49], 0.00022232, 1, 5e-05, 0)
