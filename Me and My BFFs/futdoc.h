/* futdoc.h */


#include <stdio.h>
#include <math.h>
#include <string.h>
#include <unistd.h>  /* for unlink futin file */
#include <ctype.h>   /* toupper() */

/*  #include "as_defsm.h" */
#include "futdefs.h"


char year_in_the_life_todo_yyyy[6];
char mth_of_birth[6];
char day_of_birth[6];
char year_of_birth[6];

#define DOCIN_ARRAY_MAX 512  
char *docin_lines[DOCIN_ARRAY_MAX];
int   docin_idx = 0;
char  errbuf[256];
void f_docin_put(char *line, int length);
void f_docin_free(void); 

int  global_flag_which_graph;   /* 1 or 2 */

char Grh_bottom_line1[SIZE_EPH_GRH_LINE+1];  /*  +1 for \0*/
char Grh_bottom_line2[SIZE_EPH_GRH_LINE+1];
char Grh_bottom_line3[SIZE_EPH_GRH_LINE+1];

/* in this file futdoc.c */
void fill_eph_buf_by_calc(void);
void free_eph_space(void);

void do_future_args(int argc_from_main, char *args[]);
void arg_abort(void);
int  start_up(void);
void put_aspect_ranges(int *porbs, int *porb_adj);
void open_fut_output_file(void);
void close_fut_output_file(void);
void do_future(void);
void get_eph_data(int m, int d, int y);
void calloc_eph_space(void);
void open_eph_file(int year);
void close_eph_file(void);
void get_ctrl_rec_stuff(void);
void sput_date_range(char *s, int m, int d, int y, int step);
void mk_grh_bottom(double mn, double dy, double yr);
void put_grh_scale_dates(int col, int mn, int dy, int yr);
void put_scale_mth(int col,int mn);
void put_scale_yr(int col,int yr);
void put_scale_dy(int col,int dy);
void put_scale_mark_char(int col,int line);
/* void fill_eph_buf(int m,int d,int y); */
void fill_eph_buf(void);
void set_grh_top_and_bot(void);
int  read_eph(struct Futureposrec *pbuf,int offset);
void do_grh_calcs_and_prt(void);
int  isaspect(int mdiff,int right_row);
void put_minutes(int *pi);
int  get_minutes(double d);

/* void calc_fut_graph(int nat_plt,int aspect_num,int trn_plt,int day_num); */
void add_aspect_to_grhdata(int nat_plt,int aspect_num,int trn_plt,int day_num);
void add_aspect_to_grhdata_bestday(int nat_plt,int aspect_num,int trn_plt,int day_num);
void add_aspect_to_grhdata_score_B(int nat_plt,int aspect_num,int trn_plt,int day_num);

int  get_sign(int minutes);
int  get_house(int minutes,int mc);
void do_grhs(void);
void set_tops_and_bots(int grh_num);
void do_a_graph(int p_grh[], int grh_num);
void prt_grh_hdr(int grh_num);
char *strim(char *s, char *set);
void put_grh_blnk_lines_at_top(void);
void prt_grh_bot(char *p_line, int cols_with_pt[], int pt_ctr, int *p_ln_ctr);
void put_fill_lines_at_bot(char p_line[0]);
void reverse_grh_body_and_prt(void);
void prt_grh_line(char *p_line, int cols_with_pt[],
                  int pt_ctr, int *p_ln_ctr, int top);
char *get_grh_left_margin(int *p_ln_ctr, int top, char *p_line);
void put_good_line(char *p_line);
void undo_good_line(char *p_line);
void sort_grh(int varg[], int n, int altarg[]);
void do_size_grh(void);
void sfill(char *sarg, int num, int c);
int  get_fut_input(char *futin_pathname);
void init_bufs(void);
void rd_futin(char *buf, int num_being_read);
/* char *rkfgets(char *buf, int size_buf,FILE *fp_inputfile); */
void assign_fld(int jrk);
/* void wrt_letter_window(void); */
void f_set_doc_hdr(void);
void display_event_specs(void);
char *scapwords(char *s);
/* char *sallcaps(char *); */
char *swholenum(char *t, char *s);
char *sdecnum(char *t, char *s);
int  sfind(char s[], char c);
void f_display_positions(void);
char *sfromto(char *dest, char *srcarg, int beg, int end);
int  sall(char *s, char *set);
/* <.> */


