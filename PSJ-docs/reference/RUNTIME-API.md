# API runtime Jupiter 5.0.4

Đọc qua MCP ngày 2026-10-12 trong phiên riêng. Không gọi các API tác động model. Alias được gộp; chữ ký Python/docstring C++ lấy trực tiếp, không suy đoán.

## JPT.AddPyObserver

```text
JPT.AddPyObserver


AddPyObserver( (object)arg1) -> None :

    C++ signature :
        void AddPyObserver(class boost::python::api::object)
```

## JPT.Apply

```text
JPT.Apply


Apply() -> None :

    C++ signature :
        void Apply()
```

## JPT.AssociateType

```text
JPT.AssociateType


```

## JPT.AssociateType.as_integer_ratio

```text
JPT.AssociateType.as_integer_ratio(self, /)

Return integer ratio.

Return a pair of integers, whose ratio is exactly equal to the original int
and with a positive denominator.

>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

## JPT.AssociateType.bit_length

```text
JPT.AssociateType.bit_length(self, /)

Number of bits necessary to represent self in binary.

>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

## JPT.AssociateType.conjugate

```text
JPT.AssociateType.conjugate

Returns self, the complex conjugate of any int.
```

## JPT.AssociateType.from_bytes

```text
JPT.AssociateType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.AssociateType.to_bytes

```text
JPT.AssociateType.to_bytes(self, /, length, byteorder, *, signed=False)

Return an array of bytes representing an integer.

  length
    Length of bytes object to use.  An OverflowError is raised if the
    integer is not representable with the given number of bytes.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Determines whether two's complement is used to represent the integer.
    If signed is False and a negative integer is given, an OverflowError
    is raised.
```

## JPT.BeginDatabaseTransaction

```text
JPT.BeginDatabaseTransaction


BeginDatabaseTransaction( (str)arg1) -> None :

    C++ signature :
        void BeginDatabaseTransaction(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## JPT.BodyVector

```text
JPT.BodyVector


```

## JPT.BodyVector.addObj

```text
JPT.BodyVector.addObj


addObj( (BodyVector)arg1, (DBody)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue},class DBodyW)
```

## JPT.BodyVector.append

```text
JPT.BodyVector.append


append( (BodyVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue},class boost::python::api::object)
```

## JPT.BodyVector.clearVec

```text
JPT.BodyVector.clearVec


clearVec( (BodyVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue})
```

## JPT.BodyVector.deleteObj

```text
JPT.BodyVector.deleteObj


deleteObj( (BodyVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue},int)
```

## JPT.BodyVector.extend

```text
JPT.BodyVector.extend


extend( (BodyVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue},class boost::python::api::object)
```

## JPT.BodyVector.extendVec

```text
JPT.BodyVector.extendVec


extendVec( (BodyVector)arg1, (BodyVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue},class std::vector<class DBodyW,class std::allocator<class DBodyW> >)
```

## JPT.BodyVector.isContainObj

```text
JPT.BodyVector.isContainObj


isContainObj( (BodyVector)arg1, (DBody)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DBodyW,class std::allocator<class DBodyW> >,class DBodyW)
```

## JPT.BodyVector.sizeVec

```text
JPT.BodyVector.sizeVec


sizeVec( (BodyVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DBodyW,class std::allocator<class DBodyW> > {lvalue})
```

## JPT.BoolType

```text
JPT.BoolType


```

## JPT.BoolType.from_bytes

```text
JPT.BoolType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.CSVExportFormatSetting

```text
JPT.CSVExportFormatSetting


CSVExportFormatSetting( (int)arg1) -> None :

    C++ signature :
        void CSVExportFormatSetting(int)
```

## JPT.Cancel

```text
JPT.Cancel


Cancel() -> None :

    C++ signature :
        void Cancel()
```

## JPT.CastDItemToDBody

```text
JPT.CastDItemToDBody


CastDItemToDBody( (DItem)arg1) -> DBody :

    C++ signature :
        class DBodyW CastDItemToDBody(class DItemW)
```

## JPT.CastDItemToDConnect

```text
JPT.CastDItemToDConnect


CastDItemToDConnect( (DItem)arg1) -> DConnect :

    C++ signature :
        class DConnectW CastDItemToDConnect(class DItemW)
```

## JPT.CastDItemToDContact

```text
JPT.CastDItemToDContact


CastDItemToDContact( (DItem)arg1) -> DContact :

    C++ signature :
        class DContactW CastDItemToDContact(class DItemW)
```

## JPT.CastDItemToDCoord

```text
JPT.CastDItemToDCoord


CastDItemToDCoord( (DItem)arg1) -> DCoord :

    C++ signature :
        class DCoordW CastDItemToDCoord(class DItemW)
```

## JPT.CastDItemToDEdge

```text
JPT.CastDItemToDEdge


CastDItemToDEdge( (DItem)arg1) -> DEdge :

    C++ signature :
        class DEdgeW CastDItemToDEdge(class DItemW)
```

## JPT.CastDItemToDElem

```text
JPT.CastDItemToDElem


CastDItemToDElem( (DItem)arg1) -> DElem :

    C++ signature :
        class DElemW CastDItemToDElem(class DItemW)
```

## JPT.CastDItemToDFace

```text
JPT.CastDItemToDFace


CastDItemToDFace( (DItem)arg1) -> DFace :

    C++ signature :
        class DFaceW CastDItemToDFace(class DItemW)
```

## JPT.CastDItemToDGroup

```text
JPT.CastDItemToDGroup


CastDItemToDGroup( (DItem)arg1) -> DGroup :

    C++ signature :
        class DGroupW CastDItemToDGroup(class DItemW)
```

## JPT.CastDItemToDLoadBC

```text
JPT.CastDItemToDLoadBC


CastDItemToDLoadBC( (DItem)arg1) -> DLoadBC :

    C++ signature :
        class DLoadBCW CastDItemToDLoadBC(class DItemW)
```

## JPT.CastDItemToDNode

```text
JPT.CastDItemToDNode


CastDItemToDNode( (DItem)arg1) -> DNode :

    C++ signature :
        class DNodeW CastDItemToDNode(class DItemW)
```

## JPT.CastDItemToDROElem

```text
JPT.CastDItemToDROElem


CastDItemToDROElem( (DItem)arg1) -> DPostElem :

    C++ signature :
        class DROElemW CastDItemToDROElem(class DItemW)
```

## JPT.CastDItemToDRONode

```text
JPT.CastDItemToDRONode


CastDItemToDRONode( (DItem)arg1) -> DPostNode :

    C++ signature :
        class DRONodeW CastDItemToDRONode(class DItemW)
```

## JPT.CastToDItem

```text
JPT.CastToDItem


CastToDItem( (DBody)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DBodyW)

CastToDItem( (DFace)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DFaceW)

CastToDItem( (DNode)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DNodeW)

CastToDItem( (DEdge)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DEdgeW)

CastToDItem( (DElem)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DElemW)

CastToDItem( (DGroup)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DGroupW)

CastToDItem( (DCoord)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DCoordW)

CastToDItem( (DConnect)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DConnectW)

CastToDItem( (DContact)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DContactW)

CastToDItem( (DLoadBC)arg1) -> DItem :

    C++ signature :
        class DItemW CastToDItem(class DLoadBCW)
```

## JPT.CheckLicense

```text
JPT.CheckLicense


CheckLicense( (str)arg1) -> bool :

    C++ signature :
        bool CheckLicense(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## JPT.ClearAllSelection

```text
JPT.ClearAllSelection


ClearAllSelection() -> None :

    C++ signature :
        void ClearAllSelection()
```

## JPT.ClearDraw

```text
JPT.ClearDraw


ClearDraw() -> None :

    C++ signature :
        void ClearDraw()
```

## JPT.ClearLog

```text
JPT.ClearLog


ClearLog() -> None :

    C++ signature :
        void ClearLog()
```

## JPT.ClearPreview

```text
JPT.ClearPreview


ClearPreview() -> None :

    C++ signature :
        void ClearPreview()
```

## JPT.ClearPyObserver

```text
JPT.ClearPyObserver


ClearPyObserver() -> None :

    C++ signature :
        void ClearPyObserver()
```

## JPT.ClearRedo

```text
JPT.ClearRedo


ClearRedo() -> None :

    C++ signature :
        void ClearRedo()
```

## JPT.ClearUndo

```text
JPT.ClearUndo


ClearUndo() -> None :

    C++ signature :
        void ClearUndo()
```

## JPT.CloseAllGraphViews

```text
JPT.CloseAllGraphViews


CloseAllGraphViews() -> None :

    C++ signature :
        void CloseAllGraphViews()
```

## JPT.CloseDocumentByID

```text
JPT.CloseDocumentByID


CloseDocumentByID( (str)arg1) -> None :

    C++ signature :
        void CloseDocumentByID(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.CloseDocumentByName

```text
JPT.CloseDocumentByName


CloseDocumentByName( (str)arg1) -> None :

    C++ signature :
        void CloseDocumentByName(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.CloseGraphViewByDocumentName

```text
JPT.CloseGraphViewByDocumentName


CloseGraphViewByDocumentName( (str)arg1) -> bool :

    C++ signature :
        bool CloseGraphViewByDocumentName(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.CollapseAssemblyTree

```text
JPT.CollapseAssemblyTree


CollapseAssemblyTree() -> None :

    C++ signature :
        void CollapseAssemblyTree()
```

## JPT.ConnectVector

```text
JPT.ConnectVector


```

## JPT.ConnectVector.addObj

```text
JPT.ConnectVector.addObj


addObj( (ConnectVector)arg1, (DConnect)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue},class DConnectW)
```

## JPT.ConnectVector.append

```text
JPT.ConnectVector.append


append( (ConnectVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue},class boost::python::api::object)
```

## JPT.ConnectVector.clearVec

```text
JPT.ConnectVector.clearVec


clearVec( (ConnectVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue})
```

## JPT.ConnectVector.deleteObj

```text
JPT.ConnectVector.deleteObj


deleteObj( (ConnectVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue},int)
```

## JPT.ConnectVector.extend

```text
JPT.ConnectVector.extend


extend( (ConnectVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue},class boost::python::api::object)
```

## JPT.ConnectVector.extendVec

```text
JPT.ConnectVector.extendVec


extendVec( (ConnectVector)arg1, (ConnectVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue},class std::vector<class DConnectW,class std::allocator<class DConnectW> >)
```

## JPT.ConnectVector.isContainObj

```text
JPT.ConnectVector.isContainObj


isContainObj( (ConnectVector)arg1, (DConnect)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DConnectW,class std::allocator<class DConnectW> >,class DConnectW)
```

## JPT.ConnectVector.sizeVec

```text
JPT.ConnectVector.sizeVec


sizeVec( (ConnectVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DConnectW,class std::allocator<class DConnectW> > {lvalue})
```

## JPT.ContactVector

```text
JPT.ContactVector


```

## JPT.ContactVector.addObj

```text
JPT.ContactVector.addObj


addObj( (ContactVector)arg1, (DContact)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue},class DContactW)
```

## JPT.ContactVector.append

```text
JPT.ContactVector.append


append( (ContactVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue},class boost::python::api::object)
```

## JPT.ContactVector.clearVec

```text
JPT.ContactVector.clearVec


clearVec( (ContactVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue})
```

## JPT.ContactVector.deleteObj

```text
JPT.ContactVector.deleteObj


deleteObj( (ContactVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue},int)
```

## JPT.ContactVector.extend

```text
JPT.ContactVector.extend


extend( (ContactVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue},class boost::python::api::object)
```

## JPT.ContactVector.extendVec

```text
JPT.ContactVector.extendVec


extendVec( (ContactVector)arg1, (ContactVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue},class std::vector<class DContactW,class std::allocator<class DContactW> >)
```

## JPT.ContactVector.isContainObj

```text
JPT.ContactVector.isContainObj


isContainObj( (ContactVector)arg1, (DContact)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DContactW,class std::allocator<class DContactW> >,class DContactW)
```

## JPT.ContactVector.sizeVec

```text
JPT.ContactVector.sizeVec


sizeVec( (ContactVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DContactW,class std::allocator<class DContactW> > {lvalue})
```

## JPT.ConvertCoordinateFromGlobalToLocal

```text
JPT.ConvertCoordinateFromGlobalToLocal


ConvertCoordinateFromGlobalToLocal( (int)arg1, (int)arg2, (DCoord)arg3) -> PositionPairVector :

    C++ signature :
        class std::vector<struct std::pair<int,struct TVector3<double> >,class std::allocator<struct std::pair<int,struct TVector3<double> > > > ConvertCoordinateFromGlobalToLocal(int,int,class DCoordW)
```

## JPT.ConvertFromDocUnit

```text
JPT.ConvertFromDocUnit


ConvertFromDocUnit( (float)arg1, (UnitType)arg2) -> float :

    C++ signature :
        double ConvertFromDocUnit(double,enum UnitType)
```

## JPT.ConvertFromMacroUnit

```text
JPT.ConvertFromMacroUnit


ConvertFromMacroUnit( (float)arg1, (UnitType)arg2, (str)arg3) -> float :

    C++ signature :
        double ConvertFromMacroUnit(double,enum UnitType,char * __ptr64)
```

## JPT.ConvertJPTColorToRGB

```text
JPT.ConvertJPTColorToRGB


ConvertJPTColorToRGB( (int)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > ConvertJPTColorToRGB(int)
```

## JPT.ConvertRGBToJPTColor

```text
JPT.ConvertRGBToJPTColor


ConvertRGBToJPTColor( (int)arg1, (int)arg2, (int)arg3) -> int :

    C++ signature :
        int ConvertRGBToJPTColor(int,int,int)
```

## JPT.ConvertValueToDocUnit

```text
JPT.ConvertValueToDocUnit


ConvertValueToDocUnit( (float)arg1, (UnitType)arg2) -> float :

    C++ signature :
        double ConvertValueToDocUnit(double,enum UnitType)
```

## JPT.ConvertValueToMacroUnit

```text
JPT.ConvertValueToMacroUnit


ConvertValueToMacroUnit( (float)arg1, (UnitType)arg2, (str)arg3) -> float :

    C++ signature :
        double ConvertValueToMacroUnit(double,enum UnitType,char * __ptr64)
```

## JPT.CoordVector

```text
JPT.CoordVector


```

## JPT.CoordVector.addObj

```text
JPT.CoordVector.addObj


addObj( (CoordVector)arg1, (DCoord)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue},class DCoordW)
```

## JPT.CoordVector.append

```text
JPT.CoordVector.append


append( (CoordVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue},class boost::python::api::object)
```

## JPT.CoordVector.clearVec

```text
JPT.CoordVector.clearVec


clearVec( (CoordVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue})
```

## JPT.CoordVector.deleteObj

```text
JPT.CoordVector.deleteObj


deleteObj( (CoordVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue},int)
```

## JPT.CoordVector.extend

```text
JPT.CoordVector.extend


extend( (CoordVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue},class boost::python::api::object)
```

## JPT.CoordVector.extendVec

```text
JPT.CoordVector.extendVec


extendVec( (CoordVector)arg1, (CoordVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue},class std::vector<class DCoordW,class std::allocator<class DCoordW> >)
```

## JPT.CoordVector.isContainObj

```text
JPT.CoordVector.isContainObj


isContainObj( (CoordVector)arg1, (DCoord)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DCoordW,class std::allocator<class DCoordW> >,class DCoordW)
```

## JPT.CoordVector.sizeVec

```text
JPT.CoordVector.sizeVec


sizeVec( (CoordVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DCoordW,class std::allocator<class DCoordW> > {lvalue})
```

## JPT.CopyToClipBoard

```text
JPT.CopyToClipBoard


CopyToClipBoard( (str)arg1) -> None :

    C++ signature :
        void CopyToClipBoard(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## JPT.CreateNewDocument

```text
JPT.CreateNewDocument


CreateNewDocument([  (str)arg1]) -> Document :

    C++ signature :
        class DocumentW CreateNewDocument([ class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >])
```

## JPT.CreateSubAssembly

```text
JPT.CreateSubAssembly


CreateSubAssembly( (str)arg1, (DItem)arg2) -> DItem :

    C++ signature :
        class DItemW CreateSubAssembly(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class DItemW)
```

## JPT.CustomNoteCollectionVector

```text
JPT.CustomNoteCollectionVector


```

## JPT.CustomNoteCollectionVector.addObj

```text
JPT.CustomNoteCollectionVector.addObj


addObj( (CustomNoteCollectionVector)arg1, (DCustomNoteCollection)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue},class DCustomNoteCollectionW)
```

## JPT.CustomNoteCollectionVector.append

```text
JPT.CustomNoteCollectionVector.append


append( (CustomNoteCollectionVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue},class boost::python::api::object)
```

## JPT.CustomNoteCollectionVector.clearVec

```text
JPT.CustomNoteCollectionVector.clearVec


clearVec( (CustomNoteCollectionVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue})
```

## JPT.CustomNoteCollectionVector.deleteObj

```text
JPT.CustomNoteCollectionVector.deleteObj


deleteObj( (CustomNoteCollectionVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue},int)
```

## JPT.CustomNoteCollectionVector.extend

```text
JPT.CustomNoteCollectionVector.extend


extend( (CustomNoteCollectionVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue},class boost::python::api::object)
```

## JPT.CustomNoteCollectionVector.extendVec

```text
JPT.CustomNoteCollectionVector.extendVec


extendVec( (CustomNoteCollectionVector)arg1, (CustomNoteCollectionVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue},class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> >)
```

## JPT.CustomNoteCollectionVector.isContainObj

```text
JPT.CustomNoteCollectionVector.isContainObj


isContainObj( (CustomNoteCollectionVector)arg1, (DCustomNoteCollection)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> >,class DCustomNoteCollectionW)
```

## JPT.CustomNoteCollectionVector.sizeVec

```text
JPT.CustomNoteCollectionVector.sizeVec


sizeVec( (CustomNoteCollectionVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > {lvalue})
```

## JPT.CustomNoteVector

```text
JPT.CustomNoteVector


```

## JPT.CustomNoteVector.addObj

```text
JPT.CustomNoteVector.addObj


addObj( (CustomNoteVector)arg1, (DCustomNote)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue},class DCustomNoteW)
```

## JPT.CustomNoteVector.append

```text
JPT.CustomNoteVector.append


append( (CustomNoteVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue},class boost::python::api::object)
```

## JPT.CustomNoteVector.clearVec

```text
JPT.CustomNoteVector.clearVec


clearVec( (CustomNoteVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue})
```

## JPT.CustomNoteVector.deleteObj

```text
JPT.CustomNoteVector.deleteObj


deleteObj( (CustomNoteVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue},int)
```

## JPT.CustomNoteVector.extend

```text
JPT.CustomNoteVector.extend


extend( (CustomNoteVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue},class boost::python::api::object)
```

## JPT.CustomNoteVector.extendVec

```text
JPT.CustomNoteVector.extendVec


extendVec( (CustomNoteVector)arg1, (CustomNoteVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue},class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> >)
```

## JPT.CustomNoteVector.isContainObj

```text
JPT.CustomNoteVector.isContainObj


isContainObj( (CustomNoteVector)arg1, (DCustomNote)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> >,class DCustomNoteW)
```

## JPT.CustomNoteVector.sizeVec

```text
JPT.CustomNoteVector.sizeVec


sizeVec( (CustomNoteVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > {lvalue})
```

## JPT.DBody

```text
JPT.DBody


```

## JPT.DConnect

```text
JPT.DConnect


```

## JPT.DContact

```text
JPT.DContact


```

## JPT.DCoord

```text
JPT.DCoord


```

## JPT.DCustomNote

```text
JPT.DCustomNote


```

## JPT.DCustomNoteCollection

```text
JPT.DCustomNoteCollection


```

## JPT.DEdge

```text
JPT.DEdge


```

## JPT.DElem

```text
JPT.DElem


```

## JPT.DFace

```text
JPT.DFace


```

## JPT.DGroup

```text
JPT.DGroup


```

## JPT.DItem

```text
JPT.DItem


```

## JPT.DItemListToMacroListTCursor

```text
JPT.DItemListToMacroListTCursor


DItemListToMacroListTCursor( (DItemVector)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > DItemListToMacroListTCursor(class std::vector<class DItemW,class std::allocator<class DItemW> >)

DItemListToMacroListTCursor( (list)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > DItemListToMacroListTCursor(class boost::python::list)
```

## JPT.DItemPair

```text
JPT.DItemPair


```

## JPT.DItemPairVector

```text
JPT.DItemPairVector


```

## JPT.DItemPairVector.addObj

```text
JPT.DItemPairVector.addObj


addObj( (DItemPairVector)arg1, (DItemPair)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue},class DItemPairW)
```

## JPT.DItemPairVector.append

```text
JPT.DItemPairVector.append


append( (DItemPairVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue},class boost::python::api::object)
```

## JPT.DItemPairVector.clearVec

```text
JPT.DItemPairVector.clearVec


clearVec( (DItemPairVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue})
```

## JPT.DItemPairVector.deleteObj

```text
JPT.DItemPairVector.deleteObj


deleteObj( (DItemPairVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue},int)
```

## JPT.DItemPairVector.extend

```text
JPT.DItemPairVector.extend


extend( (DItemPairVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue},class boost::python::api::object)
```

## JPT.DItemPairVector.extendVec

```text
JPT.DItemPairVector.extendVec


extendVec( (DItemPairVector)arg1, (DItemPairVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue},class std::vector<class DItemPairW,class std::allocator<class DItemPairW> >)
```

## JPT.DItemPairVector.isContainObj

```text
JPT.DItemPairVector.isContainObj


isContainObj( (DItemPairVector)arg1, (DItemPair)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> >,class DItemPairW)
```

## JPT.DItemPairVector.sizeVec

```text
JPT.DItemPairVector.sizeVec


sizeVec( (DItemPairVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > {lvalue})
```

## JPT.DItemToMacroListTCursor

```text
JPT.DItemToMacroListTCursor


DItemToMacroListTCursor( (DItem)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > DItemToMacroListTCursor(class DItemW)
```

## JPT.DItemToMacroTCursor

```text
JPT.DItemToMacroTCursor


DItemToMacroTCursor( (DItem)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > DItemToMacroTCursor(class DItemW)
```

## JPT.DItemToMacroTCursorPair

```text
JPT.DItemToMacroTCursorPair


DItemToMacroTCursorPair( (DItem)arg1, (DItem)arg2) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > DItemToMacroTCursorPair(class DItemW,class DItemW)
```

## JPT.DItemType

```text
JPT.DItemType


```

## JPT.DItemType.from_bytes

```text
JPT.DItemType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.DItemVector

```text
JPT.DItemVector


```

## JPT.DItemVector.addObj

```text
JPT.DItemVector.addObj


addObj( (DItemVector)arg1, (DItem)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue},class DItemW)
```

## JPT.DItemVector.append

```text
JPT.DItemVector.append


append( (DItemVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue},class boost::python::api::object)
```

## JPT.DItemVector.clearVec

```text
JPT.DItemVector.clearVec


clearVec( (DItemVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.DItemVector.deleteObj

```text
JPT.DItemVector.deleteObj


deleteObj( (DItemVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue},int)
```

## JPT.DItemVector.extend

```text
JPT.DItemVector.extend


extend( (DItemVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue},class boost::python::api::object)
```

## JPT.DItemVector.extendVec

```text
JPT.DItemVector.extendVec


extendVec( (DItemVector)arg1, (DItemVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue},class std::vector<class DItemW,class std::allocator<class DItemW> >)
```

## JPT.DItemVector.isContainObj

```text
JPT.DItemVector.isContainObj


isContainObj( (DItemVector)arg1, (DItem)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DItemW,class std::allocator<class DItemW> >,class DItemW)
```

## JPT.DItemVector.sizeVec

```text
JPT.DItemVector.sizeVec


sizeVec( (DItemVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.DLoadBC

```text
JPT.DLoadBC


```

## JPT.DNode

```text
JPT.DNode


```

## JPT.DPostElem

```text
JPT.DPostElem


```

## JPT.DPostNode

```text
JPT.DPostNode


```

## JPT.DSolverJob

```text
JPT.DSolverJob


```

## JPT.DTVector3dToMacroVector

```text
JPT.DTVector3dToMacroVector


DTVector3dToMacroVector( (TVector3d)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > DTVector3dToMacroVector(struct TVector3<double>)
```

## JPT.DTableType

```text
JPT.DTableType


```

## JPT.DTableType.from_bytes

```text
JPT.DTableType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.DeSelectArrayCursor

```text
JPT.DeSelectArrayCursor


DeSelectArrayCursor( (str)arg1) -> bool :

    C++ signature :
        bool DeSelectArrayCursor(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.Debugger

```text
JPT.Debugger


object Debugger(tuple args, dict kwds) :

    C++ signature :
        object Debugger(tuple args, dict kwds)
```

## JPT.DeleteSubAssembly

```text
JPT.DeleteSubAssembly


DeleteSubAssembly( (DItem)arg1) -> None :

    C++ signature :
        void DeleteSubAssembly(class DItemW)
```

## JPT.DeleteSubAssemblyRecursively

```text
JPT.DeleteSubAssemblyRecursively


DeleteSubAssemblyRecursively( (DItem)arg1) -> None :

    C++ signature :
        void DeleteSubAssemblyRecursively(class DItemW)
```

## JPT.DisableMessageBox

```text
JPT.DisableMessageBox


DisableMessageBox( (int)arg1) -> None :

    C++ signature :
        void DisableMessageBox(int)
```

## JPT.DisableOutputMessage

```text
JPT.DisableOutputMessage


DisableOutputMessage() -> None :

    C++ signature :
        void DisableOutputMessage()
```

## JPT.DisableScreenAnimation

```text
JPT.DisableScreenAnimation


DisableScreenAnimation() -> None :

    C++ signature :
        void DisableScreenAnimation()
```

## JPT.Document

```text
JPT.Document


```

## JPT.DocumentType

```text
JPT.DocumentType


```

## JPT.DocumentType.from_bytes

```text
JPT.DocumentType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.DocumentVector

```text
JPT.DocumentVector


```

## JPT.DocumentVector.append

```text
JPT.DocumentVector.append


append( (DocumentVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DocumentW,class std::allocator<class DocumentW> > {lvalue},class boost::python::api::object)
```

## JPT.DocumentVector.extend

```text
JPT.DocumentVector.extend


extend( (DocumentVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DocumentW,class std::allocator<class DocumentW> > {lvalue},class boost::python::api::object)
```

## JPT.DoubleVector

```text
JPT.DoubleVector


```

## JPT.DoubleVector.append

```text
JPT.DoubleVector.append


append( (DoubleVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<double,class std::allocator<double> > {lvalue},class boost::python::api::object)
```

## JPT.DoubleVector.extend

```text
JPT.DoubleVector.extend


extend( (DoubleVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<double,class std::allocator<double> > {lvalue},class boost::python::api::object)
```

## JPT.DrawLine

```text
JPT.DrawLine


DrawLine( (TVector3d)arg1, (TVector3d)arg2, (float)arg3) -> None :

    C++ signature :
        void DrawLine(struct TVector3<double>,struct TVector3<double>,double)
```

## JPT.DrawPoint

```text
JPT.DrawPoint


DrawPoint( (TVector3dList)arg1, (float)arg2) -> None :

    C++ signature :
        void DrawPoint(class std::vector<struct TVector3<double>,class std::allocator<struct TVector3<double> > >,double)
```

## JPT.DrawRect

```text
JPT.DrawRect


DrawRect( (float)arg1, (float)arg2, (float)arg3, (float)arg4) -> None :

    C++ signature :
        void DrawRect(double,double,double,double)

DrawRect( (object)arg1) -> None :

    C++ signature :
        void DrawRect(class CRect)
```

## JPT.EdgeVector

```text
JPT.EdgeVector


```

## JPT.EdgeVector.addObj

```text
JPT.EdgeVector.addObj


addObj( (EdgeVector)arg1, (DEdge)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue},class DEdgeW)
```

## JPT.EdgeVector.append

```text
JPT.EdgeVector.append


append( (EdgeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue},class boost::python::api::object)
```

## JPT.EdgeVector.clearVec

```text
JPT.EdgeVector.clearVec


clearVec( (EdgeVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue})
```

## JPT.EdgeVector.deleteObj

```text
JPT.EdgeVector.deleteObj


deleteObj( (EdgeVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue},int)
```

## JPT.EdgeVector.extend

```text
JPT.EdgeVector.extend


extend( (EdgeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue},class boost::python::api::object)
```

## JPT.EdgeVector.extendVec

```text
JPT.EdgeVector.extendVec


extendVec( (EdgeVector)arg1, (EdgeVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue},class std::vector<class DEdgeW,class std::allocator<class DEdgeW> >)
```

## JPT.EdgeVector.isContainObj

```text
JPT.EdgeVector.isContainObj


isContainObj( (EdgeVector)arg1, (DEdge)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> >,class DEdgeW)
```

## JPT.EdgeVector.sizeVec

```text
JPT.EdgeVector.sizeVec


sizeVec( (EdgeVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > {lvalue})
```

## JPT.ElemKind

```text
JPT.ElemKind


```

## JPT.ElemKind.from_bytes

```text
JPT.ElemKind.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.ElemType

```text
JPT.ElemType


```

## JPT.ElemType.from_bytes

```text
JPT.ElemType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.ElemVector

```text
JPT.ElemVector


```

## JPT.ElemVector.addObj

```text
JPT.ElemVector.addObj


addObj( (ElemVector)arg1, (DElem)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue},class DElemW)
```

## JPT.ElemVector.append

```text
JPT.ElemVector.append


append( (ElemVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue},class boost::python::api::object)
```

## JPT.ElemVector.clearVec

```text
JPT.ElemVector.clearVec


clearVec( (ElemVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue})
```

## JPT.ElemVector.deleteObj

```text
JPT.ElemVector.deleteObj


deleteObj( (ElemVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue},int)
```

## JPT.ElemVector.extend

```text
JPT.ElemVector.extend


extend( (ElemVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue},class boost::python::api::object)
```

## JPT.ElemVector.extendVec

```text
JPT.ElemVector.extendVec


extendVec( (ElemVector)arg1, (ElemVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue},class std::vector<class DElemW,class std::allocator<class DElemW> >)
```

## JPT.ElemVector.isContainObj

```text
JPT.ElemVector.isContainObj


isContainObj( (ElemVector)arg1, (DElem)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DElemW,class std::allocator<class DElemW> >,class DElemW)
```

## JPT.ElemVector.sizeVec

```text
JPT.ElemVector.sizeVec


sizeVec( (ElemVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DElemW,class std::allocator<class DElemW> > {lvalue})
```

## JPT.EnableAllLicenses

```text
JPT.EnableAllLicenses


EnableAllLicenses( (bool)arg1) -> None :

    C++ signature :
        void EnableAllLicenses(bool)
```

## JPT.EnableLicenseFeature

```text
JPT.EnableLicenseFeature


EnableLicenseFeature( (str)arg1, (bool)arg2) -> None :

    C++ signature :
        void EnableLicenseFeature(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,bool)
```

## JPT.EnableMessageBox

```text
JPT.EnableMessageBox


EnableMessageBox() -> None :

    C++ signature :
        void EnableMessageBox()
```

## JPT.EnableOutputMessage

```text
JPT.EnableOutputMessage


EnableOutputMessage() -> None :

    C++ signature :
        void EnableOutputMessage()
```

## JPT.EnableScreenAnimation

```text
JPT.EnableScreenAnimation


EnableScreenAnimation() -> None :

    C++ signature :
        void EnableScreenAnimation()
```

## JPT.EndDatabaseTransaction

```text
JPT.EndDatabaseTransaction


EndDatabaseTransaction() -> None :

    C++ signature :
        void EndDatabaseTransaction()
```

## JPT.EntityType

```text
JPT.EntityType


```

## JPT.EntityType.from_bytes

```text
JPT.EntityType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.Exec

```text
JPT.Exec


Exec( (str)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > Exec(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.ExpandAssemblyTree

```text
JPT.ExpandAssemblyTree


ExpandAssemblyTree() -> None :

    C++ signature :
        void ExpandAssemblyTree()
```

## JPT.FaceVector

```text
JPT.FaceVector


```

## JPT.FaceVector.addObj

```text
JPT.FaceVector.addObj


addObj( (FaceVector)arg1, (DFace)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue},class DFaceW)
```

## JPT.FaceVector.append

```text
JPT.FaceVector.append


append( (FaceVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue},class boost::python::api::object)
```

## JPT.FaceVector.clearVec

```text
JPT.FaceVector.clearVec


clearVec( (FaceVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue})
```

## JPT.FaceVector.deleteObj

```text
JPT.FaceVector.deleteObj


deleteObj( (FaceVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue},int)
```

## JPT.FaceVector.extend

```text
JPT.FaceVector.extend


extend( (FaceVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue},class boost::python::api::object)
```

## JPT.FaceVector.extendVec

```text
JPT.FaceVector.extendVec


extendVec( (FaceVector)arg1, (FaceVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue},class std::vector<class DFaceW,class std::allocator<class DFaceW> >)
```

## JPT.FaceVector.isContainObj

```text
JPT.FaceVector.isContainObj


isContainObj( (FaceVector)arg1, (DFace)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DFaceW,class std::allocator<class DFaceW> >,class DFaceW)
```

## JPT.FaceVector.sizeVec

```text
JPT.FaceVector.sizeVec


sizeVec( (FaceVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DFaceW,class std::allocator<class DFaceW> > {lvalue})
```

## JPT.FindSubAssemblyByID

```text
JPT.FindSubAssemblyByID


FindSubAssemblyByID( (int)arg1) -> DItem :

    C++ signature :
        class DItemW FindSubAssemblyByID(int)
```

## JPT.FindSubAssemblyByName

```text
JPT.FindSubAssemblyByName


FindSubAssemblyByName( (str)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > FindSubAssemblyByName(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## JPT.GetActiveConvertedDataOption

```text
JPT.GetActiveConvertedDataOption


GetActiveConvertedDataOption() -> PostDataOp :

    C++ signature :
        struct PostDataOp GetActiveConvertedDataOption()
```

## JPT.GetActiveDataOption

```text
JPT.GetActiveDataOption


GetActiveDataOption() -> PostDataOp :

    C++ signature :
        struct PostDataOp GetActiveDataOption()
```

## JPT.GetActiveDocument

```text
JPT.GetActiveDocument


GetActiveDocument() -> Document :

    C++ signature :
        class DocumentW GetActiveDocument()
```

## JPT.GetActivePostJob

```text
JPT.GetActivePostJob


GetActivePostJob() -> DItem :

    C++ signature :
        class DItemW GetActivePostJob()
```

## JPT.GetAllAvailableResultOptions

```text
JPT.GetAllAvailableResultOptions


GetAllAvailableResultOptions( (int)arg1, (int)arg2, (int)arg3, (str)arg4, (str)arg5, (int)arg6) -> PostDataOpVector :

    C++ signature :
        class std::vector<struct PostDataOp,class std::allocator<struct PostDataOp> > GetAllAvailableResultOptions(int,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,int)
```

## JPT.GetAllByTableTypeID

```text
JPT.GetAllByTableTypeID


GetAllByTableTypeID( (int)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetAllByTableTypeID(int)
```

## JPT.GetAllByType

```text
JPT.GetAllByType


GetAllByType( (int)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetAllByType(int)
```

## JPT.GetAllByTypeID

```text
JPT.GetAllByTypeID


GetAllByTypeID( (int)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetAllByTypeID(int)
```

## JPT.GetAllConnections

```text
JPT.GetAllConnections


GetAllConnections() -> ConnectVector :

    C++ signature :
        class std::vector<class DConnectW,class std::allocator<class DConnectW> > GetAllConnections()
```

## JPT.GetAllContacts

```text
JPT.GetAllContacts


GetAllContacts() -> ContactVector :

    C++ signature :
        class std::vector<class DContactW,class std::allocator<class DContactW> > GetAllContacts()
```

## JPT.GetAllCoordinates

```text
JPT.GetAllCoordinates


GetAllCoordinates() -> CoordVector :

    C++ signature :
        class std::vector<class DCoordW,class std::allocator<class DCoordW> > GetAllCoordinates()
```

## JPT.GetAllCustomNoteCollections

```text
JPT.GetAllCustomNoteCollections


GetAllCustomNoteCollections() -> CustomNoteCollectionVector :

    C++ signature :
        class std::vector<class DCustomNoteCollectionW,class std::allocator<class DCustomNoteCollectionW> > GetAllCustomNoteCollections()
```

## JPT.GetAllCustomNotes

```text
JPT.GetAllCustomNotes


GetAllCustomNotes() -> CustomNoteVector :

    C++ signature :
        class std::vector<class DCustomNoteW,class std::allocator<class DCustomNoteW> > GetAllCustomNotes()
```

## JPT.GetAllEdges

```text
JPT.GetAllEdges


GetAllEdges() -> EdgeVector :

    C++ signature :
        class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > GetAllEdges()
```

## JPT.GetAllElems

```text
JPT.GetAllElems


GetAllElems() -> ElemVector :

    C++ signature :
        class std::vector<class DElemW,class std::allocator<class DElemW> > GetAllElems()
```

## JPT.GetAllFaces

```text
JPT.GetAllFaces


GetAllFaces() -> FaceVector :

    C++ signature :
        class std::vector<class DFaceW,class std::allocator<class DFaceW> > GetAllFaces()
```

## JPT.GetAllGroups

```text
JPT.GetAllGroups


GetAllGroups() -> GroupVector :

    C++ signature :
        class std::vector<class DGroupW,class std::allocator<class DGroupW> > GetAllGroups()
```

## JPT.GetAllLicensesStatus

```text
JPT.GetAllLicensesStatus


GetAllLicensesStatus() -> dict :

    C++ signature :
        class boost::python::dict GetAllLicensesStatus()
```

## JPT.GetAllLoadBoundaryConditions

```text
JPT.GetAllLoadBoundaryConditions


GetAllLoadBoundaryConditions() -> LoadBCVector :

    C++ signature :
        class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > GetAllLoadBoundaryConditions()
```

## JPT.GetAllLoadsBCs

```text
JPT.GetAllLoadsBCs


GetAllLoadsBCs() -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetAllLoadsBCs()
```

## JPT.GetAllNodes

```text
JPT.GetAllNodes


GetAllNodes() -> NodeVector :

    C++ signature :
        class std::vector<class DNodeW,class std::allocator<class DNodeW> > GetAllNodes()
```

## JPT.GetAllParts

```text
JPT.GetAllParts


GetAllParts() -> BodyVector :

    C++ signature :
        class std::vector<class DBodyW,class std::allocator<class DBodyW> > GetAllParts()
```

## JPT.GetAllPartsInSubAssembly

```text
JPT.GetAllPartsInSubAssembly


GetAllPartsInSubAssembly( (DItem)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetAllPartsInSubAssembly(class DItemW)
```

## JPT.GetAllPostElems

```text
JPT.GetAllPostElems


GetAllPostElems() -> PostElemVector :

    C++ signature :
        class std::vector<class DROElemW,class std::allocator<class DROElemW> > GetAllPostElems()
```

## JPT.GetAllPostNodes

```text
JPT.GetAllPostNodes


GetAllPostNodes() -> PostNodeVector :

    C++ signature :
        class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > GetAllPostNodes()
```

## JPT.GetAllResultsByElemId

```text
JPT.GetAllResultsByElemId


GetAllResultsByElemId( (int)arg1 [, (bool)arg2]) -> list :

    C++ signature :
        class boost::python::list GetAllResultsByElemId(long [,bool])
```

## JPT.GetAllResultsByNodeId

```text
JPT.GetAllResultsByNodeId


GetAllResultsByNodeId( (int)arg1 [, (bool)arg2]) -> list :

    C++ signature :
        class boost::python::list GetAllResultsByNodeId(long [,bool])
```

## JPT.GetAllSelected

```text
JPT.GetAllSelected


GetAllSelected() -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetAllSelected()
```

## JPT.GetAllSolverJobs

```text
JPT.GetAllSolverJobs


GetAllSolverJobs() -> SolverJobVector :

    C++ signature :
        class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > GetAllSolverJobs()
```

## JPT.GetAppPathInfo

```text
JPT.GetAppPathInfo


GetAppPathInfo( (int)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetAppPathInfo(int)
```

## JPT.GetAssemblyEntityData

```text
JPT.GetAssemblyEntityData


GetAssemblyEntityData( (int)arg1, (int)arg2) -> dict :

    C++ signature :
        class boost::python::dict GetAssemblyEntityData(int,int)
```

## JPT.GetAvailableResultOption

```text
JPT.GetAvailableResultOption


GetAvailableResultOption( (int)arg1, (int)arg2, (int)arg3, (str)arg4, (str)arg5, (int)arg6, (PostDataOp)arg7) -> PostDataOp :

    C++ signature :
        struct PostDataOp GetAvailableResultOption(int,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,int,struct PostDataOp)
```

## JPT.GetCenterOfEntities

```text
JPT.GetCenterOfEntities


GetCenterOfEntities( (DItemVector)arg1) -> DoubleVector :

    C++ signature :
        class std::vector<double,class std::allocator<double> > GetCenterOfEntities(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.GetContactType

```text
JPT.GetContactType


GetContactType( (int)arg1) -> int :

    C++ signature :
        int GetContactType(long)
```

## JPT.GetContourTemplateNames

```text
JPT.GetContourTemplateNames


GetContourTemplateNames() -> WStringVector :

    C++ signature :
        class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > GetContourTemplateNames()
```

## JPT.GetCountByType

```text
JPT.GetCountByType


GetCountByType( (int)arg1) -> int :

    C++ signature :
        int GetCountByType(int)
```

## JPT.GetCurrentAnimation

```text
JPT.GetCurrentAnimation


GetCurrentAnimation() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentAnimation()
```

## JPT.GetCurrentCircle

```text
JPT.GetCurrentCircle


GetCurrentCircle() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentCircle()
```

## JPT.GetCurrentContour

```text
JPT.GetCurrentContour


GetCurrentContour() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentContour()
```

## JPT.GetCurrentCrossSection

```text
JPT.GetCurrentCrossSection


GetCurrentCrossSection() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentCrossSection()
```

## JPT.GetCurrentDeformation

```text
JPT.GetCurrentDeformation


GetCurrentDeformation() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentDeformation()
```

## JPT.GetCurrentDiagram

```text
JPT.GetCurrentDiagram


GetCurrentDiagram() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentDiagram()
```

## JPT.GetCurrentDocumentPath

```text
JPT.GetCurrentDocumentPath


GetCurrentDocumentPath() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetCurrentDocumentPath()
```

## JPT.GetCurrentVector

```text
JPT.GetCurrentVector


GetCurrentVector() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentVector()
```

## JPT.GetCurrentViewPoint

```text
JPT.GetCurrentViewPoint


GetCurrentViewPoint() -> dict :

    C++ signature :
        class boost::python::dict GetCurrentViewPoint()
```

## JPT.GetDefaultResultOption

```text
JPT.GetDefaultResultOption


GetDefaultResultOption( (int)arg1, (int)arg2, (int)arg3, (str)arg4, (str)arg5, (int)arg6) -> PostDataOp :

    C++ signature :
        struct PostDataOp GetDefaultResultOption(int,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,int)
```

## JPT.GetDocumentByID

```text
JPT.GetDocumentByID


GetDocumentByID( (str)arg1) -> Document :

    C++ signature :
        class DocumentW GetDocumentByID(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.GetDocumentByName

```text
JPT.GetDocumentByName


GetDocumentByName( (str)arg1) -> Document :

    C++ signature :
        class DocumentW GetDocumentByName(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.GetDocumentList

```text
JPT.GetDocumentList


GetDocumentList() -> DocumentVector :

    C++ signature :
        class std::vector<class DocumentW,class std::allocator<class DocumentW> > GetDocumentList()
```

## JPT.GetElementResult

```text
JPT.GetElementResult


GetElementResult( (PostDataRangeType)arg1, (float)arg2 [, (float)arg3]) -> PostElemVector :

    C++ signature :
        class std::vector<class DROElemW,class std::allocator<class DROElemW> > GetElementResult(enum PostDataRangeType,double [,double])
```

## JPT.GetElemsByKind

```text
JPT.GetElemsByKind


GetElemsByKind( (int)arg1) -> ElemVector :

    C++ signature :
        class std::vector<class DElemW,class std::allocator<class DElemW> > GetElemsByKind(int)
```

## JPT.GetElemsByType

```text
JPT.GetElemsByType


GetElemsByType( (int)arg1) -> ElemVector :

    C++ signature :
        class std::vector<class DElemW,class std::allocator<class DElemW> > GetElemsByType(int)
```

## JPT.GetEntitiesByAdjacent

```text
JPT.GetEntitiesByAdjacent


GetEntitiesByAdjacent( (int)arg1, (int)arg2, (int)arg3) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetEntitiesByAdjacent(int,int,int)
```

## JPT.GetEntitiesByAssociation

```text
JPT.GetEntitiesByAssociation


GetEntitiesByAssociation( (int)arg1, (int)arg2, (int)arg3) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetEntitiesByAssociation(int,int,int)
```

## JPT.GetEntitiesByID

```text
JPT.GetEntitiesByID


GetEntitiesByID( (int)arg1, (int)arg2) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetEntitiesByID(int,int)
```

## JPT.GetEntitiesByName

```text
JPT.GetEntitiesByName


GetEntitiesByName( (int)arg1, (str)arg2, (bool)arg3) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetEntitiesByName(int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,bool)
```

## JPT.GetEntitiesByPosition

```text
JPT.GetEntitiesByPosition


GetEntitiesByPosition( (int)arg1, (float)arg2, (float)arg3, (float)arg4) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetEntitiesByPosition(int,double,double,double)
```

## JPT.GetGroupFromSubGroup

```text
JPT.GetGroupFromSubGroup


GetGroupFromSubGroup( (str)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetGroupFromSubGroup(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.GetInternalIDRefItem

```text
JPT.GetInternalIDRefItem


GetInternalIDRefItem( (int)arg1, (int)arg2 [, (bool)arg3]) -> int :

    C++ signature :
        int GetInternalIDRefItem(int,int [,bool])
```

## JPT.GetJPTTempPath

```text
JPT.GetJPTTempPath


GetJPTTempPath() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetJPTTempPath()
```

## JPT.GetJTDBVersion

```text
JPT.GetJTDBVersion


GetJTDBVersion() -> VersionInfo :

    C++ signature :
        struct CVersionInfo GetJTDBVersion()
```

## JPT.GetLastCreatedCursor

```text
JPT.GetLastCreatedCursor


GetLastCreatedCursor() -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetLastCreatedCursor()
```

## JPT.GetMacroLog

```text
JPT.GetMacroLog


GetMacroLog() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetMacroLog()
```

## JPT.GetMaterialDBById

```text
JPT.GetMaterialDBById


GetMaterialDBById( (int)arg1) -> int :

    C++ signature :
        int GetMaterialDBById(int)
```

## JPT.GetMaterialFromProperty

```text
JPT.GetMaterialFromProperty


GetMaterialFromProperty( (int)arg1) -> DItem :

    C++ signature :
        class DItemW GetMaterialFromProperty(int)
```

## JPT.GetMaterialOriginalXML

```text
JPT.GetMaterialOriginalXML


GetMaterialOriginalXML() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetMaterialOriginalXML()
```

## JPT.GetMaterialXML

```text
JPT.GetMaterialXML


GetMaterialXML() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetMaterialXML()
```

## JPT.GetMaxIDEntity

```text
JPT.GetMaxIDEntity


GetMaxIDEntity( (int)arg1) -> int :

    C++ signature :
        int GetMaxIDEntity(int)
```

## JPT.GetMaxMaterialID

```text
JPT.GetMaxMaterialID


GetMaxMaterialID() -> int :

    C++ signature :
        int GetMaxMaterialID()
```

## JPT.GetMaxResultCoord

```text
JPT.GetMaxResultCoord


GetMaxResultCoord([  (bool)arg1]) -> DoubleVector :

    C++ signature :
        class std::vector<double,class std::allocator<double> > GetMaxResultCoord([ bool])
```

## JPT.GetMaxResultId

```text
JPT.GetMaxResultId


GetMaxResultId([  (bool)arg1]) -> int :

    C++ signature :
        long GetMaxResultId([ bool])
```

## JPT.GetMaxResultValue

```text
JPT.GetMaxResultValue


GetMaxResultValue([  (bool)arg1]) -> float :

    C++ signature :
        double GetMaxResultValue([ bool])
```

## JPT.GetMinIDEntity

```text
JPT.GetMinIDEntity


GetMinIDEntity( (int)arg1) -> int :

    C++ signature :
        int GetMinIDEntity(int)
```

## JPT.GetMinResultCoord

```text
JPT.GetMinResultCoord


GetMinResultCoord([  (bool)arg1]) -> DoubleVector :

    C++ signature :
        class std::vector<double,class std::allocator<double> > GetMinResultCoord([ bool])
```

## JPT.GetMinResultId

```text
JPT.GetMinResultId


GetMinResultId([  (bool)arg1]) -> int :

    C++ signature :
        long GetMinResultId([ bool])
```

## JPT.GetMinResultValue

```text
JPT.GetMinResultValue


GetMinResultValue([  (bool)arg1]) -> float :

    C++ signature :
        double GetMinResultValue([ bool])
```

## JPT.GetNodeResult

```text
JPT.GetNodeResult


GetNodeResult( (PostDataRangeType)arg1, (float)arg2 [, (float)arg3]) -> PostNodeVector :

    C++ signature :
        class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > GetNodeResult(enum PostDataRangeType,double [,double])
```

## JPT.GetOpnList

```text
JPT.GetOpnList


GetOpnList() -> WStringVector :

    C++ signature :
        class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > GetOpnList()
```

## JPT.GetOutputLog

```text
JPT.GetOutputLog


GetOutputLog() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetOutputLog()
```

## JPT.GetPostElemFromPosition

```text
JPT.GetPostElemFromPosition


GetPostElemFromPosition( (float)arg1, (float)arg2, (float)arg3, (float)arg4, (bool)arg5) -> DPostElem :

    C++ signature :
        class DROElemW GetPostElemFromPosition(double,double,double,double,bool)
```

## JPT.GetPostResultAmt

```text
JPT.GetPostResultAmt


GetPostResultAmt( (int)arg1, (int)arg2, (int)arg3, (str)arg4, (str)arg5, (int)arg6) -> int :

    C++ signature :
        int GetPostResultAmt(int,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,int)
```

## JPT.GetPostSolverType

```text
JPT.GetPostSolverType


GetPostSolverType() -> PostJobType :

    C++ signature :
        enum POSTJOB_TYPE GetPostSolverType()
```

## JPT.GetPostSolverTypeString

```text
JPT.GetPostSolverTypeString


GetPostSolverTypeString() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetPostSolverTypeString()
```

## JPT.GetProgramPath

```text
JPT.GetProgramPath


GetProgramPath() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetProgramPath()
```

## JPT.GetProgramVersion

```text
JPT.GetProgramVersion


GetProgramVersion() -> VersionInfo :

    C++ signature :
        struct CVersionInfo GetProgramVersion()
```

## JPT.GetPythonAPILog

```text
JPT.GetPythonAPILog


GetPythonAPILog() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetPythonAPILog()
```

## JPT.GetRandomJPTColor

```text
JPT.GetRandomJPTColor


GetRandomJPTColor() -> int :

    C++ signature :
        int GetRandomJPTColor()
```

## JPT.GetRedoCount

```text
JPT.GetRedoCount


GetRedoCount() -> int :

    C++ signature :
        long GetRedoCount()
```

## JPT.GetResultByElemId

```text
JPT.GetResultByElemId


GetResultByElemId( (int)arg1) -> float :

    C++ signature :
        double GetResultByElemId(long)
```

## JPT.GetResultByNodeId

```text
JPT.GetResultByNodeId


GetResultByNodeId( (int)arg1) -> float :

    C++ signature :
        double GetResultByNodeId(long)
```

## JPT.GetResultComponentNames

```text
JPT.GetResultComponentNames


GetResultComponentNames( (int)arg1, (int)arg2, (int)arg3, (str)arg4, (bool)arg5) -> WStringVector :

    C++ signature :
        class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > GetResultComponentNames(int,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,bool)
```

## JPT.GetResultIncrements

```text
JPT.GetResultIncrements


GetResultIncrements( (int)arg1, (int)arg2) -> IntVector :

    C++ signature :
        class std::vector<int,class std::allocator<int> > GetResultIncrements(int,int)
```

## JPT.GetResultLocations

```text
JPT.GetResultLocations


GetResultLocations( (int)arg1, (int)arg2, (int)arg3, (str)arg4, (str)arg5) -> IntVector :

    C++ signature :
        class std::vector<int,class std::allocator<int> > GetResultLocations(int,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.GetResultNames

```text
JPT.GetResultNames


GetResultNames( (int)arg1, (int)arg2, (int)arg3, (bool)arg4) -> WStringVector :

    C++ signature :
        class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > GetResultNames(int,int,int,bool)
```

## JPT.GetResultSetName

```text
JPT.GetResultSetName


GetResultSetName( (int)arg1, (int)arg2) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetResultSetName(int,int)
```

## JPT.GetResultSetNameWithAnalysisID

```text
JPT.GetResultSetNameWithAnalysisID


GetResultSetNameWithAnalysisID( (int)arg1, (int)arg2, (int)arg3) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetResultSetNameWithAnalysisID(int,int,int)
```

## JPT.GetResultSteps

```text
JPT.GetResultSteps


GetResultSteps() -> IntTripleVector :

    C++ signature :
        class std::vector<class IntTriple,class std::allocator<class IntTriple> > GetResultSteps()
```

## JPT.GetResultTimeStepInfo

```text
JPT.GetResultTimeStepInfo


GetResultTimeStepInfo( (int)arg1, (int)arg2, (int)arg3) -> PostTimeStepInfo :

    C++ signature :
        struct PostTimeStepInfo GetResultTimeStepInfo(int,int,int)
```

## JPT.GetResultTitle

```text
JPT.GetResultTitle


GetResultTitle() -> dict :

    C++ signature :
        class boost::python::dict GetResultTitle()
```

## JPT.GetResultUseIncrement

```text
JPT.GetResultUseIncrement


GetResultUseIncrement( (int)arg1, (int)arg2) -> bool :

    C++ signature :
        bool GetResultUseIncrement(int,int)
```

## JPT.GetScreenHeight

```text
JPT.GetScreenHeight


GetScreenHeight() -> int :

    C++ signature :
        int GetScreenHeight()
```

## JPT.GetScreenPositionOfEntities

```text
JPT.GetScreenPositionOfEntities


GetScreenPositionOfEntities( (DItemVector)arg1) -> list :

    C++ signature :
        class boost::python::list GetScreenPositionOfEntities(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.GetScreenWidth

```text
JPT.GetScreenWidth


GetScreenWidth([  (bool)arg1]) -> int :

    C++ signature :
        int GetScreenWidth([ bool])
```

## JPT.GetSelectedEdges

```text
JPT.GetSelectedEdges


GetSelectedEdges() -> EdgeVector :

    C++ signature :
        class std::vector<class DEdgeW,class std::allocator<class DEdgeW> > GetSelectedEdges()
```

## JPT.GetSelectedEdgesCr

```text
JPT.GetSelectedEdgesCr


GetSelectedEdgesCr() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetSelectedEdgesCr()
```

## JPT.GetSelectedElemEdges

```text
JPT.GetSelectedElemEdges


GetSelectedElemEdges() -> DItemPairVector :

    C++ signature :
        class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > GetSelectedElemEdges()
```

## JPT.GetSelectedElems

```text
JPT.GetSelectedElems


GetSelectedElems() -> ElemVector :

    C++ signature :
        class std::vector<class DElemW,class std::allocator<class DElemW> > GetSelectedElems()
```

## JPT.GetSelectedElemsCr

```text
JPT.GetSelectedElemsCr


GetSelectedElemsCr() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetSelectedElemsCr()
```

## JPT.GetSelectedFaces

```text
JPT.GetSelectedFaces


GetSelectedFaces() -> FaceVector :

    C++ signature :
        class std::vector<class DFaceW,class std::allocator<class DFaceW> > GetSelectedFaces()
```

## JPT.GetSelectedFacesCr

```text
JPT.GetSelectedFacesCr


GetSelectedFacesCr() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetSelectedFacesCr()
```

## JPT.GetSelectedGroups

```text
JPT.GetSelectedGroups


GetSelectedGroups() -> GroupVector :

    C++ signature :
        class std::vector<class DGroupW,class std::allocator<class DGroupW> > GetSelectedGroups()
```

## JPT.GetSelectedGroupsCr

```text
JPT.GetSelectedGroupsCr


GetSelectedGroupsCr() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetSelectedGroupsCr()
```

## JPT.GetSelectedNodes

```text
JPT.GetSelectedNodes


GetSelectedNodes() -> NodeVector :

    C++ signature :
        class std::vector<class DNodeW,class std::allocator<class DNodeW> > GetSelectedNodes()
```

## JPT.GetSelectedNodesCr

```text
JPT.GetSelectedNodesCr


GetSelectedNodesCr() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetSelectedNodesCr()
```

## JPT.GetSelectedParts

```text
JPT.GetSelectedParts


GetSelectedParts() -> BodyVector :

    C++ signature :
        class std::vector<class DBodyW,class std::allocator<class DBodyW> > GetSelectedParts()
```

## JPT.GetSelectedPartsCr

```text
JPT.GetSelectedPartsCr


GetSelectedPartsCr() -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetSelectedPartsCr()
```

## JPT.GetSelectedROElems

```text
JPT.GetSelectedROElems


GetSelectedROElems() -> PostElemVector :

    C++ signature :
        class std::vector<class DROElemW,class std::allocator<class DROElemW> > GetSelectedROElems()
```

## JPT.GetSelectedRONodes

```text
JPT.GetSelectedRONodes


GetSelectedRONodes() -> PostNodeVector :

    C++ signature :
        class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > GetSelectedRONodes()
```

## JPT.GetSharedElements

```text
JPT.GetSharedElements


GetSharedElements( (DItemVector)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetSharedElements(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.GetSharedFaces

```text
JPT.GetSharedFaces


GetSharedFaces( (DItemVector)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetSharedFaces(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.GetSharedNodes

```text
JPT.GetSharedNodes


GetSharedNodes( (DItemVector)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > GetSharedNodes(class std::vector<class DItemW,class std::allocator<class DItemW> > {lvalue})
```

## JPT.GetSuppressedParts

```text
JPT.GetSuppressedParts


GetSuppressedParts() -> BodyVector :

    C++ signature :
        class std::vector<class DBodyW,class std::allocator<class DBodyW> > GetSuppressedParts()
```

## JPT.GetThicknessOfEntity

```text
JPT.GetThicknessOfEntity


GetThicknessOfEntity( (int)arg1, (int)arg2) -> float :

    C++ signature :
        double GetThicknessOfEntity(int,int)
```

## JPT.GetTimeStepInfoName

```text
JPT.GetTimeStepInfoName


GetTimeStepInfoName( (int)arg1, (int)arg2, (int)arg3) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > GetTimeStepInfoName(int,int,int)
```

## JPT.GetUndoCount

```text
JPT.GetUndoCount


GetUndoCount() -> int :

    C++ signature :
        long GetUndoCount()
```

## JPT.GetViewpointTemplateNames

```text
JPT.GetViewpointTemplateNames


GetViewpointTemplateNames() -> WStringVector :

    C++ signature :
        class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > GetViewpointTemplateNames()
```

## JPT.GroupVector

```text
JPT.GroupVector


```

## JPT.GroupVector.addObj

```text
JPT.GroupVector.addObj


addObj( (GroupVector)arg1, (DGroup)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue},class DGroupW)
```

## JPT.GroupVector.append

```text
JPT.GroupVector.append


append( (GroupVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue},class boost::python::api::object)
```

## JPT.GroupVector.clearVec

```text
JPT.GroupVector.clearVec


clearVec( (GroupVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue})
```

## JPT.GroupVector.deleteObj

```text
JPT.GroupVector.deleteObj


deleteObj( (GroupVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue},int)
```

## JPT.GroupVector.extend

```text
JPT.GroupVector.extend


extend( (GroupVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue},class boost::python::api::object)
```

## JPT.GroupVector.extendVec

```text
JPT.GroupVector.extendVec


extendVec( (GroupVector)arg1, (GroupVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue},class std::vector<class DGroupW,class std::allocator<class DGroupW> >)
```

## JPT.GroupVector.isContainObj

```text
JPT.GroupVector.isContainObj


isContainObj( (GroupVector)arg1, (DGroup)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DGroupW,class std::allocator<class DGroupW> >,class DGroupW)
```

## JPT.GroupVector.sizeVec

```text
JPT.GroupVector.sizeVec


sizeVec( (GroupVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DGroupW,class std::allocator<class DGroupW> > {lvalue})
```

## JPT.HidePreview

```text
JPT.HidePreview


HidePreview() -> None :

    C++ signature :
        void HidePreview()
```

## JPT.HighlightByID

```text
JPT.HighlightByID


HighlightByID( (int)arg1, (int)arg2, (bool)arg3) -> None :

    C++ signature :
        void HighlightByID(int,int,bool)
```

## JPT.IntPair

```text
JPT.IntPair


```

## JPT.IntPairVector

```text
JPT.IntPairVector


```

## JPT.IntPairVector.append

```text
JPT.IntPairVector.append


append( (IntPairVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<struct std::pair<int,int>,class std::allocator<struct std::pair<int,int> > > {lvalue},class boost::python::api::object)
```

## JPT.IntPairVector.extend

```text
JPT.IntPairVector.extend


extend( (IntPairVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<struct std::pair<int,int>,class std::allocator<struct std::pair<int,int> > > {lvalue},class boost::python::api::object)
```

## JPT.IntTriple

```text
JPT.IntTriple


```

## JPT.IntTripleVector

```text
JPT.IntTripleVector


```

## JPT.IntTripleVector.append

```text
JPT.IntTripleVector.append


append( (IntTripleVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class IntTriple,class std::allocator<class IntTriple> > {lvalue},class boost::python::api::object)
```

## JPT.IntTripleVector.extend

```text
JPT.IntTripleVector.extend


extend( (IntTripleVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class IntTriple,class std::allocator<class IntTriple> > {lvalue},class boost::python::api::object)
```

## JPT.IntVector

```text
JPT.IntVector


```

## JPT.IntVector.append

```text
JPT.IntVector.append


append( (IntVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<int,class std::allocator<int> > {lvalue},class boost::python::api::object)
```

## JPT.IntVector.extend

```text
JPT.IntVector.extend


extend( (IntVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<int,class std::allocator<int> > {lvalue},class boost::python::api::object)
```

## JPT.InverseHideBodies

```text
JPT.InverseHideBodies


InverseHideBodies( (int)arg1) -> None :

    C++ signature :
        void InverseHideBodies(int)
```

## JPT.IsDefaultDouble

```text
JPT.IsDefaultDouble


IsDefaultDouble( (float)arg1) -> bool :

    C++ signature :
        bool IsDefaultDouble(double)
```

## JPT.IsDefaultInt

```text
JPT.IsDefaultInt


IsDefaultInt( (int)arg1) -> bool :

    C++ signature :
        bool IsDefaultInt(int)
```

## JPT.IsSpatialPointRendered

```text
JPT.IsSpatialPointRendered


IsSpatialPointRendered( (float)arg1, (float)arg2, (float)arg3) -> int :

    C++ signature :
        int IsSpatialPointRendered(double,double,double)
```

## JPT.ListDoubleToMacroVector

```text
JPT.ListDoubleToMacroVector


ListDoubleToMacroVector( (float)arg1, (float)arg2, (float)arg3) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > ListDoubleToMacroVector(double,double,double)
```

## JPT.LoadBCVector

```text
JPT.LoadBCVector


```

## JPT.LoadBCVector.addObj

```text
JPT.LoadBCVector.addObj


addObj( (LoadBCVector)arg1, (DLoadBC)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue},class DLoadBCW)
```

## JPT.LoadBCVector.append

```text
JPT.LoadBCVector.append


append( (LoadBCVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue},class boost::python::api::object)
```

## JPT.LoadBCVector.clearVec

```text
JPT.LoadBCVector.clearVec


clearVec( (LoadBCVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue})
```

## JPT.LoadBCVector.deleteObj

```text
JPT.LoadBCVector.deleteObj


deleteObj( (LoadBCVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue},int)
```

## JPT.LoadBCVector.extend

```text
JPT.LoadBCVector.extend


extend( (LoadBCVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue},class boost::python::api::object)
```

## JPT.LoadBCVector.extendVec

```text
JPT.LoadBCVector.extendVec


extendVec( (LoadBCVector)arg1, (LoadBCVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue},class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> >)
```

## JPT.LoadBCVector.isContainObj

```text
JPT.LoadBCVector.isContainObj


isContainObj( (LoadBCVector)arg1, (DLoadBC)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> >,class DLoadBCW)
```

## JPT.LoadBCVector.sizeVec

```text
JPT.LoadBCVector.sizeVec


sizeVec( (LoadBCVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DLoadBCW,class std::allocator<class DLoadBCW> > {lvalue})
```

## JPT.MacroListTCursorPairToListDItemPair

```text
JPT.MacroListTCursorPairToListDItemPair


MacroListTCursorPairToListDItemPair( (str)arg1) -> DItemPairVector :

    C++ signature :
        class std::vector<class DItemPairW,class std::allocator<class DItemPairW> > MacroListTCursorPairToListDItemPair(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.MacroListTCursorToListDItem

```text
JPT.MacroListTCursorToListDItem


MacroListTCursorToListDItem( (str)arg1) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > MacroListTCursorToListDItem(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.MacroResultParser

```text
JPT.MacroResultParser


MacroResultParser( (str)arg1, (list)arg2) -> list :

    C++ signature :
        class boost::python::list MacroResultParser(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class boost::python::list)

MacroResultParser( (str)arg1, (StringVector)arg2) -> StringVector :

    C++ signature :
        class std::vector<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::allocator<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > > > MacroResultParser(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::vector<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::allocator<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > > >)
```

## JPT.MacroTCursorPairToDItemPair

```text
JPT.MacroTCursorPairToDItemPair


MacroTCursorPairToDItemPair( (str)arg1) -> DItemPair :

    C++ signature :
        class DItemPairW MacroTCursorPairToDItemPair(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.MacroTCursorToDItem

```text
JPT.MacroTCursorToDItem


MacroTCursorToDItem( (str)arg1) -> DItem :

    C++ signature :
        class DItemW MacroTCursorToDItem(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.MessageBoxPSJ

```text
JPT.MessageBoxPSJ


MessageBoxPSJ( (str)arg1, (int)arg2) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > MessageBoxPSJ(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,int)
```

## JPT.MsgBoxOptionType

```text
JPT.MsgBoxOptionType


```

## JPT.MsgBoxOptionType.from_bytes

```text
JPT.MsgBoxOptionType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.MsgBoxType

```text
JPT.MsgBoxType


```

## JPT.MsgBoxType.from_bytes

```text
JPT.MsgBoxType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.MsgOut

```text
JPT.MsgOut


object MsgOut(tuple args, dict kwds) :

    C++ signature :
        object MsgOut(tuple args, dict kwds)
```

## JPT.NodeVector

```text
JPT.NodeVector


```

## JPT.NodeVector.addObj

```text
JPT.NodeVector.addObj


addObj( (NodeVector)arg1, (DNode)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue},class DNodeW)
```

## JPT.NodeVector.append

```text
JPT.NodeVector.append


append( (NodeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue},class boost::python::api::object)
```

## JPT.NodeVector.clearVec

```text
JPT.NodeVector.clearVec


clearVec( (NodeVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue})
```

## JPT.NodeVector.deleteObj

```text
JPT.NodeVector.deleteObj


deleteObj( (NodeVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue},int)
```

## JPT.NodeVector.extend

```text
JPT.NodeVector.extend


extend( (NodeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue},class boost::python::api::object)
```

## JPT.NodeVector.extendVec

```text
JPT.NodeVector.extendVec


extendVec( (NodeVector)arg1, (NodeVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue},class std::vector<class DNodeW,class std::allocator<class DNodeW> >)
```

## JPT.NodeVector.isContainObj

```text
JPT.NodeVector.isContainObj


isContainObj( (NodeVector)arg1, (DNode)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DNodeW,class std::allocator<class DNodeW> >,class DNodeW)
```

## JPT.NodeVector.sizeVec

```text
JPT.NodeVector.sizeVec


sizeVec( (NodeVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DNodeW,class std::allocator<class DNodeW> > {lvalue})
```

## JPT.Notify

```text
JPT.Notify


Notify( (PyNotificationType)arg1, (str)arg2) -> None :

    C++ signature :
        void Notify(enum PyNotificationType,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.PathType

```text
JPT.PathType


```

## JPT.PathType.from_bytes

```text
JPT.PathType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PositionPair

```text
JPT.PositionPair


```

## JPT.PositionPairVector

```text
JPT.PositionPairVector


```

## JPT.PositionPairVector.append

```text
JPT.PositionPairVector.append


append( (PositionPairVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<struct std::pair<int,struct TVector3<double> >,class std::allocator<struct std::pair<int,struct TVector3<double> > > > {lvalue},class boost::python::api::object)
```

## JPT.PositionPairVector.extend

```text
JPT.PositionPairVector.extend


extend( (PositionPairVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<struct std::pair<int,struct TVector3<double> >,class std::allocator<struct std::pair<int,struct TVector3<double> > > > {lvalue},class boost::python::api::object)
```

## JPT.PostAnalysisType

```text
JPT.PostAnalysisType


```

## JPT.PostAnalysisType.from_bytes

```text
JPT.PostAnalysisType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostDataOp

```text
JPT.PostDataOp


```

## JPT.PostDataOpVector

```text
JPT.PostDataOpVector


```

## JPT.PostDataOpVector.append

```text
JPT.PostDataOpVector.append


append( (PostDataOpVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<struct PostDataOp,class std::allocator<struct PostDataOp> > {lvalue},class boost::python::api::object)
```

## JPT.PostDataOpVector.extend

```text
JPT.PostDataOpVector.extend


extend( (PostDataOpVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<struct PostDataOp,class std::allocator<struct PostDataOp> > {lvalue},class boost::python::api::object)
```

## JPT.PostDataRangeType

```text
JPT.PostDataRangeType


```

## JPT.PostDataRangeType.from_bytes

```text
JPT.PostDataRangeType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostElemVector

```text
JPT.PostElemVector


```

## JPT.PostElemVector.addObj

```text
JPT.PostElemVector.addObj


addObj( (PostElemVector)arg1, (DPostElem)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue},class DROElemW)
```

## JPT.PostElemVector.append

```text
JPT.PostElemVector.append


append( (PostElemVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue},class boost::python::api::object)
```

## JPT.PostElemVector.clearVec

```text
JPT.PostElemVector.clearVec


clearVec( (PostElemVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue})
```

## JPT.PostElemVector.deleteObj

```text
JPT.PostElemVector.deleteObj


deleteObj( (PostElemVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue},int)
```

## JPT.PostElemVector.extend

```text
JPT.PostElemVector.extend


extend( (PostElemVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue},class boost::python::api::object)
```

## JPT.PostElemVector.extendVec

```text
JPT.PostElemVector.extendVec


extendVec( (PostElemVector)arg1, (PostElemVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue},class std::vector<class DROElemW,class std::allocator<class DROElemW> >)
```

## JPT.PostElemVector.isContainObj

```text
JPT.PostElemVector.isContainObj


isContainObj( (PostElemVector)arg1, (DPostElem)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DROElemW,class std::allocator<class DROElemW> >,class DROElemW)
```

## JPT.PostElemVector.sizeVec

```text
JPT.PostElemVector.sizeVec


sizeVec( (PostElemVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DROElemW,class std::allocator<class DROElemW> > {lvalue})
```

## JPT.PostHasDeform

```text
JPT.PostHasDeform


PostHasDeform( (int)arg1, (int)arg2, (int)arg3) -> bool :

    C++ signature :
        bool PostHasDeform(int,int,int)
```

## JPT.PostJobType

```text
JPT.PostJobType


```

## JPT.PostJobType.from_bytes

```text
JPT.PostJobType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostNodeVector

```text
JPT.PostNodeVector


```

## JPT.PostNodeVector.addObj

```text
JPT.PostNodeVector.addObj


addObj( (PostNodeVector)arg1, (DPostNode)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue},class DRONodeW)
```

## JPT.PostNodeVector.append

```text
JPT.PostNodeVector.append


append( (PostNodeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue},class boost::python::api::object)
```

## JPT.PostNodeVector.clearVec

```text
JPT.PostNodeVector.clearVec


clearVec( (PostNodeVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue})
```

## JPT.PostNodeVector.deleteObj

```text
JPT.PostNodeVector.deleteObj


deleteObj( (PostNodeVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue},int)
```

## JPT.PostNodeVector.extend

```text
JPT.PostNodeVector.extend


extend( (PostNodeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue},class boost::python::api::object)
```

## JPT.PostNodeVector.extendVec

```text
JPT.PostNodeVector.extendVec


extendVec( (PostNodeVector)arg1, (PostNodeVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue},class std::vector<class DRONodeW,class std::allocator<class DRONodeW> >)
```

## JPT.PostNodeVector.isContainObj

```text
JPT.PostNodeVector.isContainObj


isContainObj( (PostNodeVector)arg1, (DPostNode)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> >,class DRONodeW)
```

## JPT.PostNodeVector.sizeVec

```text
JPT.PostNodeVector.sizeVec


sizeVec( (PostNodeVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DRONodeW,class std::allocator<class DRONodeW> > {lvalue})
```

## JPT.PostResultDataAmt

```text
JPT.PostResultDataAmt


```

## JPT.PostResultDataAmt.from_bytes

```text
JPT.PostResultDataAmt.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataCnv

```text
JPT.PostResultDataCnv


```

## JPT.PostResultDataCnv.from_bytes

```text
JPT.PostResultDataCnv.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataComplex

```text
JPT.PostResultDataComplex


```

## JPT.PostResultDataComplex.from_bytes

```text
JPT.PostResultDataComplex.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataCont

```text
JPT.PostResultDataCont


```

## JPT.PostResultDataCont.from_bytes

```text
JPT.PostResultDataCont.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataCoord

```text
JPT.PostResultDataCoord


```

## JPT.PostResultDataCoord.from_bytes

```text
JPT.PostResultDataCoord.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataLoad1D

```text
JPT.PostResultDataLoad1D


```

## JPT.PostResultDataLoad1D.from_bytes

```text
JPT.PostResultDataLoad1D.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataLoad2D

```text
JPT.PostResultDataLoad2D


```

## JPT.PostResultDataLoad2D.from_bytes

```text
JPT.PostResultDataLoad2D.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultDataLoc

```text
JPT.PostResultDataLoc


```

## JPT.PostResultDataLoc.from_bytes

```text
JPT.PostResultDataLoc.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.PostResultKey

```text
JPT.PostResultKey


```

## JPT.PostTimeStepInfo

```text
JPT.PostTimeStepInfo


```

## JPT.PreviewBCForceGeneral

```text
JPT.PreviewBCForceGeneral


PreviewBCForceGeneral( (DItemVector)arg1, (list)arg2, (list)arg3 [, (int)arg4 [, (int)arg5 [, (float)arg6 [, (int)arg7]]]]) -> None :

    C++ signature :
        void PreviewBCForceGeneral(class std::vector<class DItemW,class std::allocator<class DItemW> >,class boost::python::list,class boost::python::list [,int [,int [,float [,int]]]])
```

## JPT.PreviewBCForceNormal

```text
JPT.PreviewBCForceNormal


PreviewBCForceNormal( (DElem)arg1, (DItemVector)arg2 [, (int)arg3 [, (int)arg4 [, (float)arg5 [, (int)arg6]]]]) -> None :

    C++ signature :
        void PreviewBCForceNormal(class DElemW,class std::vector<class DItemW,class std::allocator<class DItemW> > [,int [,int [,float [,int]]]])
```

## JPT.PreviewBCPressureGeneral

```text
JPT.PreviewBCPressureGeneral


PreviewBCPressureGeneral( (DItemVector)arg1 [, (int)arg2 [, (int)arg3 [, (float)arg4 [, (int)arg5]]]]) -> None :

    C++ signature :
        void PreviewBCPressureGeneral(class std::vector<class DItemW,class std::allocator<class DItemW> > [,int [,int [,float [,int]]]])
```

## JPT.PreviewMirror

```text
JPT.PreviewMirror


PreviewMirror( (BodyVector)arg1, (list)arg2 [, (float)arg3 [, (int)arg4 [, (float)arg5]]]) -> None :

    C++ signature :
        void PreviewMirror(class std::vector<class DBodyW,class std::allocator<class DBodyW> >,class boost::python::list [,double [,int [,float]]])
```

## JPT.PreviewRotate

```text
JPT.PreviewRotate


PreviewRotate( (BodyVector)arg1, (list)arg2, (list)arg3, (float)arg4 [, (int)arg5 [, (float)arg6 [, (DCoord)arg7]]]) -> None :

    C++ signature :
        void PreviewRotate(class std::vector<class DBodyW,class std::allocator<class DBodyW> >,class boost::python::list,class boost::python::list,double [,int [,float [,class DCoordW]]])
```

## JPT.PreviewScaling

```text
JPT.PreviewScaling


PreviewScaling( (BodyVector)arg1, (list)arg2, (list)arg3 [, (int)arg4 [, (float)arg5]]) -> None :

    C++ signature :
        void PreviewScaling(class std::vector<class DBodyW,class std::allocator<class DBodyW> >,class boost::python::list,class boost::python::list [,int [,float]])
```

## JPT.PreviewTranslation

```text
JPT.PreviewTranslation


PreviewTranslation( (BodyVector)arg1, (list)arg2 [, (int)arg3 [, (float)arg4 [, (DCoord)arg5]]]) -> None :

    C++ signature :
        void PreviewTranslation(class std::vector<class DBodyW,class std::allocator<class DBodyW> >,class boost::python::list [,int [,float [,class DCoordW]]])
```

## JPT.PrintAppPathInfo

```text
JPT.PrintAppPathInfo


PrintAppPathInfo() -> None :

    C++ signature :
        void PrintAppPathInfo()
```

## JPT.PrintPSJUtilityManual

```text
JPT.PrintPSJUtilityManual


PrintPSJUtilityManual() -> None :

    C++ signature :
        void PrintPSJUtilityManual()
```

## JPT.PushDlgButton

```text
JPT.PushDlgButton


PushDlgButton( (int)arg1) -> None :

    C++ signature :
        void PushDlgButton(int)
```

## JPT.PyNotificationType

```text
JPT.PyNotificationType


```

## JPT.PyNotificationType.from_bytes

```text
JPT.PyNotificationType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.QuitApplication

```text
JPT.QuitApplication


QuitApplication() -> None :

    C++ signature :
        void QuitApplication()
```

## JPT.ReadJTDBVersion

```text
JPT.ReadJTDBVersion


ReadJTDBVersion( (str)arg1) -> VersionInfo :

    C++ signature :
        struct CVersionInfo ReadJTDBVersion(class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## JPT.RemoveAllAbaqusStep

```text
JPT.RemoveAllAbaqusStep


RemoveAllAbaqusStep() -> None :

    C++ signature :
        void RemoveAllAbaqusStep()
```

## JPT.RemoveAllByTableType

```text
JPT.RemoveAllByTableType


RemoveAllByTableType( (int)arg1) -> None :

    C++ signature :
        void RemoveAllByTableType(int)
```

## JPT.RemoveAllConnections

```text
JPT.RemoveAllConnections


RemoveAllConnections() -> None :

    C++ signature :
        void RemoveAllConnections()
```

## JPT.RemoveAllContacts

```text
JPT.RemoveAllContacts


RemoveAllContacts() -> None :

    C++ signature :
        void RemoveAllContacts()
```

## JPT.RemoveAllCoordinates

```text
JPT.RemoveAllCoordinates


RemoveAllCoordinates() -> None :

    C++ signature :
        void RemoveAllCoordinates()
```

## JPT.RemoveAllFieldTables

```text
JPT.RemoveAllFieldTables


RemoveAllFieldTables() -> None :

    C++ signature :
        void RemoveAllFieldTables()
```

## JPT.RemoveAllLoadCases

```text
JPT.RemoveAllLoadCases


RemoveAllLoadCases() -> None :

    C++ signature :
        void RemoveAllLoadCases()
```

## JPT.RemoveAllLoadsBCs

```text
JPT.RemoveAllLoadsBCs


RemoveAllLoadsBCs() -> None :

    C++ signature :
        void RemoveAllLoadsBCs()
```

## JPT.RemoveAllMaterials

```text
JPT.RemoveAllMaterials


RemoveAllMaterials() -> None :

    C++ signature :
        void RemoveAllMaterials()
```

## JPT.RemoveAllMeshSettings

```text
JPT.RemoveAllMeshSettings


RemoveAllMeshSettings() -> None :

    C++ signature :
        void RemoveAllMeshSettings()
```

## JPT.RemoveAllSolverjob

```text
JPT.RemoveAllSolverjob


RemoveAllSolverjob() -> None :

    C++ signature :
        void RemoveAllSolverjob()
```

## JPT.RemoveEntitiesByID

```text
JPT.RemoveEntitiesByID


RemoveEntitiesByID( (int)arg1, (int)arg2) -> None :

    C++ signature :
        void RemoveEntitiesByID(int,int)
```

## JPT.RemoveEntitiesByName

```text
JPT.RemoveEntitiesByName


RemoveEntitiesByName( (int)arg1, (str)arg2, (bool)arg3) -> None :

    C++ signature :
        void RemoveEntitiesByName(int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,bool)
```

## JPT.RemovePyObserver

```text
JPT.RemovePyObserver


RemovePyObserver( (object)arg1) -> None :

    C++ signature :
        void RemovePyObserver(class boost::python::api::object)
```

## JPT.RemoveWSProperties

```text
JPT.RemoveWSProperties


RemoveWSProperties() -> None :

    C++ signature :
        void RemoveWSProperties()
```

## JPT.SelectArrayCursor

```text
JPT.SelectArrayCursor


SelectArrayCursor( (str)arg1) -> bool :

    C++ signature :
        bool SelectArrayCursor(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.SelectDlgComboBox

```text
JPT.SelectDlgComboBox


SelectDlgComboBox( (int)arg1, (int)arg2) -> None :

    C++ signature :
        void SelectDlgComboBox(int,int)
```

## JPT.SelectMethodType

```text
JPT.SelectMethodType


```

## JPT.SelectMethodType.from_bytes

```text
JPT.SelectMethodType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.SelectionByID

```text
JPT.SelectionByID


SelectionByID( (int)arg1, (int)arg2, (bool)arg3) -> None :

    C++ signature :
        void SelectionByID(int,int,bool)
```

## JPT.SelectionByIDs

```text
JPT.SelectionByIDs


SelectionByIDs( (int)arg1, (list)arg2, (bool)arg3) -> None :

    C++ signature :
        void SelectionByIDs(int,class boost::python::list,bool)
```

## JPT.SelectionByType

```text
JPT.SelectionByType


SelectionByType( (int)arg1, (bool)arg2) -> None :

    C++ signature :
        void SelectionByType(int,bool)
```

## JPT.SelectionListDlg

```text
JPT.SelectionListDlg


```

## JPT.SelectionListDlg.Add1DElementSelector

```text
JPT.SelectionListDlg.Add1DElementSelector


Add1DElementSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void Add1DElementSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddBarBodySelector

```text
JPT.SelectionListDlg.AddBarBodySelector


AddBarBodySelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddBarBodySelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddBodySelector

```text
JPT.SelectionListDlg.AddBodySelector


AddBodySelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddBodySelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddConditionSelector

```text
JPT.SelectionListDlg.AddConditionSelector


AddConditionSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddConditionSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddCoordinateSelector

```text
JPT.SelectionListDlg.AddCoordinateSelector


AddCoordinateSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddCoordinateSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddEdgePointSelector

```text
JPT.SelectionListDlg.AddEdgePointSelector


AddEdgePointSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddEdgePointSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddEdgeSelector

```text
JPT.SelectionListDlg.AddEdgeSelector


AddEdgeSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddEdgeSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddElementEdgeSelector

```text
JPT.SelectionListDlg.AddElementEdgeSelector


AddElementEdgeSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddElementEdgeSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddElementSelector

```text
JPT.SelectionListDlg.AddElementSelector


AddElementSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddElementSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddFacePointSelector

```text
JPT.SelectionListDlg.AddFacePointSelector


AddFacePointSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddFacePointSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddFaceSelector

```text
JPT.SelectionListDlg.AddFaceSelector


AddFaceSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddFaceSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddGroupSelector

```text
JPT.SelectionListDlg.AddGroupSelector


AddGroupSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddGroupSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddNodeSelector

```text
JPT.SelectionListDlg.AddNodeSelector


AddNodeSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddNodeSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddSolidElementSelector

```text
JPT.SelectionListDlg.AddSolidElementSelector


AddSolidElementSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddSolidElementSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.AddVertexSelector

```text
JPT.SelectionListDlg.AddVertexSelector


AddVertexSelector( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void AddVertexSelector(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.Create

```text
JPT.SelectionListDlg.Create


Create( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void Create(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.Destroy

```text
JPT.SelectionListDlg.Destroy


Destroy( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void Destroy(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.Hide

```text
JPT.SelectionListDlg.Hide


Hide( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void Hide(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.Show

```text
JPT.SelectionListDlg.Show


Show( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void Show(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SelectionListDlg.UpdateSelectors

```text
JPT.SelectionListDlg.UpdateSelectors


UpdateSelectors( (SelectionListDlg)arg1) -> None :

    C++ signature :
        void UpdateSelectors(class CSelectionListDlgWrapper {lvalue})
```

## JPT.SetActiveDocumentByID

```text
JPT.SetActiveDocumentByID


SetActiveDocumentByID( (str)arg1, (bool)arg2) -> None :

    C++ signature :
        void SetActiveDocumentByID(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,bool)
```

## JPT.SetActiveDocumentByName

```text
JPT.SetActiveDocumentByName


SetActiveDocumentByName( (str)arg1, (bool)arg2) -> None :

    C++ signature :
        void SetActiveDocumentByName(class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,bool)
```

## JPT.SetDlgText

```text
JPT.SetDlgText


SetDlgText( (int)arg1, (str)arg2) -> None :

    C++ signature :
        void SetDlgText(int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## JPT.SetSelectMethod

```text
JPT.SetSelectMethod


SetSelectMethod( (int)arg1) -> None :

    C++ signature :
        void SetSelectMethod(int)
```

## JPT.ShowHideAllParts

```text
JPT.ShowHideAllParts


ShowHideAllParts( (bool)arg1) -> None :

    C++ signature :
        void ShowHideAllParts(bool)
```

## JPT.ShowHideEntitiesByID

```text
JPT.ShowHideEntitiesByID


ShowHideEntitiesByID( (int)arg1, (int)arg2, (bool)arg3) -> None :

    C++ signature :
        void ShowHideEntitiesByID(int,int,bool)
```

## JPT.ShowHideFlipFaces

```text
JPT.ShowHideFlipFaces


ShowHideFlipFaces() -> None :

    C++ signature :
        void ShowHideFlipFaces()
```

## JPT.ShowPreview

```text
JPT.ShowPreview


ShowPreview() -> None :

    C++ signature :
        void ShowPreview()
```

## JPT.SolverJobVector

```text
JPT.SolverJobVector


```

## JPT.SolverJobVector.addObj

```text
JPT.SolverJobVector.addObj


addObj( (SolverJobVector)arg1, (DSolverJob)arg2) -> None :

    C++ signature :
        void addObj(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue},class DSolverJobW)
```

## JPT.SolverJobVector.append

```text
JPT.SolverJobVector.append


append( (SolverJobVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue},class boost::python::api::object)
```

## JPT.SolverJobVector.clearVec

```text
JPT.SolverJobVector.clearVec


clearVec( (SolverJobVector)arg1) -> None :

    C++ signature :
        void clearVec(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue})
```

## JPT.SolverJobVector.deleteObj

```text
JPT.SolverJobVector.deleteObj


deleteObj( (SolverJobVector)arg1, (int)arg2) -> None :

    C++ signature :
        void deleteObj(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue},int)
```

## JPT.SolverJobVector.extend

```text
JPT.SolverJobVector.extend


extend( (SolverJobVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue},class boost::python::api::object)
```

## JPT.SolverJobVector.extendVec

```text
JPT.SolverJobVector.extendVec


extendVec( (SolverJobVector)arg1, (SolverJobVector)arg2) -> None :

    C++ signature :
        void extendVec(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue},class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> >)
```

## JPT.SolverJobVector.isContainObj

```text
JPT.SolverJobVector.isContainObj


isContainObj( (SolverJobVector)arg1, (DSolverJob)arg2) -> bool :

    C++ signature :
        bool isContainObj(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> >,class DSolverJobW)
```

## JPT.SolverJobVector.sizeVec

```text
JPT.SolverJobVector.sizeVec


sizeVec( (SolverJobVector)arg1) -> int :

    C++ signature :
        unsigned __int64 sizeVec(class std::vector<class DSolverJobW,class std::allocator<class DSolverJobW> > {lvalue})
```

## JPT.StringVector

```text
JPT.StringVector


```

## JPT.StringVector.append

```text
JPT.StringVector.append


append( (StringVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::allocator<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > > > {lvalue},class boost::python::api::object)
```

## JPT.StringVector.extend

```text
JPT.StringVector.extend


extend( (StringVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::allocator<class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > > > {lvalue},class boost::python::api::object)
```

## JPT.TVector3d

```text
JPT.TVector3d


```

## JPT.TVector3dList

```text
JPT.TVector3dList


```

## JPT.TVector3dList.append

```text
JPT.TVector3dList.append


append( (TVector3dList)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<struct TVector3<double>,class std::allocator<struct TVector3<double> > > {lvalue},class boost::python::api::object)
```

## JPT.TVector3dList.extend

```text
JPT.TVector3dList.extend


extend( (TVector3dList)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<struct TVector3<double>,class std::allocator<struct TVector3<double> > > {lvalue},class boost::python::api::object)
```

## JPT.UnitType

```text
JPT.UnitType


```

## JPT.UnitType.from_bytes

```text
JPT.UnitType.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## JPT.UpdateCheckboxAssembly

```text
JPT.UpdateCheckboxAssembly


UpdateCheckboxAssembly( (int)arg1, (int)arg2, (bool)arg3) -> None :

    C++ signature :
        void UpdateCheckboxAssembly(int,int,bool)
```

## JPT.UpdateCheckboxWatchSelected

```text
JPT.UpdateCheckboxWatchSelected


UpdateCheckboxWatchSelected( (int)arg1, (list)arg2, (bool)arg3) -> None :

    C++ signature :
        void UpdateCheckboxWatchSelected(int,class boost::python::list,bool)
```

## JPT.VersionInfo

```text
JPT.VersionInfo


```

## JPT.ViewFitToModel

```text
JPT.ViewFitToModel


ViewFitToModel() -> None :

    C++ signature :
        void ViewFitToModel()
```

## JPT.WStringVector

```text
JPT.WStringVector


```

## JPT.WStringVector.append

```text
JPT.WStringVector.append


append( (WStringVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > {lvalue},class boost::python::api::object)
```

## JPT.WStringVector.extend

```text
JPT.WStringVector.extend


extend( (WStringVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >,class std::allocator<class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > > > {lvalue},class boost::python::api::object)
```

## pyjdg.EndThread

```text
pyjdg.EndThread


EndThread( (ThreadId)arg1) -> None :

    C++ signature :
        void EndThread(struct HandleW)
```

## pyjdg.JDGCreator

```text
pyjdg.JDGCreator


```

## pyjdg.JDGCreator.add_1delement_selector

```text
pyjdg.JDGCreator.add_1delement_selector


add_1delement_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_1delement_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_2delement_selector

```text
pyjdg.JDGCreator.add_2delement_selector


add_2delement_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_2delement_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_3delement_selector

```text
pyjdg.JDGCreator.add_3delement_selector


add_3delement_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_3delement_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_barpart_selector

```text
pyjdg.JDGCreator.add_barpart_selector


add_barpart_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_barpart_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_browser

```text
pyjdg.JDGCreator.add_browser


add_browser( (JDGCreator)arg1, (str)layout, (str)name [, (str)mode='file' [, (str)file_filter='' [, (str)default='' [, (int)multisel=0]]]]) -> None :

    C++ signature :
        void add_browser(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='file' [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,int=0]]]])
```

## pyjdg.JDGCreator.add_button

```text
pyjdg.JDGCreator.add_button


add_button( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='' [, (str)img='' [, (str)location='left' [, (int)text_color=0 [, (int)bk_color=15790320]]]]]]]]) -> None :

    C++ signature :
        void add_button(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='left' [,unsigned long=0 [,unsigned long=15790320]]]]]]]])
```

## pyjdg.JDGCreator.add_checkbox

```text
pyjdg.JDGCreator.add_checkbox


add_checkbox( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='' [, (int)checked=0 [, (int)lefttext=0]]]]]]) -> None :

    C++ signature :
        void add_checkbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,int=0 [,int=0]]]]]])
```

## pyjdg.JDGCreator.add_combobox

```text
pyjdg.JDGCreator.add_combobox


add_combobox( (JDGCreator)arg1, (str)layout, (str)name [, (list)options=[] [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (int)index=-1]]]]]) -> None :

    C++ signature :
        void add_combobox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class boost::python::list=[] [,int=0 [,int=0 [,int=0 [,int=-1]]]]])
```

## pyjdg.JDGCreator.add_combobox_option

```text
pyjdg.JDGCreator.add_combobox_option


add_combobox_option( (JDGCreator)arg1, (str)name, (str)option_text) -> None :

    C++ signature :
        void add_combobox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.add_condition_selector

```text
pyjdg.JDGCreator.add_condition_selector


add_condition_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_condition_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_coordinate_selector

```text
pyjdg.JDGCreator.add_coordinate_selector


add_coordinate_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_coordinate_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_doublefield

```text
pyjdg.JDGCreator.add_doublefield


add_doublefield( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='']]]]) -> None :

    C++ signature :
        void add_doublefield(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='']]]])
```

## pyjdg.JDGCreator.add_edge_selector

```text
pyjdg.JDGCreator.add_edge_selector


add_edge_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_edge_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_elementedge_selector

```text
pyjdg.JDGCreator.add_elementedge_selector


add_elementedge_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_elementedge_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_face_selector

```text
pyjdg.JDGCreator.add_face_selector


add_face_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_face_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_group_selector

```text
pyjdg.JDGCreator.add_group_selector


add_group_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_group_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_groupbox

```text
pyjdg.JDGCreator.add_groupbox


add_groupbox( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (str)text='']]) -> None :

    C++ signature :
        void add_groupbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='']])
```

## pyjdg.JDGCreator.add_hlayout

```text
pyjdg.JDGCreator.add_hlayout


add_hlayout( (JDGCreator)arg1, (str)layout [, (list)margin=[] [, (str)name='' [, (int)id=0]]]) -> None :

    C++ signature :
        void add_hlayout(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class boost::python::list=[] [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,int=0]]])
```

## pyjdg.JDGCreator.add_imagectrl

```text
pyjdg.JDGCreator.add_imagectrl


add_imagectrl( (JDGCreator)arg1, (str)layout, (str)name [, (str)image_file='' [, (int)id=0 [, (int)width=60 [, (int)height=60]]]]) -> None :

    C++ signature :
        void add_imagectrl(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,int=0 [,int=60 [,int=60]]]])
```

## pyjdg.JDGCreator.add_intfield

```text
pyjdg.JDGCreator.add_intfield


add_intfield( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='']]]]) -> None :

    C++ signature :
        void add_intfield(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='']]]])
```

## pyjdg.JDGCreator.add_label

```text
pyjdg.JDGCreator.add_label


add_label( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='' [, (str)text_halign='left' [, (str)text_valign='top']]]]]]) -> None :

    C++ signature :
        void add_label(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='left' [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='top']]]]]])
```

## pyjdg.JDGCreator.add_layout

```text
pyjdg.JDGCreator.add_layout


add_layout( (JDGCreator)arg1, (str)layout, (orientation)orientation [, (list)margin=[] [, (str)name='' [, (int)id=0]]]) -> None :

    C++ signature :
        void add_layout(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,enum ETSLayoutMgr::layOrientation [,class boost::python::list=[] [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,int=0]]])
```

## pyjdg.JDGCreator.add_listbox

```text
pyjdg.JDGCreator.add_listbox


add_listbox( (JDGCreator)arg1, (str)layout, (str)name [, (list)options=[] [, (int)multisel=0 [, (int)id=0 [, (int)width=0 [, (int)height=0]]]]]) -> None :

    C++ signature :
        void add_listbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class boost::python::list=[] [,int=0 [,int=0 [,int=0 [,int=0]]]]])
```

## pyjdg.JDGCreator.add_listbox_option

```text
pyjdg.JDGCreator.add_listbox_option


add_listbox_option( (JDGCreator)arg1, (str)name, (str)option_text) -> None :

    C++ signature :
        void add_listbox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.add_node_selector

```text
pyjdg.JDGCreator.add_node_selector


add_node_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_node_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_pageitem

```text
pyjdg.JDGCreator.add_pageitem


add_pageitem( (JDGCreator)arg1, (str)name, (str)page_name, (str)page_header [, (int)id=0 [, (str)icon='' [, (int)text_color=0 [, (int)bk_color=16777215]]]]) -> None :

    C++ signature :
        void add_pageitem(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,unsigned long=0 [,unsigned long=16777215]]]])
```

## pyjdg.JDGCreator.add_pagesctrl

```text
pyjdg.JDGCreator.add_pagesctrl


add_pagesctrl( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)show_header=1 [, (int)show_separator=1 [, (int)current_page=0 [, (int)width=0 [, (int)height=0 [, (int)sel_color=13158460]]]]]]]) -> None :

    C++ signature :
        void add_pagesctrl(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=1 [,int=1 [,int=0 [,int=0 [,int=0 [,unsigned long=13158460]]]]]]])
```

## pyjdg.JDGCreator.add_pagesctrl_page

```text
pyjdg.JDGCreator.add_pagesctrl_page


add_pagesctrl_page( (JDGCreator)arg1, (str)name, (str)page_name, (str)page_header [, (int)id=0]) -> None :

    C++ signature :
        void add_pagesctrl_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > [,int=0])
```

## pyjdg.JDGCreator.add_part_selector

```text
pyjdg.JDGCreator.add_part_selector


add_part_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_part_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_radiobutton

```text
pyjdg.JDGCreator.add_radiobutton


add_radiobutton( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='' [, (int)checked=0 [, (int)group=0 [, (int)lefttext=0]]]]]]]) -> None :

    C++ signature :
        void add_radiobutton(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,int=0 [,int=0 [,int=0]]]]]]])
```

## pyjdg.JDGCreator.add_richeditbox

```text
pyjdg.JDGCreator.add_richeditbox


add_richeditbox( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=60 [, (int)height=22 [, (str)text='']]]]) -> None :

    C++ signature :
        void add_richeditbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=60 [,int=22 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='']]]])
```

## pyjdg.JDGCreator.add_separator

```text
pyjdg.JDGCreator.add_separator


add_separator( (JDGCreator)arg1, (str)layout [, (str)name='']) -> None :

    C++ signature :
        void add_separator(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >=''])
```

## pyjdg.JDGCreator.add_slider

```text
pyjdg.JDGCreator.add_slider


add_slider( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=60 [, (int)height=22 [, (int)vertical=0 [, (int)show_ticks=1 [, (int)show_bothticks=0 [, (int)show_border=0 [, (int)min=0 [, (int)max=100 [, (int)pos=0]]]]]]]]]]) -> None :

    C++ signature :
        void add_slider(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=60 [,int=22 [,int=0 [,int=1 [,int=0 [,int=0 [,int=0 [,int=100 [,int=0]]]]]]]]]])
```

## pyjdg.JDGCreator.add_space

```text
pyjdg.JDGCreator.add_space


add_space( (JDGCreator)arg1, (str)layout [, (str)name='' [, (str)orientation='' [, (int)size=0]]]) -> None :

    C++ signature :
        void add_space(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,int=0]]])
```

## pyjdg.JDGCreator.add_spin

```text
pyjdg.JDGCreator.add_spin


add_spin( (JDGCreator)arg1, (str)layout, (str)name [, (spin)type=pyjdg.spin.integer [, (int)id=0 [, (float)min=0.1 [, (float)max=1.0 [, (float)pos=0.1 [, (float)increment=0.1 [, (int)precision=3]]]]]]]) -> None :

    C++ signature :
        void add_spin(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,enum CJPTSpinCtrl::SpinType=pyjdg.spin.integer [,int=0 [,double=0.1 [,double=1.0 [,double=0.1 [,double=0.1 [,int=3]]]]]]])
```

## pyjdg.JDGCreator.add_table

```text
pyjdg.JDGCreator.add_table


add_table( (JDGCreator)arg1, (str)layout, (str)name='', (list)columns, (int)rows [, (int)width=260 [, (int)height=260 [, (int)id=0 [, (int)show_row_number=1 [, (int)show_grid_line=1 [, (list)menus=[] [, (int)show_col_header=1]]]]]]]) -> None :

    C++ signature :
        void add_table(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='',class boost::python::list,int [,int=260 [,int=260 [,int=0 [,int=1 [,int=1 [,class boost::python::list=[] [,int=1]]]]]]])

add_table( (JDGCreator)arg1, (str)layout [, (str)name='' [, (TableColumnInfoVector)columns=<pyjdg.TableColumnInfoVector object at 0x0000024DD9FC78D0> [, (int)rows=0 [, (int)width=260 [, (int)height=260 [, (int)id=0 [, (int)show_row_number=1 [, (int)show_grid_line=1 [, (list)menus=[] [, (int)show_col_header=1]]]]]]]]]]) -> None :

    C++ signature :
        void add_table(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> >=<pyjdg.TableColumnInfoVector object at 0x0000024DD9FC78D0> [,int=0 [,int=260 [,int=260 [,int=0 [,int=1 [,int=1 [,class boost::python::list=[] [,int=1]]]]]]]]]])
```

## pyjdg.JDGCreator.add_table_right_menu

```text
pyjdg.JDGCreator.add_table_right_menu


add_table_right_menu( (JDGCreator)arg1, (str)name, (list)menus) -> None :

    C++ signature :
        void add_table_right_menu(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::list)
```

## pyjdg.JDGCreator.add_tabwnd

```text
pyjdg.JDGCreator.add_tabwnd


add_tabwnd( (JDGCreator)arg1, (str)layout, (str)name [, (int)id=0 [, (int)width=60 [, (int)height=22 [, (str)text='']]]]) -> None :

    C++ signature :
        void add_tabwnd(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=0 [,int=60 [,int=22 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='']]]])
```

## pyjdg.JDGCreator.add_tabwnd_page

```text
pyjdg.JDGCreator.add_tabwnd_page


add_tabwnd_page( (JDGCreator)arg1, (str)name, (str)page_name [, (str)page_text='' [, (str)page_orientation='vertical']]) -> None :

    C++ signature :
        void add_tabwnd_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='vertical']])
```

## pyjdg.JDGCreator.add_textbox

```text
pyjdg.JDGCreator.add_textbox


add_textbox( (JDGCreator)arg1, (str)layout, (str)name [, (str)type='string' [, (int)id=0 [, (int)width=0 [, (int)height=0 [, (str)text='' [, (int)readonly=0 [, (str)text_align='left' [, (int)text_color=0 [, (int)bk_color=16777215]]]]]]]]]) -> None :

    C++ signature :
        void add_textbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='string' [,int=0 [,int=0 [,int=0 [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >='' [,int=0 [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='left' [,unsigned long=0 [,unsigned long=16777215]]]]]]]]])
```

## pyjdg.JDGCreator.add_vertex_selector

```text
pyjdg.JDGCreator.add_vertex_selector


add_vertex_selector( (JDGCreator)arg1) -> None :

    C++ signature :
        void add_vertex_selector(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.add_vlayout

```text
pyjdg.JDGCreator.add_vlayout


add_vlayout( (JDGCreator)arg1, (str)layout [, (list)margin=[] [, (str)name='' [, (int)id=0]]]) -> None :

    C++ signature :
        void add_vlayout(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class boost::python::list=[] [,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >='' [,int=0]]])
```

## pyjdg.JDGCreator.clear_combobox

```text
pyjdg.JDGCreator.clear_combobox


clear_combobox( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void clear_combobox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.clear_listbox

```text
pyjdg.JDGCreator.clear_listbox


clear_listbox( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void clear_listbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.clear_table_all

```text
pyjdg.JDGCreator.clear_table_all


clear_table_all( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void clear_table_all(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.clear_table_cell

```text
pyjdg.JDGCreator.clear_table_cell


clear_table_cell( (JDGCreator)arg1, (str)name, (int)row, (int)col [, (str)text='']) -> int :

    C++ signature :
        int clear_table_cell(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >=''])
```

## pyjdg.JDGCreator.clear_table_range

```text
pyjdg.JDGCreator.clear_table_range


clear_table_range( (JDGCreator)arg1, (str)name, (TableCellRange)cell_range) -> None :

    C++ signature :
        void clear_table_range(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridRange)
```

## pyjdg.JDGCreator.close

```text
pyjdg.JDGCreator.close


close( (JDGCreator)arg1) -> None :

    C++ signature :
        void close(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.delete_table_column

```text
pyjdg.JDGCreator.delete_table_column


delete_table_column( (JDGCreator)arg1, (str)name, (int)position) -> None :

    C++ signature :
        void delete_table_column(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.delete_table_row

```text
pyjdg.JDGCreator.delete_table_row


delete_table_row( (JDGCreator)arg1, (str)name, (int)position) -> None :

    C++ signature :
        void delete_table_row(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.disable_item

```text
pyjdg.JDGCreator.disable_item


disable_item( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void disable_item(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.do_modal

```text
pyjdg.JDGCreator.do_modal


do_modal( (JDGCreator)arg1) -> None :

    C++ signature :
        void do_modal(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.enable_item

```text
pyjdg.JDGCreator.enable_item


enable_item( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void enable_item(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.enable_table_column_filter

```text
pyjdg.JDGCreator.enable_table_column_filter


enable_table_column_filter( (JDGCreator)arg1, (str)name, (int)col, (int)enable) -> None :

    C++ signature :
        void enable_table_column_filter(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int)
```

## pyjdg.JDGCreator.fill_table_by_file

```text
pyjdg.JDGCreator.fill_table_by_file


fill_table_by_file( (JDGCreator)arg1, (str)name, (str)file [, (str)delimiter=',']) -> bool :

    C++ signature :
        bool fill_table_by_file(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > [,char=','])
```

## pyjdg.JDGCreator.generate_window

```text
pyjdg.JDGCreator.generate_window


generate_window( (JDGCreator)arg1) -> None :

    C++ signature :
        void generate_window(class CPSJDialogWrapper {lvalue})
```

## pyjdg.JDGCreator.get_cell_label

```text
pyjdg.JDGCreator.get_cell_label


get_cell_label( (JDGCreator)arg1, (str)name, (int)row, (int)col) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_cell_label(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int)
```

## pyjdg.JDGCreator.get_cell_value

```text
pyjdg.JDGCreator.get_cell_value


get_cell_value( (JDGCreator)arg1, (str)name, (int)row, (int)col [, (int)option=-1]) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_cell_value(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int [,int=-1])

get_cell_value( (JDGCreator)arg1, (str)name, (int)cell_row_id, (int)cell_column_id [, (int)option=-1]) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_cell_value(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int [,int=-1])
```

## pyjdg.JDGCreator.get_combobox_option

```text
pyjdg.JDGCreator.get_combobox_option


get_combobox_option( (JDGCreator)arg1, (str)name, (int)index) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_combobox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.get_combobox_sel

```text
pyjdg.JDGCreator.get_combobox_sel


get_combobox_sel( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_combobox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_dlg_selector_selected_entities

```text
pyjdg.JDGCreator.get_dlg_selector_selected_entities


get_dlg_selector_selected_entities( (JDGCreator)arg1, (int)selid) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > get_dlg_selector_selected_entities(class CPSJDialogWrapper {lvalue},int)
```

## pyjdg.JDGCreator.get_item_font

```text
pyjdg.JDGCreator.get_item_font


get_item_font( (JDGCreator)arg1, (str)name) -> PSJFont :

    C++ signature :
        struct CPSJFont get_item_font(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_item_text

```text
pyjdg.JDGCreator.get_item_text


get_item_text( (JDGCreator)arg1, (str)name) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_item_text(class CPSJDialogWrapper {lvalue},class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.get_item_visible

```text
pyjdg.JDGCreator.get_item_visible


get_item_visible( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_item_visible(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_len_combobox

```text
pyjdg.JDGCreator.get_len_combobox


get_len_combobox( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_len_combobox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_len_listbox

```text
pyjdg.JDGCreator.get_len_listbox


get_len_listbox( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_len_listbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_listbox_option

```text
pyjdg.JDGCreator.get_listbox_option


get_listbox_option( (JDGCreator)arg1, (str)name, (int)option_index) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_listbox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.get_listbox_sel

```text
pyjdg.JDGCreator.get_listbox_sel


get_listbox_sel( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_listbox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_listbox_sels

```text
pyjdg.JDGCreator.get_listbox_sels


get_listbox_sels( (JDGCreator)arg1, (str)name) -> IntVector :

    C++ signature :
        class std::vector<int,class std::allocator<int> > get_listbox_sels(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_pagesctrl_current_page

```text
pyjdg.JDGCreator.get_pagesctrl_current_page


get_pagesctrl_current_page( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_pagesctrl_current_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_pagesctrl_page_name

```text
pyjdg.JDGCreator.get_pagesctrl_page_name


get_pagesctrl_page_name( (JDGCreator)arg1, (str)name, (int)page_index) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > get_pagesctrl_page_name(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.get_selected_entities

```text
pyjdg.JDGCreator.get_selected_entities


get_selected_entities( (JDGCreator)arg1, (int)selid) -> DItemVector :

    C++ signature :
        class std::vector<class DItemW,class std::allocator<class DItemW> > get_selected_entities(class CPSJDialogWrapper {lvalue},int)
```

## pyjdg.JDGCreator.get_table_cell_fill_color

```text
pyjdg.JDGCreator.get_table_cell_fill_color


get_table_cell_fill_color( (JDGCreator)arg1, (str)name, (TableCellID)cell) -> int :

    C++ signature :
        long get_table_cell_fill_color(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridItemID)

get_table_cell_fill_color( (JDGCreator)arg1, (str)name, (int)row, (int)col) -> int :

    C++ signature :
        long get_table_cell_fill_color(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int)
```

## pyjdg.JDGCreator.get_table_column_width

```text
pyjdg.JDGCreator.get_table_column_width


get_table_column_width( (JDGCreator)arg1, (str)name, (int)col) -> int :

    C++ signature :
        int get_table_column_width(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.get_table_sel_cell

```text
pyjdg.JDGCreator.get_table_sel_cell


get_table_sel_cell( (JDGCreator)arg1, (str)name) -> TableCellVector :

    C++ signature :
        class std::vector<class CBCGPGridItemID,class std::allocator<class CBCGPGridItemID> > get_table_sel_cell(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_table_sel_range

```text
pyjdg.JDGCreator.get_table_sel_range


get_table_sel_range( (JDGCreator)arg1, (str)name) -> TableCellRangeVector :

    C++ signature :
        class std::vector<class CBCGPGridRange,class std::allocator<class CBCGPGridRange> > get_table_sel_range(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_tabwnd_current_page

```text
pyjdg.JDGCreator.get_tabwnd_current_page


get_tabwnd_current_page( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_tabwnd_current_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_total_column

```text
pyjdg.JDGCreator.get_total_column


get_total_column( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_total_column(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.get_total_row

```text
pyjdg.JDGCreator.get_total_row


get_total_row( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int get_total_row(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.hide_layout

```text
pyjdg.JDGCreator.hide_layout


hide_layout( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void hide_layout(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.insert_combobox_option

```text
pyjdg.JDGCreator.insert_combobox_option


insert_combobox_option( (JDGCreator)arg1, (str)name, (int)position, (str)option) -> None :

    C++ signature :
        void insert_combobox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.insert_combobox_options

```text
pyjdg.JDGCreator.insert_combobox_options


insert_combobox_options( (JDGCreator)arg1, (str)name, (int)position, (list)options) -> None :

    C++ signature :
        void insert_combobox_options(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,class boost::python::list)
```

## pyjdg.JDGCreator.insert_listbox_option

```text
pyjdg.JDGCreator.insert_listbox_option


insert_listbox_option( (JDGCreator)arg1, (str)name, (int)position, (str)option) -> None :

    C++ signature :
        void insert_listbox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.insert_listbox_options

```text
pyjdg.JDGCreator.insert_listbox_options


insert_listbox_options( (JDGCreator)arg1, (str)name, (int)position, (list)options) -> None :

    C++ signature :
        void insert_listbox_options(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,class boost::python::list)
```

## pyjdg.JDGCreator.insert_table_columns

```text
pyjdg.JDGCreator.insert_table_columns


insert_table_columns( (JDGCreator)arg1, (str)name, (TableColumnInfoVector)columns [, (int)position=-1]) -> int :

    C++ signature :
        int insert_table_columns(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> > [,int=-1])
```

## pyjdg.JDGCreator.insert_table_rows

```text
pyjdg.JDGCreator.insert_table_rows


insert_table_rows( (JDGCreator)arg1, (str)name [, (int)row_num=1 [, (int)position=-1]]) -> int :

    C++ signature :
        int insert_table_rows(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,int=1 [,int=-1]])
```

## pyjdg.JDGCreator.is_groupbox_checked

```text
pyjdg.JDGCreator.is_groupbox_checked


is_groupbox_checked( (JDGCreator)arg1, (str)name) -> int :

    C++ signature :
        int is_groupbox_checked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.is_table_cell_button

```text
pyjdg.JDGCreator.is_table_cell_button


is_table_cell_button( (JDGCreator)arg1, (str)name, (TableCellID)cell) -> bool :

    C++ signature :
        bool is_table_cell_button(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridItemID)
```

## pyjdg.JDGCreator.is_table_cell_checkbox

```text
pyjdg.JDGCreator.is_table_cell_checkbox


is_table_cell_checkbox( (JDGCreator)arg1, (str)name, (TableCellID)cell) -> bool :

    C++ signature :
        bool is_table_cell_checkbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridItemID)
```

## pyjdg.JDGCreator.is_table_cell_checked

```text
pyjdg.JDGCreator.is_table_cell_checked


is_table_cell_checked( (JDGCreator)arg1, (str)name, (TableCellID)cell) -> bool :

    C++ signature :
        bool is_table_cell_checked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridItemID)
```

## pyjdg.JDGCreator.is_table_cell_combobox

```text
pyjdg.JDGCreator.is_table_cell_combobox


is_table_cell_combobox( (JDGCreator)arg1, (str)name, (TableCellID)cell) -> bool :

    C++ signature :
        bool is_table_cell_combobox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridItemID)
```

## pyjdg.JDGCreator.isbutton_checked

```text
pyjdg.JDGCreator.isbutton_checked


isbutton_checked( (JDGCreator)arg1, (str)name) -> bool :

    C++ signature :
        bool isbutton_checked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.on_active_tab_page

```text
pyjdg.JDGCreator.on_active_tab_page


on_active_tab_page( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_active_tab_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_browse

```text
pyjdg.JDGCreator.on_browse


on_browse( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_browse(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_button_clicked

```text
pyjdg.JDGCreator.on_button_clicked


on_button_clicked( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_button_clicked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_combobox_sel

```text
pyjdg.JDGCreator.on_combobox_sel


on_combobox_sel( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_combobox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_command

```text
pyjdg.JDGCreator.on_command


on_command( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_command(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_dlg_apply

```text
pyjdg.JDGCreator.on_dlg_apply


on_dlg_apply( (JDGCreator)arg1, (object)callfunc) -> None :

    C++ signature :
        void on_dlg_apply(class CPSJDialogWrapper {lvalue},class boost::python::api::object)
```

## pyjdg.JDGCreator.on_dlg_cancel

```text
pyjdg.JDGCreator.on_dlg_cancel


on_dlg_cancel( (JDGCreator)arg1, (object)callfunc) -> None :

    C++ signature :
        void on_dlg_cancel(class CPSJDialogWrapper {lvalue},class boost::python::api::object)
```

## pyjdg.JDGCreator.on_dlg_help

```text
pyjdg.JDGCreator.on_dlg_help


on_dlg_help( (JDGCreator)arg1, (object)callfunc) -> None :

    C++ signature :
        void on_dlg_help(class CPSJDialogWrapper {lvalue},class boost::python::api::object)
```

## pyjdg.JDGCreator.on_dlg_ok

```text
pyjdg.JDGCreator.on_dlg_ok


on_dlg_ok( (JDGCreator)arg1, (object)callfunc) -> None :

    C++ signature :
        void on_dlg_ok(class CPSJDialogWrapper {lvalue},class boost::python::api::object)
```

## pyjdg.JDGCreator.on_dlg_selector_changed

```text
pyjdg.JDGCreator.on_dlg_selector_changed


on_dlg_selector_changed( (JDGCreator)arg1, (object)callfunc) -> None :

    C++ signature :
        void on_dlg_selector_changed(class CPSJDialogWrapper {lvalue},class boost::python::api::object)
```

## pyjdg.JDGCreator.on_groupbox_checked

```text
pyjdg.JDGCreator.on_groupbox_checked


on_groupbox_checked( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_groupbox_checked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_listbox_sel

```text
pyjdg.JDGCreator.on_listbox_sel


on_listbox_sel( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_listbox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_pagesctrl_active_page

```text
pyjdg.JDGCreator.on_pagesctrl_active_page


on_pagesctrl_active_page( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_pagesctrl_active_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_selected

```text
pyjdg.JDGCreator.on_selected


on_selected( (JDGCreator)arg1, (object)callfunc) -> None :

    C++ signature :
        void on_selected(class CPSJDialogWrapper {lvalue},class boost::python::api::object)
```

## pyjdg.JDGCreator.on_spin_changed

```text
pyjdg.JDGCreator.on_spin_changed


on_spin_changed( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_spin_changed(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_table_button_clicked

```text
pyjdg.JDGCreator.on_table_button_clicked


on_table_button_clicked( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_table_button_clicked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_table_right_menu

```text
pyjdg.JDGCreator.on_table_right_menu


on_table_right_menu( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_table_right_menu(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.on_table_sel_changed

```text
pyjdg.JDGCreator.on_table_sel_changed


on_table_sel_changed( (JDGCreator)arg1, (str)name, (object)callfunc) -> None :

    C++ signature :
        void on_table_sel_changed(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.post_message

```text
pyjdg.JDGCreator.post_message


post_message( (JDGCreator)arg1, (str)message, (int)value) -> None :

    C++ signature :
        void post_message(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.register_message

```text
pyjdg.JDGCreator.register_message


register_message( (JDGCreator)arg1, (str)message, (object)callfunc) -> int :

    C++ signature :
        unsigned int register_message(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class boost::python::api::object)
```

## pyjdg.JDGCreator.remove_combobox_option

```text
pyjdg.JDGCreator.remove_combobox_option


remove_combobox_option( (JDGCreator)arg1, (str)name, (int)position) -> None :

    C++ signature :
        void remove_combobox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.remove_listbox_option

```text
pyjdg.JDGCreator.remove_listbox_option


remove_listbox_option( (JDGCreator)arg1, (str)name, (int)position) -> None :

    C++ signature :
        void remove_listbox_option(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.select_table_range

```text
pyjdg.JDGCreator.select_table_range


select_table_range( (JDGCreator)arg1, (str)name, (TableCellRange)cell_range) -> None :

    C++ signature :
        void select_table_range(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class CBCGPGridRange)
```

## pyjdg.JDGCreator.set_cell_value

```text
pyjdg.JDGCreator.set_cell_value


set_cell_value( (JDGCreator)arg1, (str)name, (int)row, (int)col, (str)value) -> None :

    C++ signature :
        void set_cell_value(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)

set_cell_value( (JDGCreator)arg1, (str)name, (int)row, (int)col, (list)value) -> None :

    C++ signature :
        void set_cell_value(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class boost::python::list)

set_cell_value( (JDGCreator)arg1, (str)name, (int)cell_row_id, (int)cell_column_id, (str)value) -> None :

    C++ signature :
        void set_cell_value(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)

set_cell_value( (JDGCreator)arg1, (str)name, (int)cell_row_id, (int)cell_column_id, (list)value) -> None :

    C++ signature :
        void set_cell_value(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class boost::python::list)
```

## pyjdg.JDGCreator.set_checkbox_state

```text
pyjdg.JDGCreator.set_checkbox_state


set_checkbox_state( (JDGCreator)arg1, (str)name, (int)checked) -> None :

    C++ signature :
        void set_checkbox_state(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_combobox_sel

```text
pyjdg.JDGCreator.set_combobox_sel


set_combobox_sel( (JDGCreator)arg1, (str)name, (str)option) -> None :

    C++ signature :
        void set_combobox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)

set_combobox_sel( (JDGCreator)arg1, (str)name, (int)option) -> None :

    C++ signature :
        void set_combobox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_groupbox_checked

```text
pyjdg.JDGCreator.set_groupbox_checked


set_groupbox_checked( (JDGCreator)arg1, (str)name, (int)checked) -> None :

    C++ signature :
        void set_groupbox_checked(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_groupbox_collapsed

```text
pyjdg.JDGCreator.set_groupbox_collapsed


set_groupbox_collapsed( (JDGCreator)arg1, (str)name, (int)collapsed) -> None :

    C++ signature :
        void set_groupbox_collapsed(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_groupbox_orientation

```text
pyjdg.JDGCreator.set_groupbox_orientation


set_groupbox_orientation( (JDGCreator)arg1, (str)name, (str)orientation) -> None :

    C++ signature :
        void set_groupbox_orientation(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.set_icon_file

```text
pyjdg.JDGCreator.set_icon_file


set_icon_file( (JDGCreator)arg1, (str)file) -> int :

    C++ signature :
        int set_icon_file(class CPSJDialogWrapper {lvalue},class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.set_image_file

```text
pyjdg.JDGCreator.set_image_file


set_image_file( (JDGCreator)arg1, (str)name, (str)image_path) -> None :

    C++ signature :
        void set_image_file(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.set_item_font

```text
pyjdg.JDGCreator.set_item_font


set_item_font( (JDGCreator)arg1, (str)name, (PSJFont)font) -> None :

    C++ signature :
        void set_item_font(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,struct CPSJFont)
```

## pyjdg.JDGCreator.set_item_size_behavior

```text
pyjdg.JDGCreator.set_item_size_behavior


set_item_size_behavior( (JDGCreator)arg1, (str)name, (size_behavior)behavior) -> None :

    C++ signature :
        void set_item_size_behavior(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,enum ETSLayoutMgr::layResizeMode)
```

## pyjdg.JDGCreator.set_item_text

```text
pyjdg.JDGCreator.set_item_text


set_item_text( (JDGCreator)arg1, (str)name, (str)text) -> None :

    C++ signature :
        void set_item_text(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.set_item_visible

```text
pyjdg.JDGCreator.set_item_visible


set_item_visible( (JDGCreator)arg1, (str)name, (int)visible) -> None :

    C++ signature :
        void set_item_visible(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_listbox_sel

```text
pyjdg.JDGCreator.set_listbox_sel


set_listbox_sel( (JDGCreator)arg1, (str)name, (str)option) -> None :

    C++ signature :
        void set_listbox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)

set_listbox_sel( (JDGCreator)arg1, (str)name, (int)option) -> None :

    C++ signature :
        void set_listbox_sel(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_pagesctrl_current_page

```text
pyjdg.JDGCreator.set_pagesctrl_current_page


set_pagesctrl_current_page( (JDGCreator)arg1, (str)name, (int)page_index) -> None :

    C++ signature :
        void set_pagesctrl_current_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_radiobutton_state

```text
pyjdg.JDGCreator.set_radiobutton_state


set_radiobutton_state( (JDGCreator)arg1, (str)name, (int)checked) -> None :

    C++ signature :
        void set_radiobutton_state(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_slider_bothtics

```text
pyjdg.JDGCreator.set_slider_bothtics


set_slider_bothtics( (JDGCreator)arg1, (str)name, (int)enabled) -> None :

    C++ signature :
        void set_slider_bothtics(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_slider_show_border

```text
pyjdg.JDGCreator.set_slider_show_border


set_slider_show_border( (JDGCreator)arg1, (str)name, (int)enabled) -> None :

    C++ signature :
        void set_slider_show_border(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_slider_show_tics

```text
pyjdg.JDGCreator.set_slider_show_tics


set_slider_show_tics( (JDGCreator)arg1, (str)name, (int)enabled) -> None :

    C++ signature :
        void set_slider_show_tics(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_slider_vertical

```text
pyjdg.JDGCreator.set_slider_vertical


set_slider_vertical( (JDGCreator)arg1, (str)name, (int)enabled) -> None :

    C++ signature :
        void set_slider_vertical(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_table_cell_alignment

```text
pyjdg.JDGCreator.set_table_cell_alignment


set_table_cell_alignment( (JDGCreator)arg1, (str)name, (int)row, (int)col, (str)alignment) -> None :

    C++ signature :
        void set_table_cell_alignment(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.set_table_cell_button

```text
pyjdg.JDGCreator.set_table_cell_button


set_table_cell_button( (JDGCreator)arg1, (str)name, (int)row, (int)col, (str)text) -> None :

    C++ signature :
        void set_table_cell_button(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.JDGCreator.set_table_cell_checkbox

```text
pyjdg.JDGCreator.set_table_cell_checkbox


set_table_cell_checkbox( (JDGCreator)arg1, (str)name, (int)row, (int)col, (str)text [, (int)checked=0]) -> None :

    C++ signature :
        void set_table_cell_checkbox(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,int,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > [,int=0])
```

## pyjdg.JDGCreator.set_table_cell_fill_color

```text
pyjdg.JDGCreator.set_table_cell_fill_color


set_table_cell_fill_color( (JDGCreator)arg1, (str)name [, (TableCellID)cell=<pyjdg.TableCellID object at 0x0000024DD5555D50> [, (int)color=-1]]) -> None :

    C++ signature :
        void set_table_cell_fill_color(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class CBCGPGridItemID=<pyjdg.TableCellID object at 0x0000024DD5555D50> [,long=-1]])
```

## pyjdg.JDGCreator.set_table_cell_text_color

```text
pyjdg.JDGCreator.set_table_cell_text_color


set_table_cell_text_color( (JDGCreator)arg1, (str)name [, (TableCellID)cell=<pyjdg.TableCellID object at 0x0000024DD5555E90> [, (int)color=-1]]) -> None :

    C++ signature :
        void set_table_cell_text_color(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > [,class CBCGPGridItemID=<pyjdg.TableCellID object at 0x0000024DD5555E90> [,long=-1]])
```

## pyjdg.JDGCreator.set_table_column_data_type

```text
pyjdg.JDGCreator.set_table_column_data_type


set_table_column_data_type( (JDGCreator)arg1, (str)name, (int)col, (str)data_type) -> None :

    C++ signature :
        void set_table_column_data_type(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)

set_table_column_data_type( (JDGCreator)arg1, (str)name, (int)col, (str)data_type, (int)precision) -> None :

    C++ signature :
        void set_table_column_data_type(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,unsigned int)
```

## pyjdg.JDGCreator.set_table_column_width

```text
pyjdg.JDGCreator.set_table_column_width


set_table_column_width( (JDGCreator)arg1, (str)name, (int)col [, (int)width=-1]) -> int :

    C++ signature :
        int set_table_column_width(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int [,int=-1])
```

## pyjdg.JDGCreator.set_tabwnd_current_page

```text
pyjdg.JDGCreator.set_tabwnd_current_page


set_tabwnd_current_page( (JDGCreator)arg1, (str)name, (int)page_index) -> None :

    C++ signature :
        void set_tabwnd_current_page(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.set_textbox_type

```text
pyjdg.JDGCreator.set_textbox_type


set_textbox_type( (JDGCreator)arg1, (str)name, (str)textbox_type) -> None :

    C++ signature :
        void set_textbox_type(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.show_dlg_help_button

```text
pyjdg.JDGCreator.show_dlg_help_button


show_dlg_help_button( (JDGCreator)arg1 [, (int)shown=0]) -> None :

    C++ signature :
        void show_dlg_help_button(class CPSJDialogWrapper {lvalue} [,int=0])
```

## pyjdg.JDGCreator.show_layout

```text
pyjdg.JDGCreator.show_layout


show_layout( (JDGCreator)arg1, (str)name) -> None :

    C++ signature :
        void show_layout(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >)
```

## pyjdg.JDGCreator.show_table_column_header

```text
pyjdg.JDGCreator.show_table_column_header


show_table_column_header( (JDGCreator)arg1, (str)name, (int)show) -> None :

    C++ signature :
        void show_table_column_header(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.show_table_row_header

```text
pyjdg.JDGCreator.show_table_row_header


show_table_row_header( (JDGCreator)arg1, (str)name, (int)show) -> None :

    C++ signature :
        void show_table_row_header(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,int)
```

## pyjdg.JDGCreator.show_tooltip

```text
pyjdg.JDGCreator.show_tooltip


show_tooltip( (JDGCreator)arg1, (str)name, (str)tip) -> bool :

    C++ signature :
        bool show_tooltip(class CPSJDialogWrapper {lvalue},class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.PSJColor

```text
pyjdg.PSJColor


PSJColor( (int)arg1, (int)arg2, (int)arg3, (int)arg4) -> int :

    C++ signature :
        unsigned long PSJColor(unsigned char,unsigned char,unsigned char,unsigned char)
```

## pyjdg.PSJFont

```text
pyjdg.PSJFont


```

## pyjdg.PSJMessageBox

```text
pyjdg.PSJMessageBox


```

## pyjdg.PSJMessageBox.add_button

```text
pyjdg.PSJMessageBox.add_button


add_button( (PSJMessageBox)arg1, (msgbox_position)pos, (str)text) -> None :

    C++ signature :
        void add_button(class CPSJMessageBox {lvalue},enum PSJMSGBOX_BUTTON_POS,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.PSJMessageBox.enable_checkbox

```text
pyjdg.PSJMessageBox.enable_checkbox


enable_checkbox( (PSJMessageBox)arg1, (str)text [, (int)checked=0]) -> None :

    C++ signature :
        void enable_checkbox(class CPSJMessageBox {lvalue},class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > [,int=0])
```

## pyjdg.PSJMessageBox.ischecked

```text
pyjdg.PSJMessageBox.ischecked


ischecked( (PSJMessageBox)arg1) -> int :

    C++ signature :
        int ischecked(class CPSJMessageBox {lvalue})
```

## pyjdg.PSJMessageBox.set_buttons

```text
pyjdg.PSJMessageBox.set_buttons


set_buttons( (PSJMessageBox)arg1, (msgbox_buttons)button_type) -> None :

    C++ signature :
        void set_buttons(class CPSJMessageBox {lvalue},enum PSJMSGBOX_BUTTONS_TYPE)
```

## pyjdg.PSJMessageBox.set_caption

```text
pyjdg.PSJMessageBox.set_caption


set_caption( (PSJMessageBox)arg1, (str)text) -> None :

    C++ signature :
        void set_caption(class CPSJMessageBox {lvalue},class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.PSJMessageBox.set_header

```text
pyjdg.PSJMessageBox.set_header


set_header( (PSJMessageBox)arg1, (str)text) -> None :

    C++ signature :
        void set_header(class CPSJMessageBox {lvalue},class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.PSJMessageBox.set_icon

```text
pyjdg.PSJMessageBox.set_icon


set_icon( (PSJMessageBox)arg1, (msgbox_icon)icon_type [, (str)path='']) -> None :

    C++ signature :
        void set_icon(class CPSJMessageBox {lvalue},enum PSJMSGBOX_ICON_TYPE [,class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >=''])
```

## pyjdg.PSJMessageBox.set_message

```text
pyjdg.PSJMessageBox.set_message


set_message( (PSJMessageBox)arg1, (str)text) -> None :

    C++ signature :
        void set_message(class CPSJMessageBox {lvalue},class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> >)
```

## pyjdg.PSJMessageBox.show

```text
pyjdg.PSJMessageBox.show


show( (PSJMessageBox)arg1) -> str :

    C++ signature :
        class std::basic_string<wchar_t,struct std::char_traits<wchar_t>,class std::allocator<wchar_t> > show(class CPSJMessageBox {lvalue})
```

## pyjdg.StartThread

```text
pyjdg.StartThread


StartThread( (object)arg1, (tuple)arg2) -> ThreadId :

    C++ signature :
        struct HandleW StartThread(class boost::python::api::object,class boost::python::tuple)
```

## pyjdg.TableCellID

```text
pyjdg.TableCellID


```

## pyjdg.TableCellID.is_col

```text
pyjdg.TableCellID.is_col


is_col( (TableCellID)arg1) -> int :

    C++ signature :
        int is_col(class CBCGPGridItemID {lvalue})
```

## pyjdg.TableCellID.is_null

```text
pyjdg.TableCellID.is_null


is_null( (TableCellID)arg1) -> int :

    C++ signature :
        int is_null(class CBCGPGridItemID {lvalue})
```

## pyjdg.TableCellID.is_row

```text
pyjdg.TableCellID.is_row


is_row( (TableCellID)arg1) -> int :

    C++ signature :
        int is_row(class CBCGPGridItemID {lvalue})
```

## pyjdg.TableCellRange

```text
pyjdg.TableCellRange


```

## pyjdg.TableCellRange.count

```text
pyjdg.TableCellRange.count


count( (TableCellRange)arg1) -> int :

    C++ signature :
        int count(class CBCGPGridRange {lvalue})
```

## pyjdg.TableCellRange.is_empty

```text
pyjdg.TableCellRange.is_empty


is_empty( (TableCellRange)arg1) -> int :

    C++ signature :
        int is_empty(class CBCGPGridRange {lvalue})
```

## pyjdg.TableCellRange.is_valid

```text
pyjdg.TableCellRange.is_valid


is_valid( (TableCellRange)arg1) -> int :

    C++ signature :
        int is_valid(class CBCGPGridRange {lvalue})
```

## pyjdg.TableCellRangeVector

```text
pyjdg.TableCellRangeVector


```

## pyjdg.TableCellRangeVector.append

```text
pyjdg.TableCellRangeVector.append


append( (TableCellRangeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class CBCGPGridRange,class std::allocator<class CBCGPGridRange> > {lvalue},class boost::python::api::object)
```

## pyjdg.TableCellRangeVector.clear

```text
pyjdg.TableCellRangeVector.clear


clear( (TableCellRangeVector)arg1) -> None :

    C++ signature :
        void clear(class std::vector<class CBCGPGridRange,class std::allocator<class CBCGPGridRange> > {lvalue})
```

## pyjdg.TableCellRangeVector.extend

```text
pyjdg.TableCellRangeVector.extend


extend( (TableCellRangeVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class CBCGPGridRange,class std::allocator<class CBCGPGridRange> > {lvalue},class boost::python::api::object)
```

## pyjdg.TableCellRangeVector.size

```text
pyjdg.TableCellRangeVector.size


size( (TableCellRangeVector)arg1) -> int :

    C++ signature :
        unsigned __int64 size(class std::vector<class CBCGPGridRange,class std::allocator<class CBCGPGridRange> > {lvalue})
```

## pyjdg.TableCellVector

```text
pyjdg.TableCellVector


```

## pyjdg.TableCellVector.append

```text
pyjdg.TableCellVector.append


append( (TableCellVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class CBCGPGridItemID,class std::allocator<class CBCGPGridItemID> > {lvalue},class boost::python::api::object)
```

## pyjdg.TableCellVector.clear

```text
pyjdg.TableCellVector.clear


clear( (TableCellVector)arg1) -> None :

    C++ signature :
        void clear(class std::vector<class CBCGPGridItemID,class std::allocator<class CBCGPGridItemID> > {lvalue})
```

## pyjdg.TableCellVector.extend

```text
pyjdg.TableCellVector.extend


extend( (TableCellVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class CBCGPGridItemID,class std::allocator<class CBCGPGridItemID> > {lvalue},class boost::python::api::object)
```

## pyjdg.TableCellVector.size

```text
pyjdg.TableCellVector.size


size( (TableCellVector)arg1) -> int :

    C++ signature :
        unsigned __int64 size(class std::vector<class CBCGPGridItemID,class std::allocator<class CBCGPGridItemID> > {lvalue})
```

## pyjdg.TableColumnInfo

```text
pyjdg.TableColumnInfo


```

## pyjdg.TableColumnInfoVector

```text
pyjdg.TableColumnInfoVector


```

## pyjdg.TableColumnInfoVector.add

```text
pyjdg.TableColumnInfoVector.add


add( (TableColumnInfoVector)arg1, (TableColumnInfo)arg2) -> None :

    C++ signature :
        void add(class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> > {lvalue},class CJPTTableColumnInfoW)
```

## pyjdg.TableColumnInfoVector.append

```text
pyjdg.TableColumnInfoVector.append


append( (TableColumnInfoVector)arg1, (object)arg2) -> None :

    C++ signature :
        void append(class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> > {lvalue},class boost::python::api::object)
```

## pyjdg.TableColumnInfoVector.clear

```text
pyjdg.TableColumnInfoVector.clear


clear( (TableColumnInfoVector)arg1) -> None :

    C++ signature :
        void clear(class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> > {lvalue})
```

## pyjdg.TableColumnInfoVector.extend

```text
pyjdg.TableColumnInfoVector.extend


extend( (TableColumnInfoVector)arg1, (object)arg2) -> None :

    C++ signature :
        void extend(class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> > {lvalue},class boost::python::api::object)
```

## pyjdg.TableColumnInfoVector.size

```text
pyjdg.TableColumnInfoVector.size


size( (TableColumnInfoVector)arg1) -> int :

    C++ signature :
        unsigned __int64 size(class std::vector<class CJPTTableColumnInfoW,class std::allocator<class CJPTTableColumnInfoW> > {lvalue})
```

## pyjdg.ThreadId

```text
pyjdg.ThreadId


```

## pyjdg.bold_type

```text
pyjdg.bold_type


```

## pyjdg.bold_type.from_bytes

```text
pyjdg.bold_type.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## pyjdg.msgbox_buttons

```text
pyjdg.msgbox_buttons


```

## pyjdg.msgbox_buttons.from_bytes

```text
pyjdg.msgbox_buttons.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## pyjdg.msgbox_icon

```text
pyjdg.msgbox_icon


```

## pyjdg.msgbox_icon.from_bytes

```text
pyjdg.msgbox_icon.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## pyjdg.msgbox_position

```text
pyjdg.msgbox_position


```

## pyjdg.msgbox_position.from_bytes

```text
pyjdg.msgbox_position.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## pyjdg.open_file

```text
pyjdg.open_file


open_file() -> str :

    C++ signature :
        class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > open_file()
```

## pyjdg.open_folder

```text
pyjdg.open_folder


open_folder() -> str :

    C++ signature :
        class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > open_folder()
```

## pyjdg.orientation

```text
pyjdg.orientation


```

## pyjdg.orientation.from_bytes

```text
pyjdg.orientation.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## pyjdg.size_behavior

```text
pyjdg.size_behavior


```

## pyjdg.size_behavior.from_bytes

```text
pyjdg.size_behavior.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## pyjdg.spin

```text
pyjdg.spin


```

## pyjdg.spin.from_bytes

```text
pyjdg.spin.from_bytes(bytes, byteorder, *, signed=False)

Return the integer represented by the given array of bytes.

  bytes
    Holds the array of bytes to convert.  The argument must either
    support the buffer protocol or be an iterable object producing bytes.
    Bytes and bytearray are examples of built-in objects that support the
    buffer protocol.
  byteorder
    The byte order used to represent the integer.  If byteorder is 'big',
    the most significant byte is at the beginning of the byte array.  If
    byteorder is 'little', the most significant byte is at the end of the
    byte array.  To request the native byte order of the host system, use
    `sys.byteorder' as the byte order value.
  signed
    Indicates whether two's complement is used to represent the integer.
```

## ACModeling.ABAQUS_DYNAMIC

```text
ACModeling.ABAQUS_DYNAMIC(strName='', strDescription='', bAutomatic=True, iMaxInc=0, iInitialSize=0, iMinSize=0.0, iMaxSize=0.0, iSuppressHalfRescal=0, dHalfStepResTol=1.7976931348623157e+308, iMethod=0, iMatrixStorage=0, iSolutionTechnique=0, iAllowedIters=0, iAdjustFactor=0, iMaxContactIter=0, dDampingControl=1.7976931348623157e+308, iPassCalInitialAcceleration=0, INlgeom=1, dTimePeriod=1.7976931348623157e+308, iIncludeHeatEffect=0, iConvertDscntIter=0, iRamp=0, iAcceptByMaxIters=0, outputRequestParams=[])


```

## ACModeling.ABAQUS_DYNAMIC.fromList

```text
ACModeling.ABAQUS_DYNAMIC.fromList(self, param)


```

## ACModeling.ABAQUS_DYNAMIC.isDefault

```text
ACModeling.ABAQUS_DYNAMIC.isDefault(self)


```

## ACModeling.ABAQUS_DYNAMIC.toNativeStr

```text
ACModeling.ABAQUS_DYNAMIC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ABAQUS_LBC_STEP_INFO

```text
ACModeling.ABAQUS_LBC_STEP_INFO(crStep=None, crLbc=None, iCurflag=0, iPreflag=0)


```

## ACModeling.ABAQUS_LBC_STEP_INFO.fromList

```text
ACModeling.ABAQUS_LBC_STEP_INFO.fromList(self, param)


```

## ACModeling.ABAQUS_LBC_STEP_INFO.isDefault

```text
ACModeling.ABAQUS_LBC_STEP_INFO.isDefault(self)


```

## ACModeling.ABAQUS_LBC_STEP_INFO.toNativeStr

```text
ACModeling.ABAQUS_LBC_STEP_INFO.toNativeStr(self, isOneParam=True)


```

## ACModeling.ABAQUS_OUTPUT_REQUEST

```text
ACModeling.ABAQUS_OUTPUT_REQUEST(strName='', strDescription='', iId=0, iOutputFiletype=0, iDomainType=0, iDomainId=0, iFrequencyType=0, dFrequency=0.0, ParamTimePoint=TIME_POINTS(), iTiming=0, strlOutputVariables=[])


```

## ACModeling.ABAQUS_OUTPUT_REQUEST.fromList

```text
ACModeling.ABAQUS_OUTPUT_REQUEST.fromList(self, param)


```

## ACModeling.ABAQUS_OUTPUT_REQUEST.isDefault

```text
ACModeling.ABAQUS_OUTPUT_REQUEST.isDefault(self)


```

## ACModeling.ABAQUS_OUTPUT_REQUEST.toNativeStr

```text
ACModeling.ABAQUS_OUTPUT_REQUEST.toNativeStr(self, isOneParam=True)


```

## ACModeling.ABAQUS_PAIR

```text
ACModeling.ABAQUS_PAIR(iEnableChecked=0, dlTList=[])


```

## ACModeling.ABAQUS_PAIR.fromList

```text
ACModeling.ABAQUS_PAIR.fromList(self, param)


```

## ACModeling.ABAQUS_PAIR.isDefault

```text
ACModeling.ABAQUS_PAIR.isDefault(self)


```

## ACModeling.ABAQUS_PAIR.toNativeStr

```text
ACModeling.ABAQUS_PAIR.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ACTRAN_ANALYSIS

```text
ACModeling.ACBoundary.ACTRAN_ANALYSIS(strName='Job_1', strDescription='', iExeType=0, iAnaType=0, strEdatFile='', strAcousticFileName='', iNfSpaceType=0, iPML2DElemPID=0, iPML3DElemPID=0, iIFEM2DElemPID=0, iOrder=2147483647, dlOrigin=[0.0, 0.0, 0.0], dlXAxis=[1.0, 0.0, 0.0], dlYAxis=[0.0, 1.0, 0.0], dlZAxis=[0.0, 0.0, 1.0], strReflection='NOSYM, NOSYM, NOSYM', iProjectionSurface2DElemPID=0, dGapTol=0.01, dPlaneTol=0.0001, iFiniteDomain3DElemPID=0, iMatId=0, dAcousticSpeed=1.7976931348623157e+308, dFluidDensity=1.7976931348623157e+308, strStructuralModelBdfFile='', strStructuralModelOp2File='', strSubcase='1', iStateValue=1, iNumOfPanel=0, iSummationID=0, strStructuralModelPCHFile='', iLowerMode=2147483647, iUpperMode=2147483647, iSubcaseStart=2147483647, iSubcaseStop=2147483647, iStartRPM=2147483647, iIncrementRPM=2147483647, iFdmethod=0, dStartf=1.7976931348623157e+308, dEndf=1.7976931348623157e+308, dIncrtf=1.7976931348623157e+308, iSolver=0, strGreenDBFile='Green_db', strPltfile='AUTO', bUseMapFile=False, iFormat=1, strMapFile='AUTO', iMethod=0, iNodeGroupID=0, tshTable=[], listActranDomain=[], iJobType=0, iInfiniteSpaceType=0, strInputFile1='', strInputFile2='', iMemory=500, iThreads=2147483647)


```

## ACModeling.ACBoundary.ACTRAN_ANALYSIS.fromList

```text
ACModeling.ACBoundary.ACTRAN_ANALYSIS.fromList(self, listActranDomain)


```

## ACModeling.ACBoundary.ACTRAN_ANALYSIS.isDefault

```text
ACModeling.ACBoundary.ACTRAN_ANALYSIS.isDefault(self)


```

## ACModeling.ACBoundary.ACTRAN_ANALYSIS.toNativeStr

```text
ACModeling.ACBoundary.ACTRAN_ANALYSIS.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ACTRAN_DOMAIN

```text
ACModeling.ACBoundary.ACTRAN_DOMAIN(iElemPID=0, strName='', strBdf='')


```

## ACModeling.ACBoundary.ACTRAN_DOMAIN.fromList

```text
ACModeling.ACBoundary.ACTRAN_DOMAIN.fromList(self, param)


```

## ACModeling.ACBoundary.ACTRAN_DOMAIN.isDefault

```text
ACModeling.ACBoundary.ACTRAN_DOMAIN.isDefault(self)


```

## ACModeling.ACBoundary.ACTRAN_DOMAIN.toNativeStr

```text
ACModeling.ACBoundary.ACTRAN_DOMAIN.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC2PostJob

```text
ACModeling.ACBoundary.ADVC2PostJob(*ids)


```

## ACModeling.ACBoundary.ADVCJob

```text
ACModeling.ACBoundary.ADVCJob(*ids)


```

## ACModeling.ACBoundary.ADVCProcess

```text
ACModeling.ACBoundary.ADVCProcess(*ids)


```

## ACModeling.ACBoundary.ADVCProcessCreep

```text
ACModeling.ACBoundary.ADVCProcessCreep(*ids)


```

## ACModeling.ACBoundary.ADVCProcessDynamic

```text
ACModeling.ACBoundary.ADVCProcessDynamic(*ids)


```

## ACModeling.ACBoundary.ADVCProcessDynamicExplicit

```text
ACModeling.ACBoundary.ADVCProcessDynamicExplicit(*ids)


```

## ACModeling.ACBoundary.ADVCProcessEigen

```text
ACModeling.ACBoundary.ADVCProcessEigen(*ids)


```

## ACModeling.ACBoundary.ADVCProcessFatigue

```text
ACModeling.ACBoundary.ADVCProcessFatigue(*ids)


```

## ACModeling.ACBoundary.ADVCProcessModalFreqResp

```text
ACModeling.ACBoundary.ADVCProcessModalFreqResp(*ids)


```

## ACModeling.ACBoundary.ADVCProcessRandResp

```text
ACModeling.ACBoundary.ADVCProcessRandResp(*ids)


```

## ACModeling.ACBoundary.ADVCProcessRespSpec

```text
ACModeling.ACBoundary.ADVCProcessRespSpec(*ids)


```

## ACModeling.ACBoundary.ADVCProcessSSH

```text
ACModeling.ACBoundary.ADVCProcessSSH(*ids)


```

## ACModeling.ACBoundary.ADVCProcessStatic

```text
ACModeling.ACBoundary.ADVCProcessStatic(*ids)


```

## ACModeling.ACBoundary.ADVCProcessTH

```text
ACModeling.ACBoundary.ADVCProcessTH(*ids)


```

## ACModeling.ACBoundary.ADVC_AUTO_INCREMENT

```text
ACModeling.ACBoundary.ADVC_AUTO_INCREMENT(iNewtonResidueIncrMax=2147483647, iBeginResidueIncrCheck=2147483647, iBeginLogarithmicRateCheck=2147483647, dCutBackFactorForDivergence=1.7976931348623157e+308, dCutBackFactorForTooSlowConvergence=1.7976931348623157e+308, dCutBackFactorForExcessiveDistortion=1.7976931348623157e+308, iIncrEnlargeNewtonMax=2147483647, iIncrEnlargeSuppress=2147483647, dIncreaseFactorForStatic=1.7976931348623157e+308, dIncreaseFactorForDynamic=1.7976931348623157e+308, dIncreaseFactorForCreep=1.7976931348623157e+308, dIncreaseFactorForRdnlk=1.7976931348623157e+308, dTemperatureIncrMax=1.7976931348623157e+308, iUseTemperatureIncrMax=0, dHalfStepTol=1.7976931348623157e+308, dStraTol=1.7976931348623157e+308, dCreepStraTol=1.7976931348623157e+308, dRdnlkStraTol=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ADVC_AUTO_INCREMENT.fromList

```text
ACModeling.ACBoundary.ADVC_AUTO_INCREMENT.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_AUTO_INCREMENT.isDefault

```text
ACModeling.ACBoundary.ADVC_AUTO_INCREMENT.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_AUTO_INCREMENT.toNativeStr

```text
ACModeling.ACBoundary.ADVC_AUTO_INCREMENT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_CONTACT_ITER

```text
ACModeling.ACBoundary.ADVC_CONTACT_ITER(iSubdivideMode=-1, iContactloopMax=2147483647, iInternalContactloopMax=2147483647, dSeparationTol=1.7976931348623157e+308, dRelativeSeparationTol=1.7976931348623157e+308, dPenetrationTol=1.7976931348623157e+308, dRelativePenetrationTol=1.7976931348623157e+308, iMaxchp=2147483647, iFrictionOnset=0, dStickSlipTol=1.7976931348623157e+308, dFrictionTol=1.7976931348623157e+308, iEstimateImpactTime=0)


```

## ACModeling.ACBoundary.ADVC_CONTACT_ITER.fromList

```text
ACModeling.ACBoundary.ADVC_CONTACT_ITER.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_CONTACT_ITER.isDefault

```text
ACModeling.ACBoundary.ADVC_CONTACT_ITER.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_CONTACT_ITER.toNativeStr

```text
ACModeling.ACBoundary.ADVC_CONTACT_ITER.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_CONVERGENCE

```text
ACModeling.ACBoundary.ADVC_CONVERGENCE(dCgTol=1.7976931348623157e+308, dCgNrTol=1.7976931348623157e+308, dCgDispTol=1.7976931348623157e+308, dCgNrDispTol=1.7976931348623157e+308, dCgDispLimitTol=1.7976931348623157e+308, dCgTotalDispLimitTol=1.7976931348623157e+308, dNewtonTol=1.7976931348623157e+308, dNewtonDispTol=1.7976931348623157e+308, dNewtonDispLimitTol=1.7976931348623157e+308, dNewtonTotalDispLimitTol=1.7976931348623157e+308, iCgloopMax=2147483647, iNewtonMax=2147483647, dHtNlLoopTol=1.7976931348623157e+308, iHtNlLoopMax=2147483647)


```

## ACModeling.ACBoundary.ADVC_CONVERGENCE.fromList

```text
ACModeling.ACBoundary.ADVC_CONVERGENCE.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_CONVERGENCE.isDefault

```text
ACModeling.ACBoundary.ADVC_CONVERGENCE.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_CONVERGENCE.toNativeStr

```text
ACModeling.ACBoundary.ADVC_CONVERGENCE.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_DYNAMIC

```text
ACModeling.ACBoundary.ADVC_DYNAMIC(dAlpha=1.7976931348623157e+308, dBeta=1.7976931348623157e+308, dGamma=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ADVC_DYNAMIC.fromList

```text
ACModeling.ACBoundary.ADVC_DYNAMIC.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_DYNAMIC.isDefault

```text
ACModeling.ACBoundary.ADVC_DYNAMIC.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_DYNAMIC.toNativeStr

```text
ACModeling.ACBoundary.ADVC_DYNAMIC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC

```text
ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC(iLogMessageInterval=2147483647, iLinearApproximation=-1, dBulkViscosityCoef1=1.7976931348623157e+308, dBulkViscosityCoef2=1.7976931348623157e+308, dMassScalingdt=1.7976931348623157e+308, dDtScaleFactor=1.7976931348623157e+308, dPenaltyScaleFactor=1.7976931348623157e+308, iContactSearchInterval=2147483647)


```

## ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC.fromList

```text
ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC.isDefault

```text
ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC.toNativeStr

```text
ACModeling.ACBoundary.ADVC_EXPLICIT_DYNAMIC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP

```text
ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP(iEndType=1, dMaxTime=1, iFixedAuto=0, dMaxChange=1.7976931348623157e+308, dInitdt=1.7976931348623157e+308, iDefineMaxdt=0, dMaxdt=1.7976931348623157e+308, iDefineMindt=0, dMindt=1.7976931348623157e+308, dFixeddt=1.7976931348623157e+308, iOutputLast=-1, iOutputInterval=2147483647, iRestartLast=-1, iRestartInterval=2147483647, dOutputTimeInterval=1.7976931348623157e+308, dRestartTimeInterval=1.7976931348623157e+308, iOutputInit=-1, iListOutputInterval=2147483647)


```

## ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP.fromList

```text
ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP.isDefault

```text
ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP.toNativeStr

```text
ACModeling.ACBoundary.ADVC_HEAT_TIME_STEP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_LOAD_NODE

```text
ACModeling.ACBoundary.ADVC_LOAD_NODE(cr=None, crModify=None, flag=1, shrink=False, interference=1.7976931348623157e+308, stabilized=0, residual_factor=1.7976931348623157e+308, effective_dist=1.7976931348623157e+308, type_=0, cn=1.7976931348623157e+308, ct=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ADVC_LOAD_NODE.fromList

```text
ACModeling.ACBoundary.ADVC_LOAD_NODE.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_LOAD_NODE.isContactLoadNode

```text
ACModeling.ACBoundary.ADVC_LOAD_NODE.isContactLoadNode(self)


```

## ACModeling.ACBoundary.ADVC_LOAD_NODE.isDefault

```text
ACModeling.ACBoundary.ADVC_LOAD_NODE.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_LOAD_NODE.toNativeStr

```text
ACModeling.ACBoundary.ADVC_LOAD_NODE.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_NORMAL_MODAL

```text
ACModeling.ACBoundary.ADVC_NORMAL_MODAL(iNumberModes=2, iEigenNormalizationMethod=-1, dShift=1.7976931348623157e+308, dCGCGPITolerance=1.7976931348623157e+308, dCGCGPIEigenTolerance=1.7976931348623157e+308, iCGCGPILoopMax=2147483647, dCGCGPIInnerTolerance=1.7976931348623157e+308, iCGCGPIBlockSize=2147483647, iCGCGPIExtraMode=2147483647, iEigenSolver=0, iIfFrequencyRange=0, dMaxFrequency=1.7976931348623157e+308, dMinFrequency=1.7976931348623157e+308, iMaxNumEigenValuesOnInterval=2147483647, iOutputInit=-1, dOutputLowerLimitFrequency=1.7976931348623157e+308, iOutputParticipationFactor=-1, strRotationCenterCoordinate='', dLanczosTol=1.7976931348623157e+308, dImplicitRestartTol=1.7976931348623157e+308, iImplicitRestartLoopMax=2147483647)


```

## ACModeling.ACBoundary.ADVC_NORMAL_MODAL.fromList

```text
ACModeling.ACBoundary.ADVC_NORMAL_MODAL.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_NORMAL_MODAL.isDefault

```text
ACModeling.ACBoundary.ADVC_NORMAL_MODAL.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_NORMAL_MODAL.toNativeStr

```text
ACModeling.ACBoundary.ADVC_NORMAL_MODAL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT

```text
ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT(proc=2147483647, step=2147483647, factor=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT.fromList

```text
ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT.isDefault

```text
ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT.toNativeStr

```text
ACModeling.ACBoundary.ADVC_REFERENCE_STRESS_RESULT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT

```text
ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT(iProc=2147483647, iStep=2147483647, dFactor=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT.fromList

```text
ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT.isDefault

```text
ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT.toNativeStr

```text
ACModeling.ACBoundary.ADVC_REF_STRESS_RESULT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP

```text
ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP(iFixedOrAuto=0, iNumOfInc=1, dMaxTime=1.0, dMaxDt=1.7976931348623157e+308, dMinDt=1.7976931348623157e+308, iLoadType=-1, iOutputLast=-1, iOutputInterval=2147483647, iRestartLast=-1, iRestartInterval=2147483647, dOutputTimeInterval=1.7976931348623157e+308, dRestartTimeInterval=1.7976931348623157e+308, dInitDt=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP.fromList

```text
ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP.fromList(self, param)


```

## ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP.isDefault

```text
ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP.isDefault(self)


```

## ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP.toNativeStr

```text
ACModeling.ACBoundary.ADVC_STRUCT_TIME_STEP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ANSYS_CONTACT

```text
ACModeling.ACBoundary.ANSYS_CONTACT(dFricCoef=1.7976931348623157e+308, dPenaStiffness=1.7976931348623157e+308, dPetrTolerance=1.7976931348623157e+308, iStiffUpdate=2, iAlgorithm=2, iDetec=2, iBehavior=5, iIniPenetr=0)


```

## ACModeling.ACBoundary.ANSYS_CONTACT.fromList

```text
ACModeling.ACBoundary.ANSYS_CONTACT.fromList(self, param)


```

## ACModeling.ACBoundary.ANSYS_CONTACT.isDefault

```text
ACModeling.ACBoundary.ANSYS_CONTACT.isDefault(self)


```

## ACModeling.ACBoundary.ANSYS_CONTACT.toNativeStr

```text
ACModeling.ACBoundary.ANSYS_CONTACT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ANSYS_SETTING

```text
ACModeling.ACBoundary.ANSYS_SETTING(iAnalysisType=0, iSolverType=0, strJobName='Job1', strJobDescription='', basicData=BASIC(), transientData=TRANSIENT(), dStartFreq=1.7976931348623157e+308, dEndFreq=1.7976931348623157e+308, iModeShape=0, modalData=MODAL(), subSpaceData=SUBSPACE(), reducedData=REDUCED(), sSData=STEADY_STATIC(), fullTransData=FULLTRANS(), harmonicData=HARMONIC(), iLoadCaseId=0, bWriteResultDB=False, bRunAPDL=False, bOutputSOLVE=False, strCommandLineOption='', strAnsysVersion='')


```

## ACModeling.ACBoundary.ANSYS_SETTING.fromList

```text
ACModeling.ACBoundary.ANSYS_SETTING.fromList(self, param)


```

## ACModeling.ACBoundary.ANSYS_SETTING.isDefault

```text
ACModeling.ACBoundary.ANSYS_SETTING.isDefault(self)


```

## ACModeling.ACBoundary.ANSYS_SETTING.toNativeStr

```text
ACModeling.ACBoundary.ANSYS_SETTING.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.AbaqSteps

```text
ACModeling.ACBoundary.AbaqSteps(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStruct

```text
ACModeling.ACBoundary.AbaqStepsStruct(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructCoupledTD

```text
ACModeling.ACBoundary.AbaqStepsStructCoupledTD(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructDynamic

```text
ACModeling.ACBoundary.AbaqStepsStructDynamic(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructDynamicCoupledTD

```text
ACModeling.ACBoundary.AbaqStepsStructDynamicCoupledTD(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructDynamicExplicit

```text
ACModeling.ACBoundary.AbaqStepsStructDynamicExplicit(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructFrequency

```text
ACModeling.ACBoundary.AbaqStepsStructFrequency(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructStatic

```text
ACModeling.ACBoundary.AbaqStepsStructStatic(*ids)


```

## ACModeling.ACBoundary.AbaqStepsStructStaticRisk

```text
ACModeling.ACBoundary.AbaqStepsStructStaticRisk(*ids)


```

## ACModeling.ACBoundary.AbaqStepsThermal

```text
ACModeling.ACBoundary.AbaqStepsThermal(*ids)


```

## ACModeling.ACBoundary.AbaqStepsThermalSS

```text
ACModeling.ACBoundary.AbaqStepsThermalSS(*ids)


```

## ACModeling.ACBoundary.AbaqStepsThermalTransient

```text
ACModeling.ACBoundary.AbaqStepsThermalTransient(*ids)


```

## ACModeling.ACBoundary.AbaqusJob

```text
ACModeling.ACBoundary.AbaqusJob(*ids)


```

## ACModeling.ACBoundary.ActranJob

```text
ACModeling.ACBoundary.ActranJob(*ids)


```

## ACModeling.ACBoundary.AnsysJob

```text
ACModeling.ACBoundary.AnsysJob(*ids)


```

## ACModeling.ACBoundary.AttributeFXWeld

```text
ACModeling.ACBoundary.AttributeFXWeld(*ids)


```

## ACModeling.ACBoundary.AttributePSBlendSurface

```text
ACModeling.ACBoundary.AttributePSBlendSurface(*ids)


```

## ACModeling.ACBoundary.BALL_HEXA_SETTING

```text
ACModeling.ACBoundary.BALL_HEXA_SETTING(vecCenter=[0.0, 0.0, 0.0], dRadius=0.0, dMeshSize=0.0, iType=0, iLayer=0, bMakeCenterNode=True, strPartName='')


```

## ACModeling.ACBoundary.BALL_HEXA_SETTING.fromList

```text
ACModeling.ACBoundary.BALL_HEXA_SETTING.fromList(self, param)


```

## ACModeling.ACBoundary.BALL_HEXA_SETTING.isDefault

```text
ACModeling.ACBoundary.BALL_HEXA_SETTING.isDefault(self)


```

## ACModeling.ACBoundary.BALL_HEXA_SETTING.toNativeStr

```text
ACModeling.ACBoundary.BALL_HEXA_SETTING.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.BASIC

```text
ACModeling.ACBoundary.BASIC(bBasicOutputDisplacements=False, bOutputReactionLoad=False, bBasicOutputStrain=False, bBasicOutputStress=False, iAnalysisOption=0, bCalculatePrestressEffect=False, dUniformTemperature=0.0, dReferenceTemperature=0.0, dEndLoadTime=0.0, iTimeStep=0, iStepChosen=0, iSubStepNum=0, iMaxSubStep=0, iMinStepNum=0, dTimeStepSize=0.0, dMinTimeStep=0.0, dMaxTimeStep=0.0, iWriteResultFre=1, iNumber=1)


```

## ACModeling.ACBoundary.BASIC.fromList

```text
ACModeling.ACBoundary.BASIC.fromList(self, param)


```

## ACModeling.ACBoundary.BASIC.isDefault

```text
ACModeling.ACBoundary.BASIC.isDefault(self)


```

## ACModeling.ACBoundary.BASIC.toNativeStr

```text
ACModeling.ACBoundary.BASIC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.BEAM_1D_PROP

```text
ACModeling.ACBoundary.BEAM_1D_PROP(crMat=None, dArea=1.7976931348623157e+308, iOrientType=2147483647, vecOrient=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], iOrientNodeId=2147483647, vecInertia=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], dTorConst=1.7976931348623157e+308, dNSM=1.7976931348623157e+308, dlDnsmAB=[1.7976931348623157e+308, 1.7976931348623157e+308], listDnsmNode=[[1.7976931348623157e+308, 1.7976931348623157e+308], [1.7976931348623157e+308, 1.7976931348623157e+308]], dlShearStiffness=[1.7976931348623157e+308, 1.7976931348623157e+308], dlShearAreaRelief=[1.7976931348623157e+308, 1.7976931348623157e+308], dlWrapCoeff=[1.7976931348623157e+308, 1.7976931348623157e+308], listNA=[[1.7976931348623157e+308, 1.7976931348623157e+308], [1.7976931348623157e+308, 1.7976931348623157e+308]], dlStressRecoveryCoeff=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], bTapped=False, dTapDarea=1.7976931348623157e+308, vecTapInertia=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], dTapDtorconst=1.7976931348623157e+308, dTapDnsm=1.7976931348623157e+308, dlTapStressrecoverycoeff=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], iIntePtNum=2147483647, blPinA=[False, False, False, False, False, False], blPinB=[False, False, False, False, False, False], veclOffset=[[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], [1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308]])


```

## ACModeling.ACBoundary.BEAM_1D_PROP.fromList

```text
ACModeling.ACBoundary.BEAM_1D_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.BEAM_1D_PROP.isDefault

```text
ACModeling.ACBoundary.BEAM_1D_PROP.isDefault(self)


```

## ACModeling.ACBoundary.BEAM_1D_PROP.toNativeStr

```text
ACModeling.ACBoundary.BEAM_1D_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.BeamPropAttr

```text
ACModeling.ACBoundary.BeamPropAttr(*ids)


```

## ACModeling.ACBoundary.BeamPropAttr2

```text
ACModeling.ACBoundary.BeamPropAttr2(*ids)


```

## ACModeling.ACBoundary.BodyLink

```text
ACModeling.ACBoundary.BodyLink(*ids)


```

## ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA

```text
ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA(chord_height_tolerance=1.0, angle_tolerance_degree=5.0, convert_isolated_curve=0, iges_fixedCurevePreference=0, iges_autoStitch=1, iges_stitchTolerance=0.1, catia_convertNotShowedElement=0, catia_convertNotShowedInstance=0, catia_convertAxis=1, step_createSeam=1, step_pointTolerance=0.0, acis_healAcisBeforeVersion=0, jt_convertGeometryType=2, jt_convertGeneralBody=1, jt_convertAxis=1, jt_convertCenterLine=0, dek_cleanSelfIntersectingLoop=2, point_coincident_tolerance=0.01, dek_volumeToBody=4)


```

## ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.fromList

```text
ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.fromList(self, cadElysiumParamData)


```

## ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.isDefault

```text
ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.isDefault(self)


```

## ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.toNativeStr

```text
ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.toNativeStrSpecial

```text
ACModeling.ACBoundary.CAD_ELYSIUM_PARAM_DATA.toNativeStrSpecial(self, isOneParam=True, bSetFaceColor=True)


```

## ACModeling.ACBoundary.CAD_PROE_PARAM_DATA

```text
ACModeling.ACBoundary.CAD_PROE_PARAM_DATA(dChordHeightTolerance=0.0, dAngleToleranceDegree=20.0, dStepMaxSize=0.1)


```

## ACModeling.ACBoundary.CAD_PROE_PARAM_DATA.fromList

```text
ACModeling.ACBoundary.CAD_PROE_PARAM_DATA.fromList(self, cadProeParamData)


```

## ACModeling.ACBoundary.CAD_PROE_PARAM_DATA.isDefault

```text
ACModeling.ACBoundary.CAD_PROE_PARAM_DATA.isDefault(self)


```

## ACModeling.ACBoundary.CAD_PROE_PARAM_DATA.toNativeStr

```text
ACModeling.ACBoundary.CAD_PROE_PARAM_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA

```text
ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA(dSurfacePlaneTolerance=0.0, dSufacePlaneAngle=20.0, dMaxFacetWidth=0.1, bNXMultipart=True, bHealing=True)


```

## ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA.fromList

```text
ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA.fromList(self, cadSpatialParamData)


```

## ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA.isDefault

```text
ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA.isDefault(self)


```

## ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA.toNativeStr

```text
ACModeling.ACBoundary.CAD_SPATIAL_PARAM_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.CMaterial

```text
ACModeling.ACBoundary.CMaterial(name, mat_id, db_id, mat_layers)


```

## ACModeling.ACBoundary.CMaterial.toStr

```text
ACModeling.ACBoundary.CMaterial.toStr(self, replace_str)


```

## ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP

```text
ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP(iPID=0, dZ0=0, dNSM=0, dSB=0, iFT=0, dTREF=0, dGE=0, iLAM=0, iMID=0, iSOUT=0, dZOFF=0, iMatOrientType=0, vecMatOrient=[0, 0, 0], crLocalCS=None)


```

## ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP.fromList

```text
ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP.isDefault

```text
ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP.isDefault(self)


```

## ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP.toNativeStr

```text
ACModeling.ACBoundary.COMPOSITE_2D_SHELL_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL

```text
ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL(iItemType=0, iKConn=0, iSolver=0, iStartID=0)


```

## ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL.fromList

```text
ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL.fromList(self, param)


```

## ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL.isDefault

```text
ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL.isDefault(self)


```

## ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL.toNativeStr

```text
ACModeling.ACBoundary.CONNECT_RENUMBER_TOOL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.CONTACT_DATA_TSSS

```text
ACModeling.ACBoundary.CONTACT_DATA_TSSS(strName='', crContact=None, stNastranParam=SUNSHINE_CONTACT(), Color=0, bDuplicated=False)


```

## ACModeling.ACBoundary.CONTACT_DATA_TSSS.fromList

```text
ACModeling.ACBoundary.CONTACT_DATA_TSSS.fromList(self, param)


```

## ACModeling.ACBoundary.CONTACT_DATA_TSSS.isDefault

```text
ACModeling.ACBoundary.CONTACT_DATA_TSSS.isDefault(self)


```

## ACModeling.ACBoundary.CONTACT_DATA_TSSS.toNativeStr

```text
ACModeling.ACBoundary.CONTACT_DATA_TSSS.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.CONTACT_TABLE_TARGET

```text
ACModeling.ACBoundary.CONTACT_TABLE_TARGET(crMasterGroup=None, crSlaveGroup=None, strMaster='', strSlave='', taFacesMaster=[], taFacesSlave=[])


```

## ACModeling.ACBoundary.CONTACT_TABLE_TARGET.fromList

```text
ACModeling.ACBoundary.CONTACT_TABLE_TARGET.fromList(self, param)


```

## ACModeling.ACBoundary.CONTACT_TABLE_TARGET.isDefault

```text
ACModeling.ACBoundary.CONTACT_TABLE_TARGET.isDefault(self)


```

## ACModeling.ACBoundary.CONTACT_TABLE_TARGET.toNativeStr

```text
ACModeling.ACBoundary.CONTACT_TABLE_TARGET.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ConnPropAttr

```text
ACModeling.ACBoundary.ConnPropAttr(*ids)


```

## ACModeling.ACBoundary.ConnectBush

```text
ACModeling.ACBoundary.ConnectBush(*ids)


```

## ACModeling.ACBoundary.ConnectConm

```text
ACModeling.ACBoundary.ConnectConm(*ids)


```

## ACModeling.ACBoundary.ConnectConnector

```text
ACModeling.ACBoundary.ConnectConnector(*ids)


```

## ACModeling.ACBoundary.ConnectDamper

```text
ACModeling.ACBoundary.ConnectDamper(*ids)


```

## ACModeling.ACBoundary.ConnectGap

```text
ACModeling.ACBoundary.ConnectGap(*ids)


```

## ACModeling.ACBoundary.ConnectMoment

```text
ACModeling.ACBoundary.ConnectMoment(*ids)


```

## ACModeling.ACBoundary.ConnectMpc

```text
ACModeling.ACBoundary.ConnectMpc(*ids)


```

## ACModeling.ACBoundary.ConnectProd

```text
ACModeling.ACBoundary.ConnectProd(*ids)


```

## ACModeling.ACBoundary.ConnectRbar

```text
ACModeling.ACBoundary.ConnectRbar(*ids)


```

## ACModeling.ACBoundary.ConnectRbe2

```text
ACModeling.ACBoundary.ConnectRbe2(*ids)


```

## ACModeling.ACBoundary.ConnectRbe3

```text
ACModeling.ACBoundary.ConnectRbe3(*ids)


```

## ACModeling.ACBoundary.ConnectSpring

```text
ACModeling.ACBoundary.ConnectSpring(*ids)


```

## ACModeling.ACBoundary.ConnectWeld

```text
ACModeling.ACBoundary.ConnectWeld(*ids)


```

## ACModeling.ACBoundary.ConnectionElement

```text
ACModeling.ACBoundary.ConnectionElement(*ids)


```

## ACModeling.ACBoundary.Contact

```text
ACModeling.ACBoundary.Contact(*ids)


```

## ACModeling.ACBoundary.ContactADVC

```text
ACModeling.ACBoundary.ContactADVC(*ids)


```

## ACModeling.ACBoundary.ContactAbaqus

```text
ACModeling.ACBoundary.ContactAbaqus(*ids)


```

## ACModeling.ACBoundary.ContactAnsys

```text
ACModeling.ACBoundary.ContactAnsys(*ids)


```

## ACModeling.ACBoundary.ContactMSCNastran

```text
ACModeling.ACBoundary.ContactMSCNastran(*ids)


```

## ACModeling.ACBoundary.ContactNXNastran

```text
ACModeling.ACBoundary.ContactNXNastran(*ids)


```

## ACModeling.ACBoundary.ContactTSSOlver

```text
ACModeling.ACBoundary.ContactTSSOlver(*ids)


```

## ACModeling.ACBoundary.ContactTSSS

```text
ACModeling.ACBoundary.ContactTSSS(*ids)


```

## ACModeling.ACBoundary.Coord

```text
ACModeling.ACBoundary.Coord(*ids)


```

## ACModeling.ACBoundary.CursorPair

```text
ACModeling.ACBoundary.CursorPair(first, second)


```

## ACModeling.ACBoundary.CursorPairStr

```text
ACModeling.ACBoundary.CursorPairStr(first, second)


```

## ACModeling.ACBoundary.CursorStr

```text
ACModeling.ACBoundary.CursorStr(typeId, ids)


```

## ACModeling.ACBoundary.CustomAttrDouble

```text
ACModeling.ACBoundary.CustomAttrDouble(*ids)


```

## ACModeling.ACBoundary.CustomAttrString

```text
ACModeling.ACBoundary.CustomAttrString(*ids)


```

## ACModeling.ACBoundary.CustomAttrVector

```text
ACModeling.ACBoundary.CustomAttrVector(*ids)


```

## ACModeling.ACBoundary.DCS

```text
ACModeling.ACBoundary.DCS(*ids)


```

## ACModeling.ACBoundary.DESIGNER_CONTACT

```text
ACModeling.ACBoundary.DESIGNER_CONTACT(iContactType=1, dInterferenceClosure=0.05, dFrictionCoefficient=0, iShellOffset=0, iMasterShellOrientation=0, iSlaveShellOrientation=0, iMarkerColor=65280, bInitialAdjustment=0)


```

## ACModeling.ACBoundary.DESIGNER_CONTACT.fromList

```text
ACModeling.ACBoundary.DESIGNER_CONTACT.fromList(self, param)


```

## ACModeling.ACBoundary.DESIGNER_CONTACT.isDefault

```text
ACModeling.ACBoundary.DESIGNER_CONTACT.isDefault(self)


```

## ACModeling.ACBoundary.DESIGNER_CONTACT.toNativeStr

```text
ACModeling.ACBoundary.DESIGNER_CONTACT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.DOFSET_LBC

```text
ACModeling.ACBoundary.DOFSET_LBC(iDwDof=0, crCurCoord=None, crTable=None)


```

## ACModeling.ACBoundary.DOFSET_LBC.fromList

```text
ACModeling.ACBoundary.DOFSET_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.DOFSET_LBC.isDefault

```text
ACModeling.ACBoundary.DOFSET_LBC.isDefault(self)


```

## ACModeling.ACBoundary.DOFSET_LBC.toNativeStr

```text
ACModeling.ACBoundary.DOFSET_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Density

```text
ACModeling.ACBoundary.Density(params, temperatureDependency=False)


```

## ACModeling.ACBoundary.Density.toStr

```text
ACModeling.ACBoundary.Density.toStr(self, replace_str)


```

## ACModeling.ACBoundary.DynamisJob

```text
ACModeling.ACBoundary.DynamisJob(*ids)


```

## ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL

```text
ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL(iMethod=0, iDispType=0, bDispXDir=0, bDispCoord=0, bDispZCoord=0, dDispScale=1, dDiverseFactor=0.755)


```

## ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL.fromList

```text
ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL.fromList(self, param)


```

## ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL.isDefault

```text
ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL.isDefault(self)


```

## ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL.toNativeStr

```text
ACModeling.ACBoundary.ELEM_COORSYSTEM_TOOL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC

```text
ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC(iDwDof=0, dFVel1=1.7976931348623157e+308, dFVel2=1.7976931348623157e+308, dFVel3=1.7976931348623157e+308, dFVel4=1.7976931348623157e+308, dFVel5=1.7976931348623157e+308, dFVel6=1.7976931348623157e+308, crCurCoord=None, iEnArrowDir=0, crTable=None, crNodeSet=None, dFPhase=1.7976931348623157e+308, dFDelay=1.7976931348623157e+308, crPhaseTable=None, bExport=False, crMEExport1=None, crMEExport2=None, crMEExport3=None, crMEExport4=None, crMEExport5=None, crMEExport6=None, iAcUnit=0, iRotUnit=0)


```

## ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC.fromList

```text
ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC.isDefault

```text
ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC.isDefault(self)


```

## ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC.toNativeStr

```text
ACModeling.ACBoundary.ENFORCED_ACCELERATION_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC

```text
ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC(iDwDof=0, dVelocityTX=1.7976931348623157e+308, dVelocityTY=1.7976931348623157e+308, dVelocityTZ=1.7976931348623157e+308, dVelocityRX=1.7976931348623157e+308, dVelocityRY=1.7976931348623157e+308, dVelocityRZ=1.7976931348623157e+308, crCurCoord=None, iEndArrowDir=0, crTable=None, crNodeSet=None, dPhase=1.7976931348623157e+308, dDelay=1.7976931348623157e+308, crPhaseTable=None, iVelocityUnit=0, iRotUnit=0, bExport=False, crExportDataTX=None, crExportDataTY=None, crExportDataTZ=None, crExportDataRX=None, crExportDataRY=None, crExportDataRZ=None)


```

## ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC.fromList

```text
ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC.isDefault

```text
ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC.isDefault(self)


```

## ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC.toNativeStr

```text
ACModeling.ACBoundary.ENFORCED_VELOCITY_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_END_PROP

```text
ACModeling.ACBoundary.ERIBEAM_END_PROP(iElemId=0, iEndA=0, iEndB=0)


```

## ACModeling.ACBoundary.ERIBEAM_END_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_END_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_END_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_END_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_END_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_END_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP

```text
ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP(iPropId=0, iElemId=0, dlOffsetVec=[0, 0, 0])


```

## ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_OFFSET_VEC_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP

```text
ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP(iPropId=0, iElemId=0, iOrientNodeId=0)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_ORI_NODEID_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP

```text
ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP(iPropId=0, iElemId=0, dlOrientVec=[0, 0, 0])


```

## ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_ORI_VEC_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP

```text
ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP(iPropId=0, iElemId=0, iPinA=0)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_PIN_A_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP

```text
ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP(iPropId=0, iElemId=0, iPinB=0)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_PIN_B_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIBEAM_WARP_PROP

```text
ACModeling.ACBoundary.ERIBEAM_WARP_PROP(iPropId=0, iElemId=0, dWarp=0)


```

## ACModeling.ACBoundary.ERIBEAM_WARP_PROP.fromList

```text
ACModeling.ACBoundary.ERIBEAM_WARP_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIBEAM_WARP_PROP.isDefault

```text
ACModeling.ACBoundary.ERIBEAM_WARP_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIBEAM_WARP_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIBEAM_WARP_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_CID_PROP

```text
ACModeling.ACBoundary.ERICONT_CID_PROP(iConnId=0, iEndA=0, iEndB=0, iCid=0)


```

## ACModeling.ACBoundary.ERICONT_CID_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_CID_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_CID_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_CID_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_CID_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_CID_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP

```text
ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP(iConnId=0, iEndA=0, iEndB=0, dAmperLoc=0.0)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_DAMPER_LOC_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP

```text
ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP(iConnId=0, iEndA=0, iEndB=0, dAmperOffsetVecX=0.0, dAmperOffsetVecY=0.0, dAmperOffsetVecZ=0.0)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_DAMPER_OFFSET_VEC_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_END_PROP

```text
ACModeling.ACBoundary.ERICONT_END_PROP(iConnId=0, iEndA=0, iEndB=0)


```

## ACModeling.ACBoundary.ERICONT_END_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_END_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_END_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_END_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_END_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_END_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_NODEID_PROP

```text
ACModeling.ACBoundary.ERICONT_NODEID_PROP(iConnId=0, iEndA=0, iEndB=0, iNodeID=0)


```

## ACModeling.ACBoundary.ERICONT_NODEID_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_NODEID_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_NODEID_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_NODEID_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_NODEID_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_NODEID_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_OCID_PROP

```text
ACModeling.ACBoundary.ERICONT_OCID_PROP(iConnId=0, iEndA=0, iEndB=0, iOcid=0)


```

## ACModeling.ACBoundary.ERICONT_OCID_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_OCID_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_OCID_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_OCID_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_OCID_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_OCID_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP

```text
ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP(iConnId=0, iEndA=0, iEndB=0, dOrientVecX=0.0, dOrientVecY=0.0, dOrientVecZ=0.0)


```

## ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP.fromList

```text
ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP.isDefault

```text
ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERICONT_ORI_VEC_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERIROD_END_PROP

```text
ACModeling.ACBoundary.ERIROD_END_PROP(iElemId=0, iEndA=0, iEndB=0)


```

## ACModeling.ACBoundary.ERIROD_END_PROP.fromList

```text
ACModeling.ACBoundary.ERIROD_END_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERIROD_END_PROP.isDefault

```text
ACModeling.ACBoundary.ERIROD_END_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERIROD_END_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERIROD_END_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERISHELL_CS_PROP

```text
ACModeling.ACBoundary.ERISHELL_CS_PROP(iPropId2=0, iElemId2=0, iCS=0)


```

## ACModeling.ACBoundary.ERISHELL_CS_PROP.fromList

```text
ACModeling.ACBoundary.ERISHELL_CS_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERISHELL_CS_PROP.isDefault

```text
ACModeling.ACBoundary.ERISHELL_CS_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERISHELL_CS_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERISHELL_CS_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERISHELL_THETA_PROP

```text
ACModeling.ACBoundary.ERISHELL_THETA_PROP(iPropId1=0, iElemId1=0, dTheta=0)


```

## ACModeling.ACBoundary.ERISHELL_THETA_PROP.fromList

```text
ACModeling.ACBoundary.ERISHELL_THETA_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERISHELL_THETA_PROP.isDefault

```text
ACModeling.ACBoundary.ERISHELL_THETA_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERISHELL_THETA_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERISHELL_THETA_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP

```text
ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP(iPropId3=0, iElemId3=0, dZoffs=0.0)


```

## ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP.fromList

```text
ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP.isDefault

```text
ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP.toNativeStr

```text
ACModeling.ACBoundary.ERISHELL_ZOFFS_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Edge

```text
ACModeling.ACBoundary.Edge(*ids)


```

## ACModeling.ACBoundary.Elastic

```text
ACModeling.ACBoundary.Elastic(params, temperatureDependency=False)


```

## ACModeling.ACBoundary.Elastic.toStr

```text
ACModeling.ACBoundary.Elastic.toStr(self, replace_str)


```

## ACModeling.ACBoundary.Elem

```text
ACModeling.ACBoundary.Elem(*ids)


```

## ACModeling.ACBoundary.ElemEdgeGroup

```text
ACModeling.ACBoundary.ElemEdgeGroup(*ids)


```

## ACModeling.ACBoundary.EntityAttrCADInfo

```text
ACModeling.ACBoundary.EntityAttrCADInfo(*ids)


```

## ACModeling.ACBoundary.FIND_OPTION_UTIL

```text
ACModeling.ACBoundary.FIND_OPTION_UTIL(bFindMatch=False)


```

## ACModeling.ACBoundary.FIND_OPTION_UTIL.fromList

```text
ACModeling.ACBoundary.FIND_OPTION_UTIL.fromList(self, param)


```

## ACModeling.ACBoundary.FIND_OPTION_UTIL.isDefault

```text
ACModeling.ACBoundary.FIND_OPTION_UTIL.isDefault(self)


```

## ACModeling.ACBoundary.FIND_OPTION_UTIL.toNativeStr

```text
ACModeling.ACBoundary.FIND_OPTION_UTIL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.FIXED_CONTRAINT_LBC

```text
ACModeling.ACBoundary.FIXED_CONTRAINT_LBC(iDwDof=7, crCurCoord=None, iType=0, iUsetType=0, crTable=None, bAbaqusFixed=False)


```

## ACModeling.ACBoundary.FIXED_CONTRAINT_LBC.fromList

```text
ACModeling.ACBoundary.FIXED_CONTRAINT_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.FIXED_CONTRAINT_LBC.isDefault

```text
ACModeling.ACBoundary.FIXED_CONTRAINT_LBC.isDefault(self)


```

## ACModeling.ACBoundary.FIXED_CONTRAINT_LBC.toNativeStr

```text
ACModeling.ACBoundary.FIXED_CONTRAINT_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.FORCE_LBC

```text
ACModeling.ACBoundary.FORCE_LBC(vecForce=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], vecMoment=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], iEndArrowDir=0, iEndDistribute=0, crCurCoord=None, crTable=None, crNodeSet=None, dPhase=0.0, dDelay=0.0, crPhaseTable=None, strFormulaTX='', strFormulaTY='', strFormulaTZ='', strFormulaRX='', strFormulaRY='', strFormulaRZ='')


```

## ACModeling.ACBoundary.FORCE_LBC.fromList

```text
ACModeling.ACBoundary.FORCE_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.FORCE_LBC.isDefault

```text
ACModeling.ACBoundary.FORCE_LBC.isDefault(self)


```

## ACModeling.ACBoundary.FORCE_LBC.toNativeStr

```text
ACModeling.ACBoundary.FORCE_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.FORCE_ND_LBC

```text
ACModeling.ACBoundary.FORCE_ND_LBC(ParamGeneralForce=FORCE_LBC(), dValueForND=1.0, strFormulaValue='', crElementForND=None)


```

## ACModeling.ACBoundary.FORCE_ND_LBC.fromList

```text
ACModeling.ACBoundary.FORCE_ND_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.FORCE_ND_LBC.isDefault

```text
ACModeling.ACBoundary.FORCE_ND_LBC.isDefault(self)


```

## ACModeling.ACBoundary.FORCE_ND_LBC.toNativeStr

```text
ACModeling.ACBoundary.FORCE_ND_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.FULLTRANS

```text
ACModeling.ACBoundary.FULLTRANS(iSolutionOption=0, dPropertyChange=0.05, iPointNum=64, dMinTemp=0.0, dMaxTemp=0.0, iFullTransEquationSolver=0, dFullTransdToleranceLevel=0.0, dFullTransMultiplier=0.0, bFullTransSinglePrecision=False, bFullTransMemorySave=False, dFullTransTemperatureDifference=1.1)


```

## ACModeling.ACBoundary.FULLTRANS.fromList

```text
ACModeling.ACBoundary.FULLTRANS.fromList(self, param)


```

## ACModeling.ACBoundary.FULLTRANS.isDefault

```text
ACModeling.ACBoundary.FULLTRANS.isDefault(self)


```

## ACModeling.ACBoundary.FULLTRANS.toNativeStr

```text
ACModeling.ACBoundary.FULLTRANS.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Face

```text
ACModeling.ACBoundary.Face(*ids)


```

## ACModeling.ACBoundary.FemFieldScalar

```text
ACModeling.ACBoundary.FemFieldScalar(*ids)


```

## ACModeling.ACBoundary.FemFieldTensor

```text
ACModeling.ACBoundary.FemFieldTensor(*ids)


```

## ACModeling.ACBoundary.FemFieldVector

```text
ACModeling.ACBoundary.FemFieldVector(*ids)


```

## ACModeling.ACBoundary.FieldData

```text
ACModeling.ACBoundary.FieldData(*ids)


```

## ACModeling.ACBoundary.FirstMethod

```text
ACModeling.ACBoundary.FirstMethod(crlParts, bIsMergePart, bIsRenumber)


```

## ACModeling.ACBoundary.GRID_MESH

```text
ACModeling.ACBoundary.GRID_MESH(crlFace=[], crlCorner=[], ilMeshCount=[], iShape=-1, iElemtype=3, bSwap=False, bLocalSetting=False, bOptimize=False, bFreezeBoundary=False)


```

## ACModeling.ACBoundary.GRID_MESH.fromList

```text
ACModeling.ACBoundary.GRID_MESH.fromList(self, param)


```

## ACModeling.ACBoundary.GRID_MESH.isDefault

```text
ACModeling.ACBoundary.GRID_MESH.isDefault(self)


```

## ACModeling.ACBoundary.GRID_MESH.toNativeStr

```text
ACModeling.ACBoundary.GRID_MESH.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Group

```text
ACModeling.ACBoundary.Group(*ids)


```

## ACModeling.ACBoundary.HARMONIC

```text
ACModeling.ACBoundary.HARMONIC(dHarmonicStartFreq=0.0, dHarmonicEndFreq=1.0, iSubSteps=0, dAlphaD=0.0, dBetaD=0.0, dDmprat=0.0, bHarmonicOutputDisplacements=False, bHarmonicOutputStress=False, bHarmonicOutputStrain=False)


```

## ACModeling.ACBoundary.HARMONIC.fromList

```text
ACModeling.ACBoundary.HARMONIC.fromList(self, param)


```

## ACModeling.ACBoundary.HARMONIC.isDefault

```text
ACModeling.ACBoundary.HARMONIC.isDefault(self)


```

## ACModeling.ACBoundary.HARMONIC.toNativeStr

```text
ACModeling.ACBoundary.HARMONIC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Inst

```text
ACModeling.ACBoundary.Inst(*ids)


```

## ACModeling.ACBoundary.JOB_ABAQUS_DATA

```text
ACModeling.ACBoundary.JOB_ABAQUS_DATA(bRBE2toMPC=False, bRenameProcess=False, iCodeType=0, iSurfDefType=0, iUnit=0, iWriteType=0, strDescription='', strlUserText=[], bExportNodeElemGroup=False, bDeleteFloatingNodes=False, bExportFaceElemGroup=False, bLoadCase=False, bAutoAssignDummyProperty=True, crDummyMat=None, bOutputGeometryId=True)


```

## ACModeling.ACBoundary.JOB_ABAQUS_DATA.fromList

```text
ACModeling.ACBoundary.JOB_ABAQUS_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.JOB_ABAQUS_DATA.isDefault

```text
ACModeling.ACBoundary.JOB_ABAQUS_DATA.isDefault(self)


```

## ACModeling.ACBoundary.JOB_ABAQUS_DATA.toNativeStr

```text
ACModeling.ACBoundary.JOB_ABAQUS_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA

```text
ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA(fVelocity=1.7976931348623157e+308, fAcceleration=1.7976931348623157e+308, iAxisDirection=2, iVelocityUnit=0, iAccelerationUnit=0, curCoord=None)


```

## ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA.fromList

```text
ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_CENTRIFUGAL_FORCE_CS_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA

```text
ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA(dFluxValue=0.0, crTable=None)


```

## ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA.fromList

```text
ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_CONCENTRATE_FLUX_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA

```text
ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA(vInit=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], bSelNode=False, crNodeSet=None, crTable=None, crCoord=None)


```

## ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA.fromList

```text
ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_DYNAMIC_INITIAL_CONDITION_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA

```text
ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA(dwDof=63, vTrans=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], vRot=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], curCoord=None, enArrowDir=0, crTable=None, crNodeSet=None, m_fPhase=1.7976931348623157e+308, m_fDelay=1.7976931348623157e+308, crPhaseTable=None)


```

## ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA.fromList

```text
ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_ENFORCEDDISP_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA

```text
ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA(fTotalForce=0.0, a=0.0, b=0.0, crCoord=None, angleBase=0, angleRange=0.0, enArrowDir=0)


```

## ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA.fromList

```text
ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_FORCE_QUADRATIC_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_FORCE_SINE_DATA

```text
ACModeling.ACBoundary.LBC_FORCE_SINE_DATA(fTotalForce=0.0, a=0.0, crCoord=None, angleBase=0, angleRange=0.0, enArrowDir=0, bdistributeInAxis=False)


```

## ACModeling.ACBoundary.LBC_FORCE_SINE_DATA.fromList

```text
ACModeling.ACBoundary.LBC_FORCE_SINE_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_FORCE_SINE_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_FORCE_SINE_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_FORCE_SINE_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_FORCE_SINE_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA

```text
ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA(fTotalForce=1.7976931348623157e+308, a=1.7976931348623157e+308, x=1.7976931348623157e+308, y=1.7976931348623157e+308, crCoord=None, enDirection=0, angleRange=0.0, arrowDir=0, bdistributeInAxis=False)


```

## ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA.fromList

```text
ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_FORCE_VECTOR_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA

```text
ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA(dVelocity=1.7976931348623157e+308, strFirstCoord='', strSecondCoord='')


```

## ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA.fromList

```text
ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_INITIAL_ROTVEL_ABAQUS_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA

```text
ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA(dimension=2, elemCs=0, sXX=1.7976931348623157e+308, sYY=1.7976931348623157e+308, sXY=1.7976931348623157e+308, crTable=None)


```

## ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA.fromList

```text
ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_INITSTRESS_GENERAL_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA

```text
ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA(dInsideFlux=1.7976931348623157e+308, crTable=None)


```

## ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA.fromList

```text
ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_INSIDE_HEAT_GENERATION_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_NOLIN1_DATA

```text
ACModeling.ACBoundary.LBC_NOLIN1_DATA(dForceScale=0.0, dMomentScale=0.0, iForcDir=0, iForceDepends=0, iMomentDir=0, iMomentDepends=0, crCoord=None, crForceTable=None, crMomentTable=None)


```

## ACModeling.ACBoundary.LBC_NOLIN1_DATA.fromList

```text
ACModeling.ACBoundary.LBC_NOLIN1_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_NOLIN1_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_NOLIN1_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_NOLIN1_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_NOLIN1_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_PRESSURE_G_DATA

```text
ACModeling.ACBoundary.LBC_PRESSURE_G_DATA(fpressure=0.0, idistribute=0, crtable=None, dphase=0.0, ddelay=0.0, crphaseTable=None, strformularValue='', crcoord=None, vdirection=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], formularDirX='', formularDirY='', formularDirZ='', arrowDir=1)


```

## ACModeling.ACBoundary.LBC_PRESSURE_G_DATA.fromList

```text
ACModeling.ACBoundary.LBC_PRESSURE_G_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_PRESSURE_G_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_PRESSURE_G_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_PRESSURE_G_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_PRESSURE_G_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_PRESSURE_H_DATA

```text
ACModeling.ACBoundary.LBC_PRESSURE_H_DATA(fHPressure=0.0, fDensity=0.0, iDensityUnit=0, fGravity=0.0, iGravityUnit=0, iGravityDir=0, fWaterSuface=0.0, iSufaceUnit=0, enDistrbute=0)


```

## ACModeling.ACBoundary.LBC_PRESSURE_H_DATA.fromList

```text
ACModeling.ACBoundary.LBC_PRESSURE_H_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_PRESSURE_H_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_PRESSURE_H_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_PRESSURE_H_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_PRESSURE_H_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA

```text
ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA(a=0.0, crCoordinate=None, angleRange=0.0, distributionAxis=False, pressureDirectionMode=0, isTotalForceAdjustment=False, totalForce=0.0, pressureDirection=[0.0, 0.0, 0.0], crCoordinateSystemForDirection=None, isCornerNodesDistribution=False, formulaForA='')


```

## ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA.fromList

```text
ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_PRESSURE_SINE_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA

```text
ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA(bFixedLenght=False, crTable=None, dValue=1.7976931348623157e+308, iLocalUnit=0, stNormal='', NodePos=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308])


```

## ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA.fromList

```text
ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_PRETENSION_ABAQUS_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA

```text
ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA(bfixedLength=False, crEnforcedVelocity=None, dvalue=1.7976931348623157e+308, dirUpdateType=0, vnormal=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], vCtrolNodePos=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], refNodeId=0)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA.fromList

```text
ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_PRETENSION_ADVC_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_PRETENSION_DATA

```text
ACModeling.ACBoundary.LBC_PRETENSION_DATA(iDir=0, dValue=1.7976931348623157e+308, bFixLength=False, crTable=None, crCoord=None, iLocalUnit=0)


```

## ACModeling.ACBoundary.LBC_PRETENSION_DATA.fromList

```text
ACModeling.ACBoundary.LBC_PRETENSION_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_PRETENSION_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_PRETENSION_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_PRETENSION_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_PRETENSION_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_RIGIDWALL_DATA

```text
ACModeling.ACBoundary.LBC_RIGIDWALL_DATA(m_nObject=0, m_nType=0, m_nMotion=0, m_nFriction=0, m_nOrtho=0, m_nForces=0, m_Finite=[1.7976931348623157e+308, 1.7976931348623157e+308], m_MotionMass=1.7976931348623157e+308, m_MotionInitVelo=1.7976931348623157e+308, m_FricCoulombCoeff=1.7976931348623157e+308, m_FricWeldVelo=1.7976931348623157e+308, m_ForcesCirclesNum=0, m_OrthoStaticCoeff=[1.7976931348623157e+308, 1.7976931348623157e+308], m_OrthoDynamicCoeff=[1.7976931348623157e+308, 1.7976931348623157e+308], m_OrthoDecayConst=[1.7976931348623157e+308, 1.7976931348623157e+308], m_OrthoFricVector=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], m_bAllNodeSlave=False, crCoord=None, crAreaFaceSet=None, crVisualNodeSet=None)


```

## ACModeling.ACBoundary.LBC_RIGIDWALL_DATA.fromList

```text
ACModeling.ACBoundary.LBC_RIGIDWALL_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_RIGIDWALL_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_RIGIDWALL_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_RIGIDWALL_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_RIGIDWALL_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA

```text
ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA(iSolver=0, strFilePathName='/home/', iProcessNo=0, bTranslationX=True, bTranslationY=True, bTranslationZ=True, iReferType=-1, dExtensionRange=1.7976931348623157e+308, dExtensionTol=1.7976931348623157e+308, dExtensionLimitTol=1.7976931348623157e+308, strGlobalElementSet='', iUseBucket=-1, iNumBucketMaxX=2147483647, iNumBucketMaxY=2147483647, iNumBucketMaxZ=2147483647, iPrevBc=-1)


```

## ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA.fromList

```text
ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_SUBMODEL_FORCED_DISP_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA

```text
ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA(ExtTemp=1.7976931348623157e+308, crTableTimeTemp=None, dcoef=1.7976931348623157e+308, crTableTimeCoeff=None, crTableTempCoeff=None)


```

## ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA.fromList

```text
ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA.fromList(self, param)


```

## ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA.isDefault

```text
ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA.isDefault(self)


```

## ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA.toNativeStr

```text
ACModeling.ACBoundary.LBC_THERMAL_CONVECTION_DATA.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LOCAL_MESH

```text
ACModeling.ACBoundary.LOCAL_MESH(iEntityType=0, bEnableSizeParams=False, dAvgElemSize=0.0, dMaxElemSize=0.0, dMinElemSize=0.0, bEnableTrimAngle=False, dTrimAngle=0.0, bEnableMeshCount=False, iNodeCount=0, iBiasNodeId=0, dBiasFactor=0.0, iBiasMethod=0, iBiasProgression=0, bEnableMeshPattern=False, iMeshPatternType=0, bEnableKeepEntity=False, dFixedPointX=0.0, dFixedPointY=0.0, dFixedPointZ=0.0, iFixedPointId=0, bEnableFreezeMesh=False)


```

## ACModeling.ACBoundary.LOCAL_MESH.fromList

```text
ACModeling.ACBoundary.LOCAL_MESH.fromList(self, localMesh)


```

## ACModeling.ACBoundary.LOCAL_MESH.isDefault

```text
ACModeling.ACBoundary.LOCAL_MESH.isDefault(self)


```

## ACModeling.ACBoundary.LOCAL_MESH.toNativeStr

```text
ACModeling.ACBoundary.LOCAL_MESH.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.LSDynaJob

```text
ACModeling.ACBoundary.LSDynaJob(*ids)


```

## ACModeling.ACBoundary.LbcCSCentrifugalForce

```text
ACModeling.ACBoundary.LbcCSCentrifugalForce(*ids)


```

## ACModeling.ACBoundary.LbcConcentrateFlux

```text
ACModeling.ACBoundary.LbcConcentrateFlux(*ids)


```

## ACModeling.ACBoundary.LbcConstraint

```text
ACModeling.ACBoundary.LbcConstraint(*ids)


```

## ACModeling.ACBoundary.LbcContactClearance

```text
ACModeling.ACBoundary.LbcContactClearance(*ids)


```

## ACModeling.ACBoundary.LbcDOFSet

```text
ACModeling.ACBoundary.LbcDOFSet(*ids)


```

## ACModeling.ACBoundary.LbcDynamicInitialCondition

```text
ACModeling.ACBoundary.LbcDynamicInitialCondition(*ids)


```

## ACModeling.ACBoundary.LbcEnforcedAcceleration

```text
ACModeling.ACBoundary.LbcEnforcedAcceleration(*ids)


```

## ACModeling.ACBoundary.LbcEnforcedDisp

```text
ACModeling.ACBoundary.LbcEnforcedDisp(*ids)


```

## ACModeling.ACBoundary.LbcEnforcedVelocity

```text
ACModeling.ACBoundary.LbcEnforcedVelocity(*ids)


```

## ACModeling.ACBoundary.LbcForce

```text
ACModeling.ACBoundary.LbcForce(*ids)


```

## ACModeling.ACBoundary.LbcForceND

```text
ACModeling.ACBoundary.LbcForceND(*ids)


```

## ACModeling.ACBoundary.LbcForceQuadratic

```text
ACModeling.ACBoundary.LbcForceQuadratic(*ids)


```

## ACModeling.ACBoundary.LbcForceSine

```text
ACModeling.ACBoundary.LbcForceSine(*ids)


```

## ACModeling.ACBoundary.LbcForceVector

```text
ACModeling.ACBoundary.LbcForceVector(*ids)


```

## ACModeling.ACBoundary.LbcGPressure

```text
ACModeling.ACBoundary.LbcGPressure(*ids)


```

## ACModeling.ACBoundary.LbcGravity

```text
ACModeling.ACBoundary.LbcGravity(*ids)


```

## ACModeling.ACBoundary.LbcHPressure

```text
ACModeling.ACBoundary.LbcHPressure(*ids)


```

## ACModeling.ACBoundary.LbcInitAngularVelAbaqus

```text
ACModeling.ACBoundary.LbcInitAngularVelAbaqus(*ids)


```

## ACModeling.ACBoundary.LbcInitStressGeneral

```text
ACModeling.ACBoundary.LbcInitStressGeneral(*ids)


```

## ACModeling.ACBoundary.LbcInitStressMapping

```text
ACModeling.ACBoundary.LbcInitStressMapping(*ids)


```

## ACModeling.ACBoundary.LbcInsideHeatGeneration

```text
ACModeling.ACBoundary.LbcInsideHeatGeneration(*ids)


```

## ACModeling.ACBoundary.LbcMappingForce

```text
ACModeling.ACBoundary.LbcMappingForce(*ids)


```

## ACModeling.ACBoundary.LbcMappingForcedDsiplacement

```text
ACModeling.ACBoundary.LbcMappingForcedDsiplacement(*ids)


```

## ACModeling.ACBoundary.LbcMappingForcedTemp

```text
ACModeling.ACBoundary.LbcMappingForcedTemp(*ids)


```

## ACModeling.ACBoundary.LbcMappingHeatFlux

```text
ACModeling.ACBoundary.LbcMappingHeatFlux(*ids)


```

## ACModeling.ACBoundary.LbcMappingPressure

```text
ACModeling.ACBoundary.LbcMappingPressure(*ids)


```

## ACModeling.ACBoundary.LbcMappingTempBoundary

```text
ACModeling.ACBoundary.LbcMappingTempBoundary(*ids)


```

## ACModeling.ACBoundary.LbcMappingTempLoad

```text
ACModeling.ACBoundary.LbcMappingTempLoad(*ids)


```

## ACModeling.ACBoundary.LbcMappingTempMarineEngine

```text
ACModeling.ACBoundary.LbcMappingTempMarineEngine(*ids)


```

## ACModeling.ACBoundary.LbcMappingThermalConvection

```text
ACModeling.ACBoundary.LbcMappingThermalConvection(*ids)


```

## ACModeling.ACBoundary.LbcNolin1

```text
ACModeling.ACBoundary.LbcNolin1(*ids)


```

## ACModeling.ACBoundary.LbcNolin3

```text
ACModeling.ACBoundary.LbcNolin3(*ids)


```

## ACModeling.ACBoundary.LbcNolin4

```text
ACModeling.ACBoundary.LbcNolin4(*ids)


```

## ACModeling.ACBoundary.LbcPressureQuadratic

```text
ACModeling.ACBoundary.LbcPressureQuadratic(*ids)


```

## ACModeling.ACBoundary.LbcPressureSine

```text
ACModeling.ACBoundary.LbcPressureSine(*ids)


```

## ACModeling.ACBoundary.LbcPretension

```text
ACModeling.ACBoundary.LbcPretension(*ids)


```

## ACModeling.ACBoundary.LbcPretensionADVC

```text
ACModeling.ACBoundary.LbcPretensionADVC(*ids)


```

## ACModeling.ACBoundary.LbcPretensionAbaqus

```text
ACModeling.ACBoundary.LbcPretensionAbaqus(*ids)


```

## ACModeling.ACBoundary.LbcPretensionNXN

```text
ACModeling.ACBoundary.LbcPretensionNXN(*ids)


```

## ACModeling.ACBoundary.LbcPretensionSunShine

```text
ACModeling.ACBoundary.LbcPretensionSunShine(*ids)


```

## ACModeling.ACBoundary.LbcRigidWall

```text
ACModeling.ACBoundary.LbcRigidWall(*ids)


```

## ACModeling.ACBoundary.LbcSubModelForcedDisp

```text
ACModeling.ACBoundary.LbcSubModelForcedDisp(*ids)


```

## ACModeling.ACBoundary.LbcSubModelForcedFlux

```text
ACModeling.ACBoundary.LbcSubModelForcedFlux(*ids)


```

## ACModeling.ACBoundary.LbcSubModelForcedTemp

```text
ACModeling.ACBoundary.LbcSubModelForcedTemp(*ids)


```

## ACModeling.ACBoundary.LbcSurfaceFlux

```text
ACModeling.ACBoundary.LbcSurfaceFlux(*ids)


```

## ACModeling.ACBoundary.LbcSurfaceLoads

```text
ACModeling.ACBoundary.LbcSurfaceLoads(*ids)


```

## ACModeling.ACBoundary.LbcTCentrifugalForce

```text
ACModeling.ACBoundary.LbcTCentrifugalForce(*ids)


```

## ACModeling.ACBoundary.LbcTPressure

```text
ACModeling.ACBoundary.LbcTPressure(*ids)


```

## ACModeling.ACBoundary.LbcTempBoundary

```text
ACModeling.ACBoundary.LbcTempBoundary(*ids)


```

## ACModeling.ACBoundary.LbcTempIni

```text
ACModeling.ACBoundary.LbcTempIni(*ids)


```

## ACModeling.ACBoundary.LbcTempLoad

```text
ACModeling.ACBoundary.LbcTempLoad(*ids)


```

## ACModeling.ACBoundary.LbcTempLoadADVCFile

```text
ACModeling.ACBoundary.LbcTempLoadADVCFile(*ids)


```

## ACModeling.ACBoundary.LbcTempLoadADVCResultReference

```text
ACModeling.ACBoundary.LbcTempLoadADVCResultReference(*ids)


```

## ACModeling.ACBoundary.LbcTempLoadGeneral

```text
ACModeling.ACBoundary.LbcTempLoadGeneral(*ids)


```

## ACModeling.ACBoundary.LbcTempLoadNastran

```text
ACModeling.ACBoundary.LbcTempLoadNastran(*ids)


```

## ACModeling.ACBoundary.LbcThermalConvection

```text
ACModeling.ACBoundary.LbcThermalConvection(*ids)


```

## ACModeling.ACBoundary.LbcWeld

```text
ACModeling.ACBoundary.LbcWeld(*ids)


```

## ACModeling.ACBoundary.LoadCase

```text
ACModeling.ACBoundary.LoadCase(*ids)


```

## ACModeling.ACBoundary.LocalSetting

```text
ACModeling.ACBoundary.LocalSetting(*ids)


```

## ACModeling.ACBoundary.MESH_PART_INFO_TOOL

```text
ACModeling.ACBoundary.MESH_PART_INFO_TOOL(strPartName='', iPartID=0, strPropName='', iPropId=0, iPropType=0, strMatName='', iMatID=0, strMatType='', iPartNode=0, iNpartnodeWithprop=0, ilPartElement=[], ilNpartelementWithprop=[])


```

## ACModeling.ACBoundary.MESH_PART_INFO_TOOL.fromList

```text
ACModeling.ACBoundary.MESH_PART_INFO_TOOL.fromList(self, param)


```

## ACModeling.ACBoundary.MESH_PART_INFO_TOOL.isDefault

```text
ACModeling.ACBoundary.MESH_PART_INFO_TOOL.isDefault(self)


```

## ACModeling.ACBoundary.MESH_PART_INFO_TOOL.toNativeStr

```text
ACModeling.ACBoundary.MESH_PART_INFO_TOOL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.MIRRO_LBC_COPY

```text
ACModeling.ACBoundary.MIRRO_LBC_COPY(dOffset=0, dTol=0.1, veclPoint=[])


```

## ACModeling.ACBoundary.MIRRO_LBC_COPY.fromList

```text
ACModeling.ACBoundary.MIRRO_LBC_COPY.fromList(self, param)


```

## ACModeling.ACBoundary.MIRRO_LBC_COPY.isDefault

```text
ACModeling.ACBoundary.MIRRO_LBC_COPY.isDefault(self)


```

## ACModeling.ACBoundary.MIRRO_LBC_COPY.toNativeStr

```text
ACModeling.ACBoundary.MIRRO_LBC_COPY.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.MMC_ACMODEL_MESH

```text
ACModeling.ACBoundary.MMC_ACMODEL_MESH(crlPart=[], crlItem1=[], crlItem2=[], crlItem3=[], iType=-1, bMergeTol=False, dTol=0.01, dMeshSise=0.1, bCreatePart=False)


```

## ACModeling.ACBoundary.MMC_ACMODEL_MESH.fromList

```text
ACModeling.ACBoundary.MMC_ACMODEL_MESH.fromList(self, param)


```

## ACModeling.ACBoundary.MMC_ACMODEL_MESH.isDefault

```text
ACModeling.ACBoundary.MMC_ACMODEL_MESH.isDefault(self)


```

## ACModeling.ACBoundary.MMC_ACMODEL_MESH.toNativeStr

```text
ACModeling.ACBoundary.MMC_ACMODEL_MESH.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.MODAL

```text
ACModeling.ACBoundary.MODAL(iModeMethod=0, iExtractNum=1, bExpandShape=True, iExpandNum=0, bUseApprox=False, bInclPrestressEffect=False, bModalMemorySave=False, bResidualVector=False, bModalOutputDisplacements=False, bModalOutputStrain=False, bModalOutputStress=False)


```

## ACModeling.ACBoundary.MODAL.fromList

```text
ACModeling.ACBoundary.MODAL.fromList(self, param)


```

## ACModeling.ACBoundary.MODAL.isDefault

```text
ACModeling.ACBoundary.MODAL.isDefault(self)


```

## ACModeling.ACBoundary.MODAL.toNativeStr

```text
ACModeling.ACBoundary.MODAL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.MPC_CONNECTION

```text
ACModeling.ACBoundary.MPC_CONNECTION(dCoef=0.0, iDof=0)


```

## ACModeling.ACBoundary.MPC_CONNECTION.fromList

```text
ACModeling.ACBoundary.MPC_CONNECTION.fromList(self, param)


```

## ACModeling.ACBoundary.MPC_CONNECTION.isDefault

```text
ACModeling.ACBoundary.MPC_CONNECTION.isDefault(self)


```

## ACModeling.ACBoundary.MPC_CONNECTION.toNativeStr

```text
ACModeling.ACBoundary.MPC_CONNECTION.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.MatPropBase

```text
ACModeling.ACBoundary.MatPropBase()


```

## ACModeling.ACBoundary.Material

```text
ACModeling.ACBoundary.Material(*ids)


```

## ACModeling.ACBoundary.NASTRAN_ANALYSIS

```text
ACModeling.ACBoundary.NASTRAN_ANALYSIS(iSolverType=0, iWriteType=0, iGridFormatType=0, bDeleteFloatingNodes=False, bContinuanceMarker=False, bDefineLbcId=False, iDefinedLoadId=0, iDefinedSpcId=0, iDefinedMpcId=0, bUniqueLbcId=False, bUseCASI=False, dEpsilon=0.0, iMaxNumOfIter=0, iNumberOfThreads=0, iMemory=0, bParamInrel=False, iNcpu=0, iSolNo=0, strIncludeFilePath='', nastranEigen=NASTRAN_EIGEN(), nastranEigen126=NASTRAN_EIGEN126(), nastranFrequency=NASTRAN_FREQUENCY(), nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(), nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(), nastranExecControl=NASTRAN_EXEC_CONTROL(), nastranCaseControl=NASTRAN_CASE_CONTROL(), nastranMainLbcSet=NASTRAN_MAIN_LBC_SET(), nastranSettings=NASTRAN_SETTINGS(), nastranNonlinear=NASTRAN_NONLINEAR(), nastranNonlinearTimestep=NASTRAN_NONLINEAR_TIMESTEP(), nastranSubcase=[], strSystemCellText='', strFileManagementText='', strExecutiveControlText='', strGlobalCaseControlText='', strBulkDataText='', iExportModelUnitSystem=0)


```

## ACModeling.ACBoundary.NASTRAN_ANALYSIS.fromList

```text
ACModeling.ACBoundary.NASTRAN_ANALYSIS.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_ANALYSIS.isDefault

```text
ACModeling.ACBoundary.NASTRAN_ANALYSIS.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_ANALYSIS.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_ANALYSIS.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_CASE_CONTROL

```text
ACModeling.ACBoundary.NASTRAN_CASE_CONTROL(iECHO=0, strTitle='')


```

## ACModeling.ACBoundary.NASTRAN_CASE_CONTROL.fromList

```text
ACModeling.ACBoundary.NASTRAN_CASE_CONTROL.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_CASE_CONTROL.isDefault

```text
ACModeling.ACBoundary.NASTRAN_CASE_CONTROL.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_CASE_CONTROL.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_CASE_CONTROL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_CONTACT

```text
ACModeling.ACBoundary.NASTRAN_CONTACT(iType=0, iAlg=0, dRROR=0.5, dFNTOL=1.7976931348623157e+308, dFRIC=1.7976931348623157e+308, dCINTERF=1.7976931348623157e+308, iISEARCH=2147483647, iICOORD=2147483647, dFRLIM=1.7976931348623157e+308, dBIAS=1.7976931348623157e+308, iISTYP=2147483647, iIshellelemfaceSlave=0, iIshellelemfaceMaster=0, iIbeambarshellelemedgeSlave=0, iIbeambarshellelemedgeMaster=0)


```

## ACModeling.ACBoundary.NASTRAN_CONTACT.fromList

```text
ACModeling.ACBoundary.NASTRAN_CONTACT.fromList(self, param)


```

## ACModeling.ACBoundary.NASTRAN_CONTACT.isDefault

```text
ACModeling.ACBoundary.NASTRAN_CONTACT.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_CONTACT.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_CONTACT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN

```text
ACModeling.ACBoundary.NASTRAN_EIGEN(dStartFreq=1.7976931348623157e+308, dEndFreq=1.7976931348623157e+308, iNoOfModes=2147483647)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN.fromList

```text
ACModeling.ACBoundary.NASTRAN_EIGEN.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN.isDefault

```text
ACModeling.ACBoundary.NASTRAN_EIGEN.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_EIGEN.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN126

```text
ACModeling.ACBoundary.NASTRAN_EIGEN126(iModalExtractionMethod=0, dModalStartFreq=1.7976931348623157e+308, dModalEndFreq=1.7976931348623157e+308, iModalNoOfModes=2147483647, iBRsvec=0, iMLDSExtractionMethod=0, dMLDSStartFreq=1.7976931348623157e+308, dMLDSEndFreq=1.7976931348623157e+308, iMLDSNoOfModes=2147483647)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN126.fromList

```text
ACModeling.ACBoundary.NASTRAN_EIGEN126.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN126.isDefault

```text
ACModeling.ACBoundary.NASTRAN_EIGEN126.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_EIGEN126.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_EIGEN126.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL

```text
ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL(bGeometrycheck=False)


```

## ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL.fromList

```text
ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL.isDefault

```text
ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_EXEC_CONTROL.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_FMBD_SETTING

```text
ACModeling.ACBoundary.NASTRAN_FMBD_SETTING(iMDBSolverType=0, iMassUnitType=0, iForceUnitType=0, iLengthUnitType=0, iTimeUnitType=0, bFlexBody=False, bFlexOnly=False, bOUTGSTRS=False, bOUTGSTRN=False, iMiniVarType=0, iSHELSTRS=0, iSHELSTRN=0, bCHECKRFI=False, bRMIDNODE=False, iRMSHAPE=0)


```

## ACModeling.ACBoundary.NASTRAN_FMBD_SETTING.fromList

```text
ACModeling.ACBoundary.NASTRAN_FMBD_SETTING.fromList(self, param)


```

## ACModeling.ACBoundary.NASTRAN_FMBD_SETTING.isDefault

```text
ACModeling.ACBoundary.NASTRAN_FMBD_SETTING.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_FMBD_SETTING.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_FMBD_SETTING.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_FREQUENCY

```text
ACModeling.ACBoundary.NASTRAN_FREQUENCY(dStartFrequency=1.7976931348623157e+308, dIncrement=1.7976931348623157e+308, iumOfInc=2147483647, iTableId=0)


```

## ACModeling.ACBoundary.NASTRAN_FREQUENCY.fromList

```text
ACModeling.ACBoundary.NASTRAN_FREQUENCY.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_FREQUENCY.isDefault

```text
ACModeling.ACBoundary.NASTRAN_FREQUENCY.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_FREQUENCY.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_FREQUENCY.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP

```text
ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP(iumOfSteps=2147483647, dTimeIncrement=1.7976931348623157e+308, iOutputInterval=2147483647, iDampingType=2, iModalDampingTableId=0)


```

## ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP.fromList

```text
ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP.isDefault

```text
ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_FREQ_TIMESTEP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET

```text
ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET(iSubcaseIdForLoad=2147483647, iSubcaseIdForDload=2147483647, iSubcaseIdForSpc=2147483647, iSubcaseIdForMpc=2147483647, iSubcaseIdForTempInit=2147483647, iSubcaseIdForTempLoad=2147483647)


```

## ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET.fromList

```text
ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET.isDefault

```text
ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_MAIN_LBC_SET.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR(iNINC=1, iKMETHOD=3, iMAXITER=1, bUseEPSU=False, bUseEPSP=False, bUseEPSW=False, dEPSU=0.01, dEPSP=0.01, dEPSW=0.01)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR.fromList

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR.isDefault

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP(iNDT=2147483647, dDT=1.7976931348623157e+308, iMAXITER=2147483647)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP.fromList

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP.isDefault

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_NONLINEAR_TIMESTEP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST

```text
ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST(iValueDisplacement=2147483647, iValueSpcforces=2147483647, iValueOload=2147483647, iValueMpcforces=2147483647, iValueStress=2147483647, iValueStrain=2147483647, iValueForce=2147483647, iValueGpforces=0, iValueNlstress=0, iValueStrainenergy=2147483647, iValueKineticenergy=0, iValueBcresults=0, iValueBgresults=0, iValueSdisplacement=0, iValueAcceleration=0, iValueVelocity=0, iValueMeffmass=0, iValueThermal=2147483647, iValueFlux=2147483647, iTypeDisplacement=1, iTypeSpcforces=0, iTypeOload=0, iTypeMpcforces=0, iTypeStress=1, iTypeStrain=1, iTypeForce=0, iTypeGpforces=0, iTypeNlstress=0, iTypeStrainenergy=0, iTypeKineticenergy=0, iTypeBcresults=0, iTypeBgresults=0, iTypeSdisplacement=0, iTypeAcceleration=0, iTypeVelocity=0, iTypeMeffmass=0, iTypeThermal=0, iTypeFlux=0)


```

## ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST.fromList

```text
ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST.isDefault

```text
ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_OUTPUT_REQUEST.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_SETTINGS

```text
ACModeling.ACBoundary.NASTRAN_SETTINGS(iPOST=-1, iOGEOM=0, iAUTOSPC=0, strGRDPNT='', strWTMASS='', strK6ROT='', strMAXRATIO='', iBAILOUT=2147483647, iPRGPST=2, iRESVEC=0, dG=1.7976931348623157e+308, dHFREQ=1.7976931348623157e+308, dLFREQ=1.7976931348623157e+308, dW3=1.7976931348623157e+308, dW4=1.7976931348623157e+308, iMEFFMASS=0, MEFFMASS_GRID_ID=2147483647, iMLDS=1, iMLDSRCV=0)


```

## ACModeling.ACBoundary.NASTRAN_SETTINGS.fromList

```text
ACModeling.ACBoundary.NASTRAN_SETTINGS.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_SETTINGS.isDefault

```text
ACModeling.ACBoundary.NASTRAN_SETTINGS.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_SETTINGS.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_SETTINGS.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NASTRAN_SUBCASE

```text
ACModeling.ACBoundary.NASTRAN_SUBCASE(iId=0, strTitle='', strArbitraryText='', iSubcaseIdForLoad=0, iSubcaseIdForDload=0, iSubcaseIdForSpc=0, iSubcaseIdForMpc=0, iSubcaseIdForBcontact=0, iSubcaseIdForTempInit=0, iSubcaseIdForTempLoad=0, iOutputreqDisplacement=0, iOutputreqStress=0, iOutputreqStrain=0, iOutputreqAcceleration=0, iOutputreqVelocity=0, nastranNonlinear=2147483647)


```

## ACModeling.ACBoundary.NASTRAN_SUBCASE.fromList

```text
ACModeling.ACBoundary.NASTRAN_SUBCASE.fromList(self, nastranAnalysis)


```

## ACModeling.ACBoundary.NASTRAN_SUBCASE.isDefault

```text
ACModeling.ACBoundary.NASTRAN_SUBCASE.isDefault(self)


```

## ACModeling.ACBoundary.NASTRAN_SUBCASE.toNativeStr

```text
ACModeling.ACBoundary.NASTRAN_SUBCASE.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.NCS

```text
ACModeling.ACBoundary.NCS(*ids)


```

## ACModeling.ACBoundary.NastranHDF5PostJob

```text
ACModeling.ACBoundary.NastranHDF5PostJob(*ids)


```

## ACModeling.ACBoundary.NastranJob

```text
ACModeling.ACBoundary.NastranJob(*ids)


```

## ACModeling.ACBoundary.NastranOP2PostJob

```text
ACModeling.ACBoundary.NastranOP2PostJob(*ids)


```

## ACModeling.ACBoundary.Nastran_Psd_Data

```text
ACModeling.ACBoundary.Nastran_Psd_Data(iMasterID=0, iSlaveID=0, dRealX=1.0, dImagY=0.0, iTableID=0)


```

## ACModeling.ACBoundary.Nastran_Psd_Data.fromList

```text
ACModeling.ACBoundary.Nastran_Psd_Data.fromList(self, param)


```

## ACModeling.ACBoundary.Nastran_Psd_Data.isDefault

```text
ACModeling.ACBoundary.Nastran_Psd_Data.isDefault(self)


```

## ACModeling.ACBoundary.Nastran_Psd_Data.toNativeStr

```text
ACModeling.ACBoundary.Nastran_Psd_Data.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Nastran_Psd_Opt

```text
ACModeling.ACBoundary.Nastran_Psd_Opt(iNodeSetID=0, bDofT1=False, bDofT2=False, bDofT3=False, bDofR1=False, bDofR2=False, bDofR3=False, iOutputType=0, iDispType=0, iVelocityType=0, iAcceType=0, dStartFreq=0.0, dEndFreq=0.0)


```

## ACModeling.ACBoundary.Nastran_Psd_Opt.fromList

```text
ACModeling.ACBoundary.Nastran_Psd_Opt.fromList(self, param)


```

## ACModeling.ACBoundary.Nastran_Psd_Opt.isDefault

```text
ACModeling.ACBoundary.Nastran_Psd_Opt.isDefault(self)


```

## ACModeling.ACBoundary.Nastran_Psd_Opt.toNativeStr

```text
ACModeling.ACBoundary.Nastran_Psd_Opt.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Node

```text
ACModeling.ACBoundary.Node(*ids)


```

## ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter

```text
ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter(iEnFunctionType=-1, strFunctionName='', iOptimization=-1, strDegreeOfFreedomNum='', crNodeSet=None, crPropOrElemSet=None)


```

## ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter.fromList

```text
ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter.fromList(self, param)


```

## ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter.isDefault

```text
ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter.isDefault(self)


```

## ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter.toNativeStr

```text
ACModeling.ACBoundary.Optimization_NonDesignableArea_Parameter.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter

```text
ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter(iEnFunctionType=-1, strFunctionName='', iDisplacementRelation=-1, strDegreeOfFreedomNum='', dDisplacementCoefficient=1.7976931348623157e+308, vecProcess=[], iConstraint=-1, dConstraintTol=1.7976931348623157e+308, iTargetType=-1, dRatioOrValue=1.7976931348623157e+308, dCoefficient=1.7976931348623157e+308, crNodeSet=None, crPropOrElemSet=None, crSurfaceSet=None, iKSKernel=-1, dRHO=1.7976931348623157e+308, dExponent=1.7976931348623157e+308, iEigenNumber=2147483647)


```

## ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter.fromList

```text
ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter.fromList(self, param)


```

## ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter.isDefault

```text
ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter.isDefault(self)


```

## ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter.toNativeStr

```text
ACModeling.ACBoundary.Optimization_ObjectiveConstraint_Parameter.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Optimization_Output_Parameter

```text
ACModeling.ACBoundary.Optimization_Output_Parameter(bNodalShapeVariation=False, bShapeVariation=False, bNodalDensityRation=False, bDensityRation=False, bSensitivity=False, bSensitivity_Of_Objective=False, bSensitivity_Of_Constraint=False, bSensitivities=False)


```

## ACModeling.ACBoundary.Optimization_Output_Parameter.fromList

```text
ACModeling.ACBoundary.Optimization_Output_Parameter.fromList(self, param)


```

## ACModeling.ACBoundary.Optimization_Output_Parameter.isDefault

```text
ACModeling.ACBoundary.Optimization_Output_Parameter.isDefault(self)


```

## ACModeling.ACBoundary.Optimization_Output_Parameter.toNativeStr

```text
ACModeling.ACBoundary.Optimization_Output_Parameter.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter

```text
ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter(iEnFunctionType=-1, strFunctionName='', dInitialDensity=1.7976931348623157e+308, dDensityRandom=1.7976931348623157e+308, dAlpha=1.7976931348623157e+308, dDraftAngle=1.7976931348623157e+308, dGap=1.7976931348623157e+308, dDepth=1.7976931348623157e+308, dAngle=1.7976931348623157e+308, dClearance=1.7976931348623157e+308, dThicknessDepth=1.7976931348623157e+308, dMaxThickness=1.7976931348623157e+308, dMinThickness=1.7976931348623157e+308, iMaxIteration=2147483647, dMaxStrain=1.7976931348623157e+308, dMaxTheta=1.7976931348623157e+308, dH1Tolerance=1.7976931348623157e+308, iOutputLast=-1, iOutputInterval=2147483647, iResoutLast=-1, iResoutInterval=2147483647, iArmijoCheck=-1, dArmijoParam=1.7976931348623157e+308, strDirection='', iPunchingOneSide=-1, iAutoIncrement=-1, dStabilizationFactor=1.7976931348623157e+308, dPoissonRatio=1.7976931348623157e+308, iAutoFrozen=-1, iKeyCoordinate=-1, crNodeSet=None, crPropOrElemSet=None, crSurfaceSetNonInterferingArea=None, crSurfaceSetOptimizedArea=None, vecSurfaceSetPair=[], iWolfeCheck=-1, dWolfeParam=1.7976931348623157e+308, iMatrix=-1, iElementDStiffness=-1, iConstraintMethod=-1, dGrayScaleRatio=1.7976931348623157e+308, iOutputGrayScaleRatio=-1)


```

## ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter.fromList

```text
ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter.fromList(self, param)


```

## ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter.isDefault

```text
ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter.isDefault(self)


```

## ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter.toNativeStr

```text
ACModeling.ACBoundary.Optimization_ShapeTopology_Parameter.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.PART_COLOR_PAIR

```text
ACModeling.ACBoundary.PART_COLOR_PAIR(crPart=None, iColor=65280)


```

## ACModeling.ACBoundary.PART_COLOR_PAIR.fromList

```text
ACModeling.ACBoundary.PART_COLOR_PAIR.fromList(self, param)


```

## ACModeling.ACBoundary.PART_COLOR_PAIR.isDefault

```text
ACModeling.ACBoundary.PART_COLOR_PAIR.isDefault(self)


```

## ACModeling.ACBoundary.PART_COLOR_PAIR.toNativeStr

```text
ACModeling.ACBoundary.PART_COLOR_PAIR.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Part

```text
ACModeling.ACBoundary.Part(*ids)


```

## ACModeling.ACBoundary.PermasJob

```text
ACModeling.ACBoundary.PermasJob(*ids)


```

## ACModeling.ACBoundary.PostResultKey

```text
ACModeling.ACBoundary.PostResultKey(iAnalysisType=0, iResultSet=0, iTimeStep=0, iResultType=0, iResultPos=0)


```

## ACModeling.ACBoundary.PostResultKey.fromList

```text
ACModeling.ACBoundary.PostResultKey.fromList(self, param)


```

## ACModeling.ACBoundary.PostResultKey.isDefault

```text
ACModeling.ACBoundary.PostResultKey.isDefault(self)


```

## ACModeling.ACBoundary.PostResultKey.toNativeStr

```text
ACModeling.ACBoundary.PostResultKey.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.PostResultKey.toNativeStr2

```text
ACModeling.ACBoundary.PostResultKey.toNativeStr2(self, isOneParam=True)


```

## ACModeling.ACBoundary.Post_Tree_Item_Target

```text
ACModeling.ACBoundary.Post_Tree_Item_Target(iAnalysisType=0, iResultSet=0, iTimeStep=0, iTreeIndex=0)


```

## ACModeling.ACBoundary.Post_Tree_Item_Target.fromList

```text
ACModeling.ACBoundary.Post_Tree_Item_Target.fromList(self, param)


```

## ACModeling.ACBoundary.Post_Tree_Item_Target.isDefault

```text
ACModeling.ACBoundary.Post_Tree_Item_Target.isDefault(self)


```

## ACModeling.ACBoundary.Post_Tree_Item_Target.toNativeStr

```text
ACModeling.ACBoundary.Post_Tree_Item_Target.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Project

```text
ACModeling.ACBoundary.Project(*ids)


```

## ACModeling.ACBoundary.Property0DMass

```text
ACModeling.ACBoundary.Property0DMass(*ids)


```

## ACModeling.ACBoundary.Property1DBar

```text
ACModeling.ACBoundary.Property1DBar(*ids)


```

## ACModeling.ACBoundary.Property1DBeam

```text
ACModeling.ACBoundary.Property1DBeam(*ids)


```

## ACModeling.ACBoundary.Property1DPlot

```text
ACModeling.ACBoundary.Property1DPlot(*ids)


```

## ACModeling.ACBoundary.Property1DRod

```text
ACModeling.ACBoundary.Property1DRod(*ids)


```

## ACModeling.ACBoundary.Property2DCompositeShell

```text
ACModeling.ACBoundary.Property2DCompositeShell(*ids)


```

## ACModeling.ACBoundary.Property2DShell

```text
ACModeling.ACBoundary.Property2DShell(*ids)


```

## ACModeling.ACBoundary.Property3DCohesive

```text
ACModeling.ACBoundary.Property3DCohesive(*ids)


```

## ACModeling.ACBoundary.Property3DGasket

```text
ACModeling.ACBoundary.Property3DGasket(*ids)


```

## ACModeling.ACBoundary.Property3DSolid

```text
ACModeling.ACBoundary.Property3DSolid(*ids)


```

## ACModeling.ACBoundary.Property3DWeldBead

```text
ACModeling.ACBoundary.Property3DWeldBead(*ids)


```

## ACModeling.ACBoundary.RBAR_CONNECTION

```text
ACModeling.ACBoundary.RBAR_CONNECTION(strName='', iEType=7, iMethod=1, crCoordSys=None, iCoordSys=0)


```

## ACModeling.ACBoundary.RBAR_CONNECTION.fromList

```text
ACModeling.ACBoundary.RBAR_CONNECTION.fromList(self, param)


```

## ACModeling.ACBoundary.RBAR_CONNECTION.isDefault

```text
ACModeling.ACBoundary.RBAR_CONNECTION.isDefault(self)


```

## ACModeling.ACBoundary.RBAR_CONNECTION.toNativeStr

```text
ACModeling.ACBoundary.RBAR_CONNECTION.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.RBE3_TERM_CONNECTION

```text
ACModeling.ACBoundary.RBE3_TERM_CONNECTION(dCoef=0, iDof=0, iTarCnt=0)


```

## ACModeling.ACBoundary.RBE3_TERM_CONNECTION.fromList

```text
ACModeling.ACBoundary.RBE3_TERM_CONNECTION.fromList(self, param)


```

## ACModeling.ACBoundary.RBE3_TERM_CONNECTION.isDefault

```text
ACModeling.ACBoundary.RBE3_TERM_CONNECTION.isDefault(self)


```

## ACModeling.ACBoundary.RBE3_TERM_CONNECTION.toNativeStr

```text
ACModeling.ACBoundary.RBE3_TERM_CONNECTION.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.REDUCED

```text
ACModeling.ACBoundary.REDUCED(iPrintNum=0)


```

## ACModeling.ACBoundary.REDUCED.fromList

```text
ACModeling.ACBoundary.REDUCED.fromList(self, param)


```

## ACModeling.ACBoundary.REDUCED.isDefault

```text
ACModeling.ACBoundary.REDUCED.isDefault(self)


```

## ACModeling.ACBoundary.REDUCED.toNativeStr

```text
ACModeling.ACBoundary.REDUCED.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.RENUMBER_ITEM

```text
ACModeling.ACBoundary.RENUMBER_ITEM(crTarget=None, iBeginID=0, iTargetType=0, iCount=0, iIncrement=0, iOrder=0, iMethod=0, crRefCoord=None, ilCoordOrder=[0, 0, 0], ilOffset=[0, 0, 0], dlCoordTolerance=[0.0, 0.0, 0.0], iConflictStrategy=0, iSolver=0, bEnable=False)


```

## ACModeling.ACBoundary.RENUMBER_ITEM.fromList

```text
ACModeling.ACBoundary.RENUMBER_ITEM.fromList(self, param)


```

## ACModeling.ACBoundary.RENUMBER_ITEM.isDefault

```text
ACModeling.ACBoundary.RENUMBER_ITEM.isDefault(self)


```

## ACModeling.ACBoundary.RENUMBER_ITEM.toNativeStr

```text
ACModeling.ACBoundary.RENUMBER_ITEM.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.RENUMBER_PROP

```text
ACModeling.ACBoundary.RENUMBER_PROP(crTarget=None, crMat=None, newId=0)


```

## ACModeling.ACBoundary.RENUMBER_PROP.fromList

```text
ACModeling.ACBoundary.RENUMBER_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.RENUMBER_PROP.isDefault

```text
ACModeling.ACBoundary.RENUMBER_PROP.isDefault(self)


```

## ACModeling.ACBoundary.RENUMBER_PROP.toNativeStr

```text
ACModeling.ACBoundary.RENUMBER_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ROD_1D_PROP

```text
ACModeling.ACBoundary.ROD_1D_PROP(crMat=None, dArea=1.7976931348623157e+308, dTorConst=1.7976931348623157e+308, dTorStressCoeff=1.7976931348623157e+308, dNSM=1.7976931348623157e+308)


```

## ACModeling.ACBoundary.ROD_1D_PROP.fromList

```text
ACModeling.ACBoundary.ROD_1D_PROP.fromList(self, param)


```

## ACModeling.ACBoundary.ROD_1D_PROP.isDefault

```text
ACModeling.ACBoundary.ROD_1D_PROP.isDefault(self)


```

## ACModeling.ACBoundary.ROD_1D_PROP.toNativeStr

```text
ACModeling.ACBoundary.ROD_1D_PROP.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.ROElem

```text
ACModeling.ACBoundary.ROElem(*ids)


```

## ACModeling.ACBoundary.RONode

```text
ACModeling.ACBoundary.RONode(*ids)


```

## ACModeling.ACBoundary.ROTATE_LBC_COPY

```text
ACModeling.ACBoundary.ROTATE_LBC_COPY(iAxis=0, iCenter=2, dlCenterVec=[0, 0, 0], dlAxisVec=[0, 0, 0], crCoord=None, dAngle=0, dTol=0)


```

## ACModeling.ACBoundary.ROTATE_LBC_COPY.fromList

```text
ACModeling.ACBoundary.ROTATE_LBC_COPY.fromList(self, param)


```

## ACModeling.ACBoundary.ROTATE_LBC_COPY.isDefault

```text
ACModeling.ACBoundary.ROTATE_LBC_COPY.isDefault(self)


```

## ACModeling.ACBoundary.ROTATE_LBC_COPY.toNativeStr

```text
ACModeling.ACBoundary.ROTATE_LBC_COPY.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.RefBodyLink

```text
ACModeling.ACBoundary.RefBodyLink(*ids)


```

## ACModeling.ACBoundary.RefEdge

```text
ACModeling.ACBoundary.RefEdge(*ids)


```

## ACModeling.ACBoundary.RefElem

```text
ACModeling.ACBoundary.RefElem(*ids)


```

## ACModeling.ACBoundary.RefFace

```text
ACModeling.ACBoundary.RefFace(*ids)


```

## ACModeling.ACBoundary.RefNode

```text
ACModeling.ACBoundary.RefNode(*ids)


```

## ACModeling.ACBoundary.RefPart

```text
ACModeling.ACBoundary.RefPart(*ids)


```

## ACModeling.ACBoundary.RefShapeLink

```text
ACModeling.ACBoundary.RefShapeLink(*ids)


```

## ACModeling.ACBoundary.RefSolid

```text
ACModeling.ACBoundary.RefSolid(*ids)


```

## ACModeling.ACBoundary.RefVertex

```text
ACModeling.ACBoundary.RefVertex(*ids)


```

## ACModeling.ACBoundary.ReferenceCursorStr

```text
ACModeling.ACBoundary.ReferenceCursorStr(typeId, extKeyIds)


```

## ACModeling.ACBoundary.RenumberByConnData

```text
ACModeling.ACBoundary.RenumberByConnData(entityType=0, sortOrder=0, startId=1, incStep=1, layer1=100, layer2=100, layer3=100, offsetLayer12=2147483647, offsetLayer23=2147483647, bstopAtEdge=False)


```

## ACModeling.ACBoundary.RenumberByConnData.fromList

```text
ACModeling.ACBoundary.RenumberByConnData.fromList(self, param)


```

## ACModeling.ACBoundary.RenumberByConnData.isDefault

```text
ACModeling.ACBoundary.RenumberByConnData.isDefault(self)


```

## ACModeling.ACBoundary.RenumberByConnData.toNativeStr

```text
ACModeling.ACBoundary.RenumberByConnData.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.SPACE_MESH

```text
ACModeling.ACBoundary.SPACE_MESH(iBodyType=0, bEnclosed=False, vOrigin=[0.0, 0.0, 0.0], vCenterPt=[0.0, 0.0, 0.0], vLength=[0.01, 0.01, 0.01], vAxisPt1=[0.0, 0.0, 0.01], vAxisPt2=[0.0, 0.0, 0.0], dMaxElemSize=1.7976931348623157e+308, dMinElemSize=0.0)


```

## ACModeling.ACBoundary.SPACE_MESH.fromList

```text
ACModeling.ACBoundary.SPACE_MESH.fromList(self, param)


```

## ACModeling.ACBoundary.SPACE_MESH.isDefault

```text
ACModeling.ACBoundary.SPACE_MESH.isDefault(self)


```

## ACModeling.ACBoundary.SPACE_MESH.toNativeStr

```text
ACModeling.ACBoundary.SPACE_MESH.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.STEADY_STATIC

```text
ACModeling.ACBoundary.STEADY_STATIC(bSteadyStaticMemorySave=False, bSteadyStaticOutputHeatFlux=False, bSteadyStaticOutputTemperature=False, bPivotsCheck=True, bSteadyStaticSinglePrecision=False, dSteadyStaticMultiplier=0.0, dSteadyStaticTemperatureDifference=0.0, dSteadyStaticToleranceLevel=0.0, iAdaptiveDescent=0, iSteadyStaticEquationSolver=0, iNewtonRaphsonOption=0)


```

## ACModeling.ACBoundary.STEADY_STATIC.fromList

```text
ACModeling.ACBoundary.STEADY_STATIC.fromList(self, param)


```

## ACModeling.ACBoundary.STEADY_STATIC.isDefault

```text
ACModeling.ACBoundary.STEADY_STATIC.isDefault(self)


```

## ACModeling.ACBoundary.STEADY_STATIC.toNativeStr

```text
ACModeling.ACBoundary.STEADY_STATIC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC

```text
ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC(iSolver=0, strFilePathName='/home/', iProcessNo=0, iReferType=0, dExtensionRange=1.7976931348623157e+308, dExtensionTol=1.7976931348623157e+308, dExtensionLimitTol=1.7976931348623157e+308, strGlobalElementSet='', iUseBucket=-1, iNumBucketMaxX=2147483647, iNumBucketMaxY=2147483647, iNumBucketMaxZ=2147483647, iPrevBc=-1)


```

## ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC.fromList

```text
ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC.isDefault

```text
ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC.isDefault(self)


```

## ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC.toNativeStr

```text
ACModeling.ACBoundary.SUBMODEL_FORCED_TEMP_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.SUBSPACE

```text
ACModeling.ACBoundary.SUBSPACE(iRigidMode=0, iWorkSize=8, iNPADNum=4, iBlockNum=5, iMaxIteratorCnt=0, iMinNShift=0, iSeqCheck=0)


```

## ACModeling.ACBoundary.SUBSPACE.fromList

```text
ACModeling.ACBoundary.SUBSPACE.fromList(self, param)


```

## ACModeling.ACBoundary.SUBSPACE.isDefault

```text
ACModeling.ACBoundary.SUBSPACE.isDefault(self)


```

## ACModeling.ACBoundary.SUBSPACE.toNativeStr

```text
ACModeling.ACBoundary.SUBSPACE.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.SUNSHINE_CONTACT

```text
ACModeling.ACBoundary.SUNSHINE_CONTACT(iType=0, iAlg=0, dERROR=0.0, dFRIC=0.0, dSLIDE=0.0, iICOORD=0, dSFACT=0.0, dSFACTT=0.0, dCDAMP=0.0, iIshellelemfaceSlave=0, iIshellelemfaceMaster=0, dCINTERF=1.7976931348623157e+308, iJGLUE=1)


```

## ACModeling.ACBoundary.SUNSHINE_CONTACT.fromList

```text
ACModeling.ACBoundary.SUNSHINE_CONTACT.fromList(self, param)


```

## ACModeling.ACBoundary.SUNSHINE_CONTACT.isDefault

```text
ACModeling.ACBoundary.SUNSHINE_CONTACT.isDefault(self)


```

## ACModeling.ACBoundary.SUNSHINE_CONTACT.toNativeStr

```text
ACModeling.ACBoundary.SUNSHINE_CONTACT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.SURFACE_MESH

```text
ACModeling.ACBoundary.SURFACE_MESH(dAvgElemSize=0.005, dMaxElemSize=0.01, dMinElemSize=0.001, dReductionFactor=1.0, dGeomAngle=0.785398, dGeomMinSize=0.001, dGradingFactor=1.25, dMinStretchVal=0.1, dGeomEdgeDev=0.1, dGeomQualRatio=0.7, dGeomCntRatio=0.5, iPerformanceMode=0, iOptLevel=3, bAutoMergeEdges=False, bAutoMergeFaces=False, dAutoMeshPatternMinElemAngle=0, dAutoMergeTinyFacesAngle=0.523598756, bOutputQuadMesh=False, bPureQuad=False, bBadInputModel=False, bCloseGaps=False, bLocalRemesh=False, bGeomApprox=False, bCurvatureControl=False, bDeleteCircChamfer=False, bTinyCylinderMesh=False, iNextEntityOffsetId=10000000, iNextElemOffsetId=0, iNextNodeOffsetId=0)


```

## ACModeling.ACBoundary.SURFACE_MESH.fromList

```text
ACModeling.ACBoundary.SURFACE_MESH.fromList(self, param)


```

## ACModeling.ACBoundary.SURFACE_MESH.isDefault

```text
ACModeling.ACBoundary.SURFACE_MESH.isDefault(self)


```

## ACModeling.ACBoundary.SURFACE_MESH.toNativeStr

```text
ACModeling.ACBoundary.SURFACE_MESH.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.SectionGeneral

```text
ACModeling.ACBoundary.SectionGeneral(*ids)


```

## ACModeling.ACBoundary.SectionLibrary

```text
ACModeling.ACBoundary.SectionLibrary(*ids)


```

## ACModeling.ACBoundary.SectionSketcher

```text
ACModeling.ACBoundary.SectionSketcher(*ids)


```

## ACModeling.ACBoundary.ShapeLink

```text
ACModeling.ACBoundary.ShapeLink(*ids)


```

## ACModeling.ACBoundary.ShellPropAttr

```text
ACModeling.ACBoundary.ShellPropAttr(*ids)


```

## ACModeling.ACBoundary.Solid

```text
ACModeling.ACBoundary.Solid(*ids)


```

## ACModeling.ACBoundary.SupGroup

```text
ACModeling.ACBoundary.SupGroup(*ids)


```

## ACModeling.ACBoundary.TEMP_LOAD_LBC

```text
ACModeling.ACBoundary.TEMP_LOAD_LBC(iType=0, dFTemp=0, strFilePathName='', crTable=None, bUseAsMaterialReferenceTemp=False)


```

## ACModeling.ACBoundary.TEMP_LOAD_LBC.fromList

```text
ACModeling.ACBoundary.TEMP_LOAD_LBC.fromList(self, param)


```

## ACModeling.ACBoundary.TEMP_LOAD_LBC.isDefault

```text
ACModeling.ACBoundary.TEMP_LOAD_LBC.isDefault(self)


```

## ACModeling.ACBoundary.TEMP_LOAD_LBC.toNativeStr

```text
ACModeling.ACBoundary.TEMP_LOAD_LBC.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.TIME_POINTS

```text
ACModeling.ACBoundary.TIME_POINTS(crCrtimePoint=None, bSpecify=False)


```

## ACModeling.ACBoundary.TIME_POINTS.fromList

```text
ACModeling.ACBoundary.TIME_POINTS.fromList(self, param)


```

## ACModeling.ACBoundary.TIME_POINTS.isDefault

```text
ACModeling.ACBoundary.TIME_POINTS.isDefault(self)


```

## ACModeling.ACBoundary.TIME_POINTS.toNativeStr

```text
ACModeling.ACBoundary.TIME_POINTS.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.TRANSIENT

```text
ACModeling.ACBoundary.TRANSIENT(bTransientEffect=True, iLoadingType=0, dMassMatrixMultiplier=0.0, dStiffMatrixMultiplier=0.0, bMidStep=False, dToleranceBisection=0.0, dToleranceTimeStep=0.0, iTimeInterAlgorithm=0, iTimeInter=0, dGamma=0.005, dAlpha=0.25250625, dDelta=0.505, dAlphaF=0.005, dAlphaM=0.0, bTransientOutputTemperature=False, bTransientOutputHeatFlux=False)


```

## ACModeling.ACBoundary.TRANSIENT.fromList

```text
ACModeling.ACBoundary.TRANSIENT.fromList(self, param)


```

## ACModeling.ACBoundary.TRANSIENT.isDefault

```text
ACModeling.ACBoundary.TRANSIENT.isDefault(self)


```

## ACModeling.ACBoundary.TRANSIENT.toNativeStr

```text
ACModeling.ACBoundary.TRANSIENT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.TRANS_LBC_COPY

```text
ACModeling.ACBoundary.TRANS_LBC_COPY(iAxis=0, crCoord=None, dlTransVec=[0, 0, 0], dMag=0, dOffset=0, dTol=0)


```

## ACModeling.ACBoundary.TRANS_LBC_COPY.fromList

```text
ACModeling.ACBoundary.TRANS_LBC_COPY.fromList(self, param)


```

## ACModeling.ACBoundary.TRANS_LBC_COPY.isDefault

```text
ACModeling.ACBoundary.TRANS_LBC_COPY.isDefault(self)


```

## ACModeling.ACBoundary.TRANS_LBC_COPY.toNativeStr

```text
ACModeling.ACBoundary.TRANS_LBC_COPY.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.TSSOLVER_CONTACT

```text
ACModeling.ACBoundary.TSSOLVER_CONTACT(iType=0, iAlg=0, dCINTERF=1.7976931348623157e+308, dFRIC=1.7976931348623157e+308, dSLIDE=1.7976931348623157e+308, iICOORD=2147483647, dSFACT=1.7976931348623157e+308, iIshellelemfaceSlave=1, iIshellelemfaceMaster=1)


```

## ACModeling.ACBoundary.TSSOLVER_CONTACT.fromList

```text
ACModeling.ACBoundary.TSSOLVER_CONTACT.fromList(self, param)


```

## ACModeling.ACBoundary.TSSOLVER_CONTACT.isDefault

```text
ACModeling.ACBoundary.TSSOLVER_CONTACT.isDefault(self)


```

## ACModeling.ACBoundary.TSSOLVER_CONTACT.toNativeStr

```text
ACModeling.ACBoundary.TSSOLVER_CONTACT.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Unknown

```text
ACModeling.ACBoundary.Unknown(*ids)


```

## ACModeling.ACBoundary.UserProp

```text
ACModeling.ACBoundary.UserProp(*ids)


```

## ACModeling.ACBoundary.UserResult

```text
ACModeling.ACBoundary.UserResult(*ids)


```

## ACModeling.ACBoundary.VOLUME_MESH

```text
ACModeling.ACBoundary.VOLUME_MESH(bTet10=False, dGradingFactor=0, bGravCenter=False, dStretchLimit=0, iSpeedVsQual=0, iSpeedVsMem=0, iRegion=0, bInternalNodes=True, bSafeMode=True, iParallel=0, bSurfaceNodes=True, bEdgeNodes=True, bPreservation=True, bInternalMeshOnly=True)


```

## ACModeling.ACBoundary.VOLUME_MESH.fromList

```text
ACModeling.ACBoundary.VOLUME_MESH.fromList(self, volumeMesh)


```

## ACModeling.ACBoundary.VOLUME_MESH.isDefault

```text
ACModeling.ACBoundary.VOLUME_MESH.isDefault(self)


```

## ACModeling.ACBoundary.VOLUME_MESH.toNativeStr

```text
ACModeling.ACBoundary.VOLUME_MESH.toNativeStr(self, isOneParam=True)


```

## ACModeling.ACBoundary.Vertex

```text
ACModeling.ACBoundary.Vertex(*ids)


```

## ACModeling.ACBoundary.WeldOrder

```text
ACModeling.ACBoundary.WeldOrder(*ids)


```

## ACModeling.ACBoundary.convert_mat_value_from_doc

```text
ACModeling.ACBoundary.convert_mat_value_from_doc(val, unit)


```

## ACModeling.ACBoundary.convert_mat_value_to_doc

```text
ACModeling.ACBoundary.convert_mat_value_to_doc(val, unit)


```

## ACModeling.ACBoundary.diff_str_xml

```text
ACModeling.ACBoundary.diff_str_xml(strXML1, strXML2)


```

## ACModeling.ACBoundary.func_

```text
ACModeling.ACBoundary.func_(k)


```

## ACModeling.ACBoundary.getBoolListStr

```text
ACModeling.ACBoundary.getBoolListStr(vals)


    >>> getBoolListStr([0, 1, 1])
    '[False, True, True]'
    
```

## ACModeling.ACBoundary.getBoolStr

```text
ACModeling.ACBoundary.getBoolStr(val)


    >>> getBoolStr(0)
    'False'
    >>> getBoolStr(1)
    'True'
    
```

## ACModeling.ACBoundary.getBoolValue

```text
ACModeling.ACBoundary.getBoolValue(val)


    >>> getBoolValue(0)
    False
    >>> getBoolValue(1)
    True
    
```

## ACModeling.ACBoundary.getBoolValueFromString

```text
ACModeling.ACBoundary.getBoolValueFromString(val)


    >>> getBoolValueFromString("0")
    False
    >>> getBoolValueFromString("1")
    True
    
```

## ACModeling.ACBoundary.getCursorListListStr

```text
ACModeling.ACBoundary.getCursorListListStr(crss)


    >>> getCursorListListStr([[[6, 11]]])
    '[[Face(11)]]'
    
```

## ACModeling.ACBoundary.getCursorListStr

```text
ACModeling.ACBoundary.getCursorListStr(crs)


    >>> getCursorListStr([[10, 1], [10, 2], [11, 1]])
    '[Node(1, 2), Elem(1)]'
    
```

## ACModeling.ACBoundary.getCursorListValue

```text
ACModeling.ACBoundary.getCursorListValue(crs)


    >>> getCursorListValue([[10, 1], [10, 2], [11, 1]])
    [10:1, 10:2, 11:1]
    
```

## ACModeling.ACBoundary.getCursorListValueStr

```text
ACModeling.ACBoundary.getCursorListValueStr(crs)


    >>> getCursorListValueStr([Node(1, 2), Elem(1)])
    '[Node(1, 2), Elem(1)]'
    
```

## ACModeling.ACBoundary.getCursorPairListStr

```text
ACModeling.ACBoundary.getCursorPairListStr(crPairs)


    >>> getCursorPairListStr([[[10,11], [10,22]], [[10,33], [10,44]]])
    '[CursorPair(Node(11), Node(22)), CursorPair(Node(33), Node(44))]'
    
```

## ACModeling.ACBoundary.getCursorPairStr

```text
ACModeling.ACBoundary.getCursorPairStr(crPair)


    >>> getCursorPairStr([[10,75], [10,428]])
    'CursorPair(Node(75), Node(428))'
    
```

## ACModeling.ACBoundary.getCursorStr

```text
ACModeling.ACBoundary.getCursorStr(cr)


    >>> getCursorStr([10, 1])
    'Node(1)'
    
```

## ACModeling.ACBoundary.getCursorValue

```text
ACModeling.ACBoundary.getCursorValue(cr)


    >>> getCursorValue([10, 1])
    10:1
    
```

## ACModeling.ACBoundary.getCursorValueByStr

```text
ACModeling.ACBoundary.getCursorValueByStr(crStr)


```

## ACModeling.ACBoundary.getCursorValueStr

```text
ACModeling.ACBoundary.getCursorValueStr(cr)


    >>> getCursorValueStr(Node(1))
    'Node(1)'
    
```

## ACModeling.ACBoundary.getDoubleValueByStr

```text
ACModeling.ACBoundary.getDoubleValueByStr(doubleStr)


```

## ACModeling.ACBoundary.getListCursorValueByStr

```text
ACModeling.ACBoundary.getListCursorValueByStr(crStrs)


```

## ACModeling.ACBoundary.getListDoubleValueByStr

```text
ACModeling.ACBoundary.getListDoubleValueByStr(doubleStr)


```

## ACModeling.ACBoundary.getListIDValueByStrForAssemble

```text
ACModeling.ACBoundary.getListIDValueByStrForAssemble(idStr, bMating=True)


```

## ACModeling.ACBoundary.getListOfListCursorValueByStr

```text
ACModeling.ACBoundary.getListOfListCursorValueByStr(crStrs)


    >>> getListOfListCursorValueByStr('[[3:1, 3:2], [3:3, 3:4], [3:5, 3:6]]')
    [[3:1, 3:2], [3:3, 3:4], [3:5, 3:6]] # List
    
```

## ACModeling.ACBoundary.getMatIdFromXML

```text
ACModeling.ACBoundary.getMatIdFromXML(strMat)


```

## ACModeling.ACBoundary.getMatNameFromXML

```text
ACModeling.ACBoundary.getMatNameFromXML(strMat)


```

## ACModeling.ACBoundary.getReferenceCursorListStr

```text
ACModeling.ACBoundary.getReferenceCursorListStr(refCrs)


    >>> getReferenceCursorListStr([[12, 1, 1], [12, 1, 2], [15, 1, 1]])
    '[RefPart((1, 1), (1, 2)), RefFace((1, 1))]'
    
```

## ACModeling.ACBoundary.getReferenceCursorStr

```text
ACModeling.ACBoundary.getReferenceCursorStr(refCr)


    >>> getReferenceCursorStr([12, 1, 1])
    'RefPart((1, 1))'
    
```

## ACModeling.ACBoundary.getValueStr

```text
ACModeling.ACBoundary.getValueStr(val)


```

## ACModeling.ACBoundary.get_mat_prop_data

```text
ACModeling.ACBoundary.get_mat_prop_data(strXML)


```

## ACModeling.ACBoundary.isNativeParam

```text
ACModeling.ACBoundary.isNativeParam(param)


```

## ACModeling.ACBoundary.isNativeParamList

```text
ACModeling.ACBoundary.isNativeParamList(param, clsType)


```

## ACModeling.ACBoundary.mat_formatting

```text
ACModeling.ACBoundary.mat_formatting(mat_str, replace_space)


```

## ACModeling.ACBoundary.normalizeDoubleType

```text
ACModeling.ACBoundary.normalizeDoubleType(val)


    >>> normalizeDoubleType(1)
    1.0
    >>> normalizeDoubleType([1, 0, 0])
    [1.0, 0.0, 0.0]
    
```

## ACModeling.ACBoundary.toCursor

```text
ACModeling.ACBoundary.toCursor(crStr)


```

## ACModeling.CloseHoleAuto

```text
ACModeling.CloseHoleAuto(crlClosedHoleParts)


```

## ACModeling.Create.Convex

```text
ACModeling.Create.Convex(crlParts=[], dMeshSize=0.005, dOffset=0.02, dRadius=0.02, iDAxisGround=0, dScale=0.001)


```

## ACModeling.Cut

```text
ACModeling.Cut(crlParts)


```

## Analysis.ACTRAN.CreateEdat

```text
Analysis.ACTRAN.CreateEdat(actranAnalysis=ACTRAN_ANALYSIS(), crlTargets=[], crEdit=None)


```

## Analysis.ACTRAN.ExportBdf

```text
Analysis.ACTRAN.ExportBdf(strPath='')


```

## Analysis.ACTRAN.Run

```text
Analysis.ACTRAN.Run(actranAnalysis=ACTRAN_ANALYSIS(), crlTargets=[], crEdit=None)


```

## Analysis.ADVC.HeatTransfer

```text
Analysis.ADVC.HeatTransfer(strPath, strName='Job1', strDescription='', crlProcessSequence=[], crlElemLocationGroup=[], crlNodeLocationGroup=[], bWriteGroup=False, crEdit=None, bResultReference=False, iSeparateFile=0, bExportRelatedAllLBCs=False, bUseEntityName=False, crlTargets=[], iLoadType=1, bSameOutputOnAllProcess=True, bDeleteFloatingNode=True, bBC=True, bCheckBCDuplicate=False, bAutoAssignDummyProp=False, crDummyPropMaterial=None, bReferenceRestartData=False, strReferenceRestartDataPath='', iNumberProcesses=2147483647, iNumberSteps=2147483647, iCoordinateType=0, iUpdateContactSearch=1, listLoadNodeContact=[], iHeatConvection=1, iNumType=0, iUiWidth=10, iUiPrecision=1, bExportGeometryID=False, bSeparatePartInfoFile=False, strADVCTemplateFilePath='', bOutputDefinition=True, iDataFormatType=0)


```

## Analysis.ADVC.MakeProcess.Creep

```text
Analysis.ADVC.MakeProcess.Creep(strName, iGeomNonlinear=0, advcStructTimeStep=ADVC_STRUCT_TIME_STEP(), bConvergence=False, advcConvergence=ADVC_CONVERGENCE(), bContact=False, advcContactIter=ADVC_CONTACT_ITER(), bAutoIncrement=False, advcAutoIncrement=ADVC_AUTO_INCREMENT(), dStabilizationFactor=1.7976931348623157e+308, bThetaDefined=False, dTheta=1.7976931348623157e+308, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.Dynamic

```text
Analysis.ADVC.MakeProcess.Dynamic(strName, iGeomNonlinear=0, advcStructTimeStep=ADVC_STRUCT_TIME_STEP(), bConvergence=False, advcConvergence=ADVC_CONVERGENCE(), bContact=False, advcContactIter=ADVC_CONTACT_ITER(), bAutoIncrement=False, advcAutoIncrement=ADVC_AUTO_INCREMENT(), bDynamic=False, advcDynamic=ADVC_DYNAMIC(), crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.DynamicExplicit

```text
Analysis.ADVC.MakeProcess.DynamicExplicit(strName, iGeomNonlinear=0, advcStructTimeStep=ADVC_STRUCT_TIME_STEP(), bConvergence=False, advcConvergence=ADVC_CONVERGENCE(), bContact=False, advcContactIter=ADVC_CONTACT_ITER(), bAutoIncrement=False, advcAutoIncrement=ADVC_AUTO_INCREMENT(), iLogMessageInterval=2147483647, iLinearApproximation=-1, dBulkViscosityCoef1=1.7976931348623157e+308, dBulkViscosityCoef2=1.7976931348623157e+308, dMassScalingdt=1.7976931348623157e+308, dDtScaleFactor=1.7976931348623157e+308, dPenaltyScaleFactor=1.7976931348623157e+308, iContactSearchInterval=2147483647, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.EigenValue

```text
Analysis.ADVC.MakeProcess.EigenValue(strName, bEigenValue=False, advcNormalModal=ADVC_NORMAL_MODAL(), crEdit=None, listLoadNodeList=[], listLoadCaseNodeList=[], listLoadNodeContactList=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listReferenceResultList=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.Fatigue

```text
Analysis.ADVC.MakeProcess.Fatigue(strName='', bFatigue=False, iMethod=0, iStressAxis=0, iSafetyType=0, dSearchResolution=1.7976931348623157e+308, dSafetyMax=1.7976931348623157e+308, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.ModalFreqResp

```text
Analysis.ADVC.MakeProcess.ModalFreqResp(strName, strRefEigenDir='', dRefLowFreq=1.7976931348623157e+308, dRefHighFreq=1.7976931348623157e+308, crModalDampingRatio=None, crExcitationFreq=None, bAutoFreqInterval=False, dMaxFreq=1.7976931348623157e+308, dMinFreq=1.7976931348623157e+308, iNumFreqPoint=2147483647, dBiasParam=1.7976931348623157e+308, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.RandomResponse

```text
Analysis.ADVC.MakeProcess.RandomResponse(strName='', strRefEigenDir='', dRefLowFreq=1.7976931348623157e+308, dRefHighFreq=1.7976931348623157e+308, crModalDampingRatio=None, crExcitationFreq=None, bAutoFreqInterval=False, dMaxFreq=1.7976931348623157e+308, dMinFreq=1.7976931348623157e+308, iNumFreqPoint=2147483647, dBiasParam=1.7976931348623157e+308, iPropMethod=0, iPSDtype=-1, iPSDdir=0, crPSDLoad=None, dPSDFactor=1.7976931348623157e+308, dGravityAccel=1.7976931348623157e+308, iOutputEigenFreqStep=-1, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.ResponseSpectrum

```text
Analysis.ADVC.MakeProcess.ResponseSpectrum(strName='', strRefEigenDir='', dRefLowFreq=1.7976931348623157e+308, dRefHighFreq=1.7976931348623157e+308, iPropMethod=0, iSpttype=0, dSptFactor0=1.7976931348623157e+308, crSpt0=None, dSptFactor1=1.7976931348623157e+308, crSpt1=None, dSptFactor2=1.7976931348623157e+308, crSpt2=None, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=0, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.Static

```text
Analysis.ADVC.MakeProcess.Static(strName, iGeomNonlinear=0, advcStructTimeStep=ADVC_STRUCT_TIME_STEP(), bConvergence=False, advcConvergence=ADVC_CONVERGENCE(), bContact=False, advcContactIter=ADVC_CONTACT_ITER(), bAutoIncrement=False, advcAutoIncrement=ADVC_AUTO_INCREMENT(), dStabilizationFactor=0.0, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath='', listAdvcRefStressResult=[], strRefPathOfTempLoad='', iRefProcessOfTempLoad=2147483647)


```

## Analysis.ADVC.MakeProcess.SteadyState

```text
Analysis.ADVC.MakeProcess.SteadyState(strName='', advcHeatTimeStep=ADVC_HEAT_TIME_STEP(), bConvergence=False, advcConvergence=ADVC_CONVERGENCE(), crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[])


```

## Analysis.ADVC.MakeProcess.Transient

```text
Analysis.ADVC.MakeProcess.Transient(strName='', iEndType=1, dMaxTime=1, dSteadyRate=0.0, iFixedOrAuto=0, dMaxChange=1.7976931348623157e+308, dInitDt=1.7976931348623157e+308, iDefineMaxDt=0, dMaxDt=1.7976931348623157e+308, iDefineMinDt=0, dMinDt=1.7976931348623157e+308, dFixedDt=1.7976931348623157e+308, iOutputLast=-1, iOutputInterval=2147483647, iRestartLast=-1, iRestartInterval=2147483647, dOutputTimeInterval=1.7976931348623157e+308, dRestartTimeInterval=1.7976931348623157e+308, iOutputInit=-1, iListOutputInterval=2147483647, bConvergence=False, dCgTol=1.7976931348623157e+308, dCgNrTol=1.7976931348623157e+308, dCgDispTol=1.7976931348623157e+308, dCgNrDispTol=1.7976931348623157e+308, dCgDispLimitTol=1.7976931348623157e+308, dCgTotalDispLimitTol=1.7976931348623157e+308, dNewtonTol=1.7976931348623157e+308, dNewtonDispTol=1.7976931348623157e+308, dNewtonDispLimitTol=1.7976931348623157e+308, dNewtonTotalDispLimitTol=1.7976931348623157e+308, iCgloopMax=2147483647, iNewtonMax=2147483647, dHtNlLoopTol=1.7976931348623157e+308, iHtNlLoopMax=2147483647, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[])


```

## Analysis.ADVC.Structure

```text
Analysis.ADVC.Structure(strPath, strName='Job1', strDescription='', crlProcessSequence=[], crlElemLocationGroup=[], crlNodeLocationGroup=[], bWriteGroup=False, crEdit=None, bResultReference=False, iSeparateFile=0, bExportRelatedAllLBCs=False, bUseEntityName=False, bMatrixSolverParam=False, iPreconditionType=0, iMatrixStructure=0, crlTargets=[], iLoadType=1, bSameOutputOnAllProcess=True, bDeleteFloatingNode=True, bBC=True, bCheckBCDuplicate=False, bAutoAssignDummyProp=False, crDummyPropMaterial=None, bReferenceRestartData=False, strReferenceRestartDataPath='', iReferenceRestartDataProcessNum=2147483647, iReferenceRestartDataStepNum=2147483647, iReferenceRestartDataCoordType=0, iReferenceRestartDataUpdateContactSearch=1, listLoadNodeContact=[], bCreateProcessForBoltFixedLength=False, iNumType=0, iUiWidth=10, iUiPrecision=1, bExportGeometryID=False, bSeparatePartInfoFile=False, strADVCTemplateFilePath='', bOutputDefinition=True, iDataFormatType=0, iEJobType=0, vecObjectiveFunction=[], vecConstraintFunction=[], vecNonDesignableArea=[], vecShapeTopology=[], stOptimizationOutput=(0, 0, 0, 0, 0, 0, 0, 0))


```

## Analysis.Abaqus

```text
Analysis.Abaqus(strName, abaqusAnalysis=JOB_ABAQUS_DATA(), crlStepSequence=[], crEdit=None)


```

## Analysis.AbaqusStep.CoupledTDStep

```text
Analysis.AbaqusStep.CoupledTDStep(strName, strDesp='', iEnableAutomatic=0, iMaxInc=100, dInitSize=1.0, dMinSize=1e-05, dMaxSize=1.0, abaqusPair1=ABAQUS_PAIR(), abaqusPair2=ABAQUS_PAIR(), iCSVIntegration=0, iMethod=0, iMatrixStorage=0, iSolutionTech=0, iAllowedIters=8, dAdjustFactor=1.0, iMaxContactIter=30, iType=0, iEnableUseAdaptive=1, dDampingFactor=0.0002, dMaxRationofStrainEnergy=0.05, iEnableNlgeom=0, dTimePeriod=1.0, iTransient=1, iConvertDscntIter=0, iRamp=1, iExtrapolateMethod=0, iEnableIncludeCSV=0, listAbaqusOutputRequest=[], crEdit=None)


```

## Analysis.AbaqusStep.DynamicCoupledTDExplicitStep

```text
Analysis.AbaqusStep.DynamicCoupledTDExplicitStep(strName, strDesp, iEnableAutomatic, iMaxSizebchecked, dlMaxSizeTList, iIncrmtEstimator, iUserTimeIncrmtbchecked, dlUserTimeIncrmtTList, dTimeScalfactor, iEnableNlgeom, dTimePeriod, dLinearBlkVisco, dQuadrBlkVisco, listAbaqusOutputRequest, crEdit)


```

## Analysis.AbaqusStep.DynamicExplicitStep

```text
Analysis.AbaqusStep.DynamicExplicitStep(strName, strDesp='', iEnableAutomatic=1, iIncrmtEstimator=0, abaqusPair1=ABAQUS_PAIR(), dTimeScalfactor=1.0, abaqusPair2=ABAQUS_PAIR(), iEnableNlgeom=1, dTimePeriod=1.0, iEnableIncludeHeatEffect=0, dLinearBlkVisco=0.06, dQuadrBlkVisco=1.2, listAbaqusOutputRequest=[], crEdit=None)


```

## Analysis.AbaqusStep.DynamicStep

```text
Analysis.AbaqusStep.DynamicStep(strName, strDescription='', iAutomatic=0, iMaxInc=100, dInitSize=1.0, dMinSize=1e-05, dMaxSize=1.0, iSuppressHalfResCal=0, dHalfStepResTol=1.7976931348623157e+308, iMethod=0, iMatrixStorage=0, iSolutionTech=0, iAllowedIters=8, dAdjustFactor=1.0, iMaxContactIter=30, dDampingControl=-0.05, iByPassCalInitAcceleration=0, iNlGeom=0, dTimePeriod=1.0, iIncldHeatEffect=0, iConvertDscntIter=0, iRamp=0, iExtrapolateMethod=1, iAcceptByMaxIters=0, listOutput=[], crEdit=None)


```

## Analysis.AbaqusStep.ModalStep

```text
Analysis.AbaqusStep.ModalStep(strName, strDesp='', iEigenSolver=0, iNFreqRequestbchecked=0, ilNFreqRequestTList=[], iFreqShiftbchecked=0, ilFreqShiftTList=[], iFreqRangebchecked=0, ilFreqRangeTList=[], iIncldAcoustic=0, iBlockSizebchecked=0, ilBlockSizeTList=[], iMaxBlkNumofLanczosStepbchecked=0, ilMaxBlkNumofLanczosStepTList=[], iEnableUseSIM=0, iEnableIncludeResMods=0, iNEigenRequest=2147483647, iMaxItersUsed=30, iVectorsUsed=2147483647, iMethod=0, iMatrixStorage=0, iNormalizeEigenBy=1, iEvalPropFreqbchecked=0, ilEvalPropFreqTList=[], abaqusOutputRequest=[], crEdit=None)


```

## Analysis.AbaqusStep.StaticRiskStep

```text
Analysis.AbaqusStep.StaticRiskStep(strName, strDesp='', iEnableAutomatic=0, iMaxInc=100, dInitSize=1.0, dMinSize=1e-05, dMaxSize=1.0, iMethod=0, iMatrixStorage=0, dMaxLdPropFactor=0.0, iEnableMaxLdPropFactor=0, iEnableMaxDisp=0, dMaxDisp=1.7976931348623157e+308, iEnableMaxDispDof=2147483647, strNdRgn='', iEnableNlgeom=0, iEnableIncludeHeatEffect=0, iConvertDscntIter=0, dTotalArcLength=1.0, iExtrapolateMethod=0, iEnableAcceptByMaxIters=0, iEnableLongTerm=0, iEnablePerturbation=0, iFullplasticregionBchecked=0, strlFullplasticregionTlist=[], listOutput=0, crEdit=None)


```

## Analysis.AbaqusStep.StaticStep

```text
Analysis.AbaqusStep.StaticStep(strName='', strDescription='', iAutomatic=0, iMaxInc=0, dInitSize=0.0, dMinSize=0.0, dMaxSize=0.0, iMethod=0, iMatrixStorage=0, iSolutionTech=0, iAllowIter=0, dAdjustFactor=0.0, iMaxContactIteration=0, iType=0, dDampingFactor=0.0, iUseAdaptive=0, dMaxRationOfEnergyStrain=0.0, iNlGeom=0, dTimePeriod=0.0, iIncludeHeatEffect=0, iConvertDiscontinuityIteration=0, iRamp=0, iExtrapolateMethod=0, iAcceptByMaxIteration=0, iObtainLongTermSolution=0, iPertubation=0, iFullPlasticRegion=0, strlFullPlasticRegion=[], listOutput=[], crEdit=None)


```

## Analysis.AbaqusStep.SteadyStateStep

```text
Analysis.AbaqusStep.SteadyStateStep(strName, strDesp='', iAutomatic=0, iMaxInc=100, iInitSize=1, dMinSize=1e-05, dMaxSize=1.0, dMaxAllowTChange=1.7976931348623157e+308, endStepTemp=ABAQUS_PAIR(), dMaxAllowEmissivityChange=0.1, iMethod=0, iMatrixStorage=0, iSolutionTech=0, iAllowedIters=8, iAdjustFactor=1, iMaxContactIter=30, iNlGeom=0, dTimePeriod=1.0, iConvertDscntIter=0, iRamp=0, iExtrapolateMethod=0, listAbaqusOutputRequest=[], crEdit=None)


```

## Analysis.AbaqusStep.TransientStep

```text
Analysis.AbaqusStep.TransientStep(strName='', strDesp='', iEnableAutomatic=0, iMaxInc=0, dInitSize=1.7976931348623157e+308, dMinSize=1.7976931348623157e+308, dMaxSize=1.7976931348623157e+308, dMaxAllowTChange=1.7976931348623157e+308, iEndsteptBchecked=0, dlEndsteptTlist=[], dMaxAllowEmissivityChange=1.7976931348623157e+308, iMethod=0, iMatrixStorage=0, iSolutionTech=0, iAllowedIters=0, dAdjustFactor=1.7976931348623157e+308, iMaxContactIter=0, iEnableNlgeom=0, dTimePeriod=1.7976931348623157e+308, iConvertDscntIter=0, iRamp=0, iExtrapolateMethod=0, listAbaqusOutputRequest=[], crEdit=None)


```

## Analysis.Ansys.Harmonic

```text
Analysis.Ansys.Harmonic(strJobName, strAnsysJobname='Job1', strAnsysJobdescription='', bRunAPDL=False, bWriteResultDB=False, dAnsysAnalysisEndFreq=1.7976931348623157e+308, dAnsysAnalysisStartFreq=1.7976931348623157e+308, ansysAnalysisHarmonic=HARMONIC(), iLoadCaseId=0, ansysAnalysisModal=MODAL(), strAnsysVersion='', strCommandLineOption='', bOutputSOLVE=False, crEdit=None, strFileName='')


```

## Analysis.Ansys.HeatTransferSteady

```text
Analysis.Ansys.HeatTransferSteady(strName, iJobdataAnatype=0, iJobdataSoltype=0, strJobdataJobname='Job1', strJobdataJobdescription='', bBasicdataBoutputdisplacements=False, bBasicdataBoutputreactionload=False, bBasicdataBoutputstrain=False, bBasicdataBoutputstress=False, iBasicdataIanalysisopt=0, bBasicdataBcalPressEffects=False, dBasicdataFunitem=0.0, dBasicdataFreftemp=0.0, dBasicdataFendloadtime=0.0, iBasicdataItimestep=0, iBasicdataIstepchosen=0, iBasicdataIsubstepnum=0, iBasicdataImaxsubstep=0, iBasicdataIminstepnum=0, dBasicdataFtimestepsize=0.0, dBasicdataFmintimestep=0.0, dBasicdataFmaxtimestep=0.0, iBasicdataIwritereslutfre=1, iBasicdataIn=1, bRunAPDL=False, bWriteResultDB=False, dFEndFreq=1.7976931348623157e+308, dFStartFreq=1.7976931348623157e+308, iFulltransdataIsolutionoption=0, dFulltransdataFpropchange=0.05, iFulltransdataIpointnum=64, dFulltransdataFmintemp=0.0, dFulltransdataFmaxtemp=0.0, iFulltransdataIequationsolv=0, dFulltransdataFtollevel=0.0, dFulltransdataFmultiplier=0.0, bFulltransdataBsignleprecision=False, bFulltransdataBmemorysave=False, dFulltransdataFtempdiff=1.1, dHarmonicdataFstartfreq=0.0, dHarmonicdataFendfreq=1.0, iHarmonicdataNsubsteps=0, dHarmonicdataFalphad=0.0, dHarmonicdataFbetad=0.0, dHarmonicdataFdmprat=0.0, bHarmonicdataBoutputdisplacements=False, bHarmonicdataBoutputstrain=False, bHarmonicdataBoutputstress=False, iLCId=0, iModeShape=0, iModaldataImodemethod=0, iModaldataIextractnum=1, bModaldataBexpandshape=True, iModaldataIexpandnum=0, bModaldataBuseapprox=False, bModaldataBinclprsseff=False, bModaldataBmemorysave=False, bModaldataBrsvec=False, bModaldataBoutputdisplacements=False, bModaldataBoutputstrain=False, bModaldataBoutputstress=False, iReduceddataIprintnum=0, bSsdataBmemorysave=False, bSsdataBoutputheatflux=False, bSsdataBoutputtemperature=False, bSsdataBpivotscheck=True, bSsdataBsignleprecision=False, dSsdataFmultiplier=0.0, dSsdataFtempdiff=0.0, dSsdataFtollevel=0.0, iSsdataIadaptivedes=0, iSsdataIequationsolv=0, iSsdataInpoption=0, strAnsysVersion='', strCommandLineOption='', bOutputSOLVE=False, iSubspacedataIrigidmode=0, iSubspacedataIworksize=8, iSubspacedataInpadnum=4, iSubspacedataIblocknum=5, iSubspacedataImaxiteratcnt=0, iSubspacedataIminnshift=0, iSubspacedataIseqcheck=0, bTransientdataBtraneffect=True, iTransientdataIloadingtype=0, dTransientdataFmassmatrixmult=0.0, dTransientdataFstiffmatrixmult=0.0, bTransientdataBmidstep=False, dTransientdataFtolerancebisection=0.0, dTransientdataFtolerancetimestep=0.0, iTransientdataItimeinteralgor=0, iTransientdataItimeinter=0, dTransientdataFgamma=0.005, dTransientdataFalpha=0.25250625, dTransientdataFdelta=0.505, dTransientdataFalphaf=0.005, dTransientdataFalpham=0.0, bTransientdataBoutputtemperature=False, bTransientdataBoutputheatflux=False, crEdit=None)


```

## Analysis.Ansys.LinearStatic

```text
Analysis.Ansys.LinearStatic(strJobName, strAnsysJobName='Job1', strAnsysJobDescription='', ansysAnalysisBasic=BASIC(), bRunAPDL=False, bWriteResultDB=False, iLoadCaseId=0, strAnsysVersion='', strCommandLineOption='', bOutputSOLVE=False, crEdit=None, strFileName='', iVersion=0, iJobdataAnatype=0, iJobdataSoltype=0, strJobdataJobname='Job1', strJobdataJobdescription='', bBasicdataBoutputdisplacements=False, bBasicdataBoutputreactionload=False, bBasicdataBoutputstrain=False, bBasicdataBoutputstress=False, iBasicdataIanalysisopt=0, bBasicdataBcalPressEffects=False, dBasicdataFunitem=0.0, dBasicdataFreftemp=0.0, dBasicdataFendloadtime=0.0, iBasicdataItimestep=0, iBasicdataIstepchosen=0, iBasicdataIsubstepnum=0, iBasicdataImaxsubstep=0, iBasicdataIminstepnum=0, dBasicdataFtimestepsize=0.0, dBasicdataFmintimestep=0.0, dBasicdataFmaxtimestep=0.0, iBasicdataIwritereslutfre=1, iBasicdataIn=1, dFEndFreq=1.7976931348623157e+308, dFStartFreq=1.7976931348623157e+308, iFulltransdataIsolutionoption=0, dFulltransdataFpropchange=0.05, iFulltransdataIpointnum=64, dFulltransdataFmintemp=0.0, dFulltransdataFmaxtemp=0.0, iFulltransdataIequationsolv=0, dFulltransdataFtollevel=0.0, dFulltransdataFmultiplier=0.0, bFulltransdataBsignleprecision=False, bFulltransdataBmemorysave=False, dFulltransdataFtempdiff=1.1, dHarmonicdataFstartfreq=0.0, dHarmonicdataFendfreq=1.0, iHarmonicdataNsubsteps=0, dHarmonicdataFalphad=0.0, dHarmonicdataFbetad=0.0, dHarmonicdataFdmprat=0.0, bHarmonicdataBoutputdisplacements=False, bHarmonicdataBoutputstrain=False, bHarmonicdataBoutputstress=False, iLCId=0, iModeShape=0, iModaldataImodemethod=0, iModaldataIextractnum=1, bModaldataBexpandshape=True, iModaldataIexpandnum=0, bModaldataBuseapprox=False, bModaldataBinclprsseff=False, bModaldataBmemorysave=False, bModaldataBrsvec=False, bModaldataBoutputdisplacements=False, bModaldataBoutputstrain=False, bModaldataBoutputstress=False, iReduceddataIprintnum=0, bSsdataBmemorysave=False, bSsdataBoutputheatflux=False, bSsdataBoutputtemperature=False, bSsdataBpivotscheck=True, bSsdataBsignleprecision=False, dSsdataFmultiplier=0.0, dSsdataFtempdiff=0.0, dSsdataFtollevel=0.0, iSsdataIadaptivedes=0, iSsdataIequationsolv=0, iSsdataInpoption=0, iSubspacedataIrigidmode=0, iSubspacedataIworksize=8, iSubspacedataInpadnum=4, iSubspacedataIblocknum=5, iSubspacedataImaxiteratcnt=0, iSubspacedataIminnshift=0, iSubspacedataIseqcheck=0, bTransientdataBtraneffect=True, iTransientdataIloadingtype=0, dTransientdataFmassmatrixmult=0.0, dTransientdataFstiffmatrixmult=0.0, bTransientdataBmidstep=False, dTransientdataFtolerancebisection=0.0, dTransientdataFtolerancetimestep=0.0, iTransientdataItimeinteralgor=0, iTransientdataItimeinter=0, dTransientdataFgamma=0.005, dTransientdataFalpha=0.25250625, dTransientdataFdelta=0.505, dTransientdataFalphaf=0.005, dTransientdataFalpham=0.0, bTransientdataBoutputtemperature=False, bTransientdataBoutputheatflux=False, crAnsysJob=None)


```

## Analysis.Ansys.NormalModes

```text
Analysis.Ansys.NormalModes(strJobName, strAnsysJobname='Job1', strAnsysJobdescription='', bRunAPDL=False, bWriteResultDB=False, dEndFreq=1.7976931348623157e+308, dStartFreq=1.7976931348623157e+308, iLoadCaseId=0, ansysAnalysisModal=MODAL(), strAnsysVersion='', strCommandLineOption='', bOutputSOLVE=False, crEdit=None, strFileName='')


```

## Analysis.Ansys.Steady

```text
Analysis.Ansys.Steady(strJobName, strAnsysJobname='Job1', strAnsysJobdescription='', ansysAnalysisBasic=BASIC(), bRunAPDL=False, bWriteResultDB=False, iLoadCaseId=0, ansysAnalysisSteadyStatic=STEADY_STATIC(), strAnsysVersion='', strCommandLineOption='', bOutputSOLVE=False, crEdit=None, strFileName='')


```

## Analysis.ExportAbaqus

```text
Analysis.ExportAbaqus(crAbaJob=None, crlParts=[], strInpPath='')


```

## Analysis.ExportAdx

```text
Analysis.ExportAdx(crJob, strPath, iNumType=0, iUiWidth=10, iUiPrecision=1)


```

## Analysis.ExportAnsys

```text
Analysis.ExportAnsys(strName='', crAnsysJob=None)


```

## Analysis.ExportLsdyna

```text
Analysis.ExportLsdyna(strPath='', crJob=None)


```

## Analysis.LSDYNAJob

```text
Analysis.LSDYNAJob(crEdit=None)


```

## Analysis.ModifyLbcToStep

```text
Analysis.ModifyLbcToStep(listAbaqusLbcStepInfo=[])


```

## Analysis.Nastran.LinearBuckling

```text
Analysis.Nastran.LinearBuckling(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.Nastran.LinearStatic

```text
Analysis.Nastran.LinearStatic(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.Nastran.ModalFrequencyResponse

```text
Analysis.Nastran.ModalFrequencyResponse(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.Nastran.ModalTransientResponse

```text
Analysis.Nastran.ModalTransientResponse(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.Nastran.NormalModes

```text
Analysis.Nastran.NormalModes(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.Nastran.SteadyState

```text
Analysis.Nastran.SteadyState(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.Nastran.Transient

```text
Analysis.Nastran.Transient(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.NastranJob

```text
Analysis.NastranJob(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=False, iDummyPropMaterialID=0, crEdit=None)


```

## Analysis.Permas.Job

```text
Analysis.Permas.Job(strName, strDescription, iType, crEdit, crlTargets, bElStress, bElStressMis, bElStrain, bNodeStess, bGZip, bIdeas, bNLResult, iNLStepType, dEquiStart, dEquiStep, dEquiEnd, strNLStepList, bTimeStep, iTimeStepKind, dTimeStart, dTimeStep, dTimeEnd, iLCId)


```

## Analysis.TSSS.LinearBuckling

```text
Analysis.TSSS.LinearBuckling(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.TSSS.LinearStatic

```text
Analysis.TSSS.LinearStatic(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0, iInitTempType=0)


```

## Analysis.TSSS.ModalFrequencyResponse

```text
Analysis.TSSS.ModalFrequencyResponse(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.TSSS.NonlinearStatic

```text
Analysis.TSSS.NonlinearStatic(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), iRadialReturn=2147483647, listNastranNonlinear=[], crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.TSSS.NormalModes

```text
Analysis.TSSS.NormalModes(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0, iDofId=0, iInterior_Mode=2147483647, nastranFMBDSetting=NASTRAN_FMBD_SETTING())


```

## Analysis.TSSS.SteadyStateHeatTransfer

```text
Analysis.TSSS.SteadyStateHeatTransfer(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.TSSS.TransientHeatTransfer

```text
Analysis.TSSS.TransientHeatTransfer(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='', iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)


```

## Analysis.TSSolver.ExportDynamisBdf

```text
Analysis.TSSolver.ExportDynamisBdf(strPath, crJob)


```

## Analysis.TSSolver.Job

```text
Analysis.TSSolver.Job(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None)


```

## Analysis.TSSolver.LinearBucking

```text
Analysis.TSSolver.LinearBucking(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.LinearStatic

```text
Analysis.TSSolver.LinearStatic(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.ModalFrequencyResponse

```text
Analysis.TSSolver.ModalFrequencyResponse(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.ModalTransientResponse

```text
Analysis.TSSolver.ModalTransientResponse(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.NonlinearFrequency

```text
Analysis.TSSolver.NonlinearFrequency(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.NonlinearStatic

```text
Analysis.TSSolver.NonlinearStatic(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.NormalModes

```text
Analysis.TSSolver.NormalModes(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.SteadyStateHeatTransfer

```text
Analysis.TSSolver.SteadyStateHeatTransfer(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Analysis.TSSolver.TransientHeatTransfer

```text
Analysis.TSSolver.TransientHeatTransfer(strName='Job_1', strDescription='', crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), crEdit=None, strPath='')


```

## Assemble.AddBoss

```text
Assemble.AddBoss(crPart=None, iType=0, bMerge=True, posOrgCenter=[0, 0, 0], vecOrgDirection=[0, 0, 0], crCoord=None, iAxis=0, dAngle=0.0, bHollow=False, dInnerRadius=0.0, dOrgOuterRadius=1.0, dTaperAngle=0.0, iNodeOnCircle=12, iNodeOnAxis=2, dOriginalHeight=5.0)


```

## Assemble.AddRib

```text
Assemble.AddRib(crPart=None, crlFaces=[], veclPoints=[], dWidth=0.0, dDepth=0.0)


```

## Assemble.AddRibPart

```text
Assemble.AddRibPart(crlFaces, crPart, bAutoRemesh=True)


```

## Assemble.AssembleFace

```text
Assemble.AssembleFace(crlParts, crlFaces, dTolerance, iFitEdge, iMeshSetting)


```

## Assemble.AssembleFaceEx

```text
Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace, dTolerance=0.1, iTypeConnectPos=1, bFitEdge=False)


```

## Assemble.AssembleFaces

```text
Assemble.AssembleFaces(ilPairFaceToMakeShareFace=[], dTolerance=0.1, iTypeConnectPos=1, bUseSnapInput=False, dSnapTolerance=0.005, bFitEdge=False)


```

## Assemble.Boolean

```text
Assemble.Boolean(crlParts, iBooleanType=0, dToleranceAlignment=0.01, bLeaveOriginalBodies=False)


```

## Assemble.BooleanEx

```text
Assemble.BooleanEx(crlTargetParts, strPartNameSuffix='Boolean', iBooleanType=0, bLeaveOriginalPart=False, bImprintCrossLine=False, iTargetPart=0)


```

## Assemble.CylinderLayer

```text
Assemble.CylinderLayer(crFace=None, crNode=None)


```

## Assemble.FindMatingFace

```text
Assemble.FindMatingFace(crlMasterFaces=[], crlSlaveFaces=[], crlParts=[], dTolerance=0.0)


```

## Assemble.FindMatingFaceEx

```text
Assemble.FindMatingFaceEx(crlTaMasterFaces=[], crlTaSlaveFaces=[], crlTaBodies=[], dMatingTol=0.1)


```

## Assemble.FullLayer

```text
Assemble.FullLayer(crPart, dLayerWidth=1.0, iLayer=1, bUsePyramid=False)


```

## Assemble.GeneralLayer

```text
Assemble.GeneralLayer(crlFaces=[], dWidth=1.0, iLayer=1, bSeparatePart=False, bForceStitchToSide=False, bSmoothingEdge=False, bNoImprint=False, bWidthOnSurface=False, bMakeHexa=False)


```

## Assemble.SeparateFaces.AllSharedNodes

```text
Assemble.SeparateFaces.AllSharedNodes()


```

## Assemble.SeparateFaces.Shell

```text
Assemble.SeparateFaces.Shell(iType=0, crlEntity=[], bCreateGroup=False)


```

## Assemble.SeparateFaces.Solid

```text
Assemble.SeparateFaces.Solid(crlParts=[], crlFaces=[], iCreateGroup=0)


```

## Assemble.SharedFace

```text
Assemble.SharedFace()


```

## Assembly.RightClick.AddSubAssembly

```text
Assembly.RightClick.AddSubAssembly(crInst=None)


```

## Assembly.RightClick.AddToReference

```text
Assembly.RightClick.AddToReference(crSrcPart, crDestPart)


```

## Assembly.RightClick.ChangeBodyColor

```text
Assembly.RightClick.ChangeBodyColor(listPartColorPair=[], bResetFaceColor=False)


```

## Assembly.RightClick.ChangeEntityColor

```text
Assembly.RightClick.ChangeEntityColor(crlEntities, iColor=0)


```

## Assembly.RightClick.ChangeMeshLineColor

```text
Assembly.RightClick.ChangeMeshLineColor(crlFaces, iColor=0)


```

## Assembly.RightClick.Rename

```text
Assembly.RightClick.Rename(strNewName='New name', crItem=None)


```

## Assembly.RightClick.RestoreOriginalPart

```text
Assembly.RightClick.RestoreOriginalPart(crlBodies=[], bKeepShareFace=False)


```

## Assembly.RightClick.Suppress

```text
Assembly.RightClick.Suppress(crlParts=[])


```

## Assembly.RightClick.TransferDocumentData

```text
Assembly.RightClick.TransferDocumentData(strSourceDocTitle, strDestDocTitle, crlParts, strlNewPartName, crDestAssemblyInstance=None, bEnableCutOperation=False)


```

## Assembly.RightClick.UnSuppress

```text
Assembly.RightClick.UnSuppress(crlParts=[])


```

## BoundaryConditions.BodyLoads.CentrifugalForce.CoordinateSystems

```text
BoundaryConditions.BodyLoads.CentrifugalForce.CoordinateSystems(crlTargets, strName='CentrifugalForce1', dVelocity=1.7976931348623157e+308, dAcceleration=1.7976931348623157e+308, iAxisDirection=0, iVelocityUnit=0, iAccelerationUnit=0, crCurCoord=None, crEdit=None)


```

## BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions

```text
BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions(crlTargets, strName='CentrifugalForce1', dBasePointX=0.0, dBasePointY=0.0, dBasePointZ=0.0, dTipPointX=0.0, dTipPointY=0.0, dTipPointZ=0.0, dVelocity=0.0, dAcceleration=0.0, iVelocityUnit=0, iAccelerationUnit=0, crEdit=None)


```

## BoundaryConditions.BodyLoads.Gravity

```text
BoundaryConditions.BodyLoads.Gravity(strName, dlGravity, crCurCoord=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.BoundaryTemperature.Constant

```text
BoundaryConditions.BoundaryTemperature.Constant(strName='BoundaryTemperature_1', dFTemp=0.0, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.BoundaryTemperature.SurfaceMapping

```text
BoundaryConditions.BoundaryTemperature.SurfaceMapping(strName='MappingTemperature', crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr0=0, iMappedCpIndexArr1=0, dScaleFactor=1, posOffset=[0, 0, 0], posRotate=[0, 0, 0], dCorScale=1, dSearchRange=0, iUnit=0, strPath='', crEdit=None, iMappingMethod=0, iSubmodeLBCMappingType=3, iMappingFromStepNo=0, bSetADVCFile=False, strADVCResultFile='', bSetDetATol=False, dDetATol=1.7976931348623157e+308, bSetElementSet=False, strElementSet='all')


```

## BoundaryConditions.Convection.Constant

```text
BoundaryConditions.Convection.Constant(strName='Convection_1', dExternalTemp=1.7976931348623157e+308, crTableTimeTemp=None, dConvectionCoef=1.7976931348623157e+308, crTableTimeCoeff=None, crTableTempCoeff=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Convection.SurfaceMapping

```text
BoundaryConditions.Convection.SurfaceMapping(strName='MappingConvection1', crlTargets=[], iPos=0, iViewCp=0, iCp=0, iSrcType=0, iMappedCpIndex0=0, iMappedCpIndex1=0, dRScale=1.0, posOffset=[0, 0, 0], posAxis=[0, 0, 0], dTScale=1.0, dSearchRange=1.0, iHTCUnit=0, iTempUnit=0, strPath='', crEdit=None)


```

## BoundaryConditions.DofSet

```text
BoundaryConditions.DofSet(crlTargets, strName='', iDwDof=0, crCurCoord=None, crTable=None, crEdit=None)


```

## BoundaryConditions.EnforcedLoads.Acceleration

```text
BoundaryConditions.EnforcedLoads.Acceleration(strName='EnforcedAcceleration1', dAccelUx=1.7976931348623157e+308, dAccelUy=1.7976931348623157e+308, dAccelUz=1.7976931348623157e+308, dAccelRx=1.7976931348623157e+308, dAccelRy=1.7976931348623157e+308, dAccelRz=1.7976931348623157e+308, crCurCoord=None, iArrowDir=0, crTable=None, dPhase=1.7976931348623157e+308, dDelay=1.7976931348623157e+308, crPhaseTable=None, bExport=False, crMEExportUx=None, crMEExportUy=None, crMEExportUz=None, crMEExportRx=None, crMEExportRy=None, crMEExportRz=None, iAccelTransUnit=0, iAccelRotUnit=0, crlTargets=[], crEdit=None)


```

## BoundaryConditions.EnforcedLoads.Displacement

```text
BoundaryConditions.EnforcedLoads.Displacement(strName='', iDof=0, dDispUx=1.7976931348623157e+308, dDispUy=1.7976931348623157e+308, dDispUz=1.7976931348623157e+308, dDispRx=1.7976931348623157e+308, dDispRy=1.7976931348623157e+308, dDispRz=1.7976931348623157e+308, crCoord=None, iArrowDir=0, crTable=None, crNodeSet=None, dPhase=1.7976931348623157e+308, dDelay=1.7976931348623157e+308, crPhaseTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.EnforcedLoads.Velocity

```text
BoundaryConditions.EnforcedLoads.Velocity(strName='EnforcedVelocity1', enforceVelocity=ENFORCED_VELOCITY_LBC(), crlTargets=[], crEdit=None, bADVCStatic=False)


```

## BoundaryConditions.FieldData

```text
BoundaryConditions.FieldData(strName='', iType=0, ilSheet=[], crEdit=None, bAbaqusAmp=False, iAmpType=0)


```

## BoundaryConditions.FieldDataEx

```text
BoundaryConditions.FieldDataEx(strName='', iType=0, strPath='', crEdit=None, bAbaqusAmp=False, iAmpType=0)


```

## BoundaryConditions.FixedConstraint

```text
BoundaryConditions.FixedConstraint(strName='Constraint1', iDwDof=7, crCurCoord=None, iType=0, iUsetType=0, crTable=None, bAbaqusFixed=False, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Force.FunctionLoadCylinder.Quadratic

```text
BoundaryConditions.Force.FunctionLoadCylinder.Quadratic(strName='ForceQuadratic1', dFTotalForce=0.0, dA=0.0, dB=0.0, crCoord=None, iAngleBase=0, dAngleRange=0.0, iEnArrowDir=0, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Force.FunctionLoadCylinder.Sine

```text
BoundaryConditions.Force.FunctionLoadCylinder.Sine(strName='ForceSine1', dFTotalForce=0.0, dA=0.0, crCoord=None, iAngleBase=0, dAngleRange=0.0, iEnArrowDir=0, bDistributeInAxis=False, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Force.FunctionLoadCylinder.Vector

```text
BoundaryConditions.Force.FunctionLoadCylinder.Vector(strName='ForceVector1', dFTotalForce=1.7976931348623157e+308, dA=1.7976931348623157e+308, dX=1.7976931348623157e+308, dY=1.7976931348623157e+308, crCoord=None, iEnDirection=0, dAngleRange=0.0, iArrowDir=0, bDistributeInAxis=False, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Force.General

```text
BoundaryConditions.Force.General(strName='Force1', forceLBC=FORCE_LBC(), crlTargets=[], crEdit=None)


```

## BoundaryConditions.Force.NonlinearForce.NOLIN1

```text
BoundaryConditions.Force.NonlinearForce.NOLIN1(strName='NonlinearForce1_1', dForceScale=0.0, dMomentScale=0.0, iForcDir=0, iForceDepends=0, iMomentDir=0, iMomentDepends=0, crCoord=None, crForceTable=None, crMomentTable=None, crlMaster=[], crlSlave=[], crEdit=None)


```

## BoundaryConditions.Force.NonlinearForce.NOLIN3

```text
BoundaryConditions.Force.NonlinearForce.NOLIN3(strName, dForceScale=0.0, dMomentScale=0.0, dForcePowerA=0.0, dMomentPowerA=0.0, iForcDir=0, iForceDepends=0, iMomentDir=0, iMomentDepends=0, crCurCoord=None, crlMasterTargets=[], crlSlaveTargets=[], crEdit=None)


```

## BoundaryConditions.Force.NonlinearForce.NOLIN4

```text
BoundaryConditions.Force.NonlinearForce.NOLIN4(strName, dForceScale=0.0, dMomentScale=0.0, dForcePowerA=0.0, dMomentPowerA=0.0, iForcDir=0, iForceDepends=0, iMomentDir=0, iMomentDepends=0, crCurCoord=None, crlMasterTargets=[], crlSlaveTargets=[], crEdit=None)


```

## BoundaryConditions.Force.NormalDirection

```text
BoundaryConditions.Force.NormalDirection(strName='Force1', dForce=1, crElemForNormal=None, iArrowDir=0, iDistributeType=0, crCoord=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.HeatFlux.ConcentrateFlux

```text
BoundaryConditions.HeatFlux.ConcentrateFlux(strName='ConcentrateHeatFlux1', dflux=0.0, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.HeatFlux.SurfaceFlux

```text
BoundaryConditions.HeatFlux.SurfaceFlux(strName, dFflux, iDistributionMethod, crTable, crlTargets, crEdit=None)


```

## BoundaryConditions.HeatFlux.SurfaceMapping

```text
BoundaryConditions.HeatFlux.SurfaceMapping(strName='MappingHeatFlux', crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr0=0, dScaleFactor=1, posOffset=[0, 0, 0], posRotate=[0, 0, 0], dCorScale=1, dSearchRange=0, iUnit=0, strStrpath='', crEdit=None, iMappingMethod=0, iSubmodeLBCMappingType=4, iMappingFromStepNo=0, bSetADVCFile=False, strADVCResultFile='', bSetDetATol=False, dDetATol=1.7976931348623157e+308, bSetElementSet=False, strElementSet='all')


```

## BoundaryConditions.InitialElementalValue.InitialStress

```text
BoundaryConditions.InitialElementalValue.InitialStress(strName='InitialStress1', iDimension=2, iElemCs=0, dSXX=1.7976931348623157e+308, dSYY=1.7976931348623157e+308, dSXY=1.7976931348623157e+308, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialNodalValue.Displacement

```text
BoundaryConditions.InitialNodalValue.Displacement(strName='InitialDisplacement1', iType=0, vecInit=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], bSelNode=False, crNodeSet=None, crTable=None, crCoord=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialNodalValue.InitialAngularVelocity.Abaqus

```text
BoundaryConditions.InitialNodalValue.InitialAngularVelocity.Abaqus(strName='InitialAngularVelocityAbaqus1', dVelocity=1.7976931348623157e+308, strFirstCoord='', strSecondCoord='', crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialNodalValue.InitialAngularVelocity.General

```text
BoundaryConditions.InitialNodalValue.InitialAngularVelocity.General(strName='InitialAngularVelocity1', stData=LBC_DYNAMIC_INITIAL_CONDITION_DATA(), crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialNodalValue.RotationAngle

```text
BoundaryConditions.InitialNodalValue.RotationAngle(strName='InitialVelocity1', stData=LBC_DYNAMIC_INITIAL_CONDITION_DATA(), crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialNodalValue.Velocity

```text
BoundaryConditions.InitialNodalValue.Velocity(strName='InitialRotationAngle1', stData=LBC_DYNAMIC_INITIAL_CONDITION_DATA(), crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialTemperature.ADVC

```text
BoundaryConditions.InitialTemperature.ADVC(strName='InitialTemperature1', strFilePathName='', iLocalTemperatureUnit=0, bUseDefault=False, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialTemperature.Constant

```text
BoundaryConditions.InitialTemperature.Constant(strName='InitialTemperature1', dFTemp=0.0, strFilePathName='', iLocalTemperatureUnit=0, bUseDefault=False, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialTemperature.NastranPunch

```text
BoundaryConditions.InitialTemperature.NastranPunch(strName='InitialTemperature1', strFilePathName='', iLocalTemperatureUnit=0, bUseDefault=False, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.InitialTemperature.WholeMapping

```text
BoundaryConditions.InitialTemperature.WholeMapping(strName='TemperatureInitsWholeMapping1', iMapSourceType=0, strPath='', iMappingMethod=0, iIsubcase=0, crEdit=None)


```

## BoundaryConditions.InsideHeatGeneration

```text
BoundaryConditions.InsideHeatGeneration(strName='InsideHeatGeneration1', dInsideFlux=1.7976931348623157e+308, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.LBCCopy.ConnectionCopyMirror

```text
BoundaryConditions.LBCCopy.ConnectionCopyMirror(iMethod=2, iMatchMethod=0, poslPoints=[], dOffset=0, dTol=1, crlTargets=[])


```

## BoundaryConditions.LBCCopy.ConnectionCopyRotate

```text
BoundaryConditions.LBCCopy.ConnectionCopyRotate(iMethod=1, iMatchMethod=0, posAxis=[0, 0, 0], posCenter=[0, 0, 0], dAngle=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.ConnectionCopyTranslate

```text
BoundaryConditions.LBCCopy.ConnectionCopyTranslate(iMethod=0, iMatchMethod=0, posVecTrans=[0, 0, 0], dMagnitude=1, dTrandataDoffset=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.GroupCopyMirror

```text
BoundaryConditions.LBCCopy.GroupCopyMirror(iMethod=2, iMatchMethod=0, poslPoints=[], dOffset=0, dTol=1, crlTargets=[])


```

## BoundaryConditions.LBCCopy.GroupCopyRotate

```text
BoundaryConditions.LBCCopy.GroupCopyRotate(iMethod=1, iMatchMethod=0, posAxis=[0, 0, 0], posCenter=[0, 0, 0], dAngle=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.GroupCopyTranslate

```text
BoundaryConditions.LBCCopy.GroupCopyTranslate(iMethod=0, iMatchMethod=0, posVecTrans=[0, 0, 0], dMagnitude=1, dTrandataDoffset=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.LBCCopyMirror

```text
BoundaryConditions.LBCCopy.LBCCopyMirror(iMethod=2, iMatchMethod=0, poslPoints=[], dOffset=0, dTol=1, crlTargets=[])


```

## BoundaryConditions.LBCCopy.LBCCopyRotate

```text
BoundaryConditions.LBCCopy.LBCCopyRotate(iMethod=1, iMatchMethod=0, posAxis=[0, 0, 0], posCenter=[0, 0, 0], dAngle=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.LBCCopyTranslate

```text
BoundaryConditions.LBCCopy.LBCCopyTranslate(iMethod=0, iMatchMethod=0, posVecTrans=[0, 0, 0], dMagnitude=1, dTrandataDoffset=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.PropertiesCopyMirror

```text
BoundaryConditions.LBCCopy.PropertiesCopyMirror(iMethod=2, iMatchMethod=0, poslPoints=[], dOffset=0, dTol=1, crlTargets=[])


```

## BoundaryConditions.LBCCopy.PropertiesCopyRotate

```text
BoundaryConditions.LBCCopy.PropertiesCopyRotate(iMethod=1, iMatchMethod=0, posAxis=[0, 0, 0], posCenter=[0, 0, 0], dAngle=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopy.PropertiesCopyTranslate

```text
BoundaryConditions.LBCCopy.PropertiesCopyTranslate(iMethod=0, iMatchMethod=0, posVecTrans=[0, 0, 0], dMagnitude=1, dTrandataDoffset=0.0, dTol=1, crCoord=None, crlTargets=[])


```

## BoundaryConditions.LBCCopyMisc

```text
BoundaryConditions.LBCCopyMisc(iMethod=0, iMatchMethod=0, dlTransVec=[0, 0, 0], dTransMag=0, dTransOffset=0, dTransTol=0, crTranscrCoord=None, dlTransaxisVec=[0, 0, 0], dlTranscenterVec=[0, 0, 0], dRotateAngle=0, dRotateTol=0, crRotatecrCoord=None, veclMirrorPoint=[], dMirrordOffset=0, dMirrorTol=0.1, crlTargets=[])


```

## BoundaryConditions.LbcContactConvert

```text
BoundaryConditions.LbcContactConvert(iConvertTo, iTieConvType, crlTargets)


```

## BoundaryConditions.LoadCase

```text
BoundaryConditions.LoadCase(strName='LoadCase1', dFactor=1.0, crlTargets=[], iExportId=1, dlTargetFactor=[], crEdit=None)


```

## BoundaryConditions.Pressure.By2Nodes

```text
BoundaryConditions.Pressure.By2Nodes(strName='PressureLinear1', crNodeA=None, dPressureA=0.0, iNodeAUnit=0, crNodeB=None, dPressureB=0.0, iNodeBUnit=0, iDirection=0, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Pressure.FunctionLoadToCylinderSine

```text
BoundaryConditions.Pressure.FunctionLoadToCylinderSine(strName='PressureSine1', dA=0.0, crCoordinate=None, dAngleRange=0.0, bDistributionAxis=False, iPressureDirectionMode=0, bIsTotalForceAdjustment=False, dTotalForce=0.0, vecPressureDirection=[0.0, 0.0, 0.0], crCoordinateSystemForDirection=None, bIsCornerNodesDistribution=False, strFormulaForA='', crlTargets=[], crEdit=None)


```

## BoundaryConditions.Pressure.General

```text
BoundaryConditions.Pressure.General(strName='Pressure1', dPressure=0.0, iDistribute=0, crTable=None, dPhase=0.0, dDelay=0.0, crPhaseTable=None, strFormulaValue='', crCoord=None, dlDirection=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], strFormulaDirX='', strFormulaDirY='', strFormulaDirZ='', iArrowDir=1, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Pressure.Hydrostatic

```text
BoundaryConditions.Pressure.Hydrostatic(strName='PressureHydrostatic1', dFHPressure=0.0, dFDensity=0.0, iDensityUnit=0, dFGravity=0.0, iGravityUnit=0, iGravityDir=0, dFWaterSuface=0.0, iSufaceUnit=0, iDistributionMethod=0, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Pressure.Quadratic

```text
BoundaryConditions.Pressure.Quadratic(strName='PressureQuadratic1', dA=0.0, dB=0.0, crCoordinate=None, dAngleRange=0.0, iPressureDirectionMode=0, dlPressureDirection=[0.0, 0.0, 0.0], crlTargets=[], crEdit=None)


```

## BoundaryConditions.Pressure.SurfaceLoads

```text
BoundaryConditions.Pressure.SurfaceLoads(strName='SurfaceLoads1', dlPressure=[0, 0, 0], iArrowDir=0, crCoordinate=None, crlTargetFace=[], crEditCur=None)


```

## BoundaryConditions.Pressure.SurfaceMapping

```text
BoundaryConditions.Pressure.SurfaceMapping(strName='MappingPressure', crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr=0, dScaleFactor=1, posOffset=[0, 0, 0], posRotate=[0, 0, 0], dCorScale=1, dSearchRange=0, iUnit=0, strPath='', crEdit=None)


```

## BoundaryConditions.Submodel.ForcedDisplacement

```text
BoundaryConditions.Submodel.ForcedDisplacement(strName='SubmodelForcedDisplacement1', iSolver=0, strDataDirectory='/home/', iProcessNo=0, bMapX=True, bMapY=True, bMapZ=True, iReferType=0, dExtensionRange=1.7976931348623157e+308, dExtensionTol=1.7976931348623157e+308, dExtensionLimitTol=1.7976931348623157e+308, strGlobalElementSet='', iUseBucket=0, iNumBucketMaxX=2147483647, iNumBucketMaxY=2147483647, iNumBucketMaxZ=2147483647, iPrevBc=0, crlTargets=[], crForcedDispBC=None)


```

## BoundaryConditions.Submodel.ForcedTempertature

```text
BoundaryConditions.Submodel.ForcedTempertature(strName='SubmodelForcedTemperature1', iSolver=0, strFilePathName='/home/', iProcessNo=0, iReferType=0, dExtensionRange=1.7976931348623157e+308, dExtensionTol=1.7976931348623157e+308, dExtensionLimitTol=1.7976931348623157e+308, strGlobalElementSet='', iUseBucket=-1, iNumBucketMaxX=2147483647, iNumBucketMaxY=2147483647, iNumBucketMaxZ=2147483647, iPrevBc=-1, crlTargets=[], crEdit=None)


```

## BoundaryConditions.Submodel.SubmodelForcedFlux

```text
BoundaryConditions.Submodel.SubmodelForcedFlux(strName, iSolver=0, strFilePathName='/home/', iProcessNo=0, iReferType=-1, dExtensionRange=1.7976931348623157e+308, dExtensionTol=1.7976931348623157e+308, dExtensionLimitTol=1.7976931348623157e+308, strGlobalElementSet='', iUseBucket=-1, iNumBucketMaxX=2147483647, iNumBucketMaxY=2147483647, iNumBucketMaxZ=2147483647, iPrevBc=-1, crlTargets=[], crEdit=None)


```

## BoundaryConditions.TemperatureLoads.ADVCFile

```text
BoundaryConditions.TemperatureLoads.ADVCFile(strName='TemperatureLoadsADVC1', strFilePathName='', crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.TemperatureLoads.Constant

```text
BoundaryConditions.TemperatureLoads.Constant(strName, dTemperature=0.0, crTable=None, crlTargets=[], crEdit=None, bUseDefaultTemp=False)


```

## BoundaryConditions.TemperatureLoads.LbcInitialTemperature

```text
BoundaryConditions.TemperatureLoads.LbcInitialTemperature(strName='InitialTemperature1', iType=0, dFTemp=0.0, strFilePathName='', bUseDefault=False, crTable=None, crlTargets=[], crEdit=None)


```

## BoundaryConditions.TemperatureLoads.NastranPunch

```text
BoundaryConditions.TemperatureLoads.NastranPunch(strName='TemperatureLoadsPunch1', strFilePathName='', crTable=None, crlTargets=[], crEdit=None, bUseAsMaterialReferenceTemp=False, iLocalTemperatureUnit=0)


```

## BoundaryConditions.TemperatureLoads.WholeMapping

```text
BoundaryConditions.TemperatureLoads.WholeMapping(strName='TemperatureLoadsWholeMapping', crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr0=0, iMappedCpIndexArr1=0, iDScaleFactor=1, posOffset=[0, 0, 0], posRotate=[0, 0, 0], dCorScale=1, dSearchRange=0, strPath='', crEdit=None, iMappingMethod=0, iSubmodelBCMappingType=2, iMappingFromStepNo=0, bSetADVCFile=False, strADVCResultFile='', bSetDetATol=False, dDetATol=1.7976931348623157e+308, bSetElementSet=False, strElementSet='')


```

## Connections.BarBeam

```text
Connections.BarBeam(strName, iEType=10, iMethod=1, crProp=None, dlOrient=[], crlMasterTargets=[], crlSlaveTargets=[])


```

## Connections.BoltConnections.Edge.TypeA

```text
Connections.BoltConnections.Edge.TypeA(crlEdgeCur1, crlEdgeCur2, strRbeName='RBE', strBarName='', iShaftType=0, crCurBarProperty=None, dPlaneTol=20.0, dMaxBoltHeight=100.0, bPretensionLoad=False, iSolverType=0, dForceValue=0.0, iPreTenDof=0, crCurCoord=None, iBoltFixLength=0, iTopSlot=0, dRBE1=0.0, iBotSlot=0, dRBE2=0.0, bIsCreate2ADVCStaticProcessForFixLength=False)


```

## Connections.BoltConnections.Edge.TypeB

```text
Connections.BoltConnections.Edge.TypeB(crlEdgeCur1, crlEdgeCur2, strRbeName='RBE', strBarName='', iShaftType=0, crCurBarProperty=None, dPlaneTol=20.0, dMaxBoltHeight=100.0, bPretensionLoad=False, iSolverType=0, dForceValue=0.0, iPreTenDof=0, crCurCoord=None, iBoltFixLength=0, iTopSlot=0, dRBE1=0.0, dRBE2=0.0, dBotDtDia=0.0, dPitch=10.0, iBotRbeConnType=0, bIfCreate2ADVCStaticProcessForBoltFixLength=False)


```

## Connections.BoltConnections.Edge.TypeC

```text
Connections.BoltConnections.Edge.TypeC(crlEdgeCur1, crlEdgeCur2, strRbeName='RBE', dPlaneTol=20.0, dMaxBoltHeight=100.0, iConnectionType=0, iCoincidentNodes=1, dTolerance=0.0, iGround=0, dStiffnessX=0.0, dStiffnessY=0.0, dStiffnessZ=0.0, iLocalStiffUnit=0, dRotateStiffX=0.0, dRotateStiffY=0.0, dRotateStiffZ=0.0, iLocalRotateStiffUnit=0, dDampCoef=0.0, dStressCoef=0.0, crCurCoord=None, iTopRbeType=0, dTopPitch=10, dTopRemoveDepth=0.0, iBotRbeType=0, dBotPitch=10, dBotRemoveDepth=0.0)


```

## Connections.BoltConnections.Edge.TypeD

```text
Connections.BoltConnections.Edge.TypeD(crlEdgeCur1, crlEdgeCur2, strMpcName='MPC', dConnRadius=0.0, dPlaneTol=20.0)


```

## Connections.BoltConnections.Face.TypeA

```text
Connections.BoltConnections.Face.TypeA(crlFaceCur1, crlFaceCur2, strRbeName='RBE', strBarName='', iShaftType=0, crCurBarProperty=None, dPlaneTol=20.0, dMaxBoltHeight=100.0, dMaxDiameter=0.0, dMinDiameter=0.0, bPretensionLoad=False, iSolverType=0, dForceValue=0.0, iPreTenDof=0, crCurCoord=None, iBoltFixLength=0, iTopSlot=0, dRBE1=0.0, iBotSlot=0, dRBE2=0.0, dScale1=1.1, bIfCreate2ADVCStaticProcessForBoltFixLength=False)


```

## Connections.BoltConnections.Face.TypeB

```text
Connections.BoltConnections.Face.TypeB(crlFaceCur1, crlFaceCur2, strRbeName='RBE', strBarName='', iShaftType=0, crCurBarProperty=None, dPlaneTol=20.0, dMaxBoltHeight=100.0, dMaxDiameter=0.0, dMinDiameter=0.0, bPretensionLoad=False, iSolverType=0, dForceValue=0.0, iPreTenDof=0, crCurCoord=None, iBoltFixLength=0, iTopSlot=0, dRBE1=0.0, dRBE2=0.0, dBotDtDia=0.0, dPitch=10.0, iBotRbeConnType=0, dScale1=1.1, bIsCreate2ADVCStaticProcessForFixLength=False)


```

## Connections.BoltConnections.Face.TypeC

```text
Connections.BoltConnections.Face.TypeC(crlFaceCur1, crlFaceCur2, strRbeName='RBE', dPlaneTol=20, dMaxBoltHeight=100, dMaxDiameter=0, dMinDiameter=0, iConnectionType=0, iCoincidentNodes=1, dTolerance=0.0, iGround=0, dStiffnessX=0.0, dStiffnessY=0.0, dStiffnessZ=0.0, iLocalStiffUnit=0, dRotateStiffX=0.0, dRotateStiffY=0.0, dRotateStiffZ=0.0, iLocalRotateStiffUnit=0, dDampCoef=0.0, dStressCoef=0.0, crCurCoord=None, iTopRbeType=0, dTopPitch=10, dTopRemoveDepth=0.0, iBotRbeType=0, dBotPitch=10, dBotRemoveDepth=0.0)


```

## Connections.BoltMeshingNotSplitOnly

```text
Connections.BoltMeshingNotSplitOnly(strName='', iPartcutparamImethod=0, dPartcutparamDoffset=0.0, iPartcutparamBshareface=0, iPartcutparamBseparateface=0, iPartcutparamBsplitonly=0, iPartcutparamBmakesectionface=0, crPartcutparamCoord=None, surfaceMesh=SURFACE_MESH(), iLBCPRETENSIONDATAIdir=0, dLBCPRETENSIONDATADvalue=0.0, bLBCPRETENSIONDATABfixlength=False, crLBCPRETENSIONDATACrtable=None, crLBCPRETENSIONDATACrcoord=None, iLBCPRETENSIONDATAIlocalunit=0, crlTargets=[], poslCutter=[])


```

## Connections.BoltMeshingSplitOnly

```text
Connections.BoltMeshingSplitOnly(strName='', iPartcutparamImethod=0, dPartcutparamDoffset=0.0, iPartcutparamBshareface=0, iPartcutparamBseparateface=0, iPartcutparamBsplitonly=0, iPartcutparamBmakesectionface=0, crPartcutparamCoord=None, surfaceMesh=SURFACE_MESH(), bLBCPRETENSIONABAQUSDATABfixedlenght=False, crLBCPRETENSIONABAQUSDATACrtable=None, dLBCPRETENSIONABAQUSDATADvalue=0.0, iLBCPRETENSIONABAQUSDATAIlocalunit=0, strLBCPRETENSIONABAQUSDATAStrnormal='', posLBCPRETENSIONABAQUSDATATvctrolnodepos=[0, 0, 0], crlTargets=[], poslCutter=[])


```

## Connections.Connector

```text
Connections.Connector(strName='', iMethod=1, iConnectType=0, iRefNode=0, iElemCs=0, crLocalCS=None, crlElasticity=[], crlDamp=[], crlMasterTargets=[], crlSlaveTargets=[], crEdit=None, iEffectiveDofs=0)


```

## Connections.Contacts.ADVC.ContactClearance

```text
Connections.Contacts.ADVC.ContactClearance(strName, dClearanceVal, iLocalUnit, iSolverType, crlTargets, crEdit=None)


```

## Connections.Contacts.ADVC.ContactGroupByMatrix

```text
Connections.Contacts.ADVC.ContactGroupByMatrix(strName='ContactADVC', iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=1.7976931348623157e+308, dKineticFrictionCoef=1.7976931348623157e+308, dExponentialCoef=1.7976931348623157e+308, iBehavior=0, dClearance=1.7976931348623157e+308, iAdjust2Clearance=0, dInterference=1.7976931348623157e+308, iAdjust2Interference=0, iAutoShrink=0, iAdvAdjust=0, dAdjustValue=1.7976931348623157e+308, dFrictionCoef=1.7976931348623157e+308, dMaxShear=1.7976931348623157e+308, dElasticSlip=1.7976931348623157e+308, dSlipTolerance=1.7976931348623157e+308, dSearchWidth=1.7976931348623157e+308, dSearchGap=1.7976931348623157e+308, dSearchDepth=1.7976931348623157e+308, dCritialPenetration=1.7976931348623157e+308, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iDataType=0, iTypeId=0, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[], bStabilized=0, iStabilizeType=0, dResidualFactor=1.7976931348623157e+308, dEffectiveDist=1.7976931348623157e+308, dCN=1.7976931348623157e+308, dCT=1.7976931348623157e+308, crlClearance=[], crplTarget=[], crEdit=None, dSearchAngle=1.7976931348623157e+308, iConstraintTypeExplicit=0, dPenaltyFact=1.7976931348623157e+308, dPenaltyFactExplicit=1.7976931348623157e+308, iColor=16711680, iAlg=0, iMethod=0)


```

## Connections.Contacts.ADVC.ContactShareFace

```text
Connections.Contacts.ADVC.ContactShareFace(crlShareFace=[], strName='ContactADVC', iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=1.7976931348623157e+308, dKineticFrictionCoef=1.7976931348623157e+308, dExponentialCoef=1.7976931348623157e+308, iBehavior=0, dClearance=1.7976931348623157e+308, iAdjust2Clearance=0, dInterference=1.7976931348623157e+308, iAdjust2Interference=0, iAutoShrink=0, iAdvAdjust=0, dAdjustValue=1.7976931348623157e+308, dFrictionCoef=1.7976931348623157e+308, dMaxShear=1.7976931348623157e+308, dElasticSlip=1.7976931348623157e+308, dSlipTolerance=1.7976931348623157e+308, dSearchWidth=1.7976931348623157e+308, dSearchGap=1.7976931348623157e+308, dSearchDepth=1.7976931348623157e+308, dCritialPenetration=1.7976931348623157e+308, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iDataType=0, iTypeId=0, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[], bStabilized=0, iStabilizeType=0, dResidualFactor=1.7976931348623157e+308, dEffectiveDist=1.7976931348623157e+308, dCN=1.7976931348623157e+308, dCT=1.7976931348623157e+308, crlClearance=[], crEdit=None, dSearchAngle=1.7976931348623157e+308, iConstraintTypeExplicit=0, dPenaltyFact=1.7976931348623157e+308, dPenaltyFactExplicit=1.7976931348623157e+308, iColor=16711680, iAlg=0, iMethod=3)


```

## Connections.Contacts.ADVC.ContactTable

```text
Connections.Contacts.ADVC.ContactTable(strName='ContactADVC', iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=1.7976931348623157e+308, dKineticFrictionCoef=1.7976931348623157e+308, dExponentialCoef=1.7976931348623157e+308, iBehavior=0, dClearance=1.7976931348623157e+308, iAdjust2Clearance=0, dInterference=1.7976931348623157e+308, iAdjust2Interference=0, iAutoShrink=0, iAdvAdjust=0, dAdjustValue=1.7976931348623157e+308, dFrictionCoef=1.7976931348623157e+308, dMaxShear=1.7976931348623157e+308, dElasticSlip=1.7976931348623157e+308, dSlipTolerance=1.7976931348623157e+308, dSearchWidth=1.7976931348623157e+308, dSearchGap=1.7976931348623157e+308, dSearchDepth=1.7976931348623157e+308, dCritialPenetration=1.7976931348623157e+308, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iDataType=0, iTypeId=0, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[], bStabilized=0, iStabilizeType=0, dResidualFactor=1.7976931348623157e+308, dEffectiveDist=1.7976931348623157e+308, dCN=1.7976931348623157e+308, dCT=1.7976931348623157e+308, crlClearance=[], crplTarget=[], crEdit=None, dSearchAngle=1.7976931348623157e+308, iConstraintTypeExplicit=0, dPenaltyFact=1.7976931348623157e+308, dPenaltyFactExplicit=1.7976931348623157e+308, iColor=16711680, iAlg=0, iMethod=0)


```

## Connections.Contacts.ADVC.ManualFace

```text
Connections.Contacts.ADVC.ManualFace(crlMasterFaces=[], crlSlaveFaces=[], strName='ContactADVC', iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=1.7976931348623157e+308, dKineticFrictionCoef=1.7976931348623157e+308, dExponentialCoef=1.7976931348623157e+308, iBehavior=0, dClearance=1.7976931348623157e+308, iAdjustToClearance=0, dInterference=1.7976931348623157e+308, iAdjustToInterference=0, iAutoShrink=0, iAdjust=0, dAdjustValue=1.7976931348623157e+308, dFrictionCoef=1.7976931348623157e+308, dMaxShear=1.7976931348623157e+308, dElasticSlip=1.7976931348623157e+308, dSlipTolerance=1.7976931348623157e+308, dSearchWidth=1.7976931348623157e+308, dSearchGap=1.7976931348623157e+308, dSearchDepth=1.7976931348623157e+308, dCriticalPenetration=1.7976931348623157e+308, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iThermalDataType=0, iTypeId=0, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[], bStabilized=0, iStabilizeType=0, dResidualFactor=1.7976931348623157e+308, dEffectiveDist=1.7976931348623157e+308, dCN=1.7976931348623157e+308, dCT=1.7976931348623157e+308, crlClearances=[], crContactADVC=None, dSearchAngle=1.7976931348623157e+308, iConstraintTypeExplicit=0, dPenaltyFact=1.7976931348623157e+308, dPenaltyFactExplicit=1.7976931348623157e+308, iColor=16711680, iAlgorithm=0, iMethod=0, bPressureTemperatureDependency=False, iPressureDependencies=0, tshPressureData=[])


```

## Connections.Contacts.ADVC.ManualGroup

```text
Connections.Contacts.ADVC.ManualGroup(strName='ContactADVC', iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=1.7976931348623157e+308, dKineticFrictionCoef=1.7976931348623157e+308, dExponentialCoef=1.7976931348623157e+308, iBehavior=0, dClearance=1.7976931348623157e+308, iAdjust2Clearance=0, dInterference=1.7976931348623157e+308, iAdjust2Interference=0, iAutoShrink=0, iAdvAdjust=0, dAdjustValue=1.7976931348623157e+308, dFrictionCoef=1.7976931348623157e+308, dMaxShear=1.7976931348623157e+308, dElasticSlip=1.7976931348623157e+308, dSlipTolerance=1.7976931348623157e+308, dSearchWidth=1.7976931348623157e+308, dSearchGap=1.7976931348623157e+308, dSearchDepth=1.7976931348623157e+308, dCritialPenetration=1.7976931348623157e+308, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iDataType=0, iTypeId=1, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[1, 2, 0, 0], bStabilized=0, iStabilizeType=0, dResidualFactor=1.7976931348623157e+308, dEffectiveDist=1.7976931348623157e+308, dCN=1.7976931348623157e+308, dCT=1.7976931348623157e+308, crlClearance=[], crplTarget=[], crEdit=None, dSearchAngle=1.7976931348623157e+308, iConstraintTypeExplicit=0, dPenaltyFact=1.7976931348623157e+308, dPenaltyFactExplicit=1.7976931348623157e+308, iColor=16711680, iAlg=0, iMethod=1, TypeId_pressure=2, btemperatureDependency_pressure=False, idependencies_pressure=0, table_pressure=[1, 2, 0, 0])


```

## Connections.Contacts.Abaqus.ContactGroupByMatrix

```text
Connections.Contacts.Abaqus.ContactGroupByMatrix(strName='', iContactMethod=1, iContactType=0, iAlg=0, dAdjustVal=0.0, dExtensionZone=0.0, dMaxPenetration=0.0, iSmallSliding=0, dSmooth=0.0, iFrictionType=0, dFrictionCoef1=0.0, dFrictionCoef2=0.0, dShearLimit=0.0, dSlipTol=0.0, dStaticFrictionCoef=0.0, dKineticFrictionCoef=0.0, dDecayCoef=0.0, iAdjust=0, dPositonTol=0.0, iFormula=0, iTie=0, iPOCType=0, iAllowSeparation=0, dSlope=0.0, tshPOCTsheet=[], iClearanceType=0, iClearanceTypeId=0, bTemperatureDependency=False, iDependencies=0, tshCDTsheet=[], iPrsTypeId=0, bPrsTemperatureDependency=False, iPrsDependencies=0, tshPrsDTsheet=[], crplTarget=[], crEdit=None, iColor=0)


```

## Connections.Contacts.Abaqus.ContactShareFace

```text
Connections.Contacts.Abaqus.ContactShareFace(strName='', iContactMethod=3, iContactType=0, iAlg=0, dAdjustVal=0.0, dExtensionZone=0.0, dMaxPenetration=0.0, iSmallSliding=0, dSmooth=0.0, iFrictionType=0, dFrictionCoef1=0.0, dFrictionCoef2=0.0, dShearLimit=0.0, dSlipTol=0.0, dStaticFrictionCoef=0.0, dKineticFrictionCoef=0.0, dDecayCoef=0.0, iAdjust=0, dPositonTol=0.0, iFormula=0, iTie=0, iPOCType=0, iAllowSeparation=0, dSlope=0.0, tshPOCTsheet=[], iClearanceType=0, iClearanceTypeId=0, bTemperatureDependency=False, iDependencies=0, tshCDTsheet=[], iPrsTypeId=0, bPrsTemperatureDependency=False, iPrsDependencies=0, tshPrsDTsheet=[], crplTarget=[], crEdit=None, iColor=0)


```

## Connections.Contacts.Abaqus.ContactTable

```text
Connections.Contacts.Abaqus.ContactTable(strName='ContactAbaqus_1', iContactType=0, iContactAlgorithm=0, dAdjustWidth=0.0, dExtensionZone=0.0, dMaxPenetration=0.0, iSmallSliding=0, dSmoothAngle=0.0, iFrictionType=0, dFrictionCoeff1=0.0, dFrictionCoeff2=0.0, dShearStressLimit=0.0, dSlipTolerance=0.0, dStaticFrictionCoeff=0.0, dKineticFrictionCoeff=0.0, dDecayCoeff=0.0, bAdjustPosition=False, dPositionTolerance=0.0, iFormulationType=0, iTied=0, iPressureOverclosureType=0, bAllowSeparation=False, dContactStiffness=0.0, tshPressureOverclosure=[], iThermalConductanceDef=0, bClearanceTemperatureDependency=False, iClearanceDependencies=0, tshClearanceData=[], bPressureTemperatureDependency=False, iPressureDependencies=0, tshPressureData=[], crplTargets=[], crContactAbaqus=None, iContactColor=0)


```

## Connections.Contacts.Abaqus.ManualFace

```text
Connections.Contacts.Abaqus.ManualFace(strName='ContactAbaqus_1', iContactType=0, iContactAlgorithm=0, dAdjustWidth=0.0, dExtensionZone=0.0, dMaxPenetration=0.0, iSmallSliding=0, dSmoothAngle=0.0, iFrictionType=0, dFrictionCoeff1=0.0, dFrictionCoeff2=0.0, dShearStressLimit=0.0, dSlipTolerance=0.0, dStaticFrictionCoeff=0.0, dKineticFrictionCoeff=0.0, dDecayCoeff=0.0, bAdjustPosition=False, dPositionTolerance=0.0, iFormulationType=0, iTied=0, iPressureOverclosureType=0, bAllowSeparation=False, dContactStiffness=0.0, tshPressureOverclosure=[], iThermalConductanceDef=0, bClearanceTemperatureDependency=False, iClearanceDependencies=0, tshClearanceData=[], bPressureTemperatureDependency=False, iPressureDependencies=0, tshPressureData=[], crplTargets=[], crContactAbaqus=None, iContactColor=0)


```

## Connections.Contacts.Abaqus.ManualGroup

```text
Connections.Contacts.Abaqus.ManualGroup(strName='ContactAbaqus_1', iContactType=0, iContactAlgorithm=0, dAdjustWidth=0.0, dExtensionZone=0.0, dMaxPenetration=0.0, iSmallSliding=0, dSmoothAngle=0.0, iFrictionType=0, dFrictionCoeff1=0.0, dFrictionCoeff2=0.0, dShearStressLimit=0.0, dSlipTolerance=0.0, dStaticFrictionCoeff=0.0, dKineticFrictionCoeff=0.0, dDecayCoeff=0.0, bAdjustPosition=False, dPositionTolerance=0.0, iFormulationType=0, iTied=0, iPressureOverclosureType=0, bAllowSeparation=False, dContactStiffness=0.0, tshPressureOverclosure=[], iThermalConductanceDef=0, bClearanceTemperatureDependency=False, iClearanceDependencies=0, tshClearanceData=[], bPressureTemperatureDependency=False, iPressureDependencies=0, tshPressureData=[], crplTargets=[], crContactAbaqus=None, iContactColor=0)


```

## Connections.Contacts.Ansys.ContactGroupByMatrix

```text
Connections.Contacts.Ansys.ContactGroupByMatrix(strName='ContactAnsys_1', iMethod=1, iType=0, iContactAlgorithm=0, ansysContact=ANSYS_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680)


```

## Connections.Contacts.Ansys.ContactShareFace

```text
Connections.Contacts.Ansys.ContactShareFace(crlShareFaces=[], strName='ContactAnsys_1', iBehaviorType=0, iContactType=0, ansysContact=ANSYS_CONTACT(), crContactAnsys=None, iContactColor=16711680)


```

## Connections.Contacts.Ansys.ContactTable

```text
Connections.Contacts.Ansys.ContactTable(strName='ContactAnsys_1', iMethod=1, iType=0, iContactAlgorithm=0, ansysContact=ANSYS_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680)


```

## Connections.Contacts.Ansys.ManualFace

```text
Connections.Contacts.Ansys.ManualFace(crlMasterFaces, crlSlaveFaces, strName='ContactAnsys_1', iContactType=0, iContactAlgorithm=0, ansysContact=ANSYS_CONTACT(), crEdit=None, iColor=16711680)


```

## Connections.Contacts.Ansys.ManualGroup

```text
Connections.Contacts.Ansys.ManualGroup(strName='ContactAnsys_1', iMethod=1, iType=0, iContactAlgorithm=0, ansysContact=ANSYS_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680)


```

## Connections.Contacts.AutoConvertContact

```text
Connections.Contacts.AutoConvertContact(crlContact, iTargetType=0)


```

## Connections.Contacts.CheckPattern

```text
Connections.Contacts.CheckPattern(crlParts, bShowMismatch=False, bShowMatch=True, dTolerance=0.01)


```

## Connections.Contacts.ExportCheckReport

```text
Connections.Contacts.ExportCheckReport(strPath, dZoomFactor=1.2, iFitBy=0, iListBy=0, iListOrder=0, iFormat=0)


```

## Connections.Contacts.MSCNastran.ContactGroupByMatrix

```text
Connections.Contacts.MSCNastran.ContactGroupByMatrix(strName='', nastranContact=NASTRAN_CONTACT(), crplTarget=[], crEdit=None, iColor=65280, iMethod=1)


```

## Connections.Contacts.MSCNastran.ContactShareFace

```text
Connections.Contacts.MSCNastran.ContactShareFace(crlShareFace=[], strName='', nastranContact=NASTRAN_CONTACT(), crEdit=None, iColor=65280, iMethod=3)


```

## Connections.Contacts.MSCNastran.ContactTable

```text
Connections.Contacts.MSCNastran.ContactTable(strName='', nastranContact=NASTRAN_CONTACT(), crplTarget=[], crEdit=None, iColor=65280, iMethod=1)


```

## Connections.Contacts.MSCNastran.ManualFace

```text
Connections.Contacts.MSCNastran.ManualFace(crlMasterFaces, crlSlaveFaces, strName='ContactMSCNastran_1', nastranContact=NASTRAN_CONTACT(), crEdit=None, iColor=65280)


```

## Connections.Contacts.MSCNastran.ManualGroup

```text
Connections.Contacts.MSCNastran.ManualGroup(strName='', nastranContact=NASTRAN_CONTACT(), crplTarget=[], crEdit=None, iColor=65280, iMethod=1)


```

## Connections.Contacts.NXNastran.ContactGroupByMatrix

```text
Connections.Contacts.NXNastran.ContactGroupByMatrix(crFaceMaster=None, crFaceSlave=None, strName='ContactNXNastran_1', iContactType=0, iContactAlg=0, dNorPenFactor=10, dTanPenFactor=1, dForceConTol=0.01, dMaxForceIter=10, dMaxStaIter=20, dChangeNum=0.02, dMinContactPer=100, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=1, dMinSearDist=0, dMaxSearDist=0.01, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, iColor=0, iMethod=0, crEdit=None)


```

## Connections.Contacts.NXNastran.ContactShareFace

```text
Connections.Contacts.NXNastran.ContactShareFace(crlShareFace=[], strName='ContactNXNastran_1', iContactType=0, iContactAlg=0, dNorPenFactor=10, dTanPenFactor=1, dForceConTol=0.01, dMaxForceIter=10, dMaxStaIter=20, dChangeNum=0.02, dMinContactPer=100, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=1, dMinSearDist=0, dMaxSearDist=0.01, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, iColor=0, iMethod=3, crEdit=None)


```

## Connections.Contacts.NXNastran.ContactTable

```text
Connections.Contacts.NXNastran.ContactTable(strName='', iType=0, iAlg=0, dNorPenFactor=0, dTanPenFactor=0, dForceConTol=0, dMaxForceIter=0, dMaxStaIter=0, dChangeNum=0, dMinContactPer=0, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=0, dMinSearDist=0, dMaxSearDist=0, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, crplTargetPair=[], crEdit=None, iColor=0, iMethod=1)


```

## Connections.Contacts.NXNastran.ManualFace

```text
Connections.Contacts.NXNastran.ManualFace(crlFaceMasters, crlFaceSlaves, strName='ContactNXNastran_1', iContactType=0, iContactAlgorithm=0, dNormalPenaltyFactor=10, dTangentialPenaltyFactor=1, dForceConvergenceTol=0.01, dMaxForceIteration=10, dMaxStatusIteration=20, dNumberOfChange=0.02, dMinContactPercentage=100, iShellThickness=0, iContactStatus=0, iInitGapOrPenetration=0, iRegionRefine=0, iEvaluateOrder=1, dMinSearchDist=0, dMaxSearchDist=0.01, dFrictionCoeff=0, dSearchDist=0, dPenaltyFactor=0, iShellZOffset=0, iContactColor=0, iContactMethod=0, crContactNXNastran=None)


```

## Connections.Contacts.NXNastran.ManualGroup

```text
Connections.Contacts.NXNastran.ManualGroup(crFaceMaster=None, crFaceSlave=None, strName='ContactNXNastran_1', iContactType=0, iContactAlg=0, dNorPenFactor=10, dTanPenFactor=1, dForceConTol=0.01, dMaxForceIter=10, dMaxStaIter=20, dChangeNum=0.02, dMinContactPer=100, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=1, dMinSearDist=0, dMaxSearDist=0.01, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, iColor=0, iMethod=0, crEdit=None)


```

## Connections.Contacts.NXNastranGeneral

```text
Connections.Contacts.NXNastranGeneral(strName='', iPiType=0, iPiAlg=0, dPdNorPenFactor=0, dPdTanPenFactor=0, dPdForceConTol=0, dPdMaxForceIter=0, dPdMaxStaIter=0, dPdChangeNum=0, dPdMinContactPer=0, iPiShellThickness=0, iPiContactStatus=0, iPiInitGapPenetra=0, iPiRegionRefine=0, iPiEvaluPts=0, dPdMinSearDist=0, dPdMaxSearDist=0, dPdFricCoef=0, dPdSearchDist=0, dPdPenatlyFactor=0, iPiShellOffset=0, crlTargets=[], crEdit=None, iColor=0, iMethod=0)


```

## Connections.Contacts.SunShine.ManualFace

```text
Connections.Contacts.SunShine.ManualFace(crlMasterFaces, crlSlaveFaces, strName='ContactSunShine_1', sunshineContact=SUNSHINE_CONTACT(), crContactSunShine=None, iContactColor=16711680, iMethod=0, bDesigner=False)


```

## Connections.Contacts.TSSS.ContactTable

```text
Connections.Contacts.TSSS.ContactTable(strName='ContactTS_SS_1', sunshineContact=SUNSHINE_CONTACT(), crplTarget=[], crEdit=None, iColor=0)


```

## Connections.Contacts.TSSS.ManualFace

```text
Connections.Contacts.TSSS.ManualFace(crlFaceMasters, crlFaceSlaves, strName='ContactTS_SS_1', sunshineContact=SUNSHINE_CONTACT(), crContactTSSS=None, iContactColor=16711680)


```

## Connections.Contacts.TSSS.ManualGroup

```text
Connections.Contacts.TSSS.ManualGroup(strName='ContactTS_SS_1', sunshineContact=SUNSHINE_CONTACT(), crplTarget=[], crEdit=None, iColor=0, iMethod=1)


```

## Connections.Contacts.TSSolver.Auto

```text
Connections.Contacts.TSSolver.Auto(strlNames, crllMasterFaceTargets, crllSlaveFaceTargets, crlContactTypes=[1], dlInterferenceClosures=[1.0], dlFrictionCoefficients=[1.7976931348623157e+308], blInitialAdjustments=[False], crlColors=[65280], crlEdit=[], crlMasterGroups=[], crlSlaveGroups=[])


```

## Connections.Contacts.TSSolver.ManualFace

```text
Connections.Contacts.TSSolver.ManualFace(strName='ContactTSSolver_1', tssolverContact=TSSOLVER_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680, iMethod=0)


```

## Connections.Contacts.TSSolver.ManualGroup

```text
Connections.Contacts.TSSolver.ManualGroup(strName='ContactTSSolver_1', tssolverContact=TSSOLVER_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680, iMethod=0)


```

## Connections.CreateConnConm

```text
Connections.CreateConnConm(strName, iEType, iMethod, iCoordSys, iConmId, crMatCoord, dMass, dlX=[0, 0, 0], dlVintertia0=[0, 0, 0], dlVintertia1=[0, 0, 0])


```

## Connections.Gaps.TwoEdges

```text
Connections.Gaps.TwoEdges(crlMaster=[], crlSlave=[], iMethod=2, iOriMode=0, crCoord=None, strName='', dU0=1.7976931348623157e+308, dF0=1.7976931348623157e+308, dKa=1.7976931348623157e+308, dKb=1.7976931348623157e+308, dKt=1.7976931348623157e+308, dMar=1.7976931348623157e+308, dMu1=1.7976931348623157e+308, dMu2=1.7976931348623157e+308, dlOriVec=[], dTmax=1.7976931348623157e+308, dTol=1.7976931348623157e+308, dTrmin=1.7976931348623157e+308, crEditCur=None)


```

## Connections.Gaps.TwoFaces

```text
Connections.Gaps.TwoFaces(crlMaster=[], crlSlave=[], iMethod=3, iOriMode=0, crCoord=None, strName='', dU0=1.7976931348623157e+308, dF0=1.7976931348623157e+308, dKa=1.7976931348623157e+308, dKb=1.7976931348623157e+308, dKt=1.7976931348623157e+308, dMar=1.7976931348623157e+308, dMu1=1.7976931348623157e+308, dMu2=1.7976931348623157e+308, dlOriVec=[], dTmax=1.7976931348623157e+308, dTol=1.7976931348623157e+308, dTrmin=1.7976931348623157e+308, crEditCur=None)


```

## Connections.Gaps.TwoNodes

```text
Connections.Gaps.TwoNodes(crlMaster=[], crlSlave=[], iMethod=1, iOriMode=0, crCoord=None, strName='', dU0=1.7976931348623157e+308, dF0=1.7976931348623157e+308, dKa=1.7976931348623157e+308, dKb=1.7976931348623157e+308, dKt=1.7976931348623157e+308, dMar=1.7976931348623157e+308, dMu1=1.7976931348623157e+308, dMu2=1.7976931348623157e+308, dlOriVec=[], dTmax=1.7976931348623157e+308, dTol=1.7976931348623157e+308, dTrmin=1.7976931348623157e+308, crEditCur=None)


```

## Connections.GapsDetail

```text
Connections.GapsDetail(crlMaster=[], crlSlave=[], iMethod=0, iOriMode=0, crCoord=None, strName='', dU0=1.7976931348623157e+308, dF0=1.7976931348623157e+308, dKa=1.7976931348623157e+308, dKb=1.7976931348623157e+308, dKt=1.7976931348623157e+308, dMar=1.7976931348623157e+308, dMu1=1.7976931348623157e+308, dMu2=1.7976931348623157e+308, dlOriVec=[], dTmax=1.7976931348623157e+308, dTol=1.7976931348623157e+308, dTrmin=1.7976931348623157e+308, crEditCur=None)


```

## Connections.MPC.Equation.MultipleNodes

```text
Connections.MPC.Equation.MultipleNodes(strName='MPC_1', crlMasterNodes=[], crSlaveNode=None, listMpcConnection=[], dValue=0.0, iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.Equation.SemiAuto

```text
Connections.MPC.Equation.SemiAuto(strName='MPC_1', crlMasterEntities=[], crlSlaveEntities=[], listMpcConnection=[], dConstantValue=0.0, iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.Equation.TwoFaces

```text
Connections.MPC.Equation.TwoFaces(strName='MPC_1', crMasterFace=None, crSlaveFace=None, listMpcConnection=[], dValue=0.0, iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.FacesToFaces

```text
Connections.MPC.General.FacesToFaces(strName='MPC_1', crlMasterFaces=[], crlSlaveFaces=[], listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.NodeToAny

```text
Connections.MPC.General.NodeToAny(strName='MPC_1', crMasterNode=None, crlSlaveEntities=[], listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.NodeToEdges

```text
Connections.MPC.General.NodeToEdges(strName='MPC_1', crMasterNode=None, crlSlaveEdges=[], listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.NodeToFaces

```text
Connections.MPC.General.NodeToFaces(strName='MPC_1', crMasterNode=None, crlSlaveFaces=[], listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.NodesToNodes

```text
Connections.MPC.General.NodesToNodes(strName='MPC_1', crlMasterNodes=[], crlSlaveNodes=[], listMpcConnection=[], dSearchTol=0.0, dValue=0.0, iMPCType=0, iSearchType=1, iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.NodesWithTolerance

```text
Connections.MPC.General.NodesWithTolerance(strName='MPC_1', crlMasterNodes=[], listMpcConnection=[], dSearchTol=0.0, iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.TwoEdges

```text
Connections.MPC.General.TwoEdges(strName='MPC_1', crMasterEdge=None, crSlaveEdge=None, listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.TwoFaces

```text
Connections.MPC.General.TwoFaces(strName='MPC_1', crMasterFace=None, crSlaveFace=None, listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MPC.General.TwoNodes

```text
Connections.MPC.General.TwoNodes(strName='MPC_1', crlMasterNodes=[], crlSlaveNodes=[], listMpcConnection=[], iLocalCoordinate=0, bUpdateDispCS=True, crMPCConnection=None)


```

## Connections.MassElements

```text
Connections.MassElements(strName, crlTargets, dMass=0.01, iDof=1, bDesigner=True, crCoordinate=None, dOffset0=0.0, dOffset1=0.0, dOffset2=0.0, dInertia0=0.0, dInertia1=0.0, dInertia2=0.0, dInertia3=0.0, dInertia4=0.0, dInertia5=0.0, crEdit=None, bUpdateDispCS=True)


```

## Connections.Plot

```text
Connections.Plot(strName='PLOT_1', iPID=1, crlTargets=[], crEdit=None)


```

## Connections.Pretension.Abaqus

```text
Connections.Pretension.Abaqus(crlTargets, dForceValue, dlForceDirection, dlControlNode, iRefNodeID, strName='PreTensionAbaqus1', bFixedLength=False, crLbcConstraint=None, crLbcPretensionAbaqus=None, bRadiossPreload=False)


```

## Connections.Pretension.Advc

```text
Connections.Pretension.Advc(crlTargets, dForceValue, dlForceDirection, dlControlNode, strName='PreTensionAdvc1', bFixedLength=False, crLbcEnforcedVelocity=None, iDirectionUpdate=0, iRefNodeId=0, crLbcPretensionADVC=None)


```

## Connections.Pretension.General

```text
Connections.Pretension.General(crlFaces, dForceValue, strName='BoltLoad001', iForceDirection=0, bFixedLength=False, crLocalCoordinate=None)


```

## Connections.Pretension.SunShine

```text
Connections.Pretension.SunShine(crlTargets, dForceValue, strName='PreTensionSunShine1', iLocalUnit=0, crLbcPretensionSunShine=None)


```

## Connections.RBE3

```text
Connections.RBE3(iMethod=0, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName='', crCoordSys=None, dTolerance=0.0, posVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, bUpdateDispCS=True, bCornerOnly=False)


```

## Connections.RigidElements.RBE2.OneToMany

```text
Connections.RigidElements.RBE2.OneToMany(iMethod=16, crlMasterTargets=[], crlSlaveTargets=[], iEType=2, strName='RBE2_1', crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iEnableCheckDulplicate=1, iDuplicateMode=0)


```

## Connections.RigidElements.RBE2.OneToOne

```text
Connections.RigidElements.RBE2.OneToOne(iMethod=17, crlMasterTargets=[], crlSlaveTargets=[], iEType=2, strName='RBE2_1', crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iEnableCheckDulplicate=1, iDuplicateMode=0)


```

## Connections.RigidElements.RBE2.OneToOneNodesWithTolerance

```text
Connections.RigidElements.RBE2.OneToOneNodesWithTolerance(iMethod=21, crlMasterTargets=[], crlSlaveTargets=[], iEType=2, strName='RBE2_1', crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iEnableCheckDulplicate=1, iDuplicateMode=0)


```

## Connections.RigidElements.RBE2.ToCenter

```text
Connections.RigidElements.RBE2.ToCenter(iMethod=18, crlMasterTargets=[], crlSlaveTargets=[], iEType=2, strName='RBE2_1', crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iEnableCheckDulplicate=1, iDuplicateMode=0)


```

## Connections.RigidElements.RBE2.ToCircleCenter

```text
Connections.RigidElements.RBE2.ToCircleCenter(iMethod=19, crlMasterTargets=[], crlSlaveTargets=[], iEType=2, strName='RBE2_1', crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iEnableCheckDulplicate=1, iDuplicateMode=0)


```

## Connections.RigidElements.RBE2General

```text
Connections.RigidElements.RBE2General(iMethod, crlMasterTargets, crlSlaveTargets, iEType=2, strName='RBE2_1', crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iDuplicateMode=-1)


```

## Connections.RigidElements.RBE3.OneToMany

```text
Connections.RigidElements.RBE3.OneToMany(iMethod=16, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName='', crCoordSys=None, dTolerance=0.0, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=True, iEnableCornerOnly=False)


```

## Connections.RigidElements.RBE3.OneToOne

```text
Connections.RigidElements.RBE3.OneToOne(iMethod=17, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName='', crCoordSys=None, dTolerance=0.0, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=True, iEnableCornerOnly=False)


```

## Connections.RigidElements.RBE3.ToCenter

```text
Connections.RigidElements.RBE3.ToCenter(iMethod=18, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName='', crCoordSys=None, dTolerance=0.0, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=True, iEnableCornerOnly=False)


```

## Connections.RigidElements.RBE3.ToCircleCenter

```text
Connections.RigidElements.RBE3.ToCircleCenter(iMethod=19, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName='', crCoordSys=None, dTolerance=0.0, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=True, iEnableCornerOnly=False)


```

## Connections.RigidElements.RBE3General

```text
Connections.RigidElements.RBE3General(iMethod=0, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName='', crCoordSys=None, dTolerance=0.0, posVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, bUpdateDispCS=True, bCornerOnly=False)


```

## Connections.RigidElements.RBar.OneToMany

```text
Connections.RigidElements.RBar.OneToMany(strName='RBAR_1', crlMasterTargets=[], crlSlaveTargets=[], iMethod=16, iUlDOFs=0, dTol=1.7976931348623157e+308, crCoord=None, crEdit=None)


```

## Connections.RigidElements.RBar.OneToOne

```text
Connections.RigidElements.RBar.OneToOne(strName='RBAR_1', crlMasterTargets=[], crlSlaveTargets=[], iMethod=17, iUlDOFs=0, dTol=1.7976931348623157e+308, crCoord=None, crEdit=None)


```

## Connections.RigidElements.RBar.OneToOneNodesWithTolerance

```text
Connections.RigidElements.RBar.OneToOneNodesWithTolerance(strName='RBAR_1', crlMasterTargets=[], crlSlaveTargets=[], iMethod=21, iUlDOFs=0, dTol=1.7976931348623157e+308, crCoord=None, crEdit=None)


```

## Connections.RigidElements.RBarGeneral

```text
Connections.RigidElements.RBarGeneral(rbarConnection=RBAR_CONNECTION(), crlMasterTargets=[], crlSlaveTargets=[], iUlDOFs=0, dTol=1.7976931348623157e+308, crCoord=None, crEdit=None)


```

## Connections.RigidWall

```text
Connections.RigidWall(strName='RigidWall1', iObject=0, iType=0, iMotion=0, iFriction=0, iOrtho=0, iForces=0, dFinite1=1.7976931348623157e+308, dFinite2=1.7976931348623157e+308, dMotionMass=1.7976931348623157e+308, dMotionInitVelo=1.7976931348623157e+308, dFricCoulombCoeff=1.7976931348623157e+308, dFricWeldVelo=1.7976931348623157e+308, iForcesCirclesNum=0, dOrthoStaticCoeff1=1.7976931348623157e+308, dOrthoStaticCoeff2=1.7976931348623157e+308, dOrthoDynamicCoeff1=1.7976931348623157e+308, dOrthoDynamicCoeff2=1.7976931348623157e+308, dOrthoDecayConst1=1.7976931348623157e+308, dOrthoDecayConst2=1.7976931348623157e+308, dOrthoFricVector1=1.7976931348623157e+308, dOrthoFricVector2=1.7976931348623157e+308, dOrthoFricVector3=1.7976931348623157e+308, bAllNodeSlave=False, crCoord=None, crAreaFaceSet=None, crVisualNodeSet=None, crlTargets=[], crEdit=None)


```

## Connections.SpringsDampers.Bush.AnyEntities

```text
Connections.SpringsDampers.Bush.AnyEntities(iMethod=16, strName='BUSH_1', crlMaster=[], crlSlave=[], crCoord=None, dTol=1.7976931348623157e+308, iGround=0, iOriMode=0, iEqual=1, poslVector=[], dlStiffness=[], dlDampCoef=[], dlDampConst=[], dRotStrain=1.7976931348623157e+308, dTransStrain=1.7976931348623157e+308, dRotStress=1.7976931348623157e+308, dTransStress=1.7976931348623157e+308, crEditObj=None)


```

## Connections.SpringsDampers.Bush.OnetoOne

```text
Connections.SpringsDampers.Bush.OnetoOne(iMethod=21, strName='BUSH_1', crlMaster=[], crlSlave=[], crCoord=None, dTol=1.7976931348623157e+308, iGround=0, iOriMode=0, iEqual=1, poslVector=[], dlStiffness=[], dlDampCoef=[], dlDampConst=[], dRotStrain=1.7976931348623157e+308, dTransStrain=1.7976931348623157e+308, dRotStress=1.7976931348623157e+308, dTransStress=1.7976931348623157e+308, crEditObj=None)


```

## Connections.SpringsDampers.Bush.TwoNodes

```text
Connections.SpringsDampers.Bush.TwoNodes(iMethod=1, strName='BUSH_1', crlMaster=[], crlSlave=[], crCoord=None, dTol=1.7976931348623157e+308, iGround=0, iOriMode=0, iEqual=1, poslVector=[], dlStiffness=[], dlDampCoef=[], dlDampConst=[], dRotStrain=1.7976931348623157e+308, dTransStrain=1.7976931348623157e+308, dRotStress=1.7976931348623157e+308, dTransStress=1.7976931348623157e+308, crEditObj=None)


```

## Connections.SpringsDampers.BushGeneral

```text
Connections.SpringsDampers.BushGeneral(iMethod, strName, crlMaster, crlSlave, crCoord, dTol, iGround, iOriMode, iEqual, poslVector, dlStiffness, dlDampCoef, dlDampConst, dRotStrain, dTransStrain, dRotStress, dTransStress, crEditObj)


```

## Connections.SpringsDampers.Damper.AnyEntities11DoFS

```text
Connections.SpringsDampers.Damper.AnyEntities11DoFS(iMethod, strName, crlMasterTargets, crlSlaveTargets, crCoordSys=None, iGround=0, dTolerance=0.0, vecTDamper=[0, 0, 0], vecRDamper=[0, 0, 0], crEdit=None, bUpdateDispCS=True)


```

## Connections.SpringsDampers.Spring.GroundedSpring

```text
Connections.SpringsDampers.Spring.GroundedSpring(iMethod=0, strName='SPRING', crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=1.7976931348623157e+308, dStressCoef=1.7976931348623157e+308, posTStiffness=[0, 0, 0], posRStiffness=[0, 0, 0], bUpdateDispCS=True, crEdit=None)


```

## Connections.SpringsDampers.Spring.Nodeswithtolerance.differentDoFs

```text
Connections.SpringsDampers.Spring.Nodeswithtolerance.differentDoFs(iMethod=0, strName='SPRING', crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=1.7976931348623157e+308, dStressCoef=1.7976931348623157e+308, posTStiffness=[0, 0, 0], posRStiffness=[0, 0, 0], bUpdateDispCS=True, crEdit=None)


```

## Connections.SpringsDampers.Spring.Nodeswithtolerance.sameDoFs

```text
Connections.SpringsDampers.Spring.Nodeswithtolerance.sameDoFs(iMethod=0, strName='SPRING', crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=1.7976931348623157e+308, dStressCoef=1.7976931348623157e+308, posTStiffness=[0, 0, 0], posRStiffness=[0, 0, 0], bUpdateDispCS=True, crEdit=None)


```

## Connections.SpringsDampers.Spring.OneToOne.differentDoFs

```text
Connections.SpringsDampers.Spring.OneToOne.differentDoFs(iMethod=0, strName='SPRING', crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=1.7976931348623157e+308, dStressCoef=1.7976931348623157e+308, posTStiffness=[0, 0, 0], posRStiffness=[0, 0, 0], bUpdateDispCS=True, crEdit=None)


```

## Connections.SpringsDampers.Spring.OneToOne.sameDoFs

```text
Connections.SpringsDampers.Spring.OneToOne.sameDoFs(iMethod=0, strName='SPRING', crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=1.7976931348623157e+308, dStressCoef=1.7976931348623157e+308, posTStiffness=[0, 0, 0], posRStiffness=[0, 0, 0], bUpdateDispCS=True, crEdit=None)


```

## EngReliability.SubModelBC

```text
EngReliability.SubModelBC(strName, crlTargets, iPos, iViewCp, iCp, iSrcType, iMappedCpIndexArr0, dScaleR, vecOffset, vecRotate, dScaleT, strPath, crEdit, iMappingMethod, iSubmodelBCMappingType, iMappingFromStepNo, bSetADVCFile, strADVCResultFile, bSetDetATol, dDetATol, bSetElementSet, strElementSet)


```

## ExManifoldModeling.SZ.WeldLine2

```text
ExManifoldModeling.SZ.WeldLine2(crlFaces, crlParts, dLayerWidth, iLayerNumber)


```

## FileMenu.AddJTDB

```text
FileMenu.AddJTDB(strFileName, strMethod='AUTO', strTargetModel='IMPORTED', strOption='OFFSET', iInputNode=0, iInputElem=0, iInputPart=0, iInputFace=0, iInputEdge=0, iInputMaterial=0, iInputProperty=0, iInputInst=0, strTargetUnit='CURRENT')


```

## FileMenu.LoadJTDB

```text
FileMenu.LoadJTDB(strFileName='', bUseTmpTable=False)


```

## FileMenu.LoadJTH5

```text
FileMenu.LoadJTH5(strFileName='', bUseTmpTable=False)


```

## FileMenu.LoadPOH5

```text
FileMenu.LoadPOH5(strFileName='', bUseTmpTable=False)


```

## FileMenu.SaveJTDB

```text
FileMenu.SaveJTDB(strFileName, strHistoryTree='')


```

## FileMenu.SaveJTH5

```text
FileMenu.SaveJTH5(strFileName='')


```

## FileMenu.SavePOH5

```text
FileMenu.SavePOH5(strFileName='')


```

## Geometry.AdjustHalfCylinder

```text
Geometry.AdjustHalfCylinder(poslPoint=[], crlFaces=[], crCoord=None, iAxisPlane=0, bDivideFace=True, crlParts=[], bMergeEdge=True)


```

## Geometry.AdvancedShellAssembly

```text
Geometry.AdvancedShellAssembly(crlParts=[], crlFaces=[], iMeshType=0, bSelfIntersection=False, iMethod=3, dGapTol=2.1)


```

## Geometry.Bar.Arc

```text
Geometry.Bar.Arc(crlNodes, crPart=None, strName='Bar_1')


```

## Geometry.Bar.Spline

```text
Geometry.Bar.Spline(crlNodes, crPart=None, strName='Bar_1')


```

## Geometry.Bar.TwoNodes

```text
Geometry.Bar.TwoNodes(crStartNode, crEndNode, strName='Bar_1', iMeshOption=0, iMeshCount=5, dMeshSize=0.0)


```

## Geometry.BodyCut.By3Points

```text
Geometry.BodyCut.By3Points(crPart, poslPoints=[[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]], dOffsetDistance=0.0, bSplitOnly=False, bMakeSectionFace=True, bSharedFace=False, bSeparateFace=False)


```

## Geometry.BodyCut.BySurface

```text
Geometry.BodyCut.BySurface(crlParts, crCutter, bSplitOnly=False, bMakeSectionFace=True, bSharedFace=False, bSeparateFace=False)


```

## Geometry.BodyCut.XXYYOnOnePoint

```text
Geometry.BodyCut.XXYYOnOnePoint(crPart, posCutPoint=[0.0, 0.0, 0.0], iCuttingPlane=0, dOffsetDistance=0.0, bSplitOnly=False, bMakeSectionFace=True, bSharedFace=False, crLocalCoordinate=None, bSeparateFace=False)


```

## Geometry.BreakEntity.Edge

```text
Geometry.BreakEntity.Edge(crlParts=[], crlFaces=[], crlEdges=[], crlNodes=[], bAutoByAngle=False, dEdgeAngle=60.0)


```

## Geometry.BreakEntity.Face

```text
Geometry.BreakEntity.Face(crlFaces)


```

## Geometry.BreakEntity.Part

```text
Geometry.BreakEntity.Part(crlParts)


```

## Geometry.BreakEntity.StlPart

```text
Geometry.BreakEntity.StlPart(crlParts, iMinNoOfFacet=0, iBreakMethod=0)


```

## Geometry.CADTrim

```text
Geometry.CADTrim(crlFaces=[], crlParts=[], dTrimSize=1.0, dTrimAngle=15.0)


```

## Geometry.DeleteEntity.Edge

```text
Geometry.DeleteEntity.Edge(crlEdges)


```

## Geometry.DeleteEntity.Face

```text
Geometry.DeleteEntity.Face(crlFaces, bIgnoreFaceOnSolidBody=True)


```

## Geometry.DeleteEntity.Part

```text
Geometry.DeleteEntity.Part(crlParts)


```

## Geometry.DeleteEntity.Vertex

```text
Geometry.DeleteEntity.Vertex(crlVertices)


```

## Geometry.Edge.Angle

```text
Geometry.Edge.Angle(crplElemEdges, dEdgeAngle=135.0, bCurvature=False, bBreakFace=True)


```

## Geometry.Edge.Circle

```text
Geometry.Edge.Circle(veclPositions, crlTargetFace, dInRadius=1, dOutRadius=4, iNoOfLayer=1, iNoOfDiv=30, bBreakFace=True)


```

## Geometry.Edge.ClosedLine

```text
Geometry.Edge.ClosedLine(veclPositions, crlTargetFace, iEnableBreakFace=1)


```

## Geometry.Edge.ElementEdges

```text
Geometry.Edge.ElementEdges(crplElemEdges, bBreakEdge=True)


```

## Geometry.Edge.ExtendLine

```text
Geometry.Edge.ExtendLine(crlEdges, iMethod=0, iEnd=0, iNoFittingPoints=3, iDiv=2, iEnableBreakFace=1)


```

## Geometry.Edge.IntersectionLine

```text
Geometry.Edge.IntersectionLine(crlFaces=[], bBreakFace=True)


```

## Geometry.Edge.Line

```text
Geometry.Edge.Line(dllPoints, crlFaces, bBreakFace=True)


```

## Geometry.Edge.LineInBetween

```text
Geometry.Edge.LineInBetween(crlEdges, crlFaces, numLine=1, bBreakFace=True, bExtend=True)


```

## Geometry.Edge.NodeShortestPath

```text
Geometry.Edge.NodeShortestPath(crFirstNode, crSecondNode, iEnableBreakFace=1)


```

## Geometry.Edge.OffsetLine

```text
Geometry.Edge.OffsetLine(crlFaces, crlEdges, bBreakFace=True, dOffsetDistance=0.0, iLayerNumber=1, bMerge=True, bExtend=True, iOffsetMethod=0, dlOffsetDistance=[], iImprintMethod=2)


```

## Geometry.Edge.PerpendicularCylinderLine

```text
Geometry.Edge.PerpendicularCylinderLine(crlNodes, crlFaces, iMethod=0, dOffset=0.0, bOppositeSide=False, bBreakFace=True)


```

## Geometry.Edge.PerpendicularLineOfEdge

```text
Geometry.Edge.PerpendicularLineOfEdge(crlNodes, crlFaces, dOffsetDistance=0.0, bBreakFace=True)


```

## Geometry.Edge.PerpendicularLineToEdge

```text
Geometry.Edge.PerpendicularLineToEdge(crNode=None, crEdge=None, crlFaces=[], bBreakFace=True, bExtend=True, bAuto=False, dLimitAngle=135.0)


```

## Geometry.Edge.PlanarLine

```text
Geometry.Edge.PlanarLine(dllPoints, crlFaces, crLocalCoordinate=None, iAxisPlane=0, bBreakFace=True)


```

## Geometry.Edge.ProjectLine

```text
Geometry.Edge.ProjectLine(crlCrEdges=[], crlCrFaces=[], crlCrNodes=[], bBreakFace=True, iType=0, bCheckGap=False, dGap=0.0)


```

## Geometry.Edge.Spline

```text
Geometry.Edge.Spline(dllPoints, crlFaces, bBreakFace=True)


```

## Geometry.Edge.SplineFreeEdges

```text
Geometry.Edge.SplineFreeEdges(crlNodes, iEnableArc=0, crPart=None, strBarName='')


```

## Geometry.ExtractRefSurfaces

```text
Geometry.ExtractRefSurfaces(crlRefFaces, dFaceAngle=60.0, strName='ExtractFace_1', bIsMergePart=False)


```

## Geometry.ExtractSurfaces

```text
Geometry.ExtractSurfaces(crlFaces, dFaceAngle=60.0, strName='ExtractFace_1', bMergePart=False)


```

## Geometry.FCircVertexAdjust

```text
Geometry.FCircVertexAdjust(crlParts, bFullCylinder=False, bCylinderMoreThan90=False, dMinRadius=0.0)


```

## Geometry.Face.CreateSmoothFace

```text
Geometry.Face.CreateSmoothFace(bInterPoration, crlTargets, iElemGeneration, dGradation, iEnableFaceSmooth, crTargetPart)


```

## Geometry.Face.Edges

```text
Geometry.Face.Edges(crlEdges, crlParts=[], crlNodes=[], bSharedFace=False, bSmoothFace=False, bCreatePart=False, bImproved=False, bBarsOnly=False, bOnlyOnePart=True, bIncludeMidNodes=False)


```

## Geometry.Face.Elements

```text
Geometry.Face.Elements(crlElems, bSharedFace=False)


```

## Geometry.Face.FourEdges

```text
Geometry.Face.FourEdges(crlEdges)


```

## Geometry.Face.FromMesh

```text
Geometry.Face.FromMesh(crFace)


```

## Geometry.FindFeature.DelCircChamfer

```text
Geometry.FindFeature.DelCircChamfer(crlParts, dMaxThick=0.1, dMinThick=2)


```

## Geometry.FindFeature.Edge

```text
Geometry.FindFeature.Edge(crlParts=[], iEdgeType=0, crlEdges=[], dDiameterMin=1.0, dDiameterMax=2.0, crlFaces=[])


```

## Geometry.FindFeature.Edges

```text
Geometry.FindFeature.Edges(crlParts, iEdgeType=0, crlEdges=[], dDiameterMin=1.0, dDiameterMax=2.0, crlFaces=[])


```

## Geometry.FindFeature.Face

```text
Geometry.FindFeature.Face(crlParts=[], crlFaces=[], iType=0, bCylinder=True, bDisc=False, bFourCorners=True, dMinThickness=0.1, dMaxThickness=2.0, dMinFaceWidth=0.1, dMaxFaceWidth=10.0, dMinCurveRadius=0.1, dMaxCurveRadius=10, dAngleMin=0.0, dAngleMax=171.0, bConvex=True, bConcave=False)


```

## Geometry.FindFeature.Faces

```text
Geometry.FindFeature.Faces(crlParts, iFaceType=0, bCylinder=True, bDisc=False, bFourCorners=True, dMinThickness=0.1, dMaxThickness=2.0, crlFaces=[])


```

## Geometry.FindFeature.Fillet

```text
Geometry.FindFeature.Fillet(crlParts=[], crlFaces=[], dMinAngle=1.0, dMaxAngle=10.0, dMinFaceWidth=1.0, dMaxFaceWidth=10.0, dMinCurveRadius=0.0, dMaxCurveRadius=171, dScale=1.0)


```

## Geometry.LogoRemoval

```text
Geometry.LogoRemoval(crlStartFaces, crlStopFaces, iLayers=5, bMergeFaces=False)


```

## Geometry.MakeFacePlanar

```text
Geometry.MakeFacePlanar(dlPlanePt1=[0.0, 0.0, 0.0], dlPlanePt2=[0.0, 0.0, 0.0], dlPlanePt3=[0.0, 0.0, 0.0], ilFaceIds=[], iMergeFace=0)


```

## Geometry.MakeFillet

```text
Geometry.MakeFillet(crlEdges, dRadius=1.0)


```

## Geometry.MergeEntities.CBarParts

```text
Geometry.MergeEntities.CBarParts(crlCBarPart=[])


```

## Geometry.MergeEntities.Edges

```text
Geometry.MergeEntities.Edges(crlEdges=[], bHighSpeedProcessing=False)


```

## Geometry.MergeEntities.Faces

```text
Geometry.MergeEntities.Faces(crlFaces, bMergeEdge=True, bRemoveNonBoundEdge=True, bHighSpeedProcessing=False)


```

## Geometry.MergeEntities.PartFaces

```text
Geometry.MergeEntities.PartFaces(crlParts=[], crlFaces=[], bAngle=True, dTolAngle=20, bWidth=True, dTolWidth=0.2)


```

## Geometry.MergeEntities.Parts

```text
Geometry.MergeEntities.Parts(crlParts, dMergeTolerance=1e-05, bRemoveSharedFace=True)


```

## Geometry.MergeEntities.TinyFacesMerge

```text
Geometry.MergeEntities.TinyFacesMerge(strMethod='AUTO', crlTargets=[], dMinFaceWidth=0.0, dMaxFaceWidth=0.001, dFaceAngle=30, bReferLocalSetting=False, bCreateRefPart=False, crlRefPart=[], crlRefEdge=[])


```

## Geometry.Part.Cone

```text
Geometry.Part.Cone(dlOrigin=[0.0, 0.0, 0.0], dBottomRadius=0.01, dHeight=0.02, iCircularNodes=20, iAxialNodes=20, strName='Cone_1', iPartColor=7105764, crLocalCoordinate=None)


```

## Geometry.Part.Cube

```text
Geometry.Part.Cube(dlOrigin=[0.0, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10], strName='Cube_1', iPartColor=7105764, crLocalCoordinate=None)


```

## Geometry.Part.Cylinder

```text
Geometry.Part.Cylinder(strName='Cylinder_1', crLocalCoordinate=None, bHollow=False, bTapered=False, dlOrigin=[0.0, 0.0, 0.0], dTopInnerRadius=0.001, dTopOuterRadius=0.01, dBottomInnerRadius=0.001, dBottomOuterRadius=0.01, dHeight=0.01, iCircularNodes=36, iAxialNodes=10, iPartColor=7105764)


```

## Geometry.Part.Elems

```text
Geometry.Part.Elems(crlElems, strPartName)


```

## Geometry.Part.Sphere

```text
Geometry.Part.Sphere(dlOrigin=[0.0, 0.0, 0.0], dRadius=0.005, iLatitudeDivisions=20, iLongitudeDivisions=20, strName='Sphere_1', iPartColor=7105764, crLocalCoordinate=None)


```

## Geometry.Part.Torus

```text
Geometry.Part.Torus(dlOrigin=[0.0, 0.0, 0.0], dInnerRadius=0.015, dRingRadius=0.02, iCircumNodes=20, iRingNodes=20, strName='Torus_1', iPartColor=7105764, crLocalCoordinate=None)


```

## Geometry.Part.Trapezoid

```text
Geometry.Part.Trapezoid(dlOrigin=[0.0, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], dTopXLength=7.0, dRadius=0.0, ilAxialNodes=[10, 10, 10], strName='Trapezoid_1', iPartColor=7105764, crLocalCoordinate=None)


```

## Geometry.Part.Tube

```text
Geometry.Part.Tube(strName='Tube_1', bTri=True, crlEdges=[], dRadius=0.01, dMeshSizeAxis=0.005, dWMeshSizeCirc=0.001, iNumCirc=36, iPartColor=7105764)


```

## Geometry.Part.Wedge

```text
Geometry.Part.Wedge(dlOrigin=[0.0, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10], strName='Wedge_1', iPartColor=7105764, crLocalCoordinate=None)


```

## Geometry.RemoveRibBoss

```text
Geometry.RemoveRibBoss(crlFaces, dGradiation=1.0, iContinuity=1)


```

## Geometry.ShellAsm

```text
Geometry.ShellAsm(crlPartK=[], crlFaceK=[], dTol=0.2, iElemType=0, bSkipTiny=False)


```

## Geometry.ShipFormMorphing

```text
Geometry.ShipFormMorphing(crlFace=[], crlCornerNode=[], nNumOfSample=10, nControlPointCounts=[7, 7], dFlexsiableTol=0.02)


```

## Geometry.ShowAdjacent.Elements

```text
Geometry.ShowAdjacent.Elements(dAngle=0.0, bIncludeStopElems=False, iNumOfLayers=1, crlStartElems=[], crlStopElems=[])


```

## Geometry.ShowAdjacent.Faces

```text
Geometry.ShowAdjacent.Faces(dAngle=0.0, bIncludeStopFaces=False, iNumOfLayers=1, crlStartFaces=[], crlStopFaces=[])


```

## Geometry.SquareUpFillet

```text
Geometry.SquareUpFillet(crlFaces)


```

## Geometry.StitchEdge

```text
Geometry.StitchEdge(crlMaster, crlSlave, dTolerance=0.3, bKeepSlave=True)


```

## Geometry.Transform.AxisAlignment

```text
Geometry.Transform.AxisAlignment(crlTargetEdges, crlReferenceEdges, crlParts, bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, bCopyReference=True, iSolution=1, dTranslationLength=0.0)


```

## Geometry.Transform.CylinderFace

```text
Geometry.Transform.CylinderFace(crSourceFace, crDestinationFace, bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, bCopyReference=False)


```

## Geometry.Transform.MatingFace

```text
Geometry.Transform.MatingFace(crlParts, crSrcFace, crDstFace, crSrcEdge=None, crDstEdge=None, crSrcNode=None, crDstNode=None, iFaceOpposite=0, dEdgeAngle=0, iEdgeOpposite=0, iAlignMethodType=0, iAdjustPointType=0, iAdjustProjectionType=0, dlAlignVector=[0, 0, 0], dlAdjustPoint=[0, 0, 0], dlAdjustVector=[0, 0, 0], bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, bIsPreview=False, crlCoordSyss=[])


```

## Geometry.Transform.Mirror

```text
Geometry.Transform.Mirror(crlParts, veclPoint=[[0.0, 0.0, 0.0]], dOffset=0.0, bCreateNewPart=True, bCopyLBC=False, bCopyProperty=False, bRemoveDupFace=True, bMergeNode=False, dTol=1e-05)


```

## Geometry.Transform.PlaneAlignment

```text
Geometry.Transform.PlaneAlignment(crlTargetFaces, crlReferenceFaces, crlParts, bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, bCopyReference=True, iSolution=1, dTranslationLength=0.0, crCenterNode=None, crCenterEdge=None)


```

## Geometry.Transform.Position

```text
Geometry.Transform.Position(crlParts, dllPoints=[[0.0, 0.0, 0.0]], bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False)


```

## Geometry.Transform.Rotation

```text
Geometry.Transform.Rotation(crlParts, posCenter=[0, 0, 0], vecAxis=[1, 0, 0], dAngle=0, bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, iCopyCount=1, bMergeNode=False, dTol=1e-05)


```

## Geometry.Transform.Scaling

```text
Geometry.Transform.Scaling(crlParts, dlScaleVector=[1.0, 1.0, 1.0], dlScaleCentre=[0.0, 0.0, 0.0], crCoordinate=None, bCreateNew=False, bCopyLBC=False, bCopyProperty=False, bUsePartCenter=True)


```

## Geometry.Transform.ThreePoints

```text
Geometry.Transform.ThreePoints(crlTargetParts, poslOriginalPoints=[[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]], poslNextPoints=[[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]], bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, bCopyReference=False)


```

## Geometry.Transform.Translation

```text
Geometry.Transform.Translation(crlParts, dlTranslationVector=[0.0, 0.0, 0.0], crLocalCoordinate=None, bCreateNewPart=False, bCopyLBC=False, bCopyProperty=False, bCopyReference=False, iCopyCount=1)


```

## Groups.RightClick.AddSupGroup

```text
Groups.RightClick.AddSupGroup(crSupGroupSelected=None)


```

## Groups.RightClick.CopyGroup

```text
Groups.RightClick.CopyGroup(crlGroups, strlNames=[], crSupperGroup=None, bKeepOriginalGroup=False)


```

## Groups.RightClick.CreateMatGroup

```text
Groups.RightClick.CreateMatGroup()


```

## Groups.RightClick.DeleteGroup

```text
Groups.RightClick.DeleteGroup(crlGroups, bRemoveAll=False)


```

## Groups.RightClick.PropertyGroup

```text
Groups.RightClick.PropertyGroup()


```

## Groups.RightClick.Rename

```text
Groups.RightClick.Rename(strNewName, crItem)


```

## HexModeling.AutoSweep

```text
HexModeling.AutoSweep(crlParts=[], dMeshSize=0.0, bLayers=False, iLayers=2)


```

## HexModeling.BallHexa

```text
HexModeling.BallHexa(crPart, vecCenter=[0.0, 0.0, 0.0], dRadius=5.0, dMeshSize=0.5, iType=0, iLayer=3, bMakeCenterNode=True, strPartName='HexBall_1')


```

## HexModeling.BoxMesh

```text
HexModeling.BoxMesh(ilPartIds, dMeshSize, strMaterialName)


```

## HexModeling.Circular

```text
HexModeling.Circular(crlFaces=[], dAngle=360, dTol=1e-07, iLayer=36, vecAxisPt=[0.0, 0.0, 0.0], vecAxisVect=[1.0, 0.0, 0.0], bInterfaceElem=False, bExtrusion=False, dTranslationExtrusion=0.0, dBDeleteOriginalParts=0.0)


```

## HexModeling.Curve

```text
HexModeling.Curve(crFace=None, crlEdges=[], crlRefEdge=[], dMeshSize=0.1)


```

## HexModeling.FaceToFace

```text
HexModeling.FaceToFace(crSrcFace, crDstFace, bDeleteOriginalParts=True)


```

## HexModeling.FromMidPlane

```text
HexModeling.FromMidPlane(crlParts=[], bRef=True)


```

## HexModeling.Layer

```text
HexModeling.Layer(crlFaces=[], dFrontWidth=0.0, dBackWidth=0.0, iFrontLayers=1, iBackLayers=0, iBaseFaceType=0, iSeparate=0)


```

## HexModeling.Linear

```text
HexModeling.Linear(crlFaces=[], dLength=10, iLayer=10, vecSweepDirection=[], bInterfaceElemFlag=False, iLinearMethod=0, bDeleteOriginalParts=False, bDeleteTargetParts=False, iMethodBias=0, dFactor=2.0, iProgression=0)


```

## HexModeling.SolidElemInterface

```text
HexModeling.SolidElemInterface(crlFaces=[], bFlip=False, crlElms=[])


```

## Home.CopyToClipboard

```text
Home.CopyToClipboard(bWhiteBG=False, bTransparentBG=False, bFixedSize=False, iWidth=1200, iHeight=900, bAutoCapture=False, listAdjust=[0, 0, 0, 0])


```

## Home.EXPORT_UNIVERSAL

```text
Home.EXPORT_UNIVERSAL(strFileName, crlParts=[], UnitLengthType=0)


```

## Home.ExportGeometryBDF

```text
Home.ExportGeometryBDF(strFileName, crlParts=[], bBigID=False, bUseUnit=True, bVert=True, bEdge=True, bFace=True, bSolid=True)


```

## Home.ExportSTL

```text
Home.ExportSTL(strFile='', crlParts=[], dScale=1, bBinaryFormat=False)


```

## Home.ExportSurfaceForPost

```text
Home.ExportSurfaceForPost(strFolderName, bUseUnit=True)


```

## Home.ExportTSG

```text
Home.ExportTSG(strFileName, crlParts=[], bBigID=False, bUseUnit=True, bVert=True, bEdge=True, bFace=True, bSolid=True)


```

## Home.ExportVTFx

```text
Home.ExportVTFx(strVtfxPath='', bExportPostData=True, bExcludeBarPart=False, bSurfaceElementOnly=False, iData2D=0, lSelectedResults=[], bDisplayPostAddTrescaStress=False, iCurUnitLength=0, iCurUnitTime=0, iCurUnitMass=0, iCurUnitForce=0, iCurUnitAngle=1, iCurUnitTemperature=1)


```

## Home.Find

```text
Home.Find(strSearch='', strSelectedType='Part', bFindMatch=False)


```

## Home.FullScreen

```text
Home.FullScreen()


```

## Home.ImportCAD.Elysium

```text
Home.ImportCAD.Elysium(strlPaths, dChordHeightTolerance=1.0, dAngleToleranceDegree=5.0, dPointCoincidentTolerance=0.01, iConvertIsolatedCurve=0, iDekCleanselfintersectingloop=2, iDekVolumetopart=4, iIgesFixedcurevepreference=0, iIgesAutostitch=1, dIgesStitchtolerance=0.1, iCatiaConvertNotShownElement=0, iCatiaConvertNotShownInstance=0, iCatiaConvertaxis=1, iStepCreateseam=1, dStepPointtolerance=0.0, iAcisHealacisbeforeversion=0, iJtConvertgeometrytype=2, bFaceColor=False, iJtConvertgeneralpart=1, iJtConvertaxis=1, iJtConvertcenterline=0)


```

## Home.ImportCAD.GeomBDF

```text
Home.ImportCAD.GeomBDF(strlPaths, bUseUnit=True)


```

## Home.ImportCAD.Parasolid

```text
Home.ImportCAD.Parasolid(strlPaths, dChordHeightTolerance=0.0, dAngleToleranceDegree=7.0, dSurfacePlaneTolerance=0.0, dSurfacePlaneAngle=20.0, dMaxFacetWidth=0.1, dMinFacetWidth=0.0, dScale=1.0)


```

## Home.ImportCAD.ProECreoDirect

```text
Home.ImportCAD.ProECreoDirect(strlPaths, dChordHeightTolerance=0.0, dAngleToleranceDegree=20.0, dStepMaxSize=0.1)


```

## Home.ImportCAD.STL

```text
Home.ImportCAD.STL(strlPaths, dScale=0.001)


```

## Home.ImportCAD.Spatial

```text
Home.ImportCAD.Spatial(strlPaths, dSurfacePlaneTolerance=0.0, dSurfacePlaneAngle=20.0, dMaxFacetWidth=100.0, bNXMultipart=True, bHealing=True, bSetFaceColor=False)


```

## Home.ImportCAD.TechnoStarGeometry

```text
Home.ImportCAD.TechnoStarGeometry(strlPaths, bUseUnit=True)


```

## Home.ImportCAD.VRML

```text
Home.ImportCAD.VRML(strlPaths, iVRMLColorGroups=0, dScale=1.0)


```

## Home.ImportMesh.ADVCADX

```text
Home.ImportMesh.ADVCADX(strlPaths, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Home.ImportMesh.AbaqusINP

```text
Home.ImportMesh.AbaqusINP(strlPaths, dFaceAngle=60.0, dEdgeAngle=60.0, iImportType=1)


```

## Home.ImportMesh.AnsysDat

```text
Home.ImportMesh.AnsysDat(strlPaths, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Home.ImportMesh.LSDYNA

```text
Home.ImportMesh.LSDYNA(strlPaths, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Home.ImportMesh.NastranBdf

```text
Home.ImportMesh.NastranBdf(strlPaths, iImportType=2, dFaceAngle=60.0, dEdgeAngle=60.0, bReadNameComment=False, iCreateDup1DElemAnswer=-1)


```

## Home.ImportMesh.TSVPre

```text
Home.ImportMesh.TSVPre(strImportPath='', strExportPath='', ilModelIndex=None, iMerge=None)


```

## Home.ImportMesh.Universal

```text
Home.ImportMesh.Universal(strPath)


```

## Home.RectangularCapture

```text
Home.RectangularCapture(iLeft=0, iTop=0, iRight=0, iBottom=0)


```

## Home.Synchronize

```text
Home.Synchronize()


```

## Home.ToImage

```text
Home.ToImage(strImgPath, bWhiteBG=False, bTransparentBG=False, bFixedSize=False, iExportWidth=1200, iExportHeight=900, bAutoCapture=False, listAdjust=[0, 0, 0, 0])


```

## Home.ToPPTX

```text
Home.ToPPTX(bAutoCapture=False, listAdjust=[0, 0, 0, 0])


```

## MMCCarACTools.Repair.CloseHoleEx

```text
MMCCarACTools.Repair.CloseHoleEx(crlEdges=[], dMinArea=0.0, dMaxArea=0.54321, bMergeFace=False, bMergeEdge=False)


```

## MMCCarACTools.Repair.FindHoleEx

```text
MMCCarACTools.Repair.FindHoleEx(crlBodies=[], crlEdges=[], dMinLen=0.0, dMaxLen=12.345)


```

## MainWindow.RightClick.AssociatedPick

```text
MainWindow.RightClick.AssociatedPick(crlInput, strTarget, strConnect='UNKNOWN')


```

## MainWindow.RightClick.FlipElement

```text
MainWindow.RightClick.FlipElement(crlTargets)


```

## MainWindow.RightClick.MergeFaces

```text
MainWindow.RightClick.MergeFaces(crlFaces, bIsMergeEdge=False, bRemoveNonBoundEdge=True)


```

## MainWindow.RightClick.SelectAllParts

```text
MainWindow.RightClick.SelectAllParts()


```

## MainWindow.RightClick.SetPartAppearance

```text
MainWindow.RightClick.SetPartAppearance(crlParts, strType, bShow=True)


```

## MeshCleanup.AutoCheck

```text
MeshCleanup.AutoCheck(crlParts, iElemType, blCheckCondition, blElemQuality, dlLimitValue, crlElems)


```

## MeshCleanup.ChangeTopology.Element.SurfaceElement

```text
MeshCleanup.ChangeTopology.Element.SurfaceElement(ilElement, ilFace, ilPart, iCreateNewPart)


```

## MeshCleanup.Cleanup.CloseGap

```text
MeshCleanup.Cleanup.CloseGap(crlPartCur, dDistanceTol)


```

## MeshCleanup.CloseGap

```text
MeshCleanup.CloseGap(crlPartCur=[], dDistanceTol=0.01)


```

## MeshCleanup.CloseHoles

```text
MeshCleanup.CloseHoles(crlEdges=[], dAreaMin=0.0, dAreaMax=543210.0, bMergeFace=False, bMergeEdge=False)


```

## MeshCleanup.CorrectModel

```text
MeshCleanup.CorrectModel(crlParts, iEnableBreakEdge=0, dEdgeAngle=0, iEnableMergeEdge=0, dMergeEdgeAngle=0, iEnableMergePlanarFace=0, iEnableRemoveExtraVertex=0)


```

## MeshCleanup.Element.SolidElement

```text
MeshCleanup.Element.SolidElement(crlElems, crPart=None)


```

## MeshCleanup.Element.SurfaceElement

```text
MeshCleanup.Element.SurfaceElement(ilElement=[], ilFace=[], ilPart=[], iCreateNewPart=0)


```

## MeshCleanup.Face

```text
MeshCleanup.Face(crlFaces=[], crlParts=[], bCreateNewPart=False)


```

## MeshCleanup.Manual2D.Collapse

```text
MeshCleanup.Manual2D.Collapse(crNodeRef=None, crNodeEq=None)


```

## MeshCleanup.Manual2D.CreateElement

```text
MeshCleanup.Manual2D.CreateElement(iElemType=0, crParentEntity=None, crlNodes=[])


```

## MeshCleanup.Manual2D.DeleteElement

```text
MeshCleanup.Manual2D.DeleteElement(crlElems, bKeepShareElem=False)


```

## MeshCleanup.Manual2D.Equivalence

```text
MeshCleanup.Manual2D.Equivalence(crlNodes, iTypeEquiva=0, dTolerance=1.0)


```

## MeshCleanup.Manual2D.MergeElement.TwoQuadsToQuad

```text
MeshCleanup.Manual2D.MergeElement.TwoQuadsToQuad(crlElems)


```

## MeshCleanup.Manual2D.MergeElement.TwoTrisToQuad

```text
MeshCleanup.Manual2D.MergeElement.TwoTrisToQuad(crlElems=[])


```

## MeshCleanup.Manual2D.RemeshElement

```text
MeshCleanup.Manual2D.RemeshElement(crlTargets=[], surfaceMesh=SURFACE_MESH(), bUseSetting=False, bGrading=False, bFMesher=False, iOverrideType=0, bKeepConnection=False, bProjCAD=False, bTinyFaceMerge=False, dMinFaceWidth=0, dMaxFaceWidth=0.001, bIDchcek=False, bKeepRemeshEdge=False)


```

## MeshCleanup.Manual2D.Split

```text
MeshCleanup.Manual2D.Split(crplElemEdge, dRatio=0.0, crNodeRef=None, crProjectPart=None)


```

## MeshCleanup.Manual2D.SplitElement.QuadTo2Quads

```text
MeshCleanup.Manual2D.SplitElement.QuadTo2Quads(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadTo2Quads1Tri

```text
MeshCleanup.Manual2D.SplitElement.QuadTo2Quads1Tri(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadTo2Tris

```text
MeshCleanup.Manual2D.SplitElement.QuadTo2Tris(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadTo3Tris

```text
MeshCleanup.Manual2D.SplitElement.QuadTo3Tris(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadTo4Quads

```text
MeshCleanup.Manual2D.SplitElement.QuadTo4Quads(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadTo4Tris

```text
MeshCleanup.Manual2D.SplitElement.QuadTo4Tris(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadToQuadTri

```text
MeshCleanup.Manual2D.SplitElement.QuadToQuadTri(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadToTrans3Quads

```text
MeshCleanup.Manual2D.SplitElement.QuadToTrans3Quads(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.SplitElement.QuadToTrans4Quads

```text
MeshCleanup.Manual2D.SplitElement.QuadToTrans4Quads(crlElems=[], crDatumNode0=None, crDatumNode1=None, iMethod=0, iAutoExecute=0, iAutoTransition=0, iCADProject=0, iMergeNode=0)


```

## MeshCleanup.Manual2D.Swap

```text
MeshCleanup.Manual2D.Swap(crplElemEdge=[])


```

## MeshCleanup.Manual3D.Collapse.CenterFaceCollapse

```text
MeshCleanup.Manual3D.Collapse.CenterFaceCollapse(crlElems)


```

## MeshCleanup.Manual3D.Collapse.EdgeCollapse

```text
MeshCleanup.Manual3D.Collapse.EdgeCollapse(crplElemEdge=[], crlNodes=[])


```

## MeshCleanup.Manual3D.Collapse.HalfEdgeCollapse

```text
MeshCleanup.Manual3D.Collapse.HalfEdgeCollapse(crplElemEdge)


```

## MeshCleanup.Manual3D.CreateHex

```text
MeshCleanup.Manual3D.CreateHex(iParentEntityId=0, crlElems=[], iSeprateN=1)


```

## MeshCleanup.Manual3D.CreatePenta

```text
MeshCleanup.Manual3D.CreatePenta(iParentEntityId=0, crlElems=[])


```

## MeshCleanup.Manual3D.CreateTetra

```text
MeshCleanup.Manual3D.CreateTetra(iParentEntityId=0, crlNodes=[], crlElems=[])


```

## MeshCleanup.Manual3D.DeleteNode

```text
MeshCleanup.Manual3D.DeleteNode(crlNodes)


```

## MeshCleanup.Manual3D.Equivalence

```text
MeshCleanup.Manual3D.Equivalence(crlNodes=[], iMergeTowards=0)


```

## MeshCleanup.Manual3D.Split

```text
MeshCleanup.Manual3D.Split(crplElemEdge, crlNodes=[], dRatioDistance=0.5)


```

## MeshCleanup.Manual3D.Swap

```text
MeshCleanup.Manual3D.Swap(crplElemEdge)


```

## MeshCleanup.ManualCheck

```text
MeshCleanup.ManualCheck(crlParts=[], iElemType=0, iVeQuality=0, iCheckCondition=0, dLimitValue=0.0, dCFLValue=0.0, iNonManifold=0, iCleanupMode=0, crlElems=[])


```

## MeshEdit.AdjustOrientation

```text
MeshEdit.AdjustOrientation(crlParts=[], crlFaces=[], crlElems=[])


```

## MeshEdit.ChangePattern

```text
MeshEdit.ChangePattern(crlFaces=[], iPatternType=0)


```

## MeshEdit.CreateElement.Hex

```text
MeshEdit.CreateElement.Hex(iParentEntityId=0, crlElems=[], iSeprateN=1)


```

## MeshEdit.CreateElement.Penta

```text
MeshEdit.CreateElement.Penta(iParentEntityId=0, crlElems=[])


```

## MeshEdit.CreateElement.Quad4

```text
MeshEdit.CreateElement.Quad4(iElemType=0, crParentEntity=None, crlNodes=[])


```

## MeshEdit.CreateElement.Tet

```text
MeshEdit.CreateElement.Tet(iParentEntityId=0, crlNodes=[], crlElems=[])


```

## MeshEdit.CreateElement.Tri3

```text
MeshEdit.CreateElement.Tri3(iElemType=0, crParentEntity=None, crlNodes=[])


```

## MeshEdit.CreateNode.Absolute

```text
MeshEdit.CreateNode.Absolute(veclNodeCoord=[], ilNewNodeID=[])


```

## MeshEdit.CreateNode.Between2Nodes

```text
MeshEdit.CreateNode.Between2Nodes(iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, iNumberofNodes=0, bImprint=False, crlNodes=[], crlFaces=[])


```

## MeshEdit.CreateNode.Between3Nodes

```text
MeshEdit.CreateNode.Between3Nodes(iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, bImprint=False, crlNodes=[], crlFaces=[])


```

## MeshEdit.CreateNode.CenterOfCylinder

```text
MeshEdit.CreateNode.CenterOfCylinder(crlFaces=[], iNodeID=1)


```

## MeshEdit.CreateNode.CenterOfGravity

```text
MeshEdit.CreateNode.CenterOfGravity(iCreationType=1, iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, crlParts=[], crlBarPart=[], crlFaces=[])


```

## MeshEdit.CreateNode.CenterOfSphere

```text
MeshEdit.CreateNode.CenterOfSphere(crlNodeOrFace=[], iNodeID=1)


```

## MeshEdit.CreateNode.CircleCenter

```text
MeshEdit.CreateNode.CircleCenter(crlEdges, iNodeID, bImprint=False, crFace=None)


```

## MeshEdit.CreateNode.Import

```text
MeshEdit.CreateNode.Import(strCSVFilePath)


```

## MeshEdit.CreateNode.IntersectionNode

```text
MeshEdit.CreateNode.IntersectionNode(crlFaces, crlParts, crlEdges, crlNodes)


```

## MeshEdit.CreateNode.Offset

```text
MeshEdit.CreateNode.Offset(vecOffset=[], iRep=1, crlNodes=[], crCoord=None)


```

## MeshEdit.CreateNode.Point

```text
MeshEdit.CreateNode.Point(iNodeID=1, posPoint=[0, 0, 0], bImprint=True, crShape=None)


```

## MeshEdit.CreateNode.ProjectToLine

```text
MeshEdit.CreateNode.ProjectToLine(crlTa)


```

## MeshEdit.CreateNode.ProjectToPlane

```text
MeshEdit.CreateNode.ProjectToPlane(dX=0.0, dY=0.0, dZ=0.0, crlNodes=[], crlFaces=[])


```

## MeshEdit.Deform

```text
MeshEdit.Deform(crlFaceSrcObverse=[], crlFaceDstReverse=[], crlFaceSrcReverse=[], crlFaceDstObverse=[], crlFaceFixed=[], dDistEffect=0.02)


```

## MeshEdit.DeleteNode

```text
MeshEdit.DeleteNode(crlNodes=[], bRemoveVertex=True)


```

## MeshEdit.DividePartByRegion

```text
MeshEdit.DividePartByRegion(crlParts=[], crlBoundaryParts=[])


```

## MeshEdit.ElementConvert

```text
MeshEdit.ElementConvert(crlParts=[], iType=1)


```

## MeshEdit.Face

```text
MeshEdit.Face(crlFaces, crlFaceFixed, iOffsetType=0, crCoord=None, dlOffset=[1.0, 0.0, 0.0], dOffset=0, iDistType=0, dDistStrong=10, dDistWeak=20, iNodeIdPick=-1, dlPickForMacro=[])


```

## MeshEdit.FaceImprint

```text
MeshEdit.FaceImprint(crlFaces=[], bMeshCopy=False)


```

## MeshEdit.Import

```text
MeshEdit.Import(iSolverType=0, strFilePath='', iStep=0, dScale=1.0)


```

## MeshEdit.MergeNodes

```text
MeshEdit.MergeNodes(dTolerance=0.01, iKeepType=0, crlTargets=[], bGroup=False, bEquivalence=True)


```

## MeshEdit.MeshCopy

```text
MeshEdit.MeshCopy(crlFaces=[], crlNodes=[])


```

## MeshEdit.MirrorCopy

```text
MeshEdit.MirrorCopy(crlFaces=[])


```

## MeshEdit.MoveNode.Absolute

```text
MeshEdit.MoveNode.Absolute(dDeltaX=0.0, dDeltaY=0.0, dDeltaZ=0.0, b1stCoord=True, b2ndCoord=True, b3rdCoord=True, crlNodes=[], crCoord=None)


```

## MeshEdit.MoveNode.AlongCylinder

```text
MeshEdit.MoveNode.AlongCylinder(crlFaces=[], crlNodes=[], dIrX=0, dIrY=0, dIrZ=0, dCircleX=0, dCircleY=0, dCircleZ=0, dRadius=0, dHeight=0)


```

## MeshEdit.MoveNode.AlongDirection

```text
MeshEdit.MoveNode.AlongDirection(crlNodes=[], crElem=None, crFace=None, vecDirection=[0, 0, 0], dMagnitude=0.0, bDestination=False)


```

## MeshEdit.MoveNode.AlongEdge

```text
MeshEdit.MoveNode.AlongEdge(crlNodes=[], bMoveX=False, bMoveY=False, bMoveZ=False, dPosX=0.0, dPosY=0.0, dPosZ=0.0, iMoveType=0)


```

## MeshEdit.MoveNode.CADFollows

```text
MeshEdit.MoveNode.CADFollows(crlNodes=[], dMovedPosX=0.0, dMovedPosY=0.0, dMovedPosZ=0.0)


```

## MeshEdit.MoveNode.CoincidentNodes

```text
MeshEdit.MoveNode.CoincidentNodes(crlNodes=[], dTol=0.01, bDesOrder=False)


```

## MeshEdit.MoveNode.Equalize

```text
MeshEdit.MoveNode.Equalize(crlEdges=[])


```

## MeshEdit.MoveNode.Laplacian

```text
MeshEdit.MoveNode.Laplacian(crlTargets=[], iType=0, bWithCADFollow=False)


```

## MeshEdit.MoveNode.MoveNodeOffset

```text
MeshEdit.MoveNode.MoveNodeOffset(dDeltaX, dDeltaY, dDeltaZ, crlNodes, crCoord)


```

## MeshEdit.MoveNode.NormalOffset

```text
MeshEdit.MoveNode.NormalOffset(dMagnitude=0.0, ilNodeList=[])


```

## MeshEdit.MoveNode.Offset

```text
MeshEdit.MoveNode.Offset(dDeltaX=0.0, dDeltaY=0.0, dDeltaZ=0.0, crCoord=None, crlNodes=[])


```

## MeshEdit.MoveNode.Point

```text
MeshEdit.MoveNode.Point(dX=0.0, dY=0.0, dZ=0.0, ilNodeList=[])


```

## MeshEdit.MoveNode.ProjectToLine

```text
MeshEdit.MoveNode.ProjectToLine(crlRefNodes=[], crlObjNodes=[], iType=0)


```

## MeshEdit.MoveNode.ProjectToPlaneElem

```text
MeshEdit.MoveNode.ProjectToPlaneElem(crlNodes=[], crlElems=[])


```

## MeshEdit.MoveNode.ProjectToPlane_3Nodes

```text
MeshEdit.MoveNode.ProjectToPlane_3Nodes(ilNodeList=[])


```

## MeshEdit.MoveNode.RefineQuality

```text
MeshEdit.MoveNode.RefineQuality(iMetric=0, crlFaces=[], crlElems=[], crlNodes=[])


```

## MeshEdit.MoveNode.Scale

```text
MeshEdit.MoveNode.Scale(crlNodes=[], crlNodeOrigin=[], crCoord=None, posDeltaXYZ=[10.0, 10.0, 10.0])


```

## MeshEdit.MoveNode.StraightenMidnodes

```text
MeshEdit.MoveNode.StraightenMidnodes(crlParts=[], crlFaces=[], crlEdges=[], crlNodes=[])


```

## MeshEdit.OneNode

```text
MeshEdit.OneNode(crlNodes=[], crlFaceFixed=[], bOffsetvector=False, crCoord=None, dlOffset=[0, 1, 0], dOffset=1.0, iDistType=0, dDistStrong=10, dDistWeak=20)


```

## MeshEdit.RefineQuality

```text
MeshEdit.RefineQuality(iMetric, crlFaces, crlElems, crlNodes)


```

## MeshEdit.RemoveSolidMesh

```text
MeshEdit.RemoveSolidMesh(crlParts=[], bConvFirst=False)


```

## MeshEdit.RibThickness

```text
MeshEdit.RibThickness(crlFaceMove=[], crlFaceFixed=[], dMove=3.0, dDistStrong=10.0, dDistWeak=20.0)


```

## MeshEdit.SeparateNodes

```text
MeshEdit.SeparateNodes(crlShareNodes=[], crlTargets=[], iKeepNodeIDsOn=0)


```

## MeshEdit.SolidMesh

```text
MeshEdit.SolidMesh(crlParts=[], iType=1)


```

## MeshEdit.SurfaceMesh

```text
MeshEdit.SurfaceMesh(crlParts=[], iType=1)


```

## Meshing.BarMeshing

```text
Meshing.BarMeshing(crlCadEdge, crlBarEdge, crlBarPart, dDocMeshSize=0, iDocNumofElem=4)


```

## Meshing.CADProjection.Face

```text
Meshing.CADProjection.Face(crCadPart=None, crlMeshedFaces=[], bForceProject=False, bProjectCornerNodes=True, bProjectMidNodes=False, bIDcheck=False)


```

## Meshing.CADProjection.FaceToFace

```text
Meshing.CADProjection.FaceToFace(crlCadFaces=[], crlMeshedFaces=[], bProjectCornerNodes=False, bProjectMidNodes=True, bIDcheck=True)


```

## Meshing.CADProjection.NodeToEdge

```text
Meshing.CADProjection.NodeToEdge(crCadEdge=None, crlMeshedNodes=[], iDirection=0)


```

## Meshing.CADProjection.NodeToFace

```text
Meshing.CADProjection.NodeToFace(crlCadFaces=[], crlMeshedNodes=[], iDirection=0, iImproveQuality=0, dTol=0.001, bNearest3Nodes=False)


```

## Meshing.CADProjection.Part

```text
Meshing.CADProjection.Part(crCadPart=None, crMeshedPart=None, bForceProject=False, bProjectCornerNodes=False, bProjectMidNodes=True, bIDcheck=True)


```

## Meshing.GridMesh

```text
Meshing.GridMesh(listGridMesh=[], bProjectToCad=False, strGroupName='', bMakeNewGroup=False)


```

## Meshing.LocalMeshing.FilletMapping

```text
Meshing.LocalMeshing.FilletMapping(crlParts=[], crlFaces=[], dMinArcLength=0.0, dMaxArcLength=0.009, dMinArcRadius=0.0, dMaxArcRadius=1.0, bConvex=True, bConcave=True, dLayerAngle=30.0, dAxisAspectRatio=3.0, dAxisMinSize=0.001, bAxisMinSize=True, dAxisMaxSize=0.003, bAxisMaxSize=True, iAxisMinMeshCount=1, bAxisMinMeshCount=True, iElementType=0, dSingleLayerLength=0.001, bSingleLayerLength=True, dSingleLayerRadius=0.001, bSingleLayerRadius=False, iMinNumLayer=3, bMinNumLayer=True, bCreateReference=False, bRemeshTheEnd=False, bSkipComplexFace=False)


```

## Meshing.LocalMeshing.SelectFillet

```text
Meshing.LocalMeshing.SelectFillet(crlParts=[], crlFaces=[], dMinArcLength=0.0, dMaxArcLength=0.009, dMinArcRadius=0.0, dMaxArcRadius=1.0, bConvex=True, bConcave=True)


```

## Meshing.LocalRemesh.Solid

```text
Meshing.LocalRemesh.Solid(crlParts, dlCenter=[0.0, 0.0, 0.0], dRadius=5.0, dGradFactor=1.0, dStretchLimit=0.1)


```

## Meshing.LocalRemesh.Surface

```text
Meshing.LocalRemesh.Surface(crlTargets=[], surfaceMesh=SURFACE_MESH(), bUseSetting=True, bGrading=False, bFMesher=False, iOverrideType=1, bKeepConnection=False, bProjCAD=True, bTinyFaceMerge=False, dMinFaceWidth=0, dMaxFaceWidth=0.001, bIDcheck=False, bKeepRemeshEdge=False)


```

## Meshing.LocalSetting.SearchTargetFaces

```text
Meshing.LocalSetting.SearchTargetFaces(iPartType=0, dlOrigin=[0, 0, 0], dlLength=[0.1, 0.1, 0.1], dlCenterPt=[0.0, 0.0, 0.0], dlAxisPt1=[0.0, 0.0, 0.1], dlAxisPt2=[0.0, 0.0, 0.0], bEnclosed=False)


```

## Meshing.LocalSettings.Edge

```text
Meshing.LocalSettings.Edge(strName, localMesh, crlTargets=[], crEditTarget=None)


```

## Meshing.LocalSettings.Face

```text
Meshing.LocalSettings.Face(strName, localMesh, crlTargets=[], crEditTarget=None)


```

## Meshing.LocalSettings.FaceElement

```text
Meshing.LocalSettings.FaceElement(strName, localMesh, crlTargets=[], crEditTarget=None)


```

## Meshing.LocalSettings.Model

```text
Meshing.LocalSettings.Model(strName='', localMesh=LOCAL_MESH(), spaceMesh=SPACE_MESH(), crlTargets=[], crEditTarget=None)


```

## Meshing.LocalSettings.Part

```text
Meshing.LocalSettings.Part(strName, localMesh, crlTargets=[], veclHardPointXYZ=[], crlHardPointTarget=[], crEditTarget=None)


```

## Meshing.LocalSettings.Points

```text
Meshing.LocalSettings.Points(strName, localMesh, veclHardPointXYZ=[], crlHardPointTarget=[], crEditTarget=None)


```

## Meshing.SetMeshAttribute

```text
Meshing.SetMeshAttribute(crlParts=[], surfaceMesh=SURFACE_MESH())


```

## Meshing.SolidMeshing

```text
Meshing.SolidMeshing(crlParts=[], bTet10=False, dGradingFactor=0, dStretchLimit=0, iSpeedVsQual=0, iSpeedVsMem=0, iRegion=0, bInternalNodes=True, bSafeMode=True, iParallel=0, bSurfaceNodes=True, bEdgeNodes=True, bPreservation=True, bInternalMeshOnly=True, bMeshColor=False, iPartColor=2763429)


```

## Meshing.SurfaceMeshing

```text
Meshing.SurfaceMeshing(crlParts=[], surfaceMesh=SURFACE_MESH(), bUseSetting=True, bFMesher=False, iThreadNum=8, bRefData=True, bMeshColor=False, iPartColor=65280)


```

## Meshing.Templates.TemplateCopy

```text
Meshing.Templates.TemplateCopy(crlReferent=[], crlTargets=[], iMethod=0, iCopySub=1, dTolerance=0.001, strSource='', strTarget='')


```

## MidPlane.AdjustThickness

```text
MidPlane.AdjustThickness(crlParts=[], dRatio=1.0, bAdjustFaceThick=False, bAdjustPropThick=False)


```

## MidPlane.CreateThickProps

```text
MidPlane.CreateThickProps(crlParts=[], dThickDiff=0.1, dMaxThick=1.7976931348623157e+308, dMinThick=1.7976931348623157e+308, crMatMembrane=None, crMatBend=None, crMatShear=None, crMatCoupl=None, iMatOrientType=0, dMatOrientX=1.7976931348623157e+308, dMatOrientY=1.7976931348623157e+308, dMatOrientZ=1.7976931348623157e+308, crCoord=None, dThickness=1.7976931348623157e+308, dBendStiff=1.7976931348623157e+308, dThickRatio=1, dNSM=1.7976931348623157e+308, dFiberDist1=1.7976931348623157e+308, dFiberDist2=1.7976931348623157e+308, dPlateOff=1.7976931348623157e+308, iNumInterPts=0, bThickSetting=False, iEntityType=0, bDivideProp=False, crlRefPart=[])


```

## MidPlane.FaceCross

```text
MidPlane.FaceCross(crlBodies=[], crlFaces=[])


```

## MidPlane.FindMidPlane

```text
MidPlane.FindMidPlane()


```

## MidPlane.PressShell

```text
MidPlane.PressShell(crlPart=[], dTinyHollowDepth=0.1, iNumDigit=1, crMat=None)


```

## MidPlane.PressShellV2

```text
MidPlane.PressShellV2(crlPart=[], dTinyHollowDepth=0.1, iNumDigit=1, crMat=None)


```

## MidPlaneEdit.AddItems.Edge.FaceTwoFace

```text
MidPlaneEdit.AddItems.Edge.FaceTwoFace(crRefFace=None, crExtFace=None, iExtendType=0)


```

## MidPlaneEdit.AddItems.Edge.ProjectEdgeToFace

```text
MidPlaneEdit.AddItems.Edge.ProjectEdgeToFace(crlEdges, crlFaces, bExtendEdge=True)


```

## MidPlaneEdit.AddItems.Face.EFExtendFreeEdge

```text
MidPlaneEdit.AddItems.Face.EFExtendFreeEdge(crlEdges, crlFaces, bMergeFace, bMergeEdge, bUseNeighDir, dMergeEdgeAngle, bMultiEF)


```

## MidPlaneEdit.AddItems.Face.EFProject

```text
MidPlaneEdit.AddItems.Face.EFProject(crlEdges, crlFaces, bMergeFace, bMergeEdge, dMergeEdgeAngle, bMultiEF)


```

## MidPlaneEdit.Edge.Nodes

```text
MidPlaneEdit.Edge.Nodes(crlNodes=[])


```

## MidPlaneEdit.ExtendFace.CylinderFace

```text
MidPlaneEdit.ExtendFace.CylinderFace(crlExtFace=[], crRefFace=None, crEdge=None, iExtendType=1, iFaceType=0, iMethod=0, dParaAngleOffset=0.0, dParaArcLength=0.0, dParaZxy=0.0, iAxisPlane=0, iParaArcNodesNum=0, dOffLength=0.0, crlSelExtendedFace=[], crlSelRefFace=[], dCoMag=0.0, iAxisSystem=0, iCoorSystem=0, iCoX=0, iCoY=0, iCoZ=0, bOtherSameAsFaceNormal=False, dOtherArcNodesNum=0.0, dOtherArcRadius=0.0)


```

## MidPlaneEdit.ExtendFace.PlanarFace

```text
MidPlaneEdit.ExtendFace.PlanarFace(bIType=False, crExtFace=None, crRefFace=None, crEdge=None, iFaceType=0, iExtendType=0, iMethod=0, dParaZxy=0, iAxisPlane=0, iParaArcNodesNum=0, dOffLength=0, dCoMag=0, iAxisSystem=0, iCoorSystem=0, crCoord=None, iCoX=0, iCoY=0, iCoZ=0, bOtherSameAsFaceNormal=False, dOtherArcNodesNum=0, dOtherArcRadius=0)


```

## MidPlaneEdit.Face.EdgesToEdges

```text
MidPlaneEdit.Face.EdgesToEdges(crlEdges, bImprint=False, bMultiEdges=False)


```

## MidPlaneEdit.Face.FaceExtendToIntersection

```text
MidPlaneEdit.Face.FaceExtendToIntersection(crEdge0, crEdge1)


```

## MidPlaneEdit.Face.FaceExtendtoFace

```text
MidPlaneEdit.Face.FaceExtendtoFace(crlExtFaces, crlRefFaces, bMergeFace, bMergeEdge, dMergeEdgeAngle)


```

## MidPlaneEdit.Manual.MidByPair

```text
MidPlaneEdit.Manual.MidByPair(crlBaseFaces, crlPairFaces, crlRefFaces, crPart, bMergeFaces, bExtendFaces, bHideFaces, dExtendTol, dMergeEdgesAngle, dStitchFaces)


```

## MidPlaneEdit.Manual.vecOffset

```text
MidPlaneEdit.Manual.vecOffset(crlFaces, crPart, dOffset, bCyl, strNewPartName)


```

## MufflerHA.CopyMeshCount

```text
MufflerHA.CopyMeshCount(crlMasterEdge, crlSlaveEdge, strBaseName)


```

## MufflerHA.CreateEdge.PerpendicularLineToEdge

```text
MufflerHA.CreateEdge.PerpendicularLineToEdge(crNode, crEdge, crlFaces, bBreakFace)


```

## MufflerHA.CreateEdgeClassic.ProjectLine

```text
MufflerHA.CreateEdgeClassic.ProjectLine(ilAiedgeidForMacro, ilAifaceidForMacro, bDivideFace, crlAiparttargetForMarco)


```

## MufflerT.SpecialModeling.Rod.Rod

```text
MufflerT.SpecialModeling.Rod.Rod(crlNodes, dRadius, iType, dMeshSize, dStartDist, dWeldDist, iDivNumber, dDeformWidth, iTransitionElem, dlPosDir)


```

## MuxWeld.CreateWeld.Auto

```text
MuxWeld.CreateWeld.Auto(iIconnectattributeMethod, strStrconnectattributeName, crlMasterTargets, crlSlaveTargets, iIconnectattributeCoordsys, crEdit)


```

## MuxWeld.CreateWeld.CreateBeadWeld

```text
MuxWeld.CreateWeld.CreateBeadWeld(crlEdges, crlPrjtedEdge, crlParts, dTol, dRatio, crRefElem)


```

## MuxWeld.DefineSequence.Single

```text
MuxWeld.DefineSequence.Single(crEdit)


```

## MuxWeld.MeshingPass

```text
MuxWeld.MeshingPass(crPart=None, crlEdges=[], dMeshSize=0.0)


```

## MuxWeld.Prop3DWeldBead

```text
MuxWeld.Prop3DWeldBead(strName='Bead_1', crMaterial=None, crlTargets=[], crEdit=None)


```

## NSModeling.NSModeling_Close_Hole

```text
NSModeling.NSModeling_Close_Hole(iType, dMaxLength, bMergeFaces, bSetCenterPoint, crlNodes, crlParts)


```

## OasisAWizard.LocalMeshing.FilletMapMeshing

```text
OasisAWizard.LocalMeshing.FilletMapMeshing(crlParts=[], crlFaces=[], dMinLength=0.0, dMaxLength=1.0, dMinRadius=0.0, dMaxRadius=0.009, bConvex=True, bConcave=True, iTmp=0, dLengthSingleLayer=0, dBMinLengthForSingleLayer=0, dRadiusSingleLayer=0, dBMinRadiusForSingleLayer=0, iMinlayer=0, bMinLayer=False)


```

## Post.Calculation.PeakSearch

```text
Post.Calculation.PeakSearch(iOption=0, dParam=0.1, bStep=False)


```

## Post.ExportResults.PostViewerFile

```text
Post.ExportResults.PostViewerFile(iGroupType=0, strFileName='')


```

## Post.ImportResults.ADVC

```text
Post.ImportResults.ADVC(strlPath=[], iImportType=1, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Post.ImportResults.ADVC2PostJob

```text
Post.ImportResults.ADVC2PostJob(strName, strlResultFolderPaths, crEdit)


```

## Post.ImportResults.HDF5Mesh

```text
Post.ImportResults.HDF5Mesh(strlFilePaths, iImportType=2, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Post.ImportResults.ImportOp2Mesh

```text
Post.ImportResults.ImportOp2Mesh(strlFilePaths, iImportType=0, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Post.ImportResults.ImportTsdbMesh

```text
Post.ImportResults.ImportTsdbMesh(strTsdbFilePath, strBtxFilePath, iImportType=1, dFaceAngle=60.0, dEdgeAngle=60.0)


```

## Post.ImportResults.NastranHDF5

```text
Post.ImportResults.NastranHDF5(strName='', strlPaths=[], crEdit=None)


```

## Post.ImportResults.NastranOp2PostJob

```text
Post.ImportResults.NastranOp2PostJob(strName, strlPaths, crEdit=None)


```

## Properties.BAR

```text
Properties.BAR(strName='BAR1', iPropertyId=1, iPropertyColor=6250447, crCrossSection=None, iShapeDataType=0, crMaterial=None, dSectionArea=1.7976931348623157e+308, dlSectionOrientation=[0.0, 0.0, 0.0], dlInertiaMoment=[0.0, 0.0, 0.0], dTorionalConst=1.7976931348623157e+308, dNonStructuralMass=1.7976931348623157e+308, dShearAreaFactorY=1.7976931348623157e+308, dShearAreaFactorZ=1.7976931348623157e+308, dStressRecoveryCoeffCy=1.7976931348623157e+308, dStressRecoveryCoeffCz=1.7976931348623157e+308, dStressRecoveryCoeffDy=1.7976931348623157e+308, dStressRecoveryCoeffDz=1.7976931348623157e+308, dStressRecoveryCoeffEy=1.7976931348623157e+308, dStressRecoveryCoeffEz=1.7976931348623157e+308, dStressRecoveryCoeffFy=1.7976931348623157e+308, dStressRecoveryCoeffFz=1.7976931348623157e+308, bPinFlagAU1=False, bPinFlagAU2=False, bPinFlagAU3=False, bPinFlagAR1=False, bPinFlagAR2=False, bPinFlagAR3=False, bPinFlagBU1=False, bPinFlagBU2=False, bPinFlagBU3=False, bPinFlagBR1=False, bPinFlagBR2=False, bPinFlagBR3=False, dlOffsetVectorA=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], dlOffsetVectorB=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], iLocalLengthUnit=0, iLocalMassUnit=0, crlTargets=[], crBarProperty=None)


```

## Properties.Beam

```text
Properties.Beam(strName='BEAM1', iPropertyId=1, iPropertyColor=0, crCrossSection=None, iShapeDataType=0, crMaterial=None, dSectionArea=1.7976931348623157e+308, dlSectionOrientation=[0.0, 0.0, 0.0], dlInertiaMoment=[0.0, 0.0, 0.0], dTorsionalConst=1.7976931348623157e+308, dNSM=1.7976931348623157e+308, dNSMInertiaA=1.7976931348623157e+308, dNSMInertiaB=1.7976931348623157e+308, dNSMNodeA1=1.7976931348623157e+308, dNSMNodeA2=1.7976931348623157e+308, dNSMNodeB1=1.7976931348623157e+308, dNSMNodeB2=1.7976931348623157e+308, dShearStiffnessFactorK1=1.7976931348623157e+308, dShearStiffnessFactorK2=1.7976931348623157e+308, dShearReliefCoeffS1=1.7976931348623157e+308, dShearReliefCoeffS2=1.7976931348623157e+308, dWarpingCoeffA=1.7976931348623157e+308, dWarpingCoeffB=1.7976931348623157e+308, dNAEndA1=1.7976931348623157e+308, dNAEndA2=1.7976931348623157e+308, dNAEndB1=1.7976931348623157e+308, dNAEndB2=1.7976931348623157e+308, dStressRecoveryCoeffCy=0.0, dStressRecoveryCoeffCz=0.0, dStressRecoveryCoeffDy=0.0, dStressRecoveryCoeffDz=0.0, dStressRecoveryCoeffEy=0.0, dStressRecoveryCoeffEz=0.0, dStressRecoveryCoeffFy=0.0, dStressRecoveryCoeffFz=0.0, bPinFlagAU1=False, bPinFlagAU2=False, bPinFlagAU3=False, bPinFlagAR1=False, bPinFlagAR2=False, bPinFlagAR3=False, bPinFlagBU1=False, bPinFlagBU2=False, bPinFlagBU3=False, bPinFlagBR1=False, bPinFlagBR2=False, bPinFlagBR3=False, dlOffsetVectorA=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], dlOffsetVectorB=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], iLocalLengthUnit=0, iLocalMassUnit=0, crlTargets=[], crBeamProperty=None, bTaper=False, dTaperArea=1.7976931348623157e+308, dlTaperInertiaMoment=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], dTaperTorsionalConst=1.7976931348623157e+308, dTaperNSM=1.7976931348623157e+308, dTaperStressRecoveryCoeffCy=1.7976931348623157e+308, dTaperStressRecoveryCoeffCz=1.7976931348623157e+308, dTaperStressRecoveryCoeffDy=1.7976931348623157e+308, dTaperStressRecoveryCoeffDz=1.7976931348623157e+308, dTaperStressRecoveryCoeffEy=1.7976931348623157e+308, dTaperStressRecoveryCoeffEz=1.7976931348623157e+308, dTaperStressRecoveryCoeffFy=1.7976931348623157e+308, dTaperStressRecoveryCoeffFz=1.7976931348623157e+308, iIntergrationPoints=2147483647)


```

## Properties.Cohesive

```text
Properties.Cohesive(strName, iPropertyColor, crMaterial, iResponse, bSpecifyThick, dInitialThick, crlTargets, crEdit=None, iFLG=0, iId=0, iSolverType=0, iADVCResponseType=0, iADVCStackDir=0, iEnableADVCThickness=0, dADVCThickness=1.7976931348623157e+308)


```

## Properties.Composite

```text
Properties.Composite(strName='', iPropertyColor=0, iFT=0, dGE=1.7976931348623157e+308, iLAM=0, crMaterial=None, dNSM=1.7976931348623157e+308, iPID=0, dSB=1.7976931348623157e+308, iSOUT=0, dTREF=1.7976931348623157e+308, dZ0=1.7976931348623157e+308, dZOFF=1.7976931348623157e+308, crlTargets=[], crCompositeProperty=None, crLocalCS=None, iOrientationMethod=0, dlOrientationVector=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308])


```

## Properties.ElemRelatedInfo.Bar

```text
Properties.ElemRelatedInfo.Bar(listEribeamEndProp=[], listEribeamOriVecProp=[], listEribeamOriNodeidProp=[], listEribeamOffsetVecA=[], listEribeamOffsetVecB=[], listEribeamPinAProp=[], listEribeamPinBProp=[], listEribeamWarpProp=[])


```

## Properties.ElemRelatedInfo.Beam

```text
Properties.ElemRelatedInfo.Beam(listEribeamEndProp=[], listEribeamOriVecProp=[], listEribeamOriNodeidProp=[], listEribeamOffsetVecA=[], listEribeamOffsetVecB=[], listEribeamPinAProp=[], listEribeamPinBProp=[], listEribeamWarpProp=[])


```

## Properties.ElemRelatedInfo.Bush

```text
Properties.ElemRelatedInfo.Bush(listEricontEndProp=[], listEricontOriVecProp=[], listCidProp=[], listEricontDamperLocProp=[], listOcidProp=[], listDamperOffsetVecs=[], listEricontNodeidProp=[])


```

## Properties.ElemRelatedInfo.Conn

```text
Properties.ElemRelatedInfo.Conn(listEricontEndProp=[], listEricontOriVecProp=[], listCidProp=[], listEricontDamperLocProp=[], listOcidProp=[], listDamperOffsetVecs=[], listEricontNodeidProp=[])


```

## Properties.ElemRelatedInfo.Gap

```text
Properties.ElemRelatedInfo.Gap(listEricontEndProp=[], listEricontOriVecProp=[], listCidProp=[], listEricontDamperLocProp=[], listOcidProp=[], listDamperOffsetVecs=[], listEricontNodeidProp=[])


```

## Properties.ElemRelatedInfo.Rod

```text
Properties.ElemRelatedInfo.Rod(listEricontEndProp=[])


```

## Properties.ElemRelatedInfo.Shell

```text
Properties.ElemRelatedInfo.Shell(listErishellThetaProp=[], listErishellCsProp=[], listErishellZoffsProp=[])


```

## Properties.Gasket

```text
Properties.Gasket(strName, iPropertyColor, crMaterial, dThickX, dThickY, dThickZ, crlTargets, crEdit=None, iStData=0, iFLG=0)


```

## Properties.Material.Add

```text
Properties.Material.Add(strMaterialName, listMaterialProperty, iMaterialID=0)


```

## Properties.Material.Delete

```text
Properties.Material.Delete(iMaterialID)


```

## Properties.Material.Modify

```text
Properties.Material.Modify(iMaterialID, listMaterialProperty)


```

## Properties.Property1DBeamSimple

```text
Properties.Property1DBeamSimple(strName, iId, crSection=None, crMat=None, vecOrient=[1.7976931348623157e+308, 1.7976931348623157e+308, 1.7976931348623157e+308], crlTargets=[], crEdit=None)


```

## Properties.PropertyTable

```text
Properties.PropertyTable(listRenumberProp=[])


```

## Properties.RigidBody

```text
Properties.RigidBody(strName='RigidBody1', iPID=1, iRefNodeId=0, crlTargets=[], crRigidBodyProperty=None)


```

## Properties.Rod

```text
Properties.Rod(strName='', iPID=1, iPropertyColor=0, crSectionLib=None, crMat=None, dArea=1.7976931348623157e+308, dTorConst=1.7976931348623157e+308, dTorStressCoeff=1.7976931348623157e+308, dNSM=1.7976931348623157e+308, iLocalLengthUnit=0, iLocalMassUnit=0, crlTargets=[], crEdit=None)


```

## Properties.Section.AddGeneral

```text
Properties.Section.AddGeneral(strName='', iSecType=0, iSecGenType=0, dDsecGensizeA=0, dDsecGensizeB=0, dDsecGensizeH=0, dDsecGensizeT1=0, dDsecGensizeT2=0, dDsecGensizeT3=0, bBsecTapered=False, dDsecGensizeATap=0, dDsecGensizeBTap=0, dDsecGensizeHTap=0, dDsecGensizeT1Tap=0, dDsecGensizeT2Tap=0, dDsecGensizeT3Tap=0)


```

## Properties.Section.AddLibrary

```text
Properties.Section.AddLibrary(strName='', iSecType=1, iLibType=0, dDim1=0, dDim2=0, dDim3=0, dDim4=0, dDim5=0, dDim6=0, dDim7=0, dDim8=0, dDim9=0, dDim10=0, dDim11=0, dDim12=0)


```

## Properties.Section.AddSketcher

```text
Properties.Section.AddSketcher(strName='', iSecType=2)


```

## Properties.Section.Delete

```text
Properties.Section.Delete(crlSections)


```

## Properties.Section.Export

```text
Properties.Section.Export(strPath='')


```

## Properties.Section.Import

```text
Properties.Section.Import(strPath='')


```

## Properties.Section.ModifyGeneral

```text
Properties.Section.ModifyGeneral(strName='', crSection=None, iSecType=0, iGeneralType=0, dA=0, dB=0, dH=0, dT1=0, dT2=0, dT3=0, bTapered=False, dDaTap=0, dDbTap=0, dDhTap=0, dDt1Tap=0, dDt2Tap=0, dDt3Tap=0)


```

## Properties.Section.ModifyLibrary

```text
Properties.Section.ModifyLibrary(strName='', crSection=None, iType=0, iLibType=0, dDimSize0=0, dDimSize1=0, dDimSize2=0, dDimSize3=0, dDimSize4=0, dDimSize5=0, dDimSize6=0, dDimSize7=0, dDimSize8=0, dDimSize9=0, dDimSize10=0, dDimSize11=0)


```

## Properties.Section.ModifySketcher

```text
Properties.Section.ModifySketcher(strName='', crSection=None, iType=0)


```

## Properties.Section1D

```text
Properties.Section1D(strName='', iSecType=0, iSecGenType=2, dSecGensizeA=0, dSecGensizeB=0, dSecGensizeH=0, dSecGensizeT1=0, dSecGensizeT2=0, dSecGensizeT3=0, bSecTapered=False, dSecGensizeATap=0, dSecGensizeBTap=0, dSecGensizeHTap=0, dSecGensizeT1Tap=0, dSecGensizeT2Tap=0, dSecGensizeT3Tap=0)


```

## Properties.Shell

```text
Properties.Shell(crlTargets, strName='Shell Property', iPropertyId=1, iPropertyColor=0, crMatMembrane=None, crMatBend=None, crMatShear=None, crMatCoupl=None, dMatOrient1=0.0, dThickness=1, dBendStiff=0.0, dThickRatio=0.5, dNSM=0.0, dFiberDist1=0.0, dFiberDist2=0.0, dPlateOff=0.0, iItgPts=0, iMatOrientType=0, crLocalCS=None, crEdit=None, iDuplicateOpt=0, iPanelLabelId=1, strPanelLabelName='', iPanelLabelERP=0, iTempVaraitation=2147483647)


```

## Properties.Solid

```text
Properties.Solid(crlTargets, strName='Solid Property', iPropertyId=1, iPropertyColor=0, crMaterial=None, iCordM=0, iIN=0, iOutLoc=0, iISOP=0, iFLflag=0, iModifiedElem=0, iModifiedElemADVC=0, bHasDynaRemesh=False, dDynaRemeshVal1=0.0, dDynaRemeshVal2=0.0, iAbaqusPropHGtype=0, dDispHG=0.0, crEdit=None, iFLG=0)


```

## Properties.ThicknessDistribution

```text
Properties.ThicknessDistribution(dMax=1, dMin=0, iByEach=0, dlThicknessValueSet=[])


```

## SNOnePush.AutoSweepClosedLoopShaped

```text
SNOnePush.AutoSweepClosedLoopShaped(crlParts, dMeshSize, dLengthSize)


```

## SNOnePush.CADImport

```text
SNOnePush.CADImport(dDsurfaceplaneTolerance, dDsurfaceplaneAngle, dMaxFacetWidth, bBnxMultipart, dChordHeightTolerance, dAngleToleranceDegree, iConvertIsolatedCurve, iIigesFixedcurevepreference, iIigesAutostitch, dDigesStitchtolerance, iIcatiaConvertnotshowedelement, iIcatiaConvertnotshowedinstance, iIcatiaConvertaxis, iIstepCreateseam, dDstepPointtolerance, iIacisHealacisbeforeversion, iIjtConvertgeometrytype, iIjtConvertgeneralpart, iIjtConvertaxis, iIjtConvertcenterline, dDcreoChordheighttolerance, dDcreoAngletolerancedegree, strAbsCreoPath, iTransType, iFileType, strFilePath, bRenameDuplicateName, strCSVFilePath)


```

## SNOnePush.DropTest.CalcTimestep

```text
SNOnePush.DropTest.CalcTimestep(dRelevantElemRate, dChangeMassRage)


```

## SNOnePush.DropTest.DropRotation

```text
SNOnePush.DropTest.DropRotation(strName='', iDir=0, dRopHeight=0.0, dSolutionTime=0.0, iNumberOutput=20, dContactFriction=0.1, iRotAxis=0, dRotAngle=0.0, dRelevantElemRate=0.0, dChangeMassRate=0.0, dMinTimeStep=0.0, strSolverFile='', dFloorSize=0.0, bRename=True, crMat=None)


```

## SNOnePush.DropTest.UpdateFloor

```text
SNOnePush.DropTest.UpdateFloor(strName='', iDir=0, dRopHeight=0.0, dSolutionTime=0.0, iNumberOutput=20, dContactFriction=0.1, iRotAxis=0, dRotAngle=0.0, dRelevantElemRate=0.0, dChangeMassRate=0.0, dMinTimeStep=0.0, strSolverFile='', dFloorSize=0.0, bRename=True, crMat=None)


```

## SNOnePush.DropTestSNOnePush

```text
SNOnePush.DropTestSNOnePush(strName='', iDir=0, dRopHeight=0.0, dSolutionTime=0.0, iNumOutput=20, dContactFriction=0.1, iRotAxis=0, dRotAngle=0.0, dRelevantElemRate=0.0, dChangeMassRate=0.0, dMinTimeStep=0.0, strSolverFile='', dFloorSize=0.0, bRename=True, crMat=None)


```

## SZOnepushReliability.AlignMidNode

```text
SZOnepushReliability.AlignMidNode(crlSource, crlTargets)


```

## SZOnepushReliability.Assembly.ContactSurface

```text
SZOnepushReliability.Assembly.ContactSurface(crlSrcFace, crlTarPart, dTolerance, iLayer)


```

## SZOnepushReliability.Assembly.CreateWeld

```text
SZOnepushReliability.Assembly.CreateWeld(crlWelds, dMeshSize, iRrate, dFilletRadius)


```

## SZOnepushReliability.MeshEdit.FilletMapping

```text
SZOnepushReliability.MeshEdit.FilletMapping(crlParts, crlFaces, dMinRadius, dMaxRadius, dMinAngle, dMaxAngle, bConvex, bConcave)


```

## StiffCalc.Force

```text
StiffCalc.Force(strName, poslForce, poslMoment, iEnArrowDir, iDistributionMethod, crCurCoord, crTable, crNodeSet, dFPhase, dFDelay, crPhaseTable, strFormula0, strFormula1, strFormula2, strFormula3, strFormula4, strFormula5, crlTargets, crEdit)


```

## Test.Connection.RRod

```text
Test.Connection.RRod(rbarConnection=RBAR_CONNECTION(), iUlDOFs=1, dTol=0.0, crlMasterTargets=[], crlSlaveTargets=[])


```

## Test.CreateElementForWelding

```text
Test.CreateElementForWelding(crlSrcElems, crlDstElems, crlSideElems, crlParts, crMaterial)


```

## Test.FindFacesInPart

```text
Test.FindFacesInPart(crPart, strIdentical)


```

## Test.Muffler.ProjectLineForWeld

```text
Test.Muffler.ProjectLineForWeld(crlEdges, crlFaces)


```

## Test.ZGeometryTest.IntersectionCheck

```text
Test.ZGeometryTest.IntersectionCheck(crlParts, crlFaces, crlElems, iType)


```

## Test.ZGeometryTest.ShellAssy

```text
Test.ZGeometryTest.ShellAssy(taPart=[], crlFaces=[], _iMeshType=0, _bSelfIntersection=False, _iMethod=3, _dGapTol=2.1)


```

## Toolbar.Redo

```text
Toolbar.Redo(iCntRedo=1)


```

## Toolbar.Undo

```text
Toolbar.Undo(iCntUndo=1)


```

## Tools.BySelection.OriginalID

```text
Tools.BySelection.OriginalID(crlTargets=[], iType=0, iMethod=0, iStartID=1, iIncrementStep=1, bAscending=True)


```

## Tools.BySelection.Position

```text
Tools.BySelection.Position(crlTargets=[], iType=0, iMethod=0, iStartID=1, iIncrementStep=1, bAscending1=True, bAscending2=False, bAscending3=False, iSortFirst=0, iSortSecond=1, iSortThird=2, iEnableSortFirst=1, iEnableSortSecond=0, iEnableSortThird=0, iOffset1=0, iOffset2=0, iOffset3=0, dTol1=0.0, dTol2=0.0, dTol3=0.0, crCoord=None, bSpecialFace=False)


```

## Tools.BySelection.SelectionOrder

```text
Tools.BySelection.SelectionOrder(crlTargets=[], iType=0, iMethod=0, iStartID=1, iIncrementStep=1, bAscending=True)


```

## Tools.Connections

```text
Tools.Connections(listConnectRenumberTool)


```

## Tools.Coordinates.Align

```text
Tools.Coordinates.Align(strName='CRect1', iCoordType=0, iCoordAxis=0, bCreateNew=True, crlNodes=[], crEdge=None, crEdit=None)


```

## Tools.Coordinates.AttachCircle

```text
Tools.Coordinates.AttachCircle(strName='CRect1', iCoordType=0, crEdge=None, bCreateNew=True, crEdit=None)


```

## Tools.Coordinates.AttachNode

```text
Tools.Coordinates.AttachNode(strName='CRect1', iCoordType=0, crNode=None, bCreateNew=True, crEdit=None)


```

## Tools.Coordinates.CylinderFace

```text
Tools.Coordinates.CylinderFace(strName='CRect1', iCoordType=0, crFace=None)


```

## Tools.Coordinates.Face

```text
Tools.Coordinates.Face(strName='CRect1', iCoordType=0, iOrder=0, veclPoint=[], crlNodes=[], crItem=None, crRefCoord=None, crEdit=None)


```

## Tools.Coordinates.Offset

```text
Tools.Coordinates.Offset(strName='CRect1', iCoordType=0, vecTranslate=[0.0, 0.0, 0.0], bCreateNew=True, crRefCoord=None, crEdit=None)


```

## Tools.Coordinates.Rotate

```text
Tools.Coordinates.Rotate(strName='CRect1', iCoordType=0, vecRotate=[0.0, 0.0, 0.0], bCreateNew=True, crRefCoord=None, crEdit=None)


```

## Tools.Coordinates.ThreeNode

```text
Tools.Coordinates.ThreeNode(strName='CRect1', iCoordType=0, iOrder=0, crlNodes=[], veclPoints=[], crRefCoord=None, crEdit=None)


```

## Tools.Coordinates.vecOffset

```text
Tools.Coordinates.vecOffset(strName='CRect1', iCoordType=0, vTranslate=[0.0, 0.0, 0.0], bCreateNew=True, crRefCoord=None, crEdit=None)


```

## Tools.DisplacementCS

```text
Tools.DisplacementCS(crlInst=[], crCoordSystem=None)


```

## Tools.ElementCS

```text
Tools.ElementCS(iMethod=0, iDispType=0, bDispXDir=False, bDispCoord=False, dDispScale=1, crlTargets=[])


```

## Tools.Group.CreateGroup

```text
Tools.Group.CreateGroup(strGroupName, crlTargets=[], crEdit=None)


```

## Tools.Group.DeleteGroupEntity

```text
Tools.Group.DeleteGroupEntity(crlGroups, bRemoveAll=False, iDelFlag=-1)


```

## Tools.GroupByDCS

```text
Tools.GroupByDCS()


```

## Tools.Measure.Angle.ProjectedNode

```text
Tools.Measure.Angle.ProjectedNode(crNode, strTarget='All', iPrecision=6)


```

## Tools.Measure.Angle.ThreeNodes

```text
Tools.Measure.Angle.ThreeNodes(crNode1, crNode2, crNode3, strTarget='All', crCoord=None, iPrecision=6)


```

## Tools.Measure.Angle.TwoAxis

```text
Tools.Measure.Angle.TwoAxis(dlXyz1=[0, 0, 0], dlXyz2=[0, 0, 0], strTarget='Angle', iPrecision=6)


```

## Tools.Measure.Angle.TwoEdges

```text
Tools.Measure.Angle.TwoEdges(crEdge1, crEdge2, strTarget='Angle', crCoord=None, iPrecision=6)


```

## Tools.Measure.Angle.TwoElemEdges

```text
Tools.Measure.Angle.TwoElemEdges(crpElemEdge1, crpElemEdge2, strTarget='Angle', iPrecision=6)


```

## Tools.Measure.Angle.TwoNodesAxis

```text
Tools.Measure.Angle.TwoNodesAxis(crNode1, crNode2, dlAxis=[1, 0, 0], strTarget='Angle', iPrecision=6)


```

## Tools.Measure.Area.Element

```text
Tools.Measure.Area.Element(crlElems=[], iPrecision=6)


```

## Tools.Measure.Area.Face

```text
Tools.Measure.Area.Face(crlFaces, iPrecision=6)


```

## Tools.Measure.Area.Part

```text
Tools.Measure.Area.Part(crlParts=[], iPrecision=6)


```

## Tools.Measure.Distance.Edge

```text
Tools.Measure.Distance.Edge(crEdge=None, iPrecision=6)


```

## Tools.Measure.Distance.EdgeNode

```text
Tools.Measure.Distance.EdgeNode(crEdge, crNode, iPrecision=6)


```

## Tools.Measure.Distance.FaceNode

```text
Tools.Measure.Distance.FaceNode(crlFaces, crlNodes, iPrecision=6)


```

## Tools.Measure.Distance.LineNode

```text
Tools.Measure.Distance.LineNode(crlNodes, iPrecision=6)


```

## Tools.Measure.Distance.Plane3NodesToNode

```text
Tools.Measure.Distance.Plane3NodesToNode(crNode1, crNode2, crNode3, crNode, iPrecision=6)


```

## Tools.Measure.Distance.PlaneElemToNode

```text
Tools.Measure.Distance.PlaneElemToNode(crNode=None, crElem=None, iPrecision=6)


```

## Tools.Measure.Distance.TwoEdges

```text
Tools.Measure.Distance.TwoEdges(crEdge1, crEdge2, iPrecision=6)


```

## Tools.Measure.Distance.TwoNodes

```text
Tools.Measure.Distance.TwoNodes(crNode1, crNode2, strTarget='ALL', iPrecision=6, crCoord=None)


```

## Tools.Measure.Distance.TwoPoints

```text
Tools.Measure.Distance.TwoPoints(posPoint1=[0, 0, 0], posPoint2=[0, 0, 0], strTarget='ALL', iPrecision=6, crCoordinateSystem=None)


```

## Tools.Measure.Mass.Material

```text
Tools.Measure.Mass.Material(crlParts=[], crlMassConditions=[], dMaterialDensity=0.0, strTarget='Mass', bGravityCenter=False, crCoord=None, iPrecision=6)


```

## Tools.Measure.Mass.Property

```text
Tools.Measure.Mass.Property(crlParts=[], crlMassConditions=[], strTarget='Mass', bGravityCenter=False, crCoord=None, iPrecision=6)


```

## Tools.Measure.Radius.Edge

```text
Tools.Measure.Radius.Edge(crEdge, iPrecision=6)


```

## Tools.Measure.Radius.ThreeNodes

```text
Tools.Measure.Radius.ThreeNodes(crNode13, crNode23, crNode33, iPrecision=6)


```

## Tools.Measure.Volume

```text
Tools.Measure.Volume(crlParts, iPrecision=6)


```

## Tools.ModelInfo

```text
Tools.ModelInfo(strPath, strPathName='', listMeshPartInfoTool=[], bPropertyAssignedPart=False, bPropertyAssignedSummary=False, iModelNode=0, iNmodelnodeWithprop=0, ilModelElement=[], ilNmodelelemWithprop=[], ilModelLBC=[], iModelContact=0, ilModelConnection=[], ilModelProperty=[])


```

## Tools.NodeCS

```text
Tools.NodeCS(crlInst=[], crCoordSystem=None)


```

## Tools.NodeCSGroup

```text
Tools.NodeCSGroup()


```

## Tools.Renumber

```text
Tools.Renumber(listRenumberItem, bAssignProp=True, bSurfCornerFirst=False)


```

## Tools.RenumberByConnection

```text
Tools.RenumberByConnection(connectRenumberTool=CONNECT_RENUMBER_TOOL(), crlTargets=[])


```

## Tools.RenumberByFile

```text
Tools.RenumberByFile(strCSVPath='', iConfilctStrategy=0, bNeedToUpdateCount=False)


```

## Tools.Section

```text
Tools.Section(bSection)


```

## Tools.TotalLoad.Face

```text
Tools.TotalLoad.Face(crlTargets=[], crCoordinate=None, strOutput='Total', iPrecision=6)


```

## Tools.TotalLoad.LBC

```text
Tools.TotalLoad.LBC(crlTargets=[], crCoordinate=None, strOutput='Total', iPrecision=6)


```

## Tools.TotalLoad.Model

```text
Tools.TotalLoad.Model(crlTargets=[], crCoordinate=None, strOutput='Total', iPrecision=6)


```

## Tools.TotalLoad.Node

```text
Tools.TotalLoad.Node(crlTargets=[], crCoordinate=None, strOutput='Total', iPrecision=6)


```

## Tools.TotalLoad.Part

```text
Tools.TotalLoad.Part(crlTargets=[], crCoordinate=None, strOutput='Total', iPrecision=6)


```

## Utility.FindEntities

```text
Utility.FindEntities(strTarget, strFindType, bFindMatch=False)


```

## Utility.MeasureDistanceBy2Edges

```text
Utility.MeasureDistanceBy2Edges(crEdgeFirst, crEdgeLast, iPrecision=6)


```
