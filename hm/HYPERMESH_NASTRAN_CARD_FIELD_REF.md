# HyperMesh Nastran Card Field Reference

Generated from the local Altair HyperMesh Nastran template files. This is intended for AI/API reference, not as a solver manual.

Verification status:

```text
OFFICIAL:
  Altair help confirms the general Data Names, Solver Templates, Query Commands,
  and Modify Commands mechanisms used to access/mutate HyperMesh data.

LOCAL-INSTALL:
  The detailed Nastran property/material/component/card/field inventory in this
  file is generated from local HyperMesh template/config files.

RUNTIME-TEST-NEEDED:
  Important field edits should be checked by exporting BDF and comparing the
  resulting Nastran cards.
```

Sources scanned:

```text
<ALTAIR_INSTALL_DIR>\templates\feoutput\nastran\general
<ALTAIR_INSTALL_DIR>\templates\feoutput\nastran\include
<ALTAIR_INSTALL_DIR>\templates\feoutput\common_nas_os
<ALTAIR_INSTALL_DIR>\templates\summary\nastran\include\attrib.lst
```

Summary: 41 direct property card definitions, 11 direct material card definitions, 60 group mappings.

## How To Use This

- `Card` is the HyperMesh card image name used with `hm_getcardimagename`, `*createentity ... cardimage=...`, or `*dictionaryload`.
- `Field` is the menu/export field label observed in the template.
- `Backing ref` is usually a HyperMesh attribute variable such as `$PSHELL_T`, or a dataname such as `id`, `materialid`, `propertyid`.
- `Attr` gives the `*defineattribute` symbol, numeric attribute ID, and type when the symbol was defined in `common_nas_os/attribs` or summary `attrib.lst`.
- Some material cards include optional subcards such as `MATS1`, `MATT1`, `MATEP`, `MATT8`, etc.; those appear as fields/options under the base material card because HyperMesh stores them in the same material card UI.
- Beam section cards have many expression fields from `beamsects`; prefer the `$...` backing attributes when editing persistent card data.

## Component Structure

Nastran components are generic collectors. The component itself exports core metadata and points to a property; the effective component type is inferred from the assigned property card.

Core component fields from `components.tpl`:

| Field | Meaning |
|---|---|
| `id` | component ID |
| `name` | component name |
| `propertyid` | assigned property/internal property ref |
| `internalpropertyid` | property ref used to read property name |
| `color` | HyperMesh color |
| `elements` | elements collected by component |

Component property category mapping from `$HMNAME COMP` logic in `components.tpl`:

| Property cards | Type code | Meaning |
|---|---:|---|
| `PMASS` | `1` | mass-like 0D property |
| `PBUSH PBUSH1D PVISC PDAMP PGAP PELAS PHBDY PCONVM` | `2` | springs/gaps/thermal property |
| `PBAR PBARL PBEAM PBEAML PBEND PROD PTUBE PWELD PBCOMP` | `3` | 1D beam/bar/rod/tube/weld property |
| `PSHELL PSHEAR PCOMP PCOMPG PSHELL1` | `4` | 2D shell/composite property |
| `PSOLID PLSOLID PCOMPLS` | `5` | 3D solid property |
| `BCBDPRP BCONPRP BCONPRG` | `6` | contact property |
| `PAABSF PACABS PACINF` | `7` | acoustic property |
| `PAERO1 PAERO2` | `104` | aero property |

## Group Mappings

| Entity | Group | Card | Source |
|---|---|---|---|
| `MATS` | `ANISOTROPIC` | `MAT2` | `misc_defs.tpl:41` |
| `MATS` | `ANISOTROPIC` | `MAT9` | `misc_defs.tpl:42` |
| `MATS` | `ANISOTROPIC` | `MATT2` | `misc_defs.tpl:44` |
| `MATS` | `ANISOTROPIC` | `MATT9` | `misc_defs.tpl:43` |
| `MATS` | `FLUID` | `MAT10` | `misc_defs.tpl:46` |
| `MATS` | `FLUID` | `MATPE1` | `misc_defs.tpl:47` |
| `MATS` | `GASKET` | `MATG` | `general:10` |
| `MATS` | `HYPERELASTIC` | `MATHE` | `general:12` |
| `MATS` | `HYPERELASTIC` | `MATHP` | `general:11` |
| `MATS` | `ISOTROPIC` | `MAT1` | `misc_defs.tpl:37` |
| `MATS` | `ISOTROPIC` | `MAT4` | `misc_defs.tpl:48` |
| `MATS` | `ISOTROPIC` | `MATT1` | `misc_defs.tpl:38` |
| `MATS` | `ISOTROPIC` | `RADM` | `general:13` |
| `MATS` | `ORTHOTROPIC` | `MAT3` | `misc_defs.tpl:50` |
| `MATS` | `ORTHOTROPIC` | `MAT5` | `misc_defs.tpl:49` |
| `MATS` | `ORTHOTROPIC` | `MAT8` | `misc_defs.tpl:39` |
| `MATS` | `ORTHOTROPIC` | `MAT9ORT` | `misc_defs.tpl:45` |
| `MATS` | `ORTHOTROPIC` | `MATORT` | `general:14` |
| `MATS` | `ORTHOTROPIC` | `MATT3` | `misc_defs.tpl:51` |
| `MATS` | `ORTHOTROPIC` | `MATT8` | `misc_defs.tpl:40` |
| `PROPS` | `0D_Rigids` | `PMASS` | `misc_defs.tpl:7` |
| `PROPS` | `1D` | `PBAR` | `misc_defs.tpl:14` |
| `PROPS` | `1D` | `PBARL` | `misc_defs.tpl:15` |
| `PROPS` | `1D` | `PBCOMP` | `general:20` |
| `PROPS` | `1D` | `PBEAM` | `misc_defs.tpl:16` |
| `PROPS` | `1D` | `PBEAML` | `misc_defs.tpl:17` |
| `PROPS` | `1D` | `PBEND` | `misc_defs.tpl:18` |
| `PROPS` | `1D` | `PFAST` | `misc_defs.tpl:19` |
| `PROPS` | `1D` | `PROD` | `misc_defs.tpl:20` |
| `PROPS` | `1D` | `PSEAM` | `general:15` |
| `PROPS` | `1D` | `PTUBE` | `misc_defs.tpl:21` |
| `PROPS` | `1D` | `PWELD` | `misc_defs.tpl:22` |
| `PROPS` | `2D` | `PAXI` | `misc_defs.tpl:28` |
| `PROPS` | `2D` | `PAXSYMH` | `general:45` |
| `PROPS` | `2D` | `PCOMP` | `misc_defs.tpl:25` |
| `PROPS` | `2D` | `PCOMPG` | `misc_defs.tpl:26` |
| `PROPS` | `2D` | `PCOMPP` | `misc_defs.tpl:27` |
| `PROPS` | `2D` | `PLPLANE` | `general:32` |
| `PROPS` | `2D` | `PSHEAR` | `misc_defs.tpl:24` |
| `PROPS` | `2D` | `PSHELL` | `misc_defs.tpl:23` |
| `PROPS` | `2D` | `PSHELL1` | `general:29` |
| `PROPS` | `3D` | `PCOMPLS` | `general:42` |
| `PROPS` | `3D` | `PLSOLID` | `misc_defs.tpl:30` |
| `PROPS` | `3D` | `PSOLID` | `misc_defs.tpl:29` |
| `PROPS` | `Acoustic` | `PAABSF` | `misc_defs.tpl:31` |
| `PROPS` | `Acoustic` | `PACABS` | `misc_defs.tpl:32` |
| `PROPS` | `Acoustic` | `PACBAR` | `general:17` |
| `PROPS` | `Acoustic` | `PACINF` | `misc_defs.tpl:33` |
| `PROPS` | `Aero` | `PAERO1` | `misc_defs.tpl:34` |
| `PROPS` | `Aero` | `PAERO2` | `general:22` |
| `PROPS` | `Contact` | `BCBDPRP` | `general:53` |
| `PROPS` | `Contact` | `BCONPRG` | `general:51` |
| `PROPS` | `Contact` | `BCONPRP` | `general:52` |
| `PROPS` | `Springs_Gaps` | `PBUSH` | `misc_defs.tpl:8` |
| `PROPS` | `Springs_Gaps` | `PBUSH1D` | `misc_defs.tpl:9` |
| `PROPS` | `Springs_Gaps` | `PDAMP` | `misc_defs.tpl:11` |
| `PROPS` | `Springs_Gaps` | `PELAS` | `misc_defs.tpl:13` |
| `PROPS` | `Springs_Gaps` | `PGAP` | `misc_defs.tpl:12` |
| `PROPS` | `Springs_Gaps` | `PHBDY` | `general:16` |
| `PROPS` | `Springs_Gaps` | `PVISC` | `misc_defs.tpl:10` |

## Property Cards

### BCBDPRP

- Source: `properties.tpl:465`
- ID pool: `CONTACT_IDPOOL`
- Options/subcards: `BNC`, `BNC_INTEGER`, `BNCE`, `BNCE_INTEGER`, `BNL`, `BNL_INTEGER`, `BNLE`, `BNLE_INTEGER`, `CFILM`, `CFILM_INTEGER`, `CMB`, `CMS`, `COPTB`, `EMISS`, `EMISS_INTEGER`, `FRIC`, `FRIC1_INTEGER`, `HBL`, `HBL_INTEGER`, `HCT`, `HCT_INTEGER`, `HCV`, `HCV_INTEGER`, `HNC`, `HNC_INTEGER`, `HNCE`, `HNCE_INTEGER`, `HNL`, `HNL_INTEGER`, `HNLE`, `HNLE_INTEGER`, `IDSPL`, `ISTYP`, `ITYPE`, `MIDNOD`, `SANGLE`, `TBODY`, `TBODY_INTEGER`, `TSINK`, `TSINK_INTEGER`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:470` |
| `VAL` | `real` | `$BCBDPRP_BNC_REAL` | `BCBDPRP_BNC_REAL #8786 real` | `properties.tpl:483` |
| `VAL` | `entity` | `$BCBDPRP_BNC_INTEGER` | `BCBDPRP_BNC_INTEGER #8785 entity` | `properties.tpl:487` |
| `VAL` | `real` | `$BCBDPRP_BNCE_REAL` | `BCBDPRP_BNCE_REAL #8790 real` | `properties.tpl:503` |
| `VAL` | `entity` | `$BCBDPRP_BNCE_INTEGER` | `BCBDPRP_BNCE_INTEGER #8789 entity` | `properties.tpl:507` |
| `VAL` | `real` | `$BCBDPRP_BNL_REAL` | `BCBDPRP_BNL_REAL #8794 real` | `properties.tpl:523` |
| `VAL` | `entity` | `$BCBDPRP_BNL_INTEGER` | `BCBDPRP_BNL_INTEGER #8793 entity` | `properties.tpl:527` |
| `VAL` | `real` | `$BCBDPRP_BNLE_REAL` | `BCBDPRP_BNLE_REAL #8798 real` | `properties.tpl:543` |
| `VAL` | `entity` | `$BCBDPRP_BNLE_INTEGER` | `BCBDPRP_BNLE_INTEGER #8797 entity` | `properties.tpl:547` |
| `VAL` | `real` | `$BCBDPRP_CFILM_REAL` | `BCBDPRP_CFILM_REAL #8802 real` | `properties.tpl:563` |
| `VAL` | `entity` | `$BCBDPRP_CFILM_INTEGER` | `BCBDPRP_CFILM_INTEGER #8801 entity` | `properties.tpl:566` |
| `VAL` | `real` | `$BCBDPRP_CMB_REAL` | `BCBDPRP_CMB_REAL #8806 real` | `properties.tpl:580` |
| `VAL` | `real` | `$BCBDPRP_CMS_REAL` | `BCBDPRP_CMS_REAL #8810 real` | `properties.tpl:594` |
| `VAL` | `integer` | `$BCBDPRP_COPTB_INTEGER` | `BCBDPRP_COPTB_INTEGER #8812 integer` | `properties.tpl:608` |
| `VAL` | `real` | `$BCBDPRP_EMISS_REAL` | `BCBDPRP_EMISS_REAL #8816 real` | `properties.tpl:623` |
| `VAL` | `entity` | `$BCBDPRP_EMISS_INTEGER` | `BCBDPRP_EMISS_INTEGER #8815 entity` | `properties.tpl:626` |
| `VAL` | `real` | `$BCBDPRP_FRIC_REAL` | `BCBDPRP_FRIC_REAL #8820 real` | `properties.tpl:642` |
| `VAL` | `entity` | `$BCBDPRP_FRIC_INTEGER` | `BCBDPRP_FRIC_INTEGER #8819 entity` | `properties.tpl:646` |
| `VAL` | `real` | `$BCBDPRP_HBL_REAL` | `BCBDPRP_HBL_REAL #8824 real` | `properties.tpl:662` |
| `VAL` | `entity` | `$BCBDPRP_HBL_INTEGER` | `BCBDPRP_HBL_INTEGER #8823 entity` | `properties.tpl:665` |
| `VAL` | `real` | `$BCBDPRP_HCT_REAL` | `BCBDPRP_HCT_REAL #8828 real` | `properties.tpl:681` |
| `VAL` | `entity` | `$BCBDPRP_HCT_INTEGER` | `BCBDPRP_HCT_INTEGER #8827 entity` | `properties.tpl:684` |
| `VAL` | `real` | `$BCBDPRP_HCV_REAL` | `BCBDPRP_HCV_REAL #8832 real` | `properties.tpl:700` |
| `VAL` | `entity` | `$BCBDPRP_HCV_INTEGER` | `BCBDPRP_HCV_INTEGER #8831 entity` | `properties.tpl:703` |
| `VAL` | `real` | `$BCBDPRP_HNC_REAL` | `BCBDPRP_HNC_REAL #8836 real` | `properties.tpl:719` |
| `VAL` | `entity` | `$BCBDPRP_HNC_INTEGER` | `BCBDPRP_HNC_INTEGER #8835 entity` | `properties.tpl:722` |
| `VAL` | `real` | `$BCBDPRP_HNCE_REAL` | `BCBDPRP_HNCE_REAL #8840 real` | `properties.tpl:738` |
| `VAL` | `entity` | `$BCBDPRP_HNCE_INTEGER` | `BCBDPRP_HNCE_INTEGER #8839 entity` | `properties.tpl:741` |
| `VAL` | `real` | `$BCBDPRP_HNL_REAL` | `BCBDPRP_HNL_REAL #8844 real` | `properties.tpl:757` |
| `VAL` | `entity` | `$BCBDPRP_HNL_INTEGER` | `BCBDPRP_HNL_INTEGER #8843 entity` | `properties.tpl:760` |
| `VAL` | `real` | `$BCBDPRP_HNLE_REAL` | `BCBDPRP_HNLE_REAL #8848 real` | `properties.tpl:776` |
| `VAL` | `entity` | `$BCBDPRP_HNLE_INTEGER` | `BCBDPRP_HNLE_INTEGER #8847 entity` | `properties.tpl:780` |
| `VAL` | `integer` | `$BCBDPRP_IDSPL_INTEGER` | `BCBDPRP_IDSPL_INTEGER #8850 integer` | `properties.tpl:794` |
| `VAL` | `integer` | `$BCBDPRP_ISTYP_INTEGER` | `BCBDPRP_ISTYP_INTEGER #8852 integer` | `properties.tpl:807` |
| `VAL` | `integer` | `$BCBDPRP_ITYPE_INTEGER` | `BCBDPRP_ITYPE_INTEGER #8854 integer` | `properties.tpl:821` |
| `VAL` | `integer` | `$BCBDPRP_MIDNOD_INTEGER` | `BCBDPRP_MIDNOD_INTEGER #8856 integer` | `properties.tpl:833` |
| `VAL` | `real` | `$BCBDPRP_SANGLE_REAL` | `BCBDPRP_SANGLE_REAL #8858 real` | `properties.tpl:847` |
| `VAL` | `real` | `$BCBDPRP_TBODY_REAL` | `BCBDPRP_TBODY_REAL #8862 real` | `properties.tpl:863` |
| `VAL` | `entity` | `$BCBDPRP_TBODY_INTEGER` | `BCBDPRP_TBODY_INTEGER #8861 entity` | `properties.tpl:866` |
| `VAL` | `real` | `$BCBDPRP_TSINK_REAL` | `BCBDPRP_TSINK_REAL #8866 real` | `properties.tpl:882` |
| `VAL` | `entity` | `$BCBDPRP_TSINK_INTEGER` | `BCBDPRP_TSINK_INTEGER #8865 entity` | `properties.tpl:885` |

### BCONPRG

- Source: `properties.tpl:9`
- ID pool: `CONTACT_IDPOOL`
- Options/subcards: `AUGDIST`, `BIAS`, `CINTERF`, `COPTM`, `COPTS`, `ERROR`, `HARDS`, `ICOORD`, `IGLUE`, `ISEARCH`, `JGLUE`, `PENALT`, `SLIDE`, `STKSLP`, `TPENALT`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `BCGPID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:12` |
| `VAL` | `real` | `$BCONPRG_AUGDIST_REAL` | `BCONPRG_AUGDIST_REAL #8599 real` | `properties.tpl:26` |
| `VAL` | `real` | `$BCONPRG_BIAS_REAL` | `BCONPRG_BIAS_REAL #8702 real` | `properties.tpl:40` |
| `VAL` | `real` | `$BCONPRG_CINTERF_REAL` | `BCONPRG_CINTERF_REAL #8704 real` | `properties.tpl:54` |
| `VAL` | `integer` | `$BCONPRG_COPTM_INTEGER` | `BCONPRG_COPTM_INTEGER #8708 integer` | `properties.tpl:68` |
| `VAL` | `integer` | `$BCONPRG_COPTS_INTEGER` | `BCONPRG_COPTS_INTEGER #8706 integer` | `properties.tpl:82` |
| `VAL` | `real` | `$BCONPRG_ERROR_REAL` | `BCONPRG_ERROR_REAL #8710 real` | `properties.tpl:96` |
| `VAL` | `real` | `$BCONPRG_HARDS_REAL` | `BCONPRG_HARDS_REAL #8712 real` | `properties.tpl:109` |
| `VAL` | `integer` | `$BCONPRG_ICOORD_INTEGER` | `BCONPRG_ICOORD_INTEGER #8714 integer` | `properties.tpl:123` |
| `VAL` | `integer` | `$BCONPRG_IGLUE_INTEGER` | `BCONPRG_IGLUE_INTEGER #8716 integer` | `properties.tpl:136` |
| `VAL` | `integer` | `$BCONPRG_ISEARCH_INTEGER` | `BCONPRG_ISEARCH_INTEGER #8718 integer` | `properties.tpl:149` |
| `VAL` | `integer` | `$BCONPRG_JGLUE_INTEGER` | `BCONPRG_JGLUE_INTEGER #8720 integer` | `properties.tpl:162` |
| `VAL` | `real` | `$BCONPRG_PENALT_REAL` | `BCONPRG_PENALT_REAL #8722 real` | `properties.tpl:175` |
| `VAL` | `real` | `$BCONPRG_SLIDE_REAL` | `BCONPRG_SLIDE_REAL #8724 real` | `properties.tpl:188` |
| `VAL` | `real` | `$BCONPRG_STKSLP_REAL` | `BCONPRG_STKSLP_REAL #8726 real` | `properties.tpl:201` |
| `VAL` | `real` | `$BCONPRG_TPENALT_REAL` | `BCONPRG_TPENALT_REAL #8728 real` | `properties.tpl:214` |

### BCONPRP

- Source: `properties.tpl:1344`
- ID pool: `CONTACT_IDPOOL`
- Options/subcards: `BGM`, `BGN`, `BGSN`, `BGST`, `BNC`, `BNC_INTEGER`, `BNL`, `BNL_INTEGER`, `DQNEAR`, `EMISS`, `EMISS_INTEGER`, `FNTOL`, `FRIC`, `FRIC_INTEGER`, `FRLIM`, `HBL`, `HBL_INTEGER`, `HCT`, `HCT_INTEGER`, `HCV`, `HCV_INTEGER`, `HGLUE`, `HNC`, `HNC_INTEGER`, `HNL`, `HNL_INTEGER`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:1347` |
| `VAL` | `real` | `$BCONPRP_VAL_BGM` | `BCONPRP_VAL_BGM #8731 real` | `properties.tpl:1361` |
| `VAL` | `real` | `$BCONPRP_VAL_BGN` | `BCONPRP_VAL_BGN #8733 real` | `properties.tpl:1375` |
| `VAL` | `real` | `$BCONPRP_VAL_BGSN` | `BCONPRP_VAL_BGSN #8735 real` | `properties.tpl:1389` |
| `VAL` | `real` | `$BCONPRP_VAL_BGST` | `BCONPRP_VAL_BGST #8737 real` | `properties.tpl:1403` |
| `VAL` | `real` | `$BCONPRP_VAL_BNC_REAL` | `BCONPRP_VAL_BNC_REAL #8741 real` | `properties.tpl:1419` |
| `VAL` | `entity` | `$BCONPRP_VAL_BNC_INT` | `BCONPRP_VAL_BNC_INT #8740 entity` | `properties.tpl:1423` |
| `VAL` | `real` | `$BCONPRP_VAL_BNL_REAL` | `BCONPRP_VAL_BNL_REAL #8745 real` | `properties.tpl:1439` |
| `VAL` | `entity` | `$BCONPRP_VAL_BNL_INT` | `BCONPRP_VAL_BNL_INT #8744 entity` | `properties.tpl:1443` |
| `VAL` | `real` | `$BCONPRP_VAL_DQNEAR` | `BCONPRP_VAL_DQNEAR #8747 real` | `properties.tpl:1457` |
| `VAL` | `real` | `$BCONPRP_VAL_EMISS_REAL` | `BCONPRP_VAL_EMISS_REAL #8751 real` | `properties.tpl:1473` |
| `VAL` | `entity` | `$BCONPRP_VAL_EMISS_INT` | `BCONPRP_VAL_EMISS_INT #8750 entity` | `properties.tpl:1477` |
| `VAL` | `real` | `$BCONPRP_VAL_FNTOL` | `BCONPRP_VAL_FNTOL #8753 real` | `properties.tpl:1491` |
| `VAL` | `real` | `$BCONPRP_VAL_FRIC_REAL` | `BCONPRP_VAL_FRIC_REAL #8757 real` | `properties.tpl:1506` |
| `VAL` | `entity` | `$BCONPRP_VAL_FRIC_INT` | `BCONPRP_VAL_FRIC_INT #8756 entity` | `properties.tpl:1511` |
| `VAL` | `real` | `$BCONPRP_VAL_FRLIM` | `BCONPRP_VAL_FRLIM #8759 real` | `properties.tpl:1525` |
| `VAL` | `real` | `$BCONPRP_VAL_HBL_REAL` | `BCONPRP_VAL_HBL_REAL #8763 real` | `properties.tpl:1541` |
| `VAL` | `entity` | `$BCONPRP_VAL_HBL_INT` | `BCONPRP_VAL_HBL_INT #8762 entity` | `properties.tpl:1545` |
| `VAL` | `real` | `$BCONPRP_VAL_HCT_REAL` | `BCONPRP_VAL_HCT_REAL #8767 real` | `properties.tpl:1561` |
| `VAL` | `entity` | `$BCONPRP_VAL_HCT_INT` | `BCONPRP_VAL_HCT_INT #8766 entity` | `properties.tpl:1565` |
| `VAL` | `real` | `$BCONPRP_VAL_HCV_REAL` | `BCONPRP_VAL_HCV_REAL #8771 real` | `properties.tpl:1581` |
| `VAL` | `entity` | `$BCONPRP_VAL_HCV_INT` | `BCONPRP_VAL_HCV_INT #8770 entity` | `properties.tpl:1585` |
| `VAL` | `integer` | `$BCONPRP_VAL_HGLUE` | `BCONPRP_VAL_HGLUE #8773 integer` | `properties.tpl:1599` |
| `VAL` | `real` | `$BCONPRP_VAL_HNC_REAL` | `BCONPRP_VAL_HNC_REAL #8777 real` | `properties.tpl:1617` |
| `VAL` | `entity` | `$BCONPRP_VAL_HNC_INT` | `BCONPRP_VAL_HNC_INT #8776 entity` | `properties.tpl:1621` |
| `VAL` | `real` | `$BCONPRP_VAL_HNL_REAL` | `BCONPRP_VAL_HNL_REAL #8781 real` | `properties.tpl:1637` |
| `VAL` | `entity` | `$BCONPRP_VAL_HNL_INT` | `BCONPRP_VAL_HNL_INT #8780 entity` | `properties.tpl:1641` |

### HM_ELAS

