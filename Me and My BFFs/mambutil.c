/* mambutil.c */

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

#include "incocoa.h"
#include "rkdebug_externs.h"

/* #include "rk.h" */

/* calc_chart() is a subroutine for calculating
* planetary positions and retrograde
*/ 

#include <math.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define PENDSTR(s) (&(s)[strlen((s))-1])


//extern int gbl_nkeys_place;  /* in incocoa.h */
//extern struct my_place_fields {
//  char *my_city;
//  int  idx_prov;
//  int  idx_coun;
//  char *my_long;
//  char *my_hrs_diff;
//} gbl_placetab[];


int mapAVGbenchmarkNumToPctlRank(int in_score);
int mapBenchmarkNumToPctlRank(int benchmark_num);
int mapNumStarsToBenchmarkNum(int category, int num_stars);

int calc_percentile_rank(int in_score, int sc_hi, int sc_lo, int pr_hi, int pr_lo);

/* called from perdoc.c, futdoc.c, grpdoc.c */
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
int  snone(char *s,char *set);
void scharswitch(char *s, char ch_old, char ch_new);
void strsort(char *v[], int n);
char *sfromto(char *dest,char *src, int beg, int end);
void sfill(char *s, int num, int c);
int  sall(char *s,char *set);
char *mkstr(char *s,char *begarg,char *end);
void scharout(char *s,int c);
int  scharcnt(char *s, int c);
void put_br_every_n(char *instr, int line_not_longer_than_this);
void fn_right_pad_with_hidden(char *s_to_pad, int num_to_pad);
void commafy_int(char *dest, long intnum, int sizeofs);
char *strim(char *s, char *set);
char *rkstrrchr(char *s, char c);
char *swholenum(char *t, char *s);
char *sdecnum(char *t, char *s);
int  sfind(char s[], char c);
char *scapwords(char *s);
void strsubg(char *s, char *replace_me, char *with_me);
int  day_of_week(int month, int day, int year);
int  strcmp_ignorecase(char *s1, char *s2);
int  bin_find_first_in_array(    /* ABANDONED seq is fast enough */
  char **array_of_strings,
  char *find_begins_with,
  int num_elements
);



int bin_find_first_city1 (char *begins_with); /* bin_find_first_city1  returns index of first city in gbl_placetab[] */
int bin_find_first_city(
  char  *begins_with,
  int    numCitiesToGetPicklist,
  int   *arg_numCitiesFound,
  char  *city_prov_coun_PSVs // ptr to beginning of fixed length PSVs

); /* in gbl_placetab[] */
        /* bin_find_first_city  Uses binary  search  in gbl_placetab[] structs
        *  to find first city that "begins_with" arg.
        *  RETURN VALUE is
        *     1. index that is lowest_hit_so_far IF there are too many cities for picklist (numCitiesToGetPicklist)
        *     2. -1  IF no city  starts with arg "city_begins_with"
        *     3. -2  IF there are few enough cities to make a picklist
        *  also returns num cities found
        *  also returns array of chars holding city,prov,coun PSVs
        */



void bracket_string_of(
  char *any_of_these,
  char *in_string,   
  char *left_bracket,
  char *right_bracket  );
void seq_find_exact_citPrvCountry(char *retDiffLong, char *psvCity, char *psvProv, char *psvCountry);
void domap(char *str_to_map, int whichnum, char *map_or_unmap);



#define IDX_FOR_BEST_YEAR 90
#define IDX_FOR_MYSTERIOUS 91
#define IDX_FOR_BEST_DAY 92
#define IDX_FOR_UPS_AND_DOWNS_2 93 /* fix 201311 */
#define IDX_FOR_SCORE_B 95   /* best day 2nd iteration */
/* #define IDX_FOR_AVG_COMPATIBILITY 96  */

#define IDX_FOR_AGGRESSIVE 12
#define IDX_FOR_SENSITIVE 13
#define IDX_FOR_DOWN_TO_EARTH 14
#define IDX_FOR_RESTLESS 15
#define IDX_FOR_SEX_DRIVE 16
#define IDX_FOR_BIG_MOUTH 17
#define IDX_FOR_UPS_AND_DOWNS 18



struct aspect {
  char *asp_code;
  char *asp_text;
};
int binsearch_asp(char *asp_code, struct aspect tab[], int num_elements); 

struct cached_person_positions {
  char person_name[20]; /* max 15 may 2013 */
  int  minutes_natal[14];
};
int binsearch_person_in_cache(
  char *person_name,
  struct cached_person_positions tab[],
  int num_elements
);

char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);
/* called from perdoc.c, futdoc.c, grpdoc.c */


void calc_chart(double mnarg, double dyarg, double yrarg,
    double hrarg, double muarg, int aparg,
    double tzarg, double lnarg, double ltarg);



double sgn(double xrk);   
double fnr(double xrk);   /* degrees to radians */
double fns(double xrk);   /* sin(xrk), xrk in degrees */
double fnp(double xrk);   /* sec to deg within 360 */
double fnd(double xrk);   /* radians to degrees */
double fnu(double xrk);   /* finds angle within 360 */
double fnq(double xrk);   /* dd.mm to dd.decimal format */
double fnco(double xrk);  /* cos(xrk), xrk in degrees */

double get_element(void);
void time_calc(void); 
void asc_mc_calc(void );  /* asc, mc calc  (+ misc) */
void coordinate_transform(void );  /* coordinate transformation */
void assemble_orbital_elements(void );  /* assembles orbital elements */
void polar_to_rect(void );  /* polar to rectangular coordinates */
void rect_to_polar(void );  /* rectangular to polar coordinates */
void get_harm_for_outer(void );  /* get harmonic terms for outer planets */
void do_moon(void );    /* moon & moon's node */


/* extern double atof(); */

/* R if retrograde, _ if not */
/* char *Retro[] = { 
*     "x",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_",
*     "_"
* };
*/
char Retro[14][3]; /* "R" if retrograde, "_" if not */

static double a,ac,an,au,bq,cq,c1,d,dd,df,dy,ea,ec,f,fd,ff,g,hr,jd,jx,jz,l,la,ld;
static double ln,lt,lw,lx,m,mb,mc,ml,mn,mr,mu,n0,n1,n2,n3,n4,n5,n6,n7,n8,nd;
static double nu,ob,oe,pi,q,r,r1,r2,r4,r5,ra,rd,rx,s,s1,s2,t,t2,tnq,tz,u;

/* changed y1 to y1b (y1 defined in math.h) */
static double v,vt,w,x,x1,xl,xs,xx,y,y1b,yd,yr,yy,z,z1,zz;

static double pi_div180, temp;
static int ic, ij, ik, jl, ap, indexx;

double Arco[14];    /* `coordinates' are in following order: */
      /* xxx,sun,mer,ven,mar,jup,sat,ura,nep,plu,moo,nod,asc,mc_ */
  /* index 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13 */
static int ark[10];    /* controls access to the variable number of */
            /* harmonic terms for outer planets */
static double art[4];  /* holds 3 return values for harmonic term routine */

static char *elements[393] =
{
"358.4758445","35999.04975","-.150278e-3",".01675104","-.418e-4","-.126e-6",
"1.00000023","101.2208333","1.719175",".000452778",
"0.0","0.0","0.0","0.0","0.0","0.0",
/***
end of sun
***/
"102.2793806","149472.5152",".6389e-5",".20561421",".2046e-4","-.3e-7",
".3870984","28.75375278",".370280556",".000120833","47.14594444",
"1.185208333",".000173889","7.002880556",".001860833","-.18333e-4",
/***
end of mercury
***/
"212.6032194","58517.80386",".001286056",".00682069",
"-.4774e-4",".91e-7",".7233316","54.38418611",".508186111","-.1386389e-2",
"75.77964722",".89985",".41e-3","3.393630556",".1005833e-2","-.972e-6",
/***
end of venus
***/
"319.529425","19139.8585",".180806e-3",".0933129",".92064e-4","-.77e-7",
"1.5236915","285.4317611","1.069766667",".13125e-3","48.78644167",
".770991667","-1.389e-5","1.850333333","-.675e-3",".12611e-4",
/***
end of mars
***/
"225.4928125","3033.687936","0.0",".04838144","-.155e-4","0.0",
"5.20290493","273.3930152","1.33834464","0.0","99.41984827","1.05829152",
"0.0","1.3096585","-.515613e-2","0.0",
/***
end of jup
***/
"-.001","-.0005",".0045",".0051","581.7","-9.7","-.0005","2510.7","-12.5",
"-.0026","1313.7","-61.4",".0013","2370.79","-24.6","-.0013","3599.3","37.7",
"-.001","2574.7","31.4","-.00096","6708.2","-114.5","-.0006","5499.4","-74.97",
"-.0013","1419.0","54.2",".0006","6339.3","-109.0",".0007","4824.5","-50.9",
".0020","-.0134",".0127","-.0023","676.2",".9",".00045","2361.4","174.9",
".0015","1427.5","-188.8",".0006","2110.1","153.6",".0014","3606.8","-57.7",
"-.0017","2540.2","121.7","-.00099","6704.8","-22.3","-.0006","5480.2","24.5",
".00096","1651.3","-118.3",".0006","6310.8","-4.8",".0007","4826.6","36.2",
/***
end of jup harm
***/
"174.2152960","1223.507963","0.0",".05422831","-.20495e-3","0.0","9.55251745",
"338.911673","-.31667941","0.0","112.8261394",".82587569","0.0","2.49080547",
"-.00466035","0.0",
/***
end of sat
***/
"-.0009",".0037","0.0",".0134","1238.9","-16.4","-.00426","3040.9","-25.2",
".0064","1835.3","36.1","-.0153","610.8","-44.2","-.0015","2480.5","-69.4",
"-.0014",".0026","0.0",".0111","1242.2","78.3","-.0045","3034.96","62.8",
"-.0066","1829.2","-51.5","-.0078","640.6","24.2","-.0016","2363.4","-141.4",
".0006","-.0002","0.0","-.0005","1251.1","43.7",".0005","622.8","13.7",".0003",
"1824.7","-71.1",".0001","2997.1","78.2",
/***
end of sat harm
***/
"74.17574887","427.2742717","0.0",".04681664",
".00041875","0.0","19.22150505","95.68630387","2.05082548","0.0",
"73.52220082",".52415598","0.0",".77256652",".12824e-3","0.0",
/***
end of uranus
***/
"-.0021","-.0159","0.0",".0299","422.3","-17.7","-.0049","3035.1","-31.3",
"-.0038","945.3","60.1","-.0023","1227.0","-4.99",".0134","-.02186","0.0",
".0317","404.3","81.9","-.00495","3037.9","57.3",".004","993.5","-54.4",
"-.0018","1249.4","79.2","-.0003",".0005","0.0",".0005","352.5","-54.99",
".0001","3027.5","54.2","-.0001","1150.3","-88.0",
/***
end of ur harm
***/
"30.1329437","240.4551595","0.0",".00912805","-.00127185","0.0","30.1137593",
"284.168255","-21.6328615","0.0","130.6841531","1.10046492","0.0","1.77939281",
"-.00975088","0.0",
/***
end of neptune
***/
".1832","-.6718",".2726","-.1923","175.7","31.8",".0122","542.1","189.6",
".0027","1219.4","178.1","-.00496","3035.6","-31.3","-.1122",".166","-.0544",
"-.00496","3035.3","58.7",".0961","177.1","-68.8","-.0073","630.9","51.0",
"-.0025","1236.6","78.0",".00196","-.0119",".0111",".0001","3049.3","44.2",
"-.0002","893.9","48.5",".00007","1416.5","-25.2",
/***
end of neptune harm
***/
"229.7810007","145.1781092","0.0",".24797376",".00289875","0.0","39.53903455",
"113.5365761",".20863761","0.0","108.94405","1.37395444","0.0","17.15140319",
"-.01611824","0.0",
/***
end of pluto
***/
"-.0426",".073","-.029",".0371","372.0","-331.3","-.0049","3049.6","-39.2",
"-.0108","566.2","318.3",".0003","1746.5","-238.3","-.0603",".5002","-.6126",
".049","273.97","89.97","-.0049","3030.6","61.3",".0027","1075.3","-28.1",
"-.0007","1402.3","20.3",".0145","-.0928",".1195",".0117","302.6","-77.3",
".00198","528.1","48.6","-.0002","1000.4","-46.1"
/***
end of pluto harm
***/
};

