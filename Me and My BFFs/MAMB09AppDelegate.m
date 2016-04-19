//  MAMB09AppDelegate.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09AppDelegate.h"
#import "rkdebug_externs.h"
#import "mamblib.h"
#import "MAMB09_UITextField_noCopyPaste.h"


//  -----   turning off logging for production
//
//  FOR  turning off NSLog
//  in file "Me and My BFFs-Prefix.pch"  in xcode folder "supporting files"
//  at the end of the file
//
//  have this for doing logging:
//  #define NSLog(...)
//
//  have this for doing turning OFF logging:
//  // #define NSLog(...)
//
//
//  FOR turning off  rkdebug  functions for C
//  in rkdebug.c
//  around line 108:
//
//  have this for doing logging:
//     int RKDEBUG=1;  /* =0 turns off output in all these debug functions */
//
//  have this for doing turning OFF logging:
//     int RKDEBUG=0;  /* =0 turns off output in all these debug functions */
//
// end of  -----   turning off logging for production



@implementation MAMB09AppDelegate


#define KEY_LAST_ENTITY_STR  @"myLastEntityStr"

//#define DEFAULT_LAST_ENTITY  @"person|~Sophia|group|~Swim Team"    // for test  (testing has "~Anya 56789..." , not "~Anya"
#define DEFAULT_LAST_ENTITY  @"person|~Abigail 012345|group|~Swim Team|"    // for test  (testing has "~Anya 56789..." , not "~Anya"


//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  // iOS 6
//{
//return UIInterfaceOrientationMaskAll;
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"in didFinishLaunchingWithOptions()  in appdelegate");
    
    // test cannot have bkt c lang debug functions in  MAMB09AppDelegate.m  in method  didFinishLaunchingWithOptions 
    // test but they appear to work in other method in here (MAMB09AppDelegate.m )
    //tn(); crash    all these crash here
    //tn();
    //tn();
    //trn("in didFinishLaunchingWithOptions() 1 in appdelegate");

    
//  NSLog(@"901!");
//gbl_bestMatchActivityIndicator =
////        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
////        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
//        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
//
//    gbl_bestMatchActivityIndicator.hidesWhenStopped = YES;
//
//    gbl_bestMatchActivityIndicator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
//        UIViewAutoresizingFlexibleHeight |
//        UIViewAutoresizingFlexibleLeftMargin |
//        UIViewAutoresizingFlexibleRightMargin |
//        UIViewAutoresizingFlexibleTopMargin |
//        UIViewAutoresizingFlexibleWidth;




//    gbl_cy_apl              = @"9999";  // inited now in appdel didFinishLaunchingWithOptions
//    gbl_cy_goo              = @"9999";
//    gbl_cy_session_startup  = @"9999";  // format "20nn"  cy gotten from apl this session
//    gbl_cy_currentAllPeople = @"9999";  // format "20nn"  cy gotten from grp allpeople
//    gbl_cy_apl              = nil;    // inited now in appdel didFinishLaunchingWithOptions
//    gbl_cy_goo              = nil;  
    gbl_cy_currentAllPeople = nil;    // format "20nn"  cy gotten from grp allpeople
    gbl_cm_currentAllPeople = nil;    // format "20nn"  cy gotten from grp allpeople
    gbl_cd_currentAllPeople = nil;    // format "20nn"  cy gotten from grp allpeople
//    gbl_cy_session_startup  = nil;    // format "20nn"  cy gotten from apl this session


    // In order to get rid of opening in middle of report instead of top for tblrpts  per and co,
    // we have to reload the report at screen startup,
    // but only the first time that report screen appears in the app session.
    //
    // ensure a per and pco reload only first time  A=tblrpts_1  B=tblrpts_2  (get rid of opening in mid of report instead of top)
    //
    gbl_do_A_per_reload = @"do the reload only the first time"; // after 1st reload, set to  @"this is not reset until new app startup";
    gbl_do_A_co__reload = @"do the reload only the first time"; // after 1st reload, set to  @"this is not reset until new app startup";
    gbl_do_B_per_reload = @"do the reload only the first time"; // after 1st reload, set to  @"this is not reset until new app startup";
    gbl_do_B_co__reload = @"do the reload only the first time"; // after 1st reload, set to  @"this is not reset until new app startup";



    // Override point for customization after application launch.



//    [[UINavigationBar appearance] setTranslucent: NO ];  // set all navigation bars to opaque



//
//                [UINavigationController.navigationBar setBackgroundImage: [UIImage new]       // 1. of 2
//                                                             forBarPosition: UIBarPositionAny
//                                                                 barMetrics: UIBarMetricsDefault];
//                //
//                [self.navigationController.navigationBar setShadowImage: [UIImage new]];   
//                //
//                self.navigationController.navigationBar.backgroundColor = [UIColor redColor];  // 2. of 2
//



//  [[UINavigationBar appearance] setTranslucent: NO];                      // works
//  [[UINavigationBar appearance] setBackGroundColor: [UIColor redColor] ]; // works

    [[UINavigationBar appearance]  setTranslucent: NO];

    gbl_colorAplNavBarBG = [UIColor colorWithRed:252.0/255.0 green:250.0/255.0 blue:248.0/255.0 alpha:1.0]; 

    // both of the below need to be here to remove
    // the one-pixel border at the bottom of nav bar
    //
    [[UINavigationBar appearance] setBackgroundImage: [[UIImage alloc] init]
                                      forBarPosition: UIBarPositionAny
                                          barMetrics: UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage: [[UIImage alloc] init]];

//    [[UINavigationBar appearance] setTintColor: [UIColor redColor]];
//    [[UINavigationBar appearance] setTintColor: [UIColor brownColor]];  // <<<< set tint color for all nav bars  (apl blue better)



//   [[UINavigationBar appearance] setBarTintColor:
//  [UIColor lightGrayColor]
// [UIColor colorWithRed:242.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0] // light blue
// [UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:216.0/255.0 alpha:1.0]  // light brown 
// [UIColor colorWithRed:255.0/255.0 green:248.0/255.0 blue:232.0/255.0 alpha:1.0]  // too light brown 
// [UIColor colorWithRed:255.0/255.0 green:240.0/255.0 blue:224.0/255.0 alpha:1.0]  //  light brown 
// [UIColor colorWithRed:255.0/255.0 green:202.0/255.0 blue:192.0/255.0 alpha:1.0]  // light brown 
// [UIColor colorWithRed:255.0/255.0 green:244.0/255.0 blue:228.0/255.0 alpha:1.0]  // GOLD light brown 
//        gbl_colorNavBarBG   // light brown
//  ];

    // set font and size for all Nav Bars
    //  see addchange 

    
    // to access global method in appDelegate .h and .m
    //MAMB09AppDelegate *gbl_myappDelegate=[[UIApplication sharedApplication] delegate];


//    gbl_chevronRight = [UIImage  imageNamed: @"iconLeftArrowBlue_66.png" 
//    gbl_chevronRight = [UIImage  imageNamed: @"iconChevronRight_66.png" 
//                                   inBundle: nil
//              compatibleWithTraitCollection: nil
//    ];


//    gbl_chevronRight = [UIImage  imageNamed: @"iconRightArrowBlue_66.png" 
//    gbl_chevronLeft  = [UIImage  imageNamed: @"iconChevronLeft_66.png" 
//                                   inBundle: nil
//              compatibleWithTraitCollection: nil
//    ];

    // EDITING stuff
    //

    // editing        mode bg color for home navbar button
    gbl_YellowBG = [UIImage  imageNamed: @"bg_yellow_1x1b.png" 
                               inBundle: nil
          compatibleWithTraitCollection: nil
    ];

    // regular report mode bg color for home navbar button
    gbl_BlueBG   = [UIImage  imageNamed: @"bg_blue_1x1a.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
                               inBundle: nil
          compatibleWithTraitCollection: nil
    ];

//    gbl_blueDone   = [UIImage  imageNamed: @"bg_blueDone3.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
//    gbl_blueDone   = [UIImage  imageNamed: @"bg_blueDone5.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
//    gbl_blueDone   = [UIImage  imageNamed: @"bg_blueDone6.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
//    gbl_blueDone   = [UIImage  imageNamed: @"bg_blueDone7.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
//                                 inBundle: nil
//            compatibleWithTraitCollection: nil
//    ];

    // FYI  done button colors
    //     stroke: 255, 220, 195
    //       fill: 240, 230, 200
    //
    //     stroke: 232, 210, 190
    //       fill: 235, 215, 195
    // 
//    gbl_brownDone   = [UIImage  imageNamed: @"bg_brownDone8.png" // [self.editButtonItem setBackgroundImage: 
//    gbl_brownDone   = [UIImage  imageNamed: @"bg_brownDone9.png" // [self.editButtonItem setBackgroundImage: 



//    gbl_brownDone   = [UIImage  imageNamed: @"bg_brownDone10.png" // [self.editButtonItem setBackgroundImage: 
//                                 inBundle: nil
//            compatibleWithTraitCollection: nil
//    ];

    UIImage *tmpImage1 = [UIImage imageNamed: @"bg_brownDone10.png"];
    tmpImage1          = [tmpImage1 imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    gbl_brownDone      =  tmpImage1;


//  gbl_yellowEdit   = [UIImage  imageNamed: @"bg_yellowEdit6b_blu1.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG  try blue border
//    gbl_yellowEdit   = [UIImage  imageNamed: @"bg_yellowEdit7.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
//    gbl_yellowEdit   = [UIImage  imageNamed: @"bg_yellowEdit6.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG

//    gbl_yellowEdit   = [UIImage  imageNamed: @"bg_yellowEdit8.png" // [self.editButtonItem setBackgroundImage: gbl_BlueBG
//                                   inBundle: nil
//              compatibleWithTraitCollection: nil
//    ];

//    UIImage *tmpImage2 = [UIImage imageNamed: @"bg_yellowEdit8.png"];
    UIImage *tmpImage2 = [UIImage imageNamed: @"bg_yellowEdit10x.png"];  // x is for experiment  b is for big version
    tmpImage2          = [tmpImage2 imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    gbl_yellowEdit     =  tmpImage2;




    // ONLY used in info
//    gbl_bgColor_blueDone   = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:255.0/255.0 alpha:1.0]; 
//    gbl_bgColor_blueDone   = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:255.0/255.0 alpha:1.0]; 
    gbl_bgColor_yellowEdit = [UIColor colorWithRed:255.0/255.0 green:253.0/255.0 blue:166.0/255.0 alpha:1.0]; // ONLY used in info
    gbl_bgColor_brownDone  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // lighter burlywood  info
//    gbl_bgColor_brownHdr  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // lighter burlywood  
//    gbl_bgColor_brownHdr  = [UIColor colorWithRed:250.0/255.0 green:232.0/255.0 blue:207.0/255.0 alpha:1.0]; // much lighter burlywood  
//    gbl_bgColor_brownHdr  = [UIColor colorWithRed:250.0/255.0 green:232.0/255.0 blue:207.0/255.0 alpha:1.0]; // much lighter burlywood  

    gbl_bgColor_brownSwitch  = [UIColor colorWithRed:237.0/255.0 green:216.0/255.0 blue:187.0/255.0 alpha:1.0]; // much lighter burlywood  
    gbl_bgColor_brownSwitch  = [UIColor colorWithRed:237.0/255.0 green:222.0/255.0 blue:187.0/255.0 alpha:1.0]; // much lighter burlywood  

//    gbl_bgColor_brownHdr  = [UIColor colorWithRed:221.0/255.0 green:200.0/255.0 blue:175.0/255.0 alpha:1.0]; // much lighter burlywood  

//    gbl_bgColor_brownHdr  = [UIColor colorWithRed:200.0/255.0 green:180.0/255.0 blue:158.0/255.0 alpha:1.0]; // much lighter burlywood  
    gbl_bgColor_brownHdr  = [UIColor colorWithRed:220.0/255.0 green:190.0/255.0 blue:166.0/255.0 alpha:1.0]; // much lighter burlywood  

//    gbl_bgColor_brownHdr  = [UIColor colorWithRed:124.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0];  try dark brown



    // N.B.  HUNG when gbl_bgColor_brownHdr set to gbl_color_cAplDarkBlue in appdel .m


//    gbl_myname = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 200, 40)]; // arg 1=x 2=y 3=width 4=height
    gbl_myname  = [
        [MAMB09_UITextField_noCopyPaste alloc]  initWithFrame: CGRectMake(16, 8, 200, 40) // arg 1=x 2=y 3=width 4=height
    ];

//    gbl_whatMemberships  = [[UILabel alloc]initWithFrame: CGRectMake(32, 0, 240, 77)];
//    gbl_whatMemberships  = [[UITextView alloc]initWithFrame: CGRectMake(32, 0, 240, 75)];



//UIView *overlay = [[UIView alloc] init];  
//[overlay setFrame:CGRectMake(0, 0, gbl_myname.frame.size.width, gbl_myname.frame.size.height)];  
//[gbl_myname addSubview:overlay];  

    // gbl_myname.allowsEditingTextAttributes = NO;  THIS is the default anyway




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

//    gbl_mybirthinformation   = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 265, 40)]; // arg 1=x 2=y 3=width 4=height
    gbl_mybirthinformation  = [
        [MAMB09_UITextField_noCopyPaste alloc]  initWithFrame: CGRectMake(16, 8, 265, 40) // arg 1=x 2=y 3=width 4=height
    ];



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
//    [gbl_title_cityPicklist setTitleTextAttributes: @{
//                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size: 18.0],
//                    NSFontAttributeName: [UIFont fontWithName:@"Menlo-Bold" size: 18.0],
//                    NSFontAttributeName: [UIFont fontWithName:@"Menlo" size: 19.0],
//         NSForegroundColorAttributeName: [UIColor greenColor]
//         NSForegroundColorAttributeName: [UIColor blackColor]
//    } forState:UIControlStateNormal];

    gbl_title_cityKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Type City Name"
                                                             style: UIBarButtonItemStylePlain
                                                            target: self
                                                            action: nil ];
    [gbl_title_cityKeyboard setTitleTextAttributes: @{
//                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size: 18.0],
//                    NSFontAttributeName: [UIFont fontWithName:@"Menlo-Bold" size: 18.0],
                    NSFontAttributeName: [UIFont fontWithName:@"Menlo-Bold" size: 19.0],
         NSForegroundColorAttributeName: [UIColor grayColor]
    } forState:UIControlStateNormal];



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

     //
     // more objects that can be alloc/inited here instead of ,for example, cellforrow every time
     //


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


     gbl_reallyLightGray = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]; 
     //  DI  Disclosure Indicator  colors
     //
//     gbl_colorDIfor_home = [UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // gray
//     gbl_colorDIfor_home = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // gray
//     gbl_colorDIfor_home = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // gray
//     gbl_colorDIfor_home = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // gray
//     gbl_colorDIfor_home = [UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0]; // gray
//     gbl_colorDIfor_home = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_home = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // gray   gold #1


     gbl_colorDIfor_cGr2 = [UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cGr2 = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cGr2 = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cGr2 = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // gray

     gbl_colorDIfor_cGr2 = [UIColor colorWithRed:160.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // gray

     gbl_colorDIfor_cGre = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cGre = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cGre = [UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cGre = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // gray

     gbl_colorDIfor_cNeu = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // gray

     gbl_colorDIfor_cRed = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cRed = [UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cRed = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cRed = [UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0]; // gray

     gbl_colorDIfor_cRe2 = [UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // gray
     gbl_colorDIfor_cRe2 = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // gray

     gbl_colorDIfor_cRe2 = [UIColor colorWithRed:160.0/255.0 green:144.0/255.0 blue:160.0/255.0 alpha:1.0]; // gray
     //
     //  DI  Disclosure Indicator  colors

     gbl_colorPlaceHolderPrompt = [UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // gray
//     gbl_colorCityLabelBorder = [UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // gray


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
//    gbl_colorEditingBG = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:150.0/255.0 alpha:1.0]; // yellowy for edit
//
//    gbl_colorEditingBG = [UIColor colorWithRed:240.0/255.0 green:230.0/255.0 blue:140.0/255.0 alpha:1.0]; // khaki
//    gbl_colorEditingBG = [UIColor colorWithRed:255.0/255.0 green:246.0/255.0 blue:143.0/255.0 alpha:1.0]; // khaki1


//    gbl_colorEditingBG = [UIColor colorWithRed:247.0/255.0 green:238.0/255.0 blue:140.0/255.0 alpha:1.0]; // khaki1 darker  GOLD old

    // apple notes light yellow color   RGB(254, 239, 181)
    gbl_colorEditingBG = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:181.0/255.0 alpha:1.0]; // GOLD new- apple notes light yellow color   RGB(254, 239, 181)


    // add members color
    //
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

//    gbl_colorforAddMembers = [UIColor colorWithRed:160.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; //  GOLD #1
//    gbl_colorforAddMembers = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:128.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:016.0/255.0 green:255.0/255.0 blue:096.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:048.0/255.0 green:255.0/255.0 blue:000.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:000.0/255.0 green:255.0/255.0 blue:000.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:064.0/255.0 green:192.0/255.0 blue:064.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:096.0/255.0 green:192.0/255.0 blue:096.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:064.0/255.0 green:192.0/255.0 blue:064.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:064.0/255.0 green:224.0/255.0 blue:064.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:096.0/255.0 green:192.0/255.0 blue:096.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:096.0/255.0 green:224.0/255.0 blue:096.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:096.0/255.0 green:192.0/255.0 blue:096.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:128.0/255.0 green:192.0/255.0 blue:128.0/255.0 alpha:1.0]; //  
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:224.0/255.0 blue:112.0/255.0 alpha:1.0]; //  
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:160.0/255.0 blue:112.0/255.0 alpha:1.0]; // 
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:176.0/255.0 blue:112.0/255.0 alpha:1.0]; // 
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:168.0/255.0 blue:112.0/255.0 alpha:1.0]; // 
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:192.0/255.0 blue:112.0/255.0 alpha:1.0]; //  GOLD #2
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:184.0/255.0 blue:112.0/255.0 alpha:1.0]; //  GOLD #4  see below for #5
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:184.0/255.0 blue:112.0/255.0 alpha:1.0]; //  GOLD #6  see below for #5
//    gbl_colorforAddMembers = [UIColor colorWithRed:112.0/255.0 green:204.0/255.0 blue:112.0/255.0 alpha:1.0]; //
//    gbl_colorforAddMembers = [UIColor colorWithRed:096.0/255.0 green:204.0/255.0 blue:096.0/255.0 alpha:1.0]; //
//    gbl_colorforAddMembers = [UIColor colorWithRed:064.0/255.0 green:164.0/255.0 blue:064.0/255.0 alpha:1.0]; //
//    gbl_colorforAddMembers = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:128.0/255.0 alpha:1.0]; //

