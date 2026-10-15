# CadProject()

CadProject()

Description​

CadProject Part/Face/Face To Edge

Syntax​

CadProject(int method,Cursor crCadEntity,Cursor crMeshedEntity,bool ForceProject,
    bool CornerNodes,bool MidNodes,bool IdCheck)

Inputs​

1. int​

Projection type (Part=1,Face=2,Face to Face=3)

2. Cursor​

Cad Entity cursor ([?:*]?=Item Number,*=ID)

3. Cursor​

Meshed Entity cursor ([?:*]?=Item Number,*=ID)

4. bool​

ForceProject Flag true = 1,false=0

5. bool​

Project CornerNodes Flag true = 1,false=0

6. bool​

Project MidNodes Flag true = 1,false=0

7. bool​

Perform Entity IdCheck Flag true = 1,false=0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CadProject(1, 3:1, 3:2, 1, 1, 1, 1)
