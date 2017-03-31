/*   grpdoc.c      */

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

/*   kinds of group report 
*          1. "member in group"    
*          2. "all group members"   
*          3. "just 2 people"
   #import Darwin.C.tgmath
   #import "Darwin.C.tgmath.h"  
   #import "tgmath.h"   <this worked in xcode
* */

/* int dbctr;  * debug * */

/* #include "rkdebug.h"  comment out, use rkdebug.o instead */
#include "rkdebug_externs.h"

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <sys/time.h>
#include <math.h>

#include "rk.h"
#include "grpdoc.h"
 

char *set_cell_bg_color_2(int in_score) ;

//int  gbl_g_max_len_group_data_PSV = 64;
int  gbl_g_max_len_group_data_PSV = 128;
//int  gbl_g_top_bot_threshold  = 300;    // more data lines than this, then show top 200 + bot 100
//int  gbl_g_show_top_this_many = 200;
//int  gbl_g_show_bot_this_many = 100;
int  gbl_g_top_bot_threshold  = 200;    // more data lines than this, then show top 200 + bot 100
int  gbl_g_show_top_this_many = 150;
int  gbl_g_show_bot_this_many =  50;
char gbl_my1_group_report_line[128];  // int gbl_g_max_len_group_data_PSV = 128;
char gbl_my2_group_report_line[128];
char gbl_my3_group_report_line[128];



#define IDX_FOR_MYSTERIOUS 91

/*  struct timeval tdbeg, tdend;  long us2; gettimeofday(&tdbeg, NULL ); */
/*  gettimeofday(&tdend, NULL ); us2 = usecdiff(tdend,tdbeg); kin(us2); */
#define usecdiff(end,beg) ((end.tv_sec*1000000+end.tv_usec) - (beg.tv_sec*1000000 + beg.tv_usec))


          /*   kinds of group report   */
          /* 1. "member in group"      */
          /* 2. "all group members"    */
          /* 3. "just 2 people" */

/* may 2013  4,4,16,16 =40  int=4?
*/
#define MAX_SIZE_PERSON_NAME  15



/*   char score_color[4];   * "vhi","hi","avg","lo","vlo" * */
struct rank_report_line {      /* info for html file production */
  int  rank_in_group;
  int  score;
  char person_A[MAX_SIZE_PERSON_NAME+1];
  char person_B[MAX_SIZE_PERSON_NAME+1];
};

/* trait_report_line array declarations */
struct trait_report_line {
  int  rank_in_group;
  int  score;
  char person_name[MAX_SIZE_PERSON_NAME+1];
};

/* 
*   assuming MAX_PERSONS_IN_GROUP = 250, num pairs max is  31,125 
*   (5 sec to run on pc/gcc , 1 sec on mac/llvm )
*/
// #define MAX_PERSONS_IN_GROUP 250   /* also defined incocoa.c and grphtm.c */
#define MAX_PERSONS_IN_GROUP 200   /* also defined incocoa.c and grphtm.c */
#define MAX_IN_RANK_LINE_ARRAY \
( ( (MAX_PERSONS_IN_GROUP * (MAX_PERSONS_IN_GROUP - 1) / 2) ) + 128 )

struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
int out_rank_line_idx;  /* pts to current line in out_rank_lines */


struct trait_report_line *out_trait_lines[MAX_PERSONS_IN_GROUP + 128];
int out_trait_line_idx;  /* pts to current line in out_trait_lines */





#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* struct cocoa_rank {            /* info for cocoa table display */
*   char cocoa_rank_color[6] ;   /* like "cGre", "cRe2" ... */
*   char cocoa_rank_string[48] ; /* like "  1  Anya_   Liz_       99       "  */
*                                /* like "                        90  Great"  */
* };
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/





/* typedef struct rank_report_line Rank_report_line; */ /* capital R for typedef */
struct avg_report_line {
  int  rank_in_group;
  int  avg_score;
  char person_name[MAX_SIZE_PERSON_NAME+1];
/*  char hex_color[8]; */  /* like "66ff33" */
};


extern int mamb_report_year_in_the_life(  /* in futdoc.o */
  char *html_f_file_name,
  char *csv_person_string,   /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
);


/* ----------------------------------------------------------- */
//int mamb_report_personality ( /* in perdoc.o, called from incocoa */
//  char *html_file_name,
//  char *csv_person_string,
//  char *instructions,  /* like "return only csv with all trait scores",  */
//  char *stringBuffForTraitCSV
//);
//
int mamb_report_personality ( /* in perdoc.o, called from incocoa */
  char *html_output_filename_webview,
  char *html_output_filename_browser,
  char *csv_person_string,
  char *instructions,  /* like "return only csv with all trait scores",  */
  char *string_buffer_for_trait_csv
);
/* ----------------------------------------------------------- */

/* ----------------------------------------------------------- */
int mamb_report_trait_rank(    /* is called from cocoa */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[], /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *trait_name,
/*   struct rank_report_line *rank_lines[],  do not need */
/*   int  *rank_idx, */
//  struct trait_report_line *trait_lines[],   /* array of output report data */
//  int  *trait_idx,           /* ptr to int having last index written */                   
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
);
int get_trait_score(char *trait_name, char *stringBuffForTraitCSV);

int make_html_file_trait_rank( /* in grphtm.c */
  char *group_name,
  int   num_persons_in_grp,
  char *trait_name,
  char *in_html_filename,           /* in grphtm.c */
  struct trait_report_line  *in_trait_lines[],
  int   in_trait_lines_last_idx,
  char *grp_average_trait_scores_csv 
);
//  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
//  int  *out_group_report_idx       /* ptr to int having last index written */
/* ----------------------------------------------------------- */

/* ----------------------------------------------------------- */
/* NOTE: best yr rpt uses a lot of trait code
*/


int mamb_report_best_day(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyymmdd_todo, 
//  struct trait_report_line *trait_lines[],   /* array of output report data */
//  int  *trait_idx,           /* ptr to int having last index written */                   
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
);

int mamb_report_best_year(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyy_todo, 
//  struct trait_report_line *trait_lines[],   /* array of output report data */
//  int  *trait_idx,           /* ptr to int having last index written */                   
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
);
/* ----------------------------------------------------------- */

/* ----------------------------------------------------------- */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* int mamb_report_avg_scores(    /* called from cocoa */
*   char *html_file_name,
*   char *group_name,
*   char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
*   int  num_persons_in_grp,
*   struct rank_report_line *out_rank_lines[], 
*   int  *out_rank_line_idx,
*   struct avg_report_line *avg_lines[],   /* array of output report data */
*   int  *avg_idx            /* ptr to int having last index written */                   
* );
* int make_html_file_avg_scores( /* produce actual html file */
*   char *group_name,
*   int   num_persons_in_grp,
*   char *in_html_filename,           /* in grphtm.c */
*   struct avg_report_line  *in_avg_lines[],
*   int   in_avg_lines_last_idx,
*   char *instructions,      /* like "return only html for table in string" */
*   char *string_for_table_only   /* 1024 chars max (its 9 lines formatted) */
* );
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   char *instructions,
*   char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
*   char *instructions,
*   char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
/* ----------------------------------------------------------- */

/* ----------------------------------------------------------- */
//int  mamb_report_person_in_group(  /* in grpdoc.o */ 
//  char *html_file_name,
//  char *group_name,
//  char *in_csv_person_arr[],
//  int  num_persons_in_grp,
//  char *compare_everyone_with, /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
//  struct rank_report_line *rank_lines[],   /* array of output report data */
//  int  *rank_idx           /* ptr to int having last index written */
//);
//
int  mamb_report_person_in_group(  /* in grpdoc.o */ 
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],
  int  num_persons_in_grp,
  char *compare_everyone_with,   /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
//  struct rank_report_line *out_rank_lines[],   /* array of output report data */
//  int  *out_rank_line_idx,                     /* ptr to int having last index written */
  //char *out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx,      /* ptr to int having last index written */
  int  kingpin_is_in_group
);

//int make_html_file_person_in_group( /* produce actual html file */
//  char *group_name,
//  int   num_persons_in_grp,
//  char *html_file_name,                    /* in grphtm.c */
//  struct rank_report_line  *in_rank_lines[],  /* array of report data */
//  int   in_rank_lines_last_idx,   /* int having last index written */
//  int   avg_score_this_member     /* for report bottom */
//);
//
int make_html_file_person_in_group( /* produce actual html file */
  char *group_name,
  int   num_persons_in_grp,
  char *html_file_name,                    /* in grphtm.c */
  struct rank_report_line  *in_rank_lines[],  /* array of report data */
  int   in_rank_lines_last_idx,   /* int having last index written */
  int   avg_score_this_member,    /* for report bottom */
//  //char *out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
//  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
//  int  *out_group_report_idx ,     /* ptr to int having last index written */
  int  kingpin_is_in_group
);


/* ----------------------------------------------------------- */

/* int mamb_report_all_grp_members(  */
//int mamb_report_whole_group(    /* called from cocoa */
//  char *html_file_name,
//  char *group_name,
//  char *in_csv_person_arr[], /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
//  int  num_persons_in_grp,
//  struct rank_report_line *rank_lines[],   /* array of output report data */
//  int  *rank_idx,           /* ptr to int having last index written */                   
//  char *instructions,
//  char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
//);
//
int mamb_report_whole_group(    /* called from cocoa */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[], /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
//  struct rank_report_line *rank_lines[],   /* array of output report data */
//  int  *rank_idx,           /* ptr to int having last index written */                   
  char *instructions,
  char *string_for_table_only, /* 1024 chars max (its 9 lines formatted) */
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
);

//int make_html_file_whole_group( /* produce actual html file */
//  char *group_name,
//  int   num_persons_in_grp,
//  char *in_html_filename,           /* in grphtm.c */
//  struct rank_report_line  *in_rank_lines[],
//  int   in_rank_lines_last_idx,
//  char *instructions,
//  char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
//);
//
int make_html_file_whole_group( /* produce actual html file */
  char *group_name,
  int   num_persons_in_grp,
  char *in_html_filename,           /* in grphtm.c */
  struct rank_report_line  *in_rank_lines[],
  int   in_rank_lines_last_idx,
  char *instructions,
  char *string_for_table_only, /* 1024 chars max (its 9 lines formatted) */
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
);

/* ----------------------------------------------------------- */
int mamb_report_just_2_people(    /* called from cocoa */
  char *html_browser_file_name,
  char *html_webview_file_name,
  char *person_1_csv,         /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *person_2_csv
);
int make_html_file_just_2_people(  /* produce actual html file */
  char *in_html_filename,         /* browser HTML or webview HTML */
  char *in_docin_lines[],
  int   in_docin_last_idx,
  char *person_1_csv,         /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *person_2_csv
);
/* ----------------------------------------------------------- */


struct cached_person_positions {
  char person_name[20]; 
  int  minutes_natal[14];
/*   int  is_EXCLUDED;      NOT USED   */
} g_cached_pos_tab[MAX_PERSONS_IN_GROUP+1];  /* +1 for person_in_group rpt (he is not group member) */
typedef struct cached_person_positions Cached_person_positions; /* capital C denotes typedef) */


/* in cocoa these are defined:
*/
/* Define the array of ranking report line data.
*   (Rank  Score  person_a  person_b)
*/

int  trait_line_idx;
void g_trait_line_put(
  struct trait_report_line line,
  struct trait_report_line *out_trait_lines[], /* output param returned */
  int    *out_trait_line_idx
);
void g_trait_line_free(
  struct trait_report_line *out_trait_lines[],  /* output param returned */
  int trait_line_last_used_idx
);

int   rank_line_idx;
void g_rank_line_put(
  struct rank_report_line line,
  struct rank_report_line *out_rank_lines[], /* output param returned */
  int    *out_rank_line_idx
);
void g_rank_line_free(
  struct rank_report_line *out_rank_lines[],  /* output param returned */
  int rank_line_last_used_idx
);

int   avg_line_idx;
void g_avg_line_put(
  struct avg_report_line line,
  struct avg_report_line *out_avg_lines[], /* output param returned */
  int    *out_avg_line_idx
);
void g_avg_line_free(
  struct avg_report_line *out_avg_lines[], /* output param returned */
  int avg_line_last_used_idx
);

/* int   grankn; */
/*char *grankp = &Swk[0]; */ /* 512 */


/*#define MAX_NUM_REPORT_LINES 20000 */ /* num pairs for 200 max persons */
/* struct rank_report_line rank_line_tab[MAX_NUM_REPORT_LINES]; */

/* these are in rkdebug.o */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);

/* these are in mambutil.c
*/
extern int mapAVGbenchmarkNumToPctlRank(int in_score);
extern void scharswitch(char *s, char ch_old, char ch_new);
extern int mapBenchmarkNumToPctlRank(int in_score);
extern int day_of_week(int month, int day, int year);
extern int mapNumStarsToBenchmarkNum(int category, int num_stars);
extern int scharcnt(char *s, int c);

extern void get_event_details(  
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


extern double Arco[];  /* one of 2 tables returned from calc_chart */
  /* `coordinates' are in following order: */
  /* xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_ */
  /* positions are in radians */
extern char *Retro[]; 
              /* plts in same order as above */
              /* R if retrograde, g if not */
extern double fnu(); 
extern double fnd();

extern void strsort(char *v[], int n);
extern char *sfromto(char *dest, char *src, int beg, int end);
extern void sfill(char *s, int num, int c);
extern char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);

extern int binsearch_person_in_cache(
  char *person_name,
  struct cached_person_positions tab[],
  int num_elements
);
/* in mambutil.c */


/* declarations */
void gmake_paras(void);
int get_unbalanced_score(char *stringBuffForTraitCSV);
void display_buffs_to_stderr(void);
void save_pair_compat_score(int good, int bad);
void display_for_astrology_buffs(void);
void do_comparisons(char *csv_person_1, char *csv_person_2);
/* void set_name_A_for_doc(void); */
/* void set_name_B_for_doc(void); */
void do_future_args(int argc_from_main, char *args[]);
/* void g_arg_abort(void); */
void g_make_special_graphs(void);
void do_special_lines(int idx, int numer, int denom);
void do_grh_data_lines(int idx);
void g_mk_grh_line(int num_stars, int g_or_b);
void g_wrap_grh_line(int num_stars, int g_or_b);
void fill_A_position_strings(void);
void fill_B_position_strings(void);
/* void wrt_letter_window(void); */
/* char *scapwords(char *s); */
/* char *sallcaps(char *s); */
/* char *swholenum(char *t, char *s); */
/* char *sdecnum(char *t, char *s); */
/* int sfind(char s[], char c); */
int g_get_sign(int minutes);
void strsort(char *v[], int n);
/* char *rkstrrchr(char *s, char c); */
/* int sall(char *s, char *set); */
/* int start_up(void); */
void g_put_minutes(int *pi);
int g_get_minutes(double d);
void store_sgn_and_hse_placements_1(void);
void store_sgn_and_hse_placements_2(void);
void store_comp_aspects(void);
void g_add_all_asps_to_grh_data(void);
void g_add_an_asp_to_grh_data(int plt1, int plt2, int aspect_num);
void adjust_addval(int *paddval, int plt1, int plt2);
int g_get_aspect_multiplier(int aspect_type, int plt1, int plt2, int category_num);
void put_comp_stuff(int plt1, int plt2, int addval);
void add_to_comp_specials(int idx, int addval);
void g_put_aspect_strings(void);
void g_init_item_tbl(void);
void init_grh_datas(void);
int g_isaspect(int m1, int m2, int *porbs);
void g_calc_current_aspect_force(int m1, int m2, int *porbs, int aspect_num);
/* void set_confidence(int a_or_b); */
int g_get_house(int minutes, int mc);
void display_a_positions_and_title(void);
void set_constants(void);

void this_pair_get_data(
  char *current_person,
  char *other_person,
  int num_persons_in_grp,
  int num_persons_in_cached_array
);

void put_stuff_in_cached_array(char *in_csv_person_arr[], int num_persons_in_grp);
void get_stuff_from_cached_array(
  char *current_person,
  char *other_person,
  int  num_persons_in_grp,
  int  num_persons_in_cached_array
);


/* int Func_compare_rank_report_line_scores(
*     struct rank_report_line **line1,
*     struct rank_report_line **line2  );
*/
int Func_compare_rank_report_line_scores( const void *line1, const void *line2);
typedef int (*compareFunc_rank) (const void *, const void *);

int Func_compare_cached_positions_person_name(
    struct cached_person_positions *pos1,
    struct cached_person_positions *pos2 );
typedef int (*compareFunc_positions) (const void *, const void *);

int Func_compare_avg_report_line_scores( const void *line1, const void *line2);
typedef int (*compareFunc_avg) (const void *, const void *);

int Func_compare_trait_report_line_scores( const void *line1, const void *line2);
typedef int (*compareFunc_trait) (const void *, const void *);



/*     struct cached_person_positions *, */
/*     struct cached_person_positions *); */

char xxx1[128];
/* static char sav_compat_line[SIZE_INBUF+1]; */
char xxx2[128];
char sav_b_long[40];
char sav_b_birth[50];
char sav_ordnum[32];
double sav_a_INMN;
double sav_a_INDY;
double sav_a_INYR;
double sav_a_INHR;
double sav_a_INMU;
int    sav_a_INAP;
char sav_a_LN_PRT[32];

int A_stars_persn_g;  /* just 2 people ? */
int A_stars_persn_b;
int A_stars_aview_g;
int A_stars_aview_b;
int A_stars_bview_g;
int A_stars_bview_b;
int A_stars_love_g;
int A_stars_love_b;
int A_stars_money_g;
int A_stars_money_b;
int A_stars_ovral_g;
int A_stars_ovral_b;

int B_stars_persn_g; 
int B_stars_persn_b;
int B_stars_aview_g;
int B_stars_aview_b;
int B_stars_bview_g;
int B_stars_bview_b;
int B_stars_love_g;
int B_stars_love_b;
int B_stars_money_g;
int B_stars_money_b;
int B_stars_ovral_g;
int B_stars_ovral_b;

int stars_persn_g; 
int stars_persn_b;
int stars_aview_g;
int stars_aview_b;
int stars_bview_g;
int stars_bview_b;
int stars_love_g;
int stars_love_b;
int stars_money_g;
int stars_money_b;
int stars_ovral_g;
int stars_ovral_b;


#define DOCIN_ARRAY_MAX 1500
char *docin_lines[DOCIN_ARRAY_MAX];
int   docin_idx;
char  errbuf[256];
void  g_docin_put(char *line, int length);
void  g_docin_free(void); 
int   gdocn;
char *gdocp = &Swk[0];  /* 512 */
/* ----------------------- */

int is_first_g_docin_put;       /* 1=yes, 0=no */
int is_first_g_rank_line_put;   /* 1=yes, 0=no */
int is_first_g_avg_line_put;   /* 1=yes, 0=no */
int is_first_g_trait_line_put;   /* 1=yes, 0=no */
int allow_docin_puts_for_now;  /* 1=yes, 0=no  no= no graph output (like for just2) */


//int global_pair_compatibility_score;
//int global_pair_compatibility_score_a;
//int global_pair_compatibility_score_b;
//
int global_pair_compatibility_score;
int global_pair_a_compatibility_score;
int global_pair_b_compatibility_score;

char  gbl_fut_yyyy_todo[128];
char  gbl_fut_yyyymmdd_todo[128];
double gbl_best_day_mth; 
double gbl_best_day_day;
double gbl_best_day_year;
char   gbl_bestyear_yyyy_todo[16];
char   gbl_bestday_yyyy_todo[16];
int  gbl_is_best_year_or_day;
char gblGrpAvgTraitScoresCSV1[128];


/* ----------------  BEST YEAR  -------------------------- */
/* ----------------  BEST YEAR  -------------------------- */
int mamb_report_best_year(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyy_todo, 
//  struct trait_report_line *trait_lines[],   /* array of output report data */
//  int  *trait_idx,           /* ptr to int having last index written */                   
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
) 
{
  int retval;
  char my_trait_name[128];

  fopen_fpdb_for_debug();

  gbl_is_best_year_or_day = 1;  /* yes */

  /* build the report title and put it into "trait_name" string arg
  */

  strcpy(gbl_fut_yyyy_todo, yyyy_todo);

  gbl_is_best_year_or_day = 1;  /* yes */
  strcpy(gbl_bestyear_yyyy_todo, yyyy_todo);
  strcpy(gbl_bestday_yyyy_todo, "not applicable");

  out_rank_line_idx = 0;
/*   trait_idx    = 0; */

  /* note: trait_name contains "Best Calendar Year"
  */
  sprintf(my_trait_name, "Best Calendar Year  %s", yyyy_todo);

  retval = mamb_report_trait_rank(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    in_csv_person_arr,   /* in_csv_person_arr[] */
    num_persons_in_grp,  /* num_persons_in_grp */
    my_trait_name,       /* trait_name  assertive, emotional, etc, 6 of them */
                         /* but, here it will be  "Best Calendar Year nnnn" */
//    trait_lines,         /* struct rank_report_line *out_trait_lines[]; */
//    trait_idx,
    out_group_report_PSVs,   /* array of output report data to pass to cocoa */
    out_group_report_idx       /* ptr to int having last index written */
  );


  fclose_fpdb_for_debug();
  return(0);
} /* end of  mamb_report_best_year() */


/* ----------------  BEST DAY  -------------------------- */
/* ----------------  BEST DAY  -------------------------- */
int mamb_report_best_day(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyymmdd_todo, 
//  struct trait_report_line *trait_lines[],   /* array of output report data */
//  int  *trait_idx,           /* ptr to int having last index written */                   
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
) 
{
  int retval,imm,idd,iyyyy;
  char my_trait_name[128], s[32];

  fopen_fpdb_for_debug();

  out_rank_line_idx = 0;

  strcpy(gbl_fut_yyyymmdd_todo, yyyymmdd_todo);

  /* build the report title and put it into "trait_name" string arg
  *  note: trait_name contains "Best Day on"
  */
  imm = atoi(sfromto(s,&yyyymmdd_todo[0],5,6));
  idd = atoi(sfromto(s,&yyyymmdd_todo[0],7,8));
  iyyyy = atoi(sfromto(s,&yyyymmdd_todo[0],1,4));

  gbl_is_best_year_or_day = 1;  /* yes */
  sprintf(gbl_bestday_yyyy_todo, "%d", iyyyy);
  strcpy(gbl_bestyear_yyyy_todo, "not applicable");

  sprintf(my_trait_name, "Best Day on |%s&nbsp %s %d %d",
    N_day_of_week[ day_of_week(imm, idd, iyyyy) ], gN_MTHc[imm], idd, iyyyy);

  retval = mamb_report_trait_rank(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    in_csv_person_arr,   /* in_csv_person_arr[] */
    num_persons_in_grp,  /* num_persons_in_grp */
    my_trait_name,       /* trait_name  assertive, emotional, etc, 6 of them */
                         /* but, here it will be  "Best Day on mth dd, yyyy" */
//    trait_lines,         /* struct rank_report_line *out_trait_lines[]; */
//    trait_idx,
    out_group_report_PSVs,   /* array of output report data to pass to cocoa */
    out_group_report_idx       /* ptr to int having last index written */
  );

  fclose_fpdb_for_debug();
  return(0);
} /* end of  mamb_report_best_day() */



