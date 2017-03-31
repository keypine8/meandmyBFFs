/*         perdoc.h         */
/*     include file for perdoc.c       */

// MIT License
//
// Copyright (c) 2017 softwaredev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#include <stdio.h>
#include <math.h>


/* #include "pp_defs.h"
*/
/*         pp_defs.h       */

/* do as v (any lvalue- can be ptr) goes from lo to hi inclusive */
#define RKDO(v,lo,hi) for((v)=(lo);(v)<=(hi);(v)++)
/* return 1 if v is between lo and hi inclusive, 1 otherwise */
/*
#define RKISBETWEEN(v,lo,hi) (((v)>=(lo)&&(v)<=(hi))?1:0)
*/



char swk[512+1];  /* WORK STRING */
/* char Swk[SIZE_PRTBUF+1];*/
char Swk[512+1];

#define SIZE_INBUF 80
#define NUM_PLANETS 10 
#define NUM_ASPECTS 9
#define SIZE_PRTBUF 132
#define F1_FILE "futurepos"
#define WRITE_MODE "wv"
#define READ_MODE "rv"
#define APPEND_MODE "av"
#define NUM_MINUTES_IN_CIRCLE 21600
#define NUM_SIGNS 12
/* #define FUT_GRH_PT_EVERY_X_RECS 1 */  /* from now on pmg assumes =1 */
    /* mk a grh pt for every 1 rec in futurepos file */
#define NUM_ASPECT_TYPES 1    /*  NOTE for per it is *1*     cnj, fvr, unfvr */
#define NUM_HOUSES_CONSIDERED 2    /* 2,4,5,7,10 *//* now 2- mon,lov */
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
#define NUM_PLT_PAIRS 45  /* 9+8+7+6+5+4+3+2+1 */
#define TOT_CATEGORIES 19  /* num_signs + num_extra_categories */
#define IDX_FOR_AGGRESSIVE 12
#define IDX_FOR_SENSITIVE 13
#define IDX_FOR_DOWN_TO_EARTH 14
#define IDX_FOR_RESTLESS 15
#define IDX_FOR_SEX_DRIVE 16
#define IDX_FOR_BIG_MOUTH 17
#define IDX_FOR_UPS_AND_DOWNS 18
#define IDX_FOR_UPS_AND_DOWNS_2 93
#define BASE_CURRENT_ASPECT_FORCE 1.0  /*  1.0< force <2.0  */
#define SIZE_GRH_LINE 132
#define GRH_CHAR '*'

#define FREE_FLOATING_MULTIPLIER 4
/* #define FREE_FLOATING_MULTIPLIER 6 */

#define BEST_MULTIPLIER 2
/* #define MAX_STARS 100  * in grh line * */
#define MAX_STARS  82  /* in grh line */
#define ASPECT_TYPE_IDX_FOR_CNJ 0
#define ASPECT_TYPE_IDX_FOR_FVR 1
#define ASPECT_TYPE_IDX_FOR_UNFVR 2
#define SIZE_ITEM 5
#define MAX_IN_ITEM_TBL 50
#define NUM_PLT_FOR_PARAS 5


#define get_plt_in_12(i,k,m) (*(pPLT_IN_12+\
(i)*TOT_CATEGORIES*NUM_SIGNS+\
(k)*TOT_CATEGORIES+\
(m)))

/* ***** old
* #define get_aspect_multiplier(i,k,m,n) (*(pASPECT_MULTIPLIER+\
* (i)*NUM_HOUSES_CONSIDERED*NUM_PLANETS*NUM_PLANETS_IN_EPH_FILES+\
* (k)*NUM_HOUSES_CONSIDERED*NUM_PLANETS+\
* (m)*NUM_HOUSES_CONSIDERED+\
* (n)))
*
***** */

/*** STRUCTURE TYPE DEFINITIONS ***/
/* none */

/* end of pp_defs.h */



/* now in perdoc.c
*/
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* the following four externs are defined in calc_chart.o */
* extern double Arco[];  /* one of 2 tables returned from calc_chart */
*   /* `coordinates' are in following order: */
*   /* xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_ */
*   /* positions are in radians */
* extern char *Retro[];     /* one of two tables returned from calc_chart */
*               /* plts in same order as above */
*               /* R if retrograde, p if not */
* extern double fnu();    /* these functions are in calc_chart.o */
* extern double fnd();    /* these functions are in calc_chart.o */
* /* the above four externs are defined in calc_chart.o */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


char * pPRT_RETRO[NUM_PLANETS+3+1];  /* rearranged table */

/* extern char *strcat(); */
/* extern double atof(),floor(),dpie(),sin(); */
/* extern unsigned get_ticks(); */
/*  */
/* following are non-int returning functions */
/* extern double day_of_year(); */
/* extern char * get_grh_left_margin(); */
/* extern char * sfromto(); */
/* extern char * swholenum(); */
/* extern char * sdecnum(); */
/* extern char * scapwords(); */
/* extern char * sallcaps(); */
/* extern char * rkfgets(); */

char * pN_PLANET[] =
    {"   ","sun","moo","mer","ven","mar","jup","sat","ura","nep","plu",
     "nod","asc","mc_"};
char * pN_TRN_PLANET[] =  /* i think this should be xmjsunp (mars 1st) */
    {"   ","jup","sat","ura","nep","plu","mar"};
char * pN_SIGN[] = {
"sgn","ari","tau","gem","can","leo","vir","lib","scp","sag","cap","aqu","pis"};
char * pN_ASPECT[] =
    {"   ","cnj","sxt","squ","tri","opp","tri","squ","sxt","cnj"};
char * pN_MTH[] = {
"mth","jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"};
char * pN_LONG_MTH[] = {
    "month","January","February","March","April","May","June",
    "July","August","September","October","November","December"};
char * pN_GRH[] = {
    "signzero","Aries","Taurus","Gemini","Cancer","Leo","Virgo",
    "Libra","Scorpio","Sagittarius","Capricorn","Aquarius","Pisces",
    "","","","","","",""};
  /* following 3 are for doc set-up e.g. ^(mogsa) */
char * pN_SHORT_NAT_PLT[] = {"x","su","mo","me","ve","ma"};
/* <.> */
char * pN_SHORT_TRN_PLT[] = {"x","ju","sa","ur","ne","pl","ma"};
char * pN_SHORT_DOC_ASPECT[] = {"c","g","b"};  /* 0=cnj,1=good,2=bad */
/* numlines=11, sizeline=52 */
char * pTITLE_LINES[] = {
  "*** *** **  *** *** *  *  *  *   * *** * *          ",
  "* * *   * * *   * * ** * * * *   *  *  * *          ",
  "*** *** *** *** * * ** * *** *   *  *  ***          ",
  "*   *   **    * * * * ** * * *   *  *   *           ",
  "*   *** * * *** *** *  * * * *** *  *   *           ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
  "                                                    ",
};


/* the following is for K&R fns day_of_year() & month_day() */
double pDAY_TAB[2][13] = {
  {365.0,31.0,28.0,31.0,30.0,31.0,30.0,31.0,31.0,30.0,31.0,30.0,31.0},
  {366.0,31.0,29.0,31.0,30.0,31.0,30.0,31.0,31.0,30.0,31.0,30.0,31.0}
};