- Source: `general2_cfd:8269`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `DOF1`, `DOF2`, `DOF3`, `DOF4`, `DOF5`, `DOF6`, `User Comments`, `CFAST TYPE OPTIONS`, `Location of fastener`, `CSEAM TYPE OPTIONS`, `CSEAM SECOND LINE OPTIONS`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `PID` | `integer` | `id` | `HM dataname `id`` | `general2_cfd:8272` |
| `NAME` | `string` | `name` | `HM dataname `name`` | `general2_cfd:8273` |
| `DOF1` | `string` | `$HM_ELAS_LABEL1` | `HM_ELAS_LABEL1 #621 string` | `general2_cfd:8277` |
| `DOF1` | `real` | `$HM_ELAS_K1` | `HM_ELAS_K1 #611 real` | `general2_cfd:8281` |
| `DOF2` | `string` | `$HM_ELAS_LABEL2` | `HM_ELAS_LABEL2 #622 string` | `general2_cfd:8285` |
| `DOF2` | `real` | `$HM_ELAS_K2` | `HM_ELAS_K2 #612 real` | `general2_cfd:8289` |
| `DOF3` | `string` | `$HM_ELAS_LABEL3` | `HM_ELAS_LABEL3 #623 string` | `general2_cfd:8293` |
| `DOF3` | `real` | `$HM_ELAS_K3` | `HM_ELAS_K3 #613 real` | `general2_cfd:8297` |
| `DOF4` | `string` | `$HM_ELAS_LABEL4` | `HM_ELAS_LABEL4 #624 string` | `general2_cfd:8301` |
| `DOF4` | `real` | `$HM_ELAS_K4` | `HM_ELAS_K4 #614 real` | `general2_cfd:8305` |
| `DOF5` | `string` | `$HM_ELAS_LABEL5` | `HM_ELAS_LABEL5 #625 string` | `general2_cfd:8309` |
| `DOF5` | `real` | `$HM_ELAS_K5` | `HM_ELAS_K5 #615 real` | `general2_cfd:8313` |
| `DOF6` | `string` | `$HM_ELAS_LABEL6` | `HM_ELAS_LABEL6 #626 string` | `general2_cfd:8317` |
| `DOF6` | `real` | `$HM_ELAS_K6` | `HM_ELAS_K6 #616 real` | `general2_cfd:8322` |
| `GE` | `real` | `$HM_ELAS_GE` | `HM_ELAS_GE #992 arrayofreal` | `general2_cfd:8327` |
| `S` | `real` | `$HM_ELAS_S` | `HM_ELAS_S #998 arrayofreal` | `general2_cfd:8332` |
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `general2_cfd:8357` |
| `EID` | `integer` | `id` | `HM dataname `id`` | `general2_cfd:8364` |
| `PID` | `integer` | `propertyid` | `HM dataname `propertyid`` | `general2_cfd:8365` |
| `GA` | `integer` | `node1.id` | `` | `general2_cfd:8366` |
| `GB` | `integer` | `node2.id` | `` | `general2_cfd:8367` |
| `GO` | `integer` | `directionnode.id` | `` | `general2_cfd:8369` |
| `X1` | `real` | `[@xpointvectorlocal(node1.outputsystemid,node1.globalx,node1.globaly,node1.globalz,localyx,localyy,localyz)]` | `` | `general2_cfd:8376` |
| `X2` | `real` | `[-1.0*@zpointvectorlocal(node1.outputsystemid,node1.globalx,node1.globaly,node1.globalz,localyx,localyy,localyz)]` | `` | `general2_cfd:8377` |
| `X3` | `real` | `[@ypointvectorlocal(node1.outputsystemid,node1.globalx,node1.globaly,node1.globalz,localyx,localyy,localyz)]` | `` | `general2_cfd:8378` |
| `X2` | `real` | `[@ypointvectorlocal(node1.outputsystemid,node1.globalx,node1.globaly,node1.globalz,localyx,localyy,localyz)]` | `` | `general2_cfd:8382` |
| `X3` | `real` | `[@zpointvectorlocal(node1.outputsystemid,node1.globalx,node1.globaly,node1.globalz,localyx,localyy,localyz)]` | `` | `general2_cfd:8383` |
| `X1` | `real` | `localyx` | `` | `general2_cfd:8387` |
| `X2` | `real` | `localyy` | `` | `general2_cfd:8388` |
| `X3` | `real` | `localyz` | `` | `general2_cfd:8389` |
| `GEOM` | `string` | `$GEOM` | `GEOM #2983 integer` | `general2_cfd:8392` |
| `G1` | `integer` | `node1.id` | `` | `general2_cfd:8495` |
| `G2` | `integer` | `node2.id` | `` | `general2_cfd:8496` |
| `CMA` | `string` | `$CMA` | `CMA #3510 string` | `general2_cfd:8557` |
| `CMB` | `string` | `$CMB` | `CMB #3511 string` | `general2_cfd:8562` |
| `ALPHA` | `real` | `$RROD_ALPHA` | `RROD_ALPHA #9223 real` | `general2_cfd:8568` |
| `GO` | `integer` | `vector.farnodeid` | `` | `general2_cfd:8644` |
| `X1` | `real` | `[@xpointvectorlocal(node1.outputsystemid,vector.basenode.globalx,vector.basenode.globaly,vector.basenode.globalz,vector.xcomp,vector.ycomp,vector.zcomp)]` | `` | `general2_cfd:8648` |
| `X2` | `real` | `[@ypointvectorlocal(node1.outputsystemid,vector.basenode.globalx,vector.basenode.globaly,vector.basenode.globalz,vector.xcomp,vector.ycomp,vector.zcomp)]` | `` | `general2_cfd:8649` |
| `X3` | `real` | `[@zpointvectorlocal(node1.outputsystemid,vector.basenode.globalx,vector.basenode.globaly,vector.basenode.globalz,vector.xcomp,vector.ycomp,vector.zcomp)]` | `` | `general2_cfd:8650` |
| `X1` | `real` | `$CGAP_X1` | `CGAP_X1 #247 real` | `general2_cfd:8653` |
| `X2` | `real` | `$CGAP_X2` | `CGAP_X2 #248 real` | `general2_cfd:8655` |
| `X3` | `real` | `$CGAP_X3` | `CGAP_X3 #249 real` | `general2_cfd:8657` |
| `CID` | `entity` | `$CGAP_CID` | `CGAP_CID #1250 entity` | `general2_cfd:8659` |
| `TYPE` | `string` | `[$CFAST_TYPE]` | `` | `general2_cfd:8778` |
| `IDA` | `entity` | `$CFAST_IDA` | `CFAST_IDA #7614 entity` | `general2_cfd:8779` |
| `IDB` | `entity` | `$CFAST_IDB` | `CFAST_IDB #7615 entity` | `general2_cfd:8781` |
| `IDA` | `entity` | `$CFAST_IDA_E` | `CFAST_IDA_E #7621 entity` | `general2_cfd:8786` |
| `IDB` | `entity` | `$CFAST_IDB_E` | `CFAST_IDB_E #7622 entity` | `general2_cfd:8788` |
| `GS` | `integer` | `node1.id` | `` | `general2_cfd:8938` |
| `XS` | `real` | `node1.globalx` | `` | `general2_cfd:8943` |
| `YS` | `real` | `node1.globaly` | `` | `general2_cfd:8944` |
| `ZS` | `real` | `node1.globalz` | `` | `general2_cfd:8945` |
| `SMLN` | `string` | `$CSEAM_SMLN` | `CSEAM_SMLN #7633 string` | `general2_cfd:9070` |
| `CTYPE` | `string` | `[$CSEAM_CTYPE_STR]` | `` | `general2_cfd:9075` |
| `IDAS` | `entity` | `$CSEAM_IDAS` | `CSEAM_IDAS #7635 entity` | `general2_cfd:9076` |
| `IDBS` | `entity` | `$CSEAM_IDBS` | `CSEAM_IDBS #7636 entity` | `general2_cfd:9078` |
| `IDAE` | `entity` | `$CSEAM_IDAE` | `CSEAM_IDAE #7637 entity` | `general2_cfd:9080` |
| `IDBE` | `entity` | `$CSEAM_IDBE` | `CSEAM_IDBE #7638 entity` | `general2_cfd:9082` |
| `IDAS` | `entity` | `$CSEAM_IDAS_E` | `CSEAM_IDAS_E #7648 entity` | `general2_cfd:9087` |
| `IDBS` | `entity` | `$CSEAM_IDBS_E` | `CSEAM_IDBS_E #7649 entity` | `general2_cfd:9089` |
| `IDAE` | `entity` | `$CSEAM_IDAE_E` | `CSEAM_IDAE_E #7650 entity` | `general2_cfd:9091` |
| `IDBE` | `entity` | `$CSEAM_IDBE_E` | `CSEAM_IDBE_E #7651 entity` | `general2_cfd:9093` |
| `GE` | `integer` | `node2.id` | `` | `general2_cfd:9102` |
| `XS` | `real` | `$CSEAM_XS` | `CSEAM_XS #7642 real` | `general2_cfd:9107` |
| `YS` | `real` | `$CSEAM_YS` | `CSEAM_YS #7643 real` | `general2_cfd:9108` |
| `ZS` | `real` | `$CSEAM_ZS` | `CSEAM_ZS #7644 real` | `general2_cfd:9109` |
| `XE` | `real` | `$CSEAM_XE` | `CSEAM_XE #7645 real` | `general2_cfd:9110` |
| `YE` | `real` | `$CSEAM_YE` | `CSEAM_YE #7646 real` | `general2_cfd:9111` |
| `ZE` | `real` | `$CSEAM_ZE` | `CSEAM_ZE #7647 real` | `general2_cfd:9112` |
| `PID` | `integer` | `collector.propertyid` | `` | `general2_cfd:9265` |
| `G3` | `integer` | `node3.id` | `` | `general2_cfd:9272` |
| `G4` | `integer` | `node4.id` | `` | `general2_cfd:9273` |
| `G5` | `integer` | `node5.id` | `` | `general2_cfd:9274` |
| `G6` | `integer` | `node6.id` | `` | `general2_cfd:9275` |
| `G7` | `integer` | `node7.id` | `` | `general2_cfd:9279` |
| `G8` | `integer` | `node8.id` | `` | `general2_cfd:9280` |
| `G9` | `entity` | `$CHACAB_G9` | `CHACAB_G9 #740 entity` | `general2_cfd:9380` |
| `G10` | `entity` | `$CHACAB_G10` | `CHACAB_G10 #741 entity` | `general2_cfd:9383` |
| `G11` | `entity` | `$CHACAB_G11` | `CHACAB_G11 #742 entity` | `general2_cfd:9386` |
| `G12` | `entity` | `$CHACAB_G12` | `CHACAB_G12 #743 entity` | `general2_cfd:9389` |
| `G17` | `entity` | `$CHACAB_G17` | `CHACAB_G17 #744 entity` | `general2_cfd:9399` |
| `G18` | `entity` | `$CHACAB_G18` | `CHACAB_G18 #745 entity` | `general2_cfd:9402` |
| `G19` | `entity` | `$CHACAB_G19` | `CHACAB_G19 #746 entity` | `general2_cfd:9405` |
| `G20` | `entity` | `$CHACAB_G20` | `CHACAB_G20 #747 entity` | `general2_cfd:9408` |
| `G9` | `integer` | `node9.id` | `` | `general2_cfd:9643` |
| `G10` | `integer` | `node10.id` | `` | `general2_cfd:9644` |
| `PID` | `integer` | `collector.id` | `` | `general2_cfd:9723` |
| `G11` | `integer` | `node11.id` | `` | `general2_cfd:9903` |
| `G12` | `integer` | `node12.id` | `` | `general2_cfd:9904` |
| `G13` | `integer` | `node13.id` | `` | `general2_cfd:9905` |
| `G14` | `integer` | `node14.id` | `` | `general2_cfd:9906` |
| `G15` | `integer` | `node15.id` | `` | `general2_cfd:9910` |
| `G16` | `integer` | `node16.id` | `` | `general2_cfd:10027` |
| `G17` | `integer` | `node17.id` | `` | `general2_cfd:10028` |
| `G18` | `integer` | `node18.id` | `` | `general2_cfd:10029` |
| `G19` | `integer` | `node19.id` | `` | `general2_cfd:10030` |
| `G20` | `integer` | `node20.id` | `` | `general2_cfd:10031` |

### PAABSF

- Source: `acoustic.tpl:871`
- ID pool: `ACOUSTIC_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `acoustic.tpl:879` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `acoustic.tpl:885` |
| `TZREID` | `entity` | `$PAABSF_TZREID` | `PAABSF_TZREID #723 entity` | `acoustic.tpl:886` |
| `TZIMID` | `entity` | `$PAABSF_TZIMID` | `PAABSF_TZIMID #724 entity` | `acoustic.tpl:890` |
| `S` | `real` | `$PAABSF_S` | `PAABSF_S #725 real` | `acoustic.tpl:894` |
| `A` | `real` | `$PAABSF_A` | `PAABSF_A #726 real` | `acoustic.tpl:897` |
| `B` | `real` | `$PAABSF_B` | `PAABSF_B #727 real` | `acoustic.tpl:901` |
| `K` | `real` | `$PAABSF_K` | `PAABSF_K #728 real` | `acoustic.tpl:905` |
| `RHOC` | `real` | `$PAABSF_RHOC` | `PAABSF_RHOC #729 real` | `acoustic.tpl:909` |

### PACABS

- Source: `pacabs.tpl:9`
- ID pool: `ACOUSTIC_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pacabs.tpl:17` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pacabs.tpl:23` |
| `SYNTH` | `string` | `$PACABS_SYNTH` | `PACABS_SYNTH #731 string` | `pacabs.tpl:24` |
| `TID1` | `entity` | `$PACABS_TID1` | `PACABS_TID1 #732 entity` | `pacabs.tpl:27` |
| `TID2` | `entity` | `$PACABS_TID2` | `PACABS_TID2 #733 entity` | `pacabs.tpl:30` |
| `TID3` | `entity` | `$PACABS_TID3` | `PACABS_TID3 #734 entity` | `pacabs.tpl:33` |
| `TESTAR` | `real` | `$PACABS_TESTAR` | `PACABS_TESTAR #735 real` | `pacabs.tpl:36` |
| `CUTFR` | `real` | `$PACABS_CUTFR` | `PACABS_CUTFR #736 real` | `pacabs.tpl:40` |
| `B` | `real` | `$PACABS_B` | `PACABS_B #737 real` | `pacabs.tpl:43` |
| `K` | `real` | `$PACABS_K` | `PACABS_K #738 real` | `pacabs.tpl:50` |
| `M` | `real` | `$PACABS_M` | `PACABS_M #739 real` | `pacabs.tpl:53` |

### PACBAR

- Source: `pacbar.tpl:9`
- ID pool: `ACOUSTIC_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pacbar.tpl:17` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pacbar.tpl:23` |
| `MBACK` | `real` | `$PACBAR_MBACK` | `PACBAR_MBACK #9118 real` | `pacbar.tpl:24` |
| `MSEPTM` | `real` | `$PACBAR_MSEPTM` | `PACBAR_MSEPTM #9119 real` | `pacbar.tpl:26` |
| `FRESON` | `real` | `$PACBAR_FRESON` | `PACBAR_FRESON #9120 real` | `pacbar.tpl:28` |
| `KRESON` | `real` | `$PACBAR_KRESON` | `PACBAR_KRESON #9121 real` | `pacbar.tpl:31` |

### PACINF

- Source: `pacinf.tpl:8`
- ID pool: `ACOUSTIC_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pacinf.tpl:16` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pacinf.tpl:22` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `pacinf.tpl:23` |
| `RIO` | `integer` | `$PACINF_RIO` | `PACINF_RIO #1479 integer` | `pacinf.tpl:24` |
| `XP` | `real` | `$PACINF_XP` | `PACINF_XP #1480 real` | `pacinf.tpl:27` |
| `YP` | `real` | `$PACINF_YP` | `PACINF_YP #1481 real` | `pacinf.tpl:28` |
| `ZP` | `real` | `$PACINF_ZP` | `PACINF_ZP #1482 real` | `pacinf.tpl:29` |

### PAERO1

- Source: `aero_elas_common.tpl:254`
- ID pool: `PAERO_IDPOOL`
- Options/subcards: `User Comments`, `FORMAT`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `PID` | `integer` | `id` | `HM dataname `id`` | `aero_elas_common.tpl:257` |
| `Num Bodies` | `integer` | `$NUM_B` | `NUM_B #1419 integer` | `aero_elas_common.tpl:259` |
| `B` | `entity` | `$B` | `B #1420 arrayofentity` | `aero_elas_common.tpl:269` |
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `aero_elas_common.tpl:319` |
| `EID` | `integer` | `id` | `HM dataname `id`` | `aero_elas_common.tpl:326` |
| `CAERO` | `entity` | `$SPLINE_CAERO` | `SPLINE_CAERO #12021 entity` | `aero_elas_common.tpl:327` |
| `BOX1` | `integer` | `pointer2.pointervalue` | `` | `aero_elas_common.tpl:334` |
| `BOX2` | `integer` | `pointer2.pointervalue` | `` | `aero_elas_common.tpl:339` |
| `SETG` | `integer` | `pointer1.set.id` | `` | `aero_elas_common.tpl:346` |
| `DZ` | `real` | `$SPLINE_DZ` | `SPLINE_DZ #12025 real` | `aero_elas_common.tpl:348` |
| `METHOD` | `string` | `$SPLINE_METHOD` | `SPLINE_METHOD #12026 string` | `aero_elas_common.tpl:351` |
| `USAGE` | `string` | `$SPLINE_USAGE` | `SPLINE_USAGE #12027 string` | `aero_elas_common.tpl:356` |
| `NELEM` | `integer` | `$SPLINE_NELEM` | `SPLINE_NELEM #1413 integer` | `aero_elas_common.tpl:365` |
| `MELEM` | `integer` | `$SPLINE_MELEM` | `SPLINE_MELEM #1414 integer` | `aero_elas_common.tpl:367` |
| `DTOR` | `real` | `$SPLINE_DTOR` | `SPLINE_DTOR #12030 real` | `aero_elas_common.tpl:479` |
| `CID` | `entity` | `$SPLINE_CID` | `SPLINE_CID #12031 entity` | `aero_elas_common.tpl:482` |
| `DTHX` | `real` | `$SPLINE_DTHX` | `SPLINE_DTHX #12032 real` | `aero_elas_common.tpl:488` |
| `DTHY` | `real` | `$SPLINE_DTHY` | `SPLINE_DTHY #12033 real` | `aero_elas_common.tpl:490` |
| `SID` | `integer` | `id` | `HM dataname `id`` | `aero_elas_common.tpl:573` |
| `AELIST` | `integer` | `pointer1.set.id` | `` | `aero_elas_common.tpl:578` |
| `FTYPE` | `string` | `$SPLINE_FTYPE` | `SPLINE_FTYPE #12035 string` | `aero_elas_common.tpl:612` |
| `RCORE` | `real` | `$SPLINE_RCORE` | `SPLINE_RCORE #12036 real` | `aero_elas_common.tpl:616` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `aero_elas_common.tpl:704` |
| `LABEL` | `string` | `name` | `HM dataname `name`` | `aero_elas_common.tpl:705` |
| `CID1` | `entity` | `$LCS1` | `LCS1 #12045 entity` | `aero_elas_common.tpl:706` |
| `ALID1` | `integer` | `pointer1.set.id` | `` | `aero_elas_common.tpl:710` |
| `CID2` | `entity` | `$LCS2` | `LCS2 #12047 entity` | `aero_elas_common.tpl:712` |
| `ALID2` | `integer` | `pointer1.set.id` | `` | `aero_elas_common.tpl:716` |
| `EFF` | `real` | `$EFF` | `EFF #12049 real` | `aero_elas_common.tpl:718` |
| `LDW` | `string` | `$LDW` | `LDW #12050 string` | `aero_elas_common.tpl:720` |
| `CREFC` | `real` | `$CREFC` | `CREFC #12051 real` | `aero_elas_common.tpl:727` |
| `CREFS` | `real` | `$REFS` | `REFS #12052 real` | `aero_elas_common.tpl:729` |
| `PLLIM` | `real` | `$PLLIM` | `PLLIM #12053 real` | `aero_elas_common.tpl:731` |
| `PULIM` | `real` | `$PULIM` | `PULIM #12054 real` | `aero_elas_common.tpl:733` |
| `HMLLIM` | `real` | `$HMLLIM` | `HMLLIM #12055 real` | `aero_elas_common.tpl:735` |
| `HMULIM` | `real` | `$HMULIM` | `HMULIM #12056 real` | `aero_elas_common.tpl:737` |
| `TQLLIM` | `entity` | `$TQLLIM` | `TQLLIM #12057 entity` | `aero_elas_common.tpl:739` |
| `TQULIM` | `entity` | `$TQULIM` | `TQULIM #12058 entity` | `aero_elas_common.tpl:742` |
| `NAME` | `string` | `name` | `HM dataname `name`` | `aero_elas_common.tpl:836` |
| `LABEL` | `string` | `$MP_LABEL` | `MP_LABEL #12061 string` | `aero_elas_common.tpl:837` |
| `AXES` | `integer` | `$MP_AXES` | `MP_AXES #12062 integer` | `aero_elas_common.tpl:840` |
| `COMP` | `entity` | `$MP_COMP` | `MP_COMP #12063 entity` | `aero_elas_common.tpl:842` |
| `CP` | `entity` | `$MP_CP` | `MP_CP #12064 entity` | `aero_elas_common.tpl:845` |
| `X` | `real` | `$MP_X` | `MP_X #12068 real` | `aero_elas_common.tpl:848` |
| `Y` | `real` | `$MP_Y` | `MP_Y #12069 real` | `aero_elas_common.tpl:850` |
| `Z` | `real` | `$MP_Z` | `MP_Z #12070 real` | `aero_elas_common.tpl:852` |
| `CD` | `entity` | `$MP_CD` | `MP_CD #12065 entity` | `aero_elas_common.tpl:854` |
| `TABLE` | `string` | `$MP_TABLE` | `MP_TABLE #12074 string` | `aero_elas_common.tpl:901` |
| `TYPE` | `string` | `$MP_TYPE` | `MP_TYPE #12075 string` | `aero_elas_common.tpl:906` |
| `NDDLitem` | `string` | `$MP_NDDL` | `MP_NDDL #12076 string` | `aero_elas_common.tpl:907` |
| `EID` | `entity` | `$MP_EID` | `MP_EID #12077 entity` | `aero_elas_common.tpl:908` |
| `GRIDSET` | `entity` | `$MP_GSID` | `MP_GSID #12071 entity` | `aero_elas_common.tpl:938` |
| `ELEMSET` | `entity` | `$MP_ESID` | `MP_ESID #12072 entity` | `aero_elas_common.tpl:941` |
| `XFLAG` | `string` | `$MP_FLAG` | `MP_FLAG #12073 string` | `aero_elas_common.tpl:953` |
| `CSECT` | `entity` | `$CSECT_PTR` | `CSECT_PTR #12136 entity` | `aero_elas_common.tpl:966` |
| `ID` | `integer` | `pointer1.pointervalue` | `` | `aero_elas_common.tpl:1041` |
| `ID` | `integer` | `pointer1.start` | `` | `aero_elas_common.tpl:1098` |
| `ID` | `integer` | `pointer1.end` | `` | `aero_elas_common.tpl:1100` |
| `ID` | `integer` | `pointer3.pointervalue` | `` | `aero_elas_common.tpl:1111` |
| `ID` | `integer` | `pointer2.pointervalue` | `` | `aero_elas_common.tpl:1141` |
| `LISTTYPE` | `string` | `[$AECOMP_LISTTYPE]` | `` | `aero_elas_common.tpl:1360` |
| `LISTID` | `integer` | `pointer1.pointervalue` | `` | `aero_elas_common.tpl:1373` |
| `Num Factors` | `integer` | `$Total_Number` | `Total_Number #1435 integer` | `aero_elas_common.tpl:1543` |
| `D` | `real` | `$F` | `F #1436 arrayofreal` | `aero_elas_common.tpl:1554` |
| `LABEL` | `string` | `$LC_LABEL` | `LC_LABEL #12060 string` | `aero_elas_common.tpl:1595` |
| `TID` | `entity` | `$TRIM_ID` | `TRIM_ID #1463 entity` | `aero_elas_common.tpl:1635` |
| `OPTION` | `string` | `$AE_LABEL` | `AE_LABEL #1457 string` | `aero_elas_common.tpl:1638` |
| `LABLD` | `entity` | `$AE_PTR` | `AE_PTR #12144 entity` | `aero_elas_common.tpl:1643` |
| `LABLD` | `entity` | `$AE2_PTR` | `AE2_PTR #12149 entity` | `aero_elas_common.tpl:1647` |
| `LABLD` | `entity` | `$AE1_PTR` | `AE1_PTR #12145 entity` | `aero_elas_common.tpl:1650` |
| `Num Labels` | `integer` | `$NUM_LABEL` | `NUM_LABEL #1454 integer` | `aero_elas_common.tpl:1655` |
| `OPTIONS` | `arrayofstring` | `$TRIM_OPTIONS_STRINGS` | `TRIM_OPTIONS_STRINGS #11409 arrayofstring` | `aero_elas_common.tpl:1668` |
| `LABL` | `arrayofentity` | `$TRIM_LABEL` | `TRIM_LABEL #1451 arrayofentity` | `aero_elas_common.tpl:1673` |
| `LABL` | `arrayofentity` | `$TRIM_LABEL2` | `TRIM_LABEL2 #11410 arrayofentity` | `aero_elas_common.tpl:1677` |
| `LABL` | `arrayofentity` | `$TRIM_LABEL1` | `TRIM_LABEL1 #11408 arrayofentity` | `aero_elas_common.tpl:1680` |
| `C` | `real` | `$F` | `F #1436 arrayofreal` | `aero_elas_common.tpl:1686` |
| `Num Mach numbers` | `integer` | `$Total_Number` | `Total_Number #1435 integer` | `aero_elas_common.tpl:1790` |
| `Num Frequency` | `integer` | `$NUM_B` | `NUM_B #1419 integer` | `aero_elas_common.tpl:1800` |
| `Mi` | `real` | `$MACH` | `MACH #12114 arrayofreal` | `aero_elas_common.tpl:1819` |
| `Kj` | `real` | `$REDFACT` | `REDFACT #12115 arrayofreal` | `aero_elas_common.tpl:1832` |
| `MACH` | `real` | `$TRIM_MACH` | `TRIM_MACH #1449 real` | `aero_elas_common.tpl:1958` |
| `Q` | `real` | `$TRIM_Q` | `TRIM_Q #1450 real` | `aero_elas_common.tpl:1962` |
| `LABEL` | `arrayofentity` | `$TRIM_LABEL` | `TRIM_LABEL #1451 arrayofentity` | `aero_elas_common.tpl:1980` |
| `LABEL` | `arrayofentity` | `$TRIM_LABEL1` | `TRIM_LABEL1 #11408 arrayofentity` | `aero_elas_common.tpl:1983` |
| `UX` | `real` | `$TRIM_UX` | `TRIM_UX #1452 arrayofreal` | `aero_elas_common.tpl:1987` |
| `AEQR` | `real` | `$TRIM_AEQR` | `TRIM_AEQR #1453 real` | `aero_elas_common.tpl:1991` |
| `NROOT` | `integer` | `$NROOT` | `NROOT #12154 integer` | `aero_elas_common.tpl:2129` |
| `UNITS` | `string` | `$UNITS_SYSTEM` | `UNITS_SYSTEM #1930 string` | `aero_elas_common.tpl:2186` |
| `F` | `real` | `$F` | `F #1436 arrayofreal` | `aero_elas_common.tpl:2233` |
| `F1` | `real` | `$F1` | `F1 #1437 real` | `aero_elas_common.tpl:2236` |
| `FNF` | `real` | `$FNF` | `FNF #1438 real` | `aero_elas_common.tpl:2238` |
| `NF` | `integer` | `$NF` | `NF #1439 integer` | `aero_elas_common.tpl:2239` |
| `FMID` | `real` | `$FMID` | `FMID #1440 real` | `aero_elas_common.tpl:2241` |
| `METHOD` | `string` | `$FLUTTER_METHOD` | `FLUTTER_METHOD #1441 string` | `aero_elas_common.tpl:2296` |
| `DENS` | `entity` | `$FLUTTER_DENS` | `FLUTTER_DENS #1442 entity` | `aero_elas_common.tpl:2304` |
| `MACH` | `entity` | `$FLUTTER_MACH` | `FLUTTER_MACH #1443 entity` | `aero_elas_common.tpl:2307` |
| `RFREQ` | `entity` | `$FLUTTER_RFREQ` | `FLUTTER_RFREQ #1444 entity` | `aero_elas_common.tpl:2310` |
| `IMETH` | `string` | `$FLUTTER_IMETH` | `FLUTTER_IMETH #1445 string` | `aero_elas_common.tpl:2313` |
| `OMAX` | `real` | `$FLUTTER_OMAX` | `FLUTTER_OMAX #1447 real` | `aero_elas_common.tpl:2319` |
| `NVALUE` | `integer` | `$FLUTTER_NVALUE` | `FLUTTER_NVALUE #1446 integer` | `aero_elas_common.tpl:2322` |
| `EPS` | `real` | `$FLUTTER_EPS` | `FLUTTER_EPS #1448 real` | `aero_elas_common.tpl:2325` |
| `GID` | `integer` | `id` | `HM dataname `id`` | `aero_elas_common.tpl:2390` |
| `CP` | `integer` | `inputsystem.id` | `` | `aero_elas_common.tpl:2392` |
| `X1` | `real` | `globalx` | `` | `aero_elas_common.tpl:2393` |
| `X2` | `real` | `globaly` | `` | `aero_elas_common.tpl:2394` |
| `X3` | `real` | `globalz` | `` | `aero_elas_common.tpl:2395` |
| `CD` | `integer` | `outputsystem.id` | `` | `aero_elas_common.tpl:2396` |
| `PID` | `integer` | `collector.propertyid` | `` | `aero_elas_common.tpl:2412` |
| `PID` | `integer` | `propertyid` | `HM dataname `propertyid`` | `aero_elas_common.tpl:2414` |
| `G1` | `integer` | `node1.id` | `` | `aero_elas_common.tpl:2416` |
| `G2` | `integer` | `node2.id` | `` | `aero_elas_common.tpl:2417` |
| `G3` | `integer` | `node3.id` | `` | `aero_elas_common.tpl:2418` |
| `G4` | `integer` | `node4.id` | `` | `aero_elas_common.tpl:2419` |

### PAERO2