//    gbl_colorforAddMembers = [UIColor colorWithRed:144.0/255.0 green:188.0/255.0 blue:144.0/255.0 alpha:1.0]; //  GOLD #7

    //  try for lighter color   using guide apl Notes yellow is =  RGB(254, 239, 181)
//    gbl_colorforAddMembers = [UIColor colorWithRed:182.0/255.0 green:255.0/255.0 blue:182.0/255.0 alpha:1.0]; //  GOLD #8  green for add


//    gbl_colorforAddMembers = [UIColor colorWithRed:229.0/255.0 green:232.0/255.0 blue:163.0/255.0 alpha:1.0]; //  green for add
//    gbl_colorforAddMembers = [UIColor colorWithRed:229.0/255.0 green:248.0/255.0 blue:238.0/255.0 alpha:1.0]; //  ottoman
//    gbl_colorforAddMembers = [UIColor colorWithRed:221.0/255.0 green:246.0/255.0 blue:229.0/255.0 alpha:1.0]; //  cosmic latte
//    gbl_colorforAddMembers = [UIColor colorWithRed:206.0/255.0 green:236.0/255.0 blue:206.0/255.0 alpha:1.0]; //  surf crest good
//    gbl_colorforAddMembers = [UIColor colorWithRed:201.0/255.0 green:232.0/255.0 blue:201.0/255.0 alpha:1.0]; //  granny apple ok
//    gbl_colorforAddMembers = [UIColor colorWithRed:242.0/255.0 green:255.0/255.0 blue:251.0/255.0 alpha:1.0]; //  green for add
//    gbl_colorforAddMembers = [UIColor colorWithRed:222.0/255.0 green:243.0/255.0 blue:225.0/255.0 alpha:1.0]; //  green for add
//    gbl_colorforAddMembers = [UIColor colorWithRed:212.0/255.0 green:232.0/255.0 blue:212.0/255.0 alpha:1.0]; //
//    gbl_colorforAddMembers = [UIColor colorWithRed:182.0/255.0 green:255.0/255.0 blue:182.0/255.0 alpha:1.0]; // 
//

    gbl_colorforAddMembers = [UIColor colorWithRed:195.0/255.0 green:240.0/255.0 blue:195.0/255.0 alpha:1.0]; //   GOLD #9  green for add




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

//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; // too dark (lines strong)
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:048.0/255.0 alpha:1.0]; // too dark (lines strong)
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0]; // too dark (lines strong)
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:128.0/255.0 alpha:1.0]; // weird
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:192.0/255.0 blue:128.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // no circles
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//

//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // 

//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // can  see circles  GOLD #1
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:072.0/255.0 blue:100.0/255.0 alpha:1.0]; // ok best  TRY

//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:040.0/255.0 blue:112.0/255.0 alpha:1.0]; // new GOLD #2
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:040.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:240.0/255.0 green:040.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:236.0/255.0 green:080.0/255.0 blue:111.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:111.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:032.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:100.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:040.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:096.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:224.0/255.0 green:064.0/255.0 blue:080.0/255.0 alpha:1.0]; //  GOLD #3  flatter,darker
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:080.0/255.0 alpha:1.0]; //  
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:096.0/255.0 alpha:1.0]; //  
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:112.0/255.0 alpha:1.0]; //  
//

//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:112.0/255.0 alpha:1.0]; //  GOLD #4 see below for #5
//    // too saturated
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:112.0/255.0 blue:152.0/255.0 alpha:1.0]; //  
//    gbl_colorforDelMembers = [UIColor colorWithRed:224.0/255.0 green:112.0/255.0 blue:152.0/255.0 alpha:1.0]; //  
//    gbl_colorforDelMembers = [UIColor colorWithRed:224.0/255.0 green:112.0/255.0 blue:136.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:224.0/255.0 green:112.0/255.0 blue:120.0/255.0 alpha:1.0]; // 

//    gbl_colorforDelMembers = [UIColor colorWithRed:224.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0]; // GOLD #7

    //  try for lighter color   using guide apl Notes yellow is =  RGB(254, 239, 181)
//    gbl_colorforDelMembers = [UIColor colorWithRed:253.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:253.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:253.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]; //  

    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0]; //  GOLD #8

//    gbl_colorforDelMembers = [UIColor colorWithRed:234.0/255.0 green:212.0/255.0 blue:224.0/255.0 alpha:1.0]; //  piggy pink
//    gbl_colorforDelMembers = [UIColor colorWithRed:243.0/255.0 green:223.0/255.0 blue:247.0/255.0 alpha:1.0]; //  prim


//
//// for test   fut  colors
////    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:201.0/255.0 alpha:1.0]; // ffb5c9  gold
////    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:123.0/255.0 blue:163.0/255.0 alpha:1.0]; //   NEW gold
//
//    gbl_colorforAddMembers = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:201.0/255.0 alpha:1.0]; // ffb5c9  gold
//
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // too red too dark
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:048.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:048.0/255.0 alpha:1.0]; //
//    gbl_colorforDelMembers = [UIColor colorWithRed:192.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0]; // x
////    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // 
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:1.0]; // x
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:123.0/255.0 blue:163.0/255.0 alpha:1.0]; // ffb5c9  gold
//
//// for test
//
//

//
//// test green for fut good line
//    gbl_colorforDelMembers = [UIColor colorWithRed:048.0/255.0 green:255.0/255.0 blue:048.0/255.0 alpha:1.0]; // can  see circles
//    gbl_colorforDelMembers = [UIColor colorWithRed:024.0/255.0 green:255.0/255.0 blue:024.0/255.0 alpha:1.0]; // can  see circles
//    gbl_colorforDelMembers = [UIColor colorWithRed:000.0/255.0 green:255.0/255.0 blue:000.0/255.0 alpha:1.0]; // can  see circles
//



    gbl_colorEditingBGforInputField = [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:252.0/255.0 alpha:1.0]; // white

//    gbl_bgColor_editFocus_NO   = gbl_colorEditingBGforInputField;    // whitish
//    gbl_bgColor_editFocus_YES  = [UIColor grayColor];
//    gbl_bgColor_editFocus_NO   = gbl_colorEditingBGforInputField;    // whitish
    gbl_bgColor_editFocus_NO   = gbl_color_cRe2;
    gbl_bgColor_editFocus_YES  = gbl_color_cGr2;
// [UIColor cyanColor];
;   // something else

//    gbl_color_cGr2  = [UIColor colorWithRed:042.0/255.0 green:255.0/255.0 blue:021.0/255.0 alpha:1.0]; // 66ff33  gold #1

// try lighter green not so dark
//    gbl_color_cGr2  = [UIColor colorWithRed:192.0/255.0 green:255.0/255.0 blue:128.0/255.0 alpha:1.0]; //
//    gbl_color_cGr2  = [UIColor colorWithRed:160.0/255.0 green:255.0/255.0 blue:096.0/255.0 alpha:1.0]; //
//    gbl_color_cGr2  = [UIColor colorWithRed:144.0/255.0 green:255.0/255.0 blue:080.0/255.0 alpha:1.0]; //
//    gbl_color_cGr2  = [UIColor colorWithRed:136.0/255.0 green:255.0/255.0 blue:072.0/255.0 alpha:1.0]; //
    gbl_color_cGr2  = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:064.0/255.0 alpha:1.0]; // 80ff40  gold #2



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


//    p_fn_prtlin( "    .cPerGreen1 {background-color: #66ff33;}");  // green
//    p_fn_prtlin( "    .cPerGreen2 {background-color: #f0f5f0;}");  // whiteish

//    gbl_color_cPerGreen1 = [UIColor colorWithRed:236.0/255.0 green:255.0/255.0 blue:211.0/255.0 alpha:1.0]; // ecffd3 // really light green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:240.0/255.0 green:245.0/255.0 blue:240.0/255.0 alpha:1.0]; // f0f5f0 // really light green for personality neutral color bg
//
//    gbl_colorReportsBG          = [UIColor colorWithRed:242./255.0 green:247./255.0 blue:255./255.0 alpha:1.0];  //  apple blue 2.5
//    gbl_colorHomeBG = [UIColor colorWithRed:167.0/255.0 green:207.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid of sail/baby blue slightly dark
//    gbl_colorHomeBG = [UIColor colorWithRed:181.0/255.0 green:214.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  sail    OK
//    gbl_colorHomeBG = [UIColor colorWithRed:206.0/255.0 green:227.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  Hawkes blue
//    gbl_colorHomeBG = [UIColor colorWithRed:222.0/255.0 green:237.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid    too light
//    gbl_color_cAplBlue = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]; // 0080ff  (blue text, chevron)







//    gbl_myname.placeholder         = @"Name";
//    gbl_myname.autocorrectionType  = UITextAutocorrectionTypeNo;
//    [gbl_myname setClearButtonMode: UITextFieldViewModeWhileEditing ];
//    [gbl_myname setKeyboardType:    UIKeyboardTypeNamePhonePad];          // A type optimized for entering a person's name or phone number.
//




    // make all "Back" buttons have just the arrow
    //
    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsDefault];     // make all "Back" buttons have just the arrow


//   [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -45) forBarMetrics:UIBarMetricsDefault];     // make all "Back" buttons have just the arrow
    //  [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(, -60) forBarMetrics:UIBarMetricsDefault];     // make all "Back" buttons have just the arrow
    //    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsLandscapePhone];     // make all "Back" buttons have just the arrow
//    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics: UIBarMetricsDefault];     // make all "Back" buttons have just the arrow

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







    // SET GBL DATA  HERE        ------------ all magic numbers----------------------------

    gbl_ThresholdshortTblLineLen = 17;  // nameA  + nameB more than this , then move benchmark label
    
    gbl_MAX_groups          =  50;   // max in app 

    // for C max  see  
    //   grpdoc.c    MAX_PERSONS_IN_GROUP
    //   gtphtm.c    MAX_PERSONS_IN_GROUP
    //   incocoa.c   MAX_PERSONS_IN_GROUP
    //
//    gbl_MAX_persons         = 250;   // max in app 
//    gbl_MAX_personsInGroup  = 250;   // max in a Group
    gbl_MAX_persons         = 200;   // max in app 
    gbl_MAX_personsInGroup  = 200;   // max in a Group

    gbl_MAX_lengthOfName    =  15;   // 15 (applies to Person and Group both)
    gbl_MAX_lengthOfCity    =  30;   

    gbl_maxLenBirthinfoCSV  = 128;   // max len of birthinfo CSV for a Group Member 
    gbl_maxGrpRptLines      = 333;   // max 333 cells in app tableview 
    gbl_maxLenRptLinePSV    = 128;   // max len of report data PSV for a cell is 128 chars
                                     //   example: 128 "cGre"/"cRe2" |  "  1  Anya_   Liz_       90  Great"

    gbl_earliestYear = 1850;     // minimum birthyear (privacy)


    gbl_ExampleData_count_per = 21;  // as of 20160301 is per=21 
    gbl_ExampleData_count_grp =  2;  // as of 20160301 is grp= 2


    gbl_numCitiesToTriggerPicklist = 25;
    gbl_numRowsToTriggerIndexBar   = 50; // default - actual value set elsewhere (varies by screen size)  (home)

    gbl_numMembersToTriggerSpinner = 50;    // best match rpt  (50 = 1 sec)

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

//    gbl_nameOfGrpHavingAllPeopleIhaveAdded = @"All People~";
    gbl_nameOfGrpHavingAllPeopleIhaveAdded = @"#allpeople";



    // set up initial value for    the  GOLD CURRENT DATE  for the whole app   (stored in #allpeople grp record fld 5,6,7 1-based)
    //
//    NSString *lcl_recOfAllPeopleIhaveAdded = [ NSString stringWithFormat: @"%@||||2016|06|15||||||||", // 14 flds for misc
    NSString *lcl_recOfAllPeopleIhaveAdded = [ NSString stringWithFormat: @"%@||yes||2033|03|25||||||||", // FOR TEST
        gbl_nameOfGrpHavingAllPeopleIhaveAdded
    ]; // 14 flds for misc

    // init value for adding new  remember records
    // like @"~My Family||||",
    // like @"~Anya||||||",
//    NSString *lcl_emptyRec_arrayPerRem = @"||||||";
//    NSString *lcl_emptyRec_arrayGrpRem = @"||||";




//<.>
    //           CURRENT DATE
    //
    //   Method mambCheckForCorruptData  in HOME  in viewDidLoad
    //   grabs current date m,d,y fields in gbl_arrayGrp rec for "#allpeople"
    //           fld #5 (one-based) populates gbl_cy_currentAllPeople  yyyy     PLUS  gbl  INT
    //           fld #6 (one-based) populates gbl_cm_currentAllPeople  mm
    //           fld #7 (one-based) populates gbl_cd_currentAllPeople  dd
    //
    //
    //   Method gcy  (get current year)  is called from 2 places
    //     - on home notification method  doStuffOnEnteringForeground
    //     - on home notification method  doStuffOnSignificantTimeChange
    //
    //   Method gcy updates these gbl variables with the current date
    //   which is gotten from the internet (an apple site).
    //   These vars are updated when current y or m or d changes.
    //
    //       this current internet yr populates 
    //           - fld #5 (one-based)  in gbl_arrayGrp rec for "#allpeople" 
    //           - gbl_cy_currentAllPeople  yyyy  str
    //           - gbl_currentYearInt

    //           current internet mn populates  fld #6 (one-based)  and   gbl_cm_currentAllPeople  mm    str
    //           current internet dy populates  fld #7 (one-based)  and   gbl_cd_currentAllPeople  dd    str

    //   Method gcy updates  the current date in the data file for gbl_arrayGrp (in record for grp "#allpeople")
    //   When current y or m or d changes,
    //     - in memory array gbl_arrayGrp, update #allpeople record containing new data 
    //     - write updated array gbl_arrayGrp to file

//<.>


    
    // fld #3 (one-based) populates gbl_ExampleData_show;       // "yes"  OR  "no"

    //   gbl  gbl_ExampleData_show  is updated
    //     - on startup, (from file for gbl_arrayGrp) in home notification method  doStuffOnEnteringForeground
    //     - when user changes switch in home info screen
    //
    //   gbl  gbl_ExampleData_show  is written to file  
    //     - when user changes switch in home info screen
    //     - as a side effect, whenever gbl_arrayGrp is written to file
    //     - as a side effect, in method gcy, when y,m,d is written to file when one of them changes 




