# Geom_ShowAdjacent_Elements()

Geom_ShowAdjacent_Elements()

Description​

Select element(s) then it results in the Adjacent elements with the given constraints

Syntax​

Geom_ShowAdjacent_Elements(double stopAngle,bool IncludeStopFace,int Layer,bool IsPreview,
    Cursor[] startFaceCursor,Cursor[] stopFaceCursor)

Inputs​

1. Double​

Stop Angle value

2. Bool​

Value of whether stop elem has to be included or not

3. Int​

number of Layers

4. Bool​

Whether the result is preview or Run

5. Cursor[]​

List of Start elements cursor([11:Elem ID])

6. Cursor[]​

List of Stop elements cursor([11:Elem ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​
