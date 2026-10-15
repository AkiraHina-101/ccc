# CreateSphere

CreateSphere CreateSphere Description Create Sphere Body Syntax CreateSphere(double[3] vdOriginXYZ, double dRadius, int nLatitudeNodeCnt, int nLongitudeNodeCnt,string strBodyName, color colBody, cursor crCoord) Inputs Double[3] Origin coordinate Point([x, y, z]) Double Sphere radius value (m) Int Latitude node count int Longitude node count String Part name Color N/A Part color Cursor Whether use local coordinate or not True = 27:*, False = 0:0 Return Code 1 Succeeded 0 Failed Sample Code CreateSphere([0, 0, 0], 0.005, 50, 100, "Sphere_1", 11908427, 0:0)
