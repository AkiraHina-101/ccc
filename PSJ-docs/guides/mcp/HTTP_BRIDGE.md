# HTTP bridge reference

The separate local HTTP bridge is an adapter around PSJ tools; it is not an MCP server and is not part of this documentation corpus. This page records its conceptual interface for AI reference only.

## Operations

- `POST /search_psj`: search API documentation. Supported modes in the described adapter are `auto`, `filename`, and `semantic`.
- `POST /run`: execute a Python script in a Jupiter process.
- `POST /test_gui`: run a GUI script in a temporary Jupiter process and capture a screenshot.
- `GET /health`: readiness status.
- `GET /openapi.json`: tool schema.

The adapter's execution endpoints can run code and interact with an application. This reference does not authorize or instruct an AI to configure or invoke them. Deployment, authentication, host paths, network binding, and operational safeguards belong to the separately maintained bridge documentation and host environment.
