//  MAMB09AppDelegate.h
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>
         
//    The viewController life cycle are 
//
//    loadView
//    viewDidLoad
//    viewWillAppear
//    viewWillLayoutSubviews
//    viewDidLayoutSubviews
//    viewDidAppear
//    .................
//    viewWillDisappear
//    viewDidDisappear
//    viewWillAppear
//    viewWillLayoutSubviews
//    viewDidLayoutSubviews
//    viewDidAppear
//

// global variables
//

//NSInteger gbl_firstResponder_curr_is__NAME;   OLD
//NSInteger gbl_firstResponder_curr_is__CITY;
//NSInteger gbl_firstResponder_curr_is__DATE;
//NSInteger gbl_firstResponder_prev_was_NAME;
//NSInteger gbl_firstResponder_prev_was_CITY;
//NSInteger gbl_firstResponder_prev_was_DATE;
//
NSString *gbltmpstr; // for debug
NSInteger gbltmpint; // for debug

// cell.accessoryType = UITableViewCellAccessoryDisclosurebutton;    // home mode edit    with tap giving record details 
// cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // home mode regular with tap giving report list
//
NSString *gbl_homeUseMODE;      // "edit mode" (yellow)   or   "regular mode" (blue)
NSString *gbl_homeEditingState; // if gbl_homeUseMODE = "edit mode"    then can be "add" or "view or change"   for tapped person or group
// no, i think  // if gbl_homeUseMODE = "regular mode" then can be "add" or nil                for tapped person or group


// THE THREE  "FIELDS"  =======================================================
//
//     UITextField *gbl_myname;              // for add new person or group
//     UILabel     *gbl_mycityprovcounLabel; // for display found city,prov,coun
//     UITextField *gbl_mybirthinformation;  // for add new person
//
// THE THREE  "FIELDS"  =======================================================

// UILabel *gbl_disclosureIndicatorLa®bel;  // set in appdel .m   DID NOT WORK moved setting from appdel .m to each lcl_


NSInteger gbl_justLookedAtInfoScreen;
NSInteger gbl_justAddedPersonRecord;
NSInteger gbl_justAddedGroupRecord;


NSInteger gbl_starsNSInteger;
NSString *gbl_starsNSString;
NSString *gbl_starsWhiteSpaces;
//NSInteger gbl_compIsInHowBig;   // for setting how big section to color Neu

NSMutableAttributedString *gbl_attrStrWrk_11 ;  //  tread on eggshells
NSMutableAttributedString *gbl_attrStrWrk_12 ;  //  tread on eggshells
NSMutableAttributedString *gbl_attrStrWrk_13 ;  //  tread on eggshells
NSMutableAttributedString *gbl_attrStrWrk_14 ;  //  tread on eggshells
NSMutableAttributedString *gbl_attrStrWrk_15 ;  //  tread on eggshells

CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
                                // 6s  = 667.0 x 375  and 6
                                // 5s  = 568.0 x 320  and 5 
                                // 4s  = 480.0 x 320 

NSString  *gbl_pairScore   ;
NSString  *gbl_pairPersonA ;
NSString  *gbl_pairPersonB ;
NSInteger  gbl_topTableWidth ;
NSInteger  gbl_topTableNamesWidth;
NSString  *gbl_topTablePairLine ;

CGFloat   gbl_heightForCompTable;
NSInteger gbl_areInCompatibilityTable;  // 1=y,0=n
NSInteger gbl_ThresholdshortTblLineLen;

BOOL      gbl_disclosureSetAlready;


// EDITING stuff
//

UIImage *gbl_YellowBG ;
UIImage *gbl_BlueBG ;
UIImage *gbl_blueDone ;
UIImage *gbl_yellowEdit ;
UIColor *gbl_bgColor_blueDone;
UIColor *gbl_bgColor_yellowEdit;


//NSInteger addChangeViewJustEntered;  // 1=y,0=n
NSInteger gbl_justEnteredAddChangeView;  // 1=y,0=n
NSInteger gbl_citySetEditingValue;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
NSInteger gbl_citySetPickerValue;   // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
NSInteger gbl_citySetLabelValue;    // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
//NSInteger gbl_citySetValue;   // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
NSInteger gbl_dateSetEditingValue;  // 1=y,0=n  // set initial values when first entering Date in "edit mode"  yellow


// this is set when person record is saved in savedone button choice
// also set when person record is read in   in addchange when method global var fldKindOfSave is also set
// 
NSString *gbl_kindOfSave;   // "regular save"  or  "high security save"


// all 4 of these have possible values  "name" or "city" or "date" or "" or nil
//
NSString *gbl_firstResponder_previous;
NSString *gbl_firstResponder_current;
NSString *gbl_fieldTap_leaving; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
NSString *gbl_fieldTap_goingto; // note that name and city are captured in should/did editing, date in viewForRow uipickerview


UIColor *gbl_bgColor_editFocus_NO;    // white
UIColor *gbl_bgColor_editFocus_YES;   // something else

// in local vars
//char gbl_allowedCharactersInName[128] = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
//char gbl_allowedCharactersInCity[128] = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-";

//NSString    *incomingNameAtBegOfAddChange;  // when 
UITextField *gbl_myname;              // for add new person or group         // one of THE THREE  "FIELDS"  =====
UITextField *gbl_mycitySearchString;  // for add new person  SEARCH STRING
UILabel     *gbl_mycityprovcounLabel; // for display found city,prov,coun    // one of THE THREE  "FIELDS"  =====
NSString    *gbl_mycityInputView;     // = "keyboard" or "picker" (purpose is to reflect which one it is- not assigned)

NSInteger gbl_numCityLines;        // = 1 or 2 or 3

NSString *gbl_initPromptName;  // for values, see appdel .m
NSString *gbl_initPromptCity;
NSString *gbl_initPromptProv;
NSString *gbl_initPromptCoun;
NSString *gbl_initPromptDate;
UIColor  *gbl_colorPlaceHolderPrompt; // gray

