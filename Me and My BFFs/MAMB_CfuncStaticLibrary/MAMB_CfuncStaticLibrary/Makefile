# Makefile  (simplemakefile)

# .SUFFIXES: .c .exe
# .c.exe
#   gcc -o $@  $&  -I.

# "-I." says find ".h" in current dir
# "-L gets rid of these errs:
# /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../i686-pc-cygwin/bin/ld: cannot find -luser32
# /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../i686-pc-cygwin/bin/ld: cannot find -lkernel32
# /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../i686-pc-cygwin/bin/ld: cannot find -ladvapi32
# /usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../i686-pc-cygwin/bin/ld: cannot find -lshell32
#

# rkdebug.h in multiple files:
#  - rkdebug.c  compiled to  rkdebug.o
#  - rkdebug.o linked to fut.exe
#  - #include rkdebug_externs.h  is in futdefs.h,
#      which is included in setasp.c and fut.c
#

#  mkinput2.exe:    mkinput2.obj
#    $* is the base     name of the output file (mkinput2)
#    $@ is the complete name of the output file (mkinput2.exe)
#    $& is the complete list of prerequisites for a target
#    $^ is the list of prerequisites given in the rule that contains
#         the recipe make is executing
#    $< macro ("first dependency")
# the internal macro $< refers to the first prerequisite and $@ refers to the target.

# "-c"      --> no linker, produce ".o" object file
# "-o" pgm  --> output exe filename
# -Winvalid-pch  warn if precompiled hdr, ".h..gch" is there but cannot be used
#

# these would not link fut.exe (?)
#    had to put explicit lines below every target
# .SUFFIXES: .c .o .exe
#
# .c.o:
# 	$(CC) $^  $(CFLAGS)  -c
# .o.exe:
# 	$(CC) $^  $(CFLAGS)  -o $@

# -Wextra ?  -Wall
#CFLAGS=-I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib -Winvalid-pch -fdump-translation-unit-options-slim
#
#CFLAGS=-I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib -Winvalid-pch -ansi -Wall
#CFLAGS=-I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib -Winvalid-pch -ansi
#CFLAGS=-I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib -Winvalid-pch

#CFLAGS=-I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib -Winvalid-pch
#CFLAGS=-I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib -Winvalid-pch -ansi -Wall
#CFLAGS=-I. -Winvalid-pch -ansi -Wall
CFLAGS=-I. -Winvalid-pch -Wall

#CC=/bin/gcc
#CC=/usr/bin/clang -v   # see link errs with -v
CC=/usr/bin/clang 

#all: rktest.o rktest.exe rungmcr.o rungmcr.exe rkdebug.o \
# 	grpdoc.o grp.o
#	perdoc.o perhtm.o per.o \
#	gmcrutil.o futasp.o futdoc.o futhtm.o fut.o \
# incocoa.o abymutil.o rkdebug.o \

all: rktest.exe rktest.o \
	incocoa.exe \
	incocoa.o mambutil.o rkdebug.o \
	futdoc.o futhtm.o futasp.o \
	perdoc.o perhtm.o  \
	grpdoc.o grphtm.o

#	$(CC) $^  $(CFLAGS)  -c
# 	grpdoc.o grphtm.o grp.exe

rkdebug.o:   rkdebug.c
	$(CC) $^  $(CFLAGS)  -c
rktest.o:    rktest.c rk.h
	$(CC) $^  $(CFLAGS)  -c
grpdoc.o:     grpdoc.c rk.h grpdoc.h
	$(CC) $^  $(CFLAGS)  -c
grphtm.o:     grphtm.c rk.h
	$(CC) $^  $(CFLAGS)  -c
perdoc.o:    perdoc.c rk.h perdoc.h
	$(CC) $^  $(CFLAGS)  -c
perhtm.o:    perhtm.c rk.h perhtm.h
	$(CC) $^  $(CFLAGS)  -c
mambutil.o:  mambutil.c
	$(CC) $^  $(CFLAGS)  -c
futasp.o:    futasp.c futdefs.h
	$(CC) $^  $(CFLAGS)  -c
futdoc.o:    futdoc.c rk.h futdoc.h futdefs.h
	$(CC) $^  $(CFLAGS)  -c
futhtm.o:    futhtm.c futdefs.h futhtm.h
	$(CC) $^  $(CFLAGS)  -c
incocoa.o:   incocoa.c rk.h incocoa.h
	$(CC) $^  $(CFLAGS)  -c

rktest.exe:  rktest.o
	$(CC) $(CFLAGS) $^ -o $@

incocoa.exe: incocoa.o mambutil.o perdoc.o perhtm.o \
	futdoc.o futasp.o futhtm.o   grpdoc.o grphtm.o rkdebug.o
	$(CC) $(CFLAGS) $^ -o $@


