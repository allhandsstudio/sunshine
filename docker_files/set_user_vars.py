import toml
import subprocess

vars = toml.load('/cesm_vars.toml')

def process(filename, vars):
    for k, v in vars.items():
        subprocess.run("./xmlchange -file {} -id {} -val {}".format(filename, k, v))

for k, v in vars.items():
    if k == 'main':
        continue
    else:
        process('env_{}.xml'.format(k), v)
