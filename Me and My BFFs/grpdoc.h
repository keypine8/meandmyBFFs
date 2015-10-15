/*            grpdoc.h         */
/*     include file for grpdoc.c       */
/* this is adapted from pp.h, which was adapted from fut.h */

#include <stdio.h>
#include <math.h>
/* #include "compdefs.h" */


/* int BENCHMARK_SCORES  [6] = { -1, 373, 213, 100, 42, 18 }; */
/* int BENCHMARK_SCORES  [6] = { -1, 90, 75, 50, 25, 10 }; */
/* int BENCHMARK_SCORES  [6] = {-1, 90, 75, 65, 55, 50,  1};  */
int BENCHMARK_SCORES  [6] = { -1, 373, 213, 100, 42, 18 };

/*            compdefs.h       */
/* this is adapted from pp_defines.h, which was adapted from fut_defines.h */

#define Yes 1
#define No 0
#define Found 1
#define Not_found 0

/* do as v (any lvalue) (can be ptr) goes from lo to hi inclusive */
#define RKDO(v,lo,hi) for((v)=(lo);(v)<=(hi);(v)++)
/* return 1 if v is between lo and hi inclusive, 0 otherwise */
/*
#define RKISBETWEEN(v,lo,hi) (((v)>=(lo)&&(v)<=(hi))?1:0)
*/

#define SIZE_INBUF 80
#define gFF '\014'  /* form feed - clear scr to background_attribute_char */
#define NUM_PLANETS 10 
#define SUN_IDX 0
#define VEN_IDX 4
#define MAR_IDX 5
#define JUP_IDX 6
#define PLU_IDX 10
#define NUM_ASPECTS 9
#define SIZE_PRTBUF 132
#define WRITE_MODE "wv"
#define READ_MODE "rv"
#define APPEND_MODE "av"
#define NUM_MINUTES_IN_CIRCLE 21600
#define NUM_SIGNS 12
/* #define FUT_GRH_PT_EVERY_X_RECS 1 */  /* from now on pmg assumes =1 */
    /* mk a grh pt for every 1 rec in futurepos file */
#define NUM_ASPECT_TYPES 1    /* cnj, fvr, unfvr */
#define NUM_HOUSES_CONSIDERED 2    /* now 2- lov,mon */
#define EPH_GRH_CHAR '*'    /* pt on graph char */
#define NAT_PLT_NUM_FOR_MOON 2
#define MOON_REPLACEMENT_FACTOR 1.15

#define NUM_INPUT_ITEMS 42  /* 39 from order form, + 3 helpers */
#define NUM_TIME_CONFIDENCE_LINES 4
#define ARGNUM_FOR_FUTIN_PATHNAME 1
#define ARGNUM_FOR_DOCIN_DIR 2

#define SIZE_QNX_FILENAME 16
#define FACTOR_FOR_6LPI 1  /* num of \n to be added to a line (after the */
              /* first \n) in order to get 6lpi spacing */
              /* e.g. at 12lpi FACTOR_FOR_6LPI = 1 */
#define NUM_LINES_DOC_FOOTER 4  /* m3+m4 in doc (for .ne nn) */
#define SIZE_DAY_TAB 13
#define NUM_ASPECTS_PER_NAT_TRN_PAIR 2
#define NUM_STRESS_LEVELS 8

#define NUM_PLUS_OR_MINUS_CATEGORIES 2
#define PLUS_OR_MINUS_IDX_FOR_GOOD 0
#define PLUS_OR_MINUS_IDX_FOR_BAD 1
#define NUM_PLT_PAIRS 55  /* 10+9+8+7+6+5+4+3+2+1 (includes sun-sun etc. */


#define TOT_CATEGORIES 2  /* for comp- love,business */
  /* NOTE: there are 4 more special graphs */
#define NUM_COMP_CATEGORIES 4