- Source: `aero_elasticity.tpl:93`
- ID pool: `PAERO_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `PID` | `integer` | `id` | `HM dataname `id`` | `aero_elasticity.tpl:96` |
| `ORIENT` | `string` | `$ORIENT` | `ORIENT #1426 string` | `aero_elasticity.tpl:97` |
| `WIDTH` | `real` | `$WIDTH` | `WIDTH #1427 real` | `aero_elasticity.tpl:102` |
| `AR` | `real` | `$AR` | `AR #1428 real` | `aero_elasticity.tpl:105` |
| `LRSB` | `entity` | `$LRSB` | `LRSB #1429 entity` | `aero_elasticity.tpl:108` |
| `LRIB` | `entity` | `$LRIB` | `LRIB #1430 entity` | `aero_elasticity.tpl:111` |
| `LTH1` | `entity` | `$LTH1` | `LTH1 #1431 entity` | `aero_elasticity.tpl:114` |
| `LTH2` | `entity` | `$LTH2` | `LTH2 #1432 entity` | `aero_elasticity.tpl:117` |
| `Num Elements` | `integer` | `$NUM_B` | `NUM_B #1419 integer` | `aero_elasticity.tpl:122` |
| `THI` | `entity` | `$THI` | `THI #1433 arrayofentity` | `aero_elasticity.tpl:126` |
| `THN` | `entity` | `$THN` | `THN #1434 arrayofentity` | `aero_elasticity.tpl:128` |
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `aero_elasticity.tpl:216` |
| `SID` | `integer` | `id` | `HM dataname `id`` | `aero_elasticity.tpl:223` |
| `CAERO` | `entity` | `$SPLINE_CAERO` | `SPLINE_CAERO #12021 entity` | `aero_elasticity.tpl:224` |
| `AELIST` | `integer` | `pointer1.set.id` | `` | `aero_elasticity.tpl:228` |
| `SETG` | `integer` | `pointer1.set.id` | `` | `aero_elasticity.tpl:232` |
| `DZ` | `real` | `$SPLINE_DZ` | `SPLINE_DZ #12025 real` | `aero_elasticity.tpl:234` |
| `DTOR` | `real` | `$SPLINE_DTOR` | `SPLINE_DTOR #12030 real` | `aero_elasticity.tpl:237` |
| `CID` | `entity` | `$SPLINE_CID` | `SPLINE_CID #12031 entity` | `aero_elasticity.tpl:239` |
| `DTHX` | `real` | `$SPLINE_DTHX` | `SPLINE_DTHX #12032 real` | `aero_elasticity.tpl:245` |
| `DTHY` | `real` | `$SPLINE_DTHY` | `SPLINE_DTHY #12033 real` | `aero_elasticity.tpl:247` |
| `USAGE` | `string` | `$SPLINE_USAGE` | `SPLINE_USAGE #12027 string` | `aero_elasticity.tpl:250` |
| `METHOD` | `string` | `$SPLINE_METHOD` | `SPLINE_METHOD #12026 string` | `aero_elasticity.tpl:255` |
| `FTYPE` | `string` | `$SPLINE_FTYPE` | `SPLINE_FTYPE #12035 string` | `aero_elasticity.tpl:260` |
| `RCORE` | `real` | `$SPLINE_RCORE` | `SPLINE_RCORE #12036 real` | `aero_elasticity.tpl:264` |
| `VSTYPE` | `string` | `$VSTYPE` | `VSTYPE #12081 string` | `aero_elasticity.tpl:362` |
| `VSLIST` | `entity` | `$AELIST1_PTR` | `AELIST1_PTR #12082 entity` | `aero_elasticity.tpl:366` |
| `I2VNUM` | `integer` | `$I2VNUM` | `I2VNUM #12083 integer` | `aero_elasticity.tpl:369` |
| `D2VNUM` | `integer` | `$D2VNUM` | `D2VNUM #12084 integer` | `aero_elasticity.tpl:371` |
| `METHVS` | `string` | `$METHVS` | `METHVS #12085 string` | `aero_elasticity.tpl:373` |
| `DZR` | `real` | `$DZR` | `DZR #12086 real` | `aero_elasticity.tpl:377` |
| `METHCON` | `string` | `$METHCON` | `METHCON #12087 string` | `aero_elasticity.tpl:380` |
| `NGRID` | `integer` | `$NGRID` | `NGRID #12088 integer` | `aero_elasticity.tpl:384` |
| `ELTOL` | `real` | `$ELTOL` | `ELTOL #12089 real` | `aero_elasticity.tpl:389` |
| `NCYCLE` | `integer` | `$NCYCLE` | `NCYCLE #12090 integer` | `aero_elasticity.tpl:391` |
| `AUGWEI` | `real` | `$AUGWEI` | `AUGWEI #12091 real` | `aero_elasticity.tpl:393` |
| `IA2` | `real` | `$IA2` | `IA2 #12126 real` | `aero_elasticity.tpl:508` |
| `EPSBM` | `real` | `$EPSBM` | `EPSBM #12127 real` | `aero_elasticity.tpl:510` |
| `G1` | `entity` | `$NODE1_PTR` | `NODE1_PTR #12108 entity` | `aero_elasticity.tpl:596` |
| `C1` | `integer` | `$CON_NODECOMP1` | `CON_NODECOMP1 #2461 integer` | `aero_elasticity.tpl:599` |
| `G2` | `entity` | `$NODE2_PTR` | `NODE2_PTR #12109 entity` | `aero_elasticity.tpl:602` |
| `C2` | `integer` | `$CON_NODECOMP2` | `CON_NODECOMP2 #2470 integer` | `aero_elasticity.tpl:605` |
| `G3` | `entity` | `$NODE3_PTR` | `NODE3_PTR #12110 entity` | `aero_elasticity.tpl:611` |
| `C3` | `integer` | `$CON_NODECOMP3` | `CON_NODECOMP3 #2479 integer` | `aero_elasticity.tpl:614` |
| `G4` | `entity` | `$NODE4_PTR` | `NODE4_PTR #12111 entity` | `aero_elasticity.tpl:617` |
| `C4` | `integer` | `$CON_NODECOMP4` | `CON_NODECOMP4 #2488 integer` | `aero_elasticity.tpl:620` |
| `G5` | `entity` | `$NODE5_PTR` | `NODE5_PTR #12112 entity` | `aero_elasticity.tpl:623` |
| `C5` | `integer` | `$CON_NODECOMP5` | `CON_NODECOMP5 #2497 integer` | `aero_elasticity.tpl:626` |
| `G6` | `entity` | `$NODE6_PTR` | `NODE6_PTR #12113 entity` | `aero_elasticity.tpl:629` |
| `C6` | `integer` | `$CON_NODECOMP6` | `CON_NODECOMP6 #2506 integer` | `aero_elasticity.tpl:632` |
| `SID1` | `entity` | `$SPLINE1_PTR` | `SPLINE1_PTR #12128 entity` | `aero_elasticity.tpl:726` |
| `SID2` | `entity` | `$SPLINE2_PTR` | `SPLINE2_PTR #12129 entity` | `aero_elasticity.tpl:729` |
| `OPT` | `string` | `$SPLINE_USAGE2` | `SPLINE_USAGE2 #12153 string` | `aero_elasticity.tpl:732` |
| `W1` | `real` | `$SPBLND_W1` | `SPBLND_W1 #12130 real` | `aero_elasticity.tpl:737` |
| `GID` | `entity` | `$NODE1_PTR` | `NODE1_PTR #12108 entity` | `aero_elasticity.tpl:739` |
| `D1` | `real` | `$SPBLND_D1` | `SPBLND_D1 #12131 real` | `aero_elasticity.tpl:742` |
| `D2` | `real` | `$SPBLND_D2` | `SPBLND_D2 #12132 real` | `aero_elasticity.tpl:744` |
| `X1` | `real` | `$SPBLND_X1` | `SPBLND_X1 #12133 real` | `aero_elasticity.tpl:749` |
| `X2` | `real` | `$SPBLND_X2` | `SPBLND_X2 #12134 real` | `aero_elasticity.tpl:751` |
| `X3` | `real` | `$SPBLND_X3` | `SPBLND_X3 #12135 real` | `aero_elasticity.tpl:753` |
| `AELIST` | `entity` | `$AELIST1_PTR` | `AELIST1_PTR #12082 entity` | `aero_elasticity.tpl:833` |
| `LIST2` | `entity` | `$AELIST2_PTR` | `AELIST2_PTR #12046 entity` | `aero_elasticity.tpl:902` |
| `DREF` | `real` | `$SPBLND_D1` | `SPBLND_D1 #12131 real` | `aero_elasticity.tpl:905` |
| `LIST1` | `entity` | `$AELIST1_PTR` | `AELIST1_PTR #12082 entity` | `aero_elasticity.tpl:907` |
| `NAME` | `string` | `name` | `HM dataname `name`` | `aero_elasticity.tpl:949` |
| `LABEL` | `string` | `$MP_LABEL` | `MP_LABEL #12061 string` | `aero_elasticity.tpl:950` |
| `AXES` | `integer` | `$MP_AXES` | `MP_AXES #12062 integer` | `aero_elasticity.tpl:953` |
| `COMP` | `entity` | `$MP_COMP` | `MP_COMP #12063 entity` | `aero_elasticity.tpl:955` |
| `CP` | `entity` | `$MP_CP` | `MP_CP #12064 entity` | `aero_elasticity.tpl:958` |
| `X` | `real` | `$MP_X` | `MP_X #12068 real` | `aero_elasticity.tpl:961` |
| `Y` | `real` | `$MP_Y` | `MP_Y #12069 real` | `aero_elasticity.tpl:963` |
| `Z` | `real` | `$MP_Z` | `MP_Z #12070 real` | `aero_elasticity.tpl:965` |
| `CD` | `entity` | `$MP_CD` | `MP_CD #12065 entity` | `aero_elasticity.tpl:967` |
| `INDDOF` | `integer` | `$IND_DOF` | `IND_DOF #12059 integer` | `aero_elasticity.tpl:970` |
| `EXCITEID` | `entity` | `$TLOAD1_EXCITEID` | `TLOAD1_EXCITEID #4349 entity` | `aero_elasticity.tpl:1013` |
| `WG` | `real` | `$WG` | `WG #12078 real` | `aero_elasticity.tpl:1016` |
| `X0` | `real` | `$X0` | `X0 #12079 real` | `aero_elasticity.tpl:1018` |
| `V` | `real` | `$V` | `V #12080 real` | `aero_elasticity.tpl:1020` |
| `MACH` | `real` | `$TRIM_MACH` | `TRIM_MACH #1449 real` | `aero_elasticity.tpl:1057` |
| `SYMXZ` | `string` | `$SYMXZ` | `SYMXZ #12102 string` | `aero_elasticity.tpl:1059` |
| `SYMXY` | `string` | `$SYMXY` | `SYMXY #12103 string` | `aero_elasticity.tpl:1064` |
| `UXID` | `entity` | `$UXID` | `UXID #12104 entity` | `aero_elasticity.tpl:1069` |
| `MESH` | `string` | `$MESH` | `MESH #12105 string` | `aero_elasticity.tpl:1072` |
| `LSET` | `entity` | `$TLOAD1_EXCITEID` | `TLOAD1_EXCITEID #4349 entity` | `aero_elasticity.tpl:1076` |
| `DMIK` | `string` | `$DMIK` | `DMIK #12106 string` | `aero_elasticity.tpl:1079` |
| `PERQ` | `string` | `$PERQ` | `PERQ #12107 string` | `aero_elasticity.tpl:1081` |
| `DMI` | `string` | `$DMI_PTR` | `DMI_PTR #12142 string` | `aero_elasticity.tpl:1139` |
| `DMIJI` | `string` | `$DMIJI_PTR` | `DMIJI_PTR #12143 string` | `aero_elasticity.tpl:1143` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `aero_elasticity.tpl:1256` |
| `Num Labels` | `integer` | `$NUM_LABEL` | `NUM_LABEL #1454 integer` | `aero_elasticity.tpl:1259` |
| `OPTIONS` | `arrayofstring` | `$TRIM_OPTIONS_STRINGS` | `TRIM_OPTIONS_STRINGS #11409 arrayofstring` | `aero_elasticity.tpl:1271` |
| `LABEL` | `arrayofentity` | `$TRIM_LABEL` | `TRIM_LABEL #1451 arrayofentity` | `aero_elasticity.tpl:1276` |
| `LABEL` | `arrayofentity` | `$TRIM_LABEL2` | `TRIM_LABEL2 #11410 arrayofentity` | `aero_elasticity.tpl:1280` |
| `LABEL` | `arrayofentity` | `$TRIM_LABEL1` | `TRIM_LABEL1 #11408 arrayofentity` | `aero_elasticity.tpl:1283` |
| `UX` | `real` | `$TRIM_UX` | `TRIM_UX #1452 arrayofreal` | `aero_elasticity.tpl:1288` |

### PAXSYMH

- Source: `properties.tpl:2509`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:2517` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:2523` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2524` |
| `CID` | `entity` | `$PAXSYMH_CID` | `PAXSYMH_CID #10059 entity` | `properties.tpl:2525` |
| `NHARM` | `integer` | `$PAXSYMH_NHARM` | `PAXSYMH_NHARM #10060 integer` | `properties.tpl:2528` |
| `INT` | `integer` | `$PAXSYMH_INT` | `PAXSYMH_INT #10061 integer` | `properties.tpl:2532` |

### PBAR

- Source: `pbar.tpl:7`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`, `CONT1`, `CONT2`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pbar.tpl:16` |
| `beamsec` | `entity` | `$BeamSec` | `BeamSec #3179 entity` | `pbar.tpl:23` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pbar.tpl:28` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `pbar.tpl:29` |
| `A` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_area)]` | `` | `pbar.tpl:31` |
| `I1` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_Icentroid1)]` | `` | `pbar.tpl:32` |
| `I2` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_Icentroid0)]` | `` | `pbar.tpl:33` |
| `J` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_J)]` | `` | `pbar.tpl:34` |
| `A` | `real` | `$PBAR_A` | `PBAR_A #68 real` | `pbar.tpl:36` |
| `I1` | `real` | `$PBAR_I1` | `PBAR_I1 #69 real` | `pbar.tpl:37` |
| `I2` | `real` | `$PBAR_I2` | `PBAR_I2 #70 real` | `pbar.tpl:38` |
| `J` | `real` | `$PBAR_J` | `PBAR_J #71 real` | `pbar.tpl:39` |
| `NSM` | `real` | `$PBAR_NSM` | `PBAR_NSM #72 real` | `pbar.tpl:41` |
| `C1` | `real` | `$PBAR_C1` | `PBAR_C1 #73 real` | `pbar.tpl:48` |
| `C2` | `real` | `$PBAR_C2` | `PBAR_C2 #74 real` | `pbar.tpl:49` |
| `D1` | `real` | `$PBAR_D1` | `PBAR_D1 #75 real` | `pbar.tpl:50` |
| `D2` | `real` | `$PBAR_D2` | `PBAR_D2 #76 real` | `pbar.tpl:51` |
| `E1` | `real` | `$PBAR_E1` | `PBAR_E1 #77 real` | `pbar.tpl:52` |
| `E2` | `real` | `$PBAR_E2` | `PBAR_E2 #78 real` | `pbar.tpl:53` |
| `F1` | `real` | `$PBAR_F1` | `PBAR_F1 #79 real` | `pbar.tpl:54` |
| `F2` | `real` | `$PBAR_F2` | `PBAR_F2 #80 real` | `pbar.tpl:55` |
| `K1` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_shearStiff0)]` | `` | `pbar.tpl:62` |
| `K1` | `real` | `$PBAR_K1` | `PBAR_K1 #81 real` | `pbar.tpl:64` |
| `K2` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_shearStiff1)]` | `` | `pbar.tpl:68` |
| `K2` | `real` | `$PBAR_K2` | `PBAR_K2 #82 real` | `pbar.tpl:70` |
| `I12` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_Icentroid2)]` | `` | `pbar.tpl:74` |
| `I12` | `real` | `$PBAR_I12` | `PBAR_I12 #83 real` | `pbar.tpl:76` |

### PBARL

- Source: `pbarl.tpl:7`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pbarl.tpl:16` |
| `beamsec` | `entity` | `$BeamSec` | `BeamSec #3179 entity` | `pbarl.tpl:22` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pbarl.tpl:27` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `pbarl.tpl:28` |
| `GROUP` | `string` | `$pbarlgroup` | `pbarlgroup #3181 string` | `pbarl.tpl:29` |
| `CStype` | `string` | `[$pbarlcstype]` | `` | `pbarl.tpl:168` |
| `CStype` | `string` | `$pbarlcstype` | `pbarlcstype #3182 string` | `pbarl.tpl:190` |
| `DIMs1` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,0)]` | `` | `pbarl.tpl:219` |
| `DIMs` | `real` | `$pbarlDIMarray` | `pbarlDIMarray #3183 arrayofreal` | `pbarl.tpl:222` |
| `DIMs1` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,1)]` | `` | `pbarl.tpl:228` |
| `DIMs2` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,0)]` | `` | `pbarl.tpl:229` |
| `DIMs2` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,1)]` | `` | `pbarl.tpl:239` |
| `DIMs3` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,2)]` | `` | `pbarl.tpl:240` |
| `DIMs4` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,3)]` | `` | `pbarl.tpl:241` |
| `DIMs5` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,4)]` | `` | `pbarl.tpl:242` |
| `DIMs6` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,5)]` | `` | `pbarl.tpl:243` |
| `DIMs1` | `real` | `[variable13-variable14]` | `` | `pbarl.tpl:256` |
| `DIMs2` | `real` | `variable14` | `` | `pbarl.tpl:257` |
| `DIMs3` | `real` | `variable11` | `` | `pbarl.tpl:258` |
| `DIMs4` | `real` | `[variable11+(2*variable12)]` | `` | `pbarl.tpl:259` |
| `DIMs1` | `real` | `[variable11 - variable13]` | `` | `pbarl.tpl:284` |
| `DIMs2` | `real` | `variable13` | `` | `pbarl.tpl:285` |
| `DIMs3` | `real` | `[variable12 - variable14 - variable14]` | `` | `pbarl.tpl:286` |
| `DIMs4` | `real` | `variable12` | `` | `pbarl.tpl:287` |
| `DIMs1` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,3)]` | `` | `pbarl.tpl:296` |
| `DIMs2` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,2)]` | `` | `pbarl.tpl:297` |
| `DIMs3` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,0)]` | `` | `pbarl.tpl:298` |
| `DIMs4` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,1)]` | `` | `pbarl.tpl:299` |
| `DIMs1` | `real` | `variable11` | `` | `pbarl.tpl:324` |
| `DIMs2` | `real` | `[variable12 - variable13]` | `` | `pbarl.tpl:325` |
| `DIMs3` | `real` | `variable13` | `` | `pbarl.tpl:326` |
| `DIMs4` | `real` | `variable14` | `` | `pbarl.tpl:327` |
| `DIMs1` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,2)]` | `` | `pbarl.tpl:349` |
| `DIMs3` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,4)]` | `` | `pbarl.tpl:363` |
| `DIMs4` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,0)]` | `` | `pbarl.tpl:364` |
| `DIMs5` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,5)]` | `` | `pbarl.tpl:365` |
| `DIMs6` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,3)]` | `` | `pbarl.tpl:366` |
| `DIMs1` | `real` | `[variable13+variable14-variable15*0.5-variable16*0.5]` | `` | `pbarl.tpl:393` |
| `DIMs2` | `real` | `[variable15*0.5+variable16*0.5]` | `` | `pbarl.tpl:394` |
| `DIMs3` | `real` | `[variable11+variable12]` | `` | `pbarl.tpl:395` |
| `DIMs4` | `real` | `[variable17*0.5+variable18*0.5]` | `` | `pbarl.tpl:396` |
| `DIMs2` | `real` | `[2*variable12]` | `` | `pbarl.tpl:407` |
| `DIMs1` | `real` | `[variable12 - variable16]` | `` | `pbarl.tpl:426` |
| `DIMs2` | `real` | `variable16` | `` | `pbarl.tpl:427` |
| `DIMs3` | `real` | `[variable11 - variable15 - variable14]` | `` | `pbarl.tpl:428` |
| `DIMs4` | `real` | `variable11` | `` | `pbarl.tpl:429` |
| `DIMs7` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,6)]` | `` | `pbarl.tpl:480` |
| `DIMs8` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,7)]` | `` | `pbarl.tpl:481` |
| `DIMs9` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,8)]` | `` | `pbarl.tpl:484` |
| `DIMs10` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,9)]` | `` | `pbarl.tpl:485` |
| `NSM` | `real` | `$pbarlNSM` | `pbarlNSM #3185 real` | `pbarl.tpl:500` |

### PBCOMP

- Source: `properties.tpl:3793`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:3801` |
| `beamsec` | `entity` | `$BeamSecA` | `BeamSecA #3186 entity` | `properties.tpl:3807` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:3815` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:3816` |
| `A` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_area)]` | `` | `properties.tpl:3818` |
| `I1` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_Icentroid1)]` | `` | `properties.tpl:3819` |
| `I2` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_Icentroid0)]` | `` | `properties.tpl:3820` |
| `I12` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_Icentroid2)]` | `` | `properties.tpl:3821` |
| `J` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_J)]` | `` | `properties.tpl:3822` |
| `A` | `real` | `$PBCOMP_A` | `PBCOMP_A #9458 real` | `properties.tpl:3824` |
| `I1` | `real` | `$PBCOMP_I1` | `PBCOMP_I1 #9459 real` | `properties.tpl:3825` |
| `I2` | `real` | `$PBCOMP_I2` | `PBCOMP_I2 #9460 real` | `properties.tpl:3826` |
| `I12` | `real` | `$PBCOMP_I12` | `PBCOMP_I12 #9461 real` | `properties.tpl:3827` |
| `J` | `real` | `$PBCOMP_J` | `PBCOMP_J #9462 real` | `properties.tpl:3829` |
| `NSM` | `real` | `$PBCOMP_NSM` | `PBCOMP_NSM #9463 real` | `properties.tpl:3832` |
| `K1` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_shearStiff0)]` | `` | `properties.tpl:3838` |
| `K2` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_shearStiff1)]` | `` | `properties.tpl:3839` |
| `K1` | `real` | `$PBCOMP_K1` | `PBCOMP_K1 #9468 real` | `properties.tpl:3841` |
| `K2` | `real` | `$PBCOMP_K2` | `PBCOMP_K2 #9469 real` | `properties.tpl:3844` |
| `M1` | `real` | `$PBCOMP_M1` | `PBCOMP_M1 #9470 real` | `properties.tpl:3849` |
| `M2` | `real` | `$PBCOMP_M2` | `PBCOMP_M2 #9471 real` | `properties.tpl:3851` |
| `N1` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_centroid0)-@getentityvalue(beamsects,$BeamSecA,results_shearCenter0)]` | `` | `properties.tpl:3855` |
| `N1` | `real` | `$PBCOMP_N1` | `PBCOMP_N1 #9472 real` | `properties.tpl:3857` |
| `N2` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_centroid1)-@getentityvalue(beamsects,$BeamSecA,results_shearCenter1)]` | `` | `properties.tpl:3862` |
| `N2` | `real` | `$PBCOMP_N2` | `PBCOMP_N2 #9473 real` | `properties.tpl:3864` |
| `SYMOPT` | `integer` | `$PBCOMP_SYMOPT` | `PBCOMP_SYMOPT #9474 integer` | `properties.tpl:3868` |
| `Y` | `real` | `$PBCOMP_Y` | `PBCOMP_Y #9464 arrayofreal` | `properties.tpl:3879` |
| `Z` | `real` | `$PBCOMP_Z` | `PBCOMP_Z #9465 arrayofreal` | `properties.tpl:3881` |
| `C` | `real` | `$PBCOMP_C` | `PBCOMP_C #9466 arrayofreal` | `properties.tpl:3883` |
| `MID` | `entity` | `$PBCOMP_MID` | `PBCOMP_MID #9467 arrayofentity` | `properties.tpl:3886` |

### PBEAM

- Source: `properties.tpl:4054`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`, `CONTINUATION LINE 2`, `CONTINUATION LINE 5`, `CONTINUATION LINE 6`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:4062` |
| `beamsec` | `entity` | `$BeamSecA` | `BeamSecA #3186 entity` | `properties.tpl:4068` |
| `beamsec` | `entity` | `$BeamSecInt` | `BeamSecInt #3187 arrayofentity` | `properties.tpl:4076` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:4082` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:4083` |
| `Aa` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_area)]` | `` | `properties.tpl:4085` |
| `I1a` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_Icentroid1)]` | `` | `properties.tpl:4086` |
| `I2a` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_Icentroid0)]` | `` | `properties.tpl:4087` |
| `I12a` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_Icentroid2)]` | `` | `properties.tpl:4088` |
| `Ja` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_J)]` | `` | `properties.tpl:4089` |
| `Aa` | `real` | `$PBEAM_Aa` | `PBEAM_Aa #14 real` | `properties.tpl:4091` |
| `I1a` | `real` | `$PBEAM_I1a` | `PBEAM_I1a #15 real` | `properties.tpl:4092` |
| `I2a` | `real` | `$PBEAM_I2a` | `PBEAM_I2a #16 real` | `properties.tpl:4093` |
| `I12a` | `real` | `$PBEAM_I12a` | `PBEAM_I12a #17 real` | `properties.tpl:4094` |
| `Ja` | `real` | `$PBEAM_Ja` | `PBEAM_Ja #18 real` | `properties.tpl:4096` |
| `NSMa` | `real` | `$PBEAM_NSMa` | `PBEAM_NSMa #19 real` | `properties.tpl:4099` |
| `C1a` | `real` | `$PBEAM_C1a` | `PBEAM_C1a #20 real` | `properties.tpl:4107` |
| `C2a` | `real` | `$PBEAM_C2a` | `PBEAM_C2a #21 real` | `properties.tpl:4109` |
| `D1a` | `real` | `$PBEAM_D1a` | `PBEAM_D1a #22 real` | `properties.tpl:4111` |
| `D2a` | `real` | `$PBEAM_D2a` | `PBEAM_D2a #23 real` | `properties.tpl:4113` |
| `E1a` | `real` | `$PBEAM_E1a` | `PBEAM_E1a #24 real` | `properties.tpl:4115` |
| `E2a` | `real` | `$PBEAM_E2a` | `PBEAM_E2a #25 real` | `properties.tpl:4117` |
| `F1a` | `real` | `$PBEAM_F1a` | `PBEAM_F1a #26 real` | `properties.tpl:4119` |
| `F2a` | `real` | `$PBEAM_F2a` | `PBEAM_F2a #27 real` | `properties.tpl:4121` |
| `SO` | `string` | `$PBEAM_SO` | `PBEAM_SO #45 arrayofstring` | `properties.tpl:4130` |
| `X` | `real` | `$PBEAM_X` | `PBEAM_X #46 arrayofreal` | `properties.tpl:4134` |
| `Aa` | `real` | `[@getentityvalue(beamsects,counter5,results_area)]` | `` | `properties.tpl:4140` |
| `I1a` | `real` | `[@getentityvalue(beamsects,counter5,results_Icentroid1)]` | `` | `properties.tpl:4141` |
| `I2a` | `real` | `[@getentityvalue(beamsects,counter5,results_Icentroid0)]` | `` | `properties.tpl:4142` |
| `I12a` | `real` | `[@getentityvalue(beamsects,counter5,results_Icentroid2)]` | `` | `properties.tpl:4143` |
| `Ja` | `real` | `[@getentityvalue(beamsects,counter5,results_J)]` | `` | `properties.tpl:4144` |
| `Aa` | `real` | `$PBEAM_A` | `PBEAM_A #47 arrayofreal` | `properties.tpl:4146` |
| `I1a` | `real` | `$PBEAM_I1` | `PBEAM_I1 #48 arrayofreal` | `properties.tpl:4147` |
| `I2a` | `real` | `$PBEAM_I2` | `PBEAM_I2 #49 arrayofreal` | `properties.tpl:4148` |
| `I12a` | `real` | `$PBEAM_I12` | `PBEAM_I12 #50 arrayofreal` | `properties.tpl:4149` |
| `Ja` | `real` | `$PBEAM_J` | `PBEAM_J #51 arrayofreal` | `properties.tpl:4150` |
| `NSM` | `real` | `$PBEAM_NSM` | `PBEAM_NSM #188 arrayofreal` | `properties.tpl:4152` |
| `C1` | `real` | `$PBEAM_C1` | `PBEAM_C1 #52 arrayofreal` | `properties.tpl:4157` |
| `C2` | `real` | `$PBEAM_C2` | `PBEAM_C2 #53 arrayofreal` | `properties.tpl:4158` |
| `D1` | `real` | `$PBEAM_D1` | `PBEAM_D1 #54 arrayofreal` | `properties.tpl:4159` |
| `D2` | `real` | `$PBEAM_D2` | `PBEAM_D2 #55 arrayofreal` | `properties.tpl:4160` |
| `E1` | `real` | `$PBEAM_E1` | `PBEAM_E1 #56 arrayofreal` | `properties.tpl:4161` |
| `E2` | `real` | `$PBEAM_E2` | `PBEAM_E2 #57 arrayofreal` | `properties.tpl:4162` |
| `F1` | `real` | `$PBEAM_F1` | `PBEAM_F1 #58 arrayofreal` | `properties.tpl:4163` |
| `F2` | `real` | `$PBEAM_F2` | `PBEAM_F2 #59 arrayofreal` | `properties.tpl:4164` |
| `K1` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_shearStiff0)]` | `` | `properties.tpl:4174` |
| `K1` | `real` | `$PBEAM_K1` | `PBEAM_K1 #28 real` | `properties.tpl:4176` |
| `K2` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_shearStiff1)]` | `` | `properties.tpl:4181` |
| `K2` | `real` | `$PBEAM_K2` | `PBEAM_K2 #29 real` | `properties.tpl:4183` |
| `S1` | `real` | `$PBEAM_S1` | `PBEAM_S1 #30 real` | `properties.tpl:4187` |
| `S2` | `real` | `$PBEAM_S2` | `PBEAM_S2 #31 real` | `properties.tpl:4189` |
| `NSIa` | `real` | `$PBEAM_NSIa` | `PBEAM_NSIa #32 real` | `properties.tpl:4191` |
| `NSIb` | `real` | `$PBEAM_NSIb` | `PBEAM_NSIb #33 real` | `properties.tpl:4193` |
| `CWa` | `real` | `$PBEAM_CWa` | `PBEAM_CWa #34 real` | `properties.tpl:4195` |
| `CWb` | `real` | `$PBEAM_CWb` | `PBEAM_CWb #35 real` | `properties.tpl:4197` |
| `M1a` | `real` | `$PBEAM_M1a` | `PBEAM_M1a #36 real` | `properties.tpl:4212` |
| `M2a` | `real` | `$PBEAM_M2a` | `PBEAM_M2a #37 real` | `properties.tpl:4214` |
| `M1b` | `real` | `$PBEAM_M1b` | `PBEAM_M1b #38 real` | `properties.tpl:4216` |
| `M2b` | `real` | `$PBEAM_M2b` | `PBEAM_M2b #39 real` | `properties.tpl:4218` |
| `N1a` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_centroid0)-@getentityvalue(beamsects,$BeamSecA,results_shearCenter0)]` | `` | `properties.tpl:4222` |
| `N1a` | `real` | `$PBEAM_N1a` | `PBEAM_N1a #40 real` | `properties.tpl:4224` |
| `N2a` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_centroid1)-@getentityvalue(beamsects,$BeamSecA,results_shearCenter1)]` | `` | `properties.tpl:4229` |
| `N2a` | `real` | `$PBEAM_N2a` | `PBEAM_N2a #41 real` | `properties.tpl:4231` |
| `N1b` | `real` | `[@getentityvalue(beamsects,@attributearrayvalue($BeamSecInt,(counter2)),results_centroid0)-@getentityvalue(beamsects,@attributearrayvalue($BeamSecInt,(counter2)),results_shearCenter0)]` | `` | `properties.tpl:4237` |
| `N1b` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_centroid0)-@getentityvalue(beamsects,$BeamSecA,results_shearCenter0)]` | `` | `properties.tpl:4240` |
| `N1b` | `real` | `$PBEAM_N1b` | `PBEAM_N1b #42 real` | `properties.tpl:4242` |
| `N2b` | `real` | `[@getentityvalue(beamsects,@attributearrayvalue($BeamSecInt,(counter2)),results_centroid1)-@getentityvalue(beamsects,@attributearrayvalue($BeamSecInt,(counter2)),results_shearCenter1)]` | `` | `properties.tpl:4247` |
| `N2b` | `real` | `[@getentityvalue(beamsects,$BeamSecA,results_centroid1)-@getentityvalue(beamsects,$BeamSecA,results_shearCenter1)]` | `` | `properties.tpl:4250` |
| `N2b` | `real` | `$PBEAM_N2b` | `PBEAM_N2b #43 real` | `properties.tpl:4252` |

