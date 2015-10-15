/* futdoc.c */

/* #import "tgmath.h"    in xcode required */

/* #include "rkdebug.h"  */
/*  #include "rkdebug_externs.h"  */

/*  NEW *   gets input specs from args  osdif*/

/* combines the old futursm2.c +futursmb.c */
/*******  OLD
   gets input specs from keyboard 
   calculates natal planetary positions 
   compares those against 6-month files of 
     future planetary positions 
   puts to stdout the aspect information 
  this is input to doc (awk   fmt_fut.awk )
*******/
/* #include "futuresm.h" */
/* #include "futtblsm.h" */


#include "futdoc.h"
#include <ctype.h>
#include <stdlib.h>



#define NUM_PTS_WHOLE_YEAR 184
#define SIZE_BIG_EPH_GRH_LINE 256 // 107  (about 184 + 7 + 1)
//char Grh_body[(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1)*MAX_GRH_BODY_LINES];
char Grh_body_BIG[(SIZE_GRH_LEFT_MARGIN + SIZE_BIG_EPH_GRH_LINE +1) * MAX_GRH_BODY_LINES]; // max=333

char Grh_bottom_line1BIG[256];
char Grh_bottom_line2BIG[256];
char Grh_bottom_line3BIG[256];

void prt_BIGgrh_line(char *p_line, int cols_with_pt[],int pt_ctr, int *p_ln_ctr, int top) ;
void reverse_BIGgrh_body_and_prt(void); /* grh used to have high stress at top */
void prt_BIGgrh_bot(char *p_line, int cols_with_pt[], int pt_ctr, int *p_ln_ctr);
void mk_BIGgrh_bottom(double mn,double dy,double yr);
void prt_BIGgrh_hdr(int grh_num); /* grh title and 2nd line */
void put_BIGgrh_blnk_lines_at_top(void);   /* top is now the bottom */
void put_BIGscale_mth(int col,int mn);
void put_BIGscale_dy(int col,int dy);
void put_BIGscale_yr(int col,int yr);
void put_BIGgrh_scale_dates(int col,int mn,int dy,int yr);
void put_BIGscale_mark_char(int col,int line); /* line is 1 or 2 */
void do_BIGfuture(void);

void get_BIGeph_data(int m,int d,int y); /* args unused ? */
void do_aBIG_graph(int p_grh[], int grh_num);   /* qqq */



/* below also in mambutil.c and futhtm.c */
#define IDX_FOR_BEST_YEAR 90
#define IDX_FOR_MYSTERIOUS 91
#define IDX_FOR_BEST_DAY 92
#define IDX_FOR_UPS_AND_DOWNS_2 93 /* fix 201311 */
#define IDX_FOR_SCORE_B 95   /* best day 2nd iteration */


#define MAX_SIZE_PERSON_NAME  15


extern int make_calendar_day_html_file(  /* this is in futhtm.c */
  char *html_f_file_name,
  char *csv_person_string,
  int  itarget_mm,
  int  itarget_dd,
  int  itarget_yyyy,
  int targetDayScore
);

/* these are in rkdebug.o */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);

/* in mambutil.o */
int mapBenchmarkNumToPctlRank(int benchmark_num);
void scharswitch(char *s, char ch_old, char ch_new);
void bracket_string_of(
  char *any_of_these,
  char *in_string,   
  char *left_bracket,
  char *right_bracket  );
extern int scharcnt(char *s, int c);
extern int mapNumStarsToBenchmarkNum(int category, int num_stars);
void get_event_details(  
  char   *csv_person_string,
  char   *event_name, 
  double *mn,
  double *dy,
  double *yr,
  double *hr,
  double *mu,
  int    *ap,
  double *tz,
  double *ln
);
extern void calc_chart(double mnarg, double dyarg, double yrarg,
  double hrarg, double muarg, int aparg,
  double tzarg, double lnarg, double ltarg);
extern char *sfromto(char *dest,char *src, int beg, int end);
extern void sfill(char *s, int num, int c);
extern int  sall(char *s,char *set);
extern void scharswitch(char *s, char ch_old, char ch_new);
extern char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);
extern char *mkstr(char *s,char *begarg,char *end);
extern char *swholenum(char *t, char *s);
extern char *sdecnum(char *t, char *s);
extern int sfind(char s[], char c);
extern char *scapwords(char *s);
extern void strsubg(char *s, char *replace_me, char *with_me);
/* in mambutil.o */


int mamb_report_year_in_the_life(  /* called from cocoa */
  char *html_f_file_name,
  char *csv_person_string,
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
);

int mamb_BIGreport_year_in_the_life(  /* called from cocoa */ 
  char *html_f_file_name,
  char *csv_person_string,
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
);


void process_input(char *csv_person_string);  /* prep for calc_chart() */

void do_day_stress_score_B(void);
void fill_eph_buf_score_B(void);


#define NUM_ARGS 2
int Just_did_good_line;
char Good_save[32];    /* chars to put back, '-' */

int in_stress, out_of_stress;  /* new in jan1993 */
char gbl_instructions[128];
int gbl_in_stress, gbl_out_of_stress;  /* new in sep2013 (best cal yr rpt) */

/* int is_target_day_completed(int iday_num); */  /* return 1=yes,0=no  iday_num is one-based */

void checkFortargetDayScore(int d_daynum, int current_score);
int gblTargetDayScore; /* for best day on ... rpt */
int gblWeHaveTargetDayScore; /* 1=yes,0=no */

char  gbl_yyyy_todo[128];
char  gbl_yyyymmdd_todo[128];
double gbl_bd_mth;  /* bd = best day */
double gbl_bd_day;
double gbl_bd_year;
char gbl_csv_person_string[256];
char gbl_save_last_line[2024]; /* */
char gbl_BuffYearStressScore[32];
                             /* manage month name overwrites for babies */
int  gbl_beg_last_mth_write; /* beg col of mth name last written */
int  gbl_end_last_mth_write; /* end col of mth name last written */
int  gbl_is_first_year_of_life;  /* year todo = birthyear */

/* ptr to end of str s (last char- not \0) */
#define PENDSTR(s) (&(s)[strlen((s))-1])
/* char *strim(); */


int is_first_f_docin_put;         /* 1=yes, 0=no */
int is_first_calloc_eph_space;    /* 1=yes, 0=no */
int is_first_set_grh_top_and_bot; /* 1=yes, 0=no */
int is_first_put_grh_scale_dates; /* 1=yes, 0=no */

int allow_docin_puts;  /* 1= yes, 0=no like for  "return only year stress score" */

/* old main()
* ===========================================================================
*/
int mamb_report_year_in_the_life(  /* called from cocoa */
  char *html_f_file_name,
  char *csv_person_string,
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
  )
{
/* tn();trn("in mamb_report_year_in_the_life"); */
  int n, retval;      /* n used everywhere for "f_docin_put(p, n);" */
  char *p = &Swk[0];  /* p used everywhere for "f_docin_put(p, n);" */
  char s[128];
  int tempnum_x;
  int tempnum_y;
  int tempnum_z;
  int worknum2;  /* calibrate stress score for return value */
/*  int worknum3; */ /* calibrate stress score for return value */
  ;

  is_first_f_docin_put         = 1;  /* 1=yes, 0=no */
  is_first_calloc_eph_space    = 1;  /* 1=yes, 0=no */
  is_first_set_grh_top_and_bot = 1;  /* 1=yes, 0=no */
  is_first_put_grh_scale_dates = 1;  /* 1=yes, 0=no */

  strcpy(gbl_csv_person_string, csv_person_string);

  char mybirthyear[8];
  strcpy(mybirthyear, csv_get_field(csv_person_string, ",", 4));
  if (strcmp(mybirthyear, year_todo_yyyy) == 0) {
    gbl_is_first_year_of_life = 1;  /* year todo = birthyear */
  } else {
    gbl_is_first_year_of_life = 0;
  }

  fopen_fpdb_for_debug();

 tn();tr("in mamb_report_year_in_the_life()"); 
ksn(html_f_file_name);
ksn(csv_person_string);
ksn(year_todo_yyyy);
ksn(instructions);



  if (strstr(instructions, "return only") == NULL) {
/*     trn("in mamb_report_year_in_the_life()"); */
  }  /* avoid dbmsg on non-rpt call */


  strcpy(gbl_instructions, instructions);

    /* note below:   NEW VERSION of DAY STRESS SCORE =  "B"
    *  gbl_instructions,  "return only day stress score_B")
    */
  if(strcmp(gbl_instructions,  "return only year stress score") == 0) {
    allow_docin_puts = 0;

    strcpy(gbl_yyyymmdd_todo, ""); 

    strcpy(year_in_the_life_todo_yyyy, year_todo_yyyy);

  } else if(strcmp(gbl_instructions,  "return only day stress score") == 0) {
    allow_docin_puts = 0;

    strcpy(gbl_yyyymmdd_todo, year_todo_yyyy); /* danger - re-use arg field here */
    /* (danger re-used arg has dd added to date) */

    strcpy(year_in_the_life_todo_yyyy, sfromto(s,&year_todo_yyyy[0],1,4));

    gbl_bd_mth  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    gbl_bd_day  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    gbl_bd_year = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));

  } else if(strcmp(gbl_instructions,  "return only day stress score_B") == 0) {
/* ksn(gbl_instructions);
* tn(); b(36); ks(stringBuffForStressScore);
* b(37);
* ki(gblTargetDayScore);
* b(4);
* b(38);
* ksn(gbl_csv_person_string);
* b(39);
*/
    allow_docin_puts = 0;

    strcpy(gbl_yyyymmdd_todo, year_todo_yyyy); /* danger - re-use arg field here */
    /* (danger re-used arg has dd added to date) */

    strcpy(year_in_the_life_todo_yyyy, sfromto(s,&year_todo_yyyy[0],1,4));

    gbl_bd_mth  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    gbl_bd_day  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    gbl_bd_year = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));

/* <.> */
  } else if(strcmp(gbl_instructions,  "do day stress report and return stress score") == 0) {
b(5);tn();ksn( gbl_csv_person_string);

    allow_docin_puts = 0;   /* so short we can hard code html with no docin_puts */

    strcpy(gbl_yyyymmdd_todo, year_todo_yyyy); /* danger - re-use arg field here */
    /* (danger re-used arg has dd added to date) */

    strcpy(year_in_the_life_todo_yyyy, sfromto(s,&year_todo_yyyy[0],1,4));

    gbl_bd_mth  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    gbl_bd_day  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    gbl_bd_year = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));
/* <.> */

  } else {                 /* "normal" fut run */
    allow_docin_puts = 1;

    strcpy(gbl_yyyymmdd_todo, ""); 

    strcpy(year_in_the_life_todo_yyyy, year_todo_yyyy);
  }


  gbl_in_stress     = 0;  /* init */
  gbl_out_of_stress = 0;  /* new in sep2013 */


  /* left-overs from input changes
  */
  fPI_OVER_2 = 3.1415926535897932384 / 2.0;
  sfill(&fEvent_name[0],SIZE_INBUF,' ');

  Num_fut_units_ordered = 2;   /* for a-year-in-the-life */

  /* get event details here
  */
  process_input(csv_person_string);  /* prep for calc_chart() */
  /*  input args to calc_chrt() 
  *  mth  date of birth 
  *  day 
  *  year 
  *  hour 
  *  minute 
  *  am,0 or pm,1 
  *  dob_city_diff_hrs_from_greenwich 
  *  dob_city_longitude 
  *  "0.0"  for latitude, take equator, equal house from mc 
  */
  calc_chart(fInmn,fIndy,fInyr,fInhr,fInmu,fInap,fIntz,fInln,fInlt);

  /*   f_display_positions(); for test  */

  GRH_BACKGROUND_CHAR = 88;  /* used to be arg */
  TITLE_LINE_CHAR     = 42;  /* used to be arg */

  /* do not worry about time of day confidence - say its 100% 
  */
  House_confidence = 1;
  Moon_confidence = 1;
  Moon_confidence_factor = 1.0; 

  /* fill natal position tbl, Ar_minutes_natal, incl mc
  */
  /* double Arco[14];        positions  are in following order:
  *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
  * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
  *
  *    BUT
  * Ar_minutes_natal[1]   sun
  * Ar_minutes_natal[2]   moo
  * Ar_minutes_natal[3]   mer
  * Ar_minutes_natal[4]   ven
  * Ar_minutes_natal[5]   mar
  * Ar_minutes_natal[6]   sat
  * Ar_minutes_natal[7]   jup
  * Ar_minutes_natal[8]   ura
  * Ar_minutes_natal[9]   nep
  * Ar_minutes_natal[10]  plu
  * Ar_minutes_natal[11]  nod
  * Ar_minutes_natal[12]  asc
  * Ar_minutes_natal[13]  mc_
  */
  put_minutes(&Ar_minutes_natal[0]); 

  /*  set aspect ranges */
  put_aspect_ranges(&Orbs_trn[0],&Orb_trn_adj_for_nat[0]);

  /* this is 1st output to docin file 
  */
  f_set_doc_hdr();  /* -- this is 1st output to docin file -- */

  Is_past = 0;    /* 0= doing future, not past */



    /* note below:   NEW VERSION of DAY STRESS SCORE =  "B"
    *  gbl_instructions,  "return only day stress score_B")
    */
  /* ########################################################### */
  if(strcmp(gbl_instructions,  "return only day stress score_B") == 0) {

    do_day_stress_score_B();  /* calcs  gblTargetDayScore; */

/* <.>
* tn();b(44);ki(worknum);
*     worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
* tn();b(45);ki(worknum);
*     worknum = mapBenchmarkNumToPctlRank(worknum);
* b(46);ki(worknum);
*       gblTargetDayScore= *(Grhdata_bestday + iday_num-1);
* <.>
*/

  } else if(strcmp(gbl_instructions,  "do day stress report and return stress score") == 0) {
b(6);
    int itarget_mm;
    int itarget_dd;
    int itarget_yyyy;

    do_day_stress_score_B();  /* calcs  gblTargetDayScore; */

    itarget_mm   = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    itarget_dd   = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    itarget_yyyy = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));

/* <.> */
    retval = make_calendar_day_html_file(  /* in futhtm.c */
      html_f_file_name,
      csv_person_string,
      itarget_mm,
      itarget_dd,
      itarget_yyyy,
      gblTargetDayScore
    );
kin(gblTargetDayScore);

    /* set up return value to mamb_report_year_in_the_life()
    */
    int worknum;  /* calibrate stress score for return value */

/*     worknum = gbl_stress_score_for_target_day; */
    worknum = gblTargetDayScore;
    worknum = worknum * -1; 
    worknum = worknum + 900;
    if (worknum <= 0) worknum = 1;
/* tn();b(44);ki(worknum); */
    worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
/* tn();b(45);ki(worknum); */
    worknum = mapBenchmarkNumToPctlRank(worknum);
/* b(46);ki(worknum); */

/* <.> */
    sprintf(stringBuffForStressScore, "%d", worknum);


    if (retval != 0) {
      f_docin_free();      /* free all allocated array elements */
      rkabort("Error: html file (fut) was not produced");
    }

    /* put back settings
    */
    gblTargetDayScore= 0; /* for best day on ... rpt */
    gblWeHaveTargetDayScore= 0; /* 1=yes,0=no */
    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
b(7);trn("small end");
    return(0);

  } else {
    do_future();    /* deep in here, eph_space ALLOCed */

  }

  /* ########################################################### */



  f_display_positions();  /* put on bottom of docin_lines */

  n = sprintf(p,"\n[end_program]\n");
  f_docin_put(p, n);

  free_eph_space();  /* free Grhdata, Grh_colnum, Eph_buf */

  /* for test  put all docin_lines to stderr
  */
  /* int ii;
  * for (ii = 0; ii <= docin_idx; ii++) {
  *   strcpy(Swk, docin_lines[ii] );
  *   fprintf(stderr,"%s", Swk);
  * } 
  */

/* fprintf(stderr,"%s|%s|%d|%d|%d|\n",  fEvent_name, year_in_the_life_todo_yyyy, */
/*     gbl_out_of_stress , gbl_in_stress, gbl_out_of_stress - gbl_in_stress); */
/*  for test, no html */


/* <.> */
    /* prepare stress score for ranking purposes.
    * 1.  + 8000 is to make all positive
    * 2.  / 87 is  to normalize to 100=median
    * 3.  map to standard benchmark numbers
    */

    tempnum_y = gbl_out_of_stress - gbl_in_stress;
    tempnum_y = (tempnum_y + 8000);
    if (tempnum_y < 0) tempnum_y = 0;
    tempnum_y = (tempnum_y / 123);

    /* 3. extern int mapNumStarsToBenchmarkNum(int category, int num_stars); */

    /* this is not num_stars, but rather,  gbl_out_of_stress - gbl_in_stress;
    */
    tempnum_y = mapNumStarsToBenchmarkNum(IDX_FOR_BEST_YEAR, tempnum_y);
    tempnum_y = mapBenchmarkNumToPctlRank(tempnum_y);


    /* intercept information for data request invocation
    */
    sprintf(stringBuffForStressScore, "%d", ((tempnum_y)));


/* <.> */
    strcpy(gbl_BuffYearStressScore, stringBuffForStressScore);
/* <.>
*     worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
* 
*     sprintf(stringBuffForStressScore, "%d", worknum);
* 
* <.>
*/



  /* we might be finished  #1  (no HTML file)
  */
  if(strcmp(gbl_instructions,  "return only year stress score") == 0) {



    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
    return(0);
  }

  /* we might be finished  #2  (no HTML file)
  */
  if(strcmp(gbl_instructions,  "return only day stress score") == 0) {

    /* prepare stress score for ranking purposes.
    * 1.  * -1  because used to be stress graph (high nums were stressful)
    *    * 10 for bigger numbers
    * 2.  +100 to make all positive
    * 3.  map to standard benchmark numbers
    */

    tempnum_x = gblTargetDayScore;
    tempnum_x = tempnum_x * -1; 
/*     tempnum_x = tempnum_x * 10; */
    tempnum_x = tempnum_x + 100;
    if (tempnum_x <= 0) tempnum_x = 1;

    /* this is not num_stars, but rather,  gbl_out_of_stress - gbl_in_stress;
    */
    tempnum_x = mapNumStarsToBenchmarkNum(IDX_FOR_BEST_DAY, tempnum_x);


/*     tempnum_x = (tempnum_x + 8000); */
/*     tempnum_x = (tempnum_x / 123); */

    /* 3. extern int mapNumStarsToBenchmarkNum(int category, int num_stars); */
/*     tempnum_x = mapNumStarsToBenchmarkNum(IDX_FOR_BEST_YEAR, tempnum_x); */


    /* intercept information for data request invocation
    */
    sprintf(stringBuffForStressScore, "%d", ((tempnum_x)));


    /* re-init stuff before leaving
    */
    gblTargetDayScore= 0; /* for best day on ... rpt */
    gblWeHaveTargetDayScore= 0; /* 1=yes,0=no */
    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
    return(0);
  }

/*   if (strcmp(gbl_instructions,  "return only day stress score_B") == 0) { */

/* <.>!*/
/* tn();trn("score_b end"); */
    /* prepare stress score for ranking purposes.
    * 1.  * -1  because used to be stress graph (high nums were stressful)
    *    * 10 for bigger numbers
    * 2.  +100 to make all positive
    * 3.  map to standard benchmark numbers
    */

    tempnum_z = gblTargetDayScore;
    tempnum_z = tempnum_z * -1; 

/* ki(tempnum_z); */
    tempnum_z = tempnum_z + 900;
    if (tempnum_z <= 0) tempnum_z = 1;

    tempnum_z = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, tempnum_z);


/* ki(tempnum_z); */

/*     tempnum_z = (tempnum_z + 8000); */
/*     tempnum_z = (tempnum_z / 123); */

    /* 3. extern int mapNumStarsToBenchmarkNum(int category, int num_stars); */


    /* intercept information for data request invocation
    */
    sprintf(stringBuffForStressScore, "%d", ((tempnum_z)));


/* <.> */
/*     sprintf(gbl_BuffYearStressScore,  "%d", ((tempnum_z))); */
/* tn();b(151);ksn(gbl_BuffYearStressScore); */



  if (strcmp(gbl_instructions,  "return only day stress score_B") == 0) {


/*     worknum2 = gblTargetDayScore; */
    worknum2 = atoi(stringBuffForStressScore);

/*     worknum2 = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum2); */

/* b(75);ki(worknum2); */
    worknum2 = mapBenchmarkNumToPctlRank(worknum2);
    sprintf(stringBuffForStressScore, "%d", worknum2);

    /* re-init stuff before leaving
    */
    gblTargetDayScore= 0; /* for best day on ... rpt */
    gblWeHaveTargetDayScore= 0; /* 1=yes,0=no */
    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
    return(0);
  }
/* <.>!*/


  /* tn();  ksn(" HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML "); */

  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML 
  */
  scharswitch(fEvent_name, ' ', '_');


  /* html_f_file_name is arg to mamb_report_year_in_the_life()
  */
/* <.> */
/* tn();b(17);
* ks(stringBuffForStressScore);
* ks(gbl_BuffYearStressScore);
*/

/*   worknum3 = atoi(stringBuffForStressScore);
* kin(worknum3);
*   worknum3 = mapBenchmarkNumToPctlRank(worknum3);
* kin(worknum3);b(172);
* 
*   sprintf(stringBuffForStressScore, "%d", worknum3);
* ksn(stringBuffForStressScore);
*   sprintf(gbl_BuffYearStressScore, "%d", worknum3);
* ksn(gbl_BuffYearStressScore);
*/

  retval = make_fut_htm_file(
    html_f_file_name,
    docin_lines,
    docin_idx,
    gbl_BuffYearStressScore,
    gbl_is_first_year_of_life
  );
/* <.> */

  if (retval != 0) {
    f_docin_free();      /* free all allocated array elements */
    rkabort("Error: html file (fut) was not produced");
  }


/* for test */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/





/* for test, show all docin lines */
/* tn();trn(" #################  ALL DOCIN LINES ##############");
* trn(" #################  ALL DOCIN LINES ##############");
* int jj; for (jj = 0; jj <= docin_idx; jj++) { 
*   kin(jj);
*   strcpy(Swk, docin_lines[jj] );
*   ks(Swk);
* }
*/
/*   close_fut_output_file(); */





  f_docin_free();      /* free all allocated array elements */


  if (strstr(instructions, "return only") == NULL) {
/*     trn("end of mamb_report_year_in_the_life()!"); */
  }  /* avoid dbmsg on non-rpt call */

  fclose_fpdb_for_debug();
  return(0);

} /* end of mamb_report_year_in_the_life()  - end of old main() */




