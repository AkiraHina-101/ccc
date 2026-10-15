# Scope: AI access to PSJ API documentation

## Purpose

This folder is a read-only knowledge source for AI systems to search, read, and understand the PSJ/Jupiter API and the structure of its documentation MCP. Its contents support explanation and reference lookup.

## In scope

- Read and search files contained in this documentation corpus.
- Compare versioned API references and explain documented signatures, parameters, return values, and examples.
- Explain the documentation MCP lookup model using the included guidance: indexed search, exact API lookup, paginated document reads, and version listing.
- Cite the relevant source page and distinguish documented facts from runtime-confirmed behavior or inference.

## Out of scope

- Running macros, changing a model, controlling the Jupiter GUI, or invoking a live PSJ API.
- Reading or changing files outside this documentation corpus.
- Treating this repository as the MCP server or as a client configuration. MCP implementation and machine-specific connection settings are maintained separately.
- Assuming that help text, XML templates, or an example prove runtime behavior for every version.

## Version and evidence

The current runtime snapshot in this corpus is for Jupiter 5.0.4. Verify the target version before relying on signatures or behavior. When sources disagree, report the disagreement and prefer version-matched runtime evidence when available. Use readback or other direct evidence before describing a mutation as successful.
