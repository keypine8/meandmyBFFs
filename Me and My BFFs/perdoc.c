/*     x    perdoc.c         */

/* gets changed to fgetstr 26dec84 */
/*     this takes event specs from stdin for a chart */
/*     calculates the chart */
/*     prints the sign and house placements in the chart */
/*     prints the aspects in the chart */

/* #include "/usr/rk/c/rk.h" */
/* #include "pp_tabs.h" */

/* #include "rkdebug.h"  comment out, use rkdebug.o instead */
#include "rkdebug_externs.h"

#include "rk.h"
#include "perdoc.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

/* #define DO_STDERR_DEBUG 1 */

/* #define NUM_ARGS 7 */   /* for testing, put back to 2 */

/* these are in rkdebug.o */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);

/* these are in mambutil.o */
extern int mapBenchmarkNumToPctlRank(int in_score);
extern int mapNumStarsToBenchmarkNum(int category, int num_stars);

extern char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);

extern int map_num_stars_to_benchmark_num(int category, int num_stars);


extern void get_event_details(   /* in mambutil.c */
  char *csv_person_string,
  char *pEVENT_NAME, 
  double *pINMN,
  double *pINDY,
  double *pINYR,
  double *pINHR,
  double *pINMU,
  int    *pINAP,
  double *pINTZ,
  double *pINLN
);

extern void calc_chart(double mnarg, double dyarg, double yrarg,
    double hrarg, double muarg, int aparg,
    double tzarg, double lnarg, double ltarg);


extern double Arco[];  /* one of 2 tables returned from calc_chart() */
  /* `coordinates' are in following order: */
  /* xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_ */
  /* positions are in radians */
extern char *Retro[];     /* one of two tables returned from calc_chart() */
              /* plts in same order as above */
              /* R if retrograde, p if not */
extern double fnu();
extern double fnd();

extern void scharswitch(char *s, char ch_old, char ch_new);
extern void strsort(char *v[], int n);  
extern char *sfromto(char *dest,char *src, int beg, int end);
extern void sfill(char *s, int num, int c);
/* these are in mambutil.o */


int mamb_report_personality ( /* in perdoc.o, called from incocoa */
  char *html_output_filename_webview,
  char *html_output_filename_browser,
  char *csv_person_string,
  char *instructions,  /* like "return only csv with all trait scores",  */
  char *string_buffer_for_trait_csv
);

int make_per_htm_file(        /* in perhtm.o */
  char *an_HTML_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx,
  char *instructions);


/* char Swk[512+1]; */ /* work string */

/* ----------------------- */
#define DOCIN_ARRAY_MAX 512  
char *docin_lines[DOCIN_ARRAY_MAX];
int   docin_idx;
char  errbuf[256];
void p_docin_put(char *line, int length);
void p_docin_free(void); 
int docn;
char *docp = &Swk[0];
/* ----------------------- */


void add_integratedness_lack_to_ups_and_downs(void); /* using gblBuffTraitScoresCSV */
void insert_new_mapped_score_for_upndn(int new_upndn_score);

int adjust_score(int score);
/* void check_grh_data(void); abandoned */
void stderr_grh_data(void);
void p_display_positions(void);  /* for test only */
/* void p_arg_abort(void); */
void p_make_special_graphs(void);
void do_special_line(int grh_data_idx);
void adjust_stars(int grh_data_idx, int *pnum_stars);
void make_sign_good_bad(void)  /* back in jan93.  See below */;
/* void make_a_sign_good_bad(int plus_or_minus); */
void p_mk_grh_line(int num_stars, int category);
void p_wrap_grh_line(int num_stars, int category);
void set_doc_for_grh(void);
/* void set_doc_for_paras(void); */
void open_fut_output_file(void);
void store_sgn_and_hse_placements(void);
void add_all_placements_to_grh_data(void);
void add_a_placement_to_grh_data(int plt);
void store_pp_aspects(void);
void p_add_all_asps_to_grh_data(void);
void p_add_an_asp_to_grh_data(int plt1, int plt2, int aspect_num);
int p_get_aspect_multiplier(int aspect_type, int plt1, int plt2, int category_num);
void put_sgn_and_hse_strings(void);
void p_put_aspect_strings(void);
void p_init_item_tbl(void);
void make_paras(void);
int p_isaspect(int m1, int m2, int *porbs);
void p_calc_current_aspect_force(int m1, int m2, int *porbs, int aspect_num);
void p_put_minutes(int *pi);
int p_get_minutes(double d);
int get_fut_input(char *futin_pathname);
void init_bufs(void);
void rd_futin(char *buf,int num_being_read);
/* void assign_fld(int jrk); */
/* void wrt_letter_window(void); */
void p_set_doc_hdr(void);
char *scapwords(char *s);
/* char *sallcaps(char *s); */
/* char *swholenum(char *t, char *s); */
/* char *sdecnum(char *t, char *s); */
/* int sfind(char s[], char c); */
void sfill(char *s, int num, int c) ;
int p_get_sign(int minutes);
int p_get_house(int minutes, int mc);
/* char *sfromto(char *dest, char *src, int beg, int end); */
/* int sall(char *s,char *set); */

int is_first_p_docin_put;    /* 1=yes, 0=no */
/* int is_first_p_special_line;  */

/* new way of calc abandoned 17jun2013
* 
* int gbl_num_stars_agrsv; 
* int gbl_num_stars_sensi;
* int gbl_num_stars_restl;
* int gbl_num_stars_earth;
* int gbl_num_stars_sexdr;
* int gbl_num_stars_bgmth;
* int gbl_num_stars_upndn;
*/

char gblBuffTraitScoresCSV[64];
char gbl_trait_csv_savold[64];
char gbl_output_instructions[64];

FILE *fpdat;

