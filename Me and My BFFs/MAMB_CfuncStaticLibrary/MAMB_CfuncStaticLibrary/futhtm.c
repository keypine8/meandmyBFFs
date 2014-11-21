/* futhtm.c */

/* read from in_docin_lines[] up to idx in_docin_last_idx
* and format and write an html output file
*/

int logprtallprtlin = 0;

/* 1=yes,0=no */
/* #define GBL_HTML_HAS_NEWLINES 1 */
#define GBL_HTML_HAS_NEWLINES 0

char gbl_prtlin_lastline[4048];

int gblWeAreInPREblockContent; /* 1 = yes, 0 = no */
int gblCalDayScoreIsWritten;

/* char gbl_person_name[32]; */
char gbl_name_for_fut[32];  /* for stress num table at bottom */
char gbl_year_for_fut[32];  /* for stress num table at bottom */
/* char *gbl_csv_person_string_in_htm; */
/* char gbl_BuffYearStressScore[32];   TOO LONG ?  */

int gbl_YearStressScore;
char gbl_ffnameHTML[256];
int  gbl_is_first_year_in_life;
int  gbl_do_readahead;
int  gbl_just_started_readahead;
/* int rkdb = 0; */ /* 0=no, 1=yes */
char have_we_hit_beg_graph[5] = "NO"; /* signal to output grh and asp */

#include "futdefs.h"
#include "futhtm.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

#define NUM_ARGS 2

/* #define APP_NAME "Astrology for Me" */
/* #define APP_NAME "Astrology by Measurement" */
/* #define APP_NAME "Me & My BFFs" */
#define APP_NAME "\"Me and my BFFs\""
/* #define APP_NAME "\"My BFFs and I\"" */
/* file extension for group sharing will be ".mamb" */



/* below also in mambutil.c and futdoc.c */
#define IDX_FOR_BEST_YEAR 90
#define IDX_FOR_MYSTERIOUS 91
#define IDX_FOR_BEST_DAY 92
#define IDX_FOR_UPS_AND_DOWNS_2 93 /* fix 201311 */
#define IDX_FOR_SCORE_B 95   /* best day 2nd iteration */

char *fN_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""};
extern char *N_mth_cap[];
/* "Mth","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}; */
/* see day_of_week() */


void write_calendar_day_score(char *pname, int istress_score);

void f_fnOutPutTopOfHtmlFile(void);
void fn_outputGrhAndAspects(void);
 
void f_fn_prtlin(char *lin);
/* void f_fn_prtlin_aspect(char *lin); */ /* no \n at end */

char aspect_code[10];
void fn_aspect_from_to(char *);
void f_fn_aspect_text(char *);


/* these are in rkdebug.o */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);


/* in mambutil.c */
extern int  sfind(char s[], char c);
extern void sfill(char *s, int num, int c);
extern int mapBenchmarkNumToPctlRank(int in_score);
extern void bracket_string_of(
  char *any_of_these,
  char *in_string,   
  char *left_bracket,
  char *right_bracket  );

void scharswitch(char *s, char ch_old, char ch_new);
extern int mapNumStarsToBenchmarkNum(int category, int num_stars);

extern void strsubg(char *s, char *replace_me, char *with_me);
extern char *mkstr(char *s,char *begarg,char *end); 
extern void scharout(char *s,int c);   /* remove all c from s */
extern char *sfromto(char *dest, char *srcarg, int beg, int end);
extern void put_br_every_n(char *instr,  int line_not_longer_than_this);
extern void fn_right_pad_with_hidden(char *s_to_pad, int num_to_pad);
extern int binsearch_asp(char *asp_code, struct aspect tab[], int num_elements);
extern char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);
extern int day_of_week(int month, int day, int year);
/* in mambutil.c */



extern void f_docin_free(void);
void f_docin_get(char *in_line);

int    global_max_docin_idx;
char **global_docin_lines;
int    global_read_idx;
char doclin[4048];
int    gblIsThis1stGrhToOutput;  /* 0 false, 1 true */

char s1[4048];
char s2[4048];
char s3[4048];
char s4[4048];
char s5[4048];
char s6[4048];
char writebuf[4048];
char workbuf[4048];

FILE *Fp_f_HTML_file;
int   n;
char *p = &writebuf[0];

#define MAX_WK 10
struct {
  char wk[133]; 
} wks[MAX_WK];
#define arr(nn) (wks[nn].wk)

/*  wks is array of struct size 133 chars
* 
*  (wks[k].wk)  <==>   arr(k)
*   
*  this expression:  (wks[k].wk)  
*  gives you the kth 133-char buffer in array wks.
* *
*  With the *define* below, you can say this: 
*  arr(k) for the same buffer.
*/


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/* # examples
* #define getGrhdata(i1,k1) (*(Grhdata+(i1)*Num_eph_grh_pts+(k1)))
* #define putGrhdata(i2,k2,m2) (*(Grhdata+(i2)*Num_eph_grh_pts+(k2))=(m2))
*/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


int is_first_f_docin_get;      /* 1=yes, 0=no */
int is_first_from_to_in_doclin ;  /* 1=yes, 0=no */




/* note that is_first_from_to_in_doclin  is set at the top of
*       void fn_aspect_from_to(char *doclin)
*/
/* ***************************************************** 
*  output entire ".html" file
*  ***************************************************** */
int make_fut_htm_file(
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx,
  char *in_BuffYearStressScore,
  int   is_first_year_in_life)
{
  int i;
/* tn();trn("inmake_fut_htm()"); */

/*
* ksn(in_html_filename);
* kin(in_docin_last_idx);
* ksn(in_BuffYearStressScore);
*/

  strcpy(gbl_ffnameHTML, in_html_filename);

  gbl_is_first_year_in_life = is_first_year_in_life;

  gblWeAreInPREblockContent   = 0;  /* init to false */
  gblCalDayScoreIsWritten = 0;
  is_first_f_docin_get  = 1;  /* 1=yes, 0=no */

  global_max_docin_idx = in_docin_last_idx;
  global_docin_lines   = in_docin_lines;


/* int myoo; */
/* myoo = sizeof(gbl_BuffYearStressScore); kin(myoo); */
/* myoo = sizeof(in_BuffYearStressScore); kin(myoo); */

char myss[64];
  strcpy(myss, in_BuffYearStressScore);
/*   strcpy(gbl_YearStressScore,in_BuffYearStressScore); */
/* b(401);ksn(gbl_YearStressScore); */
/*   strcpy(gbl_BuffYearStressScore, in_BuffYearStressScore); */

/*   strcpy(gbl_YearStressScore, in_BuffYearStressScore); */

  gbl_YearStressScore = atoi(in_BuffYearStressScore);


  /* open output HTML file
  */
  if ( (Fp_f_HTML_file = fopen(in_html_filename, "w")) == NULL ) {
    rkabort("Error  when  futhum.c.  fopen().");
  }
  /* output the css, headings etc.
  */
  f_fnOutPutTopOfHtmlFile();

  /* 2. read until [beg_graph]
   */
  for (i=0; ; i++) {
    f_docin_get(doclin);

/*     sfromto(s1, doclin, 1, 11); */
/*     if (strcmp("[beg_graph]", s1) == 0) break; */
    if (strstr(doclin, "[beg_graph]") != NULL) break;
  }
  strcpy(have_we_hit_beg_graph, "YES");

  /* output *ALL*  6-mth  grh+asp
   * */
  gblIsThis1stGrhToOutput = 1;  /* 0 false, 1 true */

  while (strcmp(have_we_hit_beg_graph, "YES") == 0) {
    strcpy(have_we_hit_beg_graph, "NO"); 

    fn_outputGrhAndAspects();
  }

  /* close output HTML file
  */
  if (fclose(Fp_f_HTML_file) == EOF) {
    ;
/* trn("FCLOSE FAILED !!!   #1  "); */
  } else {
    ;
/* trn("FCLOSE SUCCESS !!!  #1  "); */
  };

  return(0);

} /* end of make_htm_file(); */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /*
* *  output "for astroloy buffs" and end html 
* *  
* *  Here we have already hit   [beg_astrobuffs],
* *  so we print the buffs table and bottom line of report
* */
* void fn_output_bot_of_html_file(void) {
*   int i;
* 
* trn(" in fn_output_bot_of_html_file() ");
* 
*   /* read until  [beg_astrobuffs]
*   *
*   */
* 
*   /* 
*   *     --------for astrology buffs--------- 
*   *     sun_10vir47 mar_13can42 nep_09lib28 
*   *     moo_21ari01 jup_21scp15 plu_13leo50 
*   *     mer_16vir24 sat_16leo10 nod_26tau21 
*   *     ven_10vir56 ura_25gem50 mc__08aqu54 
*   *     ------------------------------------
*   */
* 
*   f_fn_prtlin("<table align=center>");
*   f_fn_prtlin("  <col><col><col><col>");
*   f_fn_prtlin("  <tr>");
*   f_fn_prtlin("    <td><tt><span style=\"font-size: 90%;\">");
* 
*   /* read until  [end_astrobuffs]
*   */
*   for (i=0; ; i++) {
*     f_docin_get(doclin);
* 
* /*     sfromto(s1, doclin, 1, 16); */
* /*     if (strcmp("[end_astrobuffs]", s1) == 0) break; */
*     if (strstr(doclin, "[end_astrobuffs]") != NULL) break;
*     
*     n = sprintf(writebuf, "        %s%s\n", "<br>", doclin);
*     f_fn_prtlin(writebuf);
*   }
* 
*   f_fn_prtlin("     </span></tt></td>");
*   f_fn_prtlin("  </tr>");
*   f_fn_prtlin("</table>");
* 
* 
* /*   f_fn_prtlin("\n\n<h5>This report is for entertainment purposes only.</h5>\n"); */
* 
*   f_fn_prtlin("<h4><span style=\"background-color:#FFBAC7;\">&nbsp&nbsp&nbsp&nbsp&nbsp  This report is for entertainment purposes only.  &nbsp&nbsp&nbsp&nbsp&nbsp</span></h4>");
* 
*   f_fn_prtlin("\n</body>\n");
*   f_fn_prtlin("</html>");
* 
* } /* end of fn_output_bot_of_html_file() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


void f_fnOutPutTopOfHtmlFile(void) {
  int i;

/* trn("in f_fnOutPutTopOfHtmlFile()");  */

  /* 1. read until [beg_topinfo1]  (name)
  */
  for (i=0; ; i++) {
    f_docin_get(doclin);
    if (strstr(doclin, "[beg_topinfo1]") != NULL) break;
  }

  /* then save lines until graph until [end_topinfo1] 
  * then put out html 
  */
  for (i=0; ; i++) {
    f_docin_get(doclin);
    if (strstr(doclin, "[end_topinfo1]") != NULL) break;

    strcpy(arr(i), doclin);
  }

  /* trn("------------------------------------");
  * for (k=0; k < i; k++) ksn(arr(k));
  * trn("------------------------------------");
  */



/*   f_fn_prtlin( "<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">"); */
/*   f_fn_prtlin( "  \"http://www.w3.org/TR/html4/strict.dtd\">"); */
/*   f_fn_prtlin( "  \"http://www.w3.org/TR/html4/loose.dtd\">"); */

/*   at end, change to STRICT  (maybe) */
  f_fn_prtlin( "<!doctype html public \"-//w3c//dtd html 4.01 transitional//en\" ");
  f_fn_prtlin( "  \"http://www.w3.org/TR/html4/loose.dtd\">");

  f_fn_prtlin( "<html>");
  f_fn_prtlin( "\n<head>");

  /* IT TURNS OUT this <title> is used as the default filename when the html report
  *  is emailed, you open it, and do "Save As".
  *  Therefore, used the "real" file name with no advertising.  Rats.
  */