void process_input(char *csv_person_string)   /* prep for calc_chart() */
{
/* trn(" in process_input()"); */
/* ksn(csv_person_string); */

  get_event_details(csv_person_string, fEvent_name, 
    &fInmn, &fIndy, &fInyr, &fInhr, &fInmu, &fInap, &fIntz, &fInln);
  if (fInhr == 12.0) fInhr = 0.0;  /* hour 12 must be 0 for calcchrt.c */

  /* get month and day to start the first graph
  * e.g.  "Delia,12,13,1971,12,15,0,-1,-19.05" 
  */

  /* get character versions of these
  */
  strcpy(mth_of_birth,  csv_get_field(csv_person_string, ",", 2));
  strcpy(day_of_birth,  csv_get_field(csv_person_string, ",", 3));
  strcpy(year_of_birth, csv_get_field(csv_person_string, ",", 4));

/* ksn(mth_of_birth); */
/* ksn(day_of_birth); */
/* ksn(year_of_birth); */

// NO privacy (determine yr of birth) , always start at jan 1
//  /* for year of birth, start at birthday
//  */
//  if (strcmp(year_in_the_life_todo_yyyy, year_of_birth) == 0) {
//    Fut_start_mn = atoi(mth_of_birth);
//    Fut_start_dy = atoi(day_of_birth); 
//  } else {
//    Fut_start_mn = 1;
//    Fut_start_dy = 1; /*  old was 2 */
//  }
//

    Fut_start_mn = 1;
    Fut_start_dy = 1; /*  old was 2 */

/* kin(Fut_start_mn); */
/* kin(Fut_start_dy); */
/* kin(Fut_start_yr); */

  Fut_start_yr = atoi(year_in_the_life_todo_yyyy);

}  /* end of process_input */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/* for test */ f_docin_free(); b(99);
return(0); /* for test */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* add a line to the array of docin_lines
*  replaces this:  fput(p,n,Fp_docin_file); 
*  
*  eg 1
*  * fput(p,n,Fp_docin_file); * 
* f_docin_put(p,n);
*    
*  eg 2
*  *fprintf(fFP_DOCIN_FILE,"\n[end_program]\n"); *
*  n = sprintf(p,"\n[end_program]\n");
*  f_docin_put(p, n);
*/
void f_docin_put(char *line, int length)
{

  if (allow_docin_puts == 0) return; /* (like pt of view) */
  
  if (is_first_f_docin_put == 1) docin_idx = 0;
  else                           docin_idx++;

  docin_lines[docin_idx] = malloc(length + 1);

  if (docin_lines[docin_idx] == NULL) {
    sprintf(errbuf, "malloc failed, arridx=%d, linelen=%d, line=[%s]\n",
      docin_idx, length, line);
    rkabort(errbuf);
  }

  strcpy(docin_lines[docin_idx], line);

  strcpy(gbl_save_last_line, line);


  is_first_f_docin_put = 0;  /* set to no */
  
  /* When this function finishes,
  * the index docin_idx points at the last line written.
  * Therefore, the current docin_lines written
  * run from index = 0 to index = docin_idx. (see f_docin_free() below)
  */
}

/* Free the memory allocated for every member of docin_lines array.
*/
void f_docin_free(void)
{
  int i;

  for (i = 0; i <= docin_idx; i++) {
    free(docin_lines[i]);    docin_lines[i] = NULL;
  }
  docin_idx = 0;
}