### PBEAML

- Source: `pbeaml.tpl:6`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pbeaml.tpl:14` |
| `beamsec` | `entity` | `$BeamSecA` | `BeamSecA #3186 entity` | `pbeaml.tpl:20` |
| `beamsec` | `entity` | `$BeamSecInt` | `BeamSecInt #3187 arrayofentity` | `pbeaml.tpl:28` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pbeaml.tpl:33` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `pbeaml.tpl:34` |
| `GROUP` | `string` | `$pbeamlgroup` | `pbeamlgroup #3190 string` | `pbeaml.tpl:35` |
| `TYPE` | `string` | `[$pbeamlcstype]` | `` | `pbeaml.tpl:171` |
| `TYPE` | `string` | `$pbeamlcstype` | `pbeamlcstype #3191 string` | `pbeaml.tpl:194` |
| `DIM1A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:224` |
| `DIM1A` | `real` | `$pbeamlDIM1A` | `pbeamlDIM1A #3202 real` | `pbeaml.tpl:226` |
| `DIM1A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:232` |
| `DIM2A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:233` |
| `DIM2A` | `real` | `$pbeamlDIM2A` | `pbeamlDIM2A #3203 real` | `pbeaml.tpl:236` |
| `DIM2A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:243` |
| `DIM3A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:244` |
| `DIM4A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:245` |
| `DIM5A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,4)]` | `` | `pbeaml.tpl:246` |
| `DIM6A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,5)]` | `` | `pbeaml.tpl:247` |
| `DIM3A` | `real` | `$pbeamlDIM3A` | `pbeamlDIM3A #3204 real` | `pbeaml.tpl:251` |
| `DIM4A` | `real` | `$pbeamlDIM4A` | `pbeamlDIM4A #3205 real` | `pbeaml.tpl:252` |
| `DIM5A` | `real` | `$pbeamlDIM5A` | `pbeamlDIM5A #3206 real` | `pbeaml.tpl:253` |
| `DIM6A` | `real` | `$pbeamlDIM6A` | `pbeamlDIM6A #3207 real` | `pbeaml.tpl:254` |
| `DIM1A` | `real` | `[variable13-variable14]` | `` | `pbeaml.tpl:264` |
| `DIM2A` | `real` | `variable14` | `` | `pbeaml.tpl:265` |
| `DIM3A` | `real` | `variable11` | `` | `pbeaml.tpl:266` |
| `DIM4A` | `real` | `[variable11+(2*variable12)]` | `` | `pbeaml.tpl:267` |
| `DIM1A` | `real` | `[variable11 - variable13]` | `` | `pbeaml.tpl:296` |
| `DIM2A` | `real` | `variable13` | `` | `pbeaml.tpl:297` |
| `DIM3A` | `real` | `[variable12 - variable14 - variable14]` | `` | `pbeaml.tpl:298` |
| `DIM4A` | `real` | `variable12` | `` | `pbeaml.tpl:299` |
| `DIM1A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:310` |
| `DIM2A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:311` |
| `DIM3A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:312` |
| `DIM4A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:313` |
| `DIM2A` | `real` | `[variable12 - variable13]` | `` | `pbeaml.tpl:341` |
| `DIM3A` | `real` | `variable13` | `` | `pbeaml.tpl:342` |
| `DIM1A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:368` |
| `DIM3A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,4)]` | `` | `pbeaml.tpl:384` |
| `DIM4A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:385` |
| `DIM5A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,5)]` | `` | `pbeaml.tpl:386` |
| `DIM6A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:387` |
| `DIM1A` | `real` | `[variable13+variable14-variable15*0.5-variable16*0.5]` | `` | `pbeaml.tpl:418` |
| `DIM2A` | `real` | `[variable15*0.5+variable16*0.5]` | `` | `pbeaml.tpl:419` |
| `DIM3A` | `real` | `[variable11+variable12]` | `` | `pbeaml.tpl:420` |
| `DIM4A` | `real` | `[variable17*0.5+variable18*0.5]` | `` | `pbeaml.tpl:421` |
| `DIM2A` | `real` | `[2*variable12]` | `` | `pbeaml.tpl:434` |
| `DIM1A` | `real` | `[variable12 - variable16]` | `` | `pbeaml.tpl:455` |
| `DIM2A` | `real` | `variable16` | `` | `pbeaml.tpl:456` |
| `DIM3A` | `real` | `[variable11 - variable15 - variable14]` | `` | `pbeaml.tpl:457` |
| `DIM4A` | `real` | `variable11` | `` | `pbeaml.tpl:458` |
| `DIM3A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:471` |
| `DIM4A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:472` |
| `DIM7A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,6)]` | `` | `pbeaml.tpl:531` |
| `DIM8A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,7)]` | `` | `pbeaml.tpl:532` |
| `DIM9A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,8)]` | `` | `pbeaml.tpl:535` |
| `DIM10A` | `real` | `[@getentityarrayvalue(beamsects,$BeamSecA,standard_ParameterInitials,9)]` | `` | `pbeaml.tpl:536` |
| `DIM7A` | `real` | `$pbeamlDIM7A` | `pbeamlDIM7A #7341 real` | `pbeaml.tpl:544` |
| `DIM8A` | `real` | `$pbeamlDIM8A` | `pbeamlDIM8A #7342 real` | `pbeaml.tpl:545` |
| `DIM9A` | `real` | `$pbeamlDIM9A` | `pbeamlDIM9A #7343 real` | `pbeaml.tpl:548` |
| `DIM10A` | `real` | `$pbeamlDIM10A` | `pbeamlDIM10A #7344 real` | `pbeaml.tpl:549` |
| `NSM` | `real` | `$pbeamlNSM` | `pbeamlNSM #3194 real` | `pbeaml.tpl:559` |
| `SO` | `string` | `$pbeamlSOarray` | `pbeamlSOarray #3195 arrayofstring` | `pbeaml.tpl:578` |
| `Xi_XB` | `real` | `$pbeamlXi_XB` | `pbeamlXi_XB #3201 arrayofreal` | `pbeaml.tpl:587` |
| `DIM1` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:602` |
| `DIM1` | `real` | `$pbeamlintDIM1` | `pbeamlintDIM1 #3208 arrayofreal` | `pbeaml.tpl:604` |
| `DIM1` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:615` |
| `DIM2` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:621` |
| `DIM2` | `real` | `$pbeamlintDIM2` | `pbeamlintDIM2 #3209 arrayofreal` | `pbeaml.tpl:629` |
| `DIM2` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:646` |
| `DIM3` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:652` |
| `DIM4` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:658` |
| `DIM5` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,4)]` | `` | `pbeaml.tpl:664` |
| `DIM6` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,5)]` | `` | `pbeaml.tpl:670` |
| `DIM3` | `real` | `$pbeamlintDIM3` | `pbeamlintDIM3 #3210 arrayofreal` | `pbeaml.tpl:684` |
| `DIM4` | `real` | `$pbeamlintDIM4` | `pbeamlintDIM4 #3211 arrayofreal` | `pbeaml.tpl:690` |
| `DIM5` | `real` | `$pbeamlintDIM5` | `pbeamlintDIM5 #3212 arrayofreal` | `pbeaml.tpl:696` |
| `DIM6` | `real` | `$pbeamlintDIM6` | `pbeamlintDIM6 #3213 arrayofreal` | `pbeaml.tpl:702` |
| `DIM1` | `real` | `[variable13 - variable14]` | `` | `pbeaml.tpl:717` |
| `DIM2` | `real` | `variable14` | `` | `pbeaml.tpl:723` |
| `DIM3` | `real` | `variable11` | `` | `pbeaml.tpl:729` |
| `DIM4` | `real` | `[variable11+(2*variable12)]` | `` | `pbeaml.tpl:735` |
| `DIM1` | `real` | `[variable11 - variable13]` | `` | `pbeaml.tpl:818` |
| `DIM2` | `real` | `variable13` | `` | `pbeaml.tpl:824` |
| `DIM3` | `real` | `[variable12 - variable14 - variable14]` | `` | `pbeaml.tpl:830` |
| `DIM4` | `real` | `pointer2.pointervalue` | `` | `pbeaml.tpl:836` |
| `DIM1` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:867` |
| `DIM2` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:873` |
| `DIM3` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:879` |
| `DIM4` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:885` |
| `DIM2` | `real` | `[variable12 - variable13]` | `` | `pbeaml.tpl:973` |
| `DIM3` | `real` | `variable13` | `` | `pbeaml.tpl:979` |
| `DIM1` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:1065` |
| `DIM4` | `real` | `[@getentityarrayvalue(beamsects,$variable1,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:1083` |
| `DIM3` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,4)]` | `` | `pbeaml.tpl:1126` |
| `DIM4` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:1132` |
| `DIM5` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,5)]` | `` | `pbeaml.tpl:1138` |
| `DIM6` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:1144` |
| `DIM1` | `real` | `[variable13+variable14-variable15*0.5-variable16*0.5]` | `` | `pbeaml.tpl:1220` |
| `DIM2` | `real` | `[variable15*0.5+variable16*0.5]` | `` | `pbeaml.tpl:1226` |
| `DIM3` | `real` | `[variable11+variable12]` | `` | `pbeaml.tpl:1232` |
| `DIM4` | `real` | `[variable17*0.5+variable18*0.5]` | `` | `pbeaml.tpl:1238` |
| `DIM1` | `real` | `pointer1.pointervalue` | `` | `pbeaml.tpl:1270` |
| `DIM2` | `real` | `[2*variable12]` | `` | `pbeaml.tpl:1276` |
| `DIM1` | `real` | `[variable12 - variable16]` | `` | `pbeaml.tpl:1327` |
| `DIM2` | `real` | `variable16` | `` | `pbeaml.tpl:1333` |
| `DIM3` | `real` | `[variable11 - variable15 - variable14]` | `` | `pbeaml.tpl:1339` |
| `DIM4` | `real` | `variable11` | `` | `pbeaml.tpl:1345` |
| `DIM3` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:1388` |
| `DIM4` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:1394` |
| `DIM1` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,0)]` | `` | `pbeaml.tpl:1474` |
| `DIM2` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,1)]` | `` | `pbeaml.tpl:1480` |
| `DIM3` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,2)]` | `` | `pbeaml.tpl:1486` |
| `DIM4` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,3)]` | `` | `pbeaml.tpl:1492` |
| `DIM5` | `real` | `[@getentityarrayvalue(beamsects,$BeamSec,standard_ParameterInitials,4)]` | `` | `pbeaml.tpl:1498` |
| `DIM7` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,6)]` | `` | `pbeaml.tpl:1610` |
| `DIM8` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,7)]` | `` | `pbeaml.tpl:1616` |
| `DIM9` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,8)]` | `` | `pbeaml.tpl:1622` |
| `DIM10` | `real` | `[@getentityarrayvalue(beamsects,variable1,standard_ParameterInitials,9)]` | `` | `pbeaml.tpl:1628` |
| `DIM7` | `real` | `$pbeamlintDIM7` | `pbeamlintDIM7 #7347 arrayofreal` | `pbeaml.tpl:1666` |
| `DIM8` | `real` | `$pbeamlintDIM8` | `pbeamlintDIM8 #7348 arrayofreal` | `pbeaml.tpl:1672` |
| `DIM9` | `real` | `$pbeamlintDIM9` | `pbeamlintDIM9 #7349 arrayofreal` | `pbeaml.tpl:1678` |
| `DIM10` | `real` | `$pbeamlintDIM10` | `pbeamlintDIM10 #7350 arrayofreal` | `pbeaml.tpl:1684` |
| `NSM` | `real` | `$pbeamlintNSM` | `pbeamlintNSM #3197 arrayofreal` | `pbeaml.tpl:1693` |

### PBEND

- Source: `pbend.tpl:7`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`, `AltFormatOption`, `CONT1`, `CONT2`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pbend.tpl:15` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pbend.tpl:21` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `pbend.tpl:22` |
| `A` | `real` | `$PBEND_A` | `PBEND_A #2985 real` | `pbend.tpl:25` |
| `I1` | `real` | `$PBEND_I1` | `PBEND_I1 #2986 real` | `pbend.tpl:26` |
| `I2` | `real` | `$PBEND_I2` | `PBEND_I2 #2987 real` | `pbend.tpl:27` |
| `J` | `real` | `$PBEND_J` | `PBEND_J #2988 real` | `pbend.tpl:28` |
| `RB` | `real` | `$PBEND_RB` | `PBEND_RB #2989 real` | `pbend.tpl:29` |
| `THETAB` | `real` | `$PBEND_THETAB` | `PBEND_THETAB #2990 real` | `pbend.tpl:30` |
| `C1` | `real` | `$PBEND_C1` | `PBEND_C1 #2992 real` | `pbend.tpl:36` |
| `C2` | `real` | `$PBEND_C2` | `PBEND_C2 #2993 real` | `pbend.tpl:37` |
| `D1` | `real` | `$PBEND_D1` | `PBEND_D1 #2994 real` | `pbend.tpl:38` |
| `D2` | `real` | `$PBEND_D2` | `PBEND_D2 #2995 real` | `pbend.tpl:39` |
| `E1` | `real` | `$PBEND_E1` | `PBEND_E1 #2996 real` | `pbend.tpl:40` |
| `E2` | `real` | `$PBEND_E2` | `PBEND_E2 #2997 real` | `pbend.tpl:41` |
| `F1` | `real` | `$PBEND_F1` | `PBEND_F1 #2998 real` | `pbend.tpl:42` |
| `F2` | `real` | `$PBEND_F2` | `PBEND_F2 #2999 real` | `pbend.tpl:43` |
| `K1` | `real` | `$PBEND_K1` | `PBEND_K1 #3001 real` | `pbend.tpl:49` |
| `K2` | `real` | `$PBEND_K2` | `PBEND_K2 #3002 real` | `pbend.tpl:50` |
| `NSM` | `real` | `$PBEND_NSM` | `PBEND_NSM #3003 real` | `pbend.tpl:51` |
| `RC` | `real` | `$PBEND_RC` | `PBEND_RC #3004 real` | `pbend.tpl:52` |
| `ZC` | `real` | `$PBEND_ZC` | `PBEND_ZC #3005 real` | `pbend.tpl:53` |
| `DELTAN` | `real` | `$PBEND_DELTAN` | `PBEND_DELTAN #3006 real` | `pbend.tpl:54` |
| `FSI` | `integer` | `$PBEND_FSI` | `PBEND_FSI #3008 integer` | `pbend.tpl:58` |
| `RM` | `real` | `$PBEND_RM` | `PBEND_RM #3009 real` | `pbend.tpl:59` |
| `T` | `real` | `$PBEND_T` | `PBEND_T #3010 real` | `pbend.tpl:60` |
| `P` | `real` | `$PBEND_P` | `PBEND_P #3011 real` | `pbend.tpl:61` |

### PBUSH

- Source: `pbush.tpl:7`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`, `K_LINE`, `B_LINE`, `RCV_LINE`, `GE_LINE`, `PBUSHT`, `KN_LINE`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pbush.tpl:15` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pbush.tpl:22` |
| `K1` | `real` | `$K1` | `K1 #845 real` | `pbush.tpl:27` |
| `K2` | `real` | `$K2` | `K2 #846 real` | `pbush.tpl:30` |
| `K3` | `real` | `$K3` | `K3 #847 real` | `pbush.tpl:33` |
| `K4` | `real` | `$K4` | `K4 #848 real` | `pbush.tpl:36` |
| `K5` | `real` | `$K5` | `K5 #849 real` | `pbush.tpl:39` |
| `K6` | `real` | `$K6` | `K6 #850 real` | `pbush.tpl:42` |
| `B1` | `real` | `$B1` | `B1 #851 real` | `pbush.tpl:55` |
| `B2` | `real` | `$B2` | `B2 #852 real` | `pbush.tpl:58` |
| `B3` | `real` | `$B3` | `B3 #853 real` | `pbush.tpl:61` |
| `B4` | `real` | `$B4` | `B4 #854 real` | `pbush.tpl:64` |
| `B5` | `real` | `$B5` | `B5 #855 real` | `pbush.tpl:67` |
| `B6` | `real` | `$B6` | `B6 #856 real` | `pbush.tpl:70` |
| `SA` | `real` | `$SA` | `SA #859 real` | `pbush.tpl:83` |
| `ST` | `real` | `$ST` | `ST #860 real` | `pbush.tpl:86` |
| `EA` | `real` | `$EA` | `EA #861 real` | `pbush.tpl:89` |
| `ET` | `real` | `$ET` | `ET #862 real` | `pbush.tpl:92` |
| `GE1` | `real` | `$GE1` | `GE1 #858 real` | `pbush.tpl:105` |
| `GE2` | `real` | `$PBUSH_GE2` | `PBUSH_GE2 #4074 real` | `pbush.tpl:109` |
| `GE3` | `real` | `$PBUSH_GE3` | `PBUSH_GE3 #4075 real` | `pbush.tpl:112` |
| `GE4` | `real` | `$PBUSH_GE4` | `PBUSH_GE4 #4076 real` | `pbush.tpl:114` |
| `GE5` | `real` | `$PBUSH_GE5` | `PBUSH_GE5 #4077 real` | `pbush.tpl:117` |
| `GE6` | `real` | `$PBUSH_GE6` | `PBUSH_GE6 #4078 real` | `pbush.tpl:120` |
| `TKID1` | `entity` | `$PBUSHT_TKID1` | `PBUSHT_TKID1 #4329 entity` | `pbush.tpl:139` |
| `TKID2` | `entity` | `$PBUSHT_TKID2` | `PBUSHT_TKID2 #4332 entity` | `pbush.tpl:142` |
| `TKID3` | `entity` | `$PBUSHT_TKID3` | `PBUSHT_TKID3 #4335 entity` | `pbush.tpl:145` |
| `TKID4` | `entity` | `$PBUSHT_TKID4` | `PBUSHT_TKID4 #4338 entity` | `pbush.tpl:148` |
| `TKID5` | `entity` | `$PBUSHT_TKID5` | `PBUSHT_TKID5 #4341 entity` | `pbush.tpl:151` |
| `TKID6` | `entity` | `$PBUSHT_TKID6` | `PBUSHT_TKID6 #4344 entity` | `pbush.tpl:154` |
| `TBID1` | `entity` | `$PBUSHT_TBID1` | `PBUSHT_TBID1 #4330 entity` | `pbush.tpl:167` |
| `TBID2` | `entity` | `$PBUSHT_TBID2` | `PBUSHT_TBID2 #4333 entity` | `pbush.tpl:170` |
| `TBID3` | `entity` | `$PBUSHT_TBID3` | `PBUSHT_TBID3 #4336 entity` | `pbush.tpl:173` |
| `TBID4` | `entity` | `$PBUSHT_TBID4` | `PBUSHT_TBID4 #4339 entity` | `pbush.tpl:176` |
| `TBID5` | `entity` | `$PBUSHT_TBID5` | `PBUSHT_TBID5 #4342 entity` | `pbush.tpl:179` |
| `TBID6` | `entity` | `$PBUSHT_TBID6` | `PBUSHT_TBID6 #4345 entity` | `pbush.tpl:182` |
| `TGEID1` | `entity` | `$PBUSHT_TGEID1` | `PBUSHT_TGEID1 #4490 entity` | `pbush.tpl:195` |
| `TGEID2` | `entity` | `$PBUSHT_TGEID2` | `PBUSHT_TGEID2 #4491 entity` | `pbush.tpl:198` |
| `TGEID3` | `entity` | `$PBUSHT_TGEID3` | `PBUSHT_TGEID3 #4492 entity` | `pbush.tpl:202` |
| `TGEID4` | `entity` | `$PBUSHT_TGEID4` | `PBUSHT_TGEID4 #4493 entity` | `pbush.tpl:206` |
| `TGEID5` | `entity` | `$PBUSHT_TGEID5` | `PBUSHT_TGEID5 #4494 entity` | `pbush.tpl:210` |
| `TGEID6` | `entity` | `$PBUSHT_TGEID6` | `PBUSHT_TGEID6 #4495 entity` | `pbush.tpl:214` |
| `TKNID1` | `entity` | `$PBUSHT_TKNID1` | `PBUSHT_TKNID1 #4331 entity` | `pbush.tpl:227` |
| `TKNID2` | `entity` | `$PBUSHT_TKNID2` | `PBUSHT_TKNID2 #4334 entity` | `pbush.tpl:230` |
| `TKNID3` | `entity` | `$PBUSHT_TKNID3` | `PBUSHT_TKNID3 #4337 entity` | `pbush.tpl:233` |
| `TKNID4` | `entity` | `$PBUSHT_TKNID4` | `PBUSHT_TKNID4 #4340 entity` | `pbush.tpl:236` |
| `TKNID5` | `entity` | `$PBUSHT_TKNID5` | `PBUSHT_TKNID5 #4343 entity` | `pbush.tpl:239` |
| `TKNID6` | `entity` | `$PBUSHT_TKNID6` | `PBUSHT_TKNID6 #4346 entity` | `pbush.tpl:242` |

### PBUSH1D

- Source: `pbush1d.tpl:6`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`, `SHOCKA_LINE`, `SPRING_LINE`, `DAMPER_LINE`, `GENER_LINE`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pbush1d.tpl:14` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pbush1d.tpl:21` |
| `K` | `real` | `$PBUSH1D_K` | `PBUSH1D_K #4410 real` | `pbush1d.tpl:22` |
| `C` | `real` | `$PBUSH1D_C` | `PBUSH1D_C #4380 real` | `pbush1d.tpl:24` |
| `M` | `real` | `$PBUSH1D_M` | `PBUSH1D_M #4381 real` | `pbush1d.tpl:26` |
| `SA` | `real` | `$PBUSH1D_SA` | `PBUSH1D_SA #4382 real` | `pbush1d.tpl:29` |
| `SE` | `real` | `$PBUSH1D_SE` | `PBUSH1D_SE #4383 real` | `pbush1d.tpl:31` |
| `TYPE` | `string` | `$SHOCKA_TYPE` | `SHOCKA_TYPE #4384 string` | `pbush1d.tpl:41` |
| `CVT` | `real` | `$PBUSH1D_CVT` | `PBUSH1D_CVT #4385 real` | `pbush1d.tpl:45` |
| `CVC` | `real` | `$PBUSH1D_CVC` | `PBUSH1D_CVC #4386 real` | `pbush1d.tpl:47` |
| `EXPVT` | `real` | `$PBUSH1D_EXPVT` | `PBUSH1D_EXPVT #4387 real` | `pbush1d.tpl:49` |
| `EXPVC` | `real` | `$PBUSH1D_EXPVC` | `PBUSH1D_EXPVC #4388 real` | `pbush1d.tpl:51` |
| `IDTS` | `entity` | `$PBUSH1D_IDTS` | `PBUSH1D_IDTS #4389 entity` | `pbush1d.tpl:54` |
| `IDETS` | `entity` | `$PBUSH1D_IDETS` | `PBUSH1D_IDETS #4390 entity` | `pbush1d.tpl:61` |
| `IDECS` | `entity` | `$PBUSH1D_IDECS` | `PBUSH1D_IDECS #4391 entity` | `pbush1d.tpl:64` |
| `IDETSD` | `entity` | `$PBUSH1D_IDETSD` | `PBUSH1D_IDETSD #4392 entity` | `pbush1d.tpl:67` |
| `IDECSD` | `entity` | `$PBUSH1D_IDECSD` | `PBUSH1D_IDECSD #4393 entity` | `pbush1d.tpl:70` |
| `TYPE` | `string` | `$SPRING_TYPE` | `SPRING_TYPE #4394 string` | `pbush1d.tpl:85` |
| `IDT` | `entity` | `$SPRING_IDT` | `SPRING_IDT #4395 entity` | `pbush1d.tpl:90` |
| `IDT` | `entity` | `$SPRINGDEQ_IDT` | `SPRINGDEQ_IDT #4464 entity` | `pbush1d.tpl:94` |
| `IDC` | `entity` | `$SPRING_IDC` | `SPRING_IDC #4396 entity` | `pbush1d.tpl:98` |
| `IDTDU` | `entity` | `$SPRING_IDTDU` | `SPRING_IDTDU #4397 entity` | `pbush1d.tpl:101` |
| `IDCDU` | `entity` | `$SPRING_IDCDU` | `SPRING_IDCDU #4398 entity` | `pbush1d.tpl:104` |
| `TYPE` | `string` | `$DAMPER_TYPE` | `DAMPER_TYPE #4399 string` | `pbush1d.tpl:117` |
| `IDT` | `entity` | `$DAMPER_IDT` | `DAMPER_IDT #4400 entity` | `pbush1d.tpl:122` |
| `IDT` | `entity` | `$DAMPERDEQ_IDT` | `DAMPERDEQ_IDT #4465 entity` | `pbush1d.tpl:126` |
| `IDC` | `entity` | `$DAMPER_IDC` | `DAMPER_IDC #4401 entity` | `pbush1d.tpl:130` |
| `IDTDV` | `entity` | `$DAMPER_IDTDV` | `DAMPER_IDTDV #4402 entity` | `pbush1d.tpl:134` |
| `IDCDV` | `entity` | `$DAMPER_IDCDV` | `DAMPER_IDCDV #4403 entity` | `pbush1d.tpl:138` |
| `IDT` | `entity` | `$GENER_IDT` | `GENER_IDT #4404 entity` | `pbush1d.tpl:154` |
| `IDC` | `entity` | `$GENER_IDC` | `GENER_IDC #4405 entity` | `pbush1d.tpl:158` |
| `IDTDU` | `entity` | `$GENER_IDTDU` | `GENER_IDTDU #4406 entity` | `pbush1d.tpl:162` |
| `IDCDU` | `entity` | `$GENER_IDCDU` | `GENER_IDCDU #4407 entity` | `pbush1d.tpl:166` |
| `IDTDV` | `entity` | `$GENER_IDTDV` | `GENER_IDTDV #4408 entity` | `pbush1d.tpl:170` |
| `IDCDV` | `entity` | `$GENER_IDCDV` | `GENER_IDCDV #4409 entity` | `pbush1d.tpl:173` |

### PCOMP

