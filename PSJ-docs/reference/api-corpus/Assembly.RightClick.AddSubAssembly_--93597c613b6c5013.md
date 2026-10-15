# Assembly.RightClick.AddSubAssembly()

Assembly.RightClick.AddSubAssembly()

Description​

Add a new assembly (Sub-assembly) to the selected assembly.

Syntax​

Assembly.RightClick.AddSubAssembly(...)

Ribbon: Assembly » Right Click » Add Subassembly

Inputs​

crInst​

A Cursor specifying the instance inwhich the new subassembly will be added.

The default value is None.

Return Code​

A Cursor specifying the created sub-assembly.

Sample Code​

Geometry.Part.Cube()

Assembly.RightClick.AddSubAssembly()
created_sub_assem = Assembly.RightClick.AddSubAssembly(crInst=Inst(1))

JPT.Debugger(created_sub_assem)