/* calcs beg and end pts of all aspects */
/* ptrs to ints (table of orbs and adj to orbs) */
void put_aspect_ranges(int *porbs, int *porb_adj)
{
  int i,k;
  ;
  for (k=1; k <= NUM_PLANETS; ++k) {
    for (i=1; i <= NUM_ASPECTS; ++i) {
      *(Beg_aspect_ranges+(k-1)*(NUM_ASPECTS+1)+i) = *(Aspects+i) - (*(porbs+i)+*(porb_adj+k));
      *(End_aspect_ranges+(k-1)*(NUM_ASPECTS+1)+i) = *(Aspects+i) + (*(porbs+i)+*(porb_adj+k));
    }
  }
}



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void open_fut_output_file(void)
* {
*   sfill(&Docin_pathname[0],SIZE_INBUF,' ');
*   strcpy(&Docin_pathname[0],&Arg_docin_dir[0]);
*   strcat(&Docin_pathname[0],DIR_CHAR);
*   strcat(&Docin_pathname[0],&Futin_filename[0]);
* 
*   if ((Fp_docin_file = fopen( &Docin_pathname[0] ,WRITE_MODE)) == NULL) {
*     rkabort("future.c. open_fut_output_file(). fopen(). ");
*   }
* }
* 
* void close_fut_output_file(void)
* {
*   fclose(Fp_docin_file);
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/



void do_future(void)
{
  char s[8+1];
  double dmn,ddy,dyr,dstep;
  int ido;
  ;
  sfill(s,8,' ');
  if (Fut_start_mn == 0) {    /* special signal from mk_fut_input.c */
    dmn = atof(sfromto(s,&Date_of_order_entry[0],5,6)); /* "yyyymmdd" */
    ddy = atof(sfromto(s,&Date_of_order_entry[0],7,8));
    dyr = atof(sfromto(s,&Date_of_order_entry[0],1,4));
  } else {
    dmn = (double) Fut_start_mn;
    ddy = (double) Fut_start_dy;
    dyr = (double) Fut_start_yr;
  }
/* trn("do_future() #1"); */
/* kd(dmn); kd(ddy); kd(dyr);  */

  init_rt();

  /* for each 6-month future ordered
  */
  for (ido=1; ido <= Num_fut_units_ordered; ido++) {
    global_flag_which_graph = ido;   /* 1 or 2 */

    if (ido == 1)  dstep = 0.0;   /* WARNING v undefined 1st time thru */
    else  dstep = (double)(NUM_PTS_FOR_FUT*Eph_rec_every_x_days);

    mk_new_date(&dmn,&ddy,&dyr,dstep);

/*   if (ido == 1) trn("==========   FIRST GRAPH  =============="); */
/*   if (ido == 2) trn("==========  SECOND GRAPH  =============="); */

    Grh_beg_mn = (int)dmn; /* to be adjusted- set_grh_top_and bot()  */ 
    Grh_beg_dy = (int)ddy; /* so that arg date jogs with eph file   */  
    Grh_beg_yr = (int)dyr; /* dates, e.g. past is on Wed       */  

    get_eph_data((int)dmn,(int)ddy,(int)dyr);  /* args unused ? */

    do_grh_calcs_and_prt();    /* central pgm  qqq  */

    do_paras();

    init_rt();

  } /*  for (ido=1; ido <= Num_fut_units_ordered; ido++) */

}  /* end of do_future() */


/* for 1 6-month future
*/
void get_eph_data(int m,int d,int y)  /* args unused ? */
{
  /* Only free eph_space stuff if calloc_eph_space has run already
  *  during this call to mamb_report_year_in_the_life()
  */
  if (is_first_calloc_eph_space == 1) {
    is_first_calloc_eph_space = 0;
  } else {
    free_eph_space();
  }

  Num_eph_grh_pts = (Is_past)? NUM_PTS_FOR_PAST: NUM_PTS_FOR_FUT;

  calloc_eph_space();

  Eph_rec_every_x_days = STEP_SIZE_FOR_FUT;

  fill_eph_buf();

}  /* end of get_eph_data() */


void calloc_eph_space(void)    /* for Grhdata[], fut_col_num[], all Futurepos recs */
{
  if ((Grhdata = (int *) 
    calloc((NUM_EPH_GRAPHS-1)*Num_eph_grh_pts,sizeof(int))) == NULL)
      rkabort("future.c  not enough memory for calloc Grhdata");

  if(strcmp(gbl_instructions,  "return only day stress score") == 0) {
    if ((Grhdata_bestday = (int *)  
      calloc((NUM_EPH_GRAPHS-1)*Num_eph_grh_pts,sizeof(int))) == NULL) {
        rkabort("future.c  not enough memory for calloc Grhdata_bestday");
    }
  }

  if ((Grh_colnum = (int *)
    calloc(Num_eph_grh_pts,sizeof(int))) == NULL)
      rkabort("future.c  not enough memory for calloc Grh_colnum");

  if ((Eph_buf =        /* v (add one for zeroth (ctrl) rec) */
    (struct Futureposrec*)
    calloc(Num_eph_grh_pts+1,sizeof(struct Futureposrec)))  == NULL)
      rkabort("future.c  not enough memory for calloc Eph_buf");


  if(strcmp(gbl_instructions,  "return only day stress score") == 0) {
    if ((Eph_buf_bestday =        /* v (add one for zeroth (ctrl) rec) */
      (struct Futureposrec_bestday*)
      calloc(Num_eph_grh_pts+1,sizeof(struct Futureposrec_bestday)))  == NULL) {
        rkabort("future.c  not enough memory for calloc Eph_buf_bestday");
      }
  }

}  

void free_eph_space(void)
{
  free(Eph_buf);    Eph_buf    = NULL;
  free(Grhdata);    Grhdata    = NULL;
  free(Grh_colnum); Grh_colnum = NULL;

  if(strcmp(gbl_instructions,  "return only day stress score") == 0) {
    free(Eph_buf_bestday);  Eph_buf_bestday = NULL;
    free(Grhdata_bestday);  Grhdata_bestday = NULL;
  }
}


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/*   void open_eph_file(int year)
* {
*     char eph_pathname[SIZE_INBUF+1];
*     ;
*     sfill(&eph_pathname[0],SIZE_INBUF,' ');
*     sprintf(&eph_pathname[0],"%s%s%d",
*       DIR_FOR_EPH_FILES,
*       (Is_past)? "p": "f",
*       year);
* 
*     if ((Fp_an_eph_file = fopen( &eph_pathname[0] ,READ_MODE_BINARY)) == NULL) {
*       rkabort("future.c. open_eph_file().");
*     }
* } 
*/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/*   void close_eph_file(void)
*   {
*     *     fclose(Fp_an_eph_file); *
*   }
* 
*   void get_ctrl_rec_stuff(void)
*   {
*     * read_eph(&mar_to_plu,0);  * ctrl rec * *
*     * OLD Eph_rec_every_x_days = mar_to_plu.positions[2]; *
*     Eph_rec_every_x_days = STEP_SIZE_FOR_FUT;
* 
* *     Eph_file_beg_mn = mar_to_plu.positions[3];
* *     Eph_file_beg_dy = mar_to_plu.positions[4];
* *     Eph_file_beg_yr = mar_to_plu.positions[5];
* *
* 
*   }
*/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* puts into str s "from m,d,y to m,d,y +step" */
/* e.g. "from 03sep84 to 15dec85" */
void sput_date_range(char *s, int m, int d, int y, int step)
{
  char sdate1[NUM_CHAR_DATE_RANGE+1],sdate2[NUM_CHAR_DATE_RANGE+1];
  double mn,dy,yr;
  ;
  sfill(sdate1,NUM_CHAR_DATE_RANGE,' ');
  sfill(sdate2,NUM_CHAR_DATE_RANGE,' ');
  sprintf(sdate1,"from %3s %02d, %04d", N_mth_cap[m], d, y);

  mn = (double)m;  dy = (double)d;  yr = (double)y;
  mk_new_date(&mn,&dy,&yr,(double)step);

  sprintf(sdate2," to %3s %02d, %04d",
           N_mth_cap[(int)mn], (int)dy, (int)y);

  strcpy(s,strcat(sdate1,sdate2));
}

/* populate 3 strings  Grh_bottom_array at graph bottom. Look like this:
*   (size 99 chars  with 7 chars in lf_mar[] )
*       |   |    |     |    |    |   |    |    |     |   |    |     |   |    |     |    |    |    |    |    
*       |   10   20    |    11   21  |    11   21    |   10   20    |   10   20    |    11   21   |    11   
*  2013 jan            feb           mar             apr            may            jun            jul       
*    #define SIZE_GRH_LEFT_MARGIN 7
*    #define SIZE_EPH_GRH_LINE 107
*    #define NUM_PTS_FOR_FUT 92
*    #define NUM_GRH_BOTTOM_LINES 3
*  char Grh_bottom_line1[SIZE_EPH_GRH_LINE+1];  *  +1 for \0*
*/
void mk_grh_bottom(double mn,double dy,double yr)
{
  double dstep;
  int ibot;
  char mywk[SIZE_EPH_GRH_LINE + 1];
  ;
/* trn("in mk_grh_bottom(double mn,double dy,double yr"); */

  /* populate lines with blanks into Grh_bottom_line s
  */
  if (Num_eph_grh_pts == NUM_PTS_WHOLE_YEAR) {  // do big graph
    sfill(mywk, NUM_PTS_WHOLE_YEAR, ' ');  /* line size without left margin */
    strcpy(Grh_bottom_line1BIG, mywk); 
    strcpy(Grh_bottom_line2BIG, mywk); 
    strcpy(Grh_bottom_line3BIG, mywk); 

  } else {
    sfill(mywk, NUM_PTS_FOR_FUT, ' ');  /* line size without left margin */
    strcpy(Grh_bottom_line1, mywk); 
    strcpy(Grh_bottom_line2, mywk); 
    strcpy(Grh_bottom_line3, mywk); 
  }

/* trn("------- after init bottom lines:");
* ksn(Grh_bottom_line1);
* ksn(Grh_bottom_line2);
* ksn(Grh_bottom_line3);
*/

  put_grh_scale_dates(0,(int)mn,(int)dy,(int)yr);  /* 1st column */

  for (ibot=1; ibot <= Num_eph_grh_pts-1; ibot++) {  /* 1= start with 2nd col */

    dstep = (double)(Eph_rec_every_x_days);
    mk_new_date(&mn,&dy,&yr,dstep);

    put_grh_scale_dates(ibot,(int)mn,(int)dy,(int)yr);
  }
} /* end of mk_grh_bottom(double mn,double dy,double yr) */


/* put_grh_scale_dates()
* 
*       |   |    |     |    |    |   |    |    |     |   |    line 1
*       |   10   20    |    11   21  |    11   21    |   10   line 2
*  2013 jan            feb           mar             apr      line 3
*---------------------------------
*         1         2         3   
*123456789 123456789 123456789 123
*---------------------------------
*/
void put_grh_scale_dates(int col,int mn,int dy,int yr)
{ 

  /* on "J" in january, put 2 scale mark chars
  * also, no "sideline out" on these
  *       if (global_flag_which_graph != 1) {  * leave pipes on "J" in Jan *
  */
  if (global_flag_which_graph == 1 && col == 0) {
    put_scale_mark_char(col,1);
    put_scale_mark_char(col,2);
  }


/*   if (global_flag_which_graph == 2  &&  times_thru3 == 0) { */
/*     times_thru3++; */

  /* add scale_mth (jul) on first star of second graph
  */
  if (global_flag_which_graph == 2 && is_first_put_grh_scale_dates == 1) {
    is_first_put_grh_scale_dates = 0;
    put_scale_mth(col,mn);
    return;
  }

  if (dy >= 1  &&  dy <= Eph_rec_every_x_days) { /* beg of new mth */
    if(mn == 1) {      /* beg of january */
      if(col == 0) {  /* 1st column */
        /* jan wrt only when beg of line */
/*         put_scale_mth(col,mn); */
        put_scale_mth(col,mn);  /* jan wrt only when beg of line */
        return;
      }
      put_scale_yr(col,yr);  /* wrt yr instead of jan */
      return;
    }
    put_scale_mth(col,mn);    /* wrt mth */
    return;
  }
  if (Is_past) return;  /* don't put 10, 20 */
  if (dy >= 10  &&  dy <= 10 + (Eph_rec_every_x_days-1)) {
    put_scale_dy(col,dy);
    return;
  }
  if (dy >= 20  &&  dy <= 20 + (Eph_rec_every_x_days-1)) {
    put_scale_dy(col,dy);
    return;
  }
}  /* put_grh_scale_dates() */


void put_scale_mth(int col,int mn)
{
  int line, len;
  ;
  line = 2;  /* fut */
  if (Is_past) line = 1;

  put_scale_mark_char(col,1);

  if (Is_past == 0) put_scale_mark_char(col,2);


  if (col >= Num_eph_grh_pts-1-1) return; { /* no room on line */

/*   for (i=1; i <= 3; ++i) {  * eg  3= jan feb * */
/*     *(Date_array+line*SIZE_EPH_GRH_LINE+col+(i-1)) = *(N_mth[mn]+(i-1)); */
/*   }    * ^on 3rd bottom line (line = 2) */

  /* put month names */
  /* Jan, Feb etc */

/*  memcpy(Grh_bottom_line3 + col, N_mth[mn], 3);*/  /* jan, feb etc */
/*   memcpy(Grh_bottom_line3 + col, N_mth_cap[mn], 3);   */
  /* Thu 29 May 2014 12:09:27 EDT */
  /* Jan, Feb etc */
/*   memcpy(Grh_bottom_line3 + col, N_mth_allcaps[mn], 3);  */



 len = (int)strlen(N_allcaps_long_mth[mn]); 
/*  tn();kin(len);ksn(N_allcaps_long_mth[mn]);  */

  /* if it's going to be an overwrite put spaces
  *  (only happens for first mth name on line)
  */
  int current_beg_mth_write;
  current_beg_mth_write = col;
/* kin(current_beg_mth_write ); */
  if (current_beg_mth_write <= gbl_end_last_mth_write) {
/* trn("WRITE SPACES!"); */
    memcpy(Grh_bottom_line3 + gbl_beg_last_mth_write, "                             ", 25);  
  }

/*   memcpy(Grh_bottom_line3 + col, N_allcaps_long_mth[mn], len);   */
  memcpy(Grh_bottom_line3 + col+1, N_allcaps_long_mth[mn], len);  

  gbl_beg_last_mth_write = col;       /* beg col of mth name last written */
  gbl_end_last_mth_write = col + len - 1 ;/* end col of mth name last written */

/* ki(gbl_beg_last_mth_write); ki(gbl_end_last_mth_write); */


/* ksn("line3 after mth:");
* ki(strlen(Grh_bottom_line3));
* ksn(Grh_bottom_line3);
*/
  }  /* put month names */


} /* end of put_scale_mth() */


void put_scale_dy(int col,int dy)
{
  char s[3];
  ;
  put_scale_mark_char(col,1);
  sprintf(s,"%02d",dy);

/*   for (i=1; i <= 2; i++) { */
/*     *(Date_array+SIZE_EPH_GRH_LINE+col+(i-1)) = *(s+(i-1)); */
/*   } */

  memcpy(Grh_bottom_line2 + col, s, 2);   /* 10,11,20,21 */
/* ksn("line2 after day:");
* ki(strlen(Grh_bottom_line2));
* ksn(Grh_bottom_line2);
*/

} /* end of put_scale_dy() */


void put_scale_yr(int col,int yr)
{
  char s[5];
  ;
  put_scale_mark_char(col,1);
  put_scale_mark_char(col,2);

  
  /* with new 92 star graph, no room for next year
  */
  /*   return; */

  /* UNLESS col (max 92) is  <=89 (4 chars)
  */
  if (col > Num_eph_grh_pts - 3) return;

/*   sprintf(s,"%02d",(yr-(yr/100*100))); */
/*   for (i=1; i <= 4; i++) { */
/*     *(Date_array+2*SIZE_EPH_GRH_LINE+col+(i-1)) = *(s+(i-1)); */
/*   } */

  sprintf(s,"%04d",yr);

  memcpy(Grh_bottom_line3 + col, s, 4);   /* 2013 */
/* ksn("line3 after day:");
* ki(strlen(Grh_bottom_line3));
* ksn(Grh_bottom_line3);
*/
} /* end of put_scale_yr() */


void put_scale_mark_char(int col,int line) /* line is 1 or 2 */
{
/*   *(Date_array+(line-1)*SIZE_EPH_GRH_LINE+col) = SCALE_MARK_CHAR; */

  if(line == 1)  memcpy(Grh_bottom_line1 + col, "|", 1);  
  if(line == 2)  memcpy(Grh_bottom_line2 + col, "|", 1);  
/*   if(line == 1)  memcpy(Grh_bottom_line1 + col, "@", 1);   */
/*   if(line == 2)  memcpy(Grh_bottom_line2 + col, "@", 1);   */
}


/* for 1 6-month future
*/
void fill_eph_buf(void) 
{
/* trn(" in fill_eph_buf "); */
  /* init */
  gbl_beg_last_mth_write = 0; /* beg col of mth name last written */
  gbl_end_last_mth_write = 0; /* end col of mth name last written */
  set_grh_top_and_bot();

  fill_eph_buf_by_calc();   /* NEW NEW NEW NEW NEW NEW NEW NEW NEW */

}  /* end of fill_eph_buf() */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/*   int j,eph_jd,grh_jd,eph_year_open;
*      top of  fill_eph_buf() 
*   long recnum,size;
*   ;
* 
*   eph_year_open = Grh_beg_yr;
*   eph_jd = (int)day_of_year((double)Eph_file_beg_yr,
*                 (double)Eph_file_beg_mn,
*                 (double)Eph_file_beg_dy);
*   grh_jd = (int)day_of_year((double)Grh_beg_yr,
*                 (double)Grh_beg_mn,
*                 (double)Grh_beg_dy);
*   for (recnum=1, j=eph_jd; j < grh_jd; ++recnum) {
*     j += Eph_rec_every_x_days;
*   }
*   recnum = recnum-1;    * the for goes one past the target *
*   if (grh_jd <= eph_jd) recnum=1;  * don't open eph file yr before *
*/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/*  ***
*      bot of  fill_eph_buf() 
*   fiseek(Fp_an_eph_file,(recnum-1)*size); * skip to right eph file record *
*   ***
*   size = sizeof(struct Futureposrec);  * num char in an eph file record *
*   fseek(Fp_an_eph_file,(recnum-1)*size,SEEK_CUR);
*     * skip to the right eph file record *
* 
*   for (k=1; k <= Num_eph_grh_pts; k++) {
*     if (read_eph(Eph_buf,k) == 0) {  * 0 = eof *
*       close_eph_file();
*       open_eph_file(++eph_year_open);
*       get_ctrl_rec_stuff();  * skip ctrl rec *
*       if (read_eph(Eph_buf,k) == 0)
*         rkabort("future.c. fill_eph_buf().");
*     }
*   }
*/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* Instead of the commented out stuff below with pre-calc eph files,
*  call calc_chart() Num_eph_grh_pts times and fill in 
*  Eph_buf, which is defined as ptr to struct Futureposrec:
*
*    struct Futureposrec *Eph_buf;   * ptr to current buffer for /eph file *
*
*  and which was calloc'd like this: 
*
*    Eph_buf = (struct Futureposrec*)calloc(
*               Num_eph_grh_pts+1, sizeof(struct Futureposrec))
*
*        (add one for zeroth (ctrl) rec) 
*        
*  Futureposrec (for mar -> plu) is this:      
*
*    struct Futureposrec {int positions[NUM_PLANETS_IN_EPH_FILES];};
*
*
*  Eph_buf ACCESS -   Eph_buf[k].positions[m] 
*                 or
*                    (Eph_buf+k)->positions[m]
*
* 2 other tables calloc'd in get_future_data(),
* both for size= Num_eph_grh_pts  ints
*   int *Grhdata; 
*   int *Grh_colnum;
*/
void fill_eph_buf_by_calc(void)
{
  double m,d,y,step;
  int grh_pt, idx , minits;
  /*   int testmoon, testsun, testidx; */

  /* init */
  gbl_beg_last_mth_write = 0; /* beg col of mth name last written */
  gbl_end_last_mth_write = 0; /* end col of mth name last written */

  step = (double) Eph_rec_every_x_days;

  /* init first day to calc */
  m = (double) Grh_beg_mn;
  d = (double) Grh_beg_dy;
  y = (double) Grh_beg_yr;


  /* for all pts in one graph  -------------------------------------
  */
  for (grh_pt=1; grh_pt <= Num_eph_grh_pts; grh_pt++) {

    /* if ( grh_pt % 10 == 0) {
    *   trn("every 10"); ki(grh_pt); kd(y);kd(m);kd(d); ki(testsun);
    * }
    */

    /* calculate planetary positions for 12:01 pm on given day
    * 
    * for 12:01 pm - have to put 0.0 for arg 4 (hr)
    * 
    * calc_chart(m,d,y,12.0,1.0,1.0,0.0,0.0,0.0);
    */
    calc_chart(m,d,y,0.0,1.0,1.0,0.0,0.0,0.0);/* calcchrt.c wants 0 for hr=12*/

    /* put mar (0) to plu (5)  positions into   ------------
    *  Eph_buf Futureposrec struct member positions
    */
    for (idx=0; idx <= NUM_PLANETS_FOR_FUTURE-1; ++idx) { 
      /* testsun = get_minutes(Arco[1]);
      * testmoon = get_minutes(Arco[10]);
      * testidx = grh_pt;
      */
      /* double Arco[14];        positions  are in following order:
      *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
      * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
      *                       x                          
      */

      minits = get_minutes(Arco[idx + 4]);
      (Eph_buf + grh_pt)->positions[idx] = minits;   /* <=== */
    }



/* <.>put every day, not every 2 ! */


    /* if necessary, put positions of _bestday transiting planets sun,mer,ven,moo
    *  into Eph_buf_bestday
    */
    if(strcmp(gbl_instructions,  "return only day stress score") == 0) {

      for (idx=1; idx <= 3; ++idx) {   /*  sun,mer,ven  (in Arco) */
        /* double Arco[14];        positions  are in following order:
        *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
        * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
        *                       x                          
        */
        minits = get_minutes(Arco[idx]);
        (Eph_buf_bestday + grh_pt)->positions[idx-1] = minits;   /* <=== */

/* <.> */
/* if (idx == 1) { */
/* int mydeg; mydeg = (Eph_buf_bestday + grh_pt)->positions[idx-1] / 60; */
/* int mysgn; mysgn = (mydeg / 30) + 1; */
/*            mydeg = mydeg - ((mysgn - 1) * 30); */
/*  kin(grh_pt);ki(mysgn);ki(mydeg);  */
/* } */


      }
      minits = get_minutes(Arco[10]);   /* Arco [10] = moon, positions [3] = moon */
      (Eph_buf_bestday + grh_pt)->positions[3] = minits;   /* <=== */


    }

    mk_new_date(&m,&d,&y,step);

  }  /* for all pts in one graph */

  /* kin(testidx); ki(testsun); ki(testmoon); */

} /* end of fill_eph_buf_by_calc() */



void set_grh_top_and_bot()
{
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/*   double dmn,ddy,dyr,dstep;
*   ;
*   dmn = (double)Eph_file_beg_mn;
*   ddy = (double)Eph_file_beg_dy;
*   dyr = (double)Eph_file_beg_yr;
*   dstep = (double)(recnum*Eph_rec_every_x_days);
* 
*   mk_new_date(&dmn,&ddy,&dyr,dstep);
* 
*   Grh_beg_mn = (int)dmn;  * prev grh_beg date was arg date *
*   Grh_beg_dy = (int)ddy;  * now it jogs with eph date *
*   Grh_beg_yr = (int)dyr;  * e.g. fut dates are on Wed *
*/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

  if (is_first_set_grh_top_and_bot == 1) {
    is_first_set_grh_top_and_bot = 0;

    /*     Grh_beg_mn = 1; */
    /*     Grh_beg_dy = 1;  */

// NO  privacy  20150211  can infer birth info
//    /* get month and day to start the first graph
//    */
//    if (strcmp(year_in_the_life_todo_yyyy, year_of_birth) == 0) {
//      Grh_beg_mn = atoi(mth_of_birth);
//      Grh_beg_dy = atoi(day_of_birth); 
//    } else {
//      Grh_beg_mn = 1;
//      Grh_beg_dy = 1; /*  old was 2 */
//    }
//
      Grh_beg_mn = 1;
      Grh_beg_dy = 1; /*  old was 2 */

    Grh_beg_yr =  atoi(year_in_the_life_todo_yyyy);

  }  else {
    ;  /* start date for 2nd graph was set at the top of do_future() */
  }

  sput_date_range(
    &Grh_title_dates[0],
    Grh_beg_mn,
    Grh_beg_dy,
    Grh_beg_yr,
    (Num_eph_grh_pts-1) * Eph_rec_every_x_days
  );

  if (Num_eph_grh_pts == NUM_PTS_WHOLE_YEAR) {  // do big graph
    mk_BIGgrh_bottom((double)Grh_beg_mn,(double)Grh_beg_dy,(double)Grh_beg_yr);
  } else {
    mk_grh_bottom((double)Grh_beg_mn,(double)Grh_beg_dy,(double)Grh_beg_yr);
  }

} /* end of  set_grh_top_and_bot() */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* offset= which rec to read e.g. &mar_to_plu+3 is the 4th */
* /* mar_to_plu record */
* int read_eph(struct Futureposrec *pbuf,int offset)
* {
*   int size;
*   struct Futureposrec *p = pbuf;
*   ;
*   size = sizeof(struct Futureposrec);
*   if (fget(p+offset,size,Fp_an_eph_file) < size)
*     return(0);
*   else 
*     return(1);
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* ****************  more on do_grh_calcs_and_prt()
*             &&  (k % FUT_GRH_PT_EVERY_X_RECS) == 0) { 
* above line taken out of the if since it's true in all foreseeable circumstances
*   do_future(ptr to beg of fut pos structs)
*   for (each trn plt - mar thru plu)
*     for (each fut day - 1 thru 6 months worth of days) right now, 
*       for (each natal plt - sun thru plu)    1 rec = 1 day
*         is_aspect(1 between this trn plt
*               2 on this fut day
*               3 and this natal plt
*               4 using these orbs )
*         keep_track() of aspects as we go along in the running_table
*         if (there is an aspect  and  day is even)
*           do fut graph calculations
*/
void do_grh_calcs_and_prt(void)
{
/* trn("in do_grh_calcs_and_prt()"); */
  int itrn_plt, inatal_plt, iday_num, aspect_num ;
  int starting_natal_plt;
/*   int do_world_affairs_nat_plts; */
/*   int minutes_difference; */

  starting_natal_plt = 1;  /* set default */


  /* do REGULAR TRANSITING PLANETS  mar,jup,sat,ura,nep,plu
  */
  for (itrn_plt=1; itrn_plt <= NUM_PLANETS_IN_EPH_FILES; ++itrn_plt)    {  /* trn_plt */

    for (iday_num=1; iday_num <= Num_eph_grh_pts; ++iday_num)      {       /* day_num */


/* <.> for test ! */
/* if (itrn_plt == 1) {  */
/* int mydeg; mydeg = (Eph_buf+ iday_num)->positions[itrn_plt-1] / 60; */
/* int mysgn; mysgn = (mydeg / 30) + 1; */
/*            mydeg = mydeg - ((mysgn - 1) * 30); */
/*  kin(iday_num);ki(mysgn);ki(mydeg);  */
/* } */



          /* in double Arco[14];  natal positions  are in following order:
          *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
          * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
          *
          *    BUT in Ar_minutes_natal[] ,
          * Ar_minutes_natal[1]   sun
          * Ar_minutes_natal[2]   moo
          * Ar_minutes_natal[3]   mer
          * Ar_minutes_natal[4]   ven
          * Ar_minutes_natal[5]   mar
          * Ar_minutes_natal[6]   sat
          * Ar_minutes_natal[7]   jup
          * Ar_minutes_natal[8]   ura
          * Ar_minutes_natal[9]   nep
          * Ar_minutes_natal[10]  plu
          * Ar_minutes_natal[11]  nod
          * Ar_minutes_natal[12]  asc
          * Ar_minutes_natal[13]  mc_
          */
      /* ordinary run  does natal plts 1-10  sun,moo,mer,ven,mar,jup,sat,ura,nep,plu
      *  world affairs does natal plts 5-10                  mar,jup,sat,ura,nep,plu
      */
/*       do_world_affairs_nat_plts = 1;
*       if (do_world_affairs_nat_plts == 1) starting_natal_plt = 5;
*/

      /* for (inatal_plt=1; inatal_plt <= NUM_PLANETS; ++inatal_plt) {  */
      /*  (NUM_PLANETS is 10) */
      for (inatal_plt=starting_natal_plt; inatal_plt <= NUM_PLANETS; ++inatal_plt) {

        
/*         if (do_world_affairs_nat_plts == 1) {
*           Ar_minutes_natal[ 5] = (Eph_buf+iday_num)->positions[ 0];
*           Ar_minutes_natal[ 6] = (Eph_buf+iday_num)->positions[ 1];
*           Ar_minutes_natal[ 7] = (Eph_buf+iday_num)->positions[ 2];
*           Ar_minutes_natal[ 7] = (Eph_buf+iday_num)->positions[ 3];
*           Ar_minutes_natal[ 9] = (Eph_buf+iday_num)->positions[ 4];
*           Ar_minutes_natal[10] = (Eph_buf+iday_num)->positions[ 5];
*         }
*/


/* <.>trn_plt  why = 1 and not zero  test result -> leave it */
/*           abs((Eph_buf+iday_num)->positions[itrn_plt-1] - Ar_minutes_natal[inatal_plt]), */

        aspect_num = isaspect(
          abs((Eph_buf+iday_num)->positions[itrn_plt] - Ar_minutes_natal[inatal_plt]),
          (inatal_plt-1)*(NUM_ASPECTS+1)
        );

        do_rt(inatal_plt, aspect_num, itrn_plt, iday_num); /* keep_track() of aspects as we go along in the running_table */

        if(aspect_num != 0) {   /* add_aspect_to_grhdata() */ 
          add_aspect_to_grhdata(inatal_plt, aspect_num, itrn_plt, iday_num);
        }
      } /* natal_plt */
    } /* day_num in 6 months of graph */
  } /* trn_plt */

/* <.>! */
  if(strcmp(gbl_instructions,  "return only day stress score") == 0) {

/* tn();ksn(gbl_csv_person_string); tn(); */
    /* do BESTDAY TRANSITING PLANETS  sun,mer,ven,moo
    */
    /* #define NUM_PLANETS_TRN_BESTDAY 4      4 sun,mer,ven,mo10,mo01,mo04,mo07 */
    for (itrn_plt=0; itrn_plt <= NUM_PLANETS_TRN_BESTDAY-1; ++itrn_plt) {  /* 0->3 */

      for (iday_num=1; iday_num <= Num_eph_grh_pts; ++iday_num)      {   /* day_num */

            /* in double Arco[14];  natal positions  are in following order:
            *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
            * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
            *
            *    BUT in Ar_minutes_natal[] ,
            * Ar_minutes_natal[1]   sun
            * Ar_minutes_natal[2]   moo
            * Ar_minutes_natal[3]   mer
            * Ar_minutes_natal[4]   ven
            * Ar_minutes_natal[5]   mar
            * Ar_minutes_natal[6]   sat
            * Ar_minutes_natal[7]   jup
            * Ar_minutes_natal[8]   ura
            * Ar_minutes_natal[9]   nep
            * Ar_minutes_natal[10]  plu
            * Ar_minutes_natal[11]  nod
            * Ar_minutes_natal[12]  asc
            * Ar_minutes_natal[13]  mc_
            */

            /* TRANSITING PLT POSITIONS  in Eph_buf_bestday
            *  struct Futureposrec_bestday{   * NEW *
            *  int positions[NUM_PLANETS_TRN_BESTDAY];   * 4 sun,mer,ven,mo10,mo01,mo04,mo07 
            *                                          index   0   1   2   3    4    5    6
            *  };
            */

        /*  (NUM_PLANETS is 10) */
        for (inatal_plt=1; inatal_plt <= NUM_PLANETS; ++inatal_plt) {

          aspect_num = isaspect(
            abs((Eph_buf_bestday+iday_num)->positions[itrn_plt] - Ar_minutes_natal[inatal_plt]),
            (inatal_plt-1)*(NUM_ASPECTS+1)
          );


          /* show aspects for a trn_plt
          */
          /* <.> test if isaspect works */
          /* <.> for test ! */
          /* if (itrn_plt == 3 && aspect_num != 0) {  */
          /* int mydeg; int mysgn; char myasp[8]; */
          /* mydeg = (Eph_buf_bestday+iday_num)->positions[itrn_plt] / 60; */
          /* mysgn = (mydeg / 30) + 1; */
          /* mydeg = mydeg - ((mysgn - 1) * 30); */
          /* strcpy(myasp, N_aspect[aspect_num]); */
          /* ksn(myasp);tr("  trn");ki(iday_num); ki(itrn_plt);ki(mysgn);ki(mydeg);  */
          /* mydeg = Ar_minutes_natal[inatal_plt] / 60; */
          /* mysgn = (mydeg / 30) + 1; */
          /* mydeg = mydeg - ((mysgn - 1) * 30); */
          /* tr("   nat");ki(inatal_plt);ki(iday_num);ki(mysgn);ki(mydeg);  */
          /* } */


          if(aspect_num != 0) {   /* add_aspect_to_grhdata() */ 
            add_aspect_to_grhdata_bestday(inatal_plt, aspect_num, itrn_plt, iday_num);
          }

        } /* natal_plt */
      } /* day_num in 6 months of graph */
    } /* trn_plt */

/* <.>!here grab return value for new calendar day rpt */


  } /*   if(strcmp(gbl_instructions,  "return only day stress score") == 0)  */


  do_grhs();   /*  qqq   print graph  */



/* <.>  show all grhdata_bestday */
/*       *(Grhdata+igrh*Num_eph_grh_pts+n) /= SIZE_EPH_GRH_INCREMENT; */
/*       this_num = *(Grhdata+igrh*Num_eph_grh_pts+n); */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* static int mytimes; mytimes++;
*   double dmn,ddy,dyr,dstep;
*     dstep = (double)(Eph_rec_every_x_days);
*     dmn = (double) Fut_start_mn;
*     ddy = (double) Fut_start_dy;
*     dyr = (double) Fut_start_yr;
* if (mytimes == 2 ) mk_new_date(&dmn,&ddy,&dyr,dstep+92*2-2);
* 
* for (iday_num=1; iday_num <= Num_eph_grh_pts; ++iday_num) {
* 
* fprintf(stderr,"%s|%d|%04d|%02d|%02d|%d|\n",  fEvent_name, iday_num,
*     (int)dyr,
*     (int)dmn,
*     (int)ddy,
*     *(Grhdata_bestday + (iday_num-1) )
* );
* 
*     mk_new_date(&dmn,&ddy,&dyr,dstep);
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
/* <.>  show all grhdata_bestday */

} /* void do_grh_calcs_and_prt(void) */



/* more on is_aspect() 
* 
*   double Current_aspect_force  (0.0 THRU 1.0) *
*         ( pi     orb_in_minutes - diff_from_exact  )
*     sin ( --   x --------------------------------  )
*         ( 2        orb_in_minutes                  )
* 
*   note: sin(pi/2) = 1
*   defined in isaspect(), used in add_aspect_to_grhdata()
* 
*
* mdiff= diff in minutes of planets 1 and 2 
* subscript for right row in beg_aspect_ranges[]
*                     and in end_aspect_ranges[]
*/
int isaspect(int mdiff,int right_row)
{
  int iasp;
  int *p = Beg_aspect_ranges;
  int *q = End_aspect_ranges;
  double dorb;
  ;
  for (iasp=1; iasp <= NUM_ASPECTS; ++iasp) {

    if (mdiff > *(q+right_row+iasp)) continue;   /*keeplooking*/
    if (mdiff < *(p+right_row+iasp)) return(0);  /*noaspect*/

    dorb = (double) ( (*(q+right_row+iasp) - 
               *(p+right_row+iasp))/2 );     /* (a-b)/2 */


/* int mydiff; mydiff = (*(Aspects+iasp)-mdiff); */
/* int mya,myb; */
/* mya = *(Aspects+iasp); */
/* myb = mdiff; */
/* kdn(dorb); */
/* ki(mya);ki(myb); ki(mydiff); */


    Current_aspect_force = 
      sin(fPI_OVER_2 * (dorb-fabs((double)(*(Aspects+iasp)-mdiff)))/dorb);

    return(Aspect_id[iasp]);  /* found aspect */
  }
  return(0);    /* return of zero means no aspect found */

}  /* end of isaspect() */



/* Arco array is from calc_chart().
*     Arco `coordinates' are in following order: 
*     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
*     positions are in radians
*
* void put_minutes(int *pi) 
*   puts positions in minutes 0 thru 360*60-1
*   into a planet position table
*   
*   pi arg  is ptr to ints (position table #1 or #2) 
*/
      /* double Arco[14];        positions  are in following order:
      *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
      * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
      */
void put_minutes(int *pi) 
{
  int imin;
  ;
  *(pi+1) = get_minutes(Arco[1]);    /* sun */
  *(pi+2) = get_minutes(Arco[10]);  /* moon */
  for (imin=3; imin <= NUM_PLANETS; ++imin) {  /* 3->10 (mer->plu) */
    *(pi+imin) = get_minutes(Arco[imin-1]);
  }
  *(pi+11) = get_minutes(Arco[11]);  /* nod */
  *(pi+12) = get_minutes(Arco[12]);  /* asc */
  *(pi+13) = get_minutes(Arco[13]);  /* mc_ */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   Prt_retro[1] = Retro[1];  /* these array elements are strings */
*   Prt_retro[2] = Retro[10];  /* moon */
*   for (i=3; i <= NUM_PLANETS; ++i) {  /* 3->10 */
*     Prt_retro[i] = Retro[i-1];
*   }
*   Prt_retro[11] = Retro[11];
*   Prt_retro[12] = Retro[12];
*   Prt_retro[13] = Retro[13];
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
}  /* end of put_minutes() */

int get_minutes(double d)
{
  /***
  return((int)round(60.0 * fnu(fnd(d) + 360.0)));  * converted to int *
  ***/
  return((int)ceil(60.0 * fnu(fnd(d) + 360.0)));  /* converted to int */
} 

/* add_aspect_to_grhdata()  fills in Grhdata[][] 
*
* Integral to following fn are defines in as_defines.h
*       for get_plt_in_12() and get_aspect_multiplier
*/
void add_aspect_to_grhdata(int nat_plt,int aspect_num,int trn_plt,int day_num) 
{
  int ical;
  int addval;
  double a,b,c,d,e;
  ;
/* trn("add_aspect_to_grhdata(int nat_plt,int aspect_num,int trn_plt,int day_num) "); */

  if (Moon_confidence == 0
    &&  nat_plt == NAT_PLT_NUM_FOR_MOON)  return;

  for (ical=0; ical <= NUM_HOUSES_CONSIDERED - 1; ++ical) {  /* NUM_HOUSES_CONSIDERED = 1 */

    a = (double)(get_plt_in_12(
      nat_plt-1,
      get_sign(Ar_minutes_natal[nat_plt])-1,
      ical)
    );

    if (House_confidence == 0)  b = a;
    else  b = (double)(get_plt_in_12(nat_plt-1,
            get_house(Ar_minutes_natal[nat_plt],
              Ar_minutes_natal[13]) -1, /*13=mc*/
            ical));

    c = (double)(
      get_plt_in_12(
        ((trn_plt == 6)? 5:trn_plt+5)-1,
        get_sign((Eph_buf+day_num)->positions[trn_plt]) -1,
        ical)
      );

    if (House_confidence == 0)  d = c;
    else  d = (double)(get_plt_in_12(((trn_plt == 6)? 5:trn_plt+5)-1,
            get_house((Eph_buf+day_num)->positions[trn_plt],
                  Ar_minutes_natal[13]) - 1, /*13=mc*/
            ical));

    e = (double)(get_aspect_multiplier(Aspect_type[aspect_num],
            trn_plt-1,
            nat_plt-1,
            ical));

    addval = (int)(Current_aspect_force * Moon_confidence_factor *
            e * (sqrt(a*a+b*b)+sqrt(c*c+d*d)));

    *(Grhdata+ical*Num_eph_grh_pts+(day_num-1)) += addval;

  }


/* static int mytimes2; mytimes2++;
* if (mytimes == 1 ) mk_new_date(&dmn,&ddy,&dyr,dstep);
* if (mytimes == 2 ) mk_new_date(&dmn,&ddy,&dyr,dstep+92*2);
*/

/* <.> for test ! */
/* test asp details */
/* show all aspects */

/* char myasp[8], mynat[8], mytrn[8];
* char sday[4]; sprintf(sday,"%02d", day_num);
* strcpy(myasp, N_aspect[aspect_num]);
* strcpy(mytrn, N_planet_bestday[trn_plt]);
* strcpy(mynat, N_planet[nat_plt]);
* ksn(sday); ks(myasp); ks(mytrn); ks(mynat); ki(addval);
*/
/* <.> for test ! */


}  /* end of add_aspect_to_grhdata() */


/* arg  trn_plt is 0-> 3 coming in  sun,mer,ven,moo
*  arg  nat_plt is 1->10 coming in
*                  sun,moo,mer,ven,mar,jup,sat,ura,nep,plu, 
*/
void add_aspect_to_grhdata_bestday(int nat_plt,int aspect_num,int trn_plt,int day_num) 
{
/* <.> */
  ;
  int ical;
  int addval;
  double a,b,c,d,e;
  ;
  /* trn("add_aspect_to_grhdata(int nat_plt,int aspect_num,int trn_plt,int day_num) "); */

  if (Moon_confidence == 0
    &&  nat_plt == NAT_PLT_NUM_FOR_MOON)  return;



  for (ical=0; ical <= NUM_HOUSES_CONSIDERED - 1; ++ical) {  /* NUM_HOUSES_CONSIDERED = 1 */

    a = (double)(get_plt_in_12(
      nat_plt-1,
      get_sign(Ar_minutes_natal[nat_plt])-1,
      ical)
    );
/* kdn(a); */

    if (House_confidence == 0)  b = a;
    else  b = (double)(get_plt_in_12(nat_plt-1,
            get_house(Ar_minutes_natal[nat_plt],
              Ar_minutes_natal[13]) -1, /*13=mc*/
            ical));
/* kd(b); */
/* kin(trn_plt);ki(ical);ki(day_num); */
/* int eph; eph = (Eph_buf_bestday+day_num)->positions[trn_plt] -1; ki(eph); */

    c = (double)(
      get_plt_in_12_bestday(
        trn_plt, /* trn_plt is 0->3 coming in */
        get_sign((Eph_buf_bestday+day_num)->positions[trn_plt]) -1,
        ical)
      );
/* kd(c); */

    if (House_confidence == 0)  d = c;
    else  d = (double)(get_plt_in_12_bestday(
            trn_plt,
            get_house((Eph_buf_bestday+day_num)->positions[trn_plt],
                  Ar_minutes_natal[13]) - 1, /*13=mc*/
            ical));
/* kd(d); */

    e = (double)(get_aspect_multiplier_bestday(
            Aspect_type[aspect_num],   /* aspect_type  0=cnj, 1=good, 2=bad */
            trn_plt,
            nat_plt-1,
            ical));
/* kd(e); */
/* int mytyp;mytyp= Aspect_type[aspect_num]; */
/* ki(aspect_num);ki(mytyp); */

    addval = (int)(Current_aspect_force * Moon_confidence_factor *
            e * (sqrt(a*a+b*b)+sqrt(c*c+d*d)));
/* ki(addval); */
/* kd(Current_aspect_force); */

    *(Grhdata_bestday +ical * Num_eph_grh_pts+(day_num-1)) += addval;
  }


/* static int mytimes2; mytimes2++;
* if (mytimes == 1 ) mk_new_date(&dmn,&ddy,&dyr,dstep);
* if (mytimes == 2 ) mk_new_date(&dmn,&ddy,&dyr,dstep+92*2);
*/

/* <.> for test ! */
/* test asp details */
/* show all aspects */
/* char myasp[8], mynat[8], mytrn[8];
* char sday[4]; sprintf(sday,"%02d", day_num);
* strcpy(myasp, N_aspect[aspect_num]);
* strcpy(mytrn, N_planet_bestday[trn_plt]);
* strcpy(mynat, N_planet[nat_plt]);
* ksn(sday); ks(myasp); ks(mytrn); ks(mynat); ki(addval);
*/
/* <.> for test ! */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

} /* end of add_aspect_to_grhdata_bestday() */



int get_sign(int minutes)
{
  return((int)floor((minutes/60.0)/30.0)+1);
} 


int get_house(int minutes,int mc)
{
  int asc;
  ;
  asc = mc + 90*60;
  if (asc >= NUM_MINUTES_IN_CIRCLE) asc = asc - NUM_MINUTES_IN_CIRCLE;
  if (minutes >= asc)  return(get_sign(minutes-asc));
  else  return(get_sign((NUM_MINUTES_IN_CIRCLE-asc)+minutes));
}  /* end of get_house() */



/*  **************  more on do_grhs()  **************** 
*  
* args-  p_grh is a ptr to array extern ints of y values for grh 
*       grh_incr is increment.  e.g. =5 means if yvalue is 20 
*         then that pt goes on 4th line of grh from zero y value 
*  
*   initialize prt line to blanks 
*  for each graph to be done()     
*     change the grh values to 12lpi line numbers 
*     init the col_num array 
*     sort the grh values 
*     set up .ne for doc 
*     do_a_graph() 
*/
void do_grhs(void)
{
  int igrh, stress_num, this_num;  /* igrh = grhs 2,4,5,7,10, or whatever */
  int n;
  ;
/* trn("in do_grhs()  "); */

  /* --------------- "/Users/rk/_PC/usr/apple/_c/_wrk/futdefs.h" -------------- */
  /* 128:#define SUBSCRIPT_FOR_VLO_STRESS_LEVEL 6    * Stress_val[6] = vlo- "great"*/
  /* 129:#define SUBSCRIPT_FOR_LO_STRESS_LEVEL 5     * Stress_val[5] = lo- "good" */
  /* 130:#define SUBSCRIPT_FOR_HIGH_STRESS_LEVEL 3   * Stress_val[3] = hi-"stress" */
  /* 131:#define SUBSCRIPT_FOR_VHIGH_STRESS_LEVEL 2  * Stress_val[2] = hi-"OMG" */

  /* --------------- "/Users/rk/_PC/usr/apple/_c/_wrk/futdoc.h" -------------- */
  /* 223:int Stress_val[NUM_STRESS_LEVELS] = {304,250,196,142,88,34,-20,-74}; */
  /*                                                   32  23,    5,  */
  for (igrh=0; igrh <= NUM_EPH_GRAPHS-1 -1; igrh++)    /* -1, total grh later */
  {

    in_stress = 0;
    out_of_stress = 0;

    stress_num = Stress_val[SUBSCRIPT_FOR_HIGH_STRESS_LEVEL]
      / SIZE_EPH_GRH_INCREMENT;  /* "stress-" label */
    /*  Stress_val[SUBSCRIPT_FOR_LO_STRESS_LEVEL] "good-" label */

    /* init TABLES
    */
    for (n=0; n <= Num_eph_grh_pts-1; n++) {  /* init tbls */

      *(Grhdata+igrh*Num_eph_grh_pts+n) /= SIZE_EPH_GRH_INCREMENT;

      *(Grh_colnum+n) = n; /* init col num array [0]=0, [1]=1 etc. */


      this_num = *(Grhdata+igrh*Num_eph_grh_pts+n);

/* <.> */
      /* here, do possible intercept of data for rpt "Best Day on"
      *  and put it into return val var= targetDayScore
      */
/*       if(   strcmp(gbl_instructions,  "return only day stress score") == 0  */
      if(   strcmp(gbl_instructions,  "return only day stress scoreB") == 0 
         && gblWeHaveTargetDayScore== 0)
      {
        checkFortargetDayScore(n, this_num);

      }

      /* stress_num is 23  (201312)
      */
      if (this_num >= stress_num) {
        in_stress = in_stress         + (this_num - stress_num);
        gbl_in_stress = gbl_in_stress + (this_num - stress_num);
      } else {
        out_of_stress = out_of_stress         + (stress_num - this_num);
        gbl_out_of_stress = gbl_out_of_stress + (stress_num - this_num);
      }

    } /* init tbls */

/* <.> show y values */
/* int y; for (n=0; n <= Num_eph_grh_pts-1; n++) { */
/*   y = *(Grhdata+igrh*Num_eph_grh_pts+n);  */
  /*  arg1 = p_grh y values */
/* kin(n);ki(y); */
/* } */


    /* #define SUBSCRIPT_FOR_HIGH_STRESS_LEVEL 3  * Stress_val[3] = hi-"stress" *
    * int Stress_val[NUM_STRESS_LEVELS] = {304,250,196,142,88,34,-20,-74};
    */
    sort_grh(Grhdata+igrh*Num_eph_grh_pts,Num_eph_grh_pts,Grh_colnum);


    set_tops_and_bots(igrh);

    /* for test */
    /* tn();
    * int mytop, mybot;
    * mytop = Grh_top/SIZE_EPH_GRH_INCREMENT;
    * mybot = Grh_bot/SIZE_EPH_GRH_INCREMENT;
    * trn("!!!!!!!!!!!!!!");ki(Grh_top);
    * trn("!!!!!!!!!!!!!!");ki(Grh_bot);
    * trn("!!!!!!!!!!!!!!");ki(mytop);
    * trn("!!!!!!!!!!!!!!");ki(mybot); tn();
    */

    do_size_grh();

    if (Num_eph_grh_pts == NUM_PTS_WHOLE_YEAR) {  // do big graph
      do_aBIG_graph(Grhdata+igrh*Num_eph_grh_pts,igrh);  /*  arg1 = p_grh y values */
    } else {
      do_a_graph(Grhdata+igrh*Num_eph_grh_pts,igrh);  /*  arg1 = p_grh y values */
    }

  }  /* for each NUM_EPH_GRAPH */

}  /* end of do_grhs() */



void checkFortargetDayScore(int daynum, int current_score)
{
  double d_dy,d_mn,d_yr,d_step;
  double d_jd_current, d_jd_target;   /* jd=julian date */
  int    i_jd_current, i_jd_target;   /* jd=julian date */
  static int save_last_score;

/* tn(); trn("in checkFortargetDayScore()"); */
/* kin(daynum);ki(current_score); */
/* kin(Grh_beg_mn); ki(Grh_beg_dy); ki(Grh_beg_yr); */

  daynum = daynum + 1;  /* make it one-based */

  /* get current date  into d_mn, d_dy, d_yr
  */
  d_mn = (double)Grh_beg_mn;
  d_dy = (double)Grh_beg_dy;
  d_yr = (double)Grh_beg_yr;

  d_step = (double)((daynum-1) * Eph_rec_every_x_days);

  mk_new_date(&d_mn, &d_dy, &d_yr, d_step);


  /* compare current date to target date for "Best Day" rpt
  *  by converting to julian dates
  */
  if ((int)d_yr !=  gbl_bd_year) return;

  d_jd_current = day_of_year(d_yr, d_mn, d_dy);
  d_jd_target  = day_of_year(
    gbl_bd_year,
    gbl_bd_mth,
    gbl_bd_day
  );
  i_jd_current = (int)d_jd_current;
  i_jd_target  = (int)d_jd_target ;

/* kin(i_jd_current); ki(i_jd_target); */


  if (i_jd_current == i_jd_target) {
    gblTargetDayScore = current_score;  /* DONE! */
    gblWeHaveTargetDayScore= 1;  /* 1=yes,0=no */
    return;
  }
  /* there is 1 star every 2 days, so
  * check for case that current date is 1 more than target
  */
  if (i_jd_current > i_jd_target) {
    if (save_last_score == 0) {
      gblTargetDayScore = current_score;  /* DONE! */
      gblWeHaveTargetDayScore = 1;  /* 1=yes,0=no */
    return;

    } else {
      gblTargetDayScore = (save_last_score + current_score) / 2;  /* DONE! */
      gblWeHaveTargetDayScore = 1;  /* 1=yes,0=no */
      return;
    }
  }

  save_last_score = current_score;

} /* end of  checkFortargetDayScore() */



void set_tops_and_bots(int grh_num)
{
  Grh_top = *(Grhdata+grh_num*Num_eph_grh_pts+Num_eph_grh_pts-1) 
      * SIZE_EPH_GRH_INCREMENT;
  Grh_bot = *(Grhdata+grh_num*Num_eph_grh_pts+0) 
      * SIZE_EPH_GRH_INCREMENT;

  if (Grh_top < Stress_val[SUBSCRIPT_FOR_HIGH_STRESS_LEVEL]) {
    False_top =  Stress_val[SUBSCRIPT_FOR_HIGH_STRESS_LEVEL];
  } else {             /* ^top < hi stress level */
    False_top = Grh_top;     /* top >= hi stress level  ("STRESS_") */
  }

  if (Grh_bot > Stress_val[SUBSCRIPT_FOR_VLO_STRESS_LEVEL]) {
    False_bot =  Stress_val[SUBSCRIPT_FOR_VLO_STRESS_LEVEL];
  } else {             /* ^bot > vlo stress level   ("GOOD") */
    False_bot = Grh_bot;     /* bot <= vlo stress level */
  }

  if (False_top <= Grh_top) Num_file_lines_top = 0;
  else Num_file_lines_top = 
    ((False_top-Grh_top-1)/SIZE_EPH_GRH_INCREMENT)+1;

  if (False_bot >= Grh_bot) Num_file_lines_bot = 0;
  else Num_file_lines_bot = 
    ((Grh_bot-False_bot-1)/SIZE_EPH_GRH_INCREMENT)+1;

/* tn();ki(Num_file_lines_top); */
/* tn();ki(Num_file_lines_bot); */

}  /* end of set_tops_and_bots() */



void do_a_graph(int p_grh[], int grh_num)    /* qqq */
{
  int n;
  char *p = &Swk[0];
  static int fut_line_ctr;
/*   char grh_line[SIZE_EPH_GRH_LINE+1]; */
  char grh_line[1024];
  int cols_with_pt[SIZE_EPH_GRH_LINE+1];/*for this line, col#s holding a pt*/
    /* cols_with_pt starts at [1] */
  int k,m,current_grh_y_val,last_grh_y_val_printed,nl,pt_ctr;
  ;                      /* nl = newest line in grh */
/* trn("in do_a_graph()"); */

  n = sprintf(p,"\n\n[beg_graph]\n");  /* signal to fmt_f.awk */
  /* fput(p,n,Fp_docin_file); */
  f_docin_put(p,n);

  Num_lines_in_grh_body = 0;
  last_grh_y_val_printed = 0;
  pt_ctr = 0;
  fut_line_ctr = 0;
  current_grh_y_val = *(p_grh+Num_eph_grh_pts-1);/* for 1st time thru below */
  last_grh_y_val_printed = current_grh_y_val;  /* for 1st time thru below */
  prt_grh_hdr(grh_num);

  sfill(&grh_line[0],Num_eph_grh_pts,GRH_BACKGROUND_CHAR);
  for (k=Num_eph_grh_pts-1; k > -1; k--) {

    if ( (nl=*(p_grh+k)) != current_grh_y_val  &&
          Num_lines_in_grh_body < MAX_GRH_BODY_LINES  ) {

      prt_grh_line(&grh_line[0],&cols_with_pt[0],pt_ctr,
        &fut_line_ctr,Grh_top);

      for (m=1; m <= last_grh_y_val_printed-nl-1; m++) {
        prt_grh_line(&grh_line[0],&cols_with_pt[0],0,
          &fut_line_ctr,Grh_top);
      }
                /* ^ put in 'blank' lines */
      last_grh_y_val_printed = nl;
      pt_ctr = 0;
    }

    pt_ctr++;
    cols_with_pt[pt_ctr] = Grh_colnum[k];
    current_grh_y_val = nl;

/* <.> */
/* kin(current_grh_y_val); */

  }


  prt_grh_bot(&grh_line[0],&cols_with_pt[0],pt_ctr,&fut_line_ctr);

   n = sprintf(p,"\n[end_graph]\n\n");  /* signal to fmt_f.awk */
   f_docin_put(p,n);

}  /* end of do_a_graph() */


void prt_grh_hdr(int grh_num)  /* grh title and 2nd line */
{
  char lf_mar[SIZE_GRH_LEFT_MARGIN+1];
  char star_desc[64], star_wk[64], num1[16], num2[16];
  char wk_line[SIZE_EPH_GRH_LINE+1];
  int n;
  char *p = &Swk[0];
  long int tmp_long;
  ;
  sfill(&lf_mar[0],SIZE_GRH_LEFT_MARGIN,' ');
/*
* if (Is_past) strcpy(&star_desc[0],".(one star every Wednesday)");
* else sprintf(&star_desc[0],"(one star for every %d days)",
*   Eph_rec_every_x_days);
*/
  sfill(star_desc,26,'.');
  tmp_long =  (long int) out_of_stress;
  commafy_int(num1, tmp_long, 6);
  tmp_long =  (long int)     in_stress;
  commafy_int(num2, tmp_long, 6);
  sprintf(star_wk, "ok=%s+, stress=%s-",   /* area score  good/bad */
    strim(num1," "), strim(num2," ") );
  memcpy(star_desc, star_wk, strlen(star_wk));

  /* put name in field of dots
  */
  char dotfield[MAX_SIZE_PERSON_NAME+2];  /* 15 in 201309 */
  sfill(dotfield, MAX_SIZE_PERSON_NAME+1, '.');
  memcpy(dotfield, fEvent_name, strlen(fEvent_name));
  dotfield[MAX_SIZE_PERSON_NAME+1] = '\0';


/*    "\n\n%s .....%s..........................................%s.....%s..... \n", */
/*     Grh_name[grh_num],   */
/*    "\n\n%s .....%s.............................................%s.....%s..... \n", */
/*     "\n\n%s .....%s.............................................%s.....%s..... \n",  */

/* tn(); */
/* ksn(&lf_mar[0]); */
/* ksn(dotfield); */

/*     "\n\n%s ..<span class=\"bgy\">...%s.....................T.......................%s.....%s..... </span>\n",  */
/*     "\n\n%s ..<span class=\"bgy\">...%s..................T.....................%s.....%s..... </span>\n",  */
/*     "\n\n%s<span class=\"k\"> .....%s........................................%s.....%s..... </span>\n",  */
/*     (global_flag_which_graph == 1)? "First Half.": "Second Half"  */


/*    "%s .....%s.......... STRESS LEVELS................%s.....%s..... ", */
/*    "%s .....%s........................................%s.....%s..... ", */
/*    "%s .....%s........................................%s.....%s..... ", */

  n = sprintf(p,
    "%s .....%s...........STRESS.LEVELS................%s.....%s..... ",   /* "stress levels" added 20150325 */
    &lf_mar[0],
    dotfield,
    year_in_the_life_todo_yyyy,
    (global_flag_which_graph == 1)? "First 6 months.": "Second 6 months"
              
  );
/* kin(strlen(p)); */
/* ksn(p); */

  scharswitch(p, '.', ' ');  /* dots out */

  f_docin_put(p,n);

  strcpy(p,"\n");  /* blank line before grh lines */
  n = (int)strlen(p);
  f_docin_put(p,n);
/* kin(strlen(p)); */


  sfill(&wk_line[0],Num_eph_grh_pts,GRH_CONNECT_CHAR);
  wk_line[0] = GRH_SIDELINE_CHAR;  
  wk_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR;


  n = sprintf(p,"%s%s\n",&lf_mar[0],&wk_line[0]);  /* 2nd line */

/*  scharswitch(p, '|', ' '); */ /* sideline out */
  scharswitch(p, '|', '#');  /* sideline out */

/* tn();b(88);ks(p); */
      bracket_string_of("#", p, "<span class=\"cSky\">", "</span>");
/* tn();b(89);ks(p); */
      scharswitch(p, '#', ' ');
/* tn();b(89);ks(p); */

  n = (int)strlen(p);
/* kin(n); */
  f_docin_put(p,n);
  put_grh_blnk_lines_at_top();

}  /* end of prt_grh_hdr() */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /*
*     takes integer "intnum", formats it right-justified
*     starting at ptr "dest" in a field of "sizeofs"
* */
* void commafy_int(char *dest, long intnum, int sizeofs)
* {
*     char wkstr[64];                 /* hold digits int "intnum" */
*     char *digits;                   /* pointer to current digit */
*     char fmt[64];
*     int n;              /* digit pointer (goes backwards) */
*     int ctr;            /* digit counter (forwards) */
*     int place;          /* current char num in dest */
*     ;
*     sprintf(wkstr,"%ld",intnum);
*     digits = &wkstr[strlen(wkstr)-1];
* 
*     sprintf(fmt,"%%%ds",sizeofs);
*     sprintf(dest,fmt," ");
*     for (ctr=1, n=strlen(wkstr), place=sizeofs-1;   n >= 1;   n--, digits--, ctr++,place--) {
*         dest[place] = *digits;
*         if (ctr % 3 == 0  &&  n != 1) {
*             place--;
*             dest[place] = ',';
*         }
*     }
*     if (dest[place+1] == ',') dest[place+1] = ' ';
*     if (dest[place+1] == '-'  &&  dest[place+2] == ',') {
*         dest[place+1] = ' ';
*         dest[place+2] = '-';
*     }
* }    /* end of commafy_int() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /*
*   char *strim(s,set)
*   in string s, trim from both the left end and right end
*   all the characters in string set.
*   returns ptr to 1st non-set char in s.  
*   (\0 is written into s if right trimming occured)
* */
* char *strim(char *s, char *set)
* {
*   char *p,*q;
*   ;
*   for (p=s; *p != '\0'; p++) {
*     if (strchr(set,*p) == NULL) break;  /* out on 1st non-set char */
*   }
*   if (*p == '\0') return("");  /* s is all set chars */
*   q = PENDSTR(s);            /* | null stmt */
*   for ( ; strchr(set,*q) != NULL; q--) ;  /* out on 1st non-set char */
*   *(q+1) = '\0';
*   return(p);
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


void put_grh_blnk_lines_at_top(void)    /* top is now the bottom */
{      /* after reversal. (high stress used to be at the top) */
  static int top_ln_ctr;
  int itop;
  int dummy[1];
  char prt_line[SIZE_EPH_GRH_LINE+1];
  ;
  dummy[0] = 0; /* init */
  if (False_top <= Grh_top) return;
  top_ln_ctr = 0;
  sfill(&prt_line[0],Num_eph_grh_pts,GRH_BACKGROUND_CHAR);

  /* sideline out */
/*   prt_line[0] = GRH_SIDELINE_CHAR; */
/*   prt_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR; */


  for (itop=1; itop <= Num_file_lines_top; ++itop) {
/* tn();b(200);ki(Num_file_lines_top); */
    prt_grh_line(&prt_line[0],dummy,0,&top_ln_ctr,False_top);
  }
/* ksn(gbl_save_last_line); */
}


void prt_grh_bot(char *p_line, int cols_with_pt[], int pt_ctr, int *p_ln_ctr)
{
  char lf_mar[SIZE_GRH_LEFT_MARGIN+1];
  int n,k;
  char *p = &Swk[0];
  char mywk[SIZE_GRH_LEFT_MARGIN+1];
  ;
/* trn("in prt_grh_bot"); */
  sfill(&lf_mar[0],SIZE_GRH_LEFT_MARGIN,' ');

  *p_ln_ctr = -1;      /* last line marker */
  prt_grh_line(&p_line[0],&cols_with_pt[0],pt_ctr,   
    p_ln_ctr,Grh_top); /* last line */

  sfill(&p_line[0],Num_eph_grh_pts,GRH_CONNECT_CHAR);

  /* sideline out */
/*   p_line[0] = GRH_SIDELINE_CHAR; */
/*   p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR; */

  put_fill_lines_at_bot(&p_line[0]);  /* now top after reversal */

  reverse_grh_body_and_prt();

  sfill(&p_line[0],Num_eph_grh_pts,GRH_BACKGROUND_CHAR);

  /* sideline out */
/*   p_line[0] = GRH_SIDELINE_CHAR; */
/*   p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR;  */ /* one buffer line */

  n = sprintf(p,"%s%s\n",&lf_mar[0],&p_line[0]);

  //scharswitch(p, GRH_BACKGROUND_CHAR, '|');   // change tick from apostrophe to pipe
  scharswitch(p, GRH_BACKGROUND_CHAR, '\'');

  f_docin_put(p,n);
      /* ^bot line of dots */


  /* sideline out */
/* <.>  */
  if (global_flag_which_graph != 1) {  /* leave pipes on "J" in Jan */
    Grh_bottom_line1[0] = ' ';  /* 1st col, (sideline char) */
  }
  Grh_bottom_line1[Num_eph_grh_pts-1] = ' '; /* right side of grh*/

  n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line1);
  f_docin_put(p,n);

  /* sideline out */
  if (global_flag_which_graph != 1) {  /* leave pipes on "J" in Jan */
    Grh_bottom_line2[0] = ' ';  /* 1st col, (sideline char) */
  }

  /* right side of grh*/
/*   Grh_bottom_line2[Num_eph_grh_pts] = ' ';  */
/*   Grh_bottom_line2[Num_eph_grh_pts-1] = 'Q';  */

  n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line2);
  f_docin_put(p,n);

  /* put year into line3 lf_mar 
  */
  sfill(mywk, SIZE_GRH_LEFT_MARGIN, ' ');
  sprintf(mywk,"%4d  ", Grh_beg_yr);    /* =magic */
  k = (int)strlen(lf_mar) -1 - 4;           /* 4= numchar in yr e.g. 1988 */
  strncpy(lf_mar+k, mywk, 4);

/*   n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line3); */

  strcpy(p,"\n");  /* blank line before line with month names   may 2014 */
  n = (int)strlen(p);
  f_docin_put(p,n);

  n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line3);
  f_docin_put(p,n);

}  /* end of prt_grh_bot() */


void put_fill_lines_at_bot(char p_line[0])  /* now top */
{
  int ibot;
  int dummy[1];
  static int bot_ln_ctr;
  ;
  dummy[0] = 0; /* init */
  if (False_bot >= Grh_bot) return;
  bot_ln_ctr = 0;
  for (ibot=1; ibot <= Num_file_lines_bot; ++ibot) {
/* tn();b(633);ki(ibot);ks(p_line); */
    prt_grh_line(&p_line[0],dummy,0,&bot_ln_ctr,Grh_bot);
  }
} 


void reverse_grh_body_and_prt(void)  /* grh used to have high stress at top */
{
  int iprt, n, running_stress_level_on_line;
  char linebuf[2048];
  char *p = &Swk[0];
  char *q = &Grh_body[0];
  int we_have_hit_great_line;  /* 1=y,0=n */
  int we_have_hit_good_line;  /* 1=y,0=n */
  int we_have_hit_stress_line;  /* 1=y,0=n */
  int we_have_hit_omg_line;  /* 1=y,0=n */
  char myLastLine[2024];
  int  first_star_is_in_great, myidx;
  int  first_star_is_in_good;
  ;

  /* 20130911 ONLY use these flags to determine star coloring
  *  for good (green) and stress (red)
  */
  we_have_hit_great_line   = 0;  /* init to no */
  we_have_hit_good_line   = 0;  /* init to no */
  we_have_hit_stress_line = 0;  /* init to no */
  we_have_hit_omg_line = 0;  /* init to no */

/* tn();trn("in reverse_grh_body_and_prt()"); */

  if (Num_lines_in_grh_body-1 <  MAX_GRH_BODY_LINES-1) {
    iprt = Num_lines_in_grh_body-1;
  } else {
    iprt = MAX_GRH_BODY_LINES-1;
  }

  /* read thru Grh_body to see if "GREAT-" or "GOOD-" is first.
  *  (this is for coloring the first star lines.  we do not
  *   know if Great * or Good * level is first)
  */
  myidx = iprt;
  first_star_is_in_great = 0;
  first_star_is_in_good  = 0;
  for ( ;  myidx > -1  ; --myidx) {    /* iprt is num lines in grh body */
    strcpy(linebuf, q+myidx*(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1));
    if (strstr(linebuf, "GREAT")  != NULL) {
      first_star_is_in_great = 1;
      break;
    }
    if (strstr(linebuf, "GOOD")   != NULL) {
      first_star_is_in_good = 1;
      break;
    }
  }


  /* graph top (used to be on bot)
  *  this stress level num increases as graph moves down.
  */
  running_stress_level_on_line = Grh_bot; /* graph top (used to be on bot) */

int  have_printed_blank_top_line;  /* <.> take out */
  have_printed_blank_top_line = 0;

  for ( ;  iprt > -1  ; --iprt) {    /* iprt is num lines in grh body */


    strcpy(linebuf, q+iprt*(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1));


/* <.> show iprt and how many stars in linebuf  */
/* int starcnt; starcnt = scharcnt(linebuf, '*'); */
/* kin(iprt);ki(starcnt); */
/* <.> show iprt and how many stars in linebuf  */


    if (strstr(linebuf, "GREAT")  != NULL)   we_have_hit_great_line  = 1;
    if (strstr(linebuf, "GOOD")   != NULL)   we_have_hit_good_line   = 1;
    if (strstr(linebuf, "STRESS") != NULL)   we_have_hit_stress_line = 1;
    if (strstr(linebuf, "OMG")    != NULL)   we_have_hit_omg_line    = 1;



    /* we want no blank lines above the GOOD green line level (or GREAT
    *  They must contain a * or X.
    *  TOP LINE OF GRAPH CANNOT BE "EMPTY" of * or X  UNLESS it is GOOD line
    */

/* OLD */
/*         && we_have_hit_great_line == 0  */
/* trn("  !!!  <.> no blank lines above GREAT line !!!"); */

    /* line contains no  * or X  */  
    /* this is bot/ now top line of all connect_CHARS (#)
    */
    if (   sall(linebuf, " |#") 
        && have_printed_blank_top_line == 0
        && we_have_hit_good_line == 0 ) {

        strcat(linebuf, "##");  /* weird bug fix */

      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');

      scharswitch(linebuf, '|', ' ');  /* sideline out */

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      have_printed_blank_top_line = 1;

      continue;

    }

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* if(i==41){strcpy(linebuf, "X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX   * X*");} */
/* if(i==40){tn();tr("-----------ordinary(40) ----------line---");ksn(linebuf);tn();} */
/* if(i==41){strcpy(linebuf, "X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX X * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX *");} */
/* if(i==41){strcpy(linebuf, "       |X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX X * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX *|");} */
/* if(i==41){strcpy(linebuf, "       |                            *X  *XX XX  XX X * X* X  *X  *XX X                            |");}  */
/* if(i==41){strcpy(linebuf, "       |                            *X  *XX XX  XX X *                                            |");}  */


/* kin(running_stress_level_on_line); ki(Stress_val[SUBSCRIPT_FOR_LO_STRESS_LEVEL]); */
/*    if (running_stress_level_on_line < Stress_val[SUBSCRIPT_FOR_LO_STRESS_LEVEL] *//* is GOOD */

    /* here we have not hit the GREAT line OR the GOOD LINE 
    *  we are either  in Great color or GOOD color
    */
    if (   we_have_hit_great_line == 0
        && we_have_hit_good_line  == 0
        && strstr(linebuf, "GOOD") == NULL    /* not on GOOD line */
        && strstr(linebuf, "GREAT") == NULL ) /* not on GREAT line */
    {
      /* here we are in GREAT territory- color cGr2
      */
/*       strsubg(linebuf, "X ", "<span class=\"cGr2\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cGr2\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cGr2\">*</span>");
* 
*       strsubg(linebuf, 
*         "<span class=\"cGr2\">*</span><span class=\"cGr2\">*</span>",
*         "<span class=\"cGr2\">**</span>"
*       );
*       strsubg(linebuf, 
*         "<span class=\"cGr2\">**</span><span class=\"cGr2\">**</span>",
*         "<span class=\"cGr2\">****</span>"
*       );
*/
/*       bracket_string_of("X*", linebuf, "<span class=\"cGr2\">", "</span> "); */

      /* great or good
      */
      if (first_star_is_in_great == 1) {
        bracket_string_of("X", linebuf, "<span class=\"cGr2\">", "</span>");
      }
      if (first_star_is_in_good  == 1) {
        bracket_string_of("X", linebuf, "<span class=\"cGre\">", "</span>");
      }

      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }

    /* here we have hit the GREAT line, but not the GOOD line
    *  we are in GOOD color
    **/
    if (   we_have_hit_good_line == 0 
        && strstr(linebuf, "GOOD") == NULL    /* not on GOOD line */
        && strstr(linebuf, "GREAT") == NULL ) /* not on GREAT line */
    {
      /* here we are in GOOD territory- color cGre
      */
/*       strsubg(linebuf, "X ", "<span class=\"cGre\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cGre\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cGre\">*</span>");
* 
*       strsubg(linebuf, 
*         "<span class=\"cGre\">*</span><span class=\"cGre\">*</span>",
*         "<span class=\"cGre\">**</span>"
*       );
*       strsubg(linebuf, 
*         "<span class=\"cGre\">**</span><span class=\"cGre\">**</span>",
*         "<span class=\"cGre\">****</span>"
*       );
*/
      bracket_string_of("X", linebuf, "<span class=\"cGre\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }


    /*  we are in Neutral color  (no stress line yet) */
    if (   we_have_hit_stress_line == 0
        && strstr(linebuf, "GOOD") == NULL    /* not on GOOD line */
        && strstr(linebuf, "GREAT") == NULL) {/* not on GREAT line */
      bracket_string_of("X", linebuf, "<span class=\"cNeu\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */
    }


    if (   we_have_hit_stress_line == 1
        && we_have_hit_omg_line != 1
        && strstr(linebuf, "STRESS") == NULL  /* not on STRESS line */
        && strstr(linebuf, "OMG")    == NULL) /* not on    OMG line */
    {
      /* here we are in STRESS territory- color Red
      */
/*       strsubg(linebuf, "X ", "<span class=\"cRed\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cRed\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cRed\">*</span>");
*/

      bracket_string_of("X", linebuf, "<span class=\"cRed\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }


    if (   we_have_hit_omg_line == 1
        && strstr(linebuf, "OMG")    == NULL) /* not on    OMG line */
    {
      /* here we are in OMG territory- color Re2
      */
/*       strsubg(linebuf, "X ", "<span class=\"cRe2\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cRe2\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cRe2\">*</span>");
*/

      bracket_string_of("X", linebuf, "<span class=\"cRe2\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }


    /* NOTE it looks like GREAT falls thru to here  (maybe the others) */

    /* turn star (*) into caret (^) with star color */
    bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
    scharswitch(linebuf, '*', '^');



    n = sprintf(p,"%s\n", linebuf);
    f_docin_put(p,n);
    running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;

  }  /* for each line in grh body */

  /* put extra line at bottom for esthetics
  *  (saving last line preserves its color)
  */
  /* get color of last line and print an empty grh line with it */
/* tn();b(420);ksn(gbl_save_last_line); */
  if (strstr(gbl_save_last_line, "STRESS") == NULL) {  /* only if not on stress line */
/* ksn("PPUTTING blank line"); */
    if (strstr(gbl_save_last_line, "cRed") != NULL) {
      sfill(myLastLine, Num_eph_grh_pts, ' '); 
      bracket_string_of(" ", myLastLine, "<span class=\"cRed\">", "</span>");
      n = sprintf(p,"       %s\n", myLastLine );  /* left margin = 7 spaces */
      f_docin_put(p,n);
/* ksn("PPUTTING blank line"); */
    }
    if (strstr(gbl_save_last_line, "cRe2") != NULL) {
      sfill(myLastLine, Num_eph_grh_pts, ' '); 
      bracket_string_of(" ", myLastLine, "<span class=\"cRe2\">", "</span>");
      n = sprintf(p,"       %s\n", myLastLine );  /* left margin = 7 spaces */
      f_docin_put(p,n);
/* ksn("PPUTTING blank line"); */
    }
  }


  scharswitch(gbl_save_last_line, 'X', ' ');
  scharswitch(gbl_save_last_line, '#', ' ');
  scharswitch(gbl_save_last_line, '*', ' ');
  scharswitch(gbl_save_last_line, '|', ' ');  /* sideline out */
/* b(300); */
  n = sprintf(p,"%s\n", gbl_save_last_line);
  f_docin_put(p,n);

}  /* end of reverse_grh_body_and_prt() */






/* with \n at end */
void prt_grh_line(char *p_line, int cols_with_pt[],   
             int pt_ctr, int *p_ln_ctr, int top) 
{
  int ilin;
  ;

  ++Num_lines_in_grh_body;

  /* do not walk the plank */
  if (Num_lines_in_grh_body >= MAX_GRH_BODY_LINES) return;
 
  /* sideline out */
/*  p_line[0] = GRH_SIDELINE_CHAR; */ /* 1st col, (sideline char) */
/*  p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR; */ /* right side of grh*/

  /* pts in graph
  */
  for (ilin=1; ilin <= pt_ctr; ilin++) {
    *(p_line+cols_with_pt[ilin]) = EPH_GRH_CHAR;
  } 


  /* try to avoid stars on the sideline  (jun 2013)
  * 1st col, (sideline char) 
  * right side of grh
  */
/* <.> weird */
  /* sideline out */
/*   p_line[0] = GRH_SIDELINE_CHAR;  */
/*   p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR;  */

/*   p_line[0] = 'q';  */
/*   p_line[Num_eph_grh_pts-1] = 'q';  */
/* tn();kc(p_line[0]); kc(p_line[Num_eph_grh_pts-1]); */
  /*     *(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1),"%s%s\0", (warn on 0) */

  /* PUT LINE IN TBL
   */
  sprintf(  
    Grh_body + (Num_lines_in_grh_body-1) * 
               (SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1),
    "%s%s",
    get_grh_left_margin(p_ln_ctr,top,p_line),
    p_line
  );

  strcpy(gbl_save_last_line, p_line);

  for (ilin=1; ilin <= pt_ctr; ilin++)
    *(p_line+cols_with_pt[ilin]) = GRH_CONNECT_CHAR;  /*ch pt to connect*/

  if (Just_did_good_line == 1) {
    Just_did_good_line = 0;
    undo_good_line(p_line);

    for (ilin=1; ilin <= pt_ctr; ilin++)
      *(p_line+cols_with_pt[ilin]) = GRH_CONNECT_CHAR;  /*ch pt to connect*/
  }
}  /* end of prt_grh_line() */


char *get_grh_left_margin(int *p_ln_ctr, int top, char *p_line)
{
  int this_line,ilef;
  static char l_mar[SIZE_GRH_LEFT_MARGIN+1];  /* must be static for */
  ;      /* return value to point to stable chars, not automatic */
  sfill(&l_mar[0],SIZE_GRH_LEFT_MARGIN,' ');  /* mk margin = blanks */
  if (*p_ln_ctr == -1)  return(&l_mar[0]);  /* bot line of dots */
  (*p_ln_ctr)++;  /* e.g. =3, this line about to be printed is 3rd line */
  this_line = top - (*p_ln_ctr-1) * SIZE_EPH_GRH_INCREMENT;
  for (ilef=0; ilef <= NUM_STRESS_LEVELS-1; ilef++) {
    if (this_line >= Stress_val[ilef]) {
      if (this_line < Stress_val[ilef] + SIZE_EPH_GRH_INCREMENT) {
        sprintf(&l_mar[0],"%s",Stress_name[ilef]);

/***
         if (ilef == SUBSCRIPT_FOR_LO_STRESS_LEVEL)  * "good line" *
***/
        if (ilef == SUBSCRIPT_FOR_LO_STRESS_LEVEL  ||
            ilef == SUBSCRIPT_FOR_HIGH_STRESS_LEVEL
        )  /* "good line or stress line" */
          put_good_line(p_line);
        return(&l_mar[0]);
      } else { 
      return(&l_mar[0]); 
      }
    }
  }
  return(&l_mar[0]);
}  /* end of get_grh_left_margin() */


void put_good_line(char *p_line)    /* put line marking "good" level */
{
  ;
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   int i,k,leftmarg;
*   ;
*   leftmarg = SIZE_GRH_LEFT_MARGIN;
*   for (i=0,k=6; k <= Num_eph_grh_pts+leftmarg-5; k=k+6,++i) {
*     Good_save[i] = *(p_line+k);    /* chars to put back */
*     if (*(p_line+k) != EPH_GRH_CHAR)
*       *(p_line+k) = '-';      /* good line marker char */
*   }
*   Just_did_good_line = 1;
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
}

        
void undo_good_line(char *p_line)    /* take away line marking "good" level */
{
  ;
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   int i,k,leftmarg;
*   ;
*   leftmarg = SIZE_GRH_LEFT_MARGIN;
*   for (i=0,k=6; k <= Num_eph_grh_pts+leftmarg-5; k=k+6,++i) {
*     *(p_line+k) = Good_save[i];    /* put back old non-goodline chars */
*   }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
}

        
/* alt = 2nd parallel ar to be sorted along with v */
/* sorts y-axis value and moves x-axis around to keep them together */
/* v = Grhdata (2,4,5,7,or10), alt = Grh_colnum */
void sort_grh(int varg[], int n, int altarg[])
{
  int gap,jj,ii;
  int temp;
  int *v = varg;
  int *alt = altarg;
  ;
  for (gap=n/2; gap>0; gap /= 2) {
    for (ii=gap; ii<n; ii++) {
      for (jj=ii-gap; jj>=0 && *(v+jj) > *(v+jj+gap); jj -= gap) {
        temp = *(v+jj);
        *(v+jj) = *(v+jj+gap);
        *(v+jj+gap) = temp;
        temp = *(alt+jj);
        *(alt+jj) = *(alt+jj+gap);
        *(alt+jj+gap) = temp;
      }
    }
  }
}  /* end of sort_grh() */


void do_size_grh(void)
{
  int size_grh,topval,botval;  /* in print lines (at 12 lpi) */
  ;
  topval = Grh_top/SIZE_EPH_GRH_INCREMENT;
  botval = Grh_bot/SIZE_EPH_GRH_INCREMENT;
  size_grh = NUM_GRH_HDR_LINES 
      + Num_file_lines_top
      + topval - botval + 1
      + Num_file_lines_bot
      + NUM_GRH_BOT_LINES_ALL_DOTS
      + NUM_DATE_SCALE_LINES
      + NUM_LINES_DOC_FOOTER;  /* m3+m4 in doc */

  /* (at 12lpi) +2= grh title, +1= bot line all dots, */
  /* +2= date scale line */

}  /* end of do_size_grh() */


/* #include "futursmb.c" */

/* futursmb.c */

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* read futin, assign birth info to fields
* *
* */
* int get_fut_input(char *futin_pathname)
* {
*   int irk;
*   ;
* 
*   if (( Fp_futin_file = fopen( &futin_pathname[0] ,READ_MODE) )
*     == NULL) {
*     rkabort("future.c.  get_fut_input(). fopen().");
*   }
* 
*   init_bufs();
* 
*   for (irk=1; irk <= NUM_INPUT_ITEMS; ++irk) {  /* get input items */
*     rd_futin(&Inbuf[0],irk);
*     assign_fld(irk);              /* 0= normal end */
*   }  
*   fclose(Fp_futin_file);
*   if (equal(Is_ok,"n") || equal(Is_ok,"N")) return(0);
*   if (Num_past_units_ordered == 0  &&
*     Num_fut_units_ordered == 0) return(0);
*   return(1);    /* not eof */
* }  /* end of get_fut_input() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void init_bufs(void)
* {
*   sfill(&fEvent_name[0],SIZE_INBUF,' ');
*   sfill(&Madd_last_name[0],SIZE_INBUF,' ');
*   sfill(&Madd_first_names[0],SIZE_INBUF,' ');
*   sfill(&Madd1[0],SIZE_INBUF,' ');
*   sfill(&Madd2[0],SIZE_INBUF,' ');
*   sfill(&City_town[0],SIZE_INBUF,' ');
*   sfill(&Prov_state[0],SIZE_INBUF,' ');
*   sfill(&Country[0],SIZE_INBUF,' ');
*   sfill(&Postal_code[0],SIZE_INBUF,' ');
*   sfill(&Letter_comment_1[0],SIZE_INBUF,' ');
*   sfill(&Letter_comment_2[0],SIZE_INBUF,' ');
*   sfill(&Is_ok[0],SIZE_INBUF,' ');
*   sfill(&Futin_filename[0],SIZE_INBUF,' ');
* }
* 
* 
* /* more on rd_futin() */
* /*                                     */
* /*   fgets return 0  -->  last_line  -->  last_line=""  -->  abort  */
* /*     |n          |n          |n          */
* /*     |          |          |            */
* /*     ok          abort          ok            */
* 
* void rd_futin(char *buf, int num_being_read)
* {
*   ;
*   sfill(&buf[0],SIZE_INBUF,' ');
*   if (rkfgets(&buf[0],SIZE_INBUF,Fp_futin_file) == NULL) {
*     if (num_being_read == NUM_INPUT_ITEMS 
* /*       && (i=equal(buf,NULL)) != NULL */
*       ) {
*       ;    /* ^no \n on last line is ok, except if last line = "" */
*     } else {
*       rkabort("future.c.  rd_futin(). fgets().");
*     }
*   }
* }  /* end of rd_futin() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void assign_fld(int jrk)    /* put latest input into right field */
* {
*   #define SIZE_ORDNUM 5
*   int int_Inmn, int_Indy;
*   ;
*   switch (jrk) {    /* below "inbuf" should really be coded "&inbuf[0]" */
*     case  1: strcpy(fEvent_name,Inbuf);
*         if(sall(fEvent_name," ")) {
*           /* assume zero length input file */
*           unlink(Arg_futin_pathname);
*           exit(0);
*         }
*         break;
*     case  2: Inmn = atof(Inbuf); int_Inmn = atoi(Inbuf); break;
*     case  3: Indy = atof(Inbuf); int_Indy = atoi(Inbuf); break;
*     case  4: Inyr = atof(Inbuf); break;
*     case  5: Inhr = atof(Inbuf); break;
*     case  6: Inmu = atof(Inbuf); break;
*     case  7: Inap = atoi(Inbuf); break;
*     case  8: Incf = atoi(Inbuf); break;
*     case  9: break;  /* sex not used by future.c */
*     case 10: Intz = atof(Inbuf); break;
*     case 11: Inln = atof(Inbuf); strcpy(Ln_prt,Inbuf); break;
*     case 12: strcpy(Madd_last_name,Inbuf); break;
*     case 13: strcpy(Madd_first_names,Inbuf); break;
*     case 14: strcpy(Madd1,Inbuf); break;
*     case 15: strcpy(Madd2,Inbuf); break;
*     case 16: strcpy(City_town,Inbuf); break;
*     case 17: strcpy(Prov_state,Inbuf); break;
*     case 18: strcpy(Country,Inbuf); break;
*     case 19: strcpy(Postal_code,Inbuf); break;
*     case 20: Num_past_units_ordered = atoi(Inbuf); break;
*     case 21: Past_start_mn = atoi(Inbuf); break;
*         /*if =0, means future.c uses order_entry date minus 2 yrs */
*     case 22: Past_start_dy = atoi(Inbuf); break;
*     case 23: Past_start_yr = atoi(Inbuf); break;
*     case 24: Num_fut_units_ordered = atoi(Inbuf); break;
*     case 25: Fut_start_mn = atoi(Inbuf); break;  
*         /*if =0, means future.c uses order_entry date */
*     case 26: Fut_start_dy = atoi(Inbuf); break;
*     case 27: Fut_start_yr = atoi(Inbuf); break;
*     case 28: strcpy(Letter_comment_1,Inbuf); break;
*     case 29: strcpy(Letter_comment_2,Inbuf); break;
*     case 30: break; /* cents paid not used by future.c */
*     case 31: break; /* payment code not used by future.c */
*     case 32: break; /* ad code not used by future.c */
*     case 33: break; /* do a pp? not used by future.c */
*     case 34: break; /* comparison line not used by future.c */
*     case 35: break; /* units ordered daily not used by future.c */
*     case 36: break; /* daily start date mmddyy not used by future.c */
*     case 37: break; /* extra field#5 not used by future.c */
*     case 38: break; /* extra field#6 not used by future.c */
*     case 39: strcpy(Is_ok,Inbuf); break;
*     case 40: strcpy(Ordnum,Inbuf); break;
*     case 41: strcpy(Date_of_order_entry,Inbuf); break;
* /***
* old qnx name 16 chars
*     case 42: strcpy(&Futin_filename[0],Inbuf); break;  
*             * ^from mk_fut_input.c *
* ***/
*     case 42:
*       strcpy(Futin_filename,Inbuf);
* 
*       break;  
* 
*   }  /* end of switch */
* 
* }  /* end of assign_fld() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* this is to get around gets(), fgets()
* *  difference QNX v1.1 and v1.20
* *  \n here is NOT included as part of return string
* * this rkfgets() acts like old fgets() 
* */
* char *rkfgets(char *buf, int size_buf,FILE *fp_inputfile)  
* {
*   int n = size_buf;
*   char *p;
*   char *q = &buf[0];
*   ;
*   /*  fgets(buf,size_buf,fp_inputfile); */
*   fgetline(fp_inputfile,q,n);
*   p = strchr(q,'\n');  /* new qnx fn 02jan85 */
*   if (p == NULL) return(q);  /* no \n in buf */
*   *p = '\0';    /* replace \n with \0 (2 \0's in buf) */
*   return(q);
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


void f_set_doc_hdr(void)
{
   int n;
   char *p = &Swk[0];

  /* html moved to fmt_f.awk, which looks for "[beg_topinfo1]
  */

  n = sprintf(p,"%s\n", "\n[beg_topinfo1]");
    f_docin_put(p,n);

  n = sprintf(p,"%s\n", "A Year in the Life");
  f_docin_put(p,n);   
  n = sprintf(p,"%s\n", &fEvent_name[0]); 
    f_docin_put(p,n);
 n = sprintf(p,"%s\n", year_in_the_life_todo_yyyy);
 f_docin_put(p,n);   

/*   n = sprintf(p,"<h1>&nbsp&nbsp&nbsp&nbsp A Year in the2Life &nbsp&nbsp<span style=\"font-size: 80%%;\">of %s</span> &nbsp&nbsp <span style=\"font-size:115%%;\"> %s </span><br></h1>",  */
/*   n = sprintf(p,"<h1>A Year in the2Life<span style=\"font-size: 80%%;\">of %s</span><span style=\"font-size:115%%;\"> %s </span><br></h1>",  */

/*   n = sprintf(p, */
/*       "<h1>A Year in the2Life<span style=\"font-size: 80%%;\">of %s</span> %s <br></h1>",  */
/*     &fEvent_name[0],  year_in_the_life_todo_yyyy); */
/*   f_docin_put(p,n);    */


  /*   n = sprintf(p,"%02d%3s%02d\n",
  *     (int)Fut_start_dy,
  *     N_mth[(int)Fut_start_mn],
  *     (int)Fut_start_yr - (int)Fut_start_yr/100 * 100 
  *   );
  */
 
  n = sprintf(p,"%s\n", "[end_topinfo1]");
  f_docin_put(p,n);

}  /* end of f_set_doc_hdr() */




/* void display_event_specs(char *prt_ordnum) */

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* 2013  no more of this */
* #define size_f1 18    /* for display_event_specs only */
* #define size_f2 5
* #define size_f3 5
* #define size_f4 20
* #define size_f5 17
* #define size_f6 31
* #define size_f7 35
* void display_event_specs(void)
* {
*   int i,idy,iyr,ihr,imu,od,oy,om;
*   char f2[size_f2+1], f3[size_f3+1];  /* blank fills */
*   char s1[6],s2[6];
*   int minit, deg;
*   int n;
*   char *p = &Swk[0];
*   ;
* 
*   n = sprintf(p,"%s\n", "\n[beg_topinfo2]");
*     f_docin_put(p,n);
* 
*   /* 1. of 5  first name
*   */
*   /* n = sprintf(p,"%s\n", scapwords(&fEvent_name[0])); */
*   n = sprintf(p,"%s\n", &fEvent_name[0]);
*     f_docin_put(p,n);
* 
* 
*   i = Inmn; idy=Indy; iyr=Inyr; ihr=Inhr; imu=Inmu;
*   od = atoi(sfromto(f2,Date_of_order_entry,7,8));  /* order day */
*   oy = atoi(sfromto(f2,Date_of_order_entry,3,4));
*   om = atoi(sfromto(f2,Date_of_order_entry,5,6));
* 
*   /* 2. of 5  birth time 03mar84 12:33pm (standard time)
*   */
*   n = sprintf(p,"%02d%s%d %02d:%02d%s%s\n",
*     idy,
*     N_mth[i],
*     iyr,
*     (ihr == 0)?12:ihr,
*     imu,
*     (Inap == 1)?"pm":"am",
*     " (standard time)"
*   );
*   f_docin_put(p,n);  
* 
*   /* 3. of 5  longitude
*   */
*   minit = atoi(sdecnum(s2,&Ln_prt[0]));
*   deg = abs(atoi(swholenum(s1,&Ln_prt[0])));
*   n = sprintf(p,"longitude %03d%s%02d\n",
*     deg,
*     (sfind(&Ln_prt[0],'-')? "e":"w"),
*     minit
*   );
*   f_docin_put(p,n);
* 
*   /* 4. of 5  order number
*   */
*   sfromto(f2,Ordnum,1,2);
*   sfromto(f3,Ordnum,3,5);
*   n = sprintf(p,"order number %s-%s\n",
*     f2,
*     f3);
*   f_docin_put(p,n);
* 
*   /* 5. of 5  run date
*   */
*   n = sprintf(p,"run date %02d%s%02d\n",
*     od,
*     N_mth[om],
*     oy
*   );
*   f_docin_put(p,n);   /* run date: */
* 
* 
*   n = sprintf(p,"%s", "[end_topinfo2]\n");
*     f_docin_put(p,n);
* 
* }  /* end of display_event_specs */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


 

/* capitalizes all chars in s */
/* returns ptr to str s */
char *sallcaps(char *s)
{
  char *saveptr;
   ;
  saveptr = &s[0];
  for (; *s; ++s) *s = toupper( (int) *s);
   return(saveptr); 
} 


void f_display_positions(void)  /* now prints report title in title[] */
{
  int idsp,sign,min_in_sign,deg_in_sign,min_in_deg;
  char pos_str[(11+1)*(13+1)],lf_fill[5+1];  /* 11=numchar one str */
  char mid_fill[11+1];
        /* e.g. sun_10vir44  13=numelement (sun->plu + nod,asc,mc) */
  int n;
  char *p = &Swk[0];
  ;
  /* sprintf(pos_str+idsp*(11+1),"%s%s%02d%s%02d\0", warn on 0 */
  for (idsp=1; idsp <= NUM_PLANETS +3; ++idsp) {
    sign = get_sign(Ar_minutes_natal[idsp]);
    min_in_sign = Ar_minutes_natal[idsp] - (sign-1)*30*60;
    deg_in_sign = min_in_sign/60;
    min_in_deg  = min_in_sign - 60*deg_in_sign;
    sprintf(pos_str+idsp*(11+1),"%s%s%02d%s%02d",
      N_planet[idsp],   "_"      ,deg_in_sign,N_sign[sign],min_in_deg);
/*    N_planet[idsp],Prt_retro[idsp],deg_in_sign,N_sign[sign],min_in_deg); */
  }
  sfill(lf_fill,5,' ');  sfill(&mid_fill[0],11,' ');


  n = sprintf(p,"%s\n", "\n[beg_astrobuffs]");
    f_docin_put(p,n);

  n = sprintf(p,"%s\n", "--------for astrology buffs---------");
  f_docin_put(p,n);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+1*(11+1), pos_str+5*(11+1), pos_str+9*(11+1));
  f_docin_put(p,n);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+2*(11+1), pos_str+6*(11+1), pos_str+10*(11+1));
  f_docin_put(p,n);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+3*(11+1), pos_str+7*(11+1), pos_str+11*(11+1));
  f_docin_put(p,n);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+4*(11+1), pos_str+8*(11+1), pos_str+13*(11+1));
  f_docin_put(p,n);

  n = sprintf(p,"%s\n", "------------------------------------");
  f_docin_put(p,n);

  n = sprintf(p,"%s", "[end_astrobuffs]\n");
    f_docin_put(p,n);

}  /* end of f_display_positions() */


void do_day_stress_score_B(void) {

  char s[8+1];
  double dmn,ddy,dyr,dstep;
  ;

  /* here start lines from  do_future() */

  sfill(s,8,' ');
  if (Fut_start_mn == 0) {    /* special signal from mk_fut_input.c */
    dmn = atof(sfromto(s,&Date_of_order_entry[0],5,6)); /* "yyyymmdd" */
    ddy = atof(sfromto(s,&Date_of_order_entry[0],7,8));
    dyr = atof(sfromto(s,&Date_of_order_entry[0],1,4));
  } else {
    dmn = (double) Fut_start_mn;
    ddy = (double) Fut_start_dy;
    dyr = (double) Fut_start_yr;
  }

  init_rt();  /* now has more max aspects (1024) */

  dstep = 1.0;  /* do eph every day instead of every 2 */

  mk_new_date(&dmn,&ddy,&dyr,dstep);  /* init */

  /* these are needed for put_start_of_aspect();
  */
  Grh_beg_mn = (int)dmn; /* to be adjusted- set_grh_top_and bot()  */ 
  Grh_beg_dy = (int)ddy; /* so that arg date jogs with eph file   */  
  Grh_beg_yr = (int)dyr; /* dates, e.g. past is on Wed       */  

  /* here get_eph_data() is called
  */


  /* here start lines from  eph_data() */


  /* Only free eph_space stuff if calloc_eph_space has run already
  *  during this call to mamb_report_year_in_the_life()
  */
  if (is_first_calloc_eph_space == 1) {
    is_first_calloc_eph_space = 0;
  } else {
    free(Eph_buf_bestday);  Eph_buf_bestday = NULL;
    free(Grhdata_bestday);  Grhdata_bestday = NULL;
  }

  Num_eph_grh_pts = 366;  /* hard code for score_B */


  /* calloc eph space for score_B  (use _bestday vars)
  */
  if ((Grhdata_bestday = (int *)  
       calloc((NUM_EPH_GRAPHS-1)*Num_eph_grh_pts,sizeof(int))) == NULL) {
    rkabort("future.c  not enough memory for calloc Grhdata_bestday");
  }
  if ((Eph_buf_bestday =        /* v (add one for zeroth (ctrl) rec) */
    (struct Futureposrec_bestday*)
       calloc(Num_eph_grh_pts+1,sizeof(struct Futureposrec_bestday)))  == NULL) {
    rkabort("future.c  not enough memory for calloc Eph_buf_bestday");
  }

/* <.> */

  Eph_rec_every_x_days = 1;   /* NOT this ->  STEP_SIZE_FOR_FUT */

    /* here start lines from  fill_eph_buf() */

// NO privacy 20150211  can guess birth info
//    /* get month and day to start the first graph
//    */
//    if (strcmp(year_in_the_life_todo_yyyy, year_of_birth) == 0) {
//      Grh_beg_mn = atoi(mth_of_birth);
//      Grh_beg_dy = atoi(day_of_birth); 
//    } else {
//      Grh_beg_mn = 1;
//      Grh_beg_dy = 1; /*  old was 2 */
//    }
//
      Grh_beg_mn = 1;
      Grh_beg_dy = 1; /*  old was 2 */


    Grh_beg_yr =  atoi(year_in_the_life_todo_yyyy);

    fill_eph_buf_score_B(); /* see fill_eph_buf_by_calc();   */

    /* end of  lines from  fill_eph_buf() */

  /* end of lines from  get_eph_data() */


  /* here we have all the Eph_data_score_B populated */

  /* start of lines from do_grh_calcs_and_prt() */


  int itrn_plt, inatal_plt, iday_num, aspect_num ;
  int starting_natal_plt;

  starting_natal_plt = 1;  /* set default */


  for (iday_num=1; iday_num <= Num_eph_grh_pts; ++iday_num)      {   /* day_num */

    for (itrn_plt=0; itrn_plt <= NUM_PLANETS_TRN_BESTDAY-1; ++itrn_plt) {  /* 0->7 */

      for (inatal_plt=starting_natal_plt; inatal_plt <= NUM_PLANETS; ++inatal_plt) {

/* trn("doing...");ki(itrn_plt);ki(inatal_plt); */

        aspect_num = isaspect(
          abs((Eph_buf_bestday+iday_num)->positions[itrn_plt] - Ar_minutes_natal[inatal_plt]),
          (inatal_plt-1)*(NUM_ASPECTS+1)
        );

        if(aspect_num != 0) {   /* add_aspect_to_grhdata() */ 
          add_aspect_to_grhdata_bestday(inatal_plt, aspect_num, itrn_plt, iday_num);
        }

      } /* nat plt */

    } /* trn plt */



      /* are we finished ?
      */
/*     if (is_target_day_completed(iday_num) == 1) { */



      gblTargetDayScore= *(Grhdata_bestday + iday_num-1);


/* <.>  show all grhdata_bestday */
    /* calibrate */
/*   double ddmn,dddy,ddyr,ddstep; int myii;
*     ddstep = (double)(Eph_rec_every_x_days);
*     ddmn = (double) Fut_start_mn;
*     dddy = (double) Fut_start_dy;
*     ddyr = (double) Fut_start_yr;
* fprintf(stderr, "\n\nshow all grhdata_bestday\n");
* for (myii=1; myii <= iday_num; ++myii) {
* 
* 
*  int mytempn;
*     mytempn = (*(Grhdata_bestday + (myii-1)) * -1 ) ;
*     if (mytempn <= 0) mytempn = 1;
*     fprintf(stderr,"%d\n", mytempn); 
* 
*     fprintf(stderr,"%s|%d|%04d|%02d|%02d|%d|\n",  fEvent_name, myii,
*         (int)ddyr,
*         (int)ddmn,
*         (int)dddy,
*         *(Grhdata_bestday + (myii-1) )
*     );
* }
*/
/* <.>  show all grhdata_bestday */



/*     mk_new_date(&ddmn,&dddy,&ddyr,ddstep); */

      return;    /* to call of do_day_stress_score_B(void) */
/*     } */

  } /* daynum */


} /* end of do_day_stress_score_B(void) */




#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* int is_target_day_completed(int iday_num)  /* return 1=yes,0=no  iday_num is one-based */
* {
*   double d_dy,d_mn,d_yr,d_step, d_jd_current, d_jd_target;   /* jd=julian date */
*   int    i_jd_current, i_jd_target;   /* jd=julian date */
* 
* /* tn(); trn("in is_target_day_completed()"); */
* /* kin(daynum);ki(current_score); */
* /* kin(Grh_beg_mn); ki(Grh_beg_dy); ki(Grh_beg_yr); */
* 
*   /* get current date  into d_mn, d_dy, d_yr
*   */
*   d_mn = (double)Grh_beg_mn;
*   d_dy = (double)Grh_beg_dy;
*   d_yr = (double)Grh_beg_yr;
* 
*   d_step = (double)((iday_num-1) * Eph_rec_every_x_days);
* 
*   mk_new_date(&d_mn, &d_dy, &d_yr, d_step);
* 
* 
*   /* compare current date to target date for "Best Day" rpt
*   *  by converting to julian dates
*   */
*   if ((int)d_yr !=  gbl_bd_year) return(0);
* 
*   d_jd_current = day_of_year(d_yr, d_mn, d_dy);
*   d_jd_target  = day_of_year(
*     gbl_bd_year,         /* doubles */
*     gbl_bd_mth,
*     gbl_bd_day
*   );
*   i_jd_current = (int)d_jd_current;
*   i_jd_target  = (int)d_jd_target ;
* 
* /* kin(i_jd_current); ki(i_jd_target); */
* 
* 
*   if (i_jd_current == i_jd_target) return(1);
*   else                             return(0);
* 
* } /* end of  is_target_day_completed(int iday_num) */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* modified from fill_eph_buf_by_calc(); 
*/
void fill_eph_buf_score_B(void)
{
  double m,d,y,step;
  int grh_pt, idx , minits;
  char   s_hours[8], s_long[8];
  double d_hours,    d_long;

  /* init */
  gbl_beg_last_mth_write = 0; /* beg col of mth name last written */
  gbl_end_last_mth_write = 0; /* end col of mth name last written */

  step = (double) Eph_rec_every_x_days;

  /* init first day to calc */
/*   m = (double) Grh_beg_mn; */
/*   d = (double) Grh_beg_dy; */
/*   y = (double) Grh_beg_y; */
  /* new   do only target day */



  /* get hours diff from greenwich and longitude
  * e.g.  "Delia,12,13,1971,12,15,0,-1,-19.05" 
  */
  strcpy(s_hours, csv_get_field(gbl_csv_person_string, ",", 8));
  strcpy(s_long,  csv_get_field(gbl_csv_person_string, ",", 9));
  d_hours = atof(s_hours);
  d_long  = atof(s_long);
/* kdn(d_hours);kd(d_long); */


  /* for all 366 days
<.> only from target date - 10 ?
<.> only to target date
  */
  Num_eph_grh_pts = 1;  /* new   do only target day */

  m = gbl_bd_mth;
  d = gbl_bd_day;
  y = gbl_bd_year;         /* doubles */

  for (grh_pt=1; grh_pt <= Num_eph_grh_pts; grh_pt++) {  /* now only 1 day (target) */

    /* time = 12 noon */
    calc_chart(m,d,y,0.0,1.0,1.0,d_hours,d_long,0.0);  /* calcchrt.c wants 0 for hr=12*/

    /* do sun,mer,ven,mar first   then MOON
    */
    for (idx=1; idx <= 4; ++idx) {   /*  sun,mer,ven,mar (in Arco) */
      /* double Arco[14];        positions  are in following order:
      *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
      * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
      *                       x                          
      */
      minits = get_minutes(Arco[idx]);
      (Eph_buf_bestday + grh_pt)->positions[idx-1] = minits;   /* <=== */

    }

    /* do sun,mer,ven,mar first,  then MOON at 10am,1pm,4pm,7pm
    */
    calc_chart(m,d,y,10.0,1.0,0.0,d_hours,d_long,0.0);  /* calcchrt.c wants 0 for hr=12*/
    minits = get_minutes(Arco[10]);   /* Arco [10] = MOON, positions [4->7] = MOON */
    (Eph_buf_bestday + grh_pt)->positions[4] = minits;  /* MOON  10 am  */

    calc_chart(m,d,y, 1.0,1.0,1.0,d_hours,d_long,0.0);
    minits = get_minutes(Arco[10]); 
    (Eph_buf_bestday + grh_pt)->positions[5] = minits;  /* MOON   1 pm  */

    calc_chart(m,d,y, 4.0,1.0,1.0,d_hours,d_long,0.0);
    minits = get_minutes(Arco[10]);  
    (Eph_buf_bestday + grh_pt)->positions[6] = minits;  /* MOON   4 pm  */

    calc_chart(m,d,y, 7.0,1.0,1.0,d_hours,d_long,0.0);
    minits = get_minutes(Arco[10]);   
    (Eph_buf_bestday + grh_pt)->positions[7] = minits;  /* MOON   7 pm  */


    mk_new_date(&m,&d,&y,step);
  }

/* show all Eph_buf_bestday positions trnplt=sun,mer,ven,m10,m01,m04,m07  <.>! for test
*/
/* fprintf(stderr,"\n\nshow all Eph_buf_bestday\n");
* int mydeg, mymin, mysgn;  char mytrn[8],smysgn[8];
* for (grh_pt=1; grh_pt <= Num_eph_grh_pts; grh_pt++) {
*   fprintf(stderr,"\n%03d|",grh_pt);
*   for (idx=0; idx <= 7; ++idx) {  
* 
*     mydeg = (Eph_buf_bestday + grh_pt)->positions[idx] / 60;
*     mysgn = (mydeg / 30) + 1;
*     mydeg = mydeg - ((mysgn - 1) * 30);
*     mymin = (Eph_buf_bestday + grh_pt)->positions[idx] % (60*30);
*     mymin = mymin % 60;
*     strcpy(mytrn,N_planet_bestday[idx]);
*     strcpy(smysgn,N_sign[mysgn]);
*     fprintf(stderr,"%s|%02d|%02d|",  smysgn,mydeg,mymin);
* 
*   }
* }
*/
/* show all Eph_buf_bestday */


  /* here get_eph_data() ends */


} /* end of fill_eph_buf_score_B() */





// ==============================  BIG report renamed functions  ===============================
// ==============================  BIG report renamed functions  ===============================
// ==============================  BIG report renamed functions  ===============================
/* <.> */
int mamb_BIGreport_year_in_the_life(  /* called from cocoa */
  char *html_f_file_name,
  char *csv_person_string,
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
  )
{
/* tn();tr("in mamb_report_year_in_the_life()"); */
  int n, retval;      /* n used everywhere for "f_docin_put(p, n);" */
  char *p = &Swk[0];  /* p used everywhere for "f_docin_put(p, n);" */
  char s[128];
  int tempnum_x;
  int tempnum_y;
  int tempnum_z;
  int worknum2;  /* calibrate stress score for return value */
/*  int worknum3; */ /* calibrate stress score for return value */
  ;
/* tn();trn("in mamb_BIGreport_year_in_the_life"); */

  is_first_f_docin_put         = 1;  /* 1=yes, 0=no */
  is_first_calloc_eph_space    = 1;  /* 1=yes, 0=no */
  is_first_set_grh_top_and_bot = 1;  /* 1=yes, 0=no */
  is_first_put_grh_scale_dates = 1;  /* 1=yes, 0=no */

  strcpy(gbl_csv_person_string, csv_person_string);

  char mybirthyear[8];
  strcpy(mybirthyear, csv_get_field(csv_person_string, ",", 4));
  if (strcmp(mybirthyear, year_todo_yyyy) == 0) {
    gbl_is_first_year_of_life = 1;  /* year todo = birthyear */
  } else {
    gbl_is_first_year_of_life = 0;
  }

  fopen_fpdb_for_debug();

/* tn();b(88);tn();
* ksn(html_f_file_name);
* ksn(csv_person_string);
* ksn(year_todo_yyyy);
* ksn(instructions);
*/


  if (strstr(instructions, "return only") == NULL) {
/*     trn("in mamb_report_year_in_the_life()"); */
  }  /* avoid dbmsg on non-rpt call */


  strcpy(gbl_instructions, instructions);

    /* note below:   NEW VERSION of DAY STRESS SCORE =  "B"
    *  gbl_instructions,  "return only day stress score_B")
    */
  if(strcmp(gbl_instructions,  "return only year stress score") == 0) {
    allow_docin_puts = 0;

    strcpy(gbl_yyyymmdd_todo, ""); 

    strcpy(year_in_the_life_todo_yyyy, year_todo_yyyy);

  } else if(strcmp(gbl_instructions,  "return only day stress score") == 0) {
    allow_docin_puts = 0;

    strcpy(gbl_yyyymmdd_todo, year_todo_yyyy); /* danger - re-use arg field here */
    /* (danger re-used arg has dd added to date) */

    strcpy(year_in_the_life_todo_yyyy, sfromto(s,&year_todo_yyyy[0],1,4));

    gbl_bd_mth  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    gbl_bd_day  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    gbl_bd_year = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));

  } else if(strcmp(gbl_instructions,  "return only day stress score_B") == 0) {
/* ksn(gbl_instructions);
* tn(); b(36); ks(stringBuffForStressScore);
* b(37);
* ki(gblTargetDayScore);
* b(4);
* b(38);
* ksn(gbl_csv_person_string);
* b(39);
*/
    allow_docin_puts = 0;

    strcpy(gbl_yyyymmdd_todo, year_todo_yyyy); /* danger - re-use arg field here */
    /* (danger re-used arg has dd added to date) */

    strcpy(year_in_the_life_todo_yyyy, sfromto(s,&year_todo_yyyy[0],1,4));

    gbl_bd_mth  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    gbl_bd_day  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    gbl_bd_year = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));

/*  */
  } else if(strcmp(gbl_instructions,  "do day stress report and return stress score") == 0) {
 b(5);tn();trn("BIG");ksn( gbl_csv_person_string); 

    allow_docin_puts = 0;   /* so short we can hard code html with no docin_puts */

    strcpy(gbl_yyyymmdd_todo, year_todo_yyyy); /* danger - re-use arg field here */
    /* (danger re-used arg has dd added to date) */

    strcpy(year_in_the_life_todo_yyyy, sfromto(s,&year_todo_yyyy[0],1,4));

    gbl_bd_mth  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    gbl_bd_day  = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    gbl_bd_year = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));
/*  */

  } else {                 /* "normal" fut run */
    allow_docin_puts = 1;

    strcpy(gbl_yyyymmdd_todo, ""); 

    strcpy(year_in_the_life_todo_yyyy, year_todo_yyyy);
  }

  gbl_in_stress     = 0;  /* init */
  gbl_out_of_stress = 0;  /* new in sep2013 */


  /* left-overs from input changes
  */
  fPI_OVER_2 = 3.1415926535897932384 / 2.0;
  sfill(&fEvent_name[0],SIZE_INBUF,' ');

  Num_fut_units_ordered = 2;   /* for a-year-in-the-life */

  /* get event details here
  */
  process_input(csv_person_string);  /* prep for calc_chart() */
  /*  input args to calc_chrt() 
  *  mth  date of birth 
  *  day 
  *  year 
  *  hour 
  *  minute 
  *  am,0 or pm,1 
  *  dob_city_diff_hrs_from_greenwich 
  *  dob_city_longitude 
  *  "0.0"  for latitude, take equator, equal house from mc 
  */
  calc_chart(fInmn,fIndy,fInyr,fInhr,fInmu,fInap,fIntz,fInln,fInlt);

  /*   f_display_positions(); for test  */

  GRH_BACKGROUND_CHAR = 88;  /* used to be arg */
  TITLE_LINE_CHAR     = 42;  /* used to be arg */

  /* do not worry about time of day confidence - say its 100% 
  */
  House_confidence = 1;
  Moon_confidence = 1;
  Moon_confidence_factor = 1.0; 

  /* fill natal position tbl, Ar_minutes_natal, incl mc
  */
  /* double Arco[14];        positions  are in following order:
  *     xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_
  * index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
  *
  *    BUT
  * Ar_minutes_natal[1]   sun
  * Ar_minutes_natal[2]   moo
  * Ar_minutes_natal[3]   mer
  * Ar_minutes_natal[4]   ven
  * Ar_minutes_natal[5]   mar
  * Ar_minutes_natal[6]   sat
  * Ar_minutes_natal[7]   jup
  * Ar_minutes_natal[8]   ura
  * Ar_minutes_natal[9]   nep
  * Ar_minutes_natal[10]  plu
  * Ar_minutes_natal[11]  nod
  * Ar_minutes_natal[12]  asc
  * Ar_minutes_natal[13]  mc_
  */
  put_minutes(&Ar_minutes_natal[0]); 

  /*  set aspect ranges */
  put_aspect_ranges(&Orbs_trn[0],&Orb_trn_adj_for_nat[0]);


  /* this is 1st output to docin file 
  */
  f_set_doc_hdr();  /* -- this is 1st output to docin file -- */

  Is_past = 0;    /* 0= doing future, not past */



    /* note below:   NEW VERSION of DAY STRESS SCORE =  "B"
    *  gbl_instructions,  "return only day stress score_B")
    */
  /* ########################################################### */
  if(strcmp(gbl_instructions,  "return only day stress score_B") == 0) {

    do_day_stress_score_B();  /* calcs  gblTargetDayScore; */

/* 
* tn();b(44);ki(worknum);
*     worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
* tn();b(45);ki(worknum);
*     worknum = mapBenchmarkNumToPctlRank(worknum);
* b(46);ki(worknum);
*       gblTargetDayScore= *(Grhdata_bestday + iday_num-1);
* 
*/

  } else if(strcmp(gbl_instructions,  "do day stress report and return stress score") == 0) {
 b(6);tn();trn("BIG");ksn( gbl_csv_person_string); 
    int itarget_mm;
    int itarget_dd;
    int itarget_yyyy;

    do_day_stress_score_B();  /* calcs  gblTargetDayScore; */

    itarget_mm   = atof(sfromto(s,&gbl_yyyymmdd_todo[0],5,6));
    itarget_dd   = atof(sfromto(s,&gbl_yyyymmdd_todo[0],7,8));
    itarget_yyyy = atof(sfromto(s,&gbl_yyyymmdd_todo[0],1,4));

/*  */
    retval = make_calendar_day_html_file(  /* in futhtm.c */
      html_f_file_name,
      csv_person_string,
      itarget_mm,
      itarget_dd,
      itarget_yyyy,
      gblTargetDayScore
    );


    /* set up return value to mamb_report_year_in_the_life()
    */
    int worknum;  /* calibrate stress score for return value */

/*     worknum = gbl_stress_score_for_target_day; */
    worknum = gblTargetDayScore;
    worknum = worknum * -1; 
    worknum = worknum + 900;
    if (worknum <= 0) worknum = 1;
/* tn();b(44);ki(worknum); */
    worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
/* tn();b(45);ki(worknum); */
    worknum = mapBenchmarkNumToPctlRank(worknum);
/* b(46);ki(worknum); */

/*  */
    sprintf(stringBuffForStressScore, "%d", worknum);


    if (retval != 0) {
      f_docin_free();      /* free all allocated array elements */
      rkabort("Error: html file (fut) was not produced");
    }

    /* put back settings
    */
    gblTargetDayScore= 0; /* for best day on ... rpt */
    gblWeHaveTargetDayScore= 0; /* 1=yes,0=no */
    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
 b(7);tn();trn("BIG end");
    return(0);

  } else {
    do_BIGfuture();    /* deep in here, eph_space ALLOCed */ // ----------------------

  }
  /* ########################################################### */



  f_display_positions();  /* put on bottom of docin_lines */

  n = sprintf(p,"\n[end_program]\n");
  f_docin_put(p, n);

  free_eph_space();  /* free Grhdata, Grh_colnum, Eph_buf */

  /* for test  put all docin_lines to stderr
  */
  /* int ii;
  * for (ii = 0; ii <= docin_idx; ii++) {
  *   strcpy(Swk, docin_lines[ii] );
  *   fprintf(stderr,"%s", Swk);
  * } 
  */

