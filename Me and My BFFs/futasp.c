/* futasp.c */
/* aspect part of fut.o */

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "futdefs.h"

/* #include "rkdebug2.h"  */
/* #include "rkdebug_externs.h" */

extern void f_docin_put(char *line, int length);

/* in mambutil.o */
extern void  strsort(char *v[], int n);
extern char *sfromto(char *dest,char *src, int beg, int end);
extern void  sfill(char *s, int num, int c);
extern int   sall(char *s,char *set);
/* in mambutil.o */


/* externs follow */
extern struct Runrec Rt[];  /* rt=running_table */
extern int Aspect_type[];

extern int get_house(int minutes, int mc);  /* defined in another .o */
extern int get_minutes(double d);


/* aspect_type  0=cnj, 1=good, 2=bad (subscripts into aspect_multipier[]) */

/* start date for this grh */
/* int Grh_beg_mn, Grh_beg_dy, Grh_beg_yr;  */
extern int Grh_beg_mn;
extern int Grh_beg_dy;
extern int Grh_beg_yr; 
extern int Eph_rec_every_x_days;  /* [2] from eph file ctrl rec */
extern FILE *Fp_docin_file;
extern char *N_long_mth[];
extern char *N_short_nat_plt[];
extern char *N_short_trn_plt[];
extern char *N_short_doc_aspect[];
extern int Num_eph_grh_pts;
extern char *N_trn_planet[];
extern char *N_planet[];
extern char *N_sign[];
extern char *N_aspect[];
extern char *N_mth[];
extern struct Futureposrec *Eph_buf; /* ptr to current buffer for /eph file */
extern int Ar_minutes_natal[];  /* +1 for [0], +3 for nod asc mc */
extern double Arco[];  /* one of 2 tables returned from calc_chart */
extern char Swk[];
/* end of externs */


/* following is local to this source file */

/* #define MAX_IN_ASP_TBL 50 */
#define MAX_IN_ASP_TBL 1024

#define SIZE_ASP_REC 26

char Asp_tbl[MAX_IN_ASP_TBL*(SIZE_ASP_REC+1)];
char *P_asp_tbl[MAX_IN_ASP_TBL];  /* ptrs to above tbl */
int Asp_tbl_idx;  /* idx to the last element in the table (not a count) */

char wk1[512];  /* for do_a_para() fix for f_docin_put */
char wk2[512];  /* for do_a_para() fix for f_docin_put */
char wk3[512];  /* for do_a_para() fix for f_docin_put */
char wk4[512];  /* for do_a_para() fix for f_docin_put */


/*****************  more on do_running_table()
*
*   aspect?  y->  startthere?  y->  lastday?  y->  dspl_aspect()  -  end
*     |      |          |
*     |      |          end
*     |    lastday?  y-> end 
*     |      |            (ignore aspects beginning 
*     |    putstart()     on last day)
*     |      |
*     |      end
*     |
*   startthere?  y->  dspl_aspect()  -  end
*     |
*     end
*
*/
void do_rt(int nat_plt, int aspect_num, int trn_plt, int day_num)
{
/* 24,000 trn("do_rt(int nat_plt, int aspect_num, int trn_plt, int day_num)"); */

  if (nat_plt <  IDX_FOR_NAT_SUN  || nat_plt >  IDX_FOR_NAT_MAR)
    return;
  if (trn_plt <  IDX_FOR_TRN_JUP  || trn_plt >  IDX_FOR_TRN_PLU)
    return;    /* don't record unless nat 1-5, trn 1-5 */ 

  if (aspect_num != 0)    /* aspect? */
  {
    if(Rt[nat_plt].from_date.mn != 0)      /* start of aspect there? */ 
    {
      if (day_num == Num_eph_grh_pts)    /* last day? */
        dspl_aspect(nat_plt,trn_plt,day_num+1);
      
    } else {

      if (day_num == Num_eph_grh_pts) return;/* last day? */
      put_start_of_aspect(day_num,nat_plt,aspect_num,trn_plt);
    }
    return;

  } else {

    if(Rt[nat_plt].from_date.mn != 0)  /* start of aspect there? */ 
      dspl_aspect(nat_plt,trn_plt,day_num);
    return;
  }
}  /* end of do_rt */

