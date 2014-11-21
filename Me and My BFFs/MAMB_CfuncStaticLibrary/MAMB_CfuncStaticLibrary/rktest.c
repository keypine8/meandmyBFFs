/* rktest.c */

/* #include "windows.h"  */
#include "rkdebug.h"

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <sys/time.h>

/* #include <mtrace.h> */
/* #include "mtrace.h" */
/*   mtrace(); */
/*   muntrace(); */


/* #include "/usr/rk/c/rk.h" */
#include "rk.h"
FILE *fp; int i,j,k; double x,y,z; unsigned u,v,w;
char buf[512+1],wk[512+1];
double year;
double month;
double day;
double hour;
int amorpm;
double min;
double step;
char workbuf[512];
char writebuf[512];
char s1[512];
char s2[512];
char s3[512];

void commafy_int(char *dest, long intnum, int sizeofs);
void put_br_every_n(char *instr,  int line_not_longer_than_this);
char *mkstr(char *s,char *begarg,char *end);
char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);
char *strstrtok(char *str, char *delim);
void sfill(char *s, int num, int c);

void strsubg(char *s, char *replace_me, char *with_me);

/* strsubg    on str s (max 512) does  :s/replace_me/with_me/g
*/
void strsubg(char *s, char *replace_me, char *with_me)
{
  char final_result[2048], wkbuf[2048], wkbuf2[2024], buf2[2048];
  char save_s[2048], done_so_far[2048];
  char *p;
  char *qq; int iii;

tn();ksn("in strsubg");
ksn(s);
ksn(replace_me);
ks(with_me);
  strcpy(save_s, s);
  strcpy(done_so_far, "");
  strcpy(wkbuf, s);
  strcpy(final_result, "");

  while (1) {
    p = strstr(wkbuf, replace_me);
tn();b(1);ks(p);
    if (p == NULL) {
      strcat(final_result, wkbuf); /* put rest of wkbuf into final_result */
      strcat(done_so_far, wkbuf); 
tn();b(2);ks(final_result);
tn();b(2);ks(done_so_far);
      strcpy(s, final_result);
tn();b(3);ks(s);
      break;  
    } else {
      if (p == wkbuf) {  /* str starts with " X" */
        strcat(final_result, with_me); /* append "with_me" */
        strcat(done_so_far, replace_me); 
tn();b(10);ks(final_result);
tn();b(10);ks(done_so_far);
        /* point wkbuf at rest of s */
ksn(wkbuf);
qq = wkbuf + strlen(replace_me); ksn(qq);
iii = strlen(replace_me); kin(iii);

        /* wkbuf2 solves abort trap 6    so,
        *  instead of this: strcpy(wkbuf, wkbuf2);
        *  use this:        strcpy(wkbuf, wkbuf + strlen(replace_me));
        */
        strcpy(wkbuf2, wkbuf + strlen(replace_me));

ksn(wkbuf2);
        strcpy(wkbuf, wkbuf2);
ksn(wkbuf);
ksn("that worked 1");

/* ksn("that worked 2"); */

tn();b(11);ks(wkbuf);
        continue;
      }

tn();b(12);
      mkstr(buf2, wkbuf, p-1);  /* grab intermediate stuff in buf2 */
ks(buf2);

      /* append the stuff before "replace_me"
      */
      strcat(final_result, buf2);
      strcat(done_so_far, buf2); 
tn();b(5);ks(final_result);
tn();b(5);ks(done_so_far);

      /* append "with_me"
      */
      strcat(final_result, with_me);
      strcat(done_so_far, replace_me); 
tn();b(6);ks(final_result);
tn();b(6);ks(done_so_far);

      /* are we finished ? */
      if (strcmp(done_so_far, save_s) == 0) break;

      /* point wkbuf at rest of s
      */
/*       strcpy(wkbuf, wkbuf + strlen(done_so_far)); */
      strcpy(wkbuf, save_s + strlen(done_so_far));
tn();b(7);ks(wkbuf);
    }
  }
ksn(final_result);b(99);
  strcpy(s, final_result);
  return;
} /* end of  strsubg() */



