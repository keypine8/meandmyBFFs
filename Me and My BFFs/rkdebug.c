/* rkdebug.c */

#include <stdio.h>
#include <ctype.h>

FILE *fpdb;
void fopen_fpdb_for_debug(void);
void fclose_fpdb_for_debug(void);

int fpdb_is_open = 0; /* yes=1, n0=0 */

/* put me in main(). output file for debug code */
void fopen_fpdb_for_debug(void) {
  if (fpdb_is_open == 1) return; 
/*   fpdb = fopen("t.out","a"); */
  fpdb = stderr;
  fpdb_is_open = 1;
  ;
}
void fclose_fpdb_for_debug(void) {
/* it's going to stderr, not to a file, so never close it */

/*   if (fpdb_is_open == 0) return;  */
/*   fclose(fpdb) ; */
/*   fpdb_is_open = 0; */
  ;
}


/* comment out debug code ****************************  */
#ifdef COMMENTOUT
 rkdebug.h code here

fpdb = fopen("t.out","w");/* put me in main(). output file for debug code */
== or ==
fpdb = stderr; /* put me in main(). output file for debug code */

then,   close me
fclose(fpdb);

#endif
/* end of comment out debug code ****************************  */

/*
 convenient "k" functions with only 1 arg
 rkdebug.c functions taking advantage of ansi stringizing.
 the "k" fns call the usual "t" fns.
 */

#define kcn(c) tcn(#c,c)
#define kc(c)  tc(#c,c)

#define kin(i) tin(#i,i)
#define ki(i)  ti(#i,i)
#define nkin(i) ntin(#i,i)
#define nki(i)  nti(#i,i)
#define kdn(d) tdn(#d,d)
#define kd(d)  td(#d,d)
#define kXn(i) tXn(#i,i)
#define kX(i)  tX(#i,i)
#define kun(u) tun(#u,u)
#define ku(u)  tu(#u,u)
//#define kr(u)  tr(#u)
//#define krn(u) trn(#u)



void tspec(void);

void b  (int nrk);
void bn (int nrk);
void nb (int nrk);
void nbn(int nrk);
void tdn(char *srk, double xrk);
void td (char *srk, double xrk);
void Xtd(char *srk, double xrk);

void tcn(char *srk, char irk);
void tc (char *srk, char irk);
void Xtc(char *srk, char irk);

void tin(char *srk, int irk);
void ti (char *srk, int irk);
void ntin(char *srk, int irk);
void nti (char *srk, int irk);
void Xti(char *srk, int irk);
void Xn (char *srk, int irk);
void tX (char *srk, int irk);
void Xtx(char *srk, int irk);
void tun(char *srk, unsigned irk);
void tu (char *srk, unsigned irk);
void Xtu(char *srk, unsigned irk);
void Xts(char *srk, char *s2rk);
void tmn(char *srk, char *addr, int num);
void tm (char *srk, char *addr, int num);
void Xtm(char *srk, char *addr, int num);
void tbn(char *srk, char *addr, int num);
void tb (char *srk, char *addr, int num);
void Xtb(char *srk, char *addr, int num);
void ta (char *srk, int *pirk, int num);
void tn (void);
/* void tc (int nrk, int every); */
void trn(char *srk);
void tr (char *srk);
void Xtr(char *srk);


// int RKDEBUG=0;  /* =0 turns off output in all these debug functions */
int RKDEBUG=1;  /* =1 turns on   output in all these debug functions */

void tspec(void) { } 

int NL;  /* 0/1 put a newline or not at the beginning of displayed stuff */
int NL2;  /* 0/1 put a newline or not at the ending   of displayed stuff */

void b(int nrk)  {
    static int ctr;
    if(RKDEBUG) {
        if(++ctr > 26) {
            fprintf(fpdb,"\n");
            ctr=1;
        }
        fprintf(fpdb,"%3d!",nrk);
        //fflush(fpdb);}
    }
}
void nb (int nrk)  { if(RKDEBUG) {fprintf(fpdb,"\n%3d!"  ,nrk);} }
void bn (int nrk)  { if(RKDEBUG) {fprintf(fpdb,"%3d!\n"  ,nrk);} }
void nbn(int nrk)  { if(RKDEBUG) {fprintf(fpdb,"\n%3d!\n",nrk);} }