UIColor  *gbl_colorDIfor_home;
UIColor  *gbl_colorDIfor_cGr2;
UIColor  *gbl_colorDIfor_cGre;
UIColor  *gbl_colorDIfor_cNeu;
UIColor  *gbl_colorDIfor_cRed;
UIColor  *gbl_colorDIfor_cRe2;

    // there are 3 possible  toolbar looks  For City inputView  accessory
    //
    //    gbl_ToolbarForCityPicklist                "< Keyboard"   tor     -noButton-
    //    gbl_ToolbarForCityKeyboardWithNoPicklist  "Clear"        tor     -noButton-
    //    gbl_ToolbarForCityKeyboardHavingPicklist  "Clear"        tor     "Picklist >" 
    // 
//NSInteger gbl_lastPicklistSelectedRownum;  // any picklist

//UIBarButtonItem *gbl_searchStringTitle;     // set in appdel .m
UIBarButtonItem *gbl_title_personName;     // set in appdel .m
UIBarButtonItem *gbl_title_groupName;     // set in appdel .m
UIBarButtonItem *gbl_title_cityPicklist;     // set in appdel .m
UIBarButtonItem *gbl_title_cityKeyboard;     // set in appdel .m
UIBarButtonItem *gbl_title_birthDate;     // set in appdel .m
UIBarButtonItem *gbl_flexibleSpace;            // set in appdel .m

UIBarButtonItem *gbl_nameButtonToClearKeyboard; //  @"Clear Person Name"   
UIBarButtonItem *gbl_cityButtonToClearKeyboard; //  @"Clear City"   
UIBarButtonItem *gbl_cityButtonToGetKeyboard  ; //  @"< Keyboard "   
UIBarButtonItem *gbl_dateButtonToClearKeyboard; //  @"Clear Birth Date"   

UIToolbar       *gbl_ToolbarForGroupName;
UIToolbar       *gbl_ToolbarForPersonName;
UIToolbar       *gbl_ToolbarForCityPicklist;
UIToolbar       *gbl_ToolbarForCityKeyboard;
UIToolbar       *gbl_ToolbarForBirthDate;

NSArray *gbl_buttonArrayForGroupName;
NSArray *gbl_buttonArrayForPersonName;
NSArray *gbl_buttonArrayForPicklist;
NSMutableArray *gbl_buttonArrayForKeyboard;  // mutable to show/hide picklist button
NSArray *gbl_buttonArrayForBirthDate;

UITextField *gbl_mybirthinformation;  // for add new person    // one of THE THREE  "FIELDS"  =====

NSInteger gbl_previousCharTypedWasSpace; // for no multiple consecutive spaces
CGFloat   gbl_widthForLabelsForCityProvCoun;

NSString *gbl_lastInputFieldTapped;  // 3 values are: "name", "city", "date"

NSString *gbl_pickerToUse;  //  =  "city picker" or "date/time picker"


// While user is typing search string for City
// a new tableview picklist comes up when the number of cities found is <= gbl_numCitiesToTriggerPicklist
// BUT  only if the user pauses typing for  gbl_numSecondsToTriggerPicklist  seconds (about 1.5 sec)
//
// Idea is to not interrupt user typing valid characters for finding his City.
//
//NSTimer  *gbl_timerToCheckCityPicklistTrigger;   qOLD
NSInteger gbl_fewEnoughCitiesToMakePicklist;  // if = 1, put up picklist if pause OK
int       gbl_numCitiesToTriggerPicklist;     // is type  int  for passing to C function
// qOLD
//double    gbl_numSecondsToTriggerPicklist;    // providing numcities starting with typed so far is <= gbl_numCitiesToTriggerPicklist
//double    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist;  // 2.0
//double    gbl_frequencyOfCheckingCityPicklistTrigger;         // 0.5  max wait = 2.5 when stop typing and picklist OK
//double    gbl_timeOfPrevCityKeystroke;        // set when user types a letter in city name (CFTimeInterval/CACurrentMediaTime is a double)
//double    gbl_timeOfCurrCityKeystroke;        // set when user types a letter in city name (CFTimeInterval/CACurrentMediaTime is a double)

//NSDate   *gbl_timeOfPrevCityKeystroke;        // set when user types a letter in city name
//NSDate   *gbl_timeOfCurrCityKeystroke;        // set when user types a letter in city name

//NSString *gbl_typedCharPrev;   // for test
//NSString *gbl_typedCharCurr;   // for test
//double    gbl_intervalBetweenLast2Keystrokes;
//double    gbl_secondsSinceCurrCityKeyStroke;   // used when typing city name
NSString *gbl_currentCityPicklistIsForTypedSoFar;  // like "toron"  or "toro"



// Add screen navigation
//
//  name  inputview = KB
//  city  inputview = KB, then changes to city picker
//  date  inputview = date picker


//  You use these constants when setting the value of the accessoryType property.
//    typedef enum : NSInteger {
//       UITableViewCellAccessoryNone,
//       UITableViewCellAccessoryDisclosureIndicator,    tapping the cell triggers a push action
//       UITableViewCellAccessoryDetailDisclosureButton, tapping the cell allows the user to configure the cell’s contents
//       UITableViewCellAccessoryCheckmark,
//       UITableViewCellAccessoryDetailButton 
//    } UITableViewCellAccessoryType;
//
NSInteger  gbl_home_cell_AccessoryType;        // in regular mode =  UITableViewCellAccessoryDisclosureIndicator
NSInteger  gbl_home_cell_editingAccessoryType; 
NSInteger  gbl_home_cell_editingAccessoryView; // in editing mode =  UITableViewCellAccessoryDetailDisclosureButton





NSInteger gbl_editingChangeNAMEHasOccurred;
NSInteger gbl_editingChangeCITYHasOccurred;
NSInteger gbl_editingChangeDATEHasOccurred;

// at beginning of entering edit mode 
// or  selecting a new record
NSString *gbl_initialName; 
NSString *gbl_initialCity; 
NSString *gbl_initialProv;
NSString *gbl_initialCoun;
NSString *gbl_initialDate; 
NSString *gbl_initialGroup; 

// as user types along / edits along  ...
// these are the entered/selected new values
//
// 1 of 5  gbl_myname.text
NSString *gbl_enteredCity; // to update 3 place labels
NSString *gbl_enteredProv; // to update 3 place label
NSString *gbl_enteredCoun; // to update 3 place labels
// 5 of 5  gbl_selectedBirthInfo