/*
*   The above elements are 
*   grouped as follows: 
*                       
*   sun elements       
*   mercury elements    
*   venus elements       
*   mars elements       
*   jupiter elements     
*   jupiter harmonic terms
*   saturn elements     
*   saturn harmonic terms
*   uranus elements     
*   uranus harmonic terms   
*   neptune elements     
*   neptune harmonic terms   
*   pluto elements      
*   pluto harmonic terms   
*/



/* new functions */

double sgn(double xrk)    /* mimics applesoft function */
{
  double tmp_double = 0.0;
  if(xrk >  0.0) tmp_double =  1.0;
  if(xrk <  0.0) tmp_double = -1.0;
  if(xrk == 0.0) tmp_double =  0.0;
  return tmp_double;
} 


double fnr(double xrk)   /* degrees to radians */
{
  return(xrk*pi_div180);
}

double fns(double xrk)   /* sin(xrk), xrk in degrees */
{
  return(sin(xrk*pi_div180));
}

double fnp(double xrk)   /* sec to deg within 360 */
{
  return(sgn(xrk)*((fabs(xrk)/m)/360.0 - floor((fabs(xrk)/m)/360.0))*360.0);
}  

double fnd(double xrk)  /* radians to degrees */
{
  return(xrk*180.0/pi);
}

double fnu(double xrk)  /* finds angle within 360 */
{
  return(xrk - (floor(xrk/360.0)*360.0));
}

double fnq(double xrk)  /* dd.mm to dd.decimal format */
{
  if(xrk == 0.0) return(0.0);
  return(sgn(xrk)*(floor(fabs(xrk)) + (fabs(xrk) - floor(fabs(xrk)))*100.0/60.0));
}

double fnco(double xrk)  /* cos(xrk), xrk in degrees */
{
  return(cos(xrk*pi_div180));
}

double get_element(void)
{
  return( atof(elements[++indexx]) );
}  /* end of get_element */


void calc_chart(double mnarg, double dyarg, double yrarg,
    double hrarg, double muarg, int aparg,
    double tzarg, double lnarg, double ltarg)
{
  int iretro;
/* trn("in calc_chart()"); */

  /* 20130826  INITIALIZE Retro indicator array each time thru 
  *  (to "_" = non-retrograde)
  */
  for (iretro = 0; iretro <=13; iretro++) strcpy(Retro[iretro], "_"); 

  /* tn(); for(iretro=1;iretro<=13;iretro++) ks(Retro[iretro]); */

  mn = mnarg;
  dy = dyarg;
  yr = yrarg;
  hr = hrarg;
  if (hr == 12.0) hr = 0.0; /* hr of 12 must be 0 for here */
  mu = muarg;  /* get event specs */
  ap = aparg;
  tz = tzarg;
  ln = lnarg;
  lt = ltarg;
  t2 = 0.0;
  indexx = -1;
  pi= 3.1415926535897932384;
  pi_div180 = pi/180.0;    /* initialize */
  x = 0.0;
  y = 0.0;
  t = 0.0;
  s = 0.0;
  a = 0.0;
  r = 0.0;
  ij = 0;
  ik = 0;  /*  */
  for (jl = 0; jl <= 13; jl = jl+1) Arco[jl] = 0.0;      /*  */
      /* time and angle calc */
  if (ap == 1) {
    temp  =  1.0; /* temp avoids the 12.0*(ap =  = 1) construct below */
  }
  if (ap != 1) temp = 0.0;
  rx = 0.0;
  f =  fnq(hr + (mu/100.0)) + tz + 12.0*temp;
  la =  fnr(fnq(lt));
  time_calc();
  r2 = ra;
  ob = -oe;
    /* ap = 0,am ap = 1,pm ap = 2,hr = 12 ifhr = 12,mu = 0&ap = 2  ??  */
  if (ap != 2) {
    bq = la;
    asc_mc_calc();
  }
  if (ap == 2) {
    mr = 0.0;
    mc = 0.0;
    ac = 0.0;
    vt = 0.0;
  }
  for (ic = 1;  ic <= 11;  ic = ic+1) {    /* main loop thru planets */
    if (ic == 10) {
      do_moon();
      Arco[ic] = g;
      continue;
    } /* moon */
    if (ic == 11) {
      g = tnq;
      a = 0.0;
      Arco[ic] = g;
      continue;
    } /* true lunar node */
        /*   mean anomaly & eccentricity (in radians) */
    assemble_orbital_elements();
    m =  fnr(fnu(s)); 
    assemble_orbital_elements();
    ec = s;
        /* solve kepler's equation for */
    ea = m;  /* eccentric anomaly by iteration */
    for (a = 1;  a <= 5;  a = a+1) {
      ea = m + ec*sin(ea);
    }
        /* perifocal coordinates */
    au = get_element();
    temp  =  1.0 - ec*ec;
    x = au*( cos(ea) - ec);
    y = au*sin(ea)*pow(temp, 0.5);
        /* rotate through classical orientation angle */
    rect_to_polar();
    assemble_orbital_elements(); 
    a = a +  fnr(s);
    polar_to_rect();
    d = x;
    x = y;
    y = 0.0;
    rect_to_polar();
    assemble_orbital_elements(); 
    an =  fnr(s);
    assemble_orbital_elements();
    a = a + fnr(s);
    polar_to_rect();
    g = y;
    y = x;
    x = d;
    rect_to_polar();
    a = a + an;
    if (a <  0.0) {
      /* convert helio rectangular to helio spherical coords. */
      a = a + 2.0*pi;
    }
    polar_to_rect();
    xx = x;
    yy = y;
    zz = g;  
    if (ic <  5) {
      ;  /* null statement */
    } else {
      /* for outer planets correct rectangular */
      /* coordinates via harmonic terms */
      get_harm_for_outer();
      xx = xx + art[2];
      yy = yy + art[1];
      zz = zz + art[3];
      x = xx;
      y = yy;
      g = zz;
    }  
    rect_to_polar();
    cq = fnu(fnd(a));
    x = r;
    y = g;
    rect_to_polar();
    d = fnd(a);
    if (d >  20.0) {
      d = d - 360.0;
    }
        /* direct or retrograde? (uses circular orbits) */
    if (ic == 1) {
      x1 = xx;
      y1b = yy;
      z1 = zz;
      r1 = r;
      r4 = pow(r1,0.5);
      r5 = pow(r1,1.5);
      c1 = cq;
      g = fnr(fnu(cq + 180.0));
      Arco[ic] = g;
      continue;
    }
    r = ((pow(r,0.5) + r4)*(r4*pow(r,0.5)))/(pow(r,1.5) + r5);
    rx =  r - cos(fnr(c1) - fnr(cq));

    /* store retrograde fact in table
    *  */
    if (rx <  0.0) {
      strcpy(Retro[ic],"R");
    }
    if (rx >= 0.0) {
      strcpy(Retro[ic],"_");
    }

        /* convert helio rectangular to */
        /* geocentric rectangular coordinates */
    x = xx - x1; y = yy - y1b; z = zz - z1;
        /* convert geo-centric rectangular to */
        /* geo-centric spherical coordinates */
    rect_to_polar();
    g = a;
    y = z;
    x = r;
    rect_to_polar();
    if (a >  .35) {
      /* store geo-centric spherical coordinates (in radians) */
      a = a - 2.0*pi;
    }
    Arco[ic] = g;
  }  /* end of main loop for planets (from 4030) */

}  /* end of calc_chart() */


/* time calc- calculates (t) time interval, (ra) local sidereal*/
/* time, & (oe) obliquity of ecliptic for epoch */
void time_calc(void)
{ 
  jx=(yr + 4800.0)*12.0 + mn - 3.0;
  jz=(2.0*(jx - floor(jx/12.0)*12.0) + 7.0 + 365.0*jx)/12.0;
  jd= floor(jz) + dy + floor(jx/48.0) - 32083.5;
  if (jd >= 2299170.0)   {
    jd=jd + floor(jx/4800.0) - floor(jx/1200.0) + 38.0;
  }  
  dd=((jd - 2415020.0) + f/24.0);
  t=dd/36525.0;
  t2=t*t;
  rd= fnu((6. + .646065556 + 2400.051262*t + 2.5805e-5*t2 + f)
      * 15.0 -  fnq(ln));
  ra= fnr(rd);
  oe= fnr(23.45229444 - .0130125*t);
}  /* end of time_calc() */

void asc_mc_calc(void )   /* asc, mc calc  (+ misc) */
{
  a = r2;
  r = 1;
  polar_to_rect();
  x = x*cos(ob);
  rect_to_polar();
  mr = a;
  mc = fnd(mr);
  Arco[13]  =  mr;    /* MC in radians */
  l = r2;
  coordinate_transform();
  if (bq <  0.0) {
    r2 = r2 + pi;
  }
  ac =  fnu(fnd(g + pi/2.0));
  Arco[12]  =  fnr(ac);  /* asc in radians */
  l = r2 + pi;
  bq = pi/2.0 - bq;
  coordinate_transform();
  vt =  fnu(fnd(g + pi/2.0));
}  /* end of asc_mc_calc() */

void coordinate_transform(void )  /* coordinate transformation */
{
  a = bq;
  r = 1.0;
  polar_to_rect();
  q = y;
  r = x;
  a = l;
  polar_to_rect();
  g = x;
  x = y;
  y = q;
  rect_to_polar();
  a = a + ob;
  polar_to_rect(); 
  temp  =  1.0 - y*y;
  q = atan(y/pow(temp,0.5));
  y = x;
  x = g;
  rect_to_polar();
  if (a <  0.0) {
    a = a + 2.0*pi;
  }
  g = a;
}  /* end of coordinate_transform() */

void assemble_orbital_elements(void )  /* assembles orbital elements */
{
    s = get_element();
    s1 = get_element();
    s2 = get_element();
    s =  s + s1*t + s2*t2;
}  /* end of assemble_orbital_elements() */

void polar_to_rect(void )  /* polar to rectangular coordinates */
{
  if (a == 0.0) {
    a = 1.75453e-09;
  }
  x = r*cos(a);
  y = r*sin(a);
}  /* end of polar_to_rect() */