#define usecdiff(end,beg) ((end.tv_sec*1000000+end.tv_usec) - (beg.tv_sec*1000000 + beg.tv_usec))

/* Calculate day of week in proleptic Gregorian calendar.
*  Sunday == 0.
*/
int day_of_week(int month, int day, int year)
{
	int adjustment, mm, yy;
 
	adjustment = (14 - month) / 12;
	mm = month + 12 * adjustment - 2;
	yy = year - adjustment;
	return (day + (13 * mm - 1) / 5 +
		yy + yy / 4 - yy / 100 + yy / 400) % 7;
}
char *N_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""};


int strcmp_ignorecase(char *s1, char *s2);

int strcmp_ignorecase(char *s1, char *s2)
{
  int retval;
  for (;; s1++, s2++) {
    retval = tolower(*s1) - tolower(*s2);
    if (retval != 0 || !*s1) return retval;
  }
}


int map_benchmark_num_to_percentile_rank(int in_score);
int calc_percentile_rank(int in_score, int sc_hi, int sc_lo, int pr_hi, int pr_lo);

int benchmark_numbers[] = {-1, 777, 373, 213, 100, 42, 18,  1};  /* FROM */
int percentile_ranks[]  = {-1,  99,  90,  75,  50, 25, 10,  1};  /* TO */

int map_benchmark_num_to_percentile_rank(int in_score)
{
  if (in_score <= 1)   return( 1);
  if (in_score >= 777) return(99);

  /* return exact hits */
  if (in_score == 373) return(90);
  if (in_score == 213) return(75);
  if (in_score == 100) return(50);
  if (in_score ==  42) return(25);
  if (in_score ==  18) return(10);

  /* take in_score,
  *  find out which two scores it is between
  *  calculate interpolation score
  */

  /* e.g. map 41 -> 18 to 25 -> 10 */
  if (in_score <  18 && in_score >   1) return calc_percentile_rank(in_score,  18,   1, 10,  1);
  if (in_score <  42 && in_score >  18) return calc_percentile_rank(in_score,  42,  18, 25, 10);
  if (in_score < 100 && in_score >  42) return calc_percentile_rank(in_score, 100,  42, 50, 25);
  if (in_score < 213 && in_score > 100) return calc_percentile_rank(in_score, 213, 100, 75, 50);
  if (in_score < 373 && in_score > 213) return calc_percentile_rank(in_score, 373, 213, 90, 75);
  if (in_score < 777 && in_score > 373) return calc_percentile_rank(in_score, 777, 373, 99, 90);

  return(1);  /* should not happen */

} /* end of map_benchmark_num_to_percentile_rank()  */

int calc_percentile_rank(int in_score, int sc_hi, int sc_lo, int pr_hi, int pr_lo)
{
  /* return (10 + ( (25 - 10) *   (in_score - 18) / (41 - 18)  ); */
  return (pr_lo + ( (pr_hi - pr_lo) *   (in_score - sc_lo) / (sc_hi - sc_lo) ) );

}; /* end of calculated_percentile_rank() */