/*  for examining a string */
#define ks(s)   ts(#s,s)
#define nks(s)  nts(#s,s)
#define ksn(s)  tsn(#s,s)
#define nksn(s) ntsn(#s,s)

void ts  (char *srk, char *s2rk);
void nts (char *srk, char *s2rk);
void tsn (char *srk, char *s2rk);
void ntsn(char *srk, char *s2rk);

void ts  (char *srk, char *s2rk) {NL=0;NL2=0; Xts(srk,s2rk);}
void nts (char *srk, char *s2rk) {NL=1;NL2=0; Xts(srk,s2rk);}
void tsn (char *srk, char *s2rk) {NL=0;NL2=1; Xts(srk,s2rk);}
void ntsn(char *srk, char *s2rk) {NL=1;NL2=1; Xts(srk,s2rk);}
void Xts (char *srk, char *s2rk) {
    if(RKDEBUG) {
        fprintf(fpdb,"%s_%s=[%s]__%s",(NL?"\n":""),srk,s2rk,(NL2?"\n":"")); fflush(fpdb); }
}

//// can't work  (call NSLog() )
//// // #import <Foundation/Foundation.h>
////#import <Foundation>
//#define oksn(s) otsn(#s,s)
//void oXts(char *srk, char *s2rk);
//void otsn(char *srk, char *s2rk);
//void otsn(char *srk, char *s2rk) {NL=1; oXts(srk,s2rk);}
////NSString *stringFromUTFString;
//void oXts(char *srk, char *s2rk) {
//    if(RKDEBUG) {
//        // fprintf(fpdb,"%s_%s=[%s]__",(NL?"\n":""),srk,s2rk); fflush(fpdb);
//        //      stringFromUTFString= [[NSString alloc] initWithUTF8String:s2rk];
//        NSLog(@"@%%@=%@", srk, @(s2rk));
//        // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
//
//    }
//}

//
//- (void) oXts:(NSString *)string_to_display {
//
//}


/*  for examining a double */
    void tdn(char *srk, double xrk) {
        NL=1;
        Xtd(srk,xrk);
    }
    void td( char *srk, double xrk) {
        NL=0; Xtd(srk,xrk); }
    void Xtd(char *srk, double xrk)  {
        if(RKDEBUG) {
            fprintf(fpdb,"%s_%s=[%-9.4g]__",(NL?"\n":""),srk,xrk); fflush(fpdb); }
    }
/*  for examining a char */
void tcn(char *srk, char crk) {NL=1; Xtc(srk,crk);}
void tc (char *srk, char crk) {NL=0; Xtc(srk,crk);}
void Xtc(char *srk, char crk) {
  if(RKDEBUG) {
    fprintf(fpdb,"%s_%s=[%c]__",(NL?"\n":""),srk,crk); fflush(fpdb); }
}
/*  for examining an integer */
void ti  (char *srk, int irk) {NL=0;NL2=0; Xti(srk,irk);}
void tin (char *srk, int irk) {NL=0;NL2=1; Xti(srk,irk);}
void nti (char *srk, int irk) {NL=1;NL2=0; Xti(srk,irk);}
void ntin(char *srk, int irk) {NL=1;NL2=1; Xti(srk,irk);}
void Xti(char *srk, int irk) {
  if(RKDEBUG) {
    fprintf(fpdb,"%s_%s=[%-d]__%s",(NL?"\n":""),srk,irk,(NL2?"\n":"")); fflush(fpdb); }
}
/*  for examining an integer displayed in hex */
void Xn( char *srk, int irk) {NL=1; Xtx(srk,irk);}
void tX( char *srk, int irk) {NL=0; Xtx(srk,irk);}
void Xtx(char *srk, int irk) {
  if(RKDEBUG) {
    fprintf(fpdb,"%s_%s=[%4X]__",(NL?"\n":""),srk,irk); fflush(fpdb); }
}
/*  for examining an unsigned integer */
void tun(char *srk, unsigned irk) {NL=1; Xtu(srk,irk);}
void tu( char *srk, unsigned irk) {NL=0; Xtu(srk,irk);}
void Xtu(char *srk, unsigned irk) {
  if(RKDEBUG) {
    fprintf(fpdb,"%s_%s=[%u]__",(NL?"\n":""),srk,irk); fflush(fpdb); }
}

