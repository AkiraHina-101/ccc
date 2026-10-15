# BodyCutBySurfaceS

BodyCutBySurfaceS BodyCutBySurfaceS Description Body Cut By 3 Points Syntax BodyCutBySurfaceS(cursor[] crBody, cursor cutFace, bool splitOnly, bool makeSectionFace, bool shareFace, bool separateFace) Inputs Cursor[] Target part cursor([3:PartID]) Cursor Target face for cutting Bool Whether split face or not True = 1, False = 0 Bool Whether make section face or not True = 1, False = 0 Bool Whether share face or not True = 1, False = 0 Bool Whether separate face or not True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code BodyCutBySurfaceS([3:2], 3:9, 0, 1, 0, 0)
