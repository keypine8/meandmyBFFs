//
//  MAMB09AppDelegate.h
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>

// global variables
//

// arrays with fixed info
//NSArray *gbl_mambReportsPerson;
//NSArray *gbl_mambReportsGroup;
//NSArray *gbl_mambReportsPair;
//
NSArray *gbl_mambReports;
//        @"pcy|Calendar Year ...",             // person reports
//        @"ppe|Personality",
//        @"pco|Compatibility Paired with ...",
//        @"pbm|My Best Match in Group ...",
//        @"pwc|What Color is Today? ...",
//        @"p|",
//        @"gbm|Best Match",                    // group reports
//        @"g|",
//        @"gma|Most Assertive Person",
//        @"gme|Most Emotional",
//        @"gmr|Most Restless",
//        @"gmp|Most Passionate",
//        @"gmd|Most Down-to-earth",
//        @"gmu|Most Ups and Downs",
//        @"g|",
//        @"gby|Best Year ...",
//        @"gbd|Best Day ...",
//        @"2co|Compatibility Potential",       // pair reports
//        @"2|",
//        @"2bm|<per1> Best Match",
//        @"21p|<per1> Personality",
//        @"21c|<per1> Calendar Year ...",
//        @"2|",
//        @"22m|<per2> Best Match",
//        @"22p|<per2> Personality",
//        @"22c|<per2> Calendar Year ...",
//

NSArray *gbl_arrayExaGrp;
NSArray *gbl_arrayExaPer;
NSArray *gbl_arrayExaMem;
NSArray *gbl_arrayExaGrpRem;
NSArray *gbl_arrayExaPerRem;


BOOL gbl_show_example_data;

UIColor *gbl_colorReportsBG;
UIColor *gbl_colorSelParamForReports;
UIColor *gbl_colorEdit;

// EXAMPLE data arrays
//NSMutableArray *gbl_arrayExaGrp;
//NSMutableArray *gbl_arrayExaPer;
//NSMutableArray *gbl_arrayExaMem;
//NSMutableArray *gbl_arrayExaGrpRem; // REMEMBER EXAMPLE DATA 
//NSMutableArray *gbl_arrayExaPerRem; // REMEMBER EXAMPLE DATA 
//

// data arrays
NSMutableArray *gbl_arrayGrp;
NSMutableArray *gbl_arrayPer;
NSMutableArray *gbl_arrayMem;
NSMutableArray *gbl_arrayGrpRem; // REMEMBER DATA 
NSMutableArray *gbl_arrayPerRem; // REMEMBER DATA 

    // REMEMBER DATA for each Group 
    //     field 1  name-of-group
    //     field 2  last report selected for this Group:
    //              ="gbm"  for   "Best Match"
    //              ="gma"  for   "Most Assertive Person"
    //              ="gme"  for   "Most Emotional"
    //              ="gmr"  for   "Most Restless"
    //              ="gmp"  for   "Most Passionate"
    //              ="gmd"  for   "Most Down-to-earth"
    //              ="gmu"  for   "Most Ups and Downs"
    //              ="gby"  for   "Best Year ..."
    //              ="gbd"  for   "Best Day ..."
    //     field  3  year       last selection for this report parameter for this Group
    //     field  4  day        last selection for this report parameter for this Group
    //     + extra "|" at end
    // 
    //NSArray *arrayMAMBexampleGroupRemember = 
    // REMEMBER DATA for each Person
    //     field 1  name-of-person
    //     field 2  last report selected for this Person:
    //              ="pcy"  for   "Calendar Year ...",
    //              ="ppe"  for   "Personality",
    //              ="pco"  for   "Compatibility Paired with ...",
    //              ="pbm"  for   "My Best Match in Group ...",
    //              ="pwc"  for   "What color is today? ...",
    //     field 3  year
    //     field 4  person (this is 2nd person for rpt pco|Compatibility Paired with ...)
    //                      NOT home, which is saved with   file for  myLastEntityStr, mambd1
    //     field 5  group
    //     field 6  day
    //              extra "|" at end
    //
    //NSArray *arrayMAMBexamplePersonRemember = 



