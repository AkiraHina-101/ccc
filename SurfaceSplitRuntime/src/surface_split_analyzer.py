"""Background analyzer process launcher without Jupiter/UI dependencies."""
import os
import subprocess


BACKGROUND_FLAGS = 0x00000008 | 0x08000000  # DETACHED_PROCESS | NO_WINDOW


def progress_from_log(log_path):
    """Return approximate overall percent and the current analyzer phase."""
    try:
        with open(log_path, "r", encoding="utf-8", errors="replace") as stream:
            lines = [line.strip() for line in stream if line.strip()]
    except Exception:
        return 0, "Starting analyzer"
    if not lines:
        return 0, "Starting analyzer"
    label = "Reading BDF"
    local = 0.0
    second_run = any("face-level" in line for line in lines)
    phases = (("[1/5]", 2, "Reading BDF"),
              ("[2/5]", 15, "Building voxel grid"),
              ("[3/5]", 22, "Voxelizing surfaces"),
              ("[3b]", 32, "Closing holes"),
              ("[4/5]", 42, "Flood filling outside air"),
              ("[4c]", 52, "Computing air reach"),
              ("[4b]", 58, "Computing proximity"),
              ("[5/6]", 62, "Computing visibility"),
              ("[6/6]", 95, "Writing JSON"),
              ("Tong thoi gian", 100, "Run complete"))
    start = max((i for i, line in enumerate(lines)
                 if "[FAST] ====" in line), default=0)
    for line in lines[start:]:
        for marker, percent, phase in phases:
            if marker in line:
                local, label = percent, phase
        if line.startswith("view "):
            try:
                current, total = line.split()[1].split("/")
                local = 62 + 30 * int(current) / max(int(total), 1)
                label = "Visibility view %s/%s" % (current, total)
            except Exception:
                pass
    if any("[FAST] ALL DONE." in line for line in lines):
        return 100, "Analyzer complete"
    overall = (45 + 0.50 * local) if second_run else (0.45 * local)
    return min(99, int(round(overall))), label


def start(python_exe, analyzer_script, bdf, outdir, cwd):
    """Start the analyzer and return ``(process, log_handle, log_path)``."""
    log_path = os.path.join(outdir, "find_outer_fast.log")
    log_handle = open(log_path, "w", encoding="utf-8", errors="replace")
    try:
        process = subprocess.Popen(
            [python_exe, "-u", analyzer_script, "--all", bdf,
             "--engine", "parallel", "--outdir", outdir],
            stdout=log_handle, stderr=subprocess.STDOUT, cwd=cwd,
            creationflags=BACKGROUND_FLAGS)
    except Exception:
        log_handle.close()
        raise
    return process, log_handle, log_path
