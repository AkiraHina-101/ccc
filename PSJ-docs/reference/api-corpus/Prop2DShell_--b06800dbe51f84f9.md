# Prop2DShell()

Prop2DShell()

Description​

create property 2D shell

Syntax​

Prop2DShell(String m_strName,int m_ulId,Cursor m_crMatMembrane,Cursor m_crMatBend,
    Cursor m_crMatShear,Cursor m_crMatCoupl,double m_matOrient[0],double m_matOrient[1],
    double m_matOrient[2],double m_dThickness,double m_dBendStiff,double m_dThickRatio,
    double m_dNSM,double m_dFiberDist[0],double m_dFiberDist[1],double m_dPlateOff,
    int m_iItgPts,int m_matOrientType,Cursor m_crLocalCS,Cursor[] taTarget,Cursor crEdit,
    int duplicateOpt)

Inputs​

1. String​

name of property 2D shell

2. Int​

key of property 2D shell

3. Cursor​

cursor of membrane material

4. Cursor​

cursor of bending material

5. Cursor​

cursor of shear material

6. Cursor​

cursor of coupling material

7. Double​

theta[degree]

8. Double​

not used

9. Double​

not used

10. Double​

thickness

11. Double​

Bending stiffness

12. Double​

thickness ratio

13. Double​

nonstructural mass

14. Double​

fiber dist 1

15. Double​

fiber dist 2

16. Double​

plate offset

17. Int​

No SHELL Integration points

18. Int​

material orientation by[0: Theta; 1: coordinate system]

19. Cursor​

local coordinate system

20. Cursor[]​

targets

21. Cursor​

edit cursor

22. Int​

answer of message box when targets are duplicated[0: targets are not duplicated; 2: cancel; 6: yes; 7: no]

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property2DShell("Shell Property 1", 1, 22:2, 22:2, 22:2, 22:2, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 0.002, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 2147483647, 0, 0:0, [3:2, 6:27], 0:0, 0)