//    gbl_arrayTEST = // field 11= locked or not 
//    @[
//      @"ada|8|29|1946|1|30|0|Toronto|Ontario|Canada||",
//      @"alex|4|8|1973|12|1|1|Toronto|Ontario|Canada||",
//      @"alexei|6|22|1964|4|10|0|Toronto|Ontario|Canada||",
//      @"andy2|5|15|1961|2|0|0|Toronto|Ontario|Canada||",
//      @"barbara|4|23|1935|5|45|0|Toronto|Ontario|Canada||",
//      @"barry|4|13|1950|0|53|1|Toronto|Ontario|Canada||",
//      @"bb|9|1|1933|12|1|1|Toronto|Ontario|Canada||",
//      @"ben|8|17|1960|3|15|1|Toronto|Ontario|Canada||",
//      @"bia|8|4|1971|10|30|1|Toronto|Ontario|Canada||",
//      @"bob|7|19|1935|1|55|0|Toronto|Ontario|Canada||",
//      @"borje|5|24|1930|10|30|0|Toronto|Ontario|Canada||",
//      @"brenda|10|31|1956|11|30|1|Toronto|Ontario|Canada||",
//      @"brigitte|11|15|1945|8|22|0|Toronto|Ontario|Canada||",
//      @"charley|7|16|1939|12|1|1|Toronto|Ontario|Canada||",
//      @"chris|2|3|1959|12|1|1|Toronto|Ontario|Canada||",
//      @"cristian|5|17|1975|12|1|1|Toronto|Ontario|Canada||",
//      @"dan|12|19|1957|11|4|0|Toronto|Ontario|Canada||",
//      @"doug|8|14|1963|7|30|1|Toronto|Ontario|Canada||",
//      @"dragana|10|19|1968|8|20|0|Toronto|Ontario|Canada||",
//      @"edwin|9|20|1969|4|0|0|Toronto|Ontario|Canada||",
//      @"eleanor|2|3|1936|6|7|0|Toronto|Ontario|Canada||",
//      @"gerry Lipat|10|10|1963|12|1|1|Toronto|Ontario|Canada||",
//      @"gordana|2|23|1954|6|15|0|Toronto|Ontario|Canada||",
//      @"herc|12|15|1966|12|1|1|Toronto|Ontario|Canada||",
//      @"hicham|6|15|1959|12|1|1|Toronto|Ontario|Canada||",
//      @"irina|8|21|1971|1|20|0|Toronto|Ontario|Canada||",
//      @"joan|10|23|1929|7|0|0|Toronto|Ontario|Canada||",
//      @"johnH|3|13|1959|4|10|1|Toronto|Ontario|Canada||",
//      @"joris|4|13|1964|12|1|1|Toronto|Ontario|Canada||",
//      @"jose|10|2|1959|4|0|1|Toronto|Ontario|Canada||",
//      @"juta|7|19|1965|7|25|0|Toronto|Ontario|Canada||",
//      @"karen|4|3|1949|5|45|1|Toronto|Ontario|Canada||",
//      @"kaz|8|4|1964|5|34|0|Toronto|Ontario|Canada||",
//      @"ken|9|21|1961|5|0|1|Toronto|Ontario|Canada||",
//      @"kerstin|9|14|1946|5|25|0|Toronto|Ontario|Canada||",
//      @"kevin|11|13|1960|12|1|1|Toronto|Ontario|Canada||",
//      @"lance|9|15|1967|8|1|1|Toronto|Ontario|Canada||",
//      @"larry|3|28|1947|5|15|0|Toronto|Ontario|Canada||",
//      @"leo|6|17|1949|11|0|0|Toronto|Ontario|Canada||",
//      @"luis|5|30|1967|0|30|1|Toronto|Ontario|Canada||",
//      @"ma|4|4|1908|12|1|1|Toronto|Ontario|Canada||",
//      @"mak|11|25|1960|12|1|1|Toronto|Ontario|Canada||",
//      @"marie|8|22|1964|4|54|1|Toronto|Ontario|Canada||",
//      @"marilyn|8|16|1959|11|0|0|Toronto|Ontario|Canada||",
//      @"markgolf|1|24|1942|3|0|0|Toronto|Ontario|Canada||",
//      @"marknesbit|10|13|1964|3|30|1|Toronto|Ontario|Canada||",
//      @"matti|8|17|1947|8|5|0|Toronto|Ontario|Canada||",
//      @"mihaela|7|17|1974|12|1|1|Toronto|Ontario|Canada||",
//      @"mike2|5|2|1956|9|58|1|Toronto|Ontario|Canada||",
//      @"mosy|12|16|1932|6|0|1|Toronto|Ontario|Canada||",
//      @"muru|5|17|1944|7|0|1|Toronto|Ontario|Canada||",
//      @"nicky|7|8|1975|5|30|1|Toronto|Ontario|Canada||",
//      @"nina|4|12|1929|5|30|0|Toronto|Ontario|Canada||",
//      @"olivia|11|23|1965|0|30|0|Toronto|Ontario|Canada||",
//      @"pa|6|26|1892|12|1|1|Toronto|Ontario|Canada||",
//      @"pat tennis|9|21|1958|3|30|1|Toronto|Ontario|Canada||",
//      @"paul|10|3|1933|3|0|0|Toronto|Ontario|Canada||",
//      @"renee|12|26|1953|3|15|1|Toronto|Ontario|Canada||",
//      @"richard|9|3|1947|9|33|1|Toronto|Ontario|Canada||",
//      @"rik|11|2|1958|9|30|0|Toronto|Ontario|Canada||",
//      @"rohit|1|16|1971|0|55|1|Toronto|Ontario|Canada||",
//      @"ruth|3|24|1923|1|30|1|Toronto|Ontario|Canada||",
//      @"sam|12|02|1974|8|30|0|Toronto|Ontario|Canada||",
//      @"sarwan|5|15|1965|12|1|1|Toronto|Ontario|Canada||",
//      @"scott|2|28|1957|3|0|1|Toronto|Ontario|Canada||",
//      @"steve skipper|4|22|1960|1|30|0|Toronto|Ontario|Canada||",
//      @"ulli|4|27|1952|5|30|0|Toronto|Ontario|Canada||",
//      @"vesna|6|27|1968|10|15|1|Toronto|Ontario|Canada||",
//      @"victor|10|22|1984|11|23|0|Toronto|Ontario|Canada||",
//      @"winnie|2|26|1962|0|30|0|Toronto|Ontario|Canada||",
//      @"yogi|7|18|1959|4|0|0|Toronto|Ontario|Canada||",
//    ];
//

    gbl_arrayExaGrp =   // field 1=name-of-group  field 2=locked-or-not
    @[
      lcl_recOfAllPeopleIhaveAdded,     // gbl_nameOfGrpHavingAllPeopleIhaveAdded
      @"folks||",
      @"Long Names||",
      @"Short Names||",
      @"us politics 16||",
      @"WWWWWWWWWWWWWWW||",
      @"~My Family||",
      @"~Swim Team||",
    ];

    gbl_arrayExaPer = // field 11= locked or not  DO NOT HAVE TO BE PRE-SORTED  (sorted on reading back into arrays)
    @[
      @"donald trump|6|14|1946|10|54|0|Jamaica|New York|United States||",
      @"ted cruz|12|22|1970|12|1|1|Calgary|Alberta|Canada||",
      @"kasich|5|13|1952|12|1|1|McKees Rocks|Pennsylvania|United States||",
      @"bernie sanders|9|8|1941|12|1|1|Brooklyn|New York|United States||",
      @"hillary clinton|10|26|1947|12|1|1|Chicago|Illinois|United States||",
      @"ada|8|29|1946|1|30|0|Toronto|Ontario|Canada||",
      @"alex|4|8|1973|12|1|1|Toronto|Ontario|Canada||",
      @"alexei|6|22|1964|4|10|0|Toronto|Ontario|Canada||",
      @"andy2|5|15|1961|2|0|0|Toronto|Ontario|Canada||",
      @"barbara|4|23|1935|5|45|0|Toronto|Ontario|Canada||",
      @"barry|4|13|1950|12|53|1|Toronto|Ontario|Canada||",
      @"bb|9|1|1933|12|1|1|Toronto|Ontario|Canada||",
      @"ben|8|17|1960|3|15|1|Toronto|Ontario|Canada||",
      @"bia|8|4|1971|10|30|1|Toronto|Ontario|Canada||",
      @"bob|7|19|1935|1|55|0|Toronto|Ontario|Canada||",
      @"borje|5|24|1930|10|30|0|Toronto|Ontario|Canada||",
      @"brenda|10|31|1956|11|30|1|Toronto|Ontario|Canada||",
      @"brigitte|11|15|1945|8|22|0|Toronto|Ontario|Canada||",
      @"charley|7|16|1939|12|1|1|Toronto|Ontario|Canada||",
      @"chris|2|3|1959|12|1|1|Toronto|Ontario|Canada||",
      @"cristian|5|17|1975|12|1|1|Toronto|Ontario|Canada||",
      @"dan|12|19|1957|11|4|0|Toronto|Ontario|Canada||",
      @"doug|8|14|1963|7|30|1|Toronto|Ontario|Canada||",
      @"dragana|10|19|1968|8|20|0|Toronto|Ontario|Canada||",
      @"edwin|9|20|1969|4|0|0|Toronto|Ontario|Canada||",
      @"eleanor|2|3|1936|6|7|0|Toronto|Ontario|Canada||",
      @"gerry Lipat|10|10|1963|12|1|1|Toronto|Ontario|Canada||",
      @"gordana|2|23|1954|6|15|0|Toronto|Ontario|Canada||",
      @"herc|12|15|1966|12|1|1|Toronto|Ontario|Canada||",
      @"hicham|6|15|1959|12|1|1|Toronto|Ontario|Canada||",
      @"irina|8|21|1971|1|20|0|Toronto|Ontario|Canada||",
      @"joan|10|23|1929|7|0|0|Toronto|Ontario|Canada||",
      @"johnH|3|13|1959|4|10|1|Toronto|Ontario|Canada||",
      @"joris|4|13|1964|12|1|1|Toronto|Ontario|Canada||",
      @"jose|10|2|1959|4|0|1|Toronto|Ontario|Canada||",
      @"juta|7|19|1965|7|25|0|Toronto|Ontario|Canada||",
      @"karen|4|3|1949|5|45|1|Toronto|Ontario|Canada||",
      @"kaz|8|4|1964|5|34|0|Toronto|Ontario|Canada||",
      @"ken|9|21|1961|5|0|1|Toronto|Ontario|Canada||",
      @"kerstin|9|14|1946|5|25|0|Toronto|Ontario|Canada||",
      @"kevin|11|13|1960|12|1|1|Toronto|Ontario|Canada||",
      @"lance|9|15|1967|8|1|1|Toronto|Ontario|Canada||",
      @"larry|3|28|1947|5|15|0|Toronto|Ontario|Canada||",
      @"leo|6|17|1949|11|0|0|Toronto|Ontario|Canada||",
      @"luis|5|30|1967|12|30|1|Toronto|Ontario|Canada||",
      @"ma|4|4|1908|12|1|1|Toronto|Ontario|Canada||",
      @"mak|11|25|1960|12|1|1|Toronto|Ontario|Canada||",
      @"marie|8|22|1964|4|54|1|Toronto|Ontario|Canada||",
      @"marilyn|8|16|1959|11|0|0|Toronto|Ontario|Canada||",
      @"markgolf|1|24|1942|3|0|0|Toronto|Ontario|Canada||",
      @"marknesbit|10|13|1964|3|30|1|Toronto|Ontario|Canada||",
      @"matti|8|17|1947|8|5|0|Toronto|Ontario|Canada||",
      @"mihaela|7|17|1974|12|1|1|Toronto|Ontario|Canada||",
      @"mike2|5|2|1956|9|58|1|Toronto|Ontario|Canada||",
      @"mosy|12|16|1932|6|0|1|Toronto|Ontario|Canada||",
      @"muru|5|17|1944|7|0|1|Toronto|Ontario|Canada||",
      @"nicky|7|8|1975|5|30|1|Toronto|Ontario|Canada||",
      @"nina|4|12|1929|5|30|0|Toronto|Ontario|Canada||",
      @"olivia|11|23|1965|12|30|0|Toronto|Ontario|Canada||",
      @"pa|6|26|1892|12|1|1|Toronto|Ontario|Canada||",
      @"pat tennis|9|21|1958|3|30|1|Toronto|Ontario|Canada||",
      @"paul|10|3|1933|3|0|0|Toronto|Ontario|Canada||",
      @"renee|12|26|1953|3|15|1|Toronto|Ontario|Canada||",
      @"richard|9|3|1947|9|33|1|Toronto|Ontario|Canada||",
      @"rik|11|2|1958|9|30|0|Toronto|Ontario|Canada||",
      @"rohit|1|16|1971|12|55|1|Toronto|Ontario|Canada||",
      @"ruth|3|24|1923|1|30|1|Toronto|Ontario|Canada||",
      @"sam|12|02|1974|8|30|0|Toronto|Ontario|Canada||",
      @"sarwan|5|15|1965|12|1|1|Toronto|Ontario|Canada||",
      @"scott|2|28|1957|3|0|1|Toronto|Ontario|Canada||",
      @"steve skipper|4|22|1960|1|30|0|Toronto|Ontario|Canada||",
      @"ulli|4|27|1952|5|30|0|Toronto|Ontario|Canada||",
      @"vesna|6|27|1968|10|15|1|Toronto|Ontario|Canada||",
      @"victor|10|22|1984|11|23|0|Toronto|Ontario|Canada||",
      @"winnie|2|26|1962|12|30|0|Toronto|Ontario|Canada||",
      @"yogi|7|18|1959|4|0|0|Toronto|Ontario|Canada||",
      @"WWWWWWWWWWWWWWW|2|21|1971|1|51|1|Los Angeles|California|United States||",   // notice hr goes 1-12
      @"WWWWWWWWWWWWWMM|2|21|1975|1|51|1|Los Angeles|California|United States||",   // notice hr goes 1-12
      @"MMMMMMMMMMMMMMM|11|8|1988|10|8|0|Los Angeles|California|United States||",   // notice hr goes 1-12
      @"Father Lastnae|7|11|1961|11|8|1|Los Angeles|California|United States||",   // notice hr goes 1-12
      @"Fa|7|11|1961|11|8|1|Los Angeles|California|United States||",
      @"Mother Lastna|3|12|1965|10|45|0|Los Angeles|California|United States||",
      @"Mo|3|12|1965|10|45|1|Los Angeles|California|United States||",
      @"Sister1 Lastnam|2|27|1988|12|31|1|Los Angeles|California|United States||",
//      @"Sis|2|31|1988|12|30|1|Los Angeles|California|United States||",  // test bad dy of mth  
      @"Sis|2|29|1988|12|30|1|Los Angeles|California|United States||",
      @"Sis3|2|28|1988|3|30|1|Los Angeles|California|United States||",
      @"~Abigail 012345|8|21|1994|1|20|0|Los Angeles|California|United States||",
      @"~Aiden 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
      @"~Anya|10|19|1990|8|20|0|Los Angeles|California|United States||",
      @"~Ava|2|3|1992|8|10|0|Los Angeles|California|United States||",
      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
      @"~Elijah|10|10|1992|12|1|1|Los Angeles|California|United States||",
//      @"~Elijah|10|10|1992|0|1|1|Los Angeles|California|United States||",   // test bad hr = 0
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
      @"~Sister1|2|29|1988|12|30|1|Los Angeles|California|United States||",
      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
    ];
    gbl_arrayExaMem = // field 11= locked or not    DO NOT HAVE TO BE PRE-SORTED  (sorted on reading back into arrays)
    @[
      @"us politics 16|donald trump|",
      @"us politics 16|ted cruz|",
      @"us politics 16|kasich|",
      @"us politics 16|bernie sanders|",
      @"us politics 16|hillary clinton|",
      @"folks|ada|",
      @"folks|alex|",
      @"folks|alexei|",
      @"folks|andy",
      @"folks|barbara|",
      @"folks|barry|",
      @"folks|bb|",
      @"folks|ben|",
      @"folks|bia|",
      @"folks|bob|",
      @"folks|borje|",
      @"folks|brenda|",
      @"folks|brigitte|",
      @"folks|charley|",
      @"folks|chris|",
      @"folks|cristian|",
      @"folks|dan|",
      @"folks|doug|",
      @"folks|dragana|",
      @"folks|edwin|",
      @"folks|eleanor|",
      @"folks|gerry Lipat|",
      @"folks|gordana|",
      @"folks|herc|",
      @"folks|hicham|",
      @"folks|irina|",
      @"folks|joan|",
      @"folks|johnH|",
      @"folks|joris|",
      @"folks|jose|",
      @"folks|juta|",
      @"folks|karen|",
      @"folks|kaz|",
      @"folks|ken|",
      @"folks|kerstin|",
      @"folks|kevin|",
      @"folks|lance|",
      @"folks|larry|",
      @"folks|leo|",
      @"folks|luis|",
      @"folks|ma|",
      @"folks|mak|",
      @"folks|marie|",
      @"folks|marilyn|",  
      @"folks|markgolf|",
      @"folks|marknesbit|",
      @"folks|matti|",
      @"folks|mihaela|",
      @"folks|mike",
      @"folks|mosy|",
      @"folks|muru|",
      @"folks|nicky|",
      @"folks|nina|",
      @"folks|olivia|",
      @"folks|pa|",
      @"folks|pat tennis|",
      @"folks|paul|",
      @"folks|renee|",
      @"folks|richard|",
      @"folks|rik|",
      @"folks|rohit|",
      @"folks|ruth|",
      @"folks|sam|",
      @"folks|sarwan|",
      @"folks|scott|",
      @"folks|steve skipper|",
      @"folks|ulli|",
      @"folks|vesna|",
      @"folks|victor|",
      @"folks|winnie|",
      @"folks|yogi|",
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
    gbl_arrayExaGrpRem =   //   DO NOT HAVE TO BE PRE-SORTED  (sorted on reading back into arrays)
    @[
//      @"Long Names||||",
//      @"Short Names||||",
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
    gbl_arrayExaPerRem =   //   DO NOT HAVE TO BE PRE-SORTED  (sorted on reading back into arrays)
    @[
//      @"Father Lastnae||||||",
//      @"Fa||||||",
//      @"Mother Lastna||||||",
//      @"Mo||||||",
//      @"Sister1 Lastnam||||||",
//      @"Sis||||||",
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


//    gbl_show_example_data = YES;  // add option later to not show them
    

    // UIColor uses a 0-1 instead of 0-255 system so you just need to convert it like so:
    //
//    gbl_colorReportsBG          = [UIColor alloc];  use gbl_colorHomeBG instead 
//    gbl_colorSelParamForReports = [UIColor alloc];
    

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


    gbl_mySelectedCellBgView =[[UIView alloc] initWithFrame:CGRectZero];     // for highlight selected cell flash
//    [gbl_mySelectedCellBgView setBackgroundColor:  [UIColor yellowColor] ];   // for highlight selected cell flash
//    [gbl_mySelectedCellBgView setBackgroundColor:  [UIColor cyanColor] ];   // for highlight selected cell flash
//    [gbl_mySelectedCellBgView setBackgroundColor:  [UIColor lightGrayColor] ];   // for highlight selected cell flash
//    [gbl_mySelectedCellBgView setBackgroundColor:  [UIColor colorWithRed:226.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:1.0]]; 
    [gbl_mySelectedCellBgView setBackgroundColor:  [UIColor whiteColor] ];   // for highlight selected cell flash


    gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectZero];     // for highlight selected cell flash
    [gbl_myCellBgView setBackgroundColor:  [UIColor whiteColor] ];   // for highlight selected cell flash
//[gbl_myCellBgView setBackgroundColor:  [UIColor lightTextColor] ];

    gbl_myCellBgView_cBgr =[[UIView alloc] initWithFrame:CGRectZero];     // for highlight selected cell flash
//    [gbl_myCellBgView_cBgr setBackgroundColor:  gbl_color_cBgr ];   // for highlight selected cell flash
//    [gbl_myCellBgView_cBgr setBackgroundColor:  [UIColor redColor] ];   // for highlight selected cell flash
    [gbl_myCellBgView_cBgr setBackgroundColor: [UIColor colorWithRed:247.0/255.0 green:235.0/255.0 blue:209.0/255.0 alpha:1.0]]; // f7ebd1 cBgr

    gbl_myCellBgView_cHed =[[UIView alloc] initWithFrame:CGRectZero];     // for highlight selected cell flash
    [gbl_myCellBgView_cBgr setBackgroundColor: [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:224.0/255.0 alpha:1.0]]; // fcfce0 cHed


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

//    gbl_colorReportsBG = [UIColor colorWithRed:225.0/255.0 green:238.0/255.0 blue:255.0/255.0 alpha:1.0];  // little darker than home 230/242
//    gbl_colorSelParamForReports = gbl_colorReportsBG;  // these are for SELRPTs sceens and select 2nd person
//    gbl_colorSelParamForReports = gbl_colorHomeBG;  // these are for SELRPTs sceens and select 2nd person




//    gbl_colorHomeBG = [UIColor colorWithRed:167.0/255.0 green:207.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid of sail/baby blue slightly dark
//    gbl_colorHomeBG = [UIColor colorWithRed:181.0/255.0 green:214.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  sail    OK
//    gbl_colorHomeBG = [UIColor colorWithRed:206.0/255.0 green:227.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  Hawkes blue
//    gbl_colorHomeBG = [UIColor colorWithRed:222.0/255.0 green:237.0/255.0 blue:252.0/255.0 alpha:1.0]; // test  mid    too light



//    gbl_colorHomeBG      = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:254.0/255.0 alpha:1.0]; // gold  10160114
//    gbl_colorHomeBG_save = gbl_colorHomeBG ;  // in order to put back after editing mode color
    

//    gbl_color_cMacHighlight  = [UIColor colorWithRed:038.0/255.0 green:140.0/255.0 blue:251.0/255.0 alpha:1.0]; // 268cfb or 038,140,251
//    gbl_color_cAplTop  = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]; //  246,248,249
    gbl_color_cAplTop  = [UIColor colorWithRed:252.0/255.0 green:250.0/255.0 blue:246.0/255.0 alpha:1.0]; // f8f8f8 or 246,248,249


//    gbl_color_cAplDarkBlue = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]; // 0080ff  (blue text, chevron)


//    gbl_colorHomeBG_per  = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:254.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:238.0/255.0 green:246.0/255.0 blue:254.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:254.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:228.0/255.0 green:238.0/255.0 blue:254.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:240.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:226.0/255.0 green:242.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:218.0/255.0 green:242.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:254.0/255.0 alpha:1.0]; //  
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:0xf5/255.0 green:0xf5/255.0 blue:0xdc/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:0xde/255.0 green:0xb8/255.0 blue:0x87/255.0 alpha:1.0]; //
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:0xcd/255.0 green:0x85/255.0 blue:0x3f/255.0 alpha:1.0]; //  peru
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:205.0/255.0 green:133.0/255.0 blue:63.0/255.0 alpha:1.0]; //  peru
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:205.0/255.0 green:133.0/255.0 blue:63.0/255.0 alpha:1.0]; //  peru
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:146.0/255.0 blue:70.0/255.0 alpha:1.0]; //  lighter peru
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:165.0/255.0 blue:85.0/255.0 alpha:1.0]; //  lighter peru
//


