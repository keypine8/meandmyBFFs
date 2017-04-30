/* incocoa.c  */
/*  calling mambutil.c routines */

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

// #include "incocoa.h"

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/


#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#include "rkdebug_externs.h"
#include "rk.h"
#include <time.h>
#include <sys/time.h>

/* these are in rkdebug.o */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);



/* PLACE functions  */
/* city  prov  coun */

#define MAX_IN_PLACES_SEARCH_RESULTS1 25    /* num returned on search into array */

/* #define PREFIX_HTML_FILENAME "am_" */   /* Astrology by Measurement */
/* #define PREFIX_HTML_FILENAME "mamb_"*/  /* Me and my BFFs */ 
#define PREFIX_HTML_FILENAME "m_"          /* Me and my BFFs */ 


char *set_cell_bg_color(int in_score) ;

struct my_place_fields  *gbl_search_results1[MAX_IN_PLACES_SEARCH_RESULTS1];

int gblIdxLastResultsAdded;  /*  index of the last place written in gbl_search_results1 */
int gbl_is_first_results1_put; /* 1=y, 0=n */
int gbl_num_cities_found;
int gbl_num_provinces_found;
int gbl_num_countries_found;
void places_result1_put(struct my_place_fields place_struct);
void places_result1_free(void);
int  get_results1_using_city(char  *city_begins_with);
char *get_first_city_name(char *city_begins_with);

int possiblyGetSearchResults1( /* into gbl_search_results1[] */
                                  /* and gblIdxLastResultsAdded */
  char *city_begins_with,
  int  starting_index_into_cities,
  int  max_in_places_search_results1   /* 10 */
);



/* end of PLACE functions  */

char gbl_hdr_1[512];
char gbl_hdr_2[512];


void get_mbrs_from(char *grpmbr_file, int *num_in_grp);
void csv_person_put(char *str, int length);
void csv_person_free(void); 

void rpt1_personality(     /* personality */
  char *csv_person_string  /* like   "elena,5,17,1984,7,52,1,-2,-25.44" */
);
void rpt2_year_in_the_life(/* calendar year */
  char *csv_person_string,
  char *yyyy_todo
);
void rpt3_just_2_people(   /* Compatibility paired with ... */
   char *csv_person_A, 
   char *csv_person_B
);
void rpt4_whole_group(     /* Best Match */
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp
);
void rpt5_person_in_group( /* Best Match for ... */
  char *group_name,
  char *mamb_csv_arr[],
  int   num_in_grp,
  char *csv_compare_everyone_with
);
void rpt6_group_top_bottom(/* best match > 300 lines */
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp,
  int  top_this_many,
  int  bottom_this_many
);
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void rpt7_avg_scores(      /* Most Compatible */
*   char *group_name,
*   char *mamb_csv_arr[],
*   int  num_in_grp
* );
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
void rpt8_trait_rank(      /* Most Assertive     Person */
  char *group_name,        /* Most Emotional     Person */
  char *mamb_csv_arr[],    /* Most Restless      Person */
  int  num_in_grp,         /* Most Down-to-earth Person */
  char *trait_name         /* Most Passionate    Person */
);                         /* Most Ups and Downs */
                           

void rpt9_best_year(       /* Best Calendar Year ... */
  char *group_name, 
  char *mamb_csv_arr[],
  int  num_in_grp,    
  char *yyyy_todo    
);                  

void rpt10_best_day(       /* Best Calendar Day ... */
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp,
  char *yyyymmdd_todo
);
void rpt11_calendar_day(   /* Calendar Day ... */
  char *csv_person_string,
  char *yyyymmdd_todo
);

#define MAX_SIZE_PERSON_NAME  15



/* trait_report_line array declarations
*/
struct trait_report_line {
  int  rank_in_group;
  int  score;
  char person_name[MAX_SIZE_PERSON_NAME+1];
};

/* rank_report_line array declarations
*/
struct rank_report_line {      /* info for html file production */
  int  rank_in_group;
  int  score;
  char person_A[MAX_SIZE_PERSON_NAME+1];
  char person_B[MAX_SIZE_PERSON_NAME+1];
};
struct cocoa_rank {            /* info for cocoa table display */
  char cocoa_rank_color[6] ;   /* like "cGre", "cRe2" ... */
  char cocoa_rank_string[48] ; /* like "  1  Anya_   Liz_       99       "  */
                               /* like "                        90  Great"  */
};



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* new report_line structs with color and text of line
* */
* struct person_report_line {   /* for "trait" scores */
*   char person_color[6];   /* like "cGre" "cGr2" "cNeu"  etc. */
*   char person_line;  /* includes ranknum, name, score, benchmark label */
* };
* struct pair_report_line {   /* for compatibility of 2 people scores */
*   char pair_color[6];   /* like "cGre" "cGr2" "cNeu"  etc. */
*   char pair_line;  /* includes ranknum, name1, name2, score, benchmark label */
* };
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/



/* Define the array of ranking report line data.
*   *****  NOTE not all of these lines go into html rpt - only top "200/bot 100"
*   (Rank  Score  person_a  person_b)
*
*   assuming MAX_PERSONS_IN_GROUP = 250, num pairs max is  31,125 
*   (5 sec to run on pc/gcc , 1 sec on mac/llvm )
*/
// #define MAX_PERSONS_IN_GROUP 250  /* also defined in grpdoc.c and grphtm.c */
#define MAX_PERSONS_IN_GROUP 200  /* also defined in grpdoc.c and grphtm.c */
#define MAX_IN_RANK_LINE_ARRAY \
( ( (MAX_PERSONS_IN_GROUP * (MAX_PERSONS_IN_GROUP - 1) / 2) ) + 64 )
struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
int out_rank_idx;  /* pts to current line in out_rank_lines */
/* end of rank_report_line array declarations */


/* LIMITS
*
* 1 Group Size LIMIT is 200.       MAX_PERSONS_IN_GROUP 200 
*    (based on time to calc and space to store 31,125 structs)
* 
* 2. group report html line count LIMIT 
*    for rpt "best match in group" 
*      the num of pairs can go to 31,125 rpt lines, so
*      limit these to  (top 200 / bot 100)
* 
*      IF group size > 25   (300 pairs, 300 data lines)
*        DO THIS rpt6_group_top_bottom()
*/
#define NUM_IN_GROUP_TO_TRIGGER_TOP_BOT 25 



struct trait_report_line *out_trait_lines[MAX_IN_RANK_LINE_ARRAY];
int out_trait_idx;  /* pts to current line in out_trait_lines */

struct avg_report_line {
  int  rank_in_group;
  int  avg_score;
  char person_name[MAX_SIZE_PERSON_NAME+1];
/*  char hex_color[8]; */  /* like "66ff33" */
};
struct avg_report_line *out_avg_lines[MAX_PERSONS_IN_GROUP];
int out_avg_idx;  /* pts to current line in out_avg_lines */


char *csv_person_array[MAX_PERSONS_IN_GROUP];
int   csv_person_idx;
char  csv_person_errbuf[256];
char  csvbuf[64];
int   csvlen;
int   is_first_mamb_csv_person_put;   /* 1=yes, 0=no */


/* NOTE: best year report uses a lot of "trait" structure
*/
extern int mamb_report_best_day(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyymmdd_todo, 
  struct trait_report_line *trait_lines[],   /* array of output report data */
  int  *trait_idx            /* ptr to int having last index written */                   
);
/* ----------------------------------------------------------- */
extern int mamb_report_best_year(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyy_todo, 
  struct trait_report_line *trait_lines[],   /* array of output report data */
  int  *trait_idx            /* ptr to int having last index written */                   
);
/* ----------------------------------------------------------- */

extern int mamb_report_trait_rank(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *trait_name,
/*   struct rank_report_line *rank_lines[],  */
/*   int  *rank_idx, */
  struct trait_report_line *trait_lines[],   /* array of output report data */
  int  *trait_idx            /* ptr to int having last index written */                   
);
extern int make_html_file_trait_rank( /* in grphtm.c */
  char *group_name,
  int   num_persons_in_grp,
  char *trait_name,
  char *in_html_filename,           /* in grphtm.c */
  struct trait_report_line  *in_trait_lines[],
  int   in_trait_lines_last_idx,
  char *gblGrpAvgTraitScoresCSV
);
void g_trait_line_free(
  struct trait_report_line *out_trait_lines[],  /* output param returned */
  int trait_line_last_used_idx
);

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* extern int mamb_report_avg_scores(    /* in grpdoc.c */
*   char *html_file_name,
*   char *group_name,
*   char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
*   int  num_persons_in_grp,
*   struct rank_report_line *rank_lines[], 
*   int  *rank_idx,
*   struct avg_report_line *avg_lines[],   /* array of output report data */
*   int  *avg_idx            /* ptr to int having last index written */                   
* );
* extern int make_html_file_avg_scores( /* in grphtm.c */
*   char *group_name,
*   int   num_persons_in_grp,
*   char *in_html_filename,           /* in grphtm.c */
*   struct avg_report_line  *in_avg_lines[],
*   int   in_avg_lines_last_idx
* );
* extern void g_avg_line_free(
*   struct avg_report_line *out_avg_lines[],  /* output param returned */
*   int avg_line_last_used_idx
* );
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* 1 of 5 */ extern int mamb_report_whole_group(   /* in grpdoc.o */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  struct rank_report_line *rank_lines[],      /* output param returned */
  int  *rank_idx,                             /* output param returned */
  char *instructions,
  char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
);
int make_html_file_whole_group( /* produce actual html file */
  char *group_name,
  int   num_persons_in_grp,
  char *in_html_filename,           /* in grphtm.c */
  struct rank_report_line  *in_rank_lines[],
  int   in_rank_lines_last_idx,
  char *instructions,
  char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
);
extern void g_rank_line_free(
  struct rank_report_line *out_rank_lines[], 
  int rank_line_last_used_idx               
);
void do_a_whole_group_test_case(
  char *html_file_name,
  char *group_name,
  int  num_in_grp
);
/* 2 of 5 */ extern int  mamb_report_person_in_group(  /* in grpdoc.o */ 
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],
  int  num_persons_in_grp,
  char *csv_compare_everyone_with,  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  struct rank_report_line *rank_lines[], /* array of output report data */
  int  *rank_idx           /* ptr to int having last index written */
);
void do_a_person_in_group_test_case(
  char *html_file_name,
  char *group_name,
  int   num_in_grp,
  char *csv_compare_everyone_with
);
/* 3 of 5 */ extern int mamb_report_just_2_people(      /* in grpdoc.o */
  char *html_file_name,
  char *person_1_csv,         /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *person_2_csv
);
/* 4 of 5 */ extern int mamb_report_personality(       /* in perdoc.o */
  char *html_file_name,
  char *csv_person_string,    /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *instructions,  /* like "return only csv with all trait scores",  */
  char *stringBuffForTraitCSV
);
/* 5 of 5 */ extern int mamb_report_year_in_the_life(  /* in futdoc.o */
  char *html_f_file_name,
  char *csv_person_string,    /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *year_todo_yyyy,
  char *instructions,  /* like  "return only year stress score" */
  char *stringBuffForStressScore
);

