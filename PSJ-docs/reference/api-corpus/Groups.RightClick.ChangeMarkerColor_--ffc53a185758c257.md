# Groups.RightClick.ChangeMarkerColor()

Groups.RightClick.ChangeMarkerColor()

Description​

Change marker color of the group.

Syntax​

Groups.RightClick.ChangeMarkerColor(...)

Ribbon: Groups » RightClick » Marker

Inputs​

list​

List of pair of Cursor and color specifying the group and its marker color.

The default value is None.

Return Code​

A Boolean specifying whetehr the function succeeded or not.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create groups
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Face(26)])
Tools.Group.CreateGroup(strGroupName="Group2", crlTargets=[Face(24)])

# Show marker color
JPT.Exec('ViewShowGroupMarker(1)')
# Change marker color
Groups.RightClick.ChangeMarkerColor(listGroupColors=[[Group(1), 10616736]])
Groups.RightClick.ChangeMarkerColor(listGroupColors=[[Group(2), 16716288]])