void rect_to_polar(void )  /* rectangular to polar coordinates */
{
  if (y == 0.0) {
    y = 1.75453e-09;
  }
  if (x == 0.0) {
    x = 1e-12;
  }
  temp = x*x + y*y;
  r = pow(temp,0.5); 
  a =  atan(y/x);
  if (a <  0.0) {
    a = a + pi;
  }
  if (y <  0.0) {
    a = a + pi;
  }
}  /* end of 20310() */

void get_harm_for_outer(void )  /* get harmonic terms for outer planets */
{
  ark[5] = 11;
  ark[6] = 5;
  ark[7] = 4;
  ark[9] = 4;
  ark[8] = 4;
  for (ik = 1;  ik <= 3;  ik = ik+1) {
    if ((ic == 5) && (ik == 3)) {
      art[3] = 0.0;
      return;
    }
    if (ik == 3) {
      ark[ic] = ark[ic] - 1;
    }
    assemble_orbital_elements();
    a = 0.0;
    for (ij = 1;  ij <= ark[ic];  ij = ij+1) {
      u = get_element();
      v = get_element();
      w = get_element();
      a = a +  fnr(u)*cos((v*t + w)*pi_div180);
    }
    art[ik] =  fnd( fnr(s) + a);
  }
}  /* end of get_harm_for_outer() */

void do_moon(void )    /* moon & moon's node */
{
  df= fnu(350.7374861 + 445267.0*t + .114166*t - .001436111*t2);
      /* moon/sun elongation */
  m=3600.0;
  n0=(6.40*fns(231.19 + 20.20*t)
    + (1.882 - 0.016*t)*fns(57.24 + 150.27*t)
    + .266*fns(31.8 + 119.0*t) + .202*fns(315.6 + 893.3*t))/m;
  n1= fnu(259.183275 - .0529539222*dd + (.000002*t + .002078)*t2);
  n2= fnu(334.3295556 + .1114040803*dd
    + (-.000012*t + .010325)*t2);  /* mean lunar perigee */
  n3=n0 +  fnu(358.4758444 + 35999.04975*t - .00015*t2);
      /* mean anomaly of sun */
  n4= fnu(270.4341639 + 13.1*dd + .0763965268*dd
    + (.0000019*t - .001133)*t2);  /* mean lunar longitude */
  l=n4 - n2;
  ff=n4 - n1;  /* auxiliary angles */
  n5= fns(51.2 + 20.2*t);
  n6=14.27*fns(193.4404 - 132.87*t - .0091731*t2);
  n7= fns(n1);
  n8= -15.58*fns(n1 + 275.05 - 2.3*t);
  n4=n4 + (.84*n5 + n6 + 7.261*n7)/m;
  l=l + (2.94*n5 + n6 + 9.337*n7)/m;
  df=df + (7.24*n5 + n6 + 7.261*n7)/m;
  n3=n3 + (-6.40*n5)/m;  /* corrections to elements */
  ff=ff + (.21*n5 + n6 - 88.699*n7 - 15.58*n8)/m;
  y=2.0*df;
  yd=4.0*df;
  ld=2.0*l;
  fd=2.0*ff;
  nd=2.0*n3;
  lw=3.0*l;
  lx=l - y;
  nu=( -(17.2327 + .01737*t)*fns(n1)
    - 1.273*fns(2*( fnu(279.6966778 + 36000.0*t + .76892*t
    + .0003025*t2))))/m;
      /* moon's longitude */
  ml=22639.55*fns(l) - 4586.465*fns(lx) + 2369.912*fns(y)
    + 769.016*fns(ld) - 668.1469*fns(n3);
  ml=ml - 411.608*fns(fd) - 211.6562*fns(ld - y)
    - 205.962*fns(lx + n3) + 191.953*fns(l + y);
  ml=ml - 165.145*fns(n3 - y) + 147.687*fns(l - n3)
    - 125.154*fns(df) - 109.673*fns(l + n3)
    - 55.173*fns(fd - y);
  ml=ml - 45.099*fns(l + fd) + 39.529*fns(l - fd)
    - 38.428*fns(l - yd) + 36.124*fns(lw);
  ml=ml - 30.773*fns(ld - yd) + 28.475*fns(lx - n3)
    - 24.42*fns(n3 + y) + 18.609*fns(l - df)
    + 18.023*fns(n3 + df);
  ml=ml + 14.577*fns(l - n3 + y) + 14.387*fns(ld + y)
    + 13.902*fns(yd) - 13.193*fns(ld + lx);
  ml=ml + 9.703*fns(ld - n3) + 9.366*fns(l - fd - y)
    - 8.627*fns(ld + n3 - y) - 8.466*fns(l + df)
    - 8.096*fns(nd - y) - 7.649*fns(ld + n3);
  ml=ml - 7.486*fns(nd) - 7.412*fns(lx + nd)
    - 6.382*fns(l - fd + y) - 5.741*fns(fd + y)
    - 4.391*fns(l + n3 - yd) - 3.996*fns(ld + fd);
  ml=ml + 3.215*fns(lx - df) - 2.921*fns(l + n3 + y)
    - 2.74*fns(ld + n3 - yd) - 2.494*fns(ld - n3 - y)
    + 2.58*fns(l - nd) + 2.533*fns(lx - nd);
  ml=ml - 2.152*fns(n3 + fd - y) + 1.979*fns(l + yd)
    + 1.938*fns(ld + ld) - 1.877*fns(n3 - yd)
    + 1.75*fns(ld - df) - 1.44*fns(n3 - fd + y);
  ml=ml - 1.298*fns(ld - fd) + 1.267*fns(l + n3 + df)
    + 1.225*fns(ld - y - df) - 1.187*fns(lw - yd)
    + 1.181*fns(ld - n3 + y) - 1.167*fns(l + nd);
  ml=ml - 1.089*fns(l - n3 - df) + 1.06*fns(lw + y)
    - .992*fns(l + fd + y)
    - .952*fns(lw + lx) - .570*fns(ld - 6.0*df)
    + .636*fns(l - yd) + .560*fns(n3 - df);
  ml=ml + .757*fns(l - nd + y) - .586*fns(ld + df)
    + .584*fns(fd - df) - .551*fns(lw + n3) + .681*fns(lw - n3)
    + .557*fns(ld + fd - y) + .538*fns(ld - fd - y);
  ml= fnu((ml/m) + n4 + nu);
      /* perturbations leading to lunar latitude */
  xl=22609.0*fns(l) - 4578.1*fns(lx) + 2373.4*fns(y)
    + 768*fns(ld) + 192.7*fns(l + y) - 182.4*fns(lx + n3)
    - 165.1*fns(n3 - y) - 152.5*fns(ld - y)
    - 138.8*fns(n3 - l) - 127.0*fns(n3) - 115.2*fns(l + n3);
  xl=xl - 112.8*fns(df) - 85.1*fns(fd - l) - 52.1*fns(fd - y)
    + 50.64*fns(lw) - 38.6*fns(l - yd) - 34.1*fns(ld - yd);
  xl=ff + (xl/m);
  xs=(
    1.0 - .00004664*fnco(n1) - .0000754*fnco(n1 + 275.05 - 2.3*t)
     )  *  fns(xl);  /* intermediate perturbation (screw) */
      /* lunar latitude */
  mb=(18519.7*xs - 6.2*fns(3.0*xl))/m;
  xl= -526.1*fns(ff - y) + 44.3*fns(lx + ff)
    - 30.6*fns(ff - lx) - 24.6*fns(ff - l)
    - 22.6*fns(n3 + ff - y) + 20.6*fns(ff - l)
    + 11.0*fns( - n3 - y) - 6.0*fns(l + ff - yd);
  mb=mb + (xl/m);
      /* true lunar node */
  tnq=933060.0 - 6962911.0*t + 7.5*t2 + 5392.0*fns(fd - y)
    - 541.0*fns(n3) - 442.0*fns(y);
  tnq=tnq + 423.0*fns(fd) - 291.0*fns(ld - fd);
  g= fnr(ml);
  tnq= fnr(fnu( fnp(tnq)));
  a= fnr(fnu(mb));
  rx=0.0;
  if (a >  .35) {
    a=a - 2.0*pi;
  }
}  /* end of do_moon() */



/* in s, replaces all old with new */
void scharswitch(char *s, char ch_old, char ch_new) 
{
  char *p = s;
  int c = ch_old;
  ;
  for (p=s; *p != '\0'; ++p) {
    if (*p == c)
      *p = ch_new;
  }
}

/* sort strings v[0] ... v[n-1] */
/* into increasing order */
void strsort(char *v[], int n)
{
  int gap,ii,j;
  char *temp;
  ;
  for (gap=n/2; gap >  0; gap /=2) {
    for (ii=gap; ii <  n; ii++) {
      for (j=ii-gap; j >= 0; j-=gap) {
        if (strcmp(v[j],v[j+gap]) <= 0) break;
          temp = v[j];
          v[j] = v[j+gap];
          v[j+gap] = temp;
      }
    }
  }
}  /* end of strsort() */

/*************** more on sfromto(dest,src,beg,end)  below
Reads chars from src string (from begth char to endth char inclusive) 
and writes them to dest string starting with the [0] (first) char in dest. 
Adds \0 marker to dest.    Returns pointer to dest. 
e.g.  s2 = "abcdefghijk";  sfromto(s1,s2,3,6);  now  s1 = "cdef" 
NOTE that beg and end arguments have the intuitive values where the 
first char in the string is called 1, second is called 2 etc. 
BE CAREFUL.  this fn puts chars on top of and beyond dest \0.
dest str should be long enough to hold all the chars.
***************/
char *sfromto(char *dest,char *src, int beg, int end)
{
  char *d;
  int ii;
  ;
  d = dest;  /* save dest value for return */
  for (ii=beg-1; beg <= end; ++beg,++d,++ii) {  /* if true, still in src */
    if ((*d=*(src+ii)) == '\0') return(dest);  /* if true, end of src */
  }
  *d = '\0';
  return(dest);
}
/* end of sfromto() */


/* fill up string s with num chars, where char=c */
/* '\0' goes in (num+1)th position in s, i.e. s[num] */
void sfill(char *s, int num, int c)
{
  int ri;
  ;
  for (ri=0; ri <= num-1; ri++)  *(s+ri) = c;
  *(s+num) = '\0';
}  /* end of sfill() */

/* returns 1 if  str s consists entirely of chars in str set
*/
int sall(char *s,char *set)
{
  char *p = s;
  char *q = set;
  ;
  for ( ;  *p != '\0'; p++) {
    if (strchr(q,*p) == NULL) return(0);
  }
  return(1);
}   /* end  of sall() */


