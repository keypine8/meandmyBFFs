/* futdefs.h */

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

#include "rkdebug_externs.h"

/* one graph version of fut */

#include "rk.h"


int make_fut_htm_file(
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx,
  char *in_YearStressScore,
  int   is_first_year_of_life
  );

int mamb_report_year_in_the_life(  /* called from cocoa */
  char *html_f_file_name,
  char *csv_person_string,
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
);


void docin_get(char *input_line);


#define STEP_SIZE_FOR_FUT 2     /* a star every 2 days on grh */

/* #define NUM_PTS_FOR_FUT 100 */
#define NUM_PTS_FOR_FUT 92

#define SIZE_GRH_LEFT_MARGIN 7
#define SIZE_EPH_GRH_LINE 107
/* #define SIZE_GRH_LEFT_MARGIN 13 */
/* #define SIZE_EPH_GRH_LINE 108 */


/*** STRUCTURE TYPE DEFINITIONS ***/
#define NUM_PLANETS_IN_EPH_FILES 6
struct Futureposrec {
  int positions[NUM_PLANETS_IN_EPH_FILES];   /* 6 mar,jup,sat,ura,nep,plu */
};
/* for old eph file records, below is control record as follows: */
/*   positions[0]  = 0 */
/*   positions[1]  num_days which were calculated */
/*   positions[2]  STEP  positions calculated for every STEPth day */
/*                 DATE of 1st day calculated */
/*   positions[3]  month */
/*   positions[4]  day */
/*   positions[5]  year */


/* #define NUM_PLANETS_TRN_BESTDAY 4 */  /* 4 sun,mer,ven,moo */
/* below moon is 10am,01pm,04pm,07pm */
/* #define NUM_PLANETS_TRN_BESTDAY 7 */ /* 4 sun,mer,ven,mo10,mo01,mo04,mo07 */
#define NUM_PLANETS_TRN_BESTDAY 8   /* 4 sun,mer,ven,mar,mo10,mo01,mo04,mo07 */

struct Futureposrec_bestday{   /* NEW */
  int positions[NUM_PLANETS_TRN_BESTDAY];   /* 4 sun,mer,ven,moo */
};


struct Date {
  int mn;
  int dy;
  int yr;
};

struct Runrec {
  int aspect_id;
  struct Date from_date;
};



void do_rt(int nat_plt, int aspect_num, int trn_plt, int day_num);
void put_start_of_aspect(int day_num, int nat_plt, int aspect_num, int trn_plt);
/*     int do_rt(); */
/*  int put_start_of_aspect(); */
void dspl_aspect(int np, int tp, int dn);
void zero_runrec(int nat_plt);
void set_doc_for_grhs(void);
void set_doc_for_paras(void);
void init_rt(void);
void prt_asp_tbl(void);
void do_paras(void);
void do_a_para();
void do_a_para(char *first, char *other1, char *other2);

/* add dstep days to previous date  mn/dy/yr */
void mk_new_date(double *pm, double *pd, double *py, double dstep);  

/* is date + step in new year */
/* returns 1 if yes, 0 if in this year */
int isinnewyear(double y, double m, double d, double step);

/* return jd in year from  month & day */
double day_of_year(double year, double month, double day);

/* set month, day  for jd=yearday in year */
void month_day(double year, double yearday, double *pmonth, double *pday);

/* <.> */

/* mar -> plu */
#define NUM_PLANETS_FOR_FUTURE 6

#define SIZE_INBUF 80
#define NUM_PLANETS 10 
#define NUM_ASPECTS 9
/* #define SIZE_PRTBUF 132 */
#define F1_FILE "futurepos"
#define WRITE_MODE "w"
#define READ_MODE "r"
#define UPDATE_MODE "r+"
#define WRITE_MODE_BINARY "wb"
#define READ_MODE_BINARY "rb"
#define UPDATE_MODE_BINARY "rb+"
#define NUM_MINUTES_IN_CIRCLE 21600
#define NUM_SIGNS 12
/* #define FUT_GRH_PT_EVERY_X_RECS 1 */  /* from now on pmg assumes =1 */
    /* mk a grh pt for every 1 rec in futurepos file */
#define NUM_ASPECT_TYPES 3    /* cnj, fvr, unfvr */
#define NUM_HOUSES_CONSIDERED 1    /* 2,4,5,7,10 *//* now 2- mon,lov */
    /* now 1 for this one graph version of future */
#define NUM_EPH_GRAPHS 2    /* one more for total graph *//* now3+1 */
#define EPH_GRH_CHAR '*'    /* pt on graph char */
#define GRH_SIDELINE_CHAR '|'
#define GRH_BOTLINE_CHAR '\''


/* #define GRH_CONNECT_CHAR ' '  */ /* really the graph background char */
#define GRH_CONNECT_CHAR '#'  /* really the graph background char */


                /* (after the top/bottom reversal) */

/*
* Xdefine GRH_BACKGROUND_CHAR '\''  * really the graph 'body' char *
*                 * (high stress used to be at the grh top) *
*/
char GRH_BACKGROUND_CHAR;  /* really the graph 'body' char */
char TITLE_LINE_CHAR;    /* "future 6 months" */