/* old int main(int argc, char *argv[]) */
/* ============================================================
*/
int mamb_report_personality (   /* in perdoc.o */
  char *html_output_filename_webview,
  char *html_output_filename_browser,
  char *csv_person_string,
  char *instructions,  /* like "return only csv with all trait scores" */
  char *string_buffer_for_trait_csv )
{

  fopen_fpdb_for_debug();

/* fprintf(stderr, "HEY stderr2!"); */
    trn("in mamb_report_personality()");   /* comes out a lot in trait rank rpts */
/* fprintf(stderr, "HEY stderr3!"); */
/* ksn(html_output_filename_webview); */
/* ksn(html_output_filename_browser); */
/* ksn(csv_person_string); */
/* ksn(instructions); */

/* put me in main(). output file for debug code */
/* fpdb = fopen("t.out","a"); */   /* fpdb=stderr; */
/* fpdat = fopen("t.data_per","a");    */

  if (strstr(instructions, "return only") == NULL) {
//    trn("in mamb_report_personality()");   /* comes out a lot in trait rank rpts */
  }  /* avoid dbmsg on non-rpt call */


  /* init gbl_output_instructions
  */
  if (strcmp(instructions, "return only csv with all trait scores") == 0) {
    strcpy(gbl_output_instructions, "no output, csv string only"); 
  } else {
    strcpy(gbl_output_instructions, ""); 
  }

  sfill(gblBuffTraitScoresCSV, 60, ' ');


  pPI_OVER_2 = 3.1415926535897932384 / 2.0;

/* old  do_testing_args(); */
  pSGN_OVER_HSE_FACTOR  =  2;
  pGRAPH_FACTOR         = 18;
/*   pPLACEMENT_MULTIPLIER_SIGN  =  6; */
/*   pPLACEMENT_MULTIPLIER_SIGN  =  12; */
  pPLACEMENT_MULTIPLIER_SIGN  =  36;
  pPLACEMENT_MULTIPLIER_HOUSE =  6;
  pSUBTRACT_FROM_STARS  = 35;
  pLESSON_MULTIPLIER    =  5;


  sfill(&pEVENT_NAME[0],SIZE_INBUF,' ');
  
  get_event_details(csv_person_string, pEVENT_NAME, 
    &pINMN, &pINDY, &pINYR, &pINHR, &pINMU, &pINAP, &pINTZ, &pINLN);

  calc_chart(pINMN,pINDY,pINYR,pINHR,pINMU,pINAP,pINTZ,pINLN,pINLT);

  p_put_minutes(&ar_minutes_natal[0]);  /* into a position table */

  /* do not worry about time of day confidence - say its 100% 
  */
  pHOUSE_CONFIDENCE = 1;
  pMOON_CONFIDENCE = 1;
  pMOON_CONFIDENCE_FACTOR = 1.0;  /* for moon_cf = yes, very accurate */
  is_first_p_docin_put = 1;  /* 1=yes, 0=no */

  /* this is 1st o/p to docin file
  */
  p_set_doc_hdr(); 
  p_init_item_tbl();
  store_sgn_and_hse_placements();
  store_pp_aspects();



  /* <.> for test */
  /* for debug- goes to stderr */
  /*   p_display_positions(); */



/* p_display_positions(); */
/* <.> */


  /* initialize pGRH_DATA to zero
  *  int pGRH_DATA[TOT_CATEGORIES][NUM_PLUS_OR_MINUS_CATEGORIES];
  * 
  *  initialize pPLT_HAS_ASP_TBL to zero
  *  int pPLT_HAS_ASP_TBL[NUM_PLANETS+1];  * for free-floating control *
  */
  int kkk, mmm;
  for(kkk = 0; kkk < NUM_PLANETS + 1; kkk++) {
    pPLT_HAS_ASP_TBL[kkk] = 0;
  }
  for(kkk = 0; kkk <  TOT_CATEGORIES; kkk++) {
    for(mmm = 0; mmm < NUM_PLUS_OR_MINUS_CATEGORIES; mmm++) {
      pGRH_DATA[kkk][mmm] = 0;
    }
  }

  add_all_placements_to_grh_data();
  p_add_all_asps_to_grh_data();



/* for test*/
/*   int n; char *p = &Swk[0];
*   n = sprintf(p,"%s|%5d|%5d|%5d|\n", pEVENT_NAME,
*     pGRH_DATA[18][0], pGRH_DATA[18][1], pGRH_DATA[18][0] + pGRH_DATA[18][1]); fput(p,n,stderr);
*   fclose_fpdb_for_debug();
*   return(0);
*/



  /* new way of calc grh num_stars abandoned jun 2013
  */
  /* check_grh_data(); abandoned */

  p_put_aspect_strings();
  put_sgn_and_hse_strings();
  set_doc_for_grh();
  p_make_special_graphs();
/* <.> */

  docn = sprintf(docp,"[end_graph]");
  p_docin_put(docp, docn);


  if (strcmp(gbl_output_instructions, "no output, csv string only") == 0) {
    strcpy(string_buffer_for_trait_csv, gblBuffTraitScoresCSV);
    return(0);
  }
  /* NOW, May 2014, stringBuffForTraitCSV, is ALWAYS populated with trait scores */
/*   strcpy(string_buffer_for_trait_csv, gblBuffTraitScoresCSV); */


  docn = sprintf(docp,"\n\n[beg_aspects]\n");
  p_docin_put(docp, docn);

  make_paras();  /* for aspects */

  docn = sprintf(docp,"[end_aspects]\n");
  p_docin_put(docp, docn);

  docn = sprintf(docp,"\n[end_program]\n");
  p_docin_put(docp, docn);




  /* HTML HTML HTML HTML HTML HTML HTML HTML HTML HTML 
  */
    
  /* html report produced here
  */
  int retval, retval2;
/* tn();b(130);ksn(html_output_filename); */
  retval = make_per_htm_file(
    html_output_filename_webview,
    docin_lines,
    docin_idx,
    "make html for webview"
  );
//  if (retval != 0) {
//    p_docin_free();      /* free all allocated array elements */
//    // rkabort("Error: html file was not produced");
//    return 1;
//  }
  retval2 = make_per_htm_file(
    html_output_filename_browser,
    docin_lines,
    docin_idx,
    "make html for browser"
  );
  if (retval != 0 || retval2 != 0) {
    p_docin_free();      /* free all allocated array elements */
    //rkabort("Error: html file was not produced");
    return 1;
  }


#ifdef DO_STDERR_DEBUG 
  int ii;
  for (ii = 0; ii <= docin_idx; ii++) {
    strcpy(Swk, docin_lines[ii] );
    fprintf(stderr,"%s", Swk);
  }
#endif
  p_docin_free();

  if (strstr(instructions, "return only") == NULL) {
    trn("end of mamb_report_personality()"); 
  }  /* avoid dbmsg on non-rpt call */

  fclose_fpdb_for_debug();
  return(0);

} /* end of mamb_report_personality() */


/* add a line to the array of docin_lines
*  replaces this:  fput(p,n,Fp_docin_file); 
*  
*  eg 1
*  * fput(p,n,Fp_docin_file); * 
* p_docin_put(docp,docn);
*    
*  eg 2
*  *fprintf(pFP_DOCIN_FILE,"\n[end_program]\n"); *
*  ndoc = sprintf(p,"\n[end_program]\n");
*  p_docin_put(docp, docn);
*/
void p_docin_put(char *line, int length)
{
  
  if (strcmp(gbl_output_instructions, "no output, csv string only") == 0) return; 

  if (is_first_p_docin_put == 1) docin_idx = 0;
  else                           docin_idx++;

  docin_lines[docin_idx] = malloc(length + 1);

  if (docin_lines[docin_idx] == NULL) {
    sprintf(errbuf, "malloc failed, arridx=%d, linelen=%d, line=[%s]\n",
      docin_idx, length, line);
    rkabort(errbuf);
  }

  strcpy(docin_lines[docin_idx], line);

  is_first_p_docin_put = 0;  /* set to no */
  
  /* When this function finishes,
  * the index docin_idx points at the last line written.
  * Therefore, the current docin_lines written
  * run from index = 0 to index = docin_idx. (see p_docin_free() below)
  */
}

/* Free the memory allocated for every member of docin_lines array.
*/
void p_docin_free(void)
{
  int i;
/* tn(); trn("in p_docin_free()");ki(docin_idx); */
/* tn(); */
  for (i = 0; i <= docin_idx; i++) {
    free(docin_lines[i]);    docin_lines[i] = NULL;
  }
  docin_idx = 0;  /* pts to last array index populated */
}


/* void p_arg_abort(void)
* {
*   fprintf(stderr,"\nfut.exe.  argument number problem. ");
*   fprintf(stderr,"\n  use:");
*   fprintf(stderr,"\n fut.exe Fred 3 21 1987 11 58 1 5 80.34  # 0 args + pgmname");
*   fprintf(stderr,"\n  strcpy(pEVENT_NAME, argv[1]);");
*   fprintf(stderr,"\n  Inmn = atof(argv[2]);   mth  date of birth ");
*   fprintf(stderr,"\n  Indy = atof(argv[3]);   day ");
*   fprintf(stderr,"\n  Inyr = atof(argv[4]);   year ");
*   fprintf(stderr,"\n  Inhr = atof(argv[5]);   hour ");
*   fprintf(stderr,"\n  Inmu = atof(argv[6]);   minute ");
*   fprintf(stderr,"\n  Inap = atoi(argv[7]);   am,0 or pm,1 ");
*   fprintf(stderr,"\n  Intz = atof(argv[8]);   dob_city_diff_hrs_from_greenwich ");
*   fprintf(stderr,"\n  Inln = atof(argv[9]);  dob_city_longitude ");
* 
*   rkabort("should be 9 args\n");
* } 
*/