/* trn orbs all 2 degrees */
/* int pORBS_TRN[NUM_ASPECTS+1] = {0,120,120,120,120,120,120,120,120,120}; */
int pORBS_NAT[NUM_ASPECTS+1] = {0,360,240,360,360,360,360,360,240,360};
int pASPECT_ID[NUM_ASPECTS+1] =
             {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9};
        /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
      /* degrees  x  0  60   90   120   180   240   270   300  360 */
int pASPECT_TYPE[NUM_ASPECTS+1] =
            {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0};
 /* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */
int pASPECTS[NUM_ASPECTS+1]=
              {-1,  0,3600,5400,7200,10800,14400,16200,18000,21600};




/* see #define SIZE_GRH_LEFT_MARGIN in as_defines.h */
int pSTRESS_VAL[NUM_STRESS_LEVELS] = {304,250,196,142,88,34,-20,-74};
/* char * pSTRESS_NAME[NUM_STRESS_LEVELS] = {
*   "             ",
*   "HIGH_STRESS_ ",
*   "             ",
*   "qq___STRESS__",
*   "SOME STRAIN_ ",
*   "qq_____GOOD__",
*   "  VERY GOOD_ ",
*   "             ",
* };
*/

int ar_minutes_natal[NUM_PLANETS+1+3];  /* +1 for [0], +3 for nod asc mc */
int pGRH_DATA[TOT_CATEGORIES][NUM_PLUS_OR_MINUS_CATEGORIES];
      /* 12*2 */

/* extern FILE *fopen(); */
/* FILE *pFP_DOCIN_FILE; */
/* FILE *pFP_FUTIN_FILE; */
/* FILE *pFP_SIGNOUT_FILE; */

int pHOUSE_CONFIDENCE,pMOON_CONFIDENCE;
double pCURRENT_ASPECT_FORCE;    /* 0.0 - 1.0 */
  /*       pi    orb_in_minutes - diff_from_exact     */
  /* sin( --  X  --------------------------------)     */
  /*      2      orb_in_minutes           */
  /* defined in is_aspect(), used in calc_fut_graph() */
double pMOON_CONFIDENCE_FACTOR;

/* bufs to hold future cmd args */

char pARG_FUTIN_PATHNAME[SIZE_INBUF+1];  /* see as_defines.h for argnum defs */
char pARG_DOCIN_DIR[SIZE_INBUF+1];

char pDOCIN_PATHNAME[SIZE_INBUF+1];
/* char pSIGNOUT_PATHNAME[SIZE_INBUF+1]; */
char pINBUF[SIZE_INBUF+1];

/* the following are output from mk_fut_input.c */
char pEVENT_NAME[SIZE_INBUF+1];
char pMADD_LAST_NAME[SIZE_INBUF+1];
char pMADD_FIRST_NAMES[SIZE_INBUF+1];
char pMADD1[SIZE_INBUF+1];  /* mailing address line 1 */
char pMADD2[SIZE_INBUF+1];  /* adress line 2 */
char pCITY_TOWN[SIZE_INBUF+1];
char pPROV_STATE[SIZE_INBUF+1];
char pCOUNTRY[SIZE_INBUF+1];
char pPOSTAL_CODE[SIZE_INBUF+1];
char pLETTER_COMMENT_1[SIZE_INBUF+1];
char pLETTER_COMMENT_2[SIZE_INBUF+1];
char pIS_OK[SIZE_INBUF+1];
char pFUTIN_FILENAME[SIZE_INBUF+1];
char pORDNUM[SIZE_INBUF+1];
char pDATE_OF_ORDER_ENTRY[SIZE_INBUF+1];
char pLN_PRT[SIZE_INBUF+1];
double pINMN,pINDY,pINYR,pINHR,pINMU,pINTZ,pINLN,pINLT;
int pINAP,pINCF;  /* cf= confidence in time of day */
int pNUM_PAST_UNITS_ORDERED,pPAST_START_MN,pPAST_START_DY,pPAST_START_YR;
int pNUM_FUT_UNITS_ORDERED,pFUT_START_MN,pFUT_START_DY,pFUT_START_YR;
char pDO_PP[SIZE_INBUF+1];  /* do a personality profile? y/n */

double pPI_OVER_2;  

/* following are specific to pp.c */
char yninbuf[SIZE_INBUF];  /* for y/n answer (different from inbuf) */
/* Positions are in the following */
/* order:  xxx,sun,moo,mer,ven,mar,jup,sat,ura,nep,plu  */
int pAR_SGN[NUM_PLANETS+1];
int pAR_HSE[NUM_PLANETS+1];
int pAR_ASP[NUM_PLANETS+1][NUM_PLANETS+1];
int pPLT_HAS_ASP_TBL[NUM_PLANETS+1];  /* for free-floating control */
int pCONSIDER_HOUSE_FACTOR[TOT_CATEGORIES] = 
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
/* special grhs- no hse works best */  /* 09oct85 used to be =0 */

/* item tbl stuff follows: */
char pITEM_TBL[MAX_IN_ITEM_TBL*(SIZE_ITEM+1)];
char * pP_ITEM_TBL[MAX_IN_ITEM_TBL];  /* ptrs to elements in above tbl */
int pITEM_TBL_IDX;  /* is idx to tbl (not counter of elements) */
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
int pSGN_OVER_HSE_FACTOR;  /* sgn 2x more weight than hse */
int pGRAPH_FACTOR;      /* 15 pts in pgrh_data for 1 star */

/* int pPLACEMENT_MULTIPLIER; */ /* old value was 12 */
int pPLACEMENT_MULTIPLIER_SIGN;  /* 201309 changed value   */
int pPLACEMENT_MULTIPLIER_HOUSE;  /* 201309 = 6 */

int pSUBTRACT_FROM_STARS;  /* 35 */
int pLESSON_MULTIPLIER;    /* 3 (one third) */ 



/*         pp_tabs.h         */
/*       an include file for pp.c       */


/* ================================================================================= */
/*       this is new calibration for cat 19 ups and downs */
/* ================================================================================= */


/*  int pPLT_IN_12[NUM_PLANETS]        */
/*                [NUM_SIGNS]        */
/*                [TOT_CATEGORIES] = { */
/*  10 x 12 x 12 = 1440 ints, 2880 bytes */