/*   sprintf(writebuf, "  <title>%s %s Calendar Year produced by iPhone/iPad app named %s.</title>",arr(1),arr(2), APP_NAME); * lance 2013 * */
/*   sprintf(writebuf, "  <title>%s %s Calendar Year produced by iPhone app %s.</title>",arr(1),arr(2), APP_NAME);  */


  /* if HTML filename, gbl_ffnameHTML, has any slashes, grab the basename
  */
  char myBaseName[256], *myptr;
  if (sfind(gbl_ffnameHTML, '/')) {
    myptr = strrchr(gbl_ffnameHTML, '/');
    strcpy(myBaseName, myptr + 1);
  } else {
    strcpy(myBaseName, gbl_ffnameHTML);
  }
  sprintf(writebuf, "  <title>%s</title>", myBaseName);


  f_fn_prtlin(writebuf);
  
  /* HEAD  META
  */
  sprintf(writebuf, "  <meta name=\"description\" content=\"Calendar Year for Person produced by iPhone App %s\"> ", APP_NAME);
  f_fn_prtlin( writebuf);


  f_fn_prtlin( "  <meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"iso-8859-1\">"); 
/*   f_fn_prtlin( "  <meta name=\"Author\" content=\"Author goes here\">"); */


/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"GMCR,group,member,astrology,future,past,calendar,year,compatibility,personality\"> "); */
/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"measure,group,member,best,match,calendar,year,passionate,personality\"> "); */
/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,BFF,astrology,compatibility,group,best,match,personality,calendar,year,stress\"> "); */
/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,astrology,compatibility,group,best,match,personality,stress,calendar,year\"> ");  * 96 chars * */
  f_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,me,compatibility,group,best,match,personality,stress,calendar,year\"> ");  /* 89 chars */



  /* get rid of CHROME translate "this page is in Galician" 
  * do you want to translate?
  */
  f_fn_prtlin("  <meta name=\"google\" content=\"notranslate\">");
  f_fn_prtlin("  <meta http-equiv=\"Content-Language\" content=\"en\" />");


  /* Using the Viewport Meta Tag  (in iOS webView)
  * https://developer.apple.com/library/safari/documentation/AppleApplications/Reference/SafariWebContent/UsingtheViewport/UsingtheViewport.html#//apple_ref/doc/uid/TP40006509-SW25
  *
  * For example, TO SET THE VIEWPORT WIDTH TO THE WIDTH OF THE DEVICE, add this to your HTML file:
  * <meta name="viewport" content="width=device-width"> 
  * To set the initial scale to 1.0, add this to your HTML file:
  * <meta name="viewport" content="initial-scale=1.0"> 
  * To set the initial scale and to turn off user scaling, add this to your HTML file:
  * <meta name="viewport" content="initial-scale=2.3, user-scalable=no">
  */
  f_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width\" />");


  /* HEAD   STYLE/CSS
  */
  f_fn_prtlin( "\n  <style type=\"text/css\">");
  f_fn_prtlin( "    @media print { PRE {  page-break-inside:avoid; } }");

  f_fn_prtlin( "    BODY {");

/*  f_fn_prtlin( "      background-color: #F5EFCF;"); */
  f_fn_prtlin( "      background-color: #f7ebd1;");

/*   f_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      font-size:   medium;");
  f_fn_prtlin( "      font-weight: normal;");
  f_fn_prtlin( "      text-align:  center;");
/*   f_fn_prtlin( "    <!-- "); */
/*   f_fn_prtlin( "      background-image: url('mkgif1g.gif');"); */
/*   f_fn_prtlin( "    --> "); */
  f_fn_prtlin( "    }");

  f_fn_prtlin( "    H1 { font-size: 137%; font-weight: bold;   line-height: 95%; text-align: center;}");
  f_fn_prtlin( "    H2 { font-size: 137%;                      line-height: 25%; text-align: center;}");
  f_fn_prtlin( "    H3 { font-size: 110%; font-weight: normal; line-height: 30%; text-align: center;}");

/*   f_fn_prtlin( "    H5 { font-size:  55%; font-weight: normal; line-height: 90%; text-align: center;}"); */
/*   f_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}"); */

/*   f_fn_prtlin( "    H4 { font-size:  85%; font-weight: bold;   line-height: 30%; text-align: center;}"); */
/*   f_fn_prtlin( "    H5 { font-size:  75%; font-weight: normal; line-height: 30%; text-align: center;}"); */

  f_fn_prtlin( "    H4 { font-size:  75%; font-weight: bold;   line-height: 30%; text-align: center;}");
  f_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}");


  f_fn_prtlin( "    PRE {");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      font-weight: normal;");
  f_fn_prtlin( "      font-size:   75%;");
  f_fn_prtlin( "      line-height: 70%;");
  f_fn_prtlin( "      margin:0 auto;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    .prebox {");

/*   f_fn_prtlin( "      display: inline-block;"); */
/*   f_fn_prtlin( "      border-style: solid;"); */
/*   f_fn_prtlin( "      border-color: #e4dfae;"); */
/*   f_fn_prtlin( "      border-width: 5px;"); */

  f_fn_prtlin( "      display: inline-block;");
  f_fn_prtlin( "      background-color: #fcfce0;");
  f_fn_prtlin( "      border: none;");
  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "      line-height: 120%;");
  f_fn_prtlin( "      font-size: 75%;");

  f_fn_prtlin( "    }");
/*   f_fn_prtlin( "    .bgy {background-color:#ffff00;}"); */
  f_fn_prtlin( "    .bgy {background-color:#fcfc70;}");


  f_fn_prtlin( "    P { ");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      width: auto;");
  f_fn_prtlin( "      font-size:   80%;");
  f_fn_prtlin( "      margin-top: 0;");
  f_fn_prtlin( "      margin-bottom: 0;");
  f_fn_prtlin( "      margin-left: auto;");
  f_fn_prtlin( "      margin-right:auto;");
/*   f_fn_prtlin( "      padding-left: 5%;"); */
/*   f_fn_prtlin( "      padding-right:5%;"); */
  f_fn_prtlin( "      text-align: left;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table {");
  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "      font-size: 120%;");
  f_fn_prtlin( "    }");
/* for table: */
/*       border: 2px solid black; */
/*       cellspacing: 0; */
/*       border-top: 0; */
/*       border-bottom: 0; */
  f_fn_prtlin( "    table.center {");
  f_fn_prtlin( "      margin-left:auto;");
  f_fn_prtlin( "      margin-right:auto;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    TD {");
  f_fn_prtlin( "      white-space: nowrap;");
  f_fn_prtlin( "      padding: 0;");
  f_fn_prtlin( "    }");

/*   f_fn_prtlin("    .cGre        { background-color:#e1fdc3; }");
*   f_fn_prtlin("    .cGr2        { background-color:#d0fda0; }");
*   f_fn_prtlin("    .cRed        { background-color:#ffbac1; }");
*   f_fn_prtlin("    .cRe2        { background-color:#ff596a; }");
*/

/*   p_fn_prtlin( "    .cGr2        { background-color:#d0fda0; }"); */
/*   f_fn_prtlin( "    .cGr2        { background-color:#8bfd87; }"); */
/*   f_fn_prtlin( "    .cGr2        { background-color:#66ff33; }"); */

/*   p_fn_prtlin( "    .cGre        { background-color:#e1fdc3; }"); */
/*   f_fn_prtlin( "    .cGre        { background-color:#ccffb9; }"); */
/*   f_fn_prtlin( "    .cGre        { background-color:#84ff98; }"); */

/*   p_fn_prtlin( "    .cRed        { background-color:#ffd9d9; }"); */
/*   f_fn_prtlin( "    .cRed        { background-color:#ffcccc; }"); */
/*   f_fn_prtlin( "    .cRed        { background-color:#ff98a8; }"); */

/*   p_fn_prtlin( "    .cRe2        { background-color:#fcb9b9; }"); */
/*   f_fn_prtlin( "    .cRe2        { background-color:#fc8888; }"); */
/*   f_fn_prtlin( "    .cRe2        { background-color:#ff6094; }"); */
/*   f_fn_prtlin( "    .cRe2        { background-color:#ff3366; }"); */


  f_fn_prtlin( "    .cGr2        { background-color:#66ff33; }");
/*   f_fn_prtlin( "    .cGre        { background-color:#84ff98; }"); */
  f_fn_prtlin( "    .cGre        { background-color:#a8ff98; }");
  f_fn_prtlin( "    .cRed        { background-color:#ff98a8; }");
  f_fn_prtlin( "    .cRe2        { background-color:#ff4477; }");


  f_fn_prtlin("    .row4        { background-color:#f8f0c0; }");

/*   f_fn_prtlin("    .cNeu        { background-color:#e1ddc3; }"); */
  f_fn_prtlin("    .cNeu        { background-color:#e5e2c7; }");

  f_fn_prtlin("    .cSky        { background-color:#3f3ffa; }");
  f_fn_prtlin( "   .star        { color:#f7ebd1; }");

  f_fn_prtlin("    .cNam        { color:#3f3ffa;");
  f_fn_prtlin("                   background-color: #F7ebd1;");
  f_fn_prtlin("                   font-size: 133%;");
  f_fn_prtlin("    }");


  f_fn_prtlin( "    table.trait {");
  f_fn_prtlin( "      font-size: 100%;");
  f_fn_prtlin( "      margin-left: auto;");
  f_fn_prtlin( "      margin-right:auto;");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      text-align: left;");

/*   f_fn_prtlin( "      border: 1px solid black;"); */
  f_fn_prtlin( "      border: none;");

  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.trait td {");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      white-space: pre;");
/*   f_fn_prtlin( "      font-size: 75%;"); */
  f_fn_prtlin( "      font-size: 90%;");
  f_fn_prtlin( "      text-align: left;");