/* ----------------  TRAIT RANK  -------------------------- */
/* ----------------  TRAIT RANK  -------------------------- */
int mamb_report_trait_rank(    /* in called from cocoa */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *trait_name,          /* could be  "Best Calendar Year nnnn" */
//  struct trait_report_line *out_trait_lines[],   /* array of output report data */
//  int  *out_trait_line_idx,           /* ptr to int having last index written */                   
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
)
{

//tn();trn("in  mamb_report_trait_rank()"); ks(trait_name);
//ksn(html_file_name);
//ksn(group_name);
//kin(num_persons_in_grp);
//ksn(trait_name);
  out_trait_line_idx = 0;  // init

  char stringBuffForTraitCSV[128]; /* for instruction "return only csv with all 6 trait scores" */
  char stringBuffForStressScore[128]; /* for instruction  "return only year stress score" */
//  char stringBuffForCompatScore[1024]; /* for instruction  "return only compatibility score" */
  int kk, num_persons_in_cached_array, irank, my_rank_number, retval;
  char current_person[64], current_birth_year[16], current_birth_mth[16], current_birth_day[16];
  char current_person_name[MAX_SIZE_PERSON_NAME+1];;
  struct trait_report_line my_trait_line, my_trait_line2;

//  char *my_csv_person_arr_2[2]; /* only 2 persons for only compat score instruction */
  int fldno;
  int arr_tot_trait_scores[8];  

/* fprintf(stderr, "TRAIT-%s|%6d|\n", group_name, num_persons_in_grp); */

/* fpdb=stderr; put me in main(). output file for debug code */
/* fpdb = fopen("t.out","a"); */



  fopen_fpdb_for_debug();


  /* set gbl_is_best_year_or_day 
  */
  gbl_is_best_year_or_day = 0;  /* init to no */
  if (strstr(trait_name, "Best Calendar Year") != NULL) {
trn("    for BEST CALENDAR YEAR");
    gbl_is_best_year_or_day = 1;  /* yes */
  }
  if (strstr(trait_name, "Best Day on") != NULL) {
trn("    for BEST DAY on ");
    gbl_is_best_year_or_day = 1;  /* yes */
  }



  is_first_g_trait_line_put = 1; /* set to yes */
  allow_docin_puts_for_now = 0;  /* 1=yes, 0=no = no graph output (like pt of view in just2 rpt) */

  /* cache planetary positions of all grp mbrs in this:
  *       struct cached_person_positions {
  *        char person_name[20];    * max 15 may 2013 *
  *        int  minutes_natal[14];  * planetary positions *
  *       } g_cached_pos_tab[16];
  */
  put_stuff_in_cached_array(in_csv_person_arr, num_persons_in_grp);

  num_persons_in_cached_array = num_persons_in_grp;


  /* init for "all average trait_scores" */
  for (fldno = 1; fldno <= 6; fldno++) {  /* one-based */
    arr_tot_trait_scores[fldno] = 0;
  }

  /*   if (strcmp(trait_name, "assertive")     == 0)  fldnum = 1; * one-based *
  *   if (strcmp(trait_name, "emotional")     == 0)  fldnum = 2;
  *   if (strcmp(trait_name, "restless")      == 0)  fldnum = 3;
  *   if (strcmp(trait_name, "down to earth") == 0)  fldnum = 4;
  *   if (strcmp(trait_name, "passionate")    == 0)  fldnum = 5;
  *   if (strcmp(trait_name, "ups and downs") == 0)  fldnum = 6;
  */


  for (kk=0; kk <= num_persons_in_grp - 1; kk++) {      /* for each current_person */
    strcpy(current_person, in_csv_person_arr[kk]);
    strcpy(current_person_name, csv_get_field(in_csv_person_arr[kk], ",", 1));
    strcpy(current_birth_year,  csv_get_field(in_csv_person_arr[kk], ",", 4));
    strcpy(current_birth_mth ,  csv_get_field(in_csv_person_arr[kk], ",", 5));
    strcpy(current_birth_day ,  csv_get_field(in_csv_person_arr[kk], ",", 6));



    /* call personality pgm to get all trait scores for current person
    */
    sfill(stringBuffForTraitCSV, 60, ' '); /* for "return only csv with all trait scores" */

    /* note below:   NEW VERSION of DAY STRESS SCORE =  "B"
    *  gbl_instructions,  "return only day stress score_B")
    * 
    *
    *   "return only day stress score",   * instructions for mamb_report_year_in_the_life() *
    *   "return only day stress score_B", * instructions for mamb_report_year_in_the_life() *
    */
    if (strstr(trait_name, "Best Day on") != NULL) {
      mamb_report_year_in_the_life(     /* in futdoc.o */
        html_file_name,
        in_csv_person_arr[kk],
        gbl_fut_yyyymmdd_todo,  /* not yyyy    danger - re-use field */
        "return only day stress score_B", /* instructions for mamb_report_year_in_the_life() */
        stringBuffForStressScore
      );
/* fopen_fpdb_for_debug(); */
/* ksn(stringBuffForStressScore); */
    } else if (strstr(trait_name, "Best Calendar Year") != NULL) {
      mamb_report_year_in_the_life(     /* in futdoc.o */
        html_file_name,
        in_csv_person_arr[kk],
        gbl_fut_yyyy_todo,
        "return only year stress score",   /* instructions for mamb_report_year_in_the_life() */
        stringBuffForStressScore
      );
/* fopen_fpdb_for_debug(); */

    } else  if (strstr(trait_name, "mysterious") != NULL) {
      ;

    } else {

      mamb_report_personality(
        "",                                       /* *html_file_name, for webview  */
        "",                                       /* *html_file_name, for browser  */
        current_person,
        "return only csv with all trait scores",  /* instructions for mamb_report_personality() */
        stringBuffForTraitCSV
      );
    }
/* ksn(current_person_name); ki(my_trait_line.score); */

    /* write the data for current person into trait rank line array
    */
    my_trait_line.rank_in_group = 0;

    /* set score in trait_line struct
    */
//    int yr_todo, currbirthyr;
//    char currbirthyyyymmdd[16];

    if (strstr(trait_name, "mysterious") != NULL ) {  /* abandoned 201309 */
      my_trait_line.score =  mapNumStarsToBenchmarkNum(
          IDX_FOR_MYSTERIOUS,
          atoi(stringBuffForStressScore)
        );


    } else if (strstr(trait_name, "Best Day on") != NULL) {
      my_trait_line.score = atoi(stringBuffForStressScore);


    // NO,  can detect year of  birth if this is in
    //      /* EXCLUDE person (score = -1) 
    //      *          IF birth date < gbl_fut_yyyymmdd_todo
    //      */
    //      sprintf(currbirthyyyymmdd, "%s%s%s", current_birth_year, current_birth_mth, current_birth_day);
    //      /* must be alive on the day */
    //      if (strcmp(gbl_fut_yyyymmdd_todo, currbirthyyyymmdd) < 0)  { 
    //        my_trait_line.score = -1;     /* flag for exluding person from report */
    //      }
    //

    } else if (strstr(trait_name, "Best Calendar Year") != NULL) {
      my_trait_line.score = atoi(stringBuffForStressScore);

    // NO,  can detect year of  birth if this is in
    //      /* EXCLUDE person (score = -1) 
    //      *          IF (   birth year = gbl_bestyear_yyyy_todo
    //      */
    //      currbirthyr = atoi(current_birth_year);
    //      yr_todo     = atoi(gbl_bestyear_yyyy_todo);
    //      if (yr_todo <= currbirthyr)  {  /* must be alive whole year */
    //        my_trait_line.score = -1;     /* flag for exluding person from report */
    //      }
    //

    } else {
      my_trait_line.score = get_trait_score(trait_name, stringBuffForTraitCSV);

      /* add stringBuffForTraitCSV for current person
      *  to group total trait scores
      */
      if (my_trait_line.score != -1) {
        for (fldno = 1; fldno <= 6; fldno++) {
          arr_tot_trait_scores[fldno] = arr_tot_trait_scores[fldno] +
            atoi(csv_get_field(stringBuffForTraitCSV, ",", fldno));
        }
      }
    }

    strcpy(my_trait_line.person_name, current_person_name);

    g_trait_line_put(  /* into out_trait_lines[] */
      my_trait_line,
      out_trait_lines,
      &out_trait_line_idx
    );


  } /* for each current_person */


  /* calc all average trait scores
  *  (and put into gblGrpAvgTraitScoresCSV1)
  */
  strcpy(gblGrpAvgTraitScoresCSV1, "");
  for (fldno = 1; fldno <= 6; fldno++) {

    sprintf(gblGrpAvgTraitScoresCSV1, "%s%s%d",

      gblGrpAvgTraitScoresCSV1,

      (strlen(gblGrpAvgTraitScoresCSV1) == 0)? "": "," ,

      (int) floor(   /* floor ... + 0.5 => round() */
        (double) arr_tot_trait_scores[fldno] /
        (double) (num_persons_in_grp) + 0.5)
    );
  }



/* int i; for (i = 0; i <= (*out_trait_line_idx); i++) {
*   ksn(out_trait_lines[i]->person_name);
*   ki(out_trait_lines[i]->score);
* }
*/

  /* add the milestone lines (they will sort in themselves by score)
  */

  /* int BENCHMARK_SCORES  [6] = { -1, 373, 213, 100, 42, 18 }; */
  int BENCHMARK_SCORES  [6] = { -1, 90, 75, 50, 25, 10 };

  my_trait_line2.rank_in_group = 0;
  my_trait_line2.score         = BENCHMARK_SCORES[1];
  /* sort below ties with 203 */
  /* sort below ties with  90 */
//  strcpy(my_trait_line2.person_name, "zzzhilite-top10");
  strcpy(my_trait_line2.person_name, "~~~hilite-top10");
  g_trait_line_put(
    my_trait_line2,
    out_trait_lines,
    &out_trait_line_idx
  );
  my_trait_line2.rank_in_group = 0;
  my_trait_line2.score         = BENCHMARK_SCORES[2];
  /* sort below ties with 180 */
  strcpy(my_trait_line2.person_name, "~~~hilite-good");
  g_trait_line_put(
    my_trait_line2,
    out_trait_lines,
    &out_trait_line_idx
  );
  my_trait_line2.rank_in_group = 0;
  my_trait_line2.score         = BENCHMARK_SCORES[3];
  /* sort below ties with 154 */
  strcpy(my_trait_line2.person_name, "~~~hilite-trait");
  g_trait_line_put(
    my_trait_line2,
    out_trait_lines,
    &out_trait_line_idx
  );
  my_trait_line2.rank_in_group = 0;
  my_trait_line2.score         =  BENCHMARK_SCORES[4];
  /* sort above ties with 135 */
  strcpy(my_trait_line2.person_name, "   hilite-bad");
  g_trait_line_put(
    my_trait_line2,
    out_trait_lines,
    &out_trait_line_idx
  );
  my_trait_line2.rank_in_group = 0;
  my_trait_line2.score         =  BENCHMARK_SCORES[5];
  /* sort above ties with 116 */
  strcpy(my_trait_line2.person_name, "   hilite-bot10");
  g_trait_line_put(
    my_trait_line2,
    out_trait_lines,
    &out_trait_line_idx
  );


  /* sort  by score field
  */
  qsort(
    out_trait_lines,
    out_trait_line_idx + 1,   /* number of elements */
    sizeof(struct trait_report_line *),   /* capital R denotes a typedef */
    (compareFunc_trait)Func_compare_trait_report_line_scores
  );


  /* now that its sorted, put in ranking numbers 
  *  (except for milestone lines)
  */
  my_rank_number = 0;
  for (irank=0; irank <= out_trait_line_idx; irank++) {
    /* trn("rank num PUT");ki(irank);ks(out_trait_lines[irank]->person_B);  */
    if (strcmp(out_trait_lines[irank]->person_name, "~~~hilite-top10") == 0  ||
        strcmp(out_trait_lines[irank]->person_name, "~~~hilite-good")  == 0  ||
        strcmp(out_trait_lines[irank]->person_name, "~~~hilite-trait")   == 0  ||
        strcmp(out_trait_lines[irank]->person_name, "~~~hilite-avg")   == 0  ||
        strcmp(out_trait_lines[irank]->person_name, "   hilite-bad")   == 0  ||
        strcmp(out_trait_lines[irank]->person_name, "   hilite-bot10") == 0 ) {
      continue;
    }
    my_rank_number = my_rank_number + 1;
    out_trait_lines[irank]->rank_in_group = my_rank_number;
  }


/* int i; for (i = 0; i <= out_trait_line_idx; i++) {  * test *
*   kin(out_trait_lines[i]->rank_in_group);
*   ks(out_trait_lines[i]->person_name);
*   ki(out_trait_lines[i]->score);
* }
*/


  allow_docin_puts_for_now = 1;  /* 1=yes, 0=no = no graph output (like pt of view in just2 rpt) */

  
  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML 
  *  html report produced here
  */
  retval = make_html_file_trait_rank( /* produce actual html file */
    group_name,
    num_persons_in_grp,
    trait_name,            /* could be  "Best Calendar Year nnnn" */
    html_file_name,                     /* in grphtm.c */
    out_trait_lines,       /* array of report data */
    out_trait_line_idx,   /* int having last index written */
    gblGrpAvgTraitScoresCSV1
  );


  if (retval != 0) {
    g_docin_free();      /* free all allocated array elements */
    fclose_fpdb_for_debug();
    rkabort("Error: html file (trait score) was not produced");
    return(1);
  }

  allow_docin_puts_for_now = 1;  /* 1=yes, 0=no = no graph output (like pt of view in just2 rpt) */




  tn();trn("doing trait rank build of  out_group_report_PSVs[]  ...");  ks(html_file_name);

  // here, build raw display data for tableview in cocoa -----------------------------------------------i-
  //

  // populate   out_group_report_PSVs 
  //      char *out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  //      int  *out_group_report_idx       /* ptr to int having last index written */
  //
  *out_group_report_idx = -1;  // zero-based


  int i, lenA, longest_A, len_name, size_grp_mem;
  char sfmt_person_line[128];
  /*   char pad_spaces[32]; */
  char person_line[128], benchmark_label[16], cocoa_rowcolor[16];

  /* get size of longest names for person_A 
  */
  for (longest_A=0,i=0; i <= out_trait_line_idx; i++) {
    if (out_trait_lines[i]->rank_in_group == 0) {
      continue;
    }
    lenA = (int)strlen(out_trait_lines[i]->person_name);
    if(lenA > longest_A) longest_A = lenA;
  }
 
  if (longest_A + 2 > 14) size_grp_mem = longest_A + 2 ; /* use max of these */
  else                    size_grp_mem = 14;

  /*        Group Member   Score          */
  /*    1   Fred flinstone  98          ] */
  
  len_name = longest_A;


  /* =========  PUT HEADER LINES  ==============
  */

  // here, build raw display data for tableview in cocoa -----------------------------------------------i-

  // put out line to represent spacer before column headers in cocoa
    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s", "cHed|top space||");
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128


  //sprintf(sfmt_person_line, "       %%-%dsScore", size_grp_mem);
    sprintf(sfmt_person_line, "       %%-%ds  Score         ", size_grp_mem);
  sprintf(person_line, sfmt_person_line, "Group Member");
    /* put in cocoa table here */
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */
  *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//  sprintf(gbl_my1_group_report_line, "%s|%s", cocoa_rowcolor, person_line);
  sprintf(gbl_my1_group_report_line, "%s|%s||", cocoa_rowcolor, person_line);
  strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my1_group_report_line); // every 128
  /* end of =========  PUT HEADER LINES  ============== */


  /* ===== PUT DATA + BENCHMARK LINES  =====
  * 
  *  1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  for (i=0; i <= out_trait_line_idx; i++) {

    /* put out benchmark lines
    */
    if (out_trait_lines[i]->rank_in_group == 0) {
      if (out_trait_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_trait_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_trait_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_trait_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_trait_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

      //sprintf(sfmt_person_line, " %%3s   %%-%ds  %%2d  %%-9s", size_grp_mem );
        sprintf(sfmt_person_line, " %%3s   %%-%ds  %%2d  %%-9s ", size_grp_mem );
      sprintf(person_line, sfmt_person_line, " ", " ",
        out_trait_lines[i]->score, benchmark_label);

      /* put in cocoa table here */
      strcpy(cocoa_rowcolor, set_cell_bg_color_2(out_trait_lines[i]->score));  
      *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//      sprintf(gbl_my1_group_report_line, "%s|%s", cocoa_rowcolor, person_line);
      sprintf(gbl_my1_group_report_line, "%s|%s||", cocoa_rowcolor, person_line);

      strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my1_group_report_line); // every 128

      continue;
    }
    
    strcpy(benchmark_label, "");


    char person_A_for_UITableView[32]; // in each name, replace all ' ' with '_'
    strcpy(person_A_for_UITableView,  out_trait_lines[i]->person_name);
    scharswitch(person_A_for_UITableView, ' ', '_');


    //sprintf(sfmt_person_line, " %%3d   %%-%ds  %%2d  %%-9s", size_grp_mem);
      sprintf(sfmt_person_line, " %%3d   %%-%ds  %%2d  %%-9s ", size_grp_mem);
    sprintf(person_line, sfmt_person_line, 
      out_trait_lines[i]->rank_in_group,

//      out_trait_lines[i]->person_name,
      person_A_for_UITableView,

      out_trait_lines[i]->score,
      benchmark_label
    );

    /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    */
    /* put in cocoa table here */
    strcpy(cocoa_rowcolor, set_cell_bg_color_2(out_trait_lines[i]->score));
    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//    sprintf(gbl_my1_group_report_line, "%s|%s", cocoa_rowcolor, person_line);
//    sprintf(gbl_my1_group_report_line, "%s|%s||", cocoa_rowcolor, person_line);

    sprintf(gbl_my1_group_report_line, "%s|%s|%s|", cocoa_rowcolor, person_line, out_trait_lines[i]->person_name);

    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my1_group_report_line); // every 128

  } /* ===== PUT DATA + BENCHMARK LINES  ===== */

tn();tn();trn("finished  doing trait rank build of  out_group_report_PSVs[]  ...");  ks(html_file_name);

  /* when finished, free allocated array elements 
  */
  g_trait_line_free(out_trait_lines, out_trait_line_idx);  /* when finished, free allocated array elements  */


trn("end of mamb_report_trait_rank()");

  fclose_fpdb_for_debug();
  return(0);  

} /* end of  mamb_report_trait_rank() */


int get_trait_score(char *trait_name, char *stringBuffForTraitCSV)
{
  int fldnum = 0;
/*  tn();trn("in get_trait_score()");  */
/* ksn(trait_name); */
/* ksn(stringBuffForTraitCSV); */
  if (strcmp(trait_name, "assertive")     == 0)  fldnum = 1; /* one-based */
  if (strcmp(trait_name, "emotional")     == 0)  fldnum = 2;
  if (strcmp(trait_name, "restless")      == 0)  fldnum = 3;
  if (strcmp(trait_name, "down to earth") == 0)  fldnum = 4;
  if (strcmp(trait_name, "passionate")    == 0)  fldnum = 5;
  if (strcmp(trait_name, "ups and downs") == 0)  fldnum = 6;

  if (strstr(trait_name, "unbal")   != NULL   ) {
    return (get_unbalanced_score(stringBuffForTraitCSV));
  }

  /* csv is like "19,195,1,321,118,77"
  */
  char mytmps[256];
  int  myreti;
  strcpy(mytmps, csv_get_field(stringBuffForTraitCSV, ",", fldnum));
  myreti = atoi(mytmps);
  return (myreti);
/*   return (atoi(csv_get_field(stringBuffForTraitCSV, ",", fldnum))); */
} /* end of get_trait_score() */

/*   if (strcmp(trait_name, "aggressive")     == 0)  fldnum = 1;
*   if (strcmp(trait_name, "agrsv")         == 0)  fldnum = 1;
*   if (strcmp(trait_name, "sensitive")     == 0)  fldnum = 2;
*   if (strcmp(trait_name, "sensi")         == 0)  fldnum = 2;
*   if (strcmp(trait_name, "restl")         == 0)  fldnum = 3;
*   if (strcmp(trait_name, "down_to_earth") == 0)  fldnum = 4;
*   if (strcmp(trait_name, "down-to-earth") == 0)  fldnum = 4;
*   if (strcmp(trait_name, "earth")         == 0)  fldnum = 4;
*   if (strcmp(trait_name, "sexdr")         == 0)  fldnum = 5;
*   if (strcmp(trait_name, "ups_and_downs") == 0)  fldnum = 6;
*   if (strcmp(trait_name, "upndn")         == 0)  fldnum = 6;
*/