/* the following four externs are defined in mambutil.o */
extern double Arco[];  /* one of 2 tables returned from calc_chart */
  /* `coordinates' are in following order: */
  /* xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_ */
  /* positions are in radians */
extern char *Retro[];     /* one of two tables returned from calc_chart */
              /* plts in same order as above */
              /* R if retrograde, _ if not */
extern double fnu();    /* these functions are in calc_chart.o */
extern double fnd();    /* these functions are in calc_chart.o */
/* the above four externs are defined in calc_chart.o */
char *Prt_retro[NUM_PLANETS+3+1];  /* rearranged table */

/* extern char *strcat(); */
/* extern double atof(),floor(),sin(); */
/* extern unsigned get_ticks(); */


extern double day_of_year();
extern char *get_grh_left_margin();
extern char *sfromto();
extern char *swholenum();
extern char *sdecnum();
extern char *scapwords();
extern void commafy_int(char *dest, long intnum, int sizeofs);
/* extern char *rkfgets(); */
extern char *strchr();
/* extern char *memset(); */
/* the above four externs are defined in mambutil.o */



/* char *N_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""}; */
/* see day_of_week() */

/* sun,mer,ven first   then MOON at 10am,1pm,4pm,7pm */
char *N_planet_bestday[] =   /* trn plt for  bestday */
    {"sun","mer","ven","mar","m10","m01","m04","m07"};

char *N_planet[] =
    {"   ","sun","moo","mer","ven","mar","jup","sat","ura","nep","plu",
     "nod","asc","mc_"};
char *N_trn_planet[] =  /* i think this should be xmjsunp (mars 1st) */
    {"   ","jup","sat","ura","nep","plu","mar"};
char *N_sign[] = {
"sgn","ari","tau","gem","can","leo","vir","lib","scp","sag","cap","aqu","pis"};
char *N_aspect[] =
    {"   ","cnj","sxt","squ","tri","opp","tri","squ","sxt","cnj"};
