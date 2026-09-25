"""Local HTTP adapter for the PSJ tools, for AI clients without an MCP client.

Run with the same Python environment and files used by PSJ-mcp. The service
binds only to loopback and requires a bearer token because `run` executes code
inside Jupiter.
"""

from __future__ import annotations

import hmac
import json
import os
import secrets
import shutil
import tempfile
import threading
import time
import traceback
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse

from scripts.jupiter import launchJupiter, runOnce, runReuse
from scripts.psj_docs import filename_match, semantic_search
from scripts.window import enumerateWindowHwnds, findChildWindowByTitle
from config import (
    DCAD_EXE, GUI_TEST_DELAY_SECONDS, GUI_TEST_TEMPLATE, GUI_TEST_TIMEOUT_SECONDS,
    POLL_INTERVAL_SECONDS, STARTUP_TIMEOUT_SECONDS,
)


HOST = "127.0.0.1"
PORT = int(os.environ.get("PSJ_HTTP_PORT", "18910"))
TOKEN = os.environ.get("PSJ_HTTP_TOKEN") or secrets.token_urlsafe(32)


def _gui_test(payload: dict) -> dict:
    """Equivalent of MCP test_gui; always terminates the test Jupiter process."""
    code_path = str(payload.get("code_path", ""))
    try:
        code = Path(code_path).read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as exc:
        return {"success": False, "error": f"Cannot read code_path: {exc}", "screenshot_path": None}

    timeout = max(1, min(int(payload.get("timeout_seconds", GUI_TEST_TIMEOUT_SECONDS)), 300))
    delay = max(0, min(int(payload.get("delay_seconds", GUI_TEST_DELAY_SECONDS)), 30))
    call_dir = Path(tempfile.mkdtemp(prefix="psj_http_gui_"))
    proc = None
    try:
        ready = call_dir / "ready.flag"
        code_file = call_dir / "user_code.py"
        wrapper = call_dir / "wrapper.py"
        result_file = call_dir / "result.json"
        screenshot = call_dir / "screenshot.png"
        save_path = str(payload.get("screenshot_save_path", "") or "")
        wrapper.write_text(GUI_TEST_TEMPLATE.format(
            ready_path=str(ready), code_path=str(code_file),
            result_path=str(result_file), poll_interval=POLL_INTERVAL_SECONDS,
        ), encoding="utf-8")
        proc = launchJupiter([str(DCAD_EXE), "-py", str(wrapper)], background=False)

        deadline = time.monotonic() + STARTUP_TIMEOUT_SECONDS
        while time.monotonic() < deadline:
            if ready.exists():
                break
            if proc.poll() is not None:
                return {"success": False, "error": "Jupiter exited before loading.", "screenshot_path": None}
            time.sleep(POLL_INTERVAL_SECONDS)
        else:
            return {"success": False, "error": "Timed out waiting for Jupiter to load.", "screenshot_path": None}

        code_file.write_text(code, encoding="utf-8")
        deadline = time.monotonic() + timeout
        while time.monotonic() < deadline:
            if result_file.exists():
                result = json.loads(result_file.read_text(encoding="utf-8"))
                if not result.get("success"):
                    return {"success": False, "error": result.get("error"), "screenshot_path": None,
                            "stdout": result.get("stdout", ""), "stderr": result.get("stderr", "")}
                break
            if proc.poll() is not None:
                return {"success": False, "error": "Jupiter exited unexpectedly.", "screenshot_path": None}
            time.sleep(POLL_INTERVAL_SECONDS)
        else:
            return {"success": False, "error": f"Timed out after {timeout}s waiting for GUI initialization.",
                    "screenshot_path": None}

        time.sleep(delay)
        hwnds = enumerateWindowHwnds(proc.pid)
        title = None
        import re
        match = re.search(r'title\s*=\s*["\']([^"\']+)["\']', code)
        if match:
            title = findChildWindowByTitle(proc.pid, match.group(1))
        hwnd = title or next(iter(hwnds), None)
        if hwnd is None:
            return {"success": False, "error": "No Jupiter windows found for screenshot.", "screenshot_path": None}

        import subprocess
        capture_script = Path(__file__).parent / "scripts" / "capture_by_hwnd.ps1"
        captured = subprocess.run(
            ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(capture_script),
             "-HwndValue", str(hwnd), "-OutputPath", str(screenshot)],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
        )
        if captured.returncode != 0:
            return {"success": False, "error": captured.stderr.strip() or captured.stdout.strip(),
                    "screenshot_path": None}
        capture_result = json.loads(captured.stdout.strip())
        if not capture_result.get("success"):
            return {"success": False, "error": capture_result.get("error", "Screenshot failed."),
                    "screenshot_path": None}
        final_path = str(screenshot)
        if save_path:
            destination = Path(save_path)
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(screenshot, destination)
            final_path = str(destination)
        return {"success": True, "error": None, "screenshot_path": final_path}
    except Exception:
        return {"success": False, "error": traceback.format_exc(), "screenshot_path": None}
    finally:
        if proc is not None and proc.poll() is None:
            proc.kill()
            proc.wait()
        shutil.rmtree(call_dir, ignore_errors=True)


