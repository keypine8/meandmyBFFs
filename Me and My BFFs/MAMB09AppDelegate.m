//
//  MAMB09AppDelegate.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09AppDelegate.h"
#import "rkdebug_externs.h"
#import "mamblib.h"
#import "NSData+MAMB09_NSData_encryption.h"


@implementation MAMB09AppDelegate


#define KEY_LAST_ENTITY_STR  @"myLastEntityStr"

//#define DEFAULT_LAST_ENTITY  @"person|~Sophia|group|~Swim Team"    // for test  (testing has "~Anya 56789..." , not "~Anya"
#define DEFAULT_LAST_ENTITY  @"person|~Abigail 012345|group|~Swim Team"    // for test  (testing has "~Anya 56789..." , not "~Anya"


//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  // iOS 6
//{
//return UIInterfaceOrientationMaskAll;
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"in didFinishLaunchingWithOptions()  in appdelegate");
    

    // Override point for customization after application launch.

    [[UINavigationBar appearance] setTranslucent: NO ];  // set all navigation bars to opaque

    // set font and size for all Nav Bars
    //  see addchange 

    
    // to access global method in appDelegate .h and .m
    //MAMB09AppDelegate *gbl_myappDelegate=[[UIApplication sharedApplication] delegate];


    // EDITING stuff
    //

    gbl_YellowBG = [UIImage  imageNamed: @"bg_yellow_1x1b.png" 
                               inBundle: nil
          compatibleWithTraitCollection: nil
    ];
    gbl_BlueBG   = [UIImage  imageNamed: @"bg_blue_1x1a.png" 
                               inBundle: nil
          compatibleWithTraitCollection: nil
    ];



//    gbl_myname              = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 200, 30)]; // arg 1=x 2=y 3=width 4=height
    gbl_myname              = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 200, 40)]; // arg 1=x 2=y 3=width 4=height

    // field for  displaying current found  city,prov,coun 
//    gbl_mycityprovcounLabel  = [[UITextView alloc]initWithFrame: CGRectMake(16, 0, 250, 57)];
//    gbl_mycityprovcounLabel  = [[UITextField alloc]initWithFrame: CGRectMake(16, 0, 250, 57)];
//    gbl_mycityprovcounLabel  = [[UILabel alloc]initWithFrame: CGRectMake(16, 0, 250, 70)];

//    gbl_mycityprovcounLabel  = [[UITextField alloc]initWithFrame: CGRectMake(16, 0, 250, 57)];
//    gbl_mycityprovcounLabel  = [[UILabel alloc]initWithFrame: CGRectMake(16, 0, 250, 57)];
//    gbl_mycityprovcounLabel  = [[UILabel alloc]initWithFrame: CGRectMake(16, 0, 300, 57)];
    gbl_mycityprovcounLabel  = [[UILabel alloc]initWithFrame: CGRectMake(16, 0, 300, 77)];

    // field for  displaying current picker birth date/time info
//    gbl_mybirthinformation   = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 250, 30)]; // arg 1=x 2=y 3=width 4=height
//    gbl_mybirthinformation   = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 265, 30)]; // arg 1=x 2=y 3=width 4=height
    gbl_mybirthinformation   = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 265, 40)]; // arg 1=x 2=y 3=width 4=height

    // field for  entering city search string
//    gbl_mycity  = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 180, 30)]; // arg 1=x 2=y 3=width 4=height
    gbl_mycitySearchString   = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 180, 36)]; // arg 1=x 2=y 3=width 4=height

//    
//        UIImageView *myRightViewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forwardArrow_029.png"]];
//
//            gbl_mycitySearchString.rightViewMode          = UITextFieldViewModeAlways;
//            gbl_mycitySearchString.rightView              = myRightViewImage;
////           [gbl_mycitySearchString addSubview: myRightViewImage];
//
//

    gbl_title_groupName   = [[UIBarButtonItem alloc]initWithTitle: @"Type Group Name"
                                                            style: UIBarButtonItemStylePlain
                                                           target: self
                                                           action: nil
    ];
    gbl_title_personName   = [[UIBarButtonItem alloc]initWithTitle: @"Type Person Name"
                                                           style: UIBarButtonItemStylePlain
                              //  style: UIBarButtonItemStyleBordered
                                                            target: self
                                                            action: nil
    ];
    gbl_title_cityPicklist = [[UIBarButtonItem alloc]initWithTitle: @"Pick City"
                                                              style: UIBarButtonItemStylePlain
                              //  style: UIBarButtonItemStyleBordered
                                                            target: self
                                                            action: nil ];
    gbl_title_cityKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Type City Name"
                                                             style: UIBarButtonItemStylePlain
                                                            target: self
                                                            action: nil ];
    gbl_title_birthDate    = [[UIBarButtonItem alloc]initWithTitle: @"Pick Birth Date"
                                                             style: UIBarButtonItemStylePlain
                              //style: UIBarButtonItemStyleBordered
                                                            target: self
                                                            action: nil ];
    gbl_flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                      target: self
                                                                      action: nil
        ];
//    gbl_title_cityKeyboardWithNoPicklist    = [[UIBarButtonItem alloc]initWithTitle: @"Type City Name"
//                                                                style: UIBarButtonItemStyleBordered
//                                                               target: self
//                                                               action: nil ];
//    gbl_title_cityKeyboardHavingPicklist    = [[UIBarButtonItem alloc]initWithTitle: @"Type City Name"
//                                                                style: UIBarButtonItemStyleBordered
//                                                               target: self
//                                                               action: nil ];



     gbl_initPromptName = @"Name";
     gbl_initPromptCity = @"Birth City or Town";
     gbl_initPromptProv = @"State or Province";
     gbl_initPromptCoun = @"Country";
     gbl_initPromptDate = @"Birth Date and Time";




        // Creating a UIColor with Preset Component Values [UIColor redColor]
        //    blackColor
        //    darkGrayColor
        //    lightGrayColor
        //    whiteColor
        //    grayColor
        //    redColor
        //    greenColor
        //    blueColor
        //    cyanColor
        //    yellowColor
        //    magentaColor
        //    orangeColor
        //    purpleColor
        //    brownColor
        //    clearColor
        //



     gbl_colorPlaceHolderPrompt = [UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // gray


//    gbl_colorEditing = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:0.0/255.0 alpha:1.0]; // yellowy for edit
//    gbl_colorEditing = [UIColor colorWithRed:200.0/255.0 green:212.0/255.0 blue:0.0/255.0 alpha:1.0]; // yellowy for edit
//    gbl_colorEditing = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:100.0/255.0 alpha:1.0]; // yellowy for edit
//    gbl_colorEditing = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:200.0/255.0 alpha:1.0]; // yellowy for edit

//    gbl_colorEditing = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:1.0]; // bluey for edit
//    gbl_colorEditing = [UIColor colorWithRed:160.0/255.0 green:250.0/255.0 blue:255.0/255.0 alpha:1.0]; // bluey for edit
//    gbl_colorEditing = [UIColor colorWithRed:252.0/255.0 green:237.0/255.0 blue:189.0/255.0 alpha:1.0]; // orangey for edit
//    gbl_colorEditing = [UIColor colorWithRed:252.0/255.0 green:224.0/255.0 blue:133.0/255.0 alpha:1.0]; // orangey for edit
//    gbl_colorEditing = [UIColor colorWithRed:252.0/255.0 green:196.0/255.0 blue:108.0/255.0 alpha:1.0]; // orangey for edit
//    gbl_colorEditing = [UIColor colorWithRed:229.0/255.0 green:198.0/255.0 blue:166.0/255.0 alpha:1.0]; // browny for edit

//    gbl_color_cGre  = [UIColor colorWithRed:168.0/255.0 green:255.0/255.0 blue:152.0/255.0 alpha:1.0]; // a8ff98
    gbl_colorEditingBG = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // yellowy for edit




//    gbl_colorforAddMembers = [UIColor colorWithRed:150.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // greeny for add member
//    gbl_colorforAddMembers = [UIColor colorWithRed:200.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // greeny for add member
//    gbl_colorforAddMembers = [UIColor colorWithRed:230.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // greeny for add member
//    gbl_colorforAddMembers = [UIColor colorWithRed:212.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // greeny for add member
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:190.0/255.0 green:255.0/255.0 blue:190.0/255.0 alpha:1.0]; // not bright enough
//    gbl_colorforAddMembers = [UIColor colorWithRed:230.0/255.0 green:255.0/255.0 blue:230.0/255.0 alpha:1.0]; // too light green
//    gbl_colorforAddMembers = [UIColor colorWithRed:212.0/255.0 green:255.0/255.0 blue:212.0/255.0 alpha:1.0]; // washed out
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:150.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // greeny for add member
//    gbl_colorforAddMembers = [UIColor colorWithRed:175.0/255.0 green:255.0/255.0 blue:175.0/255.0 alpha:1.0]; // greeny for add member
//
    // add members color
    //
//    gbl_colorforAddMembers = [UIColor colorWithRed:200.0/255.0 green:255.0/255.0 blue:200.0/255.0 alpha:1.0]; // greeny for add member
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:033.0/255.0 green:128.0/255.0 blue:033.0/255.0 alpha:1.0]; // way dark
//    gbl_colorforAddMembers = [UIColor colorWithRed:033.0/255.0 green:196.0/255.0 blue:033.0/255.0 alpha:1.0]; // 
//    gbl_colorforAddMembers = [UIColor colorWithRed:033.0/255.0 green:255.0/255.0 blue:033.0/255.0 alpha:1.0]; // 
//    gbl_colorforAddMembers = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:128.0/255.0 alpha:1.0]; //  not bad, touch darker
//    gbl_colorforAddMembers = [UIColor colorWithRed:096.0/255.0 green:255.0/255.0 blue:096.0/255.0 alpha:1.0]; //
//    gbl_colorforAddMembers = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:128.0/255.0 alpha:1.0]; //  not bad
//    gbl_colorforAddMembers = [UIColor colorWithRed:160.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; //  
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:128.0/255.0 alpha:1.0]; //  not bad
//

    gbl_colorforAddMembers = [UIColor colorWithRed:160.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; //  


    // del members color
    //
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]; 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // too rich red
//    gbl_colorforDelMembers = [UIColor colorWithRed:155.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // too dark browny
//    gbl_colorforDelMembers = [UIColor colorWithRed:200.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // too rich red
//    gbl_colorforDelMembers = [UIColor colorWithRed:200.0/255.0 green:000.0/255.0 blue:000.0/255.0 alpha:1.0]; // too rich red
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:000.0/255.0 blue:000.0/255.0 alpha:1.0]; // too rich red
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // too rich red
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // too washed out
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; // too rich red
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // best
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // good
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:016.0/255.0 blue:16.0/255.0 alpha:1.0]; // too rich
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:024.0/255.0 blue:024.0/255.0 alpha:1.0]; // good
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:048.0/255.0 blue:048.0/255.0 alpha:1.0]; // not red enough
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:040.0/255.0 blue:040.0/255.0 alpha:1.0]; // not red enough
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // best
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // cant see circles
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // can  see circles
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0]; //  too dark (lines strong
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; // too dark (lines strong)
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]; // hard to see circles
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0]; // good
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0]; // ok
//
    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // can  see circles




    gbl_colorEditingBGforInputField = [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:252.0/255.0 alpha:1.0]; // whitish

//    gbl_bgColor_editFocus_NO   = gbl_colorEditingBGforInputField;    // whitish
//    gbl_bgColor_editFocus_YES  = [UIColor grayColor];
//    gbl_bgColor_editFocus_NO   = gbl_colorEditingBGforInputField;    // whitish
    gbl_bgColor_editFocus_NO   = gbl_color_cRe2;
    gbl_bgColor_editFocus_YES  = gbl_color_cGr2;
// [UIColor cyanColor];
;   // something else

//    gbl_color_cGr2  = [UIColor colorWithRed:042.0/255.0 green:255.0/255.0 blue:021.0/255.0 alpha:1.0]; // 66ff33
//    gbl_color_cGre  = [UIColor colorWithRed:168.0/255.0 green:255.0/255.0 blue:152.0/255.0 alpha:1.0]; // a8ff98
//    gbl_color_cPerGreen  = [UIColor colorWithRed:166.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0]; // a6f7ff // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:205.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1.0]; // cdfbff // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:225.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; // e1fcff // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:247.0/255.0 green:235.0/255.0 blue:209.0/255.0 alpha:1.0]; // f7ebd1
//    gbl_color_cPerGreen  = [UIColor colorWithRed:229.0/255.0 green:226.0/255.0 blue:199.0/255.0 alpha:1.0]; // e5e2c7
//    gbl_color_cPerGreen5 = [UIColor colorWithRed:185.0/255.0 green:255.0/255.0 blue:130.0/255.0 alpha:1.0]; // b9ff82 // pretty light green for personality neutral color bg
//
//    gbl_color_cPerGreen4 = [UIColor colorWithRed:206.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; // ceffa0 // light green for personality neutral color bg
//    gbl_color_cPerGreen3 = [UIColor colorWithRed:223.0/255.0 green:255.0/255.0 blue:187.0/255.0 alpha:1.0]; // dfffbb // lightER green for personality neutral color bg
//
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:236.0/255.0 green:255.0/255.0 blue:211.0/255.0 alpha:1.0]; // ecffd3 // really light green for personality neutral color bg
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:246.0/255.0 green:255.0/255.0 blue:230.0/255.0 alpha:1.0]; // f6ffe6 // really,really light green for personality neutral color bg
//


//    gbl_myname.placeholder         = @"Name";
//    gbl_myname.autocorrectionType  = UITextAutocorrectionTypeNo;
//    [gbl_myname setClearButtonMode: UITextFieldViewModeWhileEditing ];
//    [gbl_myname setKeyboardType:    UIKeyboardTypeNamePhonePad];          // A type optimized for entering a person's name or phone number.
//




    // make all "Back" buttons have just the arrow
    //




//   [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -45) forBarMetrics:UIBarMetricsDefault];     // make all "Back" buttons have just the arrow
    //  [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(, -60) forBarMetrics:UIBarMetricsDefault];     // make all "Back" buttons have just the arrow
    //    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsLandscapePhone];     // make all "Back" buttons have just the arrow
//    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsDefault];     // make all "Back" buttons have just the arrow


    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsDefault];     // make all "Back" buttons have just the arrow