void put_start_of_aspect(int day_num, int nat_plt, int aspect_num, int trn_plt)
{
            /* assumption: nat 1-5, trn 1-5 */ 
  double dy,mn,yr,step;
  ;
  Rt[nat_plt].aspect_id = aspect_num;
  mn = (double)Grh_beg_mn;  /* calc from_date from day_num */
  dy = (double)Grh_beg_dy;
  yr = (double)Grh_beg_yr;
  if(trn_plt == 6) day_num++;  /* this is a mystery. 6=mars */
    /* ^why does this old comment say 6=mars. new: it's ok (jsunpm) */
  step = (double)((day_num-1) * Eph_rec_every_x_days);
  mk_new_date(&mn,&dy,&yr,step);
  Rt[nat_plt].from_date.mn = (int)mn;
  Rt[nat_plt].from_date.dy = (int)dy;
  Rt[nat_plt].from_date.yr = (int)yr;
}  /* end of put_start_of_aspect() */

/* writes asp to array strings */ 
/* format 26 char: from_date 1-8 yyyymmdd, nat 9-10, trn 11,12, asp 13,14 */
/*     to_date 15-22 yyyymmdd, nat_hse 23-24, trn_hse 25,26 */
void dspl_aspect(int np, int tp, int dn)
{
  int asp,np_hse,tp_hse,fy,fm,fd,ty,tm,td;
  ;
  asp = Rt[np].aspect_id;
  np_hse = get_house(Ar_minutes_natal[np],get_minutes(Arco[13]));/*13=mc*/
  if (dn == Num_eph_grh_pts) --dn;  /* last day? */
  tp_hse = get_house((Eph_buf+dn)->positions[tp],get_minutes(Arco[13]));
  if (dn == Num_eph_grh_pts) ++dn;  /* last day? */
  fy = Rt[np].from_date.yr;
  fm = Rt[np].from_date.mn;
  fd = Rt[np].from_date.dy;
  put_start_of_aspect(dn-1,np,0,tp);  /* sets up to_date */
  ty = Rt[np].from_date.yr;
  tm = Rt[np].from_date.mn;
  td = Rt[np].from_date.dy;
  zero_runrec(np);
  ++Asp_tbl_idx;  /* init=-1 */
  sprintf(P_asp_tbl[Asp_tbl_idx],
    "%04d%02d%02d%02d%02d%02d%04d%02d%02d%02d%02d",
    fy,fm,fd,np,tp,asp,ty,tm,td,np_hse,tp_hse);
}  /* end of dspl_aspect() */

void zero_runrec(int nat_plt)
{
  Rt[nat_plt].aspect_id = 0;
  Rt[nat_plt].from_date.mn = 0;
  Rt[nat_plt].from_date.dy = 0;
  Rt[nat_plt].from_date.yr = 0;
}  /* end of zero_runrec() */


void init_rt(void)
{
  int i;
  ;
  for (i=0; i <= MAX_IN_ASP_TBL-1; ++i) {
    P_asp_tbl[i] = &Asp_tbl[i*(SIZE_ASP_REC+1)];
  }
  Asp_tbl_idx = -1;  /* ++ before use as subscript to write str */
}  /* end of init_rt() */

/**** for db */
void prt_asp_tbl(void)
{
  int i;
  ;
  for (i=0; i <= MAX_IN_ASP_TBL-1; ++i) {
    fprintf(stdout,"%s\n",P_asp_tbl[i]);
  }
}  /* end of prt_asp_tbl() */



/* version in mambutil.o uses array for v, not this ptr
*/
#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
* /* sort strings v[0] ... v[n-1]  into increasing order
*  */
* void strsort(char *p[], int n)
* {
*   int j,gap,i;
*   char *temp;
*   char **v = p;
*   ;
*   for (gap=n/2; gap >  0; gap /=2) {
*     for (i=gap; i <  n; i++) {
*       for (j=i-gap; j >= 0; j-=gap) {
*         if (strcmp(*(v+j),*(v+j+gap)) <= 0) break;
*           temp = *(v+j);
*           *(v+j) = *(v+j+gap);
*           *(v+j+gap) = temp;
*       }
*     }
*   }
* }  /* end of strsort() */
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