int pPLT_IN_12[NUM_PLANETS*NUM_SIGNS*TOT_CATEGORIES] = {

/******* categories 13 thru 19
  1 aggressive
  2 sensitive
  3 down-to-earth
  4 restless
  5 sex drive
  6 me and my big mouth
  7 ups and downs in life
*******/
/* ***sun */
/* ari */ 8,0,0,0,2,0, 0,0,0,0,0,0, 8,0,0,2,0,0,3,
/* tau */ 0,8,0,0,2,0, 0,0,0,0,0,0, 2,0,8,0,4,0,3,
/* gem */ 0,0,8,0,2,0, 0,0,0,0,0,0, 0,0,0,8,2,5,3,
/* can */ 0,0,0,8,2,0, 0,0,0,0,0,0, 0,8,0,0,0,0,3,
/* leo */ 0,0,0,0,8,0, 0,0,0,0,0,0, 8,0,0,0,2,0,3,
/* vir */ 0,0,0,0,2,8, 0,0,0,0,0,0, 0,0,8,0,0,2,3,
/* lib */ 0,0,0,0,2,0, 8,0,0,0,0,0, 0,4,0,0,0,0,3,
/* scp */ 0,0,0,0,2,0, 0,8,0,0,0,0, 5,0,0,0,8,3,3,
/* sag */ 0,0,0,0,2,0, 0,0,8,0,0,0, 5,0,0,7,0,5,3,
/* cap */ 0,0,0,0,2,0, 0,0,0,8,0,0, 2,0,8,0,0,0,3,
/* aqu */ 0,0,0,0,2,0, 0,0,0,0,8,0, 0,0,0,6,0,0,3,
/* pis */ 0,0,0,0,2,0, 0,0,0,0,0,8, 0,8,0,1,0,0,3,

/* ***moo */
/* ari */ 7,0,0,3,0,0, 0,0,0,0,0,0, 5,0,0,2,0,0,3,
/* tau */ 0,7,0,5,0,0, 0,0,0,0,0,0, 0,3,7,0,4,0,3,
/* gem */ 0,0,7,3,0,0, 0,0,0,0,0,0, 0,0,0,8,1,1,3,
/* can */ 0,0,0,8,0,0, 0,0,0,0,0,0, 0,8,0,0,0,0,3,
/* leo */ 0,0,0,3,7,0, 0,0,0,0,0,0, 6,0,0,0,1,0,3,
/* vir */ 0,0,0,3,0,7, 0,0,0,0,0,0, 0,0,6,0,0,0,3,
/* lib */ 0,0,0,3,0,0, 7,0,0,0,0,0, 0,0,0,0,0,0,3,
/* scp */ 0,0,0,3,0,0, 0,7,0,0,0,0, 3,3,0,0,7,1,3,
/* sag */ 0,0,0,3,0,0, 0,0,7,0,0,0, 3,0,0,6,0,1,3,
/* cap */ 0,0,0,3,0,0, 0,0,0,7,0,0, 0,0,6,0,0,0,3,
/* aqu */ 0,0,0,3,0,0, 0,0,0,0,7,0, 0,0,0,7,0,0,3,
/* pis */ 0,0,0,3,0,0, 0,0,0,0,0,7, 0,8,0,0,0,0,3,

/* ***mer */
/* ari */ 6,0,2,0,0,2, 0,0,0,0,0,0, 7,0,0,2,0,1,3,
/* tau */ 0,6,2,0,0,2, 0,0,0,0,0,0, 2,0,8,0,4,1,3,
/* gem */ 0,0,8,0,0,2, 0,0,0,0,0,0, 0,0,0,8,2,8,3,
/* can */ 0,0,2,6,0,2, 0,0,0,0,0,0, 0,7,0,2,0,1,3,
/* leo */ 0,0,2,0,6,2, 0,0,0,0,0,0, 6,0,0,0,1,1,3,
/* vir */ 0,0,2,0,0,8, 0,0,0,0,0,0, 0,0,9,0,0,4,3,
/* lib */ 0,0,2,0,0,2, 6,0,0,0,0,0, 0,1,0,0,0,1,3,
/* scp */ 0,0,2,0,0,2, 0,6,0,0,0,0, 5,2,0,0,7,6,3,
/* sag */ 0,0,2,0,0,2, 0,0,6,0,0,0, 2,0,0,5,0,8,3,
/* cap */ 0,0,2,0,0,2, 0,0,0,6,0,0, 0,0,8,0,0,1,3,
/* aqu */ 0,0,2,0,0,2, 0,0,0,0,6,0, 0,0,0,6,0,2,3,
/* pis */ 0,0,2,0,0,2, 0,0,0,0,0,6, 0,7,0,0,0,1,3,

/* ***ven */
/* ari */ 5,2,0,0,0,0, 2,0,0,0,0,0, 4,0,0,0,5,0,3,
/* tau */ 0,7,0,0,0,0, 3,0,0,0,0,0, 1,4,9,0,6,0,3,
/* gem */ 0,2,5,0,0,0, 2,0,0,0,0,0, 0,0,0,6,7,0,3,
/* can */ 0,2,0,5,0,0, 2,0,0,0,0,0, 0,8,0,0,2,0,3,
/* leo */ 0,2,0,0,5,0, 2,0,0,0,0,0, 1,0,0,0,6,0,3,
/* vir */ 0,2,0,0,0,5, 2,0,0,0,0,0, 0,0,9,0,2,0,3,
/* lib */ 0,2,0,0,0,0, 7,0,0,0,0,0, 0,0,0,0,3,0,3,
/* scp */ 0,2,0,0,0,0, 2,5,0,0,0,0, 2,4,0,0,8,0,3,
/* sag */ 0,2,0,0,0,0, 2,0,5,0,0,0, 2,0,0,4,2,0,3,
/* cap */ 0,2,0,0,0,0, 2,0,0,5,0,0, 0,0,5,0,2,0,3,
/* aqu */ 0,2,0,0,0,0, 2,0,0,0,5,0, 0,0,0,4,2,0,3,
/* pis */ 0,2,0,0,0,0, 2,0,0,0,0,8, 0,8,0,0,3,0,3,

/* ***mar */
/* ari */ 8,0,0,0,0,0, 0,0,0,0,0,0, 8,0,0,2,4,0,3,
/* tau */ 2,5,0,0,0,0, 0,0,0,0,0,0, 6,0,6,0,7,0,3,
/* gem */ 2,0,5,0,0,0, 0,0,0,0,0,0, 2,0,0,7,4,6,3,
/* can */ 2,0,0,5,0,0, 0,0,0,0,0,0, 2,3,0,0,2,0,3,
/* leo */ 2,0,0,0,5,0, 0,0,0,0,0,0, 8,0,0,0,4,0,3,
/* vir */ 2,0,0,0,0,5, 0,0,0,0,0,0, 2,0,6,0,2,4,3,
/* lib */ 2,0,0,0,0,0, 5,0,0,0,0,0, 1,1,0,0,2,0,3,
/* scp */ 2,0,0,0,0,0, 0,7,0,0,0,0, 8,2,0,0,8,0,3,
/* sag */ 2,0,0,0,0,0, 0,0,5,0,0,0, 5,0,0,7,2,4,3,
/* cap */ 5,0,0,0,0,0, 0,0,0,8,0,0, 2,0,8,0,2,0,3,
/* aqu */ 2,0,0,0,0,0, 0,0,0,0,5,0, 2,0,0,6,2,0,3,
/* pis */ 2,0,0,0,0,0, 0,0,0,0,0,5, 0,6,0,0,2,0,3,

/* ***jup */
/* ari */ 4,0,0,0,0,0, 0,0,2,0,0,0, 8,0,0,4,0,0,3,
/* tau */ 0,4,0,0,0,0, 0,0,2,0,0,0, 1,0,6,0,4,0,3,
/* gem */ 0,0,4,0,0,0, 0,0,2,0,0,0, 0,0,0,8,2,3,3,
/* can */ 0,0,0,4,0,0, 0,0,2,0,0,0, 0,5,0,0,0,0,3,
/* leo */ 0,0,0,0,4,0, 0,0,2,0,0,0, 6,0,0,0,2,0,3,
/* vir */ 0,0,0,0,0,4, 0,0,2,0,0,0, 0,0,5,0,0,1,3,
/* lib */ 0,0,0,0,0,0, 8,0,2,0,0,0, 0,0,0,0,0,0,3,
/* scp */ 0,0,0,0,0,0, 0,4,2,0,0,0, 4,0,0,0,8,0,3,
/* sag */ 0,0,0,0,0,0, 0,0,8,0,0,0, 3,0,0,7,0,5,3,
/* cap */ 0,0,0,0,0,0, 0,0,2,4,0,0, 0,0,6,0,0,0,3,
/* aqu */ 0,0,0,0,0,0, 0,0,2,0,4,0, 0,0,0,3,0,0,3,
/* pis */ 0,0,0,0,0,0, 0,0,2,0,0,4, 0,8,0,0,2,0,3,

/* ***sat */
/* ari */ 6,0,0,0,0,0, 0,0,0,2,0,0, 6,0,1,0,0,0,3,
/* tau */ 0,6,0,0,0,0, 0,0,0,2,0,0, 2,0,8,0,4,0,3,
/* gem */ 0,0,6,0,0,0, 0,0,0,2,0,0, 0,0,1,2,2,3,3,
/* can */ 0,0,0,6,0,0, 0,0,0,2,0,0, 0,8,1,0,0,0,3,
/* leo */ 0,0,0,0,6,0, 0,0,0,2,0,0, 3,0,3,0,2,0,3,
/* vir */ 0,0,0,0,0,6, 0,0,0,2,0,0, 0,0,8,0,0,3,3,
/* lib */ 0,0,0,0,0,0, 8,0,0,2,0,0, 0,0,4,0,0,0,3,
/* scp */ 0,0,0,0,0,0, 0,6,0,2,0,0, 5,0,2,0,8,0,3,
/* sag */ 0,0,0,0,0,0, 0,0,6,2,0,0, 2,0,2,3,0,5,3,
/* cap */ 0,0,0,0,0,0, 0,0,0,8,0,0, 0,0,8,0,0,0,3,
/* aqu */ 0,0,0,0,0,0, 0,0,0,2,6,0, 0,0,1,6,0,0,3,
/* pis */ 0,0,0,0,0,0, 0,0,0,2,0,6, 0,8,0,0,0,0,3,

/* ***ura */
/* ari */ 4,0,0,0,0,0, 0,0,0,0,2,0, 8,0,0,4,0,0,3,
/* tau */ 0,4,0,0,0,0, 0,0,0,0,2,0, 1,0,3,0,5,0,3,
/* gem */ 0,0,4,0,0,0, 0,0,0,0,2,0, 1,0,0,8,2,3,3,
/* can */ 0,0,0,4,0,0, 0,0,0,0,2,0, 0,8,0,1,0,0,3,
/* leo */ 0,0,0,0,4,0, 0,0,0,0,2,0, 6,0,0,0,2,0,3,
/* vir */ 0,0,0,0,0,4, 0,0,0,0,2,0, 0,0,5,0,0,0,3,
/* lib */ 0,0,0,0,0,0, 4,0,0,0,2,0, 0,0,0,0,0,0,3,
/* scp */ 0,0,0,0,0,0, 0,5,0,0,2,0, 5,0,0,2,8,3,3,
/* sag */ 0,0,0,0,0,0, 0,0,4,0,2,0, 5,0,0,7,0,5,3,
/* cap */ 0,0,0,0,0,0, 0,0,0,4,2,0, 0,0,4,0,0,0,3,
/* aqu */ 0,0,0,0,0,0, 0,0,0,0,8,0, 0,0,0,6,0,0,3,
/* pis */ 0,0,0,0,0,0, 0,0,0,0,2,4, 0,8,0,4,0,0,3,

/* ***nep */
/* ari */ 4,0,0,0,0,0, 0,0,0,0,0,2, 2,2,0,2,0,0,3,
/* tau */ 0,4,0,0,0,0, 0,0,0,0,0,2, 0,2,3,0,4,0,3,
/* gem */ 0,0,4,0,0,0, 0,0,0,0,0,2, 0,0,0,4,2,1,3,
/* can */ 0,0,0,4,0,0, 0,0,0,0,0,2, 0,8,0,0,0,0,3,
/* leo */ 0,0,0,0,7,0, 0,0,0,0,0,2, 2,0,0,0,2,0,3,
/* vir */ 0,0,0,0,0,4, 0,0,0,0,0,2, 0,0,2,0,0,0,3,
/* lib */ 0,0,0,0,0,0, 4,0,0,0,0,2, 0,0,0,0,0,0,3,
/* scp */ 0,0,0,0,0,0, 0,4,0,0,0,2, 0,3,0,0,3,0,3,
/* sag */ 0,0,0,0,0,0, 0,0,4,0,0,2, 2,0,0,2,0,1,3,
/* cap */ 0,0,0,0,0,0, 0,0,0,4,0,2, 0,0,3,0,0,0,3,
/* aqu */ 0,0,0,0,0,0, 0,0,0,0,4,2, 0,0,0,2,0,0,3,
/* pis */ 0,0,0,0,0,0, 0,0,0,0,0,8, 0,8,0,0,0,0,3,

/* ***plu */
/* ari */ 4,0,0,0,0,0, 0,2,0,0,0,0, 8,0,0,2,4,0,3,
/* tau */ 0,4,0,0,0,0, 0,2,0,0,0,0, 2,0,8,0,6,0,3,
/* gem */ 0,0,4,0,0,0, 0,2,0,0,0,0, 0,0,0,8,2,1,3,
/* can */ 0,0,0,4,0,0, 0,2,0,0,0,0, 0,8,0,0,3,0,3,
/* leo */ 0,0,0,0,4,0, 0,2,0,0,0,0, 8,0,0,1,4,0,3,
/* vir */ 0,0,0,0,0,4, 0,2,0,0,0,0, 0,0,8,0,3,1,3,
/* lib */ 0,0,0,0,0,0, 4,2,0,0,0,0, 0,0,0,0,2,0,3,
/* scp */ 0,0,0,0,0,0, 0,8,0,0,0,0, 5,0,0,0,8,0,3,
/* sag */ 0,0,0,0,0,0, 0,2,4,0,0,0, 5,0,0,7,2,1,3,
/* cap */ 0,0,0,0,0,0, 0,2,0,4,0,0, 0,0,8,0,0,0,3,
/* aqu */ 0,0,0,0,0,0, 0,2,0,0,4,0, 0,0,0,6,0,0,3,
/* pis */ 0,0,0,0,0,0, 0,2,0,0,0,4, 0,8,0,0,2,0,3,
};  /* end of pplt_in_12 */