/* not used  20130915
*/
int get_unbalanced_score(char *stringBuffForTraitCSV)
{
  int tmpint,tmpint2,i;
    tmpint = 0; tmpint2 = 0;

  /* 3,4=fire,water,air,earth */
  for (i=0; i <=3; i++) {
    tmpint  =  atoi(csv_get_field(stringBuffForTraitCSV, ",", i));
    tmpint2 =  tmpint2 + ( (tmpint - 100) * (tmpint - 100) );
  }
  return ((tmpint2/4)/211);
} /* end of get_unbalanced_score() */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* 
* /* ----------------  AVG SCORES  -------------------------- */
* /* ----------------  AVG SCORES  -------------------------- */
* int mamb_report_avg_scores(    /* called from cocoa */
*   char *html_file_name,
*   char *group_name,
*   char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
*   int  num_persons_in_grp,
*   struct rank_report_line *out_rank_lines[], 
*   int  *out_rank_line_idx,
*   struct avg_report_line *out_avg_lines[],   /* array of output report data */
*   int  *out_avg_line_idx)           /* ptr to int having last index written */                   
* {
*   int kk, ii, retval, irank, my_rank_number;
*   char current_person[64], other_person[64];
*   char current_person_name[MAX_SIZE_PERSON_NAME+1];;
*   struct avg_report_line my_avg_line;
*   struct avg_report_line my_avg_line2;
*   int num_persons_in_cached_array;
*   int current_person_tot_scores;
*   struct rank_report_line my_rank_line;
*   int PERCENTILE_RANK_SCORE;
* 
*   /* Note: mamb_report_avg_scores() sets output parameter to our arr of structs 
*   *  which is to be returned to cocoa.
*   */
* 
* /* fpdb=stderr; put me in main(). output file for debug code */
* /* fpdb = fopen("t.out","a"); */
* 
*   fopen_fpdb_for_debug();
*   
*   is_first_g_rank_line_put = 1; /* set to yes */
*   is_first_g_avg_line_put  = 1; /* set to yes */
* 
* 
*   allow_docin_puts_for_now = 0;  /* 1=yes, 0=no = no graph output (like pt of view in just2 rpt) */
* 
*   /* cache planetary positions of all grp mbrs in this:
*   *       struct cached_person_positions {
*   *        char person_name[20];    * max 15 may 2013 *
*   *        int  minutes_natal[14];  * planetary positions *
*   *       } g_cached_pos_tab[16];
*   */
*   put_stuff_in_cached_array(in_csv_person_arr, num_persons_in_grp);
* 
*   num_persons_in_cached_array = num_persons_in_grp;
* 
*   for (kk=0; kk <= num_persons_in_grp - 2; kk++) {      /* for each current_person */
*     strcpy(current_person, in_csv_person_arr[kk]);
*     for (ii=kk+1; ii <= num_persons_in_grp - 1; ii++) { /* for each other_person */
*       strcpy(other_person, in_csv_person_arr[ii]);
* 
*       /* current_person first
*       */
*       global_pair_compatibility_score   = 0;
*       global_pair_a_compatibility_score = 0;
*       global_pair_b_compatibility_score = 0;
*       init_grh_datas();
*       this_pair_get_data(   /* data is put in avg_lines array */
*         current_person,
*         other_person,
*         num_persons_in_grp,
*         num_persons_in_cached_array
*       );
*       global_pair_a_compatibility_score = global_pair_compatibility_score;
* 
*       /* other_person second
*       */
*       init_grh_datas();
*       this_pair_get_data(   /* data is put in avg_lines array */
*         other_person,
*         current_person,
*         num_persons_in_grp,
*         num_persons_in_cached_array
*       );
*       global_pair_b_compatibility_score = global_pair_compatibility_score;
* 
*       global_pair_compatibility_score = (global_pair_a_compatibility_score +
*         global_pair_b_compatibility_score) / 2; 
*       
*       /* write the data for this pair into report rank line array
*       */
*       my_rank_line.rank_in_group = 0;
*       my_rank_line.score         = global_pair_compatibility_score;
*       strcpy(my_rank_line.person_A, gA_EVENT_NAME);
*       strcpy(my_rank_line.person_B, gB_EVENT_NAME);
* 
*       g_rank_line_put(  /* into out_rank_lines[] */
*         my_rank_line,
*         out_rank_lines,
*         out_rank_line_idx
*       );
* 
*     } /* for each other_person */
*   } /* for each current_person ===============================================*/
* 
* 
*   /* now, person by person, go thru out_rank_lines[]
*   * and calc their average score and put into out_avg_line[]
*   */
*   for (kk=0; kk <= num_persons_in_grp - 1; kk++) {      /* for each current_person */
*     strcpy(
*       current_person_name,
*       csv_get_field(in_csv_person_arr[kk], ",", 1)
*     );
* 
*     current_person_tot_scores = 0;
*     for (ii=0; ii <= *out_rank_line_idx; ii++) {    /* for each rank_lines */
* 
*       /* if current person name is person_A or person_B,
*       *  then add it to the total for current person name
*       */
*       if (strcmp(current_person_name, out_rank_lines[ii]->person_A) == 0  ||
*           strcmp(current_person_name, out_rank_lines[ii]->person_B) == 0) {
* 
*         current_person_tot_scores += out_rank_lines[ii]->score;
*       }
*     } /* for each rank_lines */
* 
*     /* write the data for the current person into report avg line array
*     */
* /* tn();ksn(current_person_name);tr("tot=");ki(current_person_tot_scores); */
*     my_avg_line.rank_in_group = 0;
* 
* 
*     my_avg_line.avg_score     = (int) floor(   /* floor ... + 0.5 => round() */
*         (double) current_person_tot_scores /
*         (double) (num_persons_in_grp -1) + 0.5
*       ); 
* 
*     /* CONVERT  Average rank scores to 1 -> 99 
*     */
*     PERCENTILE_RANK_SCORE = mapAVGbenchmarkNumToPctlRank(my_avg_line.avg_score);
*     my_avg_line.avg_score = PERCENTILE_RANK_SCORE; 
* 
* 
*     /* my_avg_line.avg_score = (int) ceil(  *ceil works for positive as round fn */
* 
* /* double dd; tn();
* * dd = (double) current_person_tot_scores; kdn(dd);
* * dd = (double) num_persons_in_grp; kd(dd);
* * dd = ((double) current_person_tot_scores / (double) (num_persons_in_grp - 1)); kd(dd);
* * dd = ((double) current_person_tot_scores / (double) (num_persons_in_grp - 1)) + 0.5; kd(dd);
* */
* 
*     strcpy(my_avg_line.person_name, current_person_name);
* 
*     g_avg_line_put(  /* into out_avg_lines[] */
*       my_avg_line,
*       out_avg_lines,
*       out_avg_line_idx
*     );
* 
*     current_person_tot_scores = 0;
* 
*   } /* for each current_person */
* 
*   /* here we have the out_avg_lines array with avg data
*   */
* 
* #ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* *   kin(*(out_rank_line_idx)); 
* * fprintf(stdout,"\n1.  GROUP=|%s\" AVG TEST  in grpdoc.c\n", group_name);
* *   int rr; for(rr=0; rr <= *(out_rank_line_idx); rr++) {
* * /*     fprintf(stdout,"%3d|%5d|%s|%s\n", */
* * /*       out_rank_lines[rr]->rank_in_group, */
* *     fprintf(stdout,"%5d|%s|%s\n",
* *       out_rank_lines[rr]->score,
* *       out_rank_lines[rr]->person_A,
* *       out_rank_lines[rr]->person_B
* *     );
* *   }
* *   fflush(stdout);
* * 
* * fprintf(stdout,"\n2.  GROUP=|%s\" AVG TEST  in grpdoc.c\n", group_name);
* * fflush(stdout);
* * int ss; for(ss=0; ss <= *(out_avg_line_idx); ss++) {
* * /*   fprintf(stdout,"%3d|%5d|%s|\n", */
* * /*     out_avg_lines[ss]->rank_in_group, */
* *   fprintf(stdout,"%5d|%s|\n",
* *     out_avg_lines[ss]->avg_score,
* *     out_avg_lines[ss]->person_name
* *   );
* * }
* * fflush(stdout);
* #endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
*   
* 
*   /* add the milestone lines (they will sort in themselves by score)
*   */
*   my_avg_line2.rank_in_group = 0;
*   my_avg_line2.avg_score         = 203;
*   my_avg_line2.avg_score         =  90;
*   /* sort below ties with 203 */
*   /* sort below ties with  90 */
*   strcpy(my_avg_line2.person_name, "zzzhilite-top10");
*   g_avg_line_put(
*     my_avg_line2,
*     out_avg_lines,
*     out_avg_line_idx
*   );
*   my_avg_line2.rank_in_group = 0;
* /*   my_avg_line2.avg_score         = 180; */
*   my_avg_line2.avg_score         =  75;
*   /* sort below ties with 180 */
*   strcpy(my_avg_line2.person_name, "zzzhilite-good");
*   g_avg_line_put(
*     my_avg_line2,
*     out_avg_lines,
*     out_avg_line_idx
*   );
*   my_avg_line2.rank_in_group = 0;
* /*   my_avg_line2.avg_score         = 154; */
*   my_avg_line2.avg_score         =  50;
*   /* sort below ties with 154 */
*   strcpy(my_avg_line2.person_name, "zzzhilite-avg");
*   g_avg_line_put(
*     my_avg_line2,
*     out_avg_lines,
*     out_avg_line_idx
*   );
*   my_avg_line2.rank_in_group = 0;
* /*   my_avg_line2.avg_score         = 135; */
*   my_avg_line2.avg_score         =  25;
*   /* sort above ties with 135 */
*   strcpy(my_avg_line2.person_name, "   hilite-bad");
*   g_avg_line_put(
*     my_avg_line2,
*     out_avg_lines,
*     out_avg_line_idx
*   );
*   my_avg_line2.rank_in_group = 0;
* /*   my_avg_line2.avg_score         = 116; */
*   my_avg_line2.avg_score         =  10;
*   /* sort above ties with 116 */
*   strcpy(my_avg_line2.person_name, "   hilite-bot10");
*   g_avg_line_put(
*     my_avg_line2,
*     out_avg_lines,
*     out_avg_line_idx
*   );
* 
* 
*   /* sort  by score field
*   */
*   qsort(
*     out_avg_lines,
*     *(out_avg_line_idx) + 1,   /* number of elements */
*     sizeof(struct avg_report_line *),   /* capital R denotes a typedef */
*     (compareFunc_avg)Func_compare_avg_report_line_scores
*   );
* 
* 
*   /* now that its sorted, put in ranking numbers 
*   *  (except for milestone lines)
*   */
*   my_rank_number = 0;
*   for (irank=0; irank <= *(out_avg_line_idx); irank++) {
*     /* trn("rank num PUT");ki(irank);ks(out_avg_lines[irank]->person_B);  */
*     if (strcmp(out_avg_lines[irank]->person_name, "zzzhilite-top10") == 0  ||
*         strcmp(out_avg_lines[irank]->person_name, "zzzhilite-good")  == 0  ||
*         strcmp(out_avg_lines[irank]->person_name, "zzzhilite-avg")   == 0  ||
*         strcmp(out_avg_lines[irank]->person_name, "zzzhilite-trait")   == 0  ||
*         strcmp(out_avg_lines[irank]->person_name, "   hilite-bad")   == 0  ||
*         strcmp(out_avg_lines[irank]->person_name, "   hilite-bot10") == 0 ) {
*       continue;
*     }
*     my_rank_number = my_rank_number + 1;
*     out_avg_lines[irank]->rank_in_group = my_rank_number;
*   }
* 
* /* tn();ksn(group_name); 
* * int iii; for (iii=0; iii <= *(out_avg_line_idx); iii++) {
* * kin(out_avg_lines[iii]->rank_in_group);
* * kin(out_avg_lines[iii]->avg_score);
* * ksn(out_avg_lines[iii]->person_name);
* * }
* */
* 
*   
*   /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML 
*   *  html report produced here
*   */
*   retval = make_html_file_avg_scores( /* produce actual html file */
*     group_name,
*     num_persons_in_grp,
*     html_file_name,                     /* in grphtm.c */
*     out_avg_lines,       /* array of report data */
*     *out_avg_line_idx,   /* int having last index written */
*     "",                  /* instructions for table-in-string only */
*     ""                   /* 1024 chars max (9lines formatted) */
*   );
* 
*   if (retval != 0) {
*     g_docin_free();      /* free all allocated array elements */
*     fclose_fpdb_for_debug();
*     rkabort("Error: html file (avg score) was not produced");
*     return(1);
*   }
* 
*   trn("end of mamb_report_avg_scores()");
*   fclose_fpdb_for_debug();
*   return(0);  
* 
* } /* end of  mamb_report_avg_scores() */
* 
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/





/*   mamb_report_person_in_group()
*  Do compatibilities for person_csv with each member of the named group.
*
*/
//int  mamb_report_person_in_group(  /* in grpdoc.o */ 
//  char *html_file_name,
//  char *group_name,
//  char *in_csv_person_arr[],
//  int  num_persons_in_grp,
//  char *compare_everyone_with,   /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
//  struct rank_report_line *out_rank_lines[],   /* array of output report data */
//  int  *out_rank_line_idx )         /* ptr to int having last index written */
//{
//

int  mamb_report_person_in_group(  /* in grpdoc.o */ 
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],
  int  num_persons_in_grp,
  char *compare_everyone_with,   /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
//  struct rank_report_line *out_rank_lines[],   /* array of output report data */
//  int  *out_rank_line_idx ,                    /* ptr to int having last index written */
  //char *out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx ,     /* ptr to int having last index written */
  int  kingpin_is_in_group
)
{


  int  ii, mm, irank, my_rank_number;
  char current_person[256], other_person[256];
  struct rank_report_line my_rank_line;
  struct rank_report_line my_rank_line2;
  char name_of_compare_everyone_with[32];
  char tmp_name[SIZE_INBUF+1], my_csv[128];
  int num_persons_in_cached_array;
  int tot_scores_this_member;  /* for compare_everyone_with */
  int avg_score_this_member ;  /* for compare_everyone_with */
  int PERCENTILE_RANK_SCORE;

/* fpdb=stderr; put me in main(). output file for debug code */
/* fpdb = fopen("t.out","a"); */

  fopen_fpdb_for_debug();

trn("in mamb_report_person_in_group()");
//kin(kingpin_is_in_group);

//ksn(group_name);
//kin(num_persons_in_grp);
//ksn(compare_everyone_with);
//for (int m=0; m < num_persons_in_grp; m++) {
//char mybufff[256];
//strcpy(mybufff, in_csv_person_arr[m]);
//ksn(mybufff);
//}



  /* fprintf(stdout, "\nin mamb_report_person_in_group()\n");  */

  gbl_is_best_year_or_day = 0;  /* no */

  is_first_g_rank_line_put = 1; /* set to yes */
  allow_docin_puts_for_now = 0;  /* 1=yes, 0=no = no graph output (like pt of view in just2 rpt) */



  /* cache planetary positions of all grp mbrs in this:
  *       struct cached_person_positions {
  *        char person_name[20];    * max 15 may 2013 *
  *        int  minutes_natal[14];  * planetary positions *
  *       } g_cached_pos_tab[MAX_PERSONS_IN_GROUP];
  *
  */
  put_stuff_in_cached_array(in_csv_person_arr, num_persons_in_grp);

  /* arr idx above goes 0->num_persons_in_grp-1.
  *  
  *  Now add one more to the array (for compare_everyone_with)
  *  at idx=num_persons_in_grp.   (have to sort again after)
  */
  num_persons_in_cached_array = num_persons_in_grp + 1;

  strcpy(gA_EVENT_NAME, csv_get_field(       /* name for person A */
    compare_everyone_with, ",", 1)
  );
  strcpy(g_cached_pos_tab[num_persons_in_cached_array-1].person_name, gA_EVENT_NAME);
  ;
  strcpy(my_csv, compare_everyone_with); 
  get_event_details(my_csv, tmp_name, 
    &gINMN, &gINDY, &gINYR, &gINHR, &gINMU, &gINAP, &gINTZ, &gINLN);
  calc_chart(gINMN,gINDY,gINYR,gINHR,gINMU,gINAP,gINTZ,gINLN,gINLT);
  g_put_minutes(&ar_minutes_natal_1[0]);  /* for person 1 / person A */
  for (mm=0; mm <= 13; mm++) {
    g_cached_pos_tab[num_persons_in_cached_array-1].minutes_natal[mm] = ar_minutes_natal_1[mm];
  }
  qsort(
    g_cached_pos_tab,
    num_persons_in_cached_array,
    sizeof(Cached_person_positions),  /* capital C is a typedef */
    (compareFunc_positions)Func_compare_cached_positions_person_name
  );



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   /* for compare_everyone_with, 
*   *  save ar_minutes_natal_1 and do store_sgn_and_hse_placements_1()
*   */
* 
* /* for test */
* int kk,ll; /*char nam[32];*/ int mi;
* tn(); for(kk=0; kk <= num_persons_in_grp; kk++) {
*   ksn(g_cached_pos_tab[kk].person_name);tn();
*   for(ll=0; ll<=13; ll++){
*     mi = g_cached_pos_tab[kk].minutes_natal[ll];
*     ki(mi);
*   }
*   tn();
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


  /* Populate out_rank_lines array.
  * 
  * loop thru in_csv_person_arr and
  * compare the group person with compare_everyone_with
  */
  strcpy(current_person, compare_everyone_with);
  strcpy(
    name_of_compare_everyone_with,
    csv_get_field(compare_everyone_with, ",", 1)
  );

  tot_scores_this_member = 0; /* init for compare_everyone_with */


  /* for each person in group  -----------------------------------------------
  */
  for (ii=0; ii <= num_persons_in_grp - 1; ii++) {
    strcpy(other_person, in_csv_person_arr[ii]);

    /* avoid comparison with self     same person
    */
    if (strcmp(other_person, current_person) == 0 ) continue;

//tn();ksn(current_person);ksn(other_person);b(1);
    /* do comparison in the order  1.current_person, 2.other_person
    */
    global_pair_compatibility_score   = 0;
    global_pair_a_compatibility_score = 0;
    global_pair_b_compatibility_score = 0;
    init_grh_datas();
    this_pair_get_data(   /* data is put in rank_lines array */
      current_person,
      other_person,
      num_persons_in_grp,
      num_persons_in_cached_array
    );
    global_pair_a_compatibility_score = global_pair_compatibility_score;
//tn();ksn(current_person);ksn(other_person);b(2);
//tn();tr("person A score=");ki(global_pair_a_compatibility_score);

    /* char nam1[32]; char nam2[32];
    * strcpy(nam1, csv_get_field(current_person,",",1));
    * strcpy(nam2, csv_get_field(other_person,",",1));
    * fprintf(stdout,"%-15s|%-15s|%d|",nam1,nam2,global_pair_a_compatibility_score);
    */

//tn();ksn(current_person);ksn(other_person);b(3);
    /* do comparison in the order  1.other_person, 2.current_person
    */
    init_grh_datas();
    this_pair_get_data(   /* data is put in rank_lines array */
      other_person,
      current_person,
      num_persons_in_grp,
      num_persons_in_cached_array
    );
    global_pair_b_compatibility_score = global_pair_compatibility_score;
//tn();ksn(current_person);ksn(other_person);b(4);
//tn();tr("person B score=");ki(global_pair_b_compatibility_score);

    /* fprintf(stdout,"%d|%d|", global_pair_b_compatibility_score,
    * global_pair_a_compatibility_score -  global_pair_b_compatibility_score);
    */



    /* write the data for this pair in report line array
    */
    global_pair_compatibility_score = (global_pair_a_compatibility_score +
      global_pair_b_compatibility_score) / 2; 
//tn();tr("PAIR     score=");ki(global_pair_compatibility_score);




    my_rank_line.rank_in_group    = 0;

    my_rank_line.score         = global_pair_compatibility_score;

    PERCENTILE_RANK_SCORE =
      mapBenchmarkNumToPctlRank(global_pair_compatibility_score);
//tn();kin(PERCENTILE_RANK_SCORE );tn();

    my_rank_line.score         = PERCENTILE_RANK_SCORE;


/* tn();kin(tot_scores_this_member);ki(global_pair_compatibility_score); */


/*     tot_scores_this_member += global_pair_compatibility_score; */
    tot_scores_this_member += mapBenchmarkNumToPctlRank(global_pair_compatibility_score);

/* ki(tot_scores_this_member); */

    /* first name in pair must always be
    *  name_of_compare_everyone_with
    */
    if(strcmp(name_of_compare_everyone_with,gA_EVENT_NAME) == 0) {
      strcpy(my_rank_line.person_A, gA_EVENT_NAME);
      strcpy(my_rank_line.person_B, gB_EVENT_NAME);
    } else {
      strcpy(my_rank_line.person_A, gB_EVENT_NAME);
      strcpy(my_rank_line.person_B, gA_EVENT_NAME);
    }
    g_rank_line_put(
      my_rank_line,
      out_rank_lines,
      &out_rank_line_idx
    );

  } /* for each person in group */
    /* compared against name_of_compare_everyone_with ------------------------------*/

  /* get average score in the group for bottom of report
  */
/*   tot_scores_this_member += global_pair_compatibility_score; */
  avg_score_this_member = (int) floor(          /* do round() */
    ((double) tot_scores_this_member / (double) ( num_persons_in_grp - 1) ) + 0.5
    );  

/* tn();trn("AVG sc");ki(avg_score_this_member); */

/* tn(); */
/* ksn(name_of_compare_everyone_with); */
/* ki(avg_score_this_member); */
/* ki(tot_scores_this_member ); */
/* ki(num_persons_in_grp ); */
/* tn(); */


  /* fprintf(stdout,"\n\n"); */

  /* here all data is stored in rank_lines array
  *    line is like this:   Rank Score  Person A    Person B
  */

  /* Populate out_rank_lines array.
  * 
  *  add the milestone lines (they will sort in themselves by score)
  */
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 373; */
  my_rank_line2.score         = 90;

//strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); /* sort below ties with 373 */
  strcpy(my_rank_line2.person_A, "~~~~~~~~~~~~~~~"); /* sort below ties with 373 */

  strcpy(my_rank_line2.person_B, "qhilite - top10");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 213; */
  my_rank_line2.score         = 75;
//strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); /* sort below ties with 213 */
  strcpy(my_rank_line2.person_A, "~~~~~~~~~~~~~~~"); /* sort below ties with 213 */
  strcpy(my_rank_line2.person_B, "qhilite - good");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 100; */
  my_rank_line2.score         = 50;
//strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); /* sort below ties with 100 */
  strcpy(my_rank_line2.person_A, "~~~~~~~~~~~~~~~"); /* sort below ties with 100 */
  strcpy(my_rank_line2.person_B, "qhilite - avg");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 42; */
  my_rank_line2.score         = 25;
  strcpy(my_rank_line2.person_A, "               "); /* sort above ties with 42 */
  strcpy(my_rank_line2.person_B, "qhilite - bad");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 18; */
  my_rank_line2.score         = 10;
  strcpy(my_rank_line2.person_A, "               "); /* sort above ties with 18 */
  strcpy(my_rank_line2.person_B, "qhilite - bot10");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );


  /* Populate out_rank_lines array.
  *  
  * sort  by score field
  *  
  *  the newly created struct rank_report_line  *in_rank_lines[],
  */
  qsort(
    out_rank_lines,
    out_rank_line_idx + 1,   /* number of elements */
    sizeof(struct rank_report_line *),   /* capital R denotes a typedef */
    (compareFunc_rank)Func_compare_rank_report_line_scores
  );

  /* put in ranking numbers, now that its sorted
  *  (except for milestone lines)
  */
  my_rank_number = 0;
  for (irank=0; irank <= out_rank_line_idx; irank++) {


    if (strcmp(out_rank_lines[irank]->person_B, "qhilite - top10") == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - good")  == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - avg")   == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - bad")   == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - bot10") == 0 ) {
      continue;
    }
    my_rank_number = my_rank_number + 1;
    out_rank_lines[irank]->rank_in_group = my_rank_number;


  }