// these vars take into account "placeholder" prompt  which makes these vars = @"".
NSString *gbl_DisplayName;
NSString *gbl_DisplayCity;
NSString *gbl_DisplayProv;
NSString *gbl_DisplayCoun;
NSString *gbl_DisplayDate;

NSString *gbl_myCitySoFar; // for city letters typed so far  +  not found  err msg
NSInteger gbl_CITY_NOT_FOUND;     // in placetab

//
// end of EDITING stuff





NSInteger gbl_shouldUseDelayOnBackwardForeward;  // = 1 (0.5 sec  on what color update)
                                                 // = 0 (no delay on first show of screen)
UIToolbar *gbl_toolbarForwBack;       // for what color
UIToolbar *gbl_toolbarMemberAddDel;   // for group member list screen
CGFloat    gbl_listMemberToolbar_y;   // to set y offset of bottom toolbar on list members screen

NSMutableArray *gbl_selectedMembers_toAdd;
NSMutableArray *gbl_selectedMembers_toDel;
NSInteger  gbl_justWroteMemberFile;  // 1=y,0=n

NSIndexPath *gbl_IdxPathSaved_SelPerson;          // for highlight previous choice when come back to SelPerson
NSIndexPath *gbl_TBLRPTS1_saveSelectedIndexPath;  // for deselecting with animation when return to TBLRPTS1

//
NSInteger gbl_MAX_groups;               //  50 max in app
NSInteger gbl_MAX_persons;              // 250 max in app and max in group
NSInteger gbl_MAX_personsInGroup;       // max 250 members in a Group
//NSInteger gbl_maxGrpBirthinfoCSVs;   // max 250 members in a Group

NSInteger gbl_MAX_lengthOfName;          //  15 (applies to Person and Group both)
NSInteger gbl_MAX_lengthOfCity;


NSInteger gbl_maxLenBirthinfoCSV;    // max len of birthinfo CSV for a Group Member is 64 chars
NSInteger gbl_maxGrpRptLines;        // max 333 cells in app tableview 
NSInteger gbl_maxLenRptLinePSV;      // max len of report data PSV for a cell is 128 chars
                                     //   example: 128 "cGre"/"cRe2" |  "  1  Anya_   Liz_       90  Great" 

// not used   NSInteger gbl_MAX_size_CSV;  // like  "elena,5,17,1984,7,52,1,-2,-25.44" 


//<.>
NSMutableArray *gbl_grp_CSVs;   // report call input
NSMutableArray *gbl_grp_CSVs_B;   // report call input


// per and comp report stuff  (new uitableview versions)
//
NSArray *gbl_perDataLines;   // used in tblrpts_1 (read in from webview . html file)
NSArray *gbl_compDataLines;  // used in tblrpts_1 (read in from webview . html file)
NSArray *gbl_traitDataLines;  // used in tblrpts_1 MOST trait reports   (read in from webview . html file)
NSInteger gbl_heightCellPER;
NSInteger gbl_heightCellCOMP;
// endof per report stuff


// group report stuff
//
NSString       *gbl_thisCellBackGroundColorName;
UIColor        *gbl_thisCellBackGroundColor;
NSMutableArray *gbl_array_cellBGcolorName;      // has max group_report_output_idx + 1 entries (there are more rows on the report bottom)
//NSString       *gbl_traitCellBGcolorName;
NSMutableArray *gbl_array_cellPersonAname;  // for passing to sel rpt B title
NSMutableArray *gbl_array_cellPersonBname;  // for passing to sel rpt B title
NSMutableArray *gbl_array_cellBGcolorName_B;
NSMutableArray *gbl_array_cellPersonAname_B;  // for ?
NSMutableArray *gbl_array_cellPersonBname_B;  // 
NSString       *gbl_selectedCellPersonAname;  // used in sel rpt B title
NSString       *gbl_selectedCellPersonBname;  // used in sel rpt B title
//NSString       *gbl_selectedCellPersonAname_B;  // used ?
//NSString       *gbl_selectedCellPersonBname_B;  // ?
// NSString  *gbl_nonKingpinPerson;  // single person name for "My Best Match in grp ..." reports

//NSString  *gbl_nameOfPerson_1_OfPair;     // single person name for "My Best Match in grp ..." reports
//NSString  *gbl_nameOfPerson_2_OfPair;     // single person name for "My Best Match in grp ..." reports

NSString  *gbl_kingpinPersonName;
NSString  *gbl_kingpinPersonName_B;       // internal to MAMB09viewTBLRPTs_2_TableViewController.m


NSInteger  gbl_numPairsRanked;            // (for column header size calc)
NSString  *gbl_myCharsForRankNumsOnLeft;
NSString  *gbl_myCharsForRankNumsOnLeft_B;
NSString  *gbl_myFillSpacesInColHeaders;
NSString  *gbl_myFillSpacesInColHeaders_B;
NSInteger  gbl_numLeadingSpacesToRemove;
NSInteger  gbl_numLeadingSpacesToRemove_B;
NSInteger  gbl_myCellAdjustedTextLen;
NSInteger  gbl_myCellAdjustedTextLen_B;
NSInteger  gbl_numPeopleInCurrentGroup;
NSInteger  gbl_kingpinIsInGroup;
NSInteger  gbl_kingpinIsInGroup_B;


NSString  *gbl_highestTraitScore;             // this goes in INFO for personality
NSString  *gbl_highestTraitScoreDescription;  // like @"Assertive"


// arrays with fixed info
//

NSString *gbl_currentMenuPrefixFromHome;     // this is one of "homp" or "homg" (see below)
NSString *gbl_currentMenuPrefixFromMatchRpt; // this is one of "gbm"  or "pbm"  (see below)

NSArray *gbl_mambReports;  // all reports in all report selection menus

NSString *gbl_currentMenuPlusReportCode;   // should be called gbl_currentSourcePlusReportCode - source is either menu or tap person
          // this (gbl_currentMenuPlusReportCode) is SET in didSelectRow in SElRPT1 or SELRPT2 (see  "RPT[ 12]-" below)
