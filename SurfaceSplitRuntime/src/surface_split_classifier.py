"""Pure evidence preparation for the Surface Split classifier."""


def build_face_evidence(geometry, evidence, shared_nodes):
    """Calculate per-face ratios without any Jupiter or dialog access."""
    vis, contact, reach, reach10, reach20, vis30 = evidence
    ratios = ({}, {}, {}, {}, {}, {})
    fvis, fct, frc, frc10, frc20, fvis30 = ratios
    fctin = {}
    fshn = {}
    for fid, eids in geometry["eids"].items():
        count = len(eids)
        counts = [0, 0, 0, 0, 0, 0]
        sources = evidence
        for eid in eids:
            for index, source in enumerate(sources):
                if eid in source:
                    counts[index] += 1
        for target, found in zip(ratios, counts):
            target[fid] = found / count
        interior = geometry["interior"][fid]
        n_interior = len(interior)
        fctin[fid] = (
            n_interior,
            sum(eid in contact for eid in interior) / n_interior
            if n_interior else 0.0)
        nodes = geometry["fnodes"][fid]
        fshn[fid] = (len(nodes & shared_nodes) / len(nodes) if nodes else 0.0)
    return {
        "vis": fvis, "ct": fct, "rc": frc, "rc10": frc10,
        "rc20": frc20, "vis30": fvis30, "ctin": fctin, "shn": fshn,
    }