//    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsCompact];     // make all "Back" buttons have just the arrow


    // did not work
    ////    UIImage *myImageADD2 = [[UIImage imageNamed: @"iconPlusAddGreenBig_66.png"]
    //    UIImage *myImageADD2 = [[UIImage imageNamed: @"iconPlusAddGreenBig_66"]
    ////    UIImage *myImageADD2 = [[UIImage imageNamed: @"iconPlusAddGreenBig_44.png"]
    //                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal
    ////                         imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate
    //    ];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage: myImageADD2
    //                                                      forState: UIControlStateNormal
    //                                                    barMetrics: UIBarMetricsDefault];
    //


    // ended up putting this paragraphin selReports and MemberList (only used there)
    //
    //    UIImage *backBtn = [UIImage imageNamed:@"iconPlusAddGreenBig_66"];
    //    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    //    self.navigationItem.backBarButtonItem.title=@"";
    //    self.navigationController.navigationBar.backIndicatorImage = backBtn;
    //    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    //







    // SET GBL DATA  HERE        ----------------------------------------------------------

    gbl_ThresholdshortTblLineLen = 17;  // nameA  + nameB more than this , then move benchmark label
    
    gbl_MAX_groups          =  50;   // max in app 
    gbl_MAX_persons         = 250;   // max in app 
    gbl_MAX_personsInGroup  = 250;   // max in a Group

    gbl_MAX_lengthOfName    =  15;   // 15 (applies to Person and Group both)
    gbl_MAX_lengthOfCity    =  30;   

    gbl_maxLenBirthinfoCSV  = 128;   // max len of birthinfo CSV for a Group Member 
    gbl_maxGrpRptLines      = 333;   // max 333 cells in app tableview 
    gbl_maxLenRptLinePSV    = 128;   // max len of report data PSV for a cell is 128 chars
                                     //   example: 128 "cGre"/"cRe2" |  "  1  Anya_   Liz_       90  Great"

    gbl_earliestYear = 1850;     // minimum birthyear (privacy)
    
    gbl_numRowsToTurnOnIndexBar    = 90;
    gbl_numCitiesToTriggerPicklist = 25;

    gbl_haveSetUpHomeNavButtons    =  0;      // beginning default is no   0=n, 1=y

//    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist = 2.0;
//    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist = 1.5;
//    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist = 1.2;
//    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist = 1.0;
//    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist = 0.8;  qOLD
//    gbl_secondsPauseInCityKeyStrokesToTriggerPicklist = 0.5;
//    gbl_frequencyOfCheckingCityPicklistTrigger        = 0.5; 
//    gbl_frequencyOfCheckingCityPicklistTrigger        = 0.3;
//    gbl_frequencyOfCheckingCityPicklistTrigger        = 0.5;   qOLD   // 0.8 and 0.5  min=0.8   max=1.0 (1st multiple > 0.8)
                                                                 // 1.2 and 0.5  min=1.2   max=1.5 (1st multiple > 1.2) 
//    gbl_frequencyOfCheckingCityPicklistTrigger        = 2.5;     // 0.8 and 0.5  min=0.8   max=1.0 (1st multiple > 0.8)



//    char *gbl_grp_CSVs[gbl_MAX_persons + 16]; // for filling array of group member data



    // This is the initial example data in DB when app first starts.
    // This is NOT the ongoing data, which is in  data files.
    //
    gbl_arrayExaGrp =   // field 1=name-of-group  field 2=locked-or-not
    @[
      @"Long Names||",
      @"Short Names||",
      @"~My Family||",
      @"~Swim Team||",
    ];

    gbl_arrayExaPer = // field 11= locked or not   HAVE TO BE PRE-SORTED
    @[
      @"Father Lastnae|7|11|1961|11|8|1|Los Angeles|California|United States||",
      @"Fa|7|11|1961|11|8|1|Los Angeles|California|United States||",
      @"Mother Lastna|3|12|1965|10|45|0|Los Angeles|California|United States||",
      @"Mo|3|12|1965|10|45|1|Los Angeles|California|United States||",
      @"Sister1 Lastnam|2|31|1988|12|31|1|Los Angeles|California|United States||",
      @"Sis|2|31|1988|12|30|1|Los Angeles|California|United States||",
      @"Sis3|2|31|1988|3|30|1|Los Angeles|California|United States||",
      @"~Abigail 012345|8|21|1994|1|20|0|Los Angeles|California|United States||",
      @"~Aiden 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
      @"~Anya|10|19|1990|8|20|0|Los Angeles|California|United States||",
      @"~Ava|2|3|1992|8|10|0|Los Angeles|California|United States||",
      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
      @"~Elijah|10|10|1992|12|1|1|Los Angeles|California|United States||",
      @"~Emma|5|17|1993|12|1|1|Los Angeles|California|United States||",
      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States||",
      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||",
      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States||",
      @"~Jackson|2|3|1993|12|1|1|Los Angeles|California|United States||",
      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States||",
      @"~Liam|4|8|1993|12|1|1|Los Angeles|California|United States||",
      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||",
      @"~Lucas|4|20|1992|6|30|1|Los Angeles|California|United States||",
      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States||",
      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States||",
      @"~Olivia|4|13|1994|12|53|1|Los Angeles|California|United States||",
      @"~Sister1|2|31|1988|12|30|1|Los Angeles|California|United States||",
      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
    ];
    gbl_arrayExaMem = // field 11= locked or not   HAVE TO BE PRE-SORTED
    @[
      @"Long Names|Father Lastnae|",
      @"Long Names|Mother Lastna|",
      @"Long Names|Sister1 Lastnam|",
      @"Short Names|Fa|",
      @"Short Names|Mo|",
      @"Short Names|Sis|",
      @"~My Family|~Brother|",
      @"~My Family|~Father|",
      @"~My Family|~Grandma|",
      @"~My Family|~Mother|",
      @"~My Family|~Sister1|",
      @"~My Family|~Sister2|",
      @"~Swim Team|~Abigail 012345|",
      @"~Swim Team|~Aiden 89012345|",
      @"~Swim Team|~Anya|",
      @"~Swim Team|~Ava|",
      @"~Swim Team|~Elijah|",
      @"~Swim Team|~Emma|",
      @"~Swim Team|~Ingrid|",
      @"~Swim Team|~Jackson|",
      @"~Swim Team|~Jen|",
      @"~Swim Team|~Liam|",
      @"~Swim Team|~Liz|",
      @"~Swim Team|~Lucas|",
      @"~Swim Team|~Noah|",
      @"~Swim Team|~Olivia|",
      @"~Swim Team|~Sophia|",
    ];

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
    //     field  3  last year  last selection for this report parameter for this Group
    //     field  4  day        last selection for this report parameter for this Group
    //     + extra "|" at end
    // 
    gbl_arrayExaGrpRem =  // HAVE TO BE PRE-SORTED
    @[
      @"Long Names||||",
      @"Short Names||||",
      @"~My Family||||",
      @"~Swim Team||||",
    ];

    // REMEMBER DATA for each Person
    //     field 1  name-of-person
    //     field 2  last report selected for this Person:
    //              ="pbm"  for   "Best Match"
    //              ="pcy"  for   "Calendar Year ...",
    //              ="ppe"  for   "Personality",
    //              ="pco"  for   "Compatibility Paired with ...",
    //              ="pbg"  for   "My Best Match in Group ...",
    //              ="pwc"  for   "What color is today? ...",
    //     field 3  last year
    //     field 4  person (this is 2nd person for rpt pco|Compatibility Paired with ...)
    //                      NOT home, which is saved with   file for  myLastEntityStr, mambd1
    //     field 5  group
    //     field 6  day
    //              extra "|" at end
    //
    gbl_arrayExaPerRem =   // HAVE TO BE PRE-SORTED here
    @[
      @"Father Lastnae||||||",
      @"Fa||||||",
      @"Mother Lastna||||||",
      @"Mo||||||",
      @"Sister1 Lastnam||||||",
      @"Sis||||||",
      @"~Abigail 012345||||||",
      @"~Aiden 89012345||||||",
      @"~Anya||||||",
      @"~Ava||||||",
      @"~Brother||||||",
      @"~Elijah||||||",
      @"~Emma||||||",
      @"~Father||||||",
      @"~Grandma||||||",
      @"~Ingrid||||||",
      @"~Jackson||||||",
      @"~Jen||||||",
      @"~Liam||||||",
      @"~Liz||||||",
      @"~Lucas||||||",
      @"~Mother||||||",
      @"~Noah||||||",
      @"~Olivia||||||",
      @"~Sister1||||||",
      @"~Sister2||||||",
      @"~Sophia||||||",
    ];



//
//    gbl_mambReportsPerson =
//    @[
//        @"Calendar Year ...",
//        @"Personality",
//        @"Compatibility Paired with ...",
//        @"My Best Match in Group ...",
//        @"What Color is Today? ...",
//    ];
//    gbl_mambReportsGroup =
//    @[
//        @"Best Match",
//        @"",
//        @"Most Assertive Person",
//        @"Most Emotional",
//        @"Most Restless",
//        @"Most Passionate",
//        @"Most Down-to-earth",
//        @"Most Ups and Downs",
//        @"",
//        @"Best Year ...",
//        @"Best Day ...",
//    ];
//    gbl_mambReportsPair =
//    @[
//        @"Compatibility Potential",
//        @"",
//        @"<per1> Best Match",
//        @"<per1> Personality",
//        @"<per1> Calendar Year ...",
//        @"",
//        @"<per2> Best Match",
//        @"<per2> Personality",
//        @"<per2> Calendar Year ...",
//    ];
//
    gbl_mambReports = // all reports in all report selection menus, "homp*" "homg*" "gbm*" or "pbm*" 
    @[  // field 1 = menu code + rptcode, field 2 = menu text
    // REPORTS from home PERSON segment
        @"homp|",     // these empty ones are spacers on the tableview
        @"hompcy|Calendar Year ...",             // from home in "People" > tap on a Person  - display homp*
        @"homppe|Personality",
        @"hompco|Compatibility Paired with ...",
        @"homp|",
        @"hompbm|My Best Match in Group ...",           // in pbm, tap Pair   > direct pco for pre-selected pair (now 2 lines)
        @"homp|",
        @"hompwc|What Color is Today? ...",
    // REPORTS from home GROUP  segment
        @"homg|",     // these empty ones are spacers
        @"homgbm|Best Match",           // from home in "Group"  > tap on a Group    - display homg*
        @"homg|",
        @"homgma|Most Assertive Person",                // in gma, tap Person > direct ppe for pre-selected person
        @"homgme|Most Emotional",                       // in gme, tap Person > direct ppe for pre-selected person
        @"homgmr|Most Restless",                        // in gmr, tap Person > direct ppe for pre-selected person
        @"homgmp|Most Passionate",                      // in gmp, tap Person > direct ppe for pre-selected person
        @"homgmd|Most Down-to-earth",                   // in gmd, tap Person > direct ppe for pre-selected person
        //   @"homgmu|Most Ups and Downs",                   // in gmu, tap Person > direct ppe for pre-selected person
        @"homg|",
        @"homgby|Best Year ...",                        // in gby, tap Person > direct pcy for pre-selected year
        @"homgbd|Best Day ...",                         // in gbd, tap Person > direct pwc for pre-selected date
    // REPORTS from homgbm  "Best Match" report
        @"gbm|",     // these empty ones are spacers on the tableview
        @"gbmco|Compatibility Potential",       // from homgbm > tap on a pair  - display gbm*
        @"gbm|",            
        @"gbm1pe|<per1> Personality",
        @"gbm2pe|<per2> Personality",
        @"gbm|",
        @"gbm1bm|<per1>'s Best Match",                 // in gbm1bm, tap Pair> direct pco for pre-selected pair
        @"gbm2bm|<per2>'s Best Match",                 // in gbm2bm, tap Pair> direct pco for pre-selected pair
    // REPORTS from hompbm  "My Best Match in Group ..." report
        @"pbm|",     // these empty ones are spacers on the tableview
        @"pbmco|Compatibility Potential",       // from hompbm > tap on a pair  - display pbm*
        @"pbm|",            
        @"pbm1pe|<per1> Personality",
        @"pbm2pe|<per2> Personality",
        @"pbm|",            
        @"pbm2bm|<per2>'s Best Match",                 // in 21bm, tap Pair> direct pco for pre-selected pair
    ];
    //


    gbl_show_example_data = YES;  // add option later to not show them
    
    // UIColor uses a 0-1 instead of 0-255 system so you just need to convert it like so:
    //
    gbl_colorReportsBG          = [UIColor alloc];
    gbl_colorSelParamForReports = [UIColor alloc];
    

    // color for highlight on selected tableview rows
    //
    // in cellForRowAtIndexPath in each tableview, below this:
    //      if (cell == nil) {
    //          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //      }
    //  do this:
    //      cell.selectedBackgroundView =  gbl_myCellBgView;
    //
//    UIView *gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [cell frame].size.width, [cell frame].size.height)];
//    UIView *gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectZero];

//      gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [cell frame].size.width -20, [cell frame].size.height)];
//    NSInteger myCellHighlightWidth = [cell frame].size.width -20; 

//    NSInteger myCellHighlightWidth = _window.width - 20; 
//    double myCellHighlightWidth = [[UIScreen mainScreen] applicationFrame].size.height - 30.0;
//kdn(myCellHighlightWidth);
//    gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, myCellHighlightWidth, 44.0f)];


    //[cellBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellBgView.png"]]];
    //[gbl_myCellBgView setBackgroundColor:  gbl_color_cBGforSelected ];
//[gbl_myCellBgView setBackgroundColor:  [UIColor lightTextColor] ];

    gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectZero];     // for highlight selected cell flash
    [gbl_myCellBgView setBackgroundColor:  [UIColor whiteColor] ];   // for highlight selected cell flash
//[gbl_myCellBgView setBackgroundColor:  [UIColor lightTextColor] ];




    //  gbl_colorReportsBG           is for SELRPTs 1 and 2 and and select 2nd person
    //  gbl_colorSelParamForReports  is for pickerYear, selYear and sel Date

//    gbl_colorReportsBG          = [UIColor colorWithRed:242./255.0 green:247./255.0 blue:255./255.0 alpha:1.0];  //  apple blue 2.5
//    gbl_colorReportsBG = [UIColor colorWithRed:181.0/255.0 green:214.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  sail
//    gbl_colorReportsBG = [UIColor colorWithRed:206.0/255.0 green:227.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  Hawkes blue
//    gbl_colorReportsBG = [UIColor colorWithRed:154.0/255.0 green:200.0/255.0 blue:251.0/255.0 alpha:1.0]; // test  9ac8fb  baby blue
//    gbl_colorReportsBG = [UIColor colorWithRed:181.0/255.0 green:214.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  sail
//    gbl_colorReportsBG = [UIColor colorWithRed:167.0/255.0 green:207.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid
//

    // this is lighter than home 230/242
    // gbl_colorReportsBG = [UIColor colorWithRed:238.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0];  // eef7ff apple blue 2.5  <---

    gbl_colorReportsBG = [UIColor colorWithRed:225.0/255.0 green:238.0/255.0 blue:255.0/255.0 alpha:1.0];  // little darker than home 230/242

    gbl_colorSelParamForReports = gbl_colorReportsBG;  // these are for SELRPTs sceens and select 2nd person




