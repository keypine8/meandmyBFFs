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

//MAMB09AppDelegate *gbl_myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method in appDelegate .h and .m
//
//
//UIApplication *myApplication;
//MAMB09AppDelegate *gbl_myappDelegate=[myApplication delegate]; // to access global method in appDelegate .h and .m
//
//(AppDelegate.UIApplication.SharedApplication) *gbl_myappDelegate;
//(AppDelegate)UIApplication.SharedApplication.Delegate *gbl_myappDelegate;
//(AppDelegate)UIApplication.SharedApplication.Delegate *gbl_myappDelegate;

BOOL gbl_didThisAppJustLaunch;
BOOL gbl_show_example_data;

UIColor *gbl_colorReportsBG;
UIColor *gbl_colorSelParamForReports;
UIColor *gbl_colorEdit;

// data arrays
NSMutableArray *gbl_arrayGrp;
NSMutableArray *gbl_arrayPer;
NSMutableArray *gbl_arrayGrM;

// Pick from arrays
NSMutableArray *gbl_arrayPersonsToPickFrom;
NSInteger       gbl_currentYearInt;

// Report Parameters
 NSString *gbl_fromHomeCurrentSelectionPSV;     // PSV  for per or grp or pair of people
 NSString *gbl_fromHomeCurrentSelectionType;    // like "group" or "person" or "pair"
 NSString *gbl_fromHomeCurrentEntity;           // like "group" or "person" or "groupmember"


 NSString *gbl_fromSelRptRowPSV;      // PSV from select person tableview
 NSString *gbl_fromSelRptRowString;  // like "Personality" or "Calendar Year"

// The last selected thing by the user of Me and My BFFs.
//
// Note: in the database,  each person record will have year,day,person,group
// and each group record will have year,day,person.
// That way, the app can "remember" what to put highlight on for what was last selected.
// The "remember" fields are saved when
//   1. user changes any data
//   2. applicationDidEnterBackground
//
NSString *gbl_selectedYear;
NSString *gbl_selectedDay;
NSString *gbl_selectedPerson;
NSString *gbl_selectedGroup;

// NSString *gbl_selectedPersonFromPair; // from selPersonFromPairViewController

NSString *gbl_html_file_name_browser;
NSString *gbl_html_file_name_webview;

NSString *gbl_pathToFileToBeEmailed;

// end of global variables


@interface MAMB09AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSString *) updateDelimitedString: (NSMutableString *) DSV
                   delimitedBy: (NSString *) delimiters
      updateOneBasedElementNum: (NSInteger)  oneBasedElementnum
                withThisString: (NSString *) newString
;
- (void) rememberSelectionForEntity: (NSString *) personOrGroup
                         havingName: (NSString *) entityName
           updatingRememberCategory: (NSString *) rememberCategory
                         usingValue: (NSString *) changeToThis
;




@end