/* for test */ /* display_buffs_to_stderr(); */









trn("doing ... make_html_file_person_in_group() in mamb_report_person_in_group()");
//kin(kingpin_is_in_group);

  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML  HTML HTML HTML HTML HTML HTML  HTML HTML HTML HTML HTML HTML 
  *  html report produced here
  */
  int retval;
  retval = make_html_file_person_in_group( /* produce actual html file */
    group_name,
    num_persons_in_grp,
    html_file_name,                     /* in grphtm.c */
    out_rank_lines,          /* array of report data */
    out_rank_line_idx,      /* int having last index written */
    avg_score_this_member,   /* for report bottom */
//    out_group_report_PSVs,   // defined in cocoa  char *out_group_report_PSVs[],  
//                             // array of output report data to pass to cocoa 
//    out_group_report_idx ,  // ptr to int having last index written */
    kingpin_is_in_group
  );

//trn("finished ... make_html_file_person_in_group() in mamb_report_person_in_group()");
//kin(retval);

  if (retval != 0) {
    g_docin_free();      /* free all allocated array elements */
    fclose_fpdb_for_debug();
    rkabort("Error: html file (one person) was not produced");
    return(1);
  }



  // here, build raw display data for tableview in cocoa ------------------------------------------------
  //

  // populate   out_group_report_PSVs 
  //      char *out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  //      int  *out_group_report_idx       /* ptr to int having last index written */
  //
  *out_group_report_idx = -1;  // zero-based

//  fopen_fpdb_for_debug();  /* for test */

  int i, lenA, lenB, longest_A, longest_B, len2names;
  int pad_len, pad_left, pad_right;
  char sfmt_pair_line[64];
  char sfmt_pair_names[64];
/*   char pad_spaces[32]; */
  char pair_line[128], benchmark_label[16], cocoa_rowcolor[16];
  char pair_names[128]; 

  int  num_pairs_in_grp;
  num_pairs_in_grp = (num_persons_in_grp * (num_persons_in_grp - 1)) / 2;
  char s_npig[8]; int size_NPIG;
  sprintf(s_npig, "%d", num_pairs_in_grp);
  size_NPIG = (int)strlen(s_npig);

  pad_left  = 0;
  pad_right = 0;
  for (longest_A=0,longest_B=0, i=0; i <= out_rank_line_idx; i++) { // get size of longest names for person_A and B
    if (out_rank_lines[i]->rank_in_group == 0) {
      continue;
    }
    lenA = (int)strlen(out_rank_lines[i]->person_A);
    lenB = (int)strlen(out_rank_lines[i]->person_B);
    if(lenA > longest_A) longest_A = lenA;
    if(lenB > longest_B) longest_B = lenB;
  }
  
  /*          Pair of                     */
  /*        Group Members  Score          */
  /*    1   Fa  Mo 890123   98          ] */
  
  len2names = longest_A + 2 + longest_B;
  if (len2names < 13) pad_len = 13 - len2names;
  else                pad_len = 0;


  /* =========  PUT HEADER LINES  ==============
  */
  // put out line to represent spacer before column headers in cocoa
    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s", "cHed|top space||");
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128


  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */
  if (len2names <= 13 ) {  /* SHORT NAMES  ---------------------------------------*/
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "  Pair of      Compatibility  ");

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s|%s||", "cHed", pair_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128

// build both lines in cocoa
//    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
//      size_NPIG,
//      len2names + pad_len +2+1+9+1+1);
//    sprintf(pair_line, sfmt_pair_line, " ", "Group Members    Potential    ");
//
//    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//    sprintf(gbl_my2_group_report_line, "%s|%s||", "cHed", pair_line);
//    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128
//

    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "Group Members    Potential    ");

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s|%s||", "cHed", pair_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128

  } else {                 /* ORDINARY LENGTH NAMES ------------------------------*/
    /* center "Pair of" in len2names spaces */
    pad_left = ((len2names - 7) /2) -1;      /* 7 = "Pair of" */
    pad_right = len2names - 7 - pad_left;    /* 7 = "Pair of" */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds  Compatibility  ", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Pair of", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +3+2+1+9+1);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s|%s||", "cHed", pair_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128

// build both lines in cocoa
//    pad_left = ((len2names - 13) /2) -1;        /* 13 = "Group Members" */
//    pad_right = len2names - 13 - pad_left; /* 13 = "Group Members" */
//    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds", pad_left, pad_right);
//    sprintf(pair_names, sfmt_pair_names, " ", "Group Members", " ");  
//    //sprintf(sfmt_pair_line, " %%%ds   %%-%ds    Potential    ", size_NPIG, len2names);
//      sprintf(sfmt_pair_line, " %%%ds   %%-%ds   Potential    ", size_NPIG, len2names);
//    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
//
//    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//    sprintf(gbl_my2_group_report_line, "%s|%s||", "cHed", pair_line);
//    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128
//
    pad_left = ((len2names - 13) /2) -1;        /* 13 = "Group Members" */
    pad_right = len2names - 13 - pad_left; /* 13 = "Group Members" */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Group Members", " ");  
    //sprintf(sfmt_pair_line, " %%%ds   %%-%ds    Potential    ", size_NPIG, len2names);
      sprintf(sfmt_pair_line, " %%%ds   %%-%ds   Potential    ", size_NPIG, len2names);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s|%s||", "cHed", pair_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128


  } /* end of =========  PUT HEADER LINES  ============== */


  /* 1. format lines into one string  
  *  2. get color
  *  3. populate array for cocoa table (out_group_report_PSVs) with that  (PSV format)
  */
  for (i=0; i <= out_rank_line_idx; i++) { /* ===== PUT DATA + BENCHMARK LINES  into array out_group_report_PSVs ===== */

    /* put out benchmark lines
    */
    if (out_rank_lines[i]->rank_in_group == 0) {
      if (out_rank_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_rank_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_rank_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_rank_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_rank_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

      if (pad_len == 0) {
        sprintf(sfmt_pair_line, " %%%ds   %%-%ds  %%-%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B         );
        sprintf(pair_line, sfmt_pair_line, " ", " ", " ",
          out_rank_lines[i]->score, benchmark_label);
      } else {
        sprintf(sfmt_pair_line, " %%%ds   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B, pad_len);
        sprintf(pair_line, sfmt_pair_line, " ", " ", " ", " ",
          out_rank_lines[i]->score, benchmark_label);
      }

      strcpy(cocoa_rowcolor, set_cell_bg_color_2(out_rank_lines[i]->score));    /* put in cocoa table here */
      sprintf(gbl_my2_group_report_line, "%s|%s||", cocoa_rowcolor, pair_line);
      *out_group_report_idx = *out_group_report_idx + 1;
      strcpy(out_group_report_PSVs + (*out_group_report_idx * gbl_g_max_len_group_data_PSV) , gbl_my2_group_report_line); // every 128

      continue;
    }
    strcpy(benchmark_label, "");


    /* put out data lines
    */

    char person_A_for_UITableView[32]; // in each name, replace all ' ' with '_'
    char person_B_for_UITableView[32];
    strcpy(person_A_for_UITableView,  out_rank_lines[i]->person_A);
    strcpy(person_B_for_UITableView,  out_rank_lines[i]->person_B);
    scharswitch(person_A_for_UITableView, ' ', '_');
    scharswitch(person_B_for_UITableView, ' ', '_');

    if (pad_len == 0) {
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B         );

      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,

//        out_rank_lines[i]->person_A,
//        out_rank_lines[i]->person_B,
        person_A_for_UITableView,
        person_B_for_UITableView,

        out_rank_lines[i]->score,
        benchmark_label
      );
    } else {
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B, pad_len);

      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,

//        out_rank_lines[i]->person_A,
//        out_rank_lines[i]->person_B,
        person_A_for_UITableView,
        person_B_for_UITableView,

        " ",  /* padding */
        out_rank_lines[i]->score,
        benchmark_label
      );
    }

    // Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "

    strcpy(cocoa_rowcolor, set_cell_bg_color_2(out_rank_lines[i]->score));      /* put in cocoa table here */


  //sprintf(gbl_my2_group_report_line, "%s|%s", cocoa_rowcolor, pair_line);
    sprintf(gbl_my2_group_report_line, "%s|%s|%s|%s", cocoa_rowcolor, pair_line,
        person_A_for_UITableView,
        person_B_for_UITableView
    );


    *out_group_report_idx = *out_group_report_idx + 1;
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128

  }  /* ===== PUT DATA + BENCHMARK LINES  into array out_group_report_PSVs ===== */


  g_rank_line_free(out_rank_lines, out_rank_line_idx);   // when finished, free arr elements 

  trn("end of mamb_report_person_in_group()"); 
  fclose_fpdb_for_debug();

  return(0);  

}  /* end of  mamb_report_person_in_group() */


char * set_cell_bg_color_2(int in_score) {
    if (in_score == 999) return( "cHed"); /* top 200/bot 100 */

    if (in_score >= 90) return( "cGr2");
    if (in_score <  90 &&
        in_score >= 75) return( "cGre");
    if (in_score <  75 &&
        in_score >  25) return( "cNeu");
    if (in_score <= 25 &&
        in_score >  10) return( "cRed");
    if (in_score <= 10) return( "cRe2");
    return("cNeu");
}



/* ============================================================== */


/* ================  WHOLE GROUP  ====================================== */
/*   mamb_report_whole_group()
*
* cocoa calls  mamb_report_whole_group() and ..person_in_group()
*  passing this array argument,
*          struct rank_report_line *out_rank_lines[]
*  Arrays are passed by ptr, so this function can fill up the arr
*  (up to max) and then cocoa can use it to put up
*  group member pair ranking screen.
*  This function also uses the array to make the html version for emailing.
*/
int mamb_report_whole_group(    /* called from cocoa */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
//  struct rank_report_line *out_rank_lines[],  /* output params returned */
//  int  *out_rank_line_idx,                    /* to calling function    */
  char *instructions,
  char *string_for_table_only, /* 1024 chars max (its 9 lines formatted) */
  char out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  int  *out_group_report_idx       /* ptr to int having last index written */
) {

tn();tn();trn("in mamb_report_whole_group()");
//ksn(instructions);
//ksn(string_for_table_only);
//ksn(html_file_name);
//ksn(group_name);
//kin(num_persons_in_grp);
//ksn(in_csv_person_arr[0]);
//ksn(in_csv_person_arr[1]);


/*  struct rank_report_line **out_rank_lines, */ /* output params returned */
  int kk, ii, irank, my_rank_number;
  char current_person[64], other_person[64];
  char SAVE_name_A[32], SAVE_name_B[32];
  struct rank_report_line my_rank_line;
  struct rank_report_line my_rank_line2;
  int  num_persons_in_cached_array;
  int PERCENTILE_RANK_SCORE;

  /* mamb_report_whole_group() sets output parameter to our arr of structs 
  *  which is to be returned to cocoa.
  */

/* fpdb=stderr; put me in main(). output file for debug code */
/* fpdb = fopen("t.out","a"); */




  fopen_fpdb_for_debug();

  gbl_is_best_year_or_day = 0;  /* no */

/* tn();ks(group_name);ki(num_persons_in_grp); */

  if (strstr(instructions, "return only") == NULL) {
    trn("in mamb_report_whole_group() return only strstr == null");
  }  /* avoid dbmsg on non-rpt call */



  /* fprintf(stdout, "\nin mamb_report_whole_group()\n");  */

  is_first_g_rank_line_put = 1; /* set to yes */

  allow_docin_puts_for_now = 0;  /* 1=yes, 0=no = no graph output (like pt of view in just2 rpt) */

  /* cache planetary positions of all grp mbrs in this:
  *       struct cached_person_positions {
  *        char person_name[20];    * max 15 may 2013 *
  *        int  minutes_natal[14];  * planetary positions *
  *       } g_cached_pos_tab[16];
  */
  put_stuff_in_cached_array(in_csv_person_arr, num_persons_in_grp);

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   /* for test */
*   int jj,ll; /*char nam[32];*/ int mi;
*   tn(); for(jj=0; jj <= num_persons_in_grp; jj++) {
*     ksn(g_cached_pos_tab[jj].person_name);tn();
*     for(ll=0; ll<=14; ll++){
*       mi = g_cached_pos_tab[jj].minutes_natal[ll];
*       ki(mi);
*     }
*     tn();
*   }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


  /* msbeg = clock(); */
  /* struct timeval tdbeg, tdend;  long us;
  * gettimeofday(&tdbeg, NULL );
  * int myctr; myctr = 0;
  */

  /* Populate out_rank_lines array.
  * 
  * loop thru in_csv_person_arr
  *       (idx goes from 0 -> num-1)
  *  take the person idx 0 + compare to all the rest (1 -> *num-1*)
  *  take the person idx 1 + compare to all the rest (2 -> *num-1*)
  *  take the person idx 2 + compare to all the rest (3 -> *num-1*)
  *  ...
  *  take the person idx *num-2* + compare to all the rest (num-1)
  */
  /* in this_pair_get_data() the following data ================================
  *  is stored in rank_lines array in cocoa:
  *    line is like this:   Rank Score  Person A    Person B
  */
  num_persons_in_cached_array = num_persons_in_grp;

  for (kk=0; kk <= num_persons_in_grp - 2; kk++) {      /* for each current_person */
    strcpy(current_person, in_csv_person_arr[kk]);
    for (ii=kk+1; ii <= num_persons_in_grp - 1; ii++) { /* for each other_person */
      strcpy(other_person, in_csv_person_arr[ii]);

      /* save in the right order that they came in on
      */
      strcpy(SAVE_name_A, csv_get_field(in_csv_person_arr[kk], ",", 1));
      strcpy(SAVE_name_B, csv_get_field(in_csv_person_arr[ii], ",", 1));

      /* current_person first
      */
      global_pair_compatibility_score   = 0;
      global_pair_a_compatibility_score = 0;
      global_pair_b_compatibility_score = 0;
      init_grh_datas();
      this_pair_get_data(   /* data is put in rank_lines array */
        current_person,
        other_person,
        num_persons_in_grp,
        num_persons_in_cached_array
      );
      global_pair_a_compatibility_score = global_pair_compatibility_score;
/* kin(global_pair_a_compatibility_score ); */
      /* char nam1[32]; char nam2[32];
      * strcpy(nam1, csv_get_field(current_person,",",1));
      * strcpy(nam2, csv_get_field(other_person,",",1));
      * fprintf(stdout,"%-15s|%-15s|%d|",nam1,nam2,global_pair_a_compatibility_score);
      */

      /* other_person first
      */
      init_grh_datas();
      this_pair_get_data(   /* data is put in rank_lines array */
        other_person,
        current_person,
        num_persons_in_grp,
        num_persons_in_cached_array
      );
      global_pair_b_compatibility_score = global_pair_compatibility_score;
/* kin(global_pair_b_compatibility_score ); */

      /* fprintf(stdout,"%d|%d|%d|\n", global_pair_a_compatibility_score,
      * global_pair_b_compatibility_score,
      * (global_pair_a_compatibility_score - global_pair_b_compatibility_score));
      */

      global_pair_compatibility_score = (global_pair_a_compatibility_score +
        global_pair_b_compatibility_score) / 2; 

      /* fprintf(stdout,"%d|\n", global_pair_compatibility_score); fflush(stdout); */

      /* write the data for this pair into report rank line array
      */
      my_rank_line.rank_in_group = 0;
      my_rank_line.score         = global_pair_compatibility_score;
/* kin(global_pair_compatibility_score); */

      PERCENTILE_RANK_SCORE =
        mapBenchmarkNumToPctlRank(global_pair_compatibility_score);

      my_rank_line.score         = PERCENTILE_RANK_SCORE;
/* kin(my_rank_line.score); */

/*       strcpy(my_rank_line.person_A, gA_EVENT_NAME); */
/*       strcpy(my_rank_line.person_B, gB_EVENT_NAME); */
      strcpy(my_rank_line.person_A, SAVE_name_A);
      strcpy(my_rank_line.person_B, SAVE_name_B);

      g_rank_line_put(
        my_rank_line,
        out_rank_lines,
        &out_rank_line_idx
      );

    } /* for each other_person */
  } /* for each current_person ===============================================*/

  /* fprintf(stdout,"\n\n"); */


  /* here all data is stored in rank_lines array
  *    line is like this:   Rank Score  Person A    Person B
  */

  /* add the milestone lines (they will sort in themselves by score)
  */
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 373; */
  my_rank_line2.score         = 90;
//strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); /* sort below ties with 373 */
  strcpy(my_rank_line2.person_A, "~~~~~~~~~~~~~~~"); /* sort below ties with 373 */
  strcpy(my_rank_line2.person_B, "qhilite - top10");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 213; */
  my_rank_line2.score         = 75;
//strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); /* sort below ties with 213 */
  strcpy(my_rank_line2.person_A, "~~~~~~~~~~~~~~~"); /* sort below ties with 213 */
  strcpy(my_rank_line2.person_B, "qhilite - good");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 100; */
  my_rank_line2.score         = 50;
//strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); /* sort below ties with 100 */
  strcpy(my_rank_line2.person_A, "~~~~~~~~~~~~~~~"); /* sort below ties with 100 */
  strcpy(my_rank_line2.person_B, "qhilite - avg");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 42; */
  my_rank_line2.score         = 25;
  strcpy(my_rank_line2.person_A, "               "); /* sort above ties with 42 */
  strcpy(my_rank_line2.person_B, "qhilite - bad");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );
  my_rank_line2.rank_in_group = 0;
/*   my_rank_line2.score         = 18; */
  my_rank_line2.score         = 10;
  strcpy(my_rank_line2.person_A, "               "); /* sort above ties with 18 */
  strcpy(my_rank_line2.person_B, "qhilite - bot10");
  g_rank_line_put(
    my_rank_line2,
    out_rank_lines,
    &out_rank_line_idx
  );




  /* gettimeofday(&tdend, NULL ); us = usecdiff(tdend,tdbeg); kin(us); */
  /* msend = clock(); trn("TOT MS for this_pair_get_data()  "); ki(msend-msbeg); */
  /* return(0);   for test, end here  */
  /* tn();trn("rank_lines before sort"); */


  /* TEST :  this goes to t.data (redirect in rktest.sh)
  *  Show ALL rank lines
  */
/* fprintf(stdout,"\n\n\n  BEFORE SORT in grpdoc.c\n\n");
* b(24); kin(*(out_rank_line_idx)); 
* int rr; for(rr=0; rr <= *(out_rank_line_idx); rr++) {
* ki(rr); 
*   fprintf(stdout,"%3d|%5d|%s|%s\n",
*     out_rank_lines[rr]->rank_in_group,
*     out_rank_lines[rr]->score,
*     out_rank_lines[rr]->person_A,
*     out_rank_lines[rr]->person_B
*   );
* }
* fflush(stdout);
* b(25);
*/

  /* trn("before qsort");
  * kin(out_rank_lines[0]->rank_in_group);
  * kin(out_rank_lines[0]->score);
  * ksn(out_rank_lines[0]->person_A);
  * ksn(out_rank_lines[0]->person_B);
  * tn();
  */

  /* Populate out_rank_lines array.
  *  
  * sort  by score field
  *  
  *  the newly created struct rank_report_line  *in_rank_lines[],
  */
  qsort(
    out_rank_lines,
    out_rank_line_idx + 1,   /* number of elements */
    sizeof(struct rank_report_line *),   /* capital R denotes a typedef */
    (compareFunc_rank)Func_compare_rank_report_line_scores
  );

  /* trn("after qsort"); */
  /* kin(out_rank_lines[0]->rank_in_group);
  * kin(out_rank_lines[0]->score);
  * ksn(out_rank_lines[0]->person_A);
  * ksn(out_rank_lines[0]->person_B); tn();
  */

  /* TEST :  this goes to t.data (redirect in rktest.sh)
  *  Show ALL rank lines
  */
  /* fprintf(stdout,"\n\n\n  AFTER SORT in grpdoc.c\n\n");
  * fflush(stdout);
  * b(27); kin(out_rank_line_idx);
  * for(int rr=0; rr <= out_rank_line_idx; rr++) {
  * ki(rr); 
  *   fprintf(stdout,"%3d|%5d|%s|%s\n",
  *     out_rank_lines[rr]->rank_in_group,
  *     out_rank_lines[rr]->score,
  *     out_rank_lines[rr]->person_A,
  *     out_rank_lines[rr]->person_B
  *   );
  * }
  * fflush(stdout);
  * b(28);
  */

  /* now that its sorted, put in ranking numbers 
  *  (except for milestone lines)
  */
  /* tn();trn("put in rank numbers"); */

/* tn();trn("put in rank numbers"); */
  my_rank_number = 0;
  for (irank=0; irank <= out_rank_line_idx; irank++) {
    /* kin(irank);ks(out_rank_lines[irank]->person_B);  */
    /*   strcpy(my_rank_line2.person_B, "qhilite - top10");
    *   strcpy(my_rank_line2.person_B, "qhilite - good");
    *   strcpy(my_rank_line2.person_B, "qhilite - avg");
    *   strcpy(my_rank_line2.person_B, "qhilite - bad");
    *   strcpy(my_rank_line2.person_B, "qhilite - bot10");
    */
    /* trn("rank num PUT");ki(irank);ks(out_rank_lines[irank]->person_B);  */
    if (strcmp(out_rank_lines[irank]->person_B, "qhilite - top10") == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - good")  == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - avg")   == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - bad")   == 0  ||
        strcmp(out_rank_lines[irank]->person_B, "qhilite - bot10") == 0 ) {
      continue;
    }
    my_rank_number = my_rank_number + 1;
    out_rank_lines[irank]->rank_in_group = my_rank_number;
/* if(irank<25) {kin(my_rank_number);ks(out_rank_lines[irank]->person_B);}; */
  }

  /* fprintf(stdout,"\n\n\n  AFTER PUTTING IN RANK NUMS in grpdoc.c\n\n");
  * fflush(stdout);
  * int rr; for(rr=0; rr <= out_rank_line_idx; rr++) {
  *   fprintf(stdout,"%3d|%5d|%s|%s\n",
  *     out_rank_lines[rr]->rank_in_group,
  *     out_rank_lines[rr]->score,
  *     out_rank_lines[rr]->person_A,
  *     out_rank_lines[rr]->person_B
  *   );
  * }
  * fflush(stdout);
  * b(28);
  */


