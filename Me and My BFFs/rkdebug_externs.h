/* rkdebug_externs.h   included in futdefs.h */

/* #endif * #define RKDEBUG_H   #include GUARD  *  */

#include <stdio.h>
#include <ctype.h>

extern FILE *fpdb;
extern int fpdb_is_open;  /* yes=1, n0=0 */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);

extern void tspec(void);

extern void b  (int nrk);
extern void bn (int nrk);
extern void nb (int nrk);
extern void nbn(int nrk);
extern void tdn(char *srk, double xrk);
extern void td (char *srk, double xrk);
extern void Xtd(char *srk, double xrk);
extern void tin(char *srk, int irk);
extern void ti (char *srk, int irk);
extern void ntin(char *srk, int irk);
extern void nti (char *srk, int irk);
extern void Xti(char *srk, int irk);
extern void Xn (char *srk, int irk);
extern void tX (char *srk, int irk);
extern void Xtx(char *srk, int irk);
extern void tun(char *srk, unsigned irk);
extern void tu (char *srk, unsigned irk);
extern void Xtu(char *srk, unsigned irk);
extern void tsn(char *srk, char *s2rk);
extern void ts (char *srk, char *s2rk);
extern void ntsn(char *srk, char *s2rk);
extern void nts (char *srk, char *s2rk);
extern void Xts(char *srk, char *s2rk);

extern void tcn(char *srk, char irk);
extern void tc (char *srk, char irk);
extern void Xtc(char *srk, char irk);

extern void tmn(char *srk, char *addr, int num);
extern void tm (char *srk, char *addr, int num);
extern void Xtm(char *srk, char *addr, int num);
extern void tbn(char *srk, char *addr, int num);
extern void tb (char *srk, char *addr, int num);
extern void Xtb(char *srk, char *addr, int num);
extern void ta (char *srk, int *pirk, int num);
extern void tn (void);
/* extern void tc (int nrk, int every); */
extern void tr (char *srk);
extern void trn(char *srk);
extern void ntr(char *srk);
extern void ntrn(char *srk);
extern void Xtr(char *srk);


#define kcn(c) tcn(#c,c)
#define kc(c)  tc(#c,c)

#define ksn(s) tsn(#s,s)
#define ks(s)  ts(#s,s)
#define nksn(s) ntsn(#s,s)
#define nks(s)  nts(#s,s)

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
#define kr(u)  tr(#u)
#define krn(u) trn(#u)

/* end of rkdebug_externs.h */
