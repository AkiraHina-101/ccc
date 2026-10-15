# Geom_ShowAdjacent()

Geom_ShowAdjacent()

Description​

Select face(s) then it results in the Adjacent faces with the given constraints

Syntax​

Geom_ShowAdjacent(double stopAngle,bool IncludeStopFace,int Layer,bool IsPreview,Cursor[] startFaceCursor,
    Cursor[] stopFaceCursor)

Inputs​

1. Double​

Stop Angle value

2. Bool​

Value of whether stop face has to be included or not

3. Int​

number of Layers

4. Bool​

Whether the result is preview or Run

5. Cursor[]​

List of Start faces cursor([6:Face ID])

6. Cursor[]​

List of Stop faces cursor([6:Face ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​