void do_paras(void)
{
  int is_done[MAX_IN_ASP_TBL],i,k,m;
  char s1[6+1],s2[6+1];  /* 6-char keys (nat,trn,asp) */
  char *do_me;
  char *do_also[NUM_POSSIBLE_INSTANCES_PER_ASP-1];
  int n;
  char *p = &Swk[0];
  ;
/* trn("in do_paras() "); */
  n = sprintf(p,"\n\n[beg_aspects]\n"); 
  f_docin_put(p,n);

  strsort(P_asp_tbl,Asp_tbl_idx+1);    /* sort by fromdate */
  for (i=0; i <= MAX_IN_ASP_TBL-1; ++i) is_done[i] = 0;
  for (i=0; i <= Asp_tbl_idx; ++i) {  /*no -1(idx pts to last element) */
    do_also[0] = NULL;  do_also[1] = NULL;
    if (is_done[i]) continue;
    do_me = P_asp_tbl[i];    /* found asp to do */ 
    is_done[i] = 1;
    sfromto(s1,P_asp_tbl[i],9,14);  /* key for this asp */
    for (m=0, k=i+1; k <= Asp_tbl_idx; ++k) {  /* find all sames */

      sfromto(s2,P_asp_tbl[k],9,14);

      if(strcmp(s1,s2) != 0) continue;  /* keep looking for sames */
      do_also[m] = P_asp_tbl[k];      /* found a same */
      ++m;
      is_done[k] = 1;
    }
    do_a_para(do_me,do_also[0],do_also[1]);
  }

  n = sprintf(p,"[end_aspects]\n"); 
  f_docin_put(p,n);

}  /* end of do_paras() */

void do_a_para(char *first, char *other1, char *other2)
{
/* trn("in do_a_para()   QQQQQQQQQQQQQQQQ "); */
  char *line[NUM_POSSIBLE_INSTANCES_PER_ASP];
  char s[4+1];
  int i,yr,mn,dy,nat,transiting,asp;
  int n;
  char mywork[512];
  char mywork2[512];
  ;
  line[0] = first;  line[1] = other1;  line[2] = other2;

  strcpy(mywork,  "");
  strcpy(mywork2, "");

  for (i=0; i <= NUM_POSSIBLE_INSTANCES_PER_ASP-1; ++i) {
    if (line[i] == NULL) break;
    yr = atoi(sfromto(s,line[i],1,4));
    mn = atoi(sfromto(s,line[i],5,6));
    dy = atoi(sfromto(s,line[i],7,8));


    /* Collect these 4 f_docin_puts into 1 string and f_docin_put that 
    *  at the end.
    */
    n = sprintf(wk1,"%s%s %d, %d",
      (i == 0)? "  From ":" and also from ",
      N_long_mth[mn],dy,yr
    );

    /* append this to the end of mywork
    */
    sprintf(mywork2, "%s%s", mywork, wk1);   
    strcpy(mywork, mywork2);

    yr = atoi(sfromto(s,line[i],15,18));
    mn = atoi(sfromto(s,line[i],19,20));
    dy = atoi(sfromto(s,line[i],21,22));
    n = sprintf(wk2," to %s %d, %d",
      N_long_mth[mn],dy,yr
    );

    /* append this to the end of mywork
    */
    sprintf(mywork2, "%s%s", mywork, wk2);   
    strcpy(mywork, mywork2);
  }

  n = sprintf(wk3,".  ");

  /* append this to the end of mywork
  */
  sprintf(mywork2, "%s%s", mywork, wk3);   
  strcpy(mywork, mywork2);

  nat = atoi(sfromto(s,line[0],9,10));  /* [0] has info for sure */
  transiting = atoi(sfromto(s,line[0],11,12));
  asp = atoi(sfromto(s,line[0],13,14));

  n = sprintf(wk4,"^(%s%s%s)\n",
    N_short_nat_plt[nat],
    N_short_doc_aspect[Aspect_type[asp]],
    N_short_trn_plt[transiting]
  );

  /* append this to the end of mywork
  */
  sprintf(mywork2, "%s%s", mywork, wk4);   
  strcpy(mywork, mywork2);

  n = sprintf(mywork, "%s\n", mywork);
  f_docin_put(mywork, n);

}  /* end of do_a_para() */


/* mk_new_date.c */
/* calculates new date as below */

extern double Day_tab[][13];

/* add dstep days to previous date  mn/dy/yr
 */