/* in mambutil.o */
int bin_find_first_city(char *begins_with); /* in gbl_placetab[] */
/* int bin_find_first_begins_with(
*   char **array_of_strings,
*   char *begins_with,
*   int num_elements
* );
*/
extern void scharswitch(char *s, char ch_old, char ch_new);
extern void scharout(char *s,int c); 
extern char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);
extern void sfill(char *s, int num, int c);
/* in mambutil.o */

/* in futasp.o */
extern void mk_new_date(double *pm, double *pd, double *py, double dstep);  
/* in futasp.o */


/* kinds of group report   */
char   group_name[15];
/* ------------------------------------------- */
#define CSV_ARRAY_MAX 512  
char *mamb_csv_arr [CSV_ARRAY_MAX];
int   mamb_csv_idx;
int   mamb_csv_idx_max;
void  mamb_csv_put(char *line, int length);
void  mamb_csv_free(void); 

char  mamb_csv_buf[64];
int   mamb_csv_n;
char *mamb_csv_p = &mamb_csv_buf[0];
int   is_first_mamb_csv_put;    /* 1=yes, 0=no */
int   is_first_mamb_csv_get;    /* 1=yes, 0=no */
/* ------------------------------------------- */


/* From database, "numbers" below are all digit with left-fill of zeros.
* Signed "numbers" have, as first char, " " if positive and "-" if negative.
* SIZEs do not include '\0' at end for strings.
*/
#define SIZE_GROUP_MAX 15
#define SIZE_PERSON_ID  9
#define SIZE_NAME_MAX  15
#define SIZE_MTH        2
#define SIZE_DY         2
#define SIZE_YR         4
#define SIZE_HR12       2
#define SIZE_MINUTE     2
#define SIZE_AM_OR_PM   1  /* "0" am, "1" = pm */
#define SIZE_HRS_DIFF   3  /* from Greenwich   "-12" to "12" */
#define SIZE_LONGITUDE  7  /* "-160.00" to "0.00"  degree.min w=+, e=- */

/*   char p_person_id [SIZE_PERSON_ID + 1]; */
/* struct person {
*   char p_name      [SIZE_NAME      + 1];
*   char p_mth       [SIZE_MTH       + 1];
*   char p_dy        [SIZE_DY        + 1];
*   char p_yr        [SIZE_YR        + 1];
*   char p_hr12      [SIZE_HR12      + 1];
*   char p_minute    [SIZE_MINUTE    + 1];
*   char p_am_or_pm  [SIZE_AM_OR_PM  + 1];
*   char p_hrs_diff  [SIZE_HRS_DIFF  + 1];
*   char p_longitude [SIZE_LONGITUDE + 1];
* };
* 
* struct person p1;
* struct person p2;
*/



void test_year_in_the_life(void);
void test_personality(void);
void test_group(void);

void test_just_2_people(void);
void some_comp_tests(void);


FILE *FP_csvperson;  /* for test group input person csv lines */
FILE *FP_rpt_specs;  /* for test input in one file */
                     /* line fmt= rpt_name1,arg1,arg2,rpt_name2,arg1,... */
FILE *FP_grp_members;  

/* char dir_html_per[]  = "../_html/pero"; */




char dir_html_fut[]    = "../_html/fut";
char dir_html_day[]    = "../_html/day";
char dir_html_per[]    = "../_html/per"; 
char dir_html_grpof2[] = "../_html/grpof2";
char dir_html_grpall[] = "../_html/grpall";
char dir_html_grpone[] = "../_html/grpone";

/* char dir_html_topbot[] = "../_html/topbot"; */
char dir_html_topbot[] = "../_html/grpall";

char dir_html_grpavg[] = "../_html/grpavg";
char dir_html_grptra[] = "../_html/grptra";
char dir_html_grpbyr[] = "../_html/grpbyr";
char dir_html_grpbdy[] = "../_html/grpbdy";



  /* ======================= */
