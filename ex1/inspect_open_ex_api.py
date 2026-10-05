# Run this from the EXCITE Power Unit GUI's Python Scripts menu.
# Read-only inventory: this script does not set values or save the model.
import codecs
import os
import WS


def text(value):
    try:
        return unicode(value)
    except Exception:
        try:
            return unicode(repr(value), 'utf-8', 'replace')
        except Exception:
            return u'<unprintable>'


def write_line(report, value=u''):
    report.write(text(value) + u'\n')


client = WS.GetActiveClient()
if client is None:
    raise RuntimeError('No active Workspace client. Run this inside the open EXCITE GUI.')

model = client.GetModel()
if model is None:
    raise RuntimeError('The active EXCITE client has no loaded model.')

report_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           'simple_body_api_inventory.txt')
report = codecs.open(report_path, 'w', 'utf-8')
try:
    write_line(report, u'EXCITE Power Unit API inventory (read-only)')
    write_line(report, u'Model file: %s' % text(client.GetModelFilename()))
    write_line(report, u'Active case set: %s' % text(model.GetActiveCaseSet()))
    write_line(report, u'Active case: %s' % text(model.GetActiveCase()))

    write_line(report, u'\n=== GLOBAL PARAMETERS ===')
    try:
        for name in model.GetParameters():
            try:
                value = model.GetParameter(name)
                unit = model.GetParameterUnit(name)
                write_line(report, u'%s = %s [%s]' % (text(name), text(value), text(unit)))
            except Exception as exc:
                write_line(report, u'%s = <read error: %s>' % (text(name), text(exc)))
    except Exception as exc:
        write_line(report, u'<enumeration error: %s>' % text(exc))

    write_line(report, u'\n=== CASE SETS, CASES, CASE OVERRIDES ===')
    try:
        for case_set in model.GetCaseSets():
            write_line(report, u'CASE SET: %s' % text(case_set))
            model.WithCaseSet(case_set)  # selects API context only; does not activate or save
            for case in model.GetCases():
                write_line(report, u'  CASE: %s' % text(case))
                model.WithCase(case)  # selects API context only; does not activate or save
                try:
                    for name in model.GetCaseParameters():
                        try:
                            value = model.GetCaseParameter(name)
                            write_line(report, u'    %s = %s' % (text(name), text(value)))
                        except Exception as exc:
                            write_line(report, u'    %s = <read error: %s>' %
                                       (text(name), text(exc)))
                except Exception as exc:
                    write_line(report, u'    <override enumeration error: %s>' % text(exc))
    except Exception as exc:
        write_line(report, u'<case enumeration error: %s>' % text(exc))

    write_line(report, u'\n=== MODEL ELEMENTS AND ELEMENT PARAMETERS ===')
    try:
        for element in model.GetElements():
            name = text(element.GetName())
            write_line(report, u'ELEMENT: %s | code=%s | label=%s' %
                       (name, text(element.GetCode()), text(element.GetLabel())))
            try:
                for parameter in element.GetParameters():
                    try:
                        value = element.GetParameter(parameter)
                        unit = element.GetParameterUnit(parameter)
                        write_line(report, u'  %s = %s [%s]' %
                                   (text(parameter), text(value), text(unit)))
                    except Exception as exc:
                        write_line(report, u'  %s = <read error: %s>' %
                                   (text(parameter), text(exc)))
            except Exception as exc:
                write_line(report, u'  <parameter enumeration error: %s>' % text(exc))
            try:
                ws_class = element.GetClass()
                write_line(report, u'  WSClass: %s / %s' %
                           (text(ws_class.GetClassName()), text(ws_class.GetInstanceName())))
                write_line(report, u'  Note: WSClass scalar fields are addressable by name, but this API has no generic child-field enumerator.')
            except Exception as exc:
                write_line(report, u'  <WSClass info error: %s>' % text(exc))
    except Exception as exc:
        write_line(report, u'<element enumeration error: %s>' % text(exc))
finally:
    report.close()

print('Read-only API inventory written to: %s' % report_path)
