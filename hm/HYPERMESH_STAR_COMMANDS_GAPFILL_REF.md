# HyperMesh Extended Star-Command Gap-Fill Reference

Purpose: bo sung 308 lenh `*xxx` thuoc domain Nastran/FEM (br/common,
nastran, connectors, ModelCheck, assemblytools, entities, HyperStudy,
composites) chua co trong 28 file docs khac cua bo tai lieu nay. Day la
phan con lai sau khi loc tu 914 lenh `*xxx` duy nhat tim thay trong toan
bo `hm/scripts/**.tcl` (da loai tru `.tbc` bytecode va domain khong lien
quan: CFD, HyperXtrude, hyperform, ACM, NVH, mechanism/multibody,
aerospace-specific).

Verification status:

```text
LOCAL-INSTALL (toan bo file nay):
  Sinh boi 8 agent doc lap, moi agent grep that tren
  C:/Program Files/Altair/2022/hwdesktop/hm/scripts/ (chi file .tcl, loai
  .tbc bytecode), trich dan nguyen van dong code that kem file:line lam
  bang chung cho moi lenh. Da spot-check 8 trich dan ngau nhien tu 3 batch
  khac nhau doi chieu lai voi source that - khop 100% ca noi dung lan so
  dong. Chua co lenh nao duoc RUNTIME-TESTED (chua tu chay hmbatch de xac
  nhan hanh vi, chi xac nhan lenh ton tai va cu phap goi tu source).

Boi canh: mot AI khac (DeepSeek) truoc do duoc giao viet 10 lenh mau va da
BIA SAI signature o 30% so lenh (vi du *createnode sai so luong tham so,
*cardcreate sai hoan toan ca muc dich lan cu phap). Batch nay duoc lam lai
hoan toan tu dau bang 8 subagent voi yeu cau bat buoc trich dan nguyen van
code that, khong duoc suy doan khi thieu bang chung.
```

---

---

### *absorbentities