//
// ---------------------------------------------------------------------------------------------------------
// MIND MAP       All Report Menu Screens     (table reports are RPT1         and          RPT2) 
// ---------------------------------------------------------------------------------------------------------
//  on home     22 RPTS come from report        report param     13 home      7 RPTs come  16 level2        
// --screen--   ----menu descriptions--------   --selection--    -RPTs------  from data--  -RPTs------       
//          
// tap person  >                                                                           MENU homp* 
//              MENU homp*
//              -----------------------------
//              Calendar Year ...             > select year    > RPT -hompcy                            LEAF
//              Personality                   >                  RPT -homppe                            LEAF
//              Compatibility Paired with ... > select person2 > RPT -hompco                            LEAF
//              Best Match for x in Group ... > select group   > RPT1-hompbm, tap pair   > MENU pbm* 
//              What Color is the Day? ...    > select day     > RPT -hompwc                            LEAF
//          
//                  MENU pbm*
//                  -------------------------
//                  Compatibility Potential   >                                            RPT =pbmco   LEAF  
//                  .
//                  select perA Personality   >                                            RPT =pbm1pe  LEAF
//                  select perB Personality   >                                            RPT =pbm2pe  LEAF
//                  .
//                  select perB's Best Match  >                                            RPT2=pbm2bm  LEAF
//          
// tap group   >                                                                           MENU homg* 
//              MENU homg*
//              -----------------------------
//              Best Match in Group           >                  RPT1-homgbm, tap pair   > MENU gbm* 
//              .
//              Most Assertive Person         >                  RPT1-homgma, tap person > RPT =gmappe  LEAF
//              Most Emotional                >                  RPT1-homgme, tap person > RPT =gmeppe  LEAF
//              Most Restless                 >                  RPT1-homgmr, tap person > RPT =gmrppe  LEAF
//              Most Passionate               >                  RPT1-homgmp, tap person > RPT =gmpppe  LEAF
//              Most Down-to-earth            >                  RPT1-homgmd, tap person > RPT =gmdppe  LEAF
//              .
//              Best Year ...                 > select year    > RPT1-homgby, tap person > RPT =gbypcy  LEAF
//              Best Day ...                  > select day     > RPT1-homgbd, tap person > RPT =gbdpwc  LEAF
//          
//                  MENU gbm*
//                  -------------------------
//                  Compatibility Potential   >                                            RPT =gbmco   LEAF 
//                  .
//                  select perA Personality   >                                            RPT =gbm1pe  LEAF
//                  select perB Personality   >                                            RPT =gbm2pe  LEAF
//                  .
//                  select perA's Best Match  >                                            RPT2=gbm1bm  LEAF
//                  select perB's Best Match  >                                            RPT2=gbm2bm  LEAF
// ---------------------------------------------------------------------------------------------------------


    // -------------------------------------------------------------------------------------------------------------------------
    // MAMB09viewTBLRPTs_1_TableViewController.m 
    // -------------------------------------------------------------------------------------------------------------------------
    //     - displays 9 RPTs  hompbm,homgbm, homgma,homgme,homgmr,homgmp,homgmd homgby,homgbd
    //
    //     - goes to 16 RPTs  from hompbm ==>  pbmco,pbm1pe,pbm2pe,       pbm2bm
    //     - goes to 16 RPTs  from homgbm ==>  gbmco,gbm1pe,gbm2pe,gbm1bm,gbm2bm
    //     - goes to 16 RPTs  from homgma ==>  gmappe
    //     - goes to 16 RPTs  from homgme ==>  gmeppe
    //     - goes to 16 RPTs  from homgmr ==>  gmrppe
    //     - goes to 16 RPTs  from homgmp ==>  gmpppe
    //     - goes to 16 RPTs  from homgmd ==>  gmdppe
    //     - goes to 16 RPTs  from homgby ==>  gbypcy
    //     - goes to 16 RPTs  from homgbd ==>  gbdpwc
    //
    // NOTE that gbl_currentMenuPlusReportCode changes when the user goes to a report from any of these 9 RPTs 
    //      so, in viewWillAppear(), when the user returns, we have to re-set  gbl_currentMenuPlusReportCode  (check it out)
    //
    //      this is 16+9=25 reports   FYI, the other 4 reports are  hompcy,homppe,hompco,hompwc
    // -------------------------------------------------------------------------------------------------------------------------


NSString *gbl_PSVtappedPerson_fromGRP;    // any of the above 14 RPTs
NSString *gbl_PSVtappedPersonA_inPair;    // hompbm,homgbm,pbmco,gbmco
NSString *gbl_PSVtappedPersonB_inPair;    // same

//NSString *gbl_PSVtappedPerson_home;    // USE gbl_fromHomeCurrentSelectionPSV INSTEAD (see below)
//NSString *gbl_PSVtappedPerson_selp;    // USE gbl_fromSelSecondPersonPSV      INSTEAD (see below)
// variable to get a group's NAME from -    USE gbl_lastSelectedGroup

// 3 vars for use inside MAMB09_viewHTMLViewController.m 
//
NSString *gbl_viewHTML_PSV_personA;     // of pair
NSString *gbl_viewHTML_PSV_personB;     // of pair
NSString *gbl_viewHTML_PSV_personJust1; // (1 from pair)  for single person reports
NSString *gbl_viewHTML_NAME_personA;     // of pair
NSString *gbl_viewHTML_NAME_personB;     // of pair
NSString *gbl_viewHTML_NAME_personJust1; // (1 from pair)  for single person reports

// 3 vars for use inside  MAMB09viewTBLRPTs_1_TableViewController.m
//
NSString *gbl_TBLRPTS1_PSV_personA;     // of pair
NSString *gbl_TBLRPTS1_PSV_personB;     // of pair
NSString *gbl_TBLRPTS1_PSV_personJust1; // for single person reports
NSString *gbl_TBLRPTS1_NAME_personA;     // of pair
NSString *gbl_TBLRPTS1_NAME_personB;     // of pair
NSString *gbl_TBLRPTS1_NAME_personJust1; // for single person reports

// 3 vars for use inside  MAMB09viewTBLRPTs_1_TableViewController.m
//
NSString *gbl_TBLRPTS2_PSV_personA;     // of pair
NSString *gbl_TBLRPTS2_PSV_personB;     // of pair
NSString *gbl_TBLRPTS2_PSV_personJust1; // for single person reports
NSString *gbl_TBLRPTS2_NAME_personA;     // of pair
NSString *gbl_TBLRPTS2_NAME_personB;     // of pair
NSString *gbl_TBLRPTS2_NAME_personJust1; // for single person reports


