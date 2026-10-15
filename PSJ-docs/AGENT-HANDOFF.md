# AI handoff — PSJ API documentation

This repository folder is a read-only documentation corpus for AI lookup and understanding of the PSJ/Jupiter API and documentation MCP concepts. It is not a project workspace and does not authorize actions on a local application or machine.

## API reference state

- The runtime snapshot and API catalog describe Jupiter 5.0.4. Confirm the target runtime version before applying an API signature.
- Use `reference/API-CATALOG.md` and the versioned runtime snapshot for lookup; use the source pages under `sources/` to verify context.
- The corpus includes source-derived help and extracted reference material. A documented method does not by itself prove that every runtime build implements it identically.
- Prefer runtime signatures and observed readback where available. Label inferences from XML, help text, or examples as inferences.

## MCP lookup model

The separate documentation MCP uses a local SQLite FTS index and exposes read-only search, exact API lookup, paginated document reading, and version listing. It does not require Jupiter to run. Its server code and client configuration are not included in this documentation-only upload; configure paths in the host environment rather than copying machine-specific paths into this corpus.

## Publication boundary

Only the included API documentation, reference, guide, and source trees are intended for AI reading and lookup. Do not treat this folder as instructions to execute macros, modify models, operate the GUI, or access unrelated local files. Update this handoff when the corpus version or lookup model changes.
