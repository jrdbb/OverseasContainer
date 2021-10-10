#!/usr/bin/python
from os import listdir
from os.path import isfile, join

import yaml

with open(".github/workflows/package.yml", "r+") as f:
    contexts = [f for f in listdir(".") if isfile(join(f, "version.txt"))]
    y = yaml.safe_load(f)
    y['jobs']['release']['strategy']['matrix']['context'] = sorted(contexts)
    f.seek(0)
    f.truncate()
    f.write(yaml.dump(y, default_flow_style=False, sort_keys=False))