NSInteger gbl_numSectionIndexTitles; // for scroll bar    = mySectionIndexTitles.count;

// FYI   mind map
//
// 21 rpts need  a person selection  (p)
//  8 rpts need no person selection  (g  homg*)
//---
// 29
//
//    -----------------------------------------------------------
//    29 report navigations
//    -----------------------------------------------------------
//    13 home rpts (on left)
//        16 level2 (one tab to right)    13 + 16 = 29
//                 WHERE DISPLAYED
//    -----------------------------------------------------------
//       "now" refers to pe and co going to TBLRPT
//    -----------------------------------------------------------
//    hompcy       ViewHTML
//    homppe       ViewHTML     now TBLRPTs_1
//    hompco       ViewHTML     now TBLRPTs_1
//    hompbm       TBLRPTs_1
//        pbmco    ViewHTML     now TBLRPTs_2
//        pbm1pe   ViewHTML     now TBLRPTs_2
//        pbm2pe   ViewHTML     now TBLRPTs_2
//        pbm2bm   TBLRPTs_2
//    hompwc       ViewHTML
//
//    homgbm       TBLRPTs_1
//        gbmco    ViewHTML     now TBLRPTs_2
//        gbm1pe   ViewHTML     now TBLRPTs_2
//        gbm2pe   ViewHTML     now TBLRPTs_2
//        gbm1bm   TBLRPTs_2
//        gbm2bm   TBLRPTs_2
//    homgma       TBLRPTs_1
//        gmappe   ViewHTML     now TBLRPTs_2
//    homgme       TBLRPTs_1
//        gmeppe   ViewHTML     now TBLRPTs_2
//    homgmr       TBLRPTs_1
//        gmrppe   ViewHTML     now TBLRPTs_2
//    homgmp       TBLRPTs_1
//        gmpppe   ViewHTML     now TBLRPTs_2
//    homgmd       TBLRPTs_1
//        gmdppe   ViewHTML     now TBLRPTs_2
//    homgby       TBLRPTs_1
//        gbypcy   ViewHTML 
//    homgbd       TBLRPTs_1
//        gbdpwc   ViewHTML
//
//    -----------------------------------------------------------
//    29 report destinations
//    -----------------------------------------------------------
//                 ViewHTML  displays 17 report destinations   now  4
//                 TBLRPTs_1 displays  9 report destinations   now 11
//                 TBLRPTs_2 displays  3 report destinations   now 14
//                                   ---                          ---
//                                    29                           29
//    -----------------------------------------------------------
//
//    -------------------------
//    8 report types
//    -------------------------
//         cy      2 rpts   p
//         pe     10 rpts   p
//         co      3 rpts   p
//         grpone  4 rpts   p
//         wc      2 rpts   p
//         grpall  1 rpts   g  homg*
//         most    5 rpts   g  homg*
//         best    2 rpts   g  homg*
//               ---
//                29 rpts
//               ---
//    -------------------------
//<.>
//  hompcy
//  homppe
//  hompco
//  hompbm
//  hompwc
//
//  pbmco
//  pbm1pe
//  pbm2pe
//  pbm2bm
//
//  homgbm
//
//  homgma
//  homgme
//  homgmr
//  homgmp
//  homgmd
//
//  homgby
//  homgbd
//
//  gmappe
//  gmeppe
//  gmrppe
//  gmpppe
//  gmeppe
//  gbypcy
//  gbdpwc
//
//  gbmco
//  gbm1pe
//  gbm2pe
//  gbm1bm
//  gbm2bm
//<.>
//


// 
// -----------------------------------------------------------------------------------------------
//             MAMB Navigation Summary   ">" is a tap of a data item or report
// -----------------------------------------------------------------------------------------------
//                                                          select
// num    ----- home ------                                 report   --------- report ----------- 
// taps  segment   tap data  ------- select report ------   param    ------ ViewController ------
// -----------------------------------------------------------------------------------------------
//  4    >person  >a person  >hompcy  calendar year         >year    viewHTMLViewController
//  3    >person  >a person  >homppe  personality                    viewHTMLViewController
//  4    >person  >a person  >hompco  compat paired with    >person  viewHTMLViewController
//  4    >person  >a person  >hompwc  what color            >date    viewHTMLViewController
//  4    >person  >a person  >hompbm  my best match in grp  >group   viewTBLRPTs_1_ViewController
//  3    >group   >a group   >homgbm  best match                     viewTBLRPTs_1_ViewController
//  3    >group   >a group   >6 most  6 trait reports                viewTBLRPTs_1_ViewController
//  4    >group   >a group   >2 best  best year or day      >yr/dy   viewTBLRPTs_1_ViewController
// 
// -----------------------------------------------------------------------------------------------
//                                                  
// num    ----- home------    -------- 1st report --------   -------- 2nd report --------   
// taps   entity  tap data    -- select report -  tap data   ------ select report --------
// -----------------------------------------------------------------------------------------------
//  5    >group   >a group   >homgbm  best match  >a pair   >hompbm  my best match in grp
//                                    |                              |
//                                    |                               viewTBLRPTs_2_ViewController
//                                    |
//                                     viewTBLRPTs_1_ViewController      
// -----------------------------------------------------------------------------------------------
// 
// ===============================================================================================
// From the home screen, there is a maximum of 2 other screens to get to any of the 14 reports
//   (home  >  maximum 2 other screens  >  report).
// From the home screen, there is a maximum of 5 taps/selections to get to any of the 14 reports.
// ===============================================================================================
//

// EXAMPLE data arrays
NSArray *gbl_arrayExaGrp;
NSArray *gbl_arrayExaPer;
NSArray *gbl_arrayExaMem;
NSArray *gbl_arrayExaGrpRem;
NSArray *gbl_arrayExaPerRem;


BOOL gbl_show_example_data;


NSInteger       gbl_haveSetUpHomeNavButtons;      // 0=n, 1=y
NSMutableArray *gbl_homeLeftItemsWithAddButton;
NSMutableArray *gbl_homeLeftItemsWithNoAddButton;

UIColor *gbl_colorHomeBG;
UIColor *gbl_colorHomeBG_save;  // in order to put back after editing mode color
UIColor *gbl_colorEditButton_save;  // in order to put back after editing mode color
UIColor *gbl_colorEditingBG;
UIColor *gbl_colorEditingBG_current;  // is now yellow or blue for add a record screen  (addChange view)
UIColor *gbl_colorEditingBGforInputField;
UIColor *gbl_colorforAddMembers;
UIColor *gbl_colorforDelMembers;