void p_make_special_graphs(void)
{
/* trn("in p_make_special_graphs()"); */

  /* in fn do_special_line()
  * num_stars must be set to zero the first time thru for an html file
  */
/*   is_first_p_special_line = 1;  */

/*   fprintf(pFP_DOCIN_FILE,"\n[beg_agrsv]\n"); */
  docn = sprintf(docp,"\n[beg_agrsv]\n");
  p_docin_put(docp, docn);
  do_special_line(IDX_FOR_AGGRESSIVE);
  docn = sprintf(docp,"\n[end_agrsv]\n");
  p_docin_put(docp, docn);

  docn = sprintf(docp,"[beg_sensi]\n");
  p_docin_put(docp, docn);
  do_special_line(IDX_FOR_SENSITIVE);
  docn = sprintf(docp,"[end_sensi]\n");
  p_docin_put(docp, docn);
  docn = sprintf(docp,"[beg_sensi]\n");

  docn = sprintf(docp,"[beg_restl]\n");
  p_docin_put(docp, docn);
  do_special_line(IDX_FOR_RESTLESS);
  docn = sprintf(docp,"[end_restl]\n");
  p_docin_put(docp, docn);

  docn = sprintf(docp,"[beg_earth]\n");
  p_docin_put(docp, docn);
  do_special_line(IDX_FOR_DOWN_TO_EARTH);
  docn = sprintf(docp,"[end_earth]\n");
  p_docin_put(docp, docn);

  docn = sprintf(docp,"[beg_sexdr]\n");
  p_docin_put(docp, docn);
  do_special_line(IDX_FOR_SEX_DRIVE);
  docn = sprintf(docp,"[end_sexdr]\n");
  p_docin_put(docp, docn);

/*  removed jun 2013
*   docn = sprintf(docp,"[beg_bgmth]\n");
*   p_docin_put(docp, docn);
*   do_special_line(IDX_FOR_BIG_MOUTH);
*   docn = sprintf(docp,"[end_bgmth]\n");
*   p_docin_put(docp, docn);
*/

  docn = sprintf(docp,"[beg_upndn]\n");
  p_docin_put(docp, docn);
  do_special_line(IDX_FOR_UPS_AND_DOWNS);
  docn = sprintf(docp,"[end_upndn]\n");
  p_docin_put(docp, docn);

/* trn("end of  p_make_special_graphs()"); */



/* for test! <.> new! */
/* add_integratedness_lack_to_ups_and_downs(); */ /* using gblBuffTraitScoresCSV */





}  /* end of p_make_special_graphs() */

void do_special_line(int grh_data_idx)
{

  static int num_stars; /* static 01May87_fri_08:01pm */
  ;
/* trn(" in do_special_line() ");  */

  /* new way of calcing num_stars is abandoned  jun2013
  */
  
  /* old way of calcing num_stars 
  */

/* kin(grh_data_idx); */
  if (grh_data_idx == IDX_FOR_UPS_AND_DOWNS) {
    num_stars  = abs(pGRH_DATA[grh_data_idx][PLUS_OR_MINUS_IDX_FOR_BAD]);
  } else {
    num_stars  = abs(pGRH_DATA[grh_data_idx][PLUS_OR_MINUS_IDX_FOR_GOOD]);
    num_stars += abs(pGRH_DATA[grh_data_idx][PLUS_OR_MINUS_IDX_FOR_BAD]);
  }

  num_stars /= (pGRAPH_FACTOR * 2);

  adjust_stars(grh_data_idx, &num_stars);

  if (num_stars == 0) num_stars = 1; /*no blank line- at least 1 star*/

  p_mk_grh_line(num_stars,grh_data_idx);

}  /* end of do_special_line() */

void adjust_stars(int grh_data_idx, int *pnum_stars)
{
/* trn("in adjust_stars()"); */
  switch (grh_data_idx) {
  case IDX_FOR_AGGRESSIVE:
  case IDX_FOR_SENSITIVE:
  case IDX_FOR_DOWN_TO_EARTH:
  case IDX_FOR_RESTLESS:
  case IDX_FOR_SEX_DRIVE:

    /* *pnum_stars = max(1,*pnum_stars - pSUBTRACT_FROM_STARS); */
    if (1 > (*pnum_stars - pSUBTRACT_FROM_STARS) ) {
      *pnum_stars = 1;
    } else {
      *pnum_stars =  *pnum_stars - pSUBTRACT_FROM_STARS;
    }

    break;
  case IDX_FOR_BIG_MOUTH:
  case IDX_FOR_UPS_AND_DOWNS:
    *pnum_stars = *pnum_stars * 2;  /* 2 is magic adjust */

    /* *pnum_stars = max(1,*pnum_stars - pSUBTRACT_FROM_STARS); */

    if (1 > (*pnum_stars - pSUBTRACT_FROM_STARS) ) {
      *pnum_stars = 1;
    } else {
      *pnum_stars =  *pnum_stars - pSUBTRACT_FROM_STARS;
    }

    break;
  }
}  /* end of adjust_stars() */


void p_mk_grh_line(int num_stars, int category)
{
  int benchmark_score, upndn_score; int PERCENTILE_RANK_SCORE;

  benchmark_score = mapNumStarsToBenchmarkNum(category, num_stars);

  PERCENTILE_RANK_SCORE = mapBenchmarkNumToPctlRank(benchmark_score);


  if (category == IDX_FOR_AGGRESSIVE) {
/*     sprintf(gblBuffTraitScoresCSV, "%d", benchmark_score); */
    sprintf(gblBuffTraitScoresCSV, "%d", PERCENTILE_RANK_SCORE);
  } else {
    if (category == IDX_FOR_UPS_AND_DOWNS) {
      sprintf(gblBuffTraitScoresCSV, 
        "%s,%d", gblBuffTraitScoresCSV, benchmark_score);
    } else {
      sprintf(gblBuffTraitScoresCSV, 
        "%s,%d", gblBuffTraitScoresCSV, PERCENTILE_RANK_SCORE);
    }
  }


  if (category == IDX_FOR_UPS_AND_DOWNS) {
    /* putting this here only works because ups and downs 
    *  is the *last* (6th) item in gblBuffTraitScoresCSV
    *  so that csv is fully built here.
    */
    add_integratedness_lack_to_ups_and_downs(); /* using gblBuffTraitScoresCSV */

    upndn_score = atoi(csv_get_field(gblBuffTraitScoresCSV, ",", 6));

    PERCENTILE_RANK_SCORE =
      mapBenchmarkNumToPctlRank(upndn_score);


/*     docn = sprintf(docp, "%d\n", upndn_score);  */
    docn = sprintf(docp, "%d\n", PERCENTILE_RANK_SCORE); 
    p_docin_put(docp, docn);

  } else {
    docn = sprintf(docp, "%d\n", PERCENTILE_RANK_SCORE); 
    p_docin_put(docp, docn);
  }


}  /* end of p_mk_grh_line() */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /*  research numbers
* */
* void make_sign_good_bad(void)  /* back in jan93.  See below */
* {
*   strcpy(pSIGNOUT_PATHNAME,"");    /* init */
*   strcpy(pSIGNOUT_PATHNAME,"pp");    /* start with "pp" */
*   strcat(pSIGNOUT_PATHNAME,pORDNUM);  /* add order number */
*   if ((pFP_SIGNOUT_FILE= fopen(&pSIGNOUT_PATHNAME[0],WRITE_MODE))
*     == NULL) {
*     rkabort("pp.c. open_fut_output_file(). fopen().");
*   }
*   make_a_sign_good_bad(PLUS_OR_MINUS_IDX_FOR_GOOD);
*   make_a_sign_good_bad(PLUS_OR_MINUS_IDX_FOR_BAD);
*   fprintf(pFP_SIGNOUT_FILE,"\n");
*   fflush(pFP_SIGNOUT_FILE);
*   fclose(pFP_SIGNOUT_FILE);
* }  /* end of make_sign_good_bad() */
* 
* void make_a_sign_good_bad(int plus_or_minus)
* {
*   int k,num_stars;
*   ;
*   for (k=0; k <= NUM_SIGNS-1; ++k) {  /* not tot_cat */
*     num_stars = abs(pGRH_DATA[k][plus_or_minus] / pGRAPH_FACTOR);
*     if (plus_or_minus == PLUS_OR_MINUS_IDX_FOR_GOOD)
*        num_stars *= BEST_MULTIPLIER;  /* just to make best grhs better */
*     if (num_stars == 0) num_stars = 1; /*no blank line- at least 1 star*/
*     fprintf(pFP_SIGNOUT_FILE,"%d,", num_stars);
*   }
* }  /* end of make_a_sign_good_bad() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/





void p_wrap_grh_line(int num_stars, int category)
{
  char sformat[20];
  int i,last_line_stars;
  ;
/* tn();trn("in p_wrap_grh_line()");ki(num_stars);ki(category) ; */

  sfill(swk,MAX_STARS,GRH_CHAR);
  sprintf(sformat,"%%%ds\n",MAX_STARS);
  docn = sprintf(docp, sformat, swk); 
  p_docin_put(docp, docn);

  /* prt all full lines after 1st */
  for (i=2; i <= num_stars/MAX_STARS; ++i) {
    docn = sprintf(docp, sformat,swk);
    p_docin_put(docp, docn);
  }
  if ((last_line_stars = (num_stars % MAX_STARS)) == 0) return;

  sfill(swk,last_line_stars,GRH_CHAR);
  sprintf(sformat,"%%%ds\n",MAX_STARS);
  docn = sprintf(docp, sformat, swk);
  p_docin_put(docp, docn);
}  /* end of p_wrap_grh_line() */

