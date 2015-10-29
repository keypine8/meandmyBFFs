/* perhtm.c */

/* read from input docin_lines string array
* format and write an html output file
*/


#define GBL_HTML_HAS_NEWLINES 1
/* #define GBL_HTML_HAS_NEWLINES 0 */

int gbl_are_in_per_htm_webview;      /* 1 = yes, 0 = no */
int gbl_we_are_in_PRE_block_content; /* 1 = yes, 0 = no */

//char gbl_person_name[64];  // "p_" because same var in objC code
char gbl_p_person_name[64];  // "p_" because same var in objC code

char gbl_pfnameHTML[2024];
char gbl_instructions[128];

#include "rkdebug_externs.h"

#include "rk.h"
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "perhtm.h"

/* #define APP_NAME "Astrology for Me" */
/* #define APP_NAME "Astrology by Measurement" */
/* #define APP_NAME "Me & My BFFs" */
/* #define APP_NAME "\"Me & my BFFs\"" */
/* #define APP_NAME "\"My BFFs and I\"" */
#define APP_NAME "Me and my BFFs"

/* file extension for group sharing will be ".mamb" */

#define MAX_STARS 82  /* in perdoc.h also */
#define GRH_CHAR '*'  /* in perdoc.h also */

/* int rkdb = 0; */ /* 0=no, 1=yes */



void add_all_benchmark_lines(void);
void write_html_for_trait_table(void);
void write_TBLRPT_trait_data(void);            // !!!!  TBLRPT  instead of html for webview  !!!!! 
void write_webview_html_for_trait_table(void);

struct trait_table_line {
  char    trait[16];
  char    score[6];
  char    influence[16];
};
struct trait_table_line trait_lines[12];  /* need 11 */

int Func_compare_trait_line_scores(
  struct trait_table_line *line1,
  struct trait_table_line *line2
);
typedef int (*compareFunc_trait) (const void *, const void *);



void p_fn_prtlin(char *lin);
void p_fn_prtlin_aspect(char *lin);  /* no \n at end */
void p_fn_prtlin_stars(char *starline);

char  swork33[4048];


/* in mambutil.o */
extern void strsubg(char *s, char *replace_me, char *with_me);
extern int  sfind(char s[], char c);
extern int scharcnt(char *s, int c);
extern int sall(char *s, char *set);
extern char *mkstr(char *s, char *begarg, char *end);
extern void scharout(char *s, int c);
extern void put_br_every_n(char *instr, int line_not_longer_than_this);
extern void fn_right_pad_with_hidden(char *s_to_pad, int num_to_pad);
extern int binsearch_asp(char *asp_code, struct aspect tab[], int num_elements);
/* in mambutil.o */


extern void p_docin_free(void);   /* in grpdoc.o */


void p_docin_get(char *in_line);   

char doclin[512];

/* -------------------------- */
int    global_max_docin_idx;
char **global_docin_lines;
int    global_read_idx;
int    global_n;
char  *global_p = &swork33[0];
/* -------------------------- */


FILE *Fp_p_HTML_file;

/* char s1[512]; */
/* char s2[512]; */
/* char s3[512]; */
/* char s4[512]; */
/* char s5[512]; */
/* char s6[512]; */
char writebuf[4048];
char workbuf[4048];



#define MAX_WK 10
struct {
  char wk[133]; 
} wks[MAX_WK];
#define arr(nn) (wks[nn].wk)  /* arr arr arr arr arr  HERE */
/* wks is array of struct size 133 chars
* 
*  (wks[k].wk)  <==>   arr(k)
*   
*  this expression:  (wks[k].wk)  
*  gives you the kth 133-char buffer in array wks.
*
*  With the *define* below, you can say this: 
*  arr(k) for the same buffer.
*/



void do_orig_trait_graph(void);
void do_benchmark_trait_graph(void);
void p_fn_output_top_of_html_file(void);
void p_fn_webview_output_top_of_html_file(void);

char aspect_code[10];
void p_fn_browser_aspect_text(char *aspect_code);
void p_fn_webview_aspect_text(char *aspect_code);

int is_first_p_docin_get;  /* 1=yes, 0=no */



int make_per_htm_file_webview(
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx);

int make_per_htm_file_browser(  
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx);


/* invocation
*
* retval = make_per_htm_file(html_output_filename, docin_lines, docin_idx);
*
*  output entire ".html" file
*/
int make_per_htm_file(      // =========================================
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx,
  char *instructions
)
{
/* tn();trn("in make_per_htm_file()"); */
/* ksn(instructions); */
/* ksn(in_html_filename); */

  is_first_p_docin_get = 1;       /* init to true */
  gbl_we_are_in_PRE_block_content = 0;  /* init to false */

  strcpy(gbl_pfnameHTML, in_html_filename);

  int  retval;

  global_max_docin_idx = in_docin_last_idx;
  global_docin_lines   = in_docin_lines;
  strcpy(gbl_instructions, instructions);

  if (strstr(gbl_instructions, "make html for webview") != NULL) {
/* tn();trn("make html for webview");ksn(in_html_filename); */
    gbl_are_in_per_htm_webview = 1;
    retval = make_per_htm_file_webview (
      in_html_filename,
      in_docin_lines,
      in_docin_last_idx
    );
    if (retval != 0) return 1;
  }
  if (strstr(gbl_instructions, "make html for browser") != NULL) {
/* tn();trn("make html for browser");ksn(in_html_filename); */
    gbl_are_in_per_htm_webview = 0;
    retval = make_per_htm_file_browser (
      in_html_filename,
      in_docin_lines,
      in_docin_last_idx
    );
    if (retval != 0) return 1;
  }
  return 0;
} // end of  make_per_htm_file()  // =========================================



int make_per_htm_file_webview(      
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx)
{
/* tn();trn("in make_per_htm_file_webview"); */
/* ksn(in_html_filename); */
  is_first_p_docin_get = 1;       /* init to true */
  gbl_we_are_in_PRE_block_content = 0;  /* init to false */

  strcpy(gbl_pfnameHTML, in_html_filename);

  int i;
/* trn("in make_per_htm_file()"); */
/* tn();b(160);ksn(in_html_filename); */

  global_max_docin_idx = in_docin_last_idx;
  global_docin_lines   = in_docin_lines;

  /* open output HTML file
  */
    tn();trn("will do FOPEN");ksn(in_html_filename);
  if ( (Fp_p_HTML_file = fopen(in_html_filename, "w")) == NULL ) {
      //fprintf(stderr,"fopen() error=[%s]\n", strerror(errno));
      rkabort("Error  on   perhtm.c.  fopen().");
  }
/* tn();b(10); */

/* for test */
/* p_fn_prtlin("hey owieurw0093203");
* p_docin_get(doclin);
* p_fn_prtlin(doclin);
* p_docin_get(doclin);
* p_fn_prtlin(doclin);
* p_docin_get(doclin);
* p_fn_prtlin(doclin);
*/
/* for test */

// now tblrpt1
//  /* in this fn is the first p_docin_get
//  */
//  /* output the css, headings etc. */
//  p_fn_webview_output_top_of_html_file();
//
//

  // this used to be in   p_fn_webview_output_top_of_html_file();
  // have to get name
  //
  /* 1. read until [beg_topinfo1]  (name)  (skipping [beg_program])
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_topinfo1]") != NULL) break;
  }
  p_docin_get(doclin);
  strcpy(gbl_p_person_name, doclin);




/* b(11); */
  /*  read until [beg_graph]
   */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_graph]") != NULL) break;
  }

/*   p_fn_prtlin("  <div> Stand out character traits.</div>"); */

  /*  old graph   do_orig_trait_graph(); */
//  p_fn_prtlin("<div> </div>");

  do_benchmark_trait_graph();    /* !!!!!!!!!!!!!!!!!!!  trait table printed here !!! */
//  do_TBLRPT_benchmark_trait_graph();    /* !!!!!!!!!!!!!!!!!!!  trait table printed here !!! */

/* b(12); */

  /*   p_fn_prtlin("\n<h3> </h3>"); */
//  p_fn_prtlin("<div><br></div>");
//
//  p_fn_prtlin("</table>");


  /* DO PARAGRAPHS HERE */

  /* read until
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_aspects]") != NULL) break;
  }


  /* now read and print aspects until we hit [end_aspects] 
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strlen(doclin) == 0) continue;
    if (strstr(doclin, "[end_aspects]") != NULL) break;
    
    strcpy(aspect_code, doclin);
//    p_fn_browser_aspect_text(aspect_code);    /* output the aspect text */
    p_fn_webview_aspect_text(aspect_code);
    
  }  /* read and print aspects until we hit [end_aspects] */

/* b(14); */


  for (i=0; ; i++) {  /* read until  */
    p_docin_get(doclin);
    if (strstr(doclin, "[end_program]") != NULL) break;
  }

//
///*   p_fn_prtlin("<div> </div>"); */
//  p_fn_prtlin("<div><br></div>");
//
//  /* put trait descriptions
//  */
//  //p_fn_prtlin("<pre class=\"traitDesc\">");
//  p_fn_prtlin("<div class=\"traitDesc\">");
//  gbl_we_are_in_PRE_block_content = 1;  /* true */
//  p_fn_prtlin("    *trait");
//  p_fn_prtlin("");
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken  ");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Ups and Downs - having very high ups ");
//  p_fn_prtlin("                     and very low downs in life "); 
//  p_fn_prtlin("");
///*   p_fn_prtlin(""); */
//
///*   p_fn_prtlin("  Check out reports \"Most Assertive\", \"Most Emotional\" ...  "); */
///*   p_fn_prtlin("  which use trait scores to compare with other group members  "); */
//  p_fn_prtlin("  Check out the group trait reports like \"Most Assertive\" ");
//  p_fn_prtlin("  and \"Most Emotional\" which use these trait scores ");
//  p_fn_prtlin("  to compare with other group members  ");
//
//  p_fn_prtlin("");
//  gbl_we_are_in_PRE_block_content = 0;  /* false */
//  p_fn_prtlin("</div>");
//

//  p_fn_prtlin("<div> </div>");

/*   p_fn_prtlin("<pre>"); */
/*   gbl_we_are_in_PRE_block_content = 1; */
/*   p_fn_prtlin(""); */
/*   p_fn_prtlin(" Check out group reports \"Most Assertive\", \"Most Emotional\" etc. "); */
/*   p_fn_prtlin("     which use these scores to compare with other group members.     "); */
/*   p_fn_prtlin("  Check out group reports \"Most Assertive\", \"Most Emotional\" etc.  "); */
/*   p_fn_prtlin("  which use these trait scores to compare with other group members.  "); */
/*   p_fn_prtlin(""); */
/*   gbl_we_are_in_PRE_block_content = 0; */
/*   p_fn_prtlin("</pre>"); */

//  p_fn_prtlin("<div><br></div>");

  // put trait descriptions
  //


//  p_fn_prtlin("<pre class=\"willpower\"> ");
//background-color: #fcfce0;

//  gbl_we_are_in_PRE_block_content = 1; 
//  p_fn_prtlin( "<span style=\"background-color: #fcfce0;\">Your3intense willpower can overcome  </span>");
/*   p_fn_prtlin( "                                       "); */

//  p_fn_prtlin( "                                       ");
//p_fn_prtlin( "       Your intense willpower can overcome  ");
//p_fn_prtlin( "        bad traits and magnify good ones    ");
//  p_fn_prtlin( "     Your intense willpower can overcome    ");
//  p_fn_prtlin( "  challenging traits and magnify good ones  ");
//  p_fn_prtlin( "                                            ");

//  p_fn_prtlin( "            ");
//p_fn_prtlin( "     Your intense willpower can overcome    ");
//p_fn_prtlin( "  challenging traits and magnify good ones  ");

//  p_fn_prtlin( "               Your intense willpower          ");   // webview
//  p_fn_prtlin( "          can overcome challenging traits      ");
//  p_fn_prtlin( "            and magnify favorable ones         ");
//  p_fn_prtlin( "                                               ");
//
  sprintf(writebuf, "fill|before willpower");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "fill|in willpower at beg");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "will|            Your intense willpower          ");   // webview
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "will|       can overcome challenging traits      ");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "will|         and magnify favorable ones         ");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "fill|in willpower at end");
  p_fn_prtlin(writebuf);

//  gbl_we_are_in_PRE_block_content = 0;  /* false */
//  p_fn_prtlin("</pre>");


/*   sprintf(writebuf, "<h5><br><br><br>produced by iPhone/iPad app named %s</h5>", APP_NAME); */
/*   sprintf(writebuf, "<h5><br><br><br>produced by iPhone app %s</h5>", APP_NAME); */

/*   sprintf(writebuf, "<h5><br>produced by iPhone app %s</h5>", APP_NAME); */
/*   p_fn_prtlin(writebuf); */
/*   p_fn_prtlin("<div><br></div>"); */



/*   p_fn_prtlin("<span class=\"appBy\"> "); */
//  p_fn_prtlin("<pre class=\"appBy\"> ");
//  gbl_we_are_in_PRE_block_content = 1; 
///*   sprintf(writebuf, "<pre class=\"appBy\">produced by iPhone app %s</pre>", APP_NAME); */
//  sprintf(writebuf, "produced by iPhone app %s", APP_NAME);
//  p_fn_prtlin(writebuf);
//  gbl_we_are_in_PRE_block_content = 0;  /* false */
//  p_fn_prtlin("</pre>");

  sprintf(writebuf, "fill|before produced by");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "prod|produced by iPhone app %s", APP_NAME);
  p_fn_prtlin(writebuf);


/*   p_fn_prtlin(""); */