tn();trn("doing ... make_html_file_whole_group() in mamb_report_whole_group()");
//ksn(instructions);
  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML  HTML HTML HTML HTML HTML HTML  HTML HTML HTML HTML HTML HTML 
  *  html report produced here
  */

  int retval;
  retval = make_html_file_whole_group( /* produce actual html file */
    group_name,
    num_persons_in_grp,
    html_file_name,                     /* in grphtm.c */
    out_rank_lines,           /* array of report data */
    out_rank_line_idx,       /* int having last index written */
    instructions,             /* might be instructions for table-only OR */
                              /* "top_this_many=|%d|bot_this_many=|%d|" */
    string_for_table_only,    /* 1024 chars max (its 9 lines formatted) */
                              /* buf to hold html for table */
    out_group_report_PSVs,    /* array of output report data to pass to cocoa */
    out_group_report_idx      /* ptr to int having last index written */
  );
//tn();b(300);ksn(string_for_table_only);
trn("at end of  ... make_html_file_whole_group() in mamb_report_whole_group()");

//ksn(group_name);
//kin(num_persons_in_grp);
//ksn(instructions);
//kin(out_rank_line_idx);




  if (retval != 0) {
    g_docin_free();      /* free all allocated array elements */
    fclose_fpdb_for_debug();
    rkabort("Error: html file (whole group) was not produced");
    return(1);
  }


  // here, build raw display data for tableview in cocoa ------------------------------------------------
  //
  //
  // but not if this is "return only" 
  if (strstr(instructions, "return only") != NULL) {
//    trn("end of mamb_report_whole_group()");
    fclose_fpdb_for_debug();
    return(0);  
  }  /* avoid dbmsg on non-rpt call */


  // determine if we need to show top 200 and bottom 100
  //   int gbl_g_top_bot_threshold  = 300;    // more data lines than this, then show top 150 + bot 50
  //
  int is_topbot;
  if (out_rank_line_idx > gbl_g_top_bot_threshold) { is_topbot = 1; } // gbl_g_show_top_this_many and gbl_g_show_bot_this_many
  else                                             { is_topbot = 0; } // NO



  // populate   out_group_report_PSVs 
  //      char *out_group_report_PSVs[],   /* array of output report data to pass to cocoa */
  //      int  *out_group_report_idx       /* ptr to int having last index written */
  //
  //char my_group_report_line[gbl_g_max_len_group_data_PSV + 8];
  *out_group_report_idx = -1;  // zero-based

//  fopen_fpdb_for_debug();  /* for test */

  int i, lenA, lenB, longest_A, longest_B, len2names;
  int pad_len, pad_left, pad_right;
  char sfmt_pair_line[64];
  char sfmt_pair_names[64];
/*   char pad_spaces[32]; */
  char pair_line[128], benchmark_label[16], cocoa_rowcolor[16];
  char pair_names[128]; 

  int  num_pairs_in_grp;
  num_pairs_in_grp = (num_persons_in_grp * (num_persons_in_grp - 1)) / 2;
  char s_npig[8]; int size_NPIG;
  sprintf(s_npig, "%d", num_pairs_in_grp);
  size_NPIG = (int)strlen(s_npig);



  /* get size of longest names for person_A and B
  */
  for (longest_A=0,longest_B=0, i=0; i <= out_rank_line_idx; i++) {
    if (out_rank_lines[i]->rank_in_group == 0) {
      continue;
    }
    lenA = (int)strlen(out_rank_lines[i]->person_A);
    lenB = (int)strlen(out_rank_lines[i]->person_B);
    if(lenA > longest_A) longest_A = lenA;
    if(lenB > longest_B) longest_B = lenB;
  }
  

  /*          Pair of                     */
  /*        Group Members  Score          */
  /*    1   Fa  Mo 890123   98          ] */
  
  len2names = longest_A + 2 + longest_B;
  if (len2names < 13) pad_len = 13 - len2names;
  else                pad_len = 0;

//kin(longest_A);
//kin(longest_B);
//kin(*out_group_report_idx);
  /* =========  PUT HEADER LINES  ==============
  */
trn("/* =========  PUT HEADER LINES  ==============");

  // put out line to represent spacer before column headers in cocoa  (same as grpone)
    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my2_group_report_line, "%s", "cHed|top space||");
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my2_group_report_line); // every 128

  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */


  // 20160314   remove these lines and put a comment in the info screen for best match in grp rpt
  //
//  if (is_topbot == 1) {  // check for top / bot
//    strcpy(cocoa_rowcolor, "cBgr");   /* for html bg, etc.  */
//
//    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//    sprintf(gbl_my3_group_report_line, "cBgr|This report has over %d lines, so||", gbl_g_top_bot_threshold); // 300
////ksn(gbl_my3_group_report_line);
//    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128
//
//    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//    sprintf(gbl_my3_group_report_line, "cBgr|we show the top %d and Bottom %d||",
//      gbl_g_show_top_this_many, // 150
//      gbl_g_show_bot_this_many  //  50
//    );
////ksn(gbl_my3_group_report_line);
//    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128
//
//  } // check for top / bot
//




  if (len2names <= 13 ) {  /* SHORT NAMES  ---------------------------------------*/
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "  Pair of      Compatibility  ");
//ksn(pair_line);
//kin(*out_group_report_idx);

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
//kin(*out_group_report_idx);

    sprintf(gbl_my3_group_report_line, "%s|%s||", "cHed", pair_line);

//kin(*out_group_report_idx);
//kin(gbl_g_max_len_group_data_PSV );
//ksn(gbl_my3_group_report_line);


//  strcpy(out_group_report_PSVs +  *out_group_report_idx  * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128
    strcpy(out_group_report_PSVs + (*out_group_report_idx) * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128



    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
      sprintf(pair_line, sfmt_pair_line, " ", "Group Members    Potential    ");
    //sprintf(pair_line, sfmt_pair_line, " ", "Group Members   Potential    ");

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */


    sprintf(gbl_my3_group_report_line, "%s|%s||", "cHed", pair_line);
//tr("short names");ksn(gbl_my3_group_report_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128

  } else {                 /* ORDINARY LENGTH NAMES ------------------------------*/
    /* center "Pair of" in len2names spaces */
    pad_left = ((len2names - 7) /2) -1;      /* 7 = "Pair of" */
    pad_right = len2names - 7 - pad_left;    /* 7 = "Pair of" */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds  Compatibility  ", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Pair of", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +3+2+1+9+1);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my3_group_report_line, "%s|%s||", "cHed", pair_line);
// ksn(gbl_my3_group_report_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128

    pad_left = ((len2names - 13) /2) -1;        /* 13 = "Group Members" */
    pad_right = len2names - 13 - pad_left; /* 13 = "Group Members" */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Group Members", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds    Potential    ", size_NPIG, len2names);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);

    *out_group_report_idx = *out_group_report_idx + 1;      /* put in cocoa table here */
    sprintf(gbl_my3_group_report_line, "%s|%s||", "cHed", pair_line);

//tr("ordinary length names");ksn(gbl_my3_group_report_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128

  } // put out column headers
  /* end of =========  PUT HEADER LINES  ============== */

trn("END of  /* end of =========  PUT HEADER LINES  ============== */");tn();


  /* 1. format lines into one string  
  *  2. get color
  *  3. populate array for cocoa table (out_group_report_PSVs) with that  (PSV format)
  */
  int ctr_rank_lines_encountered;
  int len_my_group_report_line;
  int num_end_spaces;             // for Top... / Bot...lines
  ctr_rank_lines_encountered = 0;
  len_my_group_report_line   = 0;
  num_end_spaces             = 0;             // for Top... / Bot...lines


  // big loop
  //
  for (i=0; i <= out_rank_line_idx; i++) { /* ===== PUT DATA + BENCHMARK LINES  into array out_group_report_PSVs ===== */
    /* put out benchmark lines
    */
    if (out_rank_lines[i]->rank_in_group == 0) {
      if (out_rank_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_rank_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_rank_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_rank_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_rank_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

      if (pad_len == 0) {
        sprintf(sfmt_pair_line, " %%%ds   %%-%ds  %%-%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B         );
        sprintf(pair_line, sfmt_pair_line, " ", " ", " ",
          out_rank_lines[i]->score, benchmark_label);
      } else {
        sprintf(sfmt_pair_line, " %%%ds   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B, pad_len);
        sprintf(pair_line, sfmt_pair_line, " ", " ", " ", " ",
          out_rank_lines[i]->score, benchmark_label);
      }

      strcpy(cocoa_rowcolor, set_cell_bg_color_2(out_rank_lines[i]->score));    /* put in cocoa table here */


      sprintf(gbl_my3_group_report_line, "%s|%s||", cocoa_rowcolor, pair_line);

//tr("benchmark line print");ksn(gbl_my3_group_report_line);


// ksn(gbl_my3_group_report_line);
      *out_group_report_idx = *out_group_report_idx + 1;
      strcpy(out_group_report_PSVs + (*out_group_report_idx * gbl_g_max_len_group_data_PSV) , gbl_my3_group_report_line); // every 128

      continue;
    }
    strcpy(benchmark_label, "");


    /* put out data lines
    */

    char person_A_for_UITableView[32]; // in each name, replace all ' ' with '_'
    char person_B_for_UITableView[32];
    strcpy(person_A_for_UITableView,  out_rank_lines[i]->person_A);
    strcpy(person_B_for_UITableView,  out_rank_lines[i]->person_B);
    scharswitch(person_A_for_UITableView, ' ', '_');
    scharswitch(person_B_for_UITableView, ' ', '_');

    if (pad_len == 0) {
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B         );

      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,

//        out_rank_lines[i]->person_A,
//        out_rank_lines[i]->person_B,
        person_A_for_UITableView,
        person_B_for_UITableView,

        out_rank_lines[i]->score,
        benchmark_label
      );
    } else {
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B, pad_len);

      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,

//        out_rank_lines[i]->person_A,
//        out_rank_lines[i]->person_B,
        person_A_for_UITableView,
        person_B_for_UITableView,

        " ",  /* padding */
        out_rank_lines[i]->score,
        benchmark_label
      );
    }
    ctr_rank_lines_encountered = ctr_rank_lines_encountered + 1;

    // check if we are on middle lines not to print due to Top / Bot
    //
    //int gbl_g_top_bot_threshold  = 300;    // more data lines than this, then show top 200 + bot 100
    //int gbl_g_show_top_this_many = 200;
    //int gbl_g_show_bot_this_many = 100;
    //
//kin(ctr_rank_lines_encountered  );
    if (is_topbot == 1) {  // check for top / bot
      if (ctr_rank_lines_encountered  == gbl_g_show_top_this_many + 1) {

        num_end_spaces = len_my_group_report_line - 6 - size_NPIG - 3 -4 -3; // for Top... / Bot...lines

        sprintf(sfmt_pair_line, "cHed| %%%ds   %%s %%3d%%%ds", size_NPIG, num_end_spaces); 
        sprintf(gbl_my3_group_report_line, sfmt_pair_line, " ", "Top", gbl_g_show_top_this_many, " ");

//tr("top line print");ksn(gbl_my3_group_report_line);

        *out_group_report_idx = *out_group_report_idx + 1;
        strcpy(out_group_report_PSVs + (*out_group_report_idx * gbl_g_max_len_group_data_PSV) , gbl_my3_group_report_line); // every 128
      }
      if (ctr_rank_lines_encountered  == num_pairs_in_grp - gbl_g_show_bot_this_many + 1) {

        num_end_spaces = len_my_group_report_line - 6 - size_NPIG - 6 -4 -3; // for Top... / Bot...lines

        sprintf(sfmt_pair_line, "cHed| %%%ds   %%s %%3d%%%ds", size_NPIG, num_end_spaces); 
        sprintf(gbl_my3_group_report_line, sfmt_pair_line, " ", "Bottom", gbl_g_show_bot_this_many, " ");

//tr("bottom line print");ksn(gbl_my3_group_report_line);

        *out_group_report_idx = *out_group_report_idx + 1;
        strcpy(out_group_report_PSVs + (*out_group_report_idx * gbl_g_max_len_group_data_PSV) , gbl_my3_group_report_line); // every 128
      }
//ki(ctr_rank_lines_encountered );kin(gbl_g_show_top_this_many  );
//ki(ctr_rank_lines_encountered );kin(num_pairs_in_grp );
      if (ctr_rank_lines_encountered  > gbl_g_show_top_this_many   &&
          ctr_rank_lines_encountered  < num_pairs_in_grp - gbl_g_show_bot_this_many + 1)
      {
        continue; // i is zero-based
      }

    } // check for top / bot



    // Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    strcpy(cocoa_rowcolor, set_cell_bg_color_2(out_rank_lines[i]->score));      /* put in cocoa table here */


  //sprintf(gbl_my3_group_report_line, "%s|%s", cocoa_rowcolor, pair_line);
    sprintf(gbl_my3_group_report_line, "%s|%s|%s|%s", cocoa_rowcolor, pair_line,
        person_A_for_UITableView,
        person_B_for_UITableView
    );
//tr("data line print");ksn(gbl_my3_group_report_line);



// ksn(gbl_my3_group_report_line);
    *out_group_report_idx    = *out_group_report_idx + 1;
    len_my_group_report_line = (int)strlen(gbl_my3_group_report_line);
    strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my3_group_report_line); // every 128

//kin(*out_group_report_idx);

  }  /* ===== PUT DATA + BENCHMARK LINES  into array out_group_report_PSVs ===== */

trn("END of    /* ===== PUT DATA + BENCHMARK LINES  into array out_group_report_PSVs ===== */");


  g_rank_line_free(out_rank_lines, out_rank_line_idx);   // when finished, free arr elements 



  fclose_fpdb_for_debug();
  return(0);  

}  /* end of mamb_report_whole_group() */
/* ============================================================== */


/* For- sort array of struct rank_report_line by rank score
*/
/* int Func_compare_rank_report_line_scores(
*   struct rank_report_line **line1,
*   struct rank_report_line **line2  
*/
int Func_compare_rank_report_line_scores( const void *line1, const void *line2 )
{
  struct rank_report_line **myline1 = (struct rank_report_line **)line1;
  struct rank_report_line **myline2 = (struct rank_report_line **)line2;

  /* sorted high to low
  */

  /*   return ( (**myline2).score  -  (**myline1).score ); */

  /* milestone lines should be at one end of ties with their score */
  /* strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); sort below ties with 373
  *  strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); sort below ties with 213
  *  strcpy(my_rank_line2.person_A, "zzzzzzzzzzzzzzz"); sort below ties with 100
  *  strcpy(my_rank_line2.person_A, "               "); sort above ties with 42
  *  strcpy(my_rank_line2.person_A, "               "); sort above ties with 18
  */
  /*     return ( strcmp( (**myline1).person_A, (**myline2).person_A ) ); */

  /* sort is on 1. score   2. person_A   3. person_B
  */
  if ( (**myline2).score  ==  (**myline1).score ) {
    if ( strcmp( (**myline1).person_A, (**myline2).person_A ) == 0) {
      return ( strcmp( (**myline1).person_B, (**myline2).person_B ) );
    } else {
      return ( strcmp( (**myline1).person_A, (**myline2).person_A ) );
    }
  } else {
    return ( (**myline2).score  -  (**myline1).score );
  }
}


/* For- sort array of struct avg_report_line by avg score
*/
int Func_compare_avg_report_line_scores( const void *line1, const void *line2 )
{
  struct avg_report_line **myline1 = (struct avg_report_line **)line1;
  struct avg_report_line **myline2 = (struct avg_report_line **)line2;

  /* sorted high to low
  */

  /* sort is on 1. score   2. person_name
  */
  if ( (**myline2).avg_score  ==  (**myline1).avg_score ) {
    return ( strcmp( (**myline1).person_name, (**myline2).person_name ));
  } else {
    return ( (**myline2).avg_score  -  (**myline1).avg_score );
  }
}


/* For- sort array of struct trait_report_line by trait score
*/
int Func_compare_trait_report_line_scores( const void *line1, const void *line2 )
{
  struct trait_report_line **myline1 = (struct trait_report_line **)line1;
  struct trait_report_line **myline2 = (struct trait_report_line **)line2;

  /* sorted high to low
  */

  /* sort is on 1. score   2. person_name
  */
  if ( (**myline2).score  ==  (**myline1).score ) {
    return ( strcmp( (**myline1).person_name, (**myline2).person_name ));
  } else {
    return ( (**myline2).score  -  (**myline1).score );
  }
}



// called for int mamb_report_whole_group(    /* called from cocoa */
// also
// called for int  mamb_report_person_in_group(  /* in grpdoc.o */ 
//
void this_pair_get_data( 
  char *current_person,
  char *other_person,
  int num_persons_in_grp,
  int num_persons_in_cached_array
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
  ,
  struct rank_report_line *out_rank_lines[],  /* output params returned */
  int  *out_rank_line_idx                     /* to cocoa               */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
) {
/*   struct rank_report_line my_rank_line; */

/* tn();trn("in this_pair_get_data()");  */
/* trn("current");ks(current_person); */
/* trn("  other");ks(  other_person); */
/* kin( num_persons_in_grp); */
/* kin( num_persons_in_cached_array); */

  set_constants();


  /* get_stuff_from_cached_array() populates these:
  *  
  *  gA_EVENT_NAME, gB_EVENT_NAME
  *  store_sgn_and_hse_placements_1(), store_sgn_and_hse_placements_2()
  */
  get_stuff_from_cached_array(
    current_person,
    other_person,
    num_persons_in_grp,
    num_persons_in_cached_array
  );

  store_comp_aspects();  /* gAR_ASP[i][k] = g_isaspect( */

  g_add_all_asps_to_grh_data();

//  fill_A_position_strings();  /* for testing aid */
//  fill_B_position_strings();


  /* this calls do_special_lines, which populates 
  *   int global_pair_compatibility_score
  *        (in do_special_lines() > save_pair_compat_score)
  */

  g_make_special_graphs();
 
 
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   /* write the data for this pair in report line array
*   */
* /* b(83); */
*   my_rank_line.rank_in_group = 0;
*   my_rank_line.score         = global_pair_compatibility_score;
*   strcpy(my_rank_line.person_A, gA_EVENT_NAME);
*   strcpy(my_rank_line.person_B, gB_EVENT_NAME);
* 
* /* b(84); */
*   g_rank_line_put(
*     my_rank_line,
*     out_rank_lines,
*     out_rank_line_idx
*   );
* /* b(85);tn(); */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

} /* end of this_pair_get_data() */

/* ---------------------------------------------------------------- */
void g_rank_line_put(
  struct rank_report_line line,
  struct rank_report_line *out_rank_lines[], /* output param returned */
  int    *out_rank_line_idx
)
{
/*  tn();trn("in g_rank_line_put()"); */

  if (is_first_g_rank_line_put == 1 )*out_rank_line_idx = 0;
  else                              (*out_rank_line_idx)++;
/* kin(*out_rank_line_idx);  */
  out_rank_lines[*out_rank_line_idx] = malloc(sizeof(struct rank_report_line));

/*   if ( docin_lines[docin_idx] == NULL) { */
  if (out_rank_lines[*out_rank_line_idx] == NULL) {
    sprintf(errbuf, "g_rank_line_put malloc failed, arridx=%d\n",
      *out_rank_line_idx);
    rkabort(errbuf);
  }

/*   out_rank_lines[*out_rank_line_idx] = line; */
  memcpy(out_rank_lines[*out_rank_line_idx], &line, sizeof(struct rank_report_line));

/* tn(); kin(out_rank_lines[*out_rank_line_idx]->rank_in_group);
*       kin(out_rank_lines[*out_rank_line_idx]->score);
* ksn(out_rank_lines[*out_rank_line_idx]->person_A);
* ksn(out_rank_lines[*out_rank_line_idx]->person_B);
*/

  is_first_g_rank_line_put = 0; /* set to no */
  
  /* When this function finishes,
  * the index *out_rank_line_idx points at the last line written.
  * Therefore, the current docin_lines written
  * run from index = 0 to index = *out_rank_line_idx. (see g_rank_line_free() below)
  */

}  /* end of  g_rank_line_put() */

/* Free the memory allocated for every member of array.
*/
void g_rank_line_free(
  struct rank_report_line *out_rank_lines[],  /* output param returned */
  int rank_line_last_used_idx
)
{
  int i;

  /*   for (i = 0; i <= rank_line_idx; i++) { */
  for (i = 0; i <= rank_line_last_used_idx; i++) {
    free(out_rank_lines[i]);   out_rank_lines[i] = NULL;  /* accidental re-free() does not crash */
  }
  rank_line_idx = 0;  /* pts to last array index populated */
}
/* ---------------------------------------------------------------- */

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* ---------------------------------------------------------------- */
* void g_avg_line_put(
*   struct avg_report_line line,
*   struct avg_report_line *out_avg_lines[], /* output param returned */
*   int    *out_avg_line_idx
* )
* {
* /*  tn();trn("in g_avg_line_put()"); */
* 
*   if (is_first_g_avg_line_put == 1 )*out_avg_line_idx = 0;
*   else                              (*out_avg_line_idx)++;
* /* kin(*out_avg_line_idx);  */
*   out_avg_lines[*out_avg_line_idx] = malloc(sizeof(struct avg_report_line));
* 
* /*   if ( docin_lines[docin_idx] == NULL) { */
*   if (out_avg_lines[*out_avg_line_idx] == NULL) {
*     sprintf(errbuf, "g_avg_line_put malloc failed, arridx=%d\n",
*       *out_avg_line_idx);
*     rkabort(errbuf);
*   }
* /* b(60);  */
* /*   out_avg_lines[*out_avg_line_idx] = line; */
*   memcpy(out_avg_lines[*out_avg_line_idx], &line, sizeof(struct avg_report_line));
* 
* /* tn(); kin(out_avg_lines[*out_avg_line_idx]->rank_in_group);
* *       kin(out_avg_lines[*out_avg_line_idx]->avg_score);
* * ksn(out_avg_lines[*out_avg_line_idx]->person_name);
* */
* 
*   is_first_g_avg_line_put = 0; /* set to no */
*   
*   /* When this function finishes,
*   * the index *out_avg_line_idx points at the last line written.
*   * Therefore, the current docin_lines written
*   * run from index = 0 to index = *out_avg_line_idx. (see g_avg_line_free() below)
*   */
* /* b(61); */
* }  /* end of  g_avg_line_put() */
* 
* 
* /* Free the memory allocated for every member of array.
* */
* void g_avg_line_free(
*   struct avg_report_line *out_avg_lines[],  /* output param returned */
*   int avg_line_last_used_idx
* )
* {
*   int i;
* 
*   /*   for (i = 0; i <= avg_line_idx; i++) { */
*   for (i = 0; i <= avg_line_last_used_idx; i++) {
*     free(out_avg_lines[i]);   out_avg_lines[i] = NULL;  /* accidental re-free() does not crash */
*   }
*   avg_line_idx = 0;  /* pts to last array index populated */
* }
/* ---------------------------------------------------------------- */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

