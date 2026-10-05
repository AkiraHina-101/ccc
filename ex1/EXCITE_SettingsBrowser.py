# EXCITE Power Unit settings browser for AVL Workspace / Python 2.7.
# Run from the EXCITE GUI's Python Scripts menu. Read-only: no model values
# are changed and the model is never saved.

import csv
import os

import gtk
import WS
import aws_dialog


_window_instance = None


def _u(value):
    try:
        if isinstance(value, unicode):
            return value
        return unicode(value, 'utf-8', 'replace')
    except Exception:
        try:
            return unicode(str(value), 'utf-8', 'replace')
        except Exception:
            return u'<unreadable>'


class SettingsBrowser(aws_dialog.BaseUtility):
    COL_SCOPE = 0
    COL_OBJECT = 1
    COL_SETTING = 2
    COL_VALUE = 3
    COL_UNIT = 4
    COL_NOTE = 5

    def __init__(self, client):
        aws_dialog.BaseUtility.__init__(self, 'EXCITE Settings Browser', aws_dialog.b_Close)
        self.client = client
        self.model = client.GetModel()
        self.records = []

        self.set_default_size(1120, 680)
        self.set_border_width(8)

        root = gtk.VBox(False, 6)
        self.get_children()[0].get_children()[0].add(root)

        model_file = _u(client.GetModelFilename())
        self.model_label = gtk.Label('Open model: %s' % model_file)
        self.model_label.set_alignment(0.0, 0.5)
        root.pack_start(self.model_label, False, False, 0)

        toolbar = gtk.HBox(False, 6)
        root.pack_start(toolbar, False, False, 0)

        self.search = gtk.Entry()
        self.search.set_text('')
        self.search.set_activates_default(False)
        self.search.connect('changed', self._filter_changed)
        self.search.set_size_request(300, -1)
        toolbar.pack_start(self.search, True, True, 0)

        self.refresh_button = gtk.Button('Refresh from open model')
        self.refresh_button.connect('clicked', self._refresh_clicked)
        toolbar.pack_start(self.refresh_button, False, False, 0)

        self.export_button = gtk.Button('Export CSV')
        self.export_button.connect('clicked', self._export_clicked)
        toolbar.pack_start(self.export_button, False, False, 0)

        self.store = gtk.ListStore(str, str, str, str, str, str)
        self.filtered = self.store.filter_new()
        self.filtered.set_visible_func(self._visible_record)
        self.sorted_model = gtk.TreeModelSort(self.filtered)

        self.view = gtk.TreeView(self.sorted_model)
        self.view.set_rules_hint(True)
        self.view.get_selection().set_mode(gtk.SELECTION_SINGLE)
        headers = [
            ('Scope', self.COL_SCOPE, 125),
            ('Object / Case', self.COL_OBJECT, 210),
            ('Setting', self.COL_SETTING, 235),
            ('Value', self.COL_VALUE, 190),
            ('Unit', self.COL_UNIT, 130),
            ('API coverage', self.COL_NOTE, 230),
        ]
        for title, column_index, width in headers:
            renderer = gtk.CellRendererText()
            column = gtk.TreeViewColumn(title, renderer, text=column_index)
            column.set_resizable(True)
            column.set_min_width(75)
            column.set_sizing(gtk.TREE_VIEW_COLUMN_FIXED)
            column.set_fixed_width(width)
            column.set_sort_column_id(column_index)
            self.view.append_column(column)

        scroller = gtk.ScrolledWindow()
        scroller.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
        scroller.add(self.view)
        root.pack_start(scroller, True, True, 0)

        self.status = gtk.Label('')
        self.status.set_alignment(0.0, 0.5)
        root.pack_start(self.status, False, False, 0)

        self.refresh()
        self.show_all()

    def data_section_name(self):
        return None

    def _add(self, scope, obj, setting, value, unit='', note=''):
        row = (_u(scope), _u(obj), _u(setting), _u(value), _u(unit), _u(note))
        self.records.append(row)
        self.store.append(row)

    def _add_error(self, scope, obj, message):
        self._add(scope, obj, '<read error>', message, '', 'API returned an error')

    def _read_global_parameters(self):
        try:
            names = self.model.GetParameters()
        except Exception as exc:
            self._add_error('Global parameter', '', exc)
            return
        for name in names:
            try:
                value = self.model.GetParameter(name)
                try:
                    unit = self.model.GetParameterUnit(name)
                except Exception:
                    unit = ''
                self._add('Global parameter', 'Model', name, value, unit,
                          'Enumerated and readable via API')
            except Exception as exc:
                self._add_error('Global parameter', name, exc)

    def _read_cases(self):
        try:
            case_sets = self.model.GetCaseSets()
        except Exception as exc:
            self._add_error('Case set', '', exc)
            return
        for case_set in case_sets:
            self._add('Case set', case_set, '<case set>', '', '',
                      'Case membership can be queried via API')
            try:
                self.model.WithCaseSet(case_set)
                cases = self.model.GetCases()
            except Exception as exc:
                self._add_error('Case set', case_set, exc)
                continue
            for case in cases:
                context = '%s.%s' % (_u(case_set), _u(case))
                self._add('Case', context, '<case>', '', '',
                          'Override parameters listed below')
                try:
                    self.model.WithCase(case)
                    names = self.model.GetCaseParameters()
                except Exception as exc:
                    self._add_error('Case', context, exc)
                    continue
                if not names:
                    self._add('Case', context, '<no overrides>', '', '',
                              'Uses global values')
                for name in names:
                    try:
                        value = self.model.GetCaseParameter(name)
                        try:
                            unit = self.model.GetParameterUnit(name)
                        except Exception:
                            unit = ''
                        self._add('Case parameter', context, name, value, unit,
                                  'Enumerated and readable via API')
                    except Exception as exc:
                        self._add_error('Case parameter', context + ' / ' + _u(name), exc)

    def _read_elements(self):
        try:
            elements = self.model.GetElements()
        except Exception as exc:
            self._add_error('Element', '', exc)
            return
        for element in elements:
            name = _u(element.GetName())
            label = _u(element.GetLabel())
            obj = name if not label else '%s (%s)' % (name, label)
            try:
                ws_class = element.GetClass()
                class_name = _u(ws_class.GetClassName())
                instance_name = _u(ws_class.GetInstanceName())
                class_info = '%s / %s; code=%s' % (
                    class_name, instance_name, _u(element.GetCode()))
            except Exception:
                class_info = 'code=%s' % _u(element.GetCode())

            self._add('Element', obj, '<element type>', class_info, '',
                      'Element identified by API')
            try:
                names = element.GetParameters()
            except Exception as exc:
                self._add_error('Element parameter', obj, exc)
                names = []
            if not names:
                self._add('Element parameter', obj, '<none enumerated>', '', '',
                          'No element parameters exposed for this object')
            for parameter in names:
                try:
                    value = element.GetParameter(parameter)
                    try:
                        unit = element.GetParameterUnit(parameter)
                    except Exception:
                        unit = ''
                    self._add('Element parameter', obj, parameter, value, unit,
                              'Enumerated and readable via API')
                except Exception as exc:
                    self._add_error('Element parameter', obj + ' / ' + _u(parameter), exc)

            self._add('Deep object data', obj, '<WSClass fields>', class_info, '',
                      'Addressable by known field path; API cannot enumerate every field')

    def refresh(self):
        self.model = self.client.GetModel()
        self.records = []
        self.store.clear()
        if self.model is None:
            self.status.set_text('No model is currently loaded in this EXCITE client.')
            return
        try:
            model_file = _u(self.client.GetModelFilename())
            self.model_label.set_text('Open model: %s' % model_file)
        except Exception:
            pass

        self._read_global_parameters()
        self._read_cases()
        self._read_elements()
        self.filtered.refilter()
        self.status.set_text(
            '%d rows. Values are read from the open model; this window never edits or saves it.' %
            len(self.records))

    def _visible_record(self, model, iterator, data=None):
        query = self.search.get_text().strip().lower()
        if not query:
            return True
        row_text = ' '.join([model.get_value(iterator, i) for i in range(6)]).lower()
        return query in row_text

    def _filter_changed(self, widget):
        self.filtered.refilter()

    def _refresh_clicked(self, widget):
        try:
            self.refresh()
        except Exception as exc:
            aws_dialog.ErrorBox('Could not read the active EXCITE model:\n%s' % exc)

    def _export_clicked(self, widget):
        chooser = gtk.FileChooserDialog(
            'Export EXCITE settings', self, gtk.FILE_CHOOSER_ACTION_SAVE,
            (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,
             gtk.STOCK_SAVE, gtk.RESPONSE_OK))
        chooser.set_do_overwrite_confirmation(True)
        model_file = _u(self.client.GetModelFilename())
        base = os.path.splitext(os.path.basename(model_file))[0] or 'excite_model'
        chooser.set_current_name(base + '_settings.csv')
        response = chooser.run()
        filename = chooser.get_filename() if response == gtk.RESPONSE_OK else None
        chooser.destroy()
        if not filename:
            return

        try:
            output = open(filename, 'wb')
            try:
                writer = csv.writer(output)
                writer.writerow(['Scope', 'Object / Case', 'Setting', 'Value', 'Unit', 'API coverage'])
                for row in self.records:
                    writer.writerow([cell.encode('utf-8') for cell in row])
            finally:
                output.close()
            self.status.set_text('Exported %d rows to %s' % (len(self.records), filename))
        except Exception as exc:
            aws_dialog.ErrorBox('CSV export failed:\n%s' % exc)

def main():
    global _window_instance
    client = WS.GetActiveClient()
    if client is None:
        aws_dialog.ErrorBox('No active EXCITE client. Run this from the open EXCITE GUI.')
        return
    _window_instance = SettingsBrowser(client)


if __name__ == '__main__':
    main()