void bracket_string_of(
  char *any_of_these,
  char *in_string,   
  char *left_bracket,
  char *right_bracket  )
{
  int i, k, len1, len2, is_target, are_in_run;
  char str2048[2048], currchar_as_s[4];

/*   int iii; */
/* tn();ks("in bracket_string_of()"); */

  is_target  = 0;  /* 1 y, 0 n */
  are_in_run = 0;  /* 1 y, 0 n */

  strcpy(str2048, "");
/*   sfill(str2048, 2000, ' '); */

/* fill up string s with num chars, where char=c */
/* '\0' goes in (num+1)th position in s, i.e. s[num] */
/* void sfill(char *s, int num, int c) */


  /* build the new string in str2048, then copy to in_string (make big enough)
  */
  len1 = strlen(in_string);
  len2 = strlen(any_of_these);
/* b(10); */
  for (i=0; i <= len1 - 1; i++) {

    currchar_as_s[0] = in_string[i];
    currchar_as_s[1] = '\0';

    /* determine if this char is a target char in any_of_these
    *  set is_target
    */
    is_target = 0;
    for (k=0; k <= len2 - 1; k++) {
      if (in_string[i] == any_of_these[k]) is_target = 1;
    }

/* kin(i); kc(in_string[i]); ki(is_target); */

    if ((is_target == 1  &&  are_in_run == 1)  /* no change */
    ||  (is_target == 0  &&  are_in_run == 0) ){ 
/* b(11);iii = strlen(str2048); kin(iii); */
      strcat(str2048, currchar_as_s);
    }

    if (is_target == 1  &&  are_in_run == 0) {
/* b(12);iii = strlen(str2048); kin(iii); */

      are_in_run = 1;   /* copy left bracket in, then char */
      strcat(str2048, left_bracket);
      strcat(str2048, currchar_as_s);
    }
    if (is_target == 0  &&  are_in_run == 1) { 
/* b(14);iii = strlen(str2048); kin(iii); */
      are_in_run = 0;   /* copy right bracket in, then char */
      strcat(str2048, right_bracket);
      strcat(str2048, currchar_as_s);
    }
  } /* for each char in in_string */

  /* at the end of string, check if are_in_run,
  *  if so, put in the char first and right bracket
  */
  if (are_in_run == 1) {
    are_in_run = 0;
/*     strcat(str2048, currchar_as_s); */
    strcat(str2048, right_bracket);
  }

/* b(15); */
  strcpy(in_string, str2048);

/* ksn(in_string); */

} /* end of bracket_string_of() */


/* snone()   in s, look for chars in set.
*  If NONE found, return 1,  else return 0
*/
int snone(char *s,char *set)
{
	char *p = s;
	;
	for ( ; *p != '\0'; ++p) {
		if (strchr(set,*p) != NULL) return 0;
	}
  return 1;
}	/* end of snone() */



int main(int argc, char *argv[])
{
	int num, ret, i; 
  char csvstr[64], fld1[16], linebuf[2048];
  char *p, *q;
  char *s_arr[3];
  double d1,d2,d3,d4;
  int before6i;
  char char_num_pairs[6];  /* max 4,990 pairs for max 100 group members */
  int after6i;
  char after6[5];
  fpdb = fopen("t.out","w"); /* put me in main(). output file for debug code */


  /* TEST snone() */
tn();
  sprintf(fld1,"%4.0f", 1994.0); ksn(fld1);
  sprintf(fld1,"%4.0f", 1994.1); ksn(fld1);
  sprintf(fld1,"%4.0f", 1993.9); ksn(fld1);
  sprintf(fld1,"%4.0f", 1994.00000009); ksn(fld1);
  return(0);

  strcpy(linebuf, "oisidjfjfw'jg;j"); strcpy(fld1, "x");
  ret =  snone(linebuf, fld1);ksn(fld1);ki(ret);ks(linebuf);
  strcpy(linebuf, "oisidjfjfw'jg;j"); strcpy(fld1, "*");
  ret =  snone(linebuf, fld1);ksn(fld1);ki(ret);ks(linebuf);
  strcpy(linebuf, "oisidjfjfw'jg;j"); strcpy(fld1, "g");
  ret =  snone(linebuf, fld1);ksn(fld1);ki(ret);ks(linebuf);

  return(0);




  /* TEST bracket_string_of */

/*   strcpy(linebuf, */
/*     "       |X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX X * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX *|");  */
/* strcpy(linebuf, "       |             *              ****        **                                                |"); */
/* strcpy(linebuf, "XXXXX"); */
strcpy(linebuf, "       |             *              ****        **                                                |");

i = strlen(linebuf);
b(1);ki(i); ks(linebuf);

/*   bracket_string_of("X*", linebuf, "<span class=\"cGr2\">", "</span> "); */
  bracket_string_of("*", linebuf, "<span class=\"star\">", "</span> ");

tn();b(2);
i = strlen(linebuf);
;ki(i);
ksn(linebuf);

b(3);


  return(0);



  /* TEST strsubg */

/*    strcpy(s1, "  XXX   *  XX");  */
/*   strcpy(s1, " X * X"); */
/*   strcpy(s1, argv[1]); */

/* if(i==41){strcpy(linebuf, "       |X  *X  *XX XX  XX   * X* X  *X  *XX XX  XX X * X* X  *X  *XX XX  XX   * X* X  *X  *XX XX *|");} */
/* if(i==41){strcpy(linebuf, "       |                            *X  *XX XX  XX X * X* X  *X  *XX X                            |");} */

/* strcpy(s1, "       |                            *X  *XX XX  XX X * X* X  *X  *XX X                            |"); */
strcpy(s1, "       |             *              ****        **                                                |");
tn();ksn(s1);
/*   strcpy(s2, strstr(s1, " X")); */

/* void strsubg(char *s, char *replace_me, char *with_me) */
 
/*   strsubg(s1, "X ", "<span class=\"cGre\">X</span) "); */
/*   strsubg(s1, " X", " <span class=\"cGre\">X</span)"); */
/*   strsubg(s1, "*", "<span class=\"cGre\">*</span)"); */

      strsubg(s1, "X ", "<span class=\"cGre\">X</span> ");
      strsubg(s1, " X", " <span class=\"cGre\">X</span>"); 
      strsubg(s1, "*" , "<span class=\"cGre\">*</span>");
      strsubg(s1, 
        "<span class=\"cGre\">*</span><span class=\"cGre\">*</span>",
        "<span class=\"cGre\">**</span>"
      );
      strsubg(s1, 
        "<span class=\"cGre\">**</span><span class=\"cGre\">**</span>",
        "<span class=\"cGre\">****</span>"
      );
tn();tn();ksn(s1);tn();tn();

  return(0);


  /* TEST score to percentile rank conversion */

  num = 1000; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
  num = 100; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);