void set_doc_for_grh(void)
{
  docn = sprintf(docp,"\n[beg_graph]");
  p_docin_put(docp, docn);
}  /* end of set_doc_for_grh() */


void store_sgn_and_hse_placements(void)
{
  int i;
  ;
  for (i=1; i <= NUM_PLANETS; ++i) {
    pAR_SGN[i] = p_get_sign(ar_minutes_natal[i]);
    pAR_HSE[i] = p_get_house(ar_minutes_natal[i],ar_minutes_natal[13]);
  }
}  /* end of store_sgn_and_hse_placements() */

void add_all_placements_to_grh_data(void)
{
  int plt;
  int starting_planet;  /* default=1, world affairs=6 */

  int doing_world_affairs; 

  doing_world_affairs = 0;
  if (doing_world_affairs == 1) {
    starting_planet = 6; 
  } else {
    starting_planet = 1;
  }

  for (plt=starting_planet; plt <= NUM_PLANETS; ++plt) {
    add_a_placement_to_grh_data(plt);
  }

  stderr_grh_data(); /* for checking */


}  /* end of add_all_placements_to_grh_data() */

void stderr_grh_data(void) {
  ;
/*   int n; char *p = &Swk[0]; */

#ifdef DO_STDERR_DEBUG
  int n; char *p = &Swk[0];
  int ccc;

  for(ccc = 0; ccc <  TOT_CATEGORIES; ccc++) {
    n = sprintf(p,"%2d|%5d|%5d|\n",ccc+1,
        pGRH_DATA[ccc][0],
        pGRH_DATA[ccc][1] );
    fput(p,n,stderr);
  }
  int tot1,tot2;
  tot1 =  pGRH_DATA[0][0] + pGRH_DATA[4][0] + pGRH_DATA[8][0];
  n = sprintf(p,"\nfir|%5d|",tot1); fput(p,n,stderr);
  tot2 =  pGRH_DATA[0][1] + pGRH_DATA[4][1] + pGRH_DATA[8][1];
  n = sprintf(p,"%5d|%5d|\n",tot2,tot1+tot2); fput(p,n,stderr);

  tot1 =  pGRH_DATA[1][0] + pGRH_DATA[5][0] + pGRH_DATA[9][0];
  n = sprintf(p,"ear|%5d|",tot1); fput(p,n,stderr);
  tot2 =  pGRH_DATA[1][1] + pGRH_DATA[5][1] + pGRH_DATA[9][1];
  n = sprintf(p,"%5d|%5d|\n",tot2,tot1+tot2); fput(p,n,stderr);

  tot1 =  pGRH_DATA[2][0] + pGRH_DATA[6][0] + pGRH_DATA[10][0];
  n = sprintf(p,"air|%5d|",tot1); fput(p,n,stderr);
  tot2 =  pGRH_DATA[2][1] + pGRH_DATA[6][1] + pGRH_DATA[10][1];
  n = sprintf(p,"%5d|%5d|\n",tot2,tot1+tot2); fput(p,n,stderr);

  tot1 =  pGRH_DATA[3][0] + pGRH_DATA[7][0] + pGRH_DATA[11][0];
  n = sprintf(p,"wat|%5d|",tot1); fput(p,n,stderr);
  tot2 =  pGRH_DATA[3][1] + pGRH_DATA[7][1] + pGRH_DATA[11][1];
  n = sprintf(p,"%5d|%5d|\n\n",tot2,tot1+tot2); fput(p,n,stderr);

  n = sprintf(p,"agrsv|%5d|%5d|%5d|\n", pGRH_DATA[12][0], pGRH_DATA[12][1], pGRH_DATA[12][0] + pGRH_DATA[12][1]); fput(p,n,stderr);
  n = sprintf(p,"sensi|%5d|%5d|%5d|\n", pGRH_DATA[13][0], pGRH_DATA[13][1], pGRH_DATA[13][0] + pGRH_DATA[13][1]); fput(p,n,stderr);
  n = sprintf(p,"restl|%5d|%5d|%5d|\n", pGRH_DATA[14][0], pGRH_DATA[14][1], pGRH_DATA[14][0] + pGRH_DATA[14][1]); fput(p,n,stderr);
  n = sprintf(p,"earth|%5d|%5d|%5d|\n", pGRH_DATA[15][0], pGRH_DATA[15][1], pGRH_DATA[15][0] + pGRH_DATA[15][1]); fput(p,n,stderr);
  n = sprintf(p,"sexdr|%5d|%5d|%5d|\n", pGRH_DATA[16][0], pGRH_DATA[16][1], pGRH_DATA[16][0] + pGRH_DATA[16][1]); fput(p,n,stderr);
  n = sprintf(p,"bgmth|%5d|%5d|%5d|\n", pGRH_DATA[17][0], pGRH_DATA[17][1], pGRH_DATA[17][0] + pGRH_DATA[17][1]); fput(p,n,stderr);
  n = sprintf(p,"upndn|%5d|%5d|%5d|\n", pGRH_DATA[18][0], pGRH_DATA[18][1], pGRH_DATA[18][0] + pGRH_DATA[18][1]); fput(p,n,stderr);
#endif
} /* end of stderr_grh_data() */