- Source: `properties.tpl:3360`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`, `PSHLN1`, `C3`, `C4`, `C6`, `C8`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:3368` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:3374` |
| `Z0` | `real` | `$PCOMP_Z0` | `PCOMP_Z0 #3014 real` | `properties.tpl:3375` |
| `NSM` | `real` | `$PCOMP_NSM` | `PCOMP_NSM #3015 real` | `properties.tpl:3377` |
| `SB` | `real` | `$PCOMP_SB` | `PCOMP_SB #3016 real` | `properties.tpl:3379` |
| `FT` | `string` | `$PCOMP_FT` | `PCOMP_FT #3017 string` | `properties.tpl:3381` |
| `TREF` | `real` | `$PCOMP_TREF` | `PCOMP_TREF #3018 real` | `properties.tpl:3387` |
| `GE` | `real` | `$PCOMP_GE` | `PCOMP_GE #3019 real` | `properties.tpl:3389` |
| `LAM` | `string` | `$PCOMP_LAM` | `PCOMP_LAM #3020 string` | `properties.tpl:3391` |
| `MID` | `arrayofentity` | `$PCOMP_MID` | `PCOMP_MID #3023 arrayofentity` | `properties.tpl:3418` |
| `T` | `real` | `$PCOMP_T` | `PCOMP_T #3024 arrayofreal` | `properties.tpl:3421` |
| `THETA` | `real` | `$PCOMP_THETA` | `PCOMP_THETA #3025 arrayofreal` | `properties.tpl:3422` |
| `SOUT` | `string` | `$PCOMP_SOUT` | `PCOMP_SOUT #3026 arrayofstring` | `properties.tpl:3423` |
| `MID1` | `integer` | `$PSHLN1_MID1` | `PSHLN1_MID1 #1676 entity` | `pshln1_menu.tpl:8` |
| `MID2` | `integer` | `$PSHLN1_MID2` | `PSHLN1_MID2 #1677 entity` | `pshln1_menu.tpl:11` |
| `ANAL` | `string` | `$PSHLN1_ANAL` | `PSHLN1_ANAL #1678 string` | `pshln1_menu.tpl:15` |
| `BEH3` | `string` | `$PSHLN1_BEH3` | `PSHLN1_BEH3 #1680 string` | `pshln1_menu.tpl:27` |
| `INT3` | `string` | `$PSHLN1_INT3` | `PSHLN1_INT3 #1681 string` | `pshln1_menu.tpl:30` |
| `BEH3H` | `string` | `$PSHLN1_BEH3H` | `PSHLN1_BEH3H #1682 string` | `pshln1_menu.tpl:33` |
| `INT3H` | `string` | `$PSHLN1_INT3H` | `PSHLN1_INT3H #1683 string` | `pshln1_menu.tpl:36` |
| `BEH4` | `string` | `$PSHLN1_BEH4` | `PSHLN1_BEH4 #1685 string` | `pshln1_menu.tpl:46` |
| `INT4` | `string` | `$PSHLN1_INT4` | `PSHLN1_INT4 #1686 string` | `pshln1_menu.tpl:49` |
| `BEH4H` | `string` | `$PSHLN1_BEH4H` | `PSHLN1_BEH4H #1687 string` | `pshln1_menu.tpl:52` |
| `INT4H` | `string` | `$PSHLN1_INT4H` | `PSHLN1_INT4H #1688 string` | `pshln1_menu.tpl:55` |
| `BEH6` | `string` | `$PSHLN1_BEH6` | `PSHLN1_BEH6 #1690 string` | `pshln1_menu.tpl:65` |
| `INT6` | `string` | `$PSHLN1_INT6` | `PSHLN1_INT6 #1691 string` | `pshln1_menu.tpl:68` |
| `BEH6H` | `string` | `$PSHLN1_BEH6H` | `PSHLN1_BEH6H #1692 string` | `pshln1_menu.tpl:71` |
| `INT6H` | `string` | `$PSHLN1_INT6H` | `PSHLN1_INT6H #1693 string` | `pshln1_menu.tpl:74` |
| `BEH8` | `string` | `$PSHLN1_BEH8` | `PSHLN1_BEH8 #1695 string` | `pshln1_menu.tpl:84` |
| `INT8` | `string` | `$PSHLN1_INT8` | `PSHLN1_INT8 #1696 string` | `pshln1_menu.tpl:87` |
| `BEH8H` | `string` | `$PSHLN1_BEH8H` | `PSHLN1_BEH8H #1697 string` | `pshln1_menu.tpl:90` |
| `INT8H` | `string` | `$PSHLN1_INT8H` | `PSHLN1_INT8H #1698 string` | `pshln1_menu.tpl:93` |

### PCOMPG

- Source: `properties.tpl:3551`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`, `PSHLN1`, `C3`, `C4`, `C6`, `C8`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:3559` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:3565` |
| `Z0` | `real` | `$PCOMP_Z0` | `PCOMP_Z0 #3014 real` | `properties.tpl:3566` |
| `NSM` | `real` | `$PCOMP_NSM` | `PCOMP_NSM #3015 real` | `properties.tpl:3568` |
| `SB` | `real` | `$PCOMP_SB` | `PCOMP_SB #3016 real` | `properties.tpl:3570` |
| `FT` | `string` | `$PCOMP_FT` | `PCOMP_FT #3017 string` | `properties.tpl:3572` |
| `TREF` | `real` | `$PCOMP_TREF` | `PCOMP_TREF #3018 real` | `properties.tpl:3578` |
| `GE` | `real` | `$PCOMP_GE` | `PCOMP_GE #3019 real` | `properties.tpl:3580` |
| `LAM` | `string` | `$PCOMP_LAM` | `PCOMP_LAM #3020 string` | `properties.tpl:3582` |
| `GPLYID` | `arrayofinteger` | `$PCOMPG_GPLYID` | `PCOMPG_GPLYID #4703 arrayofinteger` | `properties.tpl:3608` |
| `MID` | `arrayofentity` | `$PCOMP_MID` | `PCOMP_MID #3023 arrayofentity` | `properties.tpl:3609` |
| `T` | `real` | `$PCOMP_T` | `PCOMP_T #3024 arrayofreal` | `properties.tpl:3611` |
| `THETA` | `real` | `$PCOMP_THETA` | `PCOMP_THETA #3025 arrayofreal` | `properties.tpl:3612` |
| `SOUT` | `string` | `$PCOMP_SOUT` | `PCOMP_SOUT #3026 arrayofstring` | `properties.tpl:3613` |
| `MID1` | `integer` | `$PSHLN1_MID1` | `PSHLN1_MID1 #1676 entity` | `pshln1_menu.tpl:8` |
| `MID2` | `integer` | `$PSHLN1_MID2` | `PSHLN1_MID2 #1677 entity` | `pshln1_menu.tpl:11` |
| `ANAL` | `string` | `$PSHLN1_ANAL` | `PSHLN1_ANAL #1678 string` | `pshln1_menu.tpl:15` |
| `BEH3` | `string` | `$PSHLN1_BEH3` | `PSHLN1_BEH3 #1680 string` | `pshln1_menu.tpl:27` |
| `INT3` | `string` | `$PSHLN1_INT3` | `PSHLN1_INT3 #1681 string` | `pshln1_menu.tpl:30` |
| `BEH3H` | `string` | `$PSHLN1_BEH3H` | `PSHLN1_BEH3H #1682 string` | `pshln1_menu.tpl:33` |
| `INT3H` | `string` | `$PSHLN1_INT3H` | `PSHLN1_INT3H #1683 string` | `pshln1_menu.tpl:36` |
| `BEH4` | `string` | `$PSHLN1_BEH4` | `PSHLN1_BEH4 #1685 string` | `pshln1_menu.tpl:46` |
| `INT4` | `string` | `$PSHLN1_INT4` | `PSHLN1_INT4 #1686 string` | `pshln1_menu.tpl:49` |
| `BEH4H` | `string` | `$PSHLN1_BEH4H` | `PSHLN1_BEH4H #1687 string` | `pshln1_menu.tpl:52` |
| `INT4H` | `string` | `$PSHLN1_INT4H` | `PSHLN1_INT4H #1688 string` | `pshln1_menu.tpl:55` |
| `BEH6` | `string` | `$PSHLN1_BEH6` | `PSHLN1_BEH6 #1690 string` | `pshln1_menu.tpl:65` |
| `INT6` | `string` | `$PSHLN1_INT6` | `PSHLN1_INT6 #1691 string` | `pshln1_menu.tpl:68` |
| `BEH6H` | `string` | `$PSHLN1_BEH6H` | `PSHLN1_BEH6H #1692 string` | `pshln1_menu.tpl:71` |
| `INT6H` | `string` | `$PSHLN1_INT6H` | `PSHLN1_INT6H #1693 string` | `pshln1_menu.tpl:74` |
| `BEH8` | `string` | `$PSHLN1_BEH8` | `PSHLN1_BEH8 #1695 string` | `pshln1_menu.tpl:84` |
| `INT8` | `string` | `$PSHLN1_INT8` | `PSHLN1_INT8 #1696 string` | `pshln1_menu.tpl:87` |
| `BEH8H` | `string` | `$PSHLN1_BEH8H` | `PSHLN1_BEH8H #1697 string` | `pshln1_menu.tpl:90` |
| `INT8H` | `string` | `$PSHLN1_INT8H` | `PSHLN1_INT8H #1698 string` | `pshln1_menu.tpl:93` |

### PCOMPLS

- Source: `properties.tpl:3067`
- ID pool: `THREE_IDPOOL`
- Options/subcards: `User Comments`, `CORDM options`, `C8`, `C20`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:3075` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:3081` |
| `DIRECT` | `integer` | `$PCOMPLS_DIRECT` | `PCOMPLS_DIRECT #10399 integer` | `properties.tpl:3082` |
| `CORDM` | `entity` | `$PCOMPLS_CORDM` | `PCOMPLS_CORDM #10400 entity` | `properties.tpl:3097` |
| `SB` | `real` | `$PCOMPLS_SB` | `PCOMPLS_SB #10401 real` | `properties.tpl:3102` |
| `ANAL` | `string` | `$PCOMPLS_ANAL` | `PCOMPLS_ANAL #10402 string` | `properties.tpl:3106` |
| `BEH8` | `string` | `$PCOMPLS_BEH8` | `PCOMPLS_BEH8 #10403 string` | `properties.tpl:3120` |
| `INT8` | `string` | `$PCOMPLS_INT8` | `PCOMPLS_INT8 #10404 string` | `properties.tpl:3124` |
| `BEH8H` | `string` | `$PCOMPLS_BEH8H` | `PCOMPLS_BEH8H #10405 string` | `properties.tpl:3130` |
| `INT8H` | `string` | `$PCOMPLS_INT8H` | `PCOMPLS_INT8H #10406 string` | `properties.tpl:3135` |
| `BEH20` | `string` | `$PCOMPLS_BEH20` | `PCOMPLS_BEH20 #10407 string` | `properties.tpl:3149` |
| `INT20` | `string` | `$PCOMPLS_INT20` | `PCOMPLS_INT20 #10408 string` | `properties.tpl:3153` |
| `BEH20H` | `string` | `$PCOMPLS_BEH20H` | `PCOMPLS_BEH20H #10409 string` | `properties.tpl:3159` |
| `INT20H` | `string` | `$PCOMPLS_INT20H` | `PCOMPLS_INT20H #10410 string` | `properties.tpl:3164` |
| `ID` | `integer` | `$PCOMPLS_ID_ARRAY` | `PCOMPLS_ID_ARRAY #10412 arrayofinteger` | `properties.tpl:3175` |
| `MID` | `entity` | `$PCOMPLS_MID_ARRAY` | `PCOMPLS_MID_ARRAY #10413 arrayofentity` | `properties.tpl:3177` |
| `T` | `real` | `$PCOMPLS_T_ARRAY` | `PCOMPLS_T_ARRAY #10414 arrayofreal` | `properties.tpl:3179` |
| `THETA` | `real` | `$PCOMPLS_THETA_ARRAY` | `PCOMPLS_THETA_ARRAY #10415 arrayofreal` | `properties.tpl:3182` |

### PCOMPP

- Source: `properties.tpl:3328`
- ID pool: `TWO_IDPOOL`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `RealizedCard` | `string` | `$PropertyCard` | `PropertyCard #7079 string` | `properties.tpl:3331` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:3337` |
| `Z0` | `real` | `$PCOMP_Z0` | `PCOMP_Z0 #3014 real` | `properties.tpl:3338` |
| `NSM` | `real` | `$PCOMP_NSM` | `PCOMP_NSM #3015 real` | `properties.tpl:3340` |
| `SB` | `real` | `$PCOMP_SB` | `PCOMP_SB #3016 real` | `properties.tpl:3342` |
| `FT` | `string` | `$PCOMP_FT` | `PCOMP_FT #3017 string` | `properties.tpl:3344` |
| `TREF` | `real` | `$PCOMP_TREF` | `PCOMP_TREF #3018 real` | `properties.tpl:3350` |
| `GE` | `real` | `$PCOMP_GE` | `PCOMP_GE #3019 real` | `properties.tpl:3352` |

### PCONVM

- Source: `properties.tpl:5018`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:5026` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:5033` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:5034` |
| `FORM` | `integer` | `$PCONVM_FORM` | `PCONVM_FORM #2007 integer` | `properties.tpl:5035` |
| `FLAG` | `integer` | `$PCONVM_FLAG` | `PCONVM_FLAG #2006 integer` | `properties.tpl:5043` |
| `COEF` | `real` | `$PCONVM_COEF` | `PCONVM_COEF #2005 real` | `properties.tpl:5047` |
| `EXPR` | `real` | `$PCONVM_EXPR` | `PCONVM_EXPR #2004 real` | `properties.tpl:5049` |
| `EXPPI` | `real` | `$PCONVM_EXPPI` | `PCONVM_EXPPI #2003 real` | `properties.tpl:5052` |
| `EXPPO` | `real` | `$PCONVM_EXPPO` | `PCONVM_EXPPO #2002 real` | `properties.tpl:5055` |

### PDAMP

- Source: `pdamp_c.tpl:10`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pdamp_c.tpl:18` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pdamp_c.tpl:24` |
| `B` | `real` | `$PDAMP_B` | `PDAMP_B #252 real` | `pdamp_c.tpl:25` |

### PELAS

- Source: `pelas.tpl:7`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`, `PELAST`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pelas.tpl:15` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pelas.tpl:21` |
| `K1` | `real` | `$PELAS_K` | `PELAS_K #84 real` | `pelas.tpl:22` |
| `GE1` | `real` | `$PELAS_GE` | `PELAS_GE #85 real` | `pelas.tpl:23` |
| `S1` | `real` | `$PELAS_S` | `PELAS_S #86 real` | `pelas.tpl:24` |
| `TKID` | `entity` | `$PELAST_TKID` | `PELAST_TKID #4467 entity` | `pelas.tpl:32` |
| `TGEID` | `entity` | `$PELAST_TGEID` | `PELAST_TGEID #4468 entity` | `pelas.tpl:35` |
| `TKNID` | `entity` | `$PELAST_TKNID` | `PELAST_TKNID #4469 entity` | `pelas.tpl:38` |

### PFAST

- Source: `properties.tpl:4859`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`, `MCID`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:4867` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:4874` |
| `D` | `real` | `$PFAST_DIA` | `PFAST_DIA #7602 real` | `properties.tpl:4875` |
| `MCID` | `integer` | `-1` | `` | `properties.tpl:4883` |
| `MCID` | `integer` | `$PFAST_MCID` | `PFAST_MCID #7603 entity` | `properties.tpl:4887` |
| `MFLAG` | `integer` | `$PFAST_MFLAG` | `PFAST_MFLAG #7604 integer` | `properties.tpl:4890` |
| `KT1` | `real` | `$PFAST_KT1` | `PFAST_KT1 #7605 real` | `properties.tpl:4893` |
| `KT2` | `real` | `$PFAST_KT2` | `PFAST_KT2 #7606 real` | `properties.tpl:4894` |
| `KT3` | `real` | `$PFAST_KT3` | `PFAST_KT3 #7607 real` | `properties.tpl:4895` |
| `KR1` | `real` | `$PFAST_KR1` | `PFAST_KR1 #7608 real` | `properties.tpl:4896` |
| `KR2` | `real` | `$PFAST_KR2` | `PFAST_KR2 #7609 real` | `properties.tpl:4901` |
| `KR3` | `real` | `$PFAST_KR3` | `PFAST_KR3 #7610 real` | `properties.tpl:4904` |
| `MASS` | `real` | `$PFAST_MASS` | `PFAST_MASS #7611 real` | `properties.tpl:4907` |
| `GE` | `real` | `$PFAST_GE` | `PFAST_GE #7612 real` | `properties.tpl:4910` |

### PGAP

- Source: `pgap.tpl:7`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`, `CONT`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pgap.tpl:15` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pgap.tpl:21` |
| `U0` | `real` | `$PGAP_U0` | `PGAP_U0 #254 real` | `pgap.tpl:22` |
| `F0` | `real` | `$PGAP_F0` | `PGAP_F0 #255 real` | `pgap.tpl:23` |
| `KA` | `real` | `$PGAP_KA` | `PGAP_KA #256 real` | `pgap.tpl:25` |
| `KB` | `real` | `$PGAP_KB` | `PGAP_KB #257 real` | `pgap.tpl:26` |
| `KT` | `real` | `$PGAP_KT` | `PGAP_KT #258 real` | `pgap.tpl:28` |
| `MU1` | `real` | `$PGAP_MU1` | `PGAP_MU1 #259 real` | `pgap.tpl:30` |
| `MU2` | `real` | `$PGAP_MU2` | `PGAP_MU2 #260 real` | `pgap.tpl:31` |
| `TMAX` | `real` | `$PGAP_TMAX` | `PGAP_TMAX #263 real` | `pgap.tpl:38` |
| `MAR` | `real` | `$PGAP_MAR` | `PGAP_MAR #261 real` | `pgap.tpl:39` |
| `TRMIN` | `real` | `$PGAP_TRMIN` | `PGAP_TRMIN #262 real` | `pgap.tpl:42` |

### PHBDY

- Source: `properties.tpl:5143`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:5151` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:5158` |
| `AF` | `real` | `$PHBDY_AF` | `PHBDY_AF #1891 real` | `properties.tpl:5159` |
| `D1` | `real` | `$PHBDY_D1` | `PHBDY_D1 #1894 real` | `properties.tpl:5162` |
| `D2` | `real` | `$PHBDY_D2` | `PHBDY_D2 #1895 real` | `properties.tpl:5165` |

### PLPLANE

- Source: `properties.tpl:2419`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:2427` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:2433` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2434` |
| `CID` | `entity` | `$PLPLANE_CID` | `PLPLANE_CID #10055 entity` | `properties.tpl:2435` |
| `STR` | `string` | `$PLPLANE_STR` | `PLPLANE_STR #10056 string` | `properties.tpl:2438` |

### PLSOLID

- Source: `properties.tpl:3722`
- ID pool: `THREE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:3731` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:3738` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:3739` |
| `STR` | `string` | `$PLSOLID_STR` | `PLSOLID_STR #4416 string` | `properties.tpl:3740` |

### PMASS

- Source: `propert_c.tpl:135`
- ID pool: `ZEROD_AND_RIGIDS_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `propert_c.tpl:143` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `propert_c.tpl:149` |
| `M` | `real` | `$PMASS_M` | `PMASS_M #4646 real` | `propert_c.tpl:150` |

### PROD

- Source: `properties.tpl:4712`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:4720` |
| `beamsec` | `entity` | `$BeamSec` | `BeamSec #3179 entity` | `properties.tpl:4726` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:4731` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:4732` |
| `A` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_area)]` | `` | `properties.tpl:4734` |
| `J` | `real` | `[@getentityvalue(beamsects,$BeamSec,results_J)]` | `` | `properties.tpl:4735` |
| `A` | `real` | `$PROD_A` | `PROD_A #64 real` | `properties.tpl:4738` |
| `J` | `real` | `$PROD_J` | `PROD_J #65 real` | `properties.tpl:4741` |
| `C` | `real` | `$PROD_C` | `PROD_C #66 real` | `properties.tpl:4745` |
| `NSM` | `real` | `$PROD_NSM` | `PROD_NSM #67 real` | `properties.tpl:4748` |

### PSEAM

- Source: `properties.tpl:5239`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:5247` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:5254` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:5255` |
| `TYPE` | `string` | `$PSEAM_TYPE` | `PSEAM_TYPE #7630 string` | `properties.tpl:5256` |
| `W` | `real` | `$PSEAM_W` | `PSEAM_W #7631 real` | `properties.tpl:5260` |
| `T` | `real` | `$PSEAM_T` | `PSEAM_T #7632 real` | `properties.tpl:5261` |

### PSHEAR

- Source: `propert_c.tpl:8`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `propert_c.tpl:16` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `propert_c.tpl:22` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `propert_c.tpl:23` |
| `T` | `real` | `$PSHEAR_T` | `PSHEAR_T #91 real` | `propert_c.tpl:24` |
| `NSM` | `real` | `$PSHEAR_NSM` | `PSHEAR_NSM #92 real` | `propert_c.tpl:27` |
| `F1` | `real` | `$PSHEAR_F1` | `PSHEAR_F1 #93 real` | `propert_c.tpl:30` |
| `F2` | `real` | `$PSHEAR_F2` | `PSHEAR_F2 #94 real` | `propert_c.tpl:33` |

### PSHELL

- Source: `properties.tpl:2043`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`, `MID1_blank`, `MID2_opts`, `MID3_opts`, `PSHLN1`, `C3`, `C4`, `C6`, `C8`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:2051` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:2057` |
| `MID1` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2060` |
| `T` | `real` | `$PSHELL_T` | `PSHELL_T #95 real` | `properties.tpl:2064` |
| `MID2` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2068` |
| `MID2` | `integer` | `$MID2` | `MID2 #829 entity` | `properties.tpl:2072` |
| `I12_T3` | `real` | `$PSHELL_I12_T3` | `PSHELL_I12_T3 #114 real` | `properties.tpl:2081` |
| `MID3` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2085` |
| `MID3` | `integer` | `$MID3` | `MID3 #830 entity` | `properties.tpl:2089` |
| `TS_T` | `real` | `$PSHELL_TS_T` | `PSHELL_TS_T #116 real` | `properties.tpl:2096` |
| `NSM` | `real` | `$PSHELL_NSM` | `PSHELL_NSM #96 real` | `properties.tpl:2098` |
| `Z1` | `real` | `$PSHELL_Z1` | `PSHELL_Z1 #119 real` | `properties.tpl:2104` |
| `Z2` | `real` | `$PSHELL_Z2` | `PSHELL_Z2 #120 real` | `properties.tpl:2106` |
| `MID4` | `integer` | `$MID4` | `MID4 #831 entity` | `properties.tpl:2108` |
| `MID1` | `integer` | `$PSHLN1_MID1` | `PSHLN1_MID1 #1676 entity` | `pshln1_menu.tpl:8` |
| `MID2` | `integer` | `$PSHLN1_MID2` | `PSHLN1_MID2 #1677 entity` | `pshln1_menu.tpl:11` |
| `ANAL` | `string` | `$PSHLN1_ANAL` | `PSHLN1_ANAL #1678 string` | `pshln1_menu.tpl:15` |
| `BEH3` | `string` | `$PSHLN1_BEH3` | `PSHLN1_BEH3 #1680 string` | `pshln1_menu.tpl:27` |
| `INT3` | `string` | `$PSHLN1_INT3` | `PSHLN1_INT3 #1681 string` | `pshln1_menu.tpl:30` |
| `BEH3H` | `string` | `$PSHLN1_BEH3H` | `PSHLN1_BEH3H #1682 string` | `pshln1_menu.tpl:33` |
| `INT3H` | `string` | `$PSHLN1_INT3H` | `PSHLN1_INT3H #1683 string` | `pshln1_menu.tpl:36` |
| `BEH4` | `string` | `$PSHLN1_BEH4` | `PSHLN1_BEH4 #1685 string` | `pshln1_menu.tpl:46` |
| `INT4` | `string` | `$PSHLN1_INT4` | `PSHLN1_INT4 #1686 string` | `pshln1_menu.tpl:49` |
| `BEH4H` | `string` | `$PSHLN1_BEH4H` | `PSHLN1_BEH4H #1687 string` | `pshln1_menu.tpl:52` |
| `INT4H` | `string` | `$PSHLN1_INT4H` | `PSHLN1_INT4H #1688 string` | `pshln1_menu.tpl:55` |
| `BEH6` | `string` | `$PSHLN1_BEH6` | `PSHLN1_BEH6 #1690 string` | `pshln1_menu.tpl:65` |
| `INT6` | `string` | `$PSHLN1_INT6` | `PSHLN1_INT6 #1691 string` | `pshln1_menu.tpl:68` |
| `BEH6H` | `string` | `$PSHLN1_BEH6H` | `PSHLN1_BEH6H #1692 string` | `pshln1_menu.tpl:71` |
| `INT6H` | `string` | `$PSHLN1_INT6H` | `PSHLN1_INT6H #1693 string` | `pshln1_menu.tpl:74` |
| `BEH8` | `string` | `$PSHLN1_BEH8` | `PSHLN1_BEH8 #1695 string` | `pshln1_menu.tpl:84` |
| `INT8` | `string` | `$PSHLN1_INT8` | `PSHLN1_INT8 #1696 string` | `pshln1_menu.tpl:87` |
| `BEH8H` | `string` | `$PSHLN1_BEH8H` | `PSHLN1_BEH8H #1697 string` | `pshln1_menu.tpl:90` |
| `INT8H` | `string` | `$PSHLN1_INT8H` | `PSHLN1_INT8H #1698 string` | `pshln1_menu.tpl:93` |

### PSHELL1

- Source: `properties.tpl:2268`
- ID pool: `TWO_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:2276` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:2282` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2283` |
| `FORM` | `string` | `$PSHELL1_FORM` | `PSHELL1_FORM #7190 string` | `properties.tpl:2284` |
| `QUAD` | `string` | `$PSHELL1_QUAD` | `PSHELL1_QUAD #7191 string` | `properties.tpl:2290` |
| `NUMB` | `integer` | `$PSHELL1_NUMB` | `PSHELL1_NUMB #7192 integer` | `properties.tpl:2294` |
| `SHFACT` | `real` | `$PSHELL1_SHFACT` | `PSHELL1_SHFACT #7193 real` | `properties.tpl:2307` |
| `T1` | `real` | `$PSHELL1_T1` | `PSHELL1_T1 #7194 real` | `properties.tpl:2314` |
| `T2` | `real` | `$PSHELL1_T2` | `PSHELL1_T2 #7195 real` | `properties.tpl:2316` |
| `T3` | `real` | `$PSHELL1_T3` | `PSHELL1_T3 #7196 real` | `properties.tpl:2318` |
| `T4` | `real` | `$PSHELL1_T4` | `PSHELL1_T4 #7197 real` | `properties.tpl:2320` |

### PSOLID

- Source: `properties.tpl:2612`
- ID pool: `THREE_IDPOOL`
- Options/subcards: `User Comments`, `CORDM options`, `PSLDN1`, `C4`, `C6`, `C8`, `C10`, `C15`, `C20`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `properties.tpl:2620` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `properties.tpl:2626` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `properties.tpl:2627` |
| `CORDM` | `entity` | `$PSOLID_CORDM` | `PSOLID_CORDM #123 entity` | `properties.tpl:2634` |
| `IN` | `string` | `$PSOLID_IN` | `PSOLID_IN #124 string` | `properties.tpl:2638` |
| `STRESS` | `string` | `$PSOLID_STRESS` | `PSOLID_STRESS #125 string` | `properties.tpl:2643` |
| `ISOP` | `string` | `$PSOLID_ISOP` | `PSOLID_ISOP #126 string` | `properties.tpl:2647` |
| `FCTN` | `string` | `$PSOLID_FCTN` | `PSOLID_FCTN #127 string` | `properties.tpl:2651` |
| `MID1` | `integer` | `$PSHLN1_MID1` | `PSHLN1_MID1 #1676 entity` | `properties.tpl:2663` |
| `DIRECT` | `integer` | `$PSLDN1_DIRECT` | `PSLDN1_DIRECT #1311 integer` | `properties.tpl:2666` |
| `ANAL` | `string` | `$PSHLN1_ANAL` | `PSHLN1_ANAL #1678 string` | `properties.tpl:2672` |
| `BEH4` | `string` | `$PSHLN1_BEH4` | `PSHLN1_BEH4 #1685 string` | `properties.tpl:2684` |
| `INT4` | `string` | `$PSHLN1_INT4` | `PSHLN1_INT4 #1686 string` | `properties.tpl:2688` |
| `BEH4H` | `string` | `$PSHLN1_BEH4H` | `PSHLN1_BEH4H #1687 string` | `properties.tpl:2691` |
| `INT4H` | `string` | `$PSHLN1_INT4H` | `PSHLN1_INT4H #1688 string` | `properties.tpl:2695` |
| `BEH6` | `string` | `$PSHLN1_BEH6` | `PSHLN1_BEH6 #1690 string` | `properties.tpl:2705` |
| `INT6` | `string` | `$PSHLN1_INT6` | `PSHLN1_INT6 #1691 string` | `properties.tpl:2708` |
| `BEH6H` | `string` | `$PSHLN1_BEH6H` | `PSHLN1_BEH6H #1692 string` | `properties.tpl:2711` |
| `INT6H` | `string` | `$PSHLN1_INT6H` | `PSHLN1_INT6H #1693 string` | `properties.tpl:2714` |
| `BEH8` | `string` | `$PSHLN1_BEH8` | `PSHLN1_BEH8 #1695 string` | `properties.tpl:2724` |
| `INT8` | `string` | `$PSHLN1_INT8` | `PSHLN1_INT8 #1696 string` | `properties.tpl:2728` |
| `BEH8H` | `string` | `$PSHLN1_BEH8H` | `PSHLN1_BEH8H #1697 string` | `properties.tpl:2733` |
| `INT8H` | `string` | `$PSHLN1_INT8H` | `PSHLN1_INT8H #1698 string` | `properties.tpl:2737` |
| `BEH10` | `string` | `$PSLDN1_BEH10` | `PSLDN1_BEH10 #1388 string` | `properties.tpl:2749` |
| `INT10` | `string` | `$PSLDN1_INT10` | `PSLDN1_INT10 #1389 string` | `properties.tpl:2752` |
| `BEH10H` | `string` | `$PSLDN1_BEH10H` | `PSLDN1_BEH10H #1390 string` | `properties.tpl:2756` |
| `INT10H` | `string` | `$PSLDN1_INT10H` | `PSLDN1_INT10H #1391 string` | `properties.tpl:2759` |
| `BEH15` | `string` | `$PSLDN1_BEH15` | `PSLDN1_BEH15 #1393 string` | `properties.tpl:2770` |
| `INT15` | `string` | `$PSLDN1_INT15` | `PSLDN1_INT15 #1394 string` | `properties.tpl:2773` |
| `BEH15H` | `string` | `$PSLDN1_BEH15H` | `PSLDN1_BEH15H #1395 string` | `properties.tpl:2776` |
| `INT15H` | `string` | `$PSLDN1_INT15H` | `PSLDN1_INT15H #1396 string` | `properties.tpl:2779` |
| `BEH20` | `string` | `$PSLDN1_BEH20` | `PSLDN1_BEH20 #1398 string` | `properties.tpl:2789` |
| `INT20` | `string` | `$PSLDN1_INT20` | `PSLDN1_INT20 #1399 string` | `properties.tpl:2792` |
| `BEH20H` | `string` | `$PSLDN1_BEH20H` | `PSLDN1_BEH20H #1400 string` | `properties.tpl:2796` |
| `INT20H` | `string` | `$PSLDN1_INT20H` | `PSLDN1_INT20H #1401 string` | `properties.tpl:2799` |