UIColor *gbl_colorReportsBG;
UIColor *gbl_colorSelParamForReports;
UIColor *gbl_colorEdit;

UIView *gbl_myCellBgView;
UIView *gbl_myCellBgView_cBgr;
UIView *gbl_myCellBgView_cHed;
NSInteger gbl_scrollViewIsDragging;
UIColor *gbl_color_cBGforSelected;  // for highlight bar BG

UIColor *gbl_color_cBgr;  // html background color
UIColor *gbl_color_cHed;  // column  header group reports
UIColor *gbl_color_cGr2;
UIColor *gbl_color_cGre;
UIColor *gbl_color_cNeu;
UIColor *gbl_color_cRed;
UIColor *gbl_color_cRe2;

//UIColor *gbl_color_textRe2; // [UIColor colorWithRed:034.0/255.0 green:034.0/255.0 blue:102.0/255.0 alpha:1.0]; // 222266  FOR TEST
//NSInteger gbl_cre2Flag;
UIColor *gbl_color_cMacHighlight;
UIColor *gbl_color_cAplTop;  // color of top of iPhone screen  246,248,249
UIColor *gbl_color_cAplBlue;  // tint of chevron and Back etc


UIColor *gbl_color_cPerGreen; // used to be all green (see below)  now settled on color cNeu

//gbl_color_cPerGreen5 = [UIColor colorWithRed:185.0/255.0 green:255.0/255.0 blue:130.0/255.0 alpha:1.0]; // b9ff82 // pretty light green 
//gbl_color_cPerGreen4 = [UIColor colorWithRed:206.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; // ceffa0 // light green 
//gbl_color_cPerGreen3 = [UIColor colorWithRed:223.0/255.0 green:255.0/255.0 blue:187.0/255.0 alpha:1.0]; // dfffbb // lightER green 
//gbl_color_cPerGreen2 = [UIColor colorWithRed:236.0/255.0 green:255.0/255.0 blue:211.0/255.0 alpha:1.0]; // ecffd3 // really light green 
//gbl_color_cPerGreen1 = [UIColor colorWithRed:246.0/255.0 green:255.0/255.0 blue:230.0/255.0 alpha:1.0]; // f6ffe6 // really,really light green 
//
//UIColor *gbl_color_cPerGreen5; 
//UIColor *gbl_color_cPerGreen4; 
//UIColor *gbl_color_cPerGreen3; 
//UIColor *gbl_color_cPerGreen2; 
//UIColor *gbl_color_cPerGreen1;

UIColor *gbl_color_cPerGreen2; 
UIColor *gbl_color_cPerGreen1;
UIColor *gbl_color_cAplDarkBlue;


//
// end of arrays with fixed info

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

NSInteger gbl_numRowsToTurnOnIndexBar;  // 201500624 = 90

    //                                  NSArray *arrayMAMBexampleGroupRemember = 
    // REMEMBER DATA for each Group 
    //     field 1  name-of-group
    //     field 2  last report selected for this Group:
    //              ="gbm"  for   "Best Match"
    //              ="gma"  for   "Most Assertive Person"
    //              ="gme"  for   "Most Emotional"
    //              ="gmr"  for   "Most Restless"
    //              ="gmp"  for   "Most Passionate"
    //              ="gmd"  for   "Most Down-to-earth"
    //              ="gby"  for   "Best Year ..."
    //              ="gbd"  for   "Best Day ..."
    //     field  3  year       last selection for this report parameter for this Group
    //     field  4  day        last selection for this report parameter for this Group
    //     + extra "|" at end
    // 
    //                                  NSArray *arrayMAMBexamplePersonRemember = 
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


// get file stuff
//
  // get Document directory as URL and Str
NSFileManager *gbl_sharedFM;
NSArray       *gbl_possibleURLs;
NSURL         *gbl_appDocDirURL;
NSString      *gbl_appDocDirStr;

  // get DB names as URL and Str
NSString *gbl_pathToLastEnt; // mambd1
NSString *gbl_pathToGroup;
NSString *gbl_pathToPerson;
NSString *gbl_pathToMember;
NSString *gbl_pathToGrpRem; //  the app can "remember" what to put highlight on for what was last selected.
NSString *gbl_pathToPerRem; //  the app can "remember" what to put highlight on for what was last selected.

NSURL    *gbl_URLToLastEnt;
NSURL    *gbl_URLToGroup;
NSURL    *gbl_URLToPerson;
NSURL    *gbl_URLToMember;
NSURL    *gbl_URLToGrpRem; //  the app can "remember" what to put highlight on for what was last selected.
NSURL    *gbl_URLToPerRem; //  the app can "remember" what to put highlight on for what was last selected.



// Pick from arrays
NSMutableArray *gbl_arrayPersonsToPickFrom;
NSMutableArray *gbl_arrayGroupsToPickFrom;
NSMutableArray *gbl_arrayMembersToDisplay;
NSMutableArray *gbl_arrayNewMembersToPickFrom;
NSMutableArray *gbl_arrayDeletableMembersToPickFrom;
NSInteger       gbl_currentYearInt;
NSInteger       gbl_currentMonthInt;
NSInteger       gbl_currentDayInt;
NSInteger       gbl_earliestYear;   // see .m  1850

NSString       *gbl_currentDay_yyyymmdd;

// multiple pick for group member stuff
//
NSString *gbl_groupMemberSelectionMode;  //  origin is HOME YELLOW GROUP LIST - choices are "from members"  or "from nonmembers" 
                                         // "from nonmembers" is when tap row > selPerson > tap green "+" for ADD members
                                         // "from members"    is when tap row > selPerson > tap red   "-" for DEL members
                                         //
                                         //  BTW,                when tap "i" > more info on group > add/change screen
NSInteger gbl_tappedGroupList_CellRow;   // 1=y,0=n
NSInteger gbl_tappedGroupList_MoreInfo_i;
NSInteger gbl_accessoryButtonTapped;
//NSInteger gbl_tapped_CellRow_inYellowGroupList;   // 1=y,0=n
//NSInteger gbl_tapped_Right_i_inYellowGroupList;   // "i" button on right side of row