/*   p_fn_prtlin("<h4><span style=\"background-color:#FFBAC7;\">&nbsp&nbsp&nbsp&nbsp&nbsp  This report is for entertainment purposes only.&nbsp&nbsp&nbsp&nbsp&nbsp  </span></h4>"); */
/*   p_fn_prtlin("<h4><span style=\"background-color:#FFBAC7;\">&nbspThis report is for entertainment purposes only.&nbsp</span></h4>"); */


//  p_fn_prtlin("<pre class=\"entertainment\">");
//  gbl_we_are_in_PRE_block_content = 1; 
//  sprintf(writebuf, "This report is for entertainment purposes only.");
//  p_fn_prtlin(writebuf);
//  gbl_we_are_in_PRE_block_content = 0;  /* false */
//  p_fn_prtlin("</pre>");
//  p_fn_prtlin("<div><br><br></div>");

  sprintf(writebuf, "fill|before entertainment");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "purp|This report is for entertainment purposes only.");
  p_fn_prtlin(writebuf);



//  p_fn_prtlin("\n</body>\n");
//  p_fn_prtlin("</html>");


  fflush(Fp_p_HTML_file);
  /* close output HTML file
  */
  if (fclose(Fp_p_HTML_file) == EOF) {
    ;
/* trn("FCLOSE FAILED !!!   #1  "); */
  } else {
    ;
/* trn("FCLOSE SUCCESS !!!  #1  "); */
  };

  return 0;
} // make_per_htm_file_webview      



///<.>
/* output the css, headings etc.
*/
void p_fn_webview_output_top_of_html_file(void)  // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
{
  int i;
/* trn("in p_fn_webview_output_top_of_html_file()"); */

  /* 1. read until [beg_topinfo1]  (name)  (skipping [beg_program])
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_topinfo1]") != NULL) break;
  }

/* b(20); */
  /* then save lines until graph until [end_topinfo1] 
  * then put out html 
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[end_topinfo1]") != NULL) break;
    strcpy(arr(i), doclin);
  }
/* b(25); */

/* <.>  at end, change to STRICT  */
  p_fn_prtlin( "<!doctype html public \"-//w3c//dtd html 4.01 transitional//en\" ");
/* b(26); */
  p_fn_prtlin( "  \"http://www.w3.org/TR/html4/loose.dtd\">");

  p_fn_prtlin( "<html>");
  p_fn_prtlin( "\n<head>");

/*   sprintf(writebuf, "  <title>%s- Personality, produced by iPhone app %s.</title>",arr(0), APP_NAME); */

  /* if HTML filename, gbl_pfnameHTML, has any slashes, grab the basename
  */
  char myBaseName[256], *myptr;
  if (sfind(gbl_pfnameHTML, '/')) {
    myptr = strrchr(gbl_pfnameHTML, '/');
    strcpy(myBaseName, myptr + 1);
  } else {
    strcpy(myBaseName, gbl_pfnameHTML);
  }
  sprintf(writebuf, "  <title>%s</title>", myBaseName);
  p_fn_prtlin(writebuf);
/* b(27); */
  
  /* HEAD  META
  */
  sprintf(writebuf, "  <meta name=\"description\" content=\"Personality report produced by iPhone app %s\"> ",  APP_NAME);
  p_fn_prtlin(writebuf);


  p_fn_prtlin( "  <meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"iso-8859-1\">"); 
  /*   p_fn_prtlin( "  <meta name=\"Author\" content=\"Author goes here\">"); */


/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"group,member,astrology,personality,future,past,year in the life,compatibility,GMCR\">  */
/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"measure,group,member,best,match,calendar,year,passionate,personality\"> "); */
/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"BFF,astrology,compatibility,group,best,match,calendar,year,stress,personality\"> "); */

/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,compatibility,group,best,match,personality,stress,calendar,year\"> "); */ /* 86 chars */ 
  p_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,me,compatibility,group,best,match,personality,stress,calendar,year\"> ");  /* 89 chars */


  /* get rid of CHROME translate "this page is in Galician" 
  * do you want to translate?
  */
  p_fn_prtlin("  <meta name=\"google\" content=\"notranslate\">");
  p_fn_prtlin("  <meta http-equiv=\"Content-Language\" content=\"en\" />");


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


//  p_fn_prtlin("  <meta name=\"viewport\" content=\"initial-scale=1.0; \"> ");           //   browser view
//  p_fn_prtlin("  <meta name=\"viewport\" content=\"initial-scale=0.5; \"> ");           //   browser view

//  p_fn_prtlin("  <meta name=\"viewport\" content=\"initial-scale=0.44 minimum-scale=0.44; \"> ");           //   browser view  OK

// p_fn_prtlin("  <meta name=\"viewport\" content=\"width=320 initial-scale=0.44 \" />");  // webview   OK

//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width initial-scale=0.44 minimum-scale=0.44; \" />");  // webview  OK  4s=no



//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=320 initial-scale=0.44 minimum-scale=0.44 ; \" />");  // webview  OK  4s=no



//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=320 ; \" />");  // webview  OK  4s=no

//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=320 minimum-scale=0.44 maximum-scale=0.44 ; \" />");  // webview  5=no

//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=980 initial-scale=1.0 ; \" />");  // webview  6=big
// try no viewport




//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width  \" />");  // webview   ORIG    6s=skinny, all lesser OK
//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width initial-scale=0.44 minimum-scale=0.44; \" />");  // webview  OK  4s=no
//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width initial-scale=0.44 minimum-scale=0.44; \" />");  // webview  OK <6=no

//  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width initial-scale=0.44 minimum-scale=0.44 maximum-scale=0.44;\" />");  // webview  OK <6=no   GOLD GOLD for 6+


  p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width initial-scale=0.44 minimum-scale=0.44 maximum-scale=0.44;\" />");




  p_fn_prtlin("  <meta name = \"format-detection\" content = \"telephone=no\">");

//  p_fn_prtlin( "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=0.44, minimum-scale=0.44 \" />");  // webview  for 6,6s
//  p_fn_prtlin( "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=0.44, minimum-scale=0.44, maximum-scale=0.44\" />");  // webview  for 6,6s


  /* HEAD   STYLE/CSS
  */
  p_fn_prtlin( "\n  <style type=\"text/css\">");

//<.>
//
//  //  http://stephen.io/mediaqueries/#iPhone
//  // code for portrait, landscape ->   and (orientation : portrait) { /* STYLES GO HERE */ }
//  // iPhone 6 in portrait & landscape
//  //@media only screen 
//  //and (min-device-width : 375px) 
//  //and (max-device-width : 667px) { /* 6   STYLES GO HERE */
//  //}
//  //@media only screen 
//  //and (min-device-width : 414px) 
//  //and (max-device-width : 736px) { /* 6s  STYLES GO HERE */}
//  //  iphone 5,4,3...  min-device-width = 320
//  //
////  p_fn_prtlin( "@media screen and (min-device-width: 350px) {  "); // CSS for iphone 6,6s, and bigger
////  p_fn_prtlin( "  <meta name=\"viewport\" content=\"width=device-width initial-scale=0.44 minimum-scale=0.44 \" />");  // webview  for 6,6s
////  p_fn_prtlin( "} "); // CSS for iphone 6,6s, and bigger
//
//
//
//  p_fn_prtlin( "@media screen and (min-device-width: 350px) {  "); // CSS for iphone 6,6s, and bigger
//
//  p_fn_prtlin( "      background-color: #cc0000;");
//  p_fn_prtlin( "@viewport { ");
//  p_fn_prtlin( "    width: device-width;");
//  p_fn_prtlin( "    initial-scale: 1.0;");
//  p_fn_prtlin( "    minimum-scale: 1.0;");
//  p_fn_prtlin( "}");
//  p_fn_prtlin( "}");
//
//  p_fn_prtlin( "@media screen and not (min-device-width: 350px) ){  "); // CSS for iphone 5,4,3,...
//  p_fn_prtlin( "      background-color: #00cc00;");
//  p_fn_prtlin( "@viewport{");
//  p_fn_prtlin( "    width: device-width;");
//  p_fn_prtlin( "}");
//  p_fn_prtlin( "}");
//
//<.>

  p_fn_prtlin( "    BODY {");   // BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
  p_fn_prtlin( "      background-color: #F7ebd1;");
//  p_fn_prtlin( "      background-color: #cc0000;");
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      font-size:   medium;");
  p_fn_prtlin( "      font-weight: normal;");
  p_fn_prtlin( "      text-align:  center;");  /* stupid, for IE */
  /* example comment out */
  /*   p_fn_prtlin( "    <!-- "); */
  /*   p_fn_prtlin( "      background-image: url('mkgif1g.gif');"); */
  /*   p_fn_prtlin( "    --> "); */
  p_fn_prtlin( "    }");  // BODY





/*   p_fn_prtlin( "    H1 { font-size: 137%; font-weight: bold;   line-height: 95%; text-align: center;}"); */
/*   p_fn_prtlin( "    H2 { font-size: 125%;                      line-height: 25%; text-align: center;}"); */
/*   p_fn_prtlin( "    H3 { font-size: 110%; font-weight: normal; line-height: 30%; text-align: center;}"); */

/*   p_fn_prtlin( "    H5 { font-size:  55%; font-weight: normal; line-height: 90%; text-align: center;}"); */
/*   p_fn_prtlin( "    H4 { font-size:  85%; font-weight: bold;   line-height: 30%; text-align: center;}"); */
/*   p_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}"); */

/*   p_fn_prtlin( "    H4 { font-size:  75%; font-weight: bold;   line-height: 30%; text-align: center;}"); */
/*   p_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}"); */
/*   p_fn_prtlin( "    H4 { font-size:  150%; font-weight: bold;   line-height: 100%; text-align: center;}"); */
/*   p_fn_prtlin( "    H5 { font-size:  150%; font-weight: normal; line-height: 100%; text-align: center;}"); */

  p_fn_prtlin( "    PRE {");    // webview

//  p_fn_prtlin( "     overflow-x: hidden; ");    // webview

  p_fn_prtlin( "      background-color: #fcfce0;");
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      font-weight: normal;");
  p_fn_prtlin( "      font-size: 0.9em;"); 
  p_fn_prtlin( "      line-height: 70%;");
/*   p_fn_prtlin( "      text-align:  left;"); */
/*   p_fn_prtlin( "      display: inline-block;"); */
/*   p_fn_prtlin( "      border-style: solid;"); */
/*   p_fn_prtlin( "      border-color: black;"); */
/*   p_fn_prtlin( "      border-width: 2px;"); */
/*   p_fn_prtlin( "      border-color: #e4dfae; "); */
/*   p_fn_prtlin( "      border-width: 5px;"); */

/*   p_fn_prtlin( "      border-spacing: 0;"); */
/*   p_fn_prtlin( "      border: none;"); */
/*   p_fn_prtlin( "      border-collapse: collapse;"); */
/*   p_fn_prtlin( "      border-spacing: 0;"); */

/*   p_fn_prtlin( "      font-family: Andale Mono, Menlo, Monospace, Courier New;"); */
/*   p_fn_prtlin( "      line-height: 70%;"); */
/*   p_fn_prtlin( "      line-height: 100%;"); */
/*   p_fn_prtlin( "      line-height: 108%;"); */
/*   p_fn_prtlin( "      font-size: 85%;"); */
//  p_fn_prtlin( "      font-size: 160%;");  /* <.> */
/*   p_fn_prtlin( "      margin:0 auto;"); */
  p_fn_prtlin( "    }");

//   p_fn_prtlin( "    PRE.myTitle {");
// /*   p_fn_prtlin( "      width: 300%;"); */
// /*   p_fn_prtlin( "      margin-left: 30%;"); */
// /*   p_fn_prtlin( "      margin-right:30%;"); */
// /*   p_fn_prtlin( "      width: 0%;"); */
//   p_fn_prtlin( "      margin-left: 70%;");
// /*   p_fn_prtlin( "      margin-right:30%;"); */
//   p_fn_prtlin( "      text-align: center;");
//   p_fn_prtlin( "      background-color: #F7ebd1;");
//   p_fn_prtlin( "      font-size: 500%;");  /* <.> */
//   p_fn_prtlin( "      font-weight: bold;");  /* <.> */
//   p_fn_prtlin( "    }");
//   p_fn_prtlin( "    PRE.scoreExpl {");


  p_fn_prtlin( "    .myTitle {");
  p_fn_prtlin( "      margin-top: 0.5em;");
  p_fn_prtlin( "      margin-bottom: 1.2em;");
  p_fn_prtlin( "      margin-left: 4em;");
//  f_fn_prtlin( "      text-align: center;");      // GOLD order #1
  p_fn_prtlin( "      text-align: left;");      // GOLD order #1
     // are putting spaces in code to center
  p_fn_prtlin( "      width: 300%;");             // GOLD order #2
  p_fn_prtlin( "      font-size: 3em;");         // GOLD order #3
  p_fn_prtlin( "      font-weight: bold;"); 
  p_fn_prtlin( "      background-color: #F7ebd1;");
  p_fn_prtlin( "      white-space: pre ; display: block; unicode-bidi: embed");
  p_fn_prtlin( "    }");

//  p_fn_prtlin( "    PRE.scoreExpl {");
//  p_fn_prtlin( "      background-color: #fcfce0;");
//  p_fn_prtlin( "      margin-top: 0.1em;");
//  p_fn_prtlin( "      margin-left: 3em;");
//  p_fn_prtlin( "      text-align: left;");      // GOLD order #1
//  p_fn_prtlin( "      width: 240%;");             // GOLD order #2
//  p_fn_prtlin( "      font-size: 1.4em;");  /* gold order #3 */
//  p_fn_prtlin( "      line-height: 130%;");  /* <.> */
//  p_fn_prtlin( "      white-space: pre ; display: block; unicode-bidi: embed");
//  p_fn_prtlin( "    }");
//
//<.>