/*   f_fn_prtlin( "      border: 1px solid black;"); */
  f_fn_prtlin( "      border: none;");

  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "      padding-left: 10px; ");
  f_fn_prtlin( "      padding-right: 10px; ");
  f_fn_prtlin( "      padding-top: 2px; ");
  f_fn_prtlin( "      padding-bottom: 2px; ");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.trait th{");
/*   f_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
/*   f_fn_prtlin( "      font-size: 75%;"); */
  f_fn_prtlin( "      font-size: 90%;");
  f_fn_prtlin( "      padding: 10px; ");

/*   f_fn_prtlin( "      background-color: #e1fdc3 ;"); */
  f_fn_prtlin( "      background-color: #fcfce0;");

/*   f_fn_prtlin( "      border: 1px solid black;"); */
  f_fn_prtlin( "      border: none;");

  f_fn_prtlin( "      text-align: center;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.trait       td { text-align: left; }");
  f_fn_prtlin( "    table.trait    td+td { text-align: right; }");
  f_fn_prtlin( "    table.trait td+td+td { text-align: left; }");

  f_fn_prtlin( "  </style>");

/* from p */
/*   f_fn_prtlin( "      margin-left: 20%;"); */
/*   f_fn_prtlin( "      margin-right:20%;"); */
/*   f_fn_prtlin( "      text-align: left;"); */

/*   f_fn_prtlin( "    <!-- "); */
/*   f_fn_prtlin( "    PRE {line-height: 68%}; "); */
/*   f_fn_prtlin( "    P {margin-left:10%; margin-right:10%}"); */
/*   f_fn_prtlin( "    --> "); */

/* put in favicon */
f_fn_prtlin("<link href=\"data:image/x-icon;base64,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\" rel=\"icon\" type=\"image/x-icon\" />");

  f_fn_prtlin( "</head>");
  f_fn_prtlin( " ");
  f_fn_prtlin("\n<body>");

/*   f_fn_prtlin( "<body background=\"file:///mkgif1g.gif\">"); */
/*   f_fn_prtlin( "<body background=\"file:///C/USR/RK/html/mkgif1g.gif\">"); */

  /* a year in the life header output here */

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   sprintf(writebuf, "\n  <h1>%s</h1>", arr(0));
*   f_fn_prtlin(writebuf);
* 
* b(2);
* 
* /*  <h1><center>A Year in the Life</center></h1>
* *   <h2><center>of Fred&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<em style="font-size:137%;">2013</em></center></h2>
* */
* /*   sprintf(writebuf, "\n  <h2><center>of %s</center></h2>", arr(1)); * Fred * */
*  
* /*   GOOD-|<span style="background-color:#C3FDC3; font-family: Andale Mono, Courier New, Monospace; font-weight: normal; font-size: 100;">XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-</span>| */
* 
*   sprintf(writebuf, "\n <h2>of %s&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span style=\"font-size:115%%;\">%s</span><br></h2>", arr(1), arr(2) ); /* of Fred     2013 * */
*   f_fn_prtlin(writebuf);
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

/*   n = sprintf(p,
*     "<h1>&nbsp&nbsp&nbsp&nbsp %s &nbsp&nbsp<span style=\"font-size: 80%%;\">of %s</span> &nbsp&nbsp <span style=\"font-size:115%%;\"> %s </span><br></h1>",
*       arr(0), arr(1), arr(2)
*   );
*/
/*   n = sprintf(p,
*     "<h1>&nbsp&nbsp&nbsp&nbsp %s of %s &nbsp&nbsp&nbsp %s <br></h1>",
*       arr(0), arr(1), arr(2)
*   );
*/

/*   n = sprintf(writebuf,
*     "<h1>&nbsp&nbsp&nbsp&nbsp Calendar Year &nbsp %s <br></h1>",
*     arr(2)
*   );
*   f_fn_prtlin(writebuf);
*   n = sprintf(writebuf,
*     "<h2>&nbsp&nbsp&nbsp&nbsp in the life of %s<br></h2>",
*     arr(1)
*   );
*   f_fn_prtlin(writebuf);
*/

/*     "<h1>&nbsp&nbsp&nbsp&nbsp Calendar Year %s for %s<br></h1>", */


  strcpy(gbl_name_for_fut, arr(1));  /* for stress num table at bottom */
  strcpy(gbl_year_for_fut, arr(2));  /* for stress num table at bottom */
/*   strcpy(gbl_person_name, arr(1)); */

  f_fn_prtlin("<div><br></div>");
/*   n = sprintf(writebuf, */
/*     "<h1>&nbsp&nbsp&nbsp&nbsp Calendar Year %s for <span class=\"cNam\">%s</span><br></h1>", */
/*     arr(2), arr(1) */
/*   ); */
  n = sprintf(writebuf,
    "<h1>Calendar Year %s for <span class=\"cNam\">%s&nbsp&nbsp </span><br></h1>",
    arr(2), arr(1)
  );
  f_fn_prtlin(writebuf);


  f_fn_prtlin(" ");

/*   sprintf(writebuf, "\n  <h3><center>%s</center></h1>", arr(2)); * 2013 *
*   f_fn_prtlin(writebuf);
*/

}  /* end of f_fnOutPutTopOfHtmlFile(); */


