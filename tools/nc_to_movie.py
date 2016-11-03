from netCDF4 import Dataset
import json

def extract_info(ds):
    info = {}
    for k, v in ds.variables.items():
        info[k] = {
            'name': v.name,
            'shape': v.shape,
            'datatype': str(v.datatype),
            'mask': v.mask,
            'size': int(v.size)
        }
        try:
            info[k]['long_name'] = v.long_name
        except AttributeError:
            info[k]['long_name'] = 'none'
        try:
            info[k]['units'] = v.units
        except AttributeError:
            info[k]['units'] = 'none'
    return info

def main(filename):
    ds = Dataset(filename, 'r')
    ds_info = extract_info(ds)
    with open(filename+'.vars.json', 'w') as fd:
        fd.write(json.dumps(ds_info, indent=2))


if __name__ == "__main__":
    main('/Users/beau/Downloads/case1.rtm.h0.2000-01.nc')