/* ---------------------------------------------------------------- */
void g_trait_line_put(
  struct trait_report_line line,
  struct trait_report_line *out_trait_lines[], /* output param returned */
  int    *out_trait_line_idx
)
{
/*  tn();trn("in g_trait_line_put()"); */

  if (is_first_g_trait_line_put == 1 )*out_trait_line_idx = 0;
  else                              (*out_trait_line_idx)++;
/* kin(*out_trait_line_idx);  */
  out_trait_lines[*out_trait_line_idx] = malloc(sizeof(struct trait_report_line));

/*   if ( docin_lines[docin_idx] == NULL) { */
  if (out_trait_lines[*out_trait_line_idx] == NULL) {
    sprintf(errbuf, "g_trait_line_put malloc failed, arridx=%d\n",
      *out_trait_line_idx);
    rkabort(errbuf);
  }

/*   out_trait_lines[*out_trait_line_idx] = line; */
  memcpy(out_trait_lines[*out_trait_line_idx], &line, sizeof(struct trait_report_line));

/* tn(); kin(out_trait_lines[*out_trait_line_idx]->rank_in_group);
*       kin(out_trait_lines[*out_trait_line_idx]->trait_score);
* ksn(out_trait_lines[*out_trait_line_idx]->person_name);
*/

  is_first_g_trait_line_put = 0; /* set to no */
  
  /* When this function finishes,
  * the index *out_trait_line_idx points at the last line written.
  * Therefore, the current docin_lines written
  * run from index = 0 to index = *out_trait_line_idx. (see g_trait_line_free() below)
  */

}  /* end of  g_trait_line_put() */


/* Free the memory allocated for every member of array.
*/
void g_trait_line_free(
  struct trait_report_line *out_trait_lines[],  /* output param returned */
  int trait_line_last_used_idx
)
{
  int i;

  /*   for (i = 0; i <= trait_line_idx; i++) { */
  for (i = 0; i <= trait_line_last_used_idx; i++) {
    free(out_trait_lines[i]);   out_trait_lines[i] = NULL;  /* accidental re-free() does not crash */
  }
  trait_line_idx = 0;  /* pts to last array index populated */
}
/* ---------------------------------------------------------------- */


/* struct cached_person_positions {
*   char person_name[20];    * max 15 may 2013 *
*   int  minutes_natal[14];
* } g_cached_pos_tab[MAX_PERSONS_IN_GROUP+1];
*/
void put_stuff_in_cached_array(char *in_csv_person_arr[], int num_persons_in_grp)
{
  int kk,mm;
  char tmp_name[SIZE_INBUF+1], my_csv[128];
/*   char my_birth_year[16]; */
/* trn("in put_stuff_in_cached_array"); */

  for (kk=0; kk <= num_persons_in_grp - 1; kk++) {

    sfill(&tmp_name[0],SIZE_INBUF,' ');


    strcpy(my_csv, in_csv_person_arr[kk]); 


    get_event_details(my_csv, tmp_name, 
      &gINMN, &gINDY, &gINYR, &gINHR, &gINMU, &gINAP, &gINTZ, &gINLN);


  /* EXCLUDE person if gbl_is_best_year_or_day = 1;  yes
  *          AND (   birth year = gbl_bestyear_yyyy_todo
  *               OR birth year = gbl_bestday_yyyy_todo  )
  */
/*   g_cached_pos_tab[kk].is_EXCLUDED = 0; 
*   sprintf(my_birth_year, "%4.0f", gINYR) ;
* tn();ksn(my_birth_year); ks(gbl_bestyear_yyyy_todo); ks(gbl_bestday_yyyy_todo);
*   if (gbl_is_best_year_or_day == 1  
*       && (   strcmp(my_birth_year, gbl_bestyear_yyyy_todo) == 0 
*           || strcmp(my_birth_year, gbl_bestday_yyyy_todo) == 0 ) ) {
* trn("EXCLUDED!");
*     g_cached_pos_tab[kk].is_EXCLUDED = 1;  
*     continue;
*   }
* trn("not EXCLUDED!");
*/


    strcpy(g_cached_pos_tab[kk].person_name, tmp_name);


    calc_chart(gINMN,gINDY,gINYR,gINHR,gINMU,gINAP,gINTZ,gINLN,gINLT);


    g_put_minutes(&ar_minutes_natal_1[0]);  /* for person 1 / person A */


    for (mm=0; mm <= 13; mm++) {
      g_cached_pos_tab[kk].minutes_natal[mm] = ar_minutes_natal_1[mm];
    }


  } /* end of  for (kk=0; kk <= num_persons_in_grp - 1; kk++) */


/* for test */
/* int tt; for (tt=0; tt <= num_persons_in_grp - 1; tt++) {
*   ksn(g_cached_pos_tab[tt].person_name);
* }
*/

  /* sort array of struct cached_person_positions by person_name
  *  to allow for binary search lookup
  *  now includes "excluded" persons
  */
  qsort(
    g_cached_pos_tab,
    num_persons_in_grp,
    sizeof(Cached_person_positions),  /* capital C is a typedef */
    (compareFunc_positions)Func_compare_cached_positions_person_name
  );

  /* int tt; for (tt=0; tt <= num_persons_in_grp - 1; tt++) { */
  /*   ksn(g_cached_pos_tab[tt].person_name); */
  /*   ki(g_cached_pos_tab[tt].minutes_natal[1]); */
  /* } */

} /* end of  put_stuff_in_cached_array() */


/* For- sort array of struct cached_person_positions by person_name
*/
int Func_compare_cached_positions_person_name (
    struct cached_person_positions *pos1,
    struct cached_person_positions *pos2  )
{
  int retval;
  retval = strcmp(pos1->person_name, pos2->person_name);
  if (retval <  0)  return(-1);
  if (retval >  0)  return( 1);
  if (retval == 0)  return( 0);
  return(0);
}



/* struct cached_person_positions {
*   char person_name[20];    * max 15 may 2013 *
*   char *minutes_natal[14];
* } g_cached_pos_tab[16];
*/
void get_stuff_from_cached_array(
  char *current_person,
  char *other_person,
  int num_persons_in_grp,
  int num_persons_in_cached_array )
{
  char my_name[32];
  int  my_idx, mm;
  ;
/* tn();trn("in get_stuff_from_cached_array"); */

  /*  only get current_person if this is whole_group rpt, otherwise
  *   use the saved data (for person_in_group rpt)
  */
/*   if (strcmp(global_fact, "this is whole_group report") == 0) { */

  /* current_person
  */
  strcpy(my_name, csv_get_field(current_person, ",", 1));
  strcpy(gA_EVENT_NAME, my_name);  /* name for person A */
  my_idx = binsearch_person_in_cache(
    my_name,
    g_cached_pos_tab,
    num_persons_in_cached_array
  );

  /* trn("currentperson"); ks(my_name); ki(num_persons_in_cached_array);
  * kin(my_idx);ki(g_cached_pos_tab[my_idx].minutes_natal[1]);
  *             ks(g_cached_pos_tab[my_idx].person_name);
  * ksn(g_cached_pos_tab[0].person_name);
  * ksn(g_cached_pos_tab[1].person_name);
  * ksn(g_cached_pos_tab[2].person_name);
  */


  for (mm=0; mm <= 13; mm++) {
    ar_minutes_natal_1[mm] = g_cached_pos_tab[my_idx].minutes_natal[mm];
  }
  store_sgn_and_hse_placements_1();       /* for person 1 / person A */

  /* other_person
  */
  strcpy(my_name, csv_get_field(other_person, ",", 1));
  strcpy(gB_EVENT_NAME, my_name);  /* name for person A */

  my_idx = binsearch_person_in_cache(
    my_name,
    g_cached_pos_tab,
    num_persons_in_cached_array
  );

  for (mm=0; mm <= 13; mm++) {
    ar_minutes_natal_2[mm] = g_cached_pos_tab[my_idx].minutes_natal[mm];
  }
  store_sgn_and_hse_placements_2();       /* for person 2 / person B */

}  /* end of  get_stuff_from_cached_array(); */




void set_constants()
{
  gSGN_OVER_HSE_FACTOR  =  2;  /* old testing args last setting */
  gGRAPH_FACTOR         = 15;
  gPLACEMENT_MULTIPLIER =  6;
  gSUBTRACT_FROM_GOOD   =  0;
  gLESSON_MULTIPLIER    =  1;

  gPI_OVER_2 = 3.1415926535897932384 / 2.0;
  gHOUSE_CONFIDENCE[IDX_FOR_A] = Yes;  /* assume high accuracy for both */
  gMOON_CONFIDENCE [IDX_FOR_A] = Yes;
  gMOON_CONFIDENCE_FACTOR      = 1.0;
  gHOUSE_CONFIDENCE[IDX_FOR_B] = Yes;  /* assume high accuracy for both */
  gMOON_CONFIDENCE [IDX_FOR_B] = Yes;
}


/* ============================================================== */
/* old main() */
int mamb_report_just_2_people(    /* called from incocoa */
  char *html_browser_file_name,
  char *html_webview_file_name,
  char *csv_person_1,      /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *csv_person_2  )
{
  allow_docin_puts_for_now = 1;  /* 1=yes, 0=no  yes= allow graph output (like pt of view) */

/* fpdb=stderr; put me in main(). output file for debug code */
/* fpdb = fopen("t.out","a"); */

  fopen_fpdb_for_debug();

/* trn("JUST 2   JUST 2   JUST 2   JUST 2   JUST 2   JUST 2   JUST 2   JUST 2   "); */
tn();trn("in mamb_report_just_2_people()");

  g_init_item_tbl();  // for aspect codes
//<.>

  gbl_is_best_year_or_day = 0;  /* no */

  set_constants();
  /*   open_fut_output_file(); */


//  /* get names in the order of the initial args
//  */
//  char person_name_A[32];
//  char person_name_B[32];
//  strcpy(person_name_A, csv_get_field(csv_person_1, ",", 1));
//  strcpy(person_name_B, csv_get_field(csv_person_2, ",", 1));
//


  /* get the data for num_stars for person1 being first
  */
  do_comparisons(csv_person_1, csv_person_2);

  /* save num_stars for csv_person1 being first
  */
  A_stars_persn_g  =  stars_persn_g;
  A_stars_persn_b  =  stars_persn_b;


  A_stars_aview_g  =  stars_aview_g;
  A_stars_aview_b  =  stars_aview_b;
  A_stars_bview_g  =  stars_bview_g;
  A_stars_bview_b  =  stars_bview_b;


  A_stars_love_g   =  stars_love_g;
  A_stars_love_b   =  stars_love_b;
  A_stars_money_g  =  stars_money_g;
  A_stars_money_b  =  stars_money_b;
  A_stars_ovral_g  =  stars_ovral_g;
  A_stars_ovral_b  =  stars_ovral_b;

 tn();
//kin(A_stars_persn_g);
//kin(A_stars_persn_b);
//kin(A_stars_aview_g);
//kin(A_stars_aview_b);
//kin(A_stars_bview_g);
//kin(A_stars_bview_b);
//
//kin(A_stars_love_g);
//kin(A_stars_love_b);
//kin(A_stars_money_g);
//kin(A_stars_money_b);
//kin(A_stars_ovral_g);
//kin(A_stars_ovral_b);



  /* get the data for num_starts for person2 being first
  */
  do_comparisons(csv_person_2, csv_person_1);

  /* save num_stars for csv_person2 being first
  */
  B_stars_persn_g  =  stars_persn_g;
  B_stars_persn_b  =  stars_persn_b;

  B_stars_aview_g  =  stars_aview_g;
  B_stars_aview_b  =  stars_aview_b;
  B_stars_bview_g  =  stars_bview_g;
  B_stars_bview_b  =  stars_bview_b;

  B_stars_love_g   =  stars_love_g;
  B_stars_love_b   =  stars_love_b;
  B_stars_money_g  =  stars_money_g;
  B_stars_money_b  =  stars_money_b;
  B_stars_ovral_g  =  stars_ovral_g;
  B_stars_ovral_b  =  stars_ovral_b;

 tn();
//kin(B_stars_persn_g);
//kin(B_stars_persn_b);
//kin(B_stars_aview_g);
//kin(B_stars_aview_b);
//kin(B_stars_bview_g);
//kin(B_stars_bview_b);
//
//kin(B_stars_love_g);
//kin(B_stars_love_b);
//kin(B_stars_money_g);
//kin(B_stars_money_b);
//kin(B_stars_ovral_g);
//kin(B_stars_ovral_b);
//
 tn();



  is_first_g_docin_put = 1;  /* 1=yes, 0=no */

  /*   fprintf(gFP_DOCIN_FILE,"[beg_program]\n"); */
  gdocn = sprintf(gdocp,"[beg_program]\n");
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s", "\n[beg_topinfo1]\n");
  g_docin_put(gdocp, gdocn);


  /* get names in the order of the initial args
  */
  char person_name_A[32];
  char person_name_B[32];
  strcpy(person_name_A, csv_get_field(csv_person_1, ",", 1));
  strcpy(person_name_B, csv_get_field(csv_person_2, ",", 1));


//tn();tr("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
//
//tn();
//ksn(person_name_A);
////ksn(SAVE_name_A);
//ksn(gA_EVENT_NAME);
//kin(A_stars_aview_g);
//kin(A_stars_aview_b);
//kin(A_stars_bview_g);
//kin(A_stars_bview_b);
//tn();ksn(person_name_B);
//ksn(gB_EVENT_NAME);
//kin(B_stars_aview_g);
//kin(B_stars_aview_b);
//kin(B_stars_bview_g);
//kin(B_stars_bview_b);
//tn();tr("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
//


    // 20170212 fixer put underscore in name with space
    //
    char person_name_A_with_underscore[32]; // in each name, replace all ' ' with '_'
    strcpy(person_name_A_with_underscore, person_name_A);
    scharswitch(person_name_A_with_underscore, ' ', '_');
//ksn(person_name_A);
//ksn(person_name_A_with_underscore);
//ksn("put underscore  ___________________________________");


/*   gdocn = sprintf(gdocp,"%s\n", &gA_EVENT_NAME[0]);  */
//  gdocn = sprintf(gdocp,"%s\n", person_name_A); 
//  gdocn = sprintf(gdocp,"%s\n", &gA_EVENT_NAME[0]);
//  gdocn = sprintf(gdocp,"%s\n", person_name_A); 
  gdocn = sprintf(gdocp,"%s\n", person_name_A_with_underscore); 
//ksn(gdocp);

  g_docin_put(gdocp, gdocn);    // NOTE:  this becomes arr(0) in grphtm.c



    // 20170212 fixer put underscore in name with space
    //
    char person_name_B_with_underscore[32]; // in each name, replace all ' ' with '_'
    strcpy(person_name_B_with_underscore, person_name_B);
    scharswitch(person_name_B_with_underscore, ' ', '_');



/*   gdocn = sprintf(gdocp,"%s\n", &gB_EVENT_NAME[0]); */
//  gdocn = sprintf(gdocp,"%s\n", person_name_B); 
//  gdocn = sprintf(gdocp,"%s\n", &gB_EVENT_NAME[0]); 
//  gdocn = sprintf(gdocp,"%s\n", person_name_B); 
  gdocn = sprintf(gdocp,"%s\n", person_name_B_with_underscore); 

  g_docin_put(gdocp, gdocn);    // NOTE:  this becomes arr(0) in grphtm.c




  gdocn = sprintf(gdocp,"%s", "[end_topinfo1]\n");
  g_docin_put(gdocp, gdocn);


  /* write to doc the lines for the 6 horizontal graphs
  *  - old g_make_special_graphs(); 
  */
  gdocn = sprintf(gdocp,"\n[beg_graph]\n");
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"[beg_persn]\n");  /* idx = 1 */
  g_docin_put(gdocp, gdocn);
  g_mk_grh_line(
    (A_stars_persn_g + B_stars_persn_g) / 2,
    PLUS_OR_MINUS_IDX_FOR_GOOD
  );
  g_mk_grh_line(
    (A_stars_persn_b + B_stars_persn_b) / 2,
    PLUS_OR_MINUS_IDX_FOR_BAD
  );
  gdocn = sprintf(gdocp,"[end_persn]\n");
  g_docin_put(gdocp, gdocn);



// ------------------------------------------------------------------------------------
//  gdocn = sprintf(gdocp,"[beg_aview]\n");  /* idx = 2 */

//  gdocn = sprintf(gdocp,"[beg_aview]|%s\n", person_name_A);  /* idx = 2 */
  gdocn = sprintf(gdocp,"[beg_aview]|%s\n", person_name_A_with_underscore);  /* idx = 2 */
  g_docin_put(gdocp, gdocn);



//tn();tr("beg_aview");
//ksn(gdocp);
//ksn(person_name_A);
//tn();
//

  g_mk_grh_line(
//    (A_stars_aview_g + B_stars_aview_g) / 2,
    (A_stars_aview_g + B_stars_bview_g) / 2,
    PLUS_OR_MINUS_IDX_FOR_GOOD
  );
  g_mk_grh_line(
//    (A_stars_aview_b + B_stars_aview_b) / 2,
    (A_stars_aview_b + B_stars_bview_b) / 2,
    PLUS_OR_MINUS_IDX_FOR_BAD
  );
  gdocn = sprintf(gdocp,"[end_aview]\n");
  g_docin_put(gdocp, gdocn);


//  gdocn = sprintf(gdocp,"[beg_bview]\n");  /* idx = 3 */

//  gdocn = sprintf(gdocp,"[beg_bview]|%s\n", person_name_B);  /* idx = 2 */
  gdocn = sprintf(gdocp,"[beg_bview]|%s\n", person_name_B_with_underscore);  /* idx = 2 */
  g_docin_put(gdocp, gdocn);

//tn();tr("beg_bview");
//ksn(gdocp);
//ksn(person_name_B);
//tn();
//


  g_mk_grh_line(
//    (A_stars_bview_g + B_stars_bview_g) / 2,
    (A_stars_bview_g + B_stars_aview_g) / 2,
    PLUS_OR_MINUS_IDX_FOR_GOOD
  );
  g_mk_grh_line(
//    (A_stars_bview_b + B_stars_bview_b) / 2,
    (A_stars_bview_b + B_stars_aview_b) / 2,
    PLUS_OR_MINUS_IDX_FOR_BAD
  );
  gdocn = sprintf(gdocp,"[end_bview]\n");
  g_docin_put(gdocp, gdocn);
// ------------------------------------------------------------------------------------
  


  gdocn = sprintf(gdocp,"[beg_love]\n");  /* idx = 0 */
  g_docin_put(gdocp, gdocn);
  g_mk_grh_line(
    (A_stars_love_g + B_stars_love_g) / 2,
    PLUS_OR_MINUS_IDX_FOR_GOOD
  );
  g_mk_grh_line(
    (A_stars_love_b + B_stars_love_b) / 2,
    PLUS_OR_MINUS_IDX_FOR_BAD
  );
  gdocn = sprintf(gdocp,"[end_love]\n");
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"[beg_money]\n");  /* idx = 1 */
  g_docin_put(gdocp, gdocn);
  g_mk_grh_line(
    (A_stars_money_g + B_stars_money_g) / 2,
    PLUS_OR_MINUS_IDX_FOR_GOOD
  );
  g_mk_grh_line(
    (A_stars_money_b + B_stars_money_b) / 2,
    PLUS_OR_MINUS_IDX_FOR_BAD
  );
  gdocn = sprintf(gdocp,"[end_money]\n");
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"[beg_ovral]\n");  /* idx = 0 */
  g_docin_put(gdocp, gdocn);
  g_mk_grh_line(
    (A_stars_ovral_g + B_stars_ovral_g) / 2,
    PLUS_OR_MINUS_IDX_FOR_GOOD
  );
  g_mk_grh_line(
    (A_stars_ovral_b + B_stars_ovral_b) / 2,
    PLUS_OR_MINUS_IDX_FOR_BAD
  );
  gdocn = sprintf(gdocp,"[end_ovral]\n");
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"[end_graph]\n\n");
  g_docin_put(gdocp, gdocn);






//<.> where to put this ? for just 2  aspect paras ???
  g_put_aspect_strings();  // codes for all aspects

  gmake_paras(); //  back from the past  20151012 not any more 





  gdocn = sprintf(gdocp,"[end_program]\n\n");
  g_docin_put(gdocp, gdocn);

  /* put positions at bot of docin_lines / t.perdoc (for checking)
  *  goes to docin_put
  */


//  display_for_astrology_buffs();



  /* int ii; for (ii = 0; ii <= docin_idx; ii++) { for test
  *   strcpy(Swk, docin_lines[ii] );
  *   fprintf(stderr,"%s", Swk);
  * } 
  */


  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML 
  *
  * for this call:
  *
  * int mamb_report_just_2_people(    * called from incocoa *
   *   char *html_browser_file_name,
   *   char *html_ewbview_file_name,
  *   char *csv_person_1,      * fmt= "Fred,3,21,1987,11,58,1,5,80.34" *
  *   char *csv_person_2  )
  * x
  */
  /* html report produced here
  */
//tn();trn(" doing make_html_file_just_2_people() with A,B   in mamb_report_just_2_people");
  int retval;
  retval = make_html_file_just_2_people(
    html_browser_file_name,
    docin_lines,
    docin_idx,
    csv_person_1,
    csv_person_2
  );
//tn();trn(" doing make_html_file_just_2_people() with B,A   in mamb_report_just_2_people");
  int retval2;
  retval2 = make_html_file_just_2_people(
    html_webview_file_name,
    docin_lines,
    docin_idx,
    csv_person_1,
    csv_person_2
  );
  if (retval != 0 || retval2 != 0) {
    g_docin_free();      /* free all allocated array elements */
    fclose_fpdb_for_debug();
    rkabort("Error: html file (just_2) was not produced");
    return(1);
  }

trn("end of mamb_report_just_2_people()");

  fclose_fpdb_for_debug();
  return(0);

}  /* end of mamb_report_just_2_people()   - old main() */
/* ============================================================== */