#grp.exe:      gmcrutil.o grpdoc.o grphtm.o rkdebug.o
#	$(CC) $(CFLAGS) $^ -o $@

#incocoa.o:   incocoa.c incocoa.h
#grp.o:     gmcrutil.o grpdoc.o          rkdebug.o
#	$(CC) $(CFLAGS) $^ -o $@
#per.o:     gmcrutil.o perdoc.o perhtm.o rkdebug.o
#	$(CC) $(CFLAGS) $^ -o $@
#fut.o:     gmcrutil.o futasp.o futdoc.o futhtm.o rkdebug.o
#	$(CC) $(CFLAGS) $^ -o $@
#incocoa.exe: per.o fut.o grp.o incocoa.o rkdebug.o
#incocoa.exe: incocoa.o gmcrutil.o grpdoc.o rkdebug.o


# comp.obj:       $(rkhdr) comp.c comp.h compdefs.h comptabs.h
# comp.exe:       comp.obj calcchrt.obj

# pp.obj:         $(rkhdr) pp.c pp.h pp_defs.h pp_tabs.h
# pp.exe:         pp.obj calcchrt.obj



# all: rktest.o rktest.exe runfut.o runfut.exe rkdebug.o \
# rkdebug.o:  rkdebug.c
# 	$(CC) $^  $(CFLAGS)  -c
# fut.exe:     calcchrt.o futasp.o futdoc.o rkdebug.o
# tfr.o:       tfr.c
#	$(CC) $^  $(CFLAGS)  -c
#	
#	/bin/gcc $(CFLAGS) $^ -o fut.exe
#	/bin/gcc $(CFLAGS) calcchrt.o futasp.o futdoc.o -o fut.exe
#	/bin/gcc -I. -L /usr/i686-pc-mingw32/sys-root/mingw/lib   calcchrt.o futasp.o futdoc.o -o fut.exe
#fut.exe:     calcchrt.o futasp.o futdoc.o

# FUT  name changes
# setaspsm.c              --> futasp.c
# as_defsm.h              --> futdefs.h
#
# futursm2.c + futursmb.c --> futdoc.c
# futuresm.h + futtblsm.h --> futdoc.h
#
# NEW FUT
# futasp.o:    futasp.c futdefs.h
# futdoc.o:    futdoc.c rk.h futdoc.h futdefs.h
# futhtm.o:    futhtm.c rk.h
# fut.exe:     calcchrt.o futasp.o futdoc.o futhtm.o
#
# OLD FUT
# setaspsm.obj:   rk.h setaspsm.c as_defsm.h
# futursm2.obj:   futursm2.c futursmb.c rk.h futuresm.h futtblsm.h as_defsm.h
#
# futursm2.exe:   futursm2.obj calcchrt.obj setaspsm.obj


# mks make: only does 1st one without the line below.
# all01new : calcchrt.obj setaspsm.obj \
# 		pp.obj comp.obj futursm2.obj \
#  		futursm2.exe pp.exe comp.exe
# 		
#
# calcchrt.obj:   $(rkhdr) calcchrt.c
# setaspsm.obj:   $(rkhdr) setaspsm.c as_defsm.h
# pp.obj:         $(rkhdr) pp.c pp.h pp_defs.h pp_tabs.h
# comp.obj:       $(rkhdr) comp.c comp.h compdefs.h comptabs.h
# futursm2.obj:   futursm2.c futursmb.c $(rkhdr) futuresm.h futtblsm.h as_defsm.h
# futursm2.exe:   futursm2.obj calcchrt.obj setaspsm.obj
# pp.exe:         pp.obj calcchrt.obj
# comp.exe:       comp.obj calcchrt.obj



# <.>
# CC     = gcc
#     CFLAGS = -g
#
#     all: helloworld
#
#     helloworld: helloworld.o
#             # Commands start with TAB not spaces
#             $(CC) $(LDFLAGS) -o $@ $^
#
#     helloworld.o: helloworld.c
#             $(CC) $(CFLAGS) -c -o $@ $<
#
# <.>

# $(CC) -o $*.c  $(CFLAGS)

# /bin/gcc -o rktest.exe rktest.c  -I.
#
# all:
#	gcc -o rktest.exe  rktest.c  -I.
#	$(CC) -o rktest.exe rktest.c  $(CFLAGS)
#
# this RAN on cygwin command line:
#
#      gcc -o rktest.exe rktest.c -I.

# rktest2.o:   rktest2.c rk.h
# rktest2.exe: rktest2.o calcchrt.o
#	$(CC) -c  $^  $(CFLAGS)

# end of Makefile