//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // GOLD per lighter burlywood 592 
    gbl_colorHomeBG_per  = [UIColor colorWithRed:230.0/255.0 green:211.0/255.0 blue:176.0/255.0 alpha:1.0]; // hampton  light brown  new GOLD



    //  try for lighter color   using guide apl Notes yellow is =  RGB(254, 239, 181)   tot=674   want 66-->690
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:250.0/255.0 green:220.0/255.0 blue:183.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:245.0/255.0 green:215.0/255.0 blue:179.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:240.0/255.0 green:210.0/255.0 blue:175.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:235.0/255.0 green:207.0/255.0 blue:172.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:198.0/255.0 blue:168.0/255.0 alpha:1.0]; //




    // try new reds
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:032.0/255.0 blue:128.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:240.0/255.0 green:032.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:032.0/255.0 blue:096.0/255.0 alpha:1.0]; // good red
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:032.0/255.0 blue:096.0/255.0 alpha:1.0]; // good red
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:044.0/255.0 blue:123.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:040.0/255.0 blue:112.0/255.0 alpha:1.0]; // best
//

//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:112.0/255.0 blue:128.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:128.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:140.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:140.0/255.0 alpha:1.0]; //
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:090.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:070.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:133.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:133.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:160.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:096.0/255.0 blue:096.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:124.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:040.0/255.0 blue:124.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:088.0/255.0 blue:154.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:150.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:133.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:111.0/255.0 blue:133.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:090.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:140.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:120.0/255.0 alpha:1.0]; // good2
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:130.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:140.0/255.0 alpha:1.0]; // good
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:120.0/255.0 alpha:1.0]; // good2
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:080.0/255.0 blue:110.0/255.0 alpha:1.0]; // good3
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:088.0/255.0 blue:120.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:072.0/255.0 blue:100.0/255.0 alpha:1.0]; // ok best
//


    // try  colors for done button
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:225.0/255.0 blue:190.0/255.0 alpha:1.0]; // very lighter burlywood
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:255.0/255.0 green:236.0/255.0 blue:200.0/255.0 alpha:1.0]; // very lighter burlywood
//    gbl_colorVlightBurly  = [UIColor colorWithRed:255.0/255.0 green:230.0/255.0 blue:200.0/255.0 alpha:1.0]; // very lighter burlywood



    // FYI  gbl_colorSepara  for apple is c8c7cc  200,199,204
    //
    gbl_colorSepara_per  = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:167.0/255.0 alpha:1.0]; // cell separator color
//    gbl_colorSepara_per  = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:144.0/255.0 alpha:1.0]; // cell separator color


    //  try different color for grp
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:250.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:242.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0]; //  purple
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:230.0/255.0 alpha:1.0]; //  greeny
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:242.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]; //  reddy
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:230.0/255.0 alpha:1.0]; //  yellowy
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]; //  gray
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:248.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:222.0/255.0 green:240.0/255.0 blue:248.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:233.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:192.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:224.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:232.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; //  ok robins egg
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:232.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; // ok
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:232.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0]; // ok
//
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:232.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; //  ok robins egg
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:230.0/255.0 green:242.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:246.0/255.0 green:248.0/255.0 blue:249.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:246.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:248.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:246.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0]; //  
//
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:222.0/255.0 green:234.0/255.0 blue:248.0/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:210.0/255.0 green:226.0/255.0 blue:248.0/255.0 alpha:1.0]; //  
//
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; //  c0
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:0xff/255.0 green:0xf6/255.0 blue:0x8f/255.0 alpha:1.0]; //  
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:0xde/255.0 green:0xb8/255.0 blue:0x87/255.0 alpha:1.0]; // burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:222.0/255.0 green:184.0/255.0 blue:135.0/255.0 alpha:1.0]; // burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:242.0/255.0 green:205.0/255.0 blue:150.0/255.0 alpha:1.0]; // lighter burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:255.0/255.0 green:225.0/255.0 blue:167.0/255.0 alpha:1.0]; // lighter burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:222.0/255.0 green:184.0/255.0 blue:135.0/255.0 alpha:1.0]; // burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:139.0/255.0 green:115.0/255.0 blue:085.0/255.0 alpha:1.0]; // burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:181.0/255.0 green:128.0/255.0 blue:095.0/255.0 alpha:1.0]; // burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:199.0/255.0 green:141.0/255.0 blue:105.0/255.0 alpha:1.0]; // burlywood
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:207.0/255.0 green:155.0/255.0 blue:115.0/255.0 alpha:1.0]; // burlywood brown
//

//  gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // lighter burlywood   GOLD per

//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:222.0/255.0 green:184.0/255.0 blue:135.0/255.0 alpha:1.0]; // burlywood brown



//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // GOLD per lighter burlywood 592 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:200.0/255.0 green:178.0/255.0 blue:149.0/255.0 alpha:1.0]; // burlywood brown  GOLD grp
    gbl_colorHomeBG_grp  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // GOLD grp (old per)




    //  try for lighter color   using guide apl Notes yellow is =  RGB(254, 239, 181)   tot=674   want 66-->690
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:210.0/255.0 green:186.0/255.0 blue:157.0/255.0 alpha:1.0]; // burlywood brown  GOLD grp
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:205.0/255.0 green:182.0/255.0 blue:153.0/255.0 alpha:1.0]; // burlywood brown  GOLD grp


//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // GOLD per lighter burlywood 592 


    // FYI  gbl_colorSepara  for apple is c8c7cc  200,199,204
    //
    gbl_colorSepara_grp  = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:220.0/255.0 alpha:1.0]; // cell separator color






// TESTER AREA
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // GOLD per lighter burlywood 592 
//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:200.0/255.0 green:178.0/255.0 blue:149.0/255.0 alpha:1.0]; // burlywood brown  GOLD grp
//    gbl_colorforAddMembers = [UIColor colorWithRed:182.0/255.0 green:255.0/255.0 blue:182.0/255.0 alpha:1.0]; //  GOLD #8  green for add
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]; //  GOLD #8
    //  try for lighter color   using guide apl Notes yellow is =  RGB(254, 239, 181)


// BLUE TESTER
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:167.0/255.0 green:200.0/255.0 blue:225.0/255.0 alpha:1.0]; // nice blue
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:181.0/255.0 green:239.0/255.0 blue:255.0/255.0 alpha:1.0]; // try apl notes yellow nums 2 gr robins egg
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:239.0/255.0 green:181.0/255.0 blue:255.0/255.0 alpha:1.0]; // try apl notes yellow nums way purple
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:194.0/255.0 green:231.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:214.0/255.0 green:231.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:214.0/255.0 green:241.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:194.0/255.0 green:217.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:204.0/255.0 green:229.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:214.0/255.0 green:229.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:194.0/255.0 green:229.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:200.0/255.0 green:235.0/255.0 blue:255.0/255.0 alpha:1.0]; // nice blue
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:194.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:1.0]; // best so far
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:194.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:192.0/255.0 green:222.0/255.0 blue:253.0/255.0 alpha:1.0]; // 
//
// end BLUE TESTER


// BROWN TESTER
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:167.0/255.0 alpha:1.0]; // GOLD per lighter burlywood 592 
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:220.0/255.0 blue:183.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:220.0/255.0 blue:200.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:220.0/255.0 blue:210.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:210.0/255.0 blue:190.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:210.0/255.0 blue:170.0/255.0 alpha:1.0]; // 
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:247.0/255.0 green:210.0/255.0 blue:180.0/255.0 alpha:1.0]; // 
//
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:227.0/255.0 green:210.0/255.0 blue:180.0/255.0 alpha:1.0]; // ok
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:237.0/255.0 green:210.0/255.0 blue:180.0/255.0 alpha:1.0]; // givry
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:230.0/255.0 green:211.0/255.0 blue:176.0/255.0 alpha:1.0]; // hampton  light brown  new GOLD
//
// end BROWN TESTER


//    gbl_colorHomeBG_per  = [UIColor colorWithRed:233.0/255.0 green:245.0/255.0 blue:255.0/255.0 alpha:1.0]; // 


//    gbl_colorHomeBG_per  = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:255.0/255.0 alpha:1.0]; // no = purple
//    gbl_colorHomeBG_per  = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1.0]; // no = purple

//    gbl_colorHomeBG_grp  = [UIColor colorWithRed:149.0/255.0 green:178.0/255.0 blue:200.0/255.0 alpha:1.0]; // nice blue













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



//
//    gbl_color_cGr2  = [UIColor colorWithRed:192.0/255.0 green:255.0/255.0 blue:192.0/255.0 alpha:1.0]; // 
//    gbl_color_cGr2  = [UIColor colorWithRed:128.0/255.0 green:255.0/255.0 blue:128.0/255.0 alpha:1.0]; // 



//    gbl_color_cGre  = [UIColor colorWithRed:168.0/255.0 green:255.0/255.0 blue:152.0/255.0 alpha:1.0]; // a8ff98  gold

//    gbl_color_cGre  = [UIColor colorWithRed:223.0/255.0 green:255.0/255.0 blue:223.0/255.0 alpha:1.0]; // 
    gbl_color_cGre  = [UIColor colorWithRed:192.0/255.0 green:255.0/255.0 blue:192.0/255.0 alpha:1.0]; // c0ffc0   NEW  gold




//    gbl_color_cNeu  = [UIColor colorWithRed:229.0/255.0 green:226.0/255.0 blue:199.0/255.0 alpha:1.0]; // e5e2c7  old gold
//    gbl_color_cNeu  = [UIColor colorWithRed:245.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1.0]; // f5f4ea
      gbl_color_cNeu  = [UIColor colorWithRed:237.0/255.0 green:235.0/255.0 blue:216.0/255.0 alpha:1.0]; // edebd8  new gold


    // new reds    20150511
    
//    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:152.0/255.0 blue:168.0/255.0 alpha:1.0]; // ff98a8 old gold
//    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0]; // 
//    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]; // 
//    gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:201.0/255.0 alpha:1.0]; // ffb5c9  gold
      gbl_color_cRed  = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:201.0/255.0 alpha:1.0]; // ffb5c9  new gold



//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:068.0/255.0 blue:119.0/255.0 alpha:1.0]; // ff4477 old gold
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:103.0/255.0 blue:143.0/255.0 alpha:1.0]; // ff678f  gold
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:033.0/255.0 blue:033.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:092.0/255.0 blue:092.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:103.0/255.0 blue:143.0/255.0 alpha:1.0]; // ff678f  gold
//    gbl_color_cRe2  = [UIColor colorWithRed:192.0/255.0 green:103.0/255.0 blue:143.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:093.0/255.0 blue:123.0/255.0 alpha:1.0]; // 
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:123.0/255.0 blue:163.0/255.0 alpha:1.0]; //  ok
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:143.0/255.0 blue:188.0/255.0 alpha:1.0]; //  too pinky
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:163.0/255.0 blue:188.0/255.0 alpha:1.0]; //  too light
//    gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:133.0/255.0 blue:173.0/255.0 alpha:1.0]; //  
      gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:123.0/255.0 blue:163.0/255.0 alpha:1.0]; //  ff7ba3 NEW gold

//      gbl_color_cRe2  = [UIColor colorWithRed:255.0/255.0 green:064.0/255.0 blue:080.0/255.0 alpha:1.0]; //  ff7ba3 NEW gold
//      gbl_color_cRe2  = [UIColor colorWithRed:246.0/255.0 green:008.0/255.0 blue:025.0/255.0 alpha:1.0]; // great, but too dark



//    gbl_colorforAddMembers = gbl_color_cGre;                                                                  // cGre          GOLD #5
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:201.0/255.0 alpha:1.0]; // cRed lighter
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:233.0/255.0 blue:228.0/255.0 alpha:1.0]; // cRed lighter
//    gbl_colorforDelMembers = [UIColor colorWithRed:255.0/255.0 green:222.0/255.0 blue:228.0/255.0 alpha:1.0]; // cRed lighter  GOlD #5




//    gbl_color_textRe2  = [UIColor colorWithRed:034.0/255.0 green:034.0/255.0 blue:102.0/255.0 alpha:1.0]; // 222266  FOR TEST

    // color of top of iPhone screen  246,248,249
    gbl_color_cMacHighlight  = [UIColor colorWithRed:038.0/255.0 green:140.0/255.0 blue:251.0/255.0 alpha:1.0]; // 268cfb or 038,140,251
    gbl_color_cAplBlue = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]; // 0080ff  (blue text, chevron)

//    gbl_color_cAplBlueForSpinner= [UIColor colorWithRed:000.0/255.0 green:160.0/255.0 blue:255.0/255.0 alpha:1.0]; // lighter than gbl_color_cAplBlue 
//    gbl_color_cAplBlueForSpinner= [UIColor colorWithRed:032.0/255.0 green:192.0/255.0 blue:255.0/255.0 alpha:1.0]; // lighter than gbl_color_cAplBlue 
    gbl_color_cAplBlueForSpinner = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]; // = gbl_color_cAplBlue 


//    // light green for personality neutral color bg  (alternate the two colors)
//    gbl_color_cPerGreen  = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:166.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0]; // a6f7ff // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:205.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1.0]; // cdfbff // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:225.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1.0]; // e1fcff // light green for personality neutral color bg
//    gbl_color_cPerGreen  = [UIColor colorWithRed:247.0/255.0 green:235.0/255.0 blue:209.0/255.0 alpha:1.0]; // f7ebd1
//    gbl_color_cPerGreen  = [UIColor colorWithRed:229.0/255.0 green:226.0/255.0 blue:199.0/255.0 alpha:1.0]; // e5e2c7  make it all cNeu color
//    gbl_color_cPerGreen  = [UIColor colorWithRed:229.0/255.0 green:226.0/255.0 blue:199.0/255.0 alpha:1.0]; // e5e2c7  make it all cNeu color
    gbl_color_cPerGreen  = [UIColor colorWithRed:237.0/255.0 green:235.0/255.0 blue:216.0/255.0 alpha:1.0]; // edebd8  new gold  new cneu


//    gbl_color_cPerGreen1 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:230.0/255.0 green:255.0/255.0 blue:204.0/255.0 alpha:1.0]; // e6ffcc // really light green for personality neutral color bg
//


// green/white alternate
//    p_fn_prtlin( "    .cPerGreen1 {background-color: #66ff33;}");  // green
//    p_fn_prtlin( "    .cPerGreen2 {background-color: #fafafa;}");  // whiteish
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:042.0/255.0 green:255.0/255.0 blue:021.0/255.0 alpha:1.0]; // 66ff33  (cgr2)
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:240.0/255.0 green:245.0/255.0 blue:240.0/255.0 alpha:1.0]; //  f0f5f0  whiteish


     // FYI
     // edit button stroke  240,240,0   fill  255,255,166
     // done button stroke              fill                 

    // official apl  color of chevron, plus sign etc    is  3,122,255
    gbl_color_cAplDarkBlue = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0];


    gbl_color_cAplDarkerBlue = [UIColor colorWithRed:000.0/255.0 green:096.0/255.0 blue:224.0/255.0 alpha:1.0];


//    gbl_color_cPerGreen1 = [UIColor colorWithRed:000.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0]; // 0080ff  (blue text, chevron)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:144.0/255.0 green:200.0/255.0 blue:255.0/255.0 alpha:1.0]; //        (mid blue) 
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:242.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0]; //        (light blue)

//    gbl_color_cPerGreen1 = [UIColor colorWithRed:242.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0]; // f2f7ff (light blue)  gold #1
////    gbl_color_cPerGreen1 = [UIColor colorWithRed:238.0/255.0 green:243.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:246.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)

//    gbl_color_cPerGreen1 = [UIColor colorWithRed:232.0/255.0 green:240.0/255.0 blue:255.0/255.0 alpha:1.0]; // e8f0ff (light blue)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:240.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:248.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:252.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]; // (light blue)
    gbl_color_cPerGreen1 = [UIColor colorWithRed:240.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0]; // f0f8ff (light blue) gold #2
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:224.0/255.0 green:236.0/255.0 blue:255.0/255.0 alpha:1.0]; //
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:232.0/255.0 green:240.0/255.0 blue:255.0/255.0 alpha:1.0]; // 





//    gbl_color_cPerGreen2 = [UIColor colorWithRed:144.0/255.0 green:200.0/255.0 blue:255.0/255.0 alpha:1.0]; // 90c8ff (mid blue) gold #1
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:160.0/255.0 green:216.0/255.0 blue:255.0/255.0 alpha:1.0]; //
    gbl_color_cPerGreen2 = [UIColor colorWithRed:192.0/255.0 green:224.0/255.0 blue:255.0/255.0 alpha:1.0]; //  c0e0ff  gold #2


