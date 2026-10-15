# Geometry.MakeFacePlanar()

Geometry.MakeFacePlanar()

Description​

This method flattens the curved faces or bumpy faces into planar faces defined by a set of three-nodes.

Syntax​

Geometry.MakeFacePlanar(dlPlanePt1=[0.0,0.0,0.0], dlPlanePt2=[0.0,0.0,0.0],
    dlPlanePt3=[0.0,0.0,0.0], ilFaceIds=[], iMergeFace=0)

Macro: MakeFacePlanar

Ribbon: Geometry » Make Face Planar

Inputs​

dlPlanePt1​

A List of Double specifying the plane point 1.

The default value is [0.0,0.0,0.0].

dlPlanePt2​

A List of Double specifying the plane point 2.

The default value is [0.0,0.0,0.0].

dlPlanePt3​

A List of Double specifying the plane point 3.

The default value is [0.0,0.0,0.0].

ilFaceIds​

A List of Integer specifying the target face ids.

The default value is [].

iMergeFace​

An Integer specifying whether to merge adjacent faces to each other after the operation. Possible values are 0 and 1.

If iMergeFace=0, do not merge faces after the operation.

If iMergeFace=1, merge faces after the operation.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Part.Trapezoid(dlOrigin=[0.0005, 0.0005, 0.01], dlLength=[0.005, 0.005, 0.005],
    dTopXLength=3.0, strName="Trapezoid_5", iPartColor=7697908)

Geometry.MakeFacePlanar(dlPlanePt1=[0.01, 0.0, 0.01], dlPlanePt2=[0.01, 0.01, 0.01],
    dlPlanePt3=[0.0, 0.01, 0.01], ilFaceIds=[52, 50, 48, 49, 47])