//    gbl_colorHomeBG = [UIColor colorWithRed:167.0/255.0 green:207.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid of sail/baby blue
//    gbl_colorHomeBG = [UIColor colorWithRed:181.0/255.0 green:214.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  sail
//    gbl_colorHomeBG = [UIColor colorWithRed:206.0/255.0 green:227.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  Hawkes blue
//    gbl_colorHomeBG = [UIColor colorWithRed:222.0/255.0 green:237.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid
//
    gbl_colorHomeBG      = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:254.0/255.0 alpha:1.0]; // test  mid

    gbl_colorHomeBG_save = gbl_colorHomeBG ;  // in order to put back after editing mode color


//    gbl_color_cBGforSelected  = [UIColor colorWithRed: 255.0/255.0 green: 204.0/255.0 blue: 153.0/255.0 alpha:1.0]; // ffcc99
//    gbl_color_cBGforSelected  = [UIColor colorWithRed: 255.0/255.0 green: 226.0/255.0 blue: 175.0/255.0 alpha:1.0]; // ffe2af
//    gbl_color_cBGforSelected  = [UIColor colorWithRed: 255.0/255.0 green: 249.0/255.0 blue: 198.0/255.0 alpha:1.0]; //#FFF9C6 
//
    gbl_color_cBGforSelected  = [UIColor colorWithRed: 255.0/255.0 green: 255.0/255.0 blue: 238.0/255.0 alpha:1.0]; //#FFFfdd 

    // NOTE:  cHed is good for column  header group reports
    // NOTE:  cHed is good for box comments
    //
    gbl_color_cBgr  = [UIColor colorWithRed:247.0/255.0 green:235.0/255.0 blue:209.0/255.0 alpha:1.0]; // f7ebd1  bg below/above all tbl cells
// for test   gbl_color_cBgr  = [UIColor redColor];
 
    gbl_color_cHed  = [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:224.0/255.0 alpha:1.0]; // fcfce0
    gbl_color_cGr2  = [UIColor colorWithRed:042.0/255.0 green:255.0/255.0 blue:021.0/255.0 alpha:1.0]; // 66ff33
    gbl_color_cGre  = [UIColor colorWithRed:168.0/255.0 green:255.0/255.0 blue:152.0/255.0 alpha:1.0]; // a8ff98

    gbl_color_cNeu  = [UIColor colorWithRed:229.0/255.0 green:226.0/255.0 blue:199.0/255.0 alpha:1.0]; // e5e2c7
//    gbl_color_cNeu  = [UIColor colorWithRed:237.0/255.0 green:235.0/255.0 blue:216.0/255.0 alpha:1.0]; // edebd8
//    gbl_color_cNeu  = [UIColor colorWithRed:245.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1.0]; // f5f4ea

    // new reds    20150511
    //
//    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:152.0/255.0 blue:168.0/255.0 alpha:1.0]; // ff98a8
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:068.0/255.0 blue:119.0/255.0 alpha:1.0]; // ff4477
    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:201.0/255.0 alpha:1.0]; // ffb5c9
    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:103.0/255.0 blue:143.0/255.0 alpha:1.0]; // ff678f

//    gbl_color_textRe2  = [UIColor colorWithRed:034.0/255.0 green:034.0/255.0 blue:102.0/255.0 alpha:1.0]; // 222266  FOR TEST

    // color of top of iPhone screen  246,248,249
    gbl_color_cAplTop  = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]; // f8f8f8 or 246,248,249
    gbl_color_cAplBlue = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]; // 0080ff  (blue text, chevron)


//    // light green for personality neutral color bg  (alternate the two colors)
//    gbl_color_cPerGreen  = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
    gbl_color_cPerGreen  = [UIColor colorWithRed:166.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0]; // a6f7ff // light green for personality neutral color bg
    gbl_color_cPerGreen  = [UIColor colorWithRed:205.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1.0]; // cdfbff // light green for personality neutral color bg
    gbl_color_cPerGreen  = [UIColor colorWithRed:225.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; // e1fcff // light green for personality neutral color bg
    gbl_color_cPerGreen  = [UIColor colorWithRed:247.0/255.0 green:235.0/255.0 blue:209.0/255.0 alpha:1.0]; // f7ebd1
    gbl_color_cPerGreen  = [UIColor colorWithRed:229.0/255.0 green:226.0/255.0 blue:199.0/255.0 alpha:1.0]; // e5e2c7

//    gbl_color_cPerGreen1 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:230.0/255.0 green:255.0/255.0 blue:204.0/255.0 alpha:1.0]; // e6ffcc // really light green for personality neutral color bg
//

//    gbl_color_cPerGreen5 = [UIColor colorWithRed:201.0/255.0 green:255.0/255.0 blue:145.0/255.0 alpha:1.0]; // c9ff91 // pretty light green for personality neutral color bg
//    gbl_color_cPerGreen4 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen3 = [UIColor colorWithRed:221.0/255.0 green:255.0/255.0 blue:185.0/255.0 alpha:1.0]; // ddffb9 // lightER green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:230.0/255.0 green:255.0/255.0 blue:204.0/255.0 alpha:1.0]; // e6ffcc // really light green for personality neutral color bg
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0]; // f0ffe0 // really,really light green for personality neutral color bg

    gbl_color_cPerGreen5 = [UIColor colorWithRed:185.0/255.0 green:255.0/255.0 blue:130.0/255.0 alpha:1.0]; // b9ff82 // pretty light green for personality neutral color bg

    gbl_color_cPerGreen4 = [UIColor colorWithRed:206.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; // ceffa0 // light green for personality neutral color bg
    gbl_color_cPerGreen3 = [UIColor colorWithRed:223.0/255.0 green:255.0/255.0 blue:187.0/255.0 alpha:1.0]; // dfffbb // lightER green for personality neutral color bg

    gbl_color_cPerGreen2 = [UIColor colorWithRed:236.0/255.0 green:255.0/255.0 blue:211.0/255.0 alpha:1.0]; // ecffd3 // really light green for personality neutral color bg
    gbl_color_cPerGreen1 = [UIColor colorWithRed:246.0/255.0 green:255.0/255.0 blue:230.0/255.0 alpha:1.0]; // f6ffe6 // really,really light green for personality neutral color bg


//    gbl_color_cPerGreen1 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen3 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen4 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen5 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg



    // get Document directory as URL and Str
    //
    gbl_sharedFM = [NSFileManager defaultManager];
    gbl_possibleURLs = [gbl_sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    gbl_appDocDirURL = nil;
    if ([gbl_possibleURLs count] >= 1) {
        gbl_appDocDirURL = [gbl_possibleURLs objectAtIndex:0];
    }
    gbl_appDocDirStr = [gbl_appDocDirURL path];
    
    // get DB names as URL and Str
    gbl_pathToLastEnt = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd1"];  // @"lastEntity.txt"];
    gbl_pathToGroup   = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd2"];  // @"mambGroup.txt"];
    gbl_pathToPerson  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd3"];  // @"mambPerson.txt"];
    gbl_pathToMember  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd4"];  // @"mambMember.txt"];
    gbl_pathToGrpRem  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd5"];  // group  remember data
    gbl_pathToPerRem  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd6"];  // person remember data


    gbl_URLToLastEnt = [NSURL fileURLWithPath: gbl_pathToLastEnt isDirectory:NO];
    gbl_URLToGroup   = [NSURL fileURLWithPath: gbl_pathToGroup   isDirectory:NO];
    gbl_URLToPerson  = [NSURL fileURLWithPath: gbl_pathToPerson  isDirectory:NO];
    gbl_URLToMember  = [NSURL fileURLWithPath: gbl_pathToMember  isDirectory:NO];
    gbl_URLToGrpRem  = [NSURL fileURLWithPath: gbl_pathToGrpRem  isDirectory:NO];
    gbl_URLToPerRem  = [NSURL fileURLWithPath: gbl_pathToPerRem  isDirectory:NO];

    
    //  end of   SET GBL DATA  HERE
    
    return YES;
    
} // didFinishLaunchingWithOptions


// global method called from anywhere like this:
//MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//NSString *myStrToUpdate = PSVthatWasFound;
//
//myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
//                                        delimitedBy: (NSString *) @"|"
//                           updateOneBasedElementNum: (NSInteger)  myElementNum
//                                     withThisString: (NSString *) changeToThis
//                ];
//
//[gbl_arrayPer replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];
//
- (NSString *) updateDelimitedString: (NSMutableString *) DSV
                         delimitedBy: (NSString *) delimiters
            updateOneBasedElementNum: (NSInteger)  oneBasedElementnum
                      withThisString: (NSString *) newString
{
// NSLog(@"in updateDelimitedString!");
// NSLog(@"DSV=%@",DSV);
// NSLog(@"delimiters=%@",delimiters);
// NSLog(@"oneBasedElementnum=%ld",(long)oneBasedElementnum);
// NSLog(@"newString=%@",newString);

    NSArray *myarr = [DSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: delimiters]];
    // NSLog(@"myarr=%@",myarr);
    
    NSMutableArray *myMarr = [NSMutableArray arrayWithArray: myarr];
    myMarr[oneBasedElementnum -1] = newString;
    // NSLog(@"myMarr=%@",myMarr);
    
    NSString * updatedStr = [myMarr componentsJoinedByString: @"|"];
  
    // NSLog(@"updatedStr after=%@",updatedStr);
    return updatedStr;
    
} // updateDelimitedString



// <.> TODO  ?? after remembering N things, write out the remember Files    todo ??
//
//    [myappDelegate selectionMemorizeForEntity: (NSString *) @"person"
//                                   havingName: (NSString *) myPSVarr[0]
//                     updatingRememberCategory: (NSString *) @"year"
//                                   usingValue: (NSString *) gbl_lastSelectedYear
//     ];

//e.g.
//        [myappDelegate selectionMemorizeForEntity: (NSString *) @"person"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) @"pcy"
//        ];
//
//- (void) selectionMemorizeForEntity: (NSString *) personOrGroup    // eg. input strings = person, ~Liz, year, 2005
- (void) saveLastSelectionForEntity: (NSString *) argPersonOrGroup    // eg. input strings = person, ~Liz, year, 2005
                         havingName: (NSString *) argEntityName
           updatingRememberCategory: (NSString *) argRememberCategory
                         usingValue: (NSString *) argChangeToThis
{
//tn();NSLog(@"in saveLastSelectionForEntity sssssssssssssssssssssssssss !");
    
    NSString  *PSVthatWasFound;
    NSString  *prefixStr;
    NSInteger  myElementNum = 0;
    NSInteger  arrayIdx;
    NSString  *myStrToUpdate;
    NSString  *myupdatedStr;


tn(); NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argPersonOrGroup    =%@",argPersonOrGroup);
      NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argEntityName       =%@",argEntityName);
      NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argRememberCategory =%@",argRememberCategory);
      NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argChangeToThis     =%@",argChangeToThis);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    prefixStr = [NSString stringWithFormat: @"%@|", argEntityName];
  NSLog(@"prefixStr =%@",prefixStr );

    if ([argPersonOrGroup isEqualToString:@"person"]) {

//        NSLog(@"beg of  saveLastSelectionForEntity gbl_arrayPerRem=%@",gbl_arrayPerRem);

        // get the PSV of  ~Liz in gbl_arrayPerRem
        PSVthatWasFound = NULL;
        arrayIdx = 0;
        for (NSString *element in gbl_arrayPerRem) {
            if ([element hasPrefix: prefixStr]) {
                PSVthatWasFound = element;
                break;
            }
            arrayIdx = arrayIdx + 1;
        }
//  NSLog(@"PSVthatWasFound =%@",PSVthatWasFound );

        if      ([argRememberCategory isEqualToString: @"rptsel"]) myElementNum = 2;  // one-based index number
        else if ([argRememberCategory isEqualToString: @"year"])   myElementNum = 3;
        else if ([argRememberCategory isEqualToString: @"person"]) myElementNum = 4;
        else if ([argRememberCategory isEqualToString: @"group"])  myElementNum = 5;
        else if ([argRememberCategory isEqualToString: @"day"])    myElementNum = 6;
        else {
            NSLog(@"should not happen   cannot find group  rememberCategory= %@", argRememberCategory );
            return;  // should not happen
        }

        if (PSVthatWasFound != NULL) {
            // NSLog(@"in remember!!  before ®gbl_arrayPerRem =%@",gbl_arrayPerRem);
            myStrToUpdate = PSVthatWasFound;
//  NSLog(@"myStrToUpdate =%@",myStrToUpdate );
            
            myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                    delimitedBy: (NSString *) @"|"
                                       updateOneBasedElementNum: (NSInteger)  myElementNum
                                                 withThisString: (NSString *) argChangeToThis ];
            // NSLog(@"arrayIdx=%ld",(long)arrayIdx);
            // NSLog(@"myElementNum=%ld",(long)myElementNum);
            // NSLog(@"gbl_arrayPerRem[arrayIdx]=%@",gbl_arrayPerRem[arrayIdx]);

            [gbl_arrayPerRem replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];

        }
//        NSLog(@"end of  saveLastSelectionForEntity updated gbl_arrayPerRem=%@",gbl_arrayPerRem);
//tn(); NSLog(@"end of ssssssssssssssssssssssssssss saveLastSelectionForEntity   myStrToUpdate=%@", myStrToUpdate);
//      NSLog(@"end of ssssssssssssssssssssssssssss saveLastSelectionForEntity    myupdatedStr=%@", myupdatedStr);
    }  // person
    

    if ([argPersonOrGroup isEqualToString:@"group"]) {
        //NSLog(@"end of  saveLastSelectionForEntity gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
        // get the PSV of  "~Swim Team" in gbl_arrayGrpRem
        PSVthatWasFound = NULL;
        arrayIdx = 0;


        for (NSString *element in gbl_arrayGrpRem) {
            if ([element hasPrefix: prefixStr]) {
                PSVthatWasFound = element;
                break;
            }
//NSLog(@"gbl_arrayGrpRem[arrayIdx]=%@",gbl_arrayGrpRem[arrayIdx]);
            arrayIdx = arrayIdx + 1;
        }
//  NSLog(@"PSVthatWasFound =%@",PSVthatWasFound );

        if      ([argRememberCategory isEqualToString: @"rptsel"]) myElementNum = 2;  // one-based index number
        else if ([argRememberCategory isEqualToString: @"year"])   myElementNum = 3;
        else if ([argRememberCategory isEqualToString: @"day"])    myElementNum = 4;
        else {
            NSLog(@"should not happen   cannot find group  rememberCategory= %@", argRememberCategory );
            return;  // should not happen
        }


        if (PSVthatWasFound != NULL) {
            // NSLog(@"in remember!!  before ®gbl_arrayGrpRem =%@",gbl_arrayGrpRem);
            NSString *myStrToUpdate = PSVthatWasFound;
//  NSLog(@"myStrToUpdate =%@",myStrToUpdate );
            myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                    delimitedBy: (NSString *) @"|"
                                       updateOneBasedElementNum: (NSInteger)  myElementNum
                                                 withThisString: (NSString *) argChangeToThis ];
            // NSLog(@"arrayIdx=%ld",(long)arrayIdx);
            // NSLog(@"myElementNum=%ld",(long)myElementNum);
            // NSLog(@"gbl_arrayGrpRem[arrayIdx]=%@",gbl_arrayGrpRem[arrayIdx]);

            [gbl_arrayGrpRem replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];


//tn(); NSLog(@"end of ssssssssssssssssssssssssssss saveLastSelectionForEntity   myStrToUpdate=%@", myStrToUpdate);
//      NSLog(@"end of ssssssssssssssssssssssssssss saveLastSelectionForEntity    myupdatedStr=%@", myupdatedStr);
        }
    }
    