int main_NOT_USED( int argc, char *argv[] )
{
    // char city_begins_with[40];
  /* char prov_begins_with[40]; */
  /* char coun_begins_with[40]; */
  char linebuf[128], csv_person_string[64], yyyy_todo[16], yyyymmdd_todo[16];
  char csv_person_A[64], csv_person_B[64];
  char group_name[32], csv_compare_everyone_with[64], grpmbr_file[64];
  char trait_name[32];
  int  num_in_grp, top_this_many, bot_this_many;

  /* fpdb=stderr; put me in main(). output file for debug code
  */
/*   fpdb         = fopen("t.out","a"); */
/*   fpdb         = stderr; */
  FP_rpt_specs = fopen("incocoa.in", "r"); 
  fopen_fpdb_for_debug();

/* trn("in incocoa.c >main()");  */


/* kin(gbl_num_elements_array_prov); */
/* kin(gbl_num_elements_array_coun); */
/* kin(NKEYS_PLACE); */
/* kin(NKEYS_PLACE); */

/* int tstn;
* tstn = sizeof(char *); kin(tstn);
* tstn = sizeof(int); kin(tstn);
* tstn = sizeof(unsigned int); kin(tstn);
* tstn = sizeof(struct my_place_fields); kin(tstn);
* tstn = sizeof(gbl_placetab); kin(tstn);
* tstn = sizeof(array_prov); kin(tstn);
* tstn = sizeof(array_coun); kin(tstn);
*/


/* test of personality evry 2 days upndn number
*/
/*       int id, iyr;
*       double dmn,ddy,dyr,ddstep;
*       char mycsv[128];
*       dmn = 1.0;  ddy = 1.0;  ddstep = 2.0;
* 
*       for (iyr = 1900; iyr <= 2020; iyr++)  do 120 yrs
*       {
*         dyr = (double)iyr;
*      
*         for (id=0; id <=183; id++) {
*           sprintf(mycsv, "%04d%02d%02d,%d,%d,%d,0,1,1,0,0.0", 
*             (int)dyr, (int)dmn, (int)ddy, (int)dmn, (int)ddy, (int)dyr );
*           rpt1_personality(mycsv);
*           mk_new_date(&dmn,&ddy,&dyr,(double)ddstep);
*         }
*       }
*/


  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  /* Read the instruction file "incocoa.in"
  *  and do the reports in there.
  */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {

/* trn("in while  read spec"); */
    scharout(linebuf, '\n');
/* ksn(linebuf); */
    if (strlen(linebuf) == 0) continue;
    if (linebuf[0] == '"')    continue;  /* comment = " in col 1 */

    if (strcmp(linebuf, "[==end here==]") == 0) {
/* trn("END HERE!"); */
      return(0);
    }
    if (strcmp(linebuf, "[==stop here==]") == 0) {return(0);}


//    if (strcmp(linebuf, "[get_places_w_city]") == 0) {
//      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
//      strcpy(city_begins_with, linebuf);
///* ksn(city_begins_with); */
//
//      gbl_is_first_results1_put = 1; /* set to yes */
//
//
///* code for  timing microseconds */
///* #include <time.h> */
///* #include <sys/time.h> */
//  struct timeval tdbeg, tdend;  long us;
//#define usecdiff(end,beg) ((end.tv_sec*1000000+end.tv_usec) - (beg.tv_sec*1000000 + beg.tv_usec))
//  clock_t beg, end; 
//  beg = clock();
//  gettimeofday(&tdbeg, NULL );
///*  */
///*   for (num=0; num <= 1000000; num++) { */
///*     strcpy(fld1,"junk"); */
///*   } */
///*  */
///*   gettimeofday(&tdend, NULL ); */
///*   end = clock(); */
///*   us = (tdend.tv_sec*1000000+tdend.tv_usec) - (tdbeg.tv_sec*1000000 + tdbeg.tv_usec); */
///*   us = usecdiff(tdend,tdbeg); */
///* kin(us); */
///* end of code for  timing microseconds */
//
//
//
//
//
//
//
//#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
//* /* ABANDONED - sequential is fast enough */
//* /* test int bin_find_first_begins_with(  */
//* char *arrstr[] = {
//* "apr",
//* "apr",
//* "dec",  /* 2 */
//* "feb",
//* "jan",
//* "jul",  /* 5 */
//* "jun",
//* "may",
//* "may",  /* 8 */
//* "may",
//* "mth",
//* "nov",  /* 11 */
//* "sep",
//* "sep"
//* };
//* int tstidx; char tstf[8];
//* 
//* /* tn(); for (int i=0; i < 14; i++) {
//* * ksn(arrstr[i]);
//* * } tn();
//* * strcpy(tstf, "may"); tn(); tn(); tstidx = bin_find_first_begins_with(arrstr, tstf, 14); tn();ksn(tstf); ki(tstidx);
//* * strcpy(tstf, "sep"); tn(); tn(); tstidx = bin_find_first_begins_with(arrstr, tstf, 14); tn();ksn(tstf); ki(tstidx);
//* * strcpy(tstf, "apr"); tn(); tn(); tstidx = bin_find_first_begins_with(arrstr, tstf, 14); tn();ksn(tstf); ki(tstidx);
//* */
//* /* return tstidx; */
//#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
//
//
//
//char first_city_search_results[64];
//int starting_index_into_cities;
//
//  starting_index_into_cities = bin_find_first_city(city_begins_with);
//
///* kin(starting_index_into_cities); */
//if (starting_index_into_cities != -1)  {
//strcpy(first_city_search_results, gbl_placetab[starting_index_into_cities].my_city);
///* ksn(first_city_search_results); */
//}
//
//
//  /* if num cities found is <= arg max_in_places_search_results1,
//  *  puts that many structs in   gbl_search_results1[]    and
//  *  also populates gblIdxLastResultsAdded (places_result1_put() does)
//  * 
//  *  Returns number found  ONLY IF  array gbl_search_results1[] was populated
//  *  otherwise returns -1
//  */
//  gbl_num_cities_found = possiblyGetSearchResults1(
//    city_begins_with,
//    starting_index_into_cities,
//    MAX_IN_PLACES_SEARCH_RESULTS1   /* 10 */
//  );
///* kin(gbl_num_cities_found); */
//
//
//
///* code for  timing microseconds */
//  gettimeofday(&tdend, NULL );
//  end = clock();
//  us = (tdend.tv_sec*1000000+tdend.tv_usec) - (tdbeg.tv_sec*1000000 + tdbeg.tv_usec);
//  us = usecdiff(tdend,tdbeg);
///* kin(us); */
///* end of code for  timing microseconds */
//
//
//
//      /* use gbl_places_search_results1 here
//      */
//
//
//
///* TEST   write all results like file cityall_5_sorted and grep compare */
///* for (int i = 0; i <= NKEYS_PLACE -1; i++) {
//*   fprintf(stderr, "%s|%s|%s|%s|%s\n", 
//*     gbl_placetab[i].my_city,
//*     array_prov[gbl_placetab[i].idx_prov],
//*     array_coun[gbl_placetab[i].idx_coun],
//*     gbl_placetab[i].my_long,
//*     gbl_placetab[i].my_hrs_diff
//*   ); 
//* }
//*/
//
//
//if (gbl_num_cities_found != -1) {
//  for (int i = 0; i <= gblIdxLastResultsAdded; i++) {
//    fprintf(stderr, "%03d>%s>%s>%s>\n", i+1,
//      gbl_search_results1[i]->my_city,
//      array_prov[gbl_search_results1[i]->idx_prov],
//      array_coun[gbl_search_results1[i]->idx_coun]
//    ); 
//  }
//}
//
//
//      /* finished using gbl_places_search_results1 here
//      */
//      places_result1_free();
//      gbl_is_first_results1_put = 1; /* set to yes */
//
//
//    } /* "[get_places_w_city]" */
//

    if (strcmp(linebuf, "[personality]") == 0) {
/* trn("in personality"); */
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(csv_person_string, linebuf);
      rpt1_personality(csv_person_string);
    }

    if (strcmp(linebuf, "[year in the life]") == 0) {
/* trn("in year in life"); */
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(csv_person_string, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(yyyy_todo, linebuf);
      rpt2_year_in_the_life(csv_person_string, yyyy_todo);
    }
    if (strcmp(linebuf, "[calendar day]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(csv_person_string, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(yyyymmdd_todo, linebuf);
      rpt11_calendar_day(csv_person_string, yyyymmdd_todo);
    }

    if (strcmp(linebuf, "[just two people]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(csv_person_A, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(csv_person_B, linebuf);
      rpt3_just_2_people(csv_person_A, csv_person_B);
    }
    if (strcmp(linebuf, "[whole group]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(group_name, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(grpmbr_file, linebuf);

      /* get all members of group into array 
      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
      */
      get_mbrs_from(grpmbr_file, &num_in_grp);

/*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1;  * 1=yes, 0=no *
*       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
*         scharout(linebuf, '\n');
*         if (strcmp(linebuf, "[end of group members]") == 0) break;
*         mamb_csv_put(linebuf, strlen(linebuf));
*         num_in_grp = num_in_grp + 1;
*       }
*/
       
      if (num_in_grp <= 25) {
        rpt4_whole_group(
          group_name,
          mamb_csv_arr,
          num_in_grp
        );
      } else {
        rpt6_group_top_bottom( 
          group_name,
          mamb_csv_arr,
          num_in_grp,
          200,            /* top_this_many, */
          100             /* bot_this_many   */
        );
      }
    }

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*     if (strcmp(linebuf, "[average scores]") == 0) {
*       fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
*       strcpy(group_name, linebuf);
* 
*       /* get all members of group into array 
*       *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
*       */
* /*       num_in_grp = 0;
* *       is_first_mamb_csv_put = 1;  
* *       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
* *         scharout(linebuf, '\n');
* *         if (strcmp(linebuf, "[end of group members]") == 0) break;
* *         mamb_csv_put(linebuf, strlen(linebuf));
* *         num_in_grp = num_in_grp + 1;
* *       }
* */
* 
*       fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
*       strcpy(grpmbr_file, linebuf);
*       get_mbrs_from(grpmbr_file, &num_in_grp);
* 
*       rpt7_avg_scores(
*         group_name,
*         mamb_csv_arr,
*         num_in_grp
*       );
*     }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


    if (strcmp(linebuf, "[one person in group]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(csv_compare_everyone_with, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(group_name, linebuf);

      /* get all members of group into array 
      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
      */
/*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1;
*       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
*         scharout(linebuf, '\n');
*         if (strcmp(linebuf, "[end of group members]") == 0) break;
*         mamb_csv_put(linebuf, strlen(linebuf));
*         num_in_grp = num_in_grp + 1;
*       }
*/

      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(grpmbr_file, linebuf);
      get_mbrs_from(grpmbr_file, &num_in_grp);

      rpt5_person_in_group( 
        group_name,
        mamb_csv_arr,
        num_in_grp,
        csv_compare_everyone_with
      );
    }
    if (strcmp(linebuf, "[top bottom]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(group_name, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      top_this_many = atoi(linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      bot_this_many = atoi(linebuf);

      /* get all members of group into array 
      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
      */
/*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1;
*       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
*         scharout(linebuf, '\n');
*         if (strcmp(linebuf, "[end of group members]") == 0) break;
*         mamb_csv_put(linebuf, strlen(linebuf));
*         num_in_grp = num_in_grp + 1;
*       }
*/

      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(grpmbr_file, linebuf);
      get_mbrs_from(grpmbr_file, &num_in_grp);

      rpt6_group_top_bottom( 
        group_name,
        mamb_csv_arr,
        num_in_grp,
        top_this_many,

        bot_this_many
      );
    }


    if (strcmp(linebuf, "[trait ranking]") == 0) {
/* tn();trn("incocoa.c  trait ranking"); */
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(group_name, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(trait_name, linebuf);
      /* get all members of group into array 
      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
      */
/*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1; 
*       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
*         scharout(linebuf, '\n');
*         if (strcmp(linebuf, "[end of group members]") == 0) break;
*         mamb_csv_put(linebuf, strlen(linebuf));
*         num_in_grp = num_in_grp + 1;
*       }
*/

      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(grpmbr_file, linebuf);
      get_mbrs_from(grpmbr_file, &num_in_grp);

/* test of world twin every 2 days
*/
/*       int id;
*       double dmn,ddy,dyr,ddstep;
*       char mycsv[128];
*       dmn = 1.0;  ddy = 1.0;  dyr = 1958.0; ddstep = 2.0;
*      
*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1; 
*       for (id=0; id <=185; id++) {
*         sprintf(mycsv, "%04d%02d%02d,%d,%d,%d,0,1,1,0,0.0", 
*           (int)dyr, (int)dmn, (int)ddy, (int)dmn, (int)ddy, (int)dyr );
*         mamb_csv_put(mycsv, strlen(mycsv));
*         num_in_grp = num_in_grp + 1;
* 
*         mk_new_date(&dmn,&ddy,&dyr,(double)ddstep);
*       }
*/


      /*   if (strcmp(trait_name, "assertive")     == 0)  fldnum = 1; * one-based *
      *   if (strcmp(trait_name, "emotional")     == 0)  fldnum = 2;
      *   if (strcmp(trait_name, "restless")      == 0)  fldnum = 3;
      *   if (strcmp(trait_name, "down to earth") == 0)  fldnum = 4;
      *   if (strcmp(trait_name, "passionate")    == 0)  fldnum = 5;
      *   if (strcmp(trait_name, "ups and downs") == 0)  fldnum = 6;
      */
      rpt8_trait_rank(
        group_name,
        mamb_csv_arr,
        num_in_grp,
        trait_name
      );
    }

    if (strcmp(linebuf, "[best year]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(group_name, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(yyyy_todo, linebuf);

      /* get all members of group into array 
      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
      */
/*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1;
*       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
*         scharout(linebuf, '\n');
*         if (strcmp(linebuf, "[end of group members]") == 0) break;
*         mamb_csv_put(linebuf, strlen(linebuf));
*         num_in_grp = num_in_grp + 1;
*       }
*/

      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(grpmbr_file, linebuf);
      get_mbrs_from(grpmbr_file, &num_in_grp);

      rpt9_best_year(
        group_name,
        mamb_csv_arr,
        num_in_grp,
        yyyy_todo
      );
    }

    if (strcmp(linebuf, "[best day]") == 0) {
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(group_name, linebuf);
      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(yyyymmdd_todo, linebuf);

      /* get all members of group into array 
      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
      */
/*       num_in_grp = 0;
*       is_first_mamb_csv_put = 1;
*       while (fgets(linebuf, 128, FP_rpt_specs) != NULL) {
*         scharout(linebuf, '\n');
*         if (strcmp(linebuf, "[end of group members]") == 0) break;
*         mamb_csv_put(linebuf, strlen(linebuf));
*         num_in_grp = num_in_grp + 1;
*       }
*/

      fgets(linebuf, 128, FP_rpt_specs); scharout(linebuf, '\n');
      strcpy(grpmbr_file, linebuf);
      get_mbrs_from(grpmbr_file, &num_in_grp);

      rpt10_best_day(
        group_name,
        mamb_csv_arr,
        num_in_grp,
        yyyymmdd_todo
      );
    }

  } /* while (fgets(linebuf, 128, FP_rpt_specs) != NULL) */

b(50);
  fclose(FP_rpt_specs);
b(51);

  return(0);

} /* end of main() */



void get_mbrs_from(char *grpmbr_file, int *num_in_grp)
{
  char linebuf2[256];
  *num_in_grp = 0;
  is_first_mamb_csv_put = 1;  /* 1=yes, 0=no */
  FP_grp_members = fopen(grpmbr_file, "r"); 

  while (fgets(linebuf2, 128, FP_grp_members) != NULL) {
    scharout(linebuf2, '\n');
    mamb_csv_put(linebuf2, (int)strlen(linebuf2));
    *num_in_grp = *num_in_grp + 1;
  }
  fclose(FP_grp_members);
  return;
} /* end of get_mbrs_from() */


/* add a line to the array mamb_csv_arr
*  
*  ndoc = sprintf(p,"\n[end_program]\n");
*  p_docin_put(docp, docn);
*/
void mamb_csv_put(char *line, int length)
{
  char mamb_errbuf[256];

  if (is_first_mamb_csv_put == 1) mamb_csv_idx = 0;
  else                            mamb_csv_idx++;

  mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
  if (mamb_csv_arr[mamb_csv_idx] == NULL) {
    sprintf(mamb_errbuf, "malloc failed, arridx=%d, linelen=%d, line=[%s]\n",
      mamb_csv_idx, length, line);
    fprintf(stderr, "%s", mamb_errbuf);
    exit(54);  /* ? */
  }

  strcpy(mamb_csv_arr[mamb_csv_idx], line);

  is_first_mamb_csv_put = 0;  /* set to no */
  
  /* When this function finishes,
  * the index mamb_csv_idx points at the last line written.
  * Therefore, the current mamb_csv_arr written
  * run from index = 0 to index = mamb_csv_idx. (see p_docin_free() below)
  */

} /* end of  mamb_csv_put() */

/* Free the memory allocated for every member of mamb_csv_arr array.
*/
void mamb_csv_free(void)
{
  int i;
/* tn(); trn("in p_docin_free()");ki(mamb_csv_idx); */
/* tn(); */
  for (i = 0; i <= mamb_csv_idx; i++) {
    free(mamb_csv_arr[i]);    mamb_csv_arr[i] = NULL;
  }
  mamb_csv_idx = 0;  /* pts to last array index populated */
}


void rpt1_personality(
  char *csv_person_string  /* like   "elena,5,17,1984,7,52,1,-2,-25.44" */
)
{
  char html_file_name[256], person_name[32], stringBuffForTraitCSV[64];
tn(); trn("in rpt1_personality()");

  sfill(stringBuffForTraitCSV, 60, ' ');
  strcpy(person_name, csv_get_field(csv_person_string, ",", 1));
  scharswitch(person_name, ' ', '_');
  sprintf(html_file_name, "%s/%sper_%s.html", dir_html_per, PREFIX_HTML_FILENAME, person_name);

  tn();trn("doing personality ...");  ks(html_file_name);

  /* for "return only csv with all trait scores" */
  mamb_report_personality(     /* in perdoc.o */
    html_file_name,
    csv_person_string,
    "",  /* could be "return only csv with all trait scores",  instructions */
         /* this instruction arg is now ignored, because arg next, */
         /* stringBuffForTraitCSV, is ALWAYS populated with trait scores */
    stringBuffForTraitCSV
  );
  /* here, go and look at html report */
}

void rpt2_year_in_the_life(
  char *csv_person_string,
  char  *yyyy_todo)
{
  char html_file_name[256], person_name[32], stringBuffForStressScore[32] ;

  sfill(stringBuffForStressScore, 60, ' ');

  strcpy(person_name, csv_get_field(csv_person_string, ",", 1));
  scharswitch(person_name, ' ', '_');
  sprintf(html_file_name, "%s/%syr%s_%s.html",
    dir_html_fut, PREFIX_HTML_FILENAME, yyyy_todo, person_name);

  tn();trn("doing calendar year ...");  ks(html_file_name);
  mamb_report_year_in_the_life(     /* in futdoc.o */
    html_file_name,
    csv_person_string,
    yyyy_todo,
    "",          /* char *instructions,    like  "return only year stress score" */
   stringBuffForStressScore   /* char *stringBuffForStressScore */
  );
  /* here, go and look at html report */
}


void rpt11_calendar_day(
  char *csv_person_string,
  char *yyyymmdd_todo)
{
  char html_file_name[256], person_name[32], stringBuffForStressScore[64] ;

  sfill(stringBuffForStressScore, 60, ' ');

  strcpy(person_name, csv_get_field(csv_person_string, ",", 1));
  scharswitch(person_name, ' ', '_');
  sprintf(html_file_name, "%s/%sday_%s_%s.html",
    dir_html_day, PREFIX_HTML_FILENAME, yyyymmdd_todo, person_name);

  tn();trn("doing calendar day ...");  ks(html_file_name);
  mamb_report_year_in_the_life(     /* in futdoc.o */
    html_file_name,
    csv_person_string,
    yyyymmdd_todo,
    "do day stress report and return stress score",  /* instructions */
    stringBuffForStressScore  /* char *stringBuffForStressScore */
  );
/* fopen_fpdb_for_debug(); */
/* tn();trn("  HEY HEY HEY HEY HEY HEY HEYHEY"); */
/* ksn(stringBuffForStressScore); */
/* tn();trn("  HEY HEY HEY HEY HEY HEY HEYHEY"); */
/* fclose_fpdb_for_debug(); */
}


void rpt3_just_2_people(
 char *csv_person_A, 
 char *csv_person_B)
{
  char html_file_name[256], person_name_A[32], person_name_B[32];

  strcpy(person_name_A, csv_get_field(csv_person_A, ",", 1));
  scharswitch(person_name_A, ' ', '_');
  strcpy(person_name_B, csv_get_field(csv_person_B, ",", 1));
  scharswitch(person_name_B, ' ', '_');

  /* put shortest name first
  */
/*   if ( strlen(person_name_A) <= strlen(person_name_B) ) {
*     sprintf(html_file_name,
*       "%s/mamb_grpof2_%s_%s.html", dir_html_grpof2, person_name_A, person_name_B);
*   } else {
*     sprintf(html_file_name,
*       "%s/mamb_grpof2_%s_%s.html", dir_html_grpof2, person_name_B, person_name_A);
*   }
*/
  sprintf(html_file_name,
    "%s/%sgrpof2_%s_%s.html", dir_html_grpof2, PREFIX_HTML_FILENAME, person_name_A, person_name_B);

  tn();trn("doing grpof2 ..."); ks(html_file_name);

  mamb_report_just_2_people(  
    html_file_name,
    csv_person_A,
    csv_person_B
  );
}

void rpt4_whole_group( 
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp )
{
  char html_file_name[256];
  int  retval, num_pairs_in_grp;
  char group_buf[32];

  num_pairs_in_grp = (num_in_grp * (num_in_grp -1)) / 2;
  char s_npig[8]; int size_NPIG;
  sprintf(s_npig, "%d", num_pairs_in_grp);
  size_NPIG = (int)strlen(s_npig);

  strcpy(group_buf, group_name);
  scharswitch(group_buf, ' ', '_');
  sprintf(html_file_name,
    "%s/%sgrpall_%s.html", dir_html_grpall, PREFIX_HTML_FILENAME, group_buf);

  tn();trn("doing whole group ...");  ks(html_file_name);
  /* Now call report function in grpdoc.c
  * 
  *  grpdoc.c populates array of report line data defined here.
  *
  *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
  *  int out_rank_idx;  * pts to current line in out_rank_lines *
  */
  out_rank_idx = 0;

  retval = mamb_report_whole_group(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    mamb_csv_arr,        /* in_csv_person_arr[] */
    num_in_grp,          /* num_persons_in_grp */
    out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
    &out_rank_idx,
    "",                  /* instructions, */
    ""                   /* buffer for string_for_table_only  */
  );


  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_whole_group()");}


  /* here, display data in table in cocoa
  */
/* <.> */ fopen_fpdb_for_debug();  /* for test */
/* kin(retval); */
/* kin(out_rank_idx); */

  int i, lenA, lenB, longest_A, longest_B, len2names;
  int pad_len, pad_left, pad_right;
  char sfmt_pair_line[64];
  char sfmt_pair_names[64];
/*   char pad_spaces[32]; */
  char pair_line[128], benchmark_label[16], cocoa_rowcolor[16];
  char pair_names[128]; 

  /* get size of longest names for person_A and B
  */
  for (longest_A=0,longest_B=0, i=0; i <= out_rank_idx; i++) {
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
/* ki(len2names); */
/* ki(pad_len); */

  /* =========  PUT HEADER LINES  ==============
  */
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */

  if (len2names <= 13 ) {  /* SHORT NAMES */
/*     sprintf(sfmt_pair_line, "       %%-%ds", len2names + pad_len +3+2+1+9+1+1); */
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);

/*     sprintf(pair_line, sfmt_pair_line, "Group Members  Score"); */
    sprintf(pair_line, sfmt_pair_line, " ", "  Pair of      Compatibility  ");
    /* put in cocoa table here */

/*     sprintf(sfmt_pair_line, "       %%-%ds", len2names + pad_len +3+2+1+9+1+1); */
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);

/*     sprintf(pair_line, sfmt_pair_line, "Group Members  Score"); */
/*     sprintf(pair_line, sfmt_pair_line, "Group Members  Score"); */
    sprintf(pair_line, sfmt_pair_line, " ", "Group Members    Potential    ");
    /* put in cocoa table here */

  } else {                 /* ORDINARY LENGTH NAMES */

    /* center "Pair of" in len2names spaces */
    pad_left = ((len2names - 7) /2) -1;      /* 7 = "Pair of" */
    pad_right = len2names - 7 - pad_left;    /* 7 = "Pair of" */
/* kin(pad_left);ki(pad_right); */

    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds  Compatibility  ", pad_left, pad_right);
/* ksn(sfmt_pair_names); */
    sprintf(pair_names, sfmt_pair_names, " ", "Pair of", " ");  

/* ksn(pair_names); */

/*     sprintf(sfmt_pair_line, "       %%-%ds", len2names + pad_len +3+2+1+9+1); */
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +3+2+1+9+1);

/* ksn(sfmt_pair_line); */
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
    /* put in cocoa table here */

    pad_left = ((len2names - 13) /2) -1;        /* 13 = "Group Members" */
    pad_right = len2names - 13 - pad_left; /* 13 = "Group Members" */
/* kin(pad_left);ki(pad_right); */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds", pad_left, pad_right);
/* ksn(sfmt_pair_names); */
    sprintf(pair_names, sfmt_pair_names, " ", "Group Members", " ");  

/* ksn(pair_names); */
/*     sprintf(sfmt_pair_line, "       %%-%ds Score          ", len2names); */

/*     sprintf(sfmt_pair_line, "       %%-%ds    Potential    ", len2names); */
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds    Potential    ", size_NPIG, len2names);


/* ksn(sfmt_pair_line); */
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
    /* put in cocoa table here */

  } /* =========  PUT HEADER LINES  ============== */


  /* ===== PUT DATA + BENCHMARK LINES  =====
  * 
  *  1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  for (i=0; i <= out_rank_idx; i++) {

    /* put out benchmark lines
    */
    if (out_rank_lines[i]->rank_in_group == 0) {
      if (out_rank_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_rank_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_rank_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_rank_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_rank_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

/*    sprintf(sfmt_pair_line, " %%3s   %%-%ds  %%-%ds   %%2d %%-9s", longest_A, longest_B); */
      if (pad_len == 0) {
/*         sprintf(sfmt_pair_line, " %%3s   %%-%ds  %%-%ds   %%2d  %%-10s", */
/*           longest_A, longest_B         ); */
        sprintf(sfmt_pair_line, " %%%ds   %%-%ds  %%-%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B         );
        sprintf(pair_line, sfmt_pair_line, " ", " ", " ",
          out_rank_lines[i]->score, benchmark_label);
      } else {
/*         sprintf(sfmt_pair_line, " %%3s   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s", */
/*           longest_A, longest_B, pad_len); */
        sprintf(sfmt_pair_line, " %%%ds   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B, pad_len);
/* ksn(sfmt_pair_line); */
        sprintf(pair_line, sfmt_pair_line, " ", " ", " ", " ",
          out_rank_lines[i]->score, benchmark_label);
/* ksn(pair_line); */
      }

      strcpy(cocoa_rowcolor, set_cell_bg_color(out_rank_lines[i]->score));
      /* put in cocoa table here */
      continue;
    }
    
    strcpy(benchmark_label, "");

    if (pad_len == 0) {
/*       sprintf(sfmt_pair_line, " %%3d   %%-%ds  %%-%ds   %%2d  %%-10s", */
/*         longest_A, longest_B         ); */
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B         );
      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,
        out_rank_lines[i]->person_A,
        out_rank_lines[i]->person_B,
        out_rank_lines[i]->score,
        benchmark_label
      );
    } else {
/*       sprintf(sfmt_pair_line, " %%3d   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s", */
/*         longest_A, longest_B, pad_len); */
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B, pad_len);
      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,
        out_rank_lines[i]->person_A,
        out_rank_lines[i]->person_B,
        " ",  /* padding */
        out_rank_lines[i]->score,
        benchmark_label
      );
    }

    /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    */
    strcpy(cocoa_rowcolor, set_cell_bg_color(out_rank_lines[i]->score));
    /* put in cocoa table here */

  } /* ===== PUT DATA + BENCHMARK LINES  ===== */


  /* when finished, free allocated array elements 
  */
  g_rank_line_free(out_rank_lines, out_rank_idx);

  mamb_csv_free();

  return;
} /* end of rpt4_whole_group() */

char * set_cell_bg_color(int in_score) {
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

void rpt5_person_in_group( 
  char *group_name,
  char *mamb_csv_arr[],
  int   num_in_grp,
  char *csv_compare_everyone_with )
{
  char html_file_name[256], person_name[32];
  char group_buf[32];
  int  retval, num_pairs_in_grp;

  num_pairs_in_grp = (num_in_grp * (num_in_grp -1)) / 2;
  char s_npig[8]; int size_NPIG;
  sprintf(s_npig, "%d", num_pairs_in_grp);
  size_NPIG = (int)strlen(s_npig);


  strcpy(person_name, csv_get_field(csv_compare_everyone_with, ",", 1));
  strcpy(group_buf, group_name);
  scharswitch(group_buf, ' ', '_');
  scharswitch(person_name, ' ', '_');
  sprintf(html_file_name, "%s/%sgrpone_%s_%s.html",
    dir_html_grpone, PREFIX_HTML_FILENAME, person_name, group_buf);

  tn();trn("doing person in group ..."); ks(html_file_name);

  /* Now call report function in grpdoc.c
  * 
  *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
  *  int out_rank_idx;  * pts to current line in out_rank_lines *
  */
  out_rank_idx = 0;
  retval = mamb_report_person_in_group(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    mamb_csv_arr,        /* in_csv_person_arr[] */
    num_in_grp,          /* num_persons_in_grp */
    csv_compare_everyone_with,
    out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
    &out_rank_idx 
  );

  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}


  /* here, display data in table in cocoa
  */

/* <.> */ fopen_fpdb_for_debug();  /* for test */

  int i, lenA, lenB, longest_A, longest_B, len2names;
  int pad_len, pad_left, pad_right;
  char sfmt_pair_line[64];
  char sfmt_pair_names[64];
/*   char pad_spaces[32]; */
  char pair_line[128], benchmark_label[16], cocoa_rowcolor[16];
  char pair_names[128]; 

  pad_left  = 0;
  pad_right = 0;
  /* get size of longest names for person_A and B
  */
  for (longest_A=0,longest_B=0, i=0; i <= out_rank_idx; i++) {
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
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */

  if (len2names <= 13 ) {  /* SHORT NAMES */
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "  Pair of      Compatibility  ");
    /* put in cocoa table here */

    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "Group Members    Potential    ");
    /* put in cocoa table here */

  } else {                 /* ORDINARY LENGTH NAMES */

    /* center "Pair of" in len2names spaces */
    pad_left = ((len2names - 7) /2) -1;      /* 7 = "Pair of" */
    pad_right = len2names - 7 - pad_left;    /* 7 = "Pair of" */

    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds  Compatibility  ", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Pair of", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +3+2+1+9+1);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
    /* put in cocoa table here */

    pad_left = ((len2names - 13) /2) -1;        /* 13 = "Group Members" */
    pad_right = len2names - 13 - pad_left; /* 13 = "Group Members" */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Group Members", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds    Potential    ", size_NPIG, len2names);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
    /* put in cocoa table here */

  } /* =========  PUT HEADER LINES  ============== */


  /* 1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  for (i=0; i <= out_rank_idx; i++) { /* ===== PUT DATA + BENCHMARK LINES  ===== */


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

      strcpy(cocoa_rowcolor, set_cell_bg_color(out_rank_lines[i]->score));
      /* put in cocoa table here */
      continue;
    }
    
    strcpy(benchmark_label, "");

    if (pad_len == 0) {
/*       sprintf(sfmt_pair_line, " %%3d   %%-%ds  %%-%ds   %%2d  %%-9s", */
/*         longest_A, longest_B         ); */
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B         );

      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,
        out_rank_lines[i]->person_A,
        out_rank_lines[i]->person_B,
        out_rank_lines[i]->score,
        benchmark_label
      );
    } else {
/*       sprintf(sfmt_pair_line, " %%3d   %%-%ds  %%-%ds%%%ds   %%2d  %%-9s", */
/*         longest_A, longest_B, pad_len); */
      sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
        size_NPIG, longest_A, longest_B, pad_len);

      sprintf(pair_line, sfmt_pair_line, 
        out_rank_lines[i]->rank_in_group,
        out_rank_lines[i]->person_A,
        out_rank_lines[i]->person_B,
        " ",  /* padding */
        out_rank_lines[i]->score,
        benchmark_label
      );
    }

    /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    */
    strcpy(cocoa_rowcolor, set_cell_bg_color(out_rank_lines[i]->score));
    /* put in cocoa table here */

  } /* ===== PUT DATA + BENCHMARK LINES  ===== */


  /* when finished, free arr elements 
  */
  g_rank_line_free(out_rank_lines, out_rank_idx);

  mamb_csv_free();

} /* end of rpt5_person_in_group() */


