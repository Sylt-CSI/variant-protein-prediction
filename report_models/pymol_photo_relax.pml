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

set_view (\
    -0.749248981,   -0.474489182,    0.462037027,\
    -0.348123431,   -0.311318189,   -0.884244502,\
     0.563407719,   -0.823366046,    0.068070933,\
     0.000000000,   -0.000000000, -218.041809082,\
    37.618331909,   37.654823303,   37.654891968,\
  -10354.129882812, 10790.210937500,  -20.000000000 )

colour black, name C+O+N+CA and chain R+T+S
colour gray45, name C+O+N+CA and chain A+B+C
set stick_color, dyel, (cys/ca+cb+sg)
set stick_color, gray23, resn ASP+Glu+Lys+arg

hide cartoon, *



show cartoon, 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
select TNFB_94_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
select TNFB_94_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
show spheres, (TNFB_94_negative or TNFB_94_positive) and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
distance TNFB_94_saltbridgeA1, (TNFB_94_negative and chain A and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_positive and not chain A and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeA2, (TNFB_94_positive and chain A and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_negative and not chain A and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeB1, (TNFB_94_negative and chain B and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_positive and not chain B and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeB2, (TNFB_94_positive and chain B and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_negative and not chain B and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeC1, (TNFB_94_negative and chain C and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_positive and not chain C and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeC2, (TNFB_94_positive and chain C and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_negative and not chain C and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeR1, (TNFB_94_negative and chain R and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_positive and not chain R and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeR2, (TNFB_94_positive and chain R and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_negative and not chain R and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeT1, (TNFB_94_negative and chain T and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_positive and not chain T and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeT2, (TNFB_94_positive and chain T and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_negative and not chain T and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeS1, (TNFB_94_negative and chain S and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_positive and not chain S and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0
distance TNFB_94_saltbridgeS2, (TNFB_94_positive and chain S and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), (TNFB_94_negative and not chain S and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFB_94.png, 1920, 1080
hide spheres, (TNFB_94_negative or TNFB_94_positive) and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
hide cartoon, 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_254_94_ALA_94_ALA_94_ALA_back_rub_0571_relax_0064
delete TNFB_94_saltbridge* or TNFB_94_*tive


show cartoon, 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
select TNFB_97_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
select TNFB_97_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
show spheres, (TNFB_97_negative or TNFB_97_positive) and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
distance TNFB_97_saltbridgeA1, (TNFB_97_negative and chain A and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_positive and not chain A and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeA2, (TNFB_97_positive and chain A and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_negative and not chain A and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeB1, (TNFB_97_negative and chain B and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_positive and not chain B and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeB2, (TNFB_97_positive and chain B and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_negative and not chain B and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeC1, (TNFB_97_negative and chain C and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_positive and not chain C and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeC2, (TNFB_97_positive and chain C and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_negative and not chain C and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeR1, (TNFB_97_negative and chain R and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_positive and not chain R and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeR2, (TNFB_97_positive and chain R and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_negative and not chain R and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeT1, (TNFB_97_negative and chain T and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_positive and not chain T and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeT2, (TNFB_97_positive and chain T and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_negative and not chain T and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeS1, (TNFB_97_negative and chain S and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_positive and not chain S and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0
distance TNFB_97_saltbridgeS2, (TNFB_97_positive and chain S and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), (TNFB_97_negative and not chain S and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFB_97.png, 1920, 1080
hide spheres, (TNFB_97_negative or TNFB_97_positive) and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
hide cartoon, 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_259_97_ILE_97_ILE_97_ILE_back_rub_0041_relax_0016
delete TNFB_97_saltbridge* or TNFB_97_*tive


show cartoon, 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
select TNFB_18_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
select TNFB_18_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
show spheres, (TNFB_18_negative or TNFB_18_positive) and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
distance TNFB_18_saltbridgeA1, (TNFB_18_negative and chain A and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_positive and not chain A and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeA2, (TNFB_18_positive and chain A and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_negative and not chain A and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeB1, (TNFB_18_negative and chain B and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_positive and not chain B and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeB2, (TNFB_18_positive and chain B and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_negative and not chain B and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeC1, (TNFB_18_negative and chain C and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_positive and not chain C and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeC2, (TNFB_18_positive and chain C and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_negative and not chain C and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeR1, (TNFB_18_negative and chain R and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_positive and not chain R and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeR2, (TNFB_18_positive and chain R and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_negative and not chain R and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeT1, (TNFB_18_negative and chain T and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_positive and not chain T and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeT2, (TNFB_18_positive and chain T and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_negative and not chain T and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeS1, (TNFB_18_negative and chain S and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_positive and not chain S and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0
distance TNFB_18_saltbridgeS2, (TNFB_18_positive and chain S and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), (TNFB_18_negative and not chain S and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFB_18.png, 1920, 1080
hide spheres, (TNFB_18_negative or TNFB_18_positive) and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
hide cartoon, 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_67_18_GLY_18_GLY_18_GLY_back_rub_0103_relax_0007
delete TNFB_18_saltbridge* or TNFB_18_*tive


show cartoon, 1tnr-3_back_rub_0970_relax_0056
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_back_rub_0970_relax_0056
select TNFB_wild_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr-3_back_rub_0970_relax_0056
select TNFB_wild_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr-3_back_rub_0970_relax_0056
show spheres, (TNFB_wild_negative or TNFB_wild_positive) and 1tnr-3_back_rub_0970_relax_0056
distance TNFB_wild_saltbridgeA1, (TNFB_wild_negative and chain A and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_positive and not chain A and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeA2, (TNFB_wild_positive and chain A and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_negative and not chain A and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeB1, (TNFB_wild_negative and chain B and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_positive and not chain B and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeB2, (TNFB_wild_positive and chain B and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_negative and not chain B and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeC1, (TNFB_wild_negative and chain C and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_positive and not chain C and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeC2, (TNFB_wild_positive and chain C and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_negative and not chain C and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeR1, (TNFB_wild_negative and chain R and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_positive and not chain R and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeR2, (TNFB_wild_positive and chain R and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_negative and not chain R and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeT1, (TNFB_wild_negative and chain T and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_positive and not chain T and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeT2, (TNFB_wild_positive and chain T and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_negative and not chain T and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeS1, (TNFB_wild_negative and chain S and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_positive and not chain S and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0
distance TNFB_wild_saltbridgeS2, (TNFB_wild_positive and chain S and 1tnr-3_back_rub_0970_relax_0056), (TNFB_wild_negative and not chain S and 1tnr-3_back_rub_0970_relax_0056), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFB_wild.png, 1920, 1080
hide spheres, (TNFB_wild_negative or TNFB_wild_positive) and 1tnr-3_back_rub_0970_relax_0056
hide cartoon, 1tnr-3_back_rub_0970_relax_0056
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr-3_back_rub_0970_relax_0056
delete TNFB_wild_saltbridge* or TNFB_wild_*tive


show cartoon, 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
select TNFA_94_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
select TNFA_94_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
show spheres, (TNFA_94_negative or TNFA_94_positive) and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
distance TNFA_94_saltbridgeA1, (TNFA_94_negative and chain A and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_positive and not chain A and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeA2, (TNFA_94_positive and chain A and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_negative and not chain A and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeB1, (TNFA_94_negative and chain B and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_positive and not chain B and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeB2, (TNFA_94_positive and chain B and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_negative and not chain B and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeC1, (TNFA_94_negative and chain C and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_positive and not chain C and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeC2, (TNFA_94_positive and chain C and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_negative and not chain C and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeR1, (TNFA_94_negative and chain R and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_positive and not chain R and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeR2, (TNFA_94_positive and chain R and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_negative and not chain R and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeT1, (TNFA_94_negative and chain T and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_positive and not chain T and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeT2, (TNFA_94_positive and chain T and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_negative and not chain T and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeS1, (TNFA_94_negative and chain S and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_positive and not chain S and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0
distance TNFA_94_saltbridgeS2, (TNFA_94_positive and chain S and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), (TNFA_94_negative and not chain S and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFA_94.png, 1920, 1080
hide spheres, (TNFA_94_negative or TNFA_94_positive) and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
hide cartoon, 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_254_94_ALA_94_ALA_94_ALA_back_rub_0702_relax_0051
delete TNFA_94_saltbridge* or TNFA_94_*tive


show cartoon, 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
select TNFA_97_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
select TNFA_97_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
show spheres, (TNFA_97_negative or TNFA_97_positive) and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
distance TNFA_97_saltbridgeA1, (TNFA_97_negative and chain A and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_positive and not chain A and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeA2, (TNFA_97_positive and chain A and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_negative and not chain A and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeB1, (TNFA_97_negative and chain B and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_positive and not chain B and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeB2, (TNFA_97_positive and chain B and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_negative and not chain B and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeC1, (TNFA_97_negative and chain C and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_positive and not chain C and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeC2, (TNFA_97_positive and chain C and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_negative and not chain C and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeR1, (TNFA_97_negative and chain R and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_positive and not chain R and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeR2, (TNFA_97_positive and chain R and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_negative and not chain R and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeT1, (TNFA_97_negative and chain T and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_positive and not chain T and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeT2, (TNFA_97_positive and chain T and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_negative and not chain T and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeS1, (TNFA_97_negative and chain S and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_positive and not chain S and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0
distance TNFA_97_saltbridgeS2, (TNFA_97_positive and chain S and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), (TNFA_97_negative and not chain S and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFA_97.png, 1920, 1080
hide spheres, (TNFA_97_negative or TNFA_97_positive) and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
hide cartoon, 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_259_97_ILE_97_ILE_97_ILE_back_rub_0268_relax_0025
delete TNFA_97_saltbridge* or TNFA_97_*tive


show cartoon, 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
select TNFA_18_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
select TNFA_18_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
show spheres, (TNFA_18_negative or TNFA_18_positive) and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
distance TNFA_18_saltbridgeA1, (TNFA_18_negative and chain A and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_positive and not chain A and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeA2, (TNFA_18_positive and chain A and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_negative and not chain A and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeB1, (TNFA_18_negative and chain B and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_positive and not chain B and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeB2, (TNFA_18_positive and chain B and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_negative and not chain B and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeC1, (TNFA_18_negative and chain C and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_positive and not chain C and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeC2, (TNFA_18_positive and chain C and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_negative and not chain C and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeR1, (TNFA_18_negative and chain R and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_positive and not chain R and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeR2, (TNFA_18_positive and chain R and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_negative and not chain R and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeT1, (TNFA_18_negative and chain T and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_positive and not chain T and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeT2, (TNFA_18_positive and chain T and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_negative and not chain T and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeS1, (TNFA_18_negative and chain S and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_positive and not chain S and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0
distance TNFA_18_saltbridgeS2, (TNFA_18_positive and chain S and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), (TNFA_18_negative and not chain S and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFA_18.png, 1920, 1080
hide spheres, (TNFA_18_negative or TNFA_18_positive) and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
hide cartoon, 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0056
delete TNFA_18_saltbridge* or TNFA_18_*tive


show cartoon, 1tnr3_TNFA_back_rub_0696_relax_0025
show sticks, ((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_back_rub_0696_relax_0025
select TNFA_wild_negative, (resn ASP+Glu and name OD*+OE*) and 1tnr3_TNFA_back_rub_0696_relax_0025
select TNFA_wild_positive, (resn Lys and name NZ) or (resn arg and name NE+NH*) and 1tnr3_TNFA_back_rub_0696_relax_0025
show spheres, (TNFA_wild_negative or TNFA_wild_positive) and 1tnr3_TNFA_back_rub_0696_relax_0025
distance TNFA_wild_saltbridgeA1, (TNFA_wild_negative and chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeA2, (TNFA_wild_positive and chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain A and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeB1, (TNFA_wild_negative and chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeB2, (TNFA_wild_positive and chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain B and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeC1, (TNFA_wild_negative and chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeC2, (TNFA_wild_positive and chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain C and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeR1, (TNFA_wild_negative and chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeR2, (TNFA_wild_positive and chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain R and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeT1, (TNFA_wild_negative and chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeT2, (TNFA_wild_positive and chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain T and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeS1, (TNFA_wild_negative and chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_positive and not chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0
distance TNFA_wild_saltbridgeS2, (TNFA_wild_positive and chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), (TNFA_wild_negative and not chain S and 1tnr3_TNFA_back_rub_0696_relax_0025), 4.0, 0      
ray 1920, 1080 
png /Users/gcc/Desktop/GCC/pipeline/Report/Figures/Relax_PyMOL_Images/TNFA_wild.png, 1920, 1080
hide spheres, (TNFA_wild_negative or TNFA_wild_positive) and 1tnr3_TNFA_back_rub_0696_relax_0025
hide cartoon, 1tnr3_TNFA_back_rub_0696_relax_0025
hide sticks,((cys/ca+cb+sg) or (resn ASP+Glu+Lys+arg)) and 1tnr3_TNFA_back_rub_0696_relax_0025
delete TNFA_wild_saltbridge* or TNFA_wild_*tive

