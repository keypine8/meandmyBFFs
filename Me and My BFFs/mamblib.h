/* mamblib.h */
/* c stuff referenced from Me and My BFFs */


// #include "incocoa.h"  // its in mambutil.c


#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#include "rkdebug_externs.h"
#include "rk.h"
#include <time.h>
#include <sys/time.h>



/* these are in rkdebug.o */
extern void fopen_fpdb_for_debug(void);
extern void fclose_fpdb_for_debug(void);

extern void mk_new_date(double *pm, double *pd, double *py, double dstep);   /* in futasp.o */

/* in mambutil.o */
extern void domap(char *str_to_map, int whichnum, char *map_or_unmap);
extern void scharswitch(char *s, char ch_old, char ch_new);
extern void scharout(char *s,int c); 
extern char *csv_get_field(char *csv_string, char *delim, int want_fieldnum);
extern void sfill(char *s, int num, int c);

#define PREFIX_HTML_FILENAME "m_"          /* Me and my BFFs */
#define MAX_SIZE_PERSON_NAME  15

/* trait_report_line array declarations */
struct trait_report_line {
    int  rank_in_group;
    int  score;
    char person_name[MAX_SIZE_PERSON_NAME+1];
};
/*   char score_color[4];   * "vhi","hi","avg","lo","vlo" * */
struct rank_report_line {      /* info for html file production */
    int  rank_in_group;
    int  score;
    char person_A[MAX_SIZE_PERSON_NAME+1];
    char person_B[MAX_SIZE_PERSON_NAME+1];
};


extern void g_trait_line_free(
  struct trait_report_line *out_trait_lines[],  /* output param returned */
  int trait_line_last_used_idx
);
extern void g_rank_line_free(
  struct rank_report_line *out_rank_lines[], 
  int rank_line_last_used_idx               
);

/* for place lookup 
*/
#define MAX_IN_PLACES_SEARCH_RESULTS1 25    /* num returned on search into array */

// extern int gbl_num_elements_array_coun;
// extern int gbl_num_elements_array_prov;
// extern int gbl_numkeys_place;

extern int bin_find_first_city(char *begins_with); /* in gbl_placetab[] */ /* in mambutil.o */
extern struct my_place_fields  *gbl_search_results1[MAX_IN_PLACES_SEARCH_RESULTS1];
extern int gblIdxLastResultsAdded;  /*  index of the last place written in gbl_search_results1 */
extern int gbl_is_first_results1_put; /* 1=y, 0=n */
extern int gbl_num_cities_found;
extern int gbl_num_provinces_found;
extern int gbl_num_countries_found;
extern void places_result1_put(struct my_place_fields place_struct);
extern void places_result1_free(void);
extern int  get_results1_using_city(char  *city_begins_with);
extern char *get_first_city_name(char *city_begins_with);
extern int possiblyGetSearchResults1( /* into gbl_search_results1[] */
                                  /* and gblIdxLastResultsAdded */
  char *city_begins_with,
  int  starting_index_into_cities,
  int  max_in_places_search_results1   /* 10 */
);

extern char *set_cell_bg_color(int in_score) ;
extern void seq_find_exact_citPrvCountry(char *retDiffLong, char *psvCity, char *psvProv, char *psvCountry);


/* end of PLACE functions  */

/* char gbl_hdr_1[512]; */
/* char gbl_hdr_2[512]; */
extern void get_mbrs_from(char *grpmbr_file, int *num_in_grp);
extern void csv_person_put(char *str, int length);
extern void csv_person_free(void); 


/* REPORT CALLS */

extern int mamb_report_personality(       /* in perdoc.o */
  char *html_file_name_webview,
  char *html_file_name_browser,
  char *csv_person_string,    /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *instructions,  /* like "return only csv with all trait scores",  */
  char *stringBuffForTraitCSV
);
extern int mamb_report_year_in_the_life(  /* in futdoc.o */
                                        char *html_f_file_name,
                                        char *csv_person_string,    /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
                                        char *year_todo_yyyy,
                                        char *instructions,  /* like  "return only year stress score" */
                                        char *stringBuffForStressScore
                                        );
extern int mamb_BIGreport_year_in_the_life(  /* in futdoc.o */
                                        char *html_f_file_name,
                                        char *csv_person_string,    /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
                                        char *year_todo_yyyy,
                                        char *instructions,  /* like  "return only year stress score" */
                                        char *stringBuffForStressScore
                                        );
extern int mamb_report_just_2_people(      /* in grpdoc.o */
  char *pathToHTML_browser,
  char *pathToHTML_webview,
  char *person_1_csv,         /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  char *person_2_csv
);
extern int  mamb_report_person_in_group(  /* in grpdoc.o */ 
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],
  int  num_persons_in_grp,
  char *csv_compare_everyone_with,  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  struct rank_report_line *rank_lines[], /* array of output report data */
  int  *rank_idx           /* ptr to int having last index written */
);
extern int mamb_report_whole_group(   /* in grpdoc.o */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  struct rank_report_line *rank_lines[],      /* output param returned */
  int  *rank_idx,                             /* output param returned */
  char *instructions,
  char *string_for_table_only  /* 1024 chars max (its 9 lines formatted) */
);
extern int mamb_report_trait_rank(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *trait_name,
/*   struct rank_report_line *rank_lines[],  */
/*   int  *rank_idx, */
  struct trait_report_line *trait_lines[],   /* array of output report data */
  int  *trait_idx            /* ptr to int having last index written */                   
);
extern int mamb_report_best_year(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyy_todo, 
  struct trait_report_line *trait_lines[],   /* array of output report data */
  int  *trait_idx            /* ptr to int having last index written */                   
);
extern int mamb_report_best_day(    /* in grpdoc.c */
  char *html_file_name,
  char *group_name,
  char *in_csv_person_arr[],  /* fmt= "Fred,3,21,1987,11,58,1,5,80.34" */
  int  num_persons_in_grp,
  char *yyyymmdd_todo, 
  struct trait_report_line *trait_lines[],   /* array of output report data */
  int  *trait_idx            /* ptr to int having last index written */                   
);

/* end of mamblib.h */