void fn_outputGrhAndAspects(void) {
  int i;
  int have_printed_STRESS_line_already;
  int have_printed_OMG_line_already;
/*   char myLastLine[4048]; */
  int num_OMG_printed;

/* trn(" in fn_outputGrhAndAspects() "); */

  /* put white space before  graph start
   */
  if (gblIsThis1stGrhToOutput == 1) {  /* 0 false, 1 true */
    gblIsThis1stGrhToOutput = 0; 
/*     f_fn_prtlin("  <pre><br>");          */
    f_fn_prtlin("  <pre>");         
    gblWeAreInPREblockContent = 1;  /* true */
    f_fn_prtlin("<br>");         
  } else {
    /* second graph start needs some more white space before it */
/*     f_fn_prtlin("  <pre><br><br><br><br><br><br><br>");  */
    f_fn_prtlin("  <pre>"); 
    gblWeAreInPREblockContent = 1;  /* true */
    f_fn_prtlin("<br><br><br><br><br><br><br>"); 
  }

  gblWeAreInPREblockContent = 1;  /* true */


  /* experiment bg color on left-side column containing label names
  *  This is the 7-char filler (max size "STRESS-" = 7)
  */
/*    char current_leftside[1024]; */
/*    int just_printed_stress_label; */

   /* initialize */
/*    sprintf(current_leftside, "<span class=\"cRe2\">%.7s</span>", "              "); */
/*       sprintf(current_leftside, "<span class=\"cRe2\"> </span>      "); */
/*    just_printed_stress_label = 0;                                                */


  /* now read and print graph until we hit [end_graph] 
  */
  have_printed_STRESS_line_already = 0;
  have_printed_OMG_line_already    = 0;
  num_OMG_printed = 0;


  for (i=0; ; i++) {

    f_docin_get(doclin);

    if (strstr(doclin, "[end_graph]") != NULL) break;


    /*   EXAMPLE color a  thing
    * <body style="background-color:yellow;">
    * <h2 style="background-color:red;">This is a heading</h2>
    * <p style="background-color:green;">This is a paragraph.</p>
    * </body>
    */


    /* for GOOD line, make background colour palegreen
* GOOD-|<span style="background-color:#C3FDC3; font-family: Andale Mono, Courier New, Monospace; font-weight: normal; font-size: 100%;">XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-</span>|
    */

/* tn();b(330);ks(doclin); */


    /* Here we check if we are on the exact stress-level label lines
    *  GREAT, GOOD, STRESS, OMG
    */

    if (strstr(doclin, "GREAT") != NULL) {

      /* EXPERIMENT   left side to right */
      /* replace " GREAT|" with "-GREAT " and put on right side */
      strcpy(s1, " GREAT ");
      /* sfromto(s1, doclin,  1,  7);*/  /* " GREAT-" from " GREAT-|" */

/* tn();b(331);ks(s1); */


/*       sfromto(s2, doclin,  9, 98); */
/*       sfromto(s2, doclin,  8, 99);  BUG to use sfromto- cause contains "class=star" inserted (not to 99)*/
/*       sfromto(s2, doclin,  8, 99); */

      strcpy(s2, &doclin[8 - 1]); /* into s2, get rest of string from 8th char */
/* tn();b(332);ks(s2); */


/*       sprintf(writebuf, */
/*         "<span class=\"cGr2\">%s</span>|<span class=\"cGr2\">%s</span>|", s1, s2);  */
/*         "<span class=\"cGr2\">%s</span>|<span class=\"cGr2\">%s</span>|", s1, s2);  */

/*       sprintf(writebuf, "<span class=\"cGr2\">%s</span>|%s|", s1, s2);  */

      /* replace " GREAT|" with "-GREAT " and put on right side */
      sprintf(writebuf, " %s<span class=\"cGr2\">%s</span>", s2, s1); 

/*       sprintf(writebuf, "<span class=\"cGr2\">%s</span>%s", s1, s2);  */


/* tn();b(333);ks(writebuf); */
      bracket_string_of("X", writebuf, "<span class=\"cGr2\">", "</span>");
/* tn();b(334);ks(writebuf); */
      bracket_string_of("#", writebuf, "<span class=\"cSky\">", "</span>");
/* tn();b(335);ks(writebuf); */
      scharswitch(writebuf, 'X', ' ');
      scharswitch(writebuf, '#', ' ');
      scharswitch(writebuf, '|', ' ');  /* sideline out */
/* tn();b(336);ks(writebuf); */


      f_fn_prtlin(writebuf);
      /* lines below are all light green */
/*    sprintf(current_leftside, "<span class=\"cGre\">%.7s</span>", "              "); */
/*       sprintf(current_leftside, "<span class=\"cGre\"> </span>      "); */
/*       just_printed_stress_label = 1; */
      continue;
    }

    if (strstr(doclin, "GOOD") != NULL) {

      /* replace "  GOOD|" with "-GOOD  " and put on right side */
/*       strcpy(s1, "-GOOD  "); */
      strcpy(s1, " GOOD  ");

      /* sfromto(s1, doclin,  1,  7); */  /* "  GOOD-" from "  GOOD-|" */

/*       sfromto(s2, doclin,  9, 98); */
/*       sfromto(s2, doclin,  8, 99); */
      strcpy(s2, &doclin[8 - 1]); /* into s2, get rest of string from 8th char */

      /* note "|" is at end */
/*         "%s<span style=\"background-color:#C3FDC3; font-family: Andale Mono, Courier New, Monospace; font-weight: normal; font-size: 100%%;\">%s</span>|", s1, s2);  */
/*         "%s<span class=\"cLineGood\">%s</span>|", s1, s2);  */

/*       sprintf(writebuf, */
/*         "<span class=\"cGre\">%s</span>|<span class=\"cGre\">%s</span>|", s1, s2);  */

/*       sprintf(writebuf, "<span class=\"cGre\">%s</span>|%s|", s1, s2);  */


      /* replace "  GOOD|" with "-GOOD  " and put on right side */
      sprintf(writebuf, " %s<span class=\"cGre\">%s</span>", s2, s1); 

/*       sprintf(writebuf, "<span class=\"cGre\">%s</span>%s", s1, s2);  */

      bracket_string_of("X", writebuf, "<span class=\"cGre\">", "</span>");
      bracket_string_of("#", writebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(writebuf, 'X', ' ');
      scharswitch(writebuf, '#', ' ');
      scharswitch(writebuf, '|', ' ');  /* sideline out */

      f_fn_prtlin(writebuf);

      /* lines below are all neutral color */
/*    sprintf(current_leftside, "<span class=\"cNeu\">%.7s</span>", "              "); */
/*       sprintf(current_leftside, "<span class=\"cNeu\"> </span>      "); */
/*       just_printed_stress_label = 1; */

/*      gbl_do_readahead = 0; */ /* needed only for printing "-GREAT " and "-GOOD " labels */

      continue;
    }
    /* for STRESS line, make background colour deeppink
STRESS-|<span style="background-color:#FFBAC7; font-family: Andale Mono, Courier New, Monospace; font-weight: normal; font-size: 100%;">XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-</span>|
    */
    if (strstr(doclin, "STRESS") != NULL 
    && have_printed_STRESS_line_already == 0) {
      ;

      /* replace "STRESS|" with "-STRESS" and put on right side */
      strcpy(s1, " STRESS");

/*       sfromto(s2, doclin,  9, 98); */
/*       sfromto(s2, doclin,  8, 99); */
      /* note "|" is at end */
      strcpy(s2, &doclin[8 - 1]); /* into s2, get rest of string from 8th char */

/*         "%s<span style=\"background-color:#FFBAC7; font-family: Andale Mono, Courier New, Monospace; font-weight: normal; font-size: 100%%;\">%s</span>|", */
/*         "%s<span class=\"cLineStress\">%s</span>|", s1, s2);  */

/*       sprintf(writebuf, */
/*         "<span class=\"cRed\">%s</span>|<span class=\"cRed\">%s</span>|", s1, s2);  */

/*       sprintf(writebuf, "<span class=\"cRed\">%s</span>|%s|", s1, s2);  */
      sprintf(writebuf, "<span class=\"cRed\">%s</span>%s", s1, s2); 

      /* replace "STRESS|" with "-STRESS" and put on right side */
      sprintf(writebuf, " %s<span class=\"cRed\">%s</span>", s2, s1); 


      bracket_string_of("X", writebuf, "<span class=\"cRed\">", "</span>");
      bracket_string_of("#", writebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(writebuf, 'X', ' ');
      scharswitch(writebuf, '#', ' ');
      scharswitch(writebuf, '|', ' ');  /* sideline out */


      f_fn_prtlin(writebuf);

      have_printed_STRESS_line_already = 1;

      /* lines below are all light red */
/*    sprintf(current_leftside, "<span class=\"cRed\">%.7s</span>", "              "); */
/*       sprintf(current_leftside, "<span class=\"cRed\"> </span>      "); */
/*       just_printed_stress_label = 1; */
      continue;
    }

    /* intercept 2nd OMG line  (happens when last * is right on line)
    */
/*     if (num_OMG_printed > 0) { */
/*  */
/*       if (num_OMG_printed == 1) { */
        /* print blank line with color cRe2 under the 1st OMG */
/*    */
          /* #define NUM_PTS_FOR_FUT 92 */
/*         sfill(myLastLine, NUM_PTS_FOR_FUT, ' ');  */
/*         bracket_string_of(" ", myLastLine, "<span class=\"cRe2\">", "</span>"); */
/*    */
/*         sprintf(p,"       %s\n", myLastLine );  */
/* left margin = 7 spaces */
/*         f_fn_prtlin(myLastLine); */
/*       } */
/*       continue; */
/*     } */

    /* color OMG line, but
    */
    if (strstr(doclin, "OMG") != NULL
    && have_printed_OMG_line_already == 0) {

/* tn();b(221);ki(have_printed_OMG_line_already); */

       /* "   OMG-" from "   OMG-|" */
/*       sfromto(s1, doclin,  1,  7);   */

      /* replace "   OMG-|" with "-OMG   " and put on right side */
/*       strcpy(s1, "-OMG   "); */
      strcpy(s1, " OMG   ");


/*       sfromto(s2, doclin,  9, 98); */
/*       sfromto(s2, doclin,  8, 99); */
      strcpy(s2, &doclin[8 - 1]); /* into s2, get rest of string from 8th char */

/*       sprintf(writebuf, */
/*         "<span class=\"cRe2\">%s</span>|<span class=\"cRe2\">%s</span>|", s1, s2);  */

/*       sprintf(writebuf, "<span class=\"cRe2\">%s</span>|%s|", s1, s2);  */
      sprintf(writebuf, "<span class=\"cRe2\">%s</span>%s", s1, s2); 

      /* replace "   OMG-|" with "-OMG   " and put on right side */
      sprintf(writebuf, " %s<span class=\"cRe2\">%s</span>", s2, s1); 

      bracket_string_of("X", writebuf, "<span class=\"cRe2\">", "</span>");
      bracket_string_of("#", writebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(writebuf, 'X', ' ');
      scharswitch(writebuf, '#', ' ');
      scharswitch(writebuf, '|', ' ');  /* sideline out */

      f_fn_prtlin(writebuf);

      num_OMG_printed = num_OMG_printed + 1;

/* tn();b(222);ki(have_printed_OMG_line_already); */
      have_printed_OMG_line_already = 1;

      /* lines below are all bright red */
/*    sprintf(current_leftside, "<span class=\"cRe2\">%.7s</span>", "              "); */
/*       sprintf(current_leftside, "<span class=\"cRe2\"> </span>      "); */
/*       just_printed_stress_label = 1; */
      continue;
    }


    /* in the bottom 4 graph lines, put different line-heights
    */
    if (strstr(doclin, "\'\'\'\'\'") != NULL) {

      strcpy(writebuf, "");
      f_fn_prtlin(writebuf);

      /* EXPERIMENT stress level labels on right */
      /* take 1st 7 chars margin and put them on right end */
      sprintf(s5, "%.7s", doclin);  /* 1st 7 ch left margin */
/*       sprintf(s6, "%s%s", doclin + 7 - 1, s5); */
      sprintf(s4, "%s", doclin + 7 - 1); /* part after left mar of 7 */

/*       sprintf(writebuf, "<span style=\"line-height: 90%%;\">%s</span>", doclin); */
/*       f_fn_prtlin(writebuf); */
/*       f_fn_prtlin(s6); */

/*       sprintf(writebuf, "<span style=\"line-height: 90%%;\">%s</span>", s6); */
/* ksn(s6); kin(strlen(s6)); */
/*       sprintf(writebuf, "<span class=\"bgy\" style=\"line-height: 90%%;\">%s</span>", s6); */
/*       sprintf(writebuf, "<span class=\"bgy\" style=\"line-height: 90%%;\">%s</span>%s", s4, s5); */

      /* weird   remove leadiing space from s4 and put it before yellow highlight */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 90%%;\">%s</span>%s", s4+1, s5); */
/*       sprintf(writebuf, " <span style=\"line-height: 90%%;\">%s</span>%s", s4+1, s5); */
/*       sprintf(writebuf, " <span style=\"line-height: 155%%;\">%s</span>%s", s4+1, s5); */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 155%%;\">%s</span>%s", s4+1, s5); */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 60%%;\">%s</span>%s", s4+1, s5); */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 155%%;\">%s</span>%s", s4+1, s5); */
      sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 55%%;\">%s</span>%s", s4+1, s5);

/* ksn(writebuf); kin(strlen(writebuf)); */


      f_fn_prtlin(writebuf);

      continue;
    }
    if (strstr(doclin, "|    | ") != NULL) {
/* ksn(doclin); */
/* kin(strlen(doclin)); */
      sprintf(s5, "%.7s", doclin);  /* 1st 7 ch left margin */
      sprintf(s4, "%s", doclin + 7 - 1); /* part after left mar of 7 */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height:80%%;\"\">%s</span>%s", s4+1, s5); */
      sprintf(writebuf, " <span class=\"bgy\" style=\"line-height:60%%;\">%s</span>%s", s4+1, s5);
      f_fn_prtlin(writebuf);
      continue;
    }
    if (strstr(doclin, "11   21") != NULL) {

      /* EXPERIMENT stress level labels on right */
      /* take 1st 7 chars and put them on right end */
      sprintf(s5, "%.7s", doclin);
/*       sprintf(s6, "%s%s", doclin + 7 - 1, s5); */
      sprintf(s4, "%s", doclin + 7 - 1); /* part after left mar of 7 */

/*       sprintf(writebuf, "<span style=\"line-height: 125%%;\">%s</span>", doclin); */
/*       sprintf(writebuf, "<span style=\"line-height: 125%%;\">%s</span>", s6); */
/*       sprintf(writebuf, "<span style=\"line-height: 165%%;\">%s</span>", s6); */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 165%%;\">%s</span>%s", s4+1, s5); */
      sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 170%%;\">%s</span>%s", s4+1, s5);

      f_fn_prtlin(writebuf);
      continue;
    }
    int mth_ctr;
    mth_ctr = 0;
    if (strstr(doclin, "JAN") != NULL) mth_ctr++;
    if (strstr(doclin, "FEB") != NULL) mth_ctr++;
    if (strstr(doclin, "MAR") != NULL) mth_ctr++;
    if (strstr(doclin, "APR") != NULL) mth_ctr++;
    if (strstr(doclin, "MAY") != NULL) mth_ctr++;
    if (strstr(doclin, "JUN") != NULL) mth_ctr++;
    if (strstr(doclin, "JUL") != NULL) mth_ctr++;
    if (strstr(doclin, "AUG") != NULL) mth_ctr++;
    if (strstr(doclin, "SEP") != NULL) mth_ctr++;
    if (strstr(doclin, "OCT") != NULL) mth_ctr++;
    if (strstr(doclin, "NOV") != NULL) mth_ctr++;
    if (strstr(doclin, "DEC") != NULL) mth_ctr++;

    if (mth_ctr > 3) {
/* ksn(doclin); */
/* ksn(doclin + 7); */
      /* remove the left margin (with year in it) and put spaces at end
      *  we are getting rid of the year
      */
/* ksn(doclin); */
      /* doclin is
       * [  2015  JULY          AUGUST          SEPTEMBER      OCTOBER        NOVEMBER       DECEMBER        ]
       */

      sprintf(s5, "%.7s", doclin);       /* grab 1st 7 ch */
      strcpy(s5, "       "); /* 7 spaces */
      sprintf(s4, "%s", doclin + 7 - 1); /* grab part after left mar of 7 */

/*       sprintf(writebuf, "<span style=\"line-height: 90%%;\">%s</span>", doclin); */
/*       sprintf(writebuf, "<span style=\"line-height: 90%%;\">%s       </span>", doclin + 7); */
/*       sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 90%%;\">%s</span>%s", s4+1, s5); */
      sprintf(writebuf, " <span class=\"bgy\" style=\"line-height: 75%%;\">%s</span>%s", s4+1, s5);


      f_fn_prtlin(writebuf);
      continue;
    }

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*     /* Here, before printing, we want to replace the first 7 chars (always blanks with bg color)
*     *  with current_leftside which is like
*     *       sprintf(current_leftside, "<span class=\"cRe2\">%.7s</span>", "              ");
*     */
*     /* grab line after 1st 7 chars */
* 
* trn("line1=");ks(doclin);
* 
* /* for TEST, grab 1st 7 ch */
* /* mkstr(my_right_padding_chars, lotsachars, lotsachars + num_to_pad - 1); */
* mkstr(s3, doclin, doclin + 7 - 1);
* /*     if (strcmp("[beg_graph]", s1) == 0) break; */
* if (strcmp(s3, "       ") != 0) {trn("HEY!leftpad=");ks(s3);}
* 
*    /* grab print line after 1st 7 chars */
*    sprintf(s3, "%s", doclin + 7);
* trn("HEY!restofline=");ks(s3);
* 
*    /* build new line with new left column bg colors */
*    sprintf(s5, "%s%s", current_leftside, s3) ;
* trn("HEY!newline=");ks(s5);
* 
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


  /* EXPERIMENT stress level labels on right */
  /* take 1st 7 chars and put them on right end */
  sprintf(s5, "%.7s", doclin);
/* ksn(s5); */
  sprintf(s6, "%s%s", doclin + 7 - 1, s5);
/* ksn(s6); */
  f_fn_prtlin(s6);


  /* just output regular line */
/*   f_fn_prtlin(doclin); */



  }  /* print graph until we hit [end_graph]  */



  
  gblWeAreInPREblockContent = 0;  /* false */
  f_fn_prtlin("  </pre>\n\n"); 

  /* 2. read until [beg_aspects]  , which look like this:
  *    [beg_aspects]
  *         From January 1, 2008 to March 31, 2008.  ^(sugne)
  *         From January 1, 2008 to January 5, 2008.  ^(mogju)
  *         From January 1, 2008 to February 12, 2008.  ^(megne)
  *         From February 28, 2008 to March 31, 2008 and also from June 17, 2008 to July 1, 2008.  ^(vecju)
  *    [end_aspects]
  */
  for (i=0; ; i++) {
    f_docin_get(doclin);
    if (strstr(doclin, "[beg_aspects]") != NULL) break;
  }

/*   f_fn_prtlin("  <h4><span style=\"font-size: 85%; font-weight: normal\">"); */
/*   f_fn_prtlin("      (they influence the graph above)   </span><br><br><br></h4>"); */
  f_fn_prtlin("  <h3><br><br>Important Periods</h3>");
  f_fn_prtlin("  <h4>(they influence the graph above)<br><br><br></h4>");

  /* now read and print aspects until we hit [end_aspects] 
  */
  for (i=0; ; i++) {

    f_docin_get(doclin);
    if (strlen(doclin) == 0) continue;

    if (strstr(doclin, "[end_aspects]") != NULL) break;
    f_fn_prtlin("\n");

    /* 1 of 2
    *    do intro lines like
    *    "From April 30, 1933 until mumble and also from" 
    *    From January 1, 2008 to March 31, 2008.  ^(sugne)
    *
    *  2 of 2  f_fn_aspect_text()
    *    print aspect text  strings corresponding to
    *    aspect_codes  like "^(sugne)" 
    */
    fn_aspect_from_to(doclin);

  }  /* end of read and print aspects until we hit [end_aspects] */


  /* now read until we get  either
  *    1. [beg_graph]       for another grh+asp to output
  * NO 28apr2013  no more astrobuffs  2. [beg_astrobuffs]  for report-bottom stuff
  */
  for (i=0; ; i++) {

    f_docin_get(doclin);

    if (strstr(doclin, "[beg_graph]") != NULL) {

      strcpy(have_we_hit_beg_graph, "YES"); 
      return;
    }

    if (strstr(doclin, "[beg_astrobuffs]") != NULL) break;
  }