void rpt6_group_top_bottom( 
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp,
  int  top_this_many,
  int  bot_this_many)
{
  char html_file_name[256], instructions_for_top_bot[128];
  char group_buf[32];
  int  retval, num_pairs_in_grp;

  num_pairs_in_grp = (num_in_grp * (num_in_grp -1)) / 2;
  char s_npig[8]; int size_NPIG;
  sprintf(s_npig, "%d", num_pairs_in_grp);
  size_NPIG = (int)strlen(s_npig);


  strcpy(group_buf, group_name);
  scharswitch(group_buf, ' ', '_');

/* change "topbot" dir and file name to same as grpall
*/
/*   sprintf(html_file_name, "%s/%stopbot_%s.html", */
  sprintf(html_file_name, "%s/%sgrpall_%s.html",
    dir_html_topbot, PREFIX_HTML_FILENAME, group_buf);

  tn();trn("doing whole group top/bot ...");  ks(html_file_name);

  /* Now call report function in grpdoc.c
  * 
  *  grpdoc.c populates array of report line data defined here.
  *
  *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
  *  int out_rank_idx;  * pts to current line in out_rank_lines *
  */
  out_rank_idx = 0;

  sprintf(instructions_for_top_bot,
    "top_this_many=|%d|bot_this_many=|%d|", top_this_many, bot_this_many);

  retval = mamb_report_whole_group(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    mamb_csv_arr,        /* in_csv_person_arr[] */
    num_in_grp,          /* num_persons_in_grp */
    out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
    &out_rank_idx,
    instructions_for_top_bot, 
    ""                   /* buffer for string_for_table_only  */
  );

  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_whole_group()");}



  /* here, display data in table in cocoa
  */

/* <.> */ fopen_fpdb_for_debug();  /* for test */

  int num_pairs_to_rank;
  int i, lenA, lenB, longest_A, longest_B, len2names;
  int pad_len, pad_left, pad_right;
  char sfmt_pair_line[64];
  char sfmt_pair_names[64];
/*   char pad_spaces[32]; */
  char pair_line[128], benchmark_label[16], cocoa_rowcolor[16];
  char pair_names[128]; 

  /* get size of longest names for person_A and B
  */
  for (longest_A=0,longest_B=0, i=0; i <= out_rank_idx; i++) {
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
/* ki(len2names); */
/* ki(pad_len); */


  /* =========  PUT HEADER LINES  ==============
  */
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */

  if (len2names <= 13 ) {  /* SHORT NAMES */
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "  Pair of      Compatibility  ");
    /* put in cocoa table here */

    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +2+1+9+1+1);
    sprintf(pair_line, sfmt_pair_line, " ", "Group Members    Potential    ");
    /* put in cocoa table here */

  } else {                 /* ORDINARY LENGTH NAMES */

    /* center "Pair of" in len2names spaces */
    pad_left = ((len2names - 7) /2) -1;      /* 7 = "Pair of" */
    pad_right = len2names - 7 - pad_left;    /* 7 = "Pair of" */

    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds  Compatibility  ", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Pair of", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds",
      size_NPIG,
      len2names + pad_len +3+2+1+9+1);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
    /* put in cocoa table here */

    pad_left = ((len2names - 13) /2) -1;        /* 13 = "Group Members" */
    pad_right = len2names - 13 - pad_left; /* 13 = "Group Members" */
    sprintf(sfmt_pair_names, "%%-%ds%%s%%-%ds", pad_left, pad_right);
    sprintf(pair_names, sfmt_pair_names, " ", "Group Members", " ");  
    sprintf(sfmt_pair_line, " %%%ds   %%-%ds    Potential    ", size_NPIG, len2names);
    sprintf(pair_line, sfmt_pair_line, " ", pair_names);
    /* put in cocoa table here */

  } /* =========  PUT HEADER LINES  ============== */

  /* 1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  num_pairs_to_rank = 0;  /* init */
  num_pairs_to_rank = (num_in_grp * (num_in_grp -1)) / 2;

  for (i=0; i <= out_rank_idx; i++) { /* ===== PUT DATA + BENCHMARK LINES  ===== */


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

      strcpy(cocoa_rowcolor, set_cell_bg_color(out_rank_lines[i]->score));
      /* put in cocoa table here */
      continue;
    }
    
    
    /*  put out line for boundary of bottom 100 before outputting that line
    */
