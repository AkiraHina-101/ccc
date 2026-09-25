"""Snapshot hide/show BODY hien tai va sinh code tai lap trong Jupiter.

Provider v1 chi xu ly logical visibility cua BODY. Khong suy dien occlusion,
clipping, section, viewport hay suppression.
"""
import ast
import sys

from insert_selection import copy_to_clipboard


HIDDEN_BODY_QUERY = (
    "[(item.id, item.key) for item in "
    "JPT.GetAllByTypeID(JPT.DItemType.BODY) if item.isHidden]"
)


def parse_hidden_bodies(raw):
    """Parse strict list[(body_id, key)]; tu choi response stale/hong."""
    try:
        value = ast.literal_eval(raw)
    except (SyntaxError, ValueError) as exc:
        raise ValueError("ket qua visibility khong hop le: {!r}".format(raw)) from exc
    if not isinstance(value, list):
        raise ValueError("ket qua visibility khong phai list: {!r}".format(raw))

    bodies = []
    for item in value:
        if (
            not isinstance(item, tuple)
            or len(item) != 2
            or any(isinstance(part, bool) or not isinstance(part, int) for part in item)
        ):
            raise ValueError("BODY visibility sai schema: {!r}".format(item))
        bodies.append(item)

    body_ids = [body_id for body_id, _key in bodies]
    if len(body_ids) != len(set(body_ids)):
        raise ValueError("BODY id bi trung; khong the replay an toan: {!r}".format(body_ids))
    return sorted(bodies)


def make_visibility_snippet(hidden_bodies):
    """Show tat ca lam baseline, sau do hide tung BODY trong snapshot."""
    lines = ["JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)"]
    for body_id, key in hidden_bodies:
        lines.append(
            "JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_BODY, {}, "
            "JPT.BoolType.FALSE_VAL)  # key={}".format(body_id, key)
        )
    return "\n".join(lines)


def read_hidden_bodies(run_line):
    return parse_hidden_bodies(run_line(HIDDEN_BODY_QUERY))


def main(stdout_only=False):
    from jupiterutils import JPT_RUN_LINE

    if not stdout_only:
        print("[INSERT-VISIBILITY] Dang doc BODY visibility tu Jupiter...")
    try:
        hidden_bodies = read_hidden_bodies(JPT_RUN_LINE)
        snippet = make_visibility_snippet(hidden_bodies)
        if not stdout_only:
            copy_to_clipboard(snippet)
    except Exception as exc:
        print(
            "[INSERT-VISIBILITY] LOI:",
            exc,
            file=sys.stderr if stdout_only else sys.stdout,
        )
        return 1

    if stdout_only:
        print(snippet)
        return 0

    print(
        "[INSERT-VISIBILITY] Snapshot co {} BODY dang an.".format(
            len(hidden_bodies)
        )
    )
    print("[INSERT-VISIBILITY] Da chep vao clipboard:")
    print(snippet)
    return 0


def self_test():
    assert parse_hidden_bodies("[(608, 608), (12, 99)]") == [(12, 99), (608, 608)]
    assert parse_hidden_bodies("[]") == []
    for invalid in ("None", "DBody()", "[(1, True)]", "[(1, 2), (1, 3)]"):
        try:
            parse_hidden_bodies(invalid)
        except ValueError:
            pass
        else:
            raise AssertionError("phai tu choi {!r}".format(invalid))

    assert make_visibility_snippet([]) == (
        "JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)"
    )
    assert make_visibility_snippet([(608, 700)]) == (
        "JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)\n"
        "JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_BODY, 608, "
        "JPT.BoolType.FALSE_VAL)  # key=700"
    )
    print("[STATIC-TEST] insert_visibility: PASS")


if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "--self-test":
        self_test()
    elif len(sys.argv) == 2 and sys.argv[1] == "--stdout":
        sys.exit(main(stdout_only=True))
    elif len(sys.argv) == 1:
        sys.exit(main())
    else:
        sys.exit("Cach dung: python insert_visibility.py [--stdout | --self-test]")