/* abandoned
*/
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void check_grh_data(void) {
*   ;
* /* trn("in check_grh_data()"); */
* /*   int n; char *p = &Swk[0]; */
*   int tot1,tot2,tot3,tot4;
*   int agrsv,sensi,restl,earth,sexdr,bgmth,upndn;
* 
*   tot1 =  pGRH_DATA[0][0] + pGRH_DATA[4][0] + pGRH_DATA[8][0]  +  /* fir */
*           pGRH_DATA[0][1] + pGRH_DATA[4][1] + pGRH_DATA[8][1];
* 
*   tot4 =  pGRH_DATA[3][0] + pGRH_DATA[7][0] + pGRH_DATA[11][0] +  /* wat */
*           pGRH_DATA[3][1] + pGRH_DATA[7][1] + pGRH_DATA[11][1];
* 
*   tot3 =  pGRH_DATA[2][0] + pGRH_DATA[6][0] + pGRH_DATA[10][0] +  /* air */
*           pGRH_DATA[2][1] + pGRH_DATA[6][1] + pGRH_DATA[10][1];
* 
*   tot2 =  pGRH_DATA[1][0] + pGRH_DATA[5][0] + pGRH_DATA[9][0]  +  /* ear */
*           pGRH_DATA[1][1] + pGRH_DATA[5][1] + pGRH_DATA[9][1];
* 
*   /* 
*   *   fprintf(fpdat,"%-15s|%5d|%5d|%5d|%5d|",pEVENT_NAME,tot1,tot4,tot3,tot2);
*   * 
*   *   fprintf(fpdat,"%5d|", pGRH_DATA[12][0] + pGRH_DATA[12][1]); 
*   *   fprintf(fpdat,"%5d|", pGRH_DATA[13][0] + pGRH_DATA[13][1]); 
*   *   fprintf(fpdat,"%5d|", pGRH_DATA[14][0] + pGRH_DATA[14][1]); 
*   *   fprintf(fpdat,"%5d|", pGRH_DATA[15][0] + pGRH_DATA[15][1]); 
*   */
* 
*   agrsv = pGRH_DATA[12][0] + pGRH_DATA[12][1] + tot1;  /* agrsv fld10 */
*   sensi = pGRH_DATA[13][0] + pGRH_DATA[13][1] + tot4;  /* sensi fld11 */
*   restl = pGRH_DATA[14][0] + pGRH_DATA[14][1] + tot3;  /* restl fld12 */
*   earth = pGRH_DATA[15][0] + pGRH_DATA[15][1] + tot2;  /* earth fld13 */
* 
*   /* change median score to 100
*   */
*   agrsv = (int) ((double)agrsv / 56.74 ); 
*   sensi = (int) ((double)sensi / 54.18 ); 
*   restl = (int) ((double)restl / 52.79 ); 
*   earth = (int) ((double)earth / 51.36 ); 
* 
* 
*   fprintf(fpdat,"%-15s|",pEVENT_NAME);
* 
* 
*   gbl_num_stars_agrsv = adjust_score(agrsv);
*   gbl_num_stars_sensi = adjust_score(sensi);
*   gbl_num_stars_restl = adjust_score(restl);
*   gbl_num_stars_earth = adjust_score(earth);
* 
* 
*   fprintf(fpdat,"%5d|", gbl_num_stars_agrsv);
*   fprintf(fpdat,"%5d|", gbl_num_stars_sensi);
*   fprintf(fpdat,"%5d|", gbl_num_stars_restl);
*   fprintf(fpdat,"%5d|", gbl_num_stars_earth);
* 
* 
*   sexdr = pGRH_DATA[16][0] + pGRH_DATA[16][1]; 
*   bgmth = pGRH_DATA[17][0] + pGRH_DATA[17][1]; 
*   upndn = pGRH_DATA[18][0] + pGRH_DATA[18][1]; 
* 
*   /* change median score to 100
*   */
*   sexdr = (int) ((double)sexdr / 37.89 ); 
*   bgmth = (int) ((double)bgmth /  9.01 ); 
*   upndn = (int) ((double)upndn / 18.30 ); 
* 
* 
*   gbl_num_stars_sexdr = adjust_score(sexdr);
*   gbl_num_stars_bgmth = adjust_score(bgmth);
*   gbl_num_stars_upndn = adjust_score(upndn);
* 
* 
*   fprintf(fpdat,"%5d|",   gbl_num_stars_sexdr); 
*   fprintf(fpdat,"%5d|",   gbl_num_stars_bgmth); 
*   fprintf(fpdat,"%5d|\n", gbl_num_stars_upndn); 
* 
* } /* end of check_grh_data() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

/*   100     want
*   score  num_stars   pctl
*
*    330   246 (3 rows) top
*    175   164 (2 rows)  90
*    130    82 (1 row)   75
*    100    25           50  between less important and important
*     75    12           25
*     30     1          bot
*
*    74 stars remarkable      (74th pctl)  
*    44 stars important       (60th pctl)
*    16 stars less important  (35th pctl)
*
*  group 309 people
*   pctl   rank score
*     90     31   140
*     75     77    80
*     50    155    25
*     25    231    12
*     10    278     8
*
*          1         2         3         4         5         6         7         8         9        10
* 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 
* ----------------------------------------------------------------------------------------------------
* 30                     75                      100                      130            175       330
*  1 star                12 stars                 25 stars                 82 stars      164 stars 246 stars
*                                                                         1row           2rows     3rows
*                |                           |                             |          
*           less important                   important                     remarkable 
*                35th pctl                   60th pctl                     74th pctl  
* 
*/
/* sl + (wh - wl) * (score - sl) / (sh - sl) 
*  e.g. score=40 is between 30 and 75, want between 1 and 12 
*       sl 30  sh 75  score = 40    wl  1  wh 12
*       30 + (12 - 1) * (40 - 30) / (75 - 30)
*       = 32.44  is 32 numstars
*/
/* abandoned
*/
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* int adjust_score(int score)
* {
*   if (score <=30) return (1);  /* bot */
*   if (score <= 75) {
*     /* sl + (wh - wl) * (score - sl) / (sh - sl)  */
*     /* score between 30 and 75, want between 1 and 12 */
*     score = 1 + (int) ((double)(12 -  1) * (double)(score - 30) / (double)( 75 - 30));
*     return (score);
*   }
*   if (score >  75 && score <= 100) {
*     /* score between 75 and 100, want between 12 and 25 */
*     score = 12 + (int) ((double)(25 - 12) * (double)(score - 75) / (double)(100 - 75));
*     return (score);
*   }
*   if (score > 100 && score <= 130) {
*     /* score between 100 and 130, want between 25 and 82 */
*     score = 25 + (int) ((double)(82 - 25) * (double)(score - 100) / (double)(130 - 100));
*     return (score);
*   }
*   if (score > 130 && score <= 175) {
*     /* score between 130 and 175, want between 82 and 164 */
*     score = 82 + (int) ((double)(164 - 82) * (double)(score - 130) / (double)(175 - 130));
*     return (score);
*   }
*   if (score > 175 && score <= 330) {
*     /* score between 175 and 330, want between 164 and 246 */
*     score = 164 + (int) ((double)(246 - 164) * (double)(score - 175) / (double)(330 - 175));
*     return (score);
*   }
*   if (score > 330) {
*     score = (int)(330.0 + (double)(score  - 330) / 2.0);
*     return (score);
*   }
*   return(1);  
* } /* adjust_score() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/




/* note: aspects must have been done here to know about free-float */
void add_a_placement_to_grh_data(int plt)
{
  int cat,addval;
#ifdef DO_STDERR_DEBUG
  int n, sign; char *p = &Swk[0];
#endif
  ;
  /* for each of the 12 + 7 categories
  */
  for (cat=0; cat <= TOT_CATEGORIES-1; ++cat) {

#ifdef DO_STDERR_DEBUG
    sign = p_get_sign(ar_minutes_natal[plt]);
    n = sprintf(p,"\n%-15s|plc|%2d|%s|%s|%2dH",
    pEVENT_NAME,cat+1,pN_PLANET[plt],pN_SIGN[sign],pAR_HSE[plt]); fput(p,n,stderr);
#endif

    /* get addval for SIGN
    */
    addval = pPLACEMENT_MULTIPLIER_SIGN*
             pSGN_OVER_HSE_FACTOR *
             get_plt_in_12(plt-1, pAR_SGN[plt]-1, cat);

    pGRH_DATA[cat][PLUS_OR_MINUS_IDX_FOR_GOOD] += addval;  /* adds to good */

#ifdef DO_STDERR_DEBUG
    n = sprintf(p,"|sgn=|%4d", addval); fput(p,n,stderr);
#endif

    /* get addval for HOUSE
    */
    addval = pPLACEMENT_MULTIPLIER_HOUSE*
             pCONSIDER_HOUSE_FACTOR[cat] *
             get_plt_in_12(plt-1, pAR_HSE[plt]-1, cat);

    pGRH_DATA[cat][PLUS_OR_MINUS_IDX_FOR_GOOD] += addval;  /* adds to good */

#ifdef DO_STDERR_DEBUG
    n = sprintf(p,"|hse=|%4d", addval); fput(p,n,stderr);
#endif


    /* get addval for BAD due to free-floating
    */
    if (pPLT_HAS_ASP_TBL[plt] == 0) {             /* free-floating? */
      addval = addval * FREE_FLOATING_MULTIPLIER; /* was 4 then 2 */

    pGRH_DATA[cat][PLUS_OR_MINUS_IDX_FOR_BAD]  += addval;

#ifdef DO_STDERR_DEBUG
    n = sprintf(p,"|ffl=|%5d|", addval); fput(p,n,stderr);
#endif

    }
  } /* for each of the 12 + 7 categories */

#ifdef DO_STDERR_DEBUG
  n = sprintf(p,"\n\n"); fput(p,n,stderr);
#endif

}  /* end of add_a_placement_to_grh_data() */


void store_pp_aspects(void)
{
  int i,k;  /* i=1st plt, k=2nd plt */
  ;

  for (i=1; i <= NUM_PLANETS-1; ++i) {
    for (k=i+1; k <= NUM_PLANETS; ++k) {
      pAR_ASP[i][k] = p_isaspect(ar_minutes_natal[i],
        ar_minutes_natal[k],&pORBS_NAT[0]);
    }
  }
}  /* end of store_pp_aspects() */

