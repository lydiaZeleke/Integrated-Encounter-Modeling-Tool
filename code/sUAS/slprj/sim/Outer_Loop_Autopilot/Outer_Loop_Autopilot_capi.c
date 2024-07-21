#include <stddef.h>
#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "Outer_Loop_Autopilot_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)
#else
#include "builtin_typeid_types.h"
#include "Outer_Loop_Autopilot.h"
#include "Outer_Loop_Autopilot_capi.h"
#include "Outer_Loop_Autopilot_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               ((NULL))
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) ,
0 , 0 , 0 , 0 , 0 } } ; static rtwCAPI_States rtBlockStates [ ] = { { 0 , - 1
, TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Discrete\nTransfer Fcn"
) , TARGET_STRING ( "states" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 1
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Rate Limiter\nDynamic with\nExternal IC and\nAutoreset for Change\nin IC/Delay"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 2
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Rate Limiter\nDynamic with\nExternal IC and\nAutoreset for Change\nin IC/Subsystem/Unit Delay"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 3
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Rate Limiter\nDynamic with\nExternal IC and\nAutoreset for Change\nin IC/Unit Delay\nResettable\nExternal IC/FixPt\nUnit Delay1"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 4
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Rate Limiter\nDynamic with\nExternal IC and\nAutoreset for Change\nin IC/Unit Delay\nResettable\nExternal IC/FixPt\nUnit Delay2"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 1 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 5
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Airspeed Controller/PID Controller/Filter/Disc. Forward Euler Filter/Filter"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 6
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Airspeed Controller/PID Controller/Integrator/Discrete/Integrator"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 7
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/PID Controller1/Filter/Differentiator/UD"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 8
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/PID Controller1/Integrator/Discrete/Integrator"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 9
, - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Altitude Controller/PID Controller1/Filter/Disc. Forward Euler Filter/Filter"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , {
10 , - 1 , TARGET_STRING (
 "Outer_Loop_Autopilot/Outer loop Autopilot/Altitude Controller/Altitude Controller/PID Controller1/Integrator/Discrete/Integrator"
) , TARGET_STRING ( "DSTATE" ) , "" , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } , { 0
, - 1 , ( NULL ) , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } }
; static int_T rt_LoggedStateIdxList [ ] = { 7 , 2 , 3 , 4 , 10 , 0 , 1 , 8 ,
9 , 5 , 6 } ;
#ifndef HOST_CAPI_BUILD
static void Outer_Loop_Autopilot_InitializeDataAddr ( void * dataAddr [ ] ,
iam3v5hzqw * localDW ) { dataAddr [ 0 ] = ( void * ) ( & localDW ->
ntia1rnz0t ) ; dataAddr [ 1 ] = ( void * ) ( & localDW -> hjciw5sh12 ) ;
dataAddr [ 2 ] = ( void * ) ( & localDW -> fdiqtgksxq ) ; dataAddr [ 3 ] = (
void * ) ( & localDW -> jqzz2ajp5k ) ; dataAddr [ 4 ] = ( void * ) ( &
localDW -> bsbmispgki ) ; dataAddr [ 5 ] = ( void * ) ( & localDW ->
o5q03ofnhk ) ; dataAddr [ 6 ] = ( void * ) ( & localDW -> gqkv4njxec ) ;
dataAddr [ 7 ] = ( void * ) ( & localDW -> plquzxxiyl ) ; dataAddr [ 8 ] = (
void * ) ( & localDW -> pfeb01dnf0 ) ; dataAddr [ 9 ] = ( void * ) ( &
localDW -> bz23ri30n0 ) ; dataAddr [ 10 ] = ( void * ) ( & localDW ->
m5d2mcswp1 ) ; }
#endif
#ifndef HOST_CAPI_BUILD
static void Outer_Loop_Autopilot_InitializeVarDimsAddr ( int32_T *
vardimsAddr [ ] ) { vardimsAddr [ 0 ] = ( NULL ) ; }
#endif
#ifndef HOST_CAPI_BUILD
static void Outer_Loop_Autopilot_InitializeLoggingFunctions (
RTWLoggingFcnPtr loggingPtrs [ ] ) { loggingPtrs [ 0 ] = ( NULL ) ;
loggingPtrs [ 1 ] = ( NULL ) ; loggingPtrs [ 2 ] = ( NULL ) ; loggingPtrs [ 3
] = ( NULL ) ; loggingPtrs [ 4 ] = ( NULL ) ; loggingPtrs [ 5 ] = ( NULL ) ;
loggingPtrs [ 6 ] = ( NULL ) ; loggingPtrs [ 7 ] = ( NULL ) ; loggingPtrs [ 8
] = ( NULL ) ; loggingPtrs [ 9 ] = ( NULL ) ; loggingPtrs [ 10 ] = ( NULL ) ;
}
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , ( uint8_T ) SS_DOUBLE , 0 , 0 , 0 } ,
{ "unsigned char" , "uint8_T" , 0 , 0 , sizeof ( uint8_T ) , ( uint8_T )
SS_UINT8 , 0 , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } } ; static uint_T rtDimensionArray [ ] = { 1 , 1
} ; static const real_T rtcapiStoredFloats [ ] = { 0.01 , 0.0 } ; static
rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) ,
rtwCAPI_FIX_RESERVED , 0 , 0 , ( boolean_T ) 0 } , } ; static
rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 1 ] , (
int8_T ) 0 , ( uint8_T ) 0 } } ; static int_T rtContextSystems [ 4 ] ; static
rtwCAPI_LoggingMetaInfo loggingMetaInfo [ ] = { { 0 , 0 , "" , 0 } } ; static
rtwCAPI_ModelMapLoggingStaticInfo mmiStaticInfoLogging = { 4 ,
rtContextSystems , loggingMetaInfo , 0 , ( NULL ) , { 0 , ( NULL ) , ( NULL )
} , 0 , ( NULL ) } ; static rtwCAPI_ModelMappingStaticInfo mmiStatic = { {
rtBlockSignals , 0 , ( NULL ) , 0 , ( NULL ) , 0 } , { ( NULL ) , 0 , ( NULL
) , 0 } , { rtBlockStates , 11 } , { rtDataTypeMap , rtDimensionMap ,
rtFixPtMap , rtElementMap , rtSampleTimeMap , rtDimensionArray } , "float" ,
{ 596770617U , 2369909808U , 2503356311U , 3706002120U } , &
mmiStaticInfoLogging , 0 , ( boolean_T ) 0 , rt_LoggedStateIdxList } ; const
rtwCAPI_ModelMappingStaticInfo * Outer_Loop_Autopilot_GetCAPIStaticMap ( void
) { return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
static void Outer_Loop_Autopilot_InitializeSystemRan ( ljuhlwvmol * const
bjehncrpxl , sysRanDType * systemRan [ ] , iam3v5hzqw * localDW , int_T
systemTid [ ] , void * rootSysRanPtr , int rootTid ) { UNUSED_PARAMETER (
bjehncrpxl ) ; UNUSED_PARAMETER ( localDW ) ; systemRan [ 0 ] = ( sysRanDType
* ) rootSysRanPtr ; systemRan [ 1 ] = ( NULL ) ; systemRan [ 2 ] = ( NULL ) ;
systemRan [ 3 ] = ( NULL ) ; systemTid [ 1 ] = bjehncrpxl -> Timing .
mdlref_GlobalTID [ 0 ] ; systemTid [ 2 ] = bjehncrpxl -> Timing .
mdlref_GlobalTID [ 0 ] ; systemTid [ 3 ] = bjehncrpxl -> Timing .
mdlref_GlobalTID [ 0 ] ; systemTid [ 0 ] = rootTid ; rtContextSystems [ 0 ] =
0 ; rtContextSystems [ 1 ] = 0 ; rtContextSystems [ 2 ] = 0 ;
rtContextSystems [ 3 ] = 0 ; }
#endif
#ifndef HOST_CAPI_BUILD
void Outer_Loop_Autopilot_InitializeDataMapInfo ( ljuhlwvmol * const
bjehncrpxl , iam3v5hzqw * localDW , void * sysRanPtr , int contextTid ) {
rtwCAPI_SetVersion ( bjehncrpxl -> DataMapInfo . mmi , 1 ) ;
rtwCAPI_SetStaticMap ( bjehncrpxl -> DataMapInfo . mmi , & mmiStatic ) ;
rtwCAPI_SetLoggingStaticMap ( bjehncrpxl -> DataMapInfo . mmi , &
mmiStaticInfoLogging ) ; Outer_Loop_Autopilot_InitializeDataAddr ( bjehncrpxl
-> DataMapInfo . dataAddress , localDW ) ; rtwCAPI_SetDataAddressMap (
bjehncrpxl -> DataMapInfo . mmi , bjehncrpxl -> DataMapInfo . dataAddress ) ;
Outer_Loop_Autopilot_InitializeVarDimsAddr ( bjehncrpxl -> DataMapInfo .
vardimsAddress ) ; rtwCAPI_SetVarDimsAddressMap ( bjehncrpxl -> DataMapInfo .
mmi , bjehncrpxl -> DataMapInfo . vardimsAddress ) ; rtwCAPI_SetPath (
bjehncrpxl -> DataMapInfo . mmi , ( NULL ) ) ; rtwCAPI_SetFullPath (
bjehncrpxl -> DataMapInfo . mmi , ( NULL ) ) ;
Outer_Loop_Autopilot_InitializeLoggingFunctions ( bjehncrpxl -> DataMapInfo .
loggingPtrs ) ; rtwCAPI_SetLoggingPtrs ( bjehncrpxl -> DataMapInfo . mmi ,
bjehncrpxl -> DataMapInfo . loggingPtrs ) ; rtwCAPI_SetInstanceLoggingInfo (
bjehncrpxl -> DataMapInfo . mmi , & bjehncrpxl -> DataMapInfo .
mmiLogInstanceInfo ) ; rtwCAPI_SetChildMMIArray ( bjehncrpxl -> DataMapInfo .
mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArrayLen ( bjehncrpxl -> DataMapInfo .
mmi , 0 ) ; Outer_Loop_Autopilot_InitializeSystemRan ( bjehncrpxl ,
bjehncrpxl -> DataMapInfo . systemRan , localDW , bjehncrpxl -> DataMapInfo .
systemTid , sysRanPtr , contextTid ) ; rtwCAPI_SetSystemRan ( bjehncrpxl ->
DataMapInfo . mmi , bjehncrpxl -> DataMapInfo . systemRan ) ;
rtwCAPI_SetSystemTid ( bjehncrpxl -> DataMapInfo . mmi , bjehncrpxl ->
DataMapInfo . systemTid ) ; rtwCAPI_SetGlobalTIDMap ( bjehncrpxl ->
DataMapInfo . mmi , & bjehncrpxl -> Timing . mdlref_GlobalTID [ 0 ] ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void Outer_Loop_Autopilot_host_InitializeDataMapInfo (
Outer_Loop_Autopilot_host_DataMapInfo_T * dataMap , const char * path ) {
rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ; rtwCAPI_SetStaticMap ( dataMap ->
mmi , & mmiStatic ) ; rtwCAPI_SetDataAddressMap ( dataMap -> mmi , ( NULL ) )
; rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetPath ( dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap ->
mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