//  p_fn_prtlin( "    PRE.willpower {");
  p_fn_prtlin( "    PRE.scoreExpl {");
  p_fn_prtlin( "     overflow-x: hidden; ");    // webview
  p_fn_prtlin( "      width: 300%;");             // GOLD order #2
  p_fn_prtlin( "      width: 270%;");             // GOLD order #2

//  p_fn_prtlin( "      font-size: 1.8em;");  /* <.> */
//  p_fn_prtlin( "      font-size: 1.2em;");  /* <.> */
//  p_fn_prtlin( "      font-size: 1.6em;");  /* <.> */
//  p_fn_prtlin( "      font-size: 1.7em;");  /* <.> */
//  p_fn_prtlin( "      font-size: 2.0em;");  /* <.> */
//  p_fn_prtlin( "      font-size: 1.8em;");  /* <.> */
  p_fn_prtlin( "      font-size: 1.7em;");  /* <.> */

  p_fn_prtlin( "      background-color: #fcfce0;");
  p_fn_prtlin( "      text-align: left;");      // GOLD order #1
  p_fn_prtlin( "      line-height: 1.2em;");  /* <.> */
  p_fn_prtlin( "    }");






  p_fn_prtlin( "    .aspectPara {");
  p_fn_prtlin( "      background-color: #F7ebd1;");
 // p_fn_prtlin( "      margin-left: 2.5em;");
  p_fn_prtlin( "      margin-left: 0.5em;");
  p_fn_prtlin( "      margin-right: 0.5em;"); 
  p_fn_prtlin( "      margin-top: 2em;");
  p_fn_prtlin( "      line-height: 130%;");  /* <.> */
  p_fn_prtlin( "      text-align: left;");      // GOLD order #1
//  p_fn_prtlin( "      width: 333%;");             // GOLD order #2
  p_fn_prtlin( "      width: 300%;");             // GOLD order #2
  p_fn_prtlin( "      font-size: 1.25em;");  /* gold order #3 */
  p_fn_prtlin( "      white-space: pre ; display: block; unicode-bidi: embed");
  p_fn_prtlin( "    }");


  //p_fn_prtlin( "    PRE.traitDesc {");
  p_fn_prtlin( "    .traitDesc {");

//  p_fn_prtlin( "     overflow-x: hidden; ");    // webview

  p_fn_prtlin( "      background-color: #fcfce0;");
  p_fn_prtlin( "      margin-left: 1.5em;");
  p_fn_prtlin( "      text-align: left;");      // GOLD order #1
  //p_fn_prtlin( "      width: 260%;");             // GOLD order #2
  p_fn_prtlin( "      width: 270%;");             // GOLD order #2
//  p_fn_prtlin( "      width: 240%;");             // GOLD order #2
  //p_fn_prtlin( "      font-size: 1.25em;");  /* gold order #3 */

//  p_fn_prtlin( "      font-size: 1.2em;");  /* gold order #3 */
  p_fn_prtlin( "      font-size: 1.45em;");  /* gold order #3 */
  p_fn_prtlin( "      line-height: 130%;");  /* <.> */
  p_fn_prtlin( "      white-space: pre ; display: block; unicode-bidi: embed");
  p_fn_prtlin( "    }");

  p_fn_prtlin( "    PRE.willpower {");

  p_fn_prtlin( "     overflow-x: hidden; ");    // webview

//  p_fn_prtlin( "      width: 170%;");             // GOLD order #2
//  p_fn_prtlin( "      font-size: 1.4em;");  /* <.> */
//  p_fn_prtlin( "      width: 100%;");             // GOLD order #2
//  p_fn_prtlin( "      width: 400%;");             // GOLD order #2
//  p_fn_prtlin( "      width: 250%;");             // GOLD order #2
//  p_fn_prtlin( "      width: 350%;");             // GOLD order #2
  p_fn_prtlin( "      width: 300%;");             // GOLD order #2
  p_fn_prtlin( "      font-size: 1.8em;");  /* <.> */

  p_fn_prtlin( "      background-color: #fcfce0;");
//  p_fn_prtlin( "      margin-left: 8em;");
  p_fn_prtlin( "      text-align: left;");      // GOLD order #1

  p_fn_prtlin( "      line-height: 1.2em;");  /* <.> */
  p_fn_prtlin( "    }");


//   p_fn_prtlin( "    PRE.appBy {");
// /*   p_fn_prtlin( "      width: 100%;"); */
// /*   p_fn_prtlin( "      margin-left: 60%;"); */
// /*   p_fn_prtlin( "      margin-right:60%;"); */
//   p_fn_prtlin( "      margin-left: 70%;");
// 
//   p_fn_prtlin( "      background-color: #F7ebd1;");
//   p_fn_prtlin( "      font-size: 200%;");  /* <.> */
//   p_fn_prtlin( "    }");
// 
//   p_fn_prtlin( "    PRE.entertainment {");
// 
// /*   p_fn_prtlin( "      width: 300%;"); */
// /*   p_fn_prtlin( "      margin-left: 30%;"); */
// /*   p_fn_prtlin( "      margin-right:30%;"); */
//   p_fn_prtlin( "      margin-left: 40%;");
// 
// /*   p_fn_prtlin( "      background-color:#FFBAC7;"); */
//   p_fn_prtlin( "      background-color: #F7ebd1;");
//   p_fn_prtlin( "      color:#FF0000;");
//   p_fn_prtlin( "      font-size: 150%;");  /* <.> */
//   p_fn_prtlin( "    }");


  p_fn_prtlin( "    PRE.appBy {");

//  p_fn_prtlin( "      margin-left:13.2em;");
//  p_fn_prtlin( "      margin-left: 5em;");
  p_fn_prtlin( "      margin-left: 6.5em;");

  p_fn_prtlin( "      text-align: left;");
/*   p_fn_prtlin( "      font-size: 130%;"); */
  p_fn_prtlin( "      width: 150%;");             // GOLD order #2

//  p_fn_prtlin( "      font-size: 2em;");
//  p_fn_prtlin( "      font-size: 2.4em;");
//  p_fn_prtlin( "      font-size: 3.4em;");
//  p_fn_prtlin( "      font-size: 1.2em;");
//  p_fn_prtlin( "      font-size: 1.8em;");
  p_fn_prtlin( "      font-size: 1.5em;");

  p_fn_prtlin( "      background-color: #F7ebd1;");
  p_fn_prtlin( "    }");
  p_fn_prtlin( "    PRE.entertainment {");
//  p_fn_prtlin( "      line-height: 1.4em;"); 
//  p_fn_prtlin( "      margin-left: 9.5em;");
//  p_fn_prtlin( "      margin-left: 7em;");
//  p_fn_prtlin( "      margin-left: 5em;");
  p_fn_prtlin( "      margin-left: 3em;");

  p_fn_prtlin( "      text-align: left;");

  p_fn_prtlin( "      width: 150%;");             // GOLD order #2

//  p_fn_prtlin( "      font-size: 1.5em;");
//  p_fn_prtlin( "      font-size: 1.2em;");
//  p_fn_prtlin( "      font-size: 1.4em;");
  p_fn_prtlin( "      font-size: 1.6em;");

  p_fn_prtlin( "      font-weight: bold;");

  p_fn_prtlin( "      background-color: #F7ebd1;");
  p_fn_prtlin( "      color:#FF0000;");
/*   p_fn_prtlin( "      font-size: 130%;");  */
  p_fn_prtlin( "    }");


  p_fn_prtlin( "    P { ");
/*   p_fn_prtlin( "      font-family: Andale Mono, Menlo, Monospace, Courier New;"); */
  p_fn_prtlin( "      font-family: Courier, Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      width: auto;");
/*   p_fn_prtlin( "      font-size:   93%;"); */
/*   p_fn_prtlin( "      font-size:   150%;"); */
  p_fn_prtlin( "      font-size:   165%;");
/*   p_fn_prtlin( "      margin-top: 0;"); */
/*   p_fn_prtlin( "      margin-bottom: 0;"); */
/*   p_fn_prtlin( "      margin-left: auto;"); */
/*   p_fn_prtlin( "      margin-right:auto;"); */
/*   p_fn_prtlin( "      padding-left: 5%;"); */
/*   p_fn_prtlin( "      padding-right:5%;"); */
/*   p_fn_prtlin( "      text-align: center;"); */
  p_fn_prtlin( "      text-align: left;");
/*   p_fn_prtlin( "      margin-left: 0.5em;"); */
  p_fn_prtlin( "      margin-right: 0.5em;");
  p_fn_prtlin( "    }");


/* for table: */

/*   p_fn_prtlin( "div.centered  { text-align: center; }"); */
/*   p_fn_prtlin( "div.centered table  { margin: 0 auto;  text-align: left; }"); */
/* then, */
/* <div class="centered"> */
/*     <table> */
/*     … */
/*     </table> */
/* </div> */



/*       border: 2px solid black; */
/*       cellspacing: 0; */
/*       border-top: 0; */
/*       border-bottom: 0; */
  p_fn_prtlin( "    table {");
/*   p_fn_prtlin( "      text-align: center;"); */
/*   p_fn_prtlin( "      border: none;"); */
/*   p_fn_prtlin( "      border-collapse: collapse;"); */
/*   p_fn_prtlin( "      border-spacing: 0;"); */
/*   p_fn_prtlin( "      width: 300%;"); */
/*   p_fn_prtlin( "      margin-left: auto;"); */
/*   p_fn_prtlin( "      margin-right:auto;"); */
/*   p_fn_prtlin( "      margin: auto;"); */

/*   p_fn_prtlin( "      text-align: left;"); */
/*   p_fn_prtlin( "      margin-left: 12em;"); */

  p_fn_prtlin( "      margin-left: 7em;");
  p_fn_prtlin( "      margin-top: 0.1em;");
  p_fn_prtlin( "      margin-bottom: 0.1em;");
  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "    }");

/*   p_fn_prtlin( "    table.center {"); */
/*   p_fn_prtlin( "      margin: 11px;"); */
/*   p_fn_prtlin( "      font-size:   120%;"); */
/*   p_fn_prtlin( "    }"); */
/*   p_fn_prtlin( "      margin-left: auto;"); */
/*   p_fn_prtlin( "      margin-right:auto;"); */
/*   p_fn_prtlin( "      margin: auto;"); */
/*   p_fn_prtlin( "      margin-left: 100px;"); */
/*   p_fn_prtlin( "      margin-left:auto;"); */
/*   p_fn_prtlin( "      margin-right:auto;"); */
/*   p_fn_prtlin( "      width: 300%;"); */
/*   p_fn_prtlin( "      margin-left: 15%;"); */
/*   p_fn_prtlin( "      margin-right:15%;"); */

  p_fn_prtlin( "    TD {");
/*   p_fn_prtlin( "      border: none;"); */
/*   p_fn_prtlin( "      border-spacing: 0;"); */
  p_fn_prtlin( "      white-space: nowrap;");
  p_fn_prtlin( "      margin-top: 0.1em;");
  p_fn_prtlin( "      margin-bottom: 0.1em;");
  p_fn_prtlin( "      padding: 0;");
  p_fn_prtlin( "    }");

/*   p_fn_prtlin( "    .cLineGood   { background-color:#c3fdc3; }"); */
  p_fn_prtlin( "    .cLineStress { background-color:#ffbac7; }");
  p_fn_prtlin( "    .row4        { background-color:#f8f0c0; }");

/*   p_fn_prtlin( "    .cGr2        { background-color:#d0fda0; }"); */
/*   p_fn_prtlin( "    .cGr2        { background-color:#8bfd87; }"); */
/*   p_fn_prtlin( "    .cGr2        { background-color:#66ff33; }"); */

/*   p_fn_prtlin( "    .cGre        { background-color:#e1fdc3; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#ccffb9; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ffd9d9; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ffcccc; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fcb9b9; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fc8888; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fc6094; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#ff3366; }"); */

/*    GREEN   */
/*     .cGr2        { background-color:#a3f275; } */
/*     .cGre        { background-color:#bbf699; } */
/*     .cNeu        { background-color:#d3f9bd; } */
/*     .cRed        { background-color:#bbf699; } */
/*     .cRe2        { background-color:#a3f275; } */


/*   p_fn_prtlin( "    .cGr2        { background-color:#66ff33; }"); */
/*   p_fn_prtlin( "    .cGr2        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#84ff98; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#a8ff98; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#bbf699; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#e1ddc3; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#d3f9bd; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#fcfce0; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#e6fbda; }"); */
/*   p_fn_prtlin( "      background-color: #fcfce0;"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ff98a8; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#bbf699; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#ff4477; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#a3f275; }"); */

/*   p_fn_prtlin( "    .cGr2        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#a3f275; }"); */

/*   p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #a3f275;}"); */




  // color for entire TABLE of trait scores
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #eef7ff;}"); // try blue
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #d3ffa5;}");
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #007aff;}");  // apple blue
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {color: #007aff; background-color: #ffffff}");  // apple blue on  white
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {color: #007aff; background-color: #fcfce0}");  // apple blue on  
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {                background-color: #fcfce0}");  // apple blue on  

//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #d3ffa5;}"); // light green
//  p_fn_prtlin( "    .cPerGreen1 {background-color: #d3ffa5;}"); // alternate colors
//  p_fn_prtlin( "    .cPerGreen2 {background-color: #e6ffcc;}");

//    p_fn_prtlin( "    .cPerGreen1 {background-color: #ceffa0;}");  
//    p_fn_prtlin( "    .cPerGreen2 {background-color: #dfffbb;}"); 

//    p_fn_prtlin( "    .cPerGreen1 {background-color: #d3ffa5;}");  // same
//    p_fn_prtlin( "    .cPerGreen2 {background-color: #d3ffa5;}"); // same
//
    p_fn_prtlin( "    .cPerGreen1 {background-color: #e5e2c7;}");  // same as cNeu (e5e2c7)
    p_fn_prtlin( "    .cPerGreen2 {background-color: #e5e2c7;}");  // same as cNeu (e5e2c7)



  p_fn_prtlin("    .cNam        { color:#3f3ffa;");
  p_fn_prtlin("                   background-color: #F7ebd1;");
  p_fn_prtlin("                   font-size: 133%;");
  p_fn_prtlin("    }");

  p_fn_prtlin( "    table.trait {");                   // webview
/*   p_fn_prtlin( "      margin: auto;"); */
/*   p_fn_prtlin( "      margin-left: 100px;"); */



/*   p_fn_prtlin( "      margin-left: 66%;"); */
/*   p_fn_prtlin( "      width: 0%;"); */
/*   p_fn_prtlin( "      margin-left: 70%;"); */
/*   p_fn_prtlin( "      margin-right:30%;"); */


/*   p_fn_prtlin( "      font-size: 285%;");  */
/*   p_fn_prtlin( "      font-size: 240%;");  */

//  p_fn_prtlin( "      font-size: 175%;"); 

/*   p_fn_prtlin( "      width: 300%;"); */
/*   p_fn_prtlin( "      margin-left: auto;"); */
/*   p_fn_prtlin( "      margin-right:auto;"); */
/*   p_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      text-align: left;");
  p_fn_prtlin( "      bottom-margin: 0.1em;");

/*   p_fn_prtlin( "      border: 1px solid black;"); */
/*   p_fn_prtlin( "      border: none;"); */
/*   p_fn_prtlin( "      border-spacing: 0;"); */
/*   p_fn_prtlin( "      border-collapse: collapse;"); */
/*   p_fn_prtlin( "      border-spacing: 0;"); */

/*   p_fn_prtlin( "      padding-right:2%;"); */
/*   p_fn_prtlin( "      padding-left:2%;"); */
  p_fn_prtlin( "    }");
  p_fn_prtlin( "    table.trait td {");
/*   p_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      white-space: pre;");

//  p_fn_prtlin( "      font-size: 90%;");
//  p_fn_prtlin( "      font-size: 2em;");
//  p_fn_prtlin( "      font-size: 2.5em;");
//  p_fn_prtlin( "      font-size: 2.0em;");
//  p_fn_prtlin( "      font-size: 2.3em;");
  p_fn_prtlin( "      font-size: 2.2em;");

  p_fn_prtlin( "      text-align: left;");

/*   p_fn_prtlin( "      border: 1px solid black;"); */
//  p_fn_prtlin( "      border: none;");
//  p_fn_prtlin( "      border: 1px gray;");
//  p_fn_prtlin( "      border: 1px solid black;"); 
//  p_fn_prtlin( "      border: 6px solid #404040;");
//  p_fn_prtlin( "      border: 6px solid green;");
//  p_fn_prtlin( "      border: 1px solid green;");

//  p_fn_prtlin( "      border: 1px solid #c0e8c0;");   TAKE AWAY BORDER (alternating green colors instead)

  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "      border-collapse: collapse;");
  p_fn_prtlin( "      border-spacing: 0;");

/*   p_fn_prtlin( "      padding-left: 2px; "); */
/*   p_fn_prtlin( "      padding-right: 2px; "); */
//  p_fn_prtlin( "      padding-left: 10px; ");
//  p_fn_prtlin( "      padding-right: 10px; ");
//  p_fn_prtlin( "      padding-left: 2em; ");
//  p_fn_prtlin( "      padding-right: 2em; ");

//  p_fn_prtlin( "      padding-left: 0.7em; ");
//  p_fn_prtlin( "      padding-right: 0.7em; ");
//  p_fn_prtlin( "      padding-left:  0.25em; ");
//  p_fn_prtlin( "      padding-right: 0.25em; ");
  p_fn_prtlin( "      padding-left:  0.18em; ");
  p_fn_prtlin( "      padding-right: 0.18em; ");

  p_fn_prtlin( "      padding-top: 2px; ");
  p_fn_prtlin( "      padding-bottom: 2px; ");
/*   p_fn_prtlin( "      padding-top: 1px; "); */
/*   p_fn_prtlin( "      padding-bottom: 1px; "); */

  p_fn_prtlin( "    }");
  p_fn_prtlin( "    table.trait th { ");
/*   p_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");

//  p_fn_prtlin( "      font-size: 90%;");
//  p_fn_prtlin( "      font-size: 2em;");
//  p_fn_prtlin( "      font-size: 2.5em;");
//  p_fn_prtlin( "      font-size: 2.0em;");
//  p_fn_prtlin( "      font-size: 2.3em;");
  p_fn_prtlin( "      font-size: 2.2em;");

/*   p_fn_prtlin( "      padding-left: 10px; "); */
/*   p_fn_prtlin( "      padding-right: 10px; "); */
  p_fn_prtlin( "      padding: 10px; ");

/*   p_fn_prtlin( "      background-color: #e1fdc3 ;"); */


  p_fn_prtlin( "      background-color: #fcfce0 ;"); 



/*   p_fn_prtlin( "      border: 1px solid black;"); */
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-spacing: 0;");

  p_fn_prtlin( "      text-align: center;");
  p_fn_prtlin( "    } ");

//  p_fn_prtlin( "    table.trait tfoot { ");
//  p_fn_prtlin( "      background-color: #ff0000 ;");
//  p_fn_prtlin( "      font-size: 0.9em;");
//  p_fn_prtlin( "      font-weight: normal;");
//  p_fn_prtlin( "    } ");
//


  p_fn_prtlin( "    table.trait       td { text-align: left; }");
  p_fn_prtlin( "    table.trait    td+td { text-align: right; }");
  p_fn_prtlin( "    table.trait td+td+td { text-align: left; }");

  p_fn_prtlin( "  </style>");

    
    /* put in favicon */
    p_fn_prtlin("<link href=\"data:image/x-icon;base64,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\" rel=\"icon\" type=\"image/x-icon\" />");

    
    


  p_fn_prtlin( "</head>");
  p_fn_prtlin( " ");
  p_fn_prtlin("\n<body>");

  /*   p_fn_prtlin( "<body background=\"file:///mkgif1g.gif\">"); */
  /*   p_fn_prtlin( "<body background=\"file:///C/USR/RK/html/mkgif1g.gif\">"); */

  /* "Personality"   output here */
/* 
*   sprintf(writebuf, "\n  <h1>Personality</h1>");
*   p_fn_prtlin(writebuf);
*   sprintf(writebuf, "\n  <h2>of %s<br></h2>", arr(0) ); * of Fred  *
*   p_fn_prtlin(writebuf);
*/

/*   sprintf(writebuf, "\n  <h1>Personality <span style=\"font-size:80%%;\">of %s</span><br></h1>", arr(0) );  */
/*   sprintf(writebuf, "\n  <h1>Personality of %s<br></h1>", arr(0) ); * of Fred  * */

/*   p_fn_prtlin("<div><br></div>"); */

//  sprintf(writebuf, "\n  <h1>Personality for <span class=\"cNam\">%s</span><br></h1>", arr(0) ); /* of Fred  */
/*   p_fn_prtlin(writebuf); */

  //strcpy(gbl_person_name, arr(0));
  strcpy(gbl_p_person_name, arr(0));

//  p_fn_prtlin("<div><pre class=\"myTitle\">");
//  gbl_we_are_in_PRE_block_content = 1; 
//  sprintf(writebuf, "Personality for" ); /* of Fred  */
//  p_fn_prtlin(writebuf);
//  sprintf(writebuf, "%s", arr(0) ); /* of Fred  */
//  p_fn_prtlin(writebuf);
//  gbl_we_are_in_PRE_block_content = 0;  /* false */
//  p_fn_prtlin("</pre></div>");


//<.>
//  p_fn_prtlin("<pre class=\"myTitle\">");
//  gbl_we_are_in_PRE_block_content = 1; 
//
///*   sprintf(writebuf, "Calendar Year %s",  arr(2) ); */
///*   f_fn_prtlin(writebuf); */
//
//  // want 6 sp left margin
//  // then max 15 char name centred in 15 char field
//  // extra sp on left
////  long namelen1 = strlen(gbl_person_name);
//  long namelen1 = strlen(gbl_p_person_name);
//  char mynam[32];
//  //strcpy(mynam, gbl_person_name);
//  strcpy(mynam, gbl_p_person_name);
//  char char15toprint[32];
//       if (namelen1 ==  1) sprintf(char15toprint, "       %s       ", mynam); 
//  else if (namelen1 ==  2) sprintf(char15toprint, "       %s      ", mynam); 
//  else if (namelen1 ==  3) sprintf(char15toprint, "      %s      ", mynam);
//  else if (namelen1 ==  4) sprintf(char15toprint, "      %s     ", mynam); 
//  else if (namelen1 ==  5) sprintf(char15toprint, "     %s     ", mynam); 
//  else if (namelen1 ==  6) sprintf(char15toprint, "     %s    ", mynam); 
//  else if (namelen1 ==  7) sprintf(char15toprint, "    %s    ", mynam); 
//  else if (namelen1 ==  8) sprintf(char15toprint, "    %s   ", mynam); 
//  else if (namelen1 ==  9) sprintf(char15toprint, "   %s   ", mynam); 
//  else if (namelen1 == 10) sprintf(char15toprint, "   %s  ", mynam); 
//  else if (namelen1 == 11) sprintf(char15toprint, "  %s  ", mynam); 
//  else if (namelen1 == 12) sprintf(char15toprint, "  %s ", mynam); 
//  else if (namelen1 == 13) sprintf(char15toprint, " %s ", mynam); 
//  else if (namelen1 == 14) sprintf(char15toprint, " %s", mynam); 
//  else if (namelen1 == 15) sprintf(char15toprint, "%s", mynam); 
//  else                    sprintf(char15toprint,"%s", mynam);
//  //  sprintf(writebuf, "     %s", arr(1) );     // just name
//  //sprintf(writebuf, "      %s", char15toprint );  // just name   6sp on left
//  sprintf(writebuf, "%s", char15toprint );  // just name   6sp on left
//
//  p_fn_prtlin(writebuf);
//  gbl_we_are_in_PRE_block_content = 0; 
//  p_fn_prtlin("</pre>");
//<.>
//



  p_fn_prtlin("<div><br></div>");

/* b(29); */
} /* end of  p_fn_webview_output_top_of_html_file() */
//<.>


int make_per_htm_file_browser(      
  char *in_html_filename,
  char *in_docin_lines[],
  int   in_docin_last_idx)
{
/* tn();trn("in make_per_htm_file_browser"); */
/* ksn(in_html_filename); */
  int i; 
  /* open output HTML file
  */
  if ( (Fp_p_HTML_file = fopen(in_html_filename, "w")) == NULL ) {
    rkabort("Error  on   perhtm.c.  fopen().");
  }
/* tn();b(10); */

/* for test */
/* p_fn_prtlin("hey owieurw0093203");
* p_docin_get(doclin);
* p_fn_prtlin(doclin);
* p_docin_get(doclin);
* p_fn_prtlin(doclin);
* p_docin_get(doclin);
* p_fn_prtlin(doclin);
*/
/* for test */


  /* in this fn is the first p_docin_get
  */
  p_fn_output_top_of_html_file();  /* output the css, headings etc. */




/* b(11); */
  /*  read until [beg_graph]
   */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_graph]") != NULL) break;
  }

/*   p_fn_prtlin("  <div> Stand out character traits.</div>"); */

  /*  old graph   do_orig_trait_graph(); */
  p_fn_prtlin("<div> </div>");

  do_benchmark_trait_graph();    /* !!!!!!!!!!!!!!!!!!!  trait table printed here !!! */

/* b(12); */

  /*   p_fn_prtlin("\n<h3> </h3>"); */
  p_fn_prtlin("<div><br></div>");

  p_fn_prtlin("</table>");


// see tfoot instead of this
//  //p_fn_prtlin("<pre>");
//  p_fn_prtlin("<pre style=\"font-size: 1.1em;\">");
//  gbl_we_are_in_PRE_block_content = 1; /* 1 = yes, 0 = no */
//
////  p_fn_prtlin("");
//
//
///*   p_fn_prtlin("  A score measures how high or low the influence  "); */
//
////  p_fn_prtlin("  A score from 1 to 99 measures how influential  ");                   // browser view
////  sprintf(writebuf, "  the trait is in the personality of %s.  ", gbl_p_person_name);
////  p_fn_prtlin(writebuf);
////
//
//  p_fn_prtlin(      "    A score from 1 to 99 measures \"how much\"");
//  sprintf(writebuf, "    of that trait %s has.  ", gbl_p_person_name);
//  p_fn_prtlin(      "    A score does NOT measure \"good\" or \"bad\".");
//
//
//  p_fn_prtlin("");
///*   p_fn_prtlin("  The score does NOT measure \"good\" or \"bad\", "); */
//
//  //p_fn_prtlin("  The score here does NOT measure \"good\" or \"bad\",  ");
//  p_fn_prtlin("  This score does NOT measure \"good\" or \"bad\",  ");
//
//  p_fn_prtlin("    which can be found in the paragraphs below: ");
//  p_fn_prtlin("");
//  gbl_we_are_in_PRE_block_content = 0; /* 1 = yes, 0 = no */
//  p_fn_prtlin("</pre>");
//
//

  p_fn_prtlin("<div> </div>");

  /* DO PARAGRAPHS HERE */

  /* read until
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_aspects]") != NULL) break;
  }


  /* now read and print aspects until we hit [end_aspects] 
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strlen(doclin) == 0) continue;
    if (strstr(doclin, "[end_aspects]") != NULL) break;
    
    strcpy(aspect_code, doclin);
    p_fn_browser_aspect_text(aspect_code);    /* output the aspect text */
    
  }  /* read and print aspects until we hit [end_aspects] */

/* b(14); */


  for (i=0; ; i++) {  /* read until  */
    p_docin_get(doclin);
    if (strstr(doclin, "[end_program]") != NULL) break;
  }


/*   p_fn_prtlin("<div> </div>"); */
  p_fn_prtlin("<div><br></div>");

  /* put trait descriptions
  */
  p_fn_prtlin("<pre style=\"font-size: 1.0em\">");
  gbl_we_are_in_PRE_block_content = 1;  /* true */
  p_fn_prtlin("    *trait");
  p_fn_prtlin("");
  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken  ");
  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
  p_fn_prtlin("     Restless      - versatile, changeable, independent");
  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Ups and Downs - having very high ups ");
//  p_fn_prtlin("                     and very low downs in life ");
  p_fn_prtlin("");
  p_fn_prtlin("");
  p_fn_prtlin("  Check out reports \"Most Assertive\", \"Most Emotional\" ...  ");
  p_fn_prtlin("  which use trait scores to compare with other group members  ");
  p_fn_prtlin("");
  gbl_we_are_in_PRE_block_content = 0;  /* false */
  p_fn_prtlin("</pre>");

  p_fn_prtlin("<div> </div>");

/*   p_fn_prtlin("<pre>"); */
/*   gbl_we_are_in_PRE_block_content = 1; */
/*   p_fn_prtlin(""); */
/*   p_fn_prtlin(" Check out group reports \"Most Assertive\", \"Most Emotional\" etc. "); */
/*   p_fn_prtlin("     which use these scores to compare with other group members.     "); */
/*   p_fn_prtlin("  Check out group reports \"Most Assertive\", \"Most Emotional\" etc.  "); */
/*   p_fn_prtlin("  which use these trait scores to compare with other group members.  "); */
/*   p_fn_prtlin(""); */
/*   gbl_we_are_in_PRE_block_content = 0; */
/*   p_fn_prtlin("</pre>"); */

  p_fn_prtlin("<div><br></div>");

  p_fn_prtlin("<pre style=\"font-size: 1.0em\">");


  gbl_we_are_in_PRE_block_content = 1; 
//  p_fn_prtlin( "                                       ");
//  p_fn_prtlin( "  Your intense willpower can overcome  ");
//  p_fn_prtlin( "   bad traits and magnify good ones    ");
//  p_fn_prtlin( "                                       ");

  p_fn_prtlin( "                                            ");
//p_fn_prtlin( "     Your intense willpower can overcome    ");
//p_fn_prtlin( "  challenging traits and magnify good ones  ");
  p_fn_prtlin( "            Your intense willpower          ");
  p_fn_prtlin( "       can overcome challenging traits      ");
  p_fn_prtlin( "         and magnify favorable ones         ");
  p_fn_prtlin( "                                            ");

  gbl_we_are_in_PRE_block_content = 0;  /* false */
  p_fn_prtlin("</pre>");


  //sprintf(writebuf, "<h5 style=\"font-size: 1.0em\"><br>produced by iPhone app %s</h5>", APP_NAME);
//  sprintf(writebuf, "<div style=\"font-size: 1.0em\"><br>produced by iPhone app %s</div>", APP_NAME);
//  p_fn_prtlin(writebuf);
//  p_fn_prtlin("");
//  p_fn_prtlin("<div style=\"font-size: 0.9em; font-weight: bold; color:#FF0000;\">&nbspThis report is for entertainment purposes only.&nbsp</span></div>");

  p_fn_prtlin("<div> <span style=\"font-size: 1.0em\"><br>produced by iPhone app Me and my BFFs</span><br><br><span style=\"font-size: 0.9em; font-weight: bold; color:#FF0000;\">This report is for entertainment purposes only.</span></div><div><br></div>");


  p_fn_prtlin("\n</body>\n");
  p_fn_prtlin("</html>");


  fflush(Fp_p_HTML_file);
  /* close output HTML file
  */
  if (fclose(Fp_p_HTML_file) == EOF) {
    ;
/* trn("FCLOSE FAILED !!!   #1  "); */
  } else {
    ;
/* trn("FCLOSE SUCCESS !!!  #1  "); */
  };

/* b(15); */
  return(0);

} // end of make_per_htm_file_browser      // browser



/* output the css, headings etc.
*/
void p_fn_output_top_of_html_file(void)                        // browser view
{
  int i;
/* trn("in p_fn_output_top_of_html_file()"); */

  /* 1. read until [beg_topinfo1]  (name)  (skipping [beg_program])
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_topinfo1]") != NULL) break;
  }

/* b(20); */
  /* then save lines until graph until [end_topinfo1] 
  * then put out html 
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[end_topinfo1]") != NULL) break;
    strcpy(arr(i), doclin);
  }
/* b(25); */

/* <.>  at end, change to STRICT  */
  p_fn_prtlin( "<!doctype html public \"-//w3c//dtd html 4.01 transitional//en\" ");
/* b(26); */
  p_fn_prtlin( "  \"http://www.w3.org/TR/html4/loose.dtd\">");

  p_fn_prtlin( "<html>");
  p_fn_prtlin( "\n<head>");

/*   sprintf(writebuf, "  <title>%s- Personality, produced by iPhone app %s.</title>",arr(0), APP_NAME); */

  /* if HTML filename, gbl_pfnameHTML, has any slashes, grab the basename
  */
  char myBaseName[256], *myptr;
  if (sfind(gbl_pfnameHTML, '/')) {
    myptr = strrchr(gbl_pfnameHTML, '/');
    strcpy(myBaseName, myptr + 1);
  } else {
    strcpy(myBaseName, gbl_pfnameHTML);
  }
  sprintf(writebuf, "  <title>%s</title>", myBaseName);
  p_fn_prtlin(writebuf);
/* b(27); */
  
  /* HEAD  META
  */
  sprintf(writebuf, "  <meta name=\"description\" content=\"Personality report produced by iPhone app %s\"> ",  APP_NAME);
  p_fn_prtlin(writebuf);


  p_fn_prtlin( "  <meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"iso-8859-1\">"); 
  /*   p_fn_prtlin( "  <meta name=\"Author\" content=\"Author goes here\">"); */


/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"group,member,astrology,personality,future,past,year in the life,compatibility,GMCR\">  */
/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"measure,group,member,best,match,calendar,year,passionate,personality\"> "); */
/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"BFF,astrology,compatibility,group,best,match,calendar,year,stress,personality\"> "); */

/*   p_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,compatibility,group,best,match,personality,stress,calendar,year\"> "); */ /* 86 chars */ 
  p_fn_prtlin( "  <meta name=\"keywords\" content=\"women,woman,female,BFF,me,compatibility,group,best,match,personality,stress,calendar,year\"> ");  /* 89 chars */


  /* get rid of CHROME translate "this page is in Galician" 
  * do you want to translate?
  */
  p_fn_prtlin("  <meta name=\"google\" content=\"notranslate\">");
  p_fn_prtlin("  <meta http-equiv=\"Content-Language\" content=\"en\" />");


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

  //f_fnBIG_prtlin("  <meta name=\"viewport\" content=\"initial-scale=1.0; \"> ");       //   browser view
  //p_fn_prtlin("  <meta name=\"viewport\" content=\"width=device-width\" />");
  p_fn_prtlin("  <meta name=\"viewport\" content=\"initial-scale=1.0; \"> ");           //   browser view
  p_fn_prtlin("  <meta name = \"format-detection\" content = \"telephone=no\">");


  /* HEAD   STYLE/CSS
  */
  p_fn_prtlin( "\n  <style type=\"text/css\">");
  p_fn_prtlin( "    BODY {");

/*  p_fn_prtlin( "      background-color: #F5 EF CF;"); */
/*  g_fn_prtlin( "      background-color: #F5EFCF;"); */
  p_fn_prtlin( "      background-color: #F7ebd1;");

/*   p_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");

  p_fn_prtlin( "      font-size:   medium;");
  p_fn_prtlin( "      font-weight: normal;");
  p_fn_prtlin( "      text-align:  center;");
  /* example comment out */
  /*   p_fn_prtlin( "    <!-- "); */
  /*   p_fn_prtlin( "      background-image: url('mkgif1g.gif');"); */
  /*   p_fn_prtlin( "    --> "); */
  p_fn_prtlin( "    }");

  p_fn_prtlin( "    H1 { font-size: 137%; font-weight: bold;   line-height: 95%; text-align: center;}");
  p_fn_prtlin( "    H2 { font-size: 125%;                      line-height: 25%; text-align: center;}");
  p_fn_prtlin( "    H3 { font-size: 110%; font-weight: normal; line-height: 30%; text-align: center;}");

/*   p_fn_prtlin( "    H5 { font-size:  55%; font-weight: normal; line-height: 90%; text-align: center;}"); */
/*   p_fn_prtlin( "    H4 { font-size:  85%; font-weight: bold;   line-height: 30%; text-align: center;}"); */
/*   p_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}"); */

  p_fn_prtlin( "    H4 { font-size:  75%; font-weight: bold;   line-height: 30%; text-align: center;}");
  p_fn_prtlin( "    H5 { font-size:  70%; font-weight: normal; line-height: 30%; text-align: center;}");

  p_fn_prtlin( "    PRE {");          // browser view

  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
//  p_fn_prtlin( "      white-space: pre ; display: block; unicode-bidi: embed");
  p_fn_prtlin( "      display: inline-block;");

  p_fn_prtlin( "      background-color: #fcfce0;");
  p_fn_prtlin( "      text-align:  left;");
/*   p_fn_prtlin( "      font-size:   90%;"); */
/*   p_fn_prtlin( "      border-style: solid;"); */
/*   p_fn_prtlin( "      border-color: black;"); */
/*   p_fn_prtlin( "      border-width: 2px;"); */
/*   p_fn_prtlin( "      border-color: #e4dfae; "); */
/*   p_fn_prtlin( "      border-width: 5px;"); */

  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-collapse: collapse;");
  p_fn_prtlin( "      border-spacing: 0;");
/*   p_fn_prtlin( "      font-family: Andale Mono, Menlo, Monospace, Courier New;"); */
  p_fn_prtlin( "      font-weight: normal;");
/*   p_fn_prtlin( "      line-height: 70%;"); */
/*   p_fn_prtlin( "      line-height: 100%;"); */
/*   p_fn_prtlin( "      line-height: 108%;"); */
  p_fn_prtlin( "      font-size: 85%;");
/*   p_fn_prtlin( "      margin:0 auto;"); */
  p_fn_prtlin( "    }");


  p_fn_prtlin( "    P { ");
/*   p_fn_prtlin( "      font-family: Andale Mono, Menlo, Monospace, Courier New;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      width: auto;");
  p_fn_prtlin( "      font-size:   93%;");
  p_fn_prtlin( "      margin-top: 0;");
  p_fn_prtlin( "      margin-bottom: 0;");
  p_fn_prtlin( "      margin-left: auto;");
  p_fn_prtlin( "      margin-right:auto;");
/*   p_fn_prtlin( "      padding-left: 5%;"); */
/*   p_fn_prtlin( "      padding-right:5%;"); */
/*   p_fn_prtlin( "      text-align: center;"); */
  p_fn_prtlin( "      text-align: left;");
  p_fn_prtlin( "    }");
/* for table: */
/*       border: 2px solid black; */
/*       cellspacing: 0; */
/*       border-top: 0; */
/*       border-bottom: 0; */
  p_fn_prtlin( "    table {");
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-collapse: collapse;");
  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "    }");

  p_fn_prtlin( "    table.center {");
  p_fn_prtlin( "      margin-left:auto;");
  p_fn_prtlin( "      margin-right:auto;");

  p_fn_prtlin( "    }");
  p_fn_prtlin( "    TD {");
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "      white-space: nowrap;");
  p_fn_prtlin( "      padding: 0;");
  p_fn_prtlin( "    }");

/*   p_fn_prtlin( "    .cLineGood   { background-color:#c3fdc3; }"); */
  p_fn_prtlin( "    .cLineStress { background-color:#ffbac7; }");
  p_fn_prtlin( "    .row4        { background-color:#f8f0c0; }");

/*   p_fn_prtlin( "    .cGr2        { background-color:#d0fda0; }"); */
/*   p_fn_prtlin( "    .cGr2        { background-color:#8bfd87; }"); */
/*   p_fn_prtlin( "    .cGr2        { background-color:#66ff33; }"); */

/*   p_fn_prtlin( "    .cGre        { background-color:#e1fdc3; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#ccffb9; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ffd9d9; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ffcccc; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fcb9b9; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fc8888; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#fc6094; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#ff3366; }"); */

/*    GREEN   */
/*     .cGr2        { background-color:#a3f275; } */
/*     .cGre        { background-color:#bbf699; } */
/*     .cNeu        { background-color:#d3f9bd; } */
/*     .cRed        { backgro;und-color:#bbf699; } */
/*     .cRe2        { background-color:#a3f275; } */