/*   num = 1; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 2; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 3; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 4; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 5; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 18; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 17; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 16; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 15; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 14; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
* 
*   num = 8; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 9; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*   num = 10; ret = map_benchmark_num_to_percentile_rank(num); kin(num);ki(ret);
*/

/*   num =  1;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*   num = 18;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*   num = 42;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*   num = 100;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*   num = 213;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*   num = 373;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*   num = 777;
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num - i); kin(num - i);ki(ret); }
*   for (i = 1; i < 5; i++) { ret = map_benchmark_num_to_percentile_rank(num + i); kin(num + i);ki(ret); }
*/

  for (i=1; i < 889; i++) {
    ret = map_benchmark_num_to_percentile_rank(i); kin(i);ki(ret); 
  }
  tn();
  return(0);




/* code for  timing microseconds */
#define usecdiff(end,beg) ((end.tv_sec*1000000+end.tv_usec) - (beg.tv_sec*1000000 + beg.tv_usec))
  struct timeval tdbeg, tdend;  long us;
  clock_t beg, end; 
  beg = clock();
  gettimeofday(&tdbeg, NULL );
  for (num=0; num <= 1000000; num++) {
    strcpy(fld1,"junk");
  }
  gettimeofday(&tdend, NULL );
  end = clock();
  us = (tdend.tv_sec*1000000+tdend.tv_usec) - (tdbeg.tv_sec*1000000 + tdbeg.tv_usec);
  us = usecdiff(tdend,tdbeg);
kin(us);
/* end of code for  timing microseconds */


/* kin(beg);
* kin(end);
* kin(CLOCKS_PER_SEC);
* num = end - beg;
* kin(end-beg);
* kin(num);
* d1 =  ( (double) end - beg) / CLOCKS_PER_SEC ;
* kdn(d1);
*/

