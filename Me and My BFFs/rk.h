/* rk.h */

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



//#define APP_NAME "\"Me ooo oo BFFs\""
#define APP_NAME "\"Me and my BFFs\""



/* ptr to end of str s (last char- not \0)  bbb */
#define PENDSTR(s) (&(s)[strlen((s))-1])
/* do as v (any lvalue) (can be ptr) goes from lo to hi inclusive */
#define RKDO(v,lo,hi) for((v)=(lo);(v)<=(hi);(v)++)
/* return 1 if v is between lo and hi inclusive */
#define RKISBETWEEN(v,lo,hi) ((((v)>=(lo))&&((v)<=(hi)))?1:0)

/******* BIT STUFF 
*   conventions u is an unsigned quantity, mask is hex like below
*       *** masks ***
*   #define _FILE_MODIFIED  0x10
*   #define _USED      0x40
*   #define _FILE_BUSY    0x80
******/
/* sets to 1 in u the bits that are set to 1 in mask */
#define RKBITON(u,mask) ((u)=(u)|(mask))
/* sets to 0 in u the bits that are set to 1 in mask */
#define RKBITOFF(u,mask) ((u)=(u)&~(mask))
/* returns 1 if bit is on, 0 if bit is off. */
#define RKBITTST(u,mask) ((((u)&(mask))==0)?0:1)

#define rkequal(s1,s2) ((strcmp(s1,s2)==0)?1:0)

/***
fread(buf,size,nitems,fp) returns num items successfully read
fget returns number of bytes read (0 for eof)
fput returns number of bytes written
***/
/* #define fget(buf,size,fp) fread (buf,1,size,fp) */
#define fput(buf,size,fp) fwrite(buf,1,size,fp)

/* to replace qnx "abort(msg)" */
#define rkabort(msg) {fprintf(stderr,"%s", msg); exit(1);}

/* #define _eq_ == */
/* #define _ne_ != */
/* #define _gt_ > */
/* #define _ge_ >= */
/* #define _lt_ < */
/* #define _le_ <= */
/* #define _andif_ && */
/* #define _orif_ || */
/* #define NULLPTR ((char *)0) */
/* #define RKYES 1 */
/* #define RKNO 0 */

/* is tab or space */
/* #define ISTS(c) ((strchr(" \t",(c))==NULL)?0:1) */
/* is tab or space or newline */
/* #define ISTSN(c) ((strchr(" \t\n",(c))==NULL)?0:1) */
/* copies a struct to another struct of the same type */
/* (make sure they're the same type) */
/* #define CPYSTRUCT(d,s) memcpy((&d),(&s),sizeof(s)); */
/* step thru string until null */
/* #define SSTEP(s,prk) for((prk)=(s);(*prk)!='\0';(prk)++) */
/* sleep for v ticks (other tasks get cpu during sleep) */
/* #define SLEEPTICK(v) (set_timer(TIMER_WAKEUP,ABSOLUTE,(v)) */
/* puts num chars = c into buffer s.  Adds '\0' at end */
/* #define SFILL(s,num,c) {memset(s,c,num);*(s+num)='/0';} */
/************
* WARNING: this fgetline #define does not return the number of chars read.
* fgets returns NULL at eof, fgetline returns 0 (chars read)
************/
/* #define fgetline(fp,buf,maxlen) fgets(buf,maxlen+1,fp) */

/* end of rk.h */
