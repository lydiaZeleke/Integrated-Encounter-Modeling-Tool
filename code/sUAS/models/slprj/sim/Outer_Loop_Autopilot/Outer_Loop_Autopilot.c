#include "Outer_Loop_Autopilot_capi.h"
#include "Outer_Loop_Autopilot.h"
#include "Outer_Loop_Autopilot_private.h"
static RegMdlInfo rtMdlInfo_Outer_Loop_Autopilot [ 53 ] = { { "bqxh50t43mf" ,
MDL_INFO_NAME_MDLREF_DWORK , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "dfbvcwywk2" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "fbcz3mybyo" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "dbd3i0254w" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "pol3ea0soe" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "nohds5ef3o" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "ag0f5zg2uu" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "caq4wrh4tx" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "p5welafb1j" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "nuyrzrfxfu" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "djq4zgpdbm" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "awnpy4ekcu" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "iam3v5hzqw" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "njaiiyxset" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "dxfzhncszn" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "hgfx4ibbkr" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "ehzb1dvqje" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "gjw3aottja" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "n0zwn4fij1" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "joal0r3a4b" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "brybnc1ypd" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "alcqqxvmwl" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "fpzbnlevyl" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "h21lzvoiy1" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "Outer_Loop_Autopilot" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , 0 , ( NULL ) } , { "fh2gcyrjna" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "no5mhwqtfd" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , { "ljuhlwvmol" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } , { "struct_RUNG81GCIdjqCq3JUUdhDD" ,
MDL_INFO_ID_DATA_TYPE , 0 , - 1 , ( NULL ) } , {
"struct_3PJJ4WLMHK1TvFiEKQocoD" , MDL_INFO_ID_DATA_TYPE , 0 , - 1 , ( NULL )
} , { "struct_KipJoflCB6JCEUAdQsRLpC" , MDL_INFO_ID_DATA_TYPE , 0 , - 1 , (
NULL ) } , { "struct_IVdt2OZSKf0hs7PThOqQKB" , MDL_INFO_ID_DATA_TYPE , 0 , -
1 , ( NULL ) } , { "struct_4DpoEKxWTGrPnnQ0H36a0F" , MDL_INFO_ID_DATA_TYPE ,
0 , - 1 , ( NULL ) } , { "struct_WviXPLxdKq6zu4cY2Dzal" ,
MDL_INFO_ID_DATA_TYPE , 0 , - 1 , ( NULL ) } , {
"struct_TWgvIboATVv1oYnNFGaPcB" , MDL_INFO_ID_DATA_TYPE , 0 , - 1 , ( NULL )
} , { "struct_wMU3Z0UnuhwPdkcASOisf" , MDL_INFO_ID_DATA_TYPE , 0 , - 1 , (
NULL ) } , { "struct_nqXLvpxiCuV9VWan6ELtQF" , MDL_INFO_ID_DATA_TYPE , 0 , -
1 , ( NULL ) } , { "struct_ZjT0A34wYizmJyD5SbbPIC" , MDL_INFO_ID_DATA_TYPE ,
0 , - 1 , ( NULL ) } , { "struct_RMiM9tyE6JXjOq0yW48iOB" ,
MDL_INFO_ID_DATA_TYPE , 0 , - 1 , ( NULL ) } , {
"mr_Outer_Loop_Autopilot_GetSimStateDisallowedBlocks" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_extractBitFieldFromCellArrayWithOffset" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_cacheBitFieldToCellArrayWithOffset" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_restoreDataFromMxArrayWithOffset" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_cacheDataToMxArrayWithOffset" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_extractBitFieldFromMxArray" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_cacheBitFieldToMxArray" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_restoreDataFromMxArray" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_cacheDataAsMxArray" , MDL_INFO_ID_MODEL_FCN_NAME ,
0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } , {
"mr_Outer_Loop_Autopilot_RegisterSimStateChecksum" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "mr_Outer_Loop_Autopilot_SetDWork" , MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 ,
( void * ) "Outer_Loop_Autopilot" } , { "mr_Outer_Loop_Autopilot_GetDWork" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "Outer_Loop_Autopilot" } ,
{ "Outer_Loop_Autopilot.h" , MDL_INFO_MODEL_FILENAME , 0 , - 1 , ( NULL ) } ,
{ "Outer_Loop_Autopilot.c" , MDL_INFO_MODEL_FILENAME , 0 , - 1 , ( void * )
"Outer_Loop_Autopilot" } } ; e1oexindosj e1oexindos = { 0.1 , 0.5 , 0.5 , 0.0
, 0.0 , 0.15 , 5.0 , 2.0 , 0.0 , 0.0 , 0.0 , 0.0 , 0.0 , 1.3 , 1.3 , 7.0 ,
0.5 , 0.5 , - 0.261799395F , - 0.261799395F , 0.0 , 0.0 , 0.0 , 0.01 , 0.0 ,
0.005 , 0.0 , 1.0 , 0.01 , 0.0 , 0.0 , 0.0 , 0.5 , { 1.0 , 0.5 } , 0.0 ,
100.0 , 0.0 , 0.005 , 100.0 , 0.0 , 0.005 , - 0.2617993950843811 , 5.0 , -
4.0 , 1U , 0U } ; void brybnc1ypd ( iam3v5hzqw * localDW ) { localDW ->
o5q03ofnhk = e1oexindos . P_10 ; localDW -> c2kaxshh5u = 0 ; localDW ->
gqkv4njxec = e1oexindos . P_11 ; localDW -> cre55s3b0t = 0 ; localDW ->
hjciw5sh12 = e1oexindos . P_31 ; localDW -> fdiqtgksxq = e1oexindos . P_32 ;
localDW -> bsbmispgki = e1oexindos . P_46 ; localDW -> jqzz2ajp5k =
e1oexindos . P_33 ; localDW -> ntia1rnz0t = e1oexindos . P_36 ; localDW ->
plquzxxiyl = e1oexindos . P_5 ; localDW -> pfeb01dnf0 = e1oexindos . P_12 ;
localDW -> ovxojvo0sh = 0 ; localDW -> abyhpd51lp = e1oexindos . P_6 ;
localDW -> epu3x52laf = e1oexindos . P_13 ; localDW -> fkvndktom2 = 0 ; }
void joal0r3a4b ( iam3v5hzqw * localDW ) { localDW -> o5q03ofnhk = e1oexindos
. P_10 ; localDW -> c2kaxshh5u = 0 ; localDW -> gqkv4njxec = e1oexindos .
P_11 ; localDW -> cre55s3b0t = 0 ; localDW -> hjciw5sh12 = e1oexindos . P_31
; localDW -> fdiqtgksxq = e1oexindos . P_32 ; localDW -> bsbmispgki =
e1oexindos . P_46 ; localDW -> jqzz2ajp5k = e1oexindos . P_33 ; localDW ->
ntia1rnz0t = e1oexindos . P_36 ; localDW -> plquzxxiyl = e1oexindos . P_5 ;
localDW -> pfeb01dnf0 = e1oexindos . P_12 ; localDW -> ovxojvo0sh = 0 ;
localDW -> abyhpd51lp = e1oexindos . P_6 ; localDW -> epu3x52laf = e1oexindos
. P_13 ; localDW -> fkvndktom2 = 0 ; } void Outer_Loop_Autopilot ( const
real_T bnhvz3po55 [ 3 ] , const real_T * fogmat4wia , const real_T *
gijqutldwv , const real_T * pxs0jby53b , const real_T * myhdcnwrlh , const
real_T * oylgqnx54q , real_T * hauut1f2aq , real_T * brosjbpf4m , real_T *
llhebclkdo , njaiiyxset * localB , iam3v5hzqw * localDW , nuyrzrfxfu *
localZCE ) { real_T ael5lbflcx ; real_T evhaq2jam5 ; real_T hmypluqd4a ;
real_T i0frm5qca2 ; real_T inghfb2nps ; real_T onyuzofp4i ; real_T tmp ;
real_T tmp_p ; boolean_T kqn1fye5ke ; i0frm5qca2 = * myhdcnwrlh - *
fogmat4wia ; hmypluqd4a = e1oexindos . P_15 * i0frm5qca2 ; if ( ( *
oylgqnx54q != 0.0 ) || ( localDW -> c2kaxshh5u != 0 ) ) { localDW ->
o5q03ofnhk = e1oexindos . P_10 ; } localB -> f3vvsfbgw1 = ( e1oexindos . P_2
* i0frm5qca2 - localDW -> o5q03ofnhk ) * rtP_ap . control .
derivativesConstant ; onyuzofp4i = ( hmypluqd4a + localDW -> gqkv4njxec ) +
localB -> f3vvsfbgw1 ; if ( onyuzofp4i > rtP_ap . control . dtLimit ) {
inghfb2nps = onyuzofp4i - rtP_ap . control . dtLimit ; } else if ( onyuzofp4i
>= e1oexindos . P_14 ) { inghfb2nps = 0.0 ; } else { inghfb2nps = onyuzofp4i
- e1oexindos . P_14 ; } i0frm5qca2 *= e1oexindos . P_7 ; tmp =
muDoubleScalarSign ( inghfb2nps ) ; if ( muDoubleScalarIsNaN ( tmp ) ) { tmp
= 0.0 ; } else { tmp = muDoubleScalarRem ( tmp , 256.0 ) ; } tmp_p =
muDoubleScalarSign ( i0frm5qca2 ) ; if ( muDoubleScalarIsNaN ( tmp_p ) ) {
tmp_p = 0.0 ; } else { tmp_p = muDoubleScalarRem ( tmp_p , 256.0 ) ; } if ( (
e1oexindos . P_26 * onyuzofp4i != inghfb2nps ) && ( ( tmp < 0.0 ? ( int32_T )
( int8_T ) - ( int8_T ) ( uint8_T ) - tmp : ( int32_T ) ( int8_T ) ( uint8_T
) tmp ) == ( tmp_p < 0.0 ? ( int32_T ) ( int8_T ) - ( int8_T ) ( uint8_T ) -
tmp_p : ( int32_T ) ( int8_T ) ( uint8_T ) tmp_p ) ) ) { localB -> kewmeqjqb0
= e1oexindos . P_22 ; } else { localB -> kewmeqjqb0 = i0frm5qca2 ; } if ( ( *
oylgqnx54q != 0.0 ) || ( localDW -> cre55s3b0t != 0 ) ) { localDW ->
gqkv4njxec = e1oexindos . P_11 ; } localB -> mcybxiknuu = e1oexindos . P_27 *
localB -> kewmeqjqb0 + localDW -> gqkv4njxec ; i0frm5qca2 = ( hmypluqd4a +
localB -> mcybxiknuu ) + localB -> f3vvsfbgw1 ; if ( i0frm5qca2 > rtP_ap .
control . dtLimit ) { i0frm5qca2 = rtP_ap . control . dtLimit ; } else if (
i0frm5qca2 < e1oexindos . P_14 ) { i0frm5qca2 = e1oexindos . P_14 ; } if (
i0frm5qca2 > rtP_ap . control . dtLimit ) { * brosjbpf4m = rtP_ap . control .
dtLimit ; } else if ( i0frm5qca2 < e1oexindos . P_28 ) { * brosjbpf4m =
e1oexindos . P_28 ; } else { * brosjbpf4m = i0frm5qca2 ; } onyuzofp4i =
e1oexindos . P_29 * bnhvz3po55 [ 2 ] ; i0frm5qca2 = e1oexindos . P_44 *
e1oexindos . P_30 ; localB -> cevhpp2k4y = muDoubleScalarAbs ( localDW ->
hjciw5sh12 - rtP_uavParam . ic . Pos_0 [ 2 ] ) ; kqn1fye5ke = ( ( localB ->
cevhpp2k4y >= e1oexindos . P_18 ) && ( localDW -> fdiqtgksxq < e1oexindos .
P_19 ) ) ; if ( kqn1fye5ke || ( localDW -> bsbmispgki != 0 ) ) { hmypluqd4a =
rtP_uavParam . ic . Pos_0 [ 2 ] ; } else { hmypluqd4a = localDW -> jqzz2ajp5k
; } inghfb2nps = * gijqutldwv - hmypluqd4a ; if ( ! ( inghfb2nps > i0frm5qca2
) ) { i0frm5qca2 = e1oexindos . P_45 * e1oexindos . P_30 ; if ( ! (
inghfb2nps < i0frm5qca2 ) ) { i0frm5qca2 = inghfb2nps ; } } hmypluqd4a +=
i0frm5qca2 ; inghfb2nps = hmypluqd4a - onyuzofp4i ; onyuzofp4i = * gijqutldwv
- onyuzofp4i ; localB -> n0e12fvl2q = e1oexindos . P_3 * inghfb2nps *
e1oexindos . P_37 ; if ( ( rt_ZCFcn ( ANY_ZERO_CROSSING , & localZCE ->
irgjo54hky , ( * oylgqnx54q ) ) != NO_ZCEVENT ) || ( * oylgqnx54q != 0.0 ) )
{ localDW -> plquzxxiyl = e1oexindos . P_5 ; } i0frm5qca2 = ( e1oexindos .
P_16 * inghfb2nps + localDW -> pfeb01dnf0 ) + ( localB -> n0e12fvl2q -
localDW -> plquzxxiyl ) ; if ( i0frm5qca2 > rtP_ap . control . the_cLimit ) {
ael5lbflcx = i0frm5qca2 - rtP_ap . control . the_cLimit ; } else if (
i0frm5qca2 >= e1oexindos . P_20 ) { ael5lbflcx = 0.0 ; } else { ael5lbflcx =
i0frm5qca2 - e1oexindos . P_20 ; } inghfb2nps *= e1oexindos . P_8 ; tmp =
muDoubleScalarSign ( ael5lbflcx ) ; if ( muDoubleScalarIsNaN ( tmp ) ) { tmp
= 0.0 ; } else { tmp = muDoubleScalarRem ( tmp , 256.0 ) ; } tmp_p =
muDoubleScalarSign ( inghfb2nps ) ; if ( muDoubleScalarIsNaN ( tmp_p ) ) {
tmp_p = 0.0 ; } else { tmp_p = muDoubleScalarRem ( tmp_p , 256.0 ) ; } if ( (
e1oexindos . P_38 * i0frm5qca2 != ael5lbflcx ) && ( ( tmp < 0.0 ? ( int32_T )
( int8_T ) - ( int8_T ) ( uint8_T ) - tmp : ( int32_T ) ( int8_T ) ( uint8_T
) tmp ) == ( tmp_p < 0.0 ? ( int32_T ) ( int8_T ) - ( int8_T ) ( uint8_T ) -
tmp_p : ( int32_T ) ( int8_T ) ( uint8_T ) tmp_p ) ) ) { localB -> mv5xvdfnja
= e1oexindos . P_23 ; } else { localB -> mv5xvdfnja = inghfb2nps ; } if ( ( *
oylgqnx54q != 0.0 ) || ( localDW -> ovxojvo0sh != 0 ) ) { localDW ->
pfeb01dnf0 = e1oexindos . P_12 ; } localB -> apewkcw0a5 = e1oexindos . P_39 *
localB -> mv5xvdfnja + localDW -> pfeb01dnf0 ; inghfb2nps = e1oexindos . P_17
* onyuzofp4i ; localB -> ljuzpykecg = e1oexindos . P_4 * onyuzofp4i *
e1oexindos . P_40 ; if ( ( rt_ZCFcn ( ANY_ZERO_CROSSING , & localZCE ->
gbk1r4vbqe , ( * oylgqnx54q ) ) != NO_ZCEVENT ) || ( * oylgqnx54q != 0.0 ) )
{ localDW -> abyhpd51lp = e1oexindos . P_6 ; } i0frm5qca2 = localB ->
ljuzpykecg - localDW -> abyhpd51lp ; ael5lbflcx = ( inghfb2nps + localDW ->
epu3x52laf ) + i0frm5qca2 ; if ( ael5lbflcx > rtP_ap . control . the_cLimit )
{ evhaq2jam5 = ael5lbflcx - rtP_ap . control . the_cLimit ; } else if (
ael5lbflcx >= e1oexindos . P_21 ) { evhaq2jam5 = 0.0 ; } else { evhaq2jam5 =
ael5lbflcx - e1oexindos . P_21 ; } onyuzofp4i *= e1oexindos . P_9 ; tmp =
muDoubleScalarSign ( evhaq2jam5 ) ; if ( muDoubleScalarIsNaN ( tmp ) ) { tmp
= 0.0 ; } else { tmp = muDoubleScalarRem ( tmp , 256.0 ) ; } tmp_p =
muDoubleScalarSign ( onyuzofp4i ) ; if ( muDoubleScalarIsNaN ( tmp_p ) ) {
tmp_p = 0.0 ; } else { tmp_p = muDoubleScalarRem ( tmp_p , 256.0 ) ; } if ( (
e1oexindos . P_41 * ael5lbflcx != evhaq2jam5 ) && ( ( tmp < 0.0 ? ( int32_T )
( int8_T ) - ( int8_T ) ( uint8_T ) - tmp : ( int32_T ) ( int8_T ) ( uint8_T
) tmp ) == ( tmp_p < 0.0 ? ( int32_T ) ( int8_T ) - ( int8_T ) ( uint8_T ) -
tmp_p : ( int32_T ) ( int8_T ) ( uint8_T ) tmp_p ) ) ) { localB -> gheqfuqhze
= e1oexindos . P_24 ; } else { localB -> gheqfuqhze = onyuzofp4i ; } if ( ( *
oylgqnx54q != 0.0 ) || ( localDW -> fkvndktom2 != 0 ) ) { localDW ->
epu3x52laf = e1oexindos . P_13 ; } localB -> oaz5nnoib2 = e1oexindos . P_42 *
localB -> gheqfuqhze + localDW -> epu3x52laf ; i0frm5qca2 += inghfb2nps +
localB -> oaz5nnoib2 ; if ( i0frm5qca2 > rtP_ap . control . the_cLimit ) {
localB -> pcj1p2bwp3 = rtP_ap . control . the_cLimit ; } else if ( i0frm5qca2
< e1oexindos . P_21 ) { localB -> pcj1p2bwp3 = e1oexindos . P_21 ; } else {
localB -> pcj1p2bwp3 = i0frm5qca2 ; } if ( kqn1fye5ke ) { localB ->
oxuqjnz4k1 = rtP_uavParam . ic . Pos_0 [ 2 ] ; } else { localB -> oxuqjnz4k1
= hmypluqd4a ; } i0frm5qca2 = localB -> pcj1p2bwp3 - e1oexindos . P_34 *
localDW -> ntia1rnz0t ; if ( i0frm5qca2 > rtP_ap . control . the_cLimit ) { *
hauut1f2aq = rtP_ap . control . the_cLimit ; } else if ( i0frm5qca2 <
e1oexindos . P_43 ) { * hauut1f2aq = e1oexindos . P_43 ; } else { *
hauut1f2aq = i0frm5qca2 ; } * llhebclkdo = * pxs0jby53b ; } void
Outer_Loop_AutopilotTID1 ( void ) { } void n0zwn4fij1 ( const real_T *
oylgqnx54q , njaiiyxset * localB , iam3v5hzqw * localDW ) { localDW ->
o5q03ofnhk += e1oexindos . P_25 * localB -> f3vvsfbgw1 ; if ( * oylgqnx54q >
0.0 ) { localDW -> c2kaxshh5u = 1 ; localDW -> cre55s3b0t = 1 ; } else { if (
* oylgqnx54q < 0.0 ) { localDW -> c2kaxshh5u = - 1 ; } else if ( * oylgqnx54q
== 0.0 ) { localDW -> c2kaxshh5u = 0 ; } else { localDW -> c2kaxshh5u = 2 ; }
if ( * oylgqnx54q < 0.0 ) { localDW -> cre55s3b0t = - 1 ; } else if ( *
oylgqnx54q == 0.0 ) { localDW -> cre55s3b0t = 0 ; } else { localDW ->
cre55s3b0t = 2 ; } } localDW -> gqkv4njxec = e1oexindos . P_27 * localB ->
kewmeqjqb0 + localB -> mcybxiknuu ; localDW -> hjciw5sh12 = rtP_uavParam . ic
. Pos_0 [ 2 ] ; localDW -> fdiqtgksxq = localB -> cevhpp2k4y ; localDW ->
bsbmispgki = e1oexindos . P_47 ; localDW -> jqzz2ajp5k = localB -> oxuqjnz4k1
; localDW -> ntia1rnz0t = ( localB -> pcj1p2bwp3 - e1oexindos . P_35 [ 1 ] *
localDW -> ntia1rnz0t ) / e1oexindos . P_35 [ 0 ] ; localDW -> plquzxxiyl =
localB -> n0e12fvl2q ; localDW -> pfeb01dnf0 = e1oexindos . P_39 * localB ->
mv5xvdfnja + localB -> apewkcw0a5 ; if ( * oylgqnx54q > 0.0 ) { localDW ->
ovxojvo0sh = 1 ; localDW -> fkvndktom2 = 1 ; } else { if ( * oylgqnx54q < 0.0
) { localDW -> ovxojvo0sh = - 1 ; } else if ( * oylgqnx54q == 0.0 ) { localDW
-> ovxojvo0sh = 0 ; } else { localDW -> ovxojvo0sh = 2 ; } if ( * oylgqnx54q
< 0.0 ) { localDW -> fkvndktom2 = - 1 ; } else if ( * oylgqnx54q == 0.0 ) {
localDW -> fkvndktom2 = 0 ; } else { localDW -> fkvndktom2 = 2 ; } } localDW
-> abyhpd51lp = localB -> ljuzpykecg ; localDW -> epu3x52laf = e1oexindos .
P_42 * localB -> gheqfuqhze + localB -> oaz5nnoib2 ; } void n0zwn4fij1TID1 (
void ) { } void hgfx4ibbkr ( ljuhlwvmol * const bjehncrpxl ) { if ( !
slIsRapidAcceleratorSimulating ( ) ) { slmrRunPluginEvent ( bjehncrpxl ->
_mdlRefSfcnS , "Outer_Loop_Autopilot" ,
"SIMSTATUS_TERMINATING_MODELREF_ACCEL_EVENT" ) ; } } void alcqqxvmwl (
SimStruct * _mdlRefSfcnS , int_T mdlref_TID0 , int_T mdlref_TID1 , ljuhlwvmol
* const bjehncrpxl , njaiiyxset * localB , iam3v5hzqw * localDW , nuyrzrfxfu
* localZCE , void * sysRanPtr , int contextTid , rtwCAPI_ModelMappingInfo *
rt_ParentMMI , const char_T * rt_ChildPath , int_T rt_ChildMMIIdx , int_T
rt_CSTATEIdx ) { rt_InitInfAndNaN ( sizeof ( real_T ) ) ; ( void ) memset ( (
void * ) bjehncrpxl , 0 , sizeof ( ljuhlwvmol ) ) ; bjehncrpxl -> Timing .
mdlref_GlobalTID [ 0 ] = mdlref_TID0 ; bjehncrpxl -> Timing .
mdlref_GlobalTID [ 1 ] = mdlref_TID1 ; bjehncrpxl -> _mdlRefSfcnS = (
_mdlRefSfcnS ) ; if ( ! slIsRapidAcceleratorSimulating ( ) ) {
slmrRunPluginEvent ( bjehncrpxl -> _mdlRefSfcnS , "Outer_Loop_Autopilot" ,
"START_OF_SIM_MODEL_MODELREF_ACCEL_EVENT" ) ; } { localB -> f3vvsfbgw1 = 0.0
; localB -> kewmeqjqb0 = 0.0 ; localB -> mcybxiknuu = 0.0 ; localB ->
cevhpp2k4y = 0.0 ; localB -> n0e12fvl2q = 0.0 ; localB -> mv5xvdfnja = 0.0 ;
localB -> apewkcw0a5 = 0.0 ; localB -> ljuzpykecg = 0.0 ; localB ->
gheqfuqhze = 0.0 ; localB -> oaz5nnoib2 = 0.0 ; localB -> pcj1p2bwp3 = 0.0 ;
localB -> oxuqjnz4k1 = 0.0 ; } ( void ) memset ( ( void * ) localDW , 0 ,
sizeof ( iam3v5hzqw ) ) ; localDW -> o5q03ofnhk = 0.0 ; localDW -> gqkv4njxec
= 0.0 ; localDW -> hjciw5sh12 = 0.0 ; localDW -> fdiqtgksxq = 0.0 ; localDW
-> jqzz2ajp5k = 0.0 ; localDW -> ntia1rnz0t = 0.0 ; localDW -> plquzxxiyl =
0.0 ; localDW -> pfeb01dnf0 = 0.0 ; localDW -> abyhpd51lp = 0.0 ; localDW ->
epu3x52laf = 0.0 ; Outer_Loop_Autopilot_InitializeDataMapInfo ( bjehncrpxl ,
localDW , sysRanPtr , contextTid ) ; if ( ( rt_ParentMMI != ( NULL ) ) && (
rt_ChildPath != ( NULL ) ) ) { rtwCAPI_SetChildMMI ( * rt_ParentMMI ,
rt_ChildMMIIdx , & ( bjehncrpxl -> DataMapInfo . mmi ) ) ; rtwCAPI_SetPath (
bjehncrpxl -> DataMapInfo . mmi , rt_ChildPath ) ;
rtwCAPI_MMISetContStateStartIndex ( bjehncrpxl -> DataMapInfo . mmi ,
rt_CSTATEIdx ) ; } localZCE -> irgjo54hky = UNINITIALIZED_ZCSIG ; localZCE ->
gbk1r4vbqe = UNINITIALIZED_ZCSIG ; } void
mr_Outer_Loop_Autopilot_MdlInfoRegFcn ( SimStruct * mdlRefSfcnS , char_T *
modelName , int_T * retVal ) { * retVal = 0 ; { boolean_T regSubmodelsMdlinfo
= false ; ssGetRegSubmodelsMdlinfo ( mdlRefSfcnS , & regSubmodelsMdlinfo ) ;
if ( regSubmodelsMdlinfo ) { } } * retVal = 0 ; ssRegModelRefMdlInfo (
mdlRefSfcnS , modelName , rtMdlInfo_Outer_Loop_Autopilot , 53 ) ; * retVal =
1 ; } static void mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( mxArray *
destArray , mwIndex i , int j , const void * srcData , size_t numBytes ) ;
static void mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( mxArray * destArray
, mwIndex i , int j , const void * srcData , size_t numBytes ) { mxArray *
newArray = mxCreateUninitNumericMatrix ( ( size_t ) 1 , numBytes ,
mxUINT8_CLASS , mxREAL ) ; memcpy ( ( uint8_T * ) mxGetData ( newArray ) , (
const uint8_T * ) srcData , numBytes ) ; mxSetFieldByNumber ( destArray , i ,
j , newArray ) ; } static void mr_Outer_Loop_Autopilot_restoreDataFromMxArray
( void * destData , const mxArray * srcArray , mwIndex i , int j , size_t
numBytes ) ; static void mr_Outer_Loop_Autopilot_restoreDataFromMxArray (
void * destData , const mxArray * srcArray , mwIndex i , int j , size_t
numBytes ) { memcpy ( ( uint8_T * ) destData , ( const uint8_T * ) mxGetData
( mxGetFieldByNumber ( srcArray , i , j ) ) , numBytes ) ; } static void
mr_Outer_Loop_Autopilot_cacheBitFieldToMxArray ( mxArray * destArray ,
mwIndex i , int j , uint_T bitVal ) ; static void
mr_Outer_Loop_Autopilot_cacheBitFieldToMxArray ( mxArray * destArray ,
mwIndex i , int j , uint_T bitVal ) { mxSetFieldByNumber ( destArray , i , j
, mxCreateDoubleScalar ( ( double ) bitVal ) ) ; } static uint_T
mr_Outer_Loop_Autopilot_extractBitFieldFromMxArray ( const mxArray * srcArray
, mwIndex i , int j , uint_T numBits ) ; static uint_T
mr_Outer_Loop_Autopilot_extractBitFieldFromMxArray ( const mxArray * srcArray
, mwIndex i , int j , uint_T numBits ) { const uint_T varVal = ( uint_T )
mxGetScalar ( mxGetFieldByNumber ( srcArray , i , j ) ) ; return varVal & ( (
1u << numBits ) - 1u ) ; } static void
mr_Outer_Loop_Autopilot_cacheDataToMxArrayWithOffset ( mxArray * destArray ,
mwIndex i , int j , mwIndex offset , const void * srcData , size_t numBytes )
; static void mr_Outer_Loop_Autopilot_cacheDataToMxArrayWithOffset ( mxArray
* destArray , mwIndex i , int j , mwIndex offset , const void * srcData ,
size_t numBytes ) { uint8_T * varData = ( uint8_T * ) mxGetData (
mxGetFieldByNumber ( destArray , i , j ) ) ; memcpy ( ( uint8_T * ) & varData
[ offset * numBytes ] , ( const uint8_T * ) srcData , numBytes ) ; } static
void mr_Outer_Loop_Autopilot_restoreDataFromMxArrayWithOffset ( void *
destData , const mxArray * srcArray , mwIndex i , int j , mwIndex offset ,
size_t numBytes ) ; static void
mr_Outer_Loop_Autopilot_restoreDataFromMxArrayWithOffset ( void * destData ,
const mxArray * srcArray , mwIndex i , int j , mwIndex offset , size_t
numBytes ) { const uint8_T * varData = ( const uint8_T * ) mxGetData (
mxGetFieldByNumber ( srcArray , i , j ) ) ; memcpy ( ( uint8_T * ) destData ,
( const uint8_T * ) & varData [ offset * numBytes ] , numBytes ) ; } static
void mr_Outer_Loop_Autopilot_cacheBitFieldToCellArrayWithOffset ( mxArray *
destArray , mwIndex i , int j , mwIndex offset , uint_T fieldVal ) ; static
void mr_Outer_Loop_Autopilot_cacheBitFieldToCellArrayWithOffset ( mxArray *
destArray , mwIndex i , int j , mwIndex offset , uint_T fieldVal ) {
mxSetCell ( mxGetFieldByNumber ( destArray , i , j ) , offset ,
mxCreateDoubleScalar ( ( double ) fieldVal ) ) ; } static uint_T
mr_Outer_Loop_Autopilot_extractBitFieldFromCellArrayWithOffset ( const
mxArray * srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) ;
static uint_T mr_Outer_Loop_Autopilot_extractBitFieldFromCellArrayWithOffset
( const mxArray * srcArray , mwIndex i , int j , mwIndex offset , uint_T
numBits ) { const uint_T fieldVal = ( uint_T ) mxGetScalar ( mxGetCell (
mxGetFieldByNumber ( srcArray , i , j ) , offset ) ) ; return fieldVal & ( (
1u << numBits ) - 1u ) ; } mxArray * mr_Outer_Loop_Autopilot_GetDWork ( const
bqxh50t43mf * mdlrefDW ) { static const char * ssDWFieldNames [ 3 ] = { "rtb"
, "rtdw" , "rtzce" , } ; mxArray * ssDW = mxCreateStructMatrix ( 1 , 1 , 3 ,
ssDWFieldNames ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( ssDW , 0 , 0
, ( const void * ) & ( mdlrefDW -> rtb ) , sizeof ( mdlrefDW -> rtb ) ) ; {
static const char * rtdwDataFieldNames [ 15 ] = { "mdlrefDW->rtdw.o5q03ofnhk"
, "mdlrefDW->rtdw.gqkv4njxec" , "mdlrefDW->rtdw.hjciw5sh12" ,
"mdlrefDW->rtdw.fdiqtgksxq" , "mdlrefDW->rtdw.jqzz2ajp5k" ,
"mdlrefDW->rtdw.ntia1rnz0t" , "mdlrefDW->rtdw.plquzxxiyl" ,
"mdlrefDW->rtdw.pfeb01dnf0" , "mdlrefDW->rtdw.abyhpd51lp" ,
"mdlrefDW->rtdw.epu3x52laf" , "mdlrefDW->rtdw.bsbmispgki" ,
"mdlrefDW->rtdw.c2kaxshh5u" , "mdlrefDW->rtdw.cre55s3b0t" ,
"mdlrefDW->rtdw.ovxojvo0sh" , "mdlrefDW->rtdw.fkvndktom2" , } ; mxArray *
rtdwData = mxCreateStructMatrix ( 1 , 1 , 15 , rtdwDataFieldNames ) ;
mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 , 0 , ( const void
* ) & ( mdlrefDW -> rtdw . o5q03ofnhk ) , sizeof ( mdlrefDW -> rtdw .
o5q03ofnhk ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 ,
1 , ( const void * ) & ( mdlrefDW -> rtdw . gqkv4njxec ) , sizeof ( mdlrefDW
-> rtdw . gqkv4njxec ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray (
rtdwData , 0 , 2 , ( const void * ) & ( mdlrefDW -> rtdw . hjciw5sh12 ) ,
sizeof ( mdlrefDW -> rtdw . hjciw5sh12 ) ) ;
mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 , 3 , ( const void
* ) & ( mdlrefDW -> rtdw . fdiqtgksxq ) , sizeof ( mdlrefDW -> rtdw .
fdiqtgksxq ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 ,
4 , ( const void * ) & ( mdlrefDW -> rtdw . jqzz2ajp5k ) , sizeof ( mdlrefDW
-> rtdw . jqzz2ajp5k ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray (
rtdwData , 0 , 5 , ( const void * ) & ( mdlrefDW -> rtdw . ntia1rnz0t ) ,
sizeof ( mdlrefDW -> rtdw . ntia1rnz0t ) ) ;
mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 , 6 , ( const void
* ) & ( mdlrefDW -> rtdw . plquzxxiyl ) , sizeof ( mdlrefDW -> rtdw .
plquzxxiyl ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 ,
7 , ( const void * ) & ( mdlrefDW -> rtdw . pfeb01dnf0 ) , sizeof ( mdlrefDW
-> rtdw . pfeb01dnf0 ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray (
rtdwData , 0 , 8 , ( const void * ) & ( mdlrefDW -> rtdw . abyhpd51lp ) ,
sizeof ( mdlrefDW -> rtdw . abyhpd51lp ) ) ;
mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 , 9 , ( const void
* ) & ( mdlrefDW -> rtdw . epu3x52laf ) , sizeof ( mdlrefDW -> rtdw .
epu3x52laf ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 ,
10 , ( const void * ) & ( mdlrefDW -> rtdw . bsbmispgki ) , sizeof ( mdlrefDW
-> rtdw . bsbmispgki ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray (
rtdwData , 0 , 11 , ( const void * ) & ( mdlrefDW -> rtdw . c2kaxshh5u ) ,
sizeof ( mdlrefDW -> rtdw . c2kaxshh5u ) ) ;
mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 , 12 , ( const void
* ) & ( mdlrefDW -> rtdw . cre55s3b0t ) , sizeof ( mdlrefDW -> rtdw .
cre55s3b0t ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( rtdwData , 0 ,
13 , ( const void * ) & ( mdlrefDW -> rtdw . ovxojvo0sh ) , sizeof ( mdlrefDW
-> rtdw . ovxojvo0sh ) ) ; mr_Outer_Loop_Autopilot_cacheDataAsMxArray (
rtdwData , 0 , 14 , ( const void * ) & ( mdlrefDW -> rtdw . fkvndktom2 ) ,
sizeof ( mdlrefDW -> rtdw . fkvndktom2 ) ) ; mxSetFieldByNumber ( ssDW , 0 ,
1 , rtdwData ) ; } mr_Outer_Loop_Autopilot_cacheDataAsMxArray ( ssDW , 0 , 2
, ( const void * ) & ( mdlrefDW -> rtzce ) , sizeof ( mdlrefDW -> rtzce ) ) ;
( void ) mdlrefDW ; return ssDW ; } void mr_Outer_Loop_Autopilot_SetDWork (
bqxh50t43mf * mdlrefDW , const mxArray * ssDW ) { ( void ) ssDW ; ( void )
mdlrefDW ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & (
mdlrefDW -> rtb ) , ssDW , 0 , 0 , sizeof ( mdlrefDW -> rtb ) ) ; { const
mxArray * rtdwData = mxGetFieldByNumber ( ssDW , 0 , 1 ) ;
mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW ->
rtdw . o5q03ofnhk ) , rtdwData , 0 , 0 , sizeof ( mdlrefDW -> rtdw .
o5q03ofnhk ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * )
& ( mdlrefDW -> rtdw . gqkv4njxec ) , rtdwData , 0 , 1 , sizeof ( mdlrefDW ->
rtdw . gqkv4njxec ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( (
void * ) & ( mdlrefDW -> rtdw . hjciw5sh12 ) , rtdwData , 0 , 2 , sizeof (
mdlrefDW -> rtdw . hjciw5sh12 ) ) ;
mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW ->
rtdw . fdiqtgksxq ) , rtdwData , 0 , 3 , sizeof ( mdlrefDW -> rtdw .
fdiqtgksxq ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * )
& ( mdlrefDW -> rtdw . jqzz2ajp5k ) , rtdwData , 0 , 4 , sizeof ( mdlrefDW ->
rtdw . jqzz2ajp5k ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( (
void * ) & ( mdlrefDW -> rtdw . ntia1rnz0t ) , rtdwData , 0 , 5 , sizeof (
mdlrefDW -> rtdw . ntia1rnz0t ) ) ;
mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW ->
rtdw . plquzxxiyl ) , rtdwData , 0 , 6 , sizeof ( mdlrefDW -> rtdw .
plquzxxiyl ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * )
& ( mdlrefDW -> rtdw . pfeb01dnf0 ) , rtdwData , 0 , 7 , sizeof ( mdlrefDW ->
rtdw . pfeb01dnf0 ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( (
void * ) & ( mdlrefDW -> rtdw . abyhpd51lp ) , rtdwData , 0 , 8 , sizeof (
mdlrefDW -> rtdw . abyhpd51lp ) ) ;
mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW ->
rtdw . epu3x52laf ) , rtdwData , 0 , 9 , sizeof ( mdlrefDW -> rtdw .
epu3x52laf ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * )
& ( mdlrefDW -> rtdw . bsbmispgki ) , rtdwData , 0 , 10 , sizeof ( mdlrefDW
-> rtdw . bsbmispgki ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( (
void * ) & ( mdlrefDW -> rtdw . c2kaxshh5u ) , rtdwData , 0 , 11 , sizeof (
mdlrefDW -> rtdw . c2kaxshh5u ) ) ;
mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW ->
rtdw . cre55s3b0t ) , rtdwData , 0 , 12 , sizeof ( mdlrefDW -> rtdw .
cre55s3b0t ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * )
& ( mdlrefDW -> rtdw . ovxojvo0sh ) , rtdwData , 0 , 13 , sizeof ( mdlrefDW
-> rtdw . ovxojvo0sh ) ) ; mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( (
void * ) & ( mdlrefDW -> rtdw . fkvndktom2 ) , rtdwData , 0 , 14 , sizeof (
mdlrefDW -> rtdw . fkvndktom2 ) ) ; }
mr_Outer_Loop_Autopilot_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW ->
rtzce ) , ssDW , 0 , 2 , sizeof ( mdlrefDW -> rtzce ) ) ; } void
mr_Outer_Loop_Autopilot_RegisterSimStateChecksum ( SimStruct * S ) { const
uint32_T chksum [ 4 ] = { 3143263435U , 650674334U , 2060283U , 2459367747U ,
} ; slmrModelRefRegisterSimStateChecksum ( S , "Outer_Loop_Autopilot" , &
chksum [ 0 ] ) ; } mxArray *
mr_Outer_Loop_Autopilot_GetSimStateDisallowedBlocks ( ) { return ( NULL ) ; }
#if defined(_MSC_VER)
#pragma warning(disable: 4505) //unreferenced local function has been removed
#endif