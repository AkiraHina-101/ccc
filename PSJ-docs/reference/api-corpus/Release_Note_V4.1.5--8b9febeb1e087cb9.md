# Release Note V4.1.5

Release Note V4.1.5

Highlight updates

This release mainly focuses on performance improvements along with few enhancements and bug fixes.

🚀 New Feature​

🛠 PSJ-Utility​

📝 API​

API commands related to database query are added:

List of newly added commands

JPT.GetProgramVersion() : Get Jupiter current release number.

JPT.GetContactType() : Get Abaqus contact type.

🐛 Bug Fix​

After importing a Parasolid file (in foreground and background mode), if a part or DItem with Japanese name in the assembly tree, Jupiter cannot read, put into part.name and print out. For example:

parts = JPT.GetAllParts()
for part in parts:
    print(part.name)

Jupiter crashes when PYTHONHOME and PYTHONPATH are set by other software.
