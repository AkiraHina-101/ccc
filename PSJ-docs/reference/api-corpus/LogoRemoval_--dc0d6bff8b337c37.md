# LogoRemoval()

LogoRemoval()

Description​

Create Face From Edges

Syntax​

LogoRemoval(cursor[] startFaces, cursor[] stopFaces, int layers, bool mergeFace)

Inputs​

1. Cursor[]​

Start faces cursor list ([6:Face ID])

2. Cursor[]​

End faces cursor list ([6:Face ID])

3. Int​

Layer count of adjacent faces to the start faces

4. Bool​

Whether merge face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

LogoRemoval([6:84, 6:77, 6:95, 6:64], [6:2], 5, 0)
