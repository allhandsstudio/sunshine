import toml

vars = toml.load('/cesm_vars.toml')

main_vars = vars.get('main', {})
compset = main_vars['COMPSET']
grid = main_vars['GRID']

newcase_text = """
#!/bin/bash

wget http://169.254.169.254/latest/meta-data/instance-type -q
instance_type=`cat instance-type`
rm instance_type

mkdir -p /var/cesm
cd /var/cesm
/cesm-1_2_2/scripts/create_newcase \
  -case case1 \
  -compset {} \
  -res {} \
  -mach sunshine \
  -mpilib openmpi \
  -compiler gnu \
  -pes_file /sunshine_"$instance_type"_pes.xml
""".format(compset, grid)

with open('/newcase.sh', 'w') as fd:
    fd.write(newcase_text)