/*   p_fn_prtlin( "    .cGr2        { background-color:#66ff33; }"); */
/*   p_fn_prtlin( "    .cGr2        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#84ff98; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#a8ff98; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#bbf699; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#e1ddc3; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#d3f9bd; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#fcfce0; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#e6fbda; }"); */
/*   p_fn_prtlin( "      background-color: #fcfce0;"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#ff98a8; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#bbf699; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#ff4477; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#a3f275; }"); */

/*   p_fn_prtlin( "    .cGr2        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cGre        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cNeu        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cRed        { background-color:#a3f275; }"); */
/*   p_fn_prtlin( "    .cRe2        { background-color:#a3f275; }"); */


/*   p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #a3f275;}"); */
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #d3ffa5;}");
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {color: #007aff; background-color: #ffffff}");  // apple blue on  white
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {color: #007aff; background-color: #fcfce0}");  // apple blue on  
//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {                background-color: #fcfce0}");  // black on cHed 

//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #d3ffa5;}"); // light green
//  p_fn_prtlin( "    .cPerGreen1 {background-color: #d3ffa5;}");
//  p_fn_prtlin( "    .cPerGreen2 {background-color: #e6ffcc;}");

//  p_fn_prtlin( "    .cGr2,.cGre,.cNeu,.cRed,.cRe2 {background-color: #d3ffa5;}"); // light green
//    p_fn_prtlin( "    .cPerGreen1 {background-color: #ceffa0;}");  
//    p_fn_prtlin( "    .cPerGreen2 {background-color: #dfffbb;}"); 

    p_fn_prtlin( "    .cPerGreen1 {background-color: #e5e2c7;}");  // same as cNeu (new)  e5e2c7
    p_fn_prtlin( "    .cPerGreen2 {background-color: #e5e2c7;}");  // same as cNeu (new)  e5e2c7


  p_fn_prtlin("    .cNam        { color:#3f3ffa;");
  p_fn_prtlin("                   background-color: #F7ebd1;");
  p_fn_prtlin("                   font-size: 133%;");
  p_fn_prtlin("    }");

  p_fn_prtlin( "    table.trait {");          // browser view

  //p_fn_prtlin( "      font-size: 1.7em;");
  //p_fn_prtlin( "      font-size: 1.2em;");
  p_fn_prtlin( "      font-size: 1.45em;");

  p_fn_prtlin( "      margin-left: auto;");
  p_fn_prtlin( "      margin-right:auto;");
/*   p_fn_prtlin( "      font-family: Andale Mono, Monospacae, Courier New;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");

  //p_fn_prtlin( "      text-align: left;");
  p_fn_prtlin( "      text-align: center;");

/*   p_fn_prtlin( "      border: 1px solid black;"); */
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "      border-collapse: collapse;");
  p_fn_prtlin( "      border-spacing: 0;");

/*   p_fn_prtlin( "      padding-right:2%;"); */
/*   p_fn_prtlin( "      padding-left:2%;"); */
  p_fn_prtlin( "    }");
  p_fn_prtlin( "    table.trait td {");
/*   p_fn_prtlin( "      font-family: Andale Mono, Monospace, Courier New;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      white-space: pre;");
  p_fn_prtlin( "      font-size: 90%;");
  p_fn_prtlin( "      text-align: left;");

/*   p_fn_prtlin( "      border: 1px solid black;"); */
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-spacing: 0;");
  p_fn_prtlin( "      border-collapse: collapse;");
  p_fn_prtlin( "      border-spacing: 0;");

  p_fn_prtlin( "      padding-left: 10px; ");
  p_fn_prtlin( "      padding-right: 10px; ");

/*   p_fn_prtlin( "      padding-top: 2px; "); */
/*   p_fn_prtlin( "      padding-bottom: 2px; "); */
  p_fn_prtlin( "      padding-top: 1px; ");
  p_fn_prtlin( "      padding-bottom: 1px; ");

  p_fn_prtlin( "    }");
  p_fn_prtlin( "    table.trait th{");
/*   p_fn_prtlin( "      font-family: Trebuchet MS, Arial, Verdana, sans-serif;"); */
  p_fn_prtlin( "      font-family: Menlo, Andale Mono, Monospace, Courier New;");
  p_fn_prtlin( "      font-size: 90%;");
/*   p_fn_prtlin( "      padding-left: 10px; "); */
/*   p_fn_prtlin( "      padding-right: 10px; "); */
  p_fn_prtlin( "      padding: 10px; ");

/*   p_fn_prtlin( "      background-color: #e1fdc3 ;"); */
  p_fn_prtlin( "      background-color: #fcfce0 ;");

/*   p_fn_prtlin( "      border: 1px solid black;"); */
  p_fn_prtlin( "      border: none;");
  p_fn_prtlin( "      border-spacing: 0;");

  p_fn_prtlin( "      text-align: center;");
  p_fn_prtlin( "    }");
  p_fn_prtlin( "    table.trait       td { text-align: left; }");
  p_fn_prtlin( "    table.trait    td+td { text-align: right; }");
  p_fn_prtlin( "    table.trait td+td+td { text-align: left; }");

  p_fn_prtlin( "  </style>");

    
    /* put in favicon */
    p_fn_prtlin("<link href=\"data:image/x-icon;base64,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\" rel=\"icon\" type=\"image/x-icon\" />");

    
    
/* put in favicon */
    // old favicon     p_fn_prtlin("<link href=\"data:image/x-icon;base64,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\" rel=\"icon\" type=\"image/x-icon\" />");


  p_fn_prtlin( "</head>");
  p_fn_prtlin( " ");
  p_fn_prtlin("\n<body>");

  /*   p_fn_prtlin( "<body background=\"file:///mkgif1g.gif\">"); */
  /*   p_fn_prtlin( "<body background=\"file:///C/USR/RK/html/mkgif1g.gif\">"); */

  /* "Personality"   output here */
/* 
*   sprintf(writebuf, "\n  <h1>Personality</h1>");
*   p_fn_prtlin(writebuf);
*   sprintf(writebuf, "\n  <h2>of %s<br></h2>", arr(0) ); * of Fred  *
*   p_fn_prtlin(writebuf);
*/

/*   sprintf(writebuf, "\n  <h1>Personality <span style=\"font-size:80%%;\">of %s</span><br></h1>", arr(0) );  */
/*   sprintf(writebuf, "\n  <h1>Personality of %s<br></h1>", arr(0) ); * of Fred  * */

  p_fn_prtlin("<div><br></div>");
  sprintf(writebuf, "\n  <h1>Personality of <span class=\"cNam\">%s</span><br></h1>", arr(0) ); /* of Fred  */
  p_fn_prtlin(writebuf);

  //strcpy(gbl_person_name, arr(0));
  strcpy(gbl_p_person_name, arr(0));

  p_fn_prtlin(" ");

/* b(29); */
} /* end of  p_fn_output_top_of_html_file() */


/* arg in_docin_last_idx  is pointing at the last line written.
* Therefore, the current docin_lines written
* run from index = 0 to index = arg in_docin_last_idx.
*/
void p_docin_get(char *in_line)
{
  
/* tr("in p_docin_get");  ksn(in_line); */
  if (is_first_p_docin_get == 1) global_read_idx = 0;
  else                           global_read_idx++;
  
  is_first_p_docin_get = 0;  /* set to false */

  if (global_read_idx > global_max_docin_idx) {
    p_docin_free();
    rkabort("Error. perhtm.c walked off end of docin_lines array");
  }

  strcpy(in_line, global_docin_lines[global_read_idx] );

  scharout(in_line,'\n');   /* remove newlines */

tn(); kin(global_read_idx);
ksn(in_line);

} /* end of p_docin_get */


/* ************************************************************
*
* ************************************************************/
void p_fn_browser_aspect_text(char *aspect_code) {
  int nn;

/* tr("in p_fn_browser_aspect_text()"); */

  nn = binsearch_asp(aspect_code, p_asptab, NKEYS_ASP);

  if (nn < 0) return;  /* do not print any aspect text at all  */

  strcpy(my_aspect_text, p_asptab[nn].asp_text);


  /* wrap lines at 80 chars with <br> */
/*   put_br_every_n(my_aspect_text, 80);  */
  put_br_every_n(my_aspect_text, 65); 

  char para_beg[133];
  char para_end[133];

  strcpy(para_beg, "<table class=\"center\"><tr><td><p>");
  strcpy(para_end, "</p></td></tr><br></table>");
  sprintf(writebuf, "  %s%s%s\n", para_beg, my_aspect_text, para_end);

  p_fn_prtlin(writebuf);

}  /* end of p_fn_browser_aspect_text(); */

void p_fn_webview_aspect_text(char *aspect_code){
  int nn;
/* tr("in p_fn_webview_aspect_text()"); */

  nn = binsearch_asp(aspect_code, p_asptab, NKEYS_ASP);

  if (nn < 0) return;  /* do not print any aspect text at all  */

  strcpy(my_aspect_text, p_asptab[nn].asp_text);

  /* wrap lines at 80 chars with <br> */
  /*   put_br_every_n(my_aspect_text, 80);  */
  /*   put_br_every_n(my_aspect_text, 65);  */
//  put_br_every_n(my_aspect_text, 40);          // <=====----

tn();ksn(my_aspect_text);

  // print lines in my_aspect_text wrapped to line_not_longer_than_this
  // 
  char *pNewWord;
  int len_new_word, lenbuf, line_not_longer_than_this;
  char mybuf[8192];

  line_not_longer_than_this = 40;
  strcpy(mybuf, "");

  sprintf(writebuf, "fill|before para");
  p_fn_prtlin(writebuf);

  // NOTE here that strtok overwrites my_aspect_text to get the words,
  pNewWord = strtok (my_aspect_text, " ");  /* get ptr to first word */

  while (pNewWord != NULL)  /* for all words */
  {
    lenbuf       = (int)strlen(mybuf);
    len_new_word = (int)strlen(pNewWord);

    if (lenbuf + len_new_word >= line_not_longer_than_this) {

      while (strlen(mybuf) < line_not_longer_than_this) { // add spaces at end to fill up to line_not_longer_than_this  chars
        sprintf(mybuf, "%s ", mybuf);  // add a space at the end
      }
      sprintf(writebuf, "para|  %s",  mybuf);
      p_fn_prtlin(writebuf);
      
      strcpy(mybuf, "");                    /* init  mybuf */
    } /* write out since line too long */

    sprintf(mybuf, "%s%s%s", mybuf, pNewWord, " "); /* add new word to mybuf */

    pNewWord = strtok (NULL, " ");                  /* get ptr to next word */

  }  /* for all words */

  /* here no more words in aspect desc (mybuf has last line to add) */
  if (strlen(mybuf) != 0) {

    mybuf[ strlen(mybuf) - 1] = '\0'; /* but remove sp at end */

    while (strlen(mybuf) < line_not_longer_than_this) { // add spaces at end to fill up to line_not_longer_than_this  chars
      sprintf(mybuf, "%s ", mybuf);  // add a space at the end
    }
    sprintf(writebuf, "para|  %s",  mybuf);
    p_fn_prtlin(writebuf);
  }
  //
  // end of print lines in my_aspect_text wrapped to line_not_longer_than_this

} // end of  p_fn_webview_aspect_text()


//
////  // wrap: take a long input line and wrap it into multiple lines
////  void wrap(char s[], const int wrapline)
////  {
//      int i, k, wraploc, lastwrap;
//
//      lastwrap = 0; // saves character index after most recent line wrap
//      wraploc = 0; // used to find the location for next word wrap
//
//      for (i = 0; my_aspect_text[i] != '\0'; ++i, ++wraploc) {
//
//          if (wraploc >= wrapline) {
//              for (k = i; k > 0; --k) {
//                  // make sure word wrap doesn't overflow past maximum length
//                  if (k - lastwrap <= wrapline && my_aspect_text[k] == ' ') {
//                      my_aspect_text[k] = '\n';
//                      lastwrap = k+1;
//                      break;
//                  }
//              }
//              // wraploc = 0;
//              wraploc = i-lastwrap;
//          }
//      } // end main loop
//
////      for (i = 0; i < wrapline; ++i) printf(" ");
////      printf("|\n");
////      printf("%s\n", my_aspect_text);
////  }
//ksn(my_aspect_text); tn();
//
//      sprintf(writebuf, "para|%s",  my_aspect_text);
//      p_fn_prtlin(writebuf);
//





/* show "stars" in graph as green line
*  Must change all "*" to " ";
*/
void p_fn_prtlin_stars(char *starline)
{
tr("in p_fn_prtlin_stars()  ");

  char *pBegStar;
  char *pEndStar;
  char beforeStars[512];
  char allStars[512];  /* assume stars start at startline[0] */
  char afterStars[512];

  if (sall(starline, " ") == 1) {
    return;
  }

  if (scharcnt(starline, GRH_CHAR) == MAX_STARS) {
    sprintf(writebuf,
      "<span style=\"background-color:#e1fdc3;\">%s</span>", starline);
    p_fn_prtlin(writebuf);   /* write star line here */
    return;
  }


  pBegStar = strchr (starline, GRH_CHAR);
  pEndStar = strrchr(starline, GRH_CHAR);
  if (starline[0] == GRH_CHAR) {
    strcpy(beforeStars, "");
    mkstr(allStars,    pBegStar, pEndStar);
    mkstr(afterStars,  pEndStar + 1, starline + strlen(starline) - 1);
  } else {
    mkstr(beforeStars, starline, pBegStar - 1);
    mkstr(allStars,    pBegStar, pEndStar);
    strcpy(afterStars, "");
  }

  sprintf(writebuf,
    "%s<span style=\"background-color:#e1fdc3;\">%s</span>%s",
    beforeStars,
    allStars,
    afterStars
  ); 

ksn(writebuf);
  p_fn_prtlin(writebuf);   /* write star line here */

} /* end of p_fn_prtlin_stars() */