#define COMP_IDX_FOR_OVERALL 0
#define COMP_IDX_FOR_PERSONAL 1
#define COMP_IDX_FOR_A_PT_VIEW 2
#define COMP_IDX_FOR_B_PT_VIEW 3


#define OVERALL_NUMERATOR 1
#define OVERALL_DENOMINATOR 1
#define PERSONAL_NUMERATOR 8
#define PERSONAL_DENOMINATOR 3
#define A_PT_VIEW_NUMERATOR 8
#define A_PT_VIEW_DENOMINATOR 5
#define B_PT_VIEW_NUMERATOR 8
#define B_PT_VIEW_DENOMINATOR 5

#define GRH_DATA_IDX_FOR_LOVE 0
#define GRH_DATA_IDX_FOR_MONEY 1
#define IDX_FOR_A 0
#define IDX_FOR_B 1
#define QUADRANT_NW_FACTOR 3  /* all personal */
#define QUADRANT_NE_FACTOR 2
#define QUADRANT_SW_FACTOR 2
#define QUADRANT_SE_FACTOR 1  /* none personal */
#define BASE_CURRENT_ASPECT_FORCE 1.0  /*  1.0< force <2.0  */
#define SIZE_GRH_LINE 132
#define GRH_CHAR '*'
#define FREE_FLOATING_MULTIPLIER 2

/* #define MAX_STARS 100 */ /* in grh line */
#define MAX_STARS  78  /* in grh line */

#define ASPECT_TYPE_IDX_FOR_CNJ 0
#define ASPECT_TYPE_IDX_FOR_FVR 1
#define ASPECT_TYPE_IDX_FOR_UNFVR 2

//#define MAX_IN_ITEM_TBL 50
#define gMAX_IN_ITEM_TBL 50
//#define SIZE_ITEM 5
#define SIZE_ITEM 32          // EPANDED 20150518  aspect code | -15   for num plus,minus

#define NUM_PLT_FOR_PARAS 5
#define SIZE_ORDNUM 5

/* typedef char *_STRING; */

#define get_plt_in_12(i,k,m) (*(gPLT_IN_12+\
(i)*TOT_CATEGORIES*NUM_SIGNS+\
(k)*TOT_CATEGORIES+\
(m)))

/* ***** old
* #define get_aspect_multiplier(i,k,m,n) (*(gASPECT_MULTIPLIER+\
* (i)*NUM_HOUSES_CONSIDERED*NUM_PLANETS*NUM_PLANETS_IN_EPH_FILES+\
* (k)*NUM_HOUSES_CONSIDERED*NUM_PLANETS+\
* (m)*NUM_HOUSES_CONSIDERED+\
* (n)))
*
***** */

/* end of 5 speed defines *********/

/*** STRUCTURE TYPE DEFINITIONS ***/
/* none */

/* end of compdefs.h */



char Swk[512+1];  /* work string */

/* now in grpdoc.c
*/
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* the following four externs are defined in calc_chart.o */
* extern double arco[];  /* one of 2 tables returned from calc_chart */
*   /* `coordinates' are in following order: */
*   /* xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_ */
*   /* positions are in radians */
* extern char *retro[];     /* one of two tables returned from calc_chart */
*               /* plts in same order as above */
*               /* R if retrograde, _ if not */
* extern double fnu(), fnd();    /* these functions are in calc_chart.o */
* /* the above four externs are defined in calc_chart.o */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* rearranged retro tables (for printing) */
char * gPRT_RETRO_1[NUM_PLANETS+3+1] = {"_","_","_","_","_","_","_","_","_","_","_","_","_","_"};
char * gPRT_RETRO_2[NUM_PLANETS+3+1] = {"_","_","_","_","_","_","_","_","_","_","_","_","_","_"};
char gPOS_STR_1[(11+1)*(13+1)];  /* 11=numchar one str (magic numbers) */
char gPOS_STR_2[(11+1)*(13+1)];  /* 11=numchar one str (magic numbers) */
  /* e.g. sun_10vir44  13=numelement (sun->plu + nod,asc,mc) */