/* <.>
* ct timeval start, end;
* gettimeofday( &start, NULL );
* ...
* gettimeofday( &end, NULL );
* unsigned long long micros = (end.tv_sec*1000000+end.tv_usec) - (start.tv_sec*1000000 + start.tv_usec );
* <.>
*/

  return(0);



	int y,m,d;
  y = 2014;  m = 1; 
	for (d = 1; d <= 30; d++) {
    printf("%04d%02d%02d %s\n",
      y,m,d, N_day_of_week[ day_of_week(1,d,2014) ] ) ;
	}
 
/* 	for (y = 2008; y <= 2121; y++) { */
/* 		if (day_of_week(12, 25, y) == 0) printf("%04d-12-25\n", y); */
/* 	} */
 
	return 0;



  d1 = atof(argv[1]);
  d1 = log(d1);
  printf("log(%s) is %8.2f\n", argv[1],d1);
return(0);

trn("hey");tn();
  d1 = atof(argv[1]);
  d2 = atof(argv[2]);
kdn(d1);kd(d2);
d4 = d1*d1; kdn(d4);
d4 = d2*d2; kd(d4);
d3 = sqrt(d1*d1 + d2*d2);
trn("sqrt of above=");kd(d3);

return(0);

b(1);tn();
  strcpy(fld1, "second"); 
  s_arr[0] = "first";
  s_arr[1] = "second";
ksn(s_arr[0]);
ksn(s_arr[1]);
return(0);


  strcpy(after6,"123456");
  num = atoi(argv[1]);
tn();ksn(after6);ki(before6i);ki(after6i);ki(num);
  commafy_int(char_num_pairs, num, 6);
tn();ksn(after6);ki(before6i);ki(after6i);ki(num);
ksn(char_num_pairs); tn();



/*   d3 = atof(argv[1]);
*   d3 = log2(d3);
*   printf("log2 is %8.2f\n", d3);
* 
*   d2 = atof(argv[1]);
*   d2 = log10(d2);
*   printf("log10 is %8.2f\n", d2);
*/

  d1 = atof(argv[1]);
  d1 = log(d1);
  printf("log(%s) is %8.2f\n", argv[1],d1);

  d2 = atof(argv[1]);
  d2 = log(d2) / log(1.618);
  printf("log f (%s) is %8.2f\n", argv[1],d2);


/*   d4 = atof(argv[1]);
*   d4 = log(log(d1));
*   printf("log log is %8.2f\n", d4);
*/

return(0);




  /* e.g.  "Delia,12,13,1971,12,15,0,-1,-19.05" */
/*   strcpy(csvstr, "Delia,12,13,1971,12,15,0,-1,-19.05"); */
/*   strcpy(csvstr, "Delia,12,,1971,,,,-1,-19.05"); */
  strcpy(csvstr, "Delia, 12, , 1971, , , , -1, -19.05");
ksn(csvstr);
  p = csvstr + 15;
  q = csvstr + 16;
  mkstr(workbuf, p, q);
ksn(workbuf);
  
  /* char *csv_get_field(char *csv_string, char *delim, int fieldnum)  */
  num = atoi(argv[1]);
  strcpy(fld1, csv_get_field(csvstr, ",", num));
kin(num); ks(fld1); tn();tn();

  return(0);



  
/*   strcpy(buf," put \"<br>\"s in arg1 string so lines are not longer than arg2"); */

  strcpy(buf,"All your energy is under a favourable influence giving you confidence and enthusiasm.  Sports or exercise go well because you have extra courage and your actions are constructive.");


tn(); b(31); b(55); ksn(buf);

ksn(argv[0]);
num = strlen(buf);
kin(num); b(56);
ksn(argv[1]);
b(57);
  strcpy(s2, argv[1]);
ksn(s2);
  int wrap_every;
  wrap_every = atoi(argv[1]);
kin(wrap_every);
  put_br_every_n(buf, wrap_every );

b(32);
kin(strlen(buf));

tn(); b(33); ksn(buf); tn();
return(0);

  strcpy(buf, "1234 6789 abcd fghi klmn pqrs 123");
  fprintf(stdout, "buf=[%s]\n", buf);
  put_br_every_n(buf, 10);
  fprintf(stdout, "buf=[%s]\n", buf);

  return(0);    /* ====================================== */

} /* end of main() */


