#ifndef RTW_HEADER_Outer_Loop_Autopilot_types_h_
#define RTW_HEADER_Outer_Loop_Autopilot_types_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#ifndef DEFINED_TYPEDEF_FOR_struct_RMiM9tyE6JXjOq0yW48iOB_
#define DEFINED_TYPEDEF_FOR_struct_RMiM9tyE6JXjOq0yW48iOB_
typedef struct { real_T lapseRate ; } struct_RMiM9tyE6JXjOq0yW48iOB ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_ZjT0A34wYizmJyD5SbbPIC_
#define DEFINED_TYPEDEF_FOR_struct_ZjT0A34wYizmJyD5SbbPIC_
typedef struct { real_T zCutoff ; real_T xCutoff ; real_T yCutoff ; real_T
baroCutoff ; real_T accBiasRateLimit ; real_T vzCutoff ; }
struct_ZjT0A34wYizmJyD5SbbPIC ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_nqXLvpxiCuV9VWan6ELtQF_
#define DEFINED_TYPEDEF_FOR_struct_nqXLvpxiCuV9VWan6ELtQF_
typedef struct { real32_T maxEta ; real32_T maxAcc ; real32_T maxDwnPthStar ;
real32_T tanIntercept ; real32_T IPStar ; real32_T tstar ; real32_T
turnLeadTime ; uint8_T sl_padding0 [ 4 ] ; } struct_nqXLvpxiCuV9VWan6ELtQF ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_wMU3Z0UnuhwPdkcASOisf_
#define DEFINED_TYPEDEF_FOR_struct_wMU3Z0UnuhwPdkcASOisf_
typedef struct { real_T derivativesConstant ; real32_T dtLimit ; real32_T
deLimit ; real32_T the_cLimit ; real32_T daLimit ; real32_T drLimit ;
real32_T phi_cLimit ; } struct_wMU3Z0UnuhwPdkcASOisf ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_TWgvIboATVv1oYnNFGaPcB_
#define DEFINED_TYPEDEF_FOR_struct_TWgvIboATVv1oYnNFGaPcB_
typedef struct { real_T apSampleTime ; struct_RMiM9tyE6JXjOq0yW48iOB baro ;
struct_ZjT0A34wYizmJyD5SbbPIC cf ; struct_nqXLvpxiCuV9VWan6ELtQF guidance ;
struct_wMU3Z0UnuhwPdkcASOisf control ; } struct_TWgvIboATVv1oYnNFGaPcB ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_WviXPLxdKq6zu4cY2Dzal_
#define DEFINED_TYPEDEF_FOR_struct_WviXPLxdKq6zu4cY2Dzal_
typedef struct { real_T span ; real_T chord ; real_T S ; real_T elarm ;
real_T mass ; } struct_WviXPLxdKq6zu4cY2Dzal ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_4DpoEKxWTGrPnnQ0H36a0F_
#define DEFINED_TYPEDEF_FOR_struct_4DpoEKxWTGrPnnQ0H36a0F_
typedef struct { real_T Ixx ; real_T Iyy ; real_T Izz ; }
struct_4DpoEKxWTGrPnnQ0H36a0F ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_IVdt2OZSKf0hs7PThOqQKB_
#define DEFINED_TYPEDEF_FOR_struct_IVdt2OZSKf0hs7PThOqQKB_
typedef struct { real_T CL0 ; real_T CLa ; real_T CLa_dot ; real_T CLq ;
real_T CLDe ; real_T CLDf ; real_T CD0 ; real_T A1 ; real_T Apolar ; real_T
CYb ; real_T CYDr ; real_T Clb ; real_T Clp ; real_T Clr ; real_T ClDa ;
real_T ClDr ; real_T Cm0 ; real_T Cma ; real_T Cma_dot ; real_T Cmq ; real_T
CmDe ; real_T CmDf ; real_T Cnb ; real_T Cnp ; real_T Cnr ; real_T CnDa ;
real_T CnDr ; } struct_IVdt2OZSKf0hs7PThOqQKB ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_KipJoflCB6JCEUAdQsRLpC_
#define DEFINED_TYPEDEF_FOR_struct_KipJoflCB6JCEUAdQsRLpC_
typedef struct { real_T MinThK ; real_T ThK ; real_T TFact ; }
struct_KipJoflCB6JCEUAdQsRLpC ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_3PJJ4WLMHK1TvFiEKQocoD_
#define DEFINED_TYPEDEF_FOR_struct_3PJJ4WLMHK1TvFiEKQocoD_
typedef struct { real_T Pos_0 [ 3 ] ; real_T Euler_0 [ 3 ] ; real_T Omega_0 [
3 ] ; real_T PQR_0 [ 3 ] ; real_T Vb_0 [ 3 ] ; real_T gsLL [ 2 ] ; real_T gsH
; } struct_3PJJ4WLMHK1TvFiEKQocoD ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_RUNG81GCIdjqCq3JUUdhDD_
#define DEFINED_TYPEDEF_FOR_struct_RUNG81GCIdjqCq3JUUdhDD_
typedef struct { struct_WviXPLxdKq6zu4cY2Dzal geometry ;
struct_4DpoEKxWTGrPnnQ0H36a0F inertia ; struct_IVdt2OZSKf0hs7PThOqQKB aero ;
struct_KipJoflCB6JCEUAdQsRLpC engine ; struct_3PJJ4WLMHK1TvFiEKQocoD ic ;
real_T sampleTime ; } struct_RUNG81GCIdjqCq3JUUdhDD ;
#endif
typedef struct e1oexindosj_ e1oexindosj ; typedef struct no5mhwqtfd
ljuhlwvmol ;
#endif