// Report Parameters information
NSString  *gbl_fromHomeCurrentSelectionPSV;     // PSV  for per or grp
//NSInteger  gbl_fromHomeCurrentSelectionArrayIdx;
NSString  *gbl_fromHomeCurrentEntity;           // like "group" or "person" or "member"
NSString  *gbl_fromHomeCurrentEntityName;       // like "~Anya" or "~Swim Team"
NSString  *gbl_fromHomeLastEntityRemSaved;      // like "~Anya" or "~Swim Team" (control saving *Rem)
//NSString  *gbl_fromHomeRememberedPSV;      // collect this when user taps on a home table cell

NSString *gbl_fromSelSecondPersonPSV;      // PSV from select person tableview  (selPersonViewController)
NSString *gbl_fromSelGroupPSV;             // PSV from select group  tableview  (selPersonViewController)

NSInteger gbl_intBirthYear;
NSInteger gbl_intBirthMonth;
NSInteger gbl_intBirthDayOfMonth;



// The last selected thing by the user of Me and My BFFs.
// The "remember" fields (suffix "Rem") are saved to file when
//   1. user changes any data
//   2. applicationDidEnterBackground
//
// used when switching segmented control on home page from  grp to per  or  per to grp
//   or initial setting of highlight for last selection 
NSString *gbl_lastSelectedGroup;        // like "~Family"
NSString *gbl_lastSelectedPerson;       // like "~Dave"

                                              // in change mode, the name might change out from under you
NSString *gbl_lastSelectedPersonBeforeChange; // like "~Dave"   used in YELLOW gbl_homeUseMODE "edit mode"
                                              // for BOTH gbl_homeEditingState  =  "add" OR "view or change")
NSString *gbl_lastSelectedGroupBeforeChange;  // like "~Swim Team"   used in YELLOW gbl_homeUseMODE "edit mode"
                                              // for BOTH gbl_homeEditingState  =  "add" OR "view or change")

NSString *gbl_lastSelectedSecondPerson; // set for  hompc-just 2 compat after selecting 2nd person
//NSString *gbl_lastSelPersonWasA;        // @"group" or @"person"  used when coming back to selPersonViewController to re-draw  NOW use gbl_currentMenuPlusReportCode instead

NSString *gbl_lastSelectedYear;         // yyyy
NSString *gbl_lastSelectedDay;          // yyyymmdd
NSString *gbl_lastSelectedDaySaved;     // yyyymmdd  SAVE START DAY (for "Start button")
NSString *gbl_lastSelectedDayLimit;     // yyyymmdd  Maximum future lookahead is to the end of the
                                        //           calendar year after the current calendar year.
NSString *gbl_lastSelectedReportGroup;  // 3-letter code  gbm,gma,gme,gmr,gmp,gmd,gby,gbd 
NSString *gbl_lastSelectedReportPerson; // 3-letter code  pbm,pcy,ppe,pco,pbg,pwc 

NSString *gbl_lastSelectedHomePairReport; // hompbm or homgbm  (for deciding sel rpt B choices)


// level two tbl row num remembering when coming back to table
//
NSInteger gbl_selectedRownumSelRpt_B;  // for remembering row to highlight in sel rpt B
NSInteger gbl_selectedRownumTBLRPT_2;  // for remembering row to highlight in tblrpt2
NSInteger gbl_selectedRownumTBLRPT_1;  // for remembering row to highlight in tblrpt1
// NOTE that selrpt is done by remember mechanism with remember files by person or by group



// FINAL  values for saving
//
NSString *gbl_userSpecifiedPersonName;  // final value in "add person" screen

NSString *gbl_userSpecifiedCity;  // final value in "add person" screen  use for calc  latitude, hours diff from greenwich
NSString *gbl_userSpecifiedProv;  // final value in "add person" screen
NSString *gbl_userSpecifiedCoun;  // final value in "add person" screen

NSString *gbl_rollerBirth_yyyy; // for saving picker roller current values
NSString *gbl_rollerBirth_mth;  // like "Jan"
NSString *gbl_rollerBirth_dd;
NSString *gbl_rollerBirth_hour;
NSString *gbl_rollerBirth_min;
NSString *gbl_rollerBirth_amPm;
//
// FINAL  values for saving



NSString *gbl_rollerLast_yyyy;
NSString *gbl_rollerLast_mth;  // like "Jan"
NSString *gbl_rollerLast_dd;

NSString *gbl_selectedBirthInfo;  // shows "prompt" text also at beg
NSString *gbl_rollerBirthInfo;  // only shows stuff actually selected on the rollers


// flags for adding stuff to the Nav Bar only once (viewDidLoadO
//
//NSInteger gbl_homeView_ShouldAddToNavBar;  // = 1/0  yes/no
NSInteger gbl_viewHTML_ShouldAddToNavBar;
NSInteger gbl_tblrpts1_ShouldAddToNavBar;
NSInteger gbl_tblrpts2_ShouldAddToNavBar;

// INFO Button stuff 
NSString *gbl_helpScreenDescription;


// method  makeAndViewHTMLforWhatColorRpt  uses these gbl
//
char  gbl_Cbuf_for_csv_person[128];
char  gbl_Cbuf_for_pathToHTML_webview[4048];
NSString *gbl_OpathToHTML_webview;
NSURL    *gbl_URLtoHTML_forWebview;

NSURL    *gbl_URLtoHTML_forEmailing;

// plus   gbl_lastSelectedDay giving yyyymmdd
NSString *gbl_lastSelectedDayFormattedForEmail;          // Thu  Feb 12, 2015
NSString *gbl_lastSelectedDayFormattedForTitle;          //      Feb 12, 2015

NSString *gbl_myStartButtonLabel; // for what color report, SAVE fmt "Jun_05" (for startDay button label)



// these 2 are set in the same places 1. on entering foreground and 2. seq control change
//
NSString *gbl_lastSelectionType;                // like "group" or "person" or "pair"  
NSString *gbl_fromHomeCurrentSelectionType;     // like "group" or "person" or "pair"  


NSString *gbl_html_file_name_browser;
NSString *gbl_html_file_name_browser_B;
NSString *gbl_html_file_name_webview;