OPENAPI = {
    "openapi": "3.1.0", "info": {"title": "PSJ local tools", "version": "1.0.0"},
    "servers": [{"url": f"http://{HOST}:{PORT}"}],
    "security": [{"BearerAuth": []}],
    "components": {"securitySchemes": {"BearerAuth": {"type": "http", "scheme": "bearer"}}},
    "paths": {
        "/search_psj": {"post": {"operationId": "search_psj", "summary": "Search local PSJ docs",
            "requestBody": {"required": True, "content": {"application/json": {"schema": {
                "type": "object", "required": ["query"], "properties": {
                    "query": {"type": "string"}, "top_k": {"type": "integer", "default": 3},
                    "mode": {"type": "string", "enum": ["auto", "filename", "semantic"], "default": "auto"}}}}}},
            "responses": {"200": {"description": "Search result"}}}},
        "/run": {"post": {"operationId": "run", "summary": "Run a Python file in Jupiter",
            "requestBody": {"required": True, "content": {"application/json": {"schema": {
                "type": "object", "required": ["code_path"], "properties": {
                    "code_path": {"type": "string"}, "timeout_seconds": {"type": "integer", "default": 30},
                    "background": {"type": "boolean", "default": True},
                    "reuse": {"type": "boolean", "default": False}}}}}},
            "responses": {"200": {"description": "Execution result"}}}},
        "/test_gui": {"post": {"operationId": "test_gui", "summary": "Run GUI code, capture screenshot, close test Jupiter",
            "requestBody": {"required": True, "content": {"application/json": {"schema": {
                "type": "object", "required": ["code_path"], "properties": {
                    "code_path": {"type": "string"}, "timeout_seconds": {"type": "integer", "default": 50},
                    "delay_seconds": {"type": "integer", "default": 2},
                    "screenshot_save_path": {"type": "string"}}}}}},
            "responses": {"200": {"description": "GUI test result"}}}},
    },
}


class Handler(BaseHTTPRequestHandler):
    server_version = "PSJLocalTools/1.0"

    def _json(self, status: int, value: dict) -> None:
        data = json.dumps(value, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        if self.path == "/openapi.json":
            self._json(200, OPENAPI)
        elif self.path == "/health":
            self._json(200, {"status": "ready", "service": "PSJ local tools"})
        else:
            self._json(404, {"error": "Not found"})

    def do_POST(self):
        if not hmac.compare_digest(self.headers.get("Authorization", ""), f"Bearer {TOKEN}"):
            self._json(401, {"error": "Unauthorized"})
            return
        try:
            length = int(self.headers.get("Content-Length", "0"))
            if length < 1 or length > 1_000_000:
                self._json(400, {"error": "Invalid request size"})
                return
            payload = json.loads(self.rfile.read(length))
            route = urlparse(self.path).path
            if route == "/search_psj":
                query = str(payload.get("query", ""))
                top_k = max(1, min(int(payload.get("top_k", 3)), 20))
                mode = payload.get("mode", "auto")
                if mode not in {"auto", "filename", "semantic"}:
                    self._json(400, {"error": "mode must be auto, filename, or semantic"})
                    return
                if mode == "filename":
                    result = {"results": filename_match(query, top_k), "mode_used": "filename"}
                elif mode == "semantic":
                    result = {"results": semantic_search(query, top_k), "mode_used": "semantic"}
                else:
                    hits = filename_match(query, top_k)
                    result = ({"results": hits, "mode_used": "filename"} if hits else
                              {"results": semantic_search(query, top_k), "mode_used": "semantic"})
            elif route == "/run":
                path = Path(str(payload.get("code_path", "")))
                try:
                    code = path.read_text(encoding="utf-8")
                except (OSError, UnicodeDecodeError) as exc:
                    self._json(400, {"success": False, "error": f"Cannot read code_path: {exc}",
                                     "stdout": "", "stderr": ""})
                    return
                timeout = max(1, min(int(payload.get("timeout_seconds", 30)), 600))
                background = bool(payload.get("background", True))
                reuse = bool(payload.get("reuse", False))
                result = runReuse(code, timeout, background) if reuse else runOnce(code, timeout, background)
            elif route == "/test_gui":
                result = _gui_test(payload)
            else:
                self._json(404, {"error": "Not found"})
                return
            self._json(200, result)
        except Exception as exc:
            self._json(500, {"error": str(exc), "traceback": traceback.format_exc()})

    def log_message(self, fmt, *args):
        print("[PSJ-HTTP] " + fmt % args)


def main() -> None:
    print(f"PSJ local tools listening on http://{HOST}:{PORT}")
    print(f"OpenAPI: http://{HOST}:{PORT}/openapi.json")
    print("Bearer token (keep private; used for run/test_gui):")
    print(TOKEN)
    print("Use Ctrl+C to stop.")
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()


if __name__ == "__main__":
    main()