### PTUBE

- Source: `ptube.tpl:7`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `ptube.tpl:15` |
| `beamsec` | `entity` | `$BeamSec` | `BeamSec #3179 entity` | `ptube.tpl:21` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `ptube.tpl:26` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `ptube.tpl:27` |
| `OD` | `real` | `[(2*variable12)]` | `` | `ptube.tpl:36` |
| `T` | `real` | `[(variable12-variable11)]` | `` | `ptube.tpl:37` |
| `NSM` | `real` | `$PTUBE_NSM` | `PTUBE_NSM #89 real` | `ptube.tpl:39` |
| `OD2` | `real` | `$PTUBE_OD2` | `PTUBE_OD2 #90 real` | `ptube.tpl:40` |
| `OD` | `real` | `$PTUBE_OD` | `PTUBE_OD #87 real` | `ptube.tpl:47` |
| `T` | `real` | `$PTUBE_T` | `PTUBE_T #88 real` | `ptube.tpl:48` |

### PVISC

- Source: `propert_c.tpl:220`
- ID pool: `SPRING_AND_GAPS_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `propert_c.tpl:228` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `propert_c.tpl:234` |
| `CE1` | `real` | `$PVISC_CE1` | `PVISC_CE1 #4006 real` | `propert_c.tpl:235` |
| `CR1` | `real` | `$PVISC_CR1` | `PVISC_CR1 #4007 real` | `propert_c.tpl:236` |

### PWELD

- Source: `pweld.tpl:7`
- ID pool: `ONE_IDPOOL`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `pweld.tpl:15` |
| `beamsec` | `entity` | `$BeamSec` | `BeamSec #3179 entity` | `pweld.tpl:21` |
| `PID` | `integer` | `id` | `HM dataname `id`` | `pweld.tpl:26` |
| `MID` | `integer` | `materialid` | `HM dataname `materialid`` | `pweld.tpl:27` |
| `D` | `real` | `[2*variable11]` | `` | `pweld.tpl:34` |
| `MSET` | `string` | `$PWELD_MSET` | `PWELD_MSET #3231 string` | `pweld.tpl:40` |
| `TYPE` | `string` | `$PWELD_TYPE` | `PWELD_TYPE #3259 string` | `pweld.tpl:46` |
| `LDMIN` | `real` | `$PWELD_LDMIN` | `PWELD_LDMIN #3232 real` | `pweld.tpl:52` |
| `LDMAX` | `real` | `$PWELD_LDMAX` | `PWELD_LDMAX #3233 real` | `pweld.tpl:55` |
| `D` | `real` | `$PWELD_D` | `PWELD_D #3230 real` | `pweld.tpl:62` |

## Material Cards

### MAT1

- Source: `materials.tpl:8`
- Options/subcards: `User Comments`, `MATS1`, `MATEP`, `REFFECT`, `ANISO`, `ORNL`, `PRESS`, `GURSON`, `Chaboche`, `YldOpt`, `Units`, `VParam`, `IMPCREEP`, `MATTEP`, `MATT1`, `MAT4`, `MATT4`, `MAT5`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:16` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `mat1_menu.tpl:7` |
| `E` | `real` | `$E` | `E #1 real` | `mat1_menu.tpl:8` |
| `G` | `real` | `$G` | `G #2 real` | `mat1_menu.tpl:10` |
| `NU` | `real` | `$Nu` | `Nu #3 real` | `mat1_menu.tpl:12` |
| `RHO` | `real` | `$Rho` | `Rho #4 real` | `mat1_menu.tpl:14` |
| `A` | `real` | `$MAT1_A` | `MAT1_A #5 real` | `mat1_menu.tpl:16` |
| `TREF` | `real` | `$MAT1_TREF` | `MAT1_TREF #6 real` | `mat1_menu.tpl:18` |
| `GE` | `real` | `$MAT1_GE` | `MAT1_GE #7 real` | `mat1_menu.tpl:20` |
| `ST` | `real` | `$MAT1_ST` | `MAT1_ST #341 real` | `mat1_menu.tpl:25` |
| `SC` | `real` | `$MAT1_SC` | `MAT1_SC #343 real` | `mat1_menu.tpl:27` |
| `SS` | `real` | `$MAT1_SS` | `MAT1_SS #345 real` | `mat1_menu.tpl:29` |
| `MCSID` | `entity` | `$MAT1_MCSID` | `MAT1_MCSID #347 entity` | `mat1_menu.tpl:31` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `mat1_menu.tpl:40` |
| `TID` | `entity` | `$MATS1_TID` | `MATS1_TID #4418 entity` | `mat1_menu.tpl:41` |
| `TYPE` | `string` | `$MATS1_TYPE` | `MATS1_TYPE #4419 string` | `mat1_menu.tpl:44` |
| `H` | `real` | `$MATS1_H` | `MATS1_H #4420 real` | `mat1_menu.tpl:48` |
| `YF` | `integer` | `$MATS1_YF` | `MATS1_YF #4421 integer` | `mat1_menu.tpl:51` |
| `HR` | `integer` | `$MATS1_HR` | `MATS1_HR #4422 integer` | `mat1_menu.tpl:57` |
| `LIMIT1` | `real` | `$MATS1_LIMIT1` | `MATS1_LIMIT1 #4423 real` | `mat1_menu.tpl:63` |
| `LIMIT2` | `real` | `$MATS1_LIMIT2` | `MATS1_LIMIT2 #4424 real` | `mat1_menu.tpl:66` |
| `Form` | `string` | `$MATEP_FORM` | `MATEP_FORM #5021 string` | `matep_menu.tpl:11` |
| `Y0` | `real` | `$MATEP_Y0` | `MATEP_Y0 #5022 real` | `matep_menu.tpl:18` |
| `FID` | `entity` | `$MATEP_FID` | `MATEP_FID #5023 entity` | `matep_menu.tpl:20` |
| `RYIELD` | `string` | `$MATEP_RYIELD` | `MATEP_RYIELD #8529 string` | `matep_menu.tpl:23` |
| `Wkhard` | `string` | `$MATEP_WKHARD` | `MATEP_WKHARD #5025 string` | `matep_menu.tpl:35` |
| `Method` | `string` | `$MATEP_METHOD` | `MATEP_METHOD #5026 string` | `matep_menu.tpl:46` |
| `H` | `real` | `$MATEP_H` | `MATEP_H #5027 real` | `matep_menu.tpl:54` |
| `Option` | `string` | `$MATEP_OPTION` | `MATEP_OPTION #5030 string` | `matep_menu.tpl:64` |
| `RTID` | `entity` | `$MATEP_RTID` | `MATEP_RTID #5031 entity` | `matep_menu.tpl:68` |
| `C` | `real` | `$MATEP_C` | `MATEP_C #5032 real` | `matep_menu.tpl:70` |
| `P` | `real` | `$MATEP_P` | `MATEP_P #5033 real` | `matep_menu.tpl:73` |
| `R11` | `real` | `$MATEP_R11` | `MATEP_R11 #5037 real` | `matep_menu.tpl:86` |
| `R22` | `real` | `$MATEP_R22` | `MATEP_R22 #5038 real` | `matep_menu.tpl:89` |
| `R33` | `real` | `$MATEP_R33` | `MATEP_R33 #5039 real` | `matep_menu.tpl:92` |
| `R12` | `real` | `$MATEP_R12` | `MATEP_R12 #5040 real` | `matep_menu.tpl:95` |
| `R23` | `real` | `$MATEP_R23` | `MATEP_R23 #5041 real` | `matep_menu.tpl:98` |
| `R31` | `real` | `$MATEP_R31` | `MATEP_R31 #5042 real` | `matep_menu.tpl:101` |
| `M` | `real` | `$MATEP_R11` | `MATEP_R11 #5037 real` | `matep_menu.tpl:115` |
| `C1` | `real` | `$MATEP_R22` | `MATEP_R22 #5038 real` | `matep_menu.tpl:118` |
| `C2` | `real` | `$MATEP_R33` | `MATEP_R33 #5039 real` | `matep_menu.tpl:121` |
| `C3` | `real` | `$MATEP_R12` | `MATEP_R12 #5040 real` | `matep_menu.tpl:124` |
| `C6` | `real` | `$MATEP_R23` | `MATEP_R23 #5041 real` | `matep_menu.tpl:127` |
| `Option` | `string` | `$MATEP_OPTION1` | `MATEP_OPTION1 #5045 string` | `matep_menu.tpl:140` |
| `Yc10` | `real` | `$MATEP_YC10` | `MATEP_YC10 #5046 real` | `matep_menu.tpl:146` |
| `TID` | `entity` | `$MATEP_TID` | `MATEP_TID #5047 entity` | `matep_menu.tpl:147` |
| `N/A` | `string` | `$MATEP_NA` | `MATEP_NA #5036 string` | `matep_menu.tpl:149` |
| `Option` | `string` | `$MATEP_OPTION2` | `MATEP_OPTION2 #5050 string` | `matep_menu.tpl:160` |
| `Alpha` | `real` | `$MATEP_ALPHA` | `MATEP_ALPHA #5051 real` | `matep_menu.tpl:164` |
| `Beta` | `real` | `$MATEP_BETA` | `MATEP_BETA #5052 real` | `matep_menu.tpl:166` |
| `Cracks` | `real` | `$MATEP_CRACKS` | `MATEP_CRACKS #5053 real` | `matep_menu.tpl:168` |
| `Soften` | `real` | `$MATEP_SOFTEN` | `MATEP_SOFTEN #5054 real` | `matep_menu.tpl:170` |
| `Crushs` | `real` | `$MATEP_CRUSHS` | `MATEP_CRUSHS #5055 real` | `matep_menu.tpl:173` |
| `Srfac` | `real` | `$MATEP_SRFAC` | `MATEP_SRFAC #5056 real` | `matep_menu.tpl:176` |
| `q1` | `real` | `$MATEP_Q1` | `MATEP_Q1 #5059 real` | `matep_menu.tpl:188` |
| `q2` | `real` | `$MATEP_Q2` | `MATEP_Q2 #5060 real` | `matep_menu.tpl:191` |
| `initial` | `real` | `$MATEP_INITIAL` | `MATEP_INITIAL #5061 real` | `matep_menu.tpl:194` |
| `critical` | `real` | `$MATEP_CRITICAL` | `MATEP_CRITICAL #5062 real` | `matep_menu.tpl:197` |
| `failure` | `real` | `$MATEP_FAILURE` | `MATEP_FAILURE #5063 real` | `matep_menu.tpl:200` |
| `nucl` | `string` | `$MATEP_NUCL` | `MATEP_NUCL #5064 string` | `matep_menu.tpl:203` |
| `Mean` | `real` | `$MATEP_MEAN` | `MATEP_MEAN #5065 real` | `matep_menu.tpl:208` |
| `Sdev` | `real` | `$MATEP_SDEV` | `MATEP_SDEV #5066 real` | `matep_menu.tpl:214` |
| `Nfrac` | `real` | `$MATEP_NFRAC` | `MATEP_NFRAC #5067 real` | `matep_menu.tpl:217` |
| `R0` | `real` | `$MATEP_R0` | `MATEP_R0 #8532 real` | `matep_menu.tpl:229` |
| `Rinf` | `real` | `$MATEP_Rinf` | `MATEP_Rinf #8533 real` | `matep_menu.tpl:231` |
| `B` | `real` | `$MATEP_B` | `MATEP_B #8534 real` | `matep_menu.tpl:233` |
| `C` | `real` | `$MATEP_CC` | `MATEP_CC #8535 real` | `matep_menu.tpl:235` |
| `Gam` | `real` | `$MATEP_Gam` | `MATEP_Gam #8536 real` | `matep_menu.tpl:237` |
| `Kap` | `real` | `$MATEP_Kap` | `MATEP_Kap #8537 real` | `matep_menu.tpl:239` |
| `N` | `integer` | `$MATEP_N` | `MATEP_N #8528 integer` | `matep_menu.tpl:241` |
| `Qm` | `real` | `$MATEP_Qm` | `MATEP_Qm #8538 real` | `matep_menu.tpl:246` |
| `Mu` | `real` | `$MATEP_Mu` | `MATEP_Mu #8539 real` | `matep_menu.tpl:248` |
| `Nu` | `real` | `$MATEP_Nu` | `MATEP_Nu #8540 real` | `matep_menu.tpl:250` |
| `Option` | `string` | `$MATEP_OPTION3` | `MATEP_OPTION3 #8541 string` | `matep_menu.tpl:261` |
| `Uopt` | `string` | `$MATEP_Uopt` | `MATEP_Uopt #8526 string` | `matep_menu.tpl:274` |
| `Nvp` | `string` | `$MATEP_Nvp` | `MATEP_Nvp #8544 string` | `matep_menu.tpl:290` |
| `Vp1` | `real` | `$MATEP_Vp1` | `MATEP_Vp1 #8545 real` | `matep_menu.tpl:295` |
| `Vp2` | `real` | `$MATEP_Vp2` | `MATEP_Vp2 #8546 real` | `matep_menu.tpl:298` |
| `Vmises` | `real` | `$MATEP_Vmises` | `MATEP_Vmises #8548 real` | `matep_menu.tpl:311` |
| `T(Y0)` | `entity` | `$MATTEP_TY0` | `MATTEP_TY0 #5168 entity` | `matep_menu.tpl:323` |
| `T(FID)` | `entity` | `$MATTEP_TFID` | `MATTEP_TFID #5169 entity` | `matep_menu.tpl:326` |
| `T(H)` | `entity` | `$MATTEP_TH` | `MATTEP_TH #5170 entity` | `matep_menu.tpl:332` |
| `T(YC10)FDS` | `entity` | `$MATTEP_TYC10` | `MATTEP_TYC10 #5171 entity` | `matep_menu.tpl:340` |
| `T(E)` | `entity` | `$MATT1_TE` | `MATT1_TE #5239 entity` | `mat1_menu.tpl:77` |
| `T(G)` | `entity` | `$MATT1_TG` | `MATT1_TG #5240 entity` | `mat1_menu.tpl:80` |
| `T(NU)` | `entity` | `$MATT1_TNU` | `MATT1_TNU #5241 entity` | `mat1_menu.tpl:83` |
| `T(RHO)` | `entity` | `$MATT1_TRHO` | `MATT1_TRHO #5242 entity` | `mat1_menu.tpl:86` |
| `T(A)` | `entity` | `$MATT1_TA` | `MATT1_TA #5243 entity` | `mat1_menu.tpl:89` |
| `T(GE)` | `entity` | `$MATT1_TGE` | `MATT1_TGE #5244 entity` | `mat1_menu.tpl:93` |
| `T(ST)` | `entity` | `$MATT1_TST` | `MATT1_TST #5245 entity` | `mat1_menu.tpl:98` |
| `T(SC)` | `entity` | `$MATT1_TSC` | `MATT1_TSC #5246 entity` | `mat1_menu.tpl:101` |
| `T(SS)` | `entity` | `$MATT1_TSS` | `MATT1_TSS #5247 entity` | `mat1_menu.tpl:104` |
| `K` | `real` | `$MAT4_K` | `MAT4_K #265 real` | `mat4_menu.tpl:8` |
| `CP` | `real` | `$MAT4_CP` | `MAT4_CP #194 real` | `mat4_menu.tpl:10` |
| `RHO` | `real` | `$MAT4_RHO` | `MAT4_RHO #324 real` | `mat4_menu.tpl:12` |
| `H` | `real` | `$MAT4_H` | `MAT4_H #325 real` | `mat4_menu.tpl:15` |
| `MU` | `real` | `$MAT4_MU` | `MAT4_MU #327 real` | `mat4_menu.tpl:17` |
| `HGEN` | `real` | `$MAT4_HGEN` | `MAT4_HGEN #329 real` | `mat4_menu.tpl:19` |
| `REFENTH` | `real` | `$MAT4_REFENTH` | `MAT4_REFENTH #330 real` | `mat4_menu.tpl:22` |
| `TCH` | `real` | `$MAT4_TCH` | `MAT4_TCH #332 real` | `mat4_menu.tpl:27` |
| `TDELTA` | `real` | `$MAT4_TDELTA` | `MAT4_TDELTA #334 real` | `mat4_menu.tpl:29` |
| `QLAT` | `real` | `$MAT4_QLAT` | `MAT4_QLAT #336 real` | `mat4_menu.tpl:31` |
| `T(K)` | `entity` | `$MATT4_TK` | `MATT4_TK #1670 entity` | `mat4_menu.tpl:39` |
| `T(CP)` | `entity` | `$MATT4_TCP` | `MATT4_TCP #1671 entity` | `mat4_menu.tpl:42` |
| `T(H)` | `entity` | `$MATT4_TH` | `MATT4_TH #1672 entity` | `mat4_menu.tpl:46` |
| `T(U)` | `entity` | `$MATT4_TU` | `MATT4_TU #1673 entity` | `mat4_menu.tpl:49` |
| `T(HGEN)` | `entity` | `$MATT4_THGEN` | `MATT4_THGEN #1674 entity` | `mat4_menu.tpl:52` |
| `KXX` | `real` | `$MAT5_KXX` | `MAT5_KXX #4946 real` | `mat5_menu.tpl:8` |
| `KXY` | `real` | `$MAT5_KXY` | `MAT5_KXY #4947 real` | `mat5_menu.tpl:10` |
| `KXZ` | `real` | `$MAT5_KXZ` | `MAT5_KXZ #4948 real` | `mat5_menu.tpl:12` |
| `KYY` | `real` | `$MAT5_KYY` | `MAT5_KYY #4949 real` | `mat5_menu.tpl:14` |
| `KYZ` | `real` | `$MAT5_KYZ` | `MAT5_KYZ #4950 real` | `mat5_menu.tpl:16` |
| `KZZ` | `real` | `$MAT5_KZZ` | `MAT5_KZZ #4951 real` | `mat5_menu.tpl:18` |
| `CP` | `real` | `$MAT5_CP` | `MAT5_CP #4952 real` | `mat5_menu.tpl:20` |
| `RHO` | `real` | `$MAT5_RHO` | `MAT5_RHO #4953 real` | `mat5_menu.tpl:24` |
| `HGEN` | `real` | `$MAT5_HGEN` | `MAT5_HGEN #4954 real` | `mat5_menu.tpl:26` |

### MAT10

- Source: `materials.tpl:503`
- Options/subcards: `User Comments`, `MAT4`, `MATT4`, `MAT5`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:511` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `mat10_menu.tpl:7` |
| `BULK` | `real` | `$MAT10_BULK` | `MAT10_BULK #3249 real` | `mat10_menu.tpl:8` |
| `RHO` | `real` | `$MAT10_RHO` | `MAT10_RHO #3250 real` | `mat10_menu.tpl:10` |
| `C` | `real` | `$MAT10_C` | `MAT10_C #3251 real` | `mat10_menu.tpl:12` |
| `GE` | `real` | `$MAT10_GE` | `MAT10_GE #3252 real` | `mat10_menu.tpl:14` |
| `ALPHA` | `real` | `$MAT10_ALPHA` | `MAT10_ALPHA #1003 real` | `mat10_menu.tpl:16` |
| `K` | `real` | `$MAT4_K` | `MAT4_K #265 real` | `mat4_menu.tpl:8` |
| `CP` | `real` | `$MAT4_CP` | `MAT4_CP #194 real` | `mat4_menu.tpl:10` |
| `RHO` | `real` | `$MAT4_RHO` | `MAT4_RHO #324 real` | `mat4_menu.tpl:12` |
| `H` | `real` | `$MAT4_H` | `MAT4_H #325 real` | `mat4_menu.tpl:15` |
| `MU` | `real` | `$MAT4_MU` | `MAT4_MU #327 real` | `mat4_menu.tpl:17` |
| `HGEN` | `real` | `$MAT4_HGEN` | `MAT4_HGEN #329 real` | `mat4_menu.tpl:19` |
| `REFENTH` | `real` | `$MAT4_REFENTH` | `MAT4_REFENTH #330 real` | `mat4_menu.tpl:22` |
| `TCH` | `real` | `$MAT4_TCH` | `MAT4_TCH #332 real` | `mat4_menu.tpl:27` |
| `TDELTA` | `real` | `$MAT4_TDELTA` | `MAT4_TDELTA #334 real` | `mat4_menu.tpl:29` |
| `QLAT` | `real` | `$MAT4_QLAT` | `MAT4_QLAT #336 real` | `mat4_menu.tpl:31` |
| `T(K)` | `entity` | `$MATT4_TK` | `MATT4_TK #1670 entity` | `mat4_menu.tpl:39` |
| `T(CP)` | `entity` | `$MATT4_TCP` | `MATT4_TCP #1671 entity` | `mat4_menu.tpl:42` |
| `T(H)` | `entity` | `$MATT4_TH` | `MATT4_TH #1672 entity` | `mat4_menu.tpl:46` |
| `T(U)` | `entity` | `$MATT4_TU` | `MATT4_TU #1673 entity` | `mat4_menu.tpl:49` |
| `T(HGEN)` | `entity` | `$MATT4_THGEN` | `MATT4_THGEN #1674 entity` | `mat4_menu.tpl:52` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `mat5_menu.tpl:7` |
| `KXX` | `real` | `$MAT5_KXX` | `MAT5_KXX #4946 real` | `mat5_menu.tpl:8` |
| `KXY` | `real` | `$MAT5_KXY` | `MAT5_KXY #4947 real` | `mat5_menu.tpl:10` |
| `KXZ` | `real` | `$MAT5_KXZ` | `MAT5_KXZ #4948 real` | `mat5_menu.tpl:12` |
| `KYY` | `real` | `$MAT5_KYY` | `MAT5_KYY #4949 real` | `mat5_menu.tpl:14` |
| `KYZ` | `real` | `$MAT5_KYZ` | `MAT5_KYZ #4950 real` | `mat5_menu.tpl:16` |
| `KZZ` | `real` | `$MAT5_KZZ` | `MAT5_KZZ #4951 real` | `mat5_menu.tpl:18` |
| `CP` | `real` | `$MAT5_CP` | `MAT5_CP #4952 real` | `mat5_menu.tpl:20` |
| `RHO` | `real` | `$MAT5_RHO` | `MAT5_RHO #4953 real` | `mat5_menu.tpl:24` |
| `HGEN` | `real` | `$MAT5_HGEN` | `MAT5_HGEN #4954 real` | `mat5_menu.tpl:26` |

### MAT2