/* e.g.  "Delia,12,13,1971,12,15,0,-1,-19.05"
*  assumption: no ",," empty fields
*/
void get_event_details(   /* called from perdoc.c, ... */
  char   *csv_person_string,
  char   *event_name, 
  double *gedmn,
  double *geddy,
  double *gedyr,
  double *gedhr,
  double *gedmu,
  int    *gedap,
  double *gedtz,
  double *gedln  )
{
  char workbuf[64];
  char *pNewField;
  int field_idx;

/* tn(); tr("in get_event_details()"); */
/* ksn(csv_person_string); */

  /* strtok overwrites its string, so use a buffer
  */
  strcpy(workbuf, csv_person_string); 

  pNewField = strtok(workbuf,",");  /* get ptr to first field */

/* b(7);ksn(pNewField);ks(csv_person_string);tn();b(8);  */
/* ksn(csv_person_string); */
/* ksn(workbuf); */

  field_idx = 1;

  while (pNewField != NULL)  /* for all fields in csv */
  {
    switch (field_idx) {
    case 1:  strcpy(event_name, pNewField); break;
    case 2:  *gedmn = atof(pNewField);  break;
    case 3:  *geddy = atof(pNewField);  break;
    case 4:  *gedyr = atof(pNewField);  break;
    case 5:  *gedhr = atof(pNewField);  break;
    case 6:  *gedmu = atof(pNewField);  break;
    case 7:  *gedap = atoi(pNewField);  break;
    case 8:  *gedtz = atof(pNewField);  break;
    case 9:  *gedln = atof(pNewField);  break;
    default:
      ;

  // comment this out later
/*       fprintf(stderr, "mambutil>get_event_details()>switch crazy error.\n"); */
      fprintf(stderr, "mambutil>get_event_details()>switch crazy error.\n"); 
      exit(1);
      break;
  // comment this out later

    }                       /* end of switch */

/* tn();b(80);ki(field_idx);ksn(pNewField); ks(event_name);  */
/* kdn(*gedmn);kd(*geddy);kd(*gedyr);kd(*gedhr);kd(*gedmu);ki(*gedap);kd(*gedtz);kd(*gedln);  */
/* ksn(csv_person_string); */

    pNewField = strtok (NULL, ",");  /* get ptr to next field */

    field_idx++;

  }    /* for all fields in csv */

/* tn();kd(*gedmn);kd(*geddy);kd(*gedyr);kd(*gedhr);kd(*gedmu);ki(*gedap);kd(*gedtz);kd(*gedln); tn(); */
/* ksn(csv_person_string); */
/* ksn(workbuf); */

}  /* end of get_event_details */


/* Build a string starting at "s" using consecutive chars from ptr "begarg" to ptr "end"
*  Add '\0' at end. 
*  Make sure "s" is big enough.
*/
char *mkstr(char *s, char *begarg, char *end)
{
  char *t;
  char *beg = begarg;
  ;

  // comment this out later
  if (beg > end) {
    fprintf(stderr, "Error in util mkstr() beg > end \n");
    exit(1);
  }
  // comment this out later

  for (t=s; beg <= end; beg++,t++) {
    *t = *beg;
  }

  *t = '\0';
  return(s);
}  /* end of mkstr() */


void scharout(char *s, int inchar)
{
  /* char wk[512+1]; */    /* note max size */
  char wk[2048];      /* note max size */

/*   char *p =s; */
/*   int ii=inchar; */
  char *p;
  int ii;

  char *q;
  int k;
  int num_removed;
  ;
/* trn("in scharout()"); */

  /* fill with newlines, so we do not need to add one later
  */
  sfill(wk, 2047, '\0');

/* b(50);
* ksn(wk);
* b(51);
* ksn(s);
* kin(inchar);
*/
  p = s;
  ii = inchar;
/* ksn(p); */
/* kin(ii); */
  q = &wk[0];
/* ksn(q); */

  num_removed = 0;
  for (k=-1; *p != '\0'; p++) {
    if (*p != ii) {
      ++k;              /* copy char */
      *(wk + k) = *p;
    } else {
      num_removed = num_removed + 1;
    }
/* ksn(wk); */
  }
/* kin(num_removed); */
/* trn("at end scharout() 1");ksn(s); */
  if (num_removed == 0) return;
/* kin(k); */
/*   ++k; */
/* ki(k); */
/*   *(wk+k) = '\0'; */
/* ksn(wk); */
/* ksn(s); */
/* kin(strlen(s)); */
/* kin(strlen(wk)); */

  strcpy(s,wk);

/* trn("at end scharout() 9  retval is ...");ksn(s); */

} /* end of scharout() */



/* Take long string and wrap lines with "<br>" to a given max line length
*
*  Put "<br>"s in arg1 string so lines are not longer than arg2.
*/
void put_br_every_n(char *instr,  int line_not_longer_than_this)
{
  char *pNewWord;
  int len_new_word, lenbuf, num_br_added;
  char mybuf[8192], finalbuf[8192];

/* tn();tn(); trn(" in put_br_every_n() -----------------------------------------------------------------"); */
/* ksn(instr); */
/* kin(line_not_longer_than_this); */
  strcpy(mybuf, "");
  strcpy(finalbuf, "");
  num_br_added = 0;

  /* NOTE here that strtok overwrites arg instr to get the words,
  *  but we collect the result in finalbuf and, at the end,
  *  we copy finalbuf back into arg instr, so it's ok.
  */
  pNewWord = strtok (instr," ");  /* get ptr to first word */

  while (pNewWord != NULL)  /* for all words */
  {
    lenbuf       = (int)strlen(mybuf);
    len_new_word = (int)strlen(pNewWord);
/* kin(lenbuf); tr("add this:"); ks(pNewWord); */

    if (lenbuf + len_new_word >= line_not_longer_than_this) {

/*       if (num_br_added == 0) { */
        fn_right_pad_with_hidden(mybuf, line_not_longer_than_this - lenbuf);
/* trn("len after pad="); ki(strlen(mybuf));ks(mybuf); */
/*       } */

      sprintf(mybuf, "%s<br>", mybuf);   /* add break */
      num_br_added = num_br_added + 1;

      /* add mybuf to final result in finalbuf */
      sprintf(finalbuf, "%s%s", finalbuf, mybuf);
/* ksn(finalbuf); */
      strcpy(mybuf, "");                    /* init  mybuf */
    } /* write out since line too long */

    /* add new word to mybuf */
    sprintf(mybuf, "%s%s%s", mybuf, pNewWord, " ");
    pNewWord = strtok (NULL, " ");             /* get ptr to next word */

  }  /* for all words */


  /* here no more words in aspect desc (mybuf has last line to add) */
/* trn("no more words in aspect text"); */
  if (strlen(mybuf) != 0) {

    /* add mybuf to final result in instr but remove sp at end */
    mybuf[ strlen(mybuf) - 1] = '\0';
/* tn();tn();trn("last line!!!!!!!!!!!!"); */
/* ksn(mybuf); */
/*     if (num_br_added == 0) { */
      lenbuf = (int)strlen(mybuf);
/* ki(lenbuf); */
      fn_right_pad_with_hidden(mybuf, line_not_longer_than_this - lenbuf);
/* trn("after pad last line !!!!"); */
/* ksn(mybuf); */
/*     } */
    sprintf(instr, "%s%s", finalbuf, mybuf);  /* adding mybuf */
/* trn("return string1=");ks(instr); */
  } else {
    /* here mybuf is "" */
    /* remove "<br>"  (+ sp) from the end*/
    finalbuf[ strlen(finalbuf) - 5] = '\0';

    sprintf(instr, "%s", finalbuf);
/* trn("return string2=");ks(instr); */
  }


}/* end of put_br_every_n() */

//<.>
//  // print lines in my_aspect_text wrapped to line_not_longer_than_this
//  // 
//  char *pNewWord;
//  int len_new_word, lenbuf, line_not_longer_than_this;
//  char mybuf[8192];
//
//  line_not_longer_than_this = 40;
//  strcpy(mybuf, "");
//
//  sprintf(writebuf, "fill|before para");
//  p_fn_prtlin(writebuf);
//
//  // NOTE here that strtok overwrites my_aspect_text to get the words,
//  pNewWord = strtok (my_aspect_text, " ");  /* get ptr to first word */
//
//  while (pNewWord != NULL)  /* for all words */
//  {
//    lenbuf       = (int)strlen(mybuf);
//    len_new_word = (int)strlen(pNewWord);
//
//    if (lenbuf + len_new_word >= line_not_longer_than_this) {
//
//      sprintf(writebuf, "para|%s",  mybuf);
//      p_fn_prtlin(writebuf);
//      
//      strcpy(mybuf, "");                    /* init  mybuf */
//    } /* write out since line too long */
//
//    sprintf(mybuf, "%s%s%s", mybuf, pNewWord, " "); /* add new word to mybuf */
//
//    pNewWord = strtok (NULL, " ");                  /* get ptr to next word */
//
//  }  /* for all words */
//
//  /* here no more words in aspect desc (mybuf has last line to add) */
//  if (strlen(mybuf) != 0) {
//
//    mybuf[ strlen(mybuf) - 1] = '\0'; /* but remove sp at end */
//
//    sprintf(writebuf, "para|%s",  mybuf);
//    p_fn_prtlin(writebuf);
//  }
//  //
//  // end of print lines in my_aspect_text wrapped to line_not_longer_than_this
//<.>
//



void fn_right_pad_with_hidden(char *s_to_pad, int num_to_pad)
{
  char my_right_padding_chars[80];

/*   char *lotsachars = "_________________________________________________________"; */
/*   char *lotsachars = "Lorem ipsum calor sit amet, consecr adipi elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at,"; */
/*   char *lotsachars = "lom  ipim  cor  sit  amet,  cosecr  adipi  elit.  nam  cirvus.  morbi  ut  mi.  nullam  enim  leo,  ege stas  id,  con dimen tum  at,"; */
/*   char *lotsachars ="a a a a M M M M M Ma Ma Ma M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  M  "; */

/*   char *lotsachars = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"; */
  char *lotsachars =
"oremqipsumqcalorqsitqametqconsecrqadipiqelitqNamqcursusqMorbiqutqminullamqenimqleoqegestasqid,qcondimentumqatenimqleoqegestasqid";


/* trn(" in fn_right_pad_with_hidden(char *s_to_pad, int num_to_pad)"); */
/* kin(strlen(s_to_pad)); ki(num_to_pad);ks(s_to_pad); */
/*   if (num_to_pad <= 0) return;  */
  if (num_to_pad <= 0) return;

  /* make right pad chars */
  mkstr(my_right_padding_chars, lotsachars, lotsachars + num_to_pad - 1);
  sprintf (s_to_pad,
    "%s<span style=\"visibility: hidden\">%s</span>",
    s_to_pad,
    my_right_padding_chars
  );
/* tr("padded = "); ks(s_to_pad); */
}  /* end of fn_right_pad_with_hidden() */


/*  find asp_code in tab[0]...tab[num_elements-1]
*/
int binsearch_asp(char *asp_code, struct aspect tab[], int num_elements) 
{
  int cond;
  int low, high, mid;

  low = 0;
  high = num_elements - 1;
  while (low <= high) {
    mid = (low+high) / 2;
    if ((cond = strcmp(asp_code, tab[mid].asp_code)) < 0)
      high = mid - 1;
    else if (cond > 0)
      low = mid + 1;
    else
      return mid;
  }
  return -1;
}

/*  find person_name in tab[0]...tab[num_elements-1]
*  
* struct cached_person_positions {
*   char person_name[20];    * max 15 may 2013 *
*   char *minutes_natal[14];
* } g_cached_pos_tab[16];
*
*/
int binsearch_person_in_cache(
  char *in_person_name,
  struct cached_person_positions tab[],
  int num_elements) 
{
  int cond;
  int low, high, mid;
/* tn();trn("in binsearch_person_in_cache()"); */
/* ksn(in_person_name);ki(num_elements); */

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   if (num_elements <= 32) {
*     for(ii=0; ii < num_elements; ii++) {
*       if (strcmp(in_person_name, tab[ii].person_name) == 0) return ii;
*     }
*     return -1;
*   }
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

  low = 0;
  high = num_elements - 1;
/* kin(low);ki(high); */
  while (low <= high) {
    mid = (low+high) / 2;
/* kin(mid);ks(tab[mid].person_name); */
    if ((cond = strcmp(in_person_name, tab[mid].person_name)) < 0) {
      high = mid - 1;
/* kin(low);ki(high); */
    } else {
      if (cond > 0) {
        low = mid + 1;
/* kin(low);ki(high); */
      } else {
        return mid;
      }
    }
  }
  return -1;
}