/* kin(num_pairs_to_rank); kin(bot_this_many); */

    if (out_rank_lines[i]->rank_in_group ==
      num_pairs_to_rank - bot_this_many + 1) {

/* tn();trn("BOTTOM 100 line goes here");tn(); */
      /* sprintf(sfmt_pair_line, " %%3s   %%-%ds  %%-%ds   %%2d %%-9s",  longest_A, longest_B); */
/*       sprintf(sfmt_pair_line, "       Bottom%%-%3dd ", 10 + longest_A + longest_B +1+1); */
/*       sprintf(sfmt_pair_line, "       Bottom%%-%3dd ", 10 + longest_A + longest_B +1+1+1); */

      sprintf(sfmt_pair_line, " %%%ds   Bottom%%-%3dd ",
        size_NPIG,
        10 + longest_A + longest_B +1+1);
/*         10 + longest_A + longest_B +1+1+1); */

      sprintf(pair_line, sfmt_pair_line, " ", bot_this_many);

      strcpy(cocoa_rowcolor, set_cell_bg_color(999));  /* 999 = color cHead */
    /* put in cocoa table here */
/*       continue; */
    }

/* int tmpi; tmpi = num_pairs_to_rank - bot_this_many + 1 ; */
/* kin(out_rank_lines[i]->rank_in_group);ki(tmpi);ki(top_this_many); */

    if (   out_rank_lines[i]->rank_in_group <= top_this_many
        || out_rank_lines[i]->rank_in_group >= num_pairs_to_rank - bot_this_many + 1)
    {

      strcpy(benchmark_label, "");
      if (pad_len == 0) {
/*         sprintf(sfmt_pair_line, " %%3d   %%-%ds  %%-%ds   %%2d  %%-10s", */
/*           longest_A, longest_B         ); */
        sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B         );

        sprintf(pair_line, sfmt_pair_line, 
          out_rank_lines[i]->rank_in_group,
          out_rank_lines[i]->person_A,
          out_rank_lines[i]->person_B,
          out_rank_lines[i]->score,
          benchmark_label
        );
      } else {
/*         sprintf(sfmt_pair_line, " %%3d   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s", */
/*           longest_A, longest_B, pad_len); */
        sprintf(sfmt_pair_line, " %%%dd   %%-%ds  %%-%ds%%%ds   %%2d  %%-10s",
          size_NPIG, longest_A, longest_B, pad_len);

        sprintf(pair_line, sfmt_pair_line, 
          out_rank_lines[i]->rank_in_group,
          out_rank_lines[i]->person_A,
          out_rank_lines[i]->person_B,
          " ",  /* padding */
          out_rank_lines[i]->score,
          benchmark_label
        );
      }

      /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
      */
      strcpy(cocoa_rowcolor, set_cell_bg_color(out_rank_lines[i]->score));
      /* put in cocoa table here */
    }

    /*  put out line for boundary of top 200 after outputting that line
    */
    if (out_rank_lines[i]->rank_in_group == top_this_many) {
/* tn();trn("TOP 200 line goes here");tn(); */
/* kin(out_rank_lines[i]->rank_in_group);ki(top_this_many); */
      /* sprintf(sfmt_pair_line, " %%3s   %%-%ds  %%-%ds   %%2d %%-9s",  longest_A, longest_B); */
/*       sprintf(sfmt_pair_line, "       Top%%-%3dd ", 13 + longest_A + longest_B +1); */
/*       sprintf(sfmt_pair_line, "       Top%%-%3dd ", 13 + longest_A + longest_B +1+1); */

      sprintf(sfmt_pair_line, " %%%ds   Top%%-%3dd ",
        size_NPIG,
        13 + longest_A + longest_B +1+1);
      sprintf(pair_line, sfmt_pair_line, " ", top_this_many);

      strcpy(cocoa_rowcolor, set_cell_bg_color(999));  /* 999 = color cHead */
    /* put in cocoa table here */
    }


  } /* ===== PUT DATA + BENCHMARK LINES  ===== */