- Source: `materials.tpl:95`
- Options/subcards: `User Comments`, `MATEP`, `REFFECT`, `ANISO`, `ORNL`, `PRESS`, `GURSON`, `Chaboche`, `YldOpt`, `Units`, `VParam`, `IMPCREEP`, `MATTEP`, `MATT2`, `MAT4`, `MATT4`, `MAT5`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:103` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `mat2_menu.tpl:7` |
| `G11` | `real` | `$MAT2_G11` | `MAT2_G11 #147 real` | `mat2_menu.tpl:8` |
| `G12` | `real` | `$MAT2_G12` | `MAT2_G12 #148 real` | `mat2_menu.tpl:11` |
| `G13` | `real` | `$MAT2_G13` | `MAT2_G13 #149 real` | `mat2_menu.tpl:14` |
| `G22` | `real` | `$MAT2_G22` | `MAT2_G22 #150 real` | `mat2_menu.tpl:16` |
| `G23` | `real` | `$MAT2_G23` | `MAT2_G23 #151 real` | `mat2_menu.tpl:19` |
| `G33` | `real` | `$MAT2_G33` | `MAT2_G33 #152 real` | `mat2_menu.tpl:21` |
| `RHO` | `real` | `$MAT2_RHO` | `MAT2_RHO #153 real` | `mat2_menu.tpl:23` |
| `A1` | `real` | `$MAT2_A1` | `MAT2_A1 #154 real` | `mat2_menu.tpl:29` |
| `A2` | `real` | `$MAT2_A2` | `MAT2_A2 #155 real` | `mat2_menu.tpl:32` |
| `A12` | `real` | `$MAT2_A12` | `MAT2_A12 #156 real` | `mat2_menu.tpl:35` |
| `TREF` | `real` | `$MAT2_TREF` | `MAT2_TREF #157 real` | `mat2_menu.tpl:38` |
| `GE` | `real` | `$MAT2_GE` | `MAT2_GE #158 real` | `mat2_menu.tpl:40` |
| `ST` | `real` | `$MAT2_ST` | `MAT2_ST #266 real` | `mat2_menu.tpl:43` |
| `SC` | `real` | `$MAT2_SC` | `MAT2_SC #267 real` | `mat2_menu.tpl:45` |
| `SS` | `real` | `$MAT2_SS` | `MAT2_SS #268 real` | `mat2_menu.tpl:47` |
| `MCSID` | `integer` | `$MAT2_MCSID` | `MAT2_MCSID #269 integer` | `mat2_menu.tpl:52` |
| `Form` | `string` | `$MATEP_FORM` | `MATEP_FORM #5021 string` | `matep_menu.tpl:11` |
| `Y0` | `real` | `$MATEP_Y0` | `MATEP_Y0 #5022 real` | `matep_menu.tpl:18` |
| `FID` | `entity` | `$MATEP_FID` | `MATEP_FID #5023 entity` | `matep_menu.tpl:20` |
| `RYIELD` | `string` | `$MATEP_RYIELD` | `MATEP_RYIELD #8529 string` | `matep_menu.tpl:23` |
| `Wkhard` | `string` | `$MATEP_WKHARD` | `MATEP_WKHARD #5025 string` | `matep_menu.tpl:35` |
| `Method` | `string` | `$MATEP_METHOD` | `MATEP_METHOD #5026 string` | `matep_menu.tpl:46` |
| `H` | `real` | `$MATEP_H` | `MATEP_H #5027 real` | `matep_menu.tpl:54` |
| `Option` | `string` | `$MATEP_OPTION` | `MATEP_OPTION #5030 string` | `matep_menu.tpl:64` |
| `RTID` | `entity` | `$MATEP_RTID` | `MATEP_RTID #5031 entity` | `matep_menu.tpl:68` |
| `C` | `real` | `$MATEP_C` | `MATEP_C #5032 real` | `matep_menu.tpl:70` |
| `P` | `real` | `$MATEP_P` | `MATEP_P #5033 real` | `matep_menu.tpl:73` |
| `R11` | `real` | `$MATEP_R11` | `MATEP_R11 #5037 real` | `matep_menu.tpl:86` |
| `R22` | `real` | `$MATEP_R22` | `MATEP_R22 #5038 real` | `matep_menu.tpl:89` |
| `R33` | `real` | `$MATEP_R33` | `MATEP_R33 #5039 real` | `matep_menu.tpl:92` |
| `R12` | `real` | `$MATEP_R12` | `MATEP_R12 #5040 real` | `matep_menu.tpl:95` |
| `R23` | `real` | `$MATEP_R23` | `MATEP_R23 #5041 real` | `matep_menu.tpl:98` |
| `R31` | `real` | `$MATEP_R31` | `MATEP_R31 #5042 real` | `matep_menu.tpl:101` |
| `M` | `real` | `$MATEP_R11` | `MATEP_R11 #5037 real` | `matep_menu.tpl:115` |
| `C1` | `real` | `$MATEP_R22` | `MATEP_R22 #5038 real` | `matep_menu.tpl:118` |
| `C2` | `real` | `$MATEP_R33` | `MATEP_R33 #5039 real` | `matep_menu.tpl:121` |
| `C3` | `real` | `$MATEP_R12` | `MATEP_R12 #5040 real` | `matep_menu.tpl:124` |
| `C6` | `real` | `$MATEP_R23` | `MATEP_R23 #5041 real` | `matep_menu.tpl:127` |
| `Option` | `string` | `$MATEP_OPTION1` | `MATEP_OPTION1 #5045 string` | `matep_menu.tpl:140` |
| `Yc10` | `real` | `$MATEP_YC10` | `MATEP_YC10 #5046 real` | `matep_menu.tpl:146` |
| `TID` | `entity` | `$MATEP_TID` | `MATEP_TID #5047 entity` | `matep_menu.tpl:147` |
| `N/A` | `string` | `$MATEP_NA` | `MATEP_NA #5036 string` | `matep_menu.tpl:149` |
| `Option` | `string` | `$MATEP_OPTION2` | `MATEP_OPTION2 #5050 string` | `matep_menu.tpl:160` |
| `Alpha` | `real` | `$MATEP_ALPHA` | `MATEP_ALPHA #5051 real` | `matep_menu.tpl:164` |
| `Beta` | `real` | `$MATEP_BETA` | `MATEP_BETA #5052 real` | `matep_menu.tpl:166` |
| `Cracks` | `real` | `$MATEP_CRACKS` | `MATEP_CRACKS #5053 real` | `matep_menu.tpl:168` |
| `Soften` | `real` | `$MATEP_SOFTEN` | `MATEP_SOFTEN #5054 real` | `matep_menu.tpl:170` |
| `Crushs` | `real` | `$MATEP_CRUSHS` | `MATEP_CRUSHS #5055 real` | `matep_menu.tpl:173` |
| `Srfac` | `real` | `$MATEP_SRFAC` | `MATEP_SRFAC #5056 real` | `matep_menu.tpl:176` |
| `q1` | `real` | `$MATEP_Q1` | `MATEP_Q1 #5059 real` | `matep_menu.tpl:188` |
| `q2` | `real` | `$MATEP_Q2` | `MATEP_Q2 #5060 real` | `matep_menu.tpl:191` |
| `initial` | `real` | `$MATEP_INITIAL` | `MATEP_INITIAL #5061 real` | `matep_menu.tpl:194` |
| `critical` | `real` | `$MATEP_CRITICAL` | `MATEP_CRITICAL #5062 real` | `matep_menu.tpl:197` |
| `failure` | `real` | `$MATEP_FAILURE` | `MATEP_FAILURE #5063 real` | `matep_menu.tpl:200` |
| `nucl` | `string` | `$MATEP_NUCL` | `MATEP_NUCL #5064 string` | `matep_menu.tpl:203` |
| `Mean` | `real` | `$MATEP_MEAN` | `MATEP_MEAN #5065 real` | `matep_menu.tpl:208` |
| `Sdev` | `real` | `$MATEP_SDEV` | `MATEP_SDEV #5066 real` | `matep_menu.tpl:214` |
| `Nfrac` | `real` | `$MATEP_NFRAC` | `MATEP_NFRAC #5067 real` | `matep_menu.tpl:217` |
| `R0` | `real` | `$MATEP_R0` | `MATEP_R0 #8532 real` | `matep_menu.tpl:229` |
| `Rinf` | `real` | `$MATEP_Rinf` | `MATEP_Rinf #8533 real` | `matep_menu.tpl:231` |
| `B` | `real` | `$MATEP_B` | `MATEP_B #8534 real` | `matep_menu.tpl:233` |
| `C` | `real` | `$MATEP_CC` | `MATEP_CC #8535 real` | `matep_menu.tpl:235` |
| `Gam` | `real` | `$MATEP_Gam` | `MATEP_Gam #8536 real` | `matep_menu.tpl:237` |
| `Kap` | `real` | `$MATEP_Kap` | `MATEP_Kap #8537 real` | `matep_menu.tpl:239` |
| `N` | `integer` | `$MATEP_N` | `MATEP_N #8528 integer` | `matep_menu.tpl:241` |
| `Qm` | `real` | `$MATEP_Qm` | `MATEP_Qm #8538 real` | `matep_menu.tpl:246` |
| `Mu` | `real` | `$MATEP_Mu` | `MATEP_Mu #8539 real` | `matep_menu.tpl:248` |
| `Nu` | `real` | `$MATEP_Nu` | `MATEP_Nu #8540 real` | `matep_menu.tpl:250` |
| `Option` | `string` | `$MATEP_OPTION3` | `MATEP_OPTION3 #8541 string` | `matep_menu.tpl:261` |
| `Uopt` | `string` | `$MATEP_Uopt` | `MATEP_Uopt #8526 string` | `matep_menu.tpl:274` |
| `Nvp` | `string` | `$MATEP_Nvp` | `MATEP_Nvp #8544 string` | `matep_menu.tpl:290` |
| `Vp1` | `real` | `$MATEP_Vp1` | `MATEP_Vp1 #8545 real` | `matep_menu.tpl:295` |
| `Vp2` | `real` | `$MATEP_Vp2` | `MATEP_Vp2 #8546 real` | `matep_menu.tpl:298` |
| `Vmises` | `real` | `$MATEP_Vmises` | `MATEP_Vmises #8548 real` | `matep_menu.tpl:311` |
| `T(Y0)` | `entity` | `$MATTEP_TY0` | `MATTEP_TY0 #5168 entity` | `matep_menu.tpl:323` |
| `T(FID)` | `entity` | `$MATTEP_TFID` | `MATTEP_TFID #5169 entity` | `matep_menu.tpl:326` |
| `T(H)` | `entity` | `$MATTEP_TH` | `MATTEP_TH #5170 entity` | `matep_menu.tpl:332` |
| `T(YC10)FDS` | `entity` | `$MATTEP_TYC10` | `MATTEP_TYC10 #5171 entity` | `matep_menu.tpl:340` |
| `T(G11)` | `entity` | `$MATT2_TG11` | `MATT2_TG11 #5250 entity` | `mat2_menu.tpl:61` |
| `T(G12)` | `entity` | `$MATT2_TG12` | `MATT2_TG12 #5251 entity` | `mat2_menu.tpl:64` |
| `T(G13)` | `entity` | `$MATT2_TG13` | `MATT2_TG13 #5252 entity` | `mat2_menu.tpl:67` |
| `T(G22)` | `entity` | `$MATT2_TG22` | `MATT2_TG22 #5253 entity` | `mat2_menu.tpl:70` |
| `T(G23)` | `entity` | `$MATT2_TG23` | `MATT2_TG23 #5254 entity` | `mat2_menu.tpl:73` |
| `T(G33)` | `entity` | `$MATT2_TG33` | `MATT2_TG33 #5255 entity` | `mat2_menu.tpl:76` |
| `T(RHO)` | `entity` | `$MATT2_TRHO` | `MATT2_TRHO #5256 entity` | `mat2_menu.tpl:79` |
| `T(A1)` | `entity` | `$MATT2_TA1` | `MATT2_TA1 #5257 entity` | `mat2_menu.tpl:84` |
| `T(A2)` | `entity` | `$MATT2_TA2` | `MATT2_TA2 #5258 entity` | `mat2_menu.tpl:87` |
| `T(A3)` | `entity` | `$MATT2_TA3` | `MATT2_TA3 #5259 entity` | `mat2_menu.tpl:90` |
| `T(GE)` | `entity` | `$MATT2_TGE` | `MATT2_TGE #5260 entity` | `mat2_menu.tpl:94` |
| `T(ST)` | `entity` | `$MATT2_TST` | `MATT2_TST #5261 entity` | `mat2_menu.tpl:97` |
| `T(SC)` | `entity` | `$MATT2_TSC` | `MATT2_TSC #5262 entity` | `mat2_menu.tpl:100` |
| `T(SS)` | `entity` | `$MATT2_TSS` | `MATT2_TSS #5263 entity` | `mat2_menu.tpl:103` |
| `K` | `real` | `$MAT4_K` | `MAT4_K #265 real` | `mat4_menu.tpl:8` |
| `CP` | `real` | `$MAT4_CP` | `MAT4_CP #194 real` | `mat4_menu.tpl:10` |
| `RHO` | `real` | `$MAT4_RHO` | `MAT4_RHO #324 real` | `mat4_menu.tpl:12` |
| `H` | `real` | `$MAT4_H` | `MAT4_H #325 real` | `mat4_menu.tpl:15` |
| `MU` | `real` | `$MAT4_MU` | `MAT4_MU #327 real` | `mat4_menu.tpl:17` |
| `HGEN` | `real` | `$MAT4_HGEN` | `MAT4_HGEN #329 real` | `mat4_menu.tpl:19` |
| `REFENTH` | `real` | `$MAT4_REFENTH` | `MAT4_REFENTH #330 real` | `mat4_menu.tpl:22` |
| `TCH` | `real` | `$MAT4_TCH` | `MAT4_TCH #332 real` | `mat4_menu.tpl:27` |
| `TDELTA` | `real` | `$MAT4_TDELTA` | `MAT4_TDELTA #334 real` | `mat4_menu.tpl:29` |
| `QLAT` | `real` | `$MAT4_QLAT` | `MAT4_QLAT #336 real` | `mat4_menu.tpl:31` |
| `T(K)` | `entity` | `$MATT4_TK` | `MATT4_TK #1670 entity` | `mat4_menu.tpl:39` |
| `T(CP)` | `entity` | `$MATT4_TCP` | `MATT4_TCP #1671 entity` | `mat4_menu.tpl:42` |
| `T(H)` | `entity` | `$MATT4_TH` | `MATT4_TH #1672 entity` | `mat4_menu.tpl:46` |
| `T(U)` | `entity` | `$MATT4_TU` | `MATT4_TU #1673 entity` | `mat4_menu.tpl:49` |
| `T(HGEN)` | `entity` | `$MATT4_THGEN` | `MATT4_THGEN #1674 entity` | `mat4_menu.tpl:52` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `mat5_menu.tpl:7` |
| `KXX` | `real` | `$MAT5_KXX` | `MAT5_KXX #4946 real` | `mat5_menu.tpl:8` |
| `KXY` | `real` | `$MAT5_KXY` | `MAT5_KXY #4947 real` | `mat5_menu.tpl:10` |
| `KXZ` | `real` | `$MAT5_KXZ` | `MAT5_KXZ #4948 real` | `mat5_menu.tpl:12` |
| `KYY` | `real` | `$MAT5_KYY` | `MAT5_KYY #4949 real` | `mat5_menu.tpl:14` |
| `KYZ` | `real` | `$MAT5_KYZ` | `MAT5_KYZ #4950 real` | `mat5_menu.tpl:16` |
| `KZZ` | `real` | `$MAT5_KZZ` | `MAT5_KZZ #4951 real` | `mat5_menu.tpl:18` |
| `CP` | `real` | `$MAT5_CP` | `MAT5_CP #4952 real` | `mat5_menu.tpl:20` |
| `RHO` | `real` | `$MAT5_RHO` | `MAT5_RHO #4953 real` | `mat5_menu.tpl:24` |
| `HGEN` | `real` | `$MAT5_HGEN` | `MAT5_HGEN #4954 real` | `mat5_menu.tpl:26` |

### MAT4

- Source: `materials.tpl:183`
- Options/subcards: `User Comments`, `MATT4`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:191` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `mat4_menu.tpl:7` |
| `K` | `real` | `$MAT4_K` | `MAT4_K #265 real` | `mat4_menu.tpl:8` |
| `CP` | `real` | `$MAT4_CP` | `MAT4_CP #194 real` | `mat4_menu.tpl:10` |
| `RHO` | `real` | `$MAT4_RHO` | `MAT4_RHO #324 real` | `mat4_menu.tpl:12` |
| `H` | `real` | `$MAT4_H` | `MAT4_H #325 real` | `mat4_menu.tpl:15` |
| `MU` | `real` | `$MAT4_MU` | `MAT4_MU #327 real` | `mat4_menu.tpl:17` |
| `HGEN` | `real` | `$MAT4_HGEN` | `MAT4_HGEN #329 real` | `mat4_menu.tpl:19` |
| `REFENTH` | `real` | `$MAT4_REFENTH` | `MAT4_REFENTH #330 real` | `mat4_menu.tpl:22` |
| `TCH` | `real` | `$MAT4_TCH` | `MAT4_TCH #332 real` | `mat4_menu.tpl:27` |
| `TDELTA` | `real` | `$MAT4_TDELTA` | `MAT4_TDELTA #334 real` | `mat4_menu.tpl:29` |
| `QLAT` | `real` | `$MAT4_QLAT` | `MAT4_QLAT #336 real` | `mat4_menu.tpl:31` |
| `T(K)` | `entity` | `$MATT4_TK` | `MATT4_TK #1670 entity` | `mat4_menu.tpl:39` |
| `T(CP)` | `entity` | `$MATT4_TCP` | `MATT4_TCP #1671 entity` | `mat4_menu.tpl:42` |
| `T(H)` | `entity` | `$MATT4_TH` | `MATT4_TH #1672 entity` | `mat4_menu.tpl:46` |
| `T(U)` | `entity` | `$MATT4_TU` | `MATT4_TU #1673 entity` | `mat4_menu.tpl:49` |
| `T(HGEN)` | `entity` | `$MATT4_THGEN` | `MATT4_THGEN #1674 entity` | `mat4_menu.tpl:52` |

### MAT5

- Source: `materials.tpl:252`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:260` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `mat5_menu.tpl:7` |
| `KXX` | `real` | `$MAT5_KXX` | `MAT5_KXX #4946 real` | `mat5_menu.tpl:8` |
| `KXY` | `real` | `$MAT5_KXY` | `MAT5_KXY #4947 real` | `mat5_menu.tpl:10` |
| `KXZ` | `real` | `$MAT5_KXZ` | `MAT5_KXZ #4948 real` | `mat5_menu.tpl:12` |
| `KYY` | `real` | `$MAT5_KYY` | `MAT5_KYY #4949 real` | `mat5_menu.tpl:14` |
| `KYZ` | `real` | `$MAT5_KYZ` | `MAT5_KYZ #4950 real` | `mat5_menu.tpl:16` |
| `KZZ` | `real` | `$MAT5_KZZ` | `MAT5_KZZ #4951 real` | `mat5_menu.tpl:18` |
| `CP` | `real` | `$MAT5_CP` | `MAT5_CP #4952 real` | `mat5_menu.tpl:20` |
| `RHO` | `real` | `$MAT5_RHO` | `MAT5_RHO #4953 real` | `mat5_menu.tpl:24` |
| `HGEN` | `real` | `$MAT5_HGEN` | `MAT5_HGEN #4954 real` | `mat5_menu.tpl:26` |

### MAT8

- Source: `materials.tpl:326`
- Options/subcards: `User Comments`, `MATT8`, `MAT4`, `MATT4`, `MAT5`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:334` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `mat8_menu.tpl:7` |
| `E1` | `real` | `$MAT8_E1` | `MAT8_E1 #196 real` | `mat8_menu.tpl:8` |
| `E2` | `real` | `$MAT8_E2` | `MAT8_E2 #197 real` | `mat8_menu.tpl:9` |
| `NU12` | `real` | `$MAT8_NU12` | `MAT8_NU12 #198 real` | `mat8_menu.tpl:10` |
| `G12` | `real` | `$MAT8_G12` | `MAT8_G12 #199 real` | `mat8_menu.tpl:11` |
| `G1Z` | `real` | `$MAT8_G1Z` | `MAT8_G1Z #200 real` | `mat8_menu.tpl:14` |
| `G2Z` | `real` | `$MAT8_G2Z` | `MAT8_G2Z #201 real` | `mat8_menu.tpl:16` |
| `RHO` | `real` | `$MAT8_RHO` | `MAT8_RHO #202 real` | `mat8_menu.tpl:18` |
| `A1` | `real` | `$MAT8_A1` | `MAT8_A1 #203 real` | `mat8_menu.tpl:24` |
| `A2` | `real` | `$MAT8_A2` | `MAT8_A2 #204 real` | `mat8_menu.tpl:27` |
| `TREF` | `real` | `$MAT8_TREF` | `MAT8_TREF #205 real` | `mat8_menu.tpl:30` |
| `Xt` | `real` | `$MAT8_Xt` | `MAT8_Xt #206 real` | `mat8_menu.tpl:32` |
| `Xc` | `real` | `$MAT8_Xc` | `MAT8_Xc #207 real` | `mat8_menu.tpl:34` |
| `Yt` | `real` | `$MAT8_Yt` | `MAT8_Yt #208 real` | `mat8_menu.tpl:36` |
| `Yc` | `real` | `$MAT8_Yc` | `MAT8_Yc #209 real` | `mat8_menu.tpl:38` |
| `S` | `real` | `$MAT8_S` | `MAT8_S #210 real` | `mat8_menu.tpl:40` |
| `GE` | `real` | `$MAT8_GE` | `MAT8_GE #211 real` | `mat8_menu.tpl:45` |
| `F12` | `real` | `$MAT8_F12` | `MAT8_F12 #212 real` | `mat8_menu.tpl:48` |
| `STRN` | `real` | `$MAT8_STRN` | `MAT8_STRN #213 real` | `mat8_menu.tpl:50` |
| `T(E1)` | `entity` | `$MATT8_TE1` | `MATT8_TE1 #5266 entity` | `mat8_menu.tpl:58` |
| `T(E2)` | `entity` | `$MATT8_TE2` | `MATT8_TE2 #5267 entity` | `mat8_menu.tpl:61` |
| `T(NU12)` | `entity` | `$MATT8_TNU12` | `MATT8_TNU12 #5268 entity` | `mat8_menu.tpl:64` |
| `T(G12)` | `entity` | `$MATT8_TG12` | `MATT8_TG12 #5269 entity` | `mat8_menu.tpl:67` |
| `T(G1Z)` | `entity` | `$MATT8_TG1Z` | `MATT8_TG1Z #5270 entity` | `mat8_menu.tpl:70` |
| `T(G2Z)` | `entity` | `$MATT8_TG2Z` | `MATT8_TG2Z #5271 entity` | `mat8_menu.tpl:73` |
| `T(RHO)` | `entity` | `$MATT8_TRHO` | `MATT8_TRHO #5272 entity` | `mat8_menu.tpl:76` |
| `T(A1)` | `entity` | `$MATT8_TA1` | `MATT8_TA1 #5273 entity` | `mat8_menu.tpl:81` |
| `T(A2)` | `entity` | `$MATT8_TA2` | `MATT8_TA2 #5274 entity` | `mat8_menu.tpl:84` |
| `T(Xt)` | `entity` | `$MATT8_TXT` | `MATT8_TXT #5275 entity` | `mat8_menu.tpl:88` |
| `T(Xc)` | `entity` | `$MATT8_TXC` | `MATT8_TXC #5276 entity` | `mat8_menu.tpl:91` |
| `T(Yt)` | `entity` | `$MATT8_TYT` | `MATT8_TYT #5277 entity` | `mat8_menu.tpl:94` |
| `T(Yc)` | `entity` | `$MATT8_TYC` | `MATT8_TYC #5278 entity` | `mat8_menu.tpl:97` |
| `T(S)` | `entity` | `$MATT8_TS` | `MATT8_TS #5279 entity` | `mat8_menu.tpl:100` |
| `T(GE)` | `entity` | `$MATT8_TGE` | `MATT8_TGE #5280 entity` | `mat8_menu.tpl:105` |
| `T(F12)` | `entity` | `$MATT8_TF12` | `MATT8_TF12 #5281 entity` | `mat8_menu.tpl:108` |
| `K` | `real` | `$MAT4_K` | `MAT4_K #265 real` | `mat4_menu.tpl:8` |
| `CP` | `real` | `$MAT4_CP` | `MAT4_CP #194 real` | `mat4_menu.tpl:10` |
| `RHO` | `real` | `$MAT4_RHO` | `MAT4_RHO #324 real` | `mat4_menu.tpl:12` |
| `H` | `real` | `$MAT4_H` | `MAT4_H #325 real` | `mat4_menu.tpl:15` |
| `MU` | `real` | `$MAT4_MU` | `MAT4_MU #327 real` | `mat4_menu.tpl:17` |
| `HGEN` | `real` | `$MAT4_HGEN` | `MAT4_HGEN #329 real` | `mat4_menu.tpl:19` |
| `REFENTH` | `real` | `$MAT4_REFENTH` | `MAT4_REFENTH #330 real` | `mat4_menu.tpl:22` |
| `TCH` | `real` | `$MAT4_TCH` | `MAT4_TCH #332 real` | `mat4_menu.tpl:27` |
| `TDELTA` | `real` | `$MAT4_TDELTA` | `MAT4_TDELTA #334 real` | `mat4_menu.tpl:29` |
| `QLAT` | `real` | `$MAT4_QLAT` | `MAT4_QLAT #336 real` | `mat4_menu.tpl:31` |
| `T(K)` | `entity` | `$MATT4_TK` | `MATT4_TK #1670 entity` | `mat4_menu.tpl:39` |
| `T(CP)` | `entity` | `$MATT4_TCP` | `MATT4_TCP #1671 entity` | `mat4_menu.tpl:42` |
| `T(H)` | `entity` | `$MATT4_TH` | `MATT4_TH #1672 entity` | `mat4_menu.tpl:46` |
| `T(U)` | `entity` | `$MATT4_TU` | `MATT4_TU #1673 entity` | `mat4_menu.tpl:49` |
| `T(HGEN)` | `entity` | `$MATT4_THGEN` | `MATT4_THGEN #1674 entity` | `mat4_menu.tpl:52` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `mat5_menu.tpl:7` |
| `KXX` | `real` | `$MAT5_KXX` | `MAT5_KXX #4946 real` | `mat5_menu.tpl:8` |
| `KXY` | `real` | `$MAT5_KXY` | `MAT5_KXY #4947 real` | `mat5_menu.tpl:10` |
| `KXZ` | `real` | `$MAT5_KXZ` | `MAT5_KXZ #4948 real` | `mat5_menu.tpl:12` |
| `KYY` | `real` | `$MAT5_KYY` | `MAT5_KYY #4949 real` | `mat5_menu.tpl:14` |
| `KYZ` | `real` | `$MAT5_KYZ` | `MAT5_KYZ #4950 real` | `mat5_menu.tpl:16` |
| `KZZ` | `real` | `$MAT5_KZZ` | `MAT5_KZZ #4951 real` | `mat5_menu.tpl:18` |
| `CP` | `real` | `$MAT5_CP` | `MAT5_CP #4952 real` | `mat5_menu.tpl:20` |
| `RHO` | `real` | `$MAT5_RHO` | `MAT5_RHO #4953 real` | `mat5_menu.tpl:24` |
| `HGEN` | `real` | `$MAT5_HGEN` | `MAT5_HGEN #4954 real` | `mat5_menu.tpl:26` |

### MAT9