/* fprintf(stderr,"%s|%s|%d|%d|%d|\n",  fEvent_name, year_in_the_life_todo_yyyy, */
/*     gbl_out_of_stress , gbl_in_stress, gbl_out_of_stress - gbl_in_stress); */
/*  for test, no html */


/*  */
    /* prepare stress score for ranking purposes.
    * 1.  + 8000 is to make all positive
    * 2.  / 87 is  to normalize to 100=median
    * 3.  map to standard benchmark numbers
    */

    tempnum_y = gbl_out_of_stress - gbl_in_stress;
    tempnum_y = (tempnum_y + 8000);
    if (tempnum_y < 0) tempnum_y = 0;
    tempnum_y = (tempnum_y / 123);

    /* 3. extern int mapNumStarsToBenchmarkNum(int category, int num_stars); */

    /* this is not num_stars, but rather,  gbl_out_of_stress - gbl_in_stress;
    */
    tempnum_y = mapNumStarsToBenchmarkNum(IDX_FOR_BEST_YEAR, tempnum_y);
    tempnum_y = mapBenchmarkNumToPctlRank(tempnum_y);


    /* intercept information for data request invocation
    */
    sprintf(stringBuffForStressScore, "%d", ((tempnum_y)));


/*  */
    strcpy(gbl_BuffYearStressScore, stringBuffForStressScore);