/* ksn(s1); */

  /* here we have hit [beg_astrobuffs]
  * 
  * !! 28apr2013  we no longer display this table of planetary positions !!
  * NOTE:    "[beg_astrobuffs]"  is stll there in docin stuff
  *          In fact, the whole table is there, but not output anymore.
  */
  /* fn_output_bot_of_html_file(); */ /* for all report-bottom stuff */





#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   /*    else if (strstr(trait_name, "Best Calendar Year") != NULL) */
*   /* get stress number for this year
*   */
*   char stringBuffForStressScore[64]; /* for instruction  "return only year stress score" */
*   mamb_report_year_in_the_life(     /* in futdoc.o */
*     "",                           /* html_file_name, */
*     gbl_csv_person_string_in_htm,
*     gbl_year_for_fut,         /* for stress num table at bottom */
*     "return only year stress score",   /* instructions for mamb_report_year_in_the_life() */
*     stringBuffForStressScore   );
* tn();b(112);ks(stringBuffForStressScore);
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/






  /* make table having stress score for the year
  *  but only if the person was alive for the whole calendar year
  */
  if (gbl_is_first_year_in_life == 0) {

/*   f_fn_prtlin("  <table class=\"trait\"> <tr> <th colspan=\"3\"> Single Stress Score For the Whole Year </th> </tr>"); */

  f_fn_prtlin("  <div><br><br><br></div>");
/*     "  <table class=\"trait\"> <tr> <th colspan=\"3\"> Single Score For %s </tr>", */
  sprintf(writebuf,
    "  <table class=\"trait\"> <tr> <th colspan=\"3\"> Score For %s </tr>",
    gbl_year_for_fut
  );
  f_fn_prtlin(writebuf);

/*   f_fn_prtlin("</table>"); */
/*   f_fn_prtlin("<table class=\"trait\">" ); */

  f_fn_prtlin("  <tr > <th>Person</th> <th>Score</th> <th></th></tr>");


  /* calibrate stress score for table */
/*   int worknum; 
*     worknum = targetDayScore;
*     worknum = worknum * -1; 
*     worknum = worknum + 900;
*     if (worknum <= 0) worknum = 1;
*     worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
*     targetDayScore = worknum;
* 
*     PERCENTILE_RANK_SCORE =
*       mapBenchmarkNumToPctlRank(targetDayScore);
*/
/* ks(gbl_person_name); */
  strcpy(gbl_name_for_fut, arr(1));  /* for stress num table at bottom */
  strcpy(gbl_year_for_fut, arr(2));  /* for stress num table at bottom */
/*   strcpy(gbl_person_name, arr(1)); */

  if (gbl_YearStressScore == 0) gbl_YearStressScore = 1; 

  if (gbl_YearStressScore >= 90) {
    write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore);
  }
  f_fn_prtlin("  <tr class=\"cGr2\"><td></td> <td> 90  </td> <td>Great</td> </tr>");
  if (gbl_YearStressScore >= 75) {
    write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore);
  }
  f_fn_prtlin("  <tr class=\"cGre\"><td></td> <td> 75  </td> <td>Good</td> </tr>");

  if ( gbl_YearStressScore  >= 75) {
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
  }
  if ( gbl_YearStressScore  < 75  &&  gbl_YearStressScore >= 50 ) {
    write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore);
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
  }
  if ( gbl_YearStressScore  < 50  &&  gbl_YearStressScore >= 25 ) {
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore);
  }
  if ( gbl_YearStressScore <= 25 ) {
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
  }

  if (gbl_YearStressScore >  25)
    write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore);
  f_fn_prtlin("  <tr class=\"cRed\"><td></td> <td> 25  </td> <td>Stress</td> </tr>");
  if (gbl_YearStressScore >  10)
    write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore);


  f_fn_prtlin("  <tr class=\"cRe2\"><td></td> <td> 10  </td> <td>OMG</td> </tr>");
  write_calendar_day_score(gbl_name_for_fut, gbl_YearStressScore); /* only writes if still unwritten */

  f_fn_prtlin("  </table>");


/*   f_fn_prtlin("<div><br></div>"); */
  f_fn_prtlin("<pre class=prebox> ");
  gblWeAreInPREblockContent = 1;  /* true */
/*   f_fn_prtlin(" Check out Group reports \"Best Year\" and \"Best Day\". "); */
/*   f_fn_prtlin("   Check out Group report \"Best Year\".   "); */

/*   f_fn_prtlin(""); */
/*   f_fn_prtlin("   Check out group report Best Year which uses   "); */

  f_fn_prtlin("  Check out group report \"Best Year\" which uses   ");
  f_fn_prtlin("  this score to compare with other group members.  ");
  f_fn_prtlin("");
  gblWeAreInPREblockContent = 0;  /* false */
  f_fn_prtlin("</pre> ");

  } /* only when gbl_is_first_year_in_life == 0 */


  f_fn_prtlin("<div><br><br></div>");
  f_fn_prtlin("<pre class=prebox> ");
  gblWeAreInPREblockContent = 1;  /* true */
  f_fn_prtlin( "                                                                ");
  f_fn_prtlin( "  Your intense willpower can overcome and control your destiny  ");
  f_fn_prtlin( "                                                                ");
  gblWeAreInPREblockContent = 0;  /* false */
  f_fn_prtlin("</pre>");

  sprintf(writebuf, "<h5><br><br><br>produced by iPhone app %s</h5>", APP_NAME);
  f_fn_prtlin(writebuf);
/*   f_fn_prtlin("<h4><span style=\"background-color:#FFBAC7;\">&nbsp&nbsp&nbsp&nbsp&nbsp  This report is for entertainment purposes only.&nbsp&nbsp&nbsp&nbsp&nbsp  </span></h4>"); */

  f_fn_prtlin("<h4><span style=\"background-color:#FFBAC7;\">&nbspThis report is for entertainment purposes only.&nbsp</span></h4>");


  f_fn_prtlin("");
  f_fn_prtlin("</pre>");


  f_fn_prtlin("\n</body>\n");
  f_fn_prtlin("</html>");

} /* end of fn_outputGrhAndAspects() */


/* ************************************************************
*
* ************************************************************/
void f_fn_aspect_text(char *aspect_code) {
  int nn;
/* trn("f_fn_aspect_text(char *aspect_code)"); */

  nn = binsearch_asp(aspect_code, f_asptab, NKEYS_ASP);
  if (nn < 0) return;  /* do not print any aspect text at all  */

  strcpy(my_aspect_text, f_asptab[nn].asp_text);

/*    put_br_every_n(my_aspect_text, 65);  */
   put_br_every_n(my_aspect_text, 72); 

  /* example output for text paragraph:
  * 
  *  <table class="center"><tr><td style="white-space: nowrap"><p>You1are restless about current conditions and conventional ways of doing things. <br>There's a possibility that you can turn to unusual or even impractical projects. <br>Beware of association with eccentric or unstable people at this time.</p></td></tr></table>
  */

  char para_beg[133];
  char para_end[133];

  strcpy(para_beg, "<table class=\"center\"><tr><td><p>");

  strcpy(para_end, "</p></td></tr></table>");
  sprintf(writebuf, "  %s%s%s\n", para_beg, my_aspect_text, para_end);

  f_fn_prtlin(writebuf);

}  /* end of f_fn_aspect_text(); */


/* ************************************************************
* this is called once per aspect in docin
* From February 28, 2008 to March 31, 2008 and also from June 17, 2008 to July 1, 2008.  ^(vecju)
* ************************************************************/
void fn_aspect_from_to(char *doclin)
{
  char fromtoline[1024];
  char look_starting_here[1024];
  char *p;
/* tn();trn("in fn_aspect_from_to()");  */


  strcpy(fromtoline, doclin);
  is_first_from_to_in_doclin = 1;

  /* get return value aspect_code like "^(vecju)"
  */
  p = strstr(fromtoline, " ^");
  if (p != NULL) {
    strcpy(aspect_code, p + 1);
  }
 
  /* make "^(vecju)" int "vecju"
  */
  scharout(aspect_code,'^');   
  scharout(aspect_code,'(');   
  scharout(aspect_code,')');   

  *p = '\0';   /* end the fromtoline string here */
  strcpy(look_starting_here, fromtoline);

  do {  /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */

    p = strstr(look_starting_here, " from");  /* look for a " from" */

    if (p != NULL) {
      strcpy(s3, p + 1);
    }
    if (p == NULL) {  
      /* only one from/to in doclin
      *  (less leading white for 2nd, 3rd)
      */
      if (is_first_from_to_in_doclin == 1) {
        sprintf(s1, "%s%s%s", "  <h4><br><br><br>", look_starting_here, "</h4>");
      } else {
        sprintf(s1, "%s%s%s", "  <h4>", look_starting_here, "</h4>");
      }
      f_fn_prtlin(s1);
      is_first_from_to_in_doclin = 0;
      break;  /* done */

    } else {

      /* found another from/to.  Now print the first from/to.
      *  p points to sp in " from" 
      */
      mkstr(s2, look_starting_here, p ); /* up to space in " from" */
      if (is_first_from_to_in_doclin == 1) {
        sprintf(s3, "%s%s%s", "  <h4><br><br><br><br>", s2, "</h4>");
      } else {
        sprintf(s3, "%s%s%s", "  <h4><br>", s2, "</h4>");
      }

      f_fn_prtlin(s3);
      is_first_from_to_in_doclin = 0;

      /*       strcpy(look_starting_here, p + 1); copy str into itself (nono) */
      strcpy(s5, p + 1);
      strcpy(look_starting_here, s5);
    }
  } while (p != NULL);   /* ++++++++++++++++++++++++++++++++++++ */


  /* here the from/to intro text has been output */

    /* output the aspect text
    */
    f_fn_aspect_text(aspect_code);

}  /* end of fn_aspect_from_to(); */