char *strstrtok(char *str, char *delim)
{
    static char *prev;
    if (!str) str = prev;
    if (str) {
        char *end = strstr(str, delim);
        if (end) {
            prev = end + strlen(delim);
            *end = 0;
        } else {
            prev = 0;
        }
    }
    return str;
}


/* char *csv_get_field2(char *csv_string, char delimchar, int want_fieldnum) {
*   char *p, *q;
*   int  i, field_cnt;
*   char workbuf[512],retval[512], current_field[512]; 
* 
*   strcpy(workbuf, csv_string);
*   for (i=0; i < strlen(workbuf); i++) {
*     if ( *(workbuf+i) != delimchar ) {
*       current_field
*   }
* 
*   return("");
* }
*/

char *csv_get_field(char *csv_string, char *delim, int want_fieldnum) {
  char * pNewField;
  int field_idx;
  
  if (want_fieldnum < 1) return("");

  /* strtok cannot handle "empty" fields like
  *  "Delia,12,,1971,,,,-1,-19.05"
  *  you have to change every "," to ", " then
  *  remove the leading space in pNewField
  */

  pNewField = strtok(csv_string, delim);  /* get ptr to first field */

  for (field_idx = 1; pNewField != NULL; field_idx++) /* walk fields in csv */
  {
    if (field_idx != want_fieldnum) {
trn("current=");ki(field_idx);ks(pNewField);
      pNewField = strtok (NULL, delim);  /* get ptr to next field */
trn("new    =");ki(field_idx);ks(pNewField);
      continue; 
    }
    return(pNewField);
  }  
  return("");
}  /* end of csv_get_field() */



void put_br_every_n(char *instr,  int line_not_longer_than_this)
{
  char * pch;
b(10);
  strcpy(writebuf, "");
b(11);
  strcpy(workbuf, "");
b(12);

kin(line_not_longer_than_this);
  pch = strtok (instr," ");  /* get first word */
ksn(pch);
  while (pch != NULL)  /* for all words */
  {
kin(strlen(writebuf));
kin(strlen(pch));
    int len_new_word, lenbuf;
    lenbuf       = strlen(writebuf);
    len_new_word = strlen(pch);
    if (lenbuf + len_new_word >= line_not_longer_than_this) {
    
      sprintf(writebuf, "%s<br>", writebuf); 

      /* add writebuf to final result in workbuf */
      sprintf(workbuf, "%s%s", workbuf, writebuf);
tn(); b(51); ksn(workbuf); tn();

ksn(writebuf);
      strcpy(writebuf, "");  /* init  writebuf */
    }

    /* add new word to writebuf */
    sprintf(writebuf, "%s%s%s", writebuf, pch, " ");

    pch = strtok (NULL, " ");  /* get next word */
ksn(pch);

  }  /* for all words */

tn(); b(60); ksn(writebuf); tn();
  if (strlen(writebuf) != 0){

tn(); b(52); ksn(writebuf); tn();
    /* add writebuf to final result in instr
    * but remove "<br>" at end
    */
    writebuf[ strlen(writebuf) - 1] = '\0';
tn(); b(53); ksn(writebuf); tn();
tn(); b(54); ksn(workbuf); tn();
    sprintf(instr, "%s%s", workbuf, writebuf);
tn(); b(59); ksn(workbuf); tn();
  } else {
    /* here writebut is "" */
tn(); b(61); ksn(workbuf); tn();
    workbuf[ strlen(workbuf) - 5] = '\0'; /* "<br>" out (+ sp) */
tn(); b(62); ksn(workbuf); tn();
    sprintf(instr, "%s", workbuf);
  }

}/* end of put_br_every_n() */