/* 
*     worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
* 
*     sprintf(stringBuffForStressScore, "%d", worknum);
* 
* 
*/



  /* we might be finished  #1  (no HTML file)
  */
  if(strcmp(gbl_instructions,  "return only year stress score") == 0) {



    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
    return(0);
  }

  /* we might be finished  #2  (no HTML file)
  */
  if(strcmp(gbl_instructions,  "return only day stress score") == 0) {

    /* prepare stress score for ranking purposes.
    * 1.  * -1  because used to be stress graph (high nums were stressful)
    *    * 10 for bigger numbers
    * 2.  +100 to make all positive
    * 3.  map to standard benchmark numbers
    */

    tempnum_x = gblTargetDayScore;
    tempnum_x = tempnum_x * -1; 
/*     tempnum_x = tempnum_x * 10; */
    tempnum_x = tempnum_x + 100;
    if (tempnum_x <= 0) tempnum_x = 1;

    /* this is not num_stars, but rather,  gbl_out_of_stress - gbl_in_stress;
    */
    tempnum_x = mapNumStarsToBenchmarkNum(IDX_FOR_BEST_DAY, tempnum_x);


/*     tempnum_x = (tempnum_x + 8000); */
/*     tempnum_x = (tempnum_x / 123); */

    /* 3. extern int mapNumStarsToBenchmarkNum(int category, int num_stars); */
/*     tempnum_x = mapNumStarsToBenchmarkNum(IDX_FOR_BEST_YEAR, tempnum_x); */


    /* intercept information for data request invocation
    */
    sprintf(stringBuffForStressScore, "%d", ((tempnum_x)));


    /* re-init stuff before leaving
    */
    gblTargetDayScore= 0; /* for best day on ... rpt */
    gblWeHaveTargetDayScore= 0; /* 1=yes,0=no */
    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
    return(0);
  }