/* c examples
*       n = sprintf(p,"%s", "\n[beg_topinfo1]\n");
*       fput(p,n,fFP_DOCIN_FILE);
* 
*       n = sprintf(p,"%s\n", scapwords(&fA_EVENT_NAME[0]));
*       fput(p,n,fFP_DOCIN_FILE);
*/
void f_fn_prtlin(char *lin) {
  char myEOL[8];
  char myLastLine[4048];
  char *ptr;

  /* determine end of line method
  */
  strcpy(myEOL, "\n");
  if (GBL_HTML_HAS_NEWLINES == 1)       strcpy(myEOL, "\n");
  if (GBL_HTML_HAS_NEWLINES == 0) {
    /*    scharout(lin,'\n'); */  /* remove newlines */
    if (gblWeAreInPREblockContent == 1) strcpy(myEOL, "<br>");
    else                                strcpy(myEOL, "");
  }

  /* peek ahead to the next input line
  *  if this current line has GREAT or GO0D in it
  *    replace it with 7 spaces
  *  if the next input line has "-GREAT" or -GOOD in it
  *    on this current line, replace last 7 spaces with GREAT or GOOD 
       *   strcpy(in_line, global_docin_lines[global_read_idx] ); *
  */
  if (gbl_do_readahead == 1) {
/* b(20); */

    strcpy(s1, global_docin_lines[global_read_idx + 1]); /* get next input line */
/* trn("curr=");ks(lin); */
/* trn("next=");ks(s1); */

    /* if first line of graph is GREAT or GOOD, print it as is
    */
    if (gbl_just_started_readahead == 1 ) {
      if (((strstr(lin, "GREAT") != NULL) || strstr(lin, "GOOD") != NULL)) {


/* tn();trn("in 1st line G"); */
/* ksn(lin); */
        n = sprintf(p,"%s%s", lin, myEOL);
        fput(p, n, Fp_f_HTML_file);        /* PRINT the line */
        strcpy(gbl_prtlin_lastline, p); /* save last line printed in gbl */
        return;
      } 
      gbl_just_started_readahead = 0;

    } else if (strstr(s1, "GREAT") != NULL) {
/* tn();trn("in GREAT NEXT"); */

      /* replace last 7 spaces with GREAT */
/*       s1[strlen(gbl_prtlin_lastline) - 7] = '\0'; */
      /* lastline,  append GREAT */
/*       sprintf(lin, "%s<span class=\"cGr2\">-GREAT </span>%s", s1, myEOL); */

/*       strcpy(s2, "-GREAT "); */
      strcpy(s2, " GREAT ");
      /* into s3, get rest of string from 8th char */
      strcpy(s3, &doclin[8 - 1]);
/*       strcpy(s3, &lin[8 - 1]); */
/* ksn(s3); */
      /* replace " GREAT|" with "-GREAT " and put on right side */
      sprintf(writebuf, " %s<span class=\"cGr2\">%s</span>", s3, s2); 
      bracket_string_of("X", writebuf, "<span class=\"cGr2\">", "</span>");
/* tn();b(334);ks(writebuf); */
      bracket_string_of("#", writebuf, "<span class=\"cSky\">", "</span>");
/* tn();b(335);ks(writebuf); */
      scharswitch(writebuf, 'X', ' ');
      scharswitch(writebuf, '#', ' ');
      scharswitch(writebuf, '|', ' ');  /* sideline out */
/* ksn(writebuf); */
/* ksn(myEOL); */
    /*  scharout(writebuf,'\n');*/  /* remove newlines */

      n = sprintf(p,"%s%s", writebuf, myEOL);
/*       n = sprintf(p,"%s", writebuf); */
/* trn("GREAT next printed=");ks(p); */
      fput(p, n, Fp_f_HTML_file);        /* PRINT the line */
      strcpy(gbl_prtlin_lastline, p); /* save last line printed in gbl */
      return;

    } else if (strstr(s1, "GOOD") != NULL) {
/* tn();trn("in GOOD NEXT"); */
/* ksn(global_docin_lines[global_read_idx - 1]); */
/* ksn(global_docin_lines[global_read_idx ]); */
/* ksn(global_docin_lines[global_read_idx + 1]); */
      /* replace last 7 spaces with GREAT */
/*       s1[strlen(gbl_prtlin_lastline) - 7] = '\0';  */
      /* lastline,  append GREAT */
/*       sprintf(lin, "%s<span class=\"cGre\">-GOOD </span>%s", s1, myEOL); */
/* ksn(doclin); */
/*       strcpy(s2, "-GOOD  "); */
      strcpy(s2, " GOOD  ");
      /* into s3, get rest of string from 8th char */
      strcpy(s3, &doclin[8 - 1]);
/*       strcpy(s3, &lin[8 - 1]); */
      sprintf(writebuf, " %s<span class=\"cGre\">%s</span>", s3, s2); 
      bracket_string_of("X", writebuf, "<span class=\"cGre\">", "</span>");
      bracket_string_of("#", writebuf, "<span class=\"cSky\">", "</span>");
      scharswitch(writebuf, 'X', ' ');
      scharswitch(writebuf, '#', ' ');
      scharswitch(writebuf, '|', ' ');  /* sideline out */

      n = sprintf(p,"%s%s", writebuf, myEOL);
/* trn("GOOD next printed=");ks(p); */
      fput(p, n, Fp_f_HTML_file);
      strcpy(gbl_prtlin_lastline, p);

      return;

    } else if ( strstr(lin, "GREAT") != NULL) {
/* tn();trn("in GREAT current"); */
/* ksn(lin); */
      /* remove GREAT from current line and substitute 7 spaces */
      strcpy(s1, lin);
/* ksn(s1); */
/*       ptr = strstr(s1, "<span class=\"cGr2\">-GREAT </span>"); */
      ptr = strstr(s1, "<span class=\"cGr2\"> GREAT </span>");
/* ksn(ptr); */
/*       memcpy(ptr, "       \n\0", 9); */
      memcpy(ptr, "       \0", 8);
/* ksn(ptr); */
/* ksn(s1); */
      strcpy(lin,s1);
/* ksn(lin); */
/* exit(320); */
      n = sprintf(p,"%s%s", writebuf, myEOL);
/* trn("GREAT curr printed=");ks(p); */
      fput(p, n, Fp_f_HTML_file);
      strcpy(gbl_prtlin_lastline, p);

      return;

    } else if ( strstr(lin, "GOOD")  != NULL) {
/* tn();trn("in GOOD current"); */
      /* remove GOOD from current line and substitute 7 spaces */
/* ksn(lin); */
      strcpy(s5, lin);
/* ksn(s5); */
      char *myptrtest;
/* char tststr[1024]; */
/* strcpy(tststr, "<span class=\"cGre\"> GOOD </span>"); */
/* ksn(tststr); */
      myptrtest = strstr(lin, "<span class=\"cGre\"> GOOD  </span>");
/* ksn(myptrtest); */
/*       memcpy(ptr, "       \n\0", 9); */
      memcpy(myptrtest, "       \0", 8);
/*       s1[strlen(gbl_prtlin_lastline) - 7] = '\0'; */
/* ksn(myptrtest); */
/* ksn(s5); */
/*       strcpy(lin,s5); */
/* ksn(lin); */

      n = sprintf(p,"%s%s", writebuf, myEOL);
/* trn("GOOD curr printed=");ks(p); */
      fput(p, n, Fp_f_HTML_file);
      strcpy(gbl_prtlin_lastline, p);

      gbl_do_readahead  = 0; /* do readahead until "GOOD" label is printed */
      return;
    }

  } /* (gbl_do_readahead == 1) */


/* <.> */

/* tn();trn("FALL THRU"); */

/*   if (   strstr(gbl_prtlin_lastline, "First Half") != NULL */
/*       && strstr(lin,                 "First Half") != NULL  */

  /* print blank line  under the first 6 months
  */
  if (   strstr(gbl_prtlin_lastline, "First 6 months") != NULL
      && strstr(lin,                 "First 6 months") != NULL 
     ) {
/*     n = sprintf(p,"%s\n", "" ); */
/*     n = sprintf(p,"%s%s", "", myEOL); */
    n = sprintf(p,"%s",  myEOL);
    fput(p, n, Fp_f_HTML_file);
    strcpy(gbl_prtlin_lastline, p); /* save last line printed in gbl */

    /* start readahead after printing line with "6 months" in it
    */
    if(strstr(lin, "6 months") != NULL) {
      gbl_do_readahead           = 1; /* do readahead until "GOOD" label is printed */
      gbl_just_started_readahead = 1;
    }

    return;
  }
/*   if (   strstr(gbl_prtlin_lastline, "Second Half") != NULL */
/*       && strstr(lin,                 "Second Half") != NULL  */
  if (   strstr(gbl_prtlin_lastline, "Second 6 months") != NULL
      && strstr(lin,                 "Second 6 months") != NULL 
     ) {
/*     n = sprintf(p,"%s\n", "" ); */
    n = sprintf(p,"%s%s", "", myEOL);
    fput(p, n, Fp_f_HTML_file);
    strcpy(gbl_prtlin_lastline, p); /* save last line printed in gbl */

    /* start readahead after printing line with "6 months" in it
    */
    if(strstr(lin, "6 months") != NULL) {
      gbl_do_readahead           = 1; /* do readahead until "GOOD" label is printed */
      gbl_just_started_readahead = 1;
    }

    return;
  }

  if (   strstr(gbl_prtlin_lastline, "|   10   20") != NULL  /* avoid double print */
      && strstr(lin,                 "|   10   20") != NULL 
     ) {
    return;
  }


  /* if last line printed has "-STRESS"  AND this line has "-STRESS"
  *  do not print this line
  *  (bug with 2 "STRESS-" lines when star is on bottom line and
  *  bottom line is stress line)
  */
  if (   strstr(gbl_prtlin_lastline, "STRESS") != NULL
/*       && strstr(lin,                 "STRESS-") != NULL  */
      && strstr(lin,                 "STRESS") != NULL 
     ) {
    return;
  }


/* if (strstr(lin, "GREAT-") != NULL) { */
/* tn();trn("f_fn_prtlin() GREAT   at TOP    "); ksn(lin); } */


  /* weird fix 
  *  if line has "STRESS-", but does NOT have "span", do not print it
  */
/*   if(strstr(lin, "STRESS-") != NULL */
/*   if(strstr(lin, "-STRESS") != NULL */
  if(strstr(lin, "STRESS") != NULL
  && strstr(lin, "span")    == NULL)  return;
  
  /* weird fix  #2   long blank line at top
  */
  if (strstr(lin, " <span class=\"cSky\">                                                                                              </span>" )  != NULL) {
   /* tn();b(555);ks("HIT BAD sky!"); */
   return;
  }

  /* weird fix #3
  *  if line has "OMG-", but does NOT have "cRe2", do not print it
  *  BUT, print a line of spaces in cRe2
  */
  if(strstr(lin, "OMG-") != NULL
  && strstr(lin, "cRe2")    == NULL)  {
    /* print blank line with color cRe2 under the 1st OMG */
    /* #define NUM_PTS_FOR_FUT 92 */
    sfill(myLastLine, NUM_PTS_FOR_FUT, ' '); 
    bracket_string_of(" ", myLastLine, "<span class=\"cRe2\">", "</span>");
  
/*     n = sprintf(p,"       %s\n", myLastLine );  */
    n = sprintf(p,"       %s%s", myLastLine, myEOL); /* left margin = 7 spaces */
    fput(p, n, Fp_f_HTML_file);
    strcpy(gbl_prtlin_lastline, p); /* save last line printed in gbl */
    return;
  }

/* GREAT is too short here, but OK in docin array   what hpppend? */
/* if (strstr(lin, "GREAT-") != NULL) { */
/* tn();trn("f_fn_prtlin() GREAT"); ksn(lin); } */

  /* remove pipe at end of any line with a pipe in it
  */
  char *end_pipe;
  end_pipe = strstr(lin, "|<");  /* looks like "|</span>" */
  if(end_pipe != NULL) {     
    memcpy(end_pipe, " ", 1);
  }
  end_pipe = strstr(lin, "|       <");  /* looks like "|       </span>" */
  if(end_pipe != NULL) {     
    memcpy(end_pipe, " ", 1);
  }
  

  n = sprintf(p,"%s%s", lin, myEOL);
  fput(p, n, Fp_f_HTML_file);        /* PRINT the line */
  strcpy(gbl_prtlin_lastline, p); /* save last line printed in gbl */


/* trn("end of f_fn_prtlin()"); */
} /* end of f_fn_prtlin() */


/* no \n at end */
/* void f_fn_prtlin_aspect(char *lin) { 
*   n = sprintf(p,"%s", lin);
*   fput(p, n, Fp_HTML_file);
* }  
*/


