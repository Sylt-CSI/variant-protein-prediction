
bg_color white
set label_size, 0
set_color dyel=[0.7,0.7,0]
set dash_color, cyan
set dash_radius, 0.3
set dash_length, 1
set sphere_scale, 0.2

load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr-3_back_rub_0970_relax_0056.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056.pdb
load /Users/gcc/Desktop/GCC/pipeline/report_models/backrub_relax/1tnr3_TNFA_back_rub_0696_relax_0025.pdb

align 1tnr3_TNFA_back_rub_0696_relax_0025 and name C+O+N+CA, 1tnr-3_back_rub_0970_relax_0056 and name C+O+N+CA, cycles = 10
align 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064 and name C+O+N+CA, 1tnr-3_back_rub_0970_relax_0056 and name C+O+N+CA, cycles=10
align 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016 and name C+O+N+CA, 1tnr-3_back_rub_0970_relax_0056 and name C+O+N+CA, cycles=10
align 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007 and name C+O+N+CA, 1tnr-3_back_rub_0970_relax_0056 and name C+O+N+CA, cycles=10
align 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051 and name C+O+N+CA, 1tnr3_TNFA_back_rub_0696_relax_0025 and name C+O+N+CA, cycles=10
align 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025 and name C+O+N+CA, 1tnr3_TNFA_back_rub_0696_relax_0025 and name C+O+N+CA, cycles=10
align 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056 and name C+O+N+CA, 1tnr3_TNFA_back_rub_0696_relax_0025 and name C+O+N+CA, cycles=10

set_view (    -0.508900225,   -0.512527347,   -0.691620231,     0.802209020,   -0.573755205,   -0.165096387,    -0.312200397,   -0.638840020,    0.703146875,     0.000020251,    0.000278644, -135.060638428,    36.708667755,   39.400997162,   42.949989319,  -2561.286132812, 2831.585693359,  -20.000000000 )

colour black, name C+O+N+CA and chain R+T+S
colour gray45, name C+O+N+CA and chain A+B+C
set stick_color, dyel, (cys/ca+cb+sg)
# set stick_color, gray23, resn ASP+Glu+Lys+arg

hide cartoon, *
show cartoon, 1tnr3_TNFA_back_rub_0696_relax_0025
show sticks, (cys/ca+cb+sg) and 1tnr3_TNFA_back_rub_0696_relax_0025
color red, resi 109+112+33 and chain R+T+S and 1tnr3_TNFA_back_rub_0696_relax_0025
# or (resn ASP+Glu+Lys+arg))
# select TNFA_wild_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr3_TNFA_back_rub_0696_relax_0025
# select TNFA_wild_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr3_TNFA_back_rub_0696_relax_0025
# show spheres, (TNFA_wild_negative or TNFA_wild_positive) and 1tnr3_TNFA_back_rub_0696_relax_0025
# distance TNFA_wild_saltbridgeA1, (TNFA_wild_negative and chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeA2, (TNFA_wild_positive and chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeB1, (TNFA_wild_negative and chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeB2, (TNFA_wild_positive and chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeC1, (TNFA_wild_negative and chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeC2, (TNFA_wild_positive and chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeR1, (TNFA_wild_negative and chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeR2, (TNFA_wild_positive and chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeT1, (TNFA_wild_negative and chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeT2, (TNFA_wild_positive and chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeS1, (TNFA_wild_negative and chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
# distance TNFA_wild_saltbridgeS2, (TNFA_wild_positive and chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFA_wild.png