// get file stuff
//
  // get Document directory as URL and Str
NSFileManager *gbl_sharedFM;
NSArray       *gbl_possibleURLs;
NSURL         *gbl_appDocDirURL;
NSString      *gbl_appDocDirStr;

  // get DB names as URL and Str
NSString *gbl_pathToGroup;
NSString *gbl_pathToPerson;
NSString *gbl_pathToMember;
NSString *gbl_pathToGrpRem; //  the app can "remember" what to put highlight on for what was last selected.
NSString *gbl_pathToPerRem; //  the app can "remember" what to put highlight on for what was last selected.

NSURL    *gbl_URLToGroup;
NSURL    *gbl_URLToPerson;
NSURL    *gbl_URLToMember;
NSURL    *gbl_URLToGrpRem; //  the app can "remember" what to put highlight on for what was last selected.
NSURL    *gbl_URLToPerRem; //  the app can "remember" what to put highlight on for what was last selected.



// Pick from arrays
NSMutableArray *gbl_arrayPersonsToPickFrom;
NSInteger       gbl_currentYearInt;

// Report Parameters
NSString  *gbl_fromHomeCurrentSelectionPSV;     // PSV  for per or grp or pair of people
NSInteger  gbl_fromHomeCurrentSelectionArrayIdx;
NSString  *gbl_fromHomeCurrentSelectionType;    // like "group" or "person" or "pair"
NSString  *gbl_fromHomeCurrentEntity;           // like "group" or "person" or "member"
NSString  *gbl_fromHomeCurrentEntityName;       // like "~Anya" or "~Swim Team"
NSString  *gbl_fromHomeRememberedPSV;      // collect this when user taps on a home table cell

// NSString *gbl_fromSelRptRowPSV;      // PSV from select person tableview
// NSString *gbl_fromSelRptRowString;  // like "Personality" or "Calendar Year"
//

// The last selected thing by the user of Me and My BFFs.
// The "remember" fields (suffix "Rem") are saved to file when
//   1. user changes any data
//   2. applicationDidEnterBackground
//
// used when switching segmented control on home page from  grp to per  or  per to grp
//   or initial setting of highlight for last selection 
NSString *gbl_lastSelectedGroup;   // like "~Family"
NSString *gbl_lastSelectedPerson;  // like "~Dave"
NSString *gbl_lastSelectedYear;
NSString *gbl_lastSelectedDay;
NSString *gbl_lastSelectedPerson; 
NSString *gbl_lastSelectedReportGroup;  // gbm,gma,gme,gmr,gmp,gmd,gmu,gby,gbd 
NSString *gbl_lastSelectedReportPerson; // pbm,pcy,ppe,pco,pbg,pwc 

NSString *gbl_lastSelectionType;    // like "group" or "person" or "pair"   (also saved as file mambd1)

// NSString *gbl_selectedPersonFromPair; // from selPersonFromPairViewController

NSString *gbl_html_file_name_browser;
NSString *gbl_html_file_name_webview;

NSString *gbl_pathToFileToBeEmailed;
NSString *gbl_person_name;  // for email
NSString *gbl_person_name2; // for email group-of-2 report


NSIndexPath *gbl_savePrevIndexPath;  // for scrolling to the prev row you were on when coming back to tableview

// end of global variables


//@interface MAMB09AppDelegate : UIResponder <UIApplicationDelegate, NSCoding>
@interface MAMB09AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)  NSString *myLastEntityStr;


- (NSString *) updateDelimitedString: (NSMutableString *) DSV
                   delimitedBy: (NSString *) delimiters
      updateOneBasedElementNum: (NSInteger)  oneBasedElementnum
                withThisString: (NSString *) newString
;

- (void)            saveLastSelectionForEntity: (NSString *) personOrGroup
                                    havingName: (NSString *) entityName
                      updatingRememberCategory: (NSString *) rememberCategory
                                    usingValue: (NSString *) changeToThis
