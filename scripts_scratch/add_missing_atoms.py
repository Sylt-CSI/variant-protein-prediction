#!/usr/bin/env python

import modeller.scripts
import modeller.libraries
environment = modeller.environ()
environment.libs.topology.read("/Library/modeller-9.21/modlib/top_heav.lib")
environment.libs.parameters.read("/Library/modeller-9.21/modlib/par.lib")
m = modeller.scripts.complete_pdb(environment,"data_scratch/2C35.pdb")
m.write("data_scratch/2C35_fixed_missing.pdb")