void p_fn_prtlin(char *lin) {
tr("in p_fn_prtlin()        ");
  char myEOL[8];
/* tn();
* tn();
* kin(GBL_HTML_HAS_NEWLINES);
* ksn(lin);
* kin(strlen(lin));
*/
  strcpy(myEOL, "\n");
  if (GBL_HTML_HAS_NEWLINES == 1)             strcpy(myEOL, "\n");
  if (GBL_HTML_HAS_NEWLINES == 0) {
/* tn();b(30);trn("calling scharout"); */


/*    scharout(lin,'\n'); */ /* remove newlines */


/* tn();b(31);trn("back from calling scharout"); */
/* ks(lin); */
    if (gbl_we_are_in_PRE_block_content == 1) strcpy(myEOL, "<br>");
    else                                      strcpy(myEOL, "");
  }
/* ksn(myEOL); */
  global_n = sprintf(global_p,"%s%s", lin, myEOL);

ksn(global_p);
  fput(global_p, global_n, Fp_p_HTML_file);
/* b(35); */
} 

void p_fn_prtlin_aspect(char *lin) {  /* no \n at end  ( UNUSED ) */
tr("in p_fn_prtlin_aspect() ");
  global_n = sprintf(global_p,"%s", lin);
ksn(global_p);
  fput(global_p, global_n, Fp_p_HTML_file);
}  



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* void do_orig_trait_graph(void)
* {
* int i;
* 
*   /*  read until [beg_graph]
*    */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_graph]") != NULL) break;
*   }
* 
*   p_fn_prtlin("  <div> Stand out character traits.</div>");
*  
*   p_fn_prtlin("<pre>");  /* start of graphs */
* 
*   gbl_we_are_in_PRE_block_content = 1;  /* true */
* 
*   p_fn_prtlin("  ");
* 
*   p_fn_prtlin("          less important                   important                     remarkable ");
*   p_fn_prtlin("               |                           |                             |          ");
*   p_fn_prtlin("  ");
*   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">ASSERTIVE </span> competitive, confident, enthusiastic                                     ");
* 
* 
*   /* ================================================================= */
*   /*  read until [beg_agrsv]   */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_agrsv]") != NULL) break;
*   }
* 
*   for (i=0; ; i++) {  /* print until [end_agrsv] */
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_agrsv]") != NULL) break;
* 
*     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
*     p_fn_prtlin_stars(doclin);  
*   }
*   p_fn_prtlin("  ");
* 
*   /* ================================================================= */
* 
*   /* ================================================================= */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_sensi]") != NULL) break;
*   }
* 
*   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">EMOTIONAL </span> protective, sensitive, intuitive,                                        ");
* 
*   for (i=0; ; i++) {  /* print until [end_sensi] */
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_sensi]") != NULL) break;
*     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
*     p_fn_prtlin_stars(doclin);  
*   }
*   p_fn_prtlin("  ");
* 
*   /* ================================================================= */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_restl]") != NULL) break;
*   }
* 
*   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">RESTLESS </span> versatile, changeable, drawn to new things                                ");
* 
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_restl]") != NULL) break;
*     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
*     p_fn_prtlin_stars(doclin);  
*   }
*   p_fn_prtlin("  ");
* 
*   /* ================================================================= */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_earth]") != NULL) break;
*   }
* 
*   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">DOWN-TO-EARTH </span> stable, practical, dependable                                        ");
* 
*   for (i=0; ; i++) { 
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_earth]") != NULL) break;
*     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
*     p_fn_prtlin_stars(doclin);  
*   }
*   p_fn_prtlin("  ");
* 
*   /* ================================================================= */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_sexdr]") != NULL) break;
*   }
* 
*   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">DRIVE </span> intense, passionate, relentless                                              ");
* 
*   for (i=0; ; i++) { 
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_sexdr]") != NULL) break;
*     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
*     p_fn_prtlin_stars(doclin);  
*   }
*   p_fn_prtlin("  ");
* 
*   /* ================================================================= */
* /* me and my big mouth   removed jun2013
* */
* #ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* *   for (i=0; ; i++) {
* *     p_docin_get(doclin);
* *     if (strstr(doclin, "[beg_bgmth]") != NULL) break;
* *   }
* * 
* * /*   p_fn_prtlin(" ME AND MY BIG MOUTH                                                                             ");
* * */
* *   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">ME AND MY BIG MOUTH </span>  talky, chat-loving, forthcoming                               ");
* * 
* *   for (i=0; ; i++) {
* *     p_docin_get(doclin);
* *     if (strstr(doclin, "[end_bgmth]") != NULL) break;
* * /*     p_fn_prtlin(doclin); */
* *     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
* *     p_fn_prtlin_stars(doclin);  
* *   }
* *   p_fn_prtlin("  ");
* * /*   p_fn_prtlin(" A high score shows a talky person who loves to chat and might talk first and think later.       ");
* * *   p_fn_prtlin("                                                                                                 ");
* * *   p_fn_prtlin("                                                                                                 ");
* * */
* #endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
* 
*   /* ================================================================= */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[beg_upndn]") != NULL) break;
*   }
* 
*   p_fn_prtlin("  <span style=\"background-color:#fdfbe1\">UPS AND DOWNS IN LIFE </span> having very high ups and very low downs                      ");
* 
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_upndn]") != NULL) break;
*     scharout(doclin, '|');  /* remove pipes (for old sideline)    */
*     p_fn_prtlin_stars(doclin);  
*   }
*   p_fn_prtlin("  ");
*   p_fn_prtlin("  ");
* 
* 
*   /* read until
*   */
*   for (i=0; ; i++) {
*     p_docin_get(doclin);
*     if (strstr(doclin, "[end_graph]") != NULL) break;
*   }
* 
*   gbl_we_are_in_PRE_block_content = 0;  /* false */
*   p_fn_prtlin("</pre>\n");
* 
* } /* end of do_orig_trait_graph(void) */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/



/* ============================================================================ */
void do_benchmark_trait_graph(void) {
/* ============================================================================ */
  int i;
/* trn("in do_benchmark_trait_graph(void) "); */

  /* start the graph (now table  201309) 
  */

/*   p_fn_prtlin(" <div><br></div>"); */
/*   p_fn_prtlin("  <table class=\"trait\">"); */
/*   p_fn_prtlin("    <tr> <th>Trait</th> <th>Score</th> <th>Influence</th> </tr>"); */


  /* 1. add the 5 benchmark lines to array (they will sort in themselves)
  * 1b. add the 6 trait lines to array 
  *  2. sort array of structs   (by score,trait)
  *  3. print html
  */
  add_all_benchmark_lines();

  /*  read until [beg_agrsv]   */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_agrsv]") != NULL) break;
  }

  for (i=0; ; i++) {  /* print until [end_agrsv] */
    p_docin_get(doclin);
    if (strstr(doclin, "[end_agrsv]") != NULL) break;

    strcpy(trait_lines[5].trait, "Assertive");
    strcpy(trait_lines[5].score, doclin);
    strcpy(trait_lines[5].influence, "");
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_sensi]") != NULL) break;
  }

  for (i=0; ; i++) { 
    p_docin_get(doclin);
    if (strstr(doclin, "[end_sensi]") != NULL) break;

    strcpy(trait_lines[6].trait, "Emotional");
    strcpy(trait_lines[6].score, doclin);
    strcpy(trait_lines[6].influence, "");
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_restl]") != NULL) break;
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[end_restl]") != NULL) break;

    strcpy(trait_lines[7].trait, "Restless");
    strcpy(trait_lines[7].score, doclin);
    strcpy(trait_lines[7].influence, "");
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_earth]") != NULL) break;
  }

  for (i=0; ; i++) { 
    p_docin_get(doclin);
    if (strstr(doclin, "[end_earth]") != NULL) break;

    strcpy(trait_lines[8].trait, "Down-to-earth");
    strcpy(trait_lines[8].score, doclin);
    strcpy(trait_lines[8].influence, "");
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_sexdr]") != NULL) break;
  }

  for (i=0; ; i++) { 
    p_docin_get(doclin);
    if (strstr(doclin, "[end_sexdr]") != NULL) break;

    strcpy(trait_lines[9].trait, "Passionate");
    strcpy(trait_lines[9].score, doclin);
    strcpy(trait_lines[9].influence, "");
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[beg_upndn]") != NULL) break;
  }

  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[end_upndn]") != NULL) break;

//    strcpy(trait_lines[10].trait, "Ups and Downs");
//    strcpy(trait_lines[10].score, doclin);
//    strcpy(trait_lines[10].influence, "");
  }


  /* read until
  */
  for (i=0; ; i++) {
    p_docin_get(doclin);
    if (strstr(doclin, "[end_graph]") != NULL) break;
  }

  /* sort the trait_lines by score,trait
  */
  qsort(
    trait_lines,
    11,           /* number of elements */
    sizeof(struct trait_table_line),
    (compareFunc_trait)Func_compare_trait_line_scores
  );

  //  write_html_for_trait_table(); // write the html for the table
  //
  if (gbl_are_in_per_htm_webview == 1) write_TBLRPT_trait_data();        /* now TBLRPT */
  else                                 write_html_for_trait_table();

} /* end of do_benchmark_trait_graph() */


void write_TBLRPT_trait_data(void) {    /* !!!!  TBLRPT  !!!!!  trait table data output here !!! */

  int i;
//  int score_int;

  sprintf(writebuf, "fill|filler line #1 at top");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "fill|before table head");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "head|How Much");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "head|of each trait");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "head|does %s have?", gbl_p_person_name);
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "fill|after table head");
  p_fn_prtlin(writebuf);

  for (i=0; i <= 9; i++) {   // ups and downs OUT = 1 less

    if (strcmp(trait_lines[i].influence, "Very High") == 0) {
//        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 90 </td><td>Great Deal</td></tr>");

//      strcpy(writebuf, "tabl|                          90  Great Deal  ");
      strcpy(writebuf, "tabl|                    90  Great Deal  ");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "High") == 0) {
      strcpy(writebuf, "tabl|                    75  A Lot       ");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "Average") == 0) {
      strcpy(writebuf, "tabl|                    50  Average     ");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "Low") == 0) {
      strcpy(writebuf, "tabl|                    25  Little      ");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "Very Low") == 0) {
      strcpy(writebuf, "tabl|                    10  Very Little ");
      p_fn_prtlin(writebuf);
      continue;
    }

    // put ROWCOLOR
    //    score_int = atoi(trait_lines[i].score);
    //
    //    if (score_int >= 90) strcpy(rowcolor, " class=\"cGr2\"");
    //    if (score_int <  90 &&
    //        score_int >= 75) strcpy(rowcolor, " class=\"cGre\"");
    //    if (score_int <  75 &&
    //        score_int >= 25) strcpy(rowcolor, " class=\"cNeu\"");
    //    if (score_int <= 25 &&
    //        score_int >  10) strcpy(rowcolor, " class=\"cRed\"");
    //    if (score_int <= 10) strcpy(rowcolor, " class=\"cRe2\"");
    //

//    sprintf(writebuf,  "gbl_color_cNeu|  %22s  %2s  %14s",
//      trait_lines[i].trait,
//      trait_lines[i].score,
//      " "
//    );
//    sprintf(writebuf,  "tabl|  %22s  %2s  %14s",
    sprintf(writebuf,  "tabl|  %16s  %2s  %14s",
      trait_lines[i].trait,
      trait_lines[i].score,
      " "
    );
    p_fn_prtlin(writebuf);

  } /* for all 11 table data lines */

  sprintf(writebuf, "fill|before table foot");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "foot|This score does NOT measure");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "foot|challenging or favorable.");
  p_fn_prtlin(writebuf);
  sprintf(writebuf, "fill|after table foot");
  p_fn_prtlin(writebuf);

} /* end of write_TBLRPT_trait_data() */



/* for the sort of array of struct trait_table_line by score and trait
* 
* int Func_compare_trait_line_scores( const void *line1, const void *line2);
* typedef int (*compareFunc_trait) (const void *, const void *);
* 
*/
int Func_compare_trait_line_scores(
  struct trait_table_line *line1,
  struct trait_table_line *line2
)
{

/* trn(" in  Func_compare_trait_line_scores()"); */
  /* sorted high to low
  */

  /* sort is on 1. score   2. trait
  */
  if ( strcmp( line2->score , line1->score ) == 0) {
    return ( strcmp(line1->trait, line2->trait ) );
  } else {
    return ( atoi(line2->score) - atoi(line1->score));
  }
}

/* <table>
* <tr> <th>Trait</th> <th>Score</th> <th>Influence</th> </tr>
* <tr class="cGr2"><td></td><td>373 </td><td>Very High</td></tr>
* <tr><td>Emotional</td><td>477 </td><td></td></tr>
* <tr><td>Passionate</td><td>300 </td><td></td></tr>
* <tr class="cGre"><td></td><td>213 </td><td>High</td></tr>
* <tr><td>Down-to-earth</td><td>150 </td><td></td></tr>
* <tr class="cNeu"><td></td><td>100 </td><td>Median</td></tr>
* <tr class="cRed"><td></td><td>42 </td><td>Low</td></tr>
* <tr><td>Restless</td><td>47 </td><td></td></tr>
* <tr><td>Assertive</td><td>33 </td><td></td></tr>
* <tr class="cRe2"><td></td><td>18 </td><td>Very Low</td></tr>
* <tr><td>Ups and Downs</td><td>15 </td><td></td></tr>
* </table>
*/


    //void write_html_for_trait_table(void);
    //void write_webview_html_for_trait_table(void);
