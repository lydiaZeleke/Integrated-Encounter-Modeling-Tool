#ifndef RTW_HEADER_Outer_Loop_Autopilot_h_
#define RTW_HEADER_Outer_Loop_Autopilot_h_
#include <string.h>
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#ifndef Outer_Loop_Autopilot_COMMON_INCLUDES_
#define Outer_Loop_Autopilot_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "zero_crossing_types.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "simstruc.h"
#include "fixedpoint.h"
#endif
#include "Outer_Loop_Autopilot_types.h"
#include "multiword_types.h"
#include "rt_zcfcn.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"
typedef struct { real_T f3vvsfbgw1 ; real_T kewmeqjqb0 ; real_T mcybxiknuu ;
real_T cevhpp2k4y ; real_T pkcg0uswmx ; real_T jtmfy2c2ed ; real_T bfofuhnty1
; real_T a4mouazu4l ; real_T ce5p4qffme ; real_T f3lvtpsch4 ; real_T
hj34mjqgdg ; real_T oxuqjnz4k1 ; } njaiiyxset ; typedef struct { real_T
o5q03ofnhk ; real_T gqkv4njxec ; real_T hjciw5sh12 ; real_T fdiqtgksxq ;
real_T jqzz2ajp5k ; real_T bz23ri30n0 ; real_T m5d2mcswp1 ; real_T ntia1rnz0t
; real_T plquzxxiyl ; real_T pfeb01dnf0 ; uint8_T bsbmispgki ; int8_T
c2kaxshh5u ; int8_T cre55s3b0t ; int8_T pimeoy3e2a ; int8_T nl5murwjeb ;
int8_T ovxojvo0sh ; } iam3v5hzqw ; typedef struct { real_T hzhrocwczv ; }
dfbvcwywk2 ; typedef struct { ZCSigState irgjo54hky ; } nuyrzrfxfu ; struct
e1oexindosj_ { real_T P_2 ; real_T P_3 ; real_T P_4 ; real_T P_5 ; real_T P_6
; real_T P_7 ; real_T P_8 ; real_T P_9 ; real_T P_10 ; real_T P_11 ; real_T
P_12 ; real_T P_13 ; real_T P_14 ; real_T P_15 ; real_T P_16 ; real_T P_17 ;
real_T P_18 ; real_T P_19 ; real_T P_20 ; real32_T P_21 ; real32_T P_22 ;
real_T P_23 ; real_T P_24 ; real_T P_25 ; real_T P_26 ; real_T P_27 ; real_T
P_28 ; real_T P_29 ; real_T P_30 ; real_T P_31 ; real_T P_32 ; real_T P_33 ;
real_T P_34 ; real_T P_35 ; real_T P_36 ; real_T P_37 ; real_T P_38 ; real_T
P_39 [ 2 ] ; real_T P_40 ; real_T P_41 ; real_T P_42 ; real_T P_43 ; real_T
P_44 ; real_T P_45 ; real_T P_46 ; uint8_T P_47 ; uint8_T P_48 ; } ; struct
no5mhwqtfd { struct SimStruct_tag * _mdlRefSfcnS ; struct {
rtwCAPI_ModelMappingInfo mmi ; rtwCAPI_ModelMapLoggingInstanceInfo
mmiLogInstanceInfo ; void * dataAddress [ 11 ] ; int32_T * vardimsAddress [
11 ] ; RTWLoggingFcnPtr loggingPtrs [ 11 ] ; sysRanDType * systemRan [ 4 ] ;
int_T systemTid [ 4 ] ; } DataMapInfo ; struct { int_T mdlref_GlobalTID [ 2 ]
; } Timing ; } ; typedef struct { njaiiyxset rtb ; iam3v5hzqw rtdw ;
ljuhlwvmol rtm ; nuyrzrfxfu rtzce ; } bqxh50t43mf ; extern
struct_RUNG81GCIdjqCq3JUUdhDD rtP_uavParam ; extern
struct_TWgvIboATVv1oYnNFGaPcB rtP_ap ; extern void alcqqxvmwl ( SimStruct *
_mdlRefSfcnS , int_T mdlref_TID0 , int_T mdlref_TID1 , ljuhlwvmol * const
bjehncrpxl , njaiiyxset * localB , iam3v5hzqw * localDW , nuyrzrfxfu *
localZCE , void * sysRanPtr , int contextTid , rtwCAPI_ModelMappingInfo *
rt_ParentMMI , const char_T * rt_ChildPath , int_T rt_ChildMMIIdx , int_T
rt_CSTATEIdx ) ; extern void mr_Outer_Loop_Autopilot_MdlInfoRegFcn (
SimStruct * mdlRefSfcnS , char_T * modelName , int_T * retVal ) ; extern
mxArray * mr_Outer_Loop_Autopilot_GetDWork ( const bqxh50t43mf * mdlrefDW ) ;
extern void mr_Outer_Loop_Autopilot_SetDWork ( bqxh50t43mf * mdlrefDW , const
mxArray * ssDW ) ; extern void
mr_Outer_Loop_Autopilot_RegisterSimStateChecksum ( SimStruct * S ) ; extern
mxArray * mr_Outer_Loop_Autopilot_GetSimStateDisallowedBlocks ( ) ; extern
const rtwCAPI_ModelMappingStaticInfo * Outer_Loop_Autopilot_GetCAPIStaticMap
( void ) ; extern void brybnc1ypd ( iam3v5hzqw * localDW ) ; extern void
joal0r3a4b ( iam3v5hzqw * localDW ) ; extern void n0zwn4fij1 ( const real_T *
oylgqnx54q , njaiiyxset * localB , iam3v5hzqw * localDW ) ; extern void
n0zwn4fij1TID1 ( void ) ; extern void Outer_Loop_Autopilot ( const real_T
bnhvz3po55 [ 3 ] , const real_T * fogmat4wia , const real_T * gijqutldwv ,
const real_T * pxs0jby53b , const real_T * myhdcnwrlh , const real_T *
oylgqnx54q , real_T * hauut1f2aq , real_T * brosjbpf4m , real_T * llhebclkdo
, njaiiyxset * localB , iam3v5hzqw * localDW , nuyrzrfxfu * localZCE ) ;
extern void Outer_Loop_AutopilotTID1 ( void ) ; extern void hgfx4ibbkr (
ljuhlwvmol * const bjehncrpxl ) ;
#endif
