def ver_opts(versions):
    result = []
    for v in versions:
        try:
            parts = v.strip().split(None, 1)
            n = int(parts[0])
            label = parts[1].strip() if len(parts) > 1 else str(n)
            result.append((label, n))
        except Exception:
            pass
    return result


def que_opts(queues):
    result = []
    for q in queues:
        try:
            parts = q.strip().split(None, 1)
            n = int(parts[0])
            label = parts[1].strip() if len(parts) > 1 else str(n)
            label = label.replace('â€“', '-').replace('–', '-')
            result.append((label, n))
        except Exception:
            pass
    return result


def choice_list(values):
    out = []
    for item in values:
        if isinstance(item, dict):
            display = str(item.get('display', item.get('value', ''))).strip()
            value = str(item.get('value', display)).strip()
        else:
            display = value = str(item).strip()
        if display or value:
            out.append({'display': display or value, 'value': value or display})
    return out


def numbered_choices(values):
    choices = []
    for raw in values:
        try:
            parts = str(raw).strip().split(None, 1)
            value = parts[0]
            int(value)
            display = parts[1].strip() if len(parts) > 1 else value
            display = display.replace('â€“', '-').replace('–', '-')
            choices.append({'display': display, 'value': value})
        except Exception:
            pass
    return choices