#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
/* put "<br>"s in arg1 string so lines are not longer than arg2
*/
void put_br_every_n(char *instr,  int line_not_longer_than_this)
{
  int jj, str_idx;
  char *beg_of_search_string;
  char *p[12];  /* max 12 lines */
  char *pbeg;
  char *pend;
  int  maxlen;
  int  is_first_br = 1;

  strcpy(workbuf, instr);
  maxlen = line_not_longer_than_this;
ksn(workbuf);
kin(maxlen);

  beg_of_search_string = workbuf;

  /* look for a space to the left of char arg2 chars out in arg1 
  */
  strcpy(writebuf, "\0");
  pbeg = &workbuf[0];
ksn(writebuf);
ksn(workbuf);
ksn(pbeg);
  for (jj = maxlen; jj >= 1; jj--) {

    if (pbeg[jj] == ' ') {
kin(jj); ki(pbeg[jj]); ks(&pbeg[jj]);
      pend = &pbeg[jj];
ksn(pend);
      mkstr(s1, pbeg, pend);
ksn(s1);
      pbeg = pend + 1;  /* new pbeg */
ksn(pbeg);

      if (is_first_br == 1)  {
        is_first_br = 0;
        sprintf(writebuf, "%s<br>", s1);
      } else { 
        sprintf(writebuf, "%s<br>%s", writebuf, s1);
      }
ksn(writebuf);
    }
  }
  strcpy(instr, workbuf); 
}  /* end of put_br_every_n(); */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* Build a string starting at "s" using chars from "begarg" to "end"
*  Add '\0' at end.
*/
char *mkstr(char *s,char *begarg,char *end)
{
	char *t;
	char *beg = begarg;
	;
	if (beg >  end) {
      rkabort("Error futhtm.c mkstr() beg > end .\n");
	}
	for (t=s; beg <= end; beg++,t++) *t = *beg;
	*t = '\0';
	return(s);
}	/* end of mkstr() */


/* fill up string s with num chars, where char=c */
/* '\0' goes in (num+1)th position in s, i.e. s[num] */
void sfill(char *s, int num, int c)
{
  int ri;
  ;
  for (ri=0; ri <= num-1; ri++)  *(s+ri) = c;
  *(s+num) = '\0';
}  /* end of sfill() */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   struct mystruc {char arrc[3];};
*   struct mystruc arrs[2];
* /*
*   arrs[0].arrc[0] = "00";
*   arrs[0].arrc[1] = "01";
*   arrs[0].arrc[2] = "02";
* 
*   arrs[1].arrc[0] = "10";
*   arrs[1].arrc[1] = "11";
*   arrs[1].arrc[2] = "12";
* */
* /*  memcpy(arrs, "00\001\002\010\011\012", 18); */
*   strcpy((char *)arrs, "00\001\002\010\011\012");
* 
*   fprintf(stdout,"0.1=%s\n", (arrs)->arrc[1]);
*   fprintf(stdout,"1.2=%s\n", (arrs+1)->arrc[2]);
* 
*   fprintf(stdout,"0.1=%s\n", (*arrs).arrc[1]);
*   fprintf(stdout,"1.2=%s\n", arrs[1].arrc[2]);
* 
*   fprintf(stdout,"0.1=%s\n", arrs[0].arrc[1]);
*   fprintf(stdout,"1.2=%s\n", arrs[1].arrc[2]);
* 
* /* ============================================== */
*   struct mystruct {int arri[3];};
*   struct mystruct arrst[2];
* 
*   arrst[0].arri[0] = 1;
*   arrst[0].arri[1] = 2;
*   arrst[0].arri[2] = 3;
* 
*   arrst[1].arri[0] = 2;
*   arrst[1].arri[1] = 4;
*   arrst[1].arri[2] = 6;
* 
*   fprintf(stdout,"0.1=%d\n", (arrst)->arri[1]);
*   fprintf(stdout,"1.2=%d\n", (arrst+1)->arri[2]);
* 
*   fprintf(stdout,"0.1=%d\n", (*arrst).arri[1]);
*   fprintf(stdout,"1.2=%d\n", arrst[1].arri[2]);
* 
*   fprintf(stdout,"0.1=%d\n", arrst[0].arri[1]);
*   fprintf(stdout,"1.2=%d\n", arrst[1].arri[2]);
* 
*   return(0);
* 
* 
* /* clock ticks (1 = .0549 seconds) */
* long ticks;    /* clock ticks */
* 
* 
* 	while (1) {
* 		printf("Enter string: ");
* 		if (gets(wk) == NULL) break;
* 		sprintf(buf, "[%013x]\n",atoi(wk));
* 		printf("[%s]",buf);
* 	}
* 
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/