char *csv_get_field(char *csv_string, char *delim, int want_fieldnum) {
  char * pNewField, workbuf[2048];
  int field_idx;
  
  /* strtok overwrites the string you give it, so give it a buffer copy
  */
  strcpy(workbuf, csv_string);  /* strtok overwrites the string you give it */

  if (want_fieldnum < 1) return("");

  pNewField = strtok(workbuf, delim);  /* get ptr to first field */

  for (field_idx = 1; pNewField != NULL; field_idx++) /* walk fields in csv */
  {
    if (field_idx != want_fieldnum) {
      pNewField = strtok (NULL, delim);  /* get ptr to next field */
      continue; 
    }
    return(pNewField);
  }  
  return("");
}  /* end of csv_get_field() */


/* commafy_int()  takes integer "intnum", formats it right-justified
*  starting at ptr "dest" in a field of "sizeofs".
*  "dest" better be big enough.
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
  for (
    ctr=1, n= (int)strlen(wkstr), place=sizeofs-1;
    n >= 1; 
    n--, digits--, ctr++,place-- )
  {
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


/* char *strim(s,set)
*   in string s, trim from both the left end and right end
*   all the characters in string set.
*   returns ptr to 1st non-set char in s.  
*   (\0 is written into s if right trimming occured)
*/
char *strim(char *s, char *set)
{
  char *p,*q;
  ;
  for (p=s; *p != '\0'; p++) {
    if (strchr(set,*p) == NULL) break;  /* out on 1st non-set char */
  }
  if (*p == '\0') return("");  /* s is all set chars */
  q = PENDSTR(s);            /* | null stmt */
  for ( ; strchr(set,*q) != NULL; q--) ;  /* out on 1st non-set char */
  *(q+1) = '\0';
  return(p);
}

int scharcnt(char *s, int c)
{
  char *p = s;  
  int n = c;
  int cnt;
  ;
  for (cnt=0; *p != '\0'; p++) {
    if (*p == n) cnt++;
  }
  return(cnt);
}  /* end of scharcnt() */

/* rkstrrchr() is funny fix because strrchr() won't work  
*/
char *rkstrrchr(char *s, char c)
{
  char *t;
  ;
  for (t=&s[strlen(s)]; t >= s ; t--) {  
    if (*t == c) return(t);
  }
  return(NULL);
}  /* end of rkstrrchr() */

/* returns whole num part of s- sprintf("%f",s) */
/* in t.  e.g. s="-123.45", return is "123" */
char *swholenum(char *t, char *s)
{
  int ii,k,m;
  ;
  for (m=0,ii=0; ( k=*(s+ii) ); ++ii) {
    if (k == ' ') continue;
    if (k == '.') break;
    *(t+m) = k;
    ++m;
  }
  *(t+m) = '\0';
  return(t);
}

/* returns decimal place part of s- sprintf("%f",s) */
/* in t.  e.g. s="-123.45", return is "45" */
char *sdecnum(char *t, char *s)
{
  int ii,k,m,isdec;
  ;
  for (m=0,isdec=0,ii=0; ( k=*(s+ii) ); ++ii) {
    if (k == '.') {isdec = 1; continue;}
    if (isdec == 0) continue;
    if (k == ' ') break;
    *(t+m) = k;
    ++m;
  }
  *(t+m) = '\0';
  return(t);
}

/* returns 1 if it finds a char c in string s */
/* otherwise, returns 0 */
int sfind(char s[], char c) 
{
  for(; *s != '\0'  &&  *s != c; ++s)
    ;
  /* return((*s == c)? Found:Not_found); */
  return((*s == c)? 1:0);
}

#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/

/* returns ptr to str s */
/* capitalizes 1st letter in each word in s */
char *scapwords(char *s) 
{
  int inalpha;  /* true when current char is alpha */
  char *saveptr;
  ;
  saveptr = &s[0];
  if (isalpha(*s = toupper(*s))) inalpha = 1;    /* 1st case */
  else inalpha = 0;
  for (++s; *s; ++s) {
    if (inalpha == 1) {
      if (isalpha(*s) == 0) inalpha = 0;
    } else {
      if (isalpha(*s)) {
        *s = toupper(*s);
        inalpha = 1;
      }
    }
  }
  return(saveptr); 
}  /* end of scapwords() */


/* strsubg    on str s (max 512) does  :s/replace_me/with_me/g
 * strsubg    on str s (max 2048) does  :s/replace_me/with_me/g
*/
void strsubg(char *s, char *replace_me, char *with_me) // on str s (max 2048) does  :s/replace_me/with_me/g
{
  char final_result[2048], wkbuf[2048], wkbuf2[2048], buf2[2048];
  char save_s[2048], done_so_far[2048];
  char *p;
/*   char *qq; int iii; */

/* tn();ksn("in strsubg"); */
/* ksn(s); */
/* ksn(replace_me); */
/* ks(with_me); */
  strcpy(save_s, s);
  strcpy(done_so_far, "");
  strcpy(wkbuf, s);
  strcpy(final_result, "");

  while (1) {
    p = strstr(wkbuf, replace_me);
/* tn();b(1);ks(p); */
    if (p == NULL) {
      strcat(final_result, wkbuf); /* put rest of wkbuf into final_result */
      strcat(done_so_far, wkbuf); 
/* tn();b(2);ks(final_result); */
/* tn();b(2);ks(done_so_far); */
      strcpy(s, final_result);
/* tn();b(3);ks(s); */
      break;  
    } else {
      if (p == wkbuf) {  /* str starts with " X" */
        strcat(final_result, with_me); /* append "with_me" */
        strcat(done_so_far, replace_me); 
/* tn();b(10);ks(final_result); */
/* tn();b(10);ks(done_so_far); */
        /* point wkbuf at rest of s */
/* ksn(wkbuf); */
/* qq = wkbuf + strlen(replace_me); ksn(qq); */
/* iii = strlen(replace_me); kin(iii); */

        /* wkbuf2 solves abort trap 6    so,
        *  instead of this: strcpy(wkbuf, wkbuf2);
        *  use this:        strcpy(wkbuf, wkbuf + strlen(replace_me));
        */
        strcpy(wkbuf2, wkbuf + strlen(replace_me));

/* ksn(wkbuf2); */
        strcpy(wkbuf, wkbuf2);
/* ksn(wkbuf); */
/* ksn("that worked 1"); */


/* tn();b(11);ks(wkbuf); */
        continue;
      }

/* tn();b(12); */
      mkstr(buf2, wkbuf, p-1);  /* grab intermediate stuff in buf2 */
/* ks(buf2); */

      /* append the stuff before "replace_me"
      */
      strcat(final_result, buf2);
      strcat(done_so_far, buf2); 
/* tn();b(5);ks(final_result); */
/* tn();b(5);ks(done_so_far); */

      /* append "with_me"
      */
      strcat(final_result, with_me);
      strcat(done_so_far, replace_me); 
/* tn();b(6);ks(final_result); */
/* tn();b(6);ks(done_so_far); */

      /* are we finished ? */
      if (strcmp(done_so_far, save_s) == 0) break;

      /* point wkbuf at rest of s
      */
/*       strcpy(wkbuf, wkbuf + strlen(done_so_far)); */
      strcpy(wkbuf, save_s + strlen(done_so_far));
/* tn();b(7);ks(wkbuf); */
    }
  }
/* ksn(final_result);b(99); */
  strcpy(s, final_result);
  return;
} /* end of  strsubg() */


/* Calculate day of week in proleptic Gregorian calendar.
*  Sunday == 0.
*  in grpdoc.c : char *N_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""};
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


int strcmp_ignorecase(char *s1, char *s2)
{
  int retval;
  for (;; s1++, s2++) {
    retval = tolower(*s1) - tolower(*s2);
    if (retval != 0 || !*s1) return retval;
  }
}



/* PERCENTILE RANK SCORES   for benchmark and each trait
*  5 entries idx 1-6 are for percentiles = 10,25,50,75,90
*/
/*
* -----------------------------------------------------
*  **  benchmark   |------  trait scores   ------|
* pctl  score    agrsv sensi restl earth sexdr upndn bestyr
*  90    373      130   106   111   117   143   113   130
*  75    213       94    71    74    69   101    65   116
*  50    100       59    39    48    42    70    33   100
*  25     42       27     9    20    15    43     7    84
*  10     18        7     1     1     1    20     1    68
* -----------------------------------------------------
* -----------------------------------------------------
*/
/* bs= benchmark score  ts= trait score 
 *
 *  [6] is "floor" for the category 
 *                   agr sen res  ear upndn
 *   percentile       10  25  50  75  90  */

int bs[]       = {-1,373,213,100, 42, 18,  1}; 
/* int bs[]       = {-1, 90, 75, 50, 25, 10,  1};  */
/* int bs[]       = {-1, 90, 75, 65, 55, 50,  1};  */


int ts_agrsv[] = {-1,167,130, 89, 55, 26,  1};
int ts_sensi[] = {-1,140,100, 62, 23,  4,  1}; 
int ts_restl[] = {-1,147,107, 74, 39, 16,  1}; 
int ts_earth[] = {-1,162,109, 74, 40,  8,  1}; 
int ts_sexdr[] = {-1,184,140,104, 72, 45,  1}; 

int ts_upndn[] = {-1,113, 65, 33,  7,  1,  1}; 
/* int ts_upndn_2[] = {-1,390, 275, 165,  122,  64,  1} ; */
/* int ts_upndn_2[] = {-1,390, 246, 164,  70,  54,  1};  */
/* int ts_upndn_2[] = {-1,390, 275, 158, 117,  59,  1};  */
/* int ts_upndn_2[] = {-1,390, 275, 160, 121,  59,  1};  */

/* int ts_upndn_2[] = {-1,390, 275, 169, 121,  64,  1};  */
/* int ts_upndn_2[] = {-1,861, 684, 502, 358,  219,  1};  */

int ts_upndn_2[] = {-1,1154, 962, 737, 539,  374,  1}; 



/* int ts_besty[] = {-1,130,116,100, 84, 68};  */
int ts_besty[] = {-1,120,108,100, 89, 72,  1}; 
int ts_mysty[] = {-1,1484,1092, 759, 524, 360,  1}; 

/* int ts_bestd[] = {-1, 21, 11,  0,-13,-26,-60};  */
int ts_bestd[] = {-1,121,111,100, 87, 74,  1}; 

int ts_best2[] = {-1,1199,1069,934, 805, 679,  1}; 