/*  int aspect_multiplier[NUM_ASPECT_TYPES]        */
/*             [NUM_PLT_PAIRS]    */
/*             [TOT_CATEGORIES]  = {  */
/* 3 x 35 x 12 = 1260 ints, 2520 bytes */


/* 37:#define NUM_ASPECT_TYPES 1     */
int pASPECT_MULTIPLIER  [NUM_ASPECT_TYPES*
             NUM_PLT_PAIRS*
             TOT_CATEGORIES] = {

/* sun-moo */ 3,1,1,8,3,1, 1,1,1,1,1,1, 6,7,6,6,6,1,8,
/* sun-mer */ 1,1,8,1,3,8, 1,1,1,1,1,1, 6,6,5,6,5,2,1,
/* sun-ven */ 1,8,1,1,3,1, 8,1,1,1,1,1, 5,6,4,5,7,1,1,
/* sun-mar */ 8,1,1,1,3,1, 1,1,1,1,1,1, 7,3,5,5,7,1,5,
/* sun-jup */ 1,1,1,1,3,1, 1,1,8,1,1,1, 5,5,5,5,5,1,1,
/* sun-sat */ 1,1,1,1,3,1, 1,1,1,8,1,1, 5,5,7,4,5,1,8,
/* sun-ura */ 1,1,1,1,3,1, 1,1,1,1,8,1, 6,5,5,7,7,1,8,
/* sun-nep */ 1,1,1,1,3,1, 1,1,1,1,1,8, 5,8,5,4,5,1,8,
/* sun-plu */ 1,1,1,1,3,1, 1,8,1,1,1,1, 7,5,5,5,8,1,8,

/* moo-mer */ 1,1,8,3,1,3, 1,1,1,1,1,1, 5,8,5,7,5,8,1,
/* moo-ven */ 1,8,1,3,1,1, 8,1,1,1,1,1, 4,6,5,6,5,1,2,
/* moo-mar */ 7,1,1,3,1,1, 1,1,1,1,1,1, 6,4,4,5,4,1,4,
/* moo-jup */ 1,1,1,8,1,1, 1,1,7,1,1,1, 3,5,3,5,4,1,1,
/* moo-sat */ 1,1,1,3,1,1, 1,1,1,7,1,1, 4,1,7,5,5,1,8,
/* moo-ura */ 1,1,6,3,1,1, 1,1,1,1,7,1, 5,5,5,6,5,1,8,
/* moo-nep */ 1,1,1,3,1,1, 1,1,1,1,1,8, 4,8,3,4,4,1,8,
/* moo-plu */ 3,1,1,3,1,1, 1,6,1,1,1,1, 6,4,5,5,8,1,8,

/* mer-ven */ 1,7,6,1,1,7, 7,1,1,1,1,1, 4,6,4,6,5,1,1,
/* mer-mar */ 1,1,5,1,1,3, 1,1,1,1,1,1, 5,4,4,7,4,8,3,
/* mer-jup */ 1,1,8,1,1,3, 1,1,7,1,1,1, 3,5,3,5,4,1,2,
/* mer-sat */ 1,1,5,1,1,3, 1,1,1,7,1,1, 4,5,7,5,5,1,8,
/* mer-ura */ 1,1,5,1,1,1, 1,1,1,1,7,1, 7,4,3,8,4,7,8,
/* mer-nep */ 1,1,5,1,1,1, 1,1,1,1,1,7, 3,8,2,4,4,2,8,
/* mer-plu */ 1,1,5,1,1,1, 1,7,1,1,1,1, 6,4,5,5,8,8,8,

/* ven-mar */ 1,7,1,1,1,1, 5,7,1,1,1,1, 3,6,4,4,8,1,4,
/* ven-jup */ 1,7,1,1,1,1, 7,1,6,1,1,1, 4,5,4,4,7,1,1,
/* ven-sat */ 1,3,1,1,1,1, 5,1,1,7,1,1, 2,6,4,3,4,1,8,
/* ven-ura */ 1,2,1,1,1,1, 5,1,1,1,7,1, 4,5,4,7,7,1,8,
/* ven-nep */ 1,2,1,1,1,1, 3,1,1,1,1,7, 3,8,2,4,6,1,8,
/* ven-plu */ 1,2,1,1,1,1, 3,8,1,1,1,1, 3,6,2,4,8,1,8,

/* mar-jup */ 3,1,1,1,1,1, 1,1,7,1,1,1, 5,3,4,4,7,1,4,
/* mar-sat */ 2,1,1,1,1,1, 1,1,1,7,1,1, 5,3,4,3,4,1,8,
/* mar-ura */ 4,1,1,1,1,1, 1,1,1,1,7,1, 7,3,4,7,5,3,8,
/* mar-nep */ 2,1,1,1,1,1, 1,1,1,1,1,7, 3,4,2,4,6,1,5,
/* mar-plu */ 7,1,1,1,1,1, 1,7,1,1,1,1, 8,3,2,4,6,5,8,

/* jup-sat */ 1,1,1,1,1,1, 1,1,6,7,1,1, 2,3,2,2,2,1,2,
/* jup-ura */ 1,1,1,1,1,1, 1,1,6,1,7,1, 6,3,4,7,4,1,2,
/* jup-nep */ 1,1,1,1,1,1, 1,1,6,1,1,7, 2,5,2,2,5,1,2,
/* jup-plu */ 3,1,1,1,1,1, 1,7,6,1,1,1, 5,3,2,3,6,1,2,

/* sat-ura */ 1,1,1,1,1,1, 1,1,1,6,7,1, 5,2,3,3,3,1,2,
/* sat-nep */ 1,1,1,1,1,1, 1,1,1,6,1,7, 2,5,2,2,2,1,2,
/* sat-plu */ 3,1,1,1,1,1, 1,7,1,6,1,1, 5,3,2,3,6,1,2,

/* ura-nep */ 1,1,1,1,1,1, 1,1,1,1,6,7, 2,5,2,2,2,1,2,
/* ura-plu */ 2,1,1,1,1,1, 1,7,1,1,6,1, 5,3,2,3,6,3,2,

/* nep-plu */ 1,1,1,1,1,1, 1,3,1,1,1,3, 3,3,2,2,2,1,2,
};  /* end of pASPECT_MULTIPLIER  */