// cannot be right  ?        upd   it IS wrong
//    gbl_fromHomeCurrentSelectionPSV = myupdatedStr;
//    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV );
//

      NSLog(@"end of ssssssssssssssssssssssssssss saveLastSelectionForEntity   myStrToUpdate=%@", myStrToUpdate);
      NSLog(@"end of ssssssssssssssssssssssssssss saveLastSelectionForEntity    myupdatedStr=%@", myupdatedStr);

} // saveLastSelectionForEntity 


// grabLastSelectionValueForEntity
//
// for rememberCategory = "rptsel",   returns 3-char code string to search for in report selection table
// for rememberCategory = "rptsel",   returns  code of menu+rpt like "homppe" string to search for in report selection table
// for rememberCategory = "person",   returns string to search for gbl_arrayPer
// for rememberCategory = "group",    returns string to search for gbl_arrayGrp
// for rememberCategory = "year",     returns string year
// for rememberCategory = "day",      returns string day
//
- (NSString *) grabLastSelectionValueForEntity: (NSString *) argPersonOrGroup 
                                    havingName: (NSString *) argEntityName
                          fromRememberCategory: (NSString *) argRememberCategory
{
tn(); NSLog(@"       gggggggggggggggggggggggggggggggggggggggg grabLastSelectionValueForEntity   entity     =%@", argPersonOrGroup );
      NSLog(@"       gggggggggggggggggggggggggggggggggggggggg grabLastSelectionValueForEntity   entityName =%@", argEntityName);
      NSLog(@"       gggggggggggggggggggggggggggggggggggggggg grabLastSelectionValueForEntity rememberCat  =%@", argRememberCategory);

    NSInteger myPSVfldNum = 0;
    NSArray  *myRemArr;
    NSInteger myRemArrIdx = 0;
    NSString *myRemPSV;
    NSString *myReturnStr;
    NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"]; // separators



    myRemPSV    = nil;
    myRemArrIdx = -1;  // one-based above

    // init by entity type   per or grp
    //
    if ([argPersonOrGroup isEqualToString:@"person"]) {
        myRemArr = gbl_arrayPerRem;
                                                                                  // get element fld num in PSV 
        if      ([argRememberCategory isEqualToString: @"rptsel"]) myPSVfldNum = 2;  // one-based fld number
        else if ([argRememberCategory isEqualToString: @"year"])   myPSVfldNum = 3;
        else if ([argRememberCategory isEqualToString: @"person"]) myPSVfldNum = 4;  // second person for compatibility
        else if ([argRememberCategory isEqualToString: @"group"])  myPSVfldNum = 5;
        else if ([argRememberCategory isEqualToString: @"day"])    myPSVfldNum = 6;
        else  
            return nil; // should not happen
    }

    if ([argPersonOrGroup isEqualToString:@"group"]) {
        myRemArr = gbl_arrayGrpRem;
                                                                                  // get element fld num in PSV 
        if      ([argRememberCategory isEqualToString: @"rptsel"]) myPSVfldNum = 2;  // one-based fld number
        else if ([argRememberCategory isEqualToString: @"year"])   myPSVfldNum = 3;
        else if ([argRememberCategory isEqualToString: @"day"])    myPSVfldNum = 4;
        else  
            return nil; // should not happen
    }


    NSString *prefixStr2 = [NSString stringWithFormat: @"%@|", argEntityName];
    for (NSString *elt in myRemArr) {  // get PSV of remembered data for this entity
        if ([elt hasPrefix: prefixStr2]) {
            myRemPSV = elt;
            break;
        }
        myRemArrIdx =  myRemArrIdx + 1;
    }
    if (myRemPSV) {                           // get remembered value
        myRemArr = [myRemPSV componentsSeparatedByCharactersInSet: myNSCharacterSet];

//        return myRemArr[myPSVfldNum -1]; // one-based 
        myReturnStr = myRemArr[myPSVfldNum -1]; // one-based 

      NSLog(@"end of gggggggggggggggggggggggggggggggggggggggg grabLastSelectionValueForEntity   myReturnStr=%@", myReturnStr);

        return myReturnStr;
    }

NSLog(@"end of gggggggggggggggggggggggggggggggggggggggg grabLastSelectionValueForEntity   myReturnStr=NIL");
    return nil;  // no previous selection  (pgm startup after download)
} // end of grabLastSelectionValueForEntity




- (NSString *) mambMapString: (NSString *) argStringToMap
           usingWhichMapping: (NSInteger ) whichMapping
             doingMapOrUnmap: (NSString *) mapOrUnmap
{
    NSString *returnNSString;
    const char *myStringToMapC_CONST;    
    char        myStringToMapCstring[1024];
    const char *myMapOrUnmapC_CONST;     
    char        myMapOrUnmapCstring[1024];

    myStringToMapC_CONST = [argStringToMap cStringUsingEncoding:NSUTF8StringEncoding];       // convert NSString to c string
    strcpy(myStringToMapCstring, myStringToMapC_CONST);                                      // convert NSString to c string

    myMapOrUnmapC_CONST = [mapOrUnmap cStringUsingEncoding:NSUTF8StringEncoding];        // convert NSString to c string
    strcpy(myMapOrUnmapCstring, myMapOrUnmapC_CONST);                                     // convert NSString to c string

//    trn("mapbefore");ksn(myStringToMapCstring);
    domap(
        myStringToMapCstring, 
        (int)whichMapping,
        myMapOrUnmapCstring
    );                                                   // (2) map  c string in place 
//    trn("mapafter ");ksn(myStringToMapCstring);

    returnNSString = [NSString stringWithUTF8String: myStringToMapCstring];                  // (3) convert c string to NSString 
    //NSLog(@"returnNSString=%@", returnNSString);

    return returnNSString;
} // mambMapString




- (void) mambWriteNSArrayWithDescription:  (NSString *) argEntityDescription  // like "group","person"
{
    NSLog(@"in mambWriteNSArrayWithDescription: %@  ----------", argEntityDescription  );
    NSError *err01;
    NSURL   *myURLtoWriteTo;
    NSArray *myArray;
    NSData  *myArchive;
    NSData  *myWriteable;

    BOOL haveGrp, havePer, haveMem, haveGrpRem, havePerRem;

    //tn();tr("BEG of mambWriteNSArrayWithDescription         ");
    haveGrp    = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePer    = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    haveMem    = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGrpRem];
    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerRem];
    ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);
 tn();

    // determine what array to write  and  where to write it
    //                                                           -------------------------------------------------------------------------
    //                                                                              file to write to             array to write           
    //                                                           -------------------------------------------------------------------------
    //
    if ([argEntityDescription isEqualToString:@"examplegroup"])  { myURLtoWriteTo = gbl_URLToGroup;    myArray = gbl_arrayExaGrp;    } // write on init app
    if ([argEntityDescription isEqualToString:@"exampleperson"]) { myURLtoWriteTo = gbl_URLToPerson;   myArray = gbl_arrayExaPer;    } // write on init app
    if ([argEntityDescription isEqualToString:@"examplemember"]) { myURLtoWriteTo = gbl_URLToMember;   myArray = gbl_arrayExaMem;    } // write on init app
    if ([argEntityDescription isEqualToString:@"examplegrprem"]) { myURLtoWriteTo = gbl_URLToGrpRem;   myArray = gbl_arrayExaGrpRem; } // write on init app
    if ([argEntityDescription isEqualToString:@"exampleperrem"]) { myURLtoWriteTo = gbl_URLToPerRem;   myArray = gbl_arrayExaPerRem; } // write on init app

    if ([argEntityDescription isEqualToString:@"group"])         { myURLtoWriteTo = gbl_URLToGroup;    myArray = gbl_arrayGrp;    }    // write ongoing
    if ([argEntityDescription isEqualToString:@"person"])        { myURLtoWriteTo = gbl_URLToPerson;   myArray = gbl_arrayPer;    }    // write ongoing
    if ([argEntityDescription isEqualToString:@"member"])        { myURLtoWriteTo = gbl_URLToMember;   myArray = gbl_arrayMem;    }    // write ongoing
    if ([argEntityDescription isEqualToString:@"grprem"])        { myURLtoWriteTo = gbl_URLToGrpRem;   myArray = gbl_arrayGrpRem; }    // write ongoing
    if ([argEntityDescription isEqualToString:@"perrem"])        { myURLtoWriteTo = gbl_URLToPerRem;   myArray = gbl_arrayPerRem; }    // write ongoing
    //                                                           -------------------------------------------------------------------------


//NSLog(@"in writensarray BEFORE WRITE  my EXAMPLE Array=%@",myArray);

    //NSLog(@"gbl_URLToGroup=%@",gbl_URLToGroup);
//    NSLog(@"myURLtoWriteTo  =%@",myURLtoWriteTo  );

    [gbl_sharedFM removeItemAtURL: myURLtoWriteTo  error:&err01];     // remove old (because no overcopy)
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error on remove %@= %@", argEntityDescription, err01); }

    myArchive   = [NSKeyedArchiver  archivedDataWithRootObject: myArray];
//tn();  NSLog(@"myArchive=\n%@",myArchive);

    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
    myWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myArchive];
//tn();  NSLog(@"myWriteable=\n%@",myWriteable );

    BOOL ret01 = [myWriteable writeToURL: myURLtoWriteTo  atomically:YES];
    if (!ret01)  NSLog(@"Error write to %@ \n  %@", argEntityDescription, [err01 localizedFailureReason]);
    // for some reason the below, gives error code 4,  but above has no error
    //    [myWriteable writeToURL: myURLtoWriteTo  options:NSDataWritingAtomic  error: &err01];   // for some reason, gives error code 4
    //    if (err01) { NSLog(@"Error on writeToURL %@= %@", argEntityDescription, err01); }
    //


    haveGrp    = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePer    = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    haveMem    = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGrpRem];
    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerRem];

//ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);
//tn();tr("end of mambWriteNSArrayWithDescription         ");
//tn();


} // end of mambWriteNSArrayWithDescription



// READ   there are 5  entity/array files to READ
//
- (void) mambReadArrayFileWithDescription: (NSString *) entDesc     // argEntityDescription  // like "group","person"
{
    NSLog(@"in mambReadArrayFileWithDescription: %@  ----------", entDesc  );
    NSURL   *myURLtoReadFrom;
    NSData  *myWritten;
    NSData  *myNSData;
    NSData  *myUnarchived;
    NSMutableArray *my_gbl_array;

    if ([entDesc isEqualToString:@"group"])         { myURLtoReadFrom = gbl_URLToGroup;    my_gbl_array = gbl_arrayGrp;    }
    if ([entDesc isEqualToString:@"person"])        { myURLtoReadFrom = gbl_URLToPerson;   my_gbl_array = gbl_arrayPer;    }
    if ([entDesc isEqualToString:@"member"])        { myURLtoReadFrom = gbl_URLToMember;   my_gbl_array = gbl_arrayMem;    }
    if ([entDesc isEqualToString:@"grprem"])        { myURLtoReadFrom = gbl_URLToGrpRem;   my_gbl_array = gbl_arrayGrpRem; }
    if ([entDesc isEqualToString:@"perrem"])        { myURLtoReadFrom = gbl_URLToPerRem;   my_gbl_array = gbl_arrayPerRem; }

    myWritten = [[NSData alloc] initWithContentsOfURL: myURLtoReadFrom];
    if (myWritten == nil) {
        NSLog(@"Error reading %@, skip it (ok)", entDesc);
        return;
    }
//tn();  NSLog(@"myWritten=\n%@",myWritten);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//NSLog(@"myappDelegate=%@", myappDelegate);
    myNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myWritten];
//tn();  NSLog(@"myNSData=\n%@",myNSData);

    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
//tn();  NSLog(@"myUnarchived=\n%@",myUnarchived );

    //if ([entDesc isEqualToString:@"group"])         { gbl_arrayGrp       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myLocalArray]; }
    if ([entDesc isEqualToString:@"group"])  { gbl_arrayGrp       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"person"]) { gbl_arrayPer       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"member"]) { gbl_arrayMem       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"grprem"]) { gbl_arrayGrpRem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"perrem"]) { gbl_arrayPerRem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }

} // end of mambReadArrayFileWithDescription