int mapNumStarsToBenchmarkNum(int category, int num_stars)  /* ==================== */
{
  int ts[16],im;  /* ts = score trait   im= i map */

  if (num_stars == 1) return(1);

/*   if (category == IDX_FOR_MYSTERIOUS) {
*     bs[0] = -1;
*     bs[1] = 1484;
*     bs[2] = 1092;
*     bs[3] =  759;
*     bs[4] =  524;
*     bs[5] =  360;
*   } else {
*     bs[0] = -1;
*     bs[1] = 373;
*     bs[2] = 213;
*     bs[3] = 100;
*     bs[4] =  42;
*     bs[5] =  18;
*   }
*/

  if (category == IDX_FOR_AGGRESSIVE) 
    for(im=1; im <= 6; im++) ts[im] = ts_agrsv[im]; 
  if (category == IDX_FOR_SENSITIVE)  
    for(im=1; im <= 6; im++) ts[im] = ts_sensi[im]; 
  if (category == IDX_FOR_RESTLESS)  
    for(im=1; im <= 6; im++) ts[im] = ts_restl[im]; 
  if (category == IDX_FOR_DOWN_TO_EARTH)
    for(im=1; im <= 6; im++) ts[im] = ts_earth[im]; 
  if (category == IDX_FOR_SEX_DRIVE)   
    for(im=1; im <= 6; im++) ts[im] = ts_sexdr[im]; 
  if (category == IDX_FOR_UPS_AND_DOWNS)
    for(im=1; im <= 6; im++) ts[im] = ts_upndn[im]; 

  if (category == IDX_FOR_UPS_AND_DOWNS_2) {
    for(im=1; im <= 6; im++) ts[im] = ts_upndn_2[im]; 
  }

  if (category == IDX_FOR_BEST_YEAR)
    for(im=1; im <= 6; im++) ts[im] = ts_besty[im]; 
  if (category == IDX_FOR_MYSTERIOUS) 
    for(im=1; im <= 6; im++) ts[im] = ts_mysty[im]; 
  if (category == IDX_FOR_BEST_DAY)
    for(im=1; im <= 6; im++) ts[im] = ts_bestd[im]; 
  if (category == IDX_FOR_SCORE_B)  /* best day version 2 redo */
    for(im=1; im <= 6; im++) ts[im] = ts_best2[im]; 

  /* return exact score hits
  */
  for(im=1; im <= 6; im++) {
    if (num_stars == ts[im]) return (bs[im]);
  }
  
  if (num_stars > ts[1])
    return ((int)((double)bs[1] * (double)num_stars / (double)ts[1]));

  else if (num_stars >  ts[2])
    /* return (int)(213.0+((373.0-213.0)*(num_stars-94.0)/(130.0-94.0))); */
    /*      bs[2] + ( (bs[1]-bs[2]) * (num_stars-ts[2]) / (ts[1]-ts[2]) ) */
    return ( (int)
      (double)bs[2] + ( ((double)bs[1]-(double)bs[2]) *
        ((double)num_stars-(double)ts[2]) / ((double)ts[1]-(double)ts[2]) )
    );
  else if (num_stars >  ts[3])
    return ( (int)
      (double)bs[3] + ( ((double)bs[2]-(double)bs[3]) *
        ((double)num_stars-(double)ts[3]) / ((double)ts[2]-(double)ts[3]) )
    );
  else if (num_stars >  ts[4])
    return ( (int)
      (double)bs[4] + ( ((double)bs[3]-(double)bs[4]) *
        ((double)num_stars-(double)ts[4]) / ((double)ts[3]-(double)ts[4]) )
    );
  else if (num_stars >  ts[5])
    return ( (int)
      (double)bs[5] + ( ((double)bs[4]-(double)bs[5]) *
        ((double)num_stars-(double)ts[5]) / ((double)ts[4]-(double)ts[5]) )
    );
  else if (num_stars < ts[5] && num_stars > 0)
    return ( (int)
                1.0 + ( ((double)bs[5]-         1.0 ) *
        ((double)num_stars-         1.0 ) / ((double)ts[5]-         1.0 ) )
    );

/*   else if (num_stars < ts[5] && num_stars <= 0)
*     return ( (int) ( (double)bs[5] - (double)bs[5] *
*         ((double)ts[5] - (double)num_stars) / (ts[5] + ts[6]) )  *50.0="floor"*
*     );
*/
/* 
* int bs[]       = {-1,373,213,100, 42, 18,  1}; 
* int ts_bestd[] = {-1, 21, 11,  0,-13,-26,-50}; 
*/
  else 
    return(1);

  return(1); /* should never get here */


/* example with 
*   if (category == IDX_FOR_AGGRESSIVE) {
*     if (num_stars == 130) return(373);
*     if (num_stars ==  94) return(213);
*     if (num_stars ==  59) return(100);
*     if (num_stars ==  27) return( 42);
*     if (num_stars ==   7) return( 18);
*     if (num_stars ==   1) return(  1);
* 
*     if (num_stars > 130) 
*       return ((int)(373.0 * (double)num_stars / 130.0));
*     else if (num_stars >  94)
*       return (int)(213.0+((373.0-213.0)*(num_stars-94.0)/(130.0-94.0)));

*     else if (num_stars >  59)
*       return (int)(100.0+((213.0-100.0)*(num_stars-59.0)/(94.0-59.0)));

*     else if (num_stars >  27)
*       return (int)(42.0+((100.0-42.0)*(num_stars-27.0)/(59.0-27.0)));
*     else if (num_stars >   7)
*       return (int)(18.0+((42.0-18.0)*(num_stars-7.0)/(27.0-7.0)));
*     else if (num_stars >   1) 
*       return(1);
*     return(999);
*   }
*/

} /* end of  mapNumStarsToBenchmarkNum(int category, int num_stars) */



/* int map_score_to_percentile_rank(int benchmark_num)
*
*     returns the percentile rank 1 -> 99
*     given the benchmark score from above
*/
/*
* ---------------
* pctl  benchmark
* rank  score    
*  99    880   (above this are all 99)
*  90    373     
*  75    213     
*  50    100     
*  25     42     
*  10     18     
*   1      1 or less
* -----------------------------------------------------
*/
/*                    IDX  0    1    2    3    4   5   6   7  */
/* int benchmark_numbers[] = {-1, 777, 373, 213, 100, 42, 18,  1};  * FROM * */
/* int percentile_ranks[]  = {-1,  99,  90,  75,  50, 25, 10,  1};  * TO * */

int mapBenchmarkNumToPctlRank(int in_score)
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

  /*     return ( (int)
  *       (double)percentile_ranks[7] + (
  *         ((double)percentile_ranks[6]  - (double)percentile_ranks[7])  *
  *         ((double)in_score             - (double)benchmark_numbers[7]) /
  *         ((double)benchmark_numbers[6] - (double)benchmark_numbers[7])
  *       )
  *     );
  *     return ( (int)
  *       (double)bs[3] + ( ((double)bs[2]-(double)bs[3]) *
  *         ((double)num_stars-(double)ts[3]) / ((double)ts[2]-(double)ts[3]) )
  *     );
  */


  /* e.g. map 41 -> 18 to 25 -> 10 */
  if (in_score <  18 && in_score >   1) return calc_percentile_rank(in_score,  18,   1, 10,  1);
  if (in_score <  42 && in_score >  18) return calc_percentile_rank(in_score,  42,  18, 25, 10);
  if (in_score < 100 && in_score >  42) return calc_percentile_rank(in_score, 100,  42, 50, 25);
  if (in_score < 213 && in_score > 100) return calc_percentile_rank(in_score, 213, 100, 75, 50);
  if (in_score < 373 && in_score > 213) return calc_percentile_rank(in_score, 373, 213, 90, 75);
  if (in_score < 777 && in_score > 373) return calc_percentile_rank(in_score, 777, 373, 99, 90);

  return(1);  /* should not happen */

} /* end of mapBenchmarkNumToPctlRank()  */

/* e.g. int calculated_percentile_rank(in_score, 41, 18, 25, 10)
*  e.g. maps in_score between 41 and 18 to percentil ranks between 25 and 10
*/
int calc_percentile_rank(int in_score, int sc_hi, int sc_lo, int pr_hi, int pr_lo)
{
  /* return (10 + ( (25 - 10) *   (in_score - 18) / (41 - 18)  ); */
  return (pr_lo + ( (pr_hi - pr_lo) *   (in_score - sc_lo) / (sc_hi - sc_lo) ) );

}; /* end of calculated_percentile_rank() */



/* int avg_benchmark_numbers[] = {-1, 250, 203, 180, 154, 135, 116,  1};  * FROM * */
/* int percentile_ranks[]      = {-1,  99,  90,  75,  50,  25,  10,  1};  * TO * */

int mapAVGbenchmarkNumToPctlRank(int in_score)
{
  if (in_score <= 1)   return( 1);
  if (in_score >= 250) return(99);

  /* return exact hits */
  if (in_score == 203) return(90);
  if (in_score == 180) return(75);
  if (in_score == 154) return(50);
  if (in_score == 135) return(25);
  if (in_score == 116) return(10);

  /* e.g. map 41 -> 18 to 25 -> 10 */
  if (in_score < 116 && in_score >   1) return calc_percentile_rank(in_score, 116,   1, 10,  1);
  if (in_score < 135 && in_score > 116) return calc_percentile_rank(in_score, 135, 116, 25, 10);
  if (in_score < 154 && in_score > 135) return calc_percentile_rank(in_score, 154, 135, 50, 25);
  if (in_score < 180 && in_score > 154) return calc_percentile_rank(in_score, 180, 154, 75, 50);
  if (in_score < 203 && in_score > 180) return calc_percentile_rank(in_score, 203, 180, 90, 75);
  if (in_score < 250 && in_score > 203) return calc_percentile_rank(in_score, 250, 203, 99, 90);

  return(1);  /* should not happen */

} /* end of mapAVGbenchmarkNumToPctlRank() */