void p_add_all_asps_to_grh_data(void)
{
  int i,k;  /* i=1st plt, k=2nd plt */
  int starting_planet;  /* default=1, world affairs=6 */
  int doing_world_affairs; /* 1=y, 0=n */
  int my_aspect_id;

#ifdef DO_STDERR_DEBUG
  int n; char *p = &Swk[0];
  n = sprintf(p,"\n"); fput(p,n,stderr); 
#endif

  doing_world_affairs = 0;  /* 1=y, 0=n */
  if (doing_world_affairs == 1) {
    starting_planet = 6;  /* default=1, world affairs=6 */
  } else {
    starting_planet = 1;  /* default=1, world affairs=6 */
  }


/*   for (i=1; i <= NUM_PLANETS-1; ++i) { */

  for (i=starting_planet; i <= NUM_PLANETS-1; ++i) {
    for (k=i+1; k <= NUM_PLANETS; ++k) {
      if (pAR_ASP[i][k] != 0) {

         /* int pAR_ASP[NUM_PLANETS+1][NUM_PLANETS+1]; */
         /* int pASPECT_ID[NUM_ASPECTS+1] = */
         /*     {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9}; */
         /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
         /* degrees  x  0  60   90   120   180   240   270   300  360 */
        my_aspect_id = pAR_ASP[i][k];  

        p_add_an_asp_to_grh_data(i, k, my_aspect_id);
#ifdef DO_STDERR_DEBUG
        n = sprintf(p,"\n"); fput(p,n,stderr); 
#endif
      }
    }
  }

#ifdef DO_STDERR_DEBUG
  n = sprintf(p,"\nafter add_all_asps_to_grh_data()\n"); fput(p,n,stderr); 
#endif
  stderr_grh_data(); /* for checking */

}  /* end of p_add_all_asps_to_grh_data() */



/* note: pAR_SGN & hse tbls must have been filled in before this */
void p_add_an_asp_to_grh_data(int plt1, int plt2, int aspect_id)
{
  int cat,addval;
  double a,b,c,d,e, final_amt;
  ;


  pPLT_HAS_ASP_TBL[plt1] = 1;
  pPLT_HAS_ASP_TBL[plt2] = 1;
  if (pMOON_CONFIDENCE == 0 && 
    (plt1 == NAT_PLT_NUM_FOR_MOON || plt2 == NAT_PLT_NUM_FOR_MOON))
    return;

#ifdef DO_STDERR_DEBUG
  int n, sign1,sign2; char *p = &Swk[0];
  sign1 = p_get_sign(ar_minutes_natal[plt1]);
  sign2 = p_get_sign(ar_minutes_natal[plt2]);
#endif

  /* for each of the 12 + 7 categories
  */
  for (cat=0; cat <= TOT_CATEGORIES-1; ++cat) {

#ifdef DO_STDERR_DEBUG
    n = sprintf(p,"%-15s|asp|%2d|%s|%s|%2dH|%s|%s|%2dH|",
      pEVENT_NAME, cat + 1,
      pN_PLANET[plt1],pN_SIGN[sign1], pAR_HSE[plt1],
      pN_PLANET[plt2],pN_SIGN[sign2], pAR_HSE[plt2] ); fput(p,n,stderr);
#endif

    /* a = weight of SIGN  of plt1 in aspect = (plt1 <--> plt2)
    */
    a = (double) (pSGN_OVER_HSE_FACTOR *
        get_plt_in_12(plt1-1, pAR_SGN[plt1]-1, cat));


    /* b = weight of HOUSE of plt1 in aspect = (plt1 <--> plt2)
    */
    if (pHOUSE_CONFIDENCE == 0) b = a / pSGN_OVER_HSE_FACTOR;
    else b = (double)pCONSIDER_HOUSE_FACTOR[cat] *
              get_plt_in_12(plt1-1, pAR_HSE[plt1]-1, cat);


    /* c = weight of SIGN  of plt2 in aspect = (plt1 <--> plt2)
    */
    c = (double) (pSGN_OVER_HSE_FACTOR *
        get_plt_in_12(plt2-1, pAR_SGN[plt2]-1, cat));

    /* d = weight of HOUSE of plt2 in aspect = (plt1 <--> plt2)
    */
    if (pHOUSE_CONFIDENCE == 0) d = c / pSGN_OVER_HSE_FACTOR;
    else d = (double)pCONSIDER_HOUSE_FACTOR[cat] *
              get_plt_in_12(plt2-1, pAR_HSE[plt2]-1, cat);

    /* e = aspect_multiplier
    */
         /* int pAR_ASP[NUM_PLANETS+1][NUM_PLANETS+1]; */

         /* int pASPECT_ID[NUM_ASPECTS+1] = */
         /*     {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9}; */
         /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
         /* degrees  x  0  60   90   120   180   240   270   300  360 */

         /* my_aspect_id = pAR_ASP[i][k];   */

         /* int pASPECT_TYPE[NUM_ASPECTS+1] = */
         /*     {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0}; */
         /* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */

    e = p_get_aspect_multiplier(pASPECT_TYPE[aspect_id], plt1, plt2, cat);

    /* addval = intermediate number (considering aspect_force)
    */
    addval = (int) (pCURRENT_ASPECT_FORCE * pMOON_CONFIDENCE_FACTOR *
      e * (sqrt(a*a+b*b)+sqrt(c*c+d*d)));


#ifdef DO_STDERR_DEBUG
n = sprintf(p,"%5.0f|%5.0f|%5.0f|%5.0f|%5.0f|%7d|", a,b,c,d,e,addval); fput(p,n,stderr);
#endif

    if (addval >  0) {
      final_amt = addval * BEST_MULTIPLIER; /*2*/
    } else {
      final_amt = addval * pLESSON_MULTIPLIER; /*5*/
    }


#ifdef DO_STDERR_DEBUG
n = sprintf(p,"%6.0f|\n", final_amt); fput(p,n,stderr);
#endif

    if (addval >  0) {
      pGRH_DATA[cat][PLUS_OR_MINUS_IDX_FOR_GOOD] +=  final_amt;
    } else {
      pGRH_DATA[cat][PLUS_OR_MINUS_IDX_FOR_BAD]  -=  final_amt;
    }

  } /* for each of the 12 + 7 categories */

}  /* end of add_asp_to_grh_data() */


         /* int pAR_ASP[NUM_PLANETS+1][NUM_PLANETS+1]; */
         /* int pASPECT_ID[NUM_ASPECTS+1] = */
         /*     {0,  1,   2,   3,   4,    5,    6,    7,    8  ,9}; */
         /* name x cnj  sxt  squ  tri   opp   tri   squ   sxt  cnj */
         /* degrees  x  0  60   90   120   180   240   270   300  360 */
         /* my_aspect_id = pAR_ASP[i][k];   */
         /* int pASPECT_TYPE[NUM_ASPECTS+1] = */
         /*     {-1,  0,   1,   2,   1,    2,    1,    2,    1,    0}; */
         /* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */

int p_get_aspect_multiplier(int aspect_type, int plt1, int plt2, int category_num)
{    /* using for now 1 aspect_type, neg for unfvr aspects + some cnj */
  int plt_pairs_idx,temp;
  ;

  plt_pairs_idx = pPLT_PAIRS_IDX_TBL[plt1-1][plt2-1];

/* ki(plt_pairs_idx); */

/*******
*   temp = *(pASPECT_MULTIPLIER
*     +   aspect_type * (TOT_CATEGORIES) * NUM_PLT_PAIRS
*     + plt_pairs_idx * (TOT_CATEGORIES)
*     + category_num);
********/
  temp = *(pASPECT_MULTIPLIER
    +             0 * (TOT_CATEGORIES)* NUM_PLT_PAIRS
    + plt_pairs_idx * (TOT_CATEGORIES)
    + category_num);

/* if (category_num == 18) { ki(temp); }  */

  if (aspect_type == ASPECT_TYPE_IDX_FOR_UNFVR) temp *= (-1);  /* = 2 */
  if (aspect_type == ASPECT_TYPE_IDX_FOR_CNJ) {     /* = 0 */
    temp *= pNEG_CNJ_TBL[plt1-1][plt2-1];
  }

/* if (category_num == 18) { ki(temp); }  */

  return(temp);
}  /* end of p_get_aspect_multiplier() */

