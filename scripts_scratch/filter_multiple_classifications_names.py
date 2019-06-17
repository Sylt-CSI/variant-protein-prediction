from __future__ import print_function
import sys


dikkie = {}
all_thinks = set()
derp = 0

with open(sys.argv[1], "r") as fila:
    for line in fila:
        broken = line.strip("\n").split(" ", 1)
        all_thinks.add(broken[1])
        if broken[0] in dikkie:
            dikkie[broken[0]].append(broken[1])
        else:
            dikkie[broken[0]] = [broken[1]]


def _crap_max(listie):
    ka = {'PATHOGENIC': 5.0,
          'Likely pathogenic': 4.0,
          'Pathogenic': 4.9,
          'NA': 0.1,
          'Likely benign': 4.0,
          'BENIGN': 5.0,
          'Not classified': 0.0,
          'Uncertain significance (VOUS)': 2.0,
          'POPULATION': 3.0}

    relevant = "NA"
    highest = 0.0
    for index, title in enumerate(listie):
        if ka[title] > highest:
            relevant = listie[index]
        else:
            pass
    return relevant

def _sorta_bi_number(itema):
    return int(itema[3:-3])


order = sorted(dikkie.keys(), key=_sorta_bi_number)


with open(sys.argv[2],"w") as oufila:
    for key in order:
        print(key, _crap_max(dikkie[key]),file=oufila)