/*  find first element in arg1 (sorted array of strings)
*   that begins with string arg2.
*   Return array index.  (-1 if not found)
*/
int bin_find_first_in_array(    /* ABANDONED */
  char **array_of_strings,
  char *begins_with,
  int num_elements  )
{
  int cond;
  int low, high, mid, lowest_hit_so_far;

  low = 0;
  high = num_elements - 1;
  lowest_hit_so_far = -1;

  while (low <= high) {
    mid = (low+high) / 2;
    if ((cond = strcmp(begins_with, array_of_strings[mid])) < 0) {
      high = mid - 1;
    } else if (cond > 0) {
      low = mid + 1;
    } else {

      /* Here we have found a good hit at index  "mid". */
      lowest_hit_so_far = mid;
      high = mid - 1;


      /*  Now go sequentially backwards to the FIRST good hit and return that.
      */
/*       for (n=mid; n >= 0; n--) {
*         if ((cond = strcmp( begins_with, array_of_strings[n])) == 0) {
*           continue; 
*         }
*         return (n + 1);  * n is not good, so return n+1 *
*       }
*       return(0);
*/
      /* Here we got down to index [0] and it was still good, */
    }
  }
  return lowest_hit_so_far;   /* not found at all */

} /* bin_find_first__in_array( */   /* ABANDONED */

 
/* Uses binary  search  in gbl_placetab[] structs
*  to find first city that "begins_with" arg.
*  Returns index that is   lowest_hit_so_far 
*/
int bin_find_first_city1 (char *city_begins_with) /* in gbl_placetab[] */
{
  int  ii, my_num_elements, len, iresult;
  char low_city_begins_with[64];
  char low_city_in_array[64];
  int low, high, mid, lowest_hit_so_far, lowest_exact_hit_so_far;

/* tn();trn("in  bin_find_first_city_begins_with"); */
/* kin(my_num_elements); ksn(city_begins_with); */

  /*my_num_elements = NKEYS_PLACE;*/    /* in full placetab array */
  my_num_elements = gbl_nkeys_place;     /* in full placetab array */

  low = 0;
  high = my_num_elements - 1;
  lowest_hit_so_far = -1;
  lowest_exact_hit_so_far =  -1;

  strcpy(low_city_begins_with, city_begins_with);
  for(ii = 0; low_city_begins_with[ii]; ii++){  /* make city_begins_with  lower case */
    low_city_begins_with[ii] = tolower(city_begins_with[ii]);
  }
  len = (int)strlen(low_city_begins_with);

  while (low <= high) {
    mid = (low+high) / 2;
    strcpy(low_city_in_array, gbl_placetab[mid].my_city);
    for(ii = 0; low_city_in_array[ii]; ii++){ /* make gbl_placetab[mid].my_city lower case */
      low_city_in_array[ii] = tolower(low_city_in_array[ii]);
    }

//    iresult = strncmp(low_city_begins_with, low_city_in_array, len); /* ignores case */

    char city_to_compare_against[64];
    int  how_many_minus_signs;
    how_many_minus_signs = 0;
    strcpy(city_to_compare_against, low_city_in_array);
    how_many_minus_signs = scharcnt(city_to_compare_against, '-');  // count how many minus signs - 
//ks(city_to_compare_against);
//kin(how_many_minus_signs);
    scharout(city_to_compare_against, '-');  /* remove - because it's ignored in unix sort    */
//ksn(city_to_compare_against);
//    iresult = strncmp(low_city_begins_with, city_to_compare_against, len - how_many_minus_signs ); /* ignores case */
    iresult = strncmp(low_city_begins_with, city_to_compare_against, len                        ); /* ignores case */

//ki(iresult);
//tr("qq1 loop");
    if (iresult < 0) {
//trn("qq1 got high");
      high = mid - 1;
    } else if (iresult > 0) {
//trn("qq1 got low");
      low = mid + 1;
    } else {
      /* Here we have found a good hit at index  "mid". */
//trn("qq1 got hit");
     lowest_hit_so_far = mid;
     high = mid - 1;
    }
//trn("");
  }

  return (lowest_hit_so_far);  /* could be -1 (not found) */
 
} /* end of bin_find_first_city1 */


 
/* Uses binary  search  in gbl_placetab[] structs
*  to find first city that "begins_with" arg.
*  RETURN VALUE is
*     1. index that is lowest_hit_so_far IF there are too many cities for picklist (numCitiesToGetPicklist)
*     2. -1  IF no city  starts with arg "city_begins_with"
*     3. -2  IF there are few enough cities to make a picklist
*  also returns num cities found
*  also returns array of chars holding city,prov,coun PSVs
*/
int bin_find_first_city(      /* in gbl_placetab[] */
  char  *city_begins_with,
  int    numCitiesToGetPicklist,
  int   *arg_numCitiesFound,        // a return value
  char  *city_prov_coun_PSVs    // a return value
)
{
  int  ii, my_num_elements, len, iresult;
  char low_city_begins_with[64];
  char low_city_in_array[64];
  int low, high, mid, lowest_hit_so_far, lowest_exact_hit_so_far;

tn();trn("in  bin_find_first_city_begins_with    qq qq qq "); 
//ksn(city_begins_with);
//kin(numCitiesToGetPicklist);

  /*my_num_elements = NKEYS_PLACE;*/    /* in full placetab array */
  my_num_elements = gbl_nkeys_place;     /* in full placetab array */
//kin(my_num_elements);

  low = 0;
  high = my_num_elements - 1;
  lowest_hit_so_far = -1;
  lowest_exact_hit_so_far =  -1;

  strcpy(low_city_begins_with, city_begins_with);
  for(ii = 0; low_city_begins_with[ii]; ii++){  /* make city_begins_with  lower case */
    low_city_begins_with[ii] = tolower(city_begins_with[ii]);
  }
  len = (int)strlen(low_city_begins_with);

  while (low <= high) {
    mid = (low+high) / 2;

    strcpy(low_city_in_array, gbl_placetab[mid].my_city);             // <<<<===--- -----------------

    for(ii = 0; low_city_in_array[ii]; ii++){ /* make gbl_placetab[mid].my_city lower case */
      low_city_in_array[ii] = tolower(low_city_in_array[ii]);
    }
//ksn(low_city_begins_with);
//ksn(low_city_in_array);



//    iresult = strncmp(low_city_begins_with, low_city_in_array, len); /* ignores case */

    char city_to_compare_against[64];
    int  how_many_minus_signs;
    how_many_minus_signs = 0;
    strcpy(city_to_compare_against, low_city_in_array);
    how_many_minus_signs = scharcnt(city_to_compare_against, '-');  // count how many minus signs - 
//ks(city_to_compare_against);
//kin(how_many_minus_signs);
    scharout(city_to_compare_against, '-');   /* remove - because it's ignored in unix sort    */
//ksn(city_to_compare_against);
//    iresult = strncmp(low_city_begins_with, city_to_compare_against, len - how_many_minus_signs ); /* ignores case */
    iresult = strncmp(low_city_begins_with, city_to_compare_against, len                        ); /* ignores case */




//ki(iresult);
//tr("qq loop");
    if (iresult < 0) {
//trn("got high");
      high = mid - 1;
    } else if (iresult > 0) {
//trn("got low");
      low = mid + 1;
    } else {
      /* Here we have found a good hit at index  "mid". */
//trn("got hit");
     lowest_hit_so_far = mid;
     high = mid - 1;
    }
//trn("");
  }


//kin(lowest_hit_so_far);
  if (lowest_hit_so_far == -1 ) return (lowest_hit_so_far);    // -1 = no city  starts with arg "city_begins_with"



  // regardless of whether we use them, collect city|prov|coun PSVs.
  //   if we find   > numCitiesToGetPicklist, return lowest_hit_so_far 
  //   if we find  <= numCitiesToGetPicklist, return -2 so calling pgm knows to make picklist
  //
  int out_PSVindex;
  out_PSVindex = -1;  // (0-based)

//  int my_num_elements, idx, len, num_places_found, iresult;
  char begins_with_buf[64], city_buf[64], city_buf_tolower[64], prov_buf[64], coun_buf[64];
  int starting_index_into_cities, idx_of_prov, idx_of_coun;
  int num_places_found;             // that match begins with typed so far
  int num_found_match_entire_city;  // count entire city matches
  int iresult2;                     // count entire city matches

  num_places_found            = 0;  // that match begins with typed so far
  num_found_match_entire_city = 0;  // count entire city matches
  starting_index_into_cities  = lowest_hit_so_far;

//  my_num_elements  = NKEYS_PLACE;     // in full placetab array 

  strcpy(begins_with_buf, city_begins_with);
  for(int i = 0; begins_with_buf[i]; i++){  // make begins_with_buf  lower case 
    begins_with_buf[i] = tolower(begins_with_buf[i]);
  }
  len = (int)strlen(begins_with_buf);

//tn();trn("start saving city|prov|coun");
  int save_idx;
  save_idx = -1;  // zero-based
  int dbctr; dbctr = 0; 
  while (starting_index_into_cities + num_places_found <= my_num_elements)
  {

    strcpy(city_buf, gbl_placetab[starting_index_into_cities + num_places_found].my_city); // <<<<===--- ------
    idx_of_prov =    gbl_placetab[starting_index_into_cities + num_places_found].idx_prov;
    idx_of_coun =    gbl_placetab[starting_index_into_cities + num_places_found].idx_coun;
    strcpy(prov_buf, array_prov[idx_of_prov]);
    strcpy(coun_buf, array_coun[idx_of_coun]);

    // make current city_buf  lower case 

    sfill(city_buf_tolower, 63, '\0');
    for(int i = 0; city_buf[i]; i++){
      city_buf_tolower[i] = tolower(city_buf[i]);
    }

//dbctr = dbctr + 1;
//ki(dbctr);ks(city_buf);ks(prov_buf);ksn(coun_buf);

//ki(dbctr);ks(city_buf);ki(idx_of_prov);kin(idx_of_coun);
//ksn(city_buf_tolower);


    iresult2 = strcmp(begins_with_buf, city_buf_tolower); /* ignores case */      // <<==-----  matches WHOLE CITY NAME
    if (iresult2 == 0) {
      num_found_match_entire_city = num_found_match_entire_city + 1;  // count entire city matches
    }

    iresult = strncmp(begins_with_buf, city_buf_tolower, len); /* ignores case */      // <<==-----  BEGINS WITH
    if (iresult == 0) {
      num_places_found = num_places_found + 1;
//b(230);
      if (num_places_found > numCitiesToGetPicklist) {
//b(231);

        // here we have > 25 cities matching Typed so Far
        // CHECK if there are  any  cities whose ENTIRE NAME matches Typed so Far
        //     if yes, return -2 to give permission to display button "Picklist >"
        //
        if (num_found_match_entire_city > 0) {
//        if (num_found_match_entire_city > 1) {

          *arg_numCitiesFound = num_found_match_entire_city;   // <<==-----  matches WHOLE CITY NAME
          return (-2);    // -2  IF there are  entire city matches  to make a picklist

        } else {

          *arg_numCitiesFound = num_places_found;              // <<==-----  matches BEGINS WITH
          return (lowest_hit_so_far);  // too many cities starting with  "city_begins_with"  to make a picklist
                                       // caller can display city that is  lowest_hit_so_far
        }
      }

      // save city data here into PSV
      //

//      sprintf(gbl_my1_group_report_line, "%s|%s||", cocoa_rowcolor, person_line);
//      strcpy(out_group_report_PSVs + *out_group_report_idx * gbl_g_max_len_group_data_PSV , gbl_my1_group_report_line); // every 128
      char my128PSV[128];



      sprintf(my128PSV, "%s|%s|%s", city_buf, prov_buf, coun_buf);
//ksn(my128PSV);
      strcpy(city_prov_coun_PSVs + (num_places_found - 1)  * 128, my128PSV);  // fixed rec =  128  chars

    } else {
      break;  // here we have saved city|prov|coun PSVs until hitting a city that does not start with "city_begins_with"
    }
  }

  *arg_numCitiesFound = num_places_found;

  return (-2);    // -2  IF there are few enough cities to make a picklist
 
} // end of bin_find_first_city



//<.>
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
//} /* end of possilyGetSearchResults1() */
//<.>
//




#ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
*   /* test sequential search    to do=first first that begins with ...
*   *
*   * #define MAX_IN_PLACES_SEARCH_RESULTS1   1024 
*   * struct my_place_fields  *gbl_search_results1[MAX_IN_PLACES_SEARCH_RESULTS1];
*   * int idx_last_place_added;  
*   */
*   len = strlen(city_begins_with);
* 
*   for (idx=0; idx <= my_num_elements -1; idx++) {
* 
*     strcpy(buf_city_in_array, gbl_placetab[idx].my_city);
*     for(int ii = 0; buf_city_in_array[ii]; ii++){ /* make gbl_placetab[idx].my_city  lower case */
*       buf_city_in_array[ii] = tolower(buf_city_in_array[ii]);
*     }
* 
*     iresult = strncmp(buf_city_in_array, buf_city_begins_with, len); /* ignores case */
* 
*     if (iresult == 0) return(gbl_placetab[idx].my_city);
*   }
* 
* b(11);
*   return city_begins_with;
*   ;
#endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/