/*   if (strcmp(gbl_instructions,  "return only day stress score_B") == 0) x */

/* !*/
/* tn();trn("score_b end"); */
    /* prepare stress score for ranking purposes.
    * 1.  * -1  because used to be stress graph (high nums were stressful)
    *    * 10 for bigger numbers
    * 2.  +100 to make all positive
    * 3.  map to standard benchmark numbers
    */

    tempnum_z = gblTargetDayScore;
    tempnum_z = tempnum_z * -1; 

/* ki(tempnum_z); */
    tempnum_z = tempnum_z + 900;
    if (tempnum_z <= 0) tempnum_z = 1;

    tempnum_z = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, tempnum_z);


/* ki(tempnum_z); */

/*     tempnum_z = (tempnum_z + 8000); */
/*     tempnum_z = (tempnum_z / 123); */

    /* 3. extern int mapNumStarsToBenchmarkNum(int category, int num_stars); */


    /* intercept information for data request invocation
    */
    sprintf(stringBuffForStressScore, "%d", ((tempnum_z)));


/*  */
/*     sprintf(gbl_BuffYearStressScore,  "%d", ((tempnum_z))); */
/* tn();b(151);ksn(gbl_BuffYearStressScore); */



  if (strcmp(gbl_instructions,  "return only day stress score_B") == 0) {


/*     worknum2 = gblTargetDayScore; */
    worknum2 = atoi(stringBuffForStressScore);

/*     worknum2 = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum2); */

/* b(75);ki(worknum2); */
    worknum2 = mapBenchmarkNumToPctlRank(worknum2);
    sprintf(stringBuffForStressScore, "%d", worknum2);

    /* re-init stuff before leaving
    */
    gblTargetDayScore= 0; /* for best day on ... rpt */
    gblWeHaveTargetDayScore= 0; /* 1=yes,0=no */
    strcpy(gbl_instructions,  "");  /* init gbl */
    allow_docin_puts = 1;           /* init gbl */
    fclose_fpdb_for_debug();
    return(0);
  }