void mk_new_date(double *pm, double *pd, double *py, double dstep)  
{
  int i,leap,retvalnewdate;
  double temp,jd;    /* jd julian date */
  double prev_year_num_days;    /* jd julian date */
  double prev_year_jd;    /* jd julian date */
  ;
  retvalnewdate = isinnewyear(*py, *pm, *pd, dstep);
//kin(retvalnewdate );
  if (retvalnewdate == 999) {  // new date  is in same year as arg year
    temp = day_of_year(*py, *pm, *pd);  /* julian day */
    month_day(*py, temp + dstep, pm, pd);  /* get mn dy, yr  for jd in year *py */
    return;
  }
  else if (retvalnewdate == 1) {  // in future  year
    jd = day_of_year(*py, *pm, *pd) + dstep;  /* (here, this julian date  is > 365 (or 364) */

    while (isinnewyear(*py, *pm, *pd, dstep) == 1) {

      i = (int)*py;  /* is the arg starting year  leap? */
      leap = (i%4 == 0 && i%100) != 0 || i%400 == 0;

      jd -= Day_tab[leap][0];    /* jd in the new year (or subsequent yr) */
                                 /* Day_tab[leap][0] is 364 or 365 depending on leap */
      dstep = jd;  *py += 1.0;  *pm = 1.0;  *pd = 0.0;
        /* 01Jan of new year (0 for month_day()) */
    }

    month_day(*py, jd, pm, pd);  /* get mn, dy  for jd in year *py,  */
    return;
  }
  else { // (retvalnewdate is 0 or negative)  new date is in past   year
    // this assumes new date is in arg year minus ONE
//tn();trn("in PreV YEAR!");
    // get  prev_year_num_days
    //
    i = (int) ( *py - 1) ;  /* is the arg starting year  leap? */
    leap = (i%4 == 0 && i%100) != 0 || i%400 == 0;
    prev_year_num_days = Day_tab[leap][0]; /* Day_tab[leap][0] is 364 or 365 depending on leap */
    prev_year_jd = prev_year_num_days - retvalnewdate;
               /* returns  num days to subtract from num days in prev year  if new date ymd is in past year */
    *py = *py - 1;
    month_day(*py, prev_year_jd, pm, pd);  /* get mn, dy  for jd in year *py,  */
    return;
  }


}  /* end of mk_new_date() */

/* is date + step in new year? */
             /* NO  returns 1 if yes, 0 if in this year */
/* returns  num days to subtract from num days in prev year  if new date ymd is in past year 
*  returns  1  if new date ymd is in future year
*  returns  0  if new date ymd is in same   year
*/
int isinnewyear(double y, double m, double d, double step) 
{
//tn();trn(" int isinnewyear(double y, double m, double d, double step) ");
//tn();kd(y);kd(m);kd(d);
  int i,leap;
  double temp;
  ;
  i = (int)y;
  leap = (i%4 == 0 && i%100) != 0 || i%400 == 0;
  temp = day_of_year(y,m,d) + step;

  if ( temp >  Day_tab[leap][0]) {  // [0] is num days in year (365 or 366)
    return (1);   // new date is in future year
  } 

  if ( temp <  1 ) {            // added 20150406  (backward for what color report)
    // here, temp could be 0, meaning new date is last day in prev year
    return (temp);  // (retval is 0 or negative)  new date is in past   year
  } 

  return(999);    // new date is in same   year
 
}  

/* return jd in year from  month & day */
double day_of_year(double year, double month, double day)
{
  int leap;
  int ri;
  ;
  ri = (int)year;
  leap = (ri%4 == 0 && ri%100) != 0 || ri%400 == 0;
  for (ri=1; ri <  month; ++ri) day += Day_tab[leap][ri];
  return(day);
}  /* end of day_of_year() */

/* set month, day  for jd=yearday in year */
void month_day(double year, double yearday, double *pmonth, double *pday)
{
  int leap;
  int ri;
  ;
  ri = (int)year;
  leap = (ri%4 == 0 && ri%100) != 0 || ri%400 == 0;
  for (ri=1; yearday  > Day_tab[leap][ri]; ++ri) 
    yearday -= Day_tab[leap][ri];
  *pmonth = (double)ri;
  *pday = yearday;
}  /* end of month_day() */


/* end of futasp.c */