;
//- (NSUInteger *) lastSelectionGrabForEntity: (NSString *) personOrGroup  // returns idx in tbl
//- (NSUInteger *) lastSelTblIdxForEntity: (NSString *) personOrGroup  // returns idx in tbl
//returns returns selection value   "cyr", "gbm", etc...
- (NSString *) grabLastSelectionValueForEntity: (NSString *) personOrGroup 
                                    havingName: (NSString *) entityName
                          fromRememberCategory: (NSString *) rememberCategory
;


- (NSString *) mambMapString: (NSString *) argStringToMap
           usingWhichMapping: (NSInteger ) whichMapping
             doingMapOrUnmap: (NSString *) mapOrUnmap
;

- (NSData *) mambKriptOnThisNSData:  (NSData *)  argMyNSData;
- (NSData *) mambKriptOffThisNSData: (NSData *)  argMyNSData ;

- (void) mambWriteLastEntityFile;      // for home, 1 grp  or per, which one
- (NSString *) mambReadLastEntityFile;

- (void) mambWriteNSArrayWithDescription:  (NSString *) argEntityDescription; // like "group","examplegroup" ...
- (void) mambReadArrayFileWithDescription: (NSString *) argEntityDescription; // like "group","person" ... (no example)


- (BOOL)isJailbroken;

@end

// old  stuff

//- (void) mambWriteLastEntityFileIntoDir: (NSString *)      argAppDocDirStr
//                       usingFileManager: (NSFileManager *) argSharedFM
//;
//- (NSString *) mambReadLastEntityFileFromDir: (NSString *)      argAppDocDirStr
//                            usingFileManager: (NSFileManager *) argSharedFM
//;

//
//- (void) mambWriteGroupArray: (NSArray *) argGroupArray;
//- (void) mambReadGroupFile;
//- (void) mambWritePersonArray: (NSArray *) argPersonArray;
//- (void) mambReadPersonFile;
//- (void) mambWriteMemberArray: (NSArray *) argMemberArray;
//- (void) mambReadMemberFile;
//

//- (void) mambWriteGrpRemArray: (NSArray *) argGrpRemArray;   // REMEMBER DATA for each Group 
//- (void) mambReadGrpRemFile;                                 // REMEMBER DATA for each Group 
//- (void) mambWritePerRemArray: (NSArray *) argPerRemArray;   // REMEMBER DATA for each Person 
//- (void) mambReadPerRemFile;                                 // REMEMBER DATA for each Person 
//

//2015-01-26 13:38:11.319 Me and My BFFs[4100:1602597] in applicationWillResignActive()  in appdelegate
// applicationWillResignActive()  
//   - home button  + didenterback
//   - power off  + didenterback
//   - dbl click home only will resign  when slide out, didenterback

//NSURL    *gbl_URLToGrpExa;
//NSURL    *gbl_URLToPerExa;
//NSURL    *gbl_URLToMemExa;
//
//NSString *gbl_pathToGrpExa;
//NSString *gbl_pathToPerExa;
//NSString *gbl_pathToMemExa;
//

//
//NSString *gbl_pathToGroupLastGood; // lastGood are backups if reg files are somehow bad
//NSString *gbl_pathToPersonLastGood;
//NSString *gbl_pathToMemberLastGood;
//
//NSURL    *gbl_URLToGroupLastGood;
//NSURL    *gbl_URLToPersonLastGood;
//NSURL    *gbl_URLToMemberLastGood;
//

//MAMB09AppDelegate *gbl_myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method in appDelegate .h and .m
//
//
//UIApplication *myApplication;
//MAMB09AppDelegate *gbl_myappDelegate=[myApplication delegate]; // to access global method in appDelegate .h and .m
//
//(AppDelegate.UIApplication.SharedApplication) *gbl_myappDelegate;
//(AppDelegate)UIApplication.SharedApplication.Delegate *gbl_myappDelegate;
//(AppDelegate)UIApplication.SharedApplication.Delegate *gbl_myappDelegate;

