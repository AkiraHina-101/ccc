# Assembly.RightClick.Suppress()

Assembly.RightClick.Suppress()

Description​

Suppress part on Assembly tree.

Syntax​

Assembly.RightClick.Suppress(...)

Ribbon: Assembly » Right Click » Suppress

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

Return Code​

True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()
result = Assembly.RightClick.Suppress(crlParts=[Part(1)])
print(result)