void write_html_for_trait_table(void) {  // browser version   +  webview
  int i, score_int;
  char rowcolor[32];

/* then, */
/* <div class="centered"> */
/*     <table> */
/*     … */
/*     </table> */
/* </div> */
/* p_fn_prtlin("<div class=\"centered\"> "); */


  p_fn_prtlin("<table class=\"trait\" class=\"center\">");

  // new col hdr  20150510
//  p_fn_prtlin("<tr> <th>Trait*</th> <th>Score</th> <th></th> </tr>");
  sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \">How Much<br>of each trait<br>does %s have?<br></span></th></tr>", gbl_p_person_name);
  p_fn_prtlin(writebuf);


// table footer OUT 20150510
//  // table footer
//  p_fn_prtlin("  <tfoot>");
//  sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \">The score from 1 to 99 measures<br>\"how much\" of that trait<br>%s has.<br><br>The score does NOT measure<br>\"good\" or \"bad\".<br></span></th></tr>", gbl_p_person_name);
//  p_fn_prtlin(writebuf);
//  p_fn_prtlin("  </tfoot>");
//
//sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \">The score from 1 to 99 measures<br>\"how much\" of that trait<br>%s has.<br><br>The score does NOT measure<br>\"good\" or \"bad\".<br></span></th></tr>", gbl_p_person_name);


  // table footer
  p_fn_prtlin("  <tfoot>");
    //   sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \">The score does NOT measure<br>\"good\" or \"bad\".<br></span></th></tr>", gbl_p_person_name);

//    sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \">The score does NOT measure<br>\"good\" or \"bad\".<br></span></th></tr>");
    sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.5em; font-weight: normal; \">The score does NOT measure<br>challenging or favorable.<br></span></th></tr>");

  p_fn_prtlin(writebuf);
  p_fn_prtlin("  </tfoot>");
//
//sprintf(writebuf, "    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \">The score from 1 to 99 measures<br>\"how much\" of that trait<br>%s has.<br><br>The score does NOT measure<br>\"good\" or \"bad\".<br></span></th></tr>", gbl_p_person_name);



//for (i=0; i <=10; i++) 
  for (i=0; i <= 9; i++) {   // ups and downs OUT = 1 less

    if (strcmp(trait_lines[i].influence, "Very High") == 0) {
//    sprintf(writebuf, "  <tr class=\"cGr2\"><td></td><td>90 </td><td>Very High</td></tr>");
//      sprintf(writebuf, "  <tr class=\"cGr2\"><td></td><td>90 </td><td>Great Deal</td></tr>");
      if (i % 2 == 0)
        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 90 </td><td>Great Deal</td></tr>");
      else
        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 90 </td><td>Great Deal</td></tr>");

      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "High") == 0) {
//    sprintf(writebuf, "  <tr class=\"cGre\"><td></td><td>75 </td><td>High</td></tr>");
//      sprintf(writebuf, "  <tr class=\"cGre\"><td></td><td>75 </td><td>A Lot</td></tr>");
      if (i % 2 == 0)
        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 75 </td><td>A Lot</td></tr>");
      else
        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 75 </td><td>A Lot</td></tr>");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "Average") == 0) {
//      sprintf(writebuf, "  <tr class=\"cNeu\"><td></td><td>50 </td><td>Average</td></tr>");
      if (i % 2 == 0)
        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 50 </td><td>Average</td></tr>");
      else
        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 50 </td><td>Average</td></tr>");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "Low") == 0) {
//    sprintf(writebuf, "  <tr class=\"cRed\"><td></td><td>25 </td><td>Low</td></tr>");
//      sprintf(writebuf, "  <tr class=\"cRed\"><td></td><td>25 </td><td>Little</td></tr>");
      if (i % 2 == 0)
        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 25 </td><td>Little</td></tr>");
      else
        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 25 </td><td>Little</td></tr>");
      p_fn_prtlin(writebuf);
      continue;
    }
    if (strcmp(trait_lines[i].influence, "Very Low") == 0) {
//    sprintf(writebuf, "  <tr class=\"cRe2\"><td></td><td>10 </td><td>Very Low</td></tr>");
//      sprintf(writebuf, "  <tr class=\"cRe2\"><td></td><td>10 </td><td>Very Little</td></tr>");
      if (i % 2 == 0)
        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 10 </td><td>Very Little</td></tr>");
      else
        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 10 </td><td>Very Little</td></tr>");
      p_fn_prtlin(writebuf);
      continue;
    }
    

    score_int = atoi(trait_lines[i].score);

    /* put ROWCOLOR
    */
    //    if (score_int >= 90) strcpy(rowcolor, " class=\"cGr2\"");
    //    if (score_int <  90 &&
    //        score_int >= 75) strcpy(rowcolor, " class=\"cGre\"");
    //    if (score_int <  75 &&
    //        score_int >= 25) strcpy(rowcolor, " class=\"cNeu\"");
    //    if (score_int <= 25 &&
    //        score_int >  10) strcpy(rowcolor, " class=\"cRed\"");
    //    if (score_int <= 10) strcpy(rowcolor, " class=\"cRe2\"");
    //
    if (i % 2 == 0)
      strcpy(rowcolor, " class=\"cPerGreen1\"");
    else
      strcpy(rowcolor, " class=\"cPerGreen2\"");


    sprintf(writebuf,  "  <tr %s><td>%s</td><td>%s </td><td></td></tr>",
      rowcolor,
      trait_lines[i].trait,
      trait_lines[i].score
    );
    p_fn_prtlin(writebuf);

  } /* for all 11 table data lines */


  p_fn_prtlin("</table>");
/* p_fn_prtlin("</div> "); */

} /* end of write_html_for_trait_table(void) */  // for browser + webview

//
//void write_webview_html_for_trait_table(void) {   // NOT called ??  20150510
//  int i, score_int;
//  char rowcolor[32];
//
//  p_fn_prtlin("<table class=\"trait\" class=\"center\">");
//    //<.>
///*   p_fn_prtlin("<tr> <th>Trait *</th> <th>Score</th> <th>Benchmark</th> </tr>"); */
////  p_fn_prtlin("<tr> <th>Trait*</th> <th>Score</th> <th></th> </tr>");
//  p_fn_prtlin("<tr> <th>Trait</th> <th>Score</th> <th></th> </tr>");
//
////for (i=0; i <=10; i++) 
//  for (i=0; i <= 9; i++) {   // ups and downs OUT = 1 less
//
//    if (strcmp(trait_lines[i].influence, "Very High") == 0) {
////      sprintf(writebuf, "  <tr class=\"cGr2\"><td></td><td>90 </td><td>Very High</td></tr>");
//      if (i % 2 == 0)
//        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 90 </td><td>Very High</td></tr>");
//      else
//        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 90 </td><td>Very High</td></tr>");
//      p_fn_prtlin(writebuf);
//      continue;
//    }
//    if (strcmp(trait_lines[i].influence, "High") == 0) {
////      sprintf(writebuf, "  <tr class=\"cGre\"><td></td><td>75 </td><td>High</td></tr>");
//      if (i % 2 == 0)
//        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 75 </td><td>High</td></tr>");
//      else
//        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 75 </td><td>High</td></tr>");
//      p_fn_prtlin(writebuf);
//      continue;
//    }
//    if (strcmp(trait_lines[i].influence, "Average") == 0) {
////      sprintf(writebuf, "  <tr class=\"cNeu\"><td></td><td>50 </td><td>Average</td></tr>");
//      if (i % 2 == 0)
//        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 50 </td><td>Average</td></tr>");
//      else
//        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 50 </td><td>Average</td></tr>");
//      p_fn_prtlin(writebuf);
//      continue;
//    }
//    if (strcmp(trait_lines[i].influence, "Low") == 0) {
////      sprintf(writebuf, "  <tr class=\"cRed\"><td></td><td>25 </td><td>Low</td></tr>");
//      if (i % 2 == 0)
//        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 25 </td><td>Low</td></tr>");
//      else
//        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 25 </td><td>Low</td></tr>");
//      p_fn_prtlin(writebuf);
//      continue;
//    }
//    if (strcmp(trait_lines[i].influence, "Very Low") == 0) {
////      sprintf(writebuf, "  <tr class=\"cRe2\"><td></td><td>10 </td><td>Very Low</td></tr>");
//      if (i % 2 == 0)
//        strcpy(writebuf, "<tr class=\"cPerGreen1\"><td></td><td> 10 </td><td>Very Little</td></tr>");
//      else
//        strcpy(writebuf, "<tr class=\"cPerGreen2\"><td></td><td> 10 </td><td>Very Little</td></tr>");
//      p_fn_prtlin(writebuf);
//      continue;
//    }
//    
//
//    score_int = atoi(trait_lines[i].score);
//
//    /* put ROWCOLOR
//    */
//    //    if (score_int >= 90) strcpy(rowcolor, " class=\"cGr2\"");
//    //    if (score_int <  90 &&
//    //        score_int >= 75) strcpy(rowcolor, " class=\"cGre\"");
//    //    if (score_int <  75 &&
//    //
//    ///*         score_int >= 25) strcpy(rowcolor, " class=\"cNeu\""); */
//    //        score_int >  25) strcpy(rowcolor, " class=\"cNeu\"");
//    //
//    //    if (score_int <= 25 &&
//    //        score_int >  10) strcpy(rowcolor, " class=\"cRed\"");
//    //    if (score_int <= 10) strcpy(rowcolor, " class=\"cRe2\"");
//    //
//    if (i % 2 == 0)
//      strcpy(rowcolor, " class=\"cPerGreen1\"");
//    else
//      strcpy(rowcolor, " class=\"cPerGreen2\"");
//
//
//    sprintf(writebuf,  "  <tr %s><td>%s</td><td>%s </td><td></td></tr>",
//      rowcolor,
//      trait_lines[i].trait,
//      trait_lines[i].score
//    );
//    p_fn_prtlin(writebuf);
//
//  } /* for all 11 table data lines */
//
//
//  p_fn_prtlin("</table>");
//
//} // end of  write_webview_html_for_trait_table() 
//
//

void add_all_benchmark_lines(void)
{
/* trn(" in void add_all_benchmark_lines(void)"); */
  strcpy(trait_lines[0].trait, "zzzzzzzzzzzz"); /* sort below ties with 373 */
  strcpy(trait_lines[0].score, "90");
  strcpy(trait_lines[0].influence, "Very High");

  strcpy(trait_lines[1].trait, "zzzzzzzzzzzz"); /* sort below ties with 213 */
  strcpy(trait_lines[1].score, "75");
  strcpy(trait_lines[1].influence, "High");

  strcpy(trait_lines[2].trait, "zzzzzzzzzzzz"); /* sort below ties with 100 */
  strcpy(trait_lines[2].score, "50");
  strcpy(trait_lines[2].influence, "Average");  /* not median */

  strcpy(trait_lines[3].trait, "            "); /* sort above ties with  42 */
  strcpy(trait_lines[3].score, "25");
  strcpy(trait_lines[3].influence, "Low");

  strcpy(trait_lines[4].trait, "            "); /* sort above ties with  18 */
  strcpy(trait_lines[4].score, "10");
  strcpy(trait_lines[4].influence, "Very Low");
}


/* end of perhtm.c */


//  p_fn_prtlin("   <span style=\"font-size: 0.9em; font-weight: normal;\">");
//<span style=\"font-size: 0.9em; font-weight: normal;\">
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\"> </th></tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\">The score from 1 to 99 measures</th></tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\">\"how much\" of that trait</th> </tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\">~Jen has</tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\"> </th></tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\">The score does NOT measure \"good\" or \"bad\"</th></tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\"> </th></tr>");
//

//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\"><br>The score from 1 to 99 measures \"how much\" of that trait ~Jen has.<br>The score does NOT measure \"good\" or \"bad\"<br>.</tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\"><span style=\"font-size: 0.9em; font-weight: normal;\"><br>The score from 1 to 99 measures \"how much\" of that trait ~Jen has.<br><br>The score does NOT measure<br>\"good\" or \"bad\".<br><br></span></th></tr>");

// text-align: left works below, but do  not  like it
//  p_fn_prtlin("    <tr><th colspan=\"3\" style=\" text-align: left; \"><span style=\"font-size: 0.9em; font-weight: normal; \"><br>The score from 1 to 99 measures \"how much\" of that trait ~Jen has.<br><br>The score does NOT measure<br>\"good\" or \"bad\".<br><br></span></th></tr>");
//  p_fn_prtlin("    <tr><th colspan=\"3\" \"><span style=\"font-size: 0.9em; font-weight: normal; \"><br>The score from 1 to 99 measures \"how much\" of that trait ~Jen has.<br><br>The score does NOT measure<br>\"good\" or \"bad\".<br><br></span></th></tr>");


//  p_fn_prtlin("<div> <span style=\"font-size: 1.0em\"><br>produced by iPhone app Me and my BFFs</span><br><br><span style=\"font-size: 0.9em; font-weight: bold; color:#FF0000;\">This report is for entertainment purposes only.</span></div><div><br></div>");
//<.>
//tfoot {
//  background-color: #666666;
//  color: #dddddd;
//  font-size: 80%;
//}
//  p_fn_prtlin("   <tfoot> <span style=\"font-size: 0.9em; font-weight: normal;\">");
//
//  p_fn_prtlin( "    table.trait tfoot { ");
//  p_fn_prtlin( "      background-color: #ff0000 ;");
//  p_fn_prtlin( "      font-size: 0.9em;");
//  p_fn_prtlin( "      font-weight: normal;");
//  p_fn_prtlin( "    } ");
//<.>
//