- **Signature**: `*absorbentities <entity_type> [1 $demarcation_rule ...]` — quan sát 2 dạng gọi: `*absorbentities constraints` (không tham số thêm) và `*absorbentities loads 1 $guiVar(value_demarkation_rule) ...` (có thêm flag + rule, dòng bị cắt bởi `\` tiếp dòng nên tham số đầy đủ chưa xác định).
- **Return shape**: side-effect, gọi trong `catch {...}`, không dùng giá trị trả về.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi cơ bản.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/solvers/common/operations/absorbconstraints.tcl:37:            catch { *absorbentities constraints }
./br/views/solvers/common/operations/loadclusteringgui.tcl:123:        *absorbentities loads 1 $guiVar(value_demarkation_rule)\
./FeAbsorb/loads/LoadAbsorption.tcl:127:            *absorbentities loads 1 $guiVar(value_demarkation_rule)\
```

---

### *addfacestocontactsurf

- **Signature**: `*addfacestocontactsurf <contactsurf_name> 1 1 <breakAngle> <int> <int>` — ví dụ quan sát: `*addfacestocontactsurf $contsurf_name 1 1 30 1 1` và biến thể `$breanAngle 1 0` / `1 1`. Tham số thứ 4 rõ ràng là break angle (biến `$breanAngle` = "break angle", tên biến gõ sai chính tả trong source gốc).
- **Return shape**: side-effect, luôn bọc trong `catch {...}`.
- **Precondition/side-effect**: chưa xác định ý nghĩa 2 tham số cuối (chỉ biết chúng nhận giá trị 0/1) — không suy đoán thêm.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1917:                catch {*addfacestocontactsurf $contsurf_name 1 1 30 1 1};
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:2882:            catch {*addfacestocontactsurf $csurf_name 1 1 $breanAngle 1 0};
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:3147:            catch {*addfacestocontactsurf $csurf_name 1 1 $breanAngle 1 1};
```

---

### *addposition

- **Signature**: `*addposition 1 2` — chỉ quan sát được dạng gọi với 2 literal số nguyên cố định (1 và 2) trong cả 2 file, không có biến thay thế nào khác được tìm thấy.
- **Return shape**: chưa xác định (không có `set x [...]`).
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/positiontransform/operations/reorganize.tcl:57:            *addposition 1 2
./context/src/positiontransform.tcl:628:        *addposition 1 2
```

---

### *addtransformation

- **Signature**: `*addtransformation 1 1` — chỉ quan sát dạng gọi với 2 literal cố định (1 1), giống hệt ở cả 2 file.
- **Return shape**: chưa xác định.
- **Precondition/side-effect**: chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/positiontransform/operations/reorganize.tcl:25:		*addtransformation 1 1
./context/src/positiontransform.tcl:602:        *addtransformation 1 1
```

---

### *appendmark

- **Signature**: `*appendmark <entity_type> <markid> "<criterion string>" <value>` — ví dụ: `*appendmark elements 2 "by config" "quad8"`, `*appendmark nodes 1 "by sets" +$subnset`, `*appendmark nodes 1 "by comps" +$nset_comp`. Tham số thứ 3 là chuỗi chọn tiêu chí ("by config"/"by sets"/"by comps"), tham số thứ 4 là giá trị tương ứng (có thể có tiền tố `+`).
- **Return shape**: side-effect trên mark hiện có (thêm entity vào mark), không thấy giá trị trả về được dùng.
- **Precondition/side-effect**: mark $markid phải đã tồn tại/được tạo trước đó để "append" thêm vào — suy ra từ tên lệnh và cách dùng liên tiếp nhiều lần cùng markid trong cùng file, nhưng không có comment xác nhận rõ ràng.
- **Confidence**: LOCAL-INSTALL

```tcl
./2DElemQReport.tcl:349:	*appendmark elements 2 "by config" "quad8"
./abaqus/AbaqusStep/abaqusstep.tcl:3093:                        *appendmark nodes 1 "by sets" +$subnset;
./abaqus/AbaqusStep/abaqusstep.tcl:3103:        *appendmark nodes 1 "by comps" +$nset_comp;
```

---

### *assemblyaddmark

- **Signature**: `*assemblyaddmark <assembly_id> <child_type> <markid>` — ví dụ: `*assemblyaddmark $assem_id comps 1`, `*assemblyaddmark $selectedId $type 1`, `*assemblyaddmark $parentAssembly assemblies 1`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng để thêm các entity đã có trong mark $markid vào assembly $assembly_id với loại con $child_type (comps, assemblies, ...) — suy ra trực tiếp từ tên tham số biến (`$parentAssembly`, `comps`, `assemblies`) trong code xung quanh.
- **Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/assembly_tc.tcl:521:        *assemblyaddmark $assem_id comps 1;
./br/common/operations/create.tcl:400:                    *assemblyaddmark $selectedId $type 1
./browser/replace_part.tcl:4959:				*assemblyaddmark $parentAssembly assemblies 1
```

---

### *attributedelete

- **Signature**: `*attributedelete <entity_type> <id> <attribute_name>` — ví dụ: `*attributedelete nodes $id $name`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: xóa attribute tên $name khỏi entity nodes có id $id — suy ra trực tiếp từ tên lệnh và tên biến `$name`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/delete.tcl:709:              *attributedelete nodes $id $name
```

(Chỉ tìm thấy 1 chỗ gọi trong toàn bộ scripts.)

---

### *attributeupdate_entityidarray2d

- **Signature**: `*attributeupdate_entityidarray2d <entity_type> <id> <attr_id> <int> <int> <int> <ref_entity_type> <int> <int> <maxLength>` — ví dụ: `*attributeupdate_entityidarray2d loadsteps +$stepid 2001 2 2 0 loadcols 1 $numLoadCaseNames $maxLength`, `*attributeupdate_entityidarray2d cards $Card 7138 1 2 0 sets 1 1 $NSetList`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa chi tiết từng tham số số nguyên (2001, 2, 2, 0 ...) — có vẻ là attribute-ID nội bộ của HM (giống pattern ở các lệnh attributeupdate* khác), nhưng không có bằng chứng/comment xác nhận rõ.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/mainstep.tcl:3262:   *attributeupdate_entityidarray2d loadsteps +$stepid 2001 2 2 0 loadcols 1 $numLoadCaseNames $maxLength; 
./EngineeringSolutions/aerospace/PcompToPlyConversion/PcompToPlyDrape.tcl:264:    *attributeupdate_entityidarray2d cards $Card 7138 1 2 0 sets 1 1 $NSetList 
./marc/marc_contactmanager_gui.tcl:974:       *attributeupdate_entityidarray2d groups $newContactTableID 1846 3 2 0 groups 1 [ llength $::Marc::CM::Dlg::touchedBodyTmpIDList ] 1
```

---

### *attributeupdatedoublearraymark

- **Signature**: `*attributeupdatedoublearraymark <entity_type> <mark> <id> <solver> <status> <behavior> 1 <length>` — dạng biến hóa dùng biến: `*attributeupdatedoublearraymark $entity_type $mark $id $solver $status $behavior 1 $length`; dạng dùng literal: `*attributeupdatedoublearraymark groups 1 1476 2 2 0 1 $listLen`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: tên biến `$entity_type $mark $id $solver $status $behavior` gợi ý cập nhật mảng giá trị double cho 1 attribute (do id ứng với "solver attribute id") trên các entity trong mark — nhưng ý nghĩa chính xác từng slot không có comment xác nhận, không suy đoán thêm.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2586:    *attributeupdatedoublearraymark $entity_type $mark $id $solver $status $behavior 1 $length;
./abaqus/Contact_wizard/CW.tcl:4133:    *attributeupdatedoublearraymark $entity_type $mark $id $solver $status $behavior 1 $length;
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage1.tcl:5033:   *attributeupdatedoublearraymark groups 1 1476 2 2 0 1 $listLen;
```

---

### *attributeupdatedoublemark

- **Signature**: `*attributeupdatedoublemark <entity_type> <mark> <id> <solver> <status> <behavior> <value>` — ví dụ biến hóa: `*attributeupdatedoublemark $entity_type $mark $id $solver $status $behavior $value`; ví dụ literal: `*attributeupdatedoublemark properties 2 2793 2 2 0 1.0`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: cập nhật 1 giá trị double duy nhất ($value) cho attribute id trên các entity trong mark — cùng nhóm tham số với *attributeupdatedoublearraymark nhưng chỉ 1 giá trị thay vì mảng (suy ra từ tên lệnh "mark" vs "arraymark" và cấu trúc song song 2 lệnh).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2569:        *attributeupdatedoublemark $entity_type $mark $id $solver $status $behavior $value;
./abaqus/Contact_wizard/CWsurfaceInteraction/CWsurint.tcl:215:            *attributeupdatedoublemark properties 2 2793 2 2 0 1.0
./abaqus/Contact_wizard/CWsurfaceInteraction/CWsurint.tcl:216:            *attributeupdatedoublemark properties 2 2794 2 0 0 0.5
```

---

### *attributeupdateentity

- **Signature**: `*attributeupdateentity <entity_type> <id> <attr_id> <int> <int> <int> <ref_entity_type> <ref_id>` — ví dụ: `*attributeupdateentity outputblocks $outputid 2874 2 2 0 sets $setid`, `*attributeupdateentity groups $cID 1544 2 2 0 groups $sInteractionId`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: gán một entity tham chiếu ($ref_id thuộc $ref_entity_type, ví dụ "sets"/"groups") vào attribute có id (2874, 1544...) của entity đích — suy ra từ cặp tham số cuối luôn là (entity_type_string, id).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/output/dat/dat_tab6.tcl:268:                *attributeupdateentity outputblocks $outputid 2874 2 2 0 sets $setid;
./abaqus/Contact_wizard/autocontact_tab.tcl:1909:      *attributeupdateentity groups $cID 1544 2 2 0 groups $sInteractionId;
./abaqus/Contact_wizard/autocontact_tab.tcl:1914:      *attributeupdateentity groups $cID 81 2 2 0 properties $sInteractionId;
```

---

### *attributeupdateentityidarraymark

- **Signature**: `*attributeupdateentityidarraymark <entity_type> <mark> <id> <solver> <status> <behavior> <target_entity_type> <data> <length>` — ví dụ biến hóa: `*attributeupdateentityidarraymark $entity_type $mark $id $solver $status $behavior $targetentity $data $length`; ví dụ literal: `*attributeupdateentityidarraymark groups 1 2058 2 2 0 groups 1 1`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: cập nhật mảng ID entity tham chiếu (kiểu $targetentity, dữ liệu $data, độ dài $length) cho attribute trên các entity trong mark — suy ra từ tên biến trực tiếp trong code.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2609:    *attributeupdateentityidarraymark $entity_type $mark $id $solver $status $behavior $targetentity $data $length;
./abaqus/AbaqusStep/interface/interface.tcl:851:                *attributeupdateentityidarraymark groups 1 2058 2 2 0 groups 1 1
./abaqus/Contact_wizard/CWinterface/CWcontactpair3.tcl:301:	*attributeupdateentityidarraymark $entity $mark $id $solver $status $behaviour \
```

---

### *attributeupdateintarraymark

- **Signature**: `*attributeupdateintarraymark <entity_type> <mark> <id> <solver> <status> <behavior> 1 <length>` — ví dụ biến hóa: `*attributeupdateintarraymark $entity_type $mark $id $solver $status $behavior 1 $length`; ví dụ literal: `*attributeupdateintarraymark systcols 1 3110 18 2 0 1 $n_numDataLines`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa chi tiết — cùng cấu trúc tham số với *attributeupdatedoublearraymark nhưng cho dữ liệu kiểu int.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2557:    *attributeupdateintarraymark $entity_type $mark $id $solver $status $behavior 1 $length;
./browser/transformation_manager/common_function.tcl:6095:                        *attributeupdateintarraymark systcols 1 3110 18 2 0 1 $n_numDataLines;
./browser/transformation_manager/common_function.tcl:6204:                        *attributeupdateintarraymark systcols 1 3110 18 2 0 1 $n_numDataLines;
```

---

### *attributeupdateintmark

- **Signature**: `*attributeupdateintmark <entity_type> <mark> <id> <solver> <status> <behavior> <value>` — ví dụ biến hóa: `*attributeupdateintmark $entity_type $mark $id $solver $status $behavior $value`; ví dụ literal: `*attributeupdateintmark groups 1 1952 2 0 0 1`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: cập nhật 1 giá trị int duy nhất cho attribute — song song với *attributeupdatedoublemark nhưng kiểu int, suy ra từ tên lệnh.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2542:    *attributeupdateintmark $entity_type $mark $id $solver $status $behavior $value;
./abaqus/AbaqusStep/interface/interface.tcl:798:                *attributeupdateintmark groups 1 1952 2 0 0 1 
./abaqus/AbaqusStep/interface/interface.tcl:801:                *attributeupdateintmark groups 1 1955 2 2 0 0 
```

---

### *attributeupdatestringarraymark

- **Signature**: `*attributeupdatestringarraymark <entity_type> <mark> <id> <solver> <status> <behavior> <data> <length>` — ví dụ biến hóa: `*attributeupdatestringarraymark $entity_type $mark $id $solver $status $behavior $data $length`; ví dụ literal: `*attributeupdatestringarraymark groups 1 2060 2 2 0 1 1`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — cùng họ tham số với các lệnh attributeupdate*arraymark khác nhưng cho dữ liệu chuỗi.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2601:    *attributeupdatestringarraymark $entity_type $mark $id $solver $status $behavior $data $length;
./abaqus/AbaqusStep/interface/interface.tcl:855:                *attributeupdatestringarraymark groups 1 2060 2 2 0 1 1
./abaqus/AbaqusStep/interface/interface.tcl:857:                *attributeupdatestringarraymark groups 1 2061 2 2 0 1 1
```

---

### *attributeupdatestringmark

- **Signature**: `*attributeupdatestringmark <entity_type> <mark> <id> <solver> <status> <behavior> <value>` — ví dụ biến hóa: `*attributeupdatestringmark $entity_type $mark $id $solver $status $behavior $value`; ví dụ literal: `*attributeupdatestringmark groups 1 811 2 2 0 ""`, `*attributeupdatestringmark systems 1 1319 $pam_solverId 2 0 "System of $root  connected with parent $parent"`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: gán 1 giá trị chuỗi duy nhất cho attribute id trên entity trong mark — suy ra từ vị trí tham số cuối luôn là 1 chuỗi literal có dấu ngoặc kép.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2643:    *attributeupdatestringmark $entity_type $mark $id $solver $status $behavior $value;
./abaqus/AbaqusStep/interface/interface.tcl:832:                *attributeupdatestringmark groups 1 811 2 2 0 "" 
./abaqus/dummypos/tclincludes/pampostohm.tcl:1177:    *attributeupdatestringmark systems 1 1319 $pam_solverId 2 0 "System of $root  connected with parent $parent"
```

---

### *autocolorwithmark

- **Signature**: `*autocolorwithmark <entity_type> <markid>` — ví dụ: `*autocolorwithmark $type 1`, `*autocolorwithmark plies 1`, `*autocolorwithmark SEATBELTS 1`, `*autocolorwithmark $entityType $mark`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: tô màu tự động các entity trong mark $markid thuộc loại $entity_type — suy ra trực tiếp từ tên lệnh, không có bằng chứng chi tiết hơn.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/autocolor.tcl:33:        *autocolorwithmark $type 1
./br/views/composite/operations/autocoloroption.tcl:20:	*autocolorwithmark plies 1
./br/views/seatbelt/operations/create.tcl:34:        *autocolorwithmark SEATBELTS 1
```

---

### *bagcreate

- **Signature**: `*bagcreate <name> <int>` — chỉ 1 chỗ gọi tìm thấy: `*bagcreate $newName 2`.
- **Return shape**: chưa xác định (không có `set x [...]`).
- **Precondition/side-effect**: tạo mới một "bag" (nhóm optimization?) với tên $newName — suy ra từ tên lệnh và context file `optimization/operations/create.tcl`; ý nghĩa tham số thứ 2 (literal 2) không rõ.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/optimization/operations/create.tcl:29:            *bagcreate $newName 2
```

(Chỉ tìm thấy 1 chỗ gọi trong toàn bộ scripts.)

---

### *bagentityupdate

- **Signature**: `*bagentityupdate <bag_name> <child_type> <markid>` — ví dụ: `*bagentityupdate $name $childtype 1`, `*bagentityupdate [hm_getvalue bags id=$parentid dataname=name] $childtype $markid`, `*bagentityupdate "$bagname" $type 1`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: thêm/cập nhật các entity trong mark vào bag có tên $bag_name với loại con $child_type — suy ra từ cách dùng song song với *assemblyaddmark và tên biến.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/delete.tcl:459:                        *bagentityupdate $name $childtype 1
./br/common/operations/organizeentites.tcl:275:                *bagentityupdate [hm_getvalue bags id=$parentid dataname=name] $childtype $markid
./br/views/optimization/operations/removefromproblem.tcl:48:        *bagentityupdate "$bagname" $type 1
```

---

### *bardirectionupdate

- **Signature**: `*bardirectionupdate <markid> <node_or_0> <int>` — ví dụ: `*bardirectionupdate 1 0 0`, `*bardirectionupdate 1 $newdirectionnode1 0`, `*bardirectionupdate 1 $newdirectionnode2 0`. Tham số thứ 2 rõ ràng là node id định hướng (tên biến `$newdirectionnode1/2`) hoặc 0.
- **Return shape**: side-effect.
- **Precondition/side-effect**: cập nhật hướng (direction) của bar element trong mark 1, dùng node tham chiếu $newdirectionnode — suy ra từ tên biến; ý nghĩa tham số thứ 3 chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./ansys/pretension_bolt.tcl:288:		  *bardirectionupdate 1 0 0
./ansys/pretension_bolt.tcl:306:		  *bardirectionupdate 1 $newdirectionnode1 0
./ansys/pretension_bolt.tcl:315:		  *bardirectionupdate 1 $newdirectionnode2 0
```

---

### *barelementrotatebyangle

- **Signature**: `*barelementrotatebyangle <markid> <angle_or_operation>` — chỉ 1 chỗ gọi: `*barelementrotatebyangle 1 $operation` (tên biến `$operation`, không phải rõ ràng là "angle" theo tên lệnh — có sự không khớp giữa tên lệnh và tên biến thực tế, cần lưu ý khi dùng).
- **Return shape**: chưa xác định.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/weldline/operations/rotateAxis.tcl:61:        *barelementrotatebyangle 1 $operation
```

(Chỉ tìm thấy 1 chỗ gọi trong toàn bộ scripts.)

---

### *barelementupdate

- **Signature**: `*barelementupdate <markid> <int> <int> <int> <int> <int> <int> <prop_name_or_empty>` — ví dụ: `*barelementupdate 1 1 1 0 0 0 0 0`, `*barelementupdate 1 1 1 0 0 0 1 ""`, `*barelementupdate 1 1 1 0 0 0 0 "$prop_name"`, `*barelementupdate 1 0 0 0 0 0 1 $propname`. Tổng cộng 8 tham số vị trí, tham số cuối là tên property (chuỗi) hoặc rỗng.
- **Return shape**: side-effect.
- **Precondition/side-effect**: cập nhật thuộc tính bar element trong mark, tham số cuối gán property theo tên — suy ra từ tên biến `$prop_name`/`$propname` ở vị trí cuối; ý nghĩa 6 tham số số nguyên giữa chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/BarUpdate/bar_update.tcl:38:                    *barelementupdate 1 1 1 0 0 0 0 0
./connectors/prop_opt_nas_cbar.tcl:198:      *barelementupdate 1 1 1 0 0 0 1 "";
./EngineeringSolutions/aerospace/1D_beam_offset/1D_beam_offset.tcl:454:					*barelementupdate 1 1 1 0 0 0 0 "$prop_name"
```

---

### *barelementupdatelocal

- **Signature**: `*barelementupdatelocal <markid> <int> <int> <int> <int> <int> <int> <prop_name>` — cùng số lượng tham số (8) với *barelementupdate: `*barelementupdatelocal 1 1 1 0 0 0 1 $propname`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: biến thể "local" của *barelementupdate (có thể dùng hệ tọa độ local thay vì global) — suy đoán này CHỈ dựa trên tên lệnh, không có bằng chứng comment; ghi rõ đây là suy đoán yếu.
- **Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_opt_nas_hilock.tcl:528:    *barelementupdatelocal 1 1 1 0 0 0 1 $propname
./EngineeringSolutions/aerospace/rivetConnection/prop_opt_nas_hilock.tcl:406:    *barelementupdatelocal 1 1 1 0 0 0 1 $propname
```

---

### *barelementupdatewithoffsets

- **Signature**: `*barelementupdatewithoffsets <markid> <int> <int> <int> <int> <int> <int> <int> <prop_name_or_0> <int> <int> <int> <end1_flag> <int> <offx1> <offy1> <offz1> <end2_flag> <int> <offx2> <offy2> <offz2>` — ví dụ đầy đủ: `*barelementupdatewithoffsets 1 1 0 1 0 0 0 0 "" 0 0 0 0 0 0.000000 0.000000 0.000000 0 0 0.000000 0.000000 0.000000` (21 tham số). Rõ ràng 2 bộ 3 giá trị offset X/Y/Z lặp lại ở cuối (cho 2 đầu bar).
- **Return shape**: side-effect.
- **Precondition/side-effect**: cập nhật bar element kèm offset tọa độ tại 2 đầu (end1: offx1/offy1/offz1, end2: offx2/offy2/offz2) — suy ra trực tiếp từ cấu trúc lặp 2 lần bộ (flag, int, x, y, z) và tên biến `$offset_x $offset_y $offset_z` ở ví dụ khác.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/BarUpdate/bar_update.tcl:140:                *barelementupdatewithoffsets 1 0 0 0 0 0 0 0 "" 0 0 0 1 2 $offset_x $offset_y $offset_z 1 2 $offset_x $offset_y $offset_z
./br/views/weldline/operations/rotateAxis.tcl:51:            *barelementupdatewithoffsets 1 1 0 1 0 0 0 0 "" 0 0 0 0 0 0.000000 0.000000 0.000000 0 0 0.000000 0.000000 0.000000
./EngineeringSolutions/aerospace/AirframeMesh/AirframeMesh.tcl:854:				*barelementupdatewithoffsets 1 1 0 1 0 0 0 0 0 0 0 0 1 0 ${offX} ${offY} ${offZ} 1 0 ${offX} ${offY} ${offZ}
```

---

### *beamsectioncreateshell

- **Signature**: `*beamsectioncreateshell <geomType> <geomMark> <shellPlane> <shellVector> <usePlane> <shellNode> <ftype>` — ví dụ có tên tham số rõ ràng: `*beamsectioncreateshell $geomType $geomMark $shellPlane $shellVector $usePlane $shellNode $ftype`; ví dụ literal: `*beamsectioncreateshell beamsects 1 1 1 0 0 0`.
- **Return shape**: side-effect (tạo mới beam section).
- **Precondition/side-effect**: tạo beam section kiểu shell từ hình học ($geomType/$geomMark), dùng mặt phẳng/vector shell — tên tham số lấy trực tiếp từ dòng gọi ở `hyperbeamgui.tcl:4186`, đây là bằng chứng mạnh (tên biến khớp ý nghĩa tham số).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/importcsv.tcl:29:    *beamsectioncreateshell beamsects 1 1 1 0 0 0
./HyperBeam/hyperbeamgui.tcl:4186:    *beamsectioncreateshell $geomType $geomMark $shellPlane $shellVector $usePlane $shellNode $ftype;
./HyperBeam/hyperbeamgui.tcl:6008:    *beamsectioncreateshell beamsects 1 1 1 0 0 0
```

---

### *beamsectioncreatesolid

- **Signature**: `*beamsectioncreatesolid <geomType> <geomMark> <solidPlane> <solidVector> <usePlane> <baseNode> <order>` — ví dụ tên tham số rõ: `*beamsectioncreatesolid $geomType $geomMark $solidPlane $solidVector $usePlane $baseNode $order`; ví dụ khác: `*beamsectioncreatesolid elements 1 1 1 0 $aboutNode 1`.
- **Return shape**: side-effect (tạo mới beam section kiểu solid).
- **Precondition/side-effect**: tương tự *beamsectioncreateshell nhưng cho solid, tham số `$aboutNode`/`$baseNode` là node tham chiếu — bằng chứng từ tên biến ở `hyperbeamgui.tcl:4225`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/StructuralProperty.tcl:626:    *beamsectioncreatesolid beamsects 1 1 1 0 0 0
./EngineeringSolutions/aerospace/3DToBeamSection/3DToBeamSection.tcl:388:					*beamsectioncreatesolid elements 1 1 1 0 $aboutNode 1
./HyperBeam/hyperbeamgui.tcl:4225:    *beamsectioncreatesolid $geomType $geomMark $solidPlane $solidVector $usePlane $baseNode $order;
```

---

### *beamsectioncreatestandardsolver

- **Signature**: `*beamsectioncreatestandardsolver <beamIndex_or_type> <int> <subtype_or_typename> <int>` — ví dụ: `*beamsectioncreatestandardsolver $beamIndex 8 $beamSecSubType 0`, `*beamsectioncreatestandardsolver $type 1 $type_name 0`.
- **Return shape**: side-effect (tạo standard beam section theo solver).
- **Precondition/side-effect**: tham số thứ 2 khác nhau giữa các call site (8 vs 1) tùy solver — chưa xác định ý nghĩa chính xác, không suy đoán thêm.
- **Confidence**: LOCAL-INSTALL

```tcl
./ansys/ansysbrowser/section/edit/functions/functions.tcl:312:  *beamsectioncreatestandardsolver $beamIndex 8 $beamSecSubType 0;
./ansys/ansysbrowser/section/new/functions/functions.tcl:208:       *beamsectioncreatestandardsolver $beamIndex 8 $beamSecSubType 2;
./br/views/certification/operations/Import.tcl:227:                        *beamsectioncreatestandardsolver $type 1 $type_name 0
```

---

### *beamsectionsetdataroot

- **Signature**: `*beamsectionsetdataroot <beamsect_id> <collector_id> <int> <int> <int> <int> <int> <double> <double> <int> <int> <int> <int>` — ví dụ: `*beamsectionsetdataroot $b_id $c_id 0 3 7 1 0 1 1 0 0 0 0`, `*beamsectionsetdataroot $bsect_id $collector_id 1 2 7 1 0 1.0 1.0 0 0 0 0`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: gán dữ liệu "root" cho beam section $beamsect_id thuộc collector $collector_id — chỉ 2 tham số đầu xác định rõ tên, phần còn lại (13 số) chưa xác định ý nghĩa.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/importcsv.tcl:35:    *beamsectionsetdataroot $b_id $c_id 0 3 7 1 0 1 1 0 0 0 0
./br/views/certification/operations/Import.tcl:231:                        *beamsectionsetdataroot $bsect_id $collector_id 1 2 7 1 0 1.0 1.0 0 0 0 0
./br/views/certification/operations/StructuralProperty.tcl:628:    *beamsectionsetdataroot $newBeamsectId 1 0 0 7 1 0 1 1 0 0 0 0
```

---

### *beamsectionsetdatashell

- **Signature**: `*beamsectionsetdatashell <int> <len_coordthick> <int> <len_vert> <int> <len_part> <beamsect_id> <len_part> <num_vert>` — ví dụ có tên biến rõ: `*beamsectionsetdatashell 1 $len_coordthick 1 $len_vert 1 $len_part $b_id $len_part $num_vert`. Cũng thấy dạng `eval` với danh sách: `eval *beamsectionsetdatashell $listID $numdbls $listID $numints $listID $numstrs $comdat`.
- **Return shape**: side-effect. Có dùng qua `eval` với `catch` để bắt lỗi (`set errMsg [catch {eval ...} err]`).
- **Precondition/side-effect**: thiết lập dữ liệu shell cho beam section — độ dài mảng tọa độ/độ dày ($len_coordthick), số đỉnh ($len_vert/$num_vert) — suy ra từ tên biến trực tiếp.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/importcsv.tcl:39:    *beamsectionsetdatashell 1 $len_coordthick 1 $len_vert 1 $len_part $b_id $len_part $num_vert
./HyperBeam/hyperbeamgui.tcl:2715:            set errMsg [catch {eval *beamsectionsetdatashell $listID $numdbls $listID $numints $listID $numstrs $comdat} err ];
```

---

### *beamsectionsetdatasolid

- **Signature**: `*beamsectionsetdatasolid <int> <numpoints> <order> <hollow> <beamsect_id>` — ví dụ: `*beamsectionsetdatasolid 1 [llength $pointlist] 1 0 $newBeamsectId`; và dạng biến rõ tên: `eval *beamsectionsetdatasolid $listID $numpoints $order $hollow $beamID`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: thiết lập dữ liệu solid cho beam section: số điểm ($numpoints, lấy từ `llength $pointlist`), bậc ($order), có rỗng hay không ($hollow) — bằng chứng trực tiếp từ tên biến ở `hyperbeamgui.tcl:1142`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/StructuralProperty.tcl:630:    *beamsectionsetdatasolid 1 [llength $pointlist] 1 0 $newBeamsectId
./HyperBeam/hyperbeamgui.tcl:1142:                        set errMsg [catch {eval *beamsectionsetdatasolid $listID $numpoints $order $hollow $beamID} err ];
```

---

### *beamsectionsetdatastandard

- **Signature**: `*beamsectionsetdatastandard <int> <int> <beamsect_id> <type> <int> <type_name>` — ví dụ: `*beamsectionsetdatastandard 1 12 $bsect_id $type 0 $type_name`, `*beamsectionsetdatastandard 1 3 $beamSectId 11 0 "Rod"`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: thiết lập dữ liệu standard-shape cho beam section (ví dụ "Rod"), tham số $type là mã số dạng tiết diện chuẩn (11 = Rod theo ví dụ) — suy ra từ ví dụ literal cụ thể.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/Import.tcl:233:                        *beamsectionsetdatastandard 1 12 $bsect_id $type 0 $type_name
./EngineeringSolutions/aerospace/rivetConnection/property_creation.tcl:1158:        *beamsectionsetdatastandard 1 3 $beamSectId 11 0 "Rod"
```

---

### *cardcreate

- **Signature**: `*cardcreate "<card_name>"` — CHỈ 1 tham số duy nhất là tên card dạng chuỗi. Ví dụ: `*cardcreate "CTRL_MODEL_DOC"`, `*cardcreate "ACMODL"`, `*cardcreate "$cardName"`. **Xác nhận: không có tham số property-id hay tên PSHELL nào — cách dùng `*cardcreate props 1 "PSHELL"` mà DeepSeek bịa là SAI hoàn toàn cú pháp lẫn tham số.**
- **Return shape**: side-effect, tạo mới 1 "card" (block dữ liệu solver-level) theo tên.
- **Precondition/side-effect**: chưa xác định điều kiện tiên quyết cụ thể — chỉ biết lệnh nhận đúng 1 tham số chuỗi tên card.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/modules/Documentation.tcl:253:    *cardcreate "CTRL_MODEL_DOC"
./ACM/helpers.tcl:320:        *cardcreate "ACMODL"
./ansys/ansys_analysis_options.tcl:220:            *cardcreate "$cardName"  
```

---

### *carddelete

- **Signature**: `*carddelete "<card_name>"` hoặc `*carddelete $card_name` — 1 tham số duy nhất là tên card. Ví dụ: `*carddelete "IMPORTED_MODEL_DOC"`, `*carddelete $card_name`, `*carddelete "STACK"`, `*carddelete "Units1"`.
- **Return shape**: side-effect, thường bọc trong `catch {...}`.
- **Precondition/side-effect**: xóa card đã tồn tại theo tên — cặp đối xứng với *cardcreate.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/pam2gDposProc.tcl:1358:            catch { *carddelete "IMPORTED_MODEL_DOC" }
./ddam/spec_setup.tcl:1338:             *carddelete $card_name 
./HyperMold/Moldflow/export_2.tcl:205:    *carddelete "Units1"
```

---

### *CE_DetailsCopy

- **Signature**: `*CE_DetailsCopy <ce_id> <int> <int>` — chỉ 1 chỗ gọi: `*CE_DetailsCopy $ce_id 1 0`.
- **Return shape**: chưa xác định.
- **Precondition/side-effect**: chưa xác định — CE có thể là viết tắt "Connector Entity" (dựa theo đường dẫn file `br/views/connectors/core/utils.tcl`), nhưng đây chỉ là suy đoán từ ngữ cảnh thư mục, không phải bằng chứng trực tiếp trong dòng code.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/connectors/core/utils.tcl:1467:  *CE_DetailsCopy $ce_id 1 0;
```

(Chỉ tìm thấy 1 chỗ gọi trong toàn bộ scripts.)

---

### *CE_DetermineConnectionType

- **Signature**: `*CE_DetermineConnectionType 1 0` — chỉ 1 chỗ gọi, cả 2 tham số đều là literal cố định (1 và 0).
- **Return shape**: chưa xác định (không có `set x [...]` bao quanh).
- **Precondition/side-effect**: chưa xác định — nằm trong thư mục `br/views/connectors/core/common/operations/tools.tcl`, gợi ý liên quan connector entity, nhưng không có bằng chứng trực tiếp về ý nghĩa tham số.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/connectors/core/common/operations/tools.tcl:47:         *CE_DetermineConnectionType 1 0
```

(Chỉ tìm thấy 1 chỗ gọi trong toàn bộ scripts.)

---

## Ghi chú tổng kết

- Tất cả 35 lệnh trong batch đều tìm thấy bằng chứng thật trong source `.tcl` — không có lệnh nào phải đánh dấu "KHÔNG TÌM THẤY".
- Nhiều lệnh thuộc họ `*attributeupdate*mark` và `*attributeupdate*arraymark` dùng chung một bộ 6 tham số đầu (`entity_type mark id solver status behavior`) trước khi thêm dữ liệu riêng — pattern này được xác nhận bằng nhiều call site độc lập ở các module abaqus khác nhau (AbaqusStep, Contact_wizard).
- Với các lệnh chỉ có 1 chỗ gọi (`*bagcreate`, `*barelementrotatebyangle`, `*CE_DetailsCopy`, `*CE_DetermineConnectionType`), độ tin cậy về ý nghĩa tham số thấp hơn — đã ghi rõ "chưa xác định" thay vì suy đoán.
- Không có entry nào trong file này bịa thêm/bớt số lượng tham số so với dòng code trích dẫn.


### *CE_FE_Absorb

- **Signature**: `*CE_FE_Absorb <arg1> <solver_name> <arg3> <arg4> <arg5> <arg6> <arg7> <arg8> <arg9> <arg10>` — số lượng tham số quan sát được thay đổi theo call site (7 đến 10 tham số), ví dụ `*CE_FE_Absorb 2 $solver_name 1 208 1 56 1 [llength $elem_filters(rbe2_rbe3)] 1 16;`
- **Return shape**: side-effect (không thấy gán kết quả vào biến ở các call site quan sát được).
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại trong context `connectors/fe_to_ce_generic.tcl` liên quan chuyển đổi connector FE→CE, được bọc trong `catch {...}` ở một số nơi.
- **Confidence**: LOCAL-INSTALL

```tcl
./connectors/fe_to_ce_generic.tcl:999:    *CE_FE_Absorb 1 $solver_name 2 "208 206" 0 "" 1 [llength $tie_elem_filter] 1 12;
./connectors/fe_to_ce_generic.tcl:1034:    *CE_FE_Absorb 2 $solver_name 1 208 1 56 1 [llength $elem_filters(rbe2_rbe3)] 1 16;
./connectors/fe_to_ce_generic.tcl:1268:    *CE_FE_Absorb 0 $solver_name 1 2 0 "" 1 [llength $elem_filter] 1 16;
```

---

### *CE_FE_GlobalFlags

- **Signature**: `*CE_FE_GlobalFlags <flag1> <flag2>` — 2 tham số số nguyên (0/1), ví dụ `*CE_FE_GlobalFlags $withfe 0;` hoặc `*CE_FE_GlobalFlags [expr !$cbValue] 1;`
- **Return shape**: side-effect, không gán biến.
- **Precondition/side-effect**: chưa xác định chính xác cơ chế bên trong — chỉ biết được gọi trong context xóa connector (`br/views/connectors/core/common/operations/delete.tcl`) và trong `utils.tcl` liên quan connector "withfe" flag.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/connectors/core/common/operations/delete.tcl:73:      *CE_FE_GlobalFlags [expr !$cbValue] 1; 
./br/views/connectors/core/utils.tcl:1804:  *CE_FE_GlobalFlags $withfe 0;
./dynakey/partReplacement/ifix.tcl:471:     *CE_FE_GlobalFlags 0 0;
```

---

### *CE_FE_RegisterAdvanced

- **Signature**: `*CE_FE_RegisterAdvanced <entity_type> <flag> <size>` — 3 tham số, ví dụ `*CE_FE_RegisterAdvanced elements 1 4` hoặc `*CE_FE_RegisterAdvanced $ent_type 1 $size;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — quan sát thấy `$ent_type` có thể là `elements` hoặc `equations` (tên collector-type dạng chuỗi), tham số thứ 2 luôn là `1` trong mọi call site quan sát được, tham số 3 là kích thước mảng (`$size`, `[expr $n_elemsToCon+3]`).
- **Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_ansys.tcl:413:            *CE_FE_RegisterAdvanced  elements 1 4
./connectors/prop_opt_nas_hilock.tcl:398:    *CE_FE_RegisterAdvanced $ent_type 1 $size;
./femsite/femsite_gui.tcl:2421:										*CE_FE_RegisterAdvanced equations 1 [expr $n_equan+3];
```

---

### *CE_FE_UnregisterRealizedEntities

- **Signature**: `*CE_FE_UnregisterRealizedEntities <flag>` — 1 tham số, ví dụ `*CE_FE_UnregisterRealizedEntities 1;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ tìm thấy DUY NHẤT 1 call site trong toàn bộ scripts folder.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/connectors/core/utils.tcl:2105:      *CE_FE_UnregisterRealizedEntities 1;
```

---

### *centroid1dmode

- **Signature**: có 2 dạng gọi quan sát được — không tham số: `*centroid1dmode;` và có 1 tham số: `*centroid1dmode 0`
- **Return shape**: side-effect.
- **Precondition/side-effect**: comment tại `HyperBeam/hyperbeamgui.tcl:823` ghi rõ: "`*centroid1dmode` must be last. This fixes: [tiếp câu ở dòng sau, nội dung cụ thể không trích dẫn được đầy đủ]" — cho thấy lệnh này phải được gọi CUỐI CÙNG trong một chuỗi thao tác liên quan tới beam/centroid 1D.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/importcsv.tcl:46:    *centroid1dmode 0
./HyperBeam/hyperbeamgui.tcl:823:    # *centroid1dmode must be last. This fixes:
./HyperBeam/hyperbeamgui.tcl:825:    *centroid1dmode;
```

---

### *checkpenetration

- **Signature**: `*checkpenetration components 1 0 1 0 0 0 0 0;` — 9 tham số quan sát được (entity-type string `components` + 8 số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ tìm thấy DUY NHẤT 1 call site.
- **Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/assembly_tc.tcl:319:    *checkpenetration components 1 0 1 0 0 0 0 0;
```

---

### *clearallidranges

- **Signature**: `*clearallidranges` — không tham số, gọi trực tiếp không có đối số nào ở call site duy nhất tìm thấy.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — nằm trong `br/views/idmgr/operations/clear.tcl` (ID manager, liên quan "clear" operation).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/clear.tcl:156:    *clearallidranges
```

---

### *clearallunresolvedids

- **Signature**: `*clearallunresolvedids <entity_type>` — 1 tham số chuỗi entity-type (`props`, `comps`, `components`, `assemblies`), ví dụ `*clearallunresolvedids props`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — dùng trong context AssemblyCrashBrowser và AutoPropertyCreate.
- **Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/profiles/crash/browser/AssemblyCrashBrowser.tcl:605:    *clearallunresolvedids props
./AutoPropertyCreate.tcl:109:    *clearallunresolvedids components;
./EngineeringSolutions/aerospace/srcHyperReportDemo/5_customerAddOns/modules/add_nastran_cards.tcl:43:    *clearallunresolvedids assemblies
```

---

### *clearlist

- **Signature**: `*clearlist <entity_type> <list_index>` — 2 tham số, ví dụ `*clearlist nodes 1;` hoặc `*clearlist lines 2;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — entity_type quan sát được: `nodes`, `lines`. Tham số 2 có vẻ là chỉ số danh sách (1 hoặc 2), dùng lặp lại theo cặp trong `ARSDialog.tcl`.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AnalyticalRigid/ARSDialog.tcl:224:    *clearlist nodes 1;
./abaqus/AnalyticalRigid/ARSDialog.tcl:225:    *clearlist nodes 2;
./abaqus/AnalyticalRigid/ARSDialog.tcl:226:    *clearlist lines 1;
```

---

### *clearmarkall

- **Signature**: `*clearmarkall <mark_number>` — 1 tham số số nguyên (mark id), ví dụ `*clearmarkall 1;` hoặc `*clearmarkall 2`
- **Return shape**: side-effect.
- **Precondition/side-effect**: comment tại `AssemblyHmBrowser.tcl:200` ghi "`# TODO: Is this really needed.`" ngay sau lệnh — cho thấy dùng để xóa mark trước/sau một thao tác chọn entity, nhưng không xác nhận rõ mục đích chính xác.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1760:		*clearmarkall 2  
./assemblytools/at/browser/AssemblyHmBrowser.tcl:200:  *clearmarkall 1;  # TODO: Is this really needed.
./assemblytools/at/browser/ShowEntity.tcl:39:        *clearmarkall 1
```

---

### *collectorcreateonly

- **Signature**: `*collectorcreateonly <entity_type> <name> <arg3> <color>` — 4 tham số, ví dụ `*collectorcreateonly comps ^Main_Rods "" 3` hoặc `*collectorcreateonly components $newname "" $color;`
- **Return shape**: side-effect (tạo collector mới), không thấy gán biến ở các call site.
- **Precondition/side-effect**: chưa xác định ý nghĩa tham số thứ 3 (luôn là chuỗi rỗng `""` trong mọi call site quan sát được).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:514:        *collectorcreateonly comps ^Main_Rods "" 3
./abaqus/Contact_wizard/CWinterface/CWautocontact.tcl:312:      *collectorcreateonly components $newname "" $color;
./ansys/ansysbrowser/real/new/functions/functions.tcl:51:    *collectorcreateonly properties $propName "" 7
```

---

### *collectorcreatesameas

- **Signature**: `*collectorcreatesameas <entity_type> <new_name> <same_as_name> <arg4> <color>` — 5 tham số, ví dụ `*collectorcreatesameas loadcols $strNewLoadName $strSameAsName "" 1;` hoặc `*collectorcreatesameas comps $newcompname $compname $matname $sym_color`
- **Return shape**: side-effect (tạo collector mới sao chép thuộc tính từ collector khác).
- **Precondition/side-effect**: chưa xác định — entity_type quan sát: `loadcols`, `props`, `comps`. Tham số 4 khi là `comps` thì truyền `$matname` (material name) thay vì chuỗi rỗng.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/load.tcl:1137:        *collectorcreatesameas loadcols $strNewLoadName $strSameAsName "" 1;
./ansys/ContactManager/contactpair/symmetric_contact.tcl:246:    *collectorcreatesameas comps $newcompname $compname $matname $sym_color 
```

---

### *collisionmanualfix_temp

- **Signature**: `*collisionmanualfix_temp 1 2 <distance_expr> <directionType> <iflag1> <iflag2> <iflag3>` — 7 tham số, ví dụ:
  `*collisionmanualfix_temp 1 2 [expr $direction*$::hmbr::collision::manualfix::distanceValue] $::hmbr::collision::manualfix::directionType $::hmbr::collision::manualfix::iflags(1) $::hmbr::collision::manualfix::iflags(2) $::hmbr::collision::manualfix::iflags(3)`
- **Return shape**: side-effect.
- **Precondition/side-effect**: được bọc giữa `hm_private_frwk enablehistoryfromtcl 1` (trước) và `hm_private_frwk enablehistoryfromtcl 0` (sau) — cho thấy lệnh này cần được ghi vào history stack tạm thời khi thực thi. Hậu tố `_temp` gợi ý đây là API nội bộ/tạm thời của HM (không chính thức public).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/collision/widgets/manualfixtools.tcl:279:    hm_private_frwk enablehistoryfromtcl 1
./br/views/collision/widgets/manualfixtools.tcl:280:    *collisionmanualfix_temp 1 2 [expr $direction*$::hmbr::collision::manualfix::distanceValue] $::hmbr::collision::manualfix::directionType \
./br/views/collision/widgets/manualfixtools.tcl:281:                                      $::hmbr::collision::manualfix::iflags(1) $::hmbr::collision::manualfix::iflags(2) $::hmbr::collision::manualfix::iflags(3)
./br/views/collision/widgets/manualfixtools.tcl:282:    hm_private_frwk enablehistoryfromtcl 0
```

---

### *collisionrecheck_temp

- **Signature**: `*collisionrecheck_temp <entity_type> <flag>` — 2 tham số, ví dụ `*collisionrecheck_temp collisions 1;` hoặc `*collisionrecheck_temp groups 1`
- **Return shape**: side-effect. Ở dòng 1177 gọi qua `eval *collisionrecheck_temp groups 1;`.
- **Precondition/side-effect**: chưa xác định — hậu tố `_temp` gợi ý API nội bộ/tạm thời giống `*collisionmanualfix_temp`. entity_type quan sát: `groups`, `collisions`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/collision/widgets/collision.tcl:1177:                eval *collisionrecheck_temp groups 1;
./br/views/collision/widgets/collision.tcl:1184:            *collisionrecheck_temp collisions 1;            
```

---

### *compactsubmodelids

- **Signature**: `*compactsubmodelids submodel <iid> <type> <poolnumber>` — 4 tham số, chỉ có 1 call site: `*compactsubmodelids submodel $iid $type $poolnumber`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — nằm trong `br/views/idmgr/operations/compactentities.tcl` (ID manager, compact submodel entity ids).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/compactentities.tcl:29:        *compactsubmodelids submodel $iid $type $poolnumber
```

---

### *contactsurfcreatewithfaces

- **Signature**: `*contactsurfcreatewithfaces <name> <color> <arg3> <arg4> <angle> <arg6> <arg7>` — 7 tham số, ví dụ `*contactsurfcreatewithfaces $contsurf_name $sur_color 1 1 30 1 1` hoặc `*contactsurfcreatewithfaces $csurf_name $::AbaqusCW::ElsurPage::sur_color 1 1 $breanAngle 1 0`
- **Return shape**: side-effect. Luôn được gọi bên trong `catch {...}` hoặc `if {![catch {...}]}` — cho thấy lệnh có thể thất bại (validate input).
- **Precondition/side-effect**: tham số thứ 5 quan sát được là góc (literal `30` hoặc biến `$breanAngle` — tên biến gợi ý "break angle"), nhưng chưa xác định chắc chắn do chỉ suy từ tên biến.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1913:                if { ![catch {*contactsurfcreatewithfaces $contsurf_name $sur_color 1 1 30 1 1}] } {
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:2880:            catch {*contactsurfcreatewithfaces $csurf_name $::AbaqusCW::ElsurPage::sur_color 1 1 $breanAngle 1 0};
```

---

### *contactsurfcreatewithshells

- **Signature**: 2 dạng tham số quan sát được — `*contactsurfcreatewithshells <name> <color> <arg3> <n_list>` (4 tham số, ví dụ `*contactsurfcreatewithshells $contsurf_name $sur_color 1 $n_list`) và `*contactsurfcreatewithshells "<setName>" 1 1 0` (4 tham số literal).
- **Return shape**: side-effect. Cũng thường bọc trong `catch {...}`.
- **Precondition/side-effect**: chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1895:                if { ![catch {*contactsurfcreatewithshells $contsurf_name $sur_color 1 $n_list}] } {
./dynakey/partReplacement/contacts.tcl:1025:        *contactsurfcreatewithshells "$setName" 1 1 0
```

---

### *copymark

- **Signature**: `*copymark <entity_type> <mark_number> <name_or_expr>` — 3 tham số, ví dụ `*copymark elems 1 $newname;` hoặc `*copymark elems 1 "^acoustically_rigid_fluid_faces"`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — entity_type quan sát: `elems`, `lines`. Tham số 3 có thể là tên component/collector đích (dùng cú pháp `^tên` để tạo mới, thấy trong `ACM/helpers.tcl`) hoặc biến `$newname`.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWinterface/CWautocontact.tcl:326:          *copymark elems 1 $newname;
./ACM/helpers.tcl:196:                *copymark elems 1 "^acoustically_rigid_fluid_faces" ;
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage1.tcl:3735:        *copymark lines 1 $currentComp2;
```

---

### *copytoclipboard

- **Signature**: `*copytoclipboard mark=<mark_id> componentrule=<rule> referencerule=<rule> includefilerule=<rule> holderrule=<rule> includefileids=<ids>` — dùng cú pháp key=value, chỉ có 1 call site tìm thấy:
  `*copytoclipboard mark=1 componentrule=FE_AND_GEOM referencerule=COPY_BOTH includefilerule=IGNORE holderrule=ALL includefileids=$includeIds`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — nằm trong `br/common/operations/copy.tcl` (copy operation), giá trị các rule quan sát được: `componentrule=FE_AND_GEOM`, `referencerule=COPY_BOTH`, `includefilerule=IGNORE`, `holderrule=ALL`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/copy.tcl:77:    *copytoclipboard mark=1 componentrule=FE_AND_GEOM referencerule=COPY_BOTH includefilerule=IGNORE holderrule=ALL includefileids=$includeIds
```

---

### *correctoverflowsubmodelentityids

- **Signature**: có 2 dạng tham số quan sát được — 5 tham số: `*correctoverflowsubmodelentityids submodel <iid> <type> <markOption> <datatype>` hoặc 6 tham số: `*correctoverflowsubmodelentityids submodel <iid> <type> <markOption> <datatype> <poolnumber>`, ví dụ:
  `*correctoverflowsubmodelentityids submodel $_iid $typename "both overflow ids" "$correctionOptionStr" $poolnumber;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — nằm trong ID manager (`br/views/idmgr/operations/correctoverflow.tcl`, `idoverflow.tcl`) và export flow (`ImportExport/export_fe.tcl`), liên quan sửa lỗi overflow ID khi ghép submodel.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/correctoverflow.tcl:62:        *correctoverflowsubmodelentityids submodel $iid $type $markOption $datatype $poolnumber
./br/views/idmgr/operations/idoverflow.tcl:304:    *correctoverflowsubmodelentityids submodel $_iid $typename "both overflow ids" "$correctionOptionStr" $poolnumber; 
./ImportExport/export_fe.tcl:712:           *correctoverflowsubmodelentityids submodel 0 0 "both overflow ids" "Insert In Gaps"
```

---

### *createandassignstructuralproperty

- **Signature**: `*createandassignstructuralproperty <id> <flag>` — 2 tham số, chỉ có 1 call site: `*createandassignstructuralproperty $copiedseid 1`
- **Return shape**: side-effect. Được gọi ngay sau `eval *createmark designpoints 1 $selectedddpids;` trong cùng block code.
- **Precondition/side-effect**: dựa vào ngữ cảnh dòng trước (`eval *createmark designpoints 1 $selectedddpids;`), lệnh này có thể phụ thuộc vào mark designpoints vừa tạo, nhưng chưa xác định chắc chắn.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/CopyPaste.tcl:40:					eval *createmark designpoints 1 $selectedddpids;
./br/views/certification/operations/CopyPaste.tcl:42:					*createandassignstructuralproperty $copiedseid 1
```

---

### *createarray

- **Signature**: `*createarray <length> <value_list>` — 2 tham số, thường gọi qua `eval`, ví dụ `eval *createarray $length $valueList;` hoặc `eval *createarray $numBCEntries $setIdList;`
- **Return shape**: side-effect (tạo mảng nội bộ HM từ list Tcl).
- **Precondition/side-effect**: cách dùng `eval` cho thấy `$valueList`/`$setIdList` được expand thành nhiều đối số riêng lẻ khi truyền vào lệnh (không truyền nguyên list làm 1 tham số).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:2556:	eval *createarray $length $valueList;
./abaqus/AbaqusStep/load/bc/bc_tab1.tcl:1380:        eval *createarray $numBCEntries $setIdList;
./abaqus/AbaqusStep/interface/interface.tcl:850:                *createarray 1 0
```

---

### *createcrbrelation

- **Signature**: `*createcrbrelation <parent_id> <child_id>` — 2 tham số, ví dụ `*createcrbrelation $parentid $newlySelectedCompId;` hoặc `*createcrbrelation $selectedCompId $newlySelectedCompId;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — nằm trong context CRBHierarchy (component-relationship-by-hierarchy), tên tham số gợi ý parent/child component id nhưng không có comment xác nhận.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/organizeentites.tcl:300:                    *createcrbrelation $parentid $newlySelectedCompId;
./br/views/CRBHierarchy/operations/add.tcl:86:    *createcrbrelation $selectedCompId $newlySelectedCompId;
```

---

### *createdynamicdataname

- **Signature**: `*createdynamicdataname <entity_type> <mark> dataname="<name>" displayname="<disp>" basictype=<type> defaultvalue=<val> ... visible=<bool> editable=<bool>` — dùng cú pháp key=value nhiều tham số biến đổi, ví dụ:
  `*createdynamicdataname designpointmethod 1  dataname="uid" ...` và
  `*createdynamicdataname structuralproperty 1 "dataname=$varName" "displayname=$varName" "basictype=$basicType" "defaultvalue=$varVal" "$valAllow" "$valdiff" "visible=$varVisible" "editable=$varEdit"`
- **Return shape**: side-effect (tạo dataname động cho entity).
- **Precondition/side-effect**: chưa xác định toàn bộ — entity_type quan sát: `designpointmethod`, `structuralproperty`. Có 2 tham số key=value không rõ tên (`$valAllow`, `$valdiff`) chưa xác định ý nghĩa từ code.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/methodmanager/Implementation/Interface.tcl:120:                *createdynamicdataname designpointmethod 1  dataname="uid"\
./context/src/stressToolBox/methodassign.tcl:332:                            *createdynamicdataname designpointmethod 1 "dataname=$varName" "displayname=$varName" "basictype=$basicType" "defaultvalue=$varVal" "$valAllow" "$valdiff" "visible=$varVisible" "editable=$varEdit"
```

---

### *createelement

- **Signature**: `*createelement <config> <arg2> <arg3> <arg4>` — 4 tham số, ví dụ `*createelement $FaceConfig 1 1 0;` hoặc `*createelement 2 1 1 1; # create a plot element;`
- **Return shape**: side-effect. Cũng dùng như callback event name: `AddCallback *createelement ::solverBrowser::...` (đăng ký callback khi element được tạo — cho thấy đây là 1 "creation event" trong HM).
- **Precondition/side-effect**: comment tại `common_nas_os/dmigreview.tcl:60` ghi rõ: "`# create a plot element;`" — xác nhận call site đó tạo ra 1 "plot element".
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Renumber_tool/cont_shell.tcl:272:                *createelement $FaceConfig 1 1 0;
./common_nas_os/dmigreview.tcl:60:        *createelement 2 1 1 1; # create a plot element;
./browser/bringUpthePopUp.tcl:2000:        AddCallback *createelement ::solverBrowser::contextSensitiveMenu::UpdateAttributesForElements;
```

---

### *createentitiesfromsource

- **Signature**: dùng cú pháp key=value, ví dụ `*createentitiesfromsource entitytype=FREEBODYSECTIONS source=$filename` hoặc `eval *createentitiesfromsource source=$sourcetype sourceentitytype=parts sourceentitymark=1 matcardimage=$::Marine::ferealize::materialtypeCheckboxvalue`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định toàn bộ tập keyword hợp lệ — quan sát được các key: `entitytype`, `source`, `sourceentitytype`, `sourceentitymark`, `matcardimage`, `prop1dcardimage`, `prop2dcardimage`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/Import.tcl:42:            *createentitiesfromsource entitytype=FREEBODYSECTIONS source=$filename
./EngineeringSolutions/Marine/beammeshing/FeRealize.tcl:324:		eval *createentitiesfromsource source=$sourcetype sourceentitytype=parts sourceentitymark=1 matcardimage=$::Marine::ferealize::materialtypeCheckboxvalue
```

---

### *createentitypanel

- **Signature**: `*createentitypanel <entity_type> <mark_or_prompt> [<prompt_text>]` — 2 hoặc 3 tham số, ví dụ `*createentitypanel nodes 1` hoặc `*createentitypanel sets "Select Nset";` hoặc `*createentitypanel materials 1 "Select material...";`
- **Return shape**: side-effect (mở panel chọn entity trong GUI).
- **Precondition/side-effect**: chưa xác định — entity_type quan sát: `nodes`, `sets`, `materials`, `beamsects`, `vectors`.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWinterface/CWcontactpair3.tcl:438:		*createentitypanel nodes 1
./abaqus/PretensionManager.tcl:201:        *createentitypanel sets "Select Nset";
./br/views/certification/operations/StructuralProperty.tcl:683:               *createentitypanel materials 1 "Select material...";
```

---

### *createentitysameas

- **Signature**: `*createentitysameas <entity_type> <id_or_ids>` — 2 tham số, ví dụ `*createentitysameas $type $ids` hoặc `*createentitysameas cards $id` hoặc `*createentitysameas designpointset $ddpSetIds`
- **Return shape**: side-effect (tạo entity mới sao chép từ entity nguồn theo id).
- **Precondition/side-effect**: chưa xác định — entity_type quan sát: dynamic `$type`, `cards`, `designpointset`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/duplicate.tcl:35:        *createentitysameas $type $ids
./br/common/operations/duplicate.tcl:42:            *createentitysameas cards $id
./br/views/certification/operations/duplicateddpset.tcl:19:	*createentitysameas designpointset $ddpSetIds
```

---

### *createinclude

- **Signature**: có 2 dạng — không tham số: `*createinclude` và 4 tham số: `*createinclude <flag> "<name1>" "<name2>" <flag2>`, ví dụ `*createinclude 0 "dummy_${pam_dummyName}" "dummy_${pam_dummyName}" 0` hoặc `*createinclude 0 $include_file $include_file 0`
- **Return shape**: side-effect (tạo include file mới).
- **Precondition/side-effect**: chưa xác định — 2 tên truyền vào giống hệt nhau ở mọi call site 4-tham-số quan sát được (tên1 == tên2), gợi ý có thể là "display name" và "file name" giống nhau, nhưng không có bằng chứng comment xác nhận.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/pampostohm.tcl:91:    if { [catch { *createinclude 0 "pos_[set pam_dummyName]" "pos_[set pam_dummyName]" 0 } error] } {
./advc/advc_create_cards.tcl:428:    *createinclude
./assemblytools/assembly_tc.tcl:692:    set code [catch {*createinclude 0 $include_file $include_file 0} result];
```

---

### *createlistpanel

- **Signature**: `*createlistpanel <entity_type> <mark> <prompt_text>` — 3 tham số, ví dụ `*createlistpanel nodes $mark $comments;` hoặc `*createlistpanel lines 1 "Pick lines ...";`
- **Return shape**: side-effect (mở panel chọn danh sách entity trong GUI, tương tự `*createentitypanel` nhưng cho phép chọn nhiều/nhấn prompt).
- **Precondition/side-effect**: chưa xác định — entity_type quan sát: `nodes`, `lines`.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AnalyticalRigid/ARSDialog.tcl:444:    *createlistpanel nodes $mark $comments;
./abaqus/AnalyticalRigid/ARSPage.tcl:541:    *createlistpanel lines 1 "Pick lines ...";
./ansys/pretension_bolt.tcl:598:	    *createlistpanel nodes 1 "Select 3 nodes to define direction for pretension"
```

---

### *createnode

- **Signature**: `*createnode <x> <y> <z> <local_syst> <arg5> <arg6> [<arg7>]` — 6 hoặc 7 tham số tổng cộng, ví dụ `*createnode $x $y $z $local_syst 0 0;` (6 tham số) hoặc `*createnode 0 0 0 0 0 0 0` (7 tham số). LƯU Ý: KHÔNG phải `*createnode $x $y $z 0` (4 tham số) như DeepSeek đã bịa — bằng chứng thực tế cho thấy luôn có ít nhất 6 tham số.
- **Return shape**: side-effect (tạo node mới tại tọa độ x,y,z).
- **Precondition/side-effect**: chưa xác định ý nghĩa chính xác của tham số 4 (`local_syst` — tên biến gợi ý local system id) và các tham số 5-7 (luôn là `0` trong mọi call site quan sát được).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AnalyticalRigid/ARSDialog.tcl:211:    *createnode $x $y $z $local_syst 0 0;
./abaqus/dummypos/tclincludes/pampostohm.tcl:876:            *createnode 0 0 0 0 0 0 0
./abaqus/dummypos/tclincludes/pampostohm.tcl:888:	   eval *createnode [ expr { $x + 10 } ] $y $z 0 0 0
```

---

### *createorthotropicdirection

- **Signature**: `*createorthotropicdirection` — không tham số, chỉ 1 call site duy nhất tìm thấy trong toàn bộ scripts folder.
- **Return shape**: side-effect.
- **Precondition/side-effect**: comment ngay phía trên (dòng 1563) ghi rõ: "`# Create INISHE_ORTHO_LOC table for radioss profile.`" — xác nhận lệnh này tạo bảng INISHE_ORTHO_LOC cho Radioss profile. Được bọc giữa `hm_private_frwk enablehistoryfromtcl 1` và `... 0`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/composite/operations/drapeestimator_perform.tcl:1562:		if { $::g_profile_name == "RadiossBlock" && $drapeSuccess == 1 && [string map -nocase {Block "" Radioss ""} $::g_sub_profile_name] < 2017} {
./br/views/composite/operations/drapeestimator_perform.tcl:1563:			# Create INISHE_ORTHO_LOC table for radioss profile.
./br/views/composite/operations/drapeestimator_perform.tcl:1564:			hm_private_frwk enablehistoryfromtcl 1
./br/views/composite/operations/drapeestimator_perform.tcl:1565:			*createorthotropicdirection
```

---

### *createplane

- **Signature**: `*createplane <mode> <normal_x> <normal_y> <normal_z> <base_x> <base_y> <base_z>` — 7 tham số, ví dụ `*createplane 1 $rev_x $rev_y $rev_z $base_x $base_y $base_z;` hoặc `eval *createplane 1 $X $Y $Z $baseX $baseY $baseZ`
- **Return shape**: side-effect (tạo plane entity mới).
- **Precondition/side-effect**: chưa xác định ý nghĩa chính xác tham số đầu (`1` cố định trong mọi call site — có thể là mode/type cố định "define by normal+base point").
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage1.tcl:4790:                *createplane 1 $rev_x $rev_y $rev_z $base_x $base_y $base_z;
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:422:  eval *createplane 1 $X $Y $Z $baseX $baseY $baseZ
```

---

### *createpoint

- **Signature**: có 2 dạng — 4 tham số: `*createpoint <x> <y> <z> <sys_id>` ví dụ `*createpoint $x $y $z $sysId` hoặc 3 tham số: `*createpoint <x> <y> <z>` ví dụ `*createpoint $x $y $z`
- **Return shape**: side-effect (tạo point entity mới tại tọa độ x,y,z, tùy chọn theo hệ tọa độ `sysId`).
- **Precondition/side-effect**: chưa xác định — comment tại `FlangeDetection.tcl:601` (`#puts "*createpoint $X $Y $Z 0"`) cho thấy có ý định debug với 1 tham số thêm `0`, nhưng dòng code thực thi thực tế (dòng 600) chỉ dùng 4 tham số `$X $Y $Z 0`.
- **Confidence**: LOCAL-INSTALL

```tcl
./EngineeringSolutions/aerospace/rivetConnection/rivetConnection.tcl:3280:                           *createpoint $x $y $z $sysId
./EngineeringSolutions/aerospace/rivetConnection/rivetConnection.tcl:3282:                        *createpoint $x $y $z 
./FlangeDetection.tcl:600:                *createpoint $X $Y $Z 0
```

---

### *createpositionformech

- **Signature**: `*createpositionformech <position_name>` — 1 tham số chuỗi, ví dụ `*createpositionformech $positionName` hoặc `*createpositionformech Initial;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ có 2 call site, cả hai đều trong `br/views/mechanism/operations/mechanismFunctions.tcl` (liên quan mechanism/position trong HyperMesh).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/mechanism/operations/mechanismFunctions.tcl:210:    *createpositionformech $positionName
./br/views/mechanism/operations/mechanismFunctions.tcl:291:        *createpositionformech Initial;
```

---

### *createsensor

- **Signature**: `*createsensor <name>` — 1 tham số chuỗi, ví dụ `*createsensor $sensName;` hoặc `*createsensor $sym_etname`
- **Return shape**: side-effect (tạo sensor entity mới với tên chỉ định).
- **Precondition/side-effect**: chưa xác định — dùng trong nhiều context ANSYS contact manager (autocontact, ettype).
- **Confidence**: LOCAL-INSTALL

```tcl
./ansys/ansysbrowser/ettype/new/functions/functions.tcl:51:    *createsensor $sensName;
./ansys/ContactManager/contactpair/autocontact_tab.tcl:1421:    *createsensor $sensname;
./ansys/ContactManager/contactpair/symmetric_contact.tcl:319:    *createsensor $sym_etname
```

---

### *currentcollector

- **Signature**: `*currentcollector <entity_type> <collector_id_or_name>` — 2 tham số, ví dụ `*currentcollector loadcols $::AbaqusStep::load::currentLoadcol;` hoặc `*currentcollector loadcols $currentLoadcol;`
- **Return shape**: side-effect (set collector hiện hành/active để các thao tác tiếp theo dùng).
- **Precondition/side-effect**: chưa xác định — entity_type quan sát duy nhất trong batch này: `loadcols`. Tên lệnh gợi ý set "current collector" theo ngữ cảnh (tương tự khái niệm active/current component trong HM), nhưng đây chỉ là suy luận từ tên lệnh, không phải bằng chứng comment.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/cload/cload_tab1.tcl:1651:                    *currentcollector loadcols $::AbaqusStep::load::currentLoadcol;
./abaqus/AbaqusStep/load/load.tcl:1375:            *currentcollector loadcols $currentLoadcol;
./abaqus/AbaqusStep/loadcase/loadcase.tcl:936:            *currentcollector loadcols $currentLoadcol;
```

---

## Ghi chú tổng kết

- Batch gốc liệt kê dòng cuối "38" nhưng dòng đó trống (không có tên lệnh) — không có mục thứ 38 nào để xử lý; tổng số lệnh thực tế xử lý là 37 (dòng 1-37).
- Không có lệnh nào trong batch này rơi vào trường hợp "KHÔNG TÌM THẤY" — toàn bộ 37 lệnh đều có ít nhất 1 call site thật trong `.tcl` source.
- Trường hợp cần lưu ý đặc biệt: `*CE_FE_UnregisterRealizedEntities`, `*checkpenetration`, `*clearallidranges`, `*compactsubmodelids`, `*createandassignstructuralproperty`, `*createorthotropicdirection`, `*createinclude` (dạng không tham số) chỉ có 1 (hoặc rất ít) call site — độ tin cậy về tính đầy đủ của signature thấp hơn các lệnh có nhiều call site đa dạng.


### *curveaddpoint

- **Signature**: `*curveaddpoint <curve_id> <point_index> <coord_a> <coord_b>` — quan sát: `*curveaddpoint $curve_id1 0 0 0.05`, `*curveaddpoint $curve_id1 1 0.5 0.05` (4 tham số sau tên lệnh: id đường cong, chỉ số điểm tăng dần 0,1,2,3..., rồi 2 giá trị số).
- **Return shape**: side-effect (không gán vào biến trong các dòng quan sát được).
- **Precondition/side-effect**: chưa xác định rõ ý nghĩa 2 giá trị số cuối (có thể x/y của curve theo tham số hoá) — chỉ biết chúng là số thực tăng/giảm dần theo ngữ cảnh file `HC_HexaAdhesive_rad.tcl`.
- **Confidence**: LOCAL-INSTALL

```tcl
./connectors/HC_HexaAdhesive_rad.tcl:59:  *curveaddpoint $curve_id1 0 0 0.05
./connectors/HC_HexaAdhesive_rad.tcl:60:  *curveaddpoint $curve_id1 1 0.5 0.05
./connectors/HC_HexaAdhesive_rad.tcl:61:  *curveaddpoint $curve_id1 2 1 0
./connectors/HC_HexaAdhesive_rad.tcl:62:  *curveaddpoint $curve_id1 3 2 0
```

---

### *curvedeletepoint

- **Signature**: `*curvedeletepoint <curve_id> <point_index>` — quan sát nhất quán ở 5 file khác nhau, luôn đúng 2 tham số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi (2 tham số: id curve, index điểm cần xoá).
- **Confidence**: LOCAL-INSTALL

```tcl
./ddam/spec_setup.tcl:989:            *curvedeletepoint $cur_lc_id 1
./HMCurveEditor.tcl:2603:        *curvedeletepoint $id 1;
./nastran/Tabled1.tcl:775:                *curvedeletepoint $loadid 1
```

---

### *curvemodifypointcords

- **Signature**: `*curvemodifypointcords <curve_id> <point_index> -<axis> <value>` — quan sát: `*curvemodifypointcords $id $row -$axis $val`, `*curvemodifypointcords $lcid 1 -y $varvalue` (tham số 3 là flag trục dạng `-x`/`-y`, tham số 4 là giá trị).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh sửa toạ độ 1 điểm trên curve theo trục chỉ định bằng flag `-axis`.
- **Confidence**: LOCAL-INSTALL

```tcl
./HMCurveEditor.tcl:826:        *curvemodifypointcords $id $row -$axis $val
./HyperStudy/hsdyna_hf.tcl:416:					*curvemodifypointcords $lcid 1 -y $varvalue
./HyperStudy/hsdyna_hf.tcl:431:						*curvemodifypointcords $lcmaxid 1 -y $varvalue
```

---

### *deleteedges

- **Signature**: `*deleteedges` — quan sát: gọi KHÔNG tham số trong mọi trường hợp.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh gọi không tham số, xuất hiện trong ngữ cảnh xử lý edge loops / spider macro.
- **Confidence**: LOCAL-INSTALL

```tcl
./EngineeringSolutions/aerospace/PlyToStep/includes/EdgeLoops.tcl:45:		*deleteedges
./modeltour.tcl:356:                *deleteedges;
./nastran/spiderMacro.tcl:330:               *deleteedges
```

---

### *deleteidrange

- **Signature**: `*deleteidrange <entity_type> <id_or_pair> <extra_arg>` — quan sát: `*deleteidrange submodel [lindex $pair 2] "" [lindex $pair 0] [lindex $pair 1]` (5 tham số) và `*deleteidrange submodel $iid ""` (3 tham số) — số tham số KHÔNG cố định giữa 2 lần gọi quan sát được.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết entity_type quan sát được luôn là `submodel`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/clear.tcl:27:        *deleteidrange submodel [lindex $pair 2] "" [lindex $pair 0] [lindex $pair 1]
./br/views/idmgr/operations/clear.tcl:95:        *deleteidrange submodel $iid ""
```

---

### *deletemodel

- **Signature**: `*deletemodel` — quan sát: gọi không tham số trong mọi dòng tìm thấy.
- **Return shape**: side-effect. Có callback riêng: `::hwt::AddCallback *deletemodel ...` cho thấy đây là một event/command có thể hook.
- **Precondition/side-effect**: chưa xác định chi tiết — theo tên lệnh và ngữ cảnh dùng trong `ExportFiles.tcl`/`LoadDummy.tcl` có vẻ liên quan xoá toàn bộ model hiện tại, nhưng không có comment xác nhận rõ ràng.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/autocontact_tab.tcl:146:  ::hwt::AddCallback *deletemodel ::autocontact::DeleteModelAttempted after;
./abaqus/dummypos/modules/ExportFiles.tcl:469:        	*deletemodel
./abaqus/dummypos/modules/LoadDummy.tcl:148:            *deletemodel
```

---

### *deletesolidswithelems

- **Signature**: `*deletesolidswithelems <flag1> <flag2> <flag3>` — quan sát nhất quán: `*deletesolidswithelems 1 1 1`, `*deletesolidswithelems 1 1 0`, luôn 3 tham số cờ 0/1.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa từng cờ cụ thể — chỉ biết luôn truyền 3 giá trị 0 hoặc 1.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/delete.tcl:580:                *deletesolidswithelems 1 1 1
./cfd/AcuSolve_Organize_Model.tcl:12:	*deletesolidswithelems 1 1 0
./br/views/cfdpartbrowser/operations/deletecfdpartbrentities.tcl:82:                    catch {*deletesolidswithelems 1 0 0}
```

---

### *detach_fromelements

- **Signature**: `*detach_fromelements <mode_flag> <entity_type> <count> <value>` — quan sát: `*detach_fromelements 1 nodes 2 0.1`, `*detach_fromelements 1 elements 2 0`. entity_type quan sát được là `nodes` hoặc `elements`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tách (detach) node/element khỏi phần tử liên kết, dùng trong ngữ cảnh pretension bolt và part replacement (ifix.tcl).
- **Confidence**: LOCAL-INSTALL

```tcl
./ansys/pretension_bolt.tcl:293:         *detach_fromelements 1 nodes 2 0.1
./ansys/pretension_bolt.tcl:297:		   *detach_fromelements 1 elements 2 0.1
./dynakey/partReplacement/ifix.tcl:442:  *detach_fromelements 1 elements 2 0;
```

---

### *detailedelements_shellvis

- **Signature**: `*detailedelements_shellvis <0|1>` — quan sát nhất quán: luôn 1 tham số 0 hoặc 1, dùng trong `catch {*detailedelements_shellvis 1;}`.
- **Return shape**: side-effect (thường bọc trong `catch`, cho thấy có thể lỗi nếu điều kiện không đúng).
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng để bật/tắt (0/1) một chế độ hiển thị chi tiết phần tử shell, hay bị wrap trong `catch`.
- **Confidence**: LOCAL-INSTALL

```tcl
./context/src/study/optiinputsreview.tcl:190:    *detailedelements_shellvis 0
./context/src/study/optiinputsreview.tcl:339:                catch {*detailedelements_shellvis 1;} str1
```

---

### *dictionaryresetsolver

- **Signature**: `*dictionaryresetsolver <entity_type> <name_or_id> <int_arg>` — quan sát: `*dictionaryresetsolver sensors [hm_entityinfo name sensors $elemRefNo_safe] 8`, `*dictionaryresetsolver COMPONENTS \"$name\" 8`. entity_type quan sát được: `sensors`, `properties`, `COMPONENTS`; tham số cuối luôn là `8` trong các mẫu tìm thấy.
- **Return shape**: side-effect. Cũng có callback: `AddCallback *dictionaryresetsolver ...` cho thấy là 1 event có thể hook.
- **Precondition/side-effect**: chưa xác định ý nghĩa số `8` — chỉ biết luôn xuất hiện ở vị trí tham số cuối trong mọi lần gọi quan sát được.
- **Confidence**: LOCAL-INSTALL

```tcl
./ansys/ansysbrowser/ettype/edit/functions/functions.tcl:100:        *dictionaryresetsolver sensors [hm_entityinfo name sensors $::AnsysBrowser::EtType::Edit::functions::elemRefNo_safe] 8
./ansys/ansys_update_elem_types.tcl:404:      eval *dictionaryresetsolver COMPONENTS \"$name\" 8;
./assemblytools/at/browser/ShowEntity.tcl:765:    AddCallback *dictionaryresetsolver ::hm::assembly::SEbrowser::ClearWindowr;
```

---

### *displaycollector

- **Signature**: `*displaycollector <entity_type> <selector> <mode_str> <flag1> <flag2>` — quan sát: `*displaycollector comps none "" 1 0;`, `*displaycollector components "all" "on" 1 0;`. entity_type quan sát được: `comps`/`components`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng để điều khiển hiển thị collector (component), tham số 2-3 kiểm soát selector "none"/"all" và mode "on"/"".
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/autocontact_tab.tcl:766:    #*displaycollector components "all" "on" 1 0;
./abaqus/Contact_wizard/autocontact_tab.tcl:773:      *displaycollector comps none "" 1 0;
./ansys/ContactManager/contactpair/autocontact_tab.tcl:704:        *displaycollector comps none "" 1 0;
```

---

### *displaycollectorsallbymark

- **Signature**: `*displaycollectorsallbymark <mark_num> <on|none> <flag1> <flag2>` — quan sát: `*displaycollectorsallbymark 1 "on" 1 1`, `*displaycollectorsallbymark 1 none 1 1`.
- **Return shape**: side-effect (thường bọc `catch`).
- **Precondition/side-effect**: chưa xác định — chỉ biết tham số 2 nhận giá trị chuỗi `on`/`none` để bật/tắt hiển thị theo mark.
- **Confidence**: LOCAL-INSTALL

```tcl
./ACM/hmAcousticMeshGUI.tcl:1905:        catch {*displaycollectorsallbymark  1 "on" 1 1};
./assemblytools/at/browser/AssemblyHmBrowser.tcl:315:                    *displaycollectorsallbymark 1 on 1 1;
./assemblytools/at/browser/AssemblyHmBrowser.tcl:318:                    *displaycollectorsallbymark 1 none 1 1;
```

---

### *displayimporterrors

- **Signature**: `*displayimporterrors <0|1>` — quan sát nhất quán: 1 tham số 0 hoặc 1.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — theo tên và ngữ cảnh dùng cặp `0` rồi sau đó `1` xung quanh 1 khối import trong `LoadDummy.tcl`, có vẻ liên quan bật/tắt hiển thị lỗi import trước/sau khi import file, nhưng không có comment xác nhận trực tiếp.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/modules/LoadDummy.tcl:161:        *displayimporterrors 0
./abaqus/dummypos/modules/LoadDummy.tcl:193:      *displayimporterrors 1
./abaqus/dummypos/modules/LoadNoDummyFiles.tcl:175:      *displayimporterrors 0
```

---

### *do_markrejectclear

- **Signature**: `*do_markrejectclear` — quan sát: gọi không tham số trong mọi dòng.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại, không tham số, xuất hiện gần `*deletesolidswithelems`/boolean operation context.
- **Confidence**: LOCAL-INSTALL

```tcl
./BooleanOperation.tcl:171:        *do_markrejectclear;
./br/views/cfdpartbrowser/operations/cfddestroysolidtopology.tcl:81:                *do_markrejectclear
./UserProfiles/HyperWorksCFD/HyperWorksCFD.tcl:499:    *do_markrejectclear;
```

---

### *duplicatemark

- **Signature**: `*duplicatemark <entity_type> <mark_num> <extra_arg>` — quan sát: `*duplicatemark connectors 1 0;`, `*duplicatemark nodes 1 0`, `*duplicatemark $entname 1 $i` — luôn 3 tham số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa tham số 3 (quan sát được cả `0` cố định và biến `$i`).
- **Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/assembly_tc.tcl:466:  *duplicatemark connectors 1 0;
./context/src/idle.tcl:1229:                *duplicatemark nodes 1 0
./context/src/idleproc.tcl:1602:    *duplicatemark $entname 1 $i
```

---

### *editmarkpanel

- **Signature**: `*editmarkpanel <entity_type> <mode_num> "<prompt_string>"` — quan sát: `*editmarkpanel elems 2 "Select 1D elements"`, `*editmarkpanel comps 1 "Select refinement box"`. Tham số 3 luôn là chuỗi hướng dẫn hiển thị cho người dùng.
- **Return shape**: side-effect (mở panel chọn entity tương tác).
- **Precondition/side-effect**: chưa xác định ý nghĩa số ở tham số 2 (quan sát được cả `1` và `2`) — có thể là chế độ chọn nhưng không có bằng chứng rõ ràng.
- **Confidence**: LOCAL-INSTALL

```tcl
./AdaptiveWrap.tcl:389:                *editmarkpanel elems 2 "Select 1D elements"	
./AdaptiveWrap.tcl:555:                *editmarkpanel comps 1 "Select refinement box"	
./AdaptiveWrap.tcl:719:                *editmarkpanel elems 1 "Select elements"	
```

---

### *element1dswitch

- **Signature**: `*element1dswitch <flag>` — quan sát nhất quán: luôn 1 tham số, giá trị `1` trong mọi lần gọi tìm thấy.
- **Return shape**: side-effect. Trong `elementalsystem.tcl` dòng gọi bọc trong `set err [ catch {*element1dswitch 1} ]` — cho thấy lệnh có thể fail và code bắt lỗi qua `catch`.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh liên quan chuyển đổi (switch) biểu diễn phần tử 1D.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/weldline/operations/rotateAxis.tcl:38:        *element1dswitch 1
./context/src/composites/elementalsystem.tcl:270:        set err [ catch {*element1dswitch 1} ]
./context/src/hyperlifeWC/hyperlifewcEvaluationPoints.tcl:67:        *element1dswitch 1
```

---

### *elementhandle

- **Signature**: `*elementhandle <0|1>` (hoặc biến) — quan sát: `*elementhandle 0;`, `*elementhandle $handleState;`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết tham số có thể là hằng số `0` hoặc biến trạng thái `$handleState`, gợi ý bật/tắt "handle" hiển thị của element.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AnalyticalRigid/ARSDialog.tcl:73:        *elementhandle 0;
./abaqus/AnalyticalRigid/ARSDialog.tcl:81:    *elementhandle $handleState;
./abaqus/Contact_wizard/CW.tcl:102:        *elementhandle 0;
```

---

### *elementorder

- **Signature**: `*elementorder <order_value>` — quan sát nhất quán: 1 tham số, giá trị `1` hoặc biến `$elemOrder`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết liên quan bậc phần tử (order) mesh, dùng trong các script mesh aerospace (`AirframeMesh.tcl`, `SurfaceMesh.tcl`).
- **Confidence**: LOCAL-INSTALL

```tcl
./advc/advc_create_cards.tcl:579:    *elementorder $elemOrder
./EngineeringSolutions/aerospace/AirframeMesh/AirframeMesh.tcl:425:		*elementorder 1 
./EngineeringSolutions/aerospace/SurfaceMesh/SurfaceMesh.tcl:122:	*elementorder 1
```

---

### *elementtestaspect

- **Signature**: `*elementtestaspect <entity_type> <mark_num> <threshold> <dim1> <dim2> <flag> "<label>"` — quan sát: `*elementtestaspect elements 1 $checklimit 2 2 0 "2D Element Aspect"`, `*elementtestaspect elements 1 $test_aspect 2 4 0 "3Daspectratio"` (7 tham số, luôn có chuỗi nhãn cuối cùng).
- **Return shape**: side-effect (thường ghi kết quả mark elements lỗi, dùng trong context "quality report").
- **Precondition/side-effect**: chưa xác định chi tiết ý nghĩa từng số — chỉ biết tham số cuối là chuỗi mô tả check, và các số `2 2`/`2 4` khác nhau tùy 2D/3D.
- **Confidence**: LOCAL-INSTALL

```tcl
./hm_macromenu.tcl:1247:            *elementtestaspect elements 1 $checklimit 2 2 0 "2D Element Aspect"
./HyperMold/RTM/model_summary.tcl:624:    *elementtestaspect elements 1 $test_aspect 2 4 0 "3Daspectratio" 
./MeshQualityReport/Mesh_Quality_Report.tcl:1047:    catch {*elementtestaspect elems 1 $aspect 2 2 0 ""}
```

---

### *elementtestduplicates

- **Signature**: `*elementtestduplicates <entity_type> <mark_num> <dim1> <dim2>` — quan sát nhất quán 100%: `*elementtestduplicates elements 1 2 2` (4 tham số, giống nhau ở mọi lần gọi tìm thấy).
- **Return shape**: side-effect (thường bọc `catch`).
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng để kiểm tra phần tử trùng lặp (duplicate elements).
- **Confidence**: LOCAL-INSTALL

```tcl
./2DElemQReport.tcl:456:        *elementtestduplicates elements 1 2 2
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:2994:        catch {*elementtestduplicates elements 1 2 2}
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage1.tcl:2942:        catch {*elementtestduplicates elements 1 2 2}
```

---

### *elementtestfree1d

- **Signature**: `*elementtestfree1d <entity_type> <mark_num> <dim>` — quan sát nhất quán 100%: `*elementtestfree1d elements 1 2` (3 tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng để tìm phần tử 1D tự do (free), ngữ cảnh `findfreerigids.tcl`/`find_fix_freerigids.tcl` liên quan rigid elements.
- **Confidence**: LOCAL-INSTALL

```tcl
./dynakey/findfreerigids.tcl:68:	*elementtestfree1d elements 1 2
./dynakey/find_fix_freerigids.tcl:73:	*elementtestfree1d elements 1 2
./dynakey/find_fix_freerigids.tcl:100:	*elementtestfree1d elements 1 2
```

---

### *elementtestskew

- **Signature**: `*elementtestskew <entity_type> <mark_num> <threshold> <dim1> <dim2> <flag> "<label>"` — quan sát: `*elementtestskew elements 1 [set arr_QualityIndexThresholds(...)] 2 4 0 "  3D Skew  "`, `*elementtestskew elems 1 $skewThreshold 2 2 0 "  2D Skew  "` — cùng dạng 7 tham số như `elementtestaspect`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — chỉ biết cùng khuôn mẫu tham số với elementtestaspect/warpage/taper (kiểm tra chất lượng phần tử theo ngưỡng skew).
- **Confidence**: LOCAL-INSTALL

```tcl
./MeshQualityReport/Mesh_Quality_Report.tcl:1077:    catch {*elementtestskew elems 1 $skew 2 2 0 ""}
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:78:                *elementtestskew elements 1 $sf_FailValue 2 2 0 "  2D Skew  "
./Report/Common/Nastran/ElementQualityChecks.tcl:707:	*elementtestskew elements 1 [set arr_QualityIndexThresholds(${n_Dimension}D,$str_Short)] 2 4 0 "  3D Skew  "
```

---

### *elementtesttaper

- **Signature**: `*elementtesttaper <entity_type> <mark_num> <threshold> <dim1> <dim2> <flag> "<label>"` — quan sát: `*elementtesttaper elems 1 $taper 2 2 0 ""`, `*elementtesttaper elements 1 $tr_FailValue 2 2 0 "  2D Taper  "` — cùng khuôn mẫu 7 tham số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — cùng họ lệnh elementtest* kiểm tra chất lượng mesh (taper).
- **Confidence**: LOCAL-INSTALL

```tcl
./MeshQualityReport/Mesh_Quality_Report.tcl:1092:    catch {*elementtesttaper elems 1 $taper 2 2 0 ""}
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:60:                *elementtesttaper elements 1 $tr_FailValue 2 2 0 "  2D Taper  "
./Report/Common/Nastran/ElementQualityChecks.tcl:952:	*elementtesttaper elements 1 [set arr_QualityIndexThresholds(${n_Dimension}D,$str_Short)] 2 2 0 "  2D Taper  "
```

---

### *elementtestwarpage

- **Signature**: `*elementtestwarpage <entity_type> <mark_num> <threshold> <dim1> <dim2> <flag> "<label>"` — quan sát: `*elementtestwarpage elements 1 $angle 2 2 0 "2D Element Warpage"`, `*elementtestwarpage elements 1 $checklimit 2 2 0 "2D Element Warpage"` — cùng khuôn mẫu 7 tham số như các elementtest* khác.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — kiểm tra chất lượng mesh (warpage).
- **Confidence**: LOCAL-INSTALL

```tcl
./hm_macromenu.tcl:885:        *elementtestwarpage elements 1 $angle 2 2 0 "2D Element Warpage"
./MeshQualityReport/Mesh_Quality_Report.tcl:1052:    catch {*elementtestwarpage elems 1 $warpage 2 2 0 ""}
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:69:                *elementtestwarpage elements 1 $wr_FailValue 2 2 0 "  2D Warpage  "
```

---

### *elementtype

- **Signature**: `*elementtype <config_id> <type_id>` — quan sát nhất quán: 2 tham số số nguyên, ví dụ `*elementtype 5 11`, `*elementtype 56 3`, `*elementtype 104 5;`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa cụ thể của từng số — chỉ biết dùng để set loại phần tử cho 1 config id, dùng nhiều trong so sánh contact abaqus.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:462:    *elementtype 5 11
./abaqus/abaquscontactcomparison.tcl:527:		*elementtype 5 11
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage3.tcl:894:    *elementtype 5 $elemType;
```

---

### *end_batch_import

- **Signature**: `*end_batch_import` — quan sát: gọi không tham số ở mọi vị trí.
- **Return shape**: side-effect.
- **Precondition/side-effect**: theo ngữ cảnh file `import_fe.tcl` (dùng nhiều lần trong quy trình import FE), có vẻ đánh dấu kết thúc 1 batch import bắt đầu bằng lệnh tương ứng (`*begin_batch_import` không có trong batch này) — nhưng không có comment xác nhận trực tiếp trong các dòng trích dẫn.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/workflows.tcl:2336:      *end_batch_import
./hwct/matlib/utils.tcl:347:    *end_batch_import
./ImportExport/import_fe.tcl:426:    *end_batch_import
```

---

### *endnotehistorystate

- **Signature**: `*endnotehistorystate "<message_string>"` — quan sát nhất quán: luôn 1 tham số chuỗi mô tả, ví dụ `*endnotehistorystate "Created set \"$entityName\""`, `*endnotehistorystate "Laminate created"`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: theo tên và các chuỗi thông điệp quan sát được ("Created...", "workplane created"), lệnh này ghi lại một note/label kết thúc cho 1 undo/history state — khớp với comment ngữ cảnh trong `create.tcl` (mô tả hành động vừa hoàn thành).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/create_cards.tcl:1056:		*endnotehistorystate "Created set \"$entityName\""
./br/common/operations/create.tcl:161:			*endnotehistorystate "Laminate created";
./br/common/operations/create.tcl:174:			*endnotehistorystate "workplane created";
```

---

### *entitybundleclear

- **Signature**: `*entitybundleclear <bundle_name> <id_or_flag>` — quan sát: chỉ 1 dòng duy nhất tìm thấy: `*entitybundleclear $bundleName -1;` (2 tham số, giá trị thứ 2 là `-1`).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng trong ngữ cảnh autocontact confirm-all (`confirmall.tcl`), tham số `-1` có thể nghĩa là "tất cả" nhưng không có bằng chứng trực tiếp.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/confirmall.tcl:26:        *entitybundleclear $bundleName -1;
```

---

### *entitybundleremoveid

- **Signature**: `*entitybundleremoveid <bundle_name> <list_ref> <id>` — quan sát nhất quán: `*entitybundleremoveid $bundle_name $entlist_review $id;`, `*entitybundleremoveid $bundle_name $entlist_intersect $id;` (3 tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng để xoá 1 id khỏi bundle theo danh sách tham chiếu (`entlist_review`/`entlist_intersect`), ngữ cảnh autocontact confirm.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/confirm.tcl:44:        *entitybundleremoveid $bundle_name $entlist_review $id;
./br/views/autocontact/common/operations/confirm.tcl:49:        *entitybundleremoveid $bundle_name $entlist_intersect $id;
./br/views/autocontact/common/operations/confirm.tcl:72:        *entitybundleremoveid $bundle_name $entlist_review $id;
```

---

### *entitydisplaywithattached

- **Signature**: `*entitydisplaywithattached <entity_type> <flag> <attached_entity> [<flag2>]` — quan sát: `*entitydisplaywithattached $type 1 $attached_entity 1;` (4 tham số) và `*entitydisplaywithattached $type 1 $attached_entity;` (3 tham số) — số tham số cuối là TÙY CHỌN theo 2 lần gọi khác nhau quan sát được.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — ngữ cảnh isolate/show attached entities trong autocontact.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/isolateattached.tcl:151:        *entitydisplaywithattached $type 1 $attached_entity 1;
./br/views/autocontact/common/operations/showattached.tcl:88:        *entitydisplaywithattached $type 1 $attached_entity;
```

---

### *EntityPreviewEmpty

- **Signature**: `*EntityPreviewEmpty <entity_type> <mark_num>` — quan sát nhất quán: 2 tham số, ví dụ `*EntityPreviewEmpty components $comp_mark`, `*EntityPreviewEmpty comps 1;`, `*EntityPreviewEmpty systcols 1;`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết entity_type quan sát được: `components`, `comps`, `systcols`.
- **Confidence**: LOCAL-INSTALL

```tcl
./cfd/utils.tcl:194:    *EntityPreviewEmpty components $comp_mark
./connectors/connectors.tcl:956:  *EntityPreviewEmpty comps 1;
./connectors/connectors.tcl:981:  *EntityPreviewEmpty systcols 1;
```

---

### *entitysetcreatelist

- **Signature**: `*entitysetcreatelist <set_name> <entity_type> <mark_num>` — quan sát nhất quán: `*entitysetcreatelist $_newDDPName elements 1`, `*entitysetcreatelist $name elems 1;` (3 tham số).
- **Return shape**: side-effect. Cũng dùng như callback: `AddCallback *entitysetcreatelist ...`.
- **Precondition/side-effect**: chưa xác định — chỉ biết tạo 1 entity set từ danh sách theo mark.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/View.tcl:550:    *entitysetcreatelist $_newDDPName elements 1
./connectors/prop_acm_coating.tcl:159:        *entitysetcreatelist $name elems 1;
./browser/bringUpthePopUp.tcl:1428:                AddCallback *entitysetcreatelist ::solverBrowser::contextSensitiveMenu::UpdateAttributeForEntitySets;
```

---

### *entitysetupdate

- **Signature**: `*entitysetupdate "<set_name>" <entity_type> <mark_num>` — quan sát nhất quán: `*entitysetupdate "^HM_CW_display_set1" elements 1`, `*entitysetupdate $name elems 1;`, `*entitysetupdate "$setName" nodes 1` (3 tham số, tham số 1 luôn là tên set dạng chuỗi).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng để cập nhật nội dung 1 entity set đã tồn tại (khác `*entitysetcreatelist` là tạo mới).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CW.tcl:3573:                *entitysetupdate "^HM_CW_display_set1" elements 1
./ansys/convert70to80.tcl:554:            *entitysetupdate $name elems 1;         
./br/views/modelchecker/operations/review.tcl:156:        *entitysetupdate "$setName" nodes 1
```

---

### *entitysetupdatelist

- **Signature**: `*entitysetupdatelist <set_name> <entity_type> <mark_num>` — quan sát nhất quán: `*entitysetupdatelist $secondary_name nodes 1`, `*entitysetupdatelist "$secondary_name" nodes 2` (3 tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết khác biệt so với `*entitysetupdate` (không có "list") có thể là cập nhật theo danh sách (mark_num=2 thấy trong 1 số lần gọi thay vì 1), nhưng đây chỉ là quan sát không phải bằng chứng ý nghĩa.
- **Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_type2.tcl:1565:           *entitysetupdatelist $secondary_name nodes 1
./connectors/prop_type2.tcl:1606:          *entitysetupdatelist "$secondary_name" nodes 2          
./connectors/prop_type2radioss.tcl:647:           *entitysetupdatelist $secondary_name nodes 1
```

---

### *entitysuppressactive

- **Signature**: `*entitysuppressactive <entity_type> <id> <state_flag>` — quan sát nhất quán: `*entitysuppressactive modules $part 0`, `*entitysuppressactive $type $id [expr $state?0:1]`, `*entitysuppressactive positions $posEntId 1` (3 tham số).
- **Return shape**: side-effect. Cũng có trong danh sách callback: `*marksuppressactive *entitysuppressactive` (loadstep_browser.tcl) — xác nhận đây là 1 command/event thật của HM có thể hook callback.
- **Precondition/side-effect**: chưa xác định chi tiết ý nghĩa flag — chỉ biết flag 0/1 tương ứng bật/tắt trạng thái suppress (theo cách dùng `[expr $state?0:1]`).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/cfdpartbrowser/init.tcl:139:        *entitysuppressactive modules $part 0
./br/views/entitystate/operations/active.tcl:13:            *entitysuppressactive $type $id [expr $state?0:1]
./entities/hmFieldRealization.tcl:3859:        *entitysuppressactive positions $posEntId 1      
```

---

### *entitysuppressoutput

- **Signature**: `*entitysuppressoutput <entity_type> <id> <state_flag>` — quan sát nhất quán: `*entitysuppressoutput sets $id 0`, `*entitysuppressoutput groups $id 0`, `*entitysuppressoutput $type $id 0` (3 tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: có comment trực tiếp trong code: `## Turn the entity export state to ON` đi kèm mọi lần gọi với flag `0` — xác nhận: flag `0` = bật (ON) trạng thái export cho entity.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/confirm.tcl:87:            *entitysuppressoutput sets $id 0; ## Turn the entity export state to ON
./br/views/autocontact/common/operations/confirm.tcl:103:            *entitysuppressoutput groups $id 0
./br/views/autocontact/common/operations/confirm.tcl:132:                *entitysuppressoutput $type $id 0; ## Turn the entity export state to ON
```

---

### *equivalence

- **Signature**: `*equivalence <entity_type> <mark_num> <tol1> <flag1> <flag2> <flag3>` — quan sát nhất quán: `*equivalence elems 2  0 1 0 0`, `*equivalence elements 1 0 1 0 0;` (6 tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa từng flag — chỉ biết dùng trong ngữ cảnh contact manager để "equivalence" (hợp nhất) node/element, luôn cùng pattern `0 1 0 0` sau mark_num.
- **Confidence**: LOCAL-INSTALL

```tcl
./ansys/ContactManager/contactpair/autocontact.tcl:359:            *equivalence elems 2  0 1 0 0 
./ansys/ContactManager/contactpair/common_functions.tcl:74:            *equivalence elements 1 0 1 0 0;
./ansys/ContactManager/contactpair/symmetric_contact.tcl:253:    *equivalence elements 2 0 1 0 0;
```

---

### *exclusiveidrange

- **Signature**: `*exclusiveidrange <entity_type> <id> "<name>" <type_or_entities> <pool>` — quan sát: `*exclusiveidrange submodel $id "" $entities $poolnumber`, `*exclusiveidrange "submodel" $id "$submodel_name" "$type" $pool` (5 tham số, cùng thứ tự).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết ý nghĩa `$entities`/`$type` — chỉ biết entity_type quan sát được luôn là `submodel`.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/exclusion.tcl:284:    *exclusiveidrange submodel $id "" $entities $poolnumber
./br/views/idmgr/operations/importexport.tcl:224:			*exclusiveidrange "submodel" $id "$submodel_name" "$type" $pool
```

---

### *exportfbdsectstobdf

- **Signature**: `*exportfbdsectstobdf <file_path> <fbd_ids>` — quan sát: chỉ 1 dòng duy nhất tìm thấy: `*exportfbdsectstobdf $selectedFile $fbdIds` (2 tham số).
- **Return shape**: side-effect (xuất ra file, theo tên lệnh "export...tobdf").
- **Precondition/side-effect**: chưa xác định — chỉ biết dùng trong ngữ cảnh export free body sections sang định dạng .bdf (Nastran), tham số 1 là đường dẫn file, tham số 2 là danh sách id free body section.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/freebodysections/operations/exportfbdtocsv.tcl:40:		      *exportfbdsectstobdf $selectedFile $fbdIds
```

---

## Ghi chú về dòng thứ 41 trong file batch

File `gapfill_batch_02.txt` dòng số 41 chỉ chứa số thứ tự "41" mà không có tên lệnh kèm theo — đây là dòng trống/thừa ở cuối danh sách, không phải 1 lệnh HM. Không xử lý dòng này.

ràng trong cùng ngữ cảnh.

---

### *exportfbdsectstocsv

**Signature**: `*exportfbdsectstocsv $selectedFile $fbdIds`
**Return shape**: side-effect (không gán kết quả trả về).
**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi. (Tên file gợi ý export free-body-diagram sections ra CSV, nhưng không có comment xác nhận).
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/freebodysections/operations/exportfbdtocsv.tcl:38:			  *exportfbdsectstocsv $selectedFile $fbdIds
```

---

### *feabsorbtomassentity

**Signature**: `*feabsorbtomassentity $massType $_type 1 $massEntityFilter $massReconnectRule $flag2 $flag3`
**Return shape**: side-effect; có callback đăng ký qua `::hwt::AddCallback *feabsorbtomassentity ...` cho thấy lệnh phát sinh event/callback sau khi chạy.
**Precondition/side-effect**: callback `::mass::updatemasstotal` được gọi sau lệnh này (theo `init.tcl:525`) — nghĩa là lệnh thay đổi tổng khối lượng (mass total) của model.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/mass/feabsorb.tcl:434:    *feabsorbtomassentity $massType $_type 1 $massEntityFilter $massReconnectRule $flag2 $flag3
./br/views/mass/init.tcl:525:    ::hwt::AddCallback *feabsorbtomassentity ::mass::updatemasstotal;
```

---

### *featureangleset

**Signature**: `*featureangleset $::autocontact::feature_angle` (hoặc giá trị số trực tiếp, ví dụ `*featureangleset 10;`)
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định chi tiết — chỉ biết đây là một lệnh set giá trị góc feature (feature angle), dùng trong ngữ cảnh autocontact wizard và mesh generation.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/autocontact_tab.tcl:1150:        *featureangleset $::autocontact::feature_angle
./HyperForge/HXForge/generate_mesh.tcl:171:    *featureangleset 10;
```

---

### *feinput

**Signature**: `*feinput "#<translator>\\<translator>" $fi 0 0 -0.01 1 0` (ví dụ: `*feinput "#abaqus\\abaqus" $fi 0 0 -0.01 1 0`)
**Return shape**: side-effect, thường bọc trong `catch { ... } res/err` để bắt lỗi.
**Precondition/side-effect**: chưa xác định chi tiết ý nghĩa từng tham số số — chỉ biết tham số đầu là chuỗi định danh translator/reader (`#abaqus\abaqus`, `#pamcrash2G\pamcrash2G`), tham số thứ hai là đường dẫn file input.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:1490:    catch { *feinput "#abaqus\\abaqus" $fi 0 0 -0.01 1 0 } res
./abaqus/dummypos/tclincludes/pam2gDposProc.tcl:1344:    catch { *feinput "#pamcrash2G\\pamcrash2G" $fi 0 0 -0.01 1 0 } res
./abaqus/dummypos/tclincludes/dummyproc.tcl:1656:            catch { *feinput $translator $dummyFile 0 0 -0.01 1 0 } err
```

---

### *feinputpreserveincludefiles

**Signature**: `*feinputpreserveincludefiles` (không tham số, quan sát trong toàn bộ các lần gọi tìm thấy)
**Return shape**: side-effect.
**Precondition/side-effect**: gọi trong nhánh `"Preserve"` của switch/case (`abaqusDposProc.tcl:1559`, `pam2gDposProc.tcl:1394`) — gợi ý lệnh này thiết lập chế độ "preserve include files" trước khi import fe input, nhưng cơ chế cụ thể chưa xác định.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:437:    *feinputpreserveincludefiles  ;
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:1559:        "Preserve" {*feinputpreserveincludefiles}
./abaqus/dummypos/tclincludes/pam2gDposProc.tcl:1394:        "Preserve" {*feinputpreserveincludefiles;}
```

---

### *feinputwithdata2

**Signature**: `*feinputwithdata2 "#abaqus\\abaqus" ${filewrite} 0 0 0 0 0 1 2 1 0` — 11 tham số sau tên translator quan sát được (biến đổi ở tham số thứ 9, ví dụ `2` hoặc `1` hoặc `$num_options`).
**Return shape**: side-effect, thường bọc `catch {...}`.
**Precondition/side-effect**: chưa xác định — nằm trong `CallbackList` cùng nhóm với `*feinput`, `*feinputwithdata`, `*readfile`, `*deletemodel` (`PretensionManager.tcl:1310`), gợi ý đây là một trong các lệnh import model kích hoạt callback cập nhật UI.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:439:    *feinputwithdata2 "#abaqus\\abaqus" ${filewrite} 0 0 0 0 0 1 2 1 0 ;
./abaqus/Instances/Import_Instances.tcl:348:    catch {*feinputwithdata2 "#abaqus\\abaqus" "$name1" 0 0 0 0 0 1 2 1 0}
./assemblytools/assembly_tc.tcl:416:    *feinputwithdata2 $::Assembly::TC::p_vars(fe_reader) "$::Assembly::TC::p_input_files(main_mat)" 0 0 0 0 0 1 $num_options 1 0;
```

---

### *feoutput_select

**Signature**: `*feoutput_select $outputFile $fileName 1 0 0` hoặc `*feoutput_select "$templateFile" "$tempLamToolFile" 2 0 0` — 5 tham số: template file, output filename, rồi 3 flags số.
**Return shape**: side-effect, thường bọc `catch {...}`.
**Precondition/side-effect**: chưa xác định — comment trong `browser/export_to_file.tcl:71` dùng `[hm_info templatefilename]` làm tham số đầu, cho thấy tham số 1 là đường dẫn template solver export, tham số 2 là đường dẫn file xuất ra.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/composite/operations/drapeestimator_perform.tcl:369:	if { [ catch {*feoutput_select $outputFile $fileName 1 0 0}] } {
./browser/export_to_file.tcl:71:    *feoutput_select [hm_info templatefilename] $exportFileName 1 0 0;
./br/views/list/operations/solverdeckexporter.tcl:109:  *feoutput_select "$exporttemplate" "$filepath" 1 0 
```

---

### *fieldreview

**Signature**: `*fieldreview $fieldName`
**Return shape**: side-effect (không gán biến); sau khi gọi, code tạo lại mark comps để so sánh trước/sau (`*createmark comps 1 all` trước và sau).
**Precondition/side-effect**: trước lệnh có `*createmark comps 1 all` rồi `hm_markclear comps 1`; sau lệnh lại `*createmark comps 1 all` để lấy `curCompList` — cho thấy `*fieldreview` thay đổi tập hợp components hiện có liên quan tới field `$fieldName` (có thể tạo/hiển thị components mới gắn với field).
**Confidence**: LOCAL-INSTALL

```tcl
./entities/hmFieldRealization.tcl:2243:    *createmark comps 1 all
./entities/hmFieldRealization.tcl:2244:    set prevCompList [hm_getmark comps 1]
./entities/hmFieldRealization.tcl:2245:    hm_markclear comps 1
./entities/hmFieldRealization.tcl:2246:    *fieldreview $fieldName
./entities/hmFieldRealization.tcl:2247:    *createmark comps 1 all
```

---

### *filtertable

**Signature**: `*filtertable table=$table keystring=$keyStringList keycolumns=$keyColumnList valuecolumns=$valColList allcolumns=$allColFlag targettable=$temptablename sort=$sortFilter` — dùng cú pháp named-argument `key=value` (không phải positional thuần).
**Return shape**: side-effect.
**Precondition/side-effect**: được bọc trong `if { [hm_entityinfo exist table $table] }` — nghĩa là bảng `$table` phải tồn tại trước khi gọi lệnh này. Kết quả ghi vào `targettable=$temptablename` (bảng đích tạm).
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/esacompcontour.tcl:506:		if { [hm_entityinfo exist table $table] } {
./br/views/certification/operations/esacompcontour.tcl:507:			 *filtertable table=$table keystring=$keyStringList keycolumns=$keyColumnList valuecolumns=$valColList allcolumns=$allColFlag targettable=$temptablename sort=$sortFilter
```

---

### *findattachedelementfaces

**Signature**: `*findattachedelementfaces 1 $table_id`
**Return shape**: side-effect. Chỉ tìm thấy dạng gọi với tham số đầu cố định là `1`.
**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi, dùng lặp lại giống hệt trong nhiều wizard (Abaqus/Nastran/Optistruct Contact_wizard, Renumber_tool).
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/autocontact_tab.tcl:1698:      *findattachedelementfaces 1 $table_id;
./nastran/Contact_wizard/autocontact_tab.tcl:2125:      *findattachedelementfaces 1 $table_id;
./optistruct/Contact_wizard/autocontact_tab.tcl:2111:      *findattachedelementfaces 1 $table_id;
```

---

### *findbetween

**Signature**: `*findbetween nodes components 1 0 0 2`
**Return shape**: side-effect. Mọi lần gọi tìm thấy đều dùng đúng cùng 6 tham số literal giống hệt nhau: `nodes components 1 0 0 2`.
**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi (xuất hiện y hệt ở HyperMold/RTM, HyperXtrude, và nastran/RSPLINE_elem.tcl).
**Confidence**: LOCAL-INSTALL

```tcl
./HyperMold/RTM/select_bc.tcl:351:    *findbetween nodes components 1 0 0 2
./HyperXtrude/select_bc.tcl:346:    *findbetween nodes components 1 0 0 2
./nastran/RSPLINE_elem.tcl:38:  *findbetween nodes components 1 0 0 2
```

---

### *findloops

**Signature**: `*findloops comps 1 1`
**Return shape**: side-effect; ngay sau đó code gọi `set value [hm_getinfostring]` để đọc kết quả dạng chuỗi thông tin — cho thấy `*findloops` ghi kết quả vào info string chứ không trả về trực tiếp.
**Precondition/side-effect**: gọi trong khối kiểm tra lỗi connector (`ce_error.tcl`) khi `$::CE::ERRCHK::comp_id != ""` — nghĩa là cần có comp_id hợp lệ trước khi gọi. Tham số đầu `comps` là loại entity, `1` có thể là mark ID.
**Confidence**: LOCAL-INSTALL

```tcl
./connectors/ce_error.tcl:100:  if {$::CE::ERRCHK::comp_id != ""} \
./connectors/ce_error.tcl:102:    *findloops comps 1 1;
./connectors/ce_error.tcl:103:    set value [hm_getinfostring];
```

---

### *findmark

**Signature**: `*findmark elems 1 1 1 nodes 0 1` hoặc `*findmark contactsurfs 1 1 0 elements 0 1` — 7 tham số: (entity_type_1) (mark_1) (?) (?) (entity_type_2) (?) (?).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa chi tiết từng flag — chỉ biết mẫu chung là `*findmark <type_A> <mark> ... <type_B> ...`, tái sử dụng nhiều lần trong Abaqus AbaqusStep/Contact_wizard.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:3065:                            *findmark elems 1 1 1 nodes 0 1;
./abaqus/Contact_wizard/CW.tcl:3202:                *findmark contactsurfs 1 1 0 elements 0 1;
./abaqus/Contact_wizard/CW.tcl:3217:                    *findmark elements 1 1 0 elements 0 2;
```

---

### *fixedpointhandle

**Signature**: `*fixedpointhandle 0` hoặc `*fixedpointhandle 1` — 1 tham số boolean-like (0/1).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa 0/1 cụ thể — xuất hiện lặp lại ở nhiều context độc lập (dynakey errorcheck, findfreerigids, hm_macromenu.tcl với cả 0 và 1 dùng gần nhau ở dòng 168/178, gợi ý là toggle bật/tắt một chế độ).
**Confidence**: LOCAL-INSTALL

```tcl
./dynakey/dyna_xtranodes.tcl:102:    *fixedpointhandle 0
./hm_macromenu.tcl:168:    *fixedpointhandle 1
./hm_macromenu.tcl:178:    *fixedpointhandle 0
```

---

### *flattenpartmodel

**Signature**: `*flattenpartmodel` (không tham số)
**Return shape**: side-effect; hàm bao quanh return `1` sau khi gọi lệnh.
**Precondition/side-effect**: gọi trong nhánh else của kiểm tra `if { $status == "cancel" }` — nghĩa là chỉ chạy khi user không cancel; theo tên hàm chứa nó (`utils.tcl` trong `subsystems/common`), có thể liên quan tới việc "flatten" cấu trúc part/assembly nhưng chi tiết cơ chế chưa xác định.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/subsystems/common/utils.tcl:271:        if { $status == "cancel" } {
./br/views/subsystems/common/utils.tcl:274:          *flattenpartmodel
./br/views/subsystems/common/utils.tcl:275:          return 1
```

---

### *formulasetcreate

**Signature**: `*formulasetcreate "$inter_setname" elements` — 2 tham số: tên set (string), loại entity.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tạo một "formula set" gắn với tên và loại entity truyền vào, dùng trong connectors (adhesives, prop_type2).
**Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_pam_rad_adhesives.tcl:299:        *formulasetcreate "$inter_setname" elements;
./connectors/prop_type2.tcl:1577:        *formulasetcreate "$main_name" elements;
./connectors/prop_type2radioss.tcl:659:        *formulasetcreate "$main_name" elements;
```

---

### *formulasetcreatelist

**Signature**: `*formulasetcreatelist $name_Set 0 nodes 1 0` hoặc `*formulasetcreatelist $name_Set 0 components 1 0` hoặc `*formulasetcreatelist $name_Set 0 elements 1 0` — 5 tham số: tên set, `0`, loại entity (nodes/components/elements), `1`, `0`.
**Return shape**: side-effect.
**Precondition/side-effect**: được bọc trong `if { $ent_num > 0 }` ở tất cả các lần gọi tìm thấy — nghĩa là cần có ít nhất 1 entity (`ent_num > 0`) trước khi tạo formula set list.
**Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_dyna_matnum_seamarea.tcl:987:      if { $ent_num > 0 } { *formulasetcreatelist $name_Set 0 nodes 1 0;}
./connectors/prop_opt_tie_contacts.tcl:138:      if { $ent_num > 0 } { *formulasetcreatelist $name_Set 0 elements 1 0;}
./connectors/prop_pam_rad_adhesives.tcl:342:      *formulasetcreatelist "$inter_setname" 0 components 1 0;
```

---

### *formulasetreview

**Signature**: `*formulasetreview $set_Name 1`
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định chi tiết — dùng lặp lại trong nhiều solver export contexts (radiossblock, connectors fe_to_ce_solver, radioss BCs) với cùng 2 tham số (tên set, `1`).
**Confidence**: LOCAL-INSTALL

```tcl
./browser/radiossblock/common_function.tcl:1199:    *formulasetreview $set_Name 1;
./connectors/fe_to_ce_solver.tcl:150:                *formulasetreview $set_name 1;
./radioss/BCs/11_GRNOD_API.tcl:33:      *formulasetreview $set_Name 1 ;
```

---

### *getunmeshedsurfstomark2

**Signature**: `*getunmeshedsurfstomark2 1` — 1 tham số, quan sát luôn là mark ID `1`.
**Return shape**: side-effect; kết quả đọc ra bằng `set surfcnt [llength [hm_getmark surfs 1]]` ngay sau đó — nghĩa là lệnh này ghi các surface chưa mesh vào mark 1, không trả về giá trị trực tiếp.
**Precondition/side-effect**: trước lệnh có `*startnotehistorystate "Isolate unmeshed surfaces"` và `*clearmarkall 1` (clear mark trước khi dùng) — đúng pattern trong reference_hm_optimization_patterns đã biết (clear mark trước khi mark mới). Sau lệnh gọi `*isolateonlyentitybymark 1 0 0 0` để isolate các surface đó.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/meshcontrols/operations/optional.tcl:41:  *startnotehistorystate "Isolate unmeshed surfaces"
./br/views/meshcontrols/operations/optional.tcl:42:  *clearmarkall 1
./br/views/meshcontrols/operations/optional.tcl:43:  *getunmeshedsurfstomark2 1
./br/views/meshcontrols/operations/optional.tcl:44:  set surfcnt [llength [hm_getmark surfs 1]]
./br/views/meshcontrols/operations/optional.tcl:45:  *isolateonlyentitybymark 1 0 0 0
```

---

### *graphuserwindow_byXYZandR

**Signature**: `*graphuserwindow_byXYZandR $x_pt $y_pt $z_pt $radius` (biến thể tên: `$centerX $centerY $centerZ $Radius`) — 4 tham số: x, y, z, radius.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — tên biến gợi ý lệnh định nghĩa "graphics user window" hình cầu quanh điểm (x,y,z) với bán kính radius (dùng để giới hạn vùng hiển thị/chọn đối tượng), nhưng không có comment xác nhận cơ chế.
**Confidence**: LOCAL-INSTALL

```tcl
./browser/replace_part.tcl:6458:            *graphuserwindow_byXYZandR $x_pt $y_pt $z_pt $radius 
./connectors/ce_comparison_gui.tcl:889:     *graphuserwindow_byXYZandR $centerX $centerY $centerZ $Radius;
./connectors/ce_table.tcl:1416:     *graphuserwindow_byXYZandR $centerX $centerY $centerZ $Radius;
```

---

### *hideall

**Signature**: `*hideall` (không tham số)
**Return shape**: side-effect.
**Precondition/side-effect**: gọi trong các hàm `init.tcl` của browser views (enggbr, partinstance) và trong `show_hide.tcl` — theo tên lệnh, ẩn toàn bộ entity hiển thị trong graphics area. Chưa có comment xác nhận chi tiết.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/main/init.tcl:113:    *hideall
./br/views/partinstance/main/init.tcl:109:    *hideall
./context/src/show_hide.tcl:760:    *hideall
```

---

### *hideview

**Signature**: `*hideview $name` hoặc `*hideview $viewName -1` — 1-2 tham số: tên view, tham số tùy chọn thứ 2 (`-1` quan sát được).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa tham số thứ 2 (`-1`) — chỉ biết lệnh dùng để ẩn một "view" theo tên.
**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/showhideisolate.tcl:126:                    *hideview $name
./context/viewtoolbar/toolbarviews.tcl:384:    *hideview $viewName -1
```

---

### *hwCfdBuildPartBrEntities

**Signature**: `*hwCfdBuildPartBrEntities elems $_ddpgid` hoặc `set res [*hwCfdBuildPartBrEntities REGIONS]` — có dạng gọi với 1 hoặc 2 tham số tùy context.
**Return shape**: có giá trị trả về, xác nhận bởi `set res [*hwCfdBuildPartBrEntities REGIONS]` trong `buildcfdpartbrentities.tcl:29`.
**Precondition/side-effect**: chưa xác định — CFD part browser entity build, tham số đầu là loại entity (`elems` hoặc `REGIONS`).
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/interfaces/DDPEditor.tcl:391:		*hwCfdBuildPartBrEntities elems $_ddpgid
./br/views/cfdpartbrowser/operations/buildcfdpartbrentities.tcl:29:        set res [*hwCfdBuildPartBrEntities REGIONS]
```

---

### *hwCfdSceneShowHideIsolateEntity

**Signature**: `*hwCfdSceneShowHideIsolateEntity "show" $eType 1 1 1 1` — tham số 1 là action string (`"show"`, `"hide"`, `"isolate"`, `"reverse"`), tham số 2 là entity type, sau đó 4 flags `1 1 1 1`.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa 4 flags cuối — nhưng action string đầu tiên rõ ràng điều khiển hành vi show/hide/isolate/reverse trên CFD scene entities.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/cfdpartbrowser/operations/cfdsceneshowhidesolate.tcl:27:        *hwCfdSceneShowHideIsolateEntity "show" $eType 1 1 1 1
./br/views/cfdpartbrowser/operations/cfdsceneshowhidesolate.tcl:68:        *hwCfdSceneShowHideIsolateEntity "hide" $eType 1 1 1 1
./br/views/cfdpartbrowser/operations/cfdsceneshowhidesolate.tcl:110:        *hwCfdSceneShowHideIsolateEntity "isolate" $eType 1 1 1 1
```

---

### *hwct_addrepsfromlibrary

**Signature**: `*hwct_addrepsfromlibrary subsystems 1 [join $ls_selectedReps ";"] $ls_options` — tham số: domain (`subsystems`), `1`, danh sách rep tên nối bằng `;`, chuỗi options.
**Return shape**: side-effect; có callback đăng ký `AddCallback *hwct_addrepsfromlibrary "::hmbr::reposttocontainallentities"`.
**Precondition/side-effect**: sau khi thêm reps từ library, callback `::hmbr::reposttocontainallentities` được kích hoạt — cho thấy lệnh này cập nhật lại danh sách entity chứa trong container/browser.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/entitylist/regular/uiEntityView.tcl:144:    AddCallback *hwct_addrepsfromlibrary "::hmbr::reposttocontainallentities"
./br/views/subsystems/common/operations/library/addfromlibrary.tcl:68:      *hwct_addrepsfromlibrary subsystems 1 [join $ls_selectedReps ";"] $ls_options;
```

---

### *hwct_addselectedrepsfromlibrary

**Signature**: `*hwct_addselectedrepsfromlibrary subsystems 1 $count $options`
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — tham số thứ 3 là `$count` (số lượng reps đã chọn), tham số thứ 4 là chuỗi options.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/subsystems/common/operations/library/browse.tcl:90:  *hwct_addselectedrepsfromlibrary subsystems 1 $count $options
./br/views/subsystems/common/operations/library/subsystemset/browse.tcl:82:  *hwct_addselectedrepsfromlibrary subsystems 1 $count $options
```

---

### *hwct_deleterepsfromlibrary

**Signature**: `*hwct_deleterepsfromlibrary subsystems 1 [join $ls_selectedReps ";"]`
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — chỉ có 1 lần xuất hiện duy nhất trong toàn bộ scripts, trong hàm xóa reps khỏi library (`delete.tcl`).
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/subsystems/common/operations/library/delete.tcl:56:      *hwct_deleterepsfromlibrary subsystems 1 [join $ls_selectedReps ";"]
```

---

### *hwct_savetolibrary

**Signature**: `*hwct_savetolibrary subsystems 1 [join $ls_selectedReps ";"] "overwrite=$b_overwrite"` — tham số cuối dùng named-arg string `overwrite=<bool>`.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — biến thể khác dùng `"overwrite=1"` cố định (`workflows.tcl:570`) hoặc kèm `repcomment=$comment` (`workflows.tcl:482`), cho thấy chuỗi options hỗ trợ nhiều key `overwrite=`, `repcomment=`.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/subsystems/common/operations/library/addtolibrary.tcl:58:      *hwct_savetolibrary subsystems 1 [join $ls_selectedReps ";"] "overwrite=$b_overwrite"
./br/views/subsystems/common/workflows.tcl:482:        *hwct_savetolibrary subsystems 1 $alias "overwrite=$b_overwrite, repcomment=$comment"
./br/views/subsystems/common/workflows.tcl:570:        *hwct_savetolibrary subsystems 1 $repKey "overwrite=1"
```

---

### *hwct_synclibrary

**Signature**: `*hwct_synclibrary subsystems 1 "updatesignal=1"` (biến thể `subsystems 0 "updatesignal=1"` trong `librarymanager.tcl`)
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa tham số 2 (0 vs 1) — chuỗi options `"updatesignal=1"` xuất hiện cố định trong mọi lần gọi.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/subsystems/common/operations/library/delete.tcl:58:      *hwct_synclibrary subsystems 1 "updatesignal=1"
./br/views/subsystems/common/operations/library/sync.tcl:38:    *hwct_synclibrary subsystems 1 "updatesignal=1"
./hwct/subsystemlib/librarymanager.tcl:54:    *hwct_synclibrary subsystems 0 "updatesignal=1"
```

---

### *idmgrshowhide

**Signature**: `*idmgrshowhide includes $parent_include "" 0 "submodel"` hoặc `*idmgrshowhide "includes" $id "" 0 "exclusive"` — 5 tham số: loại (`includes`), id, chuỗi rỗng, flag 0/1, mode string (`submodel`/`exclusive`).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa flag 0/1 cụ thể (có thể show=1/hide=0 dựa theo tên lệnh) — chỉ biết mode cuối cùng có 2 giá trị quan sát được: `"submodel"` và `"exclusive"`.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/includeidmgr/filter.tcl:221:            *idmgrshowhide includes $parent_include "" 0 "submodel"
./br/views/idmgr/includeidmgr/filter.tcl:341:        *idmgrshowhide includes 0 "" 1 "exclusive"
./br/views/idmgr/operations/importexport.tcl:258:            *idmgrshowhide "includes" $id "" 0 "exclusive"
```

---

### *includesuppress

**Signature**: dùng dạng nối chuỗi động `*includesuppress[set action] $includeid "" $flag` — nghĩa là tên lệnh thật là `*includesuppress<action>` (ví dụ có thể là `*includesuppressON`/`*includesuppressOFF` tùy giá trị biến `action`). KHÔNG quan sát được lệnh `*includesuppress` trần (không hậu tố) trong bất kỳ dòng nào.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — cảnh báo: đây không phải lệnh cố định `*includesuppress` mà là tiền tố bị nối thêm hậu tố động từ biến `$action` lúc runtime. Không đủ bằng chứng để khẳng định cú pháp chính xác của lệnh gốc.
**Confidence**: LOCAL-INSTALL (nhưng độ tin cậy về tên lệnh chính xác THẤP do string concatenation động — cần thận trọng khi dùng)

```tcl
./br/views/entitystate/operations/activeexportmenu.tcl:113:                            *includesuppress[set action] $includeid "" $flag
./br/views/entitystate/operations/activeexportmenu.tcl:115:                            *includesuppress[set action] $includeid "" $actionFlag
./br/views/entitystate/operations/activeexportmenu.tcl:134:                        *includesuppress[set action] $includeid "" $actionFlag
```

---

### *interfaceadd

**Signature**: `*interfaceadd $name 0 elements 1 0` — 5 tham số: tên interface, `0`, loại entity (`elements`), `1`, flag cuối biến đổi (`0`, `$reverseState`).
**Return shape**: side-effect, luôn bọc trong `catch {...}`.
**Precondition/side-effect**: chưa xác định ý nghĩa flag cuối chi tiết — nhưng biến `$reverseState` ở `CWElsurpage1.tcl:1307` gợi ý đó là flag đảo hướng (reverse normal) của bề mặt.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/dload/dload_tab1.tcl:2011:        if { [catch {*interfaceadd $name 0 elements 1 0}] } {
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1307:        if {![catch {*interfaceadd $name 0 elements 1 $reverseState}]} {
```

---

### *interfacecontactsurf

**Signature**: `*interfacecontactsurf $name 0 1` hoặc `*interfacecontactsurf $name 1 1` — 3 tham số: tên interface, flag (0 hoặc 1), `1`.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa flag thứ 2 — dùng liên tiếp với `*interfacedefinition`, `*interfacesets` trong cùng khối code Contact_wizard, gợi ý đây là 1 bước trong chuỗi thiết lập contact interface (definition → contactsurf → sets).
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CW.tcl:3544:                *interfacecontactsurf $name 0 1;
./abaqus/Contact_wizard/CW.tcl:3599:                *interfacecontactsurf $name 1 1;
```

---

### *interfacecreate

**Signature**: `*interfacecreate $strNewinterfaceName 1 4 1` — 4 tham số: tên interface mới, `1`, một số nguyên biến đổi theo loại (4, 9, 10, 6, 7 quan sát được), `1`.
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa số nguyên thứ 3 — các giá trị khác nhau (4/9/10/6/7) chắc chắn map tới các loại interface/contact type khác nhau trong `interface.tcl`, nhưng không có bảng tra rõ ràng trong ngữ cảnh trích xuất.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/interface/interface.tcl:795:                *interfacecreate $strNewinterfaceName 1 4 1;
./abaqus/AbaqusStep/interface/interface.tcl:810:                *interfacecreate $strNewinterfaceName 1 9 1;
./abaqus/AbaqusStep/interface/interface.tcl:840:                *interfacecreate $strNewinterfaceName 1 6 1;
```

---

### *interfacedefinition

**Signature**: `*interfacedefinition $name 0 "element"` hoặc `*interfacedefinition $name 0 "sets"` hoặc `*interfacedefinition $name 0 "contactsurfs"` hoặc `*interfacedefinition $name 0 "comp"` — 3 tham số: tên interface, `0`, loại definition string (`element`/`sets`/`contactsurfs`/`comp`).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định — tham số thứ 3 rõ ràng chọn loại entity định nghĩa interface, dùng trước `*interfacesets`/`*interfacecontactsurf` trong cùng khối logic.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/dload/dload_tab1.tcl:2010:        *interfacedefinition $name 0 "element";
./abaqus/Contact_wizard/CW.tcl:3537:                *interfacedefinition $name 0 "sets";
./abaqus/Contact_wizard/CW.tcl:3542:                *interfacedefinition $name 0 "contactsurfs";
./abaqus/Contact_wizard/CW.tcl:3551:                *interfacedefinition $name 0 "comp";
```

---

### *interfacesets

**Signature**: `*interfacesets $name 0 1` hoặc `*interfacesets $name 1 1` — 3 tham số: tên interface, flag 0/1, `1`.
**Return shape**: side-effect, đôi khi bọc `catch {...}` (`CWElsurpage1.tcl:1483`).
**Precondition/side-effect**: chưa xác định ý nghĩa flag thứ 2 — dùng cùng nhóm với `*interfacedefinition`/`*interfacecontactsurf` trong luồng thiết lập contact interface.
**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CW.tcl:3539:                *interfacesets $name 0 1;
./abaqus/Contact_wizard/CW.tcl:3594:                *interfacesets $name 1 1;
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1483:            catch {*interfacesets $name 0 1};
```

---

### *isolateelementswithinradius

**Signature**: `*isolateelementswithinradius masses 2 50` hoặc `*isolateelementswithinradius masses 2 $::mass::radius` — 3 tham số: loại entity (`masses`), `2`, giá trị bán kính (radius).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa tham số thứ 2 (`2`) — tham số thứ 3 rõ ràng là bán kính (biến `radius`), dùng để isolate elements/masses trong bán kính đó.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/mass/init.tcl:487:    *isolateelementswithinradius masses 2 50
./br/views/mass/operations/nearby.tcl:53:	*isolateelementswithinradius masses 2 $::mass::radius
```

---

### *linecombine

**Signature**: `*linecombine $lineid [lindex $sellines [expr $i+1]] 1` (bọc trong `catch{...}` để lấy `$ret`) hoặc `*linecombine $line1 $line2 0` — 3 tham số: line ID 1, line ID 2, flag (0 hoặc 1).
**Return shape**: có kiểm tra kết quả qua `catch` để bắt lỗi (`set ret [catch {*linecombine ...}]`) — cho thấy lệnh có thể fail và cần xử lý lỗi.
**Precondition/side-effect**: chưa xác định ý nghĩa flag cuối — chỉ biết lệnh gộp (combine) 2 line theo ID truyền vào.
**Confidence**: LOCAL-INSTALL

```tcl
./context/src/snr/review3dline.tcl:117:				set ret [catch {*linecombine $lineid [lindex $sellines [expr $i+1]] 1 }]
./nastran/ContinuousWeld.tcl:1145:            *linecombine $line1 $line2 0
```

---

### *linecreatestraight

**Signature**: `*linecreatestraight $node_x1 $node_y1 $node_z1 $node_x2 $node_y2 $node_z2` — 6 tham số tọa độ: x1,y1,z1 (điểm đầu), x2,y2,z2 (điểm cuối).
**Return shape**: side-effect, thường bọc `catch {...}`.
**Precondition/side-effect**: chưa xác định side-effect chi tiết — tên tham số biến (`node_x1`, `node_y1`...) xác nhận rõ ràng đây là tọa độ 2 điểm đầu-cuối để tạo đường thẳng.
**Confidence**: LOCAL-INSTALL

```tcl
./br/views/composite/operations/drapeestimator_perform.tcl:1188:                *linecreatestraight $node_x1 $node_y1 $node_z1 $node_x2 $node_y2 $node_z2
./br/views/composite/operations/flatshape.tcl:65:			catch {*linecreatestraight $ax $ay $az $bx $by $bz}
```

---

### *loadcreateonentity

**Signature**: `*loadcreateonentity nodes 1 8 2 [lindex $d_vecCrossProduct 0] [lindex $d_vecCrossProduct 1] [lindex $d_vecCrossProduct 2] 0 0 0` hoặc `*loadcreateonentity nodes 1 5 1 1 0 0 0 0 0` — 10 tham số: loại entity (`nodes`), mark id (`1`), loại load (8 hoặc 5), sub-type (2 hoặc 1), rồi các giá trị vector (x,y,z và thêm 3 số 0).
**Return shape**: side-effect.
**Precondition/side-effect**: chưa xác định ý nghĩa chính xác các mã số loại load (8, 5) — chỉ biết tham số vector giữa (x,y,z) map tới `$d_vecCrossProduct` hoặc `$d_ux`/`$d_uy`/`$d_uz`-like values (hướng lực), dùng để tạo load trên nodes.
**Confidence**: LOCAL-INSTALL

```tcl
./browser/radiossblock/common_function.tcl:2371:                              *loadcreateonentity nodes 1 8 2 [lindex $d_vecCrossProduct 0] [lindex $d_vecCrossProduct 1] [lindex $d_vecCrossProduct 2] 0 0 0 ;
./browser/radiossblock/common_function.tcl:2473:                        *loadcreateonentity nodes 1 5 1 1 0 0 0 0 0 ;
```

---

## Ghi chú kiểm tra chéo cuối cùng

- Tất cả 40 lệnh trong batch đều tìm thấy ít nhất 1 dòng khớp thật trong source `.tcl` — không có mục nào phải đánh dấu "KHÔNG TÌM THẤY".
- Riêng `*includesuppress` cần lưu ý đặc biệt: tên lệnh thật trong source luôn xuất hiện dưới dạng nối chuỗi động `*includesuppress[set action]`, nghĩa là lệnh gốc có hậu tố biến đổi theo runtime (`action`) chứ không phải bản thân `*includesuppress` trần được gọi trực tiếp ở đâu. Đã ghi rõ cảnh báo này trong mục tương ứng, không bịa tên hậu tố cụ thể vì không có bằng chứng giá trị `$action` là gì.
- Nhiều lệnh có tham số dạng số nguyên/flag mà ý nghĩa chính xác không suy ra được chỉ từ tên biến hoặc comment lân cận — các trường hợp này đều được đánh dấu "chưa xác định" thay vì đoán.


### *loadcreateonentity_curve

**Signature**: `*loadcreateonentity_curve <entType> <markId> <loadConfig> <loadType> <comp1> <comp2> <comp3> <comp4> <comp5> <comp6> 0 0 0 0 0` (số lượng tham số quan sát được thay đổi theo call site — có bản 14 tham số, có bản khác dùng giá trị số trực tiếp thay vì biến, xem block bên dưới).

**Return shape**: side-effect (không thấy gán `set x [*loadcreateonentity_curve ...]` ở các call site tìm được).

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi; xuất hiện trong ngữ cảnh tạo load (Abaqus step load, pretension) trên entity đã có trong mark.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/load.tcl:2425:        *loadcreateonentity_curve $entType 1 $loadConfig $loadType $comp1 $comp2 $comp3 $comp4 $comp5 $comp6 0 0 0 0 0;
./abaqus/Contact_wizard/CWinterface/CWpretension1.tcl:843:        *loadcreateonentity_curve nodes 1 1 1 $value 0 0 0 0 $value 0 0 0 0 0;
./abaqus/Contact_wizard/CWinterface/CWpretension1.tcl:855:        *loadcreateonentity_curve nodes 1 3 1 $value -999999 -999999 -999999 -999999 -999999 0 0 0 0 0;
```

---

### *loadstepsupdate

**Signature**: `*loadstepsupdate <loadStepId> <flag>` — ví dụ `*loadstepsupdate $::AbaqusStep::currentLoadStep 1`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa của tham số `1`. Có một dòng bị comment (`#*loadstepsupdate ...`) trong `mainstep.tcl:3637`, cho thấy lệnh được dùng để cập nhật loadstep hiện hành sau khi thay đổi (không có bằng chứng chi tiết hơn).

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/interface/interface.tcl:1179:    *loadstepsupdate $::AbaqusStep::currentLoadStep 1;
./abaqus/AbaqusStep/load/load.tcl:1609:            *loadstepsupdate $::AbaqusStep::currentLoadStep 1;
./abaqus/AbaqusStep/mainstep.tcl:3637:    #*loadstepsupdate $::AbaqusStep::currentLoadStep 1;
```

---

### *loadtype

**Signature**: `*loadtype <arg1> <arg2>` — ví dụ `*loadtype 3 2`, `*loadtype 3 3`. Cùng chuỗi cũng được lưu dạng string `set loadTypeCommand "*loadtype 3 1"` rồi gọi sau (có thể dùng `eval`/lưu để undo).

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa `3` (có thể là loadcollector/type cố định trong file bc_tab1.tcl) và giá trị thứ hai đổi theo lựa chọn UI (1/2/3).

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/bc/bc_tab1.tcl:106:    set loadTypeCommand "*loadtype 3 1";
./abaqus/AbaqusStep/load/bc/bc_tab1.tcl:626:            *loadtype 3 2;
./abaqus/AbaqusStep/load/bc/bc_tab1.tcl:633:            *loadtype 3 3;
```

---

### *lockallentities

**Signature**: `*lockallentities <entitytype> <poolnumber> id` — ví dụ `*lockallentities $entitytype $poolnumber id`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi, dùng trong module ID manager lock (`br/views/idmgr/operations/lock.tcl`).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/lock.tcl:126:        *lockallentities $entitytype $poolnumber id;
```

---

### *lockentities

**Signature**: `*lockentities <type> <selection_or_markid> "id"` — ví dụ `*lockentities $type 2 "id"` hoặc `*lockentities $entityType 1 id`. Có call site chỉ dùng 1 tham số: `*lockentities $selection` (xem `lock.tcl:93`, đây có vẻ tương ứng với dùng "Perform" wrapper riêng — không rõ nếu đó là literal command hay được diễn giải qua hàm `Perform`).

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/importexport.tcl:254:            *lockentities $type 2 "id"
./browser/entity_reference.tcl:3639:        *lockentities $entityType 1 id;
```

---

### *markdifference

**Signature**: `*markdifference <type1> <markId1> <type2> <markId2>` — ví dụ `*markdifference elems 1 elems 2`, `*markdifference systems 2 systems 1`, `*markdifference nodes 1 nodes 2`.

**Return shape**: side-effect (thao tác trên mark, không gán biến).

**Precondition/side-effect**: chưa xác định chi tiết nhưng theo cách dùng (elems mark 1 vs elems mark 2) tên lệnh gợi ý phép "difference" giữa hai mark cùng loại entity — mark đích thường là mark thứ nhất (không có comment xác nhận rõ ràng nên chỉ ghi nhận cách gọi).

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/BarUpdate/bar_update.tcl:33:                *markdifference elems 1 elems 2
./abaqus/create_cards.tcl:990:    *markdifference systems 2 systems 1;
./ACM/helpers.tcl:73:    *markdifference nodes 1 nodes 2;
```

---

### *markmovetoinclude

**Signature**: `*markmovetoinclude <entType> <markId> <includeId>` — ví dụ `*markmovetoinclude $ent_type 1 $con_id`, `*markmovetoinclude $childtype $markid $parentid`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết, nhưng lệnh cũng xuất hiện dưới dạng callback event name (`AddCallback *markmovetoinclude ...`), cho thấy đây là 1 lệnh HM có callback hook riêng khi thực thi.

**Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/browser/ShowEntity.tcl:775:    AddCallback *markmovetoinclude ::hm::assembly::SEbrowser::ClearWindow;
./assemblytools/at/utils/HyperMeshEntity/ConversionBrowser.tcl:398:        *markmovetoinclude $ent_type 1 $con_id;
./br/common/operations/organizeentites.tcl:244:                    *markmovetoinclude $childtype $markid $parentid
```

---

### *markmovetomodule

**Signature**: `*markmovetomodule <entType> <markId> <moduleNameOrId>` — ví dụ `*markmovetomodule components 1 $name`, `*markmovetomodule comps 1 $moduleName`.

**Return shape**: side-effect (một số call site bọc trong `catch {...}`, cho thấy lệnh có thể lỗi/throw).

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/utils/HyperMeshEntity/ConversionBrowser.tcl:1121:      *markmovetomodule $entType 1 "$entname";
./br/common/operations/migratetoparts.tcl:156:        catch {*markmovetomodule components 1 $name}
./br/views/cfdpartbrowser/init.tcl:82:    *markmovetomodule comps 1 $moduleName
```

---

### *markmovetoskeleton

**Signature**: `*markmovetoskeleton <parentid> <childtype> <markid>` — ví dụ `*markmovetoskeleton $parentid $childtype $markid`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi, dùng trong "skeleton" viewmanager.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/skeleton/main/viewmanager.tcl:626:				*markmovetoskeleton $parentid $childtype $markid
./br/views/skeleton/main/viewmanager.tcl:633:			*markmovetoskeleton $parentid $childtype $markid
```

---

### *markmovetosubmodel

**Signature**: `*markmovetosubmodel "solversubmodels" <childtype> <markid> <submodelId>` — ví dụ `*markmovetosubmodel "solversubmodels" $childtype $markid $submodelId`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi. Tham số đầu tiên literal `"solversubmodels"` xuất hiện cố định ở call site duy nhất tìm được.

**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/organizeentites.tcl:242:                    *markmovetosubmodel "solversubmodels" $childtype $markid $submodelId
```

---

### *marknotintersection

**Signature**: `*marknotintersection <type1> <markId1> <type2> <markId2>` — ví dụ `*marknotintersection elems 1 elems 2`, `*marknotintersection loads 1 loads 2`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết — tên lệnh và cách dùng (2 mark cùng type) gợi ý phép loại trừ phần giao nhau, tương tự `*markdifference`, nhưng không có comment xác nhận rõ ràng.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:316:			*marknotintersection elems 1 elems 2
./abaqus/AbaqusStep/abaqusstep.tcl:2521:    *marknotintersection elems 1 elems 2;  
./abaqus/AbaqusStep/load/bc/bc_tab1.tcl:942:          *marknotintersection loads 1 loads 2;
```

---

### *marksuppress

**LƯU Ý QUAN TRỌNG**: Không tìm thấy lệnh literal `*marksuppress` được gọi trực tiếp. Tất cả các call site thực tế đều là `*marksuppress[set action] ...` — tức là Tcl thực hiện nội suy biến `[set action]` để ghép thành tên lệnh đầy đủ (ví dụ `*marksuppresson` hoặc `*marksuppressoff`, tuỳ giá trị biến `action` tại runtime). Do đó `*marksuppress` bản thân nó KHÔNG PHẢI là một lệnh HM độc lập/hoàn chỉnh trong các dòng tìm được — đây là phần tiền tố dùng để build tên lệnh động.

**Signature**: chưa xác định (không quan sát được lệnh `*marksuppress` gọi trực tiếp, độc lập, không kèm hậu tố).

**Return shape**: N/A.

**Precondition/side-effect**: N/A.

**Confidence**: LOCAL-INSTALL (nhưng CẢNH BÁO: chuỗi tìm thấy là tiền tố của tên lệnh động, không phải chính lệnh `*marksuppress`)

```tcl
./br/views/entitystate/operations/activeexportmenu.tcl:121:                    *marksuppress[set action] solversubmodels 1 $flag
./br/views/entitystate/operations/activeexportmenu.tcl:125:                    *marksuppress[set action] solversubmodels 2 $actionFlag
./br/views/entitystate/operations/activeexportmenu.tcl:149:                *marksuppress[set action] $type 1 $flag
```

---

### *marksuppressoutput

**Signature**: `*marksuppressoutput <type> <markId> <flag>` — ví dụ `*marksuppressoutput sets 1 0`, `*marksuppressoutput contactsurfs 1 0`.

**Return shape**: side-effect.

**Precondition/side-effect**: theo ngữ cảnh code (`confirm.tcl:110-115`, comment "Turn the export entity state to ON" ngay phía trên khối `*createmark ... ; *marksuppressoutput sets 1 0; *clearmark sets 1;`), lệnh dùng để bật/tắt trạng thái xuất (export) của các entity trong mark — flag `0` ở đây tương ứng với bật export theo comment lân cận. Cần entity đã có trong mark trước khi gọi (thấy `*createmark` ngay trước).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/confirm.tcl:113:                *marksuppressoutput sets 1 0;
./br/views/autocontact/common/operations/confirm.tcl:145:                    *marksuppressoutput contactsurfs 1 0;
./br/views/autocontact/common/operations/confirm.tcl:201:                    *marksuppressoutput $stype 1 0;
```

---

### *maskall

**Signature**: `*maskall` (không tham số).

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết — theo tên lệnh, ẩn (mask) toàn bộ entity trong model. Không có comment xác nhận rõ ràng ở các call site tìm được.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWinterface/CWautocontact.tcl:700:            *maskall;
./br/views/cfdpartbrowser/operations/mask.tcl:29:    *maskall
./context/src/snr/realizeeline.tcl:144:        *maskall
```

---

### *maskentitymark

**Signature**: `*maskentitymark <type> <markId> [<flag>]` — ví dụ `*maskentitymark elems 1` (2 tham số) và `*maskentitymark elems 1 0` / `*maskentitymark elements 2 0` (3 tham số). Cả hai dạng đều tồn tại thực tế trong source, tham số thứ 3 là optional hoặc có giá trị mặc định khác nhau tuỳ phiên bản call site.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa chính xác của flag cuối (0).

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:317:			*maskentitymark elems 1
./abaqus/AbaqusStep/abaqusstep.tcl:2495:        *maskentitymark elems 1 0;
./abaqus/Contact_wizard/autocontact_tab.tcl:759:      *maskentitymark elements 2 0;;
```

---

### *masknotshown

**Signature**: `*masknotshown` (không tham số, chỉ 1 call site tìm được).

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./nastran/ContinuousWeld.tcl:785:        *masknotshown
```

---

### *masselement

**Signature**: `*masselement <arg1> <arg2> "<arg3>" <arg4>` — ví dụ `*masselement 1 0 "" 0` (xuất hiện giống hệt ở 3 call site khác nhau).

**Return shape**: side-effect. Lệnh cũng xuất hiện dạng callback event (`AddCallback *masselement ...`), nghĩa là đây là tên lệnh HM hợp lệ có callback hook riêng.

**Precondition/side-effect**: chưa xác định ý nghĩa tham số cụ thể — chuỗi rỗng `""` ở vị trí thứ 3 không rõ mục đích trong các call site tìm được.

**Confidence**: LOCAL-INSTALL

```tcl
./ansys/ContactManager/contactpair/contact_options_dialog.tcl:1031:            *masselement 1 0 "" 0
./ansys/ContactManager/contactpair/symmetric_contact.tcl:300:    *masselement 1 0 "" 0
./browser/bringUpthePopUp.tcl:1930:        AddCallback *masselement ::solverBrowser::contextSensitiveMenu::UpdateAttributesForBeams;
```

---

### *ME_ConvertIncludesToModules

**Signature**: `*ME_ConvertIncludesToModules <entid> 0 0 1 0 ""` — chỉ 1 call site tìm được: `*ME_ConvertIncludesToModules $entid 0 0 1 0 "";`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa các flag số — chỉ biết lệnh tồn tại và cú pháp gọi trong `ConversionBrowser.tcl`.

**Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/utils/HyperMeshEntity/ConversionBrowser.tcl:439:        *ME_ConvertIncludesToModules $entid 0 0 1 0 "";
```

---

### *ME_CoreBehaviorAdjust

**Signature**: `*ME_CoreBehaviorAdjust "<key>=<value>"` — ví dụ `*ME_CoreBehaviorAdjust "containment_rules_policy=free"`, `*ME_CoreBehaviorAdjust allowable_actions_policy=default`.

**Return shape**: side-effect.

**Precondition/side-effect**: theo các key/value quan sát được (`containment_rules_policy`, `allowable_actions_policy`), lệnh dùng để thay đổi policy hành vi lõi (core behavior) của Module Editor bằng chuỗi `key=value`, có thể truyền có/không có ngoặc kép.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/main/init.tcl:57:    *ME_CoreBehaviorAdjust "containment_rules_policy=free"
./br/views/modules/core/bomimport.tcl:431:    *ME_CoreBehaviorAdjust "allowable_actions_policy=default";
./br/views/modules/core/entitiesmanager.tcl:158:  *ME_CoreBehaviorAdjust allowable_actions_policy=default;
```

---

### *ME_DetailSetInt

**Signature**: `*ME_DetailSetInt <hmmid> <detailName> <intValue>` — ví dụ `*ME_DetailSetInt $hmmid me_occ_render 1`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết — `me_occ_render` là tên chi tiết (detail) module occurrence, giá trị `1` được set. Cần `hmmid` (module id) hợp lệ trước khi gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/workflows.tcl:1077:        *ME_DetailSetInt $hmmid me_occ_render 1       
./MVD/operations/tools/opCompareTwiceWithoutGui.tcl:128:      *ME_DetailSetInt $hmmid me_occ_render 1
```

---

### *ME_ModuleCreate

**Signature**: `*ME_ModuleCreate "<name>" "occurrence" <flag1> <parentIdOrFlag2> <flag3>` — ví dụ `*ME_ModuleCreate $partName "occurrence" 1 2 0;`, `*ME_ModuleCreate "$name" "occurrence" 1 $id 0`, `*ME_ModuleCreate "$name" "occurrence" 1 0 0`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa chính xác từng flag — literal string `"occurrence"` cố định ở vị trí thứ 2 trong mọi call site tìm được.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Instances/Import_Instances.tcl:346:    *ME_ModuleCreate $partName "occurrence" 1 2 0; 
./br/common/operations/create.tcl:671:        *ME_ModuleCreate "$name" "occurrence" 1 $id 0
./br/common/operations/create.tcl:673:       *ME_ModuleCreate "$name" "occurrence" 1 0 0
```

---

### *ME_ModuleExport

**Signature**: `*ME_ModuleExport <modId> <recursiveFlag> {<solverFilePath>} {<templateFilePath>} 1 <numOptions>` — ví dụ `*ME_ModuleExport $mid $b_recursive "$filePath" "$strTemplatePath" 1 [llength $lst_stringarrayoptions]`. (Dòng khác ghi ra file bằng `puts` nên là chuỗi template, không phải call trực tiếp: `puts $fp "*ME_ModuleExport \$n_modId 0 {$str_solverfile} {$templatefilename} 1 0"`.)

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi, dùng để export module ra file solver deck.

**Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/utils/solverexport/AssemblySolverDeckExport.tcl:413:  puts $fp "*ME_ModuleExport \$n_modId 0 {$str_solverfile} {$templatefilename} 1 0";
./br/views/modules/custom/TC/actions.tcl:58:  *ME_ModuleExport $mid $b_recursive "$filePath" "$strTemplatePath" 1 [ llength $lst_stringarrayoptions ];
```

---

### *ME_ModuleOccurrenceConvert

**Signature**: `*ME_ModuleOccurrenceConvert <children> <targetType> "<optionString>"` — chỉ 1 call site tìm được: `*ME_ModuleOccurrenceConvert $children assembly "override_static_behavior=1"`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa `$children` (danh sách hay 1 id) — chỉ biết literal `assembly` là loại đích và option string dạng `key=value`.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/custom/TC/workflows.tcl:628:    *ME_ModuleOccurrenceConvert $children assembly "override_static_behavior=1"
```

---

### *ME_ModuleOccurrenceCreate

**Signature**: `*ME_ModuleOccurrenceCreate <name> "parent_id=<id>, structural_type=<type>[, static=<0|1>]"` — ví dụ `*ME_ModuleOccurrenceCreate $name "parent_id=$crrp_id, structural_type=part, static=1"`, `*ME_ModuleOccurrenceCreate $modulename parent_id=[hm_me_rootget] structural_type=part` (không dùng dấu phẩy khi không có ngoặc kép).

**Return shape**: side-effect (một số call site bọc trong `catch {...}`).

**Precondition/side-effect**: chưa xác định — option string dùng cú pháp `key=value` phân cách bằng dấu phẩy khi để trong 1 chuỗi, hoặc nhiều token riêng khi không có dấu phẩy/ngoặc kép.

**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/migratetoparts.tcl:153:        catch {*ME_ModuleOccurrenceCreate $name "parent_id=$crrp_id, structural_type=part, static=1"}
./br/views/cfdpartbrowser/operations/cfdcreatepart.tcl:30:    *ME_ModuleOccurrenceCreate $modulename parent_id=[hm_me_rootget] structural_type=part
```

---

### *ME_ModuleOccurrenceInstancesSyncContents

**Signature**: `*ME_ModuleOccurrenceInstancesSyncContents <moduleId> <siblingsList> [<syncOptionsString>]` — ví dụ `*ME_ModuleOccurrenceInstancesSyncContents $moduleId "$::hmbr::pipartEditor::siblings"`, và bản 3 tham số `*ME_ModuleOccurrenceInstancesSyncContents $hmmid $lst_targetInstances $str_syncOptions`.

**Return shape**: side-effect (dùng trong `catch {...}` để bắt lỗi `err`).

**Precondition/side-effect**: chưa xác định chi tiết — chỉ biết lệnh tồn tại, dùng để đồng bộ nội dung giữa các instance module.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/parteditor/operations/modulesync.tcl:33:        *ME_ModuleOccurrenceInstancesSyncContents $moduleId "$::hmbr::pipartEditor::siblings"
./br/views/modules/core/actions.tcl:991:  if {[catch {*ME_ModuleOccurrenceInstancesSyncContents $hmmid $lst_targetInstances $str_syncOptions} err]} {
```

---

### *ME_ModuleOccurrencesDelete

**Signature**: `*ME_ModuleOccurrencesDelete <idOrIdList> "<optionString>"` — ví dụ `*ME_ModuleOccurrencesDelete $id ""`, `*ME_ModuleOccurrencesDelete $purgeMeList` (chỉ 1 tham số ở một call site).

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/cfdpartbrowser/operations/deletecfdpartbrentities.tcl:31:            *ME_ModuleOccurrencesDelete $id ""
./br/views/cfdpartbrowser/operations/purgeparts.tcl:38:        *ME_ModuleOccurrencesDelete $purgeMeList
./MVD/operations/tools/opReparentGrouping.tcl:695:			*ME_ModuleOccurrencesDelete $mid ""
```

---

### *ME_ModuleOccurrencesDeleteByMark

**Signature**: `*ME_ModuleOccurrencesDeleteByMark <markId> [<optionString...>]` — ví dụ `*ME_ModuleOccurrencesDeleteByMark 1`, `*ME_ModuleOccurrencesDeleteByMark 1 {*}$lstArgs`, `*ME_ModuleOccurrencesDeleteByMark 1 "keep_contents=1"`.

**Return shape**: side-effect.

**Precondition/side-effect**: theo comment tại `br/views/modules/core/workflows.tcl:2647` ("'move contents' functionality moved to *ME_ModuleOccurrencesDeleteByMark (option: keep_contents=1)"), option `keep_contents=1` giữ lại nội dung con khi xoá module occurrence trong mark. Cần mark đã chứa entity trước khi gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/actions.tcl:544:              *ME_ModuleOccurrencesDeleteByMark 1 {*}$lstArgs;
./br/views/modules/core/workflows.tcl:2647:    # 'move contents' functionality moved to *ME_ModuleOccurrencesDeleteByMark (option: keep_contents=1) 
./nvh/Nvh_BrowserActions.tcl:763:			catch {*ME_ModuleOccurrencesDeleteByMark 1 "keep_contents=1" }
```

---

### *ME_ModuleOccurrencesRealize

**Signature**: `*ME_ModuleOccurrencesRealize "entry_occ_id=<id>,copy_contents=<0|1>"` — ví dụ `*ME_ModuleOccurrencesRealize "entry_occ_id=$parentId,copy_contents=1"`; cũng có call site không tham số: `*ME_ModuleOccurrencesRealize`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết — option string dùng `key=value` phân cách dấu phẩy, không có khoảng trắng.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/main/operations/create.tcl:123:    *ME_ModuleOccurrencesRealize "entry_occ_id=$parentId,copy_contents=1";
./br/views/modules/core/actions.tcl:390:  *ME_ModuleOccurrencesRealize "entry_occ_id=$parent_id,copy_contents=$copy_contents";
./br/views/partinstance/main/operations/create.tcl:43:    *ME_ModuleOccurrencesRealize
```

---

### *ME_ModulePopulate

**Signature**: `*ME_ModulePopulate <modId> "<optionString>" <entType> <markId>` — ví dụ `set ret_val [ *ME_ModulePopulate $hm_mod_id "" $ent_type 1 ]`.

**Return shape**: CÓ giá trị trả về — quan sát rõ từ `set ret_val [ *ME_ModulePopulate $hm_mod_id "" $ent_type 1 ]` và `set val [ *ME_ModulePopulate $des_mod_id "" $ent_type 1 ]`.

**Precondition/side-effect**: chưa xác định chi tiết ý nghĩa giá trị trả về — chỉ biết nó được gán vào biến để dùng tiếp (có thể là success flag hoặc số lượng entity).

**Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/utils/HyperMeshEntity/AssemblyEntityCreate.tcl:781:        set ret_val [ *ME_ModulePopulate $hm_mod_id "" $ent_type 1 ];
./assemblytools/at/utils/HyperMeshEntity/AssemblyEntityCreate.tcl:874:        set val [ *ME_ModulePopulate $des_mod_id "" $ent_type 1 ];
./br/views/certification/operations/LoadProject.tcl:123:                            *ME_ModulePopulate $parent "" comps 1
```

---

### *ME_ModulePosition

**Signature**: `*ME_ModulePosition <modId> 1` — ví dụ `*ME_ModulePosition $sourcemod 1`, `*ME_ModulePosition $mid 1;`. Một số call site nằm trong `catch {...}` khi ghi ra file export script.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa tham số `1` cố định — chỉ biết lệnh tồn tại và cú pháp gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/operations/goto_partbuilder.tcl:74:	*ME_ModulePosition $sourcemod 1
./br/views/modules/custom/TC/actions.tcl:47:  *ME_ModulePosition $mid 1;
./assemblytools/at/utils/HyperMeshExport/AssemblyHypermeshExport.tcl:377:  puts $fp "  catch {*ME_ModulePosition $mod_hm_id 1}";
```

---

### *ME_ModulePrototypeCreate

**Signature**: `*ME_ModulePrototypeCreate <structuralType> <moduleName>` — ví dụ `*ME_ModulePrototypeCreate part [::hmbr::PIMainView::IncrName ModulePrototypes Part]`, `*ME_ModulePrototypeCreate $structuraltype $modulename`.

**Return shape**: side-effect (không thấy gán biến ở các call site tìm được).

**Precondition/side-effect**: chưa xác định — literal `part` xuất hiện làm structuralType ở một số call site cố định.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/common/createentity.tcl:30:            *ME_ModulePrototypeCreate part [::hmbr::PIMainView::IncrName ModulePrototypes Part]
./br/views/enggbr/common/createentity.tcl:85:    *ME_ModulePrototypeCreate $structuraltype $modulename
./br/views/partinstance/common/createentity.tcl:30:            *ME_ModulePrototypeCreate part [::hmbr::PIMainView::IncrName ModulePrototypes Part]
```

---

### *ME_ModulePrototypeInstanceCreate

**Signature**: `*ME_ModulePrototypeInstanceCreate <parentName> <prototypeName> <instanceName> 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1` — chỉ 1 call site tìm được, với chuỗi 16 số theo sau 3 tham số tên (giống ma trận biến đổi 4x4 dạng phẳng: `1 0 0 0 / 0 1 0 0 / 0 0 1 0 / 0 0 0 1`).

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chắc chắn nhưng cấu trúc số liệu rất giống identity transform matrix (dựa theo pattern số quan sát được, không phải suy đoán tên biến).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/partinstance/main/operations/create.tcl:42:    *ME_ModulePrototypeInstanceCreate $parent_name $prototype_name $instance_name 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
```

---

### *ME_ModulePrototypeInstanceCreateByID

**Signature**: `*ME_ModulePrototypeInstanceCreateByID <parentPrototypeId> <prototypeId> <instanceName> matrix=<matrix_list>` — ví dụ `*ME_ModulePrototypeInstanceCreateByID $parentPrototypeId $prototypeId $instanceName matrix=$matrix_list`.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết định dạng `$matrix_list` (không có comment giải thích) — chỉ biết truyền dưới dạng `matrix=<value>` token.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/enggbr/main/operations/create.tcl:122:    *ME_ModulePrototypeInstanceCreateByID $parentPrototypeId $prototypeId $instanceName matrix=$matrix_list
./br/views/modules/core/actions.tcl:389:  *ME_ModulePrototypeInstanceCreateByID $parent_prototype_id $prototype_id $instance_name matrix=$matrix_list;  
```

---

### *ME_SingleEntityParametersChangedEmit

**Signature**: `*ME_SingleEntityParametersChangedEmit modules <id>` — ví dụ `*ME_SingleEntityParametersChangedEmit modules $occurrence_id`, `*ME_SingleEntityParametersChangedEmit modules $n_id`. Literal đầu tiên `modules` cố định trong mọi call site tìm được.

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — tên lệnh gợi ý phát tín hiệu (emit event) rằng tham số của 1 entity module đã thay đổi, dùng để trigger refresh UI/browser (không có comment xác nhận, chỉ dựa trên tên lệnh và ngữ cảnh file `actions.tcl` của module core).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/actions.tcl:397:	*ME_SingleEntityParametersChangedEmit modules $occurrence_id;
./br/views/modules/core/actions.tcl:616:    *ME_SingleEntityParametersChangedEmit modules $n_id
./br/views/modules/core/actions.tcl:756:    *ME_SingleEntityParametersChangedEmit modules $module_id
```

---

### *mechapplyediposition

**Signature**: `*mechapplyediposition <flag>` — ví dụ `*mechapplyediposition 1`, `*mechapplyediposition 0`.

**Return shape**: side-effect (một số call site bọc trong `catch {... } err`).

**Precondition/side-effect**: chưa xác định ý nghĩa chính xác của flag 0/1 — xuất hiện trong context "dummy"/"mechanism" position operations.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/dummy/operations/position.tcl:123:        *mechapplyediposition 1
./br/views/mechanism/operations/position.tcl:127:        *mechapplyediposition 1
./br/views/mechanism/widgets/listEntitiesUI.tcl:81:                catch {*mechapplyediposition 0}
```

---

## Ghi chú tổng kết batch 04

- 34/34 lệnh trong danh sách (dòng 1-35, dòng 36 trống) đều TÌM THẤY bằng chứng thật trong source `.tcl`.
- Không có lệnh nào phải ghi "KHÔNG TÌM THẤY" trong batch này.
- Phát hiện đáng chú ý: `*marksuppress` (mục thứ 12) không tồn tại như một lệnh độc lập trong source — mọi chỗ dùng đều là `*marksuppress[set action]`, tức ghép tên lệnh động qua nội suy biến Tcl (`[set action]` trả về hậu tố như `on`/`off`). Đã ghi rõ cảnh báo này trong mục tương ứng để tránh AI khác hiểu nhầm `*marksuppress` là lệnh gọi được trực tiếp.
- Nhiều lệnh có tham số dạng option string `key=value` (thường thấy ở nhóm `ME_Module*`): `*ME_CoreBehaviorAdjust`, `*ME_ModuleOccurrenceCreate`, `*ME_ModuleOccurrencesRealize`, `*ME_ModuleOccurrenceConvert`, `*ME_ModulePrototypeInstanceCreateByID`. Format cụ thể (dấu phẩy, khoảng trắng, ngoặc kép) khác nhau tuỳ call site — đã trích dẫn nguyên văn từng biến thể thay vì chuẩn hoá.
</content>


### *mechcontructfromedi

- **Signature**: `*mechcontructfromedi <arg1> <arg2>` — ví dụ quan sát được: `*mechcontructfromedi 0 0` và `*mechcontructfromedi 2 $posId`.
- **Return shape**: side-effect (không thấy gán vào biến trong các dòng tìm được).
- **Precondition/side-effect**: chưa xác định rõ ràng tham số; comment lân cận trong `mechanismFunctions.tcl` gợi ý liên quan tới việc tạo mechanism nếu chưa tồn tại ("If does not exists, then will get created in *mechcontructfromedi function with default naming convention"), nhưng ý nghĩa cụ thể từng tham số chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/dummy/operations/limits.tcl:97
    *mechcontructfromedi 0 0
# br/views/dummy/operations/position.tcl:122
        *mechcontructfromedi 2 $posId
# br/views/dummy/operations/position.tcl:125
        *mechcontructfromedi 0 0
# br/views/mechanism/operations/mechanismFunctions.tcl:207
    catch {*mechcontructfromedi 0 0 } err
```

---

### *mechexportdaf

- **Signature**: `*mechexportdaf $filePath`
- **Return shape**: side-effect (ghi file, không gán biến).
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi, dùng trong context "export" của dummy/mechanism.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/dummy/operations/export.tcl:36
    *mechexportdaf $filePath
```

---

### *mechimportdaf

- **Signature**: `*mechimportdaf $filePath`
- **Return shape**: side-effect (đọc file, không gán biến).
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi, dùng trong context "import" của dummy/mechanism.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/dummy/operations/import.tcl:38
    *mechimportdaf $filePath
```

---

### *mechjointlimits

- **Signature**: `*mechjointlimits <arg>` — ví dụ: `*mechjointlimits 0` và `*mechjointlimits 1`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại, dùng trong file `limits.tcl` của dummy operations, tham số có vẻ là flag on/off nhưng không có bằng chứng rõ ràng ý nghĩa 0/1.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/dummy/operations/limits.tcl:96
    *mechjointlimits 0
# br/views/dummy/operations/limits.tcl:197
    *mechjointlimits 1
```

---

### *mergehistorystate

- **Signature**: `*mergehistorystate` (không tham số, trong mọi lần dùng tìm thấy).
- **Return shape**: side-effect, không gán biến.
- **Precondition/side-effect**: chưa xác định chi tiết — tên gợi ý liên quan tới việc gộp trạng thái undo/history, nhưng không có comment xác nhận trong các dòng trích.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/create_cards.tcl:1057
		*mergehistorystate
# br/common/operations/create.tcl:391
                    *mergehistorystate
# br/views/list/init.tcl:27
      *mergehistorystate
# context/viewtoolbar/hmpyviewtoolbar.tcl:446
    *mergehistorystate
```

---

### *messagefilefilter

- **Signature**: `*messagefilefilter <channel> <filterType>` — ví dụ: `*messagefilefilter feinput "error";` và `*messagefilefilter connector "error";`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định — dùng cùng nhóm với `*messagefileset` trong `assembly_tc.tcl`, có vẻ thiết lập filter mức "error" cho một channel log đã set bằng `*messagefileset`.
- **Confidence**: LOCAL-INSTALL

```tcl
# assemblytools/assembly_tc.tcl:258
  *messagefilefilter feinput "error";
# assemblytools/assembly_tc.tcl:288
  *messagefilefilter connector "error";
```

---

### *messagefileset

- **Signature**: `*messagefileset <channel> "<filepath>"` — ví dụ: `*messagefileset feinput "$::Assembly::TC::p_temp_files(log_feinput)";` và có thể gọi với chuỗi rỗng để clear: `*messagefileset feinput "";`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết ngữ nghĩa, nhưng cách dùng cho thấy set đường dẫn file log cho một channel (feinput, connector) và truyền chuỗi rỗng để tắt/reset.
- **Confidence**: LOCAL-INSTALL

```tcl
# assemblytools/assembly_tc.tcl:257
  *messagefileset feinput "$::Assembly::TC::p_temp_files(log_feinput)";
# assemblytools/assembly_tc.tcl:270
  *messagefileset feinput "";
# assemblytools/assembly_tc.tcl:287
  *messagefileset connector "$::Assembly::TC::p_temp_files(log_connectors)";
# assemblytools/assembly_tc.tcl:303
  *messagefileset connector "";
```

---

### *metadatamarkdouble

- **Signature**: `*metadatamarkdouble <entitytype> <markid> "<metadataName>" <doubleValue>` — ví dụ: `*metadatamarkdouble mats 1 "Transverse_Shear_Allowable_S13" 0.0`
- **Return shape**: side-effect.
- **Precondition/side-effect**: yêu cầu mark (ở đây markid=1) đã chứa entity đích (mats) trước khi gọi — suy ra từ pattern dùng chung với các lệnh `*metadatamark*` khác trong cùng file; giá trị double được set làm metadata cho entity trong mark.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/certification/methodmanager/Implementation/Interface.tcl:79
                        *metadatamarkdouble mats 1 "Transverse_Shear_Allowable_S13" 0.0
# br/views/certification/methodmanager/Implementation/Interface.tcl:80
                        *metadatamarkdouble mats 1 "Transverse_Shear_Allowable_S23" 0.0
# br/views/certification/methodmanager/Implementation/Interface.tcl:81
                        *metadatamarkdouble mats 1 "E3" 0.0
```

---

### *metadatamarkint

- **Signature**: `*metadatamarkint <entitytype> <markid> <metadataName> <intValue>` — ví dụ: `*metadatamarkint designpointmethod 1 IntPointSizePerEdge 3` và `*metadatamarkint comps 1 PenetrationLocked 1`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity phải nằm trong mark chỉ định trước; set giá trị metadata kiểu int lên các entity trong mark (ví dụ dùng để đánh dấu cờ khóa `PenetrationLocked 1` trong `br/views/collision/operations/lock.tcl:46`).
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/certification/operations/addmethod.tcl:365
            *metadatamarkint designpointmethod 1 IntPointSizePerEdge 3
# br/views/certification/operations/addmethod.tcl:432
								*metadatamarkint $entitytype 1 $varName $varVal
# br/views/collision/operations/lock.tcl:46
    *metadatamarkint comps 1 PenetrationLocked 1
```

---

### *metadatamarkremove

- **Signature**: `*metadatamarkremove <entitytype> <markid> "<metadataName>"` — ví dụ: `*metadatamarkremove comps 1 PenetrationLocked` và `*metadatamarkremove $strEntityType 1 $strMetaDataName;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity phải nằm trong mark; xóa metadata theo tên khỏi các entity trong mark. Được dùng đối xứng với `*metadatamarkint ... PenetrationLocked 1` để unlock (xem `br/views/collision/operations/lock.tcl:110` đối chiếu dòng 46).
- **Confidence**: LOCAL-INSTALL

```tcl
# bommgr/metadatamgrutil.tcl:320
        *metadatamarkremove $strEntityType 1 $strMetaDataName;
# br/views/collision/operations/lock.tcl:110
    *metadatamarkremove comps 1 PenetrationLocked 
# br/views/composite/operations/laminateloadmanager.tcl:45
	*metadatamarkremove 0 0 EME_laminate_load
```

---

### *metadatamarkstring

- **Signature**: `*metadatamarkstring <entitytype> <markid> "<metadataName>" "<stringValue>"` — ví dụ: `*metadatamarkstring beamsects 1 "SE_CLASS" "$_setype"`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity phải nằm trong mark; set giá trị metadata kiểu string lên entity trong mark.
- **Confidence**: LOCAL-INSTALL

```tcl
# bommgr/metadatamgrutil.tcl:63
        *metadatamarkstring $strEntityType 1 [lindex $listMetaDataNames $i] [lindex $listMetaDataValues $i];
# br/views/certification/operations/StructuralProperty.tcl:637
    *metadatamarkstring beamsects 1 "SE_CLASS" "$_setype"
# browser/default_component.tcl:692
    eval *metadatamarkstring comps 1 "$metadataname" "$newMetadataValue";
```

---

### *metadatamarkstringarray

- **Signature**: `*metadatamarkstringarray <entitytype> <markid> "<metadataName>" <count> <value...>` — ví dụ: `*metadatamarkstringarray 0 0 EME_laminate_load 1 1` và `eval *metadatamarkstringarray undefined 0 "FBDres_odb" 1 [llength $results]`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết cấu trúc tham số sau tên metadata (số lượng phần tử array), chỉ quan sát được vị trí tham số cuối dùng `[llength ...]` trong `fbd_common.tcl`, gợi ý đây là số phần tử của mảng.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/composite/operations/laminateloadmanager.tcl:47
	*metadatamarkstringarray 0 0 EME_laminate_load 1 1
# fbd/fbd_common.tcl:443
      catch {eval *metadatamarkstringarray undefined 0 "FBDres_odb" 1 [llength $results]}
# fbd/fbd_common.tcl:447
      catch {eval *metadatamarkstringarray undefined 0 "FBDresfileodb" 1 [llength $RESfile]}
```

---

### *modent_addcontentsbyids

- **Signature**: `*modent_addcontentsbyids <parentType> <parentId> <childType> <childIds>` — ví dụ: `*modent_addcontentsbyids subsystems $subsystem_id $parent_type $parent_id` và `*modent_addcontentsbyids $parenttypename $parentid $childtype $children_ids`
- **Return shape**: side-effect (dùng trong `catch {...}` nên có thể lỗi, không thấy gán trả về giá trị dùng sau đó).
- **Precondition/side-effect**: dùng trong ngữ cảnh subsystem hierarchy (`viewmanager.tcl`), có logic `if {[catch {...}] && $blDeleteParentOnError}` cho thấy nếu add content lỗi, có thể xóa parent vừa tạo — chỉ xác nhận đây là hành vi của code gọi, không phải bản thân lệnh.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/modules/core/operations/configuration/createsubsystem.tcl:35
    *modent_addcontentsbyids subsystems $subsystem_id $parent_type $parent_id
# br/views/subsystems/common/viewmanager.tcl:1073
                  if {[catch {*modent_addcontentsbyids $parenttypename $parentid $childtype $children_ids} err] && $blDeleteParentOnError} {
# br/views/subsystems/common/viewmanager.tcl:1084
                    if {[catch {*modent_addcontentsbyids $parenttypename $parentid $childtype $child_id} err] } {
```

---

### *modent_addcontentsbymark

- **Signature**: `*modent_addcontentsbymark <parentType> <parentId> <childType> <markId>` — ví dụ: `*modent_addcontentsbymark $parent_type $parent_id $entity_type 1` và `*modent_addcontentsbymark $parenttypename $parentid $childtype $markid`
- **Return shape**: side-effect; có callback đăng ký qua `AddCallback *modent_addcontentsbymark ...` trong `Export_GUI_FE.tcl`.
- **Precondition/side-effect**: entity con phải nằm trong mark chỉ định trước khi gọi; thêm các entity trong mark vào một parent (subsystem) theo type. Callback framework theo dõi lệnh này để cập nhật GUI export (`Export_GUI_FE.tcl:33-34`).
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/subsystems/common/operations/create.tcl:50
                            *modent_addcontentsbymark $parent_type $parent_id $entity_type 1
# br/views/subsystems/common/viewmanager.tcl:1128
              set catch_retval [catch {*modent_addcontentsbymark $parenttypename $parentid $childtype $markid} err]
# ImportExport/Export_GUI_FE.tcl:34
   AddCallback *modent_addcontentsbymark ::Export_GUI::FE_includesSet
```

---

### *modent_addrepresentations

- **Signature**: `*modent_addrepresentations <entityType> <id> <repKey> <includePaths> <includesFormat>` — theo comment liền kề: `# *modent_addrepresentations entities subsystemId repKey includePaths includesFormat`, dùng thực tế: `*modent_addrepresentations subsystems $id $repKey $includePaths $includesFormat`
- **Return shape**: side-effect.
- **Precondition/side-effect**: comment xác nhận rõ tên tham số theo đúng thứ tự trên; chưa xác định thêm về định dạng `includesFormat`.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/subsystems/common/workflows.tcl:555
    # *modent_addrepresentations entities subsystemId repKey includePaths includesFormat
# br/views/subsystems/common/workflows.tcl:559
    *modent_addrepresentations subsystems $id $repKey $includePaths $includesFormat
```

---

### *modent_registerconstraintruleoptions

- **Signature**: `*modent_registerconstraintruleoptions subsystems 2 $independent $dependent $move $behavior`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định ý nghĩa cụ thể của số `2` (có thể là entity type code cho subsystems) hay các biến `$independent/$dependent/$move/$behavior` — không có comment giải thích trong dòng trích được.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/subsystems/common/utils.tcl:184
          *modent_registerconstraintruleoptions subsystems 2 $independent $dependent $move $behavior
```

---

### *modent_removecontentsbyids

- **Signature**: `*modent_removecontentsbyids <parentType> <parentId> <childType> <childIds>` — ví dụ: `*modent_removecontentsbyids $parent_type $parent_id includefile $ls_includeids` và `*modent_removecontentsbyids $ptype $parent_id $childtype $childrenids`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — đối xứng cấu trúc tham số với `*modent_addcontentsbyids`, dùng trong file `remove.tcl` của subsystems.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/subsystems/common/operations/remove.tcl:62
            *modent_removecontentsbyids $parent_type $parent_id includefile $ls_includeids
# br/views/subsystems/common/operations/remove.tcl:112
                          *modent_removecontentsbyids $ptype $parent_id $childtype $childrenids
```

---

### *modent_removecontentsbymark

- **Signature**: `*modent_removecontentsbymark <parentType> <parentId> <childType> <markId>` — ví dụ: `*modent_removecontentsbymark $parent_type $parent_id $childtype 1` và `*modent_removecontentsbymark $ptype $parent_id $childtype 1`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity cần xóa khỏi parent phải nằm trong mark chỉ định trước; đối xứng với `*modent_addcontentsbymark`.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/subsystems/common/operations/remove.tcl:69
                *modent_removecontentsbymark $parent_type $parent_id $childtype 1
# br/views/subsystems/common/operations/remove.tcl:116
                            *modent_removecontentsbymark $ptype $parent_id $childtype 1
```

---

### *modent_saverepresentation

- **Signature**: `*modent_saverepresentation <entitytype> $id "repKey=$alias, filepath=$filepath, repcomment=$comment"`
- **Return shape**: side-effect (ghi file representation).
- **Precondition/side-effect**: tham số thứ 3 là một chuỗi định dạng "key=value" ghép bằng dấu phẩy (repKey, filepath, repcomment) — quan sát trực tiếp từ dòng code, không suy đoán thêm.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/subsystems/common/workflows.tcl:461
      *modent_saverepresentation $entitytype $id "repKey=$alias, filepath=$filepath, repcomment=$comment"
```

---

### *movemark

- **Signature**: `*movemark <entitytype> <markid> <destination>` — ví dụ: `*movemark elems 1 ^Main_Rods`, `*movemark elements 1 $newname;`, `*movemark lines 1 $currentComp;`, `*movemark systems 2 \"$systColName\"`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity cần di chuyển phải nằm trong mark chỉ định; tham số đích có thể là tên component dạng `^CompName` (literal) hoặc biến chứa tên component/system đích. Di chuyển entity trong mark sang component/collector đích.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/abaquscontactcomparison.tcl:526
		*movemark elems 1 ^Main_Rods
# abaqus/Contact_wizard/CWinterface/CWautocontact.tcl:314
      *movemark elements 1 $newname;
# abaqus/Contact_wizard/CWsurface/CWRigidsurface.tcl:1220
            *movemark lines 1 $currentComp;
```

---

### *movesolvermasses

- **Signature**: `*movesolvermasses $markid $parentid;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết, chỉ tìm được 1 lần dùng, trong file `organizeentites.tcl` (nhóm operations tổ chức entity), gợi ý di chuyển solver masses trong mark sang một parent/collector đích nhưng không có comment xác nhận.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/common/operations/organizeentites.tcl:307
                    *movesolvermasses $markid $parentid;
```

---

### *nodecleartempmark

- **Signature**: `*nodecleartempmark` (không tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết ngữ nghĩa; tên gợi ý xóa "temp mark" của node, xuất hiện lặp lại nhiều lần trong `abaquscontactcomparison.tcl` xen giữa các thao tác khác, và bị comment-out ở một chỗ (`abaqusstep.tcl:2025`, `#*nodecleartempmark`) cho thấy có thể tùy chọn.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/abaquscontactcomparison.tcl:302
	*nodecleartempmark
# abaqus/abaquscontactcomparison.tcl:719
    *nodecleartempmark
# abaqus/AbaqusStep/abaqusstep.tcl:2025
            #*nodecleartempmark
```

---

### *nodecreateonlines

- **Signature**: `*nodecreateonlines lines <markid> <count> 0 0` — ví dụ: `*nodecreateonlines lines 1 4 0 0`, `*nodecreateonlines lines 1 2 0 0` (kèm comment "create two end points"), `*nodecreateonlines lines 1 9 0 0`.
- **Return shape**: side-effect (tạo node).
- **Precondition/side-effect**: line(s) đích phải nằm trong mark chỉ định trước; comment tại `HXForge/create_geom.tcl:1125` xác nhận: `*nodecreateonlines lines 1 2 0 0;#create two end points` — tham số thứ 3 (count) = số node tạo trên mỗi line (2 nghĩa là 2 điểm đầu-cuối).
- **Confidence**: LOCAL-INSTALL

```tcl
# hm_macromenu.tcl:785
        *nodecreateonlines lines 1 4 0 0
# HyperForge/HXForge/create_geom.tcl:1125
        *nodecreateonlines lines 1 2 0 0;#create two end points
# hyperform/utility/Radius_Measure.tcl:22
*nodecreateonlines lines 1 4 0 0;
```

---

### *nodemarkcleartempmark

- **Signature**: `*nodemarkcleartempmark <arg>` — ví dụ: `*nodemarkcleartempmark 1;` và `*nodemarkcleartempmark  2` (khác với `*nodecleartempmark` — đây có thêm 1 tham số số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: comment tại `cfd/utils.tcl:297` — `*nodemarkcleartempmark 1 ; # delete temp node` — xác nhận lệnh này xóa temp node, tham số là markid hoặc mark index liên quan.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/AnalyticalRigid/ARSDialog.tcl:231
        *nodemarkcleartempmark 1;
# cfd/utils.tcl:297
    *nodemarkcleartempmark 1 ; # delete temp node
# cfd/utils.tcl:1186
    *nodemarkcleartempmark  2
```

---

### *normalsadjust

- **Signature**: `*normalsadjust <entitytype> <markid> <value> <flag>` — ví dụ: `*normalsadjust components 2 $felem2 1.0 0` (5 tham số ở đây, entitytype=components, markid=2, rồi $felem2, 1.0, 0), và `*normalsadjust elements 2 $eID 0 0`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định rõ ràng ý nghĩa từng tham số sau markid — số lượng tham số quan sát được không đồng nhất giữa các lần gọi (4 vs 5), nên KHÔNG chốt cứng số lượng tham số; ghi nguyên văn các biến thể quan sát được. Lưu ý: có biến thể lệnh riêng `*normalsadjust2` (khác lệnh, không nhầm lẫn) thấy tại `UserProfiles/HyperWorksCFD/HyperWorksCFD.tcl:3735`.
- **Confidence**: LOCAL-INSTALL

```tcl
# ansys/ContactManager/contactpair/contact_target_normal_dialog.tcl:380
      *normalsadjust components 2 $felem2 1.0 0
# nastran/ContinuousWeld.tcl:397
        *normalsadjust components 1 $elem 0 0
# optistruct/makehex.tcl:182
  *normalsadjust elements 2 $eID 0 0
```

---

### *normalsdisplay

- **Signature**: `*normalsdisplay <entitytype> <markid> <size>` — ví dụ: `*normalsdisplay elements 1 0` và `*normalsdisplay elements 1 $normalsize`.
- **Return shape**: side-effect (hiển thị normal, không trả về giá trị).
- **Precondition/side-effect**: elements đích phải nằm trong mark; tham số cuối là kích thước hiển thị normal (biến `$normalsize` xác nhận điều này).
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/AbaqusStep/load/dload/dload_tab1.tcl:1812
                catch {*normalsdisplay elements 1 0};
# abaqus/Contact_wizard/CWsurface/CWElsurpage2.tcl:193
        catch {*normalsdisplay elements 1 $normalsize};
# abaqus/Contact_wizard/CWsurface/CWElsurpage2.tcl:334
            *normalsdisplay elements 1 0;
```

---

### *normalsoff

- **Signature**: `*normalsoff` (không tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — tên gợi ý tắt hiển thị normal (đối xứng với `*normalsdisplay`), nhưng không có comment xác nhận trực tiếp trong các dòng trích.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/AbaqusStep/load/dload/dload_tab1.tcl:1912
    *normalsoff;
# abaqus/AnalyticalRigid/ARSDialog.tcl:77
    *normalsoff;  
# abaqus/Contact_wizard/CWsurface/CWElsurface.tcl:199
    *normalsoff;
```

---

### *normalsreverse

- **Signature**: `*normalsreverse <entitytype> <markid> <flag>` — ví dụ: `*normalsreverse elements 1 0;` và `*normalsreverse components 1 0.0;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity đích phải nằm trong mark; đảo chiều normal của elements/components trong mark. Ý nghĩa tham số cuối (0 hoặc 0.0) chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/Contact_wizard/CWsurface/CWElsurpage2.tcl:232
                        *normalsreverse elements 1 0;
# abaqus/Renumber_tool/cont_shell.tcl:640
        *normalsreverse elements 1 0
# ansys/ContactManager/cm.tcl:461
                *normalsreverse components 1 0.0;
```

---

### *numbers

- **Signature**: KHÔNG TÌM THẤY dòng nào gọi trực tiếp `*numbers` (chỉ tìm thấy các biến thể `*numbersclear` và `*numbersmark`, là các lệnh khác biệt về tên, không phải `*numbers` đứng riêng).
- **Return shape**: N/A
- **Precondition/side-effect**: N/A
- **Confidence**: N/A — KHÔNG TÌM THẤY - có thể là rác trích xuất (bị tách nhầm từ `*numbersclear`/`*numbersmark`), không phải lệnh HM thật độc lập.

---

### *numbersclear

- **Signature**: `*numbersclear` (không tham số, mọi lần dùng).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — dùng trước `*numbersmark` trong cùng workflow review (ví dụ `showhideisolateconflicts.tcl` gọi `*numbersclear` ở dòng 155 rồi `*numbersmark nodes $markid 1;` ở dòng 161), gợi ý xóa toàn bộ number hiển thị trước khi đánh số lại theo mark.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/common/operations/reviewreset.tcl:25
	*numbersclear;
# br/views/idmgr/operations/showhideisolateconflicts.tcl:155
    *numbersclear;
# br/views/mass/operations/review.tcl:90
	*numbersclear;
```

---

### *numbersmark

- **Signature**: `*numbersmark <entitytype> <markid> <flag>` — ví dụ: `*numbersmark $type $markid 1;`, `*numbersmark nodes $markid 1;`, `*numbersmark connectors 1 1;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: entity đích phải nằm trong mark; hiển thị số (number) cho các entity trong mark, dùng thường sau `*numbersclear` để reset trước.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/idmgr/operations/review.tcl:45
		*numbersmark $type $markid 1;
# br/views/idmgr/operations/showhideisolateconflicts.tcl:161
            *numbersmark nodes $markid 1;
# connectors/ce_table.tcl:1097
  *numbersmark connectors 1 1;
```

---

### *outputblocksupdate

- **Signature**: `*outputblocksupdate "<dbaseName>" <entitytype> <flag>` — ví dụ: `*outputblocksupdate "$dbaseName" nodes 1` và `*outputblocksupdate $::hmpa::entName $attrib_name 1;`
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết ý nghĩa `<dbaseName>` — trong `PartReplacement.tcl`/`dhistory.tcl` gợi ý cập nhật output block liên quan tới một database name, cho entitytype cụ thể (nodes/elements/sets).
- **Confidence**: LOCAL-INSTALL

```tcl
# browser/property_info.tcl:1742
            *outputblocksupdate $::hmpa::entName $attrib_name 1;
# dynakey/partReplacement/dhistory.tcl:506
          *outputblocksupdate "$dbaseName" nodes 1
# dynakey/partReplacement/dhistory.tcl:579
          *outputblocksupdate "$dbaseName" elements 1
```

---

### *pastefromclipboard

- **Signature**: `*pastefromclipboard` (không tham số, chỉ 1 lần dùng tìm được).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết — nằm trong `br/common/operations/paste.tcl`, tên lệnh tự giải thích chức năng (paste từ clipboard nội bộ HM), không có thêm comment.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/common/operations/paste.tcl:46
    *pastefromclipboard
```

---

### *PenetrationCheckSummary

- **Signature**: `*PenetrationCheckSummary "<logfilepath>" <arg2> <arg3>` — duy nhất 1 lần dùng: `*PenetrationCheckSummary "$::Assembly::TC::p_temp_files(log_penetration)" 1 -4;`
- **Return shape**: side-effect (ghi log ra file).
- **Precondition/side-effect**: chưa xác định ý nghĩa của `1` và `-4`; chỉ biết tham số đầu là đường dẫn file log penetration.
- **Confidence**: LOCAL-INSTALL

```tcl
# assemblytools/assembly_tc.tcl:320
    *PenetrationCheckSummary "$::Assembly::TC::p_temp_files(log_penetration)" 1 -4;
```

---

### *plot

- **Signature**: `*plot` hoặc `*plot <arg>` — ví dụ: `*plot;` (không tham số) và `*plot 1` (có 1 tham số).
- **Return shape**: side-effect (vẽ lại màn hình đồ họa).
- **Precondition/side-effect**: chưa xác định ý nghĩa tham số `1` khi có; dùng phổ biến sau các thao tác thay đổi hiển thị (normals, v.v.) để redraw.
- **Confidence**: LOCAL-INSTALL

```tcl
# abaqus/abaquscontactcomparison.tcl:475
		*plot 1
# abaqus/AbaqusStep/abaqusstep.tcl:1782
        *plot;
# abaqus/AbaqusStep/load/dload/dload_tab1.tcl:1863
        *plot;
```

---

### *rbe3

- **Signature**: `*rbe3 <arg1> <arg2> <numDep> <arg4> <numWt> <flag> <dof> <arg8>` — dòng duy nhất tìm được với đúng tên lệnh `*rbe3` (không phải `*rbe3update`/`*rbe3updatewts` là 2 lệnh khác tên): `*rbe3 1 1 [llength $newdepdndnodes] 1 [llength $newdepdndnodes] 0 123456 1`
- **Return shape**: side-effect (tạo/cập nhật RBE3 element).
- **Precondition/side-effect**: chưa xác định chi tiết từng vị trí tham số ngoài việc 2 tham số (vị trí 3 và 5) đều dùng `[llength $newdepdndnodes]` — tức là số lượng dependent node; `123456` xuất hiện giống DOF string kiểu Nastran (nhưng đây chỉ là quan sát, không khẳng định chắc). LƯU Ý: đây là lệnh khác với `*rbe3update` và `*rbe3updatewts` xuất hiện gần đó trong cùng codebase — không được nhầm lẫn ba lệnh này với nhau.
- **Confidence**: LOCAL-INSTALL

```tcl
# context/src/snr/editconnection.tcl:161
                    *rbe3update $rbe3 2 1 [llength $newdepdndnodes] 1 [llength $newdepdndnodes] $curdependnodes 123456 0
# context/src/snr/editconnection.tcl:168
                    *rbe3 1 1 [llength $newdepdndnodes] 1 [llength $newdepdndnodes] 0 123456 1
# connectors/prop_acm.tcl:79
          eval *rbe3updatewts $rbe3 1 $numnodes 1 $numwts $dep_node_wt;
```

---

### *readxmlfile

- **Signature**: `*readxmlfile file=$::mass::importPath` — tham số truyền dạng chuỗi `file=<path>` (key=value trong một token), duy nhất 1 lần dùng tìm được.
- **Return shape**: side-effect (đọc file XML để import).
- **Precondition/side-effect**: chưa xác định thêm; dùng trong `br/views/mass/init.tcl`, ngữ cảnh import mass.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/mass/init.tcl:210
    *readxmlfile file=$::mass::importPath		
```

---

### *realizecsfbdsectiontostdfbdsection

- **Signature**: `*realizecsfbdsectiontostdfbdsection $fbdIds` — duy nhất 1 lần dùng tìm được.
- **Return shape**: side-effect.
- **Precondition/side-effect**: chưa xác định chi tiết, tên và đường dẫn file (`resolvecstostdfbdsection.tcl`) gợi ý chuyển đổi free body diagram section từ dạng "cs" (coordinate-system-based?) sang dạng "std" (standard), nhưng đây chỉ là suy luận từ tên file/lệnh — KHÔNG có comment xác nhận, nên không chốt trong phần precondition.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/views/enggbr/freebodysections/operations/resolvecstostdfbdsection.tcl:19
		*realizecsfbdsectiontostdfbdsection $fbdIds
```

---

### *realizeengineeringentities

- **Signature**: `*realizeengineeringentities <entitytype> <markid> <flag>` — ví dụ: `*realizeengineeringentities $type 1 0;` và `*realizeengineeringentities mass 1 0`. Cũng thấy dạng gọi có giá trị trả về: `catch {![*realizeengineeringentities mass $markid]}`.
- **Return shape**: CÓ giá trị trả về — bằng chứng: `catch {![*realizeengineeringentities mass $markid]}` dùng kết quả lệnh trong biểu thức boolean (phủ định `!`).
- **Precondition/side-effect**: entity phải nằm trong mark; có callback framework theo dõi lệnh này (`::hwt::AddCallback *realizeengineeringentities ::mass::updatemasstotal`) để cập nhật tổng khối lượng sau khi gọi — xác nhận lệnh này thay đổi trạng thái mass entities.
- **Confidence**: LOCAL-INSTALL

```tcl
# br/common/operations/engentityoperations.tcl:30
        *realizeengineeringentities $type 1 0;
# br/views/mass/operations/commonoperations.tcl:68
	catch {![*realizeengineeringentities mass $markid]}
# br/views/mass/init.tcl:522
    ::hwt::AddCallback *realizeengineeringentities ::mass::updatemasstotal;
```

---

## Ghi chú tổng kết batch

- Tổng số lệnh trong batch: 39 (danh sách gốc có dòng trống số 40, bỏ qua).
- Số lệnh KHÔNG TÌM THẤY dạng độc lập: 1 (`*numbers` — chỉ tồn tại dưới dạng các lệnh khác `*numbersclear`/`*numbersmark`, không có `*numbers` trần).
- Tất cả các lệnh còn lại (38) đều tìm thấy bằng chứng thật trong file `.tcl` của bản cài đặt local, đã trích dẫn nguyên văn kèm đường dẫn/số dòng.
- Với các lệnh mà ý nghĩa tham số không rõ ràng từ comment/ngữ cảnh, đã ghi rõ "chưa xác định" thay vì suy đoán.


### *reconcilemasslocation

- **Signature**: `*reconcilemasslocation 2 1` (2 tham số nguyên, ý nghĩa cụ thể chưa xác định)
- **Return shape**: side-effect, không thấy gán vào biến.
- **Precondition/side-effect**: có callback đăng ký qua `::hwt::AddCallback *reconcilemasslocation ...` — tức là lệnh này phát sinh event callback được hệ thống mass lắng nghe (`::mass::updatemasstotal`). Dùng trong `br/views/mass/operations/reconcile.tcl` (module "mass reconcile").
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/mass/init.tcl:406:		    || $command == "*reconcilemasslocation" || $command == "*feabsorbtomassentity" || $command == "*setcurrentmodel" || $command == "*removemodel"} {
./br/views/mass/init.tcl:524:    ::hwt::AddCallback *reconcilemasslocation ::mass::updatemasstotal;
./br/views/mass/operations/reconcile.tcl:46:	*reconcilemasslocation 2 1
```

---

### *rejectmark

- **Signature**: `*rejectmark` (không tham số, quan sát từ mọi lần gọi).
- **Return shape**: side-effect.
- **Precondition/side-effect**: xuất hiện lặp lại ngay sau các thao tác mesh (`br/views/meshcontrols/operations/mesh.tcl`) và trong boolean operation — gợi ý dùng để loại bỏ (reject) mark hiện hành khỏi review/selection, nhưng cơ chế chính xác chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./AdaptiveWrap.tcl:1771:        *rejectmark
./BooleanOperation.tcl:175:  *rejectmark
./br/views/meshcontrols/operations/mesh.tcl:615:  *rejectmark;
./cfd/periodic_wizard.tcl:373:    *rejectmark
```

---

### *removecrbrelation

- **Signature**: `*removecrbrelation 1` (1 tham số nguyên).
- **Return shape**: side-effect.
- **Precondition/side-effect**: gọi trong `br/views/CRBHierarchy/operations/remove.tcl` — thuộc module CRB Hierarchy remove, ý nghĩa tham số chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/CRBHierarchy/operations/remove.tcl:77:    *removecrbrelation 1;
```

---

### *removeposition

- **Signature**: `*removeposition 1 2` (2 tham số nguyên).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `positiontransform` (reorganize.tcl và context/src/positiontransform.tcl) — thuộc chức năng position/transform reorganize, ý nghĩa tham số chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/positiontransform/operations/reorganize.tcl:66:            *removeposition 1 2
./context/src/positiontransform.tcl:555:                                *removeposition 1 2
```

---

### *removetransformation

- **Signature**: `*removetransformation 1 1` (2 tham số nguyên).
- **Return shape**: side-effect.
- **Precondition/side-effect**: cùng module positiontransform reorganize như `*removeposition`; ý nghĩa tham số chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/positiontransform/operations/reorganize.tcl:34:        *removetransformation 1 1
./context/src/positiontransform.tcl:516:						*removetransformation 1 1
```

---

### *replacenodes

- **Signature**: `*replacenodes $node_to_replace $node_replacement <flag1> <flag2>` — quan sát: `*replacenodes $n_node2 $n_node1 0 0` và `*replacenodes $nodeToReplace $n_lastSelectedNode 1 0`. Tổng cộng 4 tham số: node id, node id, và 2 cờ số (0/1 quan sát được).
- **Return shape**: side-effect, thường bọc trong `catch {...}`.
- **Precondition/side-effect**: dùng trong `RectifyJointCoincidentNodes.tcl` (rectify trùng node của joint) và `partReplacement/ifix.tcl` — tên biến `nodeToReplace`, `n_lastSelectedNode` gợi ý thay thế node cũ bằng node mới (merge node), nhưng ý nghĩa chính xác của 2 flag cuối chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./dynakey/errorcheck/rectify/RectifyJointCoincidentNodes.tcl:431:    catch {*replacenodes $n_node2 $n_node1 0 0}
./dynakey/partReplacement/ifix.tcl:449:  *replacenodes $nodeToReplace $n_lastSelectedNode 1 0;
./dynakey/partReplacement/ifix.tcl:526:  *replacenodes $currentNodetoBeMoved $n_prevNodeOf1DElement 1 0;
```

---

### *rescanunresolvedids

- **Signature**: `*rescanunresolvedids` (không tham số quan sát được).
- **Return shape**: side-effect.
- **Precondition/side-effect**: xuất hiện trong `assemblytools` (import MCF, assembly crash API) và `br/views/connectors`, đa số bị comment (`#*rescanunresolvedids;`) — gợi ý liên quan tới việc quét lại ID chưa resolve sau import, nhưng chưa xác định chắc chắn.
- **Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/profiles/crash/api/AssemblyCrashApi.tcl:206:  #*rescanunresolvedids;
./assemblytools/at/profiles/crash/browser/mcf_import.tcl:84:  *rescanunresolvedids;
./br/views/connectors/core/common/operations/tools.tcl:154:  *rescanunresolvedids;
```

---

### *resetreview

- **Signature**: `*resetreview` (không tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng nhiều nơi trong review workflows (`abaqus/PretensionManager.tcl`, `br/common/operations/review.tcl`, `br/common/viewmanager.tcl`, autocontact review) — thuộc nhóm review-state reset, chưa xác định chi tiết state nào bị reset.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/PretensionManager.tcl:1028:    *resetreview
./br/common/operations/review.tcl:45:        *resetreview
./br/common/viewmanager.tcl:712:        *resetreview
./br/views/autocontact/common/operations/review.tcl:32:        *resetreview
```

---

### *reverseview

- **Signature**: quan sát 2 dạng: `*reverseview [join [hmbr::selection getProp]]` (1 tham số list tên) và `*reverseview "Lock" 0` / `*reverseview $viewName -1` (2 tham số: tên view, số nguyên).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong view toolbar (`context/viewtoolbar/toolbarviews.tcl`) và idle proc lock view — liên quan đảo ngược (reverse) 1 view theo tên; chưa xác định ý nghĩa tham số số nguyên thứ hai.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/allnonereverse.tcl:67:                    *reverseview [join [hmbr::selection getProp]]
./context/src/idleproc.tcl:1110:        *reverseview "Lock" 0
./context/viewtoolbar/toolbarviews.tcl:395:    *reverseview $viewName -1
```

---

### *reviewclearall

- **Signature**: `*reviewclearall` (không tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `abaqus/AbaqusStep/abaqusstep.tcl` nhiều lần, cùng khu vực với `*resetreview`, `*setreviewmode`, `*setreviewcolormode` — thuộc chuỗi thiết lập/xóa toàn bộ trạng thái review khi mở step editor.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1740:        *reviewclearall;
./abaqus/AbaqusStep/abaqusstep.tcl:1762:		*reviewclearall;
./abaqus/AbaqusStep/abaqusstep.tcl:1831:    *reviewclearall
```

---

### *reviewcontactnormalinconsistency

- **Signature**: `*reviewcontactnormalinconsistency GROUPS "$contact_surface_name" 1` — 3 tham số: keyword loại entity (`GROUPS`), tên surface (string), cờ số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `br/views/autocontact/common/operations/reviewcontactnormal.tcl` — thuộc autocontact, review độ nhất quán normal của contact surface theo tên group; ý nghĩa cờ cuối chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/reviewcontactnormal.tcl:36:                    *reviewcontactnormalinconsistency GROUPS "$contact_surface_name" 1;
```

---

### *reviewentity

- **Signature**: `*reviewentity $type "by id" $ids $entityColor` (4 tham số) — biến thể mở rộng: `*reviewentity $entityType "by id" $entityId $color 1 0` (6 tham số, thêm 2 cờ).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong dummy review, entity_reference browser, lsdyna/radioss menu_function, PretensionManager — literal `"by id"` là chế độ chọn entity theo ID; `$entityColor` là màu review. Ý nghĩa 2 cờ thêm ở PretensionManager chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/dummy/operations/review.tcl:43:    *reviewentity $type "by id" $ids $entityColor
./browser/entity_reference.tcl:3489:    *reviewentity $str_entityType "by id" $list_entityId $entityColor;
./optistruct/PretensionManager.tcl:744:        *reviewentity $entityType "by id" $entityId $color 1 0;
```

---

### *reviewentitybymark

- **Signature**: quan sát cả dạng 1 tham số `*reviewentitybymark 2` và nhiều tham số `*reviewentitybymark 2 0 1 0` / `*reviewentitybymark $markid`. Số lượng tham số không cố định giữa các lần gọi (1 đến 4 số nguyên).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng cùng nhóm review với `*reviewentity`, thao tác trên mark hiện hành thay vì id list trực tiếp; ý nghĩa từng tham số số nguyên chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1763:		*reviewentitybymark 2 0 1 0
./br/common/operations/review.tcl:67:    *reviewentitybymark 2       
./br/views/CRBHierarchy/operations/review.tcl:42:    *reviewentitybymark $markid;
```

---

### *rigid

- **Signature**: `*rigid $node_dependent $node_independent $dof_code` — 3 tham số, ví dụ `*rigid $center $node_id 123456`, `*rigid $n2 $n0 123456`.
- **Return shape**: side-effect (tạo entity rigid).
- **Precondition/side-effect**: dùng trong SewingTool, macroAddWasher, macroTrimMeshWithCircle, nastran spiderMacro — tham số thứ 3 luôn là chuỗi số DOF kiểu `123456` (mã bậc tự do rigid, giống RBE2). Tạo 1 rigid element nối 2 node.
- **Confidence**: LOCAL-INSTALL

```tcl
./EngineeringSolutions/aerospace/SewingTool/SewingTool.tcl:482:					*rigid $n2 $n0 123456
./macroAddWasher.tcl:1437:            *rigid $center $node_id 123456;
./nastran/spiderMacro.tcl:653:                   *rigid $centerNode $tempNode 123456;
```

---

### *rigidlink

- **Signature**: `*rigidlink $node <mode_code> <dof_code>` — ví dụ `*rigidlink $indnode 1 123`, `*rigidlink $center $node_mark 123456`. Tham số thứ 2 quan sát là số nguyên nhỏ (1, 2) HOẶC một mark id (`$node_mark`), tham số 3 là chuỗi DOF.
- **Return shape**: gán vào biến `set cmd "*rigidlink $nodeT 2 123" ; eval $cmd` (dùng eval, không phải return trực tiếp).
- **Precondition/side-effect**: dùng trong RBE2Filter, fix_illegalrigids — thao tác tạo/link rigid tương tự RBE2.
- **Confidence**: LOCAL-INSTALL

```tcl
./dynakey/fix_illegalrigids.tcl:112:			*rigidlink $indnode 1 123
./EngineeringSolutions/aerospace/RBE2Filter/RBE2Filter.tcl:188:	set cmd "*rigidlink $nodeT 2 123" ; eval $cmd
./macroAddWasher.tcl:1442:        *rigidlink $center $node_mark 123456;
```

---

### *rigidlinkupdate

- **Signature**: `*rigidlinkupdate $rigid_id $independentnode <mode>` — ví dụ `*rigidlinkupdate $i $independentnode 1`, `*rigidlinkupdate $i $indnode 2`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `find_fix_freerigids.tcl` / `fix_illegalrigids.tcl` / `nastfindfixfreerigids.tcl` — cập nhật lại independent node của 1 rigid link đã tồn tại (biến `$i` là rigid element id theo ngữ cảnh vòng lặp sửa lỗi rigid).
- **Confidence**: LOCAL-INSTALL

```tcl
./dynakey/find_fix_freerigids.tcl:164:		      *rigidlinkupdate $i $independentnode 1
./dynakey/fix_illegalrigids.tcl:102:	     		*rigidlinkupdate $i $indnode 2
./nastran/nastfindfixfreerigids.tcl:163:		      *rigidlinkupdate $i $independentnode 1
```

---

### *rigidscombine

- **Signature**: `*rigidscombine 1 0` (2 tham số nguyên).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chỉ tìm thấy 1 lần dùng, trong `connectors/prop_rigid_crbody.tcl` — thuộc property rigid CRB body, ý nghĩa tham số chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_rigid_crbody.tcl:92:  *rigidscombine 1 0;
```

---

### *rigidwall_geometry

- **Signature**: `*rigidwall_geometry $entName $geometry_type $basenode $dir_x $dir_y $dir_z $lengthx $lengthy $lengthz` — 9 tham số, ví dụ `*rigidwall_geometry $entName 2 $basenode 1 0 0 $lengthx $lengthx $lengthz` và `*rigidwall_geometry $entName $geometry $basenode 1 0 0 $lengthx $lengthy $lengthz`.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong HyperStudy LS-DYNA/RADIOSS export (`hslsdyna.tcl`, `hsradioss.tcl`) — tạo hình học rigidwall cho solver export; cũng có callback đăng ký `AddCallback *rigidwall_geometry ...UpdateAttributesForRigidWalls` trong browser, xác nhận đây là entity rigidwall geometry.
- **Confidence**: LOCAL-INSTALL

```tcl
./browser/bringUpthePopUp.tcl:2489:        AddCallback *rigidwall_geometry ::solverBrowser::contextSensitiveMenu::UpdateAttributesForRigidWalls
./HyperStudy/hslsdyna.tcl:901:				*rigidwall_geometry $entName 2 $basenode 1 0 0 $lengthx $lengthx $lengthz;
./HyperStudy/hsradioss.tcl:453:				*rigidwall_geometry $entName 2 $basenode 1 0 0 $lengthx $lengthx $lengthz;
```

---

### *savefailedsurfstomark

- **Signature**: `*savefailedsurfstomark 1` (1 tham số, mark id).
- **Return shape**: side-effect.
- **Precondition/side-effect**: chỉ 1 lần dùng, trong `br/views/meshcontrols/operations/optional.tcl` — thuộc mesh controls, lưu các surface lỗi (failed mesh) vào 1 mark.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/meshcontrols/operations/optional.tcl:60:  *savefailedsurfstomark 1
```

---

### *setactiveplotcontrol

- **Signature**: `*setactiveplotcontrol $plot_type -1` — ví dụ `*setactiveplotcontrol contour -1`, `*setactiveplotcontrol vector -1`, `*setactiveplotcontrol tensor -1`, `*setactiveplotcontrol deformed -1`. Tham số 1: tên loại plot (string: contour/vector/tensor/deformed), tham số 2: luôn `-1` trong các lần quan sát.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `br/views/results/utils.tcl` và hmpost CallBacks — kích hoạt/tắt loại plot control kết quả (results post-processing).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/results/utils.tcl:157:        *setactiveplotcontrol $t -1
./EngineeringSolutions/aerospace/hmpost/CallBacks.tcl:84:            *setactiveplotcontrol contour -1
./EngineeringSolutions/aerospace/hmpost/CallBacks.tcl:89:            *setactiveplotcontrol vector -1
```

---

### *setcomponentdisplayattributes

- **Signature**: `*setcomponentdisplayattributes "<name_or_mark>" <mode> <flag>` — ví dụ `*setcomponentdisplayattributes "^faces" 2 1;`, `*setcomponentdisplayattributes "$newname" 2 1;`. 3 tham số: chuỗi tên component/mark reference (dùng `^faces` — cú pháp mark reference của HM), số mode, cờ.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong Abaqus dload, Contact Wizard autocontact/surface pages — thiết lập thuộc tính hiển thị cho component; ý nghĩa số mode/cờ chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/dload/dload_tab1.tcl:1850:                *setcomponentdisplayattributes "^faces" 2 1;
./abaqus/Contact_wizard/CWinterface/CWautocontact.tcl:315:      *setcomponentdisplayattributes "$newname" 2 1;
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1577:            *setcomponentdisplayattributes "^faces" 2 1;
```

---

### *setcurrentinclude

- **Signature**: `*setcurrentinclude <flag> "<include_name>"` hoặc `*setcurrentinclude $includeId` — quan sát cả 2 dạng: `*setcurrentinclude 0 "pos_[set pam_dummyName]"` (2 tham số) và `*setcurrentinclude $includeId` (1 tham số).
- **Return shape**: dùng trong `catch { *setcurrentinclude 0 "pos_..." } err` — không gán trực tiếp giá trị trả về, chỉ bắt lỗi.
- **Precondition/side-effect**: dùng trong LoadDummy/pampostohm (Abaqus dummy position) và AssemblyCrashApi — thiết lập include hiện hành theo tên hoặc theo id.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/pampostohm.tcl:94:    if { [catch { *setcurrentinclude 0 "pos_[set pam_dummyName]" } err] } {
./assemblytools/at/profiles/crash/api/AssemblyCrashApi.tcl:423:    *setcurrentinclude $includeId;
```

---

### *setelementcolormode

- **Signature**: `*setelementcolormode <mode>` — ví dụ `*setelementcolormode 10`, `*setelementcolormode 1`, `*setelementcolormode 2`. 1 tham số nguyên (mode code).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `br/common/operations/review.tcl` và DDP editor (certification) — đổi chế độ tô màu element trong review; giá trị mode cụ thể (1/2/10) chưa rõ ánh xạ ý nghĩa.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/review.tcl:174:        *setelementcolormode 10
./br/common/operations/review.tcl:176:        *setelementcolormode 1
./br/views/certification/operations/ddpeditperform.tcl:555:        *setelementcolormode 1 
```

---

### *setgraphicsengine

- **Signature**: `*setgraphicsengine 1` (1 tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: TẤT CẢ các lần xuất hiện trong batch đều bị comment (`#*setgraphicsengine 1;`) trong CWsurface/CWElsurpage2,3 và CWNodesurpage3 — không có bằng chứng lệnh này thực sự được thực thi trong code đang hoạt động, chỉ tồn tại dưới dạng code đã tắt.
- **Confidence**: LOCAL-INSTALL (chỉ tìm thấy dưới dạng comment)

```tcl
./abaqus/Contact_wizard/CWsurface/CWElsurpage2.tcl:258:    #*setgraphicsengine 1;
./abaqus/Contact_wizard/CWsurface/CWElsurpage3.tcl:135:    #*setgraphicsengine 1;
./abaqus/Contact_wizard/CWsurface/CWNodesurpage3.tcl:97:    #*setgraphicsengine 1;
```

---

### *sethistoryrecord

- **Signature**: `*sethistoryrecord <0|1>` — ví dụ `*sethistoryrecord 0`, `*sethistoryrecord 1`. 1 tham số on/off.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng theo cặp bật/tắt bao quanh 1 khối thao tác (`bomimport.tcl` dòng 281 = 0 rồi dòng 310 = 1; tương tự `create3dline.tcl`, `createconstraint.tcl`) — tắt ghi lịch sử undo trước khi thực hiện nhiều thao tác, bật lại sau khi xong.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/bomimport.tcl:281:    *sethistoryrecord 0
./br/views/modules/core/bomimport.tcl:310:    *sethistoryrecord 1
./context/src/snr/create3dline.tcl:69:    *sethistoryrecord 0
./context/src/snr/create3dline.tcl:83:    *sethistoryrecord 1
```

---

### *setmarkdisplayattributes

- **Signature**: `*setmarkdisplayattributes <entity_type> <mode> <value> <flag>` — ví dụ `*setmarkdisplayattributes components 2 0 1;`, `*setmarkdisplayattributes components 1 $value 1;`, `*setmarkdisplayattributes $type 1 $value 1`. 4 tham số: entity type keyword (thường `components`), mode, giá trị, cờ.
- **Return shape**: side-effect, có lần gọi qua `eval`.
- **Precondition/side-effect**: dùng trong ACM Acoustic Mesh GUI, `br/common/operations/festyle.tcl`, NVH seabeam/seaduct — thiết lập thuộc tính hiển thị cho mark hiện hành theo loại entity.
- **Confidence**: LOCAL-INSTALL

```tcl
./ACM/hmAcousticMeshGUI.tcl:689:        eval *setmarkdisplayattributes components 2 0 1;
./br/common/operations/festyle.tcl:19:            *setmarkdisplayattributes $type 1 $value 1
./context/src/nvh/nvhseabeam.tcl:178:	*setmarkdisplayattributes components 1 1 1
```

---

### *setmarktopologydisplay

- **Signature**: `*setmarktopologydisplay <entity_type> <mode> <value>` — ví dụ `*setmarktopologydisplay $type 1 $value;`, `*setmarktopologydisplay components 1 1`. 3 tham số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `br/common/operations/geomstyle.tcl` và AirframeMesh — thiết lập hiển thị topology cho mark, tương tự `*setmarkdisplayattributes` nhưng thiếu cờ thứ 4.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/geomstyle.tcl:18:		*setmarktopologydisplay $type 1 $value;
./EngineeringSolutions/aerospace/AirframeMesh/AirframeMesh.tcl:1422:	*setmarktopologydisplay components 1 1
```

---

### *setnormalsdisplaytype

- **Signature**: `*setnormalsdisplaytype 0` (1 tham số, chỉ thấy giá trị 0 trong toàn bộ batch).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong Contact Wizard, Renumber_tool (cont_shell.tcl), ANSYS ContactManager — tắt hiển thị normal (giá trị 0 = off), chưa thấy giá trị khác trong source để xác nhận cờ bật.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWElsurpage2.tcl:186:		*setnormalsdisplaytype 0
./abaqus/Renumber_tool/cont_shell.tcl:106:	*setnormalsdisplaytype 0
./ansys/ContactManager/contactpair/contact_target_normal_dialog.tcl:191:        *setnormalsdisplaytype 0
```

---

### *setoffsetconflictoptionmessage

- **Signature**: `*setoffsetconflictoptionmessage <0|1>` — ví dụ `*setoffsetconflictoptionmessage 1`, `*setoffsetconflictoptionmessage 0`. 1 tham số on/off.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `organizeentites.tcl` và `organize_include.tcl` — bật/tắt hiển thị message cảnh báo xung đột offset khi organize include/entity.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/organizeentites.tcl:233:    *setoffsetconflictoptionmessage 1
./br/common/operations/organizeentites.tcl:296:                        *setoffsetconflictoptionmessage 0
./browser/organize_include.tcl:710:	*setoffsetconflictoptionmessage 1
```

---

### *setqualitycriteria

- **Signature**: `*setqualitycriteria 1 14 0` (3 tham số nguyên) — quan sát giống hệt trong cả 2 file dùng.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `cfd/AcuSolve_Generate_Mapping.tcl` và ModelCheck Nastran MSC ValidationChecks — thiết lập tiêu chí chất lượng mesh (criteria id 14?), ý nghĩa từng tham số chưa xác định rõ.
- **Confidence**: LOCAL-INSTALL

```tcl
./cfd/AcuSolve_Generate_Mapping.tcl:61:*setqualitycriteria 1 14 0
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:36:    *setqualitycriteria 1 14 0
```

---

### *setreviewbymark

- **Signature**: `*setreviewbymark <entity_type> <mark_or_mode> <color>` — ví dụ `*setreviewbymark $entity $maskmark $secondarycolor;`, `*setreviewbymark elems 1 3;`, `*setreviewbymark nodes 1 6;`. 3 tham số: entity type keyword (elems/nodes/hoặc biến), mode/mark, màu.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong AbaqusStep, Contact Wizard autocontact_tab, CW.tcl — tô màu review cho entity theo mark.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1743:        *setreviewbymark $entity $maskmark $secondarycolor;
./abaqus/Contact_wizard/autocontact_tab.tcl:639:    *setreviewbymark elems 1 3;
./abaqus/Contact_wizard/CW.tcl:2280:                    *setreviewbymark nodes 1 6;
```

---

### *setreviewcolormode

- **Signature**: `*setreviewcolormode <mode>` — ví dụ `*setreviewcolormode $::AbaqusStep::reviewGreycolorType;`, `*setreviewcolormode 1;`. 1 tham số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng cùng nhóm review AbaqusStep/Contact Wizard — thiết lập chế độ màu review (biến tên gợi ý "grey color type").
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1741:        *setreviewcolormode $::AbaqusStep::reviewGreycolorType;
./abaqus/Contact_wizard/autocontact_tab.tcl:370:  *setreviewcolormode 1;
```

---

### *setreviewmode

- **Signature**: `*setreviewmode 1` (1 tham số, chỉ thấy giá trị 1 trong batch).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng cùng cụm review AbaqusStep/Contact Wizard, luôn kèm `*setreviewcolormode`, `*setreviewtransparentmode`, `*setreviewbymark` — bật chế độ review.
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1744:        *setreviewmode 1;
./abaqus/Contact_wizard/autocontact_tab.tcl:647:  *setreviewmode 1;
./abaqus/Contact_wizard/autocontact_tab.tcl:2736:    *setreviewmode 1;
```

---

### *setreviewtransparentmode

- **Signature**: `*setreviewtransparentmode <mode_or_var>` — ví dụ `*setreviewtransparentmode $::AbaqusStep::reviewTransparencyType;`, `*setreviewtransparentmode 0;`. 1 tham số.
- **Return shape**: side-effect.
- **Precondition/side-effect**: cùng cụm review AbaqusStep/Contact Wizard — bật/tắt chế độ trong suốt khi review (biến tên "reviewTransparencyType" xác nhận ý nghĩa transparency).
- **Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/abaqusstep.tcl:1742:        *setreviewtransparentmode $::AbaqusStep::reviewTransparencyType;
./abaqus/AbaqusStep/abaqusstep.tcl:1830:    *setreviewtransparentmode 0;
./abaqus/Contact_wizard/autocontact_tab.tcl:369:  *setreviewtransparentmode 0;
```

---

### *setsimulationstep

- **Signature**: `*setsimulationstep <subcase_id> <sim_id>` — ví dụ `*setsimulationstep $ids $sim`, `*setsimulationstep $hm_subc_id $ids`, `*setsimulationstep -1 -1`, `*setsimulationstep [lindex $all_subs 0] [lindex $all_sims 0]`. 2 tham số: subcase/simulation index.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `br/common/operations/makecurrent.tcl` và `br/views/results/utils.tcl` — thiết lập bước simulation hiện hành cho results post-processing; `-1 -1` dùng để reset/không chọn.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/makecurrent.tcl:61:            *setsimulationstep $ids $sim
./br/views/results/utils.tcl:154:    *setsimulationstep -1 -1
./br/views/results/utils.tcl:182:                    *setsimulationstep [lindex $all_subs 0] [lindex $all_sims 0]
```

---

### *setsurfacenormalsdisplaytype

- **Signature**: `*setsurfacenormalsdisplaytype 0` (1 tham số, chỉ thấy giá trị 0 trong batch).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng lặp lại nhiều lần trong `br/views/autocontact/common/operations/displayelementsnormals.tcl` — tắt hiển thị normal của surface trong autocontact.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/displayelementsnormals.tcl:64:							*setsurfacenormalsdisplaytype 0
./br/views/autocontact/common/operations/displayelementsnormals.tcl:81:							*setsurfacenormalsdisplaytype 0
./br/views/autocontact/common/operations/displayelementsnormals.tcl:129:								*setsurfacenormalsdisplaytype 0
```

---

### *showall

- **Signature**: `*showall` (không tham số).
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong `br/views/partinstance/assembly/init.tcl` (active) và bị comment ở `enggbr/main/init.tcl`, `partinstance/main/init.tcl`; cũng trong `context/src/show_hide.tcl` — hiển thị lại toàn bộ entity đang ẩn (show all).
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/partinstance/assembly/init.tcl:30:    *showall
./context/src/show_hide.tcl:754:    *showall
```

---

### *simulationtitleon

- **Signature**: `*simulationtitleon <0|1>` — ví dụ `*simulationtitleon 1`, `*simulationtitleon 0;`. 1 tham số on/off.
- **Return shape**: side-effect.
- **Precondition/side-effect**: dùng trong HyperForm (`hf_proc.tcl`) và ModelCheckerFramework element checks (aspectcheck, elementsizecheck, jacobiancheck) — bật/tắt hiển thị tiêu đề simulation, ModelCheck tắt nó (0) trước khi chạy check để tránh nhiễu hiển thị.
- **Confidence**: LOCAL-INSTALL

```tcl
./hyperform/hf_proc.tcl:1277:	*simulationtitleon 1
./ModelCheckerFramework/elementcheck/aspectcheck.tcl:192:	*simulationtitleon 0;
./ModelCheckerFramework/elementcheck/elementsizecheck.tcl:192:	*simulationtitleon 0;
```

---

### *solid_untrim

- **Signature**: `*solid_untrim 1 1` (2 tham số, luôn `1 1` trong toàn bộ batch).
- **Return shape**: side-effect, thường bọc `catch { ... }`.
- **Precondition/side-effect**: dùng trong `br/common/operations/delete.tcl`, `featuremanager/operations/areadelete.tcl` (một số bị comment), `UserProfiles/HyperWorksCFD.tcl` — hoàn tác trim của solid (untrim), thường gọi trước khi xóa/resize feature.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/delete.tcl:587:                *solid_untrim 1 1
./br/views/featuremanager/operations/areadelete.tcl:74:    catch { *solid_untrim 1 1 }
./UserProfiles/HyperWorksCFD/HyperWorksCFD.tcl:2363:    catch { *solid_untrim 1 1 }
```

---

### *solids_create_from_surfaces

- **Signature**: `*solids_create_from_surfaces <mode> <param2> -1 <param4>` — ví dụ `*solids_create_from_surfaces 1 0 -1 2`, `*solids_create_from_surfaces 1 4 -1 2`, `*solids_create_from_surfaces 1 4 -1 1`. 4 tham số, tham số 3 luôn `-1` trong batch.
- **Return shape**: side-effect (tạo entity solid mới từ surface hiện hành/mark).
- **Precondition/side-effect**: dùng trong `br/views/cfdpartbrowser/operations/createsolid.tcl`, `HyperMold/Moldflow/draw_element.tcl`, `nvh/assembler/seam/xml_reader/vol_batch.tcl` — tạo solid từ tập surface (mark) đang chọn; ý nghĩa chi tiết từng tham số chưa xác định.
- **Confidence**: LOCAL-INSTALL

```tcl
./br/views/cfdpartbrowser/operations/createsolid.tcl:30:    *solids_create_from_surfaces 1 0 -1 2
./HyperMold/Moldflow/draw_element.tcl:749:    *solids_create_from_surfaces 1 4 -1 2
./nvh/assembler/seam/xml_reader/vol_batch.tcl:228:        *solids_create_from_surfaces 1 4 -1 1
```


### *splitcontactfromcontactgroup

**Signature**: `*splitcontactfromcontactgroup $grp_id`

**Return shape**: side-effect (no captured return value observed).

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi (dùng trong nhiều branch xử lý contact group trong properties.tcl).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/common/contacts/properties.tcl:211:        *splitcontactfromcontactgroup $grp_id
./br/views/common/contacts/properties.tcl:224:        *splitcontactfromcontactgroup $grp_id
./br/views/common/contacts/properties.tcl:246:        *splitcontactfromcontactgroup $grp_id
```

---

### *start_batch_import

**Signature**: `*start_batch_import $mode`

**Return shape**: side-effect.

**Precondition/side-effect**: comment tại workflows.tcl cho biết `mode` là một chế độ định danh (giá trị số, ví dụ `2` dùng trong import_fe.tcl và matlib/utils.tcl); chưa xác định ý nghĩa từng giá trị vì comment bị cắt trong đoạn trích.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/modules/core/workflows.tcl:2291:  #*start_batch_import <mode>, where mode is:
./br/views/modules/core/workflows.tcl:2311:      *start_batch_import $mode
./hwct/matlib/utils.tcl:337:    *start_batch_import 2
./ImportExport/import_fe.tcl:408:    *start_batch_import 2
```

---

### *startnotehistorystate

**Signature**: `*startnotehistorystate "<label string>"`

**Return shape**: side-effect.

**Precondition/side-effect**: dùng để mở một "note" trong undo history stack với tên hiển thị (label); phải đóng lại bằng `*endnotehistorystate` cùng label (thấy cặp `*startnotehistorystate "Volume Mesh"` ... `*endnotehistorystate "Volume Mesh"` trong mesh.tcl). Thường đi kèm `hm_private_frwk enablehistoryfromtcl 1` trước đó.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/create_cards.tcl:1053:		*startnotehistorystate "Created set \"$entityName\""
./br/common/operations/create.tcl:112:            *startnotehistorystate "Created View \"View$no\""
./br/views/meshcontrols/operations/mesh.tcl:428:    *startnotehistorystate "Volume Mesh"
```

---

### *swapcards

**Signature**: `*swapcards GROUPS 1;` hoặc `*swapcards GROUPS 1 $new_card_image;`

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa của literal `GROUPS` và `1` (không có comment giải thích trong 2 file trích); tham số thứ 3 tùy chọn là tên "card image" mới khi có.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/swapCpTie.tcl:158:        *swapcards GROUPS 1;
./br/views/common/contacts/properties.tcl:259:    *swapcards GROUPS 1 $new_card_image;
```

---

### *swapcontactmainsecondary

**Signature**: `*swapcontactmainsecondary 1;`

**Return shape**: side-effect.

**Precondition/side-effect**: comment trong swapMainSecondary.tcl (dòng 218: "Please re-write this feature in *swapcontactmainsecondary in cmd177b.cxx") cho thấy đây là API mới thay thế logic cũ swap main/secondary của contact; ý nghĩa tham số `1` chưa xác định (không có ngữ cảnh biến).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/autocontact/common/operations/createSymmetryContact.tcl:97:        *swapcontactmainsecondary 1;
./br/views/autocontact/common/operations/swapMainSecondary.tcl:211:        *swapcontactmainsecondary 1;
./br/views/autocontact/common/operations/swapMainSecondary.tcl:218:## Please re-write this feature in *swapcontactmainsecondary in cmd177b.cxx
```

---

### *systemcreate

**Signature**: `*systemcreate 1 $sysType $originnode $axis $axisnode $plane $planenode`

**Return shape**: side-effect (không thấy `set x [*systemcreate ...]` trong các dòng trích).

**Precondition/side-effect**: comment cạnh dòng (CWRigidsurface.tcl:618) `#set error [catch {*systemcreate3nodes ...}]` cho thấy `*systemcreate` và `*systemcreate3nodes` là hai lệnh khác nhau — không được nhầm lẫn. Tham số gồm: hằng số `1`, `$sysType`, node gốc (`$originnode`), tên trục (`$axis`, ví dụ chuỗi `"x-axis"`), node trên trục (`$axisnode`), tên mặt phẳng (`$plane`, ví dụ chuỗi `"xy plane"`), node trên mặt phẳng (`$planenode`); ý nghĩa chính xác của giá trị số `$sysType` chưa xác định.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AnalyticalRigid/ARSDialog.tcl:192:    set error [catch {*systemcreate 1 $sysType $originnode $axis $axisnode $plane $planenode}];
./abaqus/Contact_wizard/CWsurface/CWRigidsurface.tcl:1146:    set syst_error [catch {*systemcreate 1 1 $originnode "x-axis" $startnode "xy plane    " $endnode}];
./abaqus/Contact_wizard/CWsurface/CWRigidsurface.tcl:1147:    #*systemcreate3nodes 1 $originnode "x-axis" $startnode "xy plane    " $endnode;
```

---

### *systemsetanalysis

**Signature**: `*systemsetanalysis nodes 1 $sysref` (dạng khác: `*systemsetanalysis nodes 2 $sys_id`)

**Return shape**: side-effect.

**Precondition/side-effect**: literal đầu tiên là entity type ("nodes"); tham số thứ 2 (`1` hoặc `2`) thay đổi theo ngữ cảnh — chưa xác định ý nghĩa chính xác của giá trị này (không có comment).

**Confidence**: LOCAL-INSTALL

```tcl
./connectors/connectors.tcl:900:        if { $analysis } { catch {*systemsetanalysis nodes 1 $sysref;} }
./connectors/prop_hinge.tcl:69:       *systemsetanalysis nodes 1 $feInfoArr($ce_id:sysID)
./connectors/prop_opt_nas_hilock.tcl:780:  *systemsetanalysis nodes 2 $sys_id
```

---

### *systemsetreference

**Signature**: `*systemsetreference systems 2 $refSys` hoặc `*systemsetreference systems 1 $someSysId` hoặc `*systemsetreference nodes 1 $sysId`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số đầu là entity type liên quan ("systems" hoặc "nodes"); ý nghĩa số `1`/`2` chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:1338:		      *systemsetreference systems 2 $refSys
./abaqus/dummypos/tclincludes/dummyproc.tcl:639:                     *systemsetreference systems 1 [lindex $systemList 0]
./abaqus/dummypos/tclincludes/dummyproc.tcl:1027:                *systemsetreference nodes 1 $sysId
```

---

### *tableaddcolumn

**Signature**: `*tableaddcolumn $tablename designpoints "$column1" 1 $nrows` / `*tableaddcolumn $tablename elements "$column1" 1 $nrows` / `*tableaddcolumn $tablename double "$column2" 1 $nrows`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số thứ 2 là kiểu cột (`designpoints`, `elements`, `double` quan sát được là các giá trị hợp lệ); tham số cuối `$nrows` khớp với số dòng của bảng đã tạo bằng `*tablecreate` trước đó (esacompcontour.tcl dùng chung `$temptablename`).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/esacompcontour.tcl:536:					*tableaddcolumn $temptablename designpoints "$column1" 1 $nrows
./br/views/certification/operations/esacompcontour.tcl:538:					*tableaddcolumn $temptablename elements "$column1" 1 $nrows
./br/views/certification/operations/esacompcontour.tcl:541:				*tableaddcolumn $temptablename double "$column2" 1 $nrows
```

---

### *tableaddrow

**Signature**: `*tableaddrow $table_name 1 $count` (ví dụ `[llength $lst_values]` hoặc số cứng như `3`, `1`, `5`)

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa chính xác của `1` và `$count`; quan sát được `$count` thường bằng số phần tử cần thêm (`[llength $lst_values]`).

**Confidence**: LOCAL-INSTALL

```tcl
./context/src/hyperlifeWC/LoadCase.tcl:391:		*tableaddrow $_HM_LC_table 1 [llength $lst_values]
./ddam/spec_setup.tcl:2289:			*tableaddrow $table_name 1 3
./EngineeringSolutions/aerospace/f06_Parser/f06_Parser.tcl:684:    *tableaddrow $tableName 1 1
```

---

### *tablecontour

**Signature**: `*tablecontour $tablename $column1 $column2 "$column1 VS $column2"`

**Return shape**: side-effect (tạo/hiển thị contour plot từ dữ liệu bảng, dựa theo tên hàm và cách dùng liên tiếp sau `*tablecreate`/`*tableaddcolumn`).

**Precondition/side-effect**: cần bảng đã tồn tại (`$tablename`) với các cột `$column1`, `$column2` đã được thêm trước đó qua `*tableaddcolumn`; tham số thứ 4 là tiêu đề/label.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/esacompcontour.tcl:551:			*tablecontour $temptablename $column1 $column2 "$column1 VS $column2"
./br/views/composite/operations/drapeestimator_perform.tcl:1285:			*tablecontour $review_tblname ElemId "Drape Thickness" "Drape Thickness"
./br/views/composite/operations/drapeestimator_perform.tcl:1333:			*tablecontour $review_tblname ElemId Orientation Orientation
```

---

### *tablecreate

**Signature**: `*tablecreate "attachedelementtable" 1 1 1 6;` hoặc `*tablecreate $temptablename 3 1 1 0 0`

**Return shape**: side-effect.

**Precondition/side-effect**: comment tại autocontact_tab.tcl:1670 xác nhận: "table must be created with 6 integer columns using the *tablecreate command" — trong ví dụ đó tham số cuối `6` là số cột kiểu integer. Ý nghĩa đầy đủ các tham số vị trí khác (giữa tên bảng và số cột) chưa xác định rõ ràng từ comment.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/autocontact_tab.tcl:1670:  #Returns information to a table about solid elements attached to quad/tria element.  The table must be created with 6 integer columns using the *tablecreate command.  The output to each column is as follows:
./abaqus/Contact_wizard/autocontact_tab.tcl:1691:  *tablecreate "attachedelementtable" 1 1 1 6;
./br/views/certification/operations/esacompcontour.tcl:532:				*tablecreate $temptablename 3 1 1 0 0
```

---

### *tableexport

**Signature**: `*tableexport $tablename $selectedFile ","` (dấu phân cách có thể là `","` hoặc `";"`)

**Return shape**: side-effect (ghi file ra `$selectedFile`).

**Precondition/side-effect**: tham số 3 là ký tự phân cách cột khi xuất (đã quan sát cả `,` và `;`).

**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/exporttable.tcl:36:				*tableexport $tablename $selectedFile ","
./br/common/operations/exporttable.tcl:38:				*tableexport $tablename $selectedFile ";"
```

---

### *tableinsertcolumn

**Signature**: `*tableinsertcolumn $tableName "string" "ply" 1 $plyCount 1` / `*tableinsertcolumn $tableName "triple" "points" 1 $pointCount $columnIndex`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số 2 là kiểu dữ liệu cột (`"string"`, `"triple"` quan sát được); tham số 3 là tên cột; các tham số số chưa xác định đầy đủ ý nghĩa (có thể liên quan tới range hàng và vị trí chèn cột) — không có comment rõ ràng.

**Confidence**: LOCAL-INSTALL

```tcl
./entities/hmPlyRealization.tcl:365:    *tableinsertcolumn $tableName "string" "ply" 1 $plyCount 1
./entities/hmPlyRealization.tcl:382:                *tableinsertcolumn $tableName "triple" "points" 1 $pointCount $columnIndex
```

---

### *tableupdatecell

**Signature**: `*tableupdatecell $tablename 1 $colno $newvalue`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số 2 (`1`, hoặc `$row`) là chỉ số hàng, `$colno` là chỉ số cột, tham số cuối là giá trị mới ghi vào ô.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/methodassign_classic.tcl:230:	*tableupdatecell $tablename 1 $colno $newvalue 
./entities/createTableDlgFuncs.tcl:115:				*tableupdatecell [set ::collectordlg::${ns}::strEntityName] $row $tableColsarr($tmp_col) $value;
./entities/hmPlyRealization.tcl:377:                *tableupdatecell $tableName $index 1 $item
```

---

### *tableupdatecolumn

**Signature**: `*tableupdatecolumn $tablename 1 $coltype 0 "" 1 [llength $coldata] $col` (dạng khác: `*tableupdatecolumn $review_tblname 1 elements 1 ElemId 1 $len 1`)

**Return shape**: side-effect.

**Precondition/side-effect**: quan sát được tham số bao gồm loại cột (`elements`, `float`), tên cột (`ElemId`), phạm vi hàng (`1` đến `$len`), và chỉ số cột đích ở cuối; ý nghĩa chính xác từng vị trí số chưa xác định đầy đủ (không có comment giải thích tham số theo tên).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/certification/operations/Common.tcl:175:    *tableupdatecolumn $::MatrixBrowser::active_table_name 1 $coltype 0 "" 1 [llength $coldata] $col
./br/views/composite/operations/drapeestimator_perform.tcl:1264:		*tableupdatecolumn $review_tblname 1 elements 1 ElemId 1 $len 1
./br/views/composite/operations/drapeestimator_perform.tcl:1266:		*tableupdatecolumn $review_tblname 1 float 1 ElemId 1 $len 2
```

---

### *tagcreate

**Signature**: `*tagcreate elems $id $face_i "a$id" $color_i;` hoặc `*tagcreate nodes $pretenNodeid "Pretension_Node_$pretenNodeid" "" 5;`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số 1 là entity type (`elems`, `nodes`); với `elems` có thêm tham số face index (`$face_i`) trước tên tag; tham số cuối là màu (color index, ví dụ `5`) — quan sát được từ literal số ở vị trí cuối cùng đi cùng comment "Pretension_Node" gợi ý màu hiển thị.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/AbaqusStep/load/dload/dload_tab1.tcl:2051:                *tagcreate elems $id $face_i "a$id" $color_i;
./abaqus/Contact_wizard/CWinterface/CWpretension1.tcl:831:            *tagcreate nodes $pretenNodeid "Pretension_Node_$pretenNodeid" "" 5;
```

---

### *tetmesh

**Signature**: `*tetmesh meshcontrol 1 -1 $ent_type 2 15 1 0` (dạng khác: `*tetmesh components 1 9 elements 0 -1 1 2;`)

**Return shape**: side-effect (dùng trong `catch {*tetmesh ...} err`, không capture giá trị trả về có ý nghĩa ngoài mã lỗi catch).

**Precondition/side-effect**: phải bao trong `*startnotehistorystate "Volume Mesh"` ... `*endnotehistorystate "Volume Mesh"` theo ngữ cảnh trực tiếp thấy trong mesh.tcl (dòng 428 ngay trước, dòng 439 ngay sau khối if/elseif). Tham số đầu là loại nguồn mesh (`meshcontrol` hoặc `components`).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/meshcontrols/operations/mesh.tcl:428:    *startnotehistorystate "Volume Mesh"
./br/views/meshcontrols/operations/mesh.tcl:436:    } elseif {[catch {*tetmesh meshcontrol 1 -1 $ent_type 2 15 1 0} err] == 0} { 
./br/views/modules/core/batchmesher/batchmesher_callbacks.tcl:68:    *tetmesh components 1 9 elements 0 -1 1 2;
```

---

### *translatemark

**Signature**: `*translatemark nodes 1 1 $dist;` hoặc `*translatemark systems 1 1 $mag`

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa của hai tham số `1 1` (không có comment); yêu cầu mark đã được set trước (theo quy ước tên lệnh "mark"), tham số cuối là khoảng dịch chuyển. Lưu ý: có lệnh khác biệt `*translatemarkwithsystem` xuất hiện gần đó — không được nhầm lẫn hai lệnh.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWinterface/CWpretension1.tcl:1519:    *translatemark nodes 1 1 $dist;
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:357:    eval *translatemarkwithsystem systems 1 1 $mag $refSys [hm_getentityvalue systems $refSys "originnodeid" 0]
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:359:    eval *translatemark systems 1 1 $mag
```

---

### *unlockallentities

**Signature**: `*unlockallentities $entitytype $poolnumber id;`

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định — chỉ biết lệnh tồn tại và cú pháp gọi (dùng trong module idmgr/operations/lock.tcl, ngữ cảnh liên quan tới ID pool).

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/lock.tcl:208:        *unlockallentities $entitytype $poolnumber id;
```

---

### *unmaskall

**Signature**: `*unmaskall;` (không tham số)

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định chi tiết — dựa theo tên lệnh và các dòng bị comment cạnh nhau (`#*unmaskall;`) trong cùng bối cảnh contact wizard, có thể liên quan tới việc bỏ mask toàn bộ entities đang ẩn; không có comment trực tiếp xác nhận.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWinterface/CWautocontact.tcl:675:    *unmaskall;
./abaqus/Contact_wizard/CWsurface/CWElsurpage1.tcl:1600:    *unmaskall;
./abaqus/Contact_wizard/CWsurface/CWElsurpage2.tcl:280:    #*unmaskall;   
```

---

### *unmaskentitymark

**Signature**: `*unmaskentitymark elems 1` / `*unmaskentitymark components 1 0;` / `*unmaskentitymark comps 1 0;`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số 1 là entity type (`elems`, `components`, `comps`); tham số 2 là mark id; tham số 3 tùy chọn (`0` quan sát được) chưa xác định ý nghĩa.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/abaquscontactcomparison.tcl:295:		*unmaskentitymark elems 1
./abaqus/AbaqusStep/abaqusstep.tcl:2490:        *unmaskentitymark components 1 0;
./abaqus/Contact_wizard/autocontact_tab.tcl:765:    *unmaskentitymark comps 1 0;
```

---

### *unrealizeengineeringentities

**Signature**: `*unrealizeengineeringentities $type 1 0;` (dạng khác: `*unrealizeengineeringentities mass $markid`)

**Return shape**: side-effect (dùng trong `catch {![*unrealizeengineeringentities mass $markid]}` — biểu thức có vẻ dùng giá trị trả về qua `!`, nhưng cách viết `catch {![...]}` là bất thường; ghi nhận nguyên văn, không suy diễn thêm).

**Precondition/side-effect**: `init.tcl` liệt kê `*unrealizeengineeringentities` cùng nhóm các lệnh callback được theo dõi qua `::hwt::AddCallback`/`RemoveCallback` để cập nhật tổng khối lượng (mass) sau khi "un-realize" các entity kỹ thuật (engineering entities) như mass.

**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/engentityoperations.tcl:25:        *unrealizeengineeringentities $type 1 0;
./br/views/mass/init.tcl:523:    ::hwt::AddCallback *unrealizeengineeringentities ::mass::updatemasstotal;
./br/views/mass/operations/commonoperations.tcl:147:    catch {![*unrealizeengineeringentities mass $markid]}
```

---

### *updatehfconstraint

**Signature**: `*updatehfconstraint "XY_CONSTRAINTS" 3 0 0 2`

**Return shape**: side-effect.

**Precondition/side-effect**: chưa xác định ý nghĩa các tham số số; literal `"XY_CONSTRAINTS"` xuất hiện giống nhau ở cả 3 file (composite draping context), gợi ý đây là identifier cố định cho loại constraint, không phải biến tùy chỉnh.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/composite/operations/drapeestimator_perform.tcl:359:		*updatehfconstraint "XY_CONSTRAINTS" 3 0 0 2
./context/src/composites/drape.tcl:432:        *updatehfconstraint "XY_CONSTRAINTS" 3 0 0 2
./entities/hmPlyDraping.tcl:219:		*updatehfconstraint "XY_CONSTRAINTS" 3 0 0 2
```

---

### *updatehmdb

**Signature**: `*updatehmdb beamsects 1;`

**Return shape**: side-effect.

**Precondition/side-effect**: trong functions.tcl, lệnh này được gọi ngay sau `*createmark beamsects 1 $beamsectionId;` — tức là dùng mark vừa tạo trên entity type `beamsects` để báo cho HyperMesh database cập nhật lại (refresh) sau khi tạo beam section mới bằng `*beamsectioncreatestandardsolver`.

**Confidence**: LOCAL-INSTALL

```tcl
./ansys/ansysbrowser/section/edit/functions/functions.tcl:314:  *createmark beamsects 1 $beamsectionId;
./ansys/ansysbrowser/section/edit/functions/functions.tcl:315:  *updatehmdb beamsects 1;
./br/common/operations/importcsv.tcl:45:    *updatehmdb beamsects 1
```

---

### *updateidrange

**Signature**: `*updateidrange $submodeltype $id "" $entityName $min $max $poolnumber 1 0` (dạng khác: `*updateidrange "submodel" $id "" "$type" $min $max $pool 1 0`)

**Return shape**: side-effect (luôn bọc trong `catch {...}`).

**Precondition/side-effect**: tham số 1 là loại submodel/pool context (`submodel`); tham số 3 để trống (`""`) trong tất cả các lần gọi quan sát được — ý nghĩa chưa xác định; `$min`/`$max` là khoảng ID; hai tham số cuối `1 0` chưa xác định ý nghĩa.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/idmgr/operations/edit.tcl:171:    catch {*updateidrange submodel $_iid "" $entities $newmin $newmax $poolnumber 1 0} err
./br/views/idmgr/operations/exclusion.tcl:91:    catch {*updateidrange submodel $iid "" $entities $min $max $poolnumber 1 0} err
./br/views/idmgr/operations/importexport.tcl:228:				*updateidrange "submodel" $id "" "$type" $min $max $pool 1 0
```

---

### *updateinclude

**Signature**: `*updateinclude $includeid 0 "0" 1 "$file" 0 0` (dạng khác: `*updateinclude $id 1 "$value" 1 "$includeFullName" 0 0`)

**Return shape**: side-effect (dòng thứ 2 gọi qua `eval [list *updateinclude ...]` trong `catch`).

**Precondition/side-effect**: dùng để cập nhật thông tin include file (bao gồm đường dẫn `$file`/`$includeFullName`); các tham số số (`0`, `1`) chưa xác định ý nghĩa cụ thể.

**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/includepath.tcl:15:        *updateinclude $includeid 0 "0" 1 "$file" 0 0
./br/common/operations/rename.tcl:59:                    if {[catch {eval [list *updateinclude $id 1 "$value" 1 "$includeFullName" 0 0]} err]} { set ret false }
```

---

### *updateincludedata

**Signature**: `*updateincludedata 0 "$shortname" 1 0 1 $includeType 0 0;` (dạng khác: `*updateincludedata $includeid "" 0 0 1 $includeSolverTypeSelected 0 0`)

**Return shape**: side-effect.

**Precondition/side-effect**: LƯU Ý ĐÂY LÀ LỆNH KHÁC `*updateincludedata2` (không có hậu tố "2") — tham số đầu là include id (hoặc `0` trong AssemblyCrashApi.tcl), có tham số tên ngắn (`$shortname`) hoặc chuỗi rỗng `""`, và một tham số kiểu solver (`$includeType`/`$includeSolverTypeSelected`); ý nghĩa từng vị trí số còn lại chưa xác định.

**Confidence**: LOCAL-INSTALL

```tcl
./assemblytools/at/profiles/crash/api/AssemblyCrashApi.tcl:430:      *updateincludedata 0 "$shortname" 1 0 1 $includeType 0 0;
./br/common/operations/includetype.tcl:21:        if {[catch {*updateincludedata $includeid "" 0 0 1 $includeSolverTypeSelected 0 0}]} {
./browser/default_includes.tcl:556:                *updateincludedata $includeid "" 0 0 1 $includeSolverTypeSelected 0 0;
```

---

### *updateincludedata2

**Signature**: `*updateincludedata2 $iid "" 0 0 1 10 0 0` (dạng khác: `*updateincludedata2 $includeid "" 1 $expflag 1 $solverflag 0 0 1 0;`)

**Return shape**: side-effect.

**Precondition/side-effect**: khác với `*updateincludedata` (không có "2") ở số lượng tham số — bản "2" có nhiều tham số hơn (quan sát 8-10 tham số vs 8 tham số ở bản không có "2"), bao gồm cờ export (`$expflag`) và cờ solver (`$solverflag`) theo tên biến quan sát được trong default_includes.tcl. Không được dùng lẫn hai lệnh này.

**Confidence**: LOCAL-INSTALL

```tcl
./br/common/operations/transforminclude.tcl:77:                *updateincludedata2 $iid "" 0 0 1 10 0 0
./browser/default_includes.tcl:601:    *updateincludedata2 $includeid "" 1 $expflag 1 $solverflag 0 0 1 0;
./createtreectrl.tcl:2794:           *updateincludedata2 $includeId "" 1 1 0 0 0 0 0 0;
```

---

### *updateoptimizationentitiesafterdelete

**Signature**: `*updateoptimizationentitiesafterdelete;` (không tham số)

**Return shape**: side-effect.

**Precondition/side-effect**: gọi sau khi xóa entity trong bảng dialog optimization (ansysbrowser ettype/mat/real table dialogs) — tên lệnh và vị trí gọi (trong dialog.tcl của các bảng ettype/mat/real) gợi ý mục đích đồng bộ lại các optimization entities sau delete.

**Confidence**: LOCAL-INSTALL

```tcl
./ansys/ansysbrowser/ettype/table/dialog/dialog.tcl:548:    *updateoptimizationentitiesafterdelete;
./ansys/ansysbrowser/mat/table/dialog/dialog.tcl:398:          *updateoptimizationentitiesafterdelete;
./ansys/ansysbrowser/real/table/dialog/dialog.tcl:479:          *updateoptimizationentitiesafterdelete;
```

---

### *updatepositions

**Signature**: `*updatepositions 1`

**Return shape**: side-effect.

**Precondition/side-effect**: dùng trong `br/views/positiontransform/operations/undoredo.tcl` (module position transform undo/redo) — gợi ý lệnh này refresh vị trí sau một thao tác undo/redo; ý nghĩa tham số `1` chưa xác định.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/positiontransform/operations/undoredo.tcl:21:    *updatepositions 1
./br/views/positiontransform/operations/undoredo.tcl:33:    *updatepositions 1
./context/src/positiontransform.tcl:229:				*updatepositions 1
```

---

### *vectorautoscale

**Signature**: `*vectorautoscale 1` hoặc `*vectorautoscale 0`

**Return shape**: side-effect.

**Precondition/side-effect**: dùng trong ModelValidationChecks.tcl cùng nhóm với `*vectorlabel` và `*vectordrawoptions` để cấu hình hiển thị vector trước khi vẽ (`*vectorcreate_twonode` gọi ngay sau đó trong cùng file) — tham số `0`/`1` là bật/tắt tự động scale (suy luận hợp lý từ tên lệnh "autoscale" kết hợp giá trị boolean 0/1, không có comment xác nhận rõ).

**Confidence**: LOCAL-INSTALL

```tcl
./EngineeringSolutions/aerospace/ImportGroundcheckForces/importgroundcheckforces.tcl:548:		*vectorautoscale 1
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:281:        *vectorautoscale 0;
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:325:        *vectorautoscale 0;
```

---

### *vectorcreate_twonode

**Signature**: `*vectorcreate_twonode $node1 $node2;`

**Return shape**: side-effect.

**Precondition/side-effect**: tạo vector hiển thị giữa 2 node (tên lệnh + 2 tham số node id là bằng chứng trực tiếp); dùng trong context vẽ vector kiểm tra rivet/model validation.

**Confidence**: LOCAL-INSTALL

```tcl
./femsite/rivet.tcl:630:			*vectorcreate_twonode $node1 $node2;
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:287:            *vectorcreate_twonode $node1 $node2;
./br/views/composite/operations/LTdrapeestimator_perform.tcl:648:                    *vectorcreate_twonode [lindex $::hm::LTplydraping::nodeList 0] [lindex $::hm::LTplydraping::nodeList 1]
```

---

### *vectordrawoptions

**Signature**: `*vectordrawoptions $normalsize 0 0;` (dạng khác: `*vectordrawoptions 10 1 0.0005;`)

**Return shape**: side-effect.

**Precondition/side-effect**: tham số 1 là kích thước vector (`$normalsize`/`10`) theo tên biến quan sát được; hai tham số còn lại chưa xác định ý nghĩa chính xác.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage2.tcl:188:            *vectordrawoptions $normalsize 0 0;
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:282:        *vectordrawoptions 10 1 0.0005;
```

---

### *vectorlabel

**Signature**: `*vectorlabel 0;` hoặc `*vectorlabel 1`

**Return shape**: side-effect.

**Precondition/side-effect**: giá trị 0/1 gợi ý bật/tắt label hiển thị trên vector (suy luận từ tên lệnh, không có comment xác nhận rõ).

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/Contact_wizard/CWsurface/CWRigidsurpage2.tcl:406:    *vectorlabel 0;
./EngineeringSolutions/aerospace/ImportGroundcheckForces/importgroundcheckforces.tcl:549:		*vectorlabel     1
./ModelCheck/Aerospace/NastranMSC/Checks_Corrections/ModelValidationChecks.tcl:280:        *vectorlabel 0;
```

---

### *vectorsoff

**Signature**: `*vectorsoff` (không tham số)

**Return shape**: side-effect.

**Precondition/side-effect**: dùng trong `context/src/composites/normals.tcl` và `MaterialOrientation.tcl` — tên lệnh gợi ý tắt hiển thị toàn bộ vectors (ví dụ normal vectors) trên màn hình; không có comment xác nhận thêm.

**Confidence**: LOCAL-INSTALL

```tcl
./context/src/composites/normals.tcl:99:	*vectorsoff
./EngineeringSolutions/aerospace/MaterialOrientation/MaterialOrientation.tcl:483:	*vectorsoff
./EngineeringSolutions/aerospace/MaterialOrientation/MaterialOrientation.tcl:527:	*vectorsoff
```

---

### *writeentitiestoxmlfile

**Signature**: `*writeentitiestoxmlfile type=mass mark=2 file=$::mass::exportPath`

**Return shape**: side-effect (ghi file XML ra `file=...`).

**Precondition/side-effect**: cú pháp dùng key=value inline (khác các lệnh khác dùng positional args) — `type=mass` chỉ loại entity export, `mark=2` là mark id, `file=` là đường dẫn xuất. Chỉ tìm thấy DUY NHẤT 1 lần dùng trong toàn bộ source.

**Confidence**: LOCAL-INSTALL

```tcl
./br/views/mass/init.tcl:203:    *writeentitiestoxmlfile type=mass mark=2 file=$::mass::exportPath
```

---

### *writefile

**Signature**: `*writefile $hmFile 1` (dạng khác: `*writefile "$str_file" 1;`)

**Return shape**: side-effect (ghi HM model file ra `$hmFile`/`$str_file`).

**Precondition/side-effect**: tham số 2 luôn là `1` trong tất cả các lần gọi quan sát được — ý nghĩa chính xác (có thể là cờ "save as binary"/"overwrite") chưa xác định vì không có comment.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/modules/ExportFiles.tcl:243:        *writefile $hmFile 1
./assemblytools/at/profiles/crash/api/AssemblyCrashApi.tcl:819:  *writefile "$str_file" 1;
./assemblytools/at/profiles/crash/browser/AssemblyCrashBrowser.tcl:877:  *writefile "$temp_hm_file" 1;
```

---

### *xyplotcreate

**Signature**: `*xyplotcreate $jointId ""` (dạng khác: `*xyplotcreate "curve_for_joint$joint" ""`)

**Return shape**: side-effect (gọi qua `eval`).

**Precondition/side-effect**: tham số 1 là tên/id của plot, tham số 2 là chuỗi rỗng `""` trong mọi lần quan sát được — ý nghĩa chưa xác định. LƯU Ý: có lệnh khác `*xyplotcreatecurve` xuất hiện gần các dòng này trong cùng file (abaqusDposProc.tcl) — không được nhầm `*xyplotcreate` với `*xyplotcreatecurve` hay `*xyplotcurvecreate`.

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:705:    eval *xyplotcreate $jointId \"\"
./abaqus/dummypos/tclincludes/pam2gDposProc.tcl:850:  eval *xyplotcreate "curve_for_joint$joint" \"\"
```

---

### *xyplotcurvecreate

**Signature**: `*xyplotcurvecreate "RW^^FN_$fn"`

**Return shape**: side-effect.

**Precondition/side-effect**: chỉ tìm thấy 2 lần dùng thật (1 lần khác bị comment `#*xyplotcurvecreate $NewName;` trong HMCurveEditor.tcl); tham số duy nhất quan sát được là tên curve. LƯU Ý tên lệnh này KHÁC với `*xyplotcreatecurve` (thứ tự từ "curve"/"create" đảo ngược) — đây là 2 lệnh riêng biệt, đã kiểm tra bằng grep chính xác từng chuỗi.

**Confidence**: LOCAL-INSTALL

```tcl
./connectors/prop_type2.tcl:1883:    *xyplotcurvecreate "RW^^FN_$fn"
./connectors/prop_type2.tcl:1896:    *xyplotcurvecreate "RW^^FS_$fs"
./HMCurveEditor.tcl:3220:    #*xyplotcurvecreate $NewName;
```

---

### *xyplotmodifycurve

**Signature**: `*xyplotmodifycurve "<curve_name>" "{x1,x2,...}" "" "" "" 1 "{y1,y2,...}" "" "" "" 1`

**Return shape**: side-effect.

**Precondition/side-effect**: tham số 1 là tên curve cần sửa (phải đã tồn tại); tham số 2 là chuỗi list giá trị X trong `{}`; ba tham số rỗng `"" "" ""` tiếp theo chưa xác định; `1` là (có thể) cờ; tham số 7 là chuỗi list giá trị Y; kết thúc lặp lại pattern `"" "" "" 1`. Cấu trúc lặp lại giống hệt nhau ở 5 vị trí khác nhau (connectors/*.tcl) cho thấy đây là API cố định, không suy đoán thêm ngoài các giá trị quan sát được.

**Confidence**: LOCAL-INSTALL

```tcl
./connectors/HC_HexaAdhesive_rad.tcl:63:  *xyplotmodifycurve "Adhesive_Solid_Material_YSvsNormalElong" "{ 0.0, 0.5, 1.0, 2.0 }" "" "" "" 1 "{ 0.05, 0.05, 0.0, 0 }" "" "" "" 1  
./connectors/HC_HexaSpotWeld_rad.tcl:57:  *xyplotmodifycurve "Solid Spotweld Tensile HC-Default" "{ 0.0, 10.0 }" "" "" "" 1 "{ 400.0, 400.0}" "" "" "" 1  
./connectors/prop_type2.tcl:1884:    *xyplotmodifycurve "RW^^FN_$fn" "{$fndisp1x,$fndisp2x,$fndisp3x,$fndisp4x,$fndisp5x,$fndisp6x,$fndisp7x,$fndisp8x,$fndisp9x}" "" "" "" 1 \
```

---

### *xyplotsetcurrent

**Signature**: `*xyplotsetcurrent "$plotname"` (dạng khác: `*xyplotsetcurrent "curve_for_joint$jointId"`, gọi qua `eval`)

**Return shape**: side-effect.

**Precondition/side-effect**: đặt plot/curve hiện hành theo tên (`$plotname`); dùng trước khi gọi các lệnh thao tác trên "current" plot (ví dụ liền kề `*xyplotmodifycurve`/`*xyplotcurvecreate` trong prop_type2.tcl).

**Confidence**: LOCAL-INSTALL

```tcl
./abaqus/dummypos/tclincludes/abaqusDposProc.tcl:1197:   eval *xyplotsetcurrent "curve_for_joint$jointId"
./connectors/prop_type2.tcl:1009:    *xyplotsetcurrent "$plotname"
./radioss/weld.tcl:2512:	    *xyplotsetcurrent "$plotname"
```
</content>