NSString *gbl_pathToFileToBeEmailed;
NSString *gbl_pathToFileToBeEmailed_B;
NSString *gbl_person_name;  // for email
NSString *gbl_person_name2; // for email group-of-2 report


NSIndexPath *gbl_savePrevIndexPath;  // for scrolling to the prev row you were on when coming back to tableview

// end of global variables


//@interface MAMB09AppDelegate : UIResponder <UIApplicationDelegate, NSCoding>
@interface MAMB09AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)  NSString *myLastEntityStr;


- (NSString *) updateDelimitedString: (NSMutableString *) DSV
                         delimitedBy: (NSString *)        delimiters
            updateOneBasedElementNum: (NSInteger)         oneBasedElementnum
                      withThisString: (NSString *)        newString
;

- (void)  saveLastSelectionForEntity: (NSString *) personOrGroup
                          havingName: (NSString *) entityName
            updatingRememberCategory: (NSString *) rememberCategory
                          usingValue: (NSString *) changeToThis
;
- (NSString *) grabLastSelectionValueForEntity: (NSString *) personOrGroup  //returns "cyr", "gbm", etc...
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


- (NSIndexPath *) indexpathForTableView: (UITableView *) argTableView
                         havingCellText: (NSString *)    argCellText;


- (BOOL)isJailbroken;


// get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs or gbl_grp_CSVs_B
// but possibly excluding  one person who is kingpin of grpone report "MY Best Match in Group ..." 
//
//- (NSInteger) getNSArrayOfCSVsForGroup: (NSString *) argGroupName
//               excludingThisPersonName: (NSString *) argPersonToCompareEveryoneElseWith // non-empty string for groupOne
;
- (NSInteger) getNSArrayOfCSVsForGroup: (NSString *) argGroupName
               excludingThisPersonName: (NSString *) argPersonToCompareEveryoneElseWith // non-empty string for groupOne
       puttingIntoArrayWithDescription: (NSString *) argArrayDescription                // destination array "" or "_B"
;


- (NSString *) getCSVforPersonName: (NSString *) argPersonName; 
- (NSString *) getPSVforPersonName: (NSString *) argPersonName; 


- (UIFont *)boldFontWithFont: (UIFont *) argFont;  // return Bold version of Font

- (void) mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) argArrayDescription; // like "group" "grprem"

- (CGSize) currentScreenSize;   // for using  CGSize.width and CGSize.height

- (NSInteger) mambCheckForCorruptData;
- (void) handleCorruptDataErrNum: (NSInteger) argCorruptDataErrNum;

- (void) mamb_endIgnoringInteractionEvents_after: (CGFloat) arg_numSecondsDelay; 
- (void) mamb_beginIgnoringInteractionEvents;                                   


- (void) mambChangeGRPMEM_memberNameFrom: (NSString *) arg_originalMemberName
                               toNewName: (NSString *) arg_newMemberName;

- (void) mambChangeGRPMEM_groupNameFrom: (NSString *) arg_originalGroupName
                              toNewName: (NSString *) arg_newGroupName;


@end




// old
//        @"pcy|Calendar Year ...",             // PERSON REPORTS (from home in "People")
//        @"ppe|Personality",
//        @"pco|Compatibility Paired with ...",
//        @"pbm|My Best Match in Group ...",
//        @"pwc|What Color is Today? ...",
//        @"p|",

//        @"gbm|Best Match",                    // GROUP REPORTS (from home in "Group")
//        @"g|",
//        @"gma|Most Assertive Person", // "Most" or "Best" > tap Person > can choose reports 21m, 21p, 21c 
//        @"gme|Most Emotional",
//        @"gmr|Most Restless",
//        @"gmp|Most Passionate",
//        @"gmd|Most Down-to-earth",
//        @"gmu|Most Ups and Downs",
//        @"g|",
//        @"gby|Best Year ...",
//        @"gbd|Best Day ...",

//        @"2co|Compatibility Potential",       // PAIR REPORTS ( from pbm or gbm report)
//        @"2|",
//        @"21m|<per1> Best Match",
//        @"21p|<per1> Personality",
//        @"21c|<per1> Calendar Year ...",
//        @"2|",
//        @"22m|<per2> Best Match",
//        @"22p|<per2> Personality",
//        @"22c|<per2> Calendar Year ...",
//

//NSInteger gbl_shouldReceiveTouches; // 0/1 no/yes  (for Backward / Foreward)

//too complex  
//
//NSString *whereAmI_text;
// whereAmI_text =
//hompcy "homePerson > Calendar Year > 2011 ";
//homppe "Fred > Personality";
//homppe "homePerson > person 34512345 > Compatibility";
//hompbm "Fred > Swim Team > Best Match for Fred in Swim Team";
//pbmco  "Fred > Swim Team > Best Match for Fred in Swim Team > Fred and person 34512345 > Compatibility";
//pbm1pe "Fred > Swim Team > Best Match for Fred in Swim Team > Fred and person 34512345 > person 34512345 > Personality";
//pbm2pe "Fred > Swim Team > Best Match for Fred in Swim Team > Fred and person 34512345 > Fred > Personality";
//pbm2bm "Fred > Swim Team > Best Match for Fred in Swim Team > Fred and person 34512345 > person 34512345 > Best Match for person 34512345 in Group Swim Team";
//
//pbm2bm
//
//  home
//> person  Fred
//> menu    Calendar Year
//> year    2011
//> report  Calendar Year 2011
//
//"
//selections starting at home
//> select  Fred
//> menu    Best Match for Fred in Group ...
//> select  Swim Team 
//> view    Best Match for person 34512345
//> select  Fred + person 34512345
//> view    Best Match for person 34512345
//";
//
//selections starting at home
//> Fred
//> Best Match for Fred in Group ...
//> Swim Team 
//  in  Best Match for Fred
//> Fred + person 34512345
//> Best Match for person 34512345
//  in  Best Match for person 34512345
//
//screen navigation
//  at home, selected Fred
//  selected report Best Match for Fred in Group ...
//  selected Swim Team 
//  in report, select pair Fred + person 34512345
//  selected report Best Match for person 34512345
//  in report 
//
//homgbm "Swim Team > Best Match";
//homgma "Swim Team > Most Assertive";
//gmappe "Swim Team > Most Assertive > Fred > Personality";
//