//    gbl_color_cPerGreen5 = [UIColor colorWithRed:201.0/255.0 green:255.0/255.0 blue:145.0/255.0 alpha:1.0]; // c9ff91 // pretty light green for personality neutral color bg
//    gbl_color_cPerGreen4 = [UIColor colorWithRed:211.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1.0]; // d3ffa5 // light green for personality neutral color bg
//    gbl_color_cPerGreen3 = [UIColor colorWithRed:221.0/255.0 green:255.0/255.0 blue:185.0/255.0 alpha:1.0]; // ddffb9 // lightER green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:230.0/255.0 green:255.0/255.0 blue:204.0/255.0 alpha:1.0]; // e6ffcc // really light green for personality neutral color bg
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0]; // f0ffe0 // really,really light green for personality neutral color bg

//    gbl_color_cPerGreen5 = [UIColor colorWithRed:185.0/255.0 green:255.0/255.0 blue:130.0/255.0 alpha:1.0]; // b9ff82 // pretty light green for personality neutral color bg
//    gbl_color_cPerGreen4 = [UIColor colorWithRed:206.0/255.0 green:255.0/255.0 blue:160.0/255.0 alpha:1.0]; // ceffa0 // light green for personality neutral color bg
//    gbl_color_cPerGreen3 = [UIColor colorWithRed:223.0/255.0 green:255.0/255.0 blue:187.0/255.0 alpha:1.0]; // dfffbb // lightER green for personality neutral color bg
//    gbl_color_cPerGreen2 = [UIColor colorWithRed:236.0/255.0 green:255.0/255.0 blue:211.0/255.0 alpha:1.0]; // ecffd3 // really light green for personality neutral color bg
//    gbl_color_cPerGreen1 = [UIColor colorWithRed:246.0/255.0 green:255.0/255.0 blue:230.0/255.0 alpha:1.0]; // f6ffe6 // really,really light green for personality neutral color bg


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



// <.> ?? after remembering N things, write out the remember Files    TODO ??
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
    NSInteger  arrayIdx = 0;
    NSString  *myStrToUpdate;
    NSString  *myupdatedStr;


tn(); NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argPersonOrGroup    =%@",argPersonOrGroup);
      NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argEntityName       =%@",argEntityName);
      NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argRememberCategory =%@",argRememberCategory);
      NSLog(@"       ssssssssssssssssssssssssssss saveLastSelectionForEntity   argChangeToThis     =%@",argChangeToThis);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    prefixStr = [NSString stringWithFormat: @"%@|", argEntityName];
//  NSLog(@"prefixStr =%@",prefixStr );

    if ([argPersonOrGroup isEqualToString:@"person"]) {

//        NSLog(@"beg of  saveLastSelectionForEntity gbl_arrayPerRem=%@",gbl_arrayPerRem);

        // get the PSV and arrayIdx of  argEntityName  in gbl_arrayPerRem
        PSVthatWasFound = nil;
        arrayIdx        = 0;
        for (NSString *element in gbl_arrayPerRem) {
            if ([element hasPrefix: prefixStr]) {
                PSVthatWasFound = element;
                break;
            }
            arrayIdx = arrayIdx + 1;
        }
//NSLog(@"PSVthatWasFound 1 =%@",PSVthatWasFound );
        // if the record was not found in gbl_array_PerRem, create an empty one (in the memory array) (has name only)
        //@
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
        NSString *newPerRemRec;
        if (PSVthatWasFound == nil) {
            newPerRemRec = [ NSString stringWithFormat: @"%@||||||", argEntityName ];

            [gbl_arrayPerRem addObject:  newPerRemRec ];   // sort here?  prob no   sorted in home when read in

            // get the PSV and arrayIdx of  argEntityName  in gbl_arrayPerRem
            PSVthatWasFound = nil;
            arrayIdx        = 0;
            for (NSString *element in gbl_arrayPerRem) {
                if ([element hasPrefix: prefixStr]) {
                    PSVthatWasFound = element;
                    break;
                }
                arrayIdx = arrayIdx + 1;
            }
            PSVthatWasFound = newPerRemRec ;
//NSLog(@"PSVthatWasFound 2 (created) =%@",PSVthatWasFound );
        }  // create a new gbl_array_PerRem for this entity

        if      ([argRememberCategory isEqualToString: @"rptsel"]) myElementNum = 2;  // one-based index number
        else if ([argRememberCategory isEqualToString: @"year"])   myElementNum = 3;
        else if ([argRememberCategory isEqualToString: @"person"]) myElementNum = 4;
        else if ([argRememberCategory isEqualToString: @"group"])  myElementNum = 5;
        else if ([argRememberCategory isEqualToString: @"day"])    myElementNum = 6;
        else {
            NSLog(@"should not happen   cannot find group  rememberCategory= %@", argRememberCategory );
            return;  // should not happen
        }

        if (PSVthatWasFound != nil) {
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
        PSVthatWasFound = nil;
        arrayIdx        = 0;
        for (NSString *element in gbl_arrayGrpRem) {
            if ([element hasPrefix: prefixStr]) {
                PSVthatWasFound = element;
                break;
            }
//NSLog(@"gbl_arrayGrpRem[arrayIdx]=%@",gbl_arrayGrpRem[arrayIdx]);
            arrayIdx = arrayIdx + 1;
        }
//  NSLog(@"PSVthatWasFound =%@",PSVthatWasFound );

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
        NSString *newGrpRemRec;
        if (PSVthatWasFound == nil) {
            newGrpRemRec = [ NSString stringWithFormat: @"%@||||", argEntityName ];

            [gbl_arrayGrpRem addObject:  newGrpRemRec ];   // sort here?  prob no   sorted in home when read in

            // get the PSV and arrayIdx of  argEntityName  in gbl_arrayGrpRem
            PSVthatWasFound = nil;
            arrayIdx        = 0;
            arrayIdx = 0;
            for (NSString *element in gbl_arrayGrpRem) {
                if ([element hasPrefix: prefixStr]) {
                    PSVthatWasFound = element;
                    break;
                }
                arrayIdx = arrayIdx + 1;
            }
            PSVthatWasFound = newGrpRemRec ;
//NSLog(@"PSVthatWasFound 2 (created) =%@",PSVthatWasFound );
        }  // create a new gbl_array_GrpRem for this entity

        if      ([argRememberCategory isEqualToString: @"rptsel"]) myElementNum = 2;  // one-based index number
        else if ([argRememberCategory isEqualToString: @"year"])   myElementNum = 3;
        else if ([argRememberCategory isEqualToString: @"day"])    myElementNum = 4;
        else {
            NSLog(@"should not happen   cannot find group  rememberCategory= %@", argRememberCategory );
            return;  // should not happen
        }


        if (PSVthatWasFound != nil) {
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

  NSLog(@"arrayIdx                                                                      =[%ld]",(long)arrayIdx );
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
tn(); NSLog(@"       ggggg  grabLastSelectionValueForEntity   entity     =%@", argPersonOrGroup );
      NSLog(@"       ggggg  grabLastSelectionValueForEntity   entityName =%@", argEntityName);
      NSLog(@"       ggggg  grabLastSelectionValueForEntity rememberCat  =%@", argRememberCategory);

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
//  NSLog(@"myRemArrIdx =[%ld]",(long)myRemArrIdx );
//  NSLog(@"myRemPSV    =[%@]",myRemPSV );
    if (myRemPSV) {                           // get remembered value
        myRemArr = [myRemPSV componentsSeparatedByCharactersInSet: myNSCharacterSet];

//        return myRemArr[myPSVfldNum -1]; // one-based 
        myReturnStr = myRemArr[myPSVfldNum -1]; // one-based 
//  NSLog(@"myReturnStr =[%@]",myReturnStr );

      NSLog(@"end of ggggg  grabLastSelectionValueForEntity   myReturnStr=%@", myReturnStr);

        return myReturnStr;
    }

NSLog(@"end of ggggg  grabLastSelectionValueForEntity   myReturnStr=NIL");
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


//NSLog(@"in mambWriteNSArrayWithDescription   BEFORE WRITE  my EXAMPLE Array=%@",myArray);

    //NSLog(@"gbl_URLToGroup=%@",gbl_URLToGroup);
//    NSLog(@"myURLtoWriteTo  =%@",myURLtoWriteTo  );

    [gbl_sharedFM removeItemAtURL: myURLtoWriteTo  error:&err01];     // remove old (because no overcopy)
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error on remove %@= %@", argEntityDescription, err01); }

    myArchive   = [NSKeyedArchiver  archivedDataWithRootObject: myArray];
//tn();  NSLog(@"myArchive=\n%@",myArchive);

    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//    myWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myArchive];
    myWriteable = [myappDelegate mambPreWriteForThisNSData: (NSData *) myArchive];
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

ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);
tr("end of mambWriteNSArrayWithDescription         ");
tn();


} // end of mambWriteNSArrayWithDescription



// READ   there are 5  entity/array files to READ
//
- (void) mambReadArrayFileWithDescription: (NSString *) entDesc     // argEntityDescription  // like "group","person"  populate gbl_array*
{
    NSLog(@"in mambReadArrayFileWithDescription: %@  ----------", entDesc  );
    NSURL          *myURLtoReadFrom;
    NSMutableArray *my_gbl_array;
    NSData  *myWritten;
    NSData  *myNSData;
    NSData  *myUnarchived;

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
//    myNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myWritten];
    myNSData = [myappDelegate mambPostReadForThisNSData: (NSData *) myWritten];
//tn();  NSLog(@"myNSData=\n%@",myNSData);

    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
//tn();  NSLog(@"myUnarchived=\n%@",myUnarchived );

    //if ([entDesc isEqualToString:@"group"])         { gbl_arrayGrp       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myLocalArray]; }
    if ([entDesc isEqualToString:@"group"])  { gbl_arrayGrp    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"person"]) { gbl_arrayPer    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"member"]) { gbl_arrayMem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"grprem"]) { gbl_arrayGrpRem = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"perrem"]) { gbl_arrayPerRem = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }


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
    char C_allowedCharactersInName[128] = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