void do_comparisons(char *csv_person_1, char *csv_person_2)  // called from   int mamb_report_just_2_people(    /* called from incocoa */
{
  ;

/* tn();trn("in do_comparisons() ------------------------------------"); */
    init_grh_datas();

  sfill(&gEVENT_NAME[0],SIZE_INBUF,' ');
  
  get_event_details(csv_person_1, gEVENT_NAME, 
    &gINMN, &gINDY, &gINYR, &gINHR, &gINMU, &gINAP, &gINTZ, &gINLN);

  /* ksn(csv_person_1); ksn(gEVENT_NAME);
  * tn();kd(gINMN);kd(gINDY);kd(gINYR);kd(gINHR);kd(gINMU);ki(gINAP);kd(gINTZ);kd(gINLN); tn();
  */
  strcpy(gA_EVENT_NAME,gEVENT_NAME);  /* name for person A */

  calc_chart(gINMN,gINDY,gINYR,gINHR,gINMU,gINAP,gINTZ,gINLN,gINLT);

  g_put_minutes(&ar_minutes_natal_1[0]);  /* for person 1 / person A */

  store_sgn_and_hse_placements_1();       /* for person 1 / person A */

  sfill(&gEVENT_NAME[0],SIZE_INBUF,' ');
  

  get_event_details(csv_person_2, gEVENT_NAME, 
    &gINMN, &gINDY, &gINYR, &gINHR, &gINMU, &gINAP, &gINTZ, &gINLN);

  strcpy(gB_EVENT_NAME,gEVENT_NAME);  /* name for person B */


  calc_chart(gINMN,gINDY,gINYR,gINHR,gINMU,gINAP,gINTZ,gINLN,gINLT);

  g_put_minutes(&ar_minutes_natal_2[0]);
  store_sgn_and_hse_placements_2();

  store_comp_aspects();  /* gAR_ASP[i][k] = g_isaspect( */  // also, capture orb data in here

//  fill_A_position_strings();  /* for testing aid */
//  fill_B_position_strings();

  g_add_all_asps_to_grh_data();                             // also, capture plus or minus for aspect in here


  /* this changed to not write anything, but save num_stars data
  *  > do_special_lines() and > do_grh_data_lines()
  */
  g_make_special_graphs();

//<.>
//  g_init_item_tbl();  // for aspect codes
//nbn(501);
//  gmake_paras(); //  back from the past  20151012 not any more 
//nbn(502);
//
//


} /* end of do_comparisons() */


void g_init_item_tbl(void)
{
//tn();tr("g_init_item_tbl");
  int i;
  ;
  for (i=0; i <= gMAX_IN_ITEM_TBL-1; ++i) {
    gP_ITEM_TBL[i] = &gITEM_TBL[i*(SIZE_ITEM+1)];
//ki(i);ksn(gP_ITEM_TBL[i]);
  }
  gITEM_TBL_IDX = -1;  /* setup use as ++subscript */
}  /* end of g_init_item_tbl() */


//<.>
//void g_put_aspect_strings(void)
//{
//  int i,k;  /* i=1st plt  k=2nd plt */
//  ;
//tn();tr("g_put_aspect_strings");
//  for (i=1; i <= NUM_PLT_FOR_PARAS; ++i) {
//    for (k=i+1; k <= NUM_PLANETS; ++k) {
//      if (gAR_ASP[i][k] == 0) continue;
//      ++gITEM_TBL_IDX;
//      sprintf(gP_ITEM_TBL[gITEM_TBL_IDX],"%02d%1s%02d",
//        i,  /* plt1 */
//        gN_SHORT_DOC_ASPECT[gASPECT_TYPE[gAR_ASP[i][k]]],
//        k);  /* plt2 */
//
//tn();ki(gITEM_TBL_IDX);ks(gP_ITEM_TBL[gITEM_TBL_IDX]);
//
//    }
//  }
//tn();tr("end of g_put_aspect_strings");
//}  /* end of g_put_aspect_strings() */
//<.>
//

void g_put_aspect_strings(void)
{
  int i,k;  /* i=A plt  k=B plt */
//tn();tr("g_put_aspect_strings");
  ;
//trn("HEY222");
  RKDO(i,1,NUM_PLANETS) {
  
    RKDO(k,1,NUM_PLANETS) {

      if (gAR_ASP[i][k] == 0) continue;  // no aspect

      // missed mar opp sat
      //      if (RKISBETWEEN(i, MAR_IDX,PLU_IDX)
      //      &&  RKISBETWEEN(k, MAR_IDX,PLU_IDX)) { continue;  /* no far,far */ }
      //
      if (RKISBETWEEN(i, JUP_IDX,PLU_IDX)  // is inclusive of  bounds
      &&  RKISBETWEEN(k, JUP_IDX,PLU_IDX)) { continue;  /* no far,far */ }

      ++gITEM_TBL_IDX;

//      sprintf(gP_ITEM_TBL[gITEM_TBL_IDX],"%02d%1s%02d",
//        i,  /* A plt */
//        gN_SHORT_DOC_ASPECT[gASPECT_TYPE[gAR_ASP[i][k]]],
//        k   /* B plt */
//      );
//
      // make pipe-delimited with 2 added fields
      // add 1 ->25 plus/minus  (neg=minus signs red, pos=plus signs green)
      //
      // int gEXPRESSION_1_25[NUM_PLANETS+1][NUM_PLANETS+1]; // -25 -> +25 (nozero) num minuses or pluses below each aspect para (negative=red, positive-green)
      //

//tn();tr("store expressionval in gP_ITEM_TBL[gITEM_TBL_IDX]");ki(i);ki(k);kin(gEXPRESSION_1_25[i][k]);

      sprintf(gP_ITEM_TBL[gITEM_TBL_IDX], "%02d%1s%02d|%d",
        i,  /* A plt */
        gN_SHORT_DOC_ASPECT[gASPECT_TYPE[gAR_ASP[i][k]]],
        k,  /* B plt */
        gEXPRESSION_1_25[i][k]
      );
//ki(gITEM_TBL_IDX); ksn(gP_ITEM_TBL[gITEM_TBL_IDX]); 
//<.>



//      char test_aspstr[32];
//      sprintf(test_aspstr,"%02d%1s%02d",
//        i,  /* A plt */
//        gN_SHORT_DOC_ASPECT[gASPECT_TYPE[gAR_ASP[i][k]]],
//        k   /* B plt */
//      );
////<.>
////double testorb; testorb = gAR_ASP_ORB[i][k];
////tn();tr("is orb OK to add here?");ks(test_aspstr);kd(testorb);
//
//
    } // RKDO(i,1,NUM_PLANETS) {

  } // RKDO(k,1,NUM_PLANETS) {

//tn();tr("end of g_put_aspect_strings");
}  /* end of put_aspect_strings() */



void gmake_paras(void)  // generates codes  for aspect text
{
  int i;
  char oldAspCode[32];
  char numplusminus[32], paraworkstr[128];
  ;
//tn();tr("gmake_paras");
  /*  set_doc_for_paras();   old old */
//<.>
  fill_A_position_strings();  /* for testing aid */
  fill_B_position_strings();

  //  fprintf(_FP_DOCIN_FILE,"\n\n[beg_aspects]\n");
  gdocn = sprintf(gdocp,"[beg_aspects]\n");
  g_docin_put(gdocp, gdocn);

  /*  fprintf(_FP_DOCIN_FILE,"\n.(compttl)\n"); */
  /* read stuff in */
  strsort(gP_ITEM_TBL, gITEM_TBL_IDX + 1);

//tn();trn("HEY");

  for (i=0; i <= gITEM_TBL_IDX; ++i) {  /* idx pts to last element */

//ki(i); ksn(gP_ITEM_TBL[i]); 
    // get old gP_ITEM_TBL from PSV
    //
    strcpy(paraworkstr, gP_ITEM_TBL[i]);
//ksn(paraworkstr);
    strcpy(oldAspCode,   csv_get_field(paraworkstr, "|", 1) );
    strcpy(numplusminus, csv_get_field(paraworkstr, "|", 2) );
//ks(oldAspCode);ksn(numplusminus);

    /* put 'c' at head of doc register name */
    /* (bad form to start with a number) */

//    gdocn = sprintf(gdocp, "^(c%s)\n", gP_ITEM_TBL[i] );  /* c for comp */
//    g_docin_put(gdocp, gdocn);

          // fprintf(stdout,"^(c%s)\n",_P_ITEM_TBL[i]);
          //     * ^to be piped to pick_stuff >compdoc/@ in ws futin1 "comp * 

    gdocn = sprintf(gdocp, "^(c%s)|%s", oldAspCode, numplusminus);  /* c for comp */
    g_docin_put(gdocp, gdocn);
  }

  /*  fprintf(_FP_DOCIN_FILE,"\n.(compftr)\n"); */

  // fprintf(_FP_DOCIN_FILE,"[end_aspects]\n");
  gdocn = sprintf(gdocp,"[end_aspects]\n");
  g_docin_put(gdocp, gdocn);

}  /* end of gmake_paras() */


/* for docin lines for debug, not in html
*/
void display_for_astrology_buffs(void)
{
/*   char lf_fill[10+1]; */
  char mid_fill[21+1];

  sfill(&mid_fill[0],21,' ');
  gdocn = sprintf(gdocp,"\n\n%s%s\n", mid_fill,
    "---------for astrology buffs---------");
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp, "%19s  %s  %s  %s\n", gA_EVENT_NAME,
    gPOS_STR_1+1*(11+1), gPOS_STR_1+5*(11+1), gPOS_STR_1+9*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_1+2*(11+1), gPOS_STR_1+6*(11+1), gPOS_STR_1+10*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_1+3*(11+1), gPOS_STR_1+7*(11+1), gPOS_STR_1+11*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n\n", mid_fill,
    gPOS_STR_1+4*(11+1), gPOS_STR_1+8*(11+1), gPOS_STR_1+13*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp, "%19s  %s  %s  %s\n", gB_EVENT_NAME,
    gPOS_STR_2+1*(11+1), gPOS_STR_2+5*(11+1), gPOS_STR_2+9*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_2+2*(11+1), gPOS_STR_2+6*(11+1), gPOS_STR_2+10*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_2+3*(11+1), gPOS_STR_2+7*(11+1), gPOS_STR_2+11*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_2+4*(11+1), gPOS_STR_2+8*(11+1), gPOS_STR_2+13*(11+1));
  g_docin_put(gdocp, gdocn);

  gdocn = sprintf(gdocp,"%s%s\n", mid_fill,
    "-------------------------------------");
  g_docin_put(gdocp, gdocn);

} /* end of display_for_astrology_buffs() */


/* for docin lines for debug, not in html
*/
void display_buffs_to_stderr(void)
{
/*   char lf_fill[10+1]; */
  char mid_fill[21+1];

  sfill(&mid_fill[0],21,' ');
  gdocn = sprintf(gdocp,"\n\n%s%s\n", mid_fill,
    "---------for astrology buffs---------");
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp, "%19s  %s  %s  %s\n", gA_EVENT_NAME,
    gPOS_STR_1+1*(11+1), gPOS_STR_1+5*(11+1), gPOS_STR_1+9*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_1+2*(11+1), gPOS_STR_1+6*(11+1), gPOS_STR_1+10*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_1+3*(11+1), gPOS_STR_1+7*(11+1), gPOS_STR_1+11*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n\n", mid_fill,
    gPOS_STR_1+4*(11+1), gPOS_STR_1+8*(11+1), gPOS_STR_1+13*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp, "%19s  %s  %s  %s\n", gB_EVENT_NAME,
    gPOS_STR_2+1*(11+1), gPOS_STR_2+5*(11+1), gPOS_STR_2+9*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_2+2*(11+1), gPOS_STR_2+6*(11+1), gPOS_STR_2+10*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_2+3*(11+1), gPOS_STR_2+7*(11+1), gPOS_STR_2+11*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s  %s  %s\n", mid_fill,
    gPOS_STR_2+4*(11+1), gPOS_STR_2+8*(11+1), gPOS_STR_2+13*(11+1));
  fprintf(stderr, "%s", gdocp);

  gdocn = sprintf(gdocp,"%s%s\n", mid_fill,
    "-------------------------------------");
  fprintf(stderr, "%s", gdocp);

}  /* end of display_buffs_to_stderr() */



/* looks like "real" docin_put is only for just_2
*/
/* add a line to the array of docin_lines
*  replaces this:  fput(p,n,Fp_docin_file); 
*  
*  eg 1
*  * fput(p,n,Fp_docin_file); * 
* docin_put(docp,docn);
*    
*  eg 2
*  *fprintf(FP_DOCIN_FILE,"\n[end_program]\n"); *
*  ndoc = sprintf(p,"\n[end_program]\n");
*  docin_put(docp, docn);
*/
void g_docin_put(char *line, int length)
{
//tn();tr("in g_docin_PUT");  ksn(line);
  if (allow_docin_puts_for_now == 0) return; /* (like pt of view in just2) */
  
  if (is_first_g_docin_put == 1) docin_idx = 0;
  else                           docin_idx++;
//tr("docin_put");ki(docin_idx);ki(length);ks(line);

//tn();ki(docin_idx);ks(line);

  docin_lines[docin_idx] = malloc(length + 1);

  if (docin_lines[docin_idx] == NULL) {
    sprintf(errbuf, "g_docin_put malloc failed, arridx=%d, linelen=%d, line=[%s]\n",
      docin_idx, length, line);
    rkabort(errbuf);
  }

  strcpy(docin_lines[docin_idx], line);

  is_first_g_docin_put = 0;  /* set to no */
  
  /* When this function finishes,
  * the index docin_idx points at the last line written.
  * Therefore, the current docin_lines written
  * run from index = 0 to index = docin_idx. (see g_docin_free() below)
  */
}


/* Free the memory allocated for every member of docin_lines array.
*/
void g_docin_free(void)
{
  int i;
/* tn(); trn("in g_docin_free()");ki(docin_idx); */ /* tn(); */

  for (i = 0; i <= docin_idx; i++) {
    free(docin_lines[i]);  
    docin_lines[i] = NULL;  /* accidental re-free() does not crash */
  }
  docin_idx = 0;  /* pts to last array index populated */
}


void g_make_special_graphs(void)
{
  /*  set_doc_for_grh(); */
/* trn("in g_make_special_graphs()"); */

  do_special_lines(COMP_IDX_FOR_PERSONAL, PERSONAL_NUMERATOR,PERSONAL_DENOMINATOR);
  do_special_lines(COMP_IDX_FOR_A_PT_VIEW, A_PT_VIEW_NUMERATOR,A_PT_VIEW_DENOMINATOR);
  do_special_lines(COMP_IDX_FOR_B_PT_VIEW, B_PT_VIEW_NUMERATOR,B_PT_VIEW_DENOMINATOR);
  
  do_grh_data_lines(GRH_DATA_IDX_FOR_LOVE);
  do_grh_data_lines(GRH_DATA_IDX_FOR_MONEY);

  do_special_lines(COMP_IDX_FOR_OVERALL,OVERALL_NUMERATOR,OVERALL_DENOMINATOR);

}  /* end of g_make_special_graphs() */


/* for idx 0,1,2,3  for  gGRH_DATA_FOR_COMP[idx][PLUS_OR_MINUS_IDX_FOR_GOOD]
*/
void do_special_lines(int idx, int numer, int denom)  /* for grpdoc */
{
  int num_stars, save_good_stars_for_personal = 0;
  ;
  /* idx   0=overall 1=personal 2=A pt of view  3=B pt of view
  */
  num_stars = abs(gGRH_DATA_FOR_COMP[idx][PLUS_OR_MINUS_IDX_FOR_GOOD]);


  if (idx == 1) {  /* personal */
    /* tn();trn("in do_special_lines()"); */
    save_good_stars_for_personal = num_stars;
    /* trn("raw num_starsGOOD=");ki(save_good_stars_for_personal); */
  }
  num_stars = num_stars * numer / denom;
  num_stars /= (gGRAPH_FACTOR*2);    /* (gGRAPH_FACTOR*2); */
  if (num_stars == 0) num_stars = 1; /*no blank line- at least 1 star*/

  if (idx == COMP_IDX_FOR_PERSONAL)  stars_persn_g = num_stars; 
  if (idx == COMP_IDX_FOR_A_PT_VIEW) stars_aview_g = num_stars;
  if (idx == COMP_IDX_FOR_B_PT_VIEW) stars_bview_g = num_stars;
  if (idx == COMP_IDX_FOR_OVERALL)   stars_ovral_g = num_stars;

  num_stars += abs(gGRH_DATA_FOR_COMP[idx][PLUS_OR_MINUS_IDX_FOR_BAD]);

  /* idx 1 = personal- if group report, calc compatibility score
  */
  if (idx == 1) { /* 1 = personal- if group report, calc compatibility score */

    save_pair_compat_score(   /* <<<-------== */
      save_good_stars_for_personal,  /* good_score */
      num_stars                      /* bad_score */
    );
  } /* end of idx 1 = personal- if group report, calc compatibility score */

  num_stars /= gGRAPH_FACTOR;    /* (gGRAPH_FACTOR*2); */
  if (num_stars == 0) num_stars = 1; /*no blank line- at least 1 star*/

  if (idx == COMP_IDX_FOR_PERSONAL)  stars_persn_b = num_stars; 
  if (idx == COMP_IDX_FOR_A_PT_VIEW) stars_aview_b = num_stars;
  if (idx == COMP_IDX_FOR_B_PT_VIEW) stars_bview_b = num_stars;
  if (idx == COMP_IDX_FOR_OVERALL)   stars_ovral_b = num_stars;

}  /* end of do_special_lines() */


/* in   int global_pair_compatibility_score
*/
void save_pair_compat_score(int good_int, int bad_int) {
  double good_dbl, bad_dbl, tmpdouble, maxgood, maxbad, g_b;

//tn();trn(" in save_pair_compat_score()");
  if (good_int == 0) good_int = 1;
  if (bad_int  == 0) bad_int  = 1;

  if (good_int == 1 && bad_int == 1) {
    global_pair_compatibility_score =  1;
    return;
  }

  maxgood = 4300; 
  maxbad  = 4300; 

  good_dbl = (double)good_int;
  bad_dbl  = (double)bad_int;

  tmpdouble = good_dbl * (1 + good_dbl/maxgood) - (bad_dbl/maxbad);

  g_b = good_dbl/bad_dbl;
  if (g_b > 1.0) tmpdouble = tmpdouble * ( 1 + log(g_b) );

  tmpdouble = tmpdouble / 16.0;  /* reduce number to roughly median 100 */

  if (tmpdouble < 1.0) tmpdouble = 1.0;  /* no zero scores allowed */

  global_pair_compatibility_score =  (int) tmpdouble;

//kin(global_pair_compatibility_score);

}  /* end of  save_pair_compat_score(); */


/* only 2- love money */
void do_grh_data_lines(int idx)   
{
  int num_stars;
  ;
  num_stars  = abs(gGRH_DATA[idx][PLUS_OR_MINUS_IDX_FOR_GOOD]);
  num_stars /= gGRAPH_FACTOR;    /* (gGRAPH_FACTOR*2); */
  if (num_stars == 0) num_stars = 1; /*no blank line- at least 1 star*/

  if (idx == GRH_DATA_IDX_FOR_LOVE)   stars_love_g  = num_stars;
  if (idx == GRH_DATA_IDX_FOR_MONEY)  stars_money_g = num_stars;
  /* g_mk_grh_line(num_stars,PLUS_OR_MINUS_IDX_FOR_GOOD); */

  num_stars += abs(gGRH_DATA[idx][PLUS_OR_MINUS_IDX_FOR_BAD]);
  num_stars /= gGRAPH_FACTOR;    /* (gGRAPH_FACTOR*2); */
  if (num_stars == 0) num_stars = 1; /*no blank line- at least 1 star*/

  if (idx == GRH_DATA_IDX_FOR_LOVE)   stars_love_b  = num_stars;
  if (idx == GRH_DATA_IDX_FOR_MONEY)  stars_money_b = num_stars;
  /* g_mk_grh_line(num_stars,PLUS_OR_MINUS_IDX_FOR_BAD); */

}  /* end of do_grh_data_lines() */

void g_mk_grh_line(int num_stars, int g_or_b)
{
  char sformat[20];
  char s[SIZE_GRH_LINE+1];
  ;
  if (num_stars >  (MAX_STARS -1)) {
    g_wrap_grh_line(num_stars,g_or_b);
    return;
  } else {
    sfill(s,num_stars,GRH_CHAR);

    /* send thru "easy"/"difficult" labels as flags even though
    *  they are not printed out now  (aug 2013)
    */
    sprintf(sformat,"|%%12s %%-%ds|\n",(MAX_STARS -1)+2); /*"|%11s %-100s|\n"); */
    gdocn = sprintf(gdocp,sformat,(g_or_b)?"difficult":"easy",s);

    /* #define PLUS_OR_MINUS_IDX_FOR_GOOD 0 */
    /* #define PLUS_OR_MINUS_IDX_FOR_BAD 1 */
/* tn();b(200);ks(gdocp);tn(); */
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_GOOD) scharswitch(gdocp, '*', '+'); 
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_BAD ) scharswitch(gdocp, '*', '-'); 
/* tn();b(201);ks(gdocp);tn(); */

    g_docin_put(gdocp, gdocn);

    return;
  }
}  /* end of g_mk_grh_line() */

void g_wrap_grh_line(int num_stars, int g_or_b)
{
  char s[SIZE_GRH_LINE+1];
  char sformat[20];
  int i,last_line_stars;
  ;
  sfill(s,(MAX_STARS -1),GRH_CHAR);
/* kin(num_stars);ki(g_or_b); */

  sprintf(sformat,"|%%12s %%%ds  |\n",(MAX_STARS -1)); /* "|%11s %-100s|\n"); */
  gdocn = sprintf(gdocp, sformat,(g_or_b)?"difficult":"easy",s);

/* tn();b(210);ks(gdocp);tn(); */
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_GOOD) scharswitch(gdocp, '*', '+'); 
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_BAD ) scharswitch(gdocp, '*', '-'); 
/* tn();b(211);ks(gdocp);tn(); */

  g_docin_put(gdocp, gdocn);

  /* prt all full lines after 1st
  */
  for (i=2; i <= num_stars/(MAX_STARS -1); ++i) {
    gdocn = sprintf(gdocp, sformat,"",s);

/* tn();b(220);ks(gdocp);tn(); */
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_GOOD) scharswitch(gdocp, '*', '+'); 
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_BAD ) scharswitch(gdocp, '*', '-'); 
/* tn();b(221);ks(gdocp);tn(); */

    g_docin_put(gdocp, gdocn);
  }

  if ((last_line_stars = (num_stars % (MAX_STARS -1))) == 0) return;

  sfill(s,last_line_stars,GRH_CHAR);