// check these for invalid stuff
//    gbl_arrayPer
//    gbl_arrayGrp  
//    gbl_arrayMem
//             example data:
//                  @"~My Family||",
//                  @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
//                  @"~My Family|~Sister1|",
//
//    NSInteger gbl_MAX_groups;                //  50 max in app
//    NSInteger gbl_MAX_persons;               // 250 max in app and max in group
//    NSInteger gbl_MAX_personsInGroup;        // max 250 members in a Group
//
- (NSInteger) mambCheckForCorruptData
{
tn();
  NSLog(@"in mambCheckForCorruptData    BEG");
    NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString: @"|"];
    NSArray        *flds;

    const char *constant_char;                                           // NSString object to C str
    NSString  *fname,*fmth,*fday,*fyr,*fhr,*fmin,*fampm;
    char      cname[32], cmth[32], cday[32], cyr[32], chr[32], cmin[32], campm[32];
    NSString *fcity, *fprov, *fcoun, *fhighsec;
    char allowedCharactersInName[128] = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    char allowedCharactersInCity[128] = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-";
    int daysinmonth[12]     ={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int daysinmonth_leap[12]={31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    // get the current year
    NSCalendar       *gregorian;
    NSDateComponents *dateComponents;
    NSInteger         myCurrentYearInt;
    gregorian        = [NSCalendar currentCalendar]; 
    dateComponents   = [gregorian components: (NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear) 
                                    fromDate: [NSDate date]
    ];
    myCurrentYearInt = [dateComponents year];

    //  int sall(char *s,char *set) // returns 1 if  str s consists entirely of chars in str set, else 0

    NSInteger numRecords;
    NSInteger numFields;

  NSLog(@"BEG   CHECK  group");
    //      BEG   CHECK  group
    numRecords = 0;   numFields = 0;
    for (NSString *psvGrp in gbl_arrayGrp) {     // get PSV of arg name
        numRecords = numRecords + 1;
       
        // check for exactly 3 fields
        //                  @"~My Family||",
        //
        flds  = [psvGrp componentsSeparatedByCharactersInSet: mySeparators];
        if (flds.count != 3)                                   return   1;   // s/b 3   for test

        fname    = flds[0];

        if (fname.length < 1)                                  return   2;
        if (fname.length > gbl_MAX_lengthOfName)               return   3;

        // check for invalid characters in name
        //
        if ([fname canBeConvertedToEncoding:         NSUTF8StringEncoding] == NO) return 4;
        constant_char = [fname cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cname, constant_char);                                        // NSString object to C str  // because of const
        if (cname[0] == '~') {        // ~ only legal as first char
            if (sall(cname + 1, allowedCharactersInName) == 0) return   4;
        } else {
            if (sall(cname,     allowedCharactersInName) == 0) return   5;
        }
    }
    if (numRecords <   2 )                                     return   6;  // 2 is MAGIC for the 2 example groups
    if (numRecords >  gbl_MAX_groups)                          return   7;  // max groups is 50
  NSLog(@"END   CHECK  group");



  NSLog(@"BEG   CHECK  person");
    //      BEG   CHECK  person)";
    for (NSString *psvPer in gbl_arrayPer) {     // get PSV of arg name
        numRecords = numRecords + 1;

        // check for exactly 12 fields
        //                  @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
        //
        flds  = [psvPer componentsSeparatedByCharactersInSet: mySeparators];
        
  NSLog(@"flds=[%@]",flds);
  NSLog(@"flds.count=[%ld]",(long)flds.count);
        if (flds.count != 12)                                 return  11;  
        
        fname    = flds[0];
        fmth     = flds[1];
        fday     = flds[2];
        fyr      = flds[3];
        fhr      = flds[4];
        fmin     = flds[5];
        fampm    = flds[6];
        fcity    = flds[7];
        fprov    = flds[8];
        fcoun    = flds[9];
        fhighsec = flds[10];  // "" or "hs"

        // check for invalid  name fld
        if (fname.length < 1)                                  return  12;
        if (fname.length > gbl_MAX_lengthOfName)               return  13;
        constant_char = [fname  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cname, constant_char);                                        // NSString object to C str  // because of const
        //
        if (cname[0] == '~') {        // ~ only legal as first char of name
            if (sall(cname + 1, allowedCharactersInName) == 0) return  14;
        } else {
            if (sall(cname,     allowedCharactersInName) == 0) return  15;
        }


        // check for invalid  month fld
        if (fmth.length < 1)                                   return  16;
        if (fmth.length > 2)                                   return  17;
        constant_char = [fmth  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cmth, constant_char);                                        // NSString object to C str  // because of const
        if (sall(cmth, "0123456789") == 0)                     return  18;
        if (atoi(cmth) <  1)                                   return  19;
        if (atoi(cmth) > 12)                                   return  20;

        // check for invalid  year fld
        if (fyr.length != 4)                                   return  25;
        constant_char = [fyr  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cyr, constant_char);                                        // NSString object to C str  // because of const
        if (sall(cyr, "0123456789") == 0)                      return  26;
        if (atoi(cyr) < gbl_earliestYear)                      return  27;
        if (atoi(cyr) > (int) myCurrentYearInt + 1)            return  28;


        // check for invalid  day fld
        if (fday.length < 1)                                   return  21;
        if (fday.length > 2)                                   return  22;
        constant_char = [fday  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cday, constant_char);                                        // NSString object to C str  // because of const
        if (sall(cday, "0123456789") == 0)                     return  23;
        if (atoi(cday) <  1)                                   return  24;
        //
        if (    atoi(cyr) % 400 == 0                            //  invalid day of month
            || (atoi(cyr) % 100 != 0  &&  atoi(cyr) % 4 == 0))  // if leap year
        {
            if (atoi(cday) > daysinmonth_leap[ atoi(cmth) ])   return  25;
        } else {
            if (atoi(cday) > daysinmonth     [ atoi(cmth) ])   return  25;
        }


        // check for invalid  hr fld
        if (fhr.length < 1)                                    return  29;
        if (fhr.length > 2)                                    return  30;
        constant_char = [fhr  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(chr, constant_char);                                        // NSString object to C str  // because of const
ksn(chr);
        if (sall(chr, "0123456789") == 0)                      return  30;
        if (atoi(chr) <  1)                                    return  31;
        if (atoi(chr) > 12)                                    return  32;


        // check for invalid  min fld
        if (fmin.length < 1)                                   return  33;
        if (fmin.length > 2)                                   return  34;
        constant_char = [fmin  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cmin, constant_char);                                        // NSString object to C str  // because of const
        if (sall(cmin, "0123456789") == 0)                     return  35;
        if (atoi(cmin) <  0)                                   return  36;
        if (atoi(cmin) > 59)                                   return  37;


        // check for invalid  am/pm (0/1) fld
        if (fampm.length != 1)                                 return  38;
        constant_char = [fampm  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(campm, constant_char);                                        // NSString object to C str  // because of const
        if (sall(campm, "0123456789") == 0)                    return  39;
        if (atoi(campm) <  0)                                  return  40;
        if (atoi(campm) >  1)                                  return  41;

//<.>
//        fcity    = flds[7];
//        fprov    = flds[8];
//        fcoun    = flds[9];
//        fhighsec = flds[10];  // "" or "hs"
//<.>
//





//<.>

    }
  NSLog(@"END   CHECK  person");

  NSLog(@"BEG   CHECK  member");
    //     "BEG   CHECK  member)";
    for (NSString *psvMem in gbl_arrayMem) {   // loop thru gbl group member array
    }
  NSLog(@"END   CHECK  member");

  NSLog(@"in mambCheckForCorruptData    END");

  return 0;  // no errors

}  // end of mambCheckForCorruptData


- (void) handleCorruptDataErrNum:  (NSInteger) argCorruptDataErrNum
{
  NSLog(@"in handleCorruptDataNum    BEG");
  NSLog(@"argCorruptDataErrNum=[%ld]",(long)argCorruptDataErrNum);

//automatic backup?  how often?  when?
//
//-------------------------------------------
//RECOVERY from Corrupt Data
//-------------------------------------------
//Corrupt data has caused your current data to be lost.
//
//Do these RECOVERY steps to get back your latest BACKUP data.
//
//   1. Leave this App alone right now.  Do not tap OK.
//   2. On this device, go to the mail App.
//   3. Open your MOST RECENT email
//      with the subject "Me and my BFFs BACKUP"
//      and the attachment "BACKUP.mamb".
//   4. Long-press the email attachment.
//   4. Tap and hold on the email attachment.
//   5. Tap YES for doing the backup recovery.
//   6. When the recovery is done, come back here and tap OK.
//
//These instructions are also on the home page. Tap the Info button.
//
//The data corruption error number was 123.   auto-email to web site?
//-------------------------------------------
//
//
//Tap OK and let the App clean up.
//Corrupt Data has been found
//
//RECOVER your latest BACKUP.
//This App will now start running with only the example data that comes with the App.
//
//Hopefully, you recently backed up your data by sending yourself an email with group "BACKUP".
//
//Then let the App put back your saved birth information for all the people you have entered before (or imported before).
//You will also get back the groups you had at the time you backed up.
//


  NSLog(@"in handleCorruptDataNum    END");
} // end of handleCorruptDataNum


- (NSData *) mambKriptOnThisNSData:  (NSData *)  argMyArchive   // arg is NSData/archived, returns a file-writeable NSData
{
//tn();trn("in KRIPT ON");
    NSString      *myKeyStr = @"Lorem ipsum calor sit amet, cons"; // len 32
    NSData        *myEncrypted;
    NSData        *myb64Data; 
    NSMutableData *myb64Muta; 

    myEncrypted = [argMyArchive AES256EncryptWithKey: myKeyStr];               // (1) argMyArchive to myEncrypted
//    printf("myEncrypted=     KriptOn\n%s\n", [[myEncrypted description] UTF8String]);

    myb64Data   = [myEncrypted base64EncodedDataWithOptions: 0];              // (2) myEncrypted to myb64Data
//tn();  NSLog(@"myb64Data=     KriptOn\n%@",myb64Data);

    myb64Muta   = [[NSMutableData alloc] initWithData: myb64Data];            // (3) myb64Data to myb64Muta obfuscated (in place)
    uint8_t *bytes = (uint8_t *)[myb64Muta bytes];                            
    uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44}; 
    const int patternLengthInBytes = 8;    // len 64 bit
    for(int index = 0; index < [myb64Data length]; index++) {
         bytes[index] ^= pattern[index % patternLengthInBytes];
    }
//tn();  NSLog(@"myb64MutaOBFUSCATED=     KriptOn\n%@",myb64Muta);

    return myb64Muta;

} // end of mambKriptOnThisNSData


- (NSData *) mambKriptOffThisNSData: (NSData *)  argMyNSData  //  arg is a file-writeable NSData, returns an NSData/archived
{
//tn();trn("in KRIPT OFF");
    NSMutableData *myb64Muta; 
    NSString      *myKeyStr = @"Lorem ipsum calor sit amet, cons"; // len 32
    NSData        *myEncrypted;
    NSData        *myArchive; 

    myb64Muta   = [[NSMutableData alloc] initWithData: argMyNSData];         // (3) myb64Muta obfuscated to myb64Muta (in place)
    uint8_t *bytes = (uint8_t *)[myb64Muta bytes];                       
    uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44};
    const int patternLengthInBytes = 8;
    for(int index = 0; index < [myb64Muta length]; index++) {
        bytes[index] ^= pattern[index % patternLengthInBytes];
    }
//tn();  NSLog(@"myb64Muta=     KriptOff\n%@",myb64Muta);

    myEncrypted = [[NSData alloc] initWithBase64EncodedData: myb64Muta       // (2) myb64Muta to myEncrypted
                                                    options: 0];  
//tn();  NSLog(@"myEncrypted=     KriptOff\n%@",myEncrypted );

    myArchive = [myEncrypted AES256DecryptWithKey: myKeyStr];                // (2) myEncrypted to myArchive
//    NSLog(@"myArchive=     KriptOff\n%@",myArchive);
    //printf("myArchiveSTR=\n%s\n", [[myArchive description] UTF8String]);

    return myArchive;

} // end of mambKriptOffThisNSData



//- (void) mambWriteLastEntityFileIntoDir: (NSString *)      argAppDocDirStr
//                       usingFileManager: (NSFileManager *) argSharedFM
//
- (void) mambWriteLastEntityFile  // uses gbl_appDocDirStr gbl_lastSelectedPerson gbl_lastSelectedGroup gbl_fromHomeCurrentSelectionType 
{
    NSLog(@"in mambWriteLastEntityFile() ----------");

    //NSString *pathToLastEntity = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd1"];
    //NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];
    NSError *err01;

    NSData     *myLastEntityArchive;    
    NSData     *myLastEntityDataFil;        //  final NSData to write to file

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method myappDelegate in appDelegate.m

    // remove old (because no overcopy),
    // write out new lastEntity file with current entity
    [gbl_sharedFM removeItemAtURL: gbl_URLToLastEnt
                            error: &err01];
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity %@", err01); }

        // 20150113, 20150121 NEW FORMAT=  exampl "person|~Jim|group|~Family"  which means the following:
        //    1. set "person" on home segemented control  (1st attribute is what to put on home screen)
        //    2. set grey highlight on row for "~Jim"
        //    3. set gbl_lastSelectedGroup = "~Family"
NSLog(@"enterBG_gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
NSLog(@"enterBG_gbl_lastSelectedGroup=%@" , gbl_lastSelectedGroup);
NSLog(@"enterBG_gbl_fromHomeCurrentSelectionType=%@", gbl_fromHomeCurrentSelectionType); // determines who goes first attribute

   
    if (gbl_lastSelectedPerson == NULL ||  gbl_lastSelectedGroup == NULL  ||   gbl_fromHomeCurrentSelectionType == NULL ||
        gbl_lastSelectedPerson.length == 0 ||  gbl_lastSelectedGroup.length == 0  ||   gbl_fromHomeCurrentSelectionType.length == 0 ) {
//trn("using DEFAULT lastEnt");
        self.myLastEntityStr =  DEFAULT_LAST_ENTITY  ;  // DEFAULT lastEntity

    } else {  // not empty vars
        if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {     // determine if group or person goes first
            self.myLastEntityStr = [NSString stringWithFormat:@"person|%@|group|%@", gbl_lastSelectedPerson, gbl_lastSelectedGroup];
        } else {
            self.myLastEntityStr = [NSString stringWithFormat:@"group|%@|person|%@", gbl_lastSelectedGroup, gbl_lastSelectedPerson];
        }
    }
    NSLog(@"self.myLastEntityStr=%@",self.myLastEntityStr);   // this is file contents to write out


//tn();trn("ENCODE HERE :");
       myLastEntityArchive = [NSKeyedArchiver  archivedDataWithRootObject: self.myLastEntityStr];
//tn();  NSLog(@"myLastEntityArchive =\n%@",myLastEntityArchive );

       myLastEntityDataFil = [myappDelegate mambKriptOnThisNSData: (NSData *) myLastEntityArchive];
//tn();  NSLog(@"myLastEntityDataFil =\n%@", myLastEntityDataFil);
       
    // This will ensure that your save operation has a fighting chance to successfully complete,
    // even if the app is interrupted.
    //
    // get background task identifier before you dispatch the save operation to the background
    UIApplication *application = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier __block task = [application beginBackgroundTaskWithExpirationHandler:^{
        if (task != UIBackgroundTaskInvalid) {
            [application endBackgroundTask:task];
            task = UIBackgroundTaskInvalid;
        }
    }];
    // now dispatch the save operation
    dispatch_async(dispatch_get_main_queue(),  ^{
        // do the save operation here
        [myLastEntityDataFil writeToURL: gbl_URLToLastEnt
                             atomically: YES ];

        // now tell the OS that you're done
        if (task != UIBackgroundTaskInvalid) {
            [application endBackgroundTask:task];
            task = UIBackgroundTaskInvalid;
        }
     });

BOOL haveLastEntity        = [gbl_sharedFM fileExistsAtPath: gbl_pathToLastEnt];
NSLog(@"haveLastEntity= %d", haveLastEntity);
tn();trn("finished WRITE   lastEntity");

} // end of    mambWriteLastEntityFile()



//- (NSString *) mambReadLastEntityFileFromDir: (NSString *)      argAppDocDirStr
//                            usingFileManager: (NSFileManager *) argSharedFM
//
- (NSString *) mambReadLastEntityFile
{
    NSLog(@"in mambReadLastEntityFile() ----------");
    //NSString *pathToLastEntity = [argAppDocDirStr stringByAppendingPathComponent: @"mambLastEntity.txt"];
    //NSString *pathToLastEntity = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd1"];
    //NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];

    NSData     *myLastEntityDataFil;        // NSData in file
    NSData     *myLastEntityArchive;
    NSString   *myLastEntityDecoded;    

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    // for test, remove lastEntity file
    //  [argSharedFM removeItemAtURL: gbl_URLToLastEntity
    //                      error:&err01];
    //  if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity test rm %@", err01); }

    BOOL haveLastEntity        = [gbl_sharedFM fileExistsAtPath: gbl_pathToLastEnt];
    NSLog(@"haveLastEntity= %d", haveLastEntity);

// haveLastEntity = NO; // for test

    if ( ! haveLastEntity ) {
        // the write below, because there is no lastEntity file "mambd1",
        // removes the old lastEntity file and writes out new lastEntity file with DEFAULT entity

        //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // for global method myappDelegate in appDelegate.m
        [myappDelegate mambWriteLastEntityFile];
        myLastEntityDecoded  =  DEFAULT_LAST_ENTITY;  // DEFAULT lastEntity from mambWriteLastEntityFileIntoDir
    } else {

        // here we have the lastEntity file, so read and decode it
        //
        myLastEntityDataFil = [[NSData alloc] initWithContentsOfURL: gbl_URLToLastEnt ];    // READ READ READ READ READ READ READ READ
//tn();           NSLog(@"myLastEntityDataFil=%@",myLastEntityDataFil);

//        tn();trn("DECODE lastEntity  HERE :");

        myLastEntityArchive = [myappDelegate mambKriptOffThisNSData: (NSData *) myLastEntityDataFil];
//tn();  NSLog(@"myLastEntityArchive =\n%@",myLastEntityArchive );
       
        myLastEntityDecoded = [NSKeyedUnarchiver unarchiveObjectWithData: myLastEntityArchive]; 
    }

tn();  NSLog(@"at end of   mambReadLastEntityFile  myLastEntityDecoded=\n%@",myLastEntityDecoded); // should = gbl_arrayGrp
    return myLastEntityDecoded;

} // end of  mambReadLastEntityFile()




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
    // or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates.
    // Games should use this method to pause the game.

    NSLog(@"in applicationWillResignActive()  in appdelegate");


    NSLog(@"finished  applicationWillResignActive()  in appdelegate");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources,   *SAVE USER DATA*   , invalidate timers,
    // and store enough application state information to restore your application
    // to its current state in case it is terminated later.
    // If your application supports background execution,
    // this method is called instead of applicationWillTerminate: when the user quits.
    //
    NSLog(@"applicationDidEnterBackground()!  in appdelegate");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m


// CHANGE  20150127  Separate out "remember" data from gbl_arrayPer and gbl_arrayGrp into their own file
// CHANGE  20150127  write ONLY "remember" data here at "end of app" not per,grp

    // 1. save person + group in order to remember the last user report parameter selections for each person and for each group
    // 2.   Note: any changes done to per,grp,grpmember  are saved right away in green edit screens
    // 3. also save lastentity.dat to highlight correct entity in seg control at top
    // 
    //BOOL ret01;
    //NSError *err01;

    [myappDelegate mambWriteLastEntityFile];

    //BOOL haveLastEntity        = [gbl_sharedFM fileExistsAtPath: gbl_pathToLastEnt];
    //NSLog(@"haveLastEntity= %d", haveLastEntity);

    // save only remember files (data dealt with at change time)
    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"perrem"];
    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"grprem"];
    

    NSLog(@"finished  did enter BG!");
} // applicationDidEnterBackground



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"in applicationWillEnterForeground()  in appdelegate");
    // Called as part of the transition from the background to the inactive state;
    // here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"in applicationDidBecomeActive()  in appdelegate");
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, OPTIONALLY REFRESH THE USER INTERFACE.
}