//    char C_allowedCharactersInCity[128] = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-";
    int daysinmonth[12]     ={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int daysinmonth_leap[12]={31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

//ksn(C_allowedCharactersInCity);
//trn("hey");
//tn();
//tn();


//<.>
//    int daysinmonth[12]={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
//    int rollerMM, rollerDD, rollerYYYY;
//
//<.>
//


    //    // get the current year       relying on gcy() instead
    //    NSCalendar       *gregorian;
    //    NSDateComponents *dateComponents;
    //    NSInteger         myCurrentYearInt;
    //    gregorian        = [NSCalendar currentCalendar]; 
    //    dateComponents   = [gregorian components: (NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear) 
    //                                    fromDate: [NSDate date]
    //    ];
    //    myCurrentYearInt = [dateComponents year];

    //  int sall(char *s,char *set) // returns 1 if  str s consists entirely of chars in str set, else 0

    NSInteger numRecords;
    NSInteger numFields;

  NSLog(@"BEG   CHECK  group NAME");
    //      BEG   CHECK  group
    numRecords = 0;   numFields = 0;
    for (NSString *psvGrp in gbl_arrayGrp) {     // get PSV of arg name
        numRecords = numRecords + 1;
       
        // check for exactly 3 fields
        //   EXCEPT for  "All People~" which has 15-20 fields
        //                  @"~My Family||",
        //
        flds  = [psvGrp componentsSeparatedByCharactersInSet: mySeparators];

        if (flds.count == 0)                                   return 100;   // s/b 3   or lots for "All People~"

        fname    = flds[0];
       
        if ([fname isEqualToString: gbl_nameOfGrpHavingAllPeopleIhaveAdded]) // gbl_nameOfGrpHavingAllPeopleIhaveAdded; 
        {
            // do not do fld count check for all people
            if (flds.count  < 10 )                                 return 101;   // s/b  gt 14,15 

            //  the  GOLD CURRENT DATE  for the whole app  
            // (stored in #allpeople grp record fld 5,6,7 1-based) 
            //
            NSString *curyr = flds[4];  // 5 1-based
            NSString *curmn = flds[5];  // 6 1-based
            NSString *curdy = flds[6];  // 7 1-based

            // check for invalid  current year fld in #allpeople
            if (curyr.length != 4)                                 return 102;
            constant_char = [curyr  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
            strcpy(cyr, constant_char);                                        // NSString object to C str  // because of const
            if (sall(cyr, "0123456789") == 0)                      return 103;
            if (atoi(cyr) < gbl_earliestYear)                      return 104;

            // check for invalid  current month fld in #allpeople
            if (curmn.length < 1)                                  return 104;
            if (curmn.length > 2)                                  return 105;
            constant_char = [curmn  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
            strcpy(cmth, constant_char);                                        // NSString object to C str  // because of const
            if (sall(cmth, "0123456789") == 0)                     return 106;
            if (atoi(cmth) <  1)                                   return 107;
            if (atoi(cmth) > 12)                                   return 108;

            // check for invalid current day fld in #allpeople
            if (curdy.length < 1)                                  return 109;
            if (curdy.length > 2)                                  return 110;
            constant_char = [curdy  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
            strcpy(cday, constant_char);                                        // NSString object to C str  // because of const
            if (sall(cday, "0123456789") == 0)                     return 111;
            if (atoi(cday) <  1)                                   return 112;

        } else {
            // do fld count check for other groups
            if (flds.count !=  3)                                   return   1;   // s/b 3   
        }


        if (fname.length < 1)                                  return   2;
        if (fname.length > gbl_MAX_lengthOfName)               return   3;

        // check for invalid characters in name
        //
        if ([fname canBeConvertedToEncoding:         NSUTF8StringEncoding] == NO) return 4;
        constant_char = [fname cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cname, constant_char);                                        // NSString object to C str  // because of const

        // check for  ~  as first char (is ok)
        //   EXCEPT  do not check grp "#allpeople"  for this (gbl_nameOfGrpHavingAllPeopleIhaveAdded)
        //
        if ([fname isEqualToString: gbl_nameOfGrpHavingAllPeopleIhaveAdded]) // gbl_nameOfGrpHavingAllPeopleIhaveAdded;// "All People~"
        {
            // skip this check for group  gbl_nameOfGrpHavingAllPeopleIhaveAdded

        } else {
            if (cname[0] == '~') {      
                if (sall(cname + 1, C_allowedCharactersInName) == 0) return   4;
            } else {
                if (sall(cname,     C_allowedCharactersInName) == 0) return   5;
            }
        }
    }
    if (numRecords <   2 )                                     return   6;  // 2 is MAGIC for the 2 example groups
    if (numRecords >  gbl_MAX_groups)                          return   7;  // max groups is 50
  NSLog(@"END   CHECK  group NAME");



  NSLog(@"BEG   CHECK  person");
    //      BEG   CHECK  person)";
    for (NSString *psvPer in gbl_arrayPer) {     // get PSV of arg name
//  NSLog(@"psvPer =[%@]",psvPer );
        numRecords = numRecords + 1;

        // check for exactly 12 fields
        //                  @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
        //
        flds  = [psvPer componentsSeparatedByCharactersInSet: mySeparators];
        
//  NSLog(@"flds=[%@]",flds);
//  NSLog(@"flds.count=[%ld]",(long)flds.count);
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
//  NSLog(@"fyr=[%@]",fyr);

        // check for invalid  name fld
        if (fname.length < 1)                                  return  12;
        if (fname.length > gbl_MAX_lengthOfName)               return  13;
        constant_char = [fname  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cname, constant_char);                                        // NSString object to C str  // because of const
        //
        if (cname[0] == '~') {        // ~ only legal as first char of name
            if (sall(cname + 1, C_allowedCharactersInName) == 0) return  14;
        } else {
            if (sall(cname,     C_allowedCharactersInName) == 0) return  15;
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
        if (fyr.length != 4)                                   return  21;
        constant_char = [fyr  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cyr, constant_char);                                        // NSString object to C str  // because of const
//ksn(cyr);
        if (sall(cyr, "0123456789") == 0)                      return  22;
        if (atoi(cyr) < gbl_earliestYear)                      return  23;


        // gbl_currentYearInt  is not set yet from gcy   nothing to check it against
        //        if (atoi(cyr) > (int) myCurrentYearInt + 1)            return  24;
        //        if (atoi(cyr) > (int) gbl_currentYearInt + 1)            return  24;



        // check for invalid  day fld
        if (fday.length < 1)                                   return  25;
        if (fday.length > 2)                                   return  26;
        constant_char = [fday  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cday, constant_char);                                        // NSString object to C str  // because of const
        if (sall(cday, "0123456789") == 0)                     return  27;
        if (atoi(cday) <  1)                                   return  28;

        //
        if (    atoi(cyr) % 400 == 0                            //  invalid day of month
            || (atoi(cyr) % 100 != 0  &&  atoi(cyr) % 4 == 0))  // if leap year
        {

            if (atoi(cday) > daysinmonth_leap[ atoi(cmth) - 1] )   return  29;   // -1 because array is 0-based
        } else {
            if (atoi(cday) > daysinmonth     [ atoi(cmth) - 1])   return  30;
        }


        // check for invalid  hr fld
        if (fhr.length < 1)                                    return  31;
        if (fhr.length > 2)                                    return  32;
        constant_char = [fhr  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(chr, constant_char);                                        // NSString object to C str  // because of const
//ksn(chr);
        if (sall(chr, "0123456789") == 0)                      return  33;

        if (atoi(chr) <  1)                                    return  34; // valid vals= 01 to 12
//        if (atoi(chr) <  1)         {
//  NSLog(@"psvPer=[%@]",psvPer);
//            return  31; // valid vals= 01 to 12
//        }

        if (atoi(chr) > 12)                                    return  35; // valid vals= 01 to 12
//        if (atoi(chr) <  0)                                    return  31; // valid vals= 00 to 11
//        if (atoi(chr) > 11)                                    return  32;


        // check for invalid  min fld
        if (fmin.length < 1)                                   return  36;
        if (fmin.length > 2)                                   return  37;
        constant_char = [fmin  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(cmin, constant_char);                                        // NSString object to C str  // because of const
        if (sall(cmin, "0123456789") == 0)                     return  38;
        if (atoi(cmin) <  0)                                   return  39;
        if (atoi(cmin) > 59)                                   return  40;


        // check for invalid  am/pm (0/1) fld
        if (fampm.length != 1)                                 return  41;
        constant_char = [fampm  cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C str
        strcpy(campm, constant_char);                                        // NSString object to C str  // because of const
        if (sall(campm, "0123456789") == 0)                    return  42;
        if (atoi(campm) <  0)                                  return  43;
        if (atoi(campm) >  1)                                  return  44;

    }
  NSLog(@"END   CHECK  person");



  NSLog(@"BEG   CHECK all members");
    // go thru  gbl_arrayMem
    //   - check each group  name exists
    //     - if group does not exist,  delete this gbl_arrayMem
    //   - check each person name exists
    //     - if person does not exist,  delete this gbl_arrayMem
    //
    NSString *arrayMem_rec;
    NSArray  *psvArray;
    NSString *currGroup;
    NSString *currPerson;
    NSString *prefixStr6;
    NSString *prefixStr7;
    BOOL      group_wasFound, person_wasFound;
    NSString *lastFoundPersonName;
    NSString *lastFoundGroupName;
    NSInteger idx_gbl_arrayMem, num_rec_arrayMem;
    NSMutableArray  *indexNumsToDeleteFrom_gblArrayMem;
    NSInteger idxToDel;

    [indexNumsToDeleteFrom_gblArrayMem  removeAllObjects];
     indexNumsToDeleteFrom_gblArrayMem  = [[NSMutableArray alloc] init];

    idx_gbl_arrayMem    = -1;
    lastFoundPersonName = @"";
    lastFoundGroupName  = @"";

//    for (id myMemberRec in gbl_arrayMem)  
    num_rec_arrayMem = gbl_arrayMem.count;
  NSLog(@"num_rec_arrayMem =[%ld]",(long)num_rec_arrayMem );

    for (idx_gbl_arrayMem = 0; idx_gbl_arrayMem < num_rec_arrayMem; idx_gbl_arrayMem++ ) 
    {
        arrayMem_rec = gbl_arrayMem[idx_gbl_arrayMem];
        psvArray        = [arrayMem_rec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"|"]];
        currGroup       = psvArray[0];
        currPerson      = psvArray[1];
        group_wasFound  = NO;
        person_wasFound = NO;

        // for test, put in non-existant group and person
        //if ([currGroup isEqualToString: @"Short Names" ]) currGroup = @"short names xxx";
        //if ([currPerson isEqualToString: @"harry" ]) currPerson = @"harry xxx";

        if ([currGroup isEqualToString: lastFoundGroupName ])
        {   
            // do NOT look up if group exists
            group_wasFound      = YES;

        } else {  // look up if group exists

            prefixStr6 = [NSString stringWithFormat: @"%@|", currGroup];  // notice '|'
//  NSLog(@"prefixStr6 =[%@]",prefixStr6 );
            for (NSString *elt in gbl_arrayGrp) {     
                if ([elt hasPrefix: prefixStr6]) { 
                    group_wasFound      = YES;
                    lastFoundGroupName  = currGroup;
                    break;
                }
            }
        } //  look up if group exists

//  NSLog(@"group_wasFound =[%d]",group_wasFound );
//  NSLog(@"currGroup      =[%@]",currGroup);

        if (group_wasFound == NO) { 
            // here group was NOT found

            [indexNumsToDeleteFrom_gblArrayMem addObject: [[NSNumber alloc] initWithInteger: idx_gbl_arrayMem ]] ;
//  NSLog(@"delete member with group  1 =[%@]", currGroup);
//  NSLog(@"delete member with member 1 =[%@]", currPerson);
            continue;
        } else {
            // here group was found,  so look for Person

            if ([currPerson isEqualToString: lastFoundPersonName ])
            {   
                // do NOT look up if person exists
                person_wasFound      = YES;

            } else {  // look up if person exists

                prefixStr7 = [NSString stringWithFormat: @"%@|", currPerson];  // notice '|'
//  NSLog(@"prefixStr7 =[%@]",prefixStr7 );
                for (NSString *elt in gbl_arrayPer) {   
                    if ([elt hasPrefix: prefixStr7]) { 
                        person_wasFound      = YES;
                        lastFoundPersonName  = currPerson;
                    }
                }
            } //  look up if person exists

//  NSLog(@"person_wasFound =[%d]",person_wasFound );
//  NSLog(@"currperson      =[%@]",currPerson);

            if (person_wasFound == NO) { 
                // here person was NOT found
                [indexNumsToDeleteFrom_gblArrayMem addObject: [[NSNumber alloc] initWithInteger: idx_gbl_arrayMem ]] ;
//  NSLog(@"delete member with group  2 =[%@]", currGroup);
//  NSLog(@"delete member with member 2 =[%@]", currPerson);
            } else {
                // here person was  found
                continue;
            }
        } // group was found

    } // for each gbl_arrayMem

//  NSLog(@"indexNumsToDeleteFrom_gblArrayMem =[%@]",indexNumsToDeleteFrom_gblArrayMem );

    // now delete all the gbl_arrayMemb elements that were not kosheer
    //
    if (indexNumsToDeleteFrom_gblArrayMem.count > 0) {

        [indexNumsToDeleteFrom_gblArrayMem  removeAllObjects];
         indexNumsToDeleteFrom_gblArrayMem  = [[NSMutableArray alloc] init];

        // now delete from gbl_arrayMem
        // by  going backwards from the highest index to delete to the lowest
        // (because indexNumsToDeleteFrom_gblArrayMem is automatically sorted  smallest idx to largest idx)
        //
        for (NSInteger i = indexNumsToDeleteFrom_gblArrayMem.count - 1;  i >= 0;  i--) 
        {
            idxToDel = [indexNumsToDeleteFrom_gblArrayMem[i]  integerValue];
//  NSLog(@"idxToDel      =[%ld]",idxToDel);
//  NSLog(@"(long)idxToDel=[%ld]",(long)idxToDel);

            [gbl_arrayMem removeObjectAtIndex: idxToDel ];   // TODO      uncomment

//      NSLog(@"deleted index=[%ld]", (long)idxToDel);
        }
    }  // delete deleteable gbl_arrayMem


  NSLog(@"END   CHECK all members");

  NSLog(@"in mambCheckForCorruptData    END");

  return 0;  // no errors

}  // end of mambCheckForCorruptData


//- (void) handleCorruptDataErrNum:  (NSInteger) argCorruptDataErrNum
//{
//  NSLog(@"in handleCorruptDataNum    BEG");
//  NSLog(@"argCorruptDataErrNum=[%ld]",(long)argCorruptDataErrNum);
//
//    NSString *mymsg;
//    mymsg = @"When corrupt data is found, the App has to delete all of your added people, groups and group members.\n\n   RECOVERY of DATA \n\n Method 1:\n\nAssuming you did backups, go to the latest email having the \"Me and My BFFs\" BACKUP.\nFollow the instructions in the email to restore the data.\n\nMethod 2:  Delete \"Me and My BFFs\" and install it again from the App store. \n Doing this uses your iTunes or iCloud backup to automatically restore the data for people, groups and members.\n\n ";
//
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Corrupt Data has been Found"
//                                                                   message: mymsg
//                                                            preferredStyle: UIAlertControllerStyleAlert  ];
//     
//    UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
//                                                        style: UIAlertActionStyleDefault
//                                                      handler: ^(UIAlertAction * action) {
//        NSLog(@"Ok button pressed    for corrupt data");
//    } ];
//     
//    [alert addAction:  okButton];
//
//    [self presentViewController: alert  animated: YES  completion: nil   ];
////    [presentViewController: alert  animated: YES  completion: nil   ];
//        
//
//// automatic backup?  how often?  when?   NO  all manual
////
////-------------------------------------------
////RECOVERY from Corrupt Data
////-------------------------------------------
//// TODO 
//
////      Corrupt data has been found
////
//// When corrupt data is found, the App has to delete
//// all of your added people, groups and group members.
////
//// RECOVERY of DATA 
////
//// Method 1:  Assuming you did backups, go to the latest email having the \"Me and My BFFs\" BACKUP.
//// Follow the instructions in the email to restore the data.
////
//// Method 2:  Delete "Me and My BFFs" and install it again from the App store. 
//// Doing this uses your iTunes or iCloud backup to automatically restore the data for people, groups and members.
////
//
//
//// The people, groups and members data is automatically restored from iCloud backup.
//
//
////      Corrupt data has been found
////
//// When corrupt data is found, the App has to delete
//// all of your added people, groups and group members.
////
//// Luckily, the App every so often sends you a data BACKUP file
//// as an email attachment.
////
//// Do these RECOVERY steps to get back your latest BACKUP data.
////
////   1. On this device, go to the mail App.
////   2. Open the MOST RECENT email with
////      - the subject "BACKUP for Me and my BFFs on yyyymmdd"
////      - the attachment "BACKUP_yyyymmdd.mamb"
////        (yyyymmdd is the date of the backup)
////   3. Follow the direcions in the email to
////      restore your backed up data.
//// 
//
//
////Corrupt data has caused your current data to be lost.
////
////Do these RECOVERY steps to get back your latest BACKUP data.
////
////   1. Leave this App alone right now.  Do not tap OK.
//
////   1. On this device, go to the mail App.
////   2. Open your MOST RECENT email
////      with the subject "Me and my BFFs BACKUP"
////      and the attachment "BACKUP.mamb".
////   3. Follow the direcions in the email to
////      restore the backup data.
//
//
////   4. Long-press the email attachment.
////   5. Tap and hold on the email attachment.
////   6. Tap YES for doing the backup recovery.
////   7. When the recovery is done, come back here and tap OK.
////
////These instructions are also on the home page. Tap the Info button.
////
////The data corruption error number was 123.   auto-email to web site?
////-------------------------------------------
//
//
//  NSLog(@"in handleCorruptDataNum    END");
//} // end of handleCorruptDataNum
//

// mambPreWriteForThisNSData  is called like this:
//    myArchive   = [NSKeyedArchiver  archivedDataWithRootObject: myArray];
//    myWriteable = [myappDelegate mambPreWriteForThisNSData: (NSData *) myArchive];

- (NSData *) mambPreWriteForThisNSData:  (NSData *)  argMyArchive   // arg is NSData/archived, returns a file-writeable NSData
{
tn();trn("in PreWrite");
//  NSLog(@"argMyArchive   =[%@]",argMyArchive   );

    NSData        *myb64Data; 
    NSMutableData *myb64Muta; 

    myb64Data   = [argMyArchive base64EncodedDataWithOptions: 0];             // (1) myArchive to myb64Data
//tn();  NSLog(@"myb64Data=     PreWriteFor\n%@",myb64Data);

    myb64Muta   = [[NSMutableData alloc] initWithData: myb64Data];            // (2) myb64Data to myb64Muta obfuscated (in place)
        uint8_t *bytes = (uint8_t *)[myb64Muta bytes];                            
        uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44}; 
        const int patternLengthInBytes = 8;    // len 64 bit
        for(int index = 0; index < [myb64Data length]; index++) {
             bytes[index] ^= pattern[index % patternLengthInBytes];
        }
//tn();  NSLog(@"myb64DataOBFUSCATED=     PreWriteFor\n%@",myb64Muta);

trn("end of  PreWrite");
    return myb64Muta;

} // end of mambPreWriteForThisNSData


- (NSData *) mambPostReadForThisNSData: (NSData *)  argMyNSData  //  arg is a file-writeable NSData, returns an NSData/archived
{
tn();trn("in PostRead");
    NSMutableData *myb64Muta; 
    NSData        *myArchive; 

    myb64Muta   = [[NSMutableData alloc] initWithData: argMyNSData];          // (2) myb64Muta obfuscated to myb64Muta (in place)
        uint8_t *bytes = (uint8_t *)[myb64Muta bytes];                       
        uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44};
        const int patternLengthInBytes = 8;
        for(int index = 0; index < [myb64Muta length]; index++) {
            bytes[index] ^= pattern[index % patternLengthInBytes];
        }
//tn();  NSLog(@"myb64Muta=     PostReadFor\n%@",myb64Muta);

    myArchive = [[NSData alloc] initWithBase64EncodedData: myb64Muta          // (2) myb64Muta to myArchive
                                                    options: 0];  
//    NSLog(@"myArchive=     PostReadFor\n%@",myArchive);
//printf("myArchiveSTR=\n%s\n", [[myArchive description] UTF8String]);
trn("end of  PostRead");

    return myArchive;

} // end of mambPostReadForThisNSData



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

   
    if (gbl_lastSelectedPerson == nil ||  gbl_lastSelectedGroup == nil  ||   gbl_fromHomeCurrentSelectionType == nil ||
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

//       myLastEntityDataFil = [myappDelegate mambKriptOnThisNSData: (NSData *) myLastEntityArchive];
       myLastEntityDataFil = [myappDelegate mambPreWriteForThisNSData: (NSData *) myLastEntityArchive];
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

//        myLastEntityArchive = [myappDelegate mambKriptOffThisNSData: (NSData *) myLastEntityDataFil];
        myLastEntityArchive = [myappDelegate mambPostReadForThisNSData: (NSData *) myLastEntityDataFil];
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


  NSLog(@"[[UIApplication sharedApplication] isIgnoringInteractionEvents] =[%d]",[[UIApplication sharedApplication] isIgnoringInteractionEvents] );
      // testing - came here on rapid fire tapping Person/Group on home screen  (one time only)
      // here, maybe user can tap on home screen app icon to come back ?

//
//    // Called as part of the transition from the background to the inactive state;
//    // here you can undo many of the changes made on entering the background.
//    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//    [navigationController popToRootViewControllerAnimated: YES];
//


    NSLog(@"finished  applicationWillResignActive()  in appdelegate");

} // end of  applicationWillResignActive



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

//    if (gbl/onent
//<.>

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

    // do ordinary group  (not #allpeople)
    if (! [argGroupName  isEqualToString: gbl_nameOfGrpHavingAllPeopleIhaveAdded ])
    {

        if (     [argArrayDescription isEqualToString: @"gbl_grp_CSVs"])
        {
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

        // move to bottom
        //        return gbl_kingpinIsInGroup;
    } // do ordinary group  (not #allpeople)




    // do special group   #allpeople
    if ([argGroupName  isEqualToString: gbl_nameOfGrpHavingAllPeopleIhaveAdded ])
    {
        if (     [argArrayDescription isEqualToString: @"gbl_grp_CSVs"])
        {
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

        for (id member in gbl_arrayPer) {   // loop thru gbl group member array

            NSCharacterSet *mySeparators           = [NSCharacterSet characterSetWithCharactersInString:@"|"];
            NSArray        *groupMemberComponents  = [member componentsSeparatedByCharactersInSet: mySeparators];
    //NSLog(@"groupMemberComponents  =%@",groupMemberComponents  );

            NSString *nameOfMember = groupMemberComponents[0];  // member (person) name is 1st fld in gbl_arrayPer
//    NSLog(@"nameOfMember =%@",nameOfMember );


            // 20160309 allow ~ members in a group
            //            if ([nameOfMember hasPrefix: @"~"]) continue;

            gbl_numPeopleInCurrentGroup = gbl_numPeopleInCurrentGroup + 1;

            if (  [nameOfMember isEqualToString: argPersonToCompareEveryoneElseWith]) {
                gbl_kingpinIsInGroup = 1;
                continue;
            }

//tn(); NSLog(@"member=%@", member);

            // add this member's CSV to our array of Group CSVs
            //
//  NSLog(@"nameOfMember=%@",nameOfMember);
           NSString *myCSVobj = [myappDelegate getCSVforPersonName: (NSString *) nameOfMember]; 
//  NSLog(@"myCSVobj =%@",myCSVobj );

           if (myCSVobj != nil) {

                if ([argArrayDescription isEqualToString: @"gbl_grp_CSVs"]) {

                    [gbl_grp_CSVs   addObject: myCSVobj];
                }
                if ([argArrayDescription isEqualToString: @"gbl_grp_CSVs_B"]) {

                    [gbl_grp_CSVs_B addObject: myCSVobj];
                }
           }

        }   // loop thru gbl group member array 

    } // do special group   #allpeople



    return gbl_kingpinIsInGroup;  // both regular and #allpeople

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
    return myPerPSV;

} // end of  getPSVforPersonName


- (NSString *) getPSVforGroupName: (NSString *) argGroupName;
{
//  NSLog(@"in getPSVforGroupName!");
    NSString *myGrpPSV;
    myGrpPSV = nil;

    NSString *prefixStr5 = [NSString stringWithFormat: @"%@|", argGroupName];  // notice '|'
//  NSLog(@"prefixStr5 =[%@]",prefixStr5 );
    for (NSString *elt in gbl_arrayGrp) {     // get PSV of arg name
//  NSLog(@"elt=[%@]",elt);
        if ([elt hasPrefix: prefixStr5]) { 
            myGrpPSV = elt;
//  NSLog(@"elt FOUND! =[%@]",elt);
            break;
        }
    }
//  NSLog(@"return myGrpPSV=[%@]",myGrpPSV);
//tn();
    return myGrpPSV;

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
        if ([elt hasPrefix: prefixStr3]) {  
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

} // end of mambSortOnFieldOneForPSVarrayWithDescription


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

//    if ( NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 ) {  
//        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//        if ( UIInterfaceOrientationIsLandscape(interfaceOrientation) ) {
//            myScreenSize = CGSizeMake(myScreenSize.height, myScreenSize.width);
//        }
//    }

    return myScreenSize;
}



// Look in gbl_arrayMem  for all  arg_originalMemberName  and  change it to  arg_newMemberName
//
- (void) mambChangeGRPMEM_memberNameFrom: (NSString *) arg_originalMemberName
                               toNewName: (NSString *) arg_newMemberName
{
tn();
  NSLog(@"in mambChangeMemberNameFrom: toNewName:  ");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    NSArray *psvArray;
    NSString *currGroup;
    NSString *currMember;
    NSMutableString *prefixStr;
    NSInteger        idx, foundIdx, idxToDel;  
    NSMutableArray  *indexNumsToDeleteFrom_gblArrayMem;
    NSMutableArray  *recordsToAddTo_gblarrayMem;

    [indexNumsToDeleteFrom_gblArrayMem  removeAllObjects];
     indexNumsToDeleteFrom_gblArrayMem  = [[NSMutableArray alloc] init];

    [recordsToAddTo_gblarrayMem  removeAllObjects];
     recordsToAddTo_gblarrayMem  = [[NSMutableArray alloc] init];

        
    for (id myMemberRec in gbl_arrayMem)  {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//

//  NSLog(@"myMemberRec =[%@]",myMemberRec );

        psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currGroup  = psvArray[0];
        currMember = psvArray[1];
//  NSLog(@"currGroup  =[%@]",currGroup  );
//  NSLog(@"currMember =[%@]",currMember );

        if ([currMember isEqualToString: arg_originalMemberName ] )
        {
            // here, we're going to change the name in this member record

            // here, get a copy of myMemberRec with the member name changed in it
            //
            NSString *myUpdatedRec = [myappDelegate updateDelimitedString: (NSMutableString *) myMemberRec
                                                              delimitedBy: (NSString *) @"|"
                                                 updateOneBasedElementNum: (NSInteger)  2                 // member name field
                                                           withThisString: (NSString *) arg_newMemberName ];

            // get the array index of this element of the array gbl_arrayMem 
            // so we can delete it  (and then add myUpdatedRec)
            //
            do {
                idx = 0;       foundIdx = -1;
                prefixStr = [NSMutableString stringWithFormat: @"%@|%@|", currGroup, currMember ];

                for (NSString *element in gbl_arrayMem) {
                    if ([element hasPrefix: prefixStr]) {
                        foundIdx = idx;
//  NSLog(@"found element  =[%@]",element);
                        [indexNumsToDeleteFrom_gblArrayMem addObject: [[NSNumber alloc] initWithInteger: foundIdx ]] ;
                        [recordsToAddTo_gblarrayMem        addObject: myUpdatedRec ];
                    }
                    idx = idx + 1;
                }
            } while (FALSE);

        } // change member name

    } // for each groupmember

//  NSLog(@"indexNumsToDeleteFrom_gblArrayMem =[%@]",indexNumsToDeleteFrom_gblArrayMem );
//  NSLog(@"recordsToAddTo_gblarrayMem        =[%@]",recordsToAddTo_gblarrayMem);

    // now delete the old records in gbl_arrayMem
    // by  going backwards from the highest index to delete to the lowest
    // (because indexNumsToDeleteFrom_gblArrayMem is automatically sorted  smallest idx to largest idx)
    //
    for (NSInteger i = indexNumsToDeleteFrom_gblArrayMem.count - 1;  i >= 0;  i--) 
    {
        idxToDel = [indexNumsToDeleteFrom_gblArrayMem[i]  integerValue];
//  NSLog(@"idxToDel      =[%ld]",idxToDel);
//  NSLog(@"(long)idxToDel=[%ld]",(long)idxToDel);

        [gbl_arrayMem removeObjectAtIndex: idxToDel ]; 
//  NSLog(@"deleted index=[%ld]", (long)idxToDel);
    }

    // now add the updated record in gbl_arrayMem
    for (id add_me in recordsToAddTo_gblarrayMem)
    {
        [gbl_arrayMem addObject:  add_me ]; 
//  NSLog(@"added   =[%@]", add_me);
    }

} // mambChangeGRPMEM_memberNameFrom




// Look in gbl_arrayMem  for all  arg_originalGroupName  and  change it to  arg_newGroupName
//
- (void) mambChangeGRPMEM_groupNameFrom: (NSString *) arg_originalGroupName
                              toNewName: (NSString *) arg_newGroupName
{
tn();
  NSLog(@"in mambChangeGRPMEM_groupNameFrom: toNewName:  ");
  NSLog(@"arg_originalGroupName=[%@]",arg_originalGroupName);
  NSLog(@"arg_newGroupName     =[%@]",arg_newGroupName);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    NSArray *psvArray;
    NSString *currGroup;
    NSString *currMember;
    NSMutableString *prefixStr;
    NSInteger        idx, foundIdx, idxToDel;  
    NSMutableArray  *indexNumsToDeleteFrom_gblArrayMem;
    NSMutableArray  *recordsToAddTo_gblarrayMem;

    [indexNumsToDeleteFrom_gblArrayMem  removeAllObjects];
     indexNumsToDeleteFrom_gblArrayMem  = [[NSMutableArray alloc] init];

    [recordsToAddTo_gblarrayMem  removeAllObjects];
     recordsToAddTo_gblarrayMem  = [[NSMutableArray alloc] init];

        
    for (id myMemberRec in gbl_arrayMem)  {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//

//  NSLog(@"myMemberRec =[%@]",myMemberRec );

        psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currGroup  = psvArray[0];
        currMember = psvArray[1];
//  NSLog(@"currGroup  =[%@]",currGroup  );
//  NSLog(@"currMember =[%@]",currMember );

        if ([currGroup isEqualToString: arg_originalGroupName ] )
        {
            // here, we're going to change the group name in this member record

            // here, get a copy of myMemberRec with the Group name changed in it
            //
            NSString *myUpdatedRec = [myappDelegate updateDelimitedString: (NSMutableString *) myMemberRec
                                                              delimitedBy: (NSString *) @"|"
                                                 updateOneBasedElementNum: (NSInteger)  1                 // Group name field
                                                           withThisString: (NSString *) arg_newGroupName ];

            // get the array index of this element of the array gbl_arrayMem 
            // so we can delete it later (and then add myUpdatedRec)
            //
            do {
                idx = 0;       foundIdx = -1;
                prefixStr = [NSMutableString stringWithFormat: @"%@|%@|", currGroup, currMember ];

                for (NSString *element in gbl_arrayMem) {
                    if ([element hasPrefix: prefixStr]) {
                        foundIdx = idx;
  NSLog(@"found deleteable element  =[%@]",element);
                        [indexNumsToDeleteFrom_gblArrayMem addObject: [[NSNumber alloc] initWithInteger: foundIdx ]] ;
                        [recordsToAddTo_gblarrayMem        addObject: myUpdatedRec ];
                    }
                    idx = idx + 1;
                }
            } while (FALSE);

        } // change group name

    } // for each groupmember

  NSLog(@"indexNumsToDeleteFrom_gblArrayMem =[%@]",indexNumsToDeleteFrom_gblArrayMem );
  NSLog(@"recordsToAddTo_gblarrayMem        =[%@]",recordsToAddTo_gblarrayMem);

    // now delete the old records in gbl_arrayMem
    // by  going backwards from the highest index to delete down to the lowest
    // (because indexNumsToDeleteFrom_gblArrayMem is automatically sorted  smallest idx to largest idx)
    //
    for (NSInteger i = indexNumsToDeleteFrom_gblArrayMem.count - 1;  i >= 0;  i--) 
    {
        idxToDel = [indexNumsToDeleteFrom_gblArrayMem[i]  integerValue];
//  NSLog(@"idxToDel      =[%ld]",idxToDel);
//  NSLog(@"(long)idxToDel=[%ld]",(long)idxToDel);

        [gbl_arrayMem removeObjectAtIndex: idxToDel ]; 
  NSLog(@"deleted index=[%ld]", (long)idxToDel);
    }

    // now add the updated record in gbl_arrayMem
    for (id add_me in recordsToAddTo_gblarrayMem)
    {
        [gbl_arrayMem addObject:  add_me ]; 
  NSLog(@"added   =[%@]", add_me);
    }

} // mambChangeGRPMEM_groupNameFrom





// usage:
//
// MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
// [myappDelegate mamb_beginIgnoringInteractionEvents ];
//
// MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
// [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.6 ];    // after arg seconds
//
//
// want to mamb_beginIgnoringInteractionEvents
//    in just before leaving view - viewWillDisappear  NO  not so far
//    just before performSegue                   
//    just before popViewControllerAnimated     
//    just before mambread  file 
//    just before mambwrite file
//    just before saveLastSelectionForEntity
//
// want to mamb_endIgnoringInteractionEvents_after 
//    in first method after view appears  - viewDidAppear     at end of method
//    just after  mambread  file
//    just after  mambwrite file
//    just after  saveLastSelectionForEntity
//
//
- (void) mamb_endIgnoringInteractionEvents_after: (CGFloat) arg_numSecondsDelay  // seconds  ( endIgnoringInteractionEvents )
{
tn();
  NSLog(@"in mamb_endIgnoringInteractionEvents_after:  ");
//  NSLog(@"arg_numSecondsDelay  =[%f]",arg_numSecondsDelay  );
  NSLog(@"BEG  isIgnoringInteractionEvents=[%d]b", [[UIApplication sharedApplication] isIgnoringInteractionEvents] );

    BOOL areIgnoringEvents = [[UIApplication sharedApplication] isIgnoringInteractionEvents];

    if (areIgnoringEvents  ==  YES) 
    {
        int64_t myDelayInSec   = arg_numSecondsDelay * (double)NSEC_PER_SEC;
  NSLog(@"myDelayInSec   =[%lld]",myDelayInSec   );
//        dispatch_time_t my_dispatch_time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);
//        dispatch_after(my_dispatch_time, dispatch_get_main_queue(), ^{     
//            [[UIApplication sharedApplication] endIgnoringInteractionEvents ];
//        });

        // suspend handling of touch-related events
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
  NSLog(@"CHG  in mamb_endIgnoringInteractionEvents_after:  CHANGE to END IGNORING");
    }

  NSLog(@"END  isIgnoringInteractionEvents=[%d]b", [[UIApplication sharedApplication] isIgnoringInteractionEvents] );
tn();

} // mamb_endIgnoringInteractionEvents_after


- (void) mamb_beginIgnoringInteractionEvents 
{
tn();
  NSLog(@"in mamb_beginIgnoringInteractionEvents:  ");
  NSLog(@"BEG  isIgnoringInteractionEvents=[%d]b", [[UIApplication sharedApplication] isIgnoringInteractionEvents] );

    BOOL areIgnoringEvents = [[UIApplication sharedApplication] isIgnoringInteractionEvents];

    if (areIgnoringEvents  ==   NO) 
    {
        // suspend handling of touch-related events
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];     // typically call this before an animation or transitiion.

  NSLog(@"CHG  in mamb_endIgnoringInteractionEvents_after:  CHANGE to BEGIN IGNORING");
    }

  NSLog(@"END  isIgnoringInteractionEvents=[%d]b", [[UIApplication sharedApplication] isIgnoringInteractionEvents] );
tn();
} // mamb_beginIgnoringInteractionEvents 



//  // response header apl
//  mydict =[{
//      "Cache-Control" = "max-age=0";
//      Connection = "keep-alive";
//      "Content-Encoding" = gzip;
//      "Content-Length" = 4721;
//      "Content-Type" = "text/html; charset=UTF-8";
//      Date = "Tue, 23 Feb 2016 16:32:16 GMT";
//      Expires = "Tue, 23 Feb 2016 16:32:16 GMT";
//      Server = Apache;
//      Vary = "Accept-Encoding";
//  }]
//  
//  // response header goo
//      "Cache-Control" = "private, max-age=0";
//      "Content-Encoding" = gzip;
//      "Content-Length" = 41659;
//      "Content-Type" = "text/html; charset=ISO-8859-1";
//      Date = "Tue, 23 Feb 2016 16:32:17 GMT";
//      Expires = "-1";
//      Server = gws;
//      "x-frame-options" = SAMEORIGIN;
//      "x-xss-protection" = "1; mode=block";
//  }]
//
    // this works, but      deprecated -> sendSynchronousRequest
    //  find the actual current date time, found in apl's response header:
    //    NSHTTPURLResponse *myhttpUrlResponse = nil;
    //    NSString *mydateString;
    //
    //    NSMutableURLRequest *myaplrequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"https://apple.com" ]];
    //    [myaplrequest setHTTPMethod: @"GET"];
    //    [NSURLConnection sendSynchronousRequest: myaplrequest returningResponse: &myhttpUrlResponse error: nil];
    //    NSDictionary *mydict = [myhttpUrlResponse allHeaderFields] ; 
    //  NSLog(@"mydict =[%@]",mydict );
    //    mydateString = [[myhttpUrlResponse allHeaderFields] objectForKey: @"Date"]; 
    //  NSLog(@"mydateString =[%@]",mydateString );
    //
    // deprecated -> sendSynchronousRequest


- (void) gcy   //  find the actual current year   from  date found in apl's response header:
{
tn();
trn(" XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ");
trn(" XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ");
  NSLog(@"start gcy   get real date   apple    116, 108, 135");

    //    gbl_cy_apl = @"9999";  inited now to nil  in appdel didFinishLaunchingWithOptions
    //    gbl_cy_goo = @"9999";
  NSLog(@"gbl_cy_currentAllPeople =[%@] at top of gcy",gbl_cy_currentAllPeople );
  NSLog(@"gbl_cm_currentAllPeople =[%@] at top of gcy",gbl_cm_currentAllPeople );
  NSLog(@"gbl_cd_currentAllPeople =[%@] at top of gcy",gbl_cd_currentAllPeople );


// NSLog(@"gbl_cy_goo 1 =[%@]",gbl_cy_goo);

//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
//                                                                 delegate: myappDelegate 
//                                                                 delegate: (NSURLSessionDelegate) self

//                                                                 delegate: self
//                                                                 delegate: (__bridge NSURLSessionDelegate* _Nullable) self
//                                                                 delegate: ( (NSURLSessionDelegate _Nullable) self )
//4347://  gbl_mycityprovcounLabel.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]); // gray   __bridge suggested by XCODE
                                                                 delegate: nil
                                                            delegateQueue: [NSOperationQueue mainQueue]
    ];

  NSLog(@"start  APPLE  NSURLSessionDataTask");
    NSURL *myurl;
    myurl      = [NSURL URLWithString: @"https://apple.com" ];



    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


//    //    http://stackoverflow.com/questions/21198404/nsurlsession-with-nsblockoperation-and-queues
//    // You can create a semaphore with:
//    //
//    dispatch_semaphore_t mySemaphore = dispatch_semaphore_create(0);
//  NSLog(@"mySemaphore =[%@]",mySemaphore );
//




    // Always try to get the latest internet time in case the date has changed
    //
    NSURLSessionDataTask *mydataTask;
    mydataTask = [ defaultSession dataTaskWithURL: myurl    // START of defining   NSURLSessionDataTask 
                                completionHandler: ^(NSData *mydata,  NSURLResponse *myresponse,  NSError *myerror)
        { // start of completionHandler block   COMPLETIONHANDLER
  NSLog(@"  start of completionHandler block    COMPLETIONHANDLER");


            if(myerror == nil)
            { // if(myerror == nil)
tn();            
trn(" xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
trn(" xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
  NSLog(@"  doing completionHandler got data branch   doing completionHandler   error == nil");

                // cast response into form having allHeaderFields method
                NSHTTPURLResponse *myNSURLResponse_as_NSHTTPURLResponse = (NSHTTPURLResponse*) myresponse;

                // get allHeaderFields dictionary
                NSDictionary *mydict         = [myNSURLResponse_as_NSHTTPURLResponse  allHeaderFields] ; 

                // get date from allHeaderFields dictionary
                NSString *mydatestr          = [mydict objectForKey: @"Date"];  

 NSLog(@"mydict APPLE =[%@]",mydict );
 NSLog(@"mydatestr    =[%@]",mydatestr);

                // verify year 
                NSInteger yearIsValid;
                yearIsValid = 0;
                NSArray *myarr = [mydatestr componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet ]];
                for (NSString *fld in myarr) {
                    if ( [fld length] == 4  &&  [fld hasPrefix: @"20" ]) {
                        NSString *myYYstr  = [fld  substringWithRange: NSMakeRange(2,2) ];
                        unichar c = [myYYstr characterAtIndex: 0];
                        if (c >= '0' && c <= '9') {            // check that char 1 and 2 are numeric
                            c = [myYYstr characterAtIndex: 1];

                            if (c >= '0' && c <= '9') {
                                yearIsValid = 1;
                                gbl_cy_apl  = fld;          // !!!!  here fld is valid year  "20nn"
                            }
                        }
  NSLog(@"gbl_cy_apl 2 =[%@]",gbl_cy_apl);
                        break; 
                    }
                }
                if (yearIsValid == 1) {   //  Date = "Tue, 23 Feb 2016 16:32:17 GMT";

                    gbl_cd_apl = [NSString stringWithFormat: @"%02d", [myarr[1] intValue ] ];  // "23"

                    if ([myarr[2] isEqualToString: @"Jan"]) gbl_cm_apl = @"01";
                    if ([myarr[2] isEqualToString: @"Feb"]) gbl_cm_apl = @"02";
                    if ([myarr[2] isEqualToString: @"Mar"]) gbl_cm_apl = @"03";
                    if ([myarr[2] isEqualToString: @"Apr"]) gbl_cm_apl = @"04";
                    if ([myarr[2] isEqualToString: @"May"]) gbl_cm_apl = @"05";
                    if ([myarr[2] isEqualToString: @"Jun"]) gbl_cm_apl = @"06";
                    if ([myarr[2] isEqualToString: @"Jul"]) gbl_cm_apl = @"07";
                    if ([myarr[2] isEqualToString: @"Aug"]) gbl_cm_apl = @"08";
                    if ([myarr[2] isEqualToString: @"Sep"]) gbl_cm_apl = @"09";
                    if ([myarr[2] isEqualToString: @"Oct"]) gbl_cm_apl = @"10";
                    if ([myarr[2] isEqualToString: @"Nov"]) gbl_cm_apl = @"11";
                    if ([myarr[2] isEqualToString: @"Dec"]) gbl_cm_apl = @"12";
  NSLog(@"gbl_cm_apl 2 =[%@]",gbl_cm_apl);
  NSLog(@"gbl_cd_apl 2 =[%@]",gbl_cd_apl);
                }

                // unused data    NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                //                NSLog(@"Data = %@",text);

                // can do notification here that you are finished

                // if the fresh from the internet  y OR m OR d  is different from all people version,
                // update all people version with  the new data
                //

  NSLog(@"gbl_cy_apl  in gcy before check diffs             =[%@]",gbl_cy_apl);
  NSLog(@"gbl_cm_apl  in gcy before check diffs             =[%@]",gbl_cm_apl);
  NSLog(@"gbl_cd_apl  in gcy before check diffs             =[%@]",gbl_cd_apl);
  NSLog(@"gbl_cy_currentAllPeople in gcy before check diffs =[%@]",gbl_cy_currentAllPeople );
  NSLog(@"gbl_cm_currentAllPeople in gcy before check diffs =[%@]",gbl_cm_currentAllPeople );
  NSLog(@"gbl_cd_currentAllPeople in gcy before check diffs =[%@]",gbl_cd_currentAllPeople );


                NSInteger do_update;
                do_update = 0;
                if ( ! [gbl_cy_apl isEqualToString: gbl_cy_currentAllPeople ]) do_update = 1;
                if ( ! [gbl_cm_apl isEqualToString: gbl_cm_currentAllPeople ]) do_update = 1;
                if ( ! [gbl_cd_apl isEqualToString: gbl_cd_currentAllPeople ]) do_update = 1;
  NSLog(@"do_update =[%ld]",(long)do_update );
                if (do_update == 1) {
    
                    NSString  *PSVthatWasFound;
                    NSInteger  arrayIdx;
                    NSString  *myStrToUpdate;
                    NSString  *myupdatedStr1, *myupdatedStr2, *myupdatedStr3; 

                    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

                    NSString *prefixStr7 = [NSString stringWithFormat: @"%@|",gbl_nameOfGrpHavingAllPeopleIhaveAdded ];  // notice '|'
  NSLog(@"prefixStr7            =%@",prefixStr7 );

                    // get the PSV of  AllPeople~ in gbl_arrayGrp
                    PSVthatWasFound = nil;
                    arrayIdx = 0;
                    for (NSString *element in gbl_arrayGrp) {
  NSLog(@"element =[%@]",element );

                        if ([element hasPrefix: prefixStr7]) {
                            PSVthatWasFound = element;
                            break;
                        }
                        arrayIdx = arrayIdx + 1;
                    }
  NSLog(@"PSVthatWasFound       =%@",PSVthatWasFound );

                    if (PSVthatWasFound != nil) {

                        myStrToUpdate = PSVthatWasFound;
  NSLog(@"myStrToUpdate         =%@",myStrToUpdate );
  NSLog(@"arrayIdx              =%ld",(long)arrayIdx);
  NSLog(@"gbl1arrayGrp[arrayIdx]=%@",gbl_arrayGrp[arrayIdx]);
tn();
  NSLog(@"gbl_cy_apl=[%@]",gbl_cy_apl);
                        myupdatedStr1 = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                                 delimitedBy: (NSString *) @"|"
                                                    updateOneBasedElementNum: (NSInteger)  5                     // current year
                                                              withThisString: (NSString *) gbl_cy_apl ];
  NSLog(@"myupdatedStr1          =%@",myupdatedStr1 );

tn();
  NSLog(@"gbl_cm_apl=[%@]",gbl_cm_apl);
                        myupdatedStr2 = [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr1
                                                                 delimitedBy: (NSString *) @"|"
                                                    updateOneBasedElementNum: (NSInteger)  6                     // current month
                                                              withThisString: (NSString *) gbl_cm_apl ];
  NSLog(@"myupdatedStr2          =%@",myupdatedStr2 );

tn();
  NSLog(@"gbl_cd_apl=[%@]",gbl_cd_apl);
                        myupdatedStr3 = [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr2
                                                                 delimitedBy: (NSString *) @"|"
                                                    updateOneBasedElementNum: (NSInteger)  7                     // current year
                                                              withThisString: (NSString *) gbl_cd_apl ];
  NSLog(@"myupdatedStr3          =%@",myupdatedStr3 );
tn();

                        // update gbls for current date
                        //
                        gbl_cy_currentAllPeople = gbl_cy_apl;
                        gbl_cm_currentAllPeople = gbl_cm_apl;
                        gbl_cd_currentAllPeople = gbl_cd_apl;

  NSLog(@"gbl_cy_currentAllPeople =[%@] at end of  found allpeople rec to update",gbl_cy_currentAllPeople );
  NSLog(@"gbl_cm_currentAllPeople =[%@]   at end of  found allpeople rec to update",gbl_cm_currentAllPeople );
  NSLog(@"gbl_cd_currentAllPeople =[%@]   at end of  found allpeople rec to update",gbl_cd_currentAllPeople );

                        // update #allpeople record containing new data  in memory array gbl_arrayGrp 
                        //
  NSLog(@"gbl4arrayGrp[arrayIdx]=%@",gbl_arrayGrp[arrayIdx]);
                        [gbl_arrayGrp replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr3];  // <<<<<<<<<<<<<<<<---------
  NSLog(@"gbl2arrayGrp[arrayIdx]=%@",gbl_arrayGrp[arrayIdx]);

                        // write updated gbl_arrayGrp to file
                        //
  NSLog(@"write updated gbl_arrayGrp to file");
  NSLog(@"gbl_arrayGrp=[%@]",gbl_arrayGrp);
                        [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"group"]; // write new array data to file
  NSLog(@"write updated gbl_arrayGrp to file");


                    } // if (PSVthatWasFound != nil)    update allpeople rec in file

                } // do_update == 1  because there is a difference between allpeople rec and latest internet  y, m, d

 
                // here we got a date, so update globals  in case the values are new
                //
                //  This is the  GOLD CURRENT DATE  for the whole app   (stored in #allpeople grp record)
                //
                gbl_currentYearInt  = [gbl_cy_currentAllPeople intValue];
                gbl_currentMonthInt = [gbl_cm_currentAllPeople intValue];
                gbl_currentDayInt   = [gbl_cd_currentAllPeople intValue];



            } // if(myerror == nil)   dataTaskWithURL  error arg is nil       mydataTask =  defaultSession dataTaskWithURL: myurl
            else
            { // if(myerror != nil)   dataTaskWithURL  error arg is not nil   mydataTask =  defaultSession dataTaskWithURL: myurl

                 // 
                 // got an error, so keep using whatever is in #allpeople record
                 // 

  NSLog(@"got an error  in gcy  dataTaskWithURL  apl");
            } // year is NOT valid

  NSLog(@"gbl_cy_currentAllPeople =[%@] at end of  completionHandler",gbl_cy_currentAllPeople );
  NSLog(@"gbl_cm_currentAllPeople =[%@] at end of  completionHandler",gbl_cm_currentAllPeople );
  NSLog(@"gbl_cd_currentAllPeople =[%@] at end of  completionHandler",gbl_cd_currentAllPeople );
  NSLog(@"gbl_currentYearInt      =[%ld]",(long)gbl_currentYearInt  );
  NSLog(@"gbl_currentMonthInt     =[%ld]",(long)gbl_currentMonthInt  );
  NSLog(@"gbl_currentDayInt       =[%ld]",(long)gbl_currentDayInt  );

trn(" xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  gcy  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
trn(" xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  gcy  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ");
tn();

//            // You can then have the completion block of the asynchronous process signal the semaphore with:
//            //
//  NSLog(@"SEMAPHORE dispatched here");
//            dispatch_semaphore_signal(mySemaphore);
//



        } // end of completionHandler COMPLETIONHANDLER



//<.>
//[queue addOperationWithBlock:^{
//
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//    NSURLSession *session = [NSURLSession sharedSession]; // or create your own session with your own NSURLSessionConfiguration
//    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (data) {
//            // do whatever you want with the data here
//        } else {
//            NSLog(@"error = %@", error);
//        }
//
//        dispatch_semaphore_signal(semaphore);
//    }];
//    [task resume];
//
//    // but have the thread wait until the task is done
//
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//    // now carry on with other stuff contingent upon what you did above
//]);
//
//<.>
//


    ]; // end of defining   NSURLSessionDataTask 



  NSLog(@"sending off dataTask apl");
trn(" XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ");
  tn();
    [mydataTask resume];            // sending off dataTask  to execute asynchronously
  NSLog(@"sent    off dataTask apl");


//  NSLog(@"before semaphore wait");
//    // but have the thread wait until the task is done
//    //
////    dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
//        //
//        //    int64_t myDelayInSec   = 0.38 * (double)NSEC_PER_SEC;
//        //    dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);
//        //
//        //    dispatch_after(mytime, dispatch_get_main_queue(), ^{       // do after delay of mytime    dispatch 
//        //
////        int64_t myTimeoutInSec   = 3.0 * (double)NSEC_PER_SEC;
//        int64_t myTimeoutInSec   = 1.0 * (double)NSEC_PER_SEC;
//    dispatch_semaphore_wait(mySemaphore, myTimeoutInSec   );
//    //
//    // now carry on with other stuff contingent upon what you did above
//  NSLog(@"after semaphore wait");
//


  NSLog(@"dataTask apl  FINISHED");
  NSLog(@"gbl_cy_currentAllPeople =[%@] at end of  completionHandler",gbl_cy_currentAllPeople );
  NSLog(@"gbl_cm_currentAllPeople =[%@] at end of  completionHandler",gbl_cm_currentAllPeople );
  NSLog(@"gbl_cd_currentAllPeople =[%@] at end of  completionHandler",gbl_cd_currentAllPeople );


    // 20160227  do only apl , not goo as well
    //
    //    myurl = [NSURL URLWithString: @"https://google.com" ];
    //    mydataTask = [ defaultSession dataTaskWithURL: myurl
    //                                completionHandler: ^(NSData *mydata,  NSURLResponse *myresponse,  NSError *myerror)
    //        { // start of completionHandler
    //            if (myerror == nil)
    //            {
    //                // cast response into form having allHeaderFields
    //                NSHTTPURLResponse *myNSURLResponse_as_NSHTTPURLResponse = (NSHTTPURLResponse*) myresponse;
    //                // get allHeaderFields dictionary
    //                NSDictionary *mydict         = [myNSURLResponse_as_NSHTTPURLResponse  allHeaderFields] ; 
    //                // get date from allHeaderFields dictionary
    //                NSString *mydatestr          = [mydict objectForKey: @"Date"];  
    //
    //                // verify year 
    //                NSInteger yearIsValid;
    //                yearIsValid = 0;
    //                NSArray *myarr = [mydatestr componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet ]];
    //                for (NSString *fld in myarr) {
    //                    if ( [fld length] == 4  &&  [fld hasPrefix: @"20" ]) {
    //                        NSString *myYYstr  = [fld  substringWithRange: NSMakeRange(2,2) ];
    //                        unichar c = [myYYstr characterAtIndex: 0];
    //                        if (c >= '0' && c <= '9') {            // check that char 1 and 2 are numeric
    //                            c = [myYYstr characterAtIndex: 1];
    //
    //                            if (c >= '0' && c <= '9') {
    //                                yearIsValid = 1;
    //                                gbl_cy_goo = fld;          // !!!!  here fld is valid year  "20nn"
    //                            }
    //                        }
    // NSLog(@"gbl_cy_goo 2 =[%@]",gbl_cy_goo);
    //                        break; 
    //                    }
    //                }
    //
    //                if (yearIsValid == 1) {   //  Date = "Tue, 23 Feb 2016 16:32:17 GMT";
    //                    gbl_cd_goo = [NSString stringWithFormat: @"%02d", [myarr[1] intValue ] ];  // "23"
    //
    //                    if ([myarr[2] isEqualToString: @"Jan"]) gbl_cm_goo = @"01";
    //                    if ([myarr[2] isEqualToString: @"Feb"]) gbl_cm_goo = @"02";
    //                    if ([myarr[2] isEqualToString: @"Mar"]) gbl_cm_goo = @"03";
    //                    if ([myarr[2] isEqualToString: @"Apr"]) gbl_cm_goo = @"04";
    //                    if ([myarr[2] isEqualToString: @"May"]) gbl_cm_goo = @"05";
    //                    if ([myarr[2] isEqualToString: @"Jun"]) gbl_cm_goo = @"06";
    //                    if ([myarr[2] isEqualToString: @"Jul"]) gbl_cm_goo = @"07";
    //                    if ([myarr[2] isEqualToString: @"Aug"]) gbl_cm_goo = @"08";
    //                    if ([myarr[2] isEqualToString: @"Sep"]) gbl_cm_goo = @"09";
    //                    if ([myarr[2] isEqualToString: @"Oct"]) gbl_cm_goo = @"10";
    //                    if ([myarr[2] isEqualToString: @"Nov"]) gbl_cm_goo = @"11";
    //                    if ([myarr[2] isEqualToString: @"Dec"]) gbl_cm_goo = @"12";
    // NSLog(@"gbl_cm_goo 2 =[%@]",gbl_cm_goo);
    // NSLog(@"gbl_cd_goo 2 =[%@]",gbl_cd_goo);
    //                }
    //
    // NSLog(@"gbl_cy_goo 3 =[%@]",gbl_cy_goo);
    //
    //                // can do notification here that you are finished
    //            } else {
    //  NSLog(@"got an error  dataTaskWithURL  goo");
    //            }
    //        } // end of completionHandler
    //    ]; // end of NSURLSessionDataTask 
    //
    //    [mydataTask resume];            // sending off dataTask  to execute asynchronously
    // NSLog(@"gbl_cy_goo 4 =[%@]",gbl_cy_goo);
    //  NSLog(@"sending off dataTask goo");
    //


} // end of  gcy


- (void) get_gbl_numMembersInCurrentGroup  // populates gbl_numMembersInCurrentGroup, gbl_namesInCurrentGroup  using  gbl_lastSelectedGroup
{
  NSLog(@"in  get_gbl_numMembersInCurrentGroup !");

   gbl_numMembersInCurrentGroup = 0;                             // init before setting
   [gbl_namesInCurrentGroup  removeAllObjects];                  // init before setting
    gbl_namesInCurrentGroup  = [[NSMutableArray alloc] init];    // init before setting


    // determine gbl_numMembersInCurrentGroup 
    //
    if ([gbl_lastSelectedGroup isEqualToString: gbl_nameOfGrpHavingAllPeopleIhaveAdded ] ) {
        // "#allpeople"
        if ([gbl_ExampleData_show isEqualToString: @"yes"] ) 
        {
           gbl_numMembersInCurrentGroup = gbl_arrayPer.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           gbl_numMembersInCurrentGroup = gbl_arrayPer.count - gbl_ExampleData_count_per ;
        }

    } else {
        // regular group
        NSString *currGroupMemberRec;
        NSString *currGroupName;
        NSString *currMemberName;
        for (int i=0;  i < gbl_arrayMem.count;  i++) {

            currGroupMemberRec  = gbl_arrayMem[i];
            currGroupName       = [currGroupMemberRec componentsSeparatedByString: @"|"][0]; // get fld#1 (grpname) - arr is 0-based 
            currMemberName      = [currGroupMemberRec componentsSeparatedByString: @"|"][1]; // get fld#2 (mbrname) - arr is 0-based 

            if ( [currGroupName isEqualToString: gbl_lastSelectedGroup ] ) {
//  NSLog(@"currGroupMemberRec  =[%@]",currGroupMemberRec  );
                gbl_numMembersInCurrentGroup = gbl_numMembersInCurrentGroup + 1;

               [gbl_namesInCurrentGroup  addObject: currMemberName ];          //  Person name for pick
            }
        }
    }   // determine gbl_numMembersInCurrentGroup 
  NSLog(@"gbl_numMembersInCurrentGroup =[%ld]", (long)gbl_numMembersInCurrentGroup );
  NSLog(@"gbl_namesInCurrentGroup  =[%@]",gbl_namesInCurrentGroup  );

} // end of   get_gbl_numMembersInCurrentGroup 



- (void) doBackupAll //  find the actual current year   from  date found in apl's response header:
{
  NSLog(@"in doBackupAll");


} // end of doBackupAll




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


// this does not work  app hangs in home (no data in cells)  cpu and mem go nuts  BUT it did work as lcl_ global
//  NSLog(@"10!");
//     
//
//
//    // UILabel for the disclosure indicator, ">",  for tappable cells
//    //
////    NSString *myDisclosureIndicatorBGcolorName; 
//    NSString *myDisclosureIndicatorText; 
//    UIColor  *colorOfGroupReportArrow; 
//    UIFont   *myDisclosureIndicatorFont; 
//
//    myDisclosureIndicatorText = @">"; 
////            colorOfGroupReportArrow   = [UIColor blackColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor darkGrayColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor grayColor];                 // blue background
//    colorOfGroupReportArrow   = [UIColor lightGrayColor];                 // blue background
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 24.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 20.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     boldSystemFontOfSize: 24.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     boldSystemFontOfSize: 20.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"Menlo-bold" size:  24.0]; // no good
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"ArialRoundedMTBold" size:  24.0];
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"HelveticaNeue-ThinItalic" size:  24.0];
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"IowanOldStyle-Bold" size:  24.0];
//    myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0]; // good
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Wide" size:  24.0]; // bad
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"SanFranciscoDisplay-Thin" size:  24.0]; 
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"SanFranciscoRounded-Bold" size:  16.0]; 
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"TimesNewRomanPS-BoldMT" size:  24.0]; // good
////              myDisclosureIndicatorFont = [UIFont fontWithName: @"Superclarendon-Bold" size:  24.0]; // good
////              myDisclosureIndicatorFont = [UIFont fontWithName: @"SnellRoundhand-Bold" size:  24.0]; // good
////              myDisclosureIndicatorFont = [UIFont fontWithName: @"AvenirNextCondensed-Heavy" size:  24.0]; // good
//
//  NSLog(@"11!");
//
//
//
//    NSAttributedString *myNewCellAttributedText3 = [
//        [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
//                                       attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
//                                                       NSForegroundColorAttributeName: colorOfGroupReportArrow                }
//    ];
//  NSLog(@"12!");
//
//    gbl_disclosureIndicatorLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
//  NSLog(@"13!");
//    gbl_disclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
//  NSLog(@"14!");
//    gbl_disclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 
//  NSLog(@"15!");
//    //
//    // end of  UILabel for the disclosure indicator, ">",  for tappable cells
//
//
//
//


//    NSHTTPURLResponse *myhttpUrlResponse = nil;
//    NSString *mydateString;
//      NSLog(@"start get real date   GOOGLE   300ms ,300, 300");
//    NSMutableURLRequest *mygoorequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"https://google.com"]];
//    [mygoorequest setHTTPMethod: @"GET"];
//    [NSURLConnection sendSynchronousRequest: mygoorequest returningResponse: &myhttpUrlResponse error: nil];
//    NSDictionary *mydict = [myhttpUrlResponse allHeaderFields] ; 
//    mydateString = [[myhttpUrlResponse allHeaderFields] objectForKey: @"Date"];
//  NSLog(@"mydict =[%@]",mydict );
//  NSLog(@"mydateString GOOGLE =[%@]",mydateString );