/* <.> */

  /* when finished, free allocated array elements 
  */
  g_rank_line_free(out_rank_lines, out_rank_idx);

  mamb_csv_free();

  return;
} /* end of  rpt6_group_top_bottom() */


/*   if (strcmp(trait_name, "assertive")     == 0)  fldnum = 1; * one-based *
*   if (strcmp(trait_name, "emotional")     == 0)  fldnum = 2;
*   if (strcmp(trait_name, "restless")      == 0)  fldnum = 3;
*   if (strcmp(trait_name, "down to earth") == 0)  fldnum = 4;
*   if (strcmp(trait_name, "passionate")    == 0)  fldnum = 5;
*   if (strcmp(trait_name, "ups and downs") == 0)  fldnum = 6;
*/
void rpt8_trait_rank(
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp,
  char *trait_name  )
{
  char html_file_name[256];
  int  retval;
  char group_buf[32], trait_buf[32];

/* trn("in rpt8_trait_rank"); */
  
  strcpy(group_buf, group_name);
  strcpy(trait_buf, trait_name);
  scharswitch(group_buf, ' ', '_');
  scharswitch(trait_buf, ' ', '_');

  if (strstr(trait_buf, "ups") != NULL) strcpy(trait_buf, "ups_n_downs");

  sprintf(html_file_name, "%s/%sgrptra_%s_%s.html",
    dir_html_grptra, PREFIX_HTML_FILENAME, group_buf, trait_buf);

  tn();trn("doing trait rank ...");  ks(html_file_name);
  /* Now call report function in grpdoc.c
  * 
  *  grpdoc.c populates array of report line data defined here.
  *
  *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
  *  int out_rank_idx;  * pts to current line in out_rank_lines *
  */
  out_rank_idx = 0;
  retval = mamb_report_trait_rank(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    mamb_csv_arr,        /* in_csv_person_arr[] */
    num_in_grp,          /* num_persons_in_grp */
    trait_name,          /* assertive, emotional, etc 6 of them */
    out_trait_lines,     /* struct rank_report_line *out_trait_lines[]; */
    &out_trait_idx
/*    "",  */               /* instructions, */
/*    ""   */               /* buffer for string_for_table_only  */
  );

  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_trait_rank()");}




  /* Here the html file is created.
  *  Now, create the array of strings which will be used
  *  to populate the cocoa report table.
  */

  /* here, display data in table in cocoa
  */

/* <.> */ fopen_fpdb_for_debug();  /* for test */

  int i, lenA, longest_A, len_name, size_grp_mem;
  char sfmt_person_line[64];
/*   char pad_spaces[32]; */
  char person_line[128], benchmark_label[16], cocoa_rowcolor[16];

  /* get size of longest names for person_A 
  */
  for (longest_A=0,i=0; i <= out_trait_idx; i++) {
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
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */
  sprintf(sfmt_person_line, "       %%-%dsScore", size_grp_mem);
  sprintf(person_line, sfmt_person_line, "Group Member");
    /* put in cocoa table here */
  /* =========  PUT HEADER LINES  ============== */


  /* ===== PUT DATA + BENCHMARK LINES  =====
  * 
  *  1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  for (i=0; i <= out_trait_idx; i++) {

    /* put out benchmark lines
    */
    if (out_trait_lines[i]->rank_in_group == 0) {
      if (out_trait_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_trait_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_trait_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_trait_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_trait_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

      sprintf(sfmt_person_line, " %%3s   %%-%ds  %%2d  %%-9s", size_grp_mem );
      sprintf(person_line, sfmt_person_line, " ", " ",
        out_trait_lines[i]->score, benchmark_label);

      strcpy(cocoa_rowcolor, set_cell_bg_color(out_trait_lines[i]->score));
      /* put in cocoa table here */
      continue;
    }
    
    strcpy(benchmark_label, "");

    sprintf(sfmt_person_line, " %%3d   %%-%ds  %%2d  %%-9s", size_grp_mem);
    sprintf(person_line, sfmt_person_line, 
      out_trait_lines[i]->rank_in_group,
      out_trait_lines[i]->person_name,
      out_trait_lines[i]->score,
      benchmark_label
    );

    /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    */
    strcpy(cocoa_rowcolor, set_cell_bg_color(out_trait_lines[i]->score));
    /* put in cocoa table here */

  } /* ===== PUT DATA + BENCHMARK LINES  ===== */
/* <.> */



  /* when finished, free allocated array elements 
  */
  g_trait_line_free(out_trait_lines, out_trait_idx);

  mamb_csv_free();

  return;
} /* end of rpt8_trait_rank() */


void rpt9_best_year(
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp,
  char *yyyy_todo
) {
  char html_file_name[256];
  int  retval;
  char group_buf[32];

/* trn("in rpt9_best_year"); */

  strcpy(group_buf, group_name);
  scharswitch(group_buf, ' ', '_');
  sprintf(html_file_name,
    "%s/%sgrpbyr_%s_%s.html",
      dir_html_grpbyr, PREFIX_HTML_FILENAME, group_buf, yyyy_todo);

  tn();trn("doing best year ...");  ks(html_file_name);
  /* Now call report function in grpdoc.c
  * 
  *  grpdoc.c populates array of report line data defined here.
  */
  out_trait_idx = 0;
  retval = mamb_report_best_year(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    mamb_csv_arr,        /* in_csv_person_arr[] */
    num_in_grp,          /* num_persons_in_grp */
    yyyy_todo,           /* calendar year */
    out_trait_lines,     /* struct trait_report_line *out_trait_lines[]; */
    &out_trait_idx
  );

  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_best_year()");}



  /* Here the html file is created.
  *  Now, create the array of strings which will be used
  *  to populate the cocoa report table.
  */

  /* here, display data in table in cocoa
  */

/* <.> */ fopen_fpdb_for_debug();  /* for test */

  int i, lenA, longest_A, len_name, size_grp_mem;
  char sfmt_person_line[64];
/*   char pad_spaces[32]; */
  char person_line[128], benchmark_label[16], cocoa_rowcolor[16];

  /* get size of longest names for person_A 
  */
  for (longest_A=0,i=0; i <= out_trait_idx; i++) {
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
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */
  sprintf(sfmt_person_line, "       %%-%dsScore", size_grp_mem);
  sprintf(person_line, sfmt_person_line, "Group Member");
    /* put in cocoa table here */
  /* =========  PUT HEADER LINES  ============== */


  /* ===== PUT DATA + BENCHMARK LINES  =====
  * 
  *  1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  for (i=0; i <= out_trait_idx; i++) {

    /* put out benchmark lines
    */
    if (out_trait_lines[i]->rank_in_group == 0) {
      if (out_trait_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_trait_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_trait_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_trait_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_trait_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

      sprintf(sfmt_person_line, " %%3s   %%-%ds  %%2d  %%-9s", size_grp_mem );
      sprintf(person_line, sfmt_person_line, " ", " ",
        out_trait_lines[i]->score, benchmark_label);

      strcpy(cocoa_rowcolor, set_cell_bg_color(out_trait_lines[i]->score));
      /* put in cocoa table here */
      continue;
    }
    
    strcpy(benchmark_label, "");

    sprintf(sfmt_person_line, " %%3d   %%-%ds  %%2d  %%-9s", size_grp_mem);
    sprintf(person_line, sfmt_person_line, 
      out_trait_lines[i]->rank_in_group,
      out_trait_lines[i]->person_name,
      out_trait_lines[i]->score,
      benchmark_label
    );

    /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    */
    strcpy(cocoa_rowcolor, set_cell_bg_color(out_trait_lines[i]->score));
    /* put in cocoa table here */

  } /* ===== PUT DATA + BENCHMARK LINES  ===== */
/* <.> */


  /* when finished, free allocated array elements 
  */
  g_trait_line_free(out_trait_lines, out_trait_idx);

  mamb_csv_free();
  return;

} /* end of  rpt9_best_year() */



void rpt10_best_day(
  char *group_name,
  char *mamb_csv_arr[],
  int  num_in_grp,
  char *yyyymmdd_todo
) {
  char html_file_name[256];
  int  retval;
  char group_buf[32];

/* trn("in rpt10_best_day"); */

  strcpy(group_buf, group_name);
  scharswitch(group_buf, ' ', '_');
  sprintf(html_file_name,
    "%s/%sgrpbdy_%s_%s.html", dir_html_grpbdy, PREFIX_HTML_FILENAME, group_buf, yyyymmdd_todo);

  tn();trn("doing best day ...");  ks(html_file_name);
  /* Now call report function in grpdoc.c
  * 
  *  grpdoc.c populates array of report line data defined here.
  */
  out_trait_idx = 0;
  retval = mamb_report_best_day(  /* in grpdoc.o */
    html_file_name,      /* html_file_name */
    group_name,          /* group_name */
    mamb_csv_arr,        /* in_csv_person_arr[] */
    num_in_grp,          /* num_persons_in_grp */
    yyyymmdd_todo,           /* day to do */
    out_trait_lines,     /* struct trait_report_line *out_trait_lines[]; */
    &out_trait_idx
  );

  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_best_day ()");}


  /* Here the html file is created.
  *  Now, create the array of strings which will be used
  *  to populate the cocoa report table.
  */

  /* here, display data in table in cocoa
  */

/* <.> */ fopen_fpdb_for_debug();  /* for test */

  int i, lenA, longest_A, len_name, size_grp_mem;
  char sfmt_person_line[64];
/*   char pad_spaces[32]; */
  char person_line[128], benchmark_label[16], cocoa_rowcolor[16];

  /* get size of longest names for person_A 
  */
  for (longest_A=0,i=0; i <= out_trait_idx; i++) {
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
  strcpy(cocoa_rowcolor, "cHed");   /* for hdr */
  sprintf(sfmt_person_line, "       %%-%dsScore", size_grp_mem);
  sprintf(person_line, sfmt_person_line, "Group Member");
    /* put in cocoa table here */
  /* =========  PUT HEADER LINES  ============== */


  /* ===== PUT DATA + BENCHMARK LINES  =====
  * 
  *  1. format lines into one string   2. get color
  *  3. populate cocoa table with that
  */
  for (i=0; i <= out_trait_idx; i++) {

    /* put out benchmark lines
    */
    if (out_trait_lines[i]->rank_in_group == 0) {
      if (out_trait_lines[i]->score == 90) strcpy(benchmark_label, "Great");
      if (out_trait_lines[i]->score == 75) strcpy(benchmark_label, "Very Good");
      if (out_trait_lines[i]->score == 50) strcpy(benchmark_label, "Average");
      if (out_trait_lines[i]->score == 25) strcpy(benchmark_label, "Not Good");
      if (out_trait_lines[i]->score == 10) strcpy(benchmark_label, "OMG");

      sprintf(sfmt_person_line, " %%3s   %%-%ds  %%2d  %%-9s", size_grp_mem );
      sprintf(person_line, sfmt_person_line, " ", " ",
        out_trait_lines[i]->score, benchmark_label);

      strcpy(cocoa_rowcolor, set_cell_bg_color(out_trait_lines[i]->score));
      /* put in cocoa table here */
      continue;
    }
    
    strcpy(benchmark_label, "");

    sprintf(sfmt_person_line, " %%3d   %%-%ds  %%2d  %%-9s", size_grp_mem);
    sprintf(person_line, sfmt_person_line, 
      out_trait_lines[i]->rank_in_group,
      out_trait_lines[i]->person_name,
      out_trait_lines[i]->score,
      benchmark_label
    );

    /* Note: set bg color of cell (UIColor) in "tableView: cellForRowAtIndexPath: "
    */
    strcpy(cocoa_rowcolor, set_cell_bg_color(out_trait_lines[i]->score));
    /* put in cocoa table here */

  } /* ===== PUT DATA + BENCHMARK LINES  ===== */
/* <.> */


  /* when finished, free allocated array elements 
  */
  g_trait_line_free(out_trait_lines, out_trait_idx);

  mamb_csv_free();
  return;
} /* end of rpt10_best_day() */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void rpt7_avg_scores( 
*   char *group_name,
*   char *mamb_csv_arr[],
*   int  num_in_grp)
* {
*   char html_file_name[256];
*   int  retval;
*   char group_buf[32];
* 
*   strcpy(group_buf, group_name);
*   scharswitch(group_buf, ' ', '_');
*   sprintf(html_file_name, "%s/%sgrpavg_%s.html",
*     dir_html_grpavg, PREFIX_HTML_FILENAME, group_buf);
* 
*   tn();trn("doing average scores ...");  ks(html_file_name);
*   /* Now call report function in grpdoc.c
*   * 
*   *  grpdoc.c populates array of report line data defined here.
*   *
*   *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
*   *  int out_rank_idx;  * pts to current line in out_rank_lines *
*   */
*   out_avg_idx = 0;
* 
*   retval = mamb_report_avg_scores(    /* in grpdoc.o */
*     html_file_name,
*     group_name,
*     mamb_csv_arr,
*     num_in_grp,
*     out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
*     &out_rank_idx,
*     out_avg_lines,  /*  struct avg_report_line *avg_lines[]  */
*     &out_avg_idx
*   );
* 
*   if (retval != 0) {tn(); trn("non-zero retval from mamb_report_whole_group()");}
* 
*   /* when finished, free allocated array elements 
*   */
*   g_rank_line_free(out_rank_lines, out_rank_idx);
*   g_avg_line_free(out_avg_lines, out_avg_idx);
* 
*   mamb_csv_free();
* 
*   return;
* } /* end of rpt7_avg_scores() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/



/* csv_person_put()   add a string to the array of person_csv_strings
*  eg
*      csvlen = sprintf(csbuf, "Delia,12,13,1971,12,15,0,-1,-19.05");
*      csv_person_put(csbuf, csvlen);
*      
*/
/* somewhere appropriate set flag:
*       is_first_mamb_csv_person_put = 1;  * 1=yes, 0=no *
*/
void csv_person_put(char *str, int length)
{
  if (is_first_mamb_csv_person_put == 1) csv_person_idx = 0;
  else                                   csv_person_idx++;

  csv_person_array[csv_person_idx] = malloc(length + 1);

  if (csv_person_array[csv_person_idx] == NULL) {
    sprintf(csv_person_errbuf,
      "csv_person_array malloc failed, arridx=%d, strlen=%d, str=[%s]\n",
      csv_person_idx, length, str);
    fprintf(stderr, "%s", csv_person_errbuf);
    exit(9);
  }

  strcpy(csv_person_array[csv_person_idx], str);

  is_first_mamb_csv_person_put = 0;  /* set to no */
  
  /* When this function finishes,
  * the index csv_person_idx points at the last string written.
  * Therefore, the current csv_person_array string written
  * run from index = 0 to index = csv_person_idx. (see csv_person_free() below)
  */
}
  

/* Free the memory allocated for every member of csv_person_array.
*/
void csv_person_free(void)
{
  int i;

  for (i = 0; i <= csv_person_idx; i++) {
    free(csv_person_array[i]);    csv_person_array[i] = NULL;
  }
}


//
///* ==================  search place stuff  =================== */
///* 
//* struct my_place_fields  *gbl_search_results1[MAX_IN_PLACES_SEARCH_RESULTS1];
//* int gblIdxLastResultsAdded;
//* int gbl_is_first_results1_put;
//*
//* void places_result1_put(struct my_place_fields place_struct);
//* void places_result1_free(void);
//*/
//
///* ---------------------------------------------------------------- */
//void places_result1_put(struct my_place_fields place_struct)
//{
//  char errbuf[128];
///* tn();trn("in places_result1_put()"); */
//
//  if (gbl_is_first_results1_put == 1 )  gblIdxLastResultsAdded= 0;
//  else                                 (gblIdxLastResultsAdded)++;
//
//  gbl_search_results1[gblIdxLastResultsAdded] = malloc(sizeof(struct my_place_fields));
//
//  if (gbl_search_results1[gblIdxLastResultsAdded] == NULL) {
//    sprintf(errbuf, "places_result_put malloc failed, arridx=%d\n", gblIdxLastResultsAdded);
//    rkabort(errbuf);
//  }
//  memcpy(
//    gbl_search_results1[gblIdxLastResultsAdded],
//    &place_struct,
//    sizeof(struct my_place_fields)
//  );
//
//  gbl_is_first_results1_put = 0; /* set to no */
//  
//  /* When this function finishes,
//  * the index *gblIdxLastResultsAdded points at the last gbl_search_results1 written.
//  * Therefore, the current gbl_search_results1 written
//  * run from index = 0 to index = *gblIdxLastResultsAdded. (see places_array_free() below)
//  */
//}  /* end of  places_result_put() */
//
///* Free the memory allocated for every member of array.
//*/
//void places_result1_free(void)
//{
//  int i;
///* tn();trn("in places_result1_free()"); */
//
//  /*   for (i = 0; i <= rank_line_idx; i++) { */
//  for (i = 0; i <= gblIdxLastResultsAdded; i++) {
//    free(gbl_search_results1[i]);   gbl_search_results1[i] = NULL;  /* accidental re-free() does not crash the free() */
//  }
//  gblIdxLastResultsAdded = 0;  /* pts to last array index populated */
//}
///* ---------------------------------------------------------------- */
//
//
///* if num cities found is <= arg max_in_places_search_results1,
//*  puts that many structs in   gbl_search_results1[]    and
//*  also populates gblIdxLastResultsAdded (places_result1_put() does)
//* 
//*  Returns number found  IF  array gbl_search_results1[] was populated
//*  otherwise returns -1
//*/
//int possiblyGetSearchResults1(
//  char *city_begins_with,
//  int  starting_index_into_cities,   /* into array struct my_place_fields gbl_placetab[] */
//  int  max_in_places_search_results1   /* 10 */
//)
//{
//  int my_num_elements, idx, len, num_places_found, iresult;
//  char begins_with_buf[64], city_buf[64];
//
///* tn();trn("in  possiblyGetSearchResults1"); */
///* kin(max_in_places_search_results1  ); */
///* kin(starting_index_into_cities); */
//  num_places_found = 0;
//  my_num_elements  = NKEYS_PLACE;     /* in full placetab array */
//
///* kin(my_num_elements); ksn(city_begins_with); */
//
//  strcpy(begins_with_buf, city_begins_with);
//  for(int i = 0; begins_with_buf[i]; i++){  /* make begins_with_buf  lower case */
//    begins_with_buf[i] = tolower(begins_with_buf[i]);
//  }
//  len = (int)strlen(begins_with_buf);
///* kin(len); */
//  while (starting_index_into_cities + num_places_found <= my_num_elements) {
//
//    /* make city_buf  lower case */
//    strcpy(city_buf, gbl_placetab[starting_index_into_cities + num_places_found].my_city);
//    for(int i = 0; city_buf[i]; i++){
//      city_buf[i] = tolower(city_buf[i]);
//    }
//
//    iresult = strncmp(begins_with_buf, city_buf, len); /* ignores case */
///* ksn(city_buf); */
//    if (iresult == 0) {
//      num_places_found = num_places_found + 1;
///* ki(num_places_found); */
//      if (num_places_found > max_in_places_search_results1) return (-1);
//    } else {
//      break;
//    }
//  }
//
///* trn("out");ki(num_places_found);tn(); */
//  /* here num_places_found  is <=  max_in_places_search_results1) 
//  *  and we put that many into gbl_search_results1[]
//  */
//  for (idx=0; idx <= num_places_found -1; idx++) {
///* ki(idx); */
//    /* ############  collect results here  ##############
//    */
//    places_result1_put( gbl_placetab[starting_index_into_cities + idx] ); 
//  }
//
//  return num_places_found;
//} /* end of possiblyGetSearchResults1() */
//

#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* end of incocoa.c  */