#define GRH_LINEMARK_CHAR '_'
#define SCALE_MARK_CHAR '|'
#define SIZE_EPH_GRH_INCREMENT 6  /* 1 '*' for every 6 Grhdata score nums */
#define NUM_DATE_SCALE_LINES 3  /* lines on bot of grh for time axis */
#define NUM_GRH_HDR_LINES 2
#define NUM_GRH_BOT_LINES_ALL_DOTS 1
#define NUM_STRESS_LEVELS 8
#define SUBSCRIPT_FOR_VLO_STRESS_LEVEL 6   /* Stress_val[6] = vlo- "great"*/
#define SUBSCRIPT_FOR_LO_STRESS_LEVEL 5    /* Stress_val[5] = lo- "good" */
#define SUBSCRIPT_FOR_HIGH_STRESS_LEVEL 3  /* Stress_val[3] = hi-"stress" */
#define SUBSCRIPT_FOR_VHIGH_STRESS_LEVEL 2  /* Stress_val[3] = hi-"OMG" */

  /* future.h has #define for SIZE_GRH_NAME (24) */

/* #define NUM_CHAR_DATE_RANGE 23 */
#define NUM_CHAR_DATE_RANGE 50

#define NAT_PLT_NUM_FOR_MOON 2
#define MOON_REPLACEMENT_FACTOR 1.15

#define NUM_INPUT_ITEMS 42  /* 39 from order form, + 3 helpers */
#define NUM_TIME_CONFIDENCE_LINES 4

#define ARGNUM_FOR_FUTIN_PATHNAME 1
#define ARGNUM_FOR_DOCIN_DIR 2
#define ARGNUM_FOR_BACKGROUND_CHAR 3
#define SIZE_QNX_FILENAME 16
#define NUM_PTS_FOR_PAST 106 
#define DIR_CHAR "\\"

/* #define DIR_FOR_EPH_FILES "/strlgy/eph/" */
#define DIR_FOR_EPH_FILES "eph/"

#define FACTOR_FOR_6LPI 1  /* num of \n to be added to a line (after the */
                           /* first \n) in order to get 6lpi spacing */
                           /* e.g. at 12lpi FACTOR_FOR_6LPI = 1 */
#define NUM_LINES_DOC_FOOTER 4  /* m3+m4 in doc (for .ne nn) */
#define SIZE_DAY_TAB 13
/* #define MAX_GRH_BODY_LINES 112 */
/* #define MAX_GRH_BODY_LINES 128 */
#define MAX_GRH_BODY_LINES 333

#define NUM_NAT_PLT_IN_RT 5
#define NUM_TRN_PLT_IN_RT 5
#define NUM_RT_ELEMENTS NUM_NAT_PLT_IN_RT*NUM_TRN_PLT_IN_RT 
  /* 5 nat_plt sun->mar X 5 trn_plt jup->plu */
#define NUM_ASPECTS_PER_NAT_TRN_PAIR 2
#define NUM_POSSIBLE_INSTANCES_PER_ASP 3
#define IDX_FOR_NAT_SUN 1
#define IDX_FOR_NAT_MAR 5
#define IDX_FOR_TRN_JUP 1  /* trn goes ju,sa,ur,ne,pl,ma 1-6 */
#define IDX_FOR_TRN_PLU 5


/* 5 speed defines follow **********/

/* rp1 is Plt_in_12 below */
#define get_plt_in_12(i,k,m) (*(Plt_in_12+\
(i)*NUM_HOUSES_CONSIDERED*NUM_SIGNS+\
(k)*NUM_HOUSES_CONSIDERED+\
(m)))

#define get_plt_in_12_bestday(i,k,m) (*(Plt_in_12_bestday +\
(i)*NUM_HOUSES_CONSIDERED*NUM_SIGNS+\
(k)*NUM_HOUSES_CONSIDERED+\
(m)))


#define get_aspect_multiplier(i,k,m,n) (*(Aspect_multiplier+\
(i)*NUM_HOUSES_CONSIDERED*NUM_PLANETS*NUM_PLANETS_IN_EPH_FILES+\
(k)*NUM_HOUSES_CONSIDERED*NUM_PLANETS+\
(m)*NUM_HOUSES_CONSIDERED+\
(n)))

#define get_aspect_multiplier_bestday(i,k,m,n) (*(Aspect_multiplier_bestday+\
(i)*NUM_HOUSES_CONSIDERED*NUM_PLANETS*NUM_PLANETS_TRN_BESTDAY+\
(k)*NUM_HOUSES_CONSIDERED*NUM_PLANETS+\
(m)*NUM_HOUSES_CONSIDERED+\
(n)))



#define getGrhdata(i1,k1) (*(Grhdata+(i1)*Num_eph_grh_pts+(k1)))
#define putGrhdata(i2,k2,m2) (*(Grhdata+(i2)*Num_eph_grh_pts+(k2))=(m2))


/* #define get_sign(i) ((int)floor((i/60.0)/30.0)+1) */

/* end of futdefs.h */