char gA_EVENT_NAME[30];
char gB_EVENT_NAME[30];

/* extern char *strcat(); */
/* extern double atof(),floor(),dpie(),sin(); */
/* extern unsigned get_ticks(); */

/* following are non-int returning functions */
extern double day_of_year();
extern char * get_grh_left_margin();
extern char * sfromto();
extern char * swholenum();
extern char * sdecnum();
extern char * scapwords();
extern char * sallcaps();
/* extern char * rkfgets(); */
extern char * strrchr();
extern char * rkstrrchr();
extern char * strchr();

char *N_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""}; /* see day_of_week() */
char * gN_PLANET[] =
    {"   ","sun","moo","mer","ven","mar","jup","sat","ura","nep","plu",
     "nod","asc","mc_"};
char * gN_TRN_PLANET[] =  /* i think this should be xmjsunp (mars 1st) */
    {"   ","jup","sat","ura","nep","plu","mar"};
char * gN_SIGN[] = {
"sgn","ari","tau","gem","can","leo","vir","lib","scp","sag","cap","aqu","pis"};
char * gN_ASPECT[] =
    {"   ","cnj","sxt","squ","tri","opp","tri","squ","sxt","cnj"};
char * gN_MTH[] = {
"mth","jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"};
char * gN_MTHc[] = {
"Mth","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
char * gN_LONG_MTH[] = {
    "month","January","February","March","April","May","June",
    "July","August","September","October","November","December"};
  /* following 3 are for doc set-up e.g. ^(mogsa) */
char * gN_GRH[] = {"","","","","","","","","","","",""};
char * gN_SHORT_NAT_PLT[] = {"x","su","mo","me","ve","ma"};
char * gN_SHORT_TRN_PLT[] = {"x","ju","sa","ur","ne","pl","ma"};
char * gN_SHORT_DOC_ASPECT[] = {"c","g","b"};  /* 0=cnj,1=good,2=bad */
/* numlines=11, sizeline=52 */
char * gTITLE_LINES[] = {
  "*** *** * * *** *** *** * *** * *   * *** * *       ",
  "*   * * *** * * * *  *  * * * * *   *  *  * *       ",
  "*   * * * * *** ***  *  * *** * *   *  *  ***       ",
  "*   * * * * *   * *  *  * * * * *   *  *   *        ",
  "*** *** * * *   * *  *  * *** * *** *  *   *        ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
};


/* the following is for K&R fns day_of_year() & month_day() */
double gDAY_TAB[2][13] = {
  {365.0,31.0,28.0,31.0,30.0,31.0,30.0,31.0,31.0,30.0,31.0,30.0,31.0},
  {366.0,31.0,29.0,31.0,30.0,31.0,30.0,31.0,31.0,30.0,31.0,30.0,31.0}
};
/* trn orbs all 2 degrees */
int gORBS_TRN[NUM_ASPECTS+1] = {0,120,120,120,120,120,120,120,120,120};
int gORBS_NAT[NUM_ASPECTS+1] = {0,360,240,360,360,360,360,360,240,360};
int gASPECT_ID[NUM_ASPECTS+1] =
             {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9};
        /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
      /* degrees  x  0  60   90   120   180   240   270   300  360 */
int gASPECT_TYPE[NUM_ASPECTS+1] =
            {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0};
 /* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */
int gASPECTS[NUM_ASPECTS+1]=
              {-1,  0,3600,5400,7200,10800,14400,16200,18000,21600};

/* see #define SIZE_GRH_LEFT_MARGIN in as_defines.h */
int gSTRESS_VAL[NUM_STRESS_LEVELS] = {304,250,196,142,88,34,-20,-74};

int ar_minutes_natal_1[NUM_PLANETS+1+3];  /* +1 for [0], +3 for nod,asc,mc */
int ar_minutes_natal_2[NUM_PLANETS+1+3];  /* +1 for [0], +3 for nod,asc,mc */
int gGRH_DATA[TOT_CATEGORIES][NUM_PLUS_OR_MINUS_CATEGORIES];
int gGRH_DATA_FOR_COMP[NUM_COMP_CATEGORIES][NUM_PLUS_OR_MINUS_CATEGORIES];
  /* 12*2 */
/******
* gGRH_DATA_FOR_COMP[X][Y] indexes  [X]        [Y]
*                                   0 overall    0 easy
*                                   1 personal   0 difficult
*                                   2 A pt of view
*                                   3 B pt of view
******/

extern FILE *fopen();
/* FILE *gFP_DOCIN_FILE; */
/* FILE *gFP_FUTIN_FILE; */
/* FILE *gFP_NAMEIN_FILE; */
/* FILE *gFP_OTHERIN_FILE; */
/* FILE *gFP_DATAOUT_FILE; */

int gHOUSE_CONFIDENCE[2],gMOON_CONFIDENCE[2];  /* 0=A,1=B */
double gCURRENT_ASPECT_FORCE;    /* 0.0 - 1.0 */
  /*       pi    orb_in_minutes - diff_from_exact     */
  /* sin( --  X  --------------------------------)     */
  /*      2      orb_in_minutes           */
  /* defined in is_aspect(), used in calc_fut_graph() */
double gMOON_CONFIDENCE_FACTOR;

/* bufs to hold future cmd args */

/* char gARG_FUTIN_PATHNAME[SIZE_INBUF+1];  * see as_defines.h for argnum defs *
* char gARG_DOCIN_DIR[SIZE_INBUF+1];
* 
* char gDOCIN_PATHNAME[SIZE_INBUF+1];
* char gDATAOUT_PATHNAME[SIZE_INBUF+1];
* char gINBUF[SIZE_INBUF+1];
*/

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* the following are output from mk_fut_input.c */
* char gMADD_LAST_NAME[SIZE_INBUF+1];
* char gMADD_FIRST_NAMES[SIZE_INBUF+1];
* char gMADD1[SIZE_INBUF+1];  /* mailing address line 1 */
* char gMADD2[SIZE_INBUF+1];  /* adress line 2 */
* char gCITY_TOWN[SIZE_INBUF+1];
* char gPROV_STATE[SIZE_INBUF+1];
* char gCOUNTRY[SIZE_INBUF+1];
* char gPOSTAL_CODE[SIZE_INBUF+1];
* char gLETTER_COMMENT_1[SIZE_INBUF+1];
* char gLETTER_COMMENT_2[SIZE_INBUF+1];
* char gIS_OK[SIZE_INBUF+1];
* char gFUTIN_FILENAME[SIZE_INBUF+1];
* char gORDNUM[SIZE_INBUF+1];
* char gDATE_OF_ORDER_ENTRY[SIZE_INBUF+1];
* char gLN_PRT[SIZE_INBUF+1];
* 
* int gNUM_PAST_UNITS_ORDERED,gPAST_START_MN,gPAST_START_DY,gPAST_START_YR;
* int gNUM_FUT_UNITS_ORDERED,gFUT_START_MN,gFUT_START_DY,gFUT_START_YR;
* char gDO_PP[SIZE_INBUF+1];  /* do a personality profile? y/n */
* char gCOMPATABILITY_LINE[SIZE_INBUF+1];  /* do a personality profile? y/n */
* char gCOMPAT_ID[SIZE_ORDNUM+1];
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

char gEVENT_NAME[SIZE_INBUF+1];

double gINMN,gINDY,gINYR,gINHR,gINMU,gINTZ,gINLN,gINLT;
int gINAP,gINCF;  /* cf= confidence in time of day */

double gPI_OVER_2;  


/* following are specific to pp.c */
char yninbuf[SIZE_INBUF];  /* for y/n answer (different from inbuf) */
/* Positions are in the following */
/* order:  xxx,sun,moo,mer,ven,mar,jup,sat,ura,nep,plu  */
int gAR_SGN_1[NUM_PLANETS+1];
int gAR_HSE_1[NUM_PLANETS+1];
int gAR_SGN_2[NUM_PLANETS+1];
int gAR_HSE_2[NUM_PLANETS+1];
int gAR_ASP[NUM_PLANETS+1][NUM_PLANETS+1];

int gEXPRESSION_1_25[NUM_PLANETS+1][NUM_PLANETS+1]; // -25 -> +25 (nozero) num minuses or pluses below each aspect para (negative=red, positive-green)
//<.>

int gPLT_HAS_ASP_TBL[NUM_PLANETS+1];  /* for free-floating control */
int gCONSIDER_HOUSE_FACTOR[TOT_CATEGORIES] = 
    {1,1};
/* special grhs- no hse works best */  /* 09oct85 used to be =0 */

/* item tbl stuff follows: */
char gITEM_TBL[gMAX_IN_ITEM_TBL*(SIZE_ITEM+1)];
char *gP_ITEM_TBL[gMAX_IN_ITEM_TBL];  /* ptrs to elements in above tbl */
int gITEM_TBL_IDX;  /* is idx to tbl (not counter of elements) */
/********
  an item is 5 char
    sign placement   aa1ss
    house placement  aa2hh
    aspect           aaXbb
  where  aa  is a natal planet
      ss  is a sign
      hh  is a house
      bb  is a 2nd natal planet
  codes are:
      1  for sign placement
      2  for house placement
      X  for aspects
        c cnj
        g good aspects
        b bad aspects
********/

/* testing args below */
int gSGN_OVER_HSE_FACTOR;  /* sgn 2x more weight than hse */
int gGRAPH_FACTOR;         /* 15 pts in ggrh_data for 1 star */
int gPLACEMENT_MULTIPLIER; /* 12 */
int gSUBTRACT_FROM_GOOD;   /* 33 */
int gLESSON_MULTIPLIER;    /* 3 (one third) */ 


/* copied comptabs.h in here (grpdoc.h)
*/

/*  comptabs.h  
  an include file for comp.c

  int gPLT_IN_12[NUM_PLANETS]
         [NUM_SIGNS]
         [TOT_CATEGORIES] = {
  10 x 12 x 12 = 1440 ints, 2880 bytes
*/

int gPLT_IN_12[NUM_PLANETS*NUM_SIGNS*TOT_CATEGORIES] = {

/*******
  1 love
  2 business
*******/
/* ***sun */
/* ari */ 1,1,
/* tau */ 7,8,
/* gem */ 1,1,
/* can */ 6,3,
/* leo */ 5,5,
/* vir */ 1,3,
/* lib */ 6,1,
/* scp */ 8,6,
/* sag */ 1,1,
/* cap */ 1,8,
/* aqu */ 1,1,
/* pis */ 6,1,

/* ***moo */
/* ari */ 1,1,
/* tau */ 8,6,
/* gem */ 1,1,
/* can */ 6,1,
/* leo */ 2,1,
/* vir */ 1,1,
/* lib */ 4,1,
/* scp */ 4,1,
/* sag */ 1,1,
/* cap */ 1,7,
/* aqu */ 1,1,
/* pis */ 5,1,

/* ***mer */
/* ari */ 1,2,
/* tau */ 1,4,
/* gem */ 1,5,
/* can */ 2,1,
/* leo */ 1,3,
/* vir */ 1,7,
/* lib */ 4,1,
/* scp */ 3,2,
/* sag */ 1,1,
/* cap */ 1,8,
/* aqu */ 1,1,
/* pis */ 2,1,

/* ***ven */
/* ari */ 1,1,
/* tau */ 8,4,
/* gem */ 2,1,
/* can */ 2,1,
/* leo */ 4,2,
/* vir */ 1,1,
/* lib */ 8,1,
/* scp */ 6,2,
/* sag */ 1,1,
/* cap */ 1,3,
/* aqu */ 1,1,
/* pis */ 6,1,

/* ***mar */
/* ari */ 1,3,
/* tau */ 1,2,
/* gem */ 1,1,
/* can */ 2,1,
/* leo */ 1,4,
/* vir */ 1,1,
/* lib */ 3,1,
/* scp */ 7,5,
/* sag */ 1,1,
/* cap */ 1,8,
/* aqu */ 1,1,
/* pis */ 3,1,

/* ***jup */
/* ari */ 1,2,
/* tau */ 2,4,
/* gem */ 1,1,
/* can */ 3,1,
/* leo */ 2,3,
/* vir */ 1,1,
/* lib */ 5,1,
/* scp */ 4,6,
/* sag */ 1,1,
/* cap */ 1,6,
/* aqu */ 1,1,
/* pis */ 6,1,

/* ***sat */
/* ari */ 1,3,
/* tau */ 2,6,
/* gem */ 1,2,
/* can */ 2,1,
/* leo */ 1,2,
/* vir */ 1,3,
/* lib */ 4,1,
/* scp */ 2,2,
/* sag */ 1,1,
/* cap */ 1,8,
/* aqu */ 1,1,
/* pis */ 4,1,

/* ***ura */
/* ari */ 1,1,
/* tau */ 2,4,
/* gem */ 1,2,
/* can */ 2,1,
/* leo */ 1,1,
/* vir */ 1,1,
/* lib */ 3,1,
/* scp */ 7,1,
/* sag */ 1,1,
/* cap */ 1,3,
/* aqu */ 1,1,
/* pis */ 3,1,

/* ***nep */
/* ari */ 1,1,
/* tau */ 2,2,
/* gem */ 1,1,
/* can */ 1,1,
/* leo */ 1,1,
/* vir */ 1,1,
/* lib */ 2,1,
/* scp */ 1,1,
/* sag */ 1,1,
/* cap */ 1,2,
/* aqu */ 1,1,
/* pis */ 2,1,

/* ***plu */
/* ari */ 1,1,
/* tau */ 1,3,
/* gem */ 1,1,
/* can */ 1,1,
/* leo */ 1,1,
/* vir */ 1,1,
/* lib */ 1,1,
/* scp */ 8,4,
/* sag */ 1,1,
/* cap */ 1,3,
/* aqu */ 1,1,
/* pis */ 2,1,
};  /* end of gplt_in_12 */

/*  int aspect_multiplier[NUM_ASPECT_TYPES]        */
/*             [NUM_PLT_PAIRS]    */
/*             [TOT_CATEGORIES]  = {  */
/* 3 x 35 x 12 = 1260 ints, 2520 bytes */

int gASPECT_MULTIPLIER  [NUM_ASPECT_TYPES*
             NUM_PLT_PAIRS*
             TOT_CATEGORIES] = {

/* CNJ******** */
/* sun-sun */ 1,1,
/* sun-moo */ 2,1,
/* sun-mer */ 1,1,
/* sun-ven */ 8,1,
/* sun-mar */ 1,4,
/* sun-jup */ 1,1,
/* sun-sat */ 1,6,
/* sun-ura */ 1,1,
/* sun-nep */ 1,1,
/* sun-plu */ 3,1,

/* moo-moo */ 5,1,
/* moo-mer */ 1,1,
/* moo-ven */ 3,1,
/* moo-mar */ 1,1,
/* moo-jup */ 1,1,
/* moo-sat */ 1,4,
/* moo-ura */ 1,1,
/* moo-nep */ 2,1,
/* moo-plu */ 2,1,

/* mer-mer */ 1,3,
/* mer-ven */ 3,1,
/* mer-mar */ 1,3,
/* mer-jup */ 1,1,
/* mer-sat */ 1,5,
/* mer-ura */ 1,1,
/* mer-nep */ 1,1,
/* mer-plu */ 1,1,

/* ven-ven */ 8,2,
/* ven-mar */ 8,1,
/* ven-jup */ 6,1,
/* ven-sat */ 7,2,
/* ven-ura */ 7,1,
/* ven-nep */ 4,1,
/* ven-plu */ 8,2,

/* mar-mar */ 1,3,
/* mar-jup */ 1,1,
/* mar-sat */ 1,4,
/* mar-ura */ 1,1,
/* mar-nep */ 2,1,
/* mar-plu */ 4,1,

/* jup-jup */ 1,1,
/* jup-sat */ 1,6,
/* jup-ura */ 1,1,
/* jup-nep */ 1,1,
/* jup-plu */ 3,1,

/* sat-sat */ 3,8,
/* sat-ura */ 1,4,
/* sat-nep */ 1,1,
/* sat-plu */ 3,6,

/* ura-ura */ 1,1,
/* ura-nep */ 1,1,
/* ura-plu */ 2,1,

/* nep-nep */ 1,1,
/* nep-plu */ 1,1,

/* plu-plu */ 1,1,
};  /* end of gASPECT_MULTIPLIER  */

int gPLT_PAIRS_IDX_TBL[NUM_PLANETS][NUM_PLANETS] = {
/*         plt2   */
/*            sun  moo  mer  ven  mar  jup  sat  ura  nep  plu     */
/* plt1sun */ {0,   1,   2,   3,   4,   5,   6,   7,   8,   9},
/*     moo */ {0,  10,  11,  12,  13,  14,  15,  16,  17,  18},
/*     mer */ {0,   0,  19,  20,  21,  22,  23,  24,  25,  26},
/*     ven */ {0,   0,   0,  27,  28,  29,  30,  31,  32,  33},
/*     mar */ {0,   0,   0,   0,  34,  35,  36,  37,  38,  39},
/*     jup */ {0,   0,   0,   0,   0,  40,  41,  42,  43,  44},
/*     sat */ {0,   0,   0,   0,   0,   0,  45,  46,  47,  48},
/*     ura */ {0,   0,   0,   0,   0,   0,   0,  49,  50,  51},
/*     nep */ {0,   0,   0,   0,   0,   0,   0,   0,  52,  53},
/*     plu */ {0,   0,   0,   0,   0,   0,   0,   0,   0,  54}
};
/*   e.g.   moo_asp_jup is #13,    mar_asp_ura is #33 */

int gNEG_CNJ_TBL[NUM_PLANETS][NUM_PLANETS] = {
/*         plt2   */
/*         sun  moo  mer  ven  mar  jup  sat  ura  nep  plu     */
/* plt1sun */{1,  1,  1,    1,  1,    1,  -1,  -1,  -1,  -1},
/*     moo */{0,  1,  1,    1,  1,    1,  -1,  -1,  -1,  -1},
/*     mer */{0,  0,  1,    1,  1,    1,  -1,  -1,  -1,  -1},
/*     ven */{0,  0,  0,    1,  1,    1,  -1,  -1,  -1,  -1},
/*     mar */{0,  0,  0,    0,  1,    1,  -1,  -1,  -1,  -1},
/*     jup */{0,  0,  0,    0,  0,    1,   1,   1,   1,   1},
/*     sat */{0,  0,  0,    0,  0,    0,   1,  -1,  -1,  -1},
/*     ura */{0,  0,  0,    0,  0,    0,   0,   1,  -1,  -1},
/*     nep */{0,  0,  0,    0,  0,    0,   0,   0,   1,  -1},
/*     plu */{0,  0,  0,    0,  0,    0,   0,   0,   0,   1}
};

/* end of comptabs.h */


/* end of grpdoc.h */