/* !*/


  /* tn();  ksn(" HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML "); */

  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML 
  */
  scharswitch(fEvent_name, ' ', '_');


  /* html_f_file_name is arg to mamb_report_year_in_the_life()
  */
/*  */
/* tn();b(17);
* ks(stringBuffForStressScore);
* ks(gbl_BuffYearStressScore);
*/

/*   worknum3 = atoi(stringBuffForStressScore);
* kin(worknum3);
*   worknum3 = mapBenchmarkNumToPctlRank(worknum3);
* kin(worknum3);b(172);
* 
*   sprintf(stringBuffForStressScore, "%d", worknum3);
* ksn(stringBuffForStressScore);
*   sprintf(gbl_BuffYearStressScore, "%d", worknum3);
* ksn(gbl_BuffYearStressScore);
*/

  retval = make_fut_htm_file(   // ------------------------------------------------
    html_f_file_name,
    docin_lines,
    docin_idx,
    gbl_BuffYearStressScore,
    gbl_is_first_year_of_life
  );
/*  */

  if (retval != 0) {
    f_docin_free();      /* free all allocated array elements */
    rkabort("Error: html file (fut) was not produced");
  }


/* for test */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/





/* for test, show all docin lines */
/* tn();trn(" #################  ALL DOCIN LINES ##############");
* trn(" #################  ALL DOCIN LINES ##############");
* int jj; for (jj = 0; jj <= docin_idx; jj++) x 
*   kin(jj);
*   strcpy(Swk, docin_lines[jj] );
*   ks(Swk);
* x
*/
/*   close_fut_output_file(); */




  f_docin_free();      /* free all allocated array elements */


  if (strstr(instructions, "return only") == NULL) {
/*     trn("end of mamb_report_year_in_the_life()!"); */
  }  /* avoid dbmsg on non-rpt call */

  fclose_fpdb_for_debug();
/* trn("end of mamb_report_year_in_the_life()"); */
  return(0);

}  // end of mamb_BIGreport_year_in_the_life(  /* called from cocoa */


void do_BIGfuture(void)
{
  char s[8+1];
  double dmn,ddy,dyr,dstep;
  int ido;
  ;
  sfill(s,8,' ');
  if (Fut_start_mn == 0) {    /* special signal from mk_fut_input.c */
    dmn = atof(sfromto(s,&Date_of_order_entry[0],5,6)); /* "yyyymmdd" */
    ddy = atof(sfromto(s,&Date_of_order_entry[0],7,8));
    dyr = atof(sfromto(s,&Date_of_order_entry[0],1,4));
  } else {
    dmn = (double) Fut_start_mn;
    ddy = (double) Fut_start_dy;
    dyr = (double) Fut_start_yr;
  }
/* trn("do_BIGfuture() #1"); */


  init_rt();

  /* for each 6-month future ordered  --------------------------------------------------
  */


  Num_fut_units_ordered = 1;   // for  whole year

  for (ido=1; ido <= Num_fut_units_ordered; ido++) {
    global_flag_which_graph = ido;   /* 1 or 2 */

  // NUM_PTS_WHOLE_YEAR 182
    if (ido == 1)  dstep = 0.0;   /* WARNING v undefined 1st time thru */
    else  dstep = (double)(NUM_PTS_WHOLE_YEAR*Eph_rec_every_x_days);
    //else  dstep = (double)(NUM_PTS_FOR_FUT*Eph_rec_every_x_days);

    mk_new_date(&dmn,&ddy,&dyr,dstep);


    Grh_beg_mn = (int)dmn; /* to be adjusted- set_grh_top_and bot()  */ 
    Grh_beg_dy = (int)ddy; /* so that arg date jogs with eph file   */  
    Grh_beg_yr = (int)dyr; /* dates, e.g. past is on Wed       */  

/* kdn(dmn);kd(ddy);kd(dyr); */
/* kin(Grh_beg_mn ); ki(Grh_beg_dy ); ki(Grh_beg_yr ); */
    get_BIGeph_data((int)dmn,(int)ddy,(int)dyr);  /* args unused ? */

    do_grh_calcs_and_prt();    /* central pgm  qqq  */

    do_paras();

    init_rt();

  } /*  for (ido=1; ido <= Num_fut_units_ordered; ido++) */

}   // end of do_BIGfuture(void)



/* populate 3 strings  Grh_bottom_array at graph bottom. Look like this:
*   (size 99 chars  with 7 chars in lf_mar[] )
*       |   |    |     |    |    |   |    |    |     |   |    |     |   |    |     |    |    |    |    |    
*       |   10   20    |    11   21  |    11   21    |   10   20    |   10   20    |    11   21   |    11   
*  2013 jan            feb           mar             apr            may            jun            jul       
*    #define SIZE_GRH_LEFT_MARGIN 7
*    #define SIZE_EPH_GRH_LINE 107
*    #define NUM_PTS_FOR_FUT 92
*    #define NUM_GRH_BOTTOM_LINES 3
*  char Grh_bottom_line1BIG[SIZE_EPH_GRH_LINE+1];  *  +1 for \0*
*/
void mk_BIGgrh_bottom(double mn,double dy,double yr)
{
  double dstep;
  int ibot;
  //char mywk[SIZE_EPH_GRH_LINE + 1];
  //char mywk[NUM_PTS_WHOLE_YEAR  + 1];
  char mywk[NUM_PTS_WHOLE_YEAR * 2];   //  assume just big enough
  ;
/* trn("in mk_BIGgrh_bottom(double mn,double dy,double yr"); */

  /* populate lines with blanks into Grh_bottom_line s
  */
  // NUM_PTS_WHOLE_YEAR 182
  //sfill(mywk, NUM_PTS_FOR_FUT, ' ');  /* line size without left margin */
  sfill(mywk, NUM_PTS_WHOLE_YEAR , ' ');  /* line size without left margin */
  strcpy(Grh_bottom_line1BIG, mywk); 
  strcpy(Grh_bottom_line2BIG, mywk); 
  strcpy(Grh_bottom_line3BIG, mywk); 

/* trn("------- after init bottom lines:");
* ksn(Grh_bottom_line1BIG);
* ksn(Grh_bottom_line2BIG);
* ksn(Grh_bottom_line3BIG);
*/

  if (Num_eph_grh_pts == NUM_PTS_WHOLE_YEAR) {  // do big graph
    put_BIGgrh_scale_dates(0,(int)mn,(int)dy,(int)yr);  /* 1st column */
  } else {
    put_grh_scale_dates(0,(int)mn,(int)dy,(int)yr);  /* 1st column */
  }

  for (ibot=1; ibot <= Num_eph_grh_pts-1; ibot++) {  /* 1= start with 2nd col */

    dstep = (double)(Eph_rec_every_x_days);
    mk_new_date(&mn,&dy,&yr,dstep);

    if (Num_eph_grh_pts == NUM_PTS_WHOLE_YEAR) {  // do big graph
      put_BIGgrh_scale_dates(ibot, (int)mn,(int)dy,(int)yr);  /* 1st column */
    } else {
      put_grh_scale_dates(ibot, (int)mn,(int)dy,(int)yr);  /* 1st column */
    }
  }
/* trn("end of mk_BIGgrh_bottom(double mn,double dy,double yr"); */
}  // end of mk_BIGgrh_bottom(double mn,double dy,double yr)



void put_BIGscale_mark_char(int col,int line) /* line is 1 or 2 */
{
/* tn();trn("in put_BIGscale_mark_char ");ki(col);ki(line); */
/*   *(Date_array+(line-1)*SIZE_EPH_GRH_LINE+col) = SCALE_MARK_CHAR; */

  if(line == 1)  memcpy(Grh_bottom_line1BIG + col, "|", 1);  
  if(line == 2)  memcpy(Grh_bottom_line2BIG + col, "|", 1);  

/*   if(line == 1)  memcpy(Grh_bottom_line1BIG + col, "@", 1);   */
/*   if(line == 2)  memcpy(Grh_bottom_line2BIG + col, "@", 1);   */
}

//
///* for 1 6-month future
//*/
//void fill_eph_buf(void) 
//{
///* trn("fill_eph_buf()"); */
//  /* init */
//  gbl_beg_last_mth_write = 0; /* beg col of mth name last written */
//  gbl_end_last_mth_write = 0; /* end col of mth name last written */
//  set_grh_top_and_bot();
//
//  fill_eph_buf_by_calc();   /* NEW NEW NEW NEW NEW NEW NEW NEW NEW */
//
//}   // end of put_BIGscale_mark_char(int col,int line) /* line is 1 or 2 */
//


/* put_grh_scale_dates()
* 
*       |   |    |     |    |    |   |    |    |     |   |    line 1
*       |   10   20    |    11   21  |    11   21    |   10   line 2
*  2013 jan            feb           mar             apr      line 3
*---------------------------------
*         1         2         3   
*123456789 123456789 123456789 123
*---------------------------------
*/
void put_BIGgrh_scale_dates(int col,int mn,int dy,int yr)
{ 
/* trn(" in  put_BIGgrh_scale_dates"); */
  /* on "J" in january, put 2 scale mark chars
  * also, no "sideline out" on these
  *       if (global_flag_which_graph != 1) x  * leave pipes on "J" in Jan *
  */
  if (global_flag_which_graph == 1 && col == 0) {
    put_BIGscale_mark_char(col,1);
    put_BIGscale_mark_char(col,2);
  }


/*   if (global_flag_which_graph == 2  &&  times_thru3 == 0) x */
/*     times_thru3++; */

  /* add scale_mth (jul) on first star of second graph
  */
  if (global_flag_which_graph == 2 && is_first_put_grh_scale_dates == 1) {
    is_first_put_grh_scale_dates = 0;
    put_BIGscale_mth(col,mn);
    return;
  }

  if (dy >= 1  &&  dy <= Eph_rec_every_x_days) { /* beg of new mth */
    if(mn == 1) {      /* beg of january */
      if(col == 0) {  /* 1st column */
        /* jan wrt only when beg of line */
/*         put_BIGscale_mth(col,mn); */
        put_BIGscale_mth(col,mn);  /* jan wrt only when beg of line */
        return;
      }
      put_BIGscale_yr(col,yr);  /* wrt yr instead of jan */
      return;
    }
    put_BIGscale_mth(col,mn);    /* wrt mth */
    return;
  }
  if (Is_past) return;  /* don't put 10, 20 */
  if (dy >= 10  &&  dy <= 10 + (Eph_rec_every_x_days-1)) {
    put_BIGscale_dy(col,dy);
    return;
  }
  if (dy >= 20  &&  dy <= 20 + (Eph_rec_every_x_days-1)) {
    put_BIGscale_dy(col,dy);
    return;
  }
}  // end of put_BIGgrh_scale_dates(int col,int mn,int dy,int yr)


void put_BIGscale_yr(int col,int yr)
{
/* trn(" in  put_BIGgrh_scale_yr"); */
  char s[5];
  ;
  put_BIGscale_mark_char(col,1);
  put_BIGscale_mark_char(col,2);

  
  /* with new 92 star graph, no room for next year
  */
  /*   return; */

  /* UNLESS col (max 92) is  <=89 (4 chars)
  */
  if (col > Num_eph_grh_pts - 3) return;

/*   sprintf(s,"%02d",(yr-(yr/100*100))); */
/*   for (i=1; i <= 4; i++) x */
/*     *(Date_array+2*SIZE_EPH_GRH_LINE+col+(i-1)) = *(s+(i-1)); */
/*   x */

  sprintf(s,"%04d",yr);

  memcpy(Grh_bottom_line3BIG + col, s, 4);   /* 2013 */
/* ksn("line3 after day:");
* ki(strlen(Grh_bottom_line3BIG));
* ksn(Grh_bottom_line3BIG);
*/
}  // end of put_BIGscale_yr(int col,int yr)


void put_BIGscale_dy(int col,int dy)
{
/* trn(" in  put_BIGgrh_scale_dy"); */
  char s[3];
  ;
  put_BIGscale_mark_char(col,1);
  sprintf(s,"%02d",dy);

/*   for (i=1; i <= 2; i++) x */
/*     *(Date_array+SIZE_EPH_GRH_LINE+col+(i-1)) = *(s+(i-1)); */
/*   x */

  memcpy(Grh_bottom_line2BIG + col, s, 2);   /* 10,11,20,21 */
/* ksn("line2 after day:");
* ki(strlen(Grh_bottom_line2BIG));
* ksn(Grh_bottom_line2BIG);
*/

}  // end of put_BIGscale_dy(int col,int dy)


void put_BIGscale_mth(int col,int mn)
{
/* trn(" in  put_BIGgrh_scale_mth"); */
  int line, len;
  ;
  line = 2;  /* fut */
  if (Is_past) line = 1;

  put_BIGscale_mark_char(col,1);

  if (Is_past == 0) put_BIGscale_mark_char(col,2);


  if (col >= Num_eph_grh_pts-1-1) return; { /* no room on line */

/*   for (i=1; i <= 3; ++i) x  * eg  3= jan feb * */
/*     *(Date_array+line*SIZE_EPH_GRH_LINE+col+(i-1)) = *(N_mth[mn]+(i-1)); */
/*   x    * ^on 3rd bottom line (line = 2) */

  /* put month names */
  /* Jan, Feb etc */

/*  memcpy(Grh_bottom_line3BIG + col, N_mth[mn], 3);*/  /* jan, feb etc */
/*   memcpy(Grh_bottom_line3BIG + col, N_mth_cap[mn], 3);   */
  /* Thu 29 May 2014 12:09:27 EDT */
  /* Jan, Feb etc */
/*   memcpy(Grh_bottom_line3BIG + col, N_mth_allcaps[mn], 3);  */



 len = (int)strlen(N_allcaps_long_mth[mn]); 
/*  tn();kin(len);ksn(N_allcaps_long_mth[mn]);  */

  /* if it's going to be an overwrite put spaces
  *  (only happens for first mth name on line)
  */
  int current_beg_mth_write;
  current_beg_mth_write = col;
/* kin(current_beg_mth_write ); */
  if (current_beg_mth_write <= gbl_end_last_mth_write) {
/* trn("WRITE SPACES!"); */
    memcpy(Grh_bottom_line3BIG + gbl_beg_last_mth_write, "                             ", 25);  
  }

/*   memcpy(Grh_bottom_line3BIG + col, N_allcaps_long_mth[mn], len);   */
  memcpy(Grh_bottom_line3BIG + col+1, N_allcaps_long_mth[mn], len);  

  gbl_beg_last_mth_write = col;       /* beg col of mth name last written */
  gbl_end_last_mth_write = col + len - 1 ;/* end col of mth name last written */

/* ki(gbl_beg_last_mth_write); ki(gbl_end_last_mth_write); */


/* ksn("line3 after mth:");
* ki(strlen(Grh_bottom_line3BIG));
* ksn(Grh_bottom_line3BIG);
*/
  }  /* put month names */


}  // end of put_BIGscale_mth(int col,int mn)


void do_aBIG_graph(int p_grh[], int grh_num)    /* qqq */
{
  int n;
  char *p = &Swk[0];
  static int fut_line_ctr;
/*   char grh_line[SIZE_EPH_GRH_LINE+1]; */
  char grh_line[8192];

  //int cols_with_pt[SIZE_EPH_GRH_LINE+1];/*for this line, col#s holding a pt*/
  int cols_with_pt[SIZE_BIG_EPH_GRH_LINE+1];/*for this line, col#s holding a pt*/

    /* cols_with_pt starts at [1] */
  int k,m,current_grh_y_val,last_grh_y_val_printed,nl,pt_ctr;
  ;                      /* nl = newest line in grh */
/* trn("in do_aBIG_graph()"); */

  n = sprintf(p,"\n\n[beg_graph]\n");  /* signal to fmt_f.awk */
  /* fput(p,n,Fp_docin_file); */
  f_docin_put(p,n);

  Num_lines_in_grh_body = 0;
  last_grh_y_val_printed = 0;
  pt_ctr = 0;
  fut_line_ctr = 0;
  current_grh_y_val = *(p_grh+Num_eph_grh_pts-1);/* for 1st time thru below */
  last_grh_y_val_printed = current_grh_y_val;  /* for 1st time thru below */

  prt_BIGgrh_hdr(grh_num);   // whole year does not need header  yes it does, for blnk line of sky

  sfill(&grh_line[0],Num_eph_grh_pts,GRH_BACKGROUND_CHAR);
  for (k=Num_eph_grh_pts-1; k > -1; k--) {
    if ( (nl=*(p_grh+k)) != current_grh_y_val  &&
          Num_lines_in_grh_body < MAX_GRH_BODY_LINES  ) {

      prt_BIGgrh_line(&grh_line[0],&cols_with_pt[0],pt_ctr,
        &fut_line_ctr,Grh_top);

      for (m=1; m <= last_grh_y_val_printed-nl-1; m++) {
        prt_BIGgrh_line(&grh_line[0],&cols_with_pt[0],0,
          &fut_line_ctr,Grh_top);
      }
                /* ^ put in 'blank' lines */
      last_grh_y_val_printed = nl;
      pt_ctr = 0;
    }

    pt_ctr++;
    cols_with_pt[pt_ctr] = Grh_colnum[k];
    current_grh_y_val = nl;

/*  */
/* kin(current_grh_y_val); */

  }


  prt_BIGgrh_bot(&grh_line[0],&cols_with_pt[0],pt_ctr,&fut_line_ctr);

   n = sprintf(p,"\n[end_graph]\n\n");  /* signal to fmt_f.awk */
   f_docin_put(p,n);

/* trn("end of  do_aBIG_graph()"); */
}   // end do_aBIG_graph(int p_grh[], int grh_num)    /* qqq */