//  sprintf(sformat,"|%%12s %%%ds  |\n",(MAX_STARS -1));
//  sprintf(sformat,"|%%12s %%%ds z|\n",(MAX_STARS -1)); 
    sprintf(sformat,"|%%12s %%%dsqx|\n",(MAX_STARS -1));    // weird fix
  gdocn = sprintf(gdocp, sformat,"",s);

/* tn();b(230);ks(gdocp);tn(); */
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_GOOD) scharswitch(gdocp, '*', '+'); 
    if (g_or_b == PLUS_OR_MINUS_IDX_FOR_BAD ) scharswitch(gdocp, '*', '-'); 
/* tn();b(231);ks(gdocp);tn(); */

  g_docin_put(gdocp, gdocn);

}  /* end of g_wrap_grh_line() */


void store_sgn_and_hse_placements_1(void)
{
  int i;
  ;
  for (i=1; i <= NUM_PLANETS; ++i) {
    gAR_SGN_1[i] = g_get_sign(ar_minutes_natal_1[i]);
    gAR_HSE_1[i] = g_get_house(ar_minutes_natal_1[i],ar_minutes_natal_1[13]);
  }
}  /* end of store_sgn_and_hse_placements_1() */

void store_sgn_and_hse_placements_2(void)
{
  int i;
  ;
  for (i=1; i <= NUM_PLANETS; ++i) {
    gAR_SGN_2[i] = g_get_sign(ar_minutes_natal_2[i]);
    gAR_HSE_2[i] = g_get_house(ar_minutes_natal_2[i],ar_minutes_natal_2[13]);
  }
}  /* end of store_sgn_and_hse_placements_2() */

void store_comp_aspects(void)
{
//tn();ksn("store_comp_aspects");tn();
  int i,k, isasp;  /* i=1st plt, k=2nd plt */
  double orb_double;          // 0.0 --> 1.0
  int    orb_int_0_1000;  // 0 --> 1000
  int    orb_int_1_25;    // 1 --> 25   (number of pluses or minuses)

  int    myAspectID;      // 0 -> 8
                          //   int gASPECT_ID[NUM_ASPECTS+1] =
                          //                {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9};
                          //           /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
                          //         /* degrees  x  0  60   90   120   180   240   270   300  360 */

  int    myAspectType;    // 0 cnj, 1 good, 2 bad
                          //   int gASPECT_TYPE[NUM_ASPECTS+1] =
                          //               {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0};
                          //    /* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */

  int    myAspectSign;  // +1 or -1
  int    myAspectExpressionVal;      // -25 -> +25 but no zero
  ;
  RKDO(i,1,NUM_PLANETS) {

    RKDO(k,1,NUM_PLANETS) {

      isasp = g_isaspect(    // in here, function g_isaspect(),  gCURRENT_ASPECT_FORCE (gbl) is calculated.
        ar_minutes_natal_1[i],
        ar_minutes_natal_2[k],
        &gORBS_NAT[0] );
      gAR_ASP[i][k] = isasp;

      //<.>
      // data DUMP here from grpdoc.h
      // 
      //            /* trn orbs all 2 degrees */
      //            int gORBS_TRN[NUM_ASPECTS+1] = {0,120,120,120,120,120,120,120,120,120};
      //            int gORBS_NAT[NUM_ASPECTS+1] = {0,360,240,360,360,360,360,360,240,360};
      //            int gASPECT_ID[NUM_ASPECTS+1] =
      //                         {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9};
      //                    /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
      //                  /* degrees  x  0  60   90   120   180   240   270   300  360 */
      //            int gASPECT_TYPE[NUM_ASPECTS+1] =
      //                        {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0};
      //             /* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */
      //            int gASPECTS[NUM_ASPECTS+1]=
      //                          {-1,  0,3600,5400,7200,10800,14400,16200,18000,21600};
      //
      if (isasp != 0) {

//
//// for test
//
//tn();
//if (isasp != 0) {
//  char plt1[8], plt2[8],myasp[8], myshow[128];
////ki(i);ki(k);ki(gAR_ASP[i][k]);
// strcpy(plt1,  gN_PLANET[i]);
// strcpy(myasp, gN_ASPECT[ gAR_ASP[i][k] ]); 
// strcpy(plt2,  gN_PLANET[k]);
// sprintf(myshow, "%s %s %s", plt1, myasp, plt2);
//ks(myshow);
////kdn(gCURRENT_ASPECT_FORCE);
//}
////for test
//


        //  capture orb here  (for htm para  red/green  for each aspect)
        //  we want to map the orb double(0.000 --> 1.000) to int(1 --> 25) (for influence expression graph)
        //
        orb_double = gCURRENT_ASPECT_FORCE - BASE_CURRENT_ASPECT_FORCE; // 1.0< gCURRENT_ASPECT_FORCE <2.0, also BASE_CURRENT_ASPECT_FORCE = 1
        orb_int_0_1000 = (int) (orb_double * 1000);
        orb_int_1_25   = orb_int_0_1000 / (1000/25) + 1 ; // from 1000, 25 pluses or minuses,  each section is size 40 (1000/25)
//ki(orb_int_0_1000);
//kin(orb_int_1_25);
        //gCURRENT_ASPECT_FORCE = BASE_CURRENT_ASPECT_FORCE +  sin(gPI_OVER_2*(orb-diff_from_exact)/orb); 

        //  capture sign of aspect (plus or minus) here  (for htm para  red/green  for each aspect)
        //
        // default to positive  (yes, it's minus one)
//        myAspectSign = 1;

        myAspectID = gAR_ASP[i][k];              // 1 -> 8 see above 
//ki(myAspectID);

        myAspectType = gASPECT_TYPE[myAspectID]; //  aspect_type  0=cnj, 1=good, 2=bad 
//kin(myAspectType);

        if (myAspectType == ASPECT_TYPE_IDX_FOR_UNFVR) {
          myAspectSign = -1;
//ki(myAspectSign);trn("#BAD");
        } else  if (myAspectType == ASPECT_TYPE_IDX_FOR_CNJ) {
          myAspectSign = gNEG_CNJ_TBL[i - 1][k - 1];               //  E.G.  temp *= gNEG_CNJ_TBL[plt1-1][plt2-1];
//ki(myAspectSign);trn("#CNJ #1");
          if (myAspectSign == 0) {
          myAspectSign = gNEG_CNJ_TBL[k -1][i - 1];
//ki(myAspectSign);trn("#CNJ #2");
          }
        } else  {
          myAspectSign = 1;  // good
//ki(myAspectSign);trn("#GOOD");
        }
//        myAspectSign = myAspectSign * -1;  // historical probably (old stress graph)
//tn();ki(myAspectSign);trn("#4");

        myAspectExpressionVal = myAspectSign * orb_int_1_25; // -25 -> +25 (nozero) num minuses or pluses below each aspect para (negative=red, positive-green)

//tn();ki(i);ki(k);kin(myAspectExpressionVal);
//tn();tr("store expressionval in gEXPRESSION_1_25[i][k]");ki(i);ki(k);

        gEXPRESSION_1_25[i][k] = myAspectExpressionVal;

//int myworki; myworki = gEXPRESSION_1_25[i][k] ; // for test
//kin(myworki);
//<.>

      } // if isasp is true

    } //  RKDO(i,1,NUM_PLANETS) 

  } //    RKDO(k,1,NUM_PLANETS) 

//tn();
}  /* end of store_comp_aspects() */

void g_add_all_asps_to_grh_data(void)
{
  int i,k;  /* i=1st plt, k=2nd plt */
  ;
  RKDO(i,1,NUM_PLANETS) {
    RKDO(k,1,NUM_PLANETS) {
      if (gAR_ASP[i][k] != 0) 
        g_add_an_asp_to_grh_data(i,k,gAR_ASP[i][k]);
    }
  }
}  /* end of g_add_all_asps_to_grh_data() */

/* note: gAR_SGN & hse tbls must have been filled in before */
void g_add_an_asp_to_grh_data(int plt1, int plt2, int aspect_num)
{        /* note: assumes confidence=1 or 2, not 3 */
  int i,addval;
  double a,b,c,d,e;
  ;
/* tn(); tn(); trn("in g_add_an_asp_to_grh_data()"); */
/* tn(); ki(plt1);ki(plt2);ki(aspect_num); */
/* tn(); */
  gPLT_HAS_ASP_TBL[plt1] = Yes;
  gPLT_HAS_ASP_TBL[plt2] = Yes;



  for (i=0; i <= TOT_CATEGORIES-1; ++i) { /* 2 - love,money */

/* tn();trn("CATEGORY");ki(i); */
    a = (double)
      (gSGN_OVER_HSE_FACTOR*get_plt_in_12(plt1-1,gAR_SGN_1[plt1]-1,i));
/* kdn(a); */

    if (gHOUSE_CONFIDENCE[IDX_FOR_A] == No) {
      b = a / gSGN_OVER_HSE_FACTOR;
    } else {
      b = (double)gCONSIDER_HOUSE_FACTOR[i]*
                  get_plt_in_12(plt1-1,gAR_HSE_1[plt1]-1,i);
    }
/* kdn(b); */

    c = (double)
      (gSGN_OVER_HSE_FACTOR*get_plt_in_12(plt2-1,gAR_SGN_2[plt2]-1,i));
/* kdn(c); */

    if (gHOUSE_CONFIDENCE[IDX_FOR_B] == No) {
      d=c/gSGN_OVER_HSE_FACTOR;
    } else {
      d = (double)gCONSIDER_HOUSE_FACTOR[i]*
                  get_plt_in_12(plt2-1,gAR_HSE_2[plt2]-1,i);
    }
/* kdn(d); */

    e = g_get_aspect_multiplier(gASPECT_TYPE[aspect_num],plt1,plt2,i); // here plus or minus for addval is set
/* kdn(e); */

/* <> */
    if (aspect_num == 5 &&               /* opposition */
      RKISBETWEEN(plt1,SUN_IDX,VEN_IDX)  &&  /* both sun->ven */
      RKISBETWEEN(plt2,SUN_IDX,VEN_IDX))
    {
      e = e * -1;      /* make favourable */
    }
/* kdn(e); */
/* <> */

    addval = (int) (gCURRENT_ASPECT_FORCE*e*(sqrt(a*a+b*b)+sqrt(c*c+d*d)));
/* trn("plain");kd(addval); */
    adjust_addval(&addval,plt1,plt2);
/* trn("quadrant adjusted");kd(addval); */

/* trn("grh_data before"); */
    if (addval >  0) {
      gGRH_DATA[i][PLUS_OR_MINUS_IDX_FOR_GOOD] += addval;
    } else {
      gGRH_DATA[i][PLUS_OR_MINUS_IDX_FOR_BAD] -=   /* -= addval <0 */
        addval*gLESSON_MULTIPLIER;
    }
    put_comp_stuff(plt1,plt2,addval);
  }
}  /* end of g_add_an_asp_to_grh_data() */

void adjust_addval(int *paddval, int plt1, int plt2)
{
  int is_plt1_personal,is_plt2_personal,factor;
  ;
  is_plt1_personal = (RKISBETWEEN(plt1,SUN_IDX,MAR_IDX)? Yes:No);
  is_plt2_personal = (RKISBETWEEN(plt2,SUN_IDX,MAR_IDX)? Yes:No);
  if (is_plt1_personal) {
    if (is_plt2_personal) {
      factor = QUADRANT_NW_FACTOR;
    } else {
      factor = QUADRANT_NE_FACTOR;
    }
  } else {
    if (is_plt2_personal) {
      factor = QUADRANT_SW_FACTOR;
    } else {
      factor = QUADRANT_SE_FACTOR;
    }
  }
  *paddval *= factor;
}  /* end of adjust_addval() */


int g_get_aspect_multiplier(int aspect_type, int plt1, int plt2, int category_num)
{    /* using for now 1 aspect_type, neg for unfvr aspects + some cnj */
  int plt_pairs_idx,temp;
  ;
  plt_pairs_idx = gPLT_PAIRS_IDX_TBL[plt1-1][plt2-1];
/*******
*   temp = *(gASPECT_MULTIPLIER
*     +   aspect_type * (TOT_CATEGORIES) * NUM_PLT_PAIRS
*     + plt_pairs_idx * (TOT_CATEGORIES)
*     + category_num);
********/
  temp = *(gASPECT_MULTIPLIER
    +             0 * (TOT_CATEGORIES)* NUM_PLT_PAIRS
    + plt_pairs_idx * (TOT_CATEGORIES)
    + category_num);
  if (aspect_type == ASPECT_TYPE_IDX_FOR_UNFVR) temp *= (-1);
  if (aspect_type == ASPECT_TYPE_IDX_FOR_CNJ) {
    temp *= gNEG_CNJ_TBL[plt1-1][plt2-1];
  }
  return(temp);
}  /* end of g_get_aspect_multiplier() */

/******
* gGRH_DATA_FOR_COMP[X][Y] indexes  [X]        [Y]
*                                   0 overall   0 easy
*                                   1 personal  0 difficult
*                                   2 A pt of view
*                                   3 B pt of view
******/
void put_comp_stuff(int plt1, int plt2, int addval)
{
  int is_plt1_personal,is_plt2_personal;
  ;
  add_to_comp_specials(COMP_IDX_FOR_OVERALL,addval);
  is_plt1_personal = (RKISBETWEEN(plt1,SUN_IDX,MAR_IDX)? Yes:No);
  is_plt2_personal = (RKISBETWEEN(plt2,SUN_IDX,MAR_IDX)? Yes:No);
  if (is_plt1_personal && is_plt2_personal) {

/* tn();trn("in add_asp_to_grh_data() > put_comp_stuffPERSNL"); */
/* kin(addval);ki(plt1);ki(plt2);tn(); */

    add_to_comp_specials(COMP_IDX_FOR_PERSONAL,addval);
  }
  if (is_plt1_personal)
    add_to_comp_specials(COMP_IDX_FOR_A_PT_VIEW,addval);
  if (is_plt2_personal)
    add_to_comp_specials(COMP_IDX_FOR_B_PT_VIEW,addval);
}  /* end of put_comp_stuff() */

void add_to_comp_specials(int idx, int addval)
{
  if (addval >  0) {
    gGRH_DATA_FOR_COMP[idx][PLUS_OR_MINUS_IDX_FOR_GOOD]
    += addval;
  } else {
    gGRH_DATA_FOR_COMP[idx][PLUS_OR_MINUS_IDX_FOR_BAD]
    -= addval*gLESSON_MULTIPLIER;
  }
}  /* end of add_to_comp_specials()*/


void init_grh_datas(void)
{
  int i,k;
  ;
  for (i=0; i <= TOT_CATEGORIES-1; ++i) {
    for (k=0; k <= NUM_PLUS_OR_MINUS_CATEGORIES-1; ++k) {
      gGRH_DATA[i][k] = 0;
    }
  }
  for (i=0; i <= NUM_COMP_CATEGORIES-1; ++i) {
    for (k=0; k <= NUM_PLUS_OR_MINUS_CATEGORIES-1; ++k) {
      gGRH_DATA_FOR_COMP[i][k] = 0;
    }
  }
}  /* end of init_grh_datas() */



/* position in minutes of planets 1 and 2 */
/* ptr to ints (table of orbs) */
int g_isaspect(int m1, int m2, int *porbs)
{
  int i,itemp;
  ;
  itemp = abs(m1-m2);
  for (i=1; i <= NUM_ASPECTS; ++i) {
    if (itemp >  (*(gASPECTS+i) + *(porbs+i))) continue;  
    if (itemp <  (*(gASPECTS+i) - *(porbs+i))) return(0);  /* no aspect */
    g_calc_current_aspect_force(m1,m2,porbs,i);
    return(gASPECT_ID[i]);  /* found aspect */
  }
  return(0);    /* return of zero means no aspect found */
} 


/* m1= position of plt1 in minutes */
void g_calc_current_aspect_force(int m1, int m2, int *porbs, int aspect_num)
{
  double orb,diff_from_exact;
  ;
  orb = (double)*(porbs+aspect_num);
  diff_from_exact = (double)abs(gASPECTS[aspect_num]-abs(m1-m2));

//  gCURRENT_ASPECT_FORCE = BASE_CURRENT_ASPECT_FORCE +  /* 1.0< force <2.0 */
//    sin(gPI_OVER_2*(orb-diff_from_exact)/orb);

  gCURRENT_ASPECT_FORCE = BASE_CURRENT_ASPECT_FORCE +  sin(gPI_OVER_2*(orb-diff_from_exact)/orb); /* 1.0< gCURRENT_ASPECT_FORCE <2.0 */


// not here gAR_ASP_ORB[m1][m2]  =  sin(gPI_OVER_2*(orb-diff_from_exact)/orb); // corresponding orb for the above aspect


}  /* end of g_calc_current_aspect_force() */

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* int start_up(void)
* {
* /*   if (get_fut_input(gARG_FUTIN_PATHNAME) == Not_found) return(Not_found); */
*     /* return val Found (1) = ok (not eof) */
*   if (rkequal(gCOMPATABILITY_LINE,"") || rkequal(gCOMPATABILITY_LINE," "))
*     return Not_found;
* 
* /***
*   gPI_OVER_2 = dpie() / 2.0;
* ***/
*   gPI_OVER_2 = 3.1415926535897932384 / 2.0;
* 
*   set_confidence(IDX_FOR_A);  /* for a, not b */
*   return(Found);    /* not eof */
* }  /* end of start_up() */
* 
* void set_confidence(int a_or_b)
* {
*   if (gINCF == 1) {      /* 1=less than 1/2 hr wrong */
*     gHOUSE_CONFIDENCE[a_or_b] = Yes;
*     gMOON_CONFIDENCE[a_or_b] = Yes;
*     gMOON_CONFIDENCE_FACTOR = 1.0;  /* for moon_cf = yes, very accurate */
*   }
*   if (gINCF == 2) {      /* 2=between 1/2 hr and 2 hr wrong */
*     gHOUSE_CONFIDENCE[a_or_b] = No;
*     gMOON_CONFIDENCE[a_or_b] = Yes;
*     gMOON_CONFIDENCE_FACTOR = 1.0;  /* for moon_cf = yes, very accurate */
*   }
*   if (gINCF == 3) {      /* 3=completely uncertain time of day */
*     gHOUSE_CONFIDENCE[a_or_b] = No;
*     gMOON_CONFIDENCE[a_or_b] = No;
*     gMOON_CONFIDENCE_FACTOR = MOON_REPLACEMENT_FACTOR;
*   }
* }  /* end of set_confidence() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* puts positions in minutes 0 thru 360*60-1 into a planet position table */
/* ptr to ints (position table #1 or #2) */
/* void g_put_minutes(int *pi, char *p_retro_tbl[]) */
void g_put_minutes(int *pi)
{
  int i;
  ;
  *(pi+1) = g_get_minutes(Arco[1]);    /* sun */
  *(pi+2) = g_get_minutes(Arco[10]);  /* moon */
  for (i=3; i <= NUM_PLANETS; ++i) {  /* 3->10 (mer->plu) */
    *(pi+i) = g_get_minutes(Arco[i-1]);
  }
  *(pi+11) = g_get_minutes(Arco[11]);  /* nod */
  *(pi+12) = g_get_minutes(Arco[12]);  /* asc */
  *(pi+13) = g_get_minutes(Arco[13]);  /* mc_ */
  ;
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   strcpy(*(p_retro_tbl+1),retro[1]);  /* these array elements are strings */
*   strcpy(*(p_retro_tbl+2),retro[10]);  /* moon */
*   for (i=3; i <= NUM_PLANETS; ++i) {  /* 3->10 */
*     strcpy(*(p_retro_tbl+i),retro[i-1]);
*   }
*   strcpy(*(p_retro_tbl+11),retro[11]);
*   strcpy(*(p_retro_tbl+12),retro[12]);
*   strcpy(*(p_retro_tbl+13),retro[13]);
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
}  /* end of g_put_minutes() */

int g_get_minutes(double d)
{
/***
* return((int)round(60.0 * fnu(fnd(d) + 360.0)));  * converted to int *
***/
  return((int)ceil(60.0 * fnu(fnd(d) + 360.0)));  /* converted to int */
} 



void fill_A_position_strings(void)
{
  static int mytimesthroo;
  int i,sign,min_in_sign,deg_in_sign,min_in_deg;
  if (mytimesthroo > 0) return;
  mytimesthroo++;
//tn();trn("person AAA");
  
  for (i=1; i <= NUM_PLANETS +3; ++i) {
    sign = g_get_sign(ar_minutes_natal_1[i]);
    min_in_sign = ar_minutes_natal_1[i] - (sign-1)*30*60;
    deg_in_sign = min_in_sign/60;
    min_in_deg  = min_in_sign - 60*deg_in_sign;
    sprintf(gPOS_STR_1+i*(11+1),"%s%s%02d%s%02d",
      gN_PLANET[i],    "_"        ,deg_in_sign,gN_SIGN[sign],min_in_deg);
/*       N_PLANET[i],gPRT_RETRO_1[i],deg_in_sign,gN_SIGN[sign],min_in_deg); */
//ksn(gPOS_STR_1+i*(11+1));
  }
} 

void fill_B_position_strings(void)
{
  static int mytimesthroo;
  int i,sign,min_in_sign,deg_in_sign,min_in_deg;
  if (mytimesthroo > 0) return;
  mytimesthroo++;
//tn();trn("person BBB");
  ;
  for (i=1; i <= NUM_PLANETS +3; ++i) {
    sign = g_get_sign(ar_minutes_natal_2[i]);
    min_in_sign = ar_minutes_natal_2[i] - (sign-1)*30*60;
    deg_in_sign = min_in_sign/60;
    min_in_deg  = min_in_sign - 60*deg_in_sign;
    sprintf(gPOS_STR_2+i*(11+1),"%s%s%02d%s%02d",
      gN_PLANET[i],    "_"        ,deg_in_sign,gN_SIGN[sign],min_in_deg);
/*       N_PLANET[i],gPRT_RETRO_2[i],deg_in_sign,gN_SIGN[sign],min_in_deg); */
//ksn(gPOS_STR_2+i*(11+1));
  }
}


int g_get_sign(int minutes)
{
  return((int)floor((minutes/60.0)/30.0)+1);
}  /* end of g_get_sign() */

/* mc in minutes */
int g_get_house(int minutes, int mc)
{
  int asc;
  ;
  asc = mc + 90*60;
  if (asc >= NUM_MINUTES_IN_CIRCLE) asc = asc - NUM_MINUTES_IN_CIRCLE;
  if (minutes >= asc)  return(g_get_sign(minutes-asc));
  else  return(g_get_sign((NUM_MINUTES_IN_CIRCLE-asc)+minutes));
}  /* end of g_get_house() */

/* end of grpdoc.c */
