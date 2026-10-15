# MakeFacePlanar

MakeFacePlanar MakeFacePlanar Description Make planar faces by given plane points Syntax MakeFacePlanar(double[3] dPlanePt1, double[3] dPlanePt2, double[3] dPlanePt3, int[] nFaceIDs, bool mergeFace) Inputs Double[3] Plane point 1 Double[3] Plane point 2 Double[3] Plane point 3 Int[] Target faces for making planar surface([Face ID]) Bool Whether merge face or not True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code MakeFacePlanar([0.01, 0.01, 0.007272871569190634], [0.01, 0.01, 0], [0.003333333333333333, 0.01, 0], [47], 0)
