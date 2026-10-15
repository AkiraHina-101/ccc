# Frequently Asked Questions (FAQ)

Frequently Asked Questions (FAQ)

Below are some questions we often receive from customers:

Q1. How can I use format with macro that have parameters with {}?

Q2. How can I get entities inside a group?

Q3. How can I get multiple return value splitting each of them?

Q4. Which and how many methods DItem has?

Q5. How can I get Master/Slave entities from the selected entity?

Q6. How can I get elapsed time for each command?

Q7. How can I rename a part?

Q8. How can I install a new module?

Q1. How can I use format with macro that have parameters with {}?​

Using %

targetParts=[3:1]
JPT.Exec('VolMeshing(%s, {1, 1.05, 0, 0.1, 1, 0, 1, 1, 0, 4, 1, 1, 1, 0}, 0, 65280)'%(targetParts))

Using .format{}

targetParts=[3:1]
params={1, 1.05, 0, 0.1, 1, 0, 1, 1, 0, 4, 1, 1, 1, 0}
JPT.Exec('VolMeshing({0}, {1}, 0, 65280)'.format(targetParts,params)

or

targetParts=[3:1]
JPT.Exec('VolMeshing({0}, {{1, 1.05, 0, 0.1, 1, 0, 1, 1, 0, 4, 1, 1, 1, 0}}, 0, 65280)'.format(targetParts)

Q2. How can I get entities inside a group?​

groups=JPT.GetAllGroups()
for g in groups:
    for e in g.targets:
        print(str(e.typeID)+' '+str(e.id))

Q3. How can I get multiple return value splitting each of them?​

import re
from itertools import groupby

def remove_dup_char(s, c):
    return ''.join(c if a==c else ''.join(b) for a,b in groupby(s))

result=JPT.Exec('FindHoles([], [], 0, 12.345, 0)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)

res = []
for s in splitted:
  s = remove_dup_char(s, '[')
  s = remove_dup_char(s, ']')
  print (s)

Q4. Which and how many methods DItem has?​

obj = JPT.DItem()
for x in dir(obj):
      print(x)

Q5. How can I get Master/Slave entities from the selected entity?​

sel = JPT.GetAllSelected()
for s in sel:
  for m in s.masters:
      print(str(m.id))
  for s in s.slaves:
      print(str(s.id))

Q6. How can I get elapsed time for each command?​

import time
start = time.time()

# Write commands to measure elapsed time
elapsed_time = time.time() - start

Q7. How can I rename a part?​

JPT.Exec('RenameItem("newname", 3:5)')

Q8. How can I install a new module?​

Installation by folder copy (up to V4.0.x)

Check the Python version of Jupiter (in V4.0.2 is 3.6.3).

Install the same Python version to your machine.

Install the module using the pip command in Python to your machine.
-> A module folder will be created under the \Lib\site-package folder in the Python installation folder.

Copy the created folder under the Jupiter-Pre installation folder \Lib\site-packages.

Install with pip (V4.1 or later)

Open a command prompt with administrator mode

Move to Jupiter installation folder

Enter the following command:

python -m pip install <module>

danger

If you update Jupiter, the additional installed libraries will basically remain.
However, if the Python version of Jupiter has been updated, the library may stop working.
In that case, please reinstall the appropriate version of the library.