int pPLT_PAIRS_IDX_TBL[NUM_PLANETS-1][NUM_PLANETS] = {
/*         plt2   */
/*              sun  moo  mer  ven  mar  jup  sat  ura  nep  plu     */
/* plt1  sun  */ {0,   0,   1,   2,   3,   4,   5,   6,   7,   8},
/*       moo  */ {0,   0,   9,  10,  11,  12,  13,  14,  15,  16},
/*       mer  */ {0,   0,   0,  17,  18,  19,  20,  21,  22,  23},
/*       ven  */ {0,   0,   0,   0,  24,  25,  26,  27,  28,  29},
/*       mar  */ {0,   0,   0,   0,   0,  30,  31,  32,  33,  34},
/*       jup  */ {0,   0,   0,   0,   0,   0,  35,  36,  37,  38},
/*       sat  */ {0,   0,   0,   0,   0,   0,   0,  39,  40,  41},
/*       ura  */ {0,   0,   0,   0,   0,   0,   0,   0,  42,  43},
/*       nep  */ {0,   0,   0,   0,   0,   0,   0,   0,   0,  44}
};
/*   e.g.   moo_asp_jup is #13,    mar_asp_ura is #33 */

int pNEG_CNJ_TBL[NUM_PLANETS-1][NUM_PLANETS] = {
/*         plt2   */
/*         sun  moo  mer  ven  mar  jup  sat  ura  nep  plu     */
/* plt1  sun  */ {0,  1,  1,  1,  1,  1,  -1,  -1,  -1,  -1},
/*       moo  */ {0,  0,  1,  1,  1,  1,  -1,  -1,  -1,  -1},
/*       mer  */ {0,  0,  0,  1,  1,  1,  -1,  -1,  -1,  -1},
/*       ven  */ {0,  0,  0,  0,  1,  1,  -1,  -1,  -1,  -1},
/*       mar  */ {0,  0,  0,  0,  0,  1,  -1,  -1,  -1,  -1},
/*       jup  */ {0,  0,  0,  0,  0,  0,   1,   1,   1,   1},
/*       sat  */ {0,  0,  0,  0,  0,  0,   0,  -1,  -1,  -1},
/*       ura  */ {0,  0,  0,  0,  0,  0,   0,   0,  -1,  -1},
/*       nep  */ {0,  0,  0,  0,  0,  0,   0,   0,   0,  -1}
};