- (NSIndexPath *) indexpathForTableView: (UITableView *) argTableView
                         havingCellText: (NSString *)    argCellText;
{
//NSLog(@"in indexpathForTableView");
//    NSLog(@"argTableView=%@",argTableView);
//    NSLog(@"argCellText=%@",argCellText);
    NSInteger nSections = [argTableView numberOfSections];

    for (int j=0; j<nSections; j++) {

        NSInteger nRows = [argTableView numberOfRowsInSection: j];
        for (int i=0; i<nRows; i++) {

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i
                                                        inSection: j];
            UITableViewCell *cell = [argTableView cellForRowAtIndexPath: indexPath];

//NSLog(@"cell.textLabel.text =%@",cell.textLabel.text );
            if ([cell.textLabel.text isEqualToString: argCellText]) {
//trn("FOUND CELL TEXT");
                return indexPath;
            }
        }
    }
//trn("DID NOT  FIND CELL TEXT");
    return nil;
} // end of  indexpathForTableView


//+(BOOL)isJailbroken {
- (BOOL)isJailbroken {
    NSURL* url = [NSURL URLWithString:@"cydia://package/com.example.package"];
    return [[UIApplication sharedApplication] canOpenURL:url];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"in applicationWillTerminate()  in appdelegate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




// get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs or gbl_grp_CSVs_B
// but possibly excluding  one person who is kingpin of grpone report "MY Best Match in Group ..." 
// RETURNs 0/1 no/yes  kingpinIsInGroup
//
- (NSInteger) getNSArrayOfCSVsForGroup: (NSString *) argGroupName
               excludingThisPersonName: (NSString *) argPersonToCompareEveryoneElseWith // non-empty string for groupOne
       puttingIntoArrayWithDescription: (NSString *) argArrayDescription                // destination array "" or "_B"
{
//tn();    NSLog(@"=in getNSArrayOfCSVsForGroup");
//    NSLog(@"argGroupName=[%@]",argGroupName);
//    NSLog(@"argPersonToCompareEveryoneElseWith =%@",argPersonToCompareEveryoneElseWith );
//  NSLog(@"argArrayDescription =%@",argArrayDescription );

    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // access global methods in appDelegate.m
    NSInteger  we_have_hit_target_group;
    we_have_hit_target_group = 0;

    if ([argArrayDescription isEqualToString: @"gbl_grp_CSVs"]) {
//trn("init  gbl_grp_CSVs");
        [gbl_grp_CSVs removeAllObjects];               // empty array for this new group
         gbl_grp_CSVs = [[NSMutableArray alloc] init];  // init  array for this new group
//NSMutableArray *outputArray=[NSMutableArray new];
//         gbl_grp_CSVs = [NSMutableArray new];  // init  array for this new group

    }
    if ([argArrayDescription isEqualToString: @"gbl_grp_CSVs_B"]) {
//trn("init  gbl_grp_CSVs_B");
        [gbl_grp_CSVs_B removeAllObjects];               // empty array for this new group
         gbl_grp_CSVs_B = [[NSMutableArray alloc] init];  // init  array for this new group
    }

    gbl_numPeopleInCurrentGroup = 0;  // INIT
    gbl_kingpinIsInGroup        = 0;  // INIT

//    NSInteger insertAt;
//    insertAt = -1;
    for (id member in gbl_arrayMem) {   // loop thru gbl group member array

        NSCharacterSet *mySeparators           = [NSCharacterSet characterSetWithCharactersInString:@"|"];
        NSArray        *groupMemberComponents  = [member componentsSeparatedByCharactersInSet: mySeparators];
//NSLog(@"groupMemberComponents  =%@",groupMemberComponents  );

        NSString *nameOfGroup  = groupMemberComponents[0];  // group name is 1st fld
        NSString *nameOfMember = groupMemberComponents[1];  // member (person) name is 2nd fld
//    NSLog(@"nameOfGroup  =%@",nameOfGroup  );
//    NSLog(@"nameOfMember =%@",nameOfMember );

        if (! [nameOfGroup isEqualToString: argGroupName]) {
            if (we_have_hit_target_group == 1) break;
            else                              continue;
        }

        // here we are in our target group
        we_have_hit_target_group = 1;

        gbl_numPeopleInCurrentGroup = gbl_numPeopleInCurrentGroup + 1;

        
        if (  [nameOfMember isEqualToString: argPersonToCompareEveryoneElseWith]) {
            gbl_kingpinIsInGroup = 1;
            continue;
        }

//tn(); NSLog(@"member=%@", member);

        // add this member's CSV to our array of Group CSVs
        //
        NSString *PSVthatWasFound;
        do {
            // grab this members's Obj PSV from gbl_arrayPer
            PSVthatWasFound = nil;


//  NSLog(@"nameOfMember=%@",nameOfMember);
           NSString *myCSVobj = [myappDelegate getCSVforPersonName: (NSString *) nameOfMember]; 
//  NSLog(@"myCSVobj =%@",myCSVobj );

           if (myCSVobj != nil) {

                if ([argArrayDescription isEqualToString: @"gbl_grp_CSVs"]) {

                    [gbl_grp_CSVs   addObject: myCSVobj];
//                    insertAt = insertAt + 1;
//                    [gbl_grp_CSVs   insertObject: myCSVobj atIndex: insertAt];


//trn("[gbl_grp_CSVs   addObject: myCSVobj];");
//  NSLog(@"gbl_grp_CSVs=%@",gbl_grp_CSVs);
//  NSLog(@"gbl_grp_CSVs.count=%ld",(unsigned long)gbl_grp_CSVs.count);
                }
                if ([argArrayDescription isEqualToString: @"gbl_grp_CSVs_B"]) {
                    [gbl_grp_CSVs_B addObject: myCSVobj];
//trn("[gbl_grp_CSVs_B  addObject: myCSVobj];");
//  NSLog(@"myCSVobj =%@",myCSVobj );
//  NSLog(@"gbl_grp_CSVs_B=%@",gbl_grp_CSVs);
                }
           }
        } while (FALSE); // add this member's CSV to our array of Group CSVs

    }   // loop thru gbl group member array 
// get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs or gbl_grp_CSVs_B
//tn();
//  NSLog(@"gbl_grp_CSVs=%@",gbl_grp_CSVs);
//  NSLog(@"gbl_grp_CSVs_B=%@",gbl_grp_CSVs_B);
//tn();

    return gbl_kingpinIsInGroup;

} // end of  getNSArrayOfCSVsForGroup


- (NSString *) getPSVforPersonName: (NSString *) argPersonName;
{
    NSString *myPerPSV;
    myPerPSV = nil;

    NSString *prefixStr5 = [NSString stringWithFormat: @"%@|", argPersonName];  // notice '|'
    for (NSString *elt in gbl_arrayPer) {     // get PSV of arg name
        if ([elt hasPrefix: prefixStr5]) { 
            myPerPSV = elt;
            break;
        }
    }
    if (myPerPSV == nil) return nil;
    return myPerPSV;

} // end of  getPSVforPersonName

//  NSLog(@"in getCSVforPersonName !");
//  NSLog(@"argPersonName=%@",argPersonName);

// get NSString  CSV  for a person name
//
//   1. get PSV NSString from gbl_arrayPer
//   2. make C string from PSV 
//   3. grab birth info fields 
//   4. make C string CSV 
//   5. return NSString of the C string CSV 
//
- (NSString *) getCSVforPersonName: (NSString *) argPersonName;
{

//  NSLog(@"in getCSVforPersonName !");
//  NSLog(@"argPersonName=%@",argPersonName);
    // 1.
    NSString *myPerPSV;
    myPerPSV = nil;

    NSString *prefixStr3 = [NSString stringWithFormat: @"%@|", argPersonName];
    for (NSString *elt in gbl_arrayPer) {     // get PSV of arg name
        if ([elt hasPrefix: prefixStr3]) {  // TODO  add |  ?
            myPerPSV = elt;
            break;
        }
    }
    if (myPerPSV == nil) return nil;

    // 2.
    const char *my_psvc; // psv=pipe-separated values                 // NSString object to C string
    char my_psv[128];                                                 // NSString object to C string
    my_psvc = [myPerPSV cStringUsingEncoding:NSUTF8StringEncoding];   // NSString object to C string
    strcpy(my_psv, my_psvc);                                          // NSString object to C string

    // 3.    
    char psvName[32], psvMth[4], psvDay[4], psvYear[8]; 
    char psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];

    strcpy(psvName, csv_get_field(my_psv, "|", 1));
    strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
    strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
    strcpy(psvYear, csv_get_field(my_psv, "|", 4));
    strcpy(psvHour, csv_get_field(my_psv, "|", 5));
    strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
    strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
    strcpy(psvCity, csv_get_field(my_psv, "|", 8));
    strcpy(psvProv, csv_get_field(my_psv, "|", 9));
    strcpy(psvCountry, csv_get_field(my_psv, "|", 10));

//ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
//ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
//
    // get longitude and timezone hoursDiff from Greenwich
    // by looking up psvCity, psvProv, psvCountry
    //
    seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
    
    strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
    strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));

    
    // 4.
    char csv_person_string[128];
    sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
            psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);

//ksn(csv_person_string);tn();

    NSString *myReturnNSStringCSV;
    myReturnNSStringCSV = [NSString stringWithUTF8String: csv_person_string];  // convert C string to NSString

    return myReturnNSStringCSV;

} // end of  getCSVforPersonName

// It's a fishy business to mess with the font names.
// And supposedly you have an italic font and you wanna make it bold -
// adding simply @"-Bold" to the name doesn't work. There's much more elegant way:
//
// You might find useful UIFontDescriptorTraitItalic trait if you need to get an italic font
//
- (UIFont *)boldFontWithFont: (UIFont *) argFont
{
//  NSLog(@"in boldFontWithFont,");

    UIFontDescriptor *fontD = [argFont.fontDescriptor fontDescriptorWithSymbolicTraits: UIFontDescriptorTraitBold];
//  NSLog(@"fontD =%@",fontD );

    UIFont *myBoldedFont = [UIFont fontWithDescriptor: fontD
                                                 size: 0];    // size:0 means 'keep the size as it is in the descriptor'.
//  NSLog(@"myBoldedFont =%@",myBoldedFont );

    return myBoldedFont ;
}



