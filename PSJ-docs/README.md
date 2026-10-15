# PSJ API documentation

This folder is a read-only reference corpus for AI-assisted lookup of the PSJ/Jupiter API. It contains API references, versioned vendor help, and guides for searching and interpreting those sources. It does not include an MCP server implementation.

## Start here

- [Scope and evidence rules](SCOPE.md)
- [API catalog](reference/API-CATALOG.md)
- [Runtime API snapshot for Jupiter 5.0.4](reference/RUNTIME-API.md)
- [API quick reference](reference/API-QUICK-REFERENCE.md)
- [General guides](guides/README.md)
- [GUI design-language survey](guides/jupiter-ui-design-language.md)
- [Source documentation inventory](sources/README.md)

## Using this corpus

Prefer the API catalog and version filters over opening many individual pages. Check the API version and locale before applying an example. Treat runtime signatures and successful readback as stronger evidence than names inferred from XML or prose. Source files are preserved as references; this folder does not provide executable tools or an MCP endpoint.

The documentation MCP implementation and its setup are maintained separately from this folder. Paths and client configuration must be supplied by the host environment; this corpus contains no machine-specific configuration.