void put_sgn_and_hse_strings(void)
{
  int i;
  ;
  for (i=0; i <= NUM_PLT_FOR_PARAS-1; ++i) {
    ++pITEM_TBL_IDX;  /* init= -1 in p_init_item_tbl() */
    sprintf(pP_ITEM_TBL[pITEM_TBL_IDX],"%02d%1s%02d",
      i+1,  /* plt */
      "1",  /* 1=sgn 2=hse */
      pAR_SGN[i+1]);  /* sign */
    if (pHOUSE_CONFIDENCE == 1) {
      ++pITEM_TBL_IDX;
      sprintf(pP_ITEM_TBL[pITEM_TBL_IDX],"%02d%1s%02d",
        i+1,  /* plt */
        "2",  /* 1=sgn 2=hse */
        pAR_HSE[i+1]);  /* house */
    }
  }
}  /* end of put_sgn_and_hse_strings() */

void p_put_aspect_strings(void)
{
  int i,k;  /* i=1st plt  k=2nd plt */
  ;
  for (i=1; i <= NUM_PLT_FOR_PARAS; ++i) {
    for (k=i+1; k <= NUM_PLANETS; ++k) {
      if (pAR_ASP[i][k] == 0) continue;
      ++pITEM_TBL_IDX;
      sprintf(pP_ITEM_TBL[pITEM_TBL_IDX],"%02d%1s%02d",
        i,  /* plt1 */
        pN_SHORT_DOC_ASPECT[pASPECT_TYPE[pAR_ASP[i][k]]],
        k);  /* plt2 */
    }
  }
}  /* end of p_put_aspect_strings() */

void p_init_item_tbl(void)
{
  int i;
  ;
  for (i=0; i <= MAX_IN_ITEM_TBL-1; ++i) {
    pP_ITEM_TBL[i] = &pITEM_TBL[i*(SIZE_ITEM+1)];
  }
  pITEM_TBL_IDX = -1;  /* setup use as ++subscript */
}  /* end of p_init_item_tbl() */

void make_paras(void)
{
  int i;
  ;

/*  fprintf(pFP_DOCIN_FILE,"\n.(pptitle)\n"); */

  strsort(pP_ITEM_TBL,pITEM_TBL_IDX+1);

  for (i=0; i <= pITEM_TBL_IDX; ++i) {  /* idx pts to last element */

    /* fprintf(pFP_DOCIN_FILE,".sp\n");*/
    /* fprintf(pFP_DOCIN_FILE,"^(p%s)\n",pP_ITEM_TBL[i]); */
    /* docn = sprintf(docp, "^(p%s)\n", pP_ITEM_TBL[i]); */
    docn = sprintf(docp, "p%s\n", pP_ITEM_TBL[i]);
    p_docin_put(docp, docn);

    /* send these like "^(p02g05)" to docin instead of stdout
    */
/*     fprintf(stdout,"^(p%s)\n",pP_ITEM_TBL[i]);    * NOTE: * */
         /* ^to be piped to pick_stuff >ppdoc/@ in ws futin1 "pp */
    /* put 'p' at head of doc regis_ter name */
    /* (bad form to start with a number) */
  }

}  /* end of make_paras() */

/* m1,m2;     position in minutes of planets 1 and 2 
* *porbs;    ptr to ints (table of orbs)
*/
int p_isaspect(int m1, int m2, int *porbs)
{
  int i,itemp;
  ;
  itemp = abs(m1-m2);
  for (i=1; i <= NUM_ASPECTS; ++i) {
    if (itemp >  (*(pASPECTS+i) + *(porbs+i))) continue;  
    if (itemp <  (*(pASPECTS+i) - *(porbs+i))) return(0);  /* no aspect */
    p_calc_current_aspect_force(m1,m2,porbs,i);
    return(pASPECT_ID[i]);  /* found aspect */
  }
  return(0);    /* return of zero means no aspect found */
}  /* end of is_aspect() */


/* m1= position of plt1 in minutes */
void p_calc_current_aspect_force(int m1, int m2, int *porbs, int aspect_num)
{
  double orb,diff_from_exact;
  ;
  orb = (double)*(porbs+aspect_num);
  diff_from_exact = (double)abs(pASPECTS[aspect_num]-abs(m1-m2));
  pCURRENT_ASPECT_FORCE = BASE_CURRENT_ASPECT_FORCE +  /* 1.0< force <2.0 */
    sin(pPI_OVER_2*(orb-diff_from_exact)/orb);
}  /* end of p_calc_current_aspect_force() */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* start_up()
* {
*   if (get_fut_input(pARG_FUTIN_PATHNAME) == 0) return(0);
*     /* return val 1 (1) = ok (not eof) */
*   if (equal(pDO_PP,"n") || equal(pDO_PP,"N")) return(0);
* 
* /***
*   pPI_OVER_2 = dpie() / 2.0;
* ***/
*   pPI_OVER_2 = 3.1415926535897932384 / 2.0;
* 
*   if (pINCF == 1) {      /* 1=less than 1/2 hr wrong */
*     pHOUSE_CONFIDENCE = 1;
*     pMOON_CONFIDENCE = 1;
*     pMOON_CONFIDENCE_FACTOR = 1.0;  /* for moon_cf = yes, very accurate */
*   }
*   if (pINCF == 2) {      /* 2=between 1/2 hr and 2 hr wrong */
*     pHOUSE_CONFIDENCE = 0;
*     pMOON_CONFIDENCE = 1;
*     pMOON_CONFIDENCE_FACTOR = 1.0;  /* for moon_cf = yes, very accurate */
*   }
*   if (pINCF == 3) {      /* 3=completely uncertain time of day */
*     pHOUSE_CONFIDENCE = 0;
*     pMOON_CONFIDENCE = 0;
*     pMOON_CONFIDENCE_FACTOR = MOON_REPLACEMENT_FACTOR;
*   }
*   return(1);    /* not eof */
* }  /* end of start_up() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

/* puts positions in minutes 0 thru 360*60-1 */
/* into a planet position table */
/* ptr to ints (position table #1 or #2) */
void p_put_minutes(int *pi) 
{
  int i;
  ;
  *(pi+1) = p_get_minutes(Arco[1]);    /* sun */
  *(pi+2) = p_get_minutes(Arco[10]);  /* moon */
  for (i=3; i <= NUM_PLANETS; ++i) {  /* 3->10 (mer->plu) */
    *(pi+i) = p_get_minutes(Arco[i-1]);
  }
  *(pi+11) = p_get_minutes(Arco[11]);  /* nod */
  *(pi+12) = p_get_minutes(Arco[12]);  /* asc */
  *(pi+13) = p_get_minutes(Arco[13]);  /* mc_ */
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   pPRT_RETRO[1] = Retro[1];  /* these array elements are strings */
*   pPRT_RETRO[2] = Retro[10];  /* moon */
*   for (i=3; i <= NUM_PLANETS; ++i) {  /* 3->10 */
*     pPRT_RETRO[i] = Retro[i-1];
*   }
*   pPRT_RETRO[11] = Retro[11];
*   pPRT_RETRO[12] = Retro[12];
*   pPRT_RETRO[13] = Retro[13];
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
}  /* end of p_put_minutes() */

int p_get_minutes(double d)
{
/***
  return((int)round(60.0 * fnu(fnd(d) + 360.0)));  * converted to int *
***/
  return((int)ceil(60.0 * fnu(fnd(d) + 360.0)));  /* converted to int */
}  /* end of p_get_minutes() */



void init_bufs(void)
{
  sfill(&pEVENT_NAME[0],SIZE_INBUF,' ');
  sfill(&pMADD_LAST_NAME[0],SIZE_INBUF,' ');
  sfill(&pMADD_FIRST_NAMES[0],SIZE_INBUF,' ');
  sfill(&pMADD1[0],SIZE_INBUF,' ');
  sfill(&pMADD2[0],SIZE_INBUF,' ');
  sfill(&pCITY_TOWN[0],SIZE_INBUF,' ');
  sfill(&pPROV_STATE[0],SIZE_INBUF,' ');
  sfill(&pCOUNTRY[0],SIZE_INBUF,' ');
  sfill(&pPOSTAL_CODE[0],SIZE_INBUF,' ');
  sfill(&pLETTER_COMMENT_1[0],SIZE_INBUF,' ');
  sfill(&pLETTER_COMMENT_2[0],SIZE_INBUF,' ');
  sfill(&pIS_OK[0],SIZE_INBUF,' ');
  sfill(&pFUTIN_FILENAME[0],SIZE_INBUF,' ');
}  /* end of init_bufs() */