/* end of pp_tabs.h */



/* end of perdoc.h */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   THIS IS OLD CALIBRATION BEFORE change to new ups and downs
* <.>
* /*  int pPLT_IN_12[NUM_PLANETS]        */
* /*                [NUM_SIGNS]        */
* /*                [TOT_CATEGORIES] = { */
* /*  10 x 12 x 12 = 1440 ints, 2880 bytes */
* 
* int pPLT_IN_12[NUM_PLANETS*NUM_SIGNS*TOT_CATEGORIES] = {
* 
* /******* categories 13 thru 19
*   1 aggressive
*   2 sensitive
*   3 down-to-earth
*   4 restless
*   5 sex drive
*   6 me and my big mouth
*   7 ups and downs in life
* *******/
* /* ***sun */
* /* ari */ 8,0,0,0,2,0, 0,0,0,0,0,0, 8,0,0,2,0,0,0,
* /* tau */ 0,8,0,0,2,0, 0,0,0,0,0,0, 2,0,8,0,4,0,0,
* /* gem */ 0,0,8,0,2,0, 0,0,0,0,0,0, 0,0,0,8,2,5,0,
* /* can */ 0,0,0,8,2,0, 0,0,0,0,0,0, 0,8,0,0,0,0,0,
* /* leo */ 0,0,0,0,8,0, 0,0,0,0,0,0, 8,0,0,0,2,0,0,
* /* vir */ 0,0,0,0,2,8, 0,0,0,0,0,0, 0,0,8,0,0,2,0,
* /* lib */ 0,0,0,0,2,0, 8,0,0,0,0,0, 0,4,0,0,0,0,0,
* /* scp */ 0,0,0,0,2,0, 0,8,0,0,0,0, 5,0,0,0,8,3,6,
* /* sag */ 0,0,0,0,2,0, 0,0,8,0,0,0, 5,0,0,7,0,5,0,
* /* cap */ 0,0,0,0,2,0, 0,0,0,8,0,0, 2,0,8,0,0,0,0,
* /* aqu */ 0,0,0,0,2,0, 0,0,0,0,8,0, 0,0,0,6,0,0,0,
* /* pis */ 0,0,0,0,2,0, 0,0,0,0,0,8, 0,8,0,1,0,0,4,
* 
* /* ***moo */
* /* ari */ 7,0,0,3,0,0, 0,0,0,0,0,0, 5,0,0,2,0,0,0,
* /* tau */ 0,7,0,5,0,0, 0,0,0,0,0,0, 0,3,7,0,4,0,0,
* /* gem */ 0,0,7,3,0,0, 0,0,0,0,0,0, 0,0,0,8,1,1,0,
* /* can */ 0,0,0,8,0,0, 0,0,0,0,0,0, 0,8,0,0,0,0,4,
* /* leo */ 0,0,0,3,7,0, 0,0,0,0,0,0, 6,0,0,0,1,0,0,
* /* vir */ 0,0,0,3,0,7, 0,0,0,0,0,0, 0,0,6,0,0,0,0,
* /* lib */ 0,0,0,3,0,0, 7,0,0,0,0,0, 0,0,0,0,0,0,0,
* /* scp */ 0,0,0,3,0,0, 0,7,0,0,0,0, 3,3,0,0,7,1,2,
* /* sag */ 0,0,0,3,0,0, 0,0,7,0,0,0, 3,0,0,6,0,1,0,
* /* cap */ 0,0,0,3,0,0, 0,0,0,7,0,0, 0,0,6,0,0,0,3,
* /* aqu */ 0,0,0,3,0,0, 0,0,0,0,7,0, 0,0,0,7,0,0,0,
* /* pis */ 0,0,0,3,0,0, 0,0,0,0,0,7, 0,8,0,0,0,0,3,
* 
* /* ***mer */
* /* ari */ 6,0,2,0,0,2, 0,0,0,0,0,0, 7,0,0,2,0,1,0,
* /* tau */ 0,6,2,0,0,2, 0,0,0,0,0,0, 2,0,8,0,4,1,0,
* /* gem */ 0,0,8,0,0,2, 0,0,0,0,0,0, 0,0,0,8,2,8,0,
* /* can */ 0,0,2,6,0,2, 0,0,0,0,0,0, 0,7,0,2,0,1,0,
* /* leo */ 0,0,2,0,6,2, 0,0,0,0,0,0, 6,0,0,0,1,1,0,
* /* vir */ 0,0,2,0,0,8, 0,0,0,0,0,0, 0,0,9,0,0,4,0,
* /* lib */ 0,0,2,0,0,2, 6,0,0,0,0,0, 0,1,0,0,0,1,0,
* /* scp */ 0,0,2,0,0,2, 0,6,0,0,0,0, 5,2,0,0,7,6,0,
* /* sag */ 0,0,2,0,0,2, 0,0,6,0,0,0, 2,0,0,5,0,8,0,
* /* cap */ 0,0,2,0,0,2, 0,0,0,6,0,0, 0,0,8,0,0,1,0,
* /* aqu */ 0,0,2,0,0,2, 0,0,0,0,6,0, 0,0,0,6,0,2,3,
* /* pis */ 0,0,2,0,0,2, 0,0,0,0,0,6, 0,7,0,0,0,1,4,
* 
* /* ***ven */
* /* ari */ 5,2,0,0,0,0, 2,0,0,0,0,0, 4,0,0,0,5,0,2,
* /* tau */ 0,7,0,0,0,0, 3,0,0,0,0,0, 1,4,9,0,6,0,1,
* /* gem */ 0,2,5,0,0,0, 2,0,0,0,0,0, 0,0,0,6,7,0,1,
* /* can */ 0,2,0,5,0,0, 2,0,0,0,0,0, 0,8,0,0,2,0,1,
* /* leo */ 0,2,0,0,5,0, 2,0,0,0,0,0, 1,0,0,0,6,0,1,
* /* vir */ 0,2,0,0,0,5, 2,0,0,0,0,0, 0,0,9,0,2,0,1,
* /* lib */ 0,2,0,0,0,0, 7,0,0,0,0,0, 0,0,0,0,3,0,1,
* /* scp */ 0,2,0,0,0,0, 2,5,0,0,0,0, 2,4,0,0,8,0,6,
* /* sag */ 0,2,0,0,0,0, 2,0,5,0,0,0, 2,0,0,4,2,0,1,
* /* cap */ 0,2,0,0,0,0, 2,0,0,5,0,0, 0,0,5,0,2,0,1,
* /* aqu */ 0,2,0,0,0,0, 2,0,0,0,5,0, 0,0,0,4,2,0,1,
* /* pis */ 0,2,0,0,0,0, 2,0,0,0,0,8, 0,8,0,0,3,0,1,
* 
* /* ***mar */
* /* ari */ 8,0,0,0,0,0, 0,0,0,0,0,0, 8,0,0,2,4,0,0,
* /* tau */ 2,5,0,0,0,0, 0,0,0,0,0,0, 6,0,6,0,7,0,0,
* /* gem */ 2,0,5,0,0,0, 0,0,0,0,0,0, 2,0,0,7,4,6,0,
* /* can */ 2,0,0,5,0,0, 0,0,0,0,0,0, 2,3,0,0,2,0,4,
* /* leo */ 2,0,0,0,5,0, 0,0,0,0,0,0, 8,0,0,0,4,0,0,
* /* vir */ 2,0,0,0,0,5, 0,0,0,0,0,0, 2,0,6,0,2,4,0,
* /* lib */ 2,0,0,0,0,0, 5,0,0,0,0,0, 1,1,0,0,2,0,5,
* /* scp */ 2,0,0,0,0,0, 0,7,0,0,0,0, 8,2,0,0,8,0,5,
* /* sag */ 2,0,0,0,0,0, 0,0,5,0,0,0, 5,0,0,7,2,4,0,
* /* cap */ 5,0,0,0,0,0, 0,0,0,8,0,0, 2,0,8,0,2,0,0,
* /* aqu */ 2,0,0,0,0,0, 0,0,0,0,5,0, 2,0,0,6,2,0,0,
* /* pis */ 2,0,0,0,0,0, 0,0,0,0,0,5, 0,6,0,0,2,0,0,
* 
* /* ***jup */
* /* ari */ 4,0,0,0,0,0, 0,0,2,0,0,0, 8,0,0,4,0,0,0,
* /* tau */ 0,4,0,0,0,0, 0,0,2,0,0,0, 1,0,6,0,4,0,0,
* /* gem */ 0,0,4,0,0,0, 0,0,2,0,0,0, 0,0,0,8,2,3,0,
* /* can */ 0,0,0,4,0,0, 0,0,2,0,0,0, 0,5,0,0,0,0,0,
* /* leo */ 0,0,0,0,4,0, 0,0,2,0,0,0, 6,0,0,0,2,0,0,
* /* vir */ 0,0,0,0,0,4, 0,0,2,0,0,0, 0,0,5,0,0,1,0,
* /* lib */ 0,0,0,0,0,0, 8,0,2,0,0,0, 0,0,0,0,0,0,0,
* /* scp */ 0,0,0,0,0,0, 0,4,2,0,0,0, 4,0,0,0,8,0,2,
* /* sag */ 0,0,0,0,0,0, 0,0,8,0,0,0, 3,0,0,7,0,5,0,
* /* cap */ 0,0,0,0,0,0, 0,0,2,4,0,0, 0,0,6,0,0,0,4,
* /* aqu */ 0,0,0,0,0,0, 0,0,2,0,4,0, 0,0,0,3,0,0,0,
* /* pis */ 0,0,0,0,0,0, 0,0,2,0,0,4, 0,8,0,0,2,0,0,
* 
* /* ***sat */
* /* ari */ 6,0,0,0,0,0, 0,0,0,2,0,0, 6,0,1,0,0,0,1,
* /* tau */ 0,6,0,0,0,0, 0,0,0,2,0,0, 2,0,8,0,4,0,1,
* /* gem */ 0,0,6,0,0,0, 0,0,0,2,0,0, 0,0,1,2,2,3,1,
* /* can */ 0,0,0,6,0,0, 0,0,0,2,0,0, 0,8,1,0,0,0,5,
* /* leo */ 0,0,0,0,6,0, 0,0,0,2,0,0, 3,0,3,0,2,0,1,
* /* vir */ 0,0,0,0,0,6, 0,0,0,2,0,0, 0,0,8,0,0,3,1,
* /* lib */ 0,0,0,0,0,0, 8,0,0,2,0,0, 0,0,4,0,0,0,1,
* /* scp */ 0,0,0,0,0,0, 0,6,0,2,0,0, 5,0,2,0,8,0,5,
* /* sag */ 0,0,0,0,0,0, 0,0,6,2,0,0, 2,0,2,3,0,5,1,
* /* cap */ 0,0,0,0,0,0, 0,0,0,8,0,0, 0,0,8,0,0,0,3,
* /* aqu */ 0,0,0,0,0,0, 0,0,0,2,6,0, 0,0,1,6,0,0,1,
* /* pis */ 0,0,0,0,0,0, 0,0,0,2,0,6, 0,8,0,0,0,0,8,
* 
* /* ***ura */
* /* ari */ 4,0,0,0,0,0, 0,0,0,0,2,0, 8,0,0,4,0,0,2,
* /* tau */ 0,4,0,0,0,0, 0,0,0,0,2,0, 1,0,3,0,5,0,2,
* /* gem */ 0,0,4,0,0,0, 0,0,0,0,2,0, 1,0,0,8,2,3,2,
* /* can */ 0,0,0,4,0,0, 0,0,0,0,2,0, 0,8,0,1,0,0,4,
* /* leo */ 0,0,0,0,4,0, 0,0,0,0,2,0, 6,0,0,0,2,0,2,
* /* vir */ 0,0,0,0,0,4, 0,0,0,0,2,0, 0,0,5,0,0,0,2,
* /* lib */ 0,0,0,0,0,0, 4,0,0,0,2,0, 0,0,0,0,0,0,5,
* /* scp */ 0,0,0,0,0,0, 0,5,0,0,2,0, 5,0,0,2,8,3,8,
* /* sag */ 0,0,0,0,0,0, 0,0,4,0,2,0, 5,0,0,7,0,5,2,
* /* cap */ 0,0,0,0,0,0, 0,0,0,4,2,0, 0,0,4,0,0,0,5,
* /* aqu */ 0,0,0,0,0,0, 0,0,0,0,8,0, 0,0,0,6,0,0,8,
* /* pis */ 0,0,0,0,0,0, 0,0,0,0,2,4, 0,8,0,4,0,0,5,
* 
* /* ***nep */
* /* ari */ 4,0,0,0,0,0, 0,0,0,0,0,2, 2,2,0,2,0,0,0,
* /* tau */ 0,4,0,0,0,0, 0,0,0,0,0,2, 0,2,3,0,4,0,0,
* /* gem */ 0,0,4,0,0,0, 0,0,0,0,0,2, 0,0,0,4,2,1,0,
* /* can */ 0,0,0,4,0,0, 0,0,0,0,0,2, 0,8,0,0,0,0,3,
* /* leo */ 0,0,0,0,7,0, 0,0,0,0,0,2, 2,0,0,0,2,0,0,
* /* vir */ 0,0,0,0,0,4, 0,0,0,0,0,2, 0,0,2,0,0,0,0,
* /* lib */ 0,0,0,0,0,0, 4,0,0,0,0,2, 0,0,0,0,0,0,1,
* /* scp */ 0,0,0,0,0,0, 0,4,0,0,0,2, 0,3,0,0,3,0,0,
* /* sag */ 0,0,0,0,0,0, 0,0,4,0,0,2, 2,0,0,2,0,1,0,
* /* cap */ 0,0,0,0,0,0, 0,0,0,4,0,2, 0,0,3,0,0,0,0,
* /* aqu */ 0,0,0,0,0,0, 0,0,0,0,4,2, 0,0,0,2,0,0,0,
* /* pis */ 0,0,0,0,0,0, 0,0,0,0,0,8, 0,8,0,0,0,0,0,
* 
* /* ***plu */
* /* ari */ 4,0,0,0,0,0, 0,2,0,0,0,0, 8,0,0,2,4,0,1,
* /* tau */ 0,4,0,0,0,0, 0,2,0,0,0,0, 2,0,8,0,6,0,1,
* /* gem */ 0,0,4,0,0,0, 0,2,0,0,0,0, 0,0,0,8,2,1,1,
* /* can */ 0,0,0,4,0,0, 0,2,0,0,0,0, 0,8,0,0,3,0,1,
* /* leo */ 0,0,0,0,4,0, 0,2,0,0,0,0, 8,0,0,1,4,0,1,
* /* vir */ 0,0,0,0,0,4, 0,2,0,0,0,0, 0,0,8,0,3,1,1,
* /* lib */ 0,0,0,0,0,0, 4,2,0,0,0,0, 0,0,0,0,2,0,1,
* /* scp */ 0,0,0,0,0,0, 0,8,0,0,0,0, 5,0,0,0,8,0,5,
* /* sag */ 0,0,0,0,0,0, 0,2,4,0,0,0, 5,0,0,7,2,1,1,
* /* cap */ 0,0,0,0,0,0, 0,2,0,4,0,0, 0,0,8,0,0,0,1,
* /* aqu */ 0,0,0,0,0,0, 0,2,0,0,4,0, 0,0,0,6,0,0,1,
* /* pis */ 0,0,0,0,0,0, 0,2,0,0,0,4, 0,8,0,0,2,0,1,
* };  /* end of pplt_in_12 */
* 
* /*  int aspect_multiplier[NUM_ASPECT_TYPES]        */
* /*             [NUM_PLT_PAIRS]    */
* /*             [TOT_CATEGORIES]  = {  */
* /* 3 x 35 x 12 = 1260 ints, 2520 bytes */
* 
* int pASPECT_MULTIPLIER  [NUM_ASPECT_TYPES*
*              NUM_PLT_PAIRS*
*              TOT_CATEGORIES] = {
* 
* /* CNJ******** */
* /* sun-moo */ 3,1,1,8,3,1, 1,1,1,1,1,1, 6,7,6,6,6,1,8,
* /* sun-mer */ 1,1,8,1,3,8, 1,1,1,1,1,1, 6,6,5,6,5,2,1,
* /* sun-ven */ 1,8,1,1,3,1, 8,1,1,1,1,1, 5,6,4,5,7,1,1,
* /* sun-mar */ 8,1,1,1,3,1, 1,1,1,1,1,1, 7,3,5,5,7,1,1,
* /* sun-jup */ 1,1,1,1,3,1, 1,1,8,1,1,1, 5,5,5,5,5,1,1,
* /* sun-sat */ 1,1,1,1,3,1, 1,1,1,8,1,1, 5,5,7,4,5,1,6,
* /* sun-ura */ 1,1,1,1,3,1, 1,1,1,1,8,1, 6,5,5,7,7,1,8,
* /* sun-nep */ 1,1,1,1,3,1, 1,1,1,1,1,8, 5,8,5,4,5,1,1,
* /* sun-plu */ 1,1,1,1,3,1, 1,8,1,1,1,1, 7,5,5,5,8,1,2,
* 
* /* moo-mer */ 1,1,8,3,1,3, 1,1,1,1,1,1, 5,8,5,7,5,8,1,
* /* moo-ven */ 1,8,1,3,1,1, 8,1,1,1,1,1, 4,6,5,6,5,1,2,
* /* moo-mar */ 7,1,1,3,1,1, 1,1,1,1,1,1, 6,4,4,5,4,1,1,
* /* moo-jup */ 1,1,1,8,1,1, 1,1,7,1,1,1, 3,5,3,5,4,1,1,
* /* moo-sat */ 1,1,1,3,1,1, 1,1,1,7,1,1, 4,1,7,5,5,1,8,
* /* moo-ura */ 1,1,6,3,1,1, 1,1,1,1,7,1, 5,5,5,6,5,1,8,
* /* moo-nep */ 1,1,1,3,1,1, 1,1,1,1,1,8, 4,8,3,4,4,1,1,
* /* moo-plu */ 3,1,1,3,1,1, 1,6,1,1,1,1, 6,4,5,5,8,1,5,
* 
* /* mer-ven */ 1,7,6,1,1,7, 7,1,1,1,1,1, 4,6,4,6,5,1,1,
* /* mer-mar */ 1,1,5,1,1,3, 1,1,1,1,1,1, 5,4,4,7,4,8,1,
* /* mer-jup */ 1,1,8,1,1,3, 1,1,7,1,1,1, 3,5,3,5,4,1,2,
* /* mer-sat */ 1,1,5,1,1,3, 1,1,1,7,1,1, 4,5,7,5,5,1,3,
* /* mer-ura */ 1,1,5,1,1,1, 1,1,1,1,7,1, 7,4,3,8,4,7,3,
* /* mer-nep */ 1,1,5,1,1,1, 1,1,1,1,1,7, 3,8,2,4,4,2,1,
* /* mer-plu */ 1,1,5,1,1,1, 1,7,1,1,1,1, 6,4,5,5,8,8,1,
* 
* /* ven-mar */ 1,7,1,1,1,1, 5,7,1,1,1,1, 3,6,4,4,8,1,1,
* /* ven-jup */ 1,7,1,1,1,1, 7,1,6,1,1,1, 4,5,4,4,7,1,1,
* /* ven-sat */ 1,3,1,1,1,1, 5,1,1,7,1,1, 2,6,4,3,4,1,6,
* /* ven-ura */ 1,2,1,1,1,1, 5,1,1,1,7,1, 4,5,4,7,7,1,5,
* /* ven-nep */ 1,2,1,1,1,1, 3,1,1,1,1,7, 3,8,2,4,6,1,1,
* /* ven-plu */ 1,2,1,1,1,1, 3,8,1,1,1,1, 3,6,2,4,8,1,8,
* 
* /* mar-jup */ 3,1,1,1,1,1, 1,1,7,1,1,1, 5,3,4,4,7,1,1,
* /* mar-sat */ 2,1,1,1,1,1, 1,1,1,7,1,1, 5,3,4,3,4,1,3,
* /* mar-ura */ 4,1,1,1,1,1, 1,1,1,1,7,1, 7,3,4,7,5,3,8,
* /* mar-nep */ 2,1,1,1,1,1, 1,1,1,1,1,7, 3,4,2,4,6,1,1,
* /* mar-plu */ 7,1,1,1,1,1, 1,7,1,1,1,1, 8,3,2,4,6,5,4,
* 
* /* jup-sat */ 1,1,1,1,1,1, 1,1,6,7,1,1, 2,3,2,2,2,1,1,
* /* jup-ura */ 1,1,1,1,1,1, 1,1,6,1,7,1, 6,3,4,7,4,1,1,
* /* jup-nep */ 1,1,1,1,1,1, 1,1,6,1,1,7, 2,5,2,2,5,1,1,
* /* jup-plu */ 3,1,1,1,1,1, 1,7,6,1,1,1, 5,3,2,3,6,1,1,
* 
* /* sat-ura */ 1,1,1,1,1,1, 1,1,1,6,7,1, 5,2,3,3,3,1,3,
* /* sat-nep */ 1,1,1,1,1,1, 1,1,1,6,1,7, 2,5,2,2,2,1,1,
* /* sat-plu */ 3,1,1,1,1,1, 1,7,1,6,1,1, 5,3,2,3,6,1,4,
* 
* /* ura-nep */ 1,1,1,1,1,1, 1,1,1,1,6,7, 2,5,2,2,2,1,1,
* /* ura-plu */ 2,1,1,1,1,1, 1,7,1,1,6,1, 5,3,2,3,6,3,8,
* 
* /* nep-plu */ 1,1,1,1,1,1, 1,3,1,1,1,3, 3,3,2,2,2,1,1,
* };  /* end of pASPECT_MULTIPLIER  */
* <.>
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