/*  for examining num chars in mem */
 void tmn(char *srk, char *addr, int num) {NL=1; Xtm(srk,addr,num);}
void tm( char *srk, char *addr, int num) {NL=0; Xtm(srk,addr,num);}
void Xtm(char *srk, char *addr, int num) {
  int n,i;
  unsigned char *p = addr;
  char wk[512+1];
  if(RKDEBUG) {
    n = sprintf(wk,"%s_%s_for_%d=[",(NL?"\n":""),srk,num);
    fwrite(wk,n,1,fpdb);
    for (n=0; n <= num-1; n++) {
      if (isprint(*(p+n))) {
        putc(*(p+n),fpdb);
      } else {
        if (*(p+n) == 0) {
          putc(0xf9,fpdb);
        } else {
          i = sprintf(wk,"'%X'",*(p+n));
          fwrite(wk,i,1,fpdb);
        }
      }
    }
    fwrite("]",1,1,fpdb);
  }
}  


/*  for examining num bytes in mem in binary */
/* 
* void tbn(char *srk, char *addr, int num) {NL=1; Xtb(srk,addr,num);}
* void tb( char *srk, char *addr, int num) {NL=0; Xtb(srk,addr,num);}
* void Xtb(char *srk, char *addr, int num) {
*   register int n,i;
*   register unsigned char *p = addr;
*   char wk[512+1];
*   if(RKDEBUG) {
*     n = sprintf(wk,"%s_%s_for_%d=[",(NL?"\n":""),srk,num);
*     fwrite(wk,n,1,fpdb);
*     fflush(fpdb);
*     for (n=0; n <= num-1; n++) {
*       i = sprintf(wk,"`%08b'",*(p+n));
*       fwrite(wk,i,1,fpdb);
*       fflush(fpdb);
*     }
*     fwrite("]",1,1,fpdb);
*     fflush(fpdb);
*   }
* }
*/

/*  for examining an array of num ints */
void ta(char *srk, int *pirk, int num) 
{
  char wk[32];
  register int i;
  ;
  if(RKDEBUG) {
    i = sprintf(wk,"\n_array_%s_for_%d=[",srk,num);
    fwrite(wk,i,1,fpdb);
    fflush(fpdb);
    for (i=1; i <= num; ++i) {
      b(*(pirk+i-1));
      fflush(fpdb);
    }
    fwrite("]__",1,1,fpdb);
    fflush(fpdb);
  }
}

/* put out a \n   blank line */
void tn(void) { if(RKDEBUG) { fprintf(fpdb,"\n"); fflush(fpdb); } }

/* (nrk=0 THRU 9 ONLY) */
/* puts n! every "every" times thru */
/* void tc(int nrk, int every) { static int Ctr[10]; ; */
/*   if(RKDEBUG){if(((Ctr[nrk])%every) == 0) {  tspec(); b(nrk); */
/*   fprintf(fpdb,"[%d]!",Ctr[nrk]);}(Ctr[nrk])++;fflush(fpdb);} */
/* } */

/*  for displaying a string (Remark) */
void tr( char *srk)  {NL=0;NL2=0; Xtr(srk);}
void ntr(char *srk)  {NL=1;NL2=0; Xtr(srk);}
void trn(char *srk)  {NL=0;NL2=1; Xtr(srk);}
void ntrn(char *srk) {NL=1;NL2=1; Xtr(srk);}
void Xtr(char *srk) {
  if(RKDEBUG) {
    fprintf(fpdb,"%s_(%s)__%s",(NL?"\n":""  ),srk,(NL2?"\n":"")); fflush(fpdb); }
}


/* /user/rk/c/rkdebug.c */