/* arg in_docin_last_idx  is pointing at the last line written.
* Therefore, the current docin_lines written
* run from index = 0 to index = arg in_docin_last_idx.
*/
void f_docin_get(char *in_line)
{
/* trn("in f_docin_get(char *in_line)"); */

/*   static int times_thru; */
/*   if (times_thru == 0) global_read_idx = 0; */
/*   else                 global_read_idx++; */
/*   times_thru++;  */

  if (is_first_f_docin_get == 1) global_read_idx = 0;
  else                           global_read_idx++;
  
  is_first_f_docin_get = 0;  /* set to false */

  if (global_read_idx > global_max_docin_idx) {
     f_docin_free();
    rkabort("Error. futhtm.c walked off end of docin_lines array");
  }

  strcpy(in_line, global_docin_lines[global_read_idx] );

  scharout(in_line,'\n');   /* remove newlines */

} /* end of f_docin_get */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* Take long string and wrap lines with "<br>" to a given max line length
* *
* *  Put "<br>"s in arg1 string so lines are not longer than arg2.
* */
* void put_br_every_n(char *instr,  int line_not_longer_than_this)
* {
*   char *pNewWord;
*   int len_new_word, lenbuf, num_br_added;
* 
* tn(); trn(" in put_br_every_n() ------------------------------");
* ksn(instr);
*   strcpy(writebuf, "");
*   strcpy(workbuf, "");
*   num_br_added = 0;
* 
*   pNewWord = strtok (instr," ");  /* get ptr to first word */
* 
*   while (pNewWord != NULL)  /* for all words */
*   {
*     lenbuf       = strlen(writebuf);
*     len_new_word = strlen(pNewWord);
* kin(lenbuf); tr("add this:"); ks(pNewWord);
* 
*     if (lenbuf + len_new_word >= line_not_longer_than_this) {
* 
*       if (num_br_added == 0) {
*         f_fn_right_pad_with_hidden(writebuf, line_not_longer_than_this - lenbuf);
* trn("len after pad="); ki(strlen(writebuf));
*       }
* 
*       sprintf(writebuf, "%s<br>", writebuf);   /* add break */
*       num_br_added = num_br_added + 1;
* 
*       /* add writebuf to final result in workbuf */
*       sprintf(workbuf, "%s%s", workbuf, writebuf);
* 
*       strcpy(writebuf, "");                    /* init  writebuf */
*     } /* write out since line too long */
* 
*     /* add new word to writebuf */
*     sprintf(writebuf, "%s%s%s", writebuf, pNewWord, " ");
*     pNewWord = strtok (NULL, " ");             /* get ptr to next word */
* 
*   }  /* for all words */
* 
* 
*   /* here no more words in aspect desc (writebuf has last line to add) */
* 
*   if (strlen(writebuf) != 0) {
* 
*     /* add writebuf to final result in instr but remove sp at end */
*     writebuf[ strlen(writebuf) - 1] = '\0';
* 
*     if (num_br_added == 0) {
*       lenbuf = strlen(writebuf);
*       f_fn_right_pad_with_hidden(writebuf, line_not_longer_than_this - lenbuf);
*     }
* 
*     sprintf(instr, "%s%s", workbuf, writebuf);  /* adding writebuf */
*   } else {
*     /* here writebuf is "" */
*     /* remove "<br>"  (+ sp) from the end*/
*     workbuf[ strlen(workbuf) - 5] = '\0';
* 
*     sprintf(instr, "%s", workbuf);
*   }
* 
* 
* }/* end of put_br_every_n() */
* 
* void f_fn_right_pad_with_hidden(char *s_to_pad, int num_to_pad)
* {
*   char my_right_padding_chars[80];
* /*   char *lotsachars = "_________________________________________________________"; */
* /*   char *lotsachars = "Lorem ipsum calor sit amet, consecr adipi elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at,"; */
* /*   char *lotsachars = "lom  ipim  cor  sit  amet,  cosecr  adipi  elit.  nam  cirvus.  morbi  ut  mi.  nullam  enim  leo,  ege stas  id,  con dimen tum  at,"; */
* /*   char *lotsachars ="a a a a M M M M M Ma Ma Ma M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  "; */
*   char *lotsachars = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
* 
* tn(); trn(" in f_fn_right_pad_with_hidden() ===========================================");
* kin(num_to_pad);ks(s_to_pad);
* 
* /*   if (num_to_pad <= 0) return;  */
*   if (num_to_pad <= 0) return;
* 
*   /* make right pad chars */
*   mkstr(my_right_padding_chars, lotsachars, lotsachars + num_to_pad - 1);
*   sprintf (s_to_pad,
*     "%s<span style=\"visibility: hidden\">%s</span>",
*     s_to_pad,
*     my_right_padding_chars
*   );
* tr("padded = "); ks(s_to_pad);
* }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/



/* make short html file for best day for a person
*/
int make_calendar_day_html_file(   /* called from futdoc.c  */
  char *html_f_file_name,
  char *csv_person_string,
  int itarget_mm,
  int itarget_dd,
  int itarget_yyyy,
  int targetDayScore)
{
  int PERCENTILE_RANK_SCORE;
  char person_name[32];
  fopen_fpdb_for_debug();

/* tn();trn("in make_calendar_day_html_file()"); */

  gblCalDayScoreIsWritten = 0;  /* init */

  strcpy(gbl_ffnameHTML, html_f_file_name);

  /* open output HTML file
  */
  if ( (Fp_f_HTML_file = fopen(html_f_file_name, "w")) == NULL ) {
    rkabort("Error  when  futhum.c.  fopen().");
  }

/*  at end, change to STRICT  maybe */
  f_fn_prtlin( "<!doctype html public \"-//w3c//dtd html 4.01 transitional//en\" ");
  f_fn_prtlin( "  \"http://www.w3.org/TR/html4/loose.dtd\">");

  f_fn_prtlin( "<html>");
  f_fn_prtlin( "\n<head>");

  strcpy(person_name,  csv_get_field(csv_person_string, ",", 1));
/*   strcpy(gbl_person_name, person_name); */


  /* <TITLE> */

/*   sprintf(writebuf,
*     "  <title>%s %04d%02d%02d- Calendar Day, produced by iPhone app %s.</title>",
*     person_name,
*     itarget_yyyy,
*     itarget_mm,
*     itarget_dd,
*     APP_NAME );
*   f_fn_prtlin(writebuf);
*/
  
  /* if HTML filename, gbl_ffnameHTML, has any slashes, grab the basename
  */
  char myBaseName[256], *myptr;
  if (sfind(gbl_ffnameHTML, '/')) {
    myptr = strrchr(gbl_ffnameHTML, '/');
    strcpy(myBaseName, myptr + 1);
  } else {
    strcpy(myBaseName, gbl_ffnameHTML);
  }
  sprintf(writebuf, "  <title>%s</title>", myBaseName);


  f_fn_prtlin(writebuf);
  




  /* HEAD  META
  */
  sprintf(writebuf, "  <meta name=\"description\" content=\"Calendar Day report produced by iPhone app %s\"> ",  APP_NAME);
  f_fn_prtlin(writebuf);


  f_fn_prtlin( "  <meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"iso-8859-1\">"); 
  /*   f_fn_prtlin( "  <meta name=\"Author\" content=\"Author goes here\">"); */


/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"group,member,astrology,personality,future,past,year in the life,compatibility,GMCR\">  */
/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"abym,Astromeasur,group,member,best,match,calendar,year,passionate,personality\"> "); */
/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"BFF,astrology,compatibility,group,best,match,calendar,year,stress,personality\"> "); */
/*   f_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,compatibility,group,best,match,personality,stress,calendar,year\"> "); */ /* 86 chars */
  f_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,me,compatibility,group,best,match,personality,stress,calendar,year\"> ");  /* 89 chars */


  /* get rid of CHROME translate "this page is in Galician" 
  * do you want to translate?
  */
  f_fn_prtlin("  <meta name=\"google\" content=\"notranslate\">");
  f_fn_prtlin("  <meta http-equiv=\"Content-Language\" content=\"en\" />");



  /* HEAD   STYLE/CSS
  */
  f_fn_prtlin( "\n  <style type=\"text/css\">");
  f_fn_prtlin( "    BODY {");

  f_fn_prtlin( "      background-color: #F7ebd1;");

/*   f_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      font-size:   medium;");
  f_fn_prtlin( "      font-weight: normal;");
  f_fn_prtlin( "      text-align:  center;");
  /* example comment out */
  /*   f_fn_prtlin( "    <!-- "); */
  /*   f_fn_prtlin( "      background-image: url('mkgif1g.gif');"); */
  /*   f_fn_prtlin( "    --> "); */
  f_fn_prtlin( "    }");

  f_fn_prtlin( "    H1 { font-size: 137%; font-weight: bold;   line-height: 95%; text-align: center;}");
  f_fn_prtlin( "    H2 { font-size: 125%;                      line-height: 25%; text-align: center;}");
  f_fn_prtlin( "    H3 { font-size: 110%; font-weight: normal; line-height: 30%; text-align: center;}");

  f_fn_prtlin( "    H4 { font-size:  75%; font-weight: bold;   line-height: 30%; text-align: center;}");
  f_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}");

  f_fn_prtlin( "    PRE {");
  f_fn_prtlin( "      text-align:  left;");
/*   f_fn_prtlin( "      font-size:   90%;"); */
  f_fn_prtlin( "      display: inline-block;");

/*   f_fn_prtlin( "      border-style: solid;"); */
/*   f_fn_prtlin( "      border-color: #e4dfae; "); */
/*   f_fn_prtlin( "      border-width: 5px;"); */

  f_fn_prtlin( "      background-color: #fcfce0;");
  f_fn_prtlin( "      border: none;");
  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
/*   f_fn_prtlin( "      line-height: 90%;"); */
/*   f_fn_prtlin( "      font-size: 85%;"); */
  f_fn_prtlin( "      font-size: 75%;");

  f_fn_prtlin( "      border-spacing: 0;");
/*       border-collapse: collapse; */
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      font-weight: normal;");
/*   f_fn_prtlin( "      line-height: 100%;"); */
  f_fn_prtlin( "      margin:0 auto;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    P { ");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      width: auto;");
  f_fn_prtlin( "      font-size:   93%;");
  f_fn_prtlin( "      margin-top: 0;");
  f_fn_prtlin( "      margin-bottom: 0;");
  f_fn_prtlin( "      margin-left: auto;");
  f_fn_prtlin( "      margin-right:auto;");
/*   f_fn_prtlin( "      padding-left: 5%;"); */
/*   f_fn_prtlin( "      padding-right:5%;"); */
/*   f_fn_prtlin( "      text-align: center;"); */
  f_fn_prtlin( "      text-align: left;");
  f_fn_prtlin( "    }");
