# HWAT Tcl coding conventions — 2022.3

Source: [Altair Coding Conventions](https://2022.help.altair.com/2022.3/hwcfdsolvers/altair_help/topics/tools/hwat_coding_conventions_r.htm), part of the public 2022.3 HWAT documentation.

This is a concise summary of the toolkit-specific conventions. Apply them when contributing to or extending HWAT-style automation; do not treat every naming convention as a HyperMesh Tcl language requirement.

## Style rules

- End lines with semicolons.
- Use lowercase namespace names beginning with `::`; use uppercase function names and lower camel/prefix style variables.
- The guide recommends Hungarian-style prefixes: integer `n_`, float/double `d_`, string `str_`, Boolean `b_`, array `arr_`. Append `List` to list-variable names; call return-value variables `retval`.
- Widget prefixes include button `btn_`, canvas `cnv_`, textbox `txt_`, combobox `cmb_`, frame `frm_`, radiobutton `rad_`, checkbox `chk_`, collector `col_`, label `lbl_`, entry `ent_` and scrollbar `scr_`.
- Define a namespace with an empty `namespace eval` block, then define fully qualified procedures separately, matching the guide's preferred example.

## Function behavior and messages

- Return `1` or another meaningful value for success/partial success; return `{}` on failure. The source page explains that this represents a null-like failure result in Tcl.
- Use `::hwat::utils::WriteErrorMessage` for error messages. Use `WriteDebugMessage` when `hwat::globals::DEBUG` is enabled; use `SetDebugOnOff` to set that flag.
- `::hwat::utils::PostToMessageBox` routes messages to the HyperWorks message box or a Tk message box in HyperMesh.

## Function headers

The guide specifies a parseable procedure header with `##` fields for procedure name, description, arguments, returns, comments, author and last-updated date. Put one argument per line, list the most recent editor first, and keep developer detail after the machine-parsed header using ordinary `#` comments. Update the header in place rather than appending a second one.

## Related references

- [HWAT function quick reference — 2022.3](HWAT_FUNCTION_REFERENCE_2022_3.md) — syntax, arguments, returns, descriptions and links for the 179 `::hwat::*` terms exposed by the Simulation Help Index Terms.
- [HWTK widget quick reference — 2022.3](HWTK_WIDGET_REFERENCE_2022_3.md) — 40 widget references and 3 related topic pages.
- [HWAT overview — HyperWorks Desktop 2022.3](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hm/hwat_r.htm) — Tcl package loading and the seven documented categories.

The coding-convention article contains examples with inconsistent namespace spellings and historical header content. Follow the written rule that applies to the requested code, then consult the exact function page for its contract.