- (void) mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) argArrayDesc; // like "group" "grprem"
{
    // assumption  "}" does not occur in array of PSVs,
    // assumption  "\t" sorts below all letters,nums,space

  NSLog(@"in mambSortArrayOfPSVsOnFieldOne");
//  NSLog(@"BEG  gbl_arrayPer  =%@",gbl_arrayPer  );

    // make big string from starting array  (PSV field sep = "|")
    //
    NSString *joinedString;

    if ([argArrayDesc isEqualToString: @"group"])    { joinedString = [gbl_arrayGrp    componentsJoinedByString: @"}"]; }
    if ([argArrayDesc isEqualToString: @"person"])   { joinedString = [gbl_arrayPer    componentsJoinedByString: @"}"]; }
    if ([argArrayDesc isEqualToString: @"member"])   { joinedString = [gbl_arrayMem    componentsJoinedByString: @"}"]; }
    if ([argArrayDesc isEqualToString: @"grprem"])   { joinedString = [gbl_arrayGrpRem componentsJoinedByString: @"}"]; }
    if ([argArrayDesc isEqualToString: @"perrem"])   { joinedString = [gbl_arrayPerRem componentsJoinedByString: @"}"]; }

    // now we have one string with lines sep by "}"  and fields sep by "|"

    // change delimiter of PSV 
    NSString *stringWithNewDelim   = [joinedString stringByReplacingOccurrencesOfString:@"|" withString:@"\t"];
    //  NSLog(@"stringWithNewDelim   =%@",stringWithNewDelim   );

    // now we have one string with lines sep by "}"  and fields sep by "\t" (tab)

    // make temp array of lines with  new  delimiter
    //
    NSMutableArray *mutArrayNewTmp = (NSMutableArray *)
       [stringWithNewDelim componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
    //  NSLog(@"mutArrayNewTmp =%@",mutArrayNewTmp );

    // now we have tmp array with each element  a TSV (string with fields sep by "\t" TAB)

    // sort temp array  mutArrayNewTmp  here (has new delimiters)
    //
    if (mutArrayNewTmp)  { [mutArrayNewTmp sortUsingSelector: @selector(caseInsensitiveCompare:)]; }

    // now we have SORTED tmp array with each element  a TSV (string with fields sep by "\t" TAB)

    // make big string from  sorted temp  array
    //
    NSString *joinedStringSorted   = [mutArrayNewTmp componentsJoinedByString:@"}"];
    //  NSLog(@"joinedStringSorted   =%@",joinedStringSorted   );

    // now we have one string with SORTED lines sep by "}"  and fields sep by "\t" (tab)

    // change delimiter of PSV back to original
    //
    NSString *stringWithNewDelim2  = [joinedStringSorted stringByReplacingOccurrencesOfString:@"\t" withString:@"|"];
    //  NSLog(@"stringWithNewDelim2  =%@",stringWithNewDelim2  );

    // now we have one string with SORTED lines sep by "}"  and fields sep by "|" (pipe)

    // make new sorted array with  old PSV delimiter
    //
    if ([argArrayDesc isEqualToString:@"group"])    {
        [gbl_arrayGrp  removeAllObjects];               // empty array
         gbl_arrayGrp    = [[NSMutableArray alloc] init];   // init  array
         gbl_arrayGrp    = (NSMutableArray *)
            [stringWithNewDelim2 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
    }
    if ([argArrayDesc isEqualToString:@"person"])   {
        [gbl_arrayPer  removeAllObjects];               // empty array
         gbl_arrayPer    = [[NSMutableArray alloc] init];   // init  array
         gbl_arrayPer    = (NSMutableArray *)
            [stringWithNewDelim2 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
    }
    if ([argArrayDesc isEqualToString:@"member"])   {
        [gbl_arrayMem  removeAllObjects];               // empty array
         gbl_arrayMem    = [[NSMutableArray alloc] init];   // init  array
         gbl_arrayMem    = (NSMutableArray *)
            [stringWithNewDelim2 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
    }
    if ([argArrayDesc isEqualToString:@"grprem"])   {
        [gbl_arrayGrpRem  removeAllObjects];               // empty array
         gbl_arrayGrpRem = [[NSMutableArray alloc] init];   // init  array
         gbl_arrayGrpRem = (NSMutableArray *)
            [stringWithNewDelim2 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
    }
    if ([argArrayDesc isEqualToString:@"perrem"])   {
        [gbl_arrayPerRem  removeAllObjects];               // empty array
         gbl_arrayPerRem = [[NSMutableArray alloc] init];   // init  array
         gbl_arrayPerRem = (NSMutableArray *)
            [stringWithNewDelim2 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
    }

//  NSLog(@"END  gbl_arrayPer  =%@",gbl_arrayPer  );

} // end of mambSortArrayOfPSVsOnFieldOne



// TODO try this instead of new function:
//     [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; 
//
//- (void) mambSortMembershipFile   // sorts gbl_arrayMem  on first 2 flds (group name, member name) // sorts on whole line
//{
//    // assumption  "}" does not occur in array of PSVs,
//    // assumption  "\t" sorts below all letters,nums,space
//
//  NSLog(@"in mambSortMembershipFile");
//
//    // make big string from starting array  (PSV field sep = "|")
//    //
//    NSString *joinedString;
//    joinedString = [gbl_arrayMem  componentsJoinedByString: @"}"]; 
//
//    // now we have one string with lines sep by "}"  and fields sep by "|"
//
//    // change delimiter of PSV 
//    NSString *stringWithNewDelim   = [joinedString stringByReplacingOccurrencesOfString:@"|" withString:@"\t"];
//    //  NSLog(@"stringWithNewDelim   =%@",stringWithNewDelim   );
//
//    // now we have one string with lines sep by "}"  and fields sep by "\t" (tab)
//
//    // make temp array with  new delimiter
//    //
//    NSMutableArray *mutArrayNewTmp = (NSMutableArray *)
//       [stringWithNewDelim componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
//    //  NSLog(@"mutArrayNewTmp =%@",mutArrayNewTmp );
//
//    // now we have tmp array with each element  a TSV (string with fields sep by "\t" TAB)
//
//    // sort temp array  mutArrayNewTmp  here (has new delimiters)
//    //
//    if (mutArrayNewTmp)  { [mutArrayNewTmp sortUsingSelector: @selector(caseInsensitiveCompare:)]; }
//
//    // now we have SORTED tmp array with each element  a TSV (string with fields sep by "\t" TAB)
//
//    // make big string from  sorted temp  array
//    //
//    NSString *joinedStringSorted   = [mutArrayNewTmp componentsJoinedByString:@"}"];
//    //  NSLog(@"joinedStringSorted   =%@",joinedStringSorted   );
//
//    // now we have one string with SORTED lines sep by "}"  and fields sep by "\t" (tab)
//
//    // change delimiter of PSV back to original
//    //
//    NSString *stringWithNewDelim2  = [joinedStringSorted stringByReplacingOccurrencesOfString:@"\t" withString:@"|"];
//    //  NSLog(@"stringWithNewDelim2  =%@",stringWithNewDelim2  );
//
//    // now we have one string with SORTED lines sep by "}"  and fields sep by "|" (pipe)
//
//
//    // make new sorted array with  old PSV delimiter
//    //
//    [gbl_arrayMem  removeAllObjects];               // empty array
//     gbl_arrayMem    = [[NSMutableArray alloc] init];   // init  array
//     gbl_arrayMem    = (NSMutableArray *)
//        [stringWithNewDelim2 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"}"]];
//
//} //  end of  mambSortMembershipFile 
//



- (CGSize)currentScreenSize {
    CGRect myScreenBounds = [[UIScreen mainScreen] bounds];
    CGSize myScreenSize = myScreenBounds.size;

    if ( NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 ) {  
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if ( UIInterfaceOrientationIsLandscape(interfaceOrientation) ) {
            myScreenSize = CGSizeMake(myScreenSize.height, myScreenSize.width);
        }
    }

    return myScreenSize;
}


- (void) mambChangeGRPMEM_memberNameFrom: (NSString *) arg_originalMemberName
                               toNewName: (NSString *) arg_newMemberName
{
tn();
  NSLog(@"in mambChangeMemberNameFrom: toNewName:  ");
  NSLog(@" TODO   after coded 1. new group  2. member selection  3. group \"view or change\"");

  // TODO   after coded 1. new group  2. member selection  3. group "view or change"
}

- (void) mambChangeGRPMEM_groupNameFrom: (NSString *) arg_originalGroupName
                              toNewName: (NSString *) arg_newGroupName
{
tn();
  NSLog(@"in mambChangeMemberNameFrom: toNewName:  ");
  NSLog(@" TODO   after coded 1. new group  2. member selection  3. group \"view or change\"");

  // TODO   after coded 1. new group  2. member selection  3. group "view or change"
}


@end




        // - (void)setOutputFormat:(NSPropertyListFormat)format
        // // The format in which the receiver encodesits data.
        // // The available formats are NSPropertyListXMLFormat_v1_0 and NSPropertyListBinaryFormat_v1_0.
        //    NSKeyedUnarchiver *myUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
        //    [myUnarchiver setOutputFormat: (NSPropertyListFormat)NSPropertyListBinaryFormat_v1_0]
   
            
    // new base64 etc.
    //
    // Convert string to nsdata e.g.
    //   NSData   *dataFromString = [NSKeyedArchiver   archivedDataWithRootObject: aString];
    //   NSString *stringFromData = [NSKeyedUnarchiver unarchiveObjectWithData: dataFromString];
    //
    // Convert NSData to Base64 data
    //   NSData *base64Data = [dataTake2 base64EncodedDataWithOptions:0];
    //   NSLog(@"%@", [NSString stringWithUTF8String:[base64Data bytes]]);
    //
    // Now convert back from Base64
    //   NSData *nsdataDecoded = [base64Data initWithBase64EncodedData:base64Data options:0];
    //   NSString *str = [[NSString alloc] initWithData:nsdataDecoded encoding:NSUTF8StringEncoding];
    //   NSLog(@"%@", str);
    //
    // Convert NSString <---> c string 
    //   NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSStrin
    //
    //   const char *my_psvc;  // psv=pipe-separated values
    //   char my_psv[1024], psvName[32];
    //   my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
    //   strcpy(my_psv, my_psvc);


//tn();trn("TEST GROUP ENCODE HERE :");
//
//       NSLog(@"gbl_arrayGrp=%@",gbl_arrayGrp);  // start here
//
//       myGroupArchive   = [NSKeyedArchiver  archivedDataWithRootObject: gbl_arrayGrp]; // (1) gbl_arrayGrp to myGroupArchive
//tn();  NSLog(@"myGroupArchive=\n%@",myGroupArchive);
//
//       myGroupEncrypted = [myGroupArchive AES256EncryptWithKey: myGroupKeyStr];        // (2) myGroupArchive to myGroupEncrypted
//       printf("myGroupEncrypted=\n%s\n", [[myGroupEncrypted description] UTF8String]);
//
//       myGroupb64Data   = [myGroupEncrypted base64EncodedDataWithOptions: 0];          // (3) myGroupEncrypted to myGroupb64Data
//tn();  NSLog(@"myGroupb64Data=\n%@",myGroupb64Data);
//
//       myGroupb64Muta   = [[NSMutableData alloc] initWithData: myGroupb64Data];        // (4) myGroupb64Data to myGroupb64Muta
//
//       uint8_t *bytes = (uint8_t *)[myGroupb64Muta bytes];                             // (5) myGroupb64Muta to myGroupb64Muta obfuscated
//       uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44};
//       const int patternLengthInBytes = 8;
//       for(int index = 0; index < [myGroupb64Data length]; index++) {
//            bytes[index] ^= pattern[index % patternLengthInBytes];
//       }
//tn();  NSLog(@"myGroupb64MutaOBFUSCATED=\n%@",myGroupb64Muta);
//
//
//
//
//tn();trn("TEST GROUP DECODE HERE :");
//
////       uint8_t *bytes = (uint8_t *)[myGroupb64Muta bytes];                             // (5) myGroupb64Muta obfuscated to myGroupb64Muta 
////       uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44}; // or whatever
////       const int patternLengthInBytes = 8;
////
//       for(int index = 0; index < [myGroupb64Data length]; index++) {
//            bytes[index] ^= pattern[index % patternLengthInBytes];
//       }
//tn();  NSLog(@"myGroupb64Muta=\n%@",myGroupb64Muta);
//
//
//       myGroupEncrypted = [[NSData alloc] initWithBase64EncodedData: myGroupb64Muta    // (3) myGroupb64Muta to myGroupEncrypted 
//                                                            options: 0];  
//tn();  NSLog(@"myGroupEncrypted =\n%@",myGroupEncrypted );
//
//       myGroupArchive = [myGroupEncrypted AES256DecryptWithKey: myGroupKeyStr];        // (2) myGroupEncrypted to myGroupArchive
//       NSLog(@"myGroupArchive=\n%@",myGroupArchive);
//       //printf("myGroupArchiveSTR=\n%s\n", [[myGroupArchive description] UTF8String]);
//
//       myGroupDecoded = [NSKeyedUnarchiver unarchiveObjectWithData: myGroupArchive];   // (1) myGroupDecrypted to MyGroupDecoded (gbl_arrayGrp)
//tn();  NSLog(@"myGroupDecoded=\n%@",myGroupDecoded); // should = gbl_arrayGrp
//
//
//

        // for test
        //         //NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"=|"];
        //         NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"];
        //         _arr = [lastEntityStr componentsSeparatedByCharactersInSet: myNSCharacterSet];
        //          NSLog(@"_arr=%@", _arr);


// orig
//             NSData *myLastEntityData       = [NSKeyedArchiver  archivedDataWithRootObject: myLastEntityStr];             // convert string to nsdata/nskeyedarchiver
//             NSLog(@"myLastEntityData=%@",myLastEntityData);
//             NSLog(@"archiv=%@", [NSString stringWithUTF8String:[myLastEntityData       bytes]]);
//             NSData *myLastEntitybase64Data = [myLastEntityData base64EncodedDataWithOptions: 0];                         // Convert NSData/nskeyedarchiver to base64 
//             NSLog(@"base64=%@", [NSString stringWithUTF8String:[myLastEntitybase64Data bytes]]);
//             NSData *nsdataDecoded = [myLastEntitybase64Data initWithBase64EncodedData:myLastEntitybase64Data options:0]; // convert base64 to nsdata/nskeyedarchiver
//             NSString* str1 = [NSKeyedUnarchiver unarchiveObjectWithData: nsdataDecoded ];                                // convert nsdata/nskeyedarchiver to string
//             NSLog(@"decoded string1=%@", str1);
// 

//  OLD OLD tries at Group WRITE
// data is empty with this
//     dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//         __block BOOL ret01 = [myGroupWriteable writeToURL:gbl_URLToGroup atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd2 \n  %@", [err01 localizedFailureReason]);
//     });
//
// data is empty with this
//    // This will ensure that your save operation has a fighting chance to successfully complete,
//    // even if the app is interrupted.
//    //
//    // get background task identifier before you dispatch the save operation to the background
//    UIApplication *application = [UIApplication sharedApplication];
//    UIBackgroundTaskIdentifier __block task = [application beginBackgroundTaskWithExpirationHandler:^{
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//    }];
//    // now dispatch the save operation
//    dispatch_async(dispatch_get_main_queue(),  ^{
//        // do the save operation here
//         BOOL ret01 = [myGroupWriteable writeToURL: gbl_URLToGroup atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd2 \n  %@", [err01 localizedFailureReason]);
//
//        // now tell the OS that you're done
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//     });
//

// OLD OLD  WRITE PERSOn   (empty data)
//     dispatch_async(dispatch_get_main_queue(), ^{                                
//         __block BOOL ret01 = [myPersonWriteable writeToURL:URLToPerson atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//     });
//
//
//    // This will ensure that your save operation has a fighting chance to successfully complete,
//    // even if the app is interrupted.
//    //
//    // get background task identifier before you dispatch the save operation to the background
//    UIApplication *application = [UIApplication sharedApplication];
//    UIBackgroundTaskIdentifier __block task = [application beginBackgroundTaskWithExpirationHandler:^{
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//    }];
//    // now dispatch the save operation
//    dispatch_async(dispatch_get_main_queue(),  ^{
//
//        // do the save operation here
//         BOOL ret01 = [myPersonWriteable writeToURL: gbl_URLToPerson atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//
//        // now tell the OS that you're done
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//     });
//


//       dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//          [myLastEntityDataFil writeToURL:URLToLastEntity
//                               atomically:YES ];
//       });
//

//
//    // lastGood are backups if reg files are somehow bad
//    gbl_pathToGroupLastGood  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambGroupLastGood.txt"];
//    gbl_pathToPersonLastGood = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambPersonLastGood.txt"];
//    gbl_pathToMemberLastGood = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambMemberLastGood.txt"];
//    gbl_URLToGroupLastGood   = [NSURL fileURLWithPath: gbl_pathToGroupLastGood isDirectory:NO];
//    gbl_URLToPersonLastGood  = [NSURL fileURLWithPath: gbl_pathToPersonLastGood isDirectory:NO];
//    gbl_URLToMemberLastGood  = [NSURL fileURLWithPath: gbl_pathToMemberLastGood isDirectory:NO];
//

// used to be at top
//    NSInteger cnt1;  // do a *.count on these arrays to avoid unused variable warning
//    // This is the initial example data in DB when app first starts.
//    // This is NOT the ongoing data, which is in  data files.
//    //
//    //NSArray *arrayMAMBexampleGroup =   // field 1=name-of-group  field 2=locked-or-not
//    NSArray *gbl_arrayExaGrp =   // field 1=name-of-group  field 2=locked-or-not
//    @[
//      @"~Swim Team||",
//      @"~My Family||",
//    ];
//    cnt1 = gbl_arrayExaGrp.count;
//    NSLog(@"cnt1=%ld",(long)cnt1);
//
//

//    cnt1 = gbl_arrayExaPerRem.count;
//

    //    for (id s in arrayMAMBexampleGroup)       {NSLog(@"eltG: %@",s);}
    //    for (id s in arrayMAMBexampleperson)      {NSLog(@"eltP: %@",s);}
    //    for (id s in arrayMAMBexampleMember)      {NSLog(@"eltGM: %@",s);}
    //
    
// OLD  read/write
//- (void) mambWriteGroupArray: (NSArray *) argGroupArray
//{
//    NSLog(@"in mambWriteGroupArray () ----------");
//    NSError *err01;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//
//    NSData *myGroupArchive;
//    NSData *myGroupWriteable;
//
//    [gbl_sharedFM removeItemAtURL:gbl_URLToGroup // remove old (because no overcopy), write out new Group file with current entity
//                           error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Group %@", err01); }
//
////     NSLog(@"argGroupArray=%@",argGroupArray);
//
//     myGroupArchive   = [NSKeyedArchiver  archivedDataWithRootObject: argGroupArray];
////tn();  NSLog(@"myGroupArchive=\n%@",myGroupArchive);
//
//     myGroupWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myGroupArchive];
////tn();  NSLog(@"myGroupWriteable=\n%@",myGroupWriteable );
//     
//
//     BOOL ret01 = [myGroupWriteable writeToURL: gbl_URLToGroup atomically:YES];
//     if (!ret01)  NSLog(@"Error write to mambd2 \n  %@", [err01 localizedFailureReason]);
//
////     NSLog(@"gbl_arrayGrp after =%@",gbl_arrayGrp);  // start here
//} // end of mambWriteGroupArray 
//
//
//- (void) mambWritePersonArray: (NSArray *) argPersonArray
//{
//    NSLog(@"in mambWritePersonArray () ----------");
//    NSError *err01;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method in appDelegate.m
//
//    NSData *myPersonArchive;
//    NSData *myPersonWriteable;
//
//    [gbl_sharedFM removeItemAtURL:gbl_URLToPerson // remove old (because no overcopy), write out new Person file with current entity
//                            error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Person %@", err01); }
//
////    NSLog(@"argPersonArray=%@",argPersonArray);
//
//    myPersonArchive   = [NSKeyedArchiver  archivedDataWithRootObject: argPersonArray];
////tn();  NSLog(@"myPersonArchive=\n%@",myPersonArchive);
//
//    myPersonWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myPersonArchive];
////tn();  NSLog(@"myPersonWriteable=\n%@",myPersonWriteable );
//     
//
//     BOOL ret01 = [myPersonWriteable writeToURL: gbl_URLToPerson atomically:YES];
//     if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//
////     NSLog(@"gbl_arrayPer after personwrite=%@",gbl_arrayPer);  // start here
//} // end of mambWritePersonArray 
//
//
//- (void) mambWriteMemberArray: (NSArray *) argMemberArray
//{
//    NSLog(@"in mambWriteMemberArray () ----------");
//    NSError *err01;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method in appDelegate.m
//
//    NSData *myMemberArchive;
//    NSData *myMemberWriteable;
//
//    [gbl_sharedFM removeItemAtURL:gbl_URLToMember // remove old (because no overcopy), write out new Member file with current entity
//                            error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Member %@", err01); }
//
//    NSLog(@"argMemberArray=%@",argMemberArray);
//
//    myMemberArchive   = [NSKeyedArchiver  archivedDataWithRootObject: argMemberArray];
//tn();  NSLog(@"myMemberArchive=\n%@",myMemberArchive);
//
//    myMemberWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myMemberArchive];
//tn();  NSLog(@"myMemberWriteable=\n%@",myMemberWriteable );
//     
//
//     BOOL ret01 = [myMemberWriteable writeToURL: gbl_URLToMember atomically:YES];
//     if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//
//     NSLog(@"gbl_arrayPer after Memberwrite=%@",gbl_arrayPer);  // start here
//} // end of mambWriteMemberArray 
//
// end of OLD  read/write

// old from read file   mambReadArrayFileWithDescription
//    if ([entDesc isEqualToString:@"group"])        { myURLtoReadFrom = gbl_URLToGroup;    my_gbl_array = gbl_arrayGrp;    }
//    if ([entDesc isEqualToString:@"person"])       { myURLtoReadFrom = gbl_URLToPerson;   my_gbl_array = gbl_arrayPer;    }
//    if ([entDesc isEqualToString:@"member"])       { myURLtoReadFrom = gbl_URLToMember;   my_gbl_array = gbl_arrayMem;    }
//    if ([entDesc isEqualToString:@"grpexample"])   { myURLtoReadFrom = gbl_URLToGroup;    my_gbl_array = gbl_arrayGrpExa; }
//    if ([entDesc isEqualToString:@"perexample"])   { myURLtoReadFrom = gbl_URLToPerson;   my_gbl_array = gbl_arrayPerExa; }
//    if ([entDesc isEqualToString:@"memexample"])   { myURLtoReadFrom = gbl_URLToMember;   my_gbl_array = gbl_arrayMemExa; }
//    if ([entDesc isEqualToString:@"grpremember"])  { myURLtoReadFrom = gbl_URLToGrpRem;   my_gbl_array = gbl_arrayGrpRem; }
//    if ([entDesc isEqualToString:@"perremember"])  { myURLtoReadFrom = gbl_URLToPerRem;   my_gbl_array = gbl_arrayPerRem; }
//
//NSMutableArray *myMutArr = (NSMutableArray *) myNSData;
//    NSLog(@"myMutArr =%@",myMutArr );
//
//NSArray *myArr = (NSArray *) myNSData;
//    NSLog(@"myArr =%@",myArr );
//

    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myMutArr]; 
//    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myArr]; 
    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: (NSMutableData *) myNSData]; 
//    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: (NSMutableArray *) myNSData]; 
//
//    if ([entDesc isEqualToString:@"examplegroup"])  { gbl_arrayExaGrp    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"exampleperson"]) { gbl_arrayExaPer    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"examplemember"]) { gbl_arrayExaMem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"examplegrprem"]) { gbl_arrayExaGrpRem = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"exampleperrem"]) { gbl_arrayExaPerRem = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//

// OLD   read fns
//- (void) mambReadGroupFile
//{
//    NSLog(@"in mambReadGroupFile() ----------");
//    
//    NSData *myGroupWritten;
//    NSData *myGroupNSData;
//    NSData *myGroupArray;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method in appDelegate.m
//
//    myGroupWritten = [[NSData alloc] initWithContentsOfURL: gbl_URLToGroup];
//    if (myGroupWritten == nil) { NSLog(@"%@", @"Error reading mambd2"); }
////tn();  NSLog(@"myGroupWritten=\n%@",myGroupWritten);
//
//    myGroupNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myGroupWritten];
////tn();  NSLog(@"myGroupNSData=\n%@",myGroupNSData);
//
//    myGroupArray = [NSKeyedUnarchiver unarchiveObjectWithData: myGroupNSData]; 
////tn();  NSLog(@"myGroupArray=\n%@",myGroupArray );
//
//    gbl_arrayGrp =  [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myGroupArray];
////tn();  NSLog(@"gbl_arrayGrp=\n%@", gbl_arrayGrp);
//} // end of mambReadGroupFile()
//
//
//- (void) mambReadPersonFile
//{
//    NSLog(@"in mambReadPersonFile() ----------");
//    
//    NSData *myPersonWritten;
//    NSData *myPersonNSData;
//    NSMutableData *myPersonArray;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//
//    myPersonWritten = [[NSData alloc] initWithContentsOfURL: gbl_URLToPerson];
//    if (myPersonWritten == nil) { NSLog(@"%@", @"Error reading mambd3"); }
////tn();  NSLog(@"myPersonWritten=\n%@", myPersonWritten);
//
//    myPersonNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myPersonWritten];
////tn();  NSLog(@"myPersonNSData=\n%@", myPersonNSData);
//
//    myPersonArray  = [NSKeyedUnarchiver unarchiveObjectWithData: myPersonNSData]; 
////tn();  NSLog(@"myPersonArray=\n%@", myPersonArray );
//
//    gbl_arrayPer   = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myPersonArray];
////tn();  NSLog(@"gbl_arrayPer=\n%@", gbl_arrayPer);
//} // end of mambReadPersonFile()
//
//
//- (void) mambReadMemberFile
//{
//    NSLog(@"in mambReadMemberFile() ----------");
//    
//    NSData *myMemberWritten;
//    NSData *myMemberNSData;
//    NSMutableData *myMemberArray;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//
//    myMemberWritten = [[NSData alloc] initWithContentsOfURL: gbl_URLToMember];
//    if (myMemberWritten == nil) { NSLog(@"%@", @"Error reading mambd3"); }
////tn();  NSLog(@"myMemberWritten=\n%@", myMemberWritten);
//
//    myMemberNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myMemberWritten];
////tn();  NSLog(@"myMemberNSData=\n%@", myMemberNSData);
//
//    myMemberArray  = [NSKeyedUnarchiver unarchiveObjectWithData: myMemberNSData]; 
////tn();  NSLog(@"myMemberArray=\n%@", myMemberArray );
//
//    gbl_arrayMem   = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myMemberArray];
////tn();  NSLog(@"gbl_arrayMem=\n%@", gbl_arrayMem);
//} // end of mambReadMemberFile()
//
// end of OLD   read fns


// from    - (void)applicationDidBecomeActive:(UIApplication *)application
// used  applicationDidBecomeActive  notification instead
//     // http://stackoverflow.com/questions/15864364/viewdidappear-is-not-called-when-opening-app-from-background
//     //
//     // I think registering for the UIApplicationWillEnterForegroundNotification is risky
//     // as you may end up with more than one controller reacting to that notification.
//     // Nothing garanties that these controllers are still visible when the notification is received.
//     // 
//     // Here is what I do: I force call viewDidAppear on the active controller directly from the App's delegate didBecomeActive method:
//     // 
//     // Add the code below to - (void)applicationDidBecomeActive:(UIApplication *)application
//     // 
//     UIViewController *activeController = window.rootViewController;
//     if ([activeController isKindOfClass:[UINavigationController class]]) {
//         activeController = [(UINavigationController*)window.rootViewController topViewController];
//     }
//     //[activeController viewDidAppear:NO];
//     [activeController viewDidAppear:NO];
//

// never used
//#pragma mark -
//#pragma mark NSCoding Methods
//
//// - (void)encodeWithCoder:(NSCoder *)aCoder  // ENCODE
//// {
//// NSLog(@"in encodeWithCoder() ENCODE");
//// tn();trn("in encodeWithCoder() ENCODE");
////     NSLog(@"KEY_LAST_ENTITY_STR=%@",KEY_LAST_ENTITY_STR);
////     [aCoder encodeObject: self.myLastEntityStr
////                   forKey: KEY_LAST_ENTITY_STR  ];
//// }
//// 
//// - (id)initWithCoder:(NSCoder *)aDecoder    // DECODE         // NS_DESIGNATED_INITIALIZER
//// {
//// NSLog(@"in initWithCoder() DECODE");
//// tn();trn("in initWithCoder() DECODE");
////     self = [super init];
//// nb(1);
////     if (self) {
//// nb(2);
////         self.myLastEntityStr = [aDecoder decodeObjectForKey: KEY_LAST_ENTITY_STR];
////     } 
//// nb(3);
////     return self;
//// }
//
//#pragma mark -
//


//
//        NSString *prefixStr = [NSString stringWithFormat: @"%@|", nameOfMember];
//            for (NSString *element in gbl_arrayPer) {
//                if ([element hasPrefix: prefixStr]) {
//                    PSVthatWasFound = element;
//                    break;
//                }
//            }
////NSLog(@"PSVthatWasFound=%@",PSVthatWasFound);
//            if ( ! PSVthatWasFound) continue;
//
//
//            // build this members's C CSV from his gbl_arrayPer PSV 
//            //
//            char csv_person_string[128];
//            char psvName[32], psvMth[4], psvDay[4], psvYear[8]; 
//            char psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
//            char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
//            const char *my_psvc; // psv=pipe-separated values
//            char my_psv[128];
//    
//            // NSString object to C
//            my_psvc = [PSVthatWasFound cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values 
//            strcpy(my_psv, my_psvc);
////  ksn(my_psv);
//            
//            strcpy(psvName, csv_get_field(my_psv, "|", 1));
//            strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
//            strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
//            strcpy(psvYear, csv_get_field(my_psv, "|", 4));
//            strcpy(psvHour, csv_get_field(my_psv, "|", 5));
//            strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
//            strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
//            strcpy(psvCity, csv_get_field(my_psv, "|", 8));
//            strcpy(psvProv, csv_get_field(my_psv, "|", 9));
//            strcpy(psvCountry, csv_get_field(my_psv, "|", 10));
//
////ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
////ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
////
//            
//            // get longitude and timezone hoursDiff from Greenwich
//            // by looking up psvCity, psvProv, psvCountry
//            //
//            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
//            
//            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
//            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
//            
//            // set gbl for email
////            ksn(psvName);
////            gbl_person_name =  [NSString stringWithUTF8String:psvName ];
//
//            // build C  CSV for this person in group
//            //
//            sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
////ksn(csv_person_string);tn();
////kin((int)(strlen(csv_person_string) + 1));
////
//        
//
//
//            // convert this members's C CSV to NSString object 
//            // and add to argArrayToWriteInto  NSArray
//            //
//            NSString *myCSVobj = [NSString stringWithUTF8String: csv_person_string];  // convert c string to NSString
//
//

//        if ( [allowedCharactersInName rangeOfString: arg_typedCharAsNSString].location == NSNotFound)
//        {
//            NSLog(@"allowedCharacters does not contain typed char");
//        }

