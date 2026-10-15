# Connections.Contacts.ExportCheckReport()

Connections.Contacts.ExportCheckReport()

Description​

Export the contact report of the current model to html/excel format. This function allows modifying report settings such as picture control, sort, and filter.

Syntax​

Connections.Contacts.ExportCheckReport(...)

Ribbon: Connections » Contacts » Export Check Report

Inputs​

strPath​

A String specifying the destination path of the HTML/Excel file to be exported. The destination path should be different from the C Drive (C:/) due to Window would deny saving any files to the C Drive directly (It is recommended to save in User's Drive such as D Drive, E Drive,...).

This is a required input.

dZoomFactor​

A Double specifying the zoom factor when capturing the image.
If the zoom factor is greater than 1, the captured model will become larger (zoom in).

if the zoom factor is smaller than 1, the captured model will become smaller (zoom out).

The default value is 1.2.

iFitBy​

An Integer specifying which entity type will be focused on when capturing the image.
If iFitBy=0: Part - Fit to Part. The part contains Master/Slave face of contact will be focused on when capturing.

If iFitBy=1: Face - Fit to Contact face. The face which is Master/Slave face of contact will be focused on when capturing.

The default value is 0.

iListBy​

An Integer specifying the contact report will be listed by type.
If iListBy=0: Part - List by Part: This option will list contacts in all parts of the model. The duplication of contacts is allowable.

If iListBy=1: Contact Condition - List by contact condition: This option will list contacts by the existing contacts in the model, each contact will be declared only once a time. The duplication of contacts will not occur.

The default value is 0.

iListOrder​

An Integer specifying the order sort type of contacts in report.
If iListOther=0: Name - Sort Result by Name: This option will list contacts in the report by Alphabetical order (from A-Z).

If iListOther=1: ID - Sort Result by identify number: This option will list contacts in the report by ID Numerical order (ascending order).

The default value is 0.

iFormat​

An Integer specifying the file format type.
If iFormat=0: the contact report will be exported by HTML format file.

If iFormat=1: the contact report will be exported by Excel format file.

The default value is 0.

Return Code​

A Boolean specifying whether the HTML file is exported correctly or not:

True: The HTML file is exported correctly.

False: The HTML file is exported correctly.

Sample Code​

from os import environ
import re

Geometry.Part.Cube(iPartColor=15132254)
Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6013120)
Geometry.Part.Cube(dlOrigin=[0.011, 0.01, 0.0],
                   strName="Cube_3",
                   iPartColor=5395146)
Tools.Group.CreateGroup(strGroupName="Group1",
                        crlTargets=[Face(73)])
Tools.Group.CreateGroup(strGroupName="Group2",
                        crlTargets=[Face(48)])
Assembly.RightClick.Rename(strNewName="Master",
                           crItem=Group(1))
Assembly.RightClick.Rename(strNewName="Slave",
                           crItem=Group(2))
Meshing.SolidMeshing(crlParts=[Part(1, 2, 3)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_M",
                        crlTargets=[Face(24)])
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_S",
                        crlTargets=[Face(49)])

# Create face contact (Abaqus)
creating_status = Connections.Contacts.Abaqus.ManualFace(strName="ContactAbaqus_1",
                                                         dAdjustWidth=0.01,
                                                         dExtensionZone=DFLT_DBL,
                                                         dMaxPenetration=DFLT_DBL,
                                                         iSmallSliding=1,
                                                         dSmoothAngle=DFLT_DBL,
                                                         iFrictionType=1,
                                                         dFrictionCoeff1=0.015,
                                                         dFrictionCoeff2=DFLT_DBL,
                                                         dShearStressLimit=DFLT_DBL,
                                                         dSlipTolerance=DFLT_DBL,
                                                         dStaticFrictionCoeff=DFLT_DBL,
                                                         dKineticFrictionCoeff=DFLT_DBL,
                                                         dDecayCoeff=DFLT_DBL,
                                                         bAdjustPosition=True,
                                                         dPositionTolerance=DFLT_DBL,
                                                         dContactStiffness=DFLT_DBL,
                                                         tshPressureOverclosure=[0, 0],
                                                         tshClearanceData=[1, 2, DFLT_DBL, DFLT_DBL],
                                                         tshPressureData=[1, 2, DFLT_DBL, DFLT_DBL],
                                                         crplTargets=[CursorPair(Group(3), Group(4))],
                                                         iContactColor=16711680)

export_status = Connections.Contacts.ExportCheckReport(strPath=(re.sub(re.escape("\\"), "/", environ["Temp"]) +
                                                                "/TechnoStar/ExportContact.html"),
                                                       iFitBy=1,
                                                       iListBy=1,
                                                       iListOrder=1)

JPT.Debugger(export_status)
