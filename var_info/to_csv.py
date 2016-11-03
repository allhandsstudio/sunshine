import json

models = ['cam', 'clm2', 'rtm', 'cice', 'pop']

with open('model_vars.csv', 'w') as out:
    for model in models:
        with open(model+'_vars.json') as fd:
            obj = json.loads(fd.read())
            for var in obj.values():
                shape = var['shape']
                type = ''
                if len(shape) == 0:
                    pass
                elif shape[0] == 1 and len(shape) == 1:
                    type='scalar'
                elif len(shape) == 1:
                    type='1D'
                elif len(shape) == 2:
                    type='2D const'
                elif shape[0] == 1 and len(shape) == 3:
                    type='3D - txy'
                elif len(shape) == 3:
                    type='3D const'
                elif shape[0] == 1 and len(shape) == 4:
                    type='4D - tzxy'


                out.write('{},{},\"{}\",{},{},\"{}\"\n'.format(model, var['name'], var['long_name'], var['units'], type, str(var['shape'])))