void bracket_string_of(
  char *any_of_these,
  char *in_string,   
  char *left_bracket,
  char *right_bracket  )
{
  int ii, k, len1, len2, is_target, are_in_run;
  char str2048[8192], currchar_as_s[4];

/*   int iii; */

/* tn();ks("in bracket_string_of()");
* ksn(any_of_these);
* ksn(in_string);
* ksn(left_bracket);
* ksn(right_bracket);
*/

  /* if NONE of the char in "any_of_these"
  *  are there in in_string, do nothing
  */
  if (snone(in_string, any_of_these) == 1) {
/* b(999); */
    return;
  };
/* b(111); */
  

  is_target  = 0;  /* 1 y, 0 n */
  are_in_run = 0;  /* 1 y, 0 n */

  strcpy(str2048, "");
/*   sfill(str2048, 2000, ' '); */

/* fill up string s with num chars, where char=c */
/* '\0' goes in (num+1)th position in s, i.e. s[num] */
/* void sfill(char *s, int num, int c) */


  /* build the new string in str2048, then copy to in_string (make big enough)
  */
  len1 = (int)strlen(in_string);
  len2 = (int)strlen(any_of_these);
/* b(10); */
  for (ii=0; ii <= len1 - 1; ii++) {

    currchar_as_s[0] = in_string[ii];
    currchar_as_s[1] = '\0';

    /* determine if this char is a target char in any_of_these
    *  set is_target
    */
    is_target = 0;
    for (k=0; k <= len2 - 1; k++) {
      if (in_string[ii] == any_of_these[k]) is_target = 1;
    }

/* kin(ii); kc(in_string[ii]); ki(is_target); */

    if ((is_target == 1  &&  are_in_run == 1)  /* no change */
    ||  (is_target == 0  &&  are_in_run == 0) ){ 
/* b(11); */
/* iii = strlen(str2048); kin(iii); */

      strcat(str2048, currchar_as_s);
    }

    if (is_target == 1  &&  are_in_run == 0) {
/* b(12); */
/* iii = strlen(str2048); kin(iii); */

      are_in_run = 1;   /* copy left bracket in, then char */
      strcat(str2048, left_bracket);
      strcat(str2048, currchar_as_s);
    }
    if (is_target == 0  &&  are_in_run == 1) { 
/* b(14); */
/* iii = strlen(str2048); kin(iii); */
      are_in_run = 0;   /* copy right bracket in, then char */
      strcat(str2048, right_bracket);
      strcat(str2048, currchar_as_s);
    }
  } /* for each char in in_string */
/* b(15); */
  /* at the end of string, check if are_in_run,
  *  if so, put in the char first and right bracket
  */
  if (are_in_run == 1) {
/* b(16); */
    are_in_run = 0;
    strcat(str2048, right_bracket);
  }

/* b(17); */
  strcpy(in_string, str2048);
/* b(18); */
/* trn("final string");ks(in_string); */

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



// from incocoa.c   place stuff

// char city_begins_with[40];
/* char prov_begins_with[40]; */
/* char coun_begins_with[40]; */

//
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
//* /* ABANDONED seq is fast enough */
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
//} /* end of possilyGetSearchResults1() */
//




// this fn ONLY returns these
//                strcpy(psvTimezoneDiff, "0");  /* should not happen */
//                strcpy(psvLongitude,  "0.0");
// as THIS ARG
//     sprintf(retDiffLong, "%s|%s", psvTimezoneDiff, psvLongitude);
//
// This is called for birth data city/prov/coun already accepted by app
// Uses idx into gbl_placetab to return a PSV of "hoursDiff|Longitude"
// or "-1" if not found  in arg retDiffLong
//
void seq_find_exact_citPrvCountry(char *retDiffLong, char *psvCity, char *psvProv, char *psvCountry) {
   
    //tn();trn("in seq_find_exact_citPrvCountry ");
    //    ksn(psvCity);ks(psvProv);ks(psvCountry);
    
    char cityInPlacetab[64], provInPlacetab[64], counInPlacetab[64],psvTimezoneDiff[16], psvLongitude[16];
    int idx_of_found_city, idx_of_prov, idx_of_coun;
    idx_of_found_city = bin_find_first_city1(psvCity);   /* in gbl_placetab[]  NOTE: is "begins with" */
    
    if (idx_of_found_city ==  -1) {   /* not found */
        //  b(20);
        // should not happen  -  use Greenwich long and 0 timezone diff
        strcpy(psvTimezoneDiff, "0");
        strcpy(psvLongitude, "0.0");
    } else {
        //b(21);

        // same city name like Springfield might be in multiple Provs
        // move down cities with exact name  psvName
        // checking for same Prov  and  same Country
        //  #define NKEYS_PLACE (sizeof gbl_placetab / sizeof(struct my_place_fields))
        // {"Spring", 103, 175, "-23.47", "-2"},   <----  cityCSV
        // {"Spring", 2948, 228, "95.25", "6"},
        //
        for (int icit = idx_of_found_city; icit <  gbl_nkeys_place; icit++) {
            
            strcpy(cityInPlacetab, gbl_placetab[icit].my_city);
            idx_of_prov          = gbl_placetab[icit].idx_prov;
            idx_of_coun          = gbl_placetab[icit].idx_coun;
            // check if city is equal
            if (strcmp(cityInPlacetab, psvCity) == 0) {
                //      trn("found city");ks(cityInPlacetab);
                
                // here we are on a row with correct city
                // check if prov is equal
                strcpy(provInPlacetab, array_prov[idx_of_prov]);
                if (strcmp (provInPlacetab, psvProv) == 0) {
                 
                    // here we are on a row with correct city and prov
                    // check if coun is equal
                    strcpy(counInPlacetab, array_coun[idx_of_coun]);
                    if (strcmp (counInPlacetab, psvCountry) == 0) {
                      
                        // here -all  cit,prv,cou match we are DONE
                        strcpy(psvTimezoneDiff, gbl_placetab[icit].my_hrs_diff);
                        strcpy(psvLongitude,    gbl_placetab[icit].my_long);
                        break;
                
                    } else {  /* city and prov match, coun does not  -  try next city in placetab */
                        continue;
                    }
                } else {  /* city matches, prov does not  -  try next city in placetab */
                    continue;
                }
            } else {                           /* city  does not match */
                strcpy(psvTimezoneDiff, "0");  /* should not happen */
                strcpy(psvLongitude,  "0.0");
                break;                         /* return Greenwich */
            }
            
        } // for each placetab record = target city (arg psvCity)
        
    } // city begins with is found
    
    sprintf(retDiffLong, "%s|%s", psvTimezoneDiff, psvLongitude);
    //ksn(retDiffLong);
    
} // seq_find_exact_citPrvCountry
    

void domap(char *str_to_map, int whichnum, char *map_or_unmap) {
  int oij;
 char map1beg[129] = "GPl^Couzd95m\"}KI\\BqnDa@=y/';~_F%:bv[N2VO`1iH#34SWgM0,r?]w<8cf)j&U6>k*.e-X(+JA$YsEQhxLt7ZTp!| R{";
 char mystr35[67]  = "Lorem ipsum calor sit amet, consecr adipi elit. Nam cursus. Morbi";
 char map1end[118] = ":\\ZvygiqnW$G#VY?7Kh`Hj.&BF[~b4Dw O^2ETcX/*re+o5fAzNauJ'p@9_>]xL|{I0C!m83PM)kl%(<U6}\"tQd=;sS,1-R";
 char mystr36[137] = "Lorem ipsum calor sit amet, consecr adipi elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at";
 char map2beg[101] = "?*2KY(v{06l<'d8=E!:i\\nw-#B,JCecsS@>Fk\"I|Z7PyXDT_)G.o1}5~+tR%L[^Wh;pH`U9Ou4Vmx/bA 3MNq]&$gQzfjar";
 char mystr37[17]  = "Lorem ipsum c";
 char map2end[177] = "o!{XK}0.5ZFqfQ-_~G`AT#d;\"U4nz%+\\mP,(tk8'lwx/aHN^2C*h9?pRJv3=D@IM6 1uYEW)|biy&Vg>$eSLrj:<sc[OB7]";

//     char map1beg[129] = "GPlCouzd95mKIBqnDay/_FbvN2VO1iH#34SWgM0,rw8cfj&U6k.e-X+JAYsEQhxLt7ZTp! R";
//     char mystr35[67]  = "Lorem ipsum calor sit amet, consecr adipi elit. Nam cursus. Morbi";
//     char map1end[118] = "ZvygiqnWG#VY7KhHj.&BFb4Dw O2ETcX/re+o5fAzNauJp9_xLI0C!m83PMklU6tQdsS,1-R";
//     char mystr36[137] = "Lorem ipsum calor sit amet, consecr adipi elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at";
//     char map2beg[101] = "2KYv06ld8E!inw-#B,JCecsSFkIZ7PyXDT_G.o15+tRLWhpHU9Ou4Vmx/bA 3MNq&gQzfjar";
//     char mystr37[17]  = "Lorem ipsum c";
//     char map2end[177] = "o!XK0.5ZFqfQ-_GAT#dU4nz+mP,tk8lwx/aHN2Ch9pRJv3DIM6 1uYEWbiy&VgeSLrjscOB7";

    
  char workstr[252];

/* ksn(str_to_map); */
/* kin(whichnum); */
/* ksn(map_or_unmap); */

  sfill(workstr, 250, '\0');
  oij = (int)strlen(mystr35);
  oij = (int)strlen(mystr36);
  oij = (int)strlen(mystr37);
  if (whichnum == 1) {
    if (strcmp(map_or_unmap, "map") == 0) {
      for (int i = 0; i < strlen(str_to_map); i++) {
        for (int j = 0; j < strlen(map1beg); j ++) {   // find char in map1beg
          if (str_to_map[i] == map1beg[j] ) {
            memcpy(workstr + i, map1end + j, 1);   // write corresponding char into result
            break; // write and get next letter 
          }
        }
      }
      strcpy(str_to_map, workstr);
      return;
    }
    if (strcmp(map_or_unmap, "unmap") == 0) {
      for (int i = 0; i < strlen(str_to_map); i++) {
        for (int j = 0; j < strlen(map1end); j ++) {   // find char in map1end
          if (str_to_map[i] == map1end[j] ) {
            memcpy(workstr + i, map1beg + j, 1);   // write corresponding char into result
            break; // write and get next letter 
          }
        }
      }
      strcpy(str_to_map, workstr);
      return;
    }
  }
  if (whichnum == 2) {
    if (strcmp(map_or_unmap, "map") == 0) {
      for (int i = 0; i < strlen(str_to_map); i++) {
        for (int j = 0; j < strlen(map2beg); j ++) {   // find char in map2beg
          if (str_to_map[i] == map2beg[j] ) {
            memcpy(workstr + i, map2end + j, 1);   // write corresponding char into result
            break; // write and get next letter 
          }
        }
      }
      strcpy(str_to_map, workstr);
      return;
    }
    if (strcmp(map_or_unmap, "unmap") == 0) {
      for (int i = 0; i < strlen(str_to_map); i++) {
        for (int j = 0; j < strlen(map2end); j ++) {   // find char in map2end
          if (str_to_map[i] == map2end[j] ) {
            memcpy(workstr + i, map2beg + j, 1);   // write corresponding char into result
            break; // write and get next letter 
          }
        }
      }
      strcpy(str_to_map, workstr);
      return;
    }
  }

} // end of  domap(int whichnum, char *str_to_map) {


/* end of mambutil.c */