char *N_mth[] = {
"mth","jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"};
char *N_mth_cap[] = {
"Mth","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
char *N_mth_allcaps[] = {
"MTH","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
char *N_long_mth[] = {
    "month","January","February","March","April","May","June",
    "July","August","September","October","November","December"};
char *N_allcaps_long_mth[] = {
    "MONTH","JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE",
    "JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"};
  /* following 3 are for doc set-up e.g. ^(mogsa) */
char *N_short_nat_plt[] = {"x","su","mo","me","ve","ma"};
char *N_short_trn_plt[] = {"x","ju","sa","ur","ne","pl","ma"};
char *N_short_doc_aspect[] = {"c","g","b"};  /* 0=cnj,1=good,2=bad */
/* numlines=11, sizeline=57 */
char *Title_lines[11];  /* 11 is magic- see f_display_positions() */
char *Fut_title_lines[] = {
  "*** * * *** * * **  ***    **   * * *** *  * *** * * *** ",
  "*   * *  *  * * * * *     *     *** * * ** *  *  * * *   ",
  "**  * *  *  * * *** **    ***   * * * * ** *  *  *** *** ",
  "*   * *  *  * * **  *     *  *  * * * * * **  *  * *   * ",
  "*   ***  *  *** * * ***    **   * * *** *  *  *  * * *** ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
};
char *Past_title_lines[] = {
  "***  *  *** ***   ***   * * ***  *  **  ***              ",
  "* * * * *    *      *   * * *   * * * * *                ",
  "**  *** ***  *     *    *** **  *** *** ***              ",
  "*   * *   *  *    *      *  *   * * **    *              ",
  "*   * * ***  *   ****    *  *** * * * * ***              ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
  "                                                         ",
};

/* the following is for K&R fns day_of_year() & month_day() */
double Day_tab[2][13] = {
  {365.0,31.0,28.0,31.0,30.0,31.0,30.0,31.0,31.0,30.0,31.0,30.0,31.0},
  {366.0,31.0,29.0,31.0,30.0,31.0,30.0,31.0,31.0,30.0,31.0,30.0,31.0}
};
/* trn orbs all 2 degrees */
int Orbs_trn[NUM_ASPECTS+1] = {0,120,120,120,120,120,120,120,120,120};

int Orb_trn_adj_for_nat[NUM_PLANETS+1] = {0,40,30,27,24,21,-20,0,-20,-25,-30};

int Aspect_id[NUM_ASPECTS+1] =
             {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9};
        /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
      /* degrees x  0  60   90   120   180   240   270   300  360 */
int Aspects[NUM_ASPECTS+1]=
              {-1,  0,3600,5400,7200,10800,14400,16200,18000,21600};
      /* degrees x  0  60   90   120   180   240   270   300  360 */
        /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */

int Aspect_type[NUM_ASPECTS+1] = {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0};
 /* Aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */

/* size of angle between 2 plts for all aspects
*/

int Beg_aspect_ranges[(NUM_PLANETS)*(NUM_ASPECTS+1)];
int End_aspect_ranges[(NUM_PLANETS)*(NUM_ASPECTS+1)];
  /* subscript is (nat_plt-1)*(NUM_ASPECTS+1) + num_of_this_aspect */
  /* or ...[nat_plt-1][num_of_this_aspect] */



/*** structures ***/
/* structure definitions for type Futureposrec, type date and type Runrec */
/* are in as_defines.h   (date and Runrec are also used in putasp.c) */
/* struct Runrec {
*   int aspect_id;
*   struct Date from_date;
* };
* 
*/
/*  */
struct Futureposrec mar_to_plu;
/* following is array of structs of type Runrec */
struct Runrec Rt[NUM_PLANETS+1];      /* rt=running_table */
/* there is a Runrec record for each nat_plt */
/*** end of structures ***/

char Date_array[NUM_DATE_SCALE_LINES*(SIZE_EPH_GRH_LINE+1)];
/* 3 prt lines for bottom of grh (time axis) */

/* see #define SIZE_GRH_LEFT_MARGIN in as_defines.h */
int Stress_val[NUM_STRESS_LEVELS] = {304,250,196,142,88,34,-20,-74};
/* char *Stress_name[NUM_STRESS_LEVELS] = {
*   "             ",
*   "HIGH STRESS- ",
*   "             ",
*   "-----STRESS- ",
*   "SOME STRAIN- ",
*   "-------GOOD--",
*   "  VERY GOOD- ",
*   "  FANTASTIC- ",
* };
*/
char *Stress_name[NUM_STRESS_LEVELS] = {
  "       ",
  "   OMG-",
  "       ",
  "STRESS-",
  "       ",
  "  GOOD-",
  "       ",
  " GREAT-",
};
/*   " YIKES- ", */

#define SIZE_GRH_NAME 23    /* 36 for sm */
char *Grh_name[NUM_EPH_GRAPHS-1] = {
"A YEAR IN THE LIFE",
};
/* #define SIZE_GRH_NAME 36    * 36 for sm * */
/* "UPS AND DOWNS OVER THE MONTHS.......", */

int Ar_minutes_natal[NUM_PLANETS+1+3];  /* +1 for [0], +3 for nod asc mc */

/* extern FILE *fopen(); */
FILE *Fp_an_eph_file;
FILE *Fp_docin_file;
FILE *Fp_futin_file;

/* struct defined in futdefs.h */
struct Futureposrec *Eph_buf;  /* ptr to current buffer for /eph file */
struct Futureposrec_bestday *Eph_buf_bestday;  /* ptr to current buffer for /eph file */


int *Grhdata_bestday;     /* for sun,mer,ven,moo */

int *Grhdata;     /* 2 tables calloc'd in get_future_data() */
int *Grh_colnum;  /* 2 tables calloc'd in get_future_data() */
int Num_eph_grh_pts;  /* get_future_data() assigns value */
int Eph_rec_every_x_days;  /* [2] from futurepos ctrl rec */

int Is_past;  /* 1= doing past, 0= no, doing future */
  /* funny switch to tell fns when we're doing past or future */
int Grh_top;  /* value of highest line in grh */
  /* ^ defined in do_grhs(), used in get_grh_left_margin()  */
int Grh_bot;
int False_top;  /* =Grh_top unless Grh_top < hi stress level */
        /* then = hi stress level (200) */
int False_bot;
int Num_file_lines_top,Num_file_lines_bot;
int House_confidence,Moon_confidence;
double Current_aspect_force;    /* 0.0 - 1.0 */
  /*       pi    orb_in_minutes - diff_from_exact     */
  /* sin( --  X  --------------------------------)     */
  /*      2      orb_in_minutes           */
  /* defined in is_aspect(), used in calc_fut_graph() */
double Moon_confidence_factor;
char Grh_title_dates[NUM_CHAR_DATE_RANGE+1];
  /* e.g. "from 25dec83 to 14Feb84" */
int Num_lines_in_grh_body;
char Grh_body[(SIZE_GRH_LEFT_MARGIN+SIZE_EPH_GRH_LINE+1)*MAX_GRH_BODY_LINES];
  /* hold body of grh (for inverting) */
int Mark_this_line;  /* put grh_linemark char in to this line */

/* bufs to hold future cmd args */

char Arg_futin_pathname[SIZE_INBUF+1];  /* see as_defines.h for argnum defs */
char Arg_docin_dir[SIZE_INBUF+1];

char Docin_pathname[SIZE_INBUF+1];
char Inbuf[SIZE_INBUF+1];

/* the following are output from mk_fut_input.c */
char fEvent_name[SIZE_INBUF+1];
char Madd_last_name[SIZE_INBUF+1];
char Madd_first_names[SIZE_INBUF+1];
char Madd1[SIZE_INBUF+1];  /* mailing address line 1 */
char Madd2[SIZE_INBUF+1];  /* adress line 2 */
char City_town[SIZE_INBUF+1];
char Prov_state[SIZE_INBUF+1];
char Country[SIZE_INBUF+1];
char Postal_code[SIZE_INBUF+1];
char Letter_comment_1[SIZE_INBUF+1];
char Letter_comment_2[SIZE_INBUF+1];
char Is_ok[SIZE_INBUF+1];
char Futin_filename[SIZE_INBUF+1];
char Ordnum[SIZE_INBUF+1];
char Date_of_order_entry[SIZE_INBUF+1];
char Ln_prt[SIZE_INBUF+1];

double fInmn,fIndy,fInyr,fInhr,fInmu,fIntz,fInln,fInlt;
int    fInap;  /* am or pm, 0 or 1 */
/* int fIncf; */ /* cf= conffIdence fIn tfIme of day */

int Num_past_units_ordered,Past_start_mn,Past_start_dy,Past_start_yr;
int Num_fut_units_ordered,Fut_start_mn,Fut_start_dy,Fut_start_yr;

int Grh_beg_mn, Grh_beg_dy, Grh_beg_yr;  /* start date for this grh */
/* int Eph_file_beg_mn, Eph_file_beg_dy, Eph_file_beg_yr; */
        /* ^for this eph file */
double fPI_OVER_2;
/* char Swk[SIZE_PRTBUF+1]; */
char Swk[8192];

/* end of futuresm.h */
/* futtblsm.h */
/***
* int plt_in_12[NUM_PLANETS]
*   [NUM_SIGNS]
*   [NUM_HOUSES_CONSIDERED] = {    (houses = 1 )
*   10 x 12 x 5 = 600 ints, 1200 bytes
***/


/* sun,mer,ven,moo
*/
char Plt_in_12_bestday[ NUM_PLANETS_TRN_BESTDAY *NUM_SIGNS*NUM_HOUSES_CONSIDERED] = {
/* sun */
/*ari tau gem can leo vir */
  5,  8,  5,  7,  6,  6,
/*lib scp sag cap aqu pis */
  7,  6,  5,  8,  5,  7,
/* mer */
  4,  4,  4,  5,  4,  6,
  5,  4,  4,  6,  5,  6,
/* ven */
  4,  8,  6,  6,  5,  5,
  8,  7,  4,  5,  5,  7,
/* mar */
  6,  7,  4,  7,  5,  4,
  7,  5,  5,  7,  4,  6,
/* moo 10am */
  5,  8,  5,  8,  5,  4,
  7,  5,  4,  7,  4,  7,
/* moo  1pm */
  5,  8,  5,  8,  5,  4,
  7,  5,  4,  7,  4,  7,
/* moo  4pm */
  5,  8,  5,  8,  5,  4,
  7,  5,  4,  7,  4,  7,
/* moo  7pm */
  5,  8,  5,  8,  5,  4,
  7,  5,  4,  7,  4,  7,
};


char Plt_in_12[NUM_PLANETS*NUM_SIGNS*NUM_HOUSES_CONSIDERED] = {

/* sun */
/*ari tau gem can leo vir */
5,  8,  5,  7,  6,  6,
/*lib scp sag cap aqu pis */
7,  6,  5,  8,  5,  7,
/* moo */
5,  8,  5,  8,  5,  4,
7,  5,  4,  7,  4,  7,
/* mer */
4,  4,  4,  5,  4,  6,
5,  4,  4,  6,  5,  6,
/* ven */
4,  8,  6,  6,  5,  5,
8,  7,  4,  5,  5,  7,
/* mar */
6,  7,  3,  7,  5,  4,
7,  5,  5,  7,  4,  6,
/* jup */
5,  6,  4,  7,  4,  4,
5,  5,  4,  6,  4,  5,
/* sat */
5,  8,  5,  8,  5,  5,
8,  6,  5,  8,  5,  8,
/* ura */
4,  7,  4,  7,  5,  4,
6,  5,  4,  7,  4,  4,
/* nep */
4,  5,  4,  4,  5,  4,
5,  4,  4,  5,  4,  8,
/* plu */
4,  7,  4,  6,  5,  2,
7,  5,  4,  7,  4,  4,
};
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* sun */
* /*ari tau gem can leo vir */
* 5,  5,  5,  5,  5,  5,
* /*lib scp sag cap aqu pis */
* 5,  5,  5,  5,  5,  5,
* /* moo */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* mer */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* ven */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* mar */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* jup */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* sat */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* ura */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* nep */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* /* plu */
* 5,  5,  5,  5,  5,  5,
* 5,  5,  5,  5,  5,  5,
* };
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/



/********
*   int aspect_multiplier[NUM_ASPECT_TYPES]
*              [NUM_PLANETS_IN_EPH_FILES]
*              [NUM_PLANETS]
*              [NUM_HOUSES_CONSIDERED]  = {
*  3 x 6 x 10 x 5 = 900 ints, 1800 bytes
********/

char Aspect_multiplier_bestday [NUM_ASPECT_TYPES*    /* 3 */
            NUM_PLANETS_TRN_BESTDAY*   /* 4 transiting plts sun,mer,ven,mo10,mo01,mo04,mo07 */
            NUM_PLANETS*
            NUM_HOUSES_CONSIDERED]  = {

/* natal plts */
/* sun,moo,mer,ven,mar */
/* jup,sat,ura,nep,plu, */

/* CNJ******** */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* sun */
* 8,  8,  8,  8,  8,
* 8,  8,  8,  8,  8,
* /* mer */
* 4,  4,  4,  4,  4,
* 4,  4,  4,  4,  4,
* /* ven */
* -4,  -4,  -4,  -4,  -4,
* -4,  -4,  -4,  -4,  -4,
* /* moo */
* 6,  6,  6,  6,  6,
* 6,  6,  6,  6,  6,
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
/* sun */
-6,  1,  1,  -2,  1,
-3,  4,  4,  4,  4,
/* mer */
1,  1,  -2,  -1,  1,
-1,  2,  2,  2,  2,
/* ven */
1,  1,  1,  -1,  1,
-1,  2,  2,  2,  2,
/* mar */
2,  2,  3,  -1,  2,
-2,  3,  3,  3,  3,
/* moo 10am */
1,  -2,  1,  -2,  1,
-2,  3,  3,  3,  3,
/* moo  1pm */
1,  -2,  1,  -2,  1,
-2,  3,  3,  3,  3,
/* moo  4pm */
1,  -2,  1,  -2,  1,
-2,  3,  3,  3,  3,
/* moo  7pm */
1,  -2,  1,  -2,  1,
-2,  3,  3,  3,  3,

/* FVR**************/
/* sun */
-8,  -8,  -8,  -8,  -8,
-8,  -8,  -8,  -8,  -8,
/* mer */
-4,  -4,  -4,  -4,  -4,
-4,  -4,  -4,  -4,  -4,
/* ven */
-4,  -4,  -4,  -4,  -4,
-4,  -4,  -4,  -4,  -4,
/* mar */
-4,  -4,  -4,  -4,  -4,
-4,  -4,  -4,  -4,  -4,
/* moo 10am */
-6,  -6,  -6,  -6,  -6,
-6,  -6,  -6,  -6,  -6,
/* moo  1pm */
-6,  -6,  -6,  -6,  -6,
-6,  -6,  -6,  -6,  -6,
/* moo  4pm */
-6,  -6,  -6,  -6,  -6,
-6,  -6,  -6,  -6,  -6,
/* moo  7pm */
-6,  -6,  -6,  -6,  -6,
-6,  -6,  -6,  -6,  -6,

/* UNFVR**************/
/* sun */
8,  8,  8,  8,  8,
8,  8,  8,  8,  8,
/* mer */
4,  4,  4,  4,  4,
4,  4,  4,  4,  4,
/* ven */
4,  4,  4,  4,  4,
4,  4,  4,  4,  4,
/* mar */
6,  6,  6,  6,  6,
6,  6,  6,  6,  6,
/* moo 10am */
6,  6,  6,  6,  6,
6,  6,  6,  6,  6,
/* moo  1pm */
6,  6,  6,  6,  6,
6,  6,  6,  6,  6,
/* moo  4pm */
6,  6,  6,  6,  6,
6,  6,  6,  6,  6,
/* moo  7pm */
6,  6,  6,  6,  6,
6,  6,  6,  6,  6,

};



char Aspect_multiplier  [NUM_ASPECT_TYPES*
            NUM_PLANETS_IN_EPH_FILES*       /* transiting plts jup,sat,ura,nep,plu,mar */
            NUM_PLANETS*
            NUM_HOUSES_CONSIDERED]  = {

/* natal plts */
/* sun,moo,mer,ven,mar */
/* jup,sat,ura,nep,plu, */

/* CNJ******** */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* jup */
* -5,  -5,  -5,  -5,  -5,
* -5,  -5,  -5,  -5,  -5,
* /* sat */
* 7,  8,  5,  8,  4,
* -4,  8,  5,  5,  5,
* /* ura */
* 6,  8,  5,  8,  7,
* -4, 4, 4,  4,  4,
* /* nep */
* 5,  8,  7,  8,  4,
* 4,  4,  4,  4,  4,
* /* plu */
* 7,  7,  7,  7,  7,
* 3,  4,  3,  3,  3,
* /* mar */
* 4,  4,  3,  -2,  2,
* 2,  3,  2,  2,  2,
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
/* CNJ******** */
/* jup */
-5,  -5,  -5,  -5,  -5,
-5,  -5,  -5,  -5,  -5,
/* sat */
8,  8,  8,  8,  8,
5,  6,  5,  5,  5,
/* ura */
8,  8,  8,  8,  8,
4,  4 , 4,  4,  4,
/* nep */
8,  8,  8,  8,  8,
4,  4,  4,  4,  4,
/* plu */
8,  8,  8,  8,  8,
4,  4,  4,  4,  4,
/* mar */
5,  5,  5,  5,  5,
2,  2,  2,  2,  2,


/* FVR**************/

/* natal plts */
/* sun,moo,mer,ven,mar */
/* jup,sat,ura,nep,plu, */

/* jup */
-6,  -6,  -4,  -5,  -4,
-4,  -5,  -4,  -3,  -3,
/* sat */
-5,  -4,  -4,  -5,  -4,
-5,  -5,  -3,  -3,  -3,
/* ura */
-4,  -4,  -4,  -6,  -4,
-4,  -3,  -3,  -3,  -3,
/* nep */
-4,  -4,  -3,  -5,  -3,
-2,  -2,  -2,  -2,  -2,
/* plu */
-4,  -3,  -3,  -5,  -4,
-2,  -2,  -2,  -2,  -2,
/* mar */
-3,  -2,  -2,  -4,  -2,
-3,  -2,  -2,  -2,  -2,


/* UNFVR**************/

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* jup */
* 3,  3,  3,  4,  6,
* 2,  4,  2,  2,  2,
* /* sat */
* 8,  8,  6,  8,  5,
* 3,  6,  3,  3,  4,
* /* ura */
* 7,  7,  5,  7,  6,
* 2,  3,  2,  2,  2,
* /* nep */
* 6,  7,  5,  7,  3,
* 2,  3,  2,  3,  2,
* /* plu */
* 6,  5,  4,  6,  5,
* 2,  3,  2,  2,  2,
* /* mar */
* 3,  3,  2,  2,  2,
* 1,  2,  2,  1,  2,
* };
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
/* jup */
3,  3,  3,  4,  5,
2,  4,  2,  2,  2,
/* sat */
8,  8,  8,  8,  6,
3,  6,  3,  3,  4,
/* ura */
8,  8,  8,  8,  6,
2,  3,  2,  2,  2,
/* nep */
8,  8,  8,  8,  6,
2,  3,  2,  3,  2,
/* plu */
8,  8,  8,  8,  6,
2,  3,  2,  2,  2,
/* mar */
3,  3,  2,  2,  3,
2,  2,  2,  2,  4,
};



/* int grh_fut[NUM_FUT_GRAPHS*100] ;*/
            /* 100 = NUM_FUT_GRH_POINTS */
            /* 6 x 100 = 600 ints, 1200 bytes */
            /* holds numbers for the future graphs */
/* the above is now allocated with calloc() to avoid magic number = 100 */
/* see get_future_data() */

/* end of futdoc.h */
