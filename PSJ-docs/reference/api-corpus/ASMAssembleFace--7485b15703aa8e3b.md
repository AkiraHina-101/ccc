# ASMAssembleFace

ASMAssembleFace ASMAssembleFace Description Assemble multiple parts in a model Syntax ASMAssembleFace(int[] taBodyKey, int[] taFaceKey, double tolerance, bool fitEdge, bool meshSetting) Inputs int[] Part key cursor([Part ID]) int[] Face key cursor([Face ID]) Double Mating tolerance Bool Imprint fit edge bool flag True = 1, False = 0 Bool N/A Mesh setting bool flag True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code ASMAssembleFace([], [22, 47], 0.001, 0, 1)
