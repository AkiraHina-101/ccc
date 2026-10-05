import json
import os
import sys
import WS
sys.path.insert(0, os.path.join(os.path.dirname(WS.__file__), 'clients', 'excite'))
import excWS


def main():
    path = os.path.abspath(sys.argv[1])
    report = {'model': path, 'checks': {}}

    def check(name, callback):
        try:
            report['checks'][name] = {'status': 'ok', 'value': callback()}
        except Exception as error:
            report['checks'][name] = {'status': 'error', 'error': str(error)}

    WS.SetRunMode('hidden')
    client = excWS.CreateExcitePUClient('settings_readonly_probe')
    if client is None:
        raise RuntimeError('Cannot create EXCITE client')
    try:
        client.LoadModel(path)
        model = client.GetModel()
        if model is None:
            raise RuntimeError('No model loaded')
        check('global_parameters', model.GetParameters)
        check('case_sets', model.GetCaseSets)
        check('active_case_set', model.GetActiveCaseSet)
        check('active_case', model.GetActiveCase)
        check('unit_system', model.get_unit_system_used)
        check('simulation_storage_deg', lambda: model.get_simulation_control().get_data_storage_interval('deg'))
        check('simulation_storage_s', lambda: model.get_simulation_control().get_data_storage_interval('s'))
        check('results_control', lambda: model.get_results_control().get_control_parameters())
        check('crank_train_orientation', model.get_crank_train_orientation)
        check('elements', lambda: [{'name': e.GetName(), 'label': e.GetLabel(), 'code': e.GetCode(),
                                    'uuid': e.GetUuid(), 'parameters': e.GetParameters(), 'act': e.IsACT()}
                                   for e in model.GetElements()])
        check('bodies', lambda: [{'label': b.GetLabel(), 'mesh': b.get_condensed_mesh_file(),
                                  'joint_nodes': b.get_all_nodes_used_by_connected_joints(),
                                  'loaded_nodes': b.get_loaded_nodes()} for b in model.get_bodies()])
        check('joints', lambda: [{'label': j.GetLabel(), 'code': j.GetCode()} for j in model.get_joints()])
        check('hd_joints', lambda: [j.GetLabel() for j in model.get_hd_joints()])
        check('line_count', lambda: len(model.GetLines()))
        check('crank_train_speed_rpm', lambda: model.GetClass('CTrain', 'ctrain').GetDblValueU('general.speed', 'rpm'))
        check('solver_timestep_s', lambda: model.GetClass('Solctr', 'solctr').GetDblValueU('param.timestep.dt', 's'))
        check('solver_timestep_min_s', lambda: model.GetClass('Solctr', 'solctr').GetDblValueU('param.timestep.min', 's'))
        check('solver_timestep_max_s', lambda: model.GetClass('Solctr', 'solctr').GetDblValueU('param.timestep.max', 's'))
        check('crank_train_bore_m', lambda: model.GetClass('CTrain', 'ctrain').GetDblValueU('general.bore', 'm'))
        check('crank_train_stroke_m', lambda: model.GetClass('CTrain', 'ctrain').GetDblValueU('general.stroke', 'm'))
        check('crank_train_lrod_m', lambda: model.GetClass('CTrain', 'ctrain').GetDblValueU('general.lrod', 'm'))
        check('load_pressure_peak_search_deg', lambda: model.GetClass('Load', 'load').GetDblValueU('cylpressdata.peakSearchWidth', 'deg'))
        check('speed_parameter_binding', lambda: model.GetClass('CTrain', 'ctrain').GetAssignedParameter('general.speed'))

        def load_case_count():
            items = model.GetClass('Load', 'load').GetWSClassList('loadcases.loadcase')
            try:
                return items.GetSize()
            finally:
                items.Release()
        check('load_case_count', load_case_count)

        def body_inertia_dimensions():
            body = model.get_bodies()[0]
            matrix = body.GetClass().GetWSMatrix('bdefine.it', 0)
            try:
                return {'rows': matrix.GetNumRows(), 'columns': matrix.GetNumCols()}
            finally:
                matrix.ReleaseHandle()
        check('body_inertia_matrix_dimensions', body_inertia_dimensions)
        check('parameter_groups', lambda: {cs: model.GetParameterGroups(cs) for cs in model.GetCaseSets()})
        check('lines', lambda: [{'code': line.GetCode(), 'start': line.GetStartElement().GetLabel(),
                                'end': line.GetEndElement().GetLabel(), 'parameters': line.GetParameters()}
                               for line in model.GetLines()])
        print('PROBE_JSON_BEGIN')
        print(json.dumps(report, indent=2, ensure_ascii=True, default=lambda obj: list(obj) if isinstance(obj, set) else str(obj)))
        print('PROBE_JSON_END')
    finally:
        WS.DestroyClient(client)


if __name__ == '__main__':
    main()