void p_set_doc_hdr(void)
{

  docn = sprintf(docp,"%s", "[beg_program]\n");
  /*     fput(p,n,pFP_DOCIN_FILE); */
  p_docin_put(docp, docn);

  docn = sprintf(docp,"%s", "\n[beg_topinfo1]\n");
  /*     fput(p,n,pFP_DOCIN_FILE); */
  p_docin_put(docp, docn);

/*   n = sprintf(p,"%s\n", scapwords(&pEVENT_NAME[0])); */
  docn = sprintf(docp,"%s\n", &pEVENT_NAME[0]);  /* first name */
  /*     fput(p,n,pFP_DOCIN_FILE); */
  p_docin_put(docp, docn);

  docn = sprintf(docp,"%s", "[end_topinfo1]\n");
  /*     fput(p,n,pFP_DOCIN_FILE); */
  p_docin_put(docp, docn);

}  /* end of p_set_doc_hdr() */


#ifdef DO_STDERR_DEBUG
#endif

/*  note: (goes to stderr)
*/
void p_display_positions(void)  /* now prints report title in title[] */
{
  int i,sign,min_in_sign,deg_in_sign,min_in_deg;
  char pos_str[(11+1)*(13+1)],lf_fill[10+1];  /* 11=numchar one str */
  char mid_fill[21+1];
        /* e.g. sun_10vir44  13=numelement (sun->plu + nod,asc,mc) */
  int n;
  char *p = &Swk[0];
  ;
  for (i=1; i <= NUM_PLANETS +3; ++i) {
    sign = p_get_sign(ar_minutes_natal[i]);
    min_in_sign = ar_minutes_natal[i] - (sign-1)*30*60;
    deg_in_sign = min_in_sign/60;
    min_in_deg  = min_in_sign - 60*deg_in_sign;
    sprintf(pos_str+i*(11+1),"%s%s%02d%s%02d",
      pN_PLANET[i],  "_"        ,deg_in_sign,pN_SIGN[sign],min_in_deg);
/*    pN_PLANET[i],pPRT_RETRO[i],deg_in_sign,pN_SIGN[sign],min_in_deg); */
  }
  sfill(lf_fill,10,' ');  sfill(&mid_fill[0],21,' ');

  n = sprintf(p,"%s\n", "\n[beg_topinfo3]");
/*     fput(p,n,fpdb); */
    fput(p,n,stderr);

  n = sprintf(p,"%s", pEVENT_NAME);
  fput(p,n,stderr);

  n = sprintf(p,"%s\n", "--------for astrology buffs---------");
  fput(p,n,stderr);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+1*(11+1), pos_str+5*(11+1), pos_str+9*(11+1));
  fput(p,n,stderr);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+2*(11+1), pos_str+6*(11+1), pos_str+10*(11+1));
  fput(p,n,stderr);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+3*(11+1), pos_str+7*(11+1), pos_str+11*(11+1));
  fput(p,n,stderr);

  n = sprintf(p,"%s  %s  %s\n",
    pos_str+4*(11+1), pos_str+8*(11+1), pos_str+13*(11+1));
  fput(p,n,stderr);

  n = sprintf(p,"%s\n", "------------------------------------");
  fput(p,n,stderr);

  n = sprintf(p,"%s", "[end_topinfo3]\n");
    fput(p,n,stderr);

}  /* end of p_display_positions() */


int p_get_sign(int minutes)
{
  return((int)floor((minutes/60.0)/30.0)+1);
}  /* end of p_get_sign() */

/* mc in minutes */
int p_get_house(int minutes, int mc)
{
  int asc;
  ;
  asc = mc + 90*60;
  if (asc >= NUM_MINUTES_IN_CIRCLE) asc = asc - NUM_MINUTES_IN_CIRCLE;
  if (minutes >= asc)  return(p_get_sign(minutes-asc));
  else  return(p_get_sign((NUM_MINUTES_IN_CIRCLE-asc)+minutes));
}  /* end of p_get_house() */


/* grab "ups and downs" from gblBuffTraitScoresCSV 
* and add in equal weight lack of "integratedness" defined as
* scores below 90th percentile (18)
*/
/* new! <.> */
void add_integratedness_lack_to_ups_and_downs(void) /* using gblBuffTraitScoresCSV */
{
  int sum_sdfm, isco, i, inum, upndn_score_old, upndn_score_new;
/*   int tst_score; */

  strcpy(gbl_trait_csv_savold, gblBuffTraitScoresCSV);

  /*  for scores below 90th percentile (18), get sum of squared
  *   differences from the mean
  */
  sum_sdfm = 0; inum = 0;
  for (i=1; i<= 6; i++) {
    isco = atoi(csv_get_field(gblBuffTraitScoresCSV, ",", i));
    if (isco >= 18) continue;  /* 90th pctl = 18 */
    inum++;
    sum_sdfm = sum_sdfm + ( (isco - 100) * (isco - 100) );
  }
/* fprintf(stderr,"QQQ %-15s|%d|555\n", pEVENT_NAME, sum_sdfm); */

  upndn_score_old = atoi(csv_get_field(gblBuffTraitScoresCSV, ",", 6));


  if (sum_sdfm == 0) {
/* fprintf(stderr,"RRR %-15s|%d|555\n", pEVENT_NAME, upndn_score_old); */
    insert_new_mapped_score_for_upndn(upndn_score_old);
    return;
  }

  /* get score for ups and downs and calc in lack of integratedness
  */

/* int score2; */
/* score2 = (int) (800.0 *((double)sum_sdfm / 30000.0) ) ;  score for lack of integratedness */

  upndn_score_new = (int) (
    (double)upndn_score_old                  /* score for bad aspects */
    +
/*  800.0 *((double)sum_sdfm / 30000.0)*/ /* score for lack of integratedness */
/*     )  / 2  ; */
    800.0 *((double)sum_sdfm / 19000.0)  /* score for lack of integratedness */
    )  ;
/* ki(sum_sdfm);
* ki(upndn_score_new);
* ksn(gblBuffTraitScoresCSV);
* fprintf(stderr,"RRR %-15s|%d|555\n", pEVENT_NAME, upndn_score_new);
*/

  /* if the new score is *lower*, use the old score
  */
  if (upndn_score_new <= upndn_score_old) {
    insert_new_mapped_score_for_upndn(upndn_score_old);
  } else {
    insert_new_mapped_score_for_upndn(upndn_score_new);
  }
/* ks(gblBuffTraitScoresCSV); */

  return;
} /* end of add_integratedness_to_ups_and_downs() */



void insert_new_mapped_score_for_upndn(int in_score)
{
  int i, isco, mapped_new_score, PERCENTILE_RANK_SCORE;

/* kin(in_score); */

  mapped_new_score = mapNumStarsToBenchmarkNum(
    IDX_FOR_UPS_AND_DOWNS_2,
    in_score
  );

  PERCENTILE_RANK_SCORE = mapBenchmarkNumToPctlRank(mapped_new_score);
/* <.> */

/*   mapped_new_score = in_score; */
/* kin(mapped_new_score); */


  /* fprintf(stderr,"%-15s|%4d|%4d|333\n", pEVENT_NAME, in_score, mapped_new_score); */

  for (i=1; i<= 6; i++) {
    isco = atoi(csv_get_field(gbl_trait_csv_savold, ",", i));

    if (i == 1) {
      sprintf(gblBuffTraitScoresCSV, "%d", isco);
    } else {
      if (i == 6) {
        sprintf(gblBuffTraitScoresCSV, 
          "%s,%d", gblBuffTraitScoresCSV, PERCENTILE_RANK_SCORE);
/*           "%s,%d", gblBuffTraitScoresCSV, mapped_new_score); */
      } else {
        sprintf(gblBuffTraitScoresCSV, 
          "%s,%d", gblBuffTraitScoresCSV, isco);
      }
    }
  }

}


/* end of perdoc.c */
