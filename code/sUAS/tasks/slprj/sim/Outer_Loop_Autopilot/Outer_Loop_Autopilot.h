#ifndef RTW_HEADER_Outer_Loop_Autopilot_h_
#define RTW_HEADER_Outer_Loop_Autopilot_h_
#include <string.h>
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#ifndef Outer_Loop_Autopilot_COMMON_INCLUDES_
#define Outer_Loop_Autopilot_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "simstruc.h"
#include "fixedpoint.h"
#endif
#include "Outer_Loop_Autopilot_types.h"
#include "multiword_types.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"
typedef struct { real_T f3vvsfbgw1 ; real_T kewmeqjqb0 ; real_T mcybxiknuu ;
real_T cevhpp2k4y ; real_T kycmot3w0g ; real_T av2zhzwzdn ; real_T gf1vegoz21
; real_T pn25duhtta ; real_T nvtjhmvvqv ; } njaiiyxset ; typedef struct {
real_T o5q03ofnhk ; real_T gqkv4njxec ; real_T hjciw5sh12 ; real_T fdiqtgksxq
; real_T jqzz2ajp5k ; real_T pfeb01dnf0 ; real_T epu3x52laf ; uint8_T
bsbmispgki ; int8_T c2kaxshh5u ; int8_T cre55s3b0t ; int8_T ovxojvo0sh ;
int8_T fkvndktom2 ; } iam3v5hzqw ; struct e1oexindosj_ { real_T P_2 ; real_T
P_3 ; real_T P_4 ; real_T P_5 ; real_T P_6 ; real_T P_7 ; real_T P_8 ; real_T
P_9 ; real_T P_10 ; real_T P_11 ; real_T P_12 ; real_T P_13 ; real_T P_14 ;
real_T P_15 ; real32_T P_16 ; real32_T P_17 ; real_T P_18 ; real_T P_19 ;
real_T P_20 ; real_T P_21 ; real_T P_22 ; real_T P_23 ; real_T P_24 ; real_T
P_25 ; real_T P_26 ; real_T P_27 ; real_T P_28 ; real_T P_29 ; real_T P_30 ;
real_T P_31 ; real_T P_32 ; real_T P_33 ; real_T P_34 ; real_T P_35 ; real_T
P_36 ; uint8_T P_37 ; uint8_T P_38 ; } ; struct no5mhwqtfd { struct
SimStruct_tag * _mdlRefSfcnS ; struct { rtwCAPI_ModelMappingInfo mmi ;
rtwCAPI_ModelMapLoggingInstanceInfo mmiLogInstanceInfo ; void * dataAddress [
8 ] ; int32_T * vardimsAddress [ 8 ] ; RTWLoggingFcnPtr loggingPtrs [ 8 ] ;
sysRanDType * systemRan [ 4 ] ; int_T systemTid [ 4 ] ; } DataMapInfo ;
struct { int_T mdlref_GlobalTID [ 2 ] ; } Timing ; } ; typedef struct {
njaiiyxset rtb ; iam3v5hzqw rtdw ; ljuhlwvmol rtm ; } bqxh50t43mf ; extern
struct_RUNG81GCIdjqCq3JUUdhDD rtP_uavParam ; extern
struct_TWgvIboATVv1oYnNFGaPcB rtP_ap ; extern void alcqqxvmwl ( SimStruct *
_mdlRefSfcnS , int_T mdlref_TID0 , int_T mdlref_TID1 , ljuhlwvmol * const
bjehncrpxl , njaiiyxset * localB , iam3v5hzqw * localDW , void * sysRanPtr ,
int contextTid , rtwCAPI_ModelMappingInfo * rt_ParentMMI , const char_T *
rt_ChildPath , int_T rt_ChildMMIIdx , int_T rt_CSTATEIdx ) ; extern void
mr_Outer_Loop_Autopilot_MdlInfoRegFcn ( SimStruct * mdlRefSfcnS , char_T *
modelName , int_T * retVal ) ; extern mxArray *
mr_Outer_Loop_Autopilot_GetDWork ( const bqxh50t43mf * mdlrefDW ) ; extern
void mr_Outer_Loop_Autopilot_SetDWork ( bqxh50t43mf * mdlrefDW , const
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
, njaiiyxset * localB , iam3v5hzqw * localDW ) ; extern void
Outer_Loop_AutopilotTID1 ( void ) ; extern void hgfx4ibbkr ( ljuhlwvmol *
const bjehncrpxl ) ;
#endif