/* for table: */
/*       border: 2px solid black; */
/*       cellspacing: 0; */
/*       border-top: 0; */
/*       border-bottom: 0; */
  f_fn_prtlin( "    table {");
  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.center {");
  f_fn_prtlin( "      margin-left:auto;");
  f_fn_prtlin( "      margin-right:auto;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    TD {");
  f_fn_prtlin( "      white-space: nowrap;");
  f_fn_prtlin( "      padding: 0;");
  f_fn_prtlin( "    }");

  f_fn_prtlin( "    .row4        { background-color:#f8f0c0; }");

/*   f_fn_prtlin( "    .cGr2        { background-color:#d0fda0; }");
*   f_fn_prtlin( "    .cGre        { background-color:#e1fdc3; }");
*   f_fn_prtlin( "    .cRed        { background-color:#ffd9d9; }");
*   f_fn_prtlin( "    .cRe2        { background-color:#fcb9b9; }");
*/

/*   p_fn_prtlin( "    .cGr2        { background-color:#d0fda0; }"); */
/*   f_fn_prtlin( "    .cGr2        { background-color:#8bfd87; }"); */
/*   f_fn_prtlin( "    .cGr2        { background-color:#66ff33; }"); */

/*   p_fn_prtlin( "    .cGre        { background-color:#e1fdc3; }"); */
/*   f_fn_prtlin( "    .cGre        { background-color:#ccffb9; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ffd9d9; }"); */
/*   f_fn_prtlin( "    .cRed        { background-color:#ffcccc; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fcb9b9; }"); */
/*   f_fn_prtlin( "    .cRe2        { background-color:#fc8888; }"); */
/*   f_fn_prtlin( "    .cRe2        { background-color:#ff6094; }"); */
/*   f_fn_prtlin( "    .cRe2        { background-color:#ff3366; }"); */


  f_fn_prtlin( "    .cGr2        { background-color:#66ff33; }");
/*   f_fn_prtlin( "    .cGre        { background-color:#84ff98; }"); */
  f_fn_prtlin( "    .cGre        { background-color:#a8ff98; }");
  f_fn_prtlin( "    .cRed        { background-color:#ff98a8; }");
  f_fn_prtlin( "    .cRe2        { background-color:#ff4477; }");

/*   f_fn_prtlin("    .cNeu        { background-color:#e1ddc3; }"); */
  f_fn_prtlin("    .cNeu        { background-color:#e5e2c7; }");

  f_fn_prtlin( "    .cSky        { background-color:#3f3ffa; }");

  f_fn_prtlin( "    .star        { color:#f7ebd1; }");

  f_fn_prtlin("     .cNam        { color:#3f3ffa;");
  f_fn_prtlin("                   background-color: #F7ebd1;");
  f_fn_prtlin("                   font-size: 133%;");
  f_fn_prtlin("    }");

  f_fn_prtlin( "    table.trait {");
  f_fn_prtlin( "      margin-left: auto;");
  f_fn_prtlin( "      margin-right:auto;");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      text-align: left;");

/*   f_fn_prtlin( "      border: 1px solid black;"); */
  f_fn_prtlin( "      border: none;");

  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.trait td {");
/*   f_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      white-space: pre;");
  f_fn_prtlin( "      font-size: 90%;");
  f_fn_prtlin( "      text-align: left;");

/*   f_fn_prtlin( "      border: 1px solid black;"); */
  f_fn_prtlin( "      border: none;");

  f_fn_prtlin( "      border-collapse: collapse;");
  f_fn_prtlin( "      border-spacing: 0;");
  f_fn_prtlin( "      padding-left: 10px; ");
  f_fn_prtlin( "      padding-right: 10px; ");
  f_fn_prtlin( "      padding-top: 2px; ");
  f_fn_prtlin( "      padding-bottom: 2px; ");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.trait th{");
/*   f_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  f_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  f_fn_prtlin( "      font-size: 90%;");
  f_fn_prtlin( "      padding: 10px; ");

/*   f_fn_prtlin( "      background-color: #e1fdc3 ;"); */
  f_fn_prtlin( "      background-color: #fcfce0;");

/*   f_fn_prtlin( "      border: 1px solid black;"); */
  f_fn_prtlin( "      border: none;");

  f_fn_prtlin( "      text-align: center;");
  f_fn_prtlin( "    }");
  f_fn_prtlin( "    table.trait       td { text-align: left; }");
  f_fn_prtlin( "    table.trait    td+td { text-align: right; }");
  f_fn_prtlin( "    table.trait td+td+td { text-align: left; }");

  f_fn_prtlin( "  </style>");

/* put in favicon */
f_fn_prtlin("<link href=\"data:image/x-icon;base64,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\" rel=\"icon\" type=\"image/x-icon\" />");

  f_fn_prtlin( "</head>");
  f_fn_prtlin( " ");
  f_fn_prtlin("\n<body>");

/*   sprintf(writebuf, "\n  <h1>Calenday Day <br></h1>"); 
*   f_fn_prtlin(writebuf);
* 
*   sprintf(writebuf, "\n  <h2>%s, %s %d, %d<br></h2>",
*     fN_day_of_week[ day_of_week(itarget_mm, itarget_dd, itarget_yyyy) ],
*     N_mth_cap[itarget_mm], 
*     itarget_dd,
*     itarget_yyyy  );
*   f_fn_prtlin(writebuf);
*/
/*   sprintf(writebuf, "\n  <h1>Calendar Day &nbsp&nbsp%s, %s %d, %d</h1>",
*     fN_day_of_week[ day_of_week(itarget_mm, itarget_dd, itarget_yyyy) ],
*     N_mth_cap[itarget_mm], 
*     itarget_dd,
*     itarget_yyyy   );
*   f_fn_prtlin(writebuf);
*/
/*   <h1>Calendar Day </h1>
*   <h1>Wed &nbspMay 21 2014 </h1>
*   <h2><br><br>for <span class="cNam">ulli</span><br></h2>
*/


  f_fn_prtlin("<div><br></div>");
  f_fn_prtlin("  <h1>Calendar Day </h1>");

  sprintf(writebuf, "   <h2>%s &nbsp%s %d %d</h2>",
    fN_day_of_week[ day_of_week(itarget_mm, itarget_dd, itarget_yyyy) ],
    N_mth_cap[itarget_mm], 
    itarget_dd,
    itarget_yyyy   );
  f_fn_prtlin(writebuf);


  sprintf(writebuf, "  <h2><br><br>for <span class=\"cNam\">%s</span><br></h2>",
    person_name    ); 
  f_fn_prtlin(writebuf);

/* <table> <tr> <th colspan="3"><br>The "compatibility score" of this pair<br>as a group with 2 members.<br>&nbsp</th> </tr>  */


/*   f_fn_prtlin("  <table class=\"trait\"> <tr> <th colspan=\"3\"><br> \"How was your day?\"<br>&nbsp</th> </tr>"); */

  f_fn_prtlin("  <table class=\"trait\"> <tr> <th colspan=\"3\"> How was your day?</th> </tr>");

/*   f_fn_prtlin("</table>"); */
/*   f_fn_prtlin("<table class=\"trait\">" ); */

  f_fn_prtlin("  <div><br></div>");
  f_fn_prtlin("  <tr > <th>Person</th> <th>Score</th> <th></th></tr>");


  int worknum;  /* calibrate stress score for table */
    worknum = targetDayScore;
    worknum = worknum * -1; 
    worknum = worknum + 900;
    if (worknum <= 0) worknum = 1;
    worknum = mapNumStarsToBenchmarkNum(IDX_FOR_SCORE_B, worknum);
    targetDayScore = worknum;

    PERCENTILE_RANK_SCORE =
      mapBenchmarkNumToPctlRank(targetDayScore);


/*   if (istress_score_for_target_day >= 373)
*     write_calendar_day_score(person_name, istress_score_for_target_day);
*   f_fn_prtlin("  <tr class=\"cGr2\"><td></td> <td> 373  </td> <td>Great</td> </tr>");
*   if (istress_score_for_target_day >= 213)
*     write_calendar_day_score(person_name, istress_score_for_target_day);
*   f_fn_prtlin("  <tr class=\"cGre\"><td></td> <td> 213  </td> <td>Good</td> </tr>");
*   if (istress_score_for_target_day >= 100)
*     write_calendar_day_score(person_name, istress_score_for_target_day);
*   f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 100  </td> <td>Median</td> </tr>");
*   if (istress_score_for_target_day >  42)
*     write_calendar_day_score(person_name, istress_score_for_target_day);
*   f_fn_prtlin("  <tr class=\"cRed\"><td></td> <td> 42  </td> <td>Stress</td> </tr>");
*   if (istress_score_for_target_day >  18)
*     write_calendar_day_score(person_name, istress_score_for_target_day);
*/

/*  for TEST */
/* PERCENTILE_RANK_SCORE = 10;
* PERCENTILE_RANK_SCORE = 25;
* PERCENTILE_RANK_SCORE = 50;
* PERCENTILE_RANK_SCORE = 75;
* PERCENTILE_RANK_SCORE = 90;
*/

  if (PERCENTILE_RANK_SCORE >= 90) {
    write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE);
  }
  f_fn_prtlin("  <tr class=\"cGr2\"><td></td> <td> 90  </td> <td>Great</td> </tr>");
  if (PERCENTILE_RANK_SCORE >= 75) {
    write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE);
  }
  f_fn_prtlin("  <tr class=\"cGre\"><td></td> <td> 75  </td> <td>Good</td> </tr>");

  if ( PERCENTILE_RANK_SCORE  >= 75) {
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
  }
  if ( PERCENTILE_RANK_SCORE  < 75  &&  PERCENTILE_RANK_SCORE >= 50 ) {
    write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE);
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
  }
/*   if ( PERCENTILE_RANK_SCORE  < 50  &&  PERCENTILE_RANK_SCORE >= 25 ) { */
  if ( PERCENTILE_RANK_SCORE  < 50  &&  PERCENTILE_RANK_SCORE >  25 ) {
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE);
  }
  if ( PERCENTILE_RANK_SCORE <= 25 ) {
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td> 50  </td> <td>Average</td> </tr>");
    f_fn_prtlin("  <tr class=\"cNeu\"><td></td> <td>     </td> <td></td> </tr>"); /* empty line */
  }

  if (PERCENTILE_RANK_SCORE >  25)
    write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE);
  f_fn_prtlin("  <tr class=\"cRed\"><td></td> <td> 25  </td> <td>Stress</td> </tr>");
  if (PERCENTILE_RANK_SCORE >  10)
    write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE);


  f_fn_prtlin("  <tr class=\"cRe2\"><td></td> <td> 10  </td> <td>OMG</td> </tr>");
  write_calendar_day_score(person_name, PERCENTILE_RANK_SCORE); /* only writes if still unwritten */

  f_fn_prtlin("  </table>");

/*   f_fn_prtlin("  <div><br><br></div>"); */
  f_fn_prtlin("  <div><br></div>");

/*   f_fn_prtlin("<pre><br>  Check out group report Best Day.  <br>");
*   f_fn_prtlin("     For \"How was your year?\"  ");
*   f_fn_prtlin("  check out report Calendar Year  <br>");
*   f_fn_prtlin("</pre>");
*   f_fn_prtlin("  <div><br><br></div>");
*   f_fn_prtlin("<pre><br>     This only covers short-term influences ");
*   f_fn_prtlin("     of a few hours or a day or two.<br>");
*   f_fn_prtlin("</pre>");
*/
/*   f_fn_prtlin("<pre><br>  This is about shorter influences  "); */

  f_fn_prtlin("  <pre>");         
  gblWeAreInPREblockContent = 1;  /* true */
  f_fn_prtlin("<br>  This measures short-term influences  ");

/*   f_fn_prtlin("  lasting a few hours or a day.<br>"); */
  f_fn_prtlin("  lasting a few hours.<br>");

/*   f_fn_prtlin("  Long term influences are in the  "); */
/*   f_fn_prtlin("  graphical report \"Calendar Year\" <br>"); */

  f_fn_prtlin("  More important long term influences are  ");
  f_fn_prtlin("  in the graphical report \"Calendar Year\" <br>");

  gblWeAreInPREblockContent = 0;  /* false */
  f_fn_prtlin("</pre>");


/*   f_fn_prtlin("<h5><br><br>produced by iPhone app Astrology by Measurement</h5>"); */

  sprintf(writebuf, "<h5><br><br><br>produced by iPhone app %s</h5>", APP_NAME);
  f_fn_prtlin(writebuf);


  f_fn_prtlin("<h4><span style=\"background-color:#FFBAC7;\">&nbspThis report is for entertainment purposes only.&nbsp</span></h4>");
  f_fn_prtlin("</body>");
  f_fn_prtlin("</html>");

  f_fn_prtlin("</table>");

  gblCalDayScoreIsWritten = 0;  /* re-init */

  fclose_fpdb_for_debug();

  return(0);

} /* end of make_calendar_day_html_file() */

void write_calendar_day_score(char *pname, int istress_score) {
  char rowcolor[32];

/* kin(gblCalDayScoreIsWritten); */

  if (gblCalDayScoreIsWritten == 1)  return;

  if (istress_score >= 90) strcpy(rowcolor, " class=\"cGr2\"");
  if (istress_score <  90 &&
      istress_score >= 75) strcpy(rowcolor, " class=\"cGre\"");
  if (istress_score <  75 &&
      istress_score >= 25) strcpy(rowcolor, " class=\"cNeu\"");
  if (istress_score <= 25 &&
      istress_score >  10) strcpy(rowcolor, " class=\"cRed\"");
  if (istress_score <= 10) strcpy(rowcolor, " class=\"cRe2\"");

/*   sprintf(writebuf, "  <tr><td> %s</td><td> %d  </td><td></td></tr>", pname, istress_score); */
  sprintf(writebuf, "  <tr %s><td> %s</td><td> %d  </td><td></td></tr>", rowcolor, pname, istress_score);

  f_fn_prtlin(writebuf);

  gblCalDayScoreIsWritten = 1;
}

/* end of futhtm.c */