/* commafy_int()  takes integer "intnum", formats it right-justified
*  starting at ptr "dest" in a field of "sizeofs"
*/
void commafy_int(char *dest, long intnum, int sizeofs)
{
    char wkstr[64];                 /* hold digits int "intnum" */
    char *digits;                   /* pointer to current digit */
    char fmt[64];
    int n;              /* digit pointer (goes backwards) */
    int ctr;            /* digit counter (forwards) */
    int place;          /* current char num in dest */
    ;
    sprintf(wkstr,"%ld",intnum);
    digits = &wkstr[strlen(wkstr)-1];

    sprintf(fmt,"%%%ds",sizeofs);
    sprintf(dest,fmt," ");
    for (ctr=1, n=strlen(wkstr), place=sizeofs-1;   n >= 1;   n--, digits--, ctr++,place--) {
        dest[place] = *digits;
        if (ctr % 3 == 0  &&  n != 1) {
            place--;
            dest[place] = ',';
        }
    }
    if (dest[place+1] == ',') dest[place+1] = ' ';
    if (dest[place+1] == '-'  &&  dest[place+2] == ',') {
        dest[place+1] = ' ';
        dest[place+2] = '-';
    }
}    /* end of commafy_int() */


#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* OLD STRSUBG
* /* strsbug    on str s (max 512) does  :s/replace_me/with_me/g
* */
* void strsubg(char *s, char *replace_me, char *with_me)
* {
*   char final_result[2048], wkbuf[2048], buf2[2048], save_s[2048], done_so_far[2048];
*   char *p;
*  
*   strcpy(save_s, s);
*   strcpy(done_so_far, "");
*   strcpy(wkbuf, s);
*   strcpy(final_result, "");
* 
*   while (1) {
*     p = strstr(wkbuf, replace_me);
* tn();b(1);ks(p);
*     if (p == NULL) {
*       strcat(final_result, wkbuf); /* put rest of wkbuf into final_result */
*       strcat(done_so_far, wkbuf); 
* tn();b(2);ks(final_result);
* tn();b(2);ks(done_so_far);
*       strcpy(s, final_result);
* tn();b(3);ks(s);
*       break;  
*     } else {
*       if (p == wkbuf) {  /* str starts with " X" */
*         strcat(final_result, with_me); /* append "with_me" */
*         strcat(done_so_far, replace_me); 
* tn();b(10);ks(final_result);
* tn();b(10);ks(done_so_far);
*         /* point wkbuf at rest of s */
*         strcpy(wkbuf, wkbuf + strlen(replace_me));
* tn();b(11);ks(wkbuf);
*         continue;
*       }
*       mkstr(buf2, wkbuf, p-1);  /* grab intermediate stuff in buf2 */
* 
*       /* append the stuff before "replace_me"
*       */
*       strcat(final_result, buf2);
*       strcat(done_so_far, buf2); 
* tn();b(5);ks(final_result);
* tn();b(5);ks(done_so_far);
*       /* append "with_me"
*       */
*       strcat(final_result, with_me);
*       strcat(done_so_far, replace_me); 
* tn();b(6);ks(final_result);
* tn();b(6);ks(done_so_far);
* 
*       /* are we finished ? */
*       if (strcmp(done_so_far, save_s) == 0) break;
* 
*       /* point wkbuf at rest of s
*       */
* /*       strcpy(wkbuf, wkbuf + strlen(done_so_far)); */
*       strcpy(wkbuf, save_s + strlen(done_so_far));
* tn();b(7);ks(wkbuf);
*     }
*   }
*   strcpy(s, final_result);
*   return;
* } /* end of  strsubg() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

/* end of rktest.c */
