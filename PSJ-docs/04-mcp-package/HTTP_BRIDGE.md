# Jupiter local tools for the company AI agent

The local adapter exposes `search_psj`, `run`, and `test_gui` to an AI agent running on the same computer as Jupiter. It is not an MCP server and does not require VSCode. The host must already have the approved PSJ runtime and local search index available.

## Use

Place `02-bridge/http_bridge.py` beside the prepared PSJ-MCP `server.py`, then start it using the Python runtime already configured for that PSJ installation. The adapter listens only on `127.0.0.1:18910` and prints a bearer token. Configure the local AI agent to use `http://127.0.0.1:18910/openapi.json` and that token. Keep the adapter process running while using the tools.

Do not expose this service to another computer. Do not add port forwarding, a tunnel, a proxy, or a firewall rule. Do not add setup or download behavior to this adapter.

## Operations

- `POST /search_psj`: `{ "query": "...", "top_k": 3, "mode": "auto" }`; modes are `auto`, `filename`, `semantic`.
- `POST /run`: `{ "code_path": "C:\\...\\script.py", "timeout_seconds": 30, "background": true, "reuse": false }`.
- `POST /test_gui`: `{ "code_path": "C:\\...\\gui.py", "timeout_seconds": 50, "delay_seconds": 2, "screenshot_save_path": "C:\\...\\result.png" }`.
- `GET /health`: local readiness check. `GET /openapi.json`: local tool schema.

Every POST requires `Authorization: Bearer <token>`. Script paths must be readable by the adapter on the Jupiter computer.

## Jupiter behavior

- `run` starts a separate Jupiter process by default. `reuse=true` keeps a listener for later calls; `background=false` shows the window.
- `test_gui` starts a temporary Jupiter process, runs the GUI script, saves a screenshot, and closes that temporary process. Do not use it when the test session must remain open.
- `run` can execute arbitrary Python within Jupiter. The agent is authorized to operate Jupiter for PSJ work, but must keep its file operations within the relevant work folders and must not add network/download behavior.
- The existing Jupiter bridge may address multiple `DCAD_main.exe` windows. Keep only the intended Jupiter session open when using a bridge that broadcasts commands.