- Source: `materials.tpl:415`
- Options/subcards: `User Comments`, `MATEP`, `REFFECT`, `ANISO`, `ORNL`, `PRESS`, `GURSON`, `Chaboche`, `YldOpt`, `Units`, `VParam`, `IMPCREEP`, `MATTEP`, `MATT9`, `MAT4`, `MATT4`, `MAT5`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:423` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `mat9_menu.tpl:7` |
| `G11` | `real` | `$MAT9_G11` | `MAT9_G11 #215 real` | `mat9_menu.tpl:8` |
| `G12` | `real` | `$MAT9_G12` | `MAT9_G12 #216 real` | `mat9_menu.tpl:9` |
| `G13` | `real` | `$MAT9_G13` | `MAT9_G13 #217 real` | `mat9_menu.tpl:10` |
| `G14` | `real` | `$MAT9_G14` | `MAT9_G14 #218 real` | `mat9_menu.tpl:11` |
| `G15` | `real` | `$MAT9_G15` | `MAT9_G15 #219 real` | `mat9_menu.tpl:12` |
| `G16` | `real` | `$MAT9_G16` | `MAT9_G16 #220 real` | `mat9_menu.tpl:13` |
| `G22` | `real` | `$MAT9_G22` | `MAT9_G22 #221 real` | `mat9_menu.tpl:14` |
| `G23` | `real` | `$MAT9_G23` | `MAT9_G23 #222 real` | `mat9_menu.tpl:18` |
| `G24` | `real` | `$MAT9_G24` | `MAT9_G24 #223 real` | `mat9_menu.tpl:19` |
| `G25` | `real` | `$MAT9_G25` | `MAT9_G25 #224 real` | `mat9_menu.tpl:20` |
| `G26` | `real` | `$MAT9_G26` | `MAT9_G26 #225 real` | `mat9_menu.tpl:21` |
| `G33` | `real` | `$MAT9_G33` | `MAT9_G33 #226 real` | `mat9_menu.tpl:22` |
| `G34` | `real` | `$MAT9_G34` | `MAT9_G34 #227 real` | `mat9_menu.tpl:23` |
| `G35` | `real` | `$MAT9_G35` | `MAT9_G35 #228 real` | `mat9_menu.tpl:24` |
| `G36` | `real` | `$MAT9_G36` | `MAT9_G36 #229 real` | `mat9_menu.tpl:25` |
| `G44` | `real` | `$MAT9_G44` | `MAT9_G44 #230 real` | `mat9_menu.tpl:29` |
| `G45` | `real` | `$MAT9_G45` | `MAT9_G45 #231 real` | `mat9_menu.tpl:30` |
| `G46` | `real` | `$MAT9_G46` | `MAT9_G46 #232 real` | `mat9_menu.tpl:31` |
| `G55` | `real` | `$MAT9_G55` | `MAT9_G55 #233 real` | `mat9_menu.tpl:32` |
| `G56` | `real` | `$MAT9_G56` | `MAT9_G56 #234 real` | `mat9_menu.tpl:33` |
| `G66` | `real` | `$MAT9_G66` | `MAT9_G66 #235 real` | `mat9_menu.tpl:34` |
| `RHO` | `real` | `$MAT9_RHO` | `MAT9_RHO #236 real` | `mat9_menu.tpl:35` |
| `A1` | `real` | `$MAT9_A1` | `MAT9_A1 #237 real` | `mat9_menu.tpl:36` |
| `A2` | `real` | `$MAT9_A2` | `MAT9_A2 #238 real` | `mat9_menu.tpl:40` |
| `A3` | `real` | `$MAT9_A3` | `MAT9_A3 #239 real` | `mat9_menu.tpl:41` |
| `A4` | `real` | `$MAT9_A4` | `MAT9_A4 #240 real` | `mat9_menu.tpl:42` |
| `A5` | `real` | `$MAT9_A5` | `MAT9_A5 #241 real` | `mat9_menu.tpl:43` |
| `A6` | `real` | `$MAT9_A6` | `MAT9_A6 #242 real` | `mat9_menu.tpl:44` |
| `TREF` | `real` | `$MAT9_TREF` | `MAT9_TREF #243 real` | `mat9_menu.tpl:45` |
| `GE` | `real` | `$MAT9_GE` | `MAT9_GE #244 real` | `mat9_menu.tpl:47` |
| `Form` | `string` | `$MATEP_FORM` | `MATEP_FORM #5021 string` | `matep_menu.tpl:11` |
| `Y0` | `real` | `$MATEP_Y0` | `MATEP_Y0 #5022 real` | `matep_menu.tpl:18` |
| `FID` | `entity` | `$MATEP_FID` | `MATEP_FID #5023 entity` | `matep_menu.tpl:20` |
| `RYIELD` | `string` | `$MATEP_RYIELD` | `MATEP_RYIELD #8529 string` | `matep_menu.tpl:23` |
| `Wkhard` | `string` | `$MATEP_WKHARD` | `MATEP_WKHARD #5025 string` | `matep_menu.tpl:35` |
| `Method` | `string` | `$MATEP_METHOD` | `MATEP_METHOD #5026 string` | `matep_menu.tpl:46` |
| `H` | `real` | `$MATEP_H` | `MATEP_H #5027 real` | `matep_menu.tpl:54` |
| `Option` | `string` | `$MATEP_OPTION` | `MATEP_OPTION #5030 string` | `matep_menu.tpl:64` |
| `RTID` | `entity` | `$MATEP_RTID` | `MATEP_RTID #5031 entity` | `matep_menu.tpl:68` |
| `C` | `real` | `$MATEP_C` | `MATEP_C #5032 real` | `matep_menu.tpl:70` |
| `P` | `real` | `$MATEP_P` | `MATEP_P #5033 real` | `matep_menu.tpl:73` |
| `R11` | `real` | `$MATEP_R11` | `MATEP_R11 #5037 real` | `matep_menu.tpl:86` |
| `R22` | `real` | `$MATEP_R22` | `MATEP_R22 #5038 real` | `matep_menu.tpl:89` |
| `R33` | `real` | `$MATEP_R33` | `MATEP_R33 #5039 real` | `matep_menu.tpl:92` |
| `R12` | `real` | `$MATEP_R12` | `MATEP_R12 #5040 real` | `matep_menu.tpl:95` |
| `R23` | `real` | `$MATEP_R23` | `MATEP_R23 #5041 real` | `matep_menu.tpl:98` |
| `R31` | `real` | `$MATEP_R31` | `MATEP_R31 #5042 real` | `matep_menu.tpl:101` |
| `M` | `real` | `$MATEP_R11` | `MATEP_R11 #5037 real` | `matep_menu.tpl:115` |
| `C1` | `real` | `$MATEP_R22` | `MATEP_R22 #5038 real` | `matep_menu.tpl:118` |
| `C2` | `real` | `$MATEP_R33` | `MATEP_R33 #5039 real` | `matep_menu.tpl:121` |
| `C3` | `real` | `$MATEP_R12` | `MATEP_R12 #5040 real` | `matep_menu.tpl:124` |
| `C6` | `real` | `$MATEP_R23` | `MATEP_R23 #5041 real` | `matep_menu.tpl:127` |
| `Option` | `string` | `$MATEP_OPTION1` | `MATEP_OPTION1 #5045 string` | `matep_menu.tpl:140` |
| `Yc10` | `real` | `$MATEP_YC10` | `MATEP_YC10 #5046 real` | `matep_menu.tpl:146` |
| `TID` | `entity` | `$MATEP_TID` | `MATEP_TID #5047 entity` | `matep_menu.tpl:147` |
| `N/A` | `string` | `$MATEP_NA` | `MATEP_NA #5036 string` | `matep_menu.tpl:149` |
| `Option` | `string` | `$MATEP_OPTION2` | `MATEP_OPTION2 #5050 string` | `matep_menu.tpl:160` |
| `Alpha` | `real` | `$MATEP_ALPHA` | `MATEP_ALPHA #5051 real` | `matep_menu.tpl:164` |
| `Beta` | `real` | `$MATEP_BETA` | `MATEP_BETA #5052 real` | `matep_menu.tpl:166` |
| `Cracks` | `real` | `$MATEP_CRACKS` | `MATEP_CRACKS #5053 real` | `matep_menu.tpl:168` |
| `Soften` | `real` | `$MATEP_SOFTEN` | `MATEP_SOFTEN #5054 real` | `matep_menu.tpl:170` |
| `Crushs` | `real` | `$MATEP_CRUSHS` | `MATEP_CRUSHS #5055 real` | `matep_menu.tpl:173` |
| `Srfac` | `real` | `$MATEP_SRFAC` | `MATEP_SRFAC #5056 real` | `matep_menu.tpl:176` |
| `q1` | `real` | `$MATEP_Q1` | `MATEP_Q1 #5059 real` | `matep_menu.tpl:188` |
| `q2` | `real` | `$MATEP_Q2` | `MATEP_Q2 #5060 real` | `matep_menu.tpl:191` |
| `initial` | `real` | `$MATEP_INITIAL` | `MATEP_INITIAL #5061 real` | `matep_menu.tpl:194` |
| `critical` | `real` | `$MATEP_CRITICAL` | `MATEP_CRITICAL #5062 real` | `matep_menu.tpl:197` |
| `failure` | `real` | `$MATEP_FAILURE` | `MATEP_FAILURE #5063 real` | `matep_menu.tpl:200` |
| `nucl` | `string` | `$MATEP_NUCL` | `MATEP_NUCL #5064 string` | `matep_menu.tpl:203` |
| `Mean` | `real` | `$MATEP_MEAN` | `MATEP_MEAN #5065 real` | `matep_menu.tpl:208` |
| `Sdev` | `real` | `$MATEP_SDEV` | `MATEP_SDEV #5066 real` | `matep_menu.tpl:214` |
| `Nfrac` | `real` | `$MATEP_NFRAC` | `MATEP_NFRAC #5067 real` | `matep_menu.tpl:217` |
| `R0` | `real` | `$MATEP_R0` | `MATEP_R0 #8532 real` | `matep_menu.tpl:229` |
| `Rinf` | `real` | `$MATEP_Rinf` | `MATEP_Rinf #8533 real` | `matep_menu.tpl:231` |
| `B` | `real` | `$MATEP_B` | `MATEP_B #8534 real` | `matep_menu.tpl:233` |
| `C` | `real` | `$MATEP_CC` | `MATEP_CC #8535 real` | `matep_menu.tpl:235` |
| `Gam` | `real` | `$MATEP_Gam` | `MATEP_Gam #8536 real` | `matep_menu.tpl:237` |
| `Kap` | `real` | `$MATEP_Kap` | `MATEP_Kap #8537 real` | `matep_menu.tpl:239` |
| `N` | `integer` | `$MATEP_N` | `MATEP_N #8528 integer` | `matep_menu.tpl:241` |
| `Qm` | `real` | `$MATEP_Qm` | `MATEP_Qm #8538 real` | `matep_menu.tpl:246` |
| `Mu` | `real` | `$MATEP_Mu` | `MATEP_Mu #8539 real` | `matep_menu.tpl:248` |
| `Nu` | `real` | `$MATEP_Nu` | `MATEP_Nu #8540 real` | `matep_menu.tpl:250` |
| `Option` | `string` | `$MATEP_OPTION3` | `MATEP_OPTION3 #8541 string` | `matep_menu.tpl:261` |
| `Uopt` | `string` | `$MATEP_Uopt` | `MATEP_Uopt #8526 string` | `matep_menu.tpl:274` |
| `Nvp` | `string` | `$MATEP_Nvp` | `MATEP_Nvp #8544 string` | `matep_menu.tpl:290` |
| `Vp1` | `real` | `$MATEP_Vp1` | `MATEP_Vp1 #8545 real` | `matep_menu.tpl:295` |
| `Vp2` | `real` | `$MATEP_Vp2` | `MATEP_Vp2 #8546 real` | `matep_menu.tpl:298` |
| `Vmises` | `real` | `$MATEP_Vmises` | `MATEP_Vmises #8548 real` | `matep_menu.tpl:311` |
| `T(Y0)` | `entity` | `$MATTEP_TY0` | `MATTEP_TY0 #5168 entity` | `matep_menu.tpl:323` |
| `T(FID)` | `entity` | `$MATTEP_TFID` | `MATTEP_TFID #5169 entity` | `matep_menu.tpl:326` |
| `T(H)` | `entity` | `$MATTEP_TH` | `MATTEP_TH #5170 entity` | `matep_menu.tpl:332` |
| `T(YC10)FDS` | `entity` | `$MATTEP_TYC10` | `MATTEP_TYC10 #5171 entity` | `matep_menu.tpl:340` |
| `T(G11)` | `entity` | `$MATT9_TG11` | `MATT9_TG11 #5284 entity` | `mat9_menu.tpl:55` |
| `T(G12)` | `entity` | `$MATT9_TG12` | `MATT9_TG12 #5285 entity` | `mat9_menu.tpl:58` |
| `T(G13)` | `entity` | `$MATT9_TG13` | `MATT9_TG13 #5286 entity` | `mat9_menu.tpl:61` |
| `T(G14)` | `entity` | `$MATT9_TG14` | `MATT9_TG14 #5287 entity` | `mat9_menu.tpl:64` |
| `T(G15)` | `entity` | `$MATT9_TG15` | `MATT9_TG15 #5288 entity` | `mat9_menu.tpl:67` |
| `T(G16)` | `entity` | `$MATT9_TG16` | `MATT9_TG16 #5289 entity` | `mat9_menu.tpl:70` |
| `T(G22)` | `entity` | `$MATT9_TG22` | `MATT9_TG22 #5290 entity` | `mat9_menu.tpl:73` |
| `T(G23)` | `entity` | `$MATT9_TG23` | `MATT9_TG23 #5291 entity` | `mat9_menu.tpl:78` |
| `T(G24)` | `entity` | `$MATT9_TG24` | `MATT9_TG24 #5292 entity` | `mat9_menu.tpl:81` |
| `T(G25)` | `entity` | `$MATT9_TG25` | `MATT9_TG25 #5293 entity` | `mat9_menu.tpl:84` |
| `T(G26)` | `entity` | `$MATT9_TG26` | `MATT9_TG26 #5294 entity` | `mat9_menu.tpl:87` |
| `T(G33)` | `entity` | `$MATT9_TG33` | `MATT9_TG33 #5295 entity` | `mat9_menu.tpl:90` |
| `T(G34)` | `entity` | `$MATT9_TG34` | `MATT9_TG34 #5296 entity` | `mat9_menu.tpl:93` |
| `T(G35)` | `entity` | `$MATT9_TG35` | `MATT9_TG35 #5297 entity` | `mat9_menu.tpl:96` |
| `T(G36)` | `entity` | `$MATT9_TG36` | `MATT9_TG36 #5298 entity` | `mat9_menu.tpl:99` |
| `T(G44)` | `entity` | `$MATT9_TG44` | `MATT9_TG44 #5299 entity` | `mat9_menu.tpl:104` |
| `T(G45)` | `entity` | `$MATT9_TG45` | `MATT9_TG45 #5300 entity` | `mat9_menu.tpl:107` |
| `T(G46)` | `entity` | `$MATT9_TG46` | `MATT9_TG46 #5301 entity` | `mat9_menu.tpl:110` |
| `T(G55)` | `entity` | `$MATT9_TG55` | `MATT9_TG55 #5302 entity` | `mat9_menu.tpl:113` |
| `T(G56)` | `entity` | `$MATT9_TG56` | `MATT9_TG56 #5303 entity` | `mat9_menu.tpl:116` |
| `T(G66)` | `entity` | `$MATT9_TG66` | `MATT9_TG66 #5304 entity` | `mat9_menu.tpl:119` |
| `T(RHO)` | `entity` | `$MATT9_TRHO` | `MATT9_TRHO #5305 entity` | `mat9_menu.tpl:122` |
| `T(A1)` | `entity` | `$MATT9_TA1` | `MATT9_TA1 #5306 entity` | `mat9_menu.tpl:125` |
| `T(A2)` | `entity` | `$MATT9_TA2` | `MATT9_TA2 #5307 entity` | `mat9_menu.tpl:130` |
| `T(A3)` | `entity` | `$MATT9_TA3` | `MATT9_TA3 #5308 entity` | `mat9_menu.tpl:133` |
| `T(A4)` | `entity` | `$MATT9_TA4` | `MATT9_TA4 #5309 entity` | `mat9_menu.tpl:136` |
| `T(A5)` | `entity` | `$MATT9_TA5` | `MATT9_TA5 #5310 entity` | `mat9_menu.tpl:139` |
| `T(A6)` | `entity` | `$MATT9_TA6` | `MATT9_TA6 #5311 entity` | `mat9_menu.tpl:142` |
| `T(GE)` | `entity` | `$MATT9_TGE` | `MATT9_TGE #5312 entity` | `mat9_menu.tpl:146` |
| `K` | `real` | `$MAT4_K` | `MAT4_K #265 real` | `mat4_menu.tpl:8` |
| `CP` | `real` | `$MAT4_CP` | `MAT4_CP #194 real` | `mat4_menu.tpl:10` |
| `RHO` | `real` | `$MAT4_RHO` | `MAT4_RHO #324 real` | `mat4_menu.tpl:12` |
| `H` | `real` | `$MAT4_H` | `MAT4_H #325 real` | `mat4_menu.tpl:15` |
| `MU` | `real` | `$MAT4_MU` | `MAT4_MU #327 real` | `mat4_menu.tpl:17` |
| `HGEN` | `real` | `$MAT4_HGEN` | `MAT4_HGEN #329 real` | `mat4_menu.tpl:19` |
| `REFENTH` | `real` | `$MAT4_REFENTH` | `MAT4_REFENTH #330 real` | `mat4_menu.tpl:22` |
| `TCH` | `real` | `$MAT4_TCH` | `MAT4_TCH #332 real` | `mat4_menu.tpl:27` |
| `TDELTA` | `real` | `$MAT4_TDELTA` | `MAT4_TDELTA #334 real` | `mat4_menu.tpl:29` |
| `QLAT` | `real` | `$MAT4_QLAT` | `MAT4_QLAT #336 real` | `mat4_menu.tpl:31` |
| `T(K)` | `entity` | `$MATT4_TK` | `MATT4_TK #1670 entity` | `mat4_menu.tpl:39` |
| `T(CP)` | `entity` | `$MATT4_TCP` | `MATT4_TCP #1671 entity` | `mat4_menu.tpl:42` |
| `T(H)` | `entity` | `$MATT4_TH` | `MATT4_TH #1672 entity` | `mat4_menu.tpl:46` |
| `T(U)` | `entity` | `$MATT4_TU` | `MATT4_TU #1673 entity` | `mat4_menu.tpl:49` |
| `T(HGEN)` | `entity` | `$MATT4_THGEN` | `MATT4_THGEN #1674 entity` | `mat4_menu.tpl:52` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `mat5_menu.tpl:7` |
| `KXX` | `real` | `$MAT5_KXX` | `MAT5_KXX #4946 real` | `mat5_menu.tpl:8` |
| `KXY` | `real` | `$MAT5_KXY` | `MAT5_KXY #4947 real` | `mat5_menu.tpl:10` |
| `KXZ` | `real` | `$MAT5_KXZ` | `MAT5_KXZ #4948 real` | `mat5_menu.tpl:12` |
| `KYY` | `real` | `$MAT5_KYY` | `MAT5_KYY #4949 real` | `mat5_menu.tpl:14` |
| `KYZ` | `real` | `$MAT5_KYZ` | `MAT5_KYZ #4950 real` | `mat5_menu.tpl:16` |
| `KZZ` | `real` | `$MAT5_KZZ` | `MAT5_KZZ #4951 real` | `mat5_menu.tpl:18` |
| `CP` | `real` | `$MAT5_CP` | `MAT5_CP #4952 real` | `mat5_menu.tpl:20` |
| `RHO` | `real` | `$MAT5_RHO` | `MAT5_RHO #4953 real` | `mat5_menu.tpl:24` |
| `HGEN` | `real` | `$MAT5_HGEN` | `MAT5_HGEN #4954 real` | `mat5_menu.tpl:26` |

### MATG

- Source: `materials.tpl:1142`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:1150` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `materials.tpl:1156` |
| `IDMEM` | `entity` | `$MATG_IDMEM` | `MATG_IDMEM #5129 entity` | `materials.tpl:1157` |
| `BEHAV` | `integer` | `$MATG_BEHAV` | `MATG_BEHAV #5130 integer` | `materials.tpl:1159` |
| `TABLD` | `integer` | `$MATG_TABLD` | `MATG_TABLD #5131 integer` | `materials.tpl:1160` |
| `TABLU` | `arrayofentity` | `$MATG_TABLUi` | `MATG_TABLUi #5132 arrayofentity` | `materials.tpl:1167` |
| `YPRS` | `real` | `$MATG_YPRS` | `MATG_YPRS #5133 real` | `materials.tpl:1175` |
| `EPL` | `real` | `$MATG_EPL` | `MATG_EPL #5134 real` | `materials.tpl:1176` |
| `GPL` | `real` | `$MATG_GPL` | `MATG_GPL #5135 real` | `materials.tpl:1180` |
| `GAP` | `real` | `$MATG_GAP` | `MATG_GAP #5136 real` | `materials.tpl:1181` |
| `TABYPRS` | `entity` | `$MATG_TABYPRS` | `MATG_TABYPRS #5137 entity` | `materials.tpl:1182` |
| `TABEPL` | `entity` | `$MATG_TABEPL` | `MATG_TABEPL #5138 entity` | `materials.tpl:1184` |
| `TABGPL` | `entity` | `$MATG_TABGPL` | `MATG_TABGPL #5139 entity` | `materials.tpl:1186` |
| `TABGAP` | `entity` | `$MATG_TABGAP` | `MATG_TABGAP #5140 entity` | `materials.tpl:1188` |

### MATHE

- Source: `materials.tpl:1273`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:1281` |
| `ID` | `integer` | `id` | `HM dataname `id`` | `materials.tpl:1287` |
| `MODEL` | `string` | `$MATHE_MODEL` | `MATHE_MODEL #5174 string` | `materials.tpl:1288` |
| `NOT` | `integer` | `$MATHE_NOT` | `MATHE_NOT #5175 integer` | `materials.tpl:1296` |
| `K` | `real` | `$MATHE_K` | `MATHE_K #5176 real` | `materials.tpl:1302` |
| `RHO` | `real` | `$MATHE_RHO` | `MATHE_RHO #5177 real` | `materials.tpl:1303` |
| `TEXP` | `real` | `$MATHE_TEXP` | `MATHE_TEXP #5178 real` | `materials.tpl:1306` |
| `TREF` | `real` | `$MATHE_TREF` | `MATHE_TREF #5179 real` | `materials.tpl:1309` |
| `GE` | `real` | `$MATHE_GE` | `MATHE_GE #5180 real` | `materials.tpl:1312` |
| `C10` | `real` | `$MATHE_C10` | `MATHE_C10 #5181 real` | `materials.tpl:1318` |
| `C01` | `real` | `$MATHE_C01` | `MATHE_C01 #5182 real` | `materials.tpl:1321` |
| `TAB1` | `entity` | `$MATHE_TAB1` | `MATHE_TAB1 #5183 entity` | `materials.tpl:1325` |
| `TAB2` | `entity` | `$MATHE_TAB2` | `MATHE_TAB2 #5184 entity` | `materials.tpl:1327` |
| `TAB3` | `entity` | `$MATHE_TAB3` | `MATHE_TAB3 #5185 entity` | `materials.tpl:1329` |
| `TAB4` | `entity` | `$MATHE_TAB4` | `MATHE_TAB4 #5186 entity` | `materials.tpl:1331` |
| `TABD` | `entity` | `$MATHE_TABD` | `MATHE_TABD #5187 entity` | `materials.tpl:1333` |
| `C20` | `real` | `$MATHE_C20` | `MATHE_C20 #5209 real` | `materials.tpl:1339` |
| `C11` | `real` | `$MATHE_C11` | `MATHE_C11 #5210 real` | `materials.tpl:1342` |
| `C30` | `real` | `$MATHE_C30` | `MATHE_C30 #5211 real` | `materials.tpl:1348` |
| `Mu1` | `real` | `$MATHE_MU1` | `MATHE_MU1 #5188 real` | `materials.tpl:1355` |
| `Alpha1` | `real` | `$MATHE_AL1` | `MATHE_AL1 #5189 real` | `materials.tpl:1358` |
| `Beta1` | `real` | `$MATHE_BT1` | `MATHE_BT1 #5190 real` | `materials.tpl:1361` |
| `Mu2` | `real` | `$MATHE_MU2` | `MATHE_MU2 #5191 real` | `materials.tpl:1378` |
| `Alpha2` | `real` | `$MATHE_AL2` | `MATHE_AL2 #5192 real` | `materials.tpl:1381` |
| `Beta2` | `real` | `$MATHE_BT2` | `MATHE_BT2 #5193 real` | `materials.tpl:1384` |
| `Mu3` | `real` | `$MATHE_MU3` | `MATHE_MU3 #5194 real` | `materials.tpl:1387` |
| `Alpha3` | `real` | `$MATHE_AL3` | `MATHE_AL3 #5195 real` | `materials.tpl:1390` |
| `Beta3` | `real` | `$MATHE_BT3` | `MATHE_BT3 #5196 real` | `materials.tpl:1393` |
| `Mu4` | `real` | `$MATHE_MU4` | `MATHE_MU4 #5197 real` | `materials.tpl:1399` |
| `Alpha4` | `real` | `$MATHE_AL4` | `MATHE_AL4 #5198 real` | `materials.tpl:1402` |
| `Beta4` | `real` | `$MATHE_BT4` | `MATHE_BT4 #5199 real` | `materials.tpl:1405` |
| `Mu5` | `real` | `$MATHE_MU5` | `MATHE_MU5 #5200 real` | `materials.tpl:1408` |
| `Alpha5` | `real` | `$MATHE_AL5` | `MATHE_AL5 #5201 real` | `materials.tpl:1411` |
| `Beta5` | `real` | `$MATHE_BT5` | `MATHE_BT5 #5202 real` | `materials.tpl:1414` |
| `NKT` | `real` | `$MATHE_NKT` | `MATHE_NKT #5203 real` | `materials.tpl:1422` |
| `N/E` | `real` | `$MATHE_NE` | `MATHE_NE #5204 real` | `materials.tpl:1425` |
| `Im` | `real` | `$MATHE_IM` | `MATHE_IM #5205 real` | `materials.tpl:1428` |

### MATHP

- Source: `materials.tpl:592`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:600` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `materials.tpl:606` |
| `A10` | `real` | `$MATHP_A10` | `MATHP_A10 #4428 real` | `materials.tpl:607` |
| `A01` | `real` | `$MATHP_A01` | `MATHP_A01 #4429 real` | `materials.tpl:609` |
| `D1` | `real` | `$MATHP_D1` | `MATHP_D1 #4430 real` | `materials.tpl:611` |
| `RHO` | `real` | `$MATHP_RHO` | `MATHP_RHO #4431 real` | `materials.tpl:613` |
| `AV` | `real` | `$MATHP_AV` | `MATHP_AV #4432 real` | `materials.tpl:615` |
| `TREF` | `real` | `$MATHP_TREF` | `MATHP_TREF #4433 real` | `materials.tpl:617` |
| `GE` | `real` | `$MATHP_GE` | `MATHP_GE #4434 real` | `materials.tpl:619` |
| `NA` | `integer` | `$MATHP_NA` | `MATHP_NA #4435 integer` | `materials.tpl:625` |
| `ND` | `integer` | `$MATHP_ND` | `MATHP_ND #4436 integer` | `materials.tpl:627` |
| `A20` | `real` | `$MATHP_A20` | `MATHP_A20 #4437 real` | `materials.tpl:632` |
| `A11` | `real` | `$MATHP_A11` | `MATHP_A11 #4438 real` | `materials.tpl:634` |
| `A02` | `real` | `$MATHP_A02` | `MATHP_A02 #4439 real` | `materials.tpl:636` |
| `D2` | `real` | `$MATHP_D2` | `MATHP_D2 #4440 real` | `materials.tpl:638` |
| `A30` | `real` | `$MATHP_A30` | `MATHP_A30 #4441 real` | `materials.tpl:643` |
| `A21` | `real` | `$MATHP_A21` | `MATHP_A21 #4442 real` | `materials.tpl:645` |
| `A12` | `real` | `$MATHP_A12` | `MATHP_A12 #4443 real` | `materials.tpl:647` |
| `A03` | `real` | `$MATHP_A03` | `MATHP_A03 #4444 real` | `materials.tpl:649` |
| `D3` | `real` | `$MATHP_D3` | `MATHP_D3 #4445 real` | `materials.tpl:651` |
| `A40` | `real` | `$MATHP_A40` | `MATHP_A40 #4446 real` | `materials.tpl:657` |
| `A31` | `real` | `$MATHP_A31` | `MATHP_A31 #4447 real` | `materials.tpl:659` |
| `A22` | `real` | `$MATHP_A22` | `MATHP_A22 #4448 real` | `materials.tpl:661` |
| `A13` | `real` | `$MATHP_A13` | `MATHP_A13 #4449 real` | `materials.tpl:663` |
| `A04` | `real` | `$MATHP_A04` | `MATHP_A04 #4450 real` | `materials.tpl:665` |
| `D4` | `real` | `$MATHP_D4` | `MATHP_D4 #4451 real` | `materials.tpl:667` |
| `A50` | `real` | `$MATHP_A50` | `MATHP_A50 #4452 real` | `materials.tpl:673` |
| `A41` | `real` | `$MATHP_A41` | `MATHP_A41 #4453 real` | `materials.tpl:675` |
| `A32` | `real` | `$MATHP_A32` | `MATHP_A32 #4454 real` | `materials.tpl:677` |
| `A23` | `real` | `$MATHP_A23` | `MATHP_A23 #4455 real` | `materials.tpl:679` |
| `A14` | `real` | `$MATHP_A14` | `MATHP_A14 #4456 real` | `materials.tpl:681` |
| `A05` | `real` | `$MATHP_A05` | `MATHP_A05 #4457 real` | `materials.tpl:683` |
| `D5` | `real` | `$MATHP_D5` | `MATHP_D5 #4458 real` | `materials.tpl:685` |
| `TAB1` | `entity` | `$MATHP_TAB1` | `MATHP_TAB1 #4459 entity` | `materials.tpl:690` |
| `TAB2` | `entity` | `$MATHP_TAB2` | `MATHP_TAB2 #4460 entity` | `materials.tpl:693` |
| `TAB3` | `entity` | `$MATHP_TAB3` | `MATHP_TAB3 #4461 entity` | `materials.tpl:696` |
| `TAB4` | `entity` | `$MATHP_TAB4` | `MATHP_TAB4 #4462 entity` | `materials.tpl:699` |
| `TABD` | `entity` | `$MATHP_TABD` | `MATHP_TABD #4463 entity` | `materials.tpl:705` |

### MATORT

- Source: `materials.tpl:1635`
- Options/subcards: `User Comments`

| Field | Type | Backing ref | Attr | Source |
|---|---|---|---|---|
| `Entity_Comments` | `string` | `$COMMENT_ARRAY` | `COMMENT_ARRAY #3238 arrayofstring` | `materials.tpl:1643` |
| `MID` | `integer` | `id` | `HM dataname `id`` | `materials.tpl:1649` |
| `E1` | `real` | `$MAT9ORT_E1` | `MAT9ORT_E1 #1519 real` | `materials.tpl:1650` |
| `E2` | `real` | `$MAT9ORT_E2` | `MAT9ORT_E2 #1520 real` | `materials.tpl:1653` |
| `E3` | `real` | `$MAT9ORT_E3` | `MAT9ORT_E3 #1521 real` | `materials.tpl:1656` |
| `NU12` | `real` | `$MAT9ORT_NU12` | `MAT9ORT_NU12 #1522 real` | `materials.tpl:1659` |
| `NU23` | `real` | `$MAT9ORT_NU23` | `MAT9ORT_NU23 #1523 real` | `materials.tpl:1661` |
| `NU31` | `real` | `$MAT9ORT_NU31` | `MAT9ORT_NU31 #1524 real` | `materials.tpl:1663` |
| `RHO` | `real` | `$MAT9ORT_RHO` | `MAT9ORT_RHO #1525 real` | `materials.tpl:1665` |
| `G12` | `real` | `$MAT9ORT_G12` | `MAT9ORT_G12 #1526 real` | `materials.tpl:1671` |
| `G23` | `real` | `$MAT9ORT_G23` | `MAT9ORT_G23 #1527 real` | `materials.tpl:1673` |
| `G31` | `real` | `$MAT9ORT_G31` | `MAT9ORT_G31 #1528 real` | `materials.tpl:1675` |
| `A1` | `real` | `$MAT9ORT_A1` | `MAT9ORT_A1 #1529 real` | `materials.tpl:1677` |
| `A2` | `real` | `$MAT9ORT_A2` | `MAT9ORT_A2 #1530 real` | `materials.tpl:1679` |
| `A3` | `real` | `$MAT9ORT_A3` | `MAT9ORT_A3 #1531 real` | `materials.tpl:1681` |
| `TREF` | `real` | `$MAT9ORT_TREF` | `MAT9ORT_TREF #1532 real` | `materials.tpl:1683` |
| `GE` | `real` | `$MAT9ORT_GE` | `MAT9ORT_GE #1533 real` | `materials.tpl:1685` |
| `IYLD` | `integer` | `$MATORT_IYLD` | `MATORT_IYLD #9987 integer` | `materials.tpl:1691` |
| `IHARD` | `integer` | `$MATORT_IHARD` | `MATORT_IHARD #9988 integer` | `materials.tpl:1699` |
| `SY` | `real` | `$MATORT_SY` | `MATORT_SY #9989 real` | `materials.tpl:1705` |
| `Y1` | `real` | `$MATORT_Y1` | `MATORT_Y1 #9990 real` | `materials.tpl:1709` |
| `Y2` | `real` | `$MATORT_Y2` | `MATORT_Y2 #9991 real` | `materials.tpl:1713` |
| `Y3` | `real` | `$MATORT_Y3` | `MATORT_Y3 #9992 real` | `materials.tpl:1717` |
| `Yshr1` | `real` | `$MATORT_Yshr1` | `MATORT_Yshr1 #9993 real` | `materials.tpl:1726` |
| `Yshr2` | `real` | `$MATORT_Yshr2` | `MATORT_Yshr2 #9994 real` | `materials.tpl:1730` |
| `Yshr3` | `real` | `$MATORT_Yshr3` | `MATORT_Yshr3 #9995 real` | `materials.tpl:1734` |

## Attribute Lookup Notes

Use these APIs to inspect card attributes at runtime when direct datanames fail:

```tcl
set max [hm_attributeindexmax properties $pid -byid]
set name [hm_attributeindexidentifier properties $pid $index -byid]
set value [hm_attributeindexvalue properties $pid $index -byid]
*attributeupdatedouble properties $pid $attr_id 1 2 0 $value
*attributeupdateint properties $pid $attr_id 18 2 0 $value
```

For materials, replace `properties` with `materials`.