void prt_BIGgrh_hdr(int grh_num)  /* grh title and 2nd line */
{
/* trn("in prt_BIGgrh_hdr"); */
  char lf_mar[SIZE_GRH_LEFT_MARGIN+1];
  char star_desc[64], star_wk[64], num1[16], num2[16];

  //char wk_line[SIZE_EPH_GRH_LINE+1];
  char wk_line[SIZE_BIG_EPH_GRH_LINE+1];

  int n;
  char *p = &Swk[0];
  long int tmp_long;
  ;
  sfill(&lf_mar[0],SIZE_GRH_LEFT_MARGIN,' ');
/*
* if (Is_past) strcpy(&star_desc[0],".(one star every Wednesday)");
* else sprintf(&star_desc[0],"(one star for every %d days)",
*   Eph_rec_every_x_days);
*/
  sfill(star_desc,26,'.');
  tmp_long =  (long int) out_of_stress;
  commafy_int(num1, tmp_long, 6);
  tmp_long =  (long int)     in_stress;
  commafy_int(num2, tmp_long, 6);
  sprintf(star_wk, "ok=%s+, stress=%s-",   /* area score  good/bad */
    strim(num1," "), strim(num2," ") );
  memcpy(star_desc, star_wk, strlen(star_wk));


  // 20141229  for BIG, no grh header
  //
// 
//   /* put name in field of dots
//   */
//   char dotfield[MAX_SIZE_PERSON_NAME+2];  /* 15 in 201309 */
//   sfill(dotfield, MAX_SIZE_PERSON_NAME+1, '.');
//   memcpy(dotfield, fEvent_name, strlen(fEvent_name));
//   dotfield[MAX_SIZE_PERSON_NAME+1] = '\0';
// 
// 
// /*    "\n\n%s .....%s..........................................%s.....%s..... \n", */
// /*     Grh_name[grh_num],   */
// /*    "\n\n%s .....%s.............................................%s.....%s..... \n", */
// /*     "\n\n%s .....%s.............................................%s.....%s..... \n",  */
// 
// /* tn(); */
// /* ksn(&lf_mar[0]); */
// /* ksn(dotfield); */
// /*     "\n\n%s ..<span class=\"bgy\">...%s.....................T.......................%s.....%s..... </span>\n",  */
// /*     "\n\n%s ..<span class=\"bgy\">...%s..................T.....................%s.....%s..... </span>\n",  */
// 
//   // this is big  version, so add 92 dots in middle
//   char dotfield_92[128];
//   sfill(dotfield_92, 92, '.'); // #define NUM_PTS_WHOLE_YEAR 184
//   n = sprintf(p,
//     "\n\n%s<span class=\"bgy\"> .....%s.................%s.......................%s.....%s..... </span>\n", 
//     &lf_mar[0],
//     dotfield,   // with person name
//     dotfield_92, // fill for big double sized graph
//     year_in_the_life_todo_yyyy,
// //    (global_flag_which_graph == 1)? "First 6 months.": "Second 6 months" 
//     (global_flag_which_graph == 1)? "               ": "               " 
//   );
// /*     (global_flag_which_graph == 1)? "First Half.": "Second Half"  */
// /* kin(strlen(p)); */
// /* ksn(p); */
// 
//   scharswitch(p, '.', ' ');  /* dots out */
// 
//   f_docin_put(p,n);
// 



  strcpy(p,"\n");  /* blank line before grh lines */
  n = (int)strlen(p);
  f_docin_put(p,n);
/* kin(strlen(p)); */


  sfill(&wk_line[0],Num_eph_grh_pts,GRH_CONNECT_CHAR);
  wk_line[0] = GRH_SIDELINE_CHAR;  
  wk_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR;


  n = sprintf(p,"%s%s\n",&lf_mar[0],&wk_line[0]);  /* 2nd line */

/*  scharswitch(p, '|', ' '); */ /* sideline out */;
  scharswitch(p, '|', '#');  /* sideline out */

      bracket_string_of("#", p, "<span class=\"cSky\">", "</span>");
      scharswitch(p, '#', ' ');

  n = (int)strlen(p);
/* kin(n); */
  f_docin_put(p,n);

  put_BIGgrh_blnk_lines_at_top();

}   // end of prt_BIGgrh_hdr(int grh_num)  /* grh title and 2nd line */


void put_BIGgrh_blnk_lines_at_top(void)    /* top is now the bottom */
{      /* after reversal. (high stress used to be at the top) */
  static int top_ln_ctr;
  int itop;
  int dummy[1];
  //char prt_line[SIZE_EPH_GRH_LINE+1];
  char prt_line[SIZE_BIG_EPH_GRH_LINE+1];
  ;
/* trn("in put_BIGgrh_blnk_lines_at_top"); */
  dummy[0] = 0; /* init */
  if (False_top <= Grh_top) return;
  top_ln_ctr = 0;
  sfill(&prt_line[0],Num_eph_grh_pts,GRH_BACKGROUND_CHAR);

  /* sideline out */
/*   prt_line[0] = GRH_SIDELINE_CHAR; */
/*   prt_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR; */


  for (itop=1; itop <= Num_file_lines_top; ++itop) {
/* tn();b(200);ki(Num_file_lines_top); */
    prt_BIGgrh_line(&prt_line[0],dummy,0,&top_ln_ctr,False_top);
  }
/* ksn(gbl_save_last_line); */
} // end of put_BIGgrh_blnk_lines_at_top(void)    /* top is now the bottom */


void prt_BIGgrh_bot(char *p_line, int cols_with_pt[], int pt_ctr, int *p_ln_ctr)
{
  char lf_mar[SIZE_GRH_LEFT_MARGIN+1];
  int n,k;
  char *p = &Swk[0];
  char mywk[SIZE_GRH_LEFT_MARGIN+1];
  ;
/* trn("in prt_BIGgrh_bot"); */
  sfill(&lf_mar[0],SIZE_GRH_LEFT_MARGIN,' ');

  *p_ln_ctr = -1;      /* last line marker */
  prt_BIGgrh_line(&p_line[0],&cols_with_pt[0],pt_ctr,   
    p_ln_ctr,Grh_top); /* last line */

  sfill(&p_line[0],Num_eph_grh_pts,GRH_CONNECT_CHAR);
  /* sideline out */
/*   p_line[0] = GRH_SIDELINE_CHAR; */
/*   p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR; */

  put_fill_lines_at_bot(&p_line[0]);  /* now top after reversal */

  reverse_BIGgrh_body_and_prt();

  sfill(&p_line[0],Num_eph_grh_pts,GRH_BACKGROUND_CHAR);

  /* sideline out */
/*   p_line[0] = GRH_SIDELINE_CHAR; */
/*   p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR;  */ /* one buffer line */

  n = sprintf(p,"%s%s\n",&lf_mar[0],&p_line[0]);

  //scharswitch(p, GRH_BACKGROUND_CHAR, '|');   // change tick from apostrophe to pipe
  scharswitch(p, GRH_BACKGROUND_CHAR, '\'');

  f_docin_put(p,n);
      /* ^bot line of dots */

  /* sideline out */
/*   */
  if (global_flag_which_graph != 1) {  /* leave pipes on "J" in Jan */
    Grh_bottom_line1BIG[0] = ' ';  /* 1st col, (sideline char) */
  }
  Grh_bottom_line1BIG[Num_eph_grh_pts-1] = ' '; /* right side of grh*/

  n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line1BIG);
  f_docin_put(p,n);

  /* sideline out */
  if (global_flag_which_graph != 1) {  /* leave pipes on "J" in Jan */
    Grh_bottom_line2BIG[0] = ' ';  /* 1st col, (sideline char) */
  }

  /* right side of grh*/
/*   Grh_bottom_line2BIG[Num_eph_grh_pts] = ' ';  */
/*   Grh_bottom_line2BIG[Num_eph_grh_pts-1] = 'Q';  */

  n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line2BIG);
  f_docin_put(p,n);

  /* put year into line3 lf_mar 
  */
  sfill(mywk, SIZE_GRH_LEFT_MARGIN, ' ');
  sprintf(mywk,"%4d  ", Grh_beg_yr);    /* =magic */
  k = (int)strlen(lf_mar) -1 - 4;           /* 4= numchar in yr e.g. 1988 */
  strncpy(lf_mar+k, mywk, 4);

/*   n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line3BIG); */

  strcpy(p,"\n");  /* blank line before line with month names   may 2014 */
  n = (int)strlen(p);
  f_docin_put(p,n);

  n = sprintf(p,"%s%s\n", &lf_mar[0], Grh_bottom_line3BIG);
  f_docin_put(p,n);

/* trn("end of prt_BIGgrh_bot"); */
}   // end of prt_BIGgrh_bot(char *p_line, int cols_with_pt[], int pt_ctr, int *p_ln_ctr)


void reverse_BIGgrh_body_and_prt(void)  /* grh used to have high stress at top */
{
  int iprt, n, running_stress_level_on_line;
  char linebuf[8192];
  char *p = &Swk[0];
  char *q = &Grh_body_BIG[0];
  int we_have_hit_great_line;  /* 1=y,0=n */
  int we_have_hit_good_line;  /* 1=y,0=n */
  int we_have_hit_stress_line;  /* 1=y,0=n */
  int we_have_hit_omg_line;  /* 1=y,0=n */
  char myLastLine[8192];
  int  first_star_is_in_great, myidx;
  int  first_star_is_in_good;
  ;
/* trn("in reverse_BIGgrh_body_and_prt"); */
  /* 20130911 ONLY use these flags to determine star coloring
  *  for good (green) and stress (red)
  */
  we_have_hit_great_line   = 0;  /* init to no */
  we_have_hit_good_line   = 0;  /* init to no */
  we_have_hit_stress_line = 0;  /* init to no */
  we_have_hit_omg_line = 0;  /* init to no */

/* tn();trn("in reverse_BIGgrh_body_and_prt()"); */

  if (Num_lines_in_grh_body-1 <  MAX_GRH_BODY_LINES-1) {
    iprt = Num_lines_in_grh_body-1;
  } else {
    iprt = MAX_GRH_BODY_LINES-1;
  }
  /* read thru Grh_body_BIG to see if "GREAT-" or "GOOD-" is first.
  *  (this is for coloring the first star lines.  we do not
  *   know if Great * or Good * level is first)
  */
  myidx = iprt;
  first_star_is_in_great = 0;
  first_star_is_in_good  = 0;




  for ( ;  myidx > -1  ; --myidx) {    /* iprt is num lines in grh body */
    strcpy(linebuf, q+myidx*(SIZE_GRH_LEFT_MARGIN+SIZE_BIG_EPH_GRH_LINE+1));
    if (strstr(linebuf, "GREAT")  != NULL) {
      first_star_is_in_great = 1;
      break;
    }
    if (strstr(linebuf, "GOOD")   != NULL) {
      first_star_is_in_good = 1;
      break;
    }
  }


  /* graph top (used to be on bot)
  *  this stress level num increases as graph moves down.
  */
  running_stress_level_on_line = Grh_bot; /* graph top (used to be on bot) */

int  have_printed_blank_top_line;  /*  take out */
  have_printed_blank_top_line = 0;

  for ( ;  iprt > -1  ; --iprt) {    /* iprt is num lines in grh body */

    // strcpy(linebuf, q+iprt*(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1));
    strcpy(linebuf, q+iprt*(SIZE_GRH_LEFT_MARGIN+SIZE_BIG_EPH_GRH_LINE+1));


/*  show iprt and how many stars in linebuf  */
/* int starcnt; starcnt = scharcnt(linebuf, '*'); */
/* kin(iprt);ki(starcnt); */
/*  show iprt and how many stars in linebuf  */


    if (strstr(linebuf, "GREAT")  != NULL)   we_have_hit_great_line  = 1;
    if (strstr(linebuf, "GOOD")   != NULL)   we_have_hit_good_line   = 1;
    if (strstr(linebuf, "STRESS") != NULL)   we_have_hit_stress_line = 1;
    if (strstr(linebuf, "OMG")    != NULL)   we_have_hit_omg_line    = 1;



    /* we want no blank lines above the GOOD green line level (or GREAT
    *  They must contain a * or X.
    *  TOP LINE OF GRAPH CANNOT BE "EMPTY" of * or X  UNLESS it is GOOD line
    */

/* OLD */
/*         && we_have_hit_great_line == 0  */
/* trn("  !!!   no blank lines above GREAT line !!!"); */

    /* line contains no  * or X  */  
    /* this is bot/ now top line of all connect_CHARS (#)
    */
    if (   sall(linebuf, " |#") 
        && have_printed_blank_top_line == 0
        && we_have_hit_good_line == 0 ) {

        strcat(linebuf, "##");  /* weird bug fix */

      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');

      scharswitch(linebuf, '|', ' ');  /* sideline out */

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      have_printed_blank_top_line = 1;

      continue;

    }

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* if(i==41)xstrcpy(linebuf, "X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX   * X*");x */
/* if(i==40)xtn();tr("-----------ordinary(40) ----------line---");ksn(linebuf);tn();x */
/* if(i==41)xstrcpy(linebuf, "X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX X * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX *");x */
/* if(i==41)xstrcpy(linebuf, "       |X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX X * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX *|");x */
/* if(i==41)xstrcpy(linebuf, "       |                            *X  *XX XX  XX X * X* X  *X  *XX X                            |");x  */
/* if(i==41)xstrcpy(linebuf, "       |                            *X  *XX XX  XX X *                                            |");x  */


/* kin(running_stress_level_on_line); ki(Stress_val[SUBSCRIPT_FOR_LO_STRESS_LEVEL]); */
/*    if (running_stress_level_on_line < Stress_val[SUBSCRIPT_FOR_LO_STRESS_LEVEL] *//* is GOOD */

    /* here we have not hit the GREAT line OR the GOOD LINE 
    *  we are either  in Great color or GOOD color
    */
    if (   we_have_hit_great_line == 0
        && we_have_hit_good_line  == 0
        && strstr(linebuf, "GOOD") == NULL    /* not on GOOD line */
        && strstr(linebuf, "GREAT") == NULL ) /* not on GREAT line */
    {
      /* here we are in GREAT territory- color cGr2
      */
/*       strsubg(linebuf, "X ", "<span class=\"cGr2\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cGr2\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cGr2\">*</span>");
* 
*       strsubg(linebuf, 
*         "<span class=\"cGr2\">*</span><span class=\"cGr2\">*</span>",
*         "<span class=\"cGr2\">**</span>"
*       );
*       strsubg(linebuf, 
*         "<span class=\"cGr2\">**</span><span class=\"cGr2\">**</span>",
*         "<span class=\"cGr2\">****</span>"
*       );
*/
/*       bracket_string_of("X*", linebuf, "<span class=\"cGr2\">", "</span> "); */

      /* great or good
      */
      if (first_star_is_in_great == 1) {
        bracket_string_of("X", linebuf, "<span class=\"cGr2\">", "</span>");
      }
      if (first_star_is_in_good  == 1) {
        bracket_string_of("X", linebuf, "<span class=\"cGre\">", "</span>");
      }

      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }

    /* here we have hit the GREAT line, but not the GOOD line
    *  we are in GOOD color
    **/
    if (   we_have_hit_good_line == 0 
        && strstr(linebuf, "GOOD") == NULL    /* not on GOOD line */
        && strstr(linebuf, "GREAT") == NULL ) /* not on GREAT line */
    {
      /* here we are in GOOD territory- color cGre
      */
/*       strsubg(linebuf, "X ", "<span class=\"cGre\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cGre\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cGre\">*</span>");
* 
*       strsubg(linebuf, 
*         "<span class=\"cGre\">*</span><span class=\"cGre\">*</span>",
*         "<span class=\"cGre\">**</span>"
*       );
*       strsubg(linebuf, 
*         "<span class=\"cGre\">**</span><span class=\"cGre\">**</span>",
*         "<span class=\"cGre\">****</span>"
*       );
*/
      bracket_string_of("X", linebuf, "<span class=\"cGre\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }


    /*  we are in Neutral color  (no stress line yet) */
    if (   we_have_hit_stress_line == 0
        && strstr(linebuf, "GOOD") == NULL    /* not on GOOD line */
        && strstr(linebuf, "GREAT") == NULL) {/* not on GREAT line */
      bracket_string_of("X", linebuf, "<span class=\"cNeu\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */
    }


    if (   we_have_hit_stress_line == 1
        && we_have_hit_omg_line != 1
        && strstr(linebuf, "STRESS") == NULL  /* not on STRESS line */
        && strstr(linebuf, "OMG")    == NULL) /* not on    OMG line */
    {
      /* here we are in STRESS territory- color Red
      */
/*       strsubg(linebuf, "X ", "<span class=\"cRed\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cRed\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cRed\">*</span>");
*/

      bracket_string_of("X", linebuf, "<span class=\"cRed\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }


    if (   we_have_hit_omg_line == 1
        && strstr(linebuf, "OMG")    == NULL) /* not on    OMG line */
    {
      /* here we are in OMG territory- color Re2
      */
/*       strsubg(linebuf, "X ", "<span class=\"cRe2\">X</span> ");
*       strsubg(linebuf, " X", " <span class=\"cRe2\">X</span>"); 
*       strsubg(linebuf, "*" , "<span class=\"cRe2\">*</span>");
*/

      bracket_string_of("X", linebuf, "<span class=\"cRe2\">", "</span>");
      scharswitch(linebuf, 'X', ' ');
      bracket_string_of("#", linebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(linebuf, '#', ' ');
      scharswitch(linebuf, '|', ' ');  /* sideline out */

      /* turn star (*) into caret (^) with star color */
      bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
      scharswitch(linebuf, '*', '^');

      n = sprintf(p,"%s\n", linebuf);
      f_docin_put(p,n);
      running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;
      continue;
    }


    /* NOTE it looks like GREAT falls thru to here  (maybe the others) */

    /* turn star (*) into caret (^) with star color */
    bracket_string_of("*", linebuf, "<span class=\"star\">", "</span>");
    scharswitch(linebuf, '*', '^');



    n = sprintf(p,"%s\n", linebuf);
    f_docin_put(p,n);
    running_stress_level_on_line += SIZE_EPH_GRH_INCREMENT;

  }  /* for each line in grh body */

  /* put extra line at bottom for esthetics
  *  (saving last line preserves its color)
  */
  /* get color of last line and print an empty grh line with it */
/* tn();b(420);ksn(gbl_save_last_line); */
  if (strstr(gbl_save_last_line, "STRESS") == NULL) {  /* only if not on stress line */
/* ksn("PPUTTING blank line"); */
    if (strstr(gbl_save_last_line, "cRed") != NULL) {
      sfill(myLastLine, Num_eph_grh_pts, ' '); 
      bracket_string_of(" ", myLastLine, "<span class=\"cRed\">", "</span>");
      n = sprintf(p,"       %s\n", myLastLine );  /* left margin = 7 spaces */
      f_docin_put(p,n);
/* ksn("PPUTTING blank line"); */
    }
    if (strstr(gbl_save_last_line, "cRe2") != NULL) {
      sfill(myLastLine, Num_eph_grh_pts, ' '); 
      bracket_string_of(" ", myLastLine, "<span class=\"cRe2\">", "</span>");
      n = sprintf(p,"       %s\n", myLastLine );  /* left margin = 7 spaces */
      f_docin_put(p,n);
/* ksn("PPUTTING blank line"); */
    }
  }


  scharswitch(gbl_save_last_line, 'X', ' ');
  scharswitch(gbl_save_last_line, '#', ' ');
  scharswitch(gbl_save_last_line, '*', ' ');
  scharswitch(gbl_save_last_line, '|', ' ');  /* sideline out */
/* b(300); */
  n = sprintf(p,"%s\n", gbl_save_last_line);
  f_docin_put(p,n);
/* trn(" end of reverse_BIGgrh_body_and_prt()"); */

}  /* end of reverse_BIGgrh_body_and_prt() */


/* with \n at end */
void prt_BIGgrh_line(char *p_line, int cols_with_pt[],int pt_ctr, int *p_ln_ctr, int top) 
{
  int ilin;
  ;
// trn("in prt_BIGgrh_line");
  ++Num_lines_in_grh_body;

  /* do not walk the plank */
  if (Num_lines_in_grh_body >= MAX_GRH_BODY_LINES) return;
 
  /* sideline out */
/*  p_line[0] = GRH_SIDELINE_CHAR; */ /* 1st col, (sideline char) */
/*  p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR; */ /* right side of grh*/

  /* pts in graph
  */
  for (ilin=1; ilin <= pt_ctr; ilin++) {
    *(p_line+cols_with_pt[ilin]) = EPH_GRH_CHAR;
  } 


  /* try to avoid stars on the sideline  (jun 2013)
  * 1st col, (sideline char) 
  * right side of grh
  */
/*  weird */
  /* sideline out */
/*   p_line[0] = GRH_SIDELINE_CHAR;  */
/*   p_line[Num_eph_grh_pts-1] = GRH_SIDELINE_CHAR;  */

/*   p_line[0] = 'q';  */
/*   p_line[Num_eph_grh_pts-1] = 'q';  */
/* tn();kc(p_line[0]); kc(p_line[Num_eph_grh_pts-1]); */
  /*     *(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1),"%s%s\0", (warn on 0) */

  /* PUT LINE IN TBL
   */
  //             (SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1),
  sprintf(  
    Grh_body_BIG + (Num_lines_in_grh_body-1) * 
               (SIZE_GRH_LEFT_MARGIN + SIZE_BIG_EPH_GRH_LINE + 1),
    "%s%s",
    get_grh_left_margin(p_ln_ctr,top,p_line),
    p_line
  );

  strcpy(gbl_save_last_line, p_line);

  for (ilin=1; ilin <= pt_ctr; ilin++)
    *(p_line+cols_with_pt[ilin]) = GRH_CONNECT_CHAR;  /*ch pt to connect*/

  if (Just_did_good_line == 1) {
    Just_did_good_line = 0;
    undo_good_line(p_line);

    for (ilin=1; ilin <= pt_ctr; ilin++)
      *(p_line+cols_with_pt[ilin]) = GRH_CONNECT_CHAR;  /*ch pt to connect*/
  }
}  /* end of prt_BIGgrh_line() */


/* for 1 *12-MONTH* future
*/
void get_BIGeph_data(int m,int d,int y)  /* args unused ? */
{
/* trn("in get_BIGeph_data(int "); */
  /* Only free eph_space stuff if calloc_eph_space has run already
  *  during this call to mamb_report_year_in_the_life()
  */
  if (is_first_calloc_eph_space == 1) {
    is_first_calloc_eph_space = 0;
  } else {
    free_eph_space();
  }
  // NUM_PTS_WHOLE_YEAR 182
  // Num_eph_grh_pts = (Is_past)? NUM_PTS_FOR_PAST: NUM_PTS_FOR_FUT;
  Num_eph_grh_pts = (Is_past)? NUM_PTS_FOR_PAST: NUM_PTS_WHOLE_YEAR; // <-----
  calloc_eph_space();

  Eph_rec_every_x_days = STEP_SIZE_FOR_FUT;

  fill_eph_buf();

}  /* end of get_BIGeph_data() */


// ===  end of  =================  BIG report renamed functions  ===============================
// ===  end of  =================  BIG report renamed functions  ===============================
// ===  end of  =================  BIG report renamed functions  ===============================

/* end of futdoc.c */
