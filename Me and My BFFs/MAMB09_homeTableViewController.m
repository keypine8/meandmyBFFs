//
//  MAMB09_homeTableViewController.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    code here
//});
//
//When you tap a cell, the willSelectRowAtIndexPath and didSelectRowAtIndexPath are called - supplying you the currently selected NSIndexPath
//– tableView:willSelectRowAtIndexPath:
//– tableView:didSelectRowAtIndexPath:
//– tableView:willDeselectRowAtIndexPath:
//– tableView:didDeselectRowAtIndexPath:

// #import "mamblib.h"
#import "MAMB09_homeTableViewController.h"
#import "MAMB09_selectReportsTableViewController.h"
#import "rkdebug_externs.h"
#import "MAMB09AppDelegate.h"   // to get globals
#import "mamblib.h"

//#include "Darwin.POSIX.netinet.in.h"
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

/* 
 * udpclient.c - A simple UDP client
 * usage: udpclient <host> <port>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
//#include <sys/types.h>
//#include <sys/socket.h>
#include <netinet/in.h>
//#include <netdb.h> 

#define BUFSIZE 1024



@interface MAMB09_homeTableViewController ()

//@property (strong, nonatomic)  UILabel *lcl_disclosureIndicatorLabel;  // set in viewDidLoad

// forward declarations
- (void) readSockData;


@end

//UITapGestureRecognizer *doubleTapGesture;   // used gbl_



@implementation MAMB09_homeTableViewController


CFSocketRef cfSocket;
int  newsock;

//@synthesize mambyObjectList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


//No this is not a bug. The behavior is explained here: developer.apple.com/library/ios/#featuredarticles/…
// "When UIKit receives an orientation notification, it uses the UIApplication object and the root view controller
// to determine whether the new orientation is allowed. If both objects agree that the new orientation is supported,
// then the user interface is rotated to the new orientation. Otherwise the device orientation is ignored."
// –  phix23 Oct 15 '12 at 12:19
//The same documentation also mentions the following, so I'm with @TheLearner about being a bug:
// "When a view controller is presented over the root view controller, the system behavior changes in two ways.
// First, the presented view controller is used instead of the root view controller
// when determining whether an orientation is supported"
// –  Oded Ben Dov Feb 19 '13 at 15:52 
//  	 	
//Personally I think this should fall on each view controller to be able to override this method
// as they are the View Controller.
// And by default, an app uses the orientations supported in the Target Summary
// –  Adam Carter Mar 27 '13 at 13:39
//
// - (NSUInteger)supportedInterfaceOrientations
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  NSLog(@"in HOME supportedInterfaceOrientations !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskPortrait;

}
- (BOOL)shouldAutorotate {
  NSLog(@"in HOME shouldAutorotate !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return NO;  // means do not call supportedInterfaceOrientations
}


//- (void) processDoubleTap
- (void) processDoubleTap:(UITapGestureRecognizer *)sender
{
  NSLog(@"GOT A DOUBLE tap");
  [self putHighlightOnCorrectRow ];
}





- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();

tn();
  NSLog(@"in viewDidLoad  in HOME  HOME  ");





//
// [ self shouldAutorotate ];
// [ self supportedInterfaceOrientations ];
//
//    gbl_justAddedPersonRecord = 0;  // do not reload home array
//    gbl_justAddedGroupRecord  = 0;  // do not reload home array
//
//    self.tableView.allowsSelectionDuringEditing = YES;
//
//    [self.navigationController.navigationBar setTranslucent: NO];
////     self.navigationController.navigationBar.barTintColor = [UIColor blueColor] ;
//     self.navigationController.navigationBar.barTintColor = gbl_color_cAplTop;
//
//




    // try to reduce load time of first cal yr report   (uiwebview)
    // this WORKED!
    //    this maybe loads  and initializes javascript ahead of first uiwebview report
tn();
  NSLog(@"BEG  use javascript to  grab document.title - to try to reduce load time of first cal yr report   ");

    UIWebView *tmpwebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
    NSString *xtitle   = [tmpwebview stringByEvaluatingJavaScriptFromString:@"document.title"];  
  NSLog(@"END  use javascript to  grab document.title - to try to reduce load time of first cal yr report   ");
  NSLog(@"xtitle   =[%@]",xtitle   );
    //
    // this WORKED!




    // doStuffOnEnteringForeground sets these 3 from lastEntityStr
    //
    //   gbl_fromHomeCurrentEntity        
    //   gbl_fromHomeCurrentSelectionType
    //   gbl_lastSelectionType          
    //
//    gbl_fromHomeCurrentEntity        = @"person";  // set default on startup
//    gbl_fromHomeCurrentSelectionType = @"person";  // set default on startup
//    gbl_lastSelectionType            = @"person";  // set default on startup

    

    gbl_currentMenuPlusReportCode = @"HOME";  // also set in viewWillAppear for coming back to HOME from other places (INFO ptr)
  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );


  NSLog(@"EDIT BUTTON 1   gbl_homeUseMODE = @regular mode; ");
  NSLog(@"gbl_homeUseMODE 1   =[%@]",gbl_homeUseMODE );

    gbl_homeUseMODE = @"regular mode";  // determines home mode  "edit mode" or "regular mode"
  NSLog(@"gbl_homeUseMODE 2   =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
    // gbl_homeEditingState;  // if gbl_homeUseMODE = "edit mode" then either "add" or "view or change"   for tapped person or group

    gbl_home_cell_AccessoryType        = UITableViewCellAccessoryDisclosureIndicator; // home mode regular with tap giving report list
    gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryNone;                // home mode regular with tap giving report list

    gbl_currentMenuPrefixFromHome    = @"homp";    // set default on startup



        //// start DO STUFF HERE


    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    

   
//
//        // UILabel for the disclosure indicator, ">",  for tappable cells
//        //
//        // set this up here since its used in cellForRow   over and over
//        //
////            NSString *myDisclosureIndicatorBGcolorName; 
////            NSString *myDisclosureIndicatorText; 
////            UIColor  *colorOfGroupReportArrow; 
////            UIFont   *myDisclosureIndicatorFont; 
//
////            colorOfGroupReportArrow   = [UIColor lightGrayColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor grayColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor redColor];                 // blue background
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0]; // good
//
//tn();trn("arrow = red !");
//            NSAttributedString *myNewCellAttributedText3 = [
//                [NSAttributedString alloc] initWithString: @">"  
//                                               attributes: @{
//                        NSFontAttributeName :  [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0] ,  
//                        NSForegroundColorAttributeName: [UIColor redColor ]  
//                    }
//            ];
//
//            _lcl_disclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
//            _lcl_disclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
//            _lcl_disclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 
////            lcl_disclosureIndicatorLabel.backgroundColor = [UIColor redColor];      
//        //
//        // end of  UILabel for the disclosure indicator, ">",  for tappable cells
//





    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // 

//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; // ADD EDIT BUTTON

    // set up the two nav bar arrays, one with + button for add a record, one without
    //
    if (gbl_haveSetUpHomeNavButtons == 0) {
nbn(100);
        gbl_haveSetUpHomeNavButtons = 1;

        UIBarButtonItem *navAddButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                                    target: self
                                                                                    action: @selector(navAddButtonAction:)];
//        navAddButton.tintColor = [UIColor blackColor];   // colors text

        self.navigationItem.leftBarButtonItems  = [self.navigationItem.leftBarButtonItems  arrayByAddingObject: navAddButton]; // ADD ADD BUTTON
        gbl_homeLeftItemsWithAddButton = [NSMutableArray arrayWithArray: self.navigationItem.leftBarButtonItems ];



//        gbl_homeLeftItemsWithNoAddButton = [NSMutableArray arrayWithArray: gbl_homeLeftItemsWithAddButton ]; // make COPY
//        [ gbl_homeLeftItemsWithNoAddButton removeObjectAtIndex: 1 ];                 // remove add button from array copy


        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

            // try with always add button
            // self.navigationItem.leftBarButtonItems  = gbl_homeLeftItemsWithNoAddButton;
            self.navigationItem.leftBarButtonItems     = gbl_homeLeftItemsWithAddButton;

//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
            UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];  // 3rd arg is horizontal length
//        spaceView.backgroundColor = [UIColor redColor];  // make visible for test
            UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView: spaceView];

  NSLog(@"EDIT BUTTON 1   set title  edit tab");
//            self.editButtonItem.title = @"Ed2t\t";  // pretty good
            self.editButtonItem.title = @"Edit";  // ok with no tab

            UIView *tmpView = (UIView *)[self.editButtonItem performSelector:@selector(view)];

//            self.editButtonItem.view.layer.backgroundColor = [[UIColor clearColor] CGColor];
            tmpView.layer.backgroundColor = [[UIColor clearColor] CGColor];



        // [myButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
//        [self.editButtonItem.titleLabel setTextAlignment: NSTextAlignmentCenter];

              // try this:
              //
              // barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 14.0f]; // right adj
//           UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 16.0f]; // too big
//           UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 15.0f]; // right adj
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 18.0f];
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 14.0f];
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 16.0f]; // right adjust
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 17.0f]; // too  big
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica-Light" size: 17.0f]; // too big
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica-Light" size: 16.0f]; // right adjust
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica" size: 16.0f];  // right adj
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica" size: 18.0f];  // too big
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica" size: 17.0f];  // too big
//            [self.editButtonItem setTitleTextAttributes:
//                                                         [NSDictionary dictionaryWithObjectsAndKeys:
//                                                             gbl_colorEditingBG, NSBackgroundColorAttributeName,
//                                                                          font1, NSFontAttributeName,
//                                                             nil
//                                                         ]
//                                               forState: UIControlStateNormal
//            ];


            // [[UIBarButtonItem appearance] setTitlePositionAdjustment: UIOffsetMake(0.0f, 5.0f)  forBarMetrics: UIBarMetricsDefault];
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-6.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault];
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-16.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // just right
            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-16.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
            

//            self.editButtonItem.layer.borderWidth = 1.0f;
//            self.editButtonItem.layer.borderColor = [UIColor lightGrayColor].CGColor;
////            self.editButtonItem.layer.cornerRadius = 5.0f;
//            self.editButtonItem.layer.cornerRadius = 8.0f;

//<.>
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setFrame:CGRectMake(0, 0, 50, 40)];
//            [button setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
//            button.layer.borderWidth = 1.0f;
//            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            button.layer.cornerRadius = 5.0f;
//
//            button.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//            button.layer.shadowRadius = 4.0f;
//            button.layer.shadowOpacity = .9;
//            button.layer.shadowOffset = CGSizeZero;
//            button.layer.masksToBounds = NO;
//
//
//            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//
//            self.navigationItem.leftBarButtonItem = leftItem;
//<.>






//        self.navigationItem.rightBarButtonItems =
//            [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];



          self.navigationItem.rightBarButtonItems =   // "editButtonItem" is magic Apple functionality
              [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; //editButtonItem=ADD apple-provided EDIT BUTTON



//  [[UINavigationBar appearance] setTranslucent: NO];
//  [[UINavigationBar appearance] setTintColor: [UIColor redColor] ];

//  [[UINavigationBar appearance]  setTranslucent: NO];
//  [[UINavigationBar appearance] setBarTintColor: [UIColor redColor] ];
//  [[UINavigationBar appearance] setBarTintColor: [UIColor brownColor] ];


//        self.navigationItem.rightBarButtonItems =
//            [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];

//        self.editButtonItem.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
//self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;



//        self.editButtonItem.backgroundColor = [UIColor yellowColor];
//       [self.editButtonItem setBackgroundColor:  [UIColor yellowColor] ];
//        self.editButtonItem.tintColor = [UIColor yellowColor];  // is textColor

        //  - (void)setBackgroundImage:(UIImage *)backgroundImage
        //                    forState:(UIControlState)state
        //                  barMetrics:(UIBarMetrics)barMetrics
//        self.editButtonItem.color = [UIColor yellowColor];  // is textColor

//                [self.navigationController.navigationBar setBackgroundImage: [UIImage new]       // 1. of 2
//                                                             forBarPosition: UIBarPositionAny
//                                                                 barMetrics: UIBarMetricsDefault];
//                //
//                [self.navigationController.navigationBar setShadowImage: [UIImage new]];   
//                //
//                self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];  // 2. of 2

        //   UIControlStateNormal               = 0,
        //   UIControlStateHighlighted          = 1 << 0,
        //   UIControlStateDisabled             = 1 << 1,
        //   UIControlStateSelected             = 1 << 2,
        //   UIControlStateFocused              = 1 << 3,
        //   UIControlStateApplication          = 0x00FF0000,
        //   UIControlStateReserved             = 0xFF000000 

//        UIImage *myYellowBG = [UIImage  imageNamed: @"bg_yellow_1x1b.png" 
//                                          inBundle: nil
//                     compatibleWithTraitCollection: nil
//        ];

//        [self.editButtonItem  setBackgroundImage: gbl_YellowBG ] ;  // view startup default color
//        [ [self.editButtonItem appearance]  setBackgroundImage: gbl_YellowBG ] ;  // view startup default color
//          self.editButtonItem.backgroundImage = gbl_YellowBG  ;  // view startup default color


  NSLog(@"EDIT BUTTON 1   set yellow          ");
//            [self.editButtonItem setBackgroundImage: gbl_YellowBG          // edit mode bg color for button
            [self.editButtonItem setBackgroundImage: gbl_yellowEdit          // edit mode bg color for button
                                           forState: UIControlStateNormal  
                                         barMetrics: UIBarMetricsDefault
            ];

//            self.navigationItem.leftBarButtonItems = gbl_homeLeftItemsWithAddButton;


        }); // end of  dispatch_async(dispatch_get_main_queue()

    } // end of   set up the two nav bar arrays, one with + button for add a record, one without






//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems arrayByAddingObject: addButton ];
//        });


//    // info button is there already so add Edit button with  arrayByAddingObject:
//    // 
//    UIBarButtonItem *myEditButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit
//                                                                                  target: self      
//                                                                                  action: @selector(pressedEditButtonAction:)  ];
//    //
//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myEditButton];
//



    [[NSNotificationCenter defaultCenter] addObserver: self  // run method doStuffOnEnteringForeground()  when entering Foreground
                                             selector: @selector(doStuffOnEnteringForeground)
                                                 name: UIApplicationWillEnterForegroundNotification
                                               object: nil  ];


    BOOL haveGrp, havePer, haveMem, haveGrpRem, havePerRem;
    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
                                                                                   //BOOL ret01;




    [myappDelegate gcy ];  // get real current year for calendar year cap (= curr yr + 1)
  NSLog(@"gbl_cy_apl 1 =[%@]",gbl_cy_apl );
  NSLog(@"gbl_cy_goo 1 =[%@]",gbl_cy_goo );




    NSError *err01;


//        // remove all "*.txt" files from TMP directory before creating new one
//        //
//        NSArray *docFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: gbl_appDocDirStr error:NULL];
//        NSLog(@"docFiles.count=%lu",(unsigned long)docFiles.count);
//                for (NSString *fil in docFiles) {
//            NSLog(@"fil=%@",fil);
//            if ([fil hasSuffix: @"txt"]) {
//                NSLog(@"remove this txt    fil=%@",fil);
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", gbl_appDocDirStr, fil] error: &err01];
//                if (err01) { NSLog(@"error on rm fil %@ = %@", fil, err01 ); }
//            }
//            if ([fil hasPrefix: @"mambd"] || [fil hasPrefix: @"mambG"]    ) {
//                 NSLog(@"remove this mambd  fil=%@",fil);
//                //[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error: &err01];
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", gbl_appDocDirStr, fil] error: &err01];
//                if (err01) { NSLog(@"error on rm fil %@ = %@", fil, [err01 localizedFailureReason]); }
//            }
//        }
//







//    //   for test   TO SIMULATE first downloading the app-  when there are no data files
//    //   FOR test   remove all regular named files   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//    //
//    NSLog(@" FOR test   BEG   remove all regular named files   xxxxxxxxxx ");
//    [gbl_sharedFM removeItemAtURL: gbl_URLToLastEnt    error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm lastent %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToGroup      error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm group   %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToPerson     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm person  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToMember     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm Member  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToGrpRem     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm GrpRem  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToPerRem     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm PerRem  %@", [err01 localizedFailureReason]); }
//    NSLog(@" FOR test   END   remove all regular named files   xxxxxxxxxx ");
//    // end of   FOR test   remove all regular named files   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//

















    haveGrp    = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePer    = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    haveMem    = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGrpRem];
    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerRem];

tn();tr("test before check data files ");
ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);

    if ( haveGrp && havePer && haveMem ) {   // good to go
        NSLog(@"%@", @"use regular files!");

    } else {   // INIT with example data    (here  at least one  have = NO )

       // possibly implement later 
        //        if (haveGrp && havePer && !haveMem) {
        //            NSLog (@"building member file from other files");
        //            //  TODox
        //            // without this done,  here you lose all  members from all groups 
        //        } 
        //        else if (!haveGrp && havePer && haveMem) {
        //            NSLog (@"building group file from other files");
        //            //  TODOx
        //            // without this done,  here you lose all  groups 
        //        } else {
        //        }
        //

        NSLog(@"%@", @"use example data arrays!");

        // delete all data files, if present, and write and use example data arrays
        //
        if (!havePer) {

            //      remove all data named files (these cannot exist - no overcopy)
            [gbl_sharedFM removeItemAtURL: gbl_URLToGroup error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm group %@",  err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToPerson error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm person %@", err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToMember error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm member %@", err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToGrpRem error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm grprem %@", err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToPerRem error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm perrem %@", err01); }

            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplegroup"];   // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayGrp=%@",gbl_arrayGrp);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"exampleperson"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayPer=%@",gbl_arrayPer);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplemember"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayMem=%@",gbl_arrayMem);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplegrprem"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"exampleperrem"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);

        }
    } // check data files

//tn();tr("HOME   test after  check data files ");
//    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
//    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
//    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
//    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);
//


    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"group"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"person"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"member"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"grprem"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"perrem"];



//
//    // read data files  with regular names into arrays
//    // and sort the arrays in place by name
//    //




//    // test check full load after app 1st downloaded
//tn();trn(" HOME   AFTER READ   BEFORE SORT  data files ");
//    NSLog(@"home2viewDidLoad  gbl_arrayGrp=%@",gbl_arrayGrp);
//    NSLog(@"home2viewDidLoad  gbl_arrayPer=%@",gbl_arrayPer);
//    NSLog(@"home2viewDidLoad  gbl_arrayMem=%@",gbl_arrayMem);
//    NSLog(@"home2viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
//    NSLog(@"home2viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);
//



    if (gbl_arrayGrp)    { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"group"]; }
    if (gbl_arrayPer)    { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"person"]; }
    if (gbl_arrayMem)    { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; }
    if (gbl_arrayGrpRem) { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"grprem"]; }
    if (gbl_arrayPerRem) { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"perrem"]; }



//    // test
//tn();trn(" HOME   AFTER read data files  with regular names into arrays // and sort the arrays in place by name");
//    NSLog(@"home2viewDidLoad  gbl_arrayGrp=%@",gbl_arrayGrp);
//    NSLog(@"home2viewDidLoad  gbl_arrayPer=%@",gbl_arrayPer);
//    NSLog(@"home2viewDidLoad  gbl_arrayMem=%@",gbl_arrayMem);
//    NSLog(@"home2viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
//    NSLog(@"home2viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);
//

// exit(1);  // for test do just once
// //break;  // for test, continue


    // check for data corruption  (should not happen)
    //
    NSInteger myCorruptDataErrNum;
    do {
        myCorruptDataErrNum =  [myappDelegate mambCheckForCorruptData ];
  NSLog(@"myCorruptDataErrNum =[%ld]",(long)myCorruptDataErrNum );

        if (myCorruptDataErrNum > 0) {

  NSLog(@"myCorruptDataErrNum =[%ld]",(long)myCorruptDataErrNum );

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];


            // delete all non-example data from people, groups and members
            //
            // now delete from each gbl_arrayXxx  the non-example data
            // by  going backwards from the highest index to delete to the lowest
            //
            for (NSInteger i = gbl_arrayMem.count - 1;  i >= 0;  i--) {
                if ([gbl_arrayMem[i] hasPrefix: @"~"]) continue; 
                [gbl_arrayMem removeObjectAtIndex: i ];
            }
            for (NSInteger i = gbl_arrayPer.count - 1;  i >= 0;  i--) {
                if ([gbl_arrayPer[i] hasPrefix: @"~"]) continue; 
                [gbl_arrayPer removeObjectAtIndex: i ];
            }
            for (NSInteger i = gbl_arrayGrp.count - 1;  i >= 0;  i--) {
                if ([gbl_arrayGrp[i] hasPrefix: @"~"]) continue; 
                [gbl_arrayGrp removeObjectAtIndex: i ];
            }

            [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"group" ]; // write new array data to file
            [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"group" ]; // read new data from file to array
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"group" ]; // sort array by name


            [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"person"]; // write new array data to file
            [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"person"]; // read new data from file to array
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"person"]; // sort array by name

            [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"member"]; // write new array data to file
            [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"member"]; // read new data from file to array
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"member"]; // sort array by name


            [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];   


//<.>
//            // http://stackoverflow.com/questions/25962559/uialertcontroller-text-alignment
//            //
//            // I have successfully used the following, for both aligning and styling the text of UIAlertControllers:
//            // 
//            // let paragraphStyle = NSMutableParagraphStyle()
//            // paragraphStyle.alignment = NSTextAlignment.Left
//            // 
//            // let messageText = NSMutableAttributedString(
//            //     string: "The message you want to display",
//            //     attributes: [
//            //         NSParagraphStyleAttributeName: paragraphStyle,
//            //         NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
//            //         NSForegroundColorAttributeName : UIColor.blackColor()
//            //     ]
//            // )
//            // 
//            // myAlert.setValue(messageText, forKey: "attributedMessage")
//            // You can do a similar thing with the title, if you use "attributedTitle", instead of "attributedMessage"
//            // 
//            // Eduardo 3,901
//            //   	 	
//            // Seems like this is private API use, did this make it into the App Store? – powerj1984 Jul 6 '15 at 14:10
//            // @powerj1984 yes, it did. – Eduardo Jul 6 '15 at 15:02
//            //
// 
//<.>
//
//  Use this code instead       [self.navigationController presentViewController: myAlert  animated: YES  completion: nil ];



            // want left-justified alert text for long msg
            //
//   //#define FONT_SIZE 20
//   //#define FONT_HELVETICA @"Helvetica-Light"
//   //#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.4f]
//   //NSString*myNSString = @"This is my string.\nIt goes to a second line.";                
//   
//   NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//                  paragraphStyle.alignment = NSTextAlignmentCenter;
//   //             paragraphStyle.lineSpacing = FONT_SIZE/2;
//   //             paragraphStyle.lineSpacing = -5;
//   
//   //                     UIFont * labelFont = [UIFont fontWithName:Menlo size: 16.0];
//   //                   UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
//   //                       NSShadow *shadow = [[NSShadow alloc] init];
//   //                 [shadow setShadowColor : BLACK_SHADOW];
//   //                [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
//   //            [shadow setShadowBlurRadius : 1 ];
//   
//   //NSAttributedString *labelText = [[NSAttributedString alloc] initWithString :  myNSString
//   //       *myAttrString = [[NSAttributedString alloc] initWithString : mylin   // myNSString
//          myAttrString = [[NSMutableAttributedString alloc] initWithString : mylin   // myNSString
//              attributes : @{
//                  NSParagraphStyleAttributeName : paragraphStyle,
//   //                         NSFontAttributeName : compFont_16 
//                            NSFontAttributeName : compFont_14 
//   //               NSBaselineOffsetAttributeName : @-1.0
//              }
//          ];
//   //                 NSKernAttributeName : @2.0,
//   //                 NSFontAttributeName : labelFont
//   //      NSForegroundColorAttributeName : labelColor,
//   //              NSShadowAttributeName : shadow
//


            // want left-justified alert text for long msg
            //
            NSString *mymsg;
            mymsg = @"When corrupt data is found, the App has to delete all of your added people, groups and group members.\n\n   RECOVERY of DATA \n\nMethod 1:  Assuming you did backups, go to your latest email having the subject \"Me and My BFFs BACKUP\".  Follow the instructions in the email to restore the data.\n\nMethod 2:  Delete the App \"Me and My BFFs\" and install it again from the App store.  Doing this might restore the data for people, groups and members.";

            NSMutableParagraphStyle *myParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            myParagraphStyle.alignment                = NSTextAlignmentLeft;

            NSMutableAttributedString *myAttrMessage;
            myAttrMessage = [[NSMutableAttributedString alloc] initWithString : mymsg   // myNSString
                attributes : @{
                    NSParagraphStyleAttributeName : myParagraphStyle,
//                   NSBackgroundColorAttributeName : gbl_color_cRed,
                              NSFontAttributeName : [UIFont boldSystemFontOfSize: 12.0]
                }
            ];
//            // myAlert.setValue(messageText, forKey: "attributedMessage")



            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Found Corrupt Data"
                                                                           message: mymsg
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            [myAlert setValue: myAttrMessage  forKey: @"attributedMessage" ];

            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
                NSLog(@"Ok button pressed    for corrupt data");
            } ];
             
            [myAlert addAction:  okButton];

            // was using this:
            //[self presentViewController: myAlert  animated: YES  completion: nil   ];
            //
            // but was getting this:   Warning :-Presenting view controllers on detached view controllers is discouraged
            //
            // finally, this got rid of the warning:
            //
            [self.navigationController presentViewController: myAlert  animated: YES  completion: nil ];

            // tried all these:
            //
            // To avoid getting the warning in a push navigation, you can directly use :
            // 
            // [self.view.window.rootViewController presentViewController:viewController animated:YES completion:nil];
            // And then in your modal view controller, when everything is finished, you can just call :
            // 
            // [self dismissViewControllerAnimated:YES completion:nil];
            //
            //[self.view.window.rootViewController presentViewController:viewController animated:YES completion:nil];
            //[self.view.window.rootViewController presentViewController: myAlert  animated: YES  completion: nil ];
            //
            // run on rootviewcontroller
            //            id rootVC = [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
            //            [rootViewController presentViewController: myAlert  animated: YES  completion: nil ];
            //You can access it using the below code if the rootViewController is a UIViewController
            //
            //ViewController *rootController=(ViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            //But if it's a UINavigationController you can use the code below.
            //
            //UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            //ViewController *rootController=(ViewController *)[nav.viewControllers objectAtIndex:0];
            //
            //        UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            //nbn(2); 
            //        ViewController *rootController=(ViewController *)[nav.viewControllers objectAtIndex:0];
            //nbn(3); 
            //       [rootController presentViewController: myAlert  animated: YES  completion: nil ];
            //
            //    [sourceViewController.navigationController.view.layer addAnimation: transition 
            //    self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 


        } // got corrupt data


    } while (FALSE);  // check for data corruption  (should not happen)




    [self doStuffOnEnteringForeground];  // read   lastEntity stuff

    // for test  LOOK AT all files in doc dir
    NSArray *docFiles2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: gbl_appDocDirStr error:NULL];
    NSLog(@"docFiles2.count=%lu",(unsigned long)docFiles2.count);
    for (NSString *fil in docFiles2) { NSLog(@"doc fil=%@",fil); }
    // for test  LOOK AT all files in doc dir

nbn(45);



//    self.tableView.sectionIndexColor = [UIColor brownColor];  // set tintColor for section index



    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex or not after switch


} // - (void)viewDidLoad




- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The App received a Memory Warning"
//                                                    message: @"The system has determined that the \namount of available memory is very low."
//                                                   delegate: nil
//                                          cancelButtonTitle: @"OK"
//                                          otherButtonTitles: nil];
//
//    [alert show];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"The App received a Memory Warning"
                                                                   message: @"The system has determined that the \namount of available memory is very low."
                                                            preferredStyle: UIAlertControllerStyleAlert  ];
     
    UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                        style: UIAlertActionStyleDefault
                                                      handler: ^(UIAlertAction * action) {
        NSLog(@"Ok button pressed");
    } ];
     
    [alert addAction:  okButton];

    [self presentViewController: alert  animated: YES  completion: nil   ];
        
    [super didReceiveMemoryWarning];
} // didReceiveMemoryWarning 

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    return 1;
} // numberOfSectionsInTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"in numberOfRowsInSection");
    // Return the number of rows in the section.
    //return 0;
    //return mambyObjectList.count;
    //if ([_mambCurrentEntity isEqualToString:@"group"])  return gbl_arrayGrp.count;
    //if ([_mambCurrentEntity isEqualToString:@"person"]) return gbl_arrayPer.count;
    if ([gbl_lastSelectionType isEqualToString:@"group"]) 
    {
  NSLog(@"retint  return num groups=[%ld]",(long)gbl_arrayGrp.count);
        return gbl_arrayGrp.count;
    }
    if ([gbl_lastSelectionType isEqualToString:@"person"])
    {
  NSLog(@"retint  return num people=[%ld]",(long)gbl_arrayPer.count);
        return gbl_arrayPer.count;
    }
    return 0;
} // numberOfRowsInSection


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in cellForRowAtIndexPath in HOME");
//  NSLog(@"indexPath.row =[%ld]",(long)indexPath.row );

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"MyCell1";
    
    // check to see if we can reuse a cell from a row that has just rolled off the screen
    // if there are no cells to be reused, create a new cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }



//    NSLog(@"in cellForRowAtIndexPath 2222");
//    NSLog(@"all array[%@]", mambyObjectList);
//    NSLog(@"current  row=[%@]", [mambyObjectList objectAtIndex:indexPath.row]);

    // set the text attribute to the name of
    // whatever we are currently looking at in our array
    // name is 1st element in csv
    //
    // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);

    NSString *currentLine, *nameOfGrpOrPer;

    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
        gbl_colorDIfor_home = gbl_colorSepara_grp ;
        currentLine = [gbl_arrayGrp objectAtIndex:indexPath.row];
    } else {
        if ([gbl_lastSelectionType isEqualToString:@"person"]) {
            currentLine = [gbl_arrayPer objectAtIndex:indexPath.row];
            gbl_colorDIfor_home = gbl_colorSepara_per ;
        } else {
            currentLine = @"Unknown|";
        }
    }
    // NSLog(@"currentLine=%@",currentLine);

    _arr = [currentLine componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    nameOfGrpOrPer = _arr[0];
    //NSLog(@"nameOfGrpOrPer=%@",nameOfGrpOrPer);


    // NSLog(@"gbl_home_cell_AccessoryType=[%d]",gbl_home_cell_AccessoryType);

//    // make label for cell text
//    //


//        CGFloat myScreenWidth, myFontSize;  // determine font size
//        if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) {
//nbn(20);
//            myScreenWidth = self.view.bounds.size.width;
//            if (        myScreenWidth >= 414.0)  { myFontSize = 17.0; }  // 6+ and 6s+  and bigger
//            else if (   myScreenWidth  < 414.0   
//                     && myScreenWidth  > 320.0)  { myFontSize = 17.0; }  // 6 and 6s
//            else if (   myScreenWidth <= 320.0)  { myFontSize = 17.0; }  //  5s and 5 and 4s and smaller
//            else                                 { myFontSize = 17.0; }  //  other ?
//        } else {
//            myFontSize = 17.0;
//        }
//

            // make label for Disclosure Indicator   ">"
            //
            NSAttributedString *myNewCellAttributedText3 = [
                [NSAttributedString alloc] initWithString: @">"  
                                               attributes: @{
                        NSFontAttributeName :  [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0] ,  
//                        NSForegroundColorAttributeName: [UIColor grayColor ]  
//                        NSForegroundColorAttributeName: [UIColor darkGrayColor ]  
//                        NSForegroundColorAttributeName: gbl_colorDIfor_home   
                        NSForegroundColorAttributeName: [UIColor grayColor ]  
                    }
            ];

            UILabel *myDisclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
            myDisclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
            if ([gbl_lastSelectionType isEqualToString:@"group"])  myDisclosureIndicatorLabel.backgroundColor = gbl_colorHomeBG_grp; 
            if ([gbl_lastSelectionType isEqualToString:@"person"]) myDisclosureIndicatorLabel.backgroundColor = gbl_colorHomeBG_per; 


//  NSLog(@"gbl_homeUseMODE =%@",gbl_homeUseMODE );

//  NSLog(@"before set access view");
    dispatch_async(dispatch_get_main_queue(), ^{                        

//  cell.textLabel.text = @"";           // for test create empty Launch screen shot 
//  cell.accessoryType        = nil;      // for test create empty Launch screen shot
//  cell.editingAccessoryType = nil;     // for test create empty Launch screen shot
  //
  // For instance let's say your app supports iPhones > 4s, so iPhone: 4s, 5, 5s, 6 and 6plus.
  // Make sure to make launch-images which have the following dimensions:
  //         iPhone4s    =  640 ×  960
  //         iPhone5, 5s =  640 × 1136
  //         iPhone6     =  750 x 1334
  //         iPhone6plus = 1242 x 2208
  //


//  ALSO for test only    comment out between her and  <.x  below
// for test create empty Launch screen shot by commenting out from here to <.x

        cell.textLabel.text = nameOfGrpOrPer;

        cell.textLabel.font            = [UIFont boldSystemFontOfSize: 17.0];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.accessoryType        = gbl_home_cell_AccessoryType;           // home mode edit    with tap giving record details
        cell.editingAccessoryType = gbl_home_cell_editingAccessoryType;    // home mode edit    with tap giving record details

//        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        // PROBLEM  name slides left off screen when you hit red round delete "-" button
        //          and delete button slides from right into screen
        //
        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right

        if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) cell.tintColor = [UIColor blackColor];

//        cell.accessoryView                       = gbl_disclosureIndicatorLabel;
        cell.accessoryView                       = myDisclosureIndicatorLabel;
        cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

  //<.x for test create empty Launch screen shot  //  ALSO comment out between the 2  <.  above


    });
//  NSLog(@"after set access view");
  
// stick with apple gray selection color
//  NSLog(@"gbl_mySelectedCellBgView=[%@]",gbl_mySelectedCellBgView);
//    cell.selectedBackgroundView =  gbl_mySelectedCellBgView;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

    return cell;
} // cellForRowAtIndexPath


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in  willSelectRowAtIndexPath !  in HOME");


// comment this out and try making  rows in yellow edit mode   selectable  (same action as "i" accessory)
//
//    // rows in yellow edit mode  should not be selectable
//    //
//    // NSString *gbl_homeUseMODE;      // "edit mode" (yellow)   or   "regular mode" (blue)
//    //
//    if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) return nil;
//

    return indexPath; // By default, allow row to be selected
}



// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
    //  NSLog(@"in heightForRowAtIndexPath 1");

  return 44.0; // matches report height

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];

    //    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    //    [self.tableView setBackgroundColor: gbl_colorHomeBG];

    if (     [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) [self.tableView setBackgroundColor: gbl_colorEditingBG];
    else if ([gbl_lastSelectionType isEqualToString:@"person"]) [self.tableView setBackgroundColor: gbl_colorHomeBG_per];
    else if ([gbl_lastSelectionType isEqualToString:@"group" ]) [self.tableView setBackgroundColor: gbl_colorHomeBG_grp];

    cell.backgroundColor = [UIColor clearColor];
}


/*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}

*/

/*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
}
*/

/*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
*/


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"in canEditRowAtIndexPath!");
//  NSLog(@"indexPath.row =%ld",indexPath.row );

//
//    // Return NO if you do not want the specified item to be editable.
//    if (indexPath.row == 5 ) return  NO;
//    else                     return YES;
//

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath
{
//tn();
//NSLog(@"in editingStyleForRowAtIndexPath");
    return UITableViewCellEditingStyleDelete;
}


//   DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD DELETE METHOD
//
- (void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)  editingStyle  // DELETE METHOD, DELETE METHOD
                                            forRowAtIndexPath: (NSIndexPath *)                indexPath
{
tn();
  NSLog(@"in commitEditingStyle");
  NSLog(@"editingStyle =[%ld]",(long)editingStyle);
  NSLog(@"indexPath.row=%ld",(long)indexPath.row);


    if (   editingStyle == UITableViewCellEditingStyleDelete
        && [gbl_lastSelectionType isEqualToString: @"person" ]
    ) {
  NSLog(@"in commitEditingStyle  2222222");

        NSInteger arrayCountBeforeDelete;
        NSInteger arrayIndexToDelete;
        NSInteger arrayIndexOfNew_gbl_lastSelectedPerson;

        arrayCountBeforeDelete = gbl_arrayPer.count;
        arrayIndexToDelete     = indexPath.row;


        // before write of array data to file, disallow/ignore user interaction events
        //
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

        [myappDelegate mamb_beginIgnoringInteractionEvents ];


        // delete the array element for this cell
        // here the array index to delete matches the incoming  indexPath.row
        //
        [gbl_arrayPer removeObjectAtIndex:  arrayIndexToDelete ]; 
        // gbl_arrayPer  is now golden  (was sorted before)

        // was sorted before anyway, but sort it for safety
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"person"]; // sort array by name
        [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"person"]; // write new array data to file

    //  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"person"]; // read new data from file to array


        // have to set new gbl_lastSelectedPerson  
        // have to set new gbl_fromHomeCurrentSelectionPSV
        //
        // to be the "nearest" person after this deleted one 
        // UNLESS deleted one IS the last person, then the one before.
        //
        if ( arrayIndexToDelete == arrayCountBeforeDelete - 1) {                       // if deleted last element
            arrayIndexOfNew_gbl_lastSelectedPerson  = arrayCountBeforeDelete - 1 - 1;  //      new = last element minus one
        } else {
            arrayIndexOfNew_gbl_lastSelectedPerson  = arrayIndexToDelete;              // else new = last element
        }
  NSLog(@"before gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"before gbl_lastSelectedPerson          =[%@]",gbl_lastSelectedPerson);

        gbl_fromHomeCurrentSelectionPSV  = gbl_arrayPer[arrayIndexOfNew_gbl_lastSelectedPerson];
        gbl_lastSelectedPerson           = [gbl_fromHomeCurrentSelectionPSV  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 

  NSLog(@"after  gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"after  gbl_lastSelectedPerson          =[%@]",gbl_lastSelectedPerson);


        // now delete the row on the screen
        // and put highlight on row number for  arrayIndexOfNew_gbl_lastSelectedPerson
        //
        dispatch_async(dispatch_get_main_queue(), ^{  

            [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]   // now delete the row on the screen
                                  withRowAnimation: UITableViewRowAnimationFade
            ];

            [self putHighlightOnCorrectRow ];
        });

        // after write of array data to file, allow user interaction events again
        //
        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];    // after arg seconds

    }  // if (editingStyle == UITableViewCellEditingStyleDelete) 



    if (   editingStyle == UITableViewCellEditingStyleDelete
        && [gbl_lastSelectionType isEqualToString: @"group" ]
    ) {
  NSLog(@"in commitEditingStyle  3333333");

        NSInteger arrayCountBeforeDelete;
        NSInteger arrayIndexToDelete;
        NSInteger arrayIndexOfNew_gbl_lastSelectedGroup;

        arrayCountBeforeDelete = gbl_arrayGrp.count;
        arrayIndexToDelete     = indexPath.row;


        // before write of array data to file, disallow/ignore user interaction events
        //
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

        [myappDelegate mamb_beginIgnoringInteractionEvents ];


        // delete the array element for this cell
        // here the array index to delete matches the incoming  indexPath.row
        //
        [gbl_arrayGrp removeObjectAtIndex:  arrayIndexToDelete ]; 
        // gbl_arrayGrp  is now golden  (was sorted before)

        // was sorted before anyway, but sort it for safety
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"group"]; // sort array by name
        [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"group"]; // write new array data to file

    //  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"group"]; // read new data from file to array


        // have to set new gbl_lastSelectedGroup  
        // have to set new gbl_fromHomeCurrentSelectionPSV
        //
        // to be the "nearest" group after this deleted one 
        // UNLESS deleted one IS the last group, then the one before.
        //
        if ( arrayIndexToDelete == arrayCountBeforeDelete - 1) {                       // if deleted last element
            arrayIndexOfNew_gbl_lastSelectedGroup  = arrayCountBeforeDelete - 1 - 1;  //      new = last element minus one
        } else {
            arrayIndexOfNew_gbl_lastSelectedGroup  = arrayIndexToDelete;              // else new = last element
        }
  NSLog(@"before gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"before gbl_lastSelectedGroup   I       =[%@]",gbl_lastSelectedGroup);

        gbl_fromHomeCurrentSelectionPSV  = gbl_arrayGrp[arrayIndexOfNew_gbl_lastSelectedGroup];
        gbl_lastSelectedGroup           = [gbl_fromHomeCurrentSelectionPSV  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 

  NSLog(@"after  gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"after  gbl_lastSelectedGroup           =[%@]",gbl_lastSelectedGroup);


        // now delete the row on the screen
        // and put highlight on row number for  arrayIndexOfNew_gbl_lastSelectedGroup
        //
        dispatch_async(dispatch_get_main_queue(), ^{  

            [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]   // now delete the row on the screen
                                  withRowAnimation: UITableViewRowAnimationFade
            ];

            [self putHighlightOnCorrectRow ];
        });

        // after write of array data to file, allow user interaction events again
        //
        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];    // after arg seconds

    }  // if (editingStyle == UITableViewCellEditingStyleDelete) 


}  // end of commitEditingStyle
//
//   DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD DELETE METHOD



#pragma mark - Navigation


-(IBAction)prepareForUnwindFromAddtoHome:(UIStoryboardSegue *)segue {
  NSLog(@" in prepareForUnwind !!! in HOME");
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in prepareForSegue() in home!");


  NSLog(@"segue.identifier =[%@]",segue.identifier );

    if ([segue.identifier isEqualToString:@"segueHomeToAddChange"]) {



        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        //        transition.subtype = direction;
        //        transition.subtype = kCATransitionFromBottom;
        //        transition.subtype = kCATransitionFromTop;
        //        transition.subtype = kCATransitionFromLeft;
        transition.subtype = kCATransitionFade;
        [self.view.layer addAnimation:transition forKey:kCATransition];

   UIViewController *sourceViewController = (UIViewController*)[segue sourceViewController];
    [sourceViewController.navigationController.view.layer addAnimation: transition 
                                                                forKey: kCATransition];

        [self.tableView setEditing: YES animated: YES];  // turn cocoa editing mode off when this screen leaves

    }
} // end of  prepareForSegue 



-(IBAction)pressedInfoButtonAction:(id)sender
{
  NSLog(@"in   infoButtonAction!  in HOME");
//tn();
    // if 2 rows have highlight, remove one

    // If you only want to iterate through the visible cells, then use
    NSArray *myVisibleCells = [self.tableView visibleCells];
    for (UITableViewCell *myviscell in myVisibleCells) {
//  NSLog(@"cell.textLabel.text=[%@]",myviscell.textLabel.text);
//  NSLog(@"highlighted  butt  =[%d]",myviscell.highlighted );
//  NSLog(@"selected     butt  =[%d]",myviscell.selected    );
    }

//        if (myviscell.selected  == NO) {
//            [myviscell setHighlighted: NO
//                             animated: NO  ];
//  NSLog(@"   set highlighted to NO");
            // get indexpath for cell
            // NSIndexPath *indexPath = [self.tableView indexPathForCell:cell] ;

//    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            [self.tableView deselectRowAtIndexPath: [self.tableView indexPathForCell: myviscell] // and remove yellow highlight
//                                          animated: NO
//            ];
//    });
//  NSLog(@"   deselect this cell ! ");

//  no        gbl_deselectThisCellOnReturnHome = myviscell;
//        }
//tn();

} // end of  infoButtonAction



// using setediting  INSTEAD
// WHEN TAPPED, THIS BUTTON AUTOMATICALLY TOGGLES BETWEEN AN eDIT AND dONE BUTTON AND
// CALLS YOUR VIEW CONTROLLER’S  setEditing:animated:  METHOD WITH APPROPRIATE VALUES.

//-(IBAction)pressedEditButtonAction:(id)sender
//{
//  NSLog(@"in   pressedEditButtonAction!  in HOME");
//
//  // gbl_homeEditingState   "add" for add a new person or group, "view or change" for tapped person or group
//  gbl_homeEditingState = @"view or change";  // this is default state when entering edit mode (addChangeViewController)
//
//  gbl_homeUseMODE = @"edit mode";   // determines home mode  @"edit mode" or @"regular mode"
//  [self.tableView reloadData];
//
//
//} // end of  pressedEditButtonAction



-(IBAction)navAddButtonAction:(id)sender
{
  NSLog(@"in   navAddButtonAction!  in HOME");

    gbl_homeEditingState = @"add";  // "add" for add a new person or group, "view or change" for tapped person or group


//    if ( self.editing == NO ) {
//        [self setEditing: YES   animated: YES ];
//    }

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];
   
    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
        [self performSegueWithIdentifier:@"segueHomeToAddChange" sender:self]; //  
    });

} // end of  navAddButtonAction



- (IBAction)actionSwitchEntity:(id)sender   // segemented control on home page   select person  or  group
{  // segemented control on home page   select person  or  group
    NSLog(@"in actionSwitchEntity() in home!");

//    NSLog(@"gbl_LastSelectedPerson=%@",gbl_lastSelectedPerson);
//    NSLog(@"gbl_LastSelectedGroup=%@" ,gbl_lastSelectedGroup);
//    NSLog(@"gbl_lastSelectionType=%@" ,gbl_lastSelectionType);
//    NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);

//    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
//        // NSLog(@"change grp to per!");
//        //_mambCurrentSelectionType = @"person";
//        gbl_fromHomeCurrentEntity        = @"person";
//        gbl_fromHomeCurrentSelectionType = @"person";
//        gbl_lastSelectionType            = @"person";
//        gbl_currentMenuPrefixFromHome              = @"homp"; 
//    } else if ([gbl_lastSelectionType isEqualToString:@"person"]){
//        // NSLog(@"change per to grp!");
//        //_mambCurrentSelectionType = @"person";
//        gbl_fromHomeCurrentEntity        = @"group";
//        gbl_fromHomeCurrentSelectionType = @"group";
//        gbl_lastSelectionType            = @"group";
//        gbl_currentMenuPrefixFromHome              = @"homg"; 
//    }
////    NSLog(@"gbl_fromHomeCurrentEntity        =%@",gbl_fromHomeCurrentEntity        );
////    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
////    NSLog(@"gbl_lastSelectionType            =%@",gbl_lastSelectionType            );
////    NSLog(@"gbl_currentMenuPrefixFromHome              =%@",gbl_currentMenuPrefixFromHome);
//
//

//    [self putHighlightOnCorrectRow ];  // does not work here (too long to investigate)


    //
    //        // change  from group data on screen to person data   or vice-versa
    //        // but, disable user interaction for "mytime"
    //        // to prevent machine-gun pounding on next or prev key
    //        //
    //        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    //        [myappDelegate mamb_beginIgnoringInteractionEvents ];
    //        if (gbl_shouldUseDelayOnBackwardForeward == 1) {  // = 1 (0.5 sec  on what color update)
    //                                                          // = 0 (no delay on first show of screen)
    //            [self.view setUserInteractionEnabled: NO];                              // this works to disable user interaction for "mytime"
    //
    //            int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
    //            dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);
    //
    //            dispatch_after(mytime, dispatch_get_main_queue(), ^{                     // do after delay of  mytime
    //
    //// DO STUFF HERE
    //                [self.outletWebView  loadHTMLString: myWhatColorHTML_FileContents  baseURL: nil];
    //// DO STUFF HERE
    //
    //                [self.view setUserInteractionEnabled: YES];                          // this works to disable user interaction for "mytime"
    //            });
    //        }
    //        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
    //


    // change  from group data on screen to person data   or vice-versa
    // but, disable user interaction for "mytime"   (0.33 sec)
    // to prevent machine-gun pounding on next or prev key
    //


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];



//    if ([gbl_fromHomeCurrentEntity isEqualToString: @"group"]) {
//        _segEntityOutlet.selectedSegmentIndex = 0;
//        _segEntityOutlet.userInteractionEnabled = YES;
//        [_segEntityOutlet setEnabled: NO forSegmentAtIndex: 1];  // disable selection of "Person"
//        _segEntityOutlet.userInteractionEnabled = NO;
//    }
//    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person"]) {
//        _segEntityOutlet.selectedSegmentIndex = 1;
//
//        _segEntityOutlet.userInteractionEnabled = YES;
//        [_segEntityOutlet setEnabled: NO forSegmentAtIndex: 0];  // disable selection of "Group"
//        _segEntityOutlet.userInteractionEnabled = NO;
//    }
//    [ _segEntityOutlet setTitleTextAttributes: selectedAttributes   forState: UIControlStateSelected];
//    [ _segEntityOutlet setTitleTextAttributes: unselectedAttributes forState: UIControlStateNormal];
//


//
////self.segmentedControl.tintColor = [UIColor cb_Grey1Color];
////self.segmentedControl.backgroundColor = [UIColor cb_Grey3Color];
//// _segEntityOutlet.tintColor = [UIColor greenColor];
//// _segEntityOutlet.backgroundColor = [UIColor cyanColor];
//// _segEntityOutlet.tintColor = gbl_color_cAplTop;
//
//  // _segEntityOutlet.backgroundColor = gbl_color_cAplTop;
////   _segEntityOutlet.backgroundColor = [UIColor yellowColor];
//     NSDictionary *selectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [UIFont boldSystemFontOfSize: 13.0] , NSFontAttributeName,
////                                        UIOffsetMake(0.0, 0.0), UITextAttributeTextShadowOffset,
////                                        [UIColor redColor], UITextAttributeTextShadowColor,
////                                    [UIColor redColor], NSForegroundColorAttributeName,
////                                    [UIColor whiteColor], NSForegroundColorAttributeName,
////                                    [UIColor greenColor], NSBackgroundColorAttributeName,
//                                     nil
//     ];
//
//     NSDictionary *unselectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                    [UIFont boldSystemFontOfSize: 13.0] , NSFontAttributeName,
//                                    [UIFont systemFontOfSize: 13.0] , NSFontAttributeName,
//
////                                        UIOffsetMake(0.0, 0.0), UITextAttributeTextShadowOffset,
////                                        [UIColor redColor], UITextAttributeTextShadowColor,
//
////                                      [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
////                                      [UIColor greenColor], NSForegroundColorAttributeName,
////                                      [UIColor lightGrayColor], NSForegroundColorAttributeName,
////                                    gbl_color_cAplDarkBlue, NSForegroundColorAttributeName,
////                                      [UIColor redColor], NSBackgroundColorAttributeName,
//                                      nil
//    ];
//
//
//
////    _segEntityOutlet.backgroundColor = gbl_reallyLightGray;
////    NSDictionary *selectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//////                                    gbl_colorHomeBG_grp, NSStrokeColorAttributeName,
//////                                    [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
//////                                    [UIColor whiteColor], NSForegroundColorAttributeName,
//////                                    gbl_color_cAplDarkBlue, NSForegroundColorAttributeName,
//////                                    [UIColor whiteColor], NSForegroundColorAttributeName,
//////                                    gbl_color_cAplDarkBlue, NSBackgroundColorAttributeName,
//////                                    gbl_colorHomeBG_grp, NSBackgroundColorAttributeName,
//////                                     [UIColor greenColor], UITextAttributeTextColor,
////                                     [UIColor whiteColor], UITextAttributeTextColor,
////                                    nil
////    ];
////
////     NSDictionary *unselectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//////                                    gbl_colorHomeBG_grp, NSStrokeColorAttributeName,
//////                                      [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
//////                                     gbl_color_cAplDarkBlue, NSForegroundColorAttributeName,
//////                                     [UIColor redColor], NSForegroundColorAttributeName,
//////                                     [UIColor lightGrayColor], NSForegroundColorAttributeName,
//////                                      [UIColor whiteColor], NSBackgroundColorAttributeName,
//////                                      [UIColor grayColor], NSBackgroundColorAttributeName,
//////                                     gbl_reallyLightGray, NSBackgroundColorAttributeName,
//////                                     [UIColor redColor], NSBackgroundColorAttributeName,
//////                                     [UIColor lightGrayColor], UITextAttributeTextColor,
////                                     [UIColor grayColor], UITextAttributeTextColor,
//////                                     [UIColor redColor], UITextAttributeTextColor,
////
////                                      nil
////    ];
////
//    [ _segEntityOutlet setTitleTextAttributes: selectedAttributes   forState: UIControlStateSelected];
//    [ _segEntityOutlet setTitleTextAttributes: unselectedAttributes forState: UIControlStateNormal];
//

//    _segEntityOutlet.tintColor = [UIColor redColor];
//    _segEntityOutlet.tintColor = gbl_colorHomeBG_grp;

//    _segEntityOutlet.tintColor = [UIColor brownColor];  // works?  set navbar tintcolor instead



//@property(nonatomic, retain) UIColor *sectionIndexColor




//    int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 2.5 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 0.33 * (double)NSEC_PER_SEC;
    int64_t myDelayInSec   = 0.38 * (double)NSEC_PER_SEC;
    dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);

    dispatch_after(mytime, dispatch_get_main_queue(), ^{       // do after delay of mytime    dispatch    dispatch    dispatch   dispatch  

        //// start DO STUFF HERE
    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
        // NSLog(@"change grp to per!");
        //_mambCurrentSelectionType = @"person";
        gbl_fromHomeCurrentEntity        = @"person";
        gbl_fromHomeCurrentSelectionType = @"person";
        gbl_lastSelectionType            = @"person";
        gbl_currentMenuPrefixFromHome    = @"homp"; 
        gbl_colorHomeBG                  = gbl_colorHomeBG_per;
        self.tableView.separatorColor    = gbl_colorSepara_per;
    } else if ([gbl_lastSelectionType isEqualToString:@"person"]){
        // NSLog(@"change per to grp!");
        //_mambCurrentSelectionType = @"person";
        gbl_fromHomeCurrentEntity        = @"group";
        gbl_fromHomeCurrentSelectionType = @"group";
        gbl_lastSelectionType            = @"group";
        gbl_currentMenuPrefixFromHome    = @"homg"; 
        gbl_colorHomeBG                  = gbl_colorHomeBG_grp;
        self.tableView.separatorColor    = gbl_colorSepara_grp;

    }
//    NSLog(@"gbl_fromHomeCurrentEntity        =%@",gbl_fromHomeCurrentEntity        );
//    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
//    NSLog(@"gbl_lastSelectionType            =%@",gbl_lastSelectionType            );
//    NSLog(@"gbl_currentMenuPrefixFromHome              =%@",gbl_currentMenuPrefixFromHome);


    if ([gbl_lastSelectionType isEqualToString: @"group"])  _segEntityOutlet.selectedSegmentIndex = 0; // highlight correct entity in seg ctrl
    if ([gbl_lastSelectionType isEqualToString: @"person"]) _segEntityOutlet.selectedSegmentIndex = 1; // highlight correct entity in seg ctrl

    [self.view setUserInteractionEnabled:  NO];                              // this works to disable user interaction for "mytime"


    NSString *nameOfGrpOrPer;
    NSInteger idxGrpOrPer;
    NSArray *arrayGrpOrper;
    idxGrpOrPer = -1;   // zero-based idx

        if ([gbl_fromHomeCurrentEntity isEqualToString: @"group"]) {


            // NSLog(@"reload table here!");
            [self.tableView reloadData];

            // highlight lastEntity row in tableview
            //
            
            // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
            for (id eltGrp in gbl_arrayGrp) {
              idxGrpOrPer = idxGrpOrPer + 1;
              //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
              //NSLog(@"eltGrp=%@", eltGrp);

              NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString: @"|"];
              arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet:  mySeparators];
              nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

              //if ([nameOfGrpOrPer isEqualToString:  _mambCurrentSelection]) 
              if ([nameOfGrpOrPer isEqualToString:  gbl_lastSelectedGroup]) {
                break;
              }
            }  // search thru gbl_arrayGrp
            NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

            // get the indexpath of row num idxGrpOrPer in tableview
            //   assumes index of entity in gbl_array Per or Grp
            //   is the same as its index (row) in the tableview
            NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow: idxGrpOrPer inSection:0];

    //tn();trn("SCROLL 333333333333333333333333333333333333333333333333333333333");

            dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  

                // select the row in UITableView
                // This puts in the light grey "highlight" indicating selection
                [self.tableView selectRowAtIndexPath:  foundIndexPath   // This puts in the light grey "highlight" indicating selection
                                            animated:  YES
                                      scrollPosition:  UITableViewScrollPositionNone];
                //[self.tableView scrollToNearestSelectedRowAtScrollPosition:  foundIndexPath.row 
                [self.tableView scrollToNearestSelectedRowAtScrollPosition:  UITableViewScrollPositionMiddle
                                                                  animated:  YES];

                if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) {
//                    self.view.backgroundColor     = gbl_colorEditingBG;
                    [self.tableView setBackgroundColor: gbl_colorEditingBG];
                }
            });

        }
        if ([gbl_fromHomeCurrentEntity isEqualToString: @"person"]) {


            // NSLog(@"reload table here!");
            [self.tableView reloadData];

            // highlight lastEntity row in tableview
            //

            // find index of _mambCurrentSelection (like "~Dave") in gbl_arrayPer
            for (id eltPer in gbl_arrayPer) {
                idxGrpOrPer = idxGrpOrPer + 1;
                //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
                //NSLog(@"eltPer=%@", eltPer);
                NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString: @"|"];
                arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet:  mySeparators];
                nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

                //if ([nameOfGrpOrPer isEqualToString:  _mambCurrentSelection]) 
                if ([nameOfGrpOrPer isEqualToString:  gbl_lastSelectedPerson]) {
                    break;
                }
            } // search thru gbl_arrayPer
            NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

            // get the indexpath of row num idxGrpOrPer in tableview
            NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];

    //tn();trn("SCROLL 444444444444444444444444444444444444444444444444444444444");
            dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
                // select the row in UITableView
                // This puts in the light grey "highlight" indicating selection
                [self.tableView selectRowAtIndexPath: foundIndexPath 
                                            animated: YES
                                      scrollPosition: UITableViewScrollPositionNone];
                //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
                [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                                  animated: YES];

                if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) {
//                    self.view.backgroundColor     = gbl_colorEditingBG;
                    [self.tableView setBackgroundColor: gbl_colorEditingBG];
                }
            });
        }

        //// end DO STUFF HERE

//    _segEntityOutlet.userInteractionEnabled = YES;

    _segEntityOutlet.userInteractionEnabled = YES;
    [_segEntityOutlet setEnabled: YES forSegmentAtIndex: 0];  // enable selection of "Group"
    [_segEntityOutlet setEnabled: YES forSegmentAtIndex: 1];  // enable selection of "Person"


    [self.view setUserInteractionEnabled: YES];      

    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex or not after switch
//nbn(145);
//    [self.tableView reloadSectionIndexTitles];


    }); // do after delay of  mytime // this works to disable user interaction for "mytime"


    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

//nbn(146);
//    [self.tableView reloadSectionIndexTitles];
//nbn(147);


} // end of   (IBAction)actionSwitchEntity:(id)sender {  // segemented control on home page



- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()  in HOME");

    // if gbl_fromHomeCurrentEntityName is different from gbl_fromHomeLastEntityRemSaved
    // save the  remember array  gbl_arrayPerRem or gbl_arrayGrpRem
    //
//    NSLog(@"gbl_fromHomeCurrentEntityName  =%@",gbl_fromHomeCurrentEntityName  );
//    if (gbl_fromHomeCurrentEntityName ) { NSLog(@"gbl_fromHomeCurrentEntityName.length=%lu",(unsigned long)gbl_fromHomeCurrentEntityName.length); }
//    NSLog(@"gbl_fromHomeLastEntityRemSaved  =%@",gbl_fromHomeLastEntityRemSaved  );
//    if (gbl_fromHomeLastEntityRemSaved) { NSLog(@"gbl_fromHomeLastEntityRemSaved.length =%lu",(unsigned long)gbl_fromHomeLastEntityRemSaved.length );}
//    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
//
//    BOOL cond1 =  gbl_fromHomeLastEntityRemSaved != nil ;
//    BOOL cond2 = ![gbl_fromHomeLastEntityRemSaved isEqualToString: gbl_fromHomeCurrentEntityName];
//
   
    if (   gbl_justAddedPersonRecord == 1
        || gbl_justAddedGroupRecord  == 1
    ) {
        gbl_justAddedPersonRecord  = 0;
        gbl_justAddedGroupRecord   = 0;
  NSLog(@"reloading tableview");

        [self.tableView reloadData];

        [self putHighlightOnCorrectRow ];
    }

    if (gbl_fromHomeCurrentEntityName  &&  gbl_fromHomeCurrentEntityName.length != 0) { // have to have something to save

        if ( (  gbl_fromHomeLastEntityRemSaved == nil )    ||                                          // if  nil, save
             (  gbl_fromHomeLastEntityRemSaved != nil   &&
               ![gbl_fromHomeLastEntityRemSaved isEqualToString: gbl_fromHomeCurrentEntityName] ) )  // if not equal to last, save
        {

                MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

                [myappDelegate mamb_beginIgnoringInteractionEvents ];
               

                if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {  
                    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"perrem"];
                }
                if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
                    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"grprem"];  
                }

                gbl_fromHomeLastEntityRemSaved = gbl_fromHomeCurrentEntityName;


                [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.6 ];    // after arg seconds
        }
    }   // save the  remember array  gbl_arrayPerRem or gbl_arrayGrpRem
    


//tn();trn("SCROLL 555555555555555555555555555555555555555555555555555555555");

    // deselect    every visible row except selected one
    // unhighlight every visible row except selected one
    //
    NSArray *myVisibleCells = [self.tableView visibleCells]; // If you only want to iterate through the visible cells, then use
tn();
    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
        for (UITableViewCell *myviscell in myVisibleCells) {

//  NSLog(@"cell.textLabel.text=[%@]",myviscell.textLabel.text);
//  NSLog(@"highlighted  viewdidappear     =[%d]",myviscell.highlighted );
//  NSLog(@"selected     viewdidappear     =[%d]",myviscell.selected    );
            if (myviscell.selected == 0) {
                [self.tableView deselectRowAtIndexPath: [self.tableView indexPathForCell: myviscell] // and remove yellow highlight
                                              animated: NO
                ];
                [myviscell setHighlighted: NO
                                 animated: NO  ];
//  NSLog(@"   DID DESELECT!!  ");
//  NSLog(@"   DID UNhighlight!!  ");
//  NSLog(@"   set highlighted to NO");
            }
        }
    });

    // select (highlight) the selected cell
    //
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//NSLog(@"myIdxPath5=%@",myIdxPath);
//NSLog(@"myIdxPath.row5=%ld",(long)myIdxPath.row);
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath: myIdxPath
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionNone
//                              scrollPosition:UITableViewScrollPositionMiddle];
        ];
    }


    //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");

    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                      animated: YES];



    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

} // end of viewDidAppear



- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in willDeselectRowAtIndexPath() in HOME!");

    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.

    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
 
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);

    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);

    
    // here deselect "previously" selected row
    // and remove yellow highlight
    //NSLog(@"willDeselectRowAtIndexPath()  DESELECT #######################################################");
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath   // and remove yellow highlight
                                  animated: NO];
//                                  animated: YES];
    return previouslyselectedIndexPath;

} // end of willDeselectRowAtIndexPath




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSLog(@"in HOME  didSelectRowAtIndexPath ");
  NSLog(@"gbl_colorHomeBG=[%@]",gbl_colorHomeBG);


//    gbl_mynow = [[[NSDate alloc] init] timeIntervalSince1970];
//
//  NSLog(@"gbl_mynow        =[%f]",gbl_mynow );
//  NSLog(@"gbl_lastClick    =[%f]",gbl_lastClick );
//  NSLog(@"gbl_lastIndexPath=[%@]",gbl_lastIndexPath);
//
//    if ((gbl_mynow - gbl_lastClick < 0.3) && [indexPath isEqual: gbl_lastIndexPath]) {
//        // Double tap here
//  NSLog(@"Double Tap!");
//  return;
//    }
//    gbl_lastClick = gbl_mynow;
//    gbl_lastIndexPath = indexPath;



    // selecting home row in yellow "edit mode" gives you  view or change mode
    //
    if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ] )
    {
        gbl_homeEditingState = @"view or change";  // "add" for add a new person or group, "view or change" for tapped person or group
    }

    if ( [gbl_homeUseMODE isEqualToString: @"regular mode" ] )
    {
        gbl_homeEditingState = nil;
        ;  // just go ahead with regular report selection functionality
    }
  NSLog(@"gbl_homeEditingState =[%@]",gbl_homeEditingState );

    [self codeForCellTapOrAccessoryButtonTapWithIndexPath: indexPath ];


//
////     // deselect previous row, select new one  (grey highlight)
////     //
////     // When the user selects a cell, you should respond by deselecting the previously selected cell (
////     // by calling the deselectRowAtIndexPath:animated: method) as well as by
////     // performing any appropriate action, such as displaying a detail view.
////     // 
////     NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];  // this is the "previously" selected row now
////     [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath  // deselect "previously" selected row and remove light grey highlight
////                                   animated: NO];
//// 
////     NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow]; // get the indexpath of current row
////     if(myIdxPath) {
////         [self.tableView selectRowAtIndexPath:myIdxPath // puts highlight on this row (?)
////                                     animated:YES
////                               scrollPosition:UITableViewScrollPositionNone];
////     }
//
//
//// tn();     NSLog(@"in didSelectRowAtIndexPath in home !!!!!!!!!!  BEFORE  !!!!!!!!!!!!!");
////             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
////             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
////             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
////             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
////             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
////             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
////             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
////             //NSLog(@"=%@",);
//// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//
//
//    // this is the "currently" selected row now
//    //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//    
//
//    // below is from prep for segue
//    gbl_savePrevIndexPath  = myIdxPath;
//    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
//    gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
//    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
//        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//    }
//    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
//        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//    }
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//    NSLog(@"home didSelectRow gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//    // above is from prep for segue
//
//
//    const char *my_psvc;  // psv=pipe-separated values
//    char my_psv[1024], psvName[32];
//    my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
//    strcpy(my_psv, my_psvc);
//    strcpy(psvName, csv_get_field(my_psv, "|", 1));
//    NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSString
//
//    gbl_fromHomeCurrentEntityName = myNameOstr;  // like "~Anya" or "~Swim Team"
//    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
//        gbl_lastSelectedPerson = myNameOstr;
//    }
//    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
//        gbl_lastSelectedGroup  = myNameOstr;
//    }
//
//
//// tn();     NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!  AFTER   !!!!!!!!!!!!!");
////             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
////             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
////             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
////             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
////             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
////             //NSLog(@"=%@",);
//// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//
////tn();trn("SCROLL 666666666666666666666666666666666666666666666666666666666");
//    // select the row in UITableView
//    // This puts in the light grey "highlight" indicating selection
//    //[self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
//    [self.tableView selectRowAtIndexPath: myIdxPath
//                                animated: YES
//                          scrollPosition: UITableViewScrollPositionNone];
//
//    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
//    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                      animated: YES];
//    b(31);
//
//
//    if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )   // = yellow
//    {
//  NSLog(@"go to add change ON TAP of ROW");
//
//        // Because background threads are not prioritized and will wait a very long time
//        // before you see results, unlike the mainthread, which is high priority for the system.
//        //
//        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
//        //
//        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            [self performSegueWithIdentifier:@"segueHomeToAddChange" sender:self]; //  
//        });
//
//    } else {
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            [self performSegueWithIdentifier:@"segueHomeToReportList" sender:self]; //  
//        });
//    }
//
//    b(32);
//        
//

} // end of  didSelectRowAtIndexPath: (NSIndexPath *) indexPath


-(void) viewWillAppear:(BOOL)animated
{
 NSLog(@"in viewWillAppear() in home   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");


    //   gbl_homeUseMODE;      // "edit mode" (yellow)   or   "regular mode" (blue)
    if ([gbl_homeUseMODE isEqualToString:@"edit mode"]) {
        [self.tableView setEditing: YES animated: YES];  // turn cocoa editing mode on
//        [self.tableView setEditing: YES animated: NO];  // turn cocoa editing mode on
    } else {
        [self.tableView setEditing: NO  animated: YES];  // turn cocoa editing mode off
//        [self.tableView setEditing: NO  animated: NO];  // turn cocoa editing mode off
    }


    gbl_currentMenuPlusReportCode = @"HOME";  // also set in viewDidAppear for coming back to HOME from other places (INFO ptr)
  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

    // HIDE BOTTOM TOOLBAR (used for edit mode - tap edit button)
    //
    self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 
//    self.segEntityOutlet.backgroundColor = gbl_colorEditingBG;
//    self.segEntityOutlet.backgroundColor = [UIColor clearColor];
//    self.segEntityOutlet.backgroundColor = [UIColor whiteColor];
//    self.segEntityOutlet.backgroundColor = [UIColor redColor];

//    if (self.tableView.editing == YES) self.segEntityOutlet.backgroundColor =  gbl_colorEditingBG;
//    if (self.tableView.editing ==  NO) self.segEntityOutlet.backgroundColor =  [UIColor whiteColor];

}


- (void) doStuffOnEnteringForeground 
{
tn();trn("in doStuffOnEnteringForeground()   NOTIFICATION method     lastEntity stuff");


    //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m

    // get Document directory as URL and Str
    //
    gbl_sharedFM = [NSFileManager defaultManager];
    gbl_possibleURLs = [gbl_sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    gbl_appDocDirURL = nil;
    if ([gbl_possibleURLs count] >= 1) {
        gbl_appDocDirURL = [gbl_possibleURLs objectAtIndex:0];
    }
//    NSString *gbl_appDocDirStr = [gbl_appDocDirURL path];
    
    
        //    gbl_numRowsToTurnOnIndexBar    = 90;
        //
        // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
        //                                 // 6s  = 667.0 x 375  and 6
        //                                 // 5s  = 568.0 x 320  and 5 
        //                                 // 4s  = 480.0 x 320  and 5 
        //
        //  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );
        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            gbl_numRowsToTurnOnIndexBar    = 50;  
            gbl_numRowsToTurnOnIndexBar    = 20;   // for test
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            gbl_numRowsToTurnOnIndexBar    = 45;
            gbl_numRowsToTurnOnIndexBar    = 20;   // for test
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            gbl_numRowsToTurnOnIndexBar    = 38;
            gbl_numRowsToTurnOnIndexBar    = 20;   // for test
        }
        else if (   self.view.bounds.size.width <= 320.0   // ??
        ) {
            gbl_numRowsToTurnOnIndexBar    = 33;
        }

    
    // lastEntity stuff  to (1) highlight correct entity in seg control at top and (2) highlight correct person-or-group
    //
    //

    [myappDelegate mamb_beginIgnoringInteractionEvents ];


    NSString *lastEntityStr = [myappDelegate mambReadLastEntityFile];

    //NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"=|"];
    NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"];
    _arr = [lastEntityStr componentsSeparatedByCharactersInSet: myNSCharacterSet];
     NSLog(@"_arr=%@", _arr);

    gbl_lastSelectionType            = _arr[0];  //  group OR person or pair
    gbl_fromHomeCurrentSelectionType = _arr[0];  //  group OR person or pair
    gbl_fromHomeCurrentEntity        = _arr[0];  //  group OR person or pair

    NSLog(@"gbl_lastSelectionType=%@",gbl_lastSelectionType);
    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
    NSLog(@"gbl_fromHomeCurrentEntity        =[%@]",gbl_fromHomeCurrentEntity        );


//    if ([gbl_lastSelectionType isEqualToString:@"person"]) gbl_colorHomeBG = gbl_colorHomeBG_per;
//    if ([gbl_lastSelectionType isEqualToString:@"group" ]) gbl_colorHomeBG = gbl_colorHomeBG_grp;
//    self.tableView.backgroundColor = gbl_colorHomeBG;       // WORKS
//  NSLog(@"gbl_colorHomeBG=[%@]",gbl_colorHomeBG);


    
    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
      gbl_lastSelectedGroup            = _arr[1];  // like "~Swim Team"
      gbl_lastSelectedPerson           = _arr[3];  // like "~Dave"
      gbl_colorHomeBG                  = gbl_colorHomeBG_grp;
      gbl_currentMenuPrefixFromHome    = @"homg";
      self.tableView.separatorColor    = gbl_colorSepara_grp;
    }
    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
      gbl_lastSelectedPerson           = _arr[1];  // like "~Dave"
      gbl_lastSelectedGroup            = _arr[3];  // like "~Swim Team"
      gbl_colorHomeBG                  = gbl_colorHomeBG_per;
      gbl_currentMenuPrefixFromHome    = @"homp";
      self.tableView.separatorColor    = gbl_colorSepara_per;
    }

    self.tableView.backgroundColor = gbl_colorHomeBG;       // WORKS

    NSLog(@"in doStuffOnEnteringForeground gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
    NSLog(@"in doStuffOnEnteringForeground gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );
//    NSLog(@"gbl_colorHomeBG                                      =[%@]",gbl_colorHomeBG);


    if ([gbl_lastSelectionType isEqualToString:@"group"])  _segEntityOutlet.selectedSegmentIndex = 0; // highlight correct entity in seg ctrl
    if ([gbl_lastSelectionType isEqualToString:@"person"]) _segEntityOutlet.selectedSegmentIndex = 1; // highlight correct entity in seg ctrl

    [self putHighlightOnCorrectRow ];

   
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.3 ];    // after arg seconds

} // end of  doStuffOnEnteringForeground()


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];  // will crash without this
}


//--------------------------------------------------------------------------------------------
// SECTION INDEX VIEW
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;  // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))


//
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?
//
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //   NSMutableArray *myEmptyArray = [NSMutableArray array];
    NSInteger myCountOfRows;
    myCountOfRows = 0;


    if ([gbl_lastSelectionType isEqualToString:@"group"])   myCountOfRows = gbl_arrayGrp.count;
    if ([gbl_lastSelectionType isEqualToString:@"person"])  myCountOfRows = gbl_arrayPer.count;
nbn(160);
  NSLog(@"myCountOfRows              =[%ld]", (long)myCountOfRows );
  NSLog(@"gbl_numRowsToTurnOnIndexBar=[%ld]", (long)gbl_numRowsToTurnOnIndexBar);
    if (myCountOfRows <= gbl_numRowsToTurnOnIndexBar) {
nbn(161);
//        return myEmptyArray ;  // no sectionindex
        return nil ;  // no sectionindex
    }
nbn(162);

    NSArray *mySectionIndexTitles = [NSArray arrayWithObjects:  // 33 items  last index=32
//         @"A", @"B", @"C", @"D",  @"E", @"F", @"G", @"H", @"I", @"J",  @"K", @"L", @"M",
//         @"N", @"O", @"P",  @"Q", @"R", @"S", @"T", @"U", @"V",  @"W", @"X", @"Y", @"Z",   nil ];

            @"TOP",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"__",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"__",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"__",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"END", nil ];



//    @"\U00002533",  // top
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//    @"\U00002500",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//    @"\U00002501",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//    @"\U00002500",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//    @"\U0000253B",  // end
//            nil ];
//


    gbl_numSectionIndexTitles = mySectionIndexTitles.count;

    return mySectionIndexTitles;


//
//    NSMutableSet    *mySetSectionIndexTitles = [[NSMutableSet alloc] init];
//    NSMutableArray  *myArrSectionIndexTitles;
//    NSMutableArray  *mutArrayNewTmp = [[NSMutableArray alloc] init];
//    NSString        *firstLetter, *pername, *grpname;
//
//    // grab ALL  first letters of all entities for use as section index titles
////    if ([gbl_lastSelectionType isEqualToString: @"group"])  {
////        myCountOfRows = gbl_arrayGrp.count;
////        for (NSString *grp in gbl_arrayGrp) {
////            firstLetter = [grp substringFromIndex: 1 ];
////            if ([firstLetter isEqualToString: @"~"]) continue;
////            [mySetSectionIndexTitles addObject: firstLetter ];
////        }
////        myArrSectionIndexTitles = [mySetSectionIndexTitles allObjects];
////    }
////
//    if ([gbl_lastSelectionType isEqualToString: @"person"])  {
//        myCountOfRows = gbl_arrayPer.count;
//        for (NSString *perrec in gbl_arrayPer) {
//  NSLog(@"perrec         =[%@]",perrec);
//            pername = [perrec  componentsSeparatedByString:@"|"][0];  // get fld1 (name) 0-based 
//  NSLog(@"pername =[%@]",pername );
//            if ([pername isEqualToString: @""]  || pername == nil) continue;
//            firstLetter = [pername substringToIndex: 1 ];
//  NSLog(@"firstLetter =[%@]",firstLetter );
//            if ([firstLetter isEqualToString: @"~"]) continue;
//            
//            firstLetter = [firstLetter uppercaseString];
//  NSLog(@"firstLetterU=[%@]",firstLetter );
//
//            [mySetSectionIndexTitles addObject: firstLetter ];
//        }
//    }
//  NSLog(@"mySetSectionIndexTitles =[%@]",mySetSectionIndexTitles );
//
//
//    // tremendous mystery  ??    but it works
//    //
//    NSSortDescriptor *mySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description"  ascending:YES];
//    myArrSectionIndexTitles = [mySetSectionIndexTitles sortedArrayUsingDescriptors:[NSArray arrayWithObject: mySortDescriptor ]];
//
//  NSLog(@"myArrSectionIndexTitles 1 =[%@]",myArrSectionIndexTitles);
//
//    return myArrSectionIndexTitles;
//




} // end of sectionIndexTitlesForTableView


//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
// {
//    [super touchesEnded:touches withEvent:event];
//
//  NSLog(@"in touchesEnded !");
//
//     if(((UITouch *)[touches anyObject]).tapCount == 2)
//    {
//    NSLog(@"DOUBLE TOUCH");
//    }
//}
//


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{

  NSLog(@"sectionForSectionIndexTitle!  in HOME");
  NSLog(@"title=[%@]",title);
  NSLog(@"atIndex=[%ld]",(long)index);



    // find first group starting with title letter (guaranteed to be there, see sectionIndexTitlesForTableView )
    NSInteger newRow;  newRow = 0;
    NSIndexPath *newIndexPath;
    NSInteger myCountOfRows;
    NSString *pername, *grpname;

//    if ([gbl_lastSelectionType isEqualToString:@"group"])  {
//        myCountOfRows = gbl_arrayGrp.count;
//        for (NSString *grp in gbl_arrayGrp) {
//            newRow = newRow + 1;
//            if ([grp hasPrefix: title])  break;
//        }
//    }
//    if ([gbl_lastSelectionType isEqualToString:@"person"])  {
//        myCountOfRows = gbl_arrayPer.count;
//        for (NSString *perrec in gbl_arrayPer) {
//            pername = [perrec  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 
//  NSLog(@"pername =[%@]",pername );
//  NSLog(@"newRow  =[%ld]",(long)newRow );
//            if ([pername hasPrefix: @"~"]) continue;
//            newRow = newRow + 1;
//            if ([pername hasPrefix: title])  break;
//        }
//    }
//  NSLog(@"newRow =[%ld]",(long)newRow );
//
//    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
//    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];
//


    if ([gbl_lastSelectionType isEqualToString:@"group"])   myCountOfRows = gbl_arrayGrp.count;
    if ([gbl_lastSelectionType isEqualToString:@"person"])  myCountOfRows = gbl_arrayPer.count;

    if ([title isEqualToString:@"TOP"]) newRow = 0;
    if ([title isEqualToString:@"END"]) newRow = myCountOfRows - 1;
    if (   [title isEqualToString:@" "]
        || [title isEqualToString:@"__"]
    )   newRow = ((double) (index + 1) / (double) gbl_numSectionIndexTitles ) * (double)myCountOfRows ;
    if (   [title isEqualToString:@"x"] )
    {  // position at row last used  (highlight row)
nbn(151);
        [self putHighlightOnCorrectRow ];
    }

    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];

    return index;

} // sectionForSectionIndexTitle


//
//// Return the index for the location of the first item in an array that begins with a certain character
//- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
//{
//    NSUInteger count = 0;
//    for (NSString *str in array) {
//        if ([str hasPrefix:character]) {
//          return count;
//        }
//        count++;
//    }
//    return 0;
//}
//
//
//// Return the index for the location of the first item in an array that begins with a certain character
//// Here is a modified version of Kyle's function that handles the case of clicking an index for which you do not have a string:
////
//- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
//{
//    char testChar = [character characterAtIndex:0];
////    __block int retIdx = 0;
////    __block int lastIdx = 0;
////    __block int retIdx = 0;
////    __block int lastIdx = 0;
//    __block unsigned long retIdx = 0;
//    __block unsigned long lastIdx = 0;
//
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        char firstChar = [obj characterAtIndex:0];
//
//        if (testChar == firstChar) {
//            retIdx = idx;
//            *stop = YES;
//        }
//
//        //if we overshot the target, just use whatever previous one was
//        if (testChar < firstChar) {
//            retIdx = lastIdx;
//            *stop = YES;
//        }
//
//        lastIdx = idx;
//    }];
//    return retIdx;
//}
//

// end of 
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?

// end of SECTION INDEX VIEW
//--------------------------------------------------------------------------------------------

// ===  EDITING  ================================================================================
//
//   https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/EnablingEditModeinaViewController/EnablingEditModeinaViewController.html#//apple_ref/doc/uid/TP40007457-CH14-SW5
//
// When implementing your navigation interface, you can include a special Edit button in the navigation bar
// when your editable view controller is visible.
// (You can get this button by calling the editButtonItem method of your view controller.)
//
// WHEN TAPPED, THIS BUTTON AUTOMATICALLY TOGGLES BETWEEN AN eDIT AND dONE BUTTON AND
// CALLS YOUR VIEW CONTROLLER’S  setEditing:animated:  METHOD WITH APPROPRIATE VALUES.
//
// You can also call this method from your own code (or modify the value of your view controller’s editing property) to toggle between modes.
//
- (void)setEditing: (BOOL)flag // editButtomItem AUTOMATICALLY TOGGLES BETWEEN AN Edit(flag=y) & Done(flag=n) BUTTON AND CALLS setEditing
          animated: (BOOL)animated
{
tn();  NSLog(@"setEditing !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  NSLog(@"=%d",flag);
  NSLog(@"=%d",animated);


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

//    int64_t myDelayInSec   = 2.33 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 0.33 * (double)NSEC_PER_SEC;
    int64_t myDelayInSec   = 0.38 * (double)NSEC_PER_SEC;
    dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);

    dispatch_after(mytime, dispatch_get_main_queue(), ^{                     // do after delay of  mytime

        //// start DO STUFF HERE


    [super setEditing: flag animated: animated];




    if (flag == YES) { // Change views to edit mode.   USER TAPPED EDIT BUTTON HERE


  NSLog(@"EDIT BUTTON 2    ");
  NSLog(@"gbl_homeUseMODE 1   =[%@]",gbl_homeUseMODE );

        gbl_homeUseMODE = @"edit mode";   // determines home mode  @"edit mode" or @"regular mode"
  NSLog(@"gbl_homeUseMODE 2   =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
nbn(300);

//  NSLog(@"gbl_homeLeftItemsWithAddButton=%@",gbl_homeLeftItemsWithAddButton);
//  NSLog(@"gbl_homeLeftItemsWithNoAddButton=%@",gbl_homeLeftItemsWithNoAddButton);
  NSLog(@"EDIT BUTTON 2   set yellow   BG color");

  NSLog(@"gbl_colorEditingBG=[%@]",gbl_colorEditingBG);

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

//            [self.editButtonItem setBackgroundImage: gbl_BlueBG          // regular report mode bg color for button
//            [self.editButtonItem setBackgroundImage: gbl_blueDone          // regular report mode bg color for button
            [self.editButtonItem setBackgroundImage: gbl_brownDone          // regular report mode bg color for button
                                           forState: UIControlStateNormal  
                                         barMetrics: UIBarMetricsDefault
            ];

//            self.navigationItem.leftBarButtonItems = gbl_homeLeftItemsWithAddButton;
  NSLog(@"EDIT BUTTON 2   set title  done tab");
            // self.editButtonItem.title = @"Done\t";  // pretty good
            self.editButtonItem.title = @"Done";  // ok with no tab
            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-8.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 

            self.view.backgroundColor     = gbl_colorEditingBG;

        });



//    self.navigationController.navigationBar.barTintColor =  gbl_colorEditing;  does whole nav bar



        gbl_colorHomeBG               = gbl_colorEditingBG;  // temporary color for editing 

nbn(3);
//        self.segmentedControl.backgroundColor = gbl_colorEditingBG;     // [UIColor cb_Grey3Color];
//        self.segEntityOutlet.backgroundColor = gbl_colorEditingBG;     


        // UITableViewCellAccessoryDisclosureIndicator,    tapping the cell triggers a push action
        // UITableViewCellAccessoryDetailDisclosureButton, tapping the cell allows the user to configure the cell’s contents
        //

        // GOLD:  http://stackoverflow.com/questions/18740594/in-ios7-uitableviewcellaccessorydetaildisclosurebutton-is-divided-into-two-diff
        // This is the correct behavior.
        // In iOS 7, 
        // UITableViewCellAccessoryDetailDisclosureButton    you show both the "detail button" and the "disclosure indicator" 
        // UITableViewCellAccessoryDetailButton              If you'd only like the "i" button
        // UITableViewCellAccessoryDisclosureIndicator       if you'd only like the "disclosure indicator
        // 
        gbl_home_cell_AccessoryType        = UITableViewCellAccessoryNone;
//      gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton; // home mode edit    with tap giving record details
        gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryDetailButton; // home mode edit    with tap giving record details

    
        [self.tableView reloadData]; // reload to    edit mode    reload reload reload reload reload reload ");

//tn();trn("reload to    edit mode    reload reload reload reload reload reload ");


//
////        self.editButtonItem.tintColor = [UIColor redColor];   // colors text
//        NSInteger buttonctr;
//        buttonctr = 0;
//        for (UIView *myview in self.navigationController.navigationBar.subviews) {
////NSLog(@"NAV BAR subview class DESCRIPTION=[%@]", [[myview class] description]);
//
//// fun test
////if (buttonctr == 0)  myview.backgroundColor = [UIColor grayColor];
////if (buttonctr == 1)  myview.backgroundColor = [UIColor cyanColor];
////if (buttonctr == 2)  myview.backgroundColor = [UIColor blueColor];
////if (buttonctr == 3)  myview.backgroundColor = [UIColor greenColor];
////if (buttonctr == 4)  myview.backgroundColor = [UIColor redColor];
////if (buttonctr == 5)  myview.backgroundColor = [UIColor orangeColor];
////if (buttonctr == 6)  myview.backgroundColor = [UIColor blackColor];
//            buttonctr = buttonctr + 1;
//
//            if ([[[myview class] description] isEqualToString:@"UINavigationButton"]) {
////  NSLog(@"buttonctr =%ld", buttonctr);
//
////                myview.backgroundColor = gbl_colorEditing;
//
////                self.editButtonItem.tintColor = [UIColor blackColor];   // colors text
////                self.editButtonItem.tintColor = [UIColor redColor];   // colors text
//            }
//
//        }


nbn(4);
    [self putHighlightOnCorrectRow ];
nbn(5);

        // Change views to   edit mode.

    } else { // Save the changes if needed and change the views to noneditable.   USER TAPPED  DONE BUTTON HERE

        // Change views from edit mode.

  NSLog(@"EDIT BUTTON 3 ");
  NSLog(@"gbl_homeUseMODE 1   =[%@]",gbl_homeUseMODE );

        gbl_homeUseMODE = @"regular mode";   // determines home mode  @"edit mode" or @"regular mode"
  NSLog(@"gbl_homeUseMODE 2   =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
nbn(311);


  NSLog(@"EDIT BUTTON 3   set home non-edit   BG color");
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

//            [self.editButtonItem setBackgroundImage: gbl_YellowBG          // regular report mode bg color for button
            [self.editButtonItem setBackgroundImage: gbl_yellowEdit          // edit mode bg color for button
                                           forState: UIControlStateNormal  
                                         barMetrics: UIBarMetricsDefault
            ];

//            self.navigationItem.leftBarButtonItems = gbl_homeLeftItemsWithAddButton;
  NSLog(@"EDIT BUTTON 3   set title  edit tab");
//            self.editButtonItem.title = @"Edit\t";  // pretty good
            self.editButtonItem.title = @"Edit";  // ok with no tab


//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-12.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-8.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-16.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 

//            self.view.backgroundColor     = gbl_colorEditingBG;

            if (     [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) [self.tableView setBackgroundColor: gbl_colorEditingBG];
            else if ([gbl_lastSelectionType isEqualToString:@"person"]) [self.tableView setBackgroundColor: gbl_colorHomeBG_per];
            else if ([gbl_lastSelectionType isEqualToString:@"group" ]) [self.tableView setBackgroundColor: gbl_colorHomeBG_grp];

        });

 

        // try with add button always
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.navigationItem.leftBarButtonItems = gbl_homeLeftItemsWithNoAddButton;
//        });

//        gbl_colorHomeBG                = gbl_colorHomeBG_save;  // in order to put back after editing mode color

        if ([gbl_lastSelectionType isEqualToString:@"person"]) gbl_colorHomeBG = gbl_colorHomeBG_per;
        if ([gbl_lastSelectionType isEqualToString:@"group" ]) gbl_colorHomeBG = gbl_colorHomeBG_grp;
        self.tableView.backgroundColor = gbl_colorHomeBG;       // WORKS

        // UITableViewCellAccessoryDisclosureIndicator,    tapping the cell triggers a push action
        // UITableViewCellAccessoryDetailDisclosureButton, tapping the cell allows the user to configure the cell’s contents
        //
        gbl_home_cell_AccessoryType        = UITableViewCellAccessoryDisclosureIndicator; // home mode regular with tap giving report list
        gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryNone;                // home mode regular with tap giving report list

        [self.tableView reloadData]; // reload to regular mode    reload reload reload reload reload reload ");

//        tn();trn("reload to regular mode    reload reload reload reload reload reload ");

// forget all special colors
//        for (UIView *myview in self.navigationController.navigationBar.subviews) {
//            NSLog(@"%@", [[myview class] description]);
//            if ([[[myview class] description] isEqualToString:@"UINavigationButton"]) {
//
////                myview.backgroundColor = gbl_color_cAplTop;
//                self.editButtonItem.tintColor = gbl_color_cAplBlue;   // colors text
//            }
//
//        }
        
//        NSMutableArray *myMutableLeftItems = [NSMutableArray arrayWithArray: self.navigationItem.leftBarButtonItems ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [ myMutableLeftItems removeObjectAtIndex: 1 ];                 // remove add button from array
//            self.navigationItem.leftBarButtonItems = myMutableLeftItems;
//        });
//

nbn(9);
    [self putHighlightOnCorrectRow ];
nbn(10);


    } // Change views from edit mode.


        //// end DO STUFF HERE



    [self.view setUserInteractionEnabled: YES];                          // this works to disable user interaction for "mytime"

    }); // do after delay of  mytime


    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

//    [self putHighlightOnCorrectRow ];


} // end of  setEditing: (BOOL)flag   animated: (BOOL)animated



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
tn();    NSLog(@"reaching accessoryButtonTappedForRowWithIndexPath:");


    gbl_accessoryButtonTapped = 1;


    [self codeForCellTapOrAccessoryButtonTapWithIndexPath: indexPath ];

    gbl_homeUseMODE      = @"edit mode" ;
    gbl_homeEditingState = @"view or change" ;
}


//NSString *gbl_homeUseMODE;      // "edit mode" (yellow)   or   "regular mode" (blue)
//NSString *gbl_homeEditingState; // if gbl_homeUseMODE = "edit mode"    then can be "add" or "view or change"   for tapped person or group
///
- (void) codeForCellTapOrAccessoryButtonTapWithIndexPath:(NSIndexPath *)indexPath  // for  gbl_homeUseMODE  =  "edit mode" (yellow)
{
tn();    NSLog(@"in codeForCellTapOrAccessoryButtonTapWithIndexPath:");
  NSLog(@"gbl_homeUseMODE           =[%@]",gbl_homeUseMODE           );
  NSLog(@"gbl_fromHomeCurrentEntity =[%@]",gbl_fromHomeCurrentEntity );

        // philosophy  on people list yellow  OR  on group list yellow 
        //
        // gbl_homeUseMODE isEqualToString: @"edit mode" // = yellow
        //   CASE_A   - tap on right side "i" button  ALWAYS  get add/change  screen
        //            - tap on left  side "-" button  ALWAYS  get delete  of person or group
        //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)
        //   CASE_C   - tap on name in cell - for "person"  get add/change  screen
        //

// 2016014  change behaviour to do edit details now, instead of nothing
// //      //   CASE_C   - tap on name in cell - for "person"  get nothing
//    if (   [gbl_homeUseMODE           isEqualToString: @"edit mode" ]     // = yellow
//        && [gbl_fromHomeCurrentEntity isEqualToString: @"person"]         // = group list
//        && gbl_accessoryButtonTapped                == 0              )   // tapped on row, not "i"
//    { 
//        //   CASE_C     - for "person"  get nothing
//        return;  // see above philosophy // if you tap on person name in yellow edit person list, do nothing
//    }
//

nbn(3);

//     // deselect previous row, select new one  (grey highlight)
//     //
//     // When the user selects a cell, you should respond by deselecting the previously selected cell (
//     // by calling the deselectRowAtIndexPath:animated: method) as well as by
//     // performing any appropriate action, such as displaying a detail view.
//     // 
//     NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];  // this is the "previously" selected row now
//     [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath  // deselect "previously" selected row and remove light grey highlight
//                                   animated: NO];
// 
//     NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow]; // get the indexpath of current row
//     if(myIdxPath) {
//         [self.tableView selectRowAtIndexPath:myIdxPath // puts highlight on this row (?)
//                                     animated:YES
//                               scrollPosition:UITableViewScrollPositionNone];
//     }


// tn();     NSLog(@"in didSelectRowAtIndexPath in home !!!!!!!!!!  BEFORE  !!!!!!!!!!!!!");
//             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
//             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
//             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
//             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//             //NSLog(@"=%@",);
// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");


    // this is the "currently" selected row now
    //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    NSIndexPath *myIdxPath = indexPath;  // method argument
    

    // set some gbl s

    // below is from prep for segue

    gbl_savePrevIndexPath  = myIdxPath;
    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
    gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
    }
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
    }
//  NSLog(@"home didSelectRow CurrentSelectionArrayIdx=%ld",(long)myIdxPath.row);  not USED
  NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
  NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
  NSLog(@"home didSelectRow gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_fromHomeCurrentEntityName=[%@]",gbl_fromHomeCurrentEntityName);
  NSLog(@"home didSelectRow gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
    // above is from prep for segue


    const char *my_psvc;  // psv=pipe-separated values
    char my_psv[1024], psvName[32];
    my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
    strcpy(my_psv, my_psvc);
    strcpy(psvName, csv_get_field(my_psv, "|", 1));
    NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSString

    gbl_fromHomeCurrentEntityName = myNameOstr;  // like "~Anya" or "~Swim Team"
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        gbl_lastSelectedPerson = myNameOstr;
    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
        gbl_lastSelectedGroup  = myNameOstr;
    }

//             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);

  NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);



//tn();trn("SCROLL 666666666666666666666666666666666666666666666666666666666");
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    //[self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
    [self.tableView selectRowAtIndexPath: myIdxPath
                                animated: YES
                          scrollPosition: UITableViewScrollPositionNone];

    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                      animated: YES];

    if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )   // = yellow
    {
//  NSLog(@"go to add change ON TAP of ROW");

        // philosophy  on people list yellow  OR  on group list yellow 
        //
        // gbl_homeUseMODE isEqualToString: @"edit mode" // = yellow
        //   CASE_A   - tap on right side "i" button  ALWAYS  get add/change  screen
        //            - tap on left  side "-" button  ALWAYS  get delete  of person or group
        //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)
        //   CASE_C   - tap on name in cell - for "person"  get nothing  (see above)
        //

        // oN TAP of accessory button (\"i\") in edit mode,   always  go to  add/change screen");
        if (gbl_accessoryButtonTapped == 1)  {
  NSLog(@"ON TAP of accessory button (\"i\"); // go to  add/change screen");

            //   CASE_A   - tap on right side "i" button  ALWAYS  get add/change  screen

            gbl_accessoryButtonTapped = 0;   // reset this to default  (could be = 1 here)

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];

            // Because background threads are not prioritized and will wait a very long time
            // before you see results, unlike the mainthread, which is high priority for the system.
            //
            // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
            //
            dispatch_async(dispatch_get_main_queue(), ^{                           
                [self performSegueWithIdentifier: @"segueHomeToAddChange" sender:self]; //  
            });
            
            return;
        }



        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group"])
        {
  NSLog(@"ON TAP of ROW in yellow edit mode and Group list,   go to  selPerson screen with group members");
  
            //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)

            gbl_groupMemberSelectionMode = @"none";  // to set this, have to tap "+" or "-" in selPerson

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];

            dispatch_async(dispatch_get_main_queue(), ^{                                
                [self performSegueWithIdentifier: @"segueHomeToListMembers" sender:self]; // selPerson screen where you can "+" or "-" group members
            });

            return;
        }
        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person"])
        {

            gbl_accessoryButtonTapped = 0;   // reset this to default  (could be = 1 here)

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];

            // Because background threads are not prioritized and will wait a very long time
            // before you see results, unlike the mainthread, which is high priority for the system.
            //
            // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
            //
            dispatch_async(dispatch_get_main_queue(), ^{                           
                [self performSegueWithIdentifier: @"segueHomeToAddChange" sender:self]; //  
            });
            
            return;
        }


    }  // if edit mode

    else
    { // this is "regular mode"  as opposed to "edit mode"

        if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
            // check for not enough group members  to do a report

            // search in  gbl_arrayMem  for   gbl_lastSelectedGroup
            // count how many members
            // if not at least 2 members,  alert and return
            //
      NSLog(@"gbl_lastSelectedGroup =[%@]",gbl_lastSelectedGroup );

            NSInteger member_cnt;
            NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_lastSelectedGroup ];

            member_cnt = 0;
            for (NSString *element in gbl_arrayMem) {
                if ([element hasPrefix: prefixStr]) {
                    member_cnt = member_cnt + 1;
                }
            }

      NSLog(@"prefixStr  =[%@]",prefixStr );
      NSLog(@"member_cnt =[%ld]",(long) member_cnt );

            if (member_cnt  <  2) {

                // here info is missing
                NSString *missingMsg;
                
                if (member_cnt == 0) missingMsg = [ NSString stringWithFormat:
                    @"A group report needs\nat least 2 members.\n\nGroup \"%@\" has %ld members.",
                    gbl_lastSelectedGroup, member_cnt
                ];
    //            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Need more Group Members"
                UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Not enough Group Members"
                                                                                 message: missingMsg
                                                                          preferredStyle: UIAlertControllerStyleAlert  ];
                 
                UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                    style: UIAlertActionStyleDefault
                                                                  handler: ^(UIAlertAction * action) {
                        NSLog(@"Ok button pressed");
                    }
                ];
                 
                [myAlert addAction:  okButton];

                // cannot goto report list   because of missing information > stay in this screen
                //
                [self presentViewController: myAlert  animated: YES  completion: nil   ];

                return;  // cannot got rpt list   because of missing information > stay in this screen
            }
        } // if we are in group, check for enough members for a report

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];

        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
            [self performSegueWithIdentifier:@"segueHomeToReportList" sender:self]; //  
        });
    
        return;

    }  // regular mode

    b(32);
        
} // end of codeForCellTapOrAccessoryButtonTap  



//
// ===  end of EDITING  ================================================================================


- (void) putHighlightOnCorrectRow 
{
nbn(357);
  NSLog(@"in putHighlightOnCorrectRow  ");
  NSLog(@"gbl_lastSelectedPerson=[%@]",gbl_lastSelectedPerson);

// return; // for test empty Launch image


        NSString  *nameOfGrpOrPer;
        NSInteger idxGrpOrPer;
        NSArray *arrayGrpOrper;
        idxGrpOrPer = -1;   // zero-based idx

        if ([gbl_lastSelectionType isEqualToString:@"group"]) {

            for (id eltGrp in gbl_arrayGrp) { // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
              idxGrpOrPer = idxGrpOrPer + 1;
    //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
    //NSLog(@"eltGrp=%@", eltGrp);
              NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
              arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
              nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

              if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedGroup]) {
                break;
              }
            } // search thru gbl_arrayGrp
    //NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  


        // get the indexpath of row num idxGrpOrPer in tableview
                NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
        //tn();trn("SCROLL 111111111111111111111111111111111111111111111111111111111");

                // select the row in UITableView
                // This puts in the light grey "highlight" indicating selection
                [self.tableView selectRowAtIndexPath: foundIndexPath 
                                            animated: YES
                                      scrollPosition: UITableViewScrollPositionNone];
                //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
                [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                          animated: YES];
            });
        }

        if ([gbl_lastSelectionType isEqualToString:@"person"]) {

//            NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
            
            do { // highlight gbl_lastSelectedPerson row in tableview

                for (id eltPer in gbl_arrayPer) {  // find index of gbl_lastSelectedPerson (like "~Dave") in gbl_arrayPer
                    idxGrpOrPer = idxGrpOrPer + 1; 
              NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
              NSLog(@"eltPer=%@", eltPer);

                  NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
                  arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
                  nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

                  if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
                    break;
                  }
                } // search thru gbl_arrayPer
//        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

                dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

                    // get the indexpath of row num idxGrpOrPer in tableview
                    NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
    //        NSLog(@"foundIndexPath=%@",foundIndexPath);
    //        NSLog(@"foundIndexPath.row=%ld",(long)foundIndexPath.row);


                    // select the row in UITableView
                    // This puts in the light grey "highlight" indicating selection
                    [self.tableView selectRowAtIndexPath: foundIndexPath 
                                                animated: YES
                                          scrollPosition: UITableViewScrollPositionMiddle];
        //                                  scrollPosition: UITableViewScrollPositionNone];
                    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 

                    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                                      animated: YES];
                });

            } while (FALSE); // END highlight lastEntity row in tableview

        }

} //  putHighlightOnCorrectRow 

@end





// for test
//     do {  // update delimited string  for saving selection in remember fields
//         NSLog(@"before ®gbl_arrayPer 0 =%@",gbl_arrayPer[0]);
//         MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
//         NSString *myStrToUpdate = gbl_arrayPer[0];
//         NSString *myupdatedStr =
//         [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
//                                  delimitedBy: (NSString *) @"|"
//                     updateOneBasedElementNum: (NSInteger)  11
//                               withThisString: (NSString *) @"not locked"
//          ];
//         gbl_arrayPer[0] = myupdatedStr;
//         NSLog(@"after gbl_arrayPer 0 =%@",gbl_arrayPer[0]);
//     } while (FALSE);
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  12
//                          withThisString: (NSString *) @"2005"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  13
//                          withThisString: (NSString *) @"20141205"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  14
//                          withThisString: (NSString *) @"~Liz"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
//    myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myupdatedStr
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  15
//                          withThisString: (NSString *) @"~Family"
//     ];
//    gbl_arrayPer[0] = myupdatedStr;
// for (id eltTst in gbl_arrayPer) { NSLog(@"aft eltGrp=%@", eltTst); }

//            ret01 = [arrayMAMBexampleGroup   writeToURL:gbl_URLToGroup atomically:YES];
//            if (!ret01)  NSLog(@"Error write to Grp \n  %@", [err01 localizedFailureReason]);
//
//
//            ret01 = [arrayMAMBexamplePerson       writeToURL:gbl_URLToPerson atomically:YES];
//            if (!ret01)  NSLog(@"Error write to Per \n  %@", [err01 localizedFailureReason]);
//

//
//            ret01 = [arrayMAMBexampleMember writeToURL:gbl_URLToMember atomically:YES];
//            if (!ret01)  NSLog(@"Error write to Mem \n  %@", [err01 localizedFailureReason]);
//

//NSLog(@"arrayMAMBexampleGroup=%@",arrayMAMBexampleGroup);
//            NSLog(@"arrayMAMBexampleMember=%@",arrayMAMBexampleMember);
//            tn();trn("after writeMemberArray");
//
//    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];   // for test member
//    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
//kin(haveGrp);
//kin(havePer);
//kin(haveMem);
//[myappDelegate mambReadMemberFile];
//tn();  NSLog(@"after test read Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//

    //[myMA sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //  for (id eltTst in gbl_arrayGrp) { NSLog(@"eltGrp=%@", eltTst); }
    //    // Log all data file contents
    //        NSMutableArray *arrayTst;
    //        arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToGroup];
    //        if (arrayTst == nil) { NSLog(@"%@", @"Error reading Grp"); }
    //        for (id eltTst in arrayTst) { NSLog(@"eltGrp=%@", eltTst); }
    //
    //    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToPerson];
    //    if (arrayTst == nil) { NSLog(@"%@", @"Error reading Per"); }
    //    for (id eltTst in arrayTst) { NSLog(@"eltPer=%@", eltTst); }
    //    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToMember];
    //    if (arrayTst == nil) { NSLog(@"%@", @"Error reading Mem"); }
    //    for (id eltTst in arrayTst) { NSLog(@"eltMem=%@", eltTst); }
    

    // Log all data in gbl_arrayPer file array contents
    // for (id eltTst in gbl_arrayPer) { NSLog(@"bef eltGrp=%@", eltTst); }

//
////    gbl_arrayMem = [[NSMutableArray alloc] initWithContentsOfURL:gbl_URLToMember];
////    if (gbl_arrayMem == nil) { NSLog(@"%@", @"Error reading Mem"); }
////
//tn();  NSLog(@"before test read Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//tn();  NSLog(@"before sort Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//            NSLog(@"arrayMAMBexampleMember=%@",arrayMAMBexampleMember);
//            tn();trn("after writeMemberArray");
//    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];   // for test member
//    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
//kin(haveGrp);
//kin(havePer);
//kin(haveMem);
//tn();  NSLog(@"after sort Member  gbl_arrayMem=\n%@", gbl_arrayMem);tn();
//


//
//        haveGrpLastGood = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroupLastGood];
//        havePerLastGood = [gbl_sharedFM fileExistsAtPath: gbl_pathToPersonLastGood];
//        haveMemLastGood = [gbl_sharedFM fileExistsAtPath: gbl_pathToMemberLastGood];
//kin(havePerLastGood );
//kin(haveGrpLastGood );
//kin(haveMemLastGood );
//
////havePerLastGood = NO;  // for test put new example per data
//
//        NSLog(@"%d  %d  %d", haveGrpLastGood, havePerLastGood, haveMemLastGood);
//
//        if ( haveGrpLastGood && havePerLastGood && haveMemLastGood ) {
//            NSLog(@"%@", @"use  LastGood files!");
//            //      remove all regular named files (these cannot exist - no overcopy)
//            [gbl_sharedFM removeItemAtURL:gbl_URLToGroup error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToPerson error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToMember error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Mem %@", err01); }
//
//            //      copy lastGood DB files to regular names
//            [gbl_sharedFM copyItemAtURL:gbl_URLToGroupLastGood toURL:gbl_URLToGroup error:&err01];
//            if (err01) { NSLog(@"cp lg to grp %@", err01); }
//            [gbl_sharedFM copyItemAtURL:gbl_URLToPersonLastGood toURL:gbl_URLToPerson error:&err01];
//            if (err01) { NSLog(@"cp lg to per %@", err01); }
//            [gbl_sharedFM copyItemAtURL:gbl_URLToMemberLastGood toURL:gbl_URLToGroup error:&err01];
//            if (err01) { NSLog(@"cp lg to Mem %@", err01); }
//


//
//            // remove any lastGood files (err code NSFileNoSuchFileError = 4)
//            [gbl_sharedFM removeItemAtURL:gbl_URLToGroupLastGood error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grpLg %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToPersonLastGood error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"perLg %@", err01); }
//            [gbl_sharedFM removeItemAtURL:gbl_URLToMemberLastGood error:&err01];
//            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"MemLg %@", err01); }
//
            
            // write out example data files from internal arrays
//


    
    // check if DB files are there
    // if all are there, good to go
    // else {

//    //   if all lastGood are there,
//    //      remove all regular named files
//    //      copy lastGood DB files to regular names
//    //   else
//    //      remove any lastGood files
//

    //      write example data from arrays into new DB files
    // }
    // read regular DB files into arrays



//
//    // This is the initial example data in DB when app first starts.
//    // This is NOT the ongoing data, which is in ".txt" data files.
//    //
//    NSArray *arrayMAMBexampleGroup =   // field 1=name-of-group  field 2=locked-or-not
//    @[
//      @"~Swim Team||",
//      @"~My Family||",
//      ];
//    NSArray *arrayMAMBexamplePerson = // field 11= locked or not
//    @[
//      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States||",
//      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States||",
//      @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
//      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
//      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
//      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||",
//      @"~Mike|4|20|1992|6|30|1|Los Angeles|California|United States||",
//      @"~Anya 789012345|10|19|1990|8|20|0|Los Angeles|California|United States||",
//      @"~Billy 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
//      @"~Emma|5|17|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Jacob|10|10|1992|0|1|1|Los Angeles|California|United States||",
//      @"~Grace|8|21|1994|1|20|0|Los Angeles|California|United States||",
//      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States||",
//      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States||",
//      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||",
//      @"~Jim|2|3|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Olivia|4|13|1994|0|53|1|Los Angeles|California|United States||",
//      @"~Dave|4|8|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States||",
//      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
//      @"~Susie|2|3|1992|8|10|0|Los Angeles|California|United States||",
//      ];
//    NSArray *arrayMAMBexampleMember =
//    @[
//      @"~My Family|~Brother|",
//      @"~My Family|~Father|",
//      @"~My Family|~Grandma|",
//      @"~My Family|~Mother|",
//      @"~My Family|~Sister1|",
//      @"~My Family|~Sister2|",
//      @"~Swim Team|~Anya|",
//      @"~Swim Team|~Billy 89012345|",
//      @"~Swim Team|~Dave|",
//      @"~Swim Team|~Emma|",
//      @"~Swim Team|~Grace|",
//      @"~Swim Team|~Ingrid|",
//      @"~Swim Team|~Jacob|",
//      @"~Swim Team|~Jen|",
//      @"~Swim Team|~Jim|",
//      @"~Swim Team|~Liz|",
//      @"~Swim Team|~Mike|",
//      @"~Swim Team|~Noah|",
//      @"~Swim Team|~Olivia|",
//      @"~Swim Team|~Sophie|",
//      @"~Swim Team|~Susie|",
//      ];
//
//    // REMEMBER DATA for each Group 
//    //     field 1  name-of-group
//    //     field 2  last report selected for this Group:
//    //              ="m"  for   "Best Match"
//    //              ="a"  for   "Most Assertive Person"
//    //              ="e"  for   "Most Emotional"
//    //              ="r"  for   "Most Restless"
//    //              ="p"  for   "Most Passionate"
//    //              ="d"  for   "Most Down-to-earth"
//    //              ="u"  for   "Most Ups and Downs"
//    //              ="y"  for   "Best Year ..."
//    //              ="d"  for   "Best Day ..."
//    //     field  3  last year  last selection for this report parameter for this Group
//    //     field  4  day        last selection for this report parameter for this Group
//    //     + extra "|" at end
//    // 
//    NSArray *arrayMAMBexampleGroupRemember = 
//    @[
//      @"~Family||||",
//      @"~My Family||||",
//      ];
//
//    // REMEMBER DATA for each Person
//    //     field 1  name-of-person
//    //     field 2  last report selected for this Person:
//    //              ="m"  for   "Best Match"
//    //              ="y"  for   "Calendar Year ...",
//    //              ="p"  for   "Personality",
//    //              ="c"  for   "Compatibility Paired with ...",
//    //              ="g"  for   "My Best Match in Group ...",
//    //              ="d"  for   "How was your Day? ...",
//    //     field 3  last year
//    //     field 4  person
//    //     field 5  group
//    //     field 6  day
//    //              extra "|" at end
//    //
//    NSArray *arrayMAMBexamplePersonRemember = 
//    @[
//      @"~Father||||||",
//      @"~Mother||||||",
//      @"~Sister1||||||",
//      @"~Sister2||||||",
//      @"~Brother||||||",
//      @"~Grandma||||||",
//      @"~Mike||||||",
//      @"~Anya 789012345||||||",
//      @"~Billy 89012345||||||",
//      @"~Emma||||||",
//      @"~Jacob||||||",
//      @"~Grace||||||",
//      @"~Ingrid||||||",
//      @"~Jen||||||",
//      @"~Liz||||||",
//      @"~Jim||||||",
//      @"~Olivia||||||",
//      @"~Dave||||||",
//      @"~Noah||||||",
//      @"~Sophia||||||",
//      @"~Susie||||||",
//      ];
//
//    
//    //    for (id s in arrayMAMBexampleGroup)       {NSLog(@"eltG: %@",s);}
//    //    for (id s in arrayMAMBexampleperson)      {NSLog(@"eltP: %@",s);}
//    //    for (id s in arrayMAMBexampleMember)      {NSLog(@"eltGM: %@",s);}
//    //
//    
//

// into read func
//         //NSString *pathToLastEntity = [appDocDirStr stringByAppendingPathComponent: @"mambLastEntity.txt"];
//         NSString *pathToLastEntity = [appDocDirStr stringByAppendingPathComponent: @"mambd1"];
//         NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];
// 
//          // for test, remove lastEntity file
//          //  [sharedFM removeItemAtURL:URLToLastEntity
//          //                      error:&err01];
//          //  if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity test rm %@", err01); }
// 
//         BOOL haveLastEntity        = [sharedFM fileExistsAtPath: pathToLastEntity];
// NSLog(@"haveLastEntity= %@", (haveLastEntity? @"YES" : @"NO"));
// NSLog(@"haveLastEntity= %d", haveLastEntity);
//         
//         // haveLastEntity = NO;
//         
//         if ( ! haveLastEntity ) {
// nb(20);
//             // remove old, write out new lastEntity file with default entity
//             [sharedFM removeItemAtURL:URLToLastEntity
//                                 error:&err01];
//             if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity %@", err01); }
//             
//             NSString *defaultEntity = @"person|~Anya|group|~Swim Team";
//             ret01 = [defaultEntity writeToURL: URLToLastEntity
//                                    atomically: YES
//                                      encoding: NSUTF8StringEncoding
//                                         error: &err01 ];
//             if (!ret01) { NSLog(@"Error write to lastEntity \n  %@", [err01 localizedFailureReason]); }
//             NSLog(@"%@", @"1 setting lastEntity to person|~Anya|group|~Swim Team");
//         }
// nb(21);
//         // get contents of LastEntity file and
//         // populate _mambCurrentEntity and _mambCurrentSelection and _mambCurrentSelectionType
//         NSString *lastEntityStr = [[NSString alloc]
//                                    initWithContentsOfURL:URLToLastEntity
//                                    encoding:NSUTF8StringEncoding
//                                    error:&err01
//                                    ];
// 
// NSLog(@"lastEntityStr = %@", lastEntityStr );
// 
// 
//           //lastEntityStr = nil;  // for test take default lastEntity
//         if (lastEntityStr == nil) {
//             NSLog(@"%@", @"2 setting lastEntity to person|~Anya|group=~Swim Team");
//             lastEntityStr = @"person|~Anya|group|~Swim Team";
//         }
//         NSLog(@"lastEntityStr=%@", lastEntityStr);
// 
// 

// from viewWillAppear
//tn();trn("SCROLL 777777777777777777777777777777777777777777777777777777777");

    // get the indexpath of current row
    //NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];

//NSLog(@"myIdxPath2=%@",myIdxPath);
//NSLog(@"myIdxPath.row=%ld",(long)myIdxPath.row);
//

//    myIdxPath = gbl_savePrevIndexPath;
//    NSLog(@"myIdxPath3=%@",gbl_savePrevIndexPath);

    //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");
//     if(myIdxPath) {
//         [self.tableView selectRowAtIndexPath:myIdxPath
//                                     animated:YES
//                               scrollPosition:UITableViewScrollPositionNone];
// //                              scrollPosition:UITableViewScrollPositionMiddle];
//     }
// 
//     //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");
// 
//     //[self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//     [self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
//                                                       animated: YES];
//    [self.tableView scrollToRowAtIndexPath: myIdxPath
 //                         atScrollPosition: UITableViewScrollPositionMiddle
  //                                animated: YES ];
    
        // myDestTableViewController = [nc.viewControllers objectAtIndex:0]; // First view in nav controller
        // Is the detailTableViewController embedded in a Navigation Controller? If so, you'll need to access it this way:
//      
//        - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
//            if ([[segue identifier] isEqualToString:@"nextScreen"]) {
//                UINavigationController *nc = segue.destinationViewController;
//                DetailTableViewController * detailTableViewController = [nc.viewControllers objectAtIndex:0]; // First view in nav controller
//                NSInteger tagIndex = [(UIButton *)sender tag];
//                detailTableViewController.productType = tagIndex;
//            }
//     

        
        //MAMB09_selectReportsTableViewController *myDestTableViewController =
        // UITableViewController *myDestTableViewController = segue.destinationViewController;
        // MAMB09_selectReportsTableViewController *myDestTableViewController = segue.destinationViewController;
        
//        if ([_mambCurrentEntity isEqualToString:@"group"]) {
//            NSLog(@"current  row 222=[%@]", [gbl_arrayGrp objectAtIndex:myIdxPath.row]);
//            myDestTableViewController.selectedObjectFromHome = [gbl_arrayGrp objectAtIndex:myIdxPath.row]
//        } else if ([_mambCurrentEntity isEqualToString:@"person"]) {
//            NSLog(@"current  row 223=[%@]", [gbl_arrayPer objectAtIndex:myIdxPath.row]);
//            myDestTableViewController.selectedObjectFromHome = [gbl_arrayPer objectAtIndex:myIdxPath.row]
//        }
    
        //myDestTableViewController.delegate = self;
        

//    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//        if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//            RecipeDetailViewController *destViewController = segue.destinationViewController;
//            destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
//        }
//    }
    
//        PlayerDetailsViewController *playerDetailsViewController =
//            [[navigationController viewControllers] objectAtIndex:0];
//        playerDetailsViewController.delegate = self;

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

//    
//    UITableViewController *SelectTblViewController = [[UITableViewController alloc] init];
//    SelectTblViewController = [segue destinationViewController];
    
    // get the indexpath
    //NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // here, pass information to destination tableview
    //if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        // MyDetailViewController *detailViewController = [segue destinationViewController];
        //  UIViewController *detailViewController = [segue destinationViewController];
    //NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    //detailViewController.data = [self.dataController objectInListAtIndex: myIndexPath.row];
    //}


// moved to didSelectRow
//    // get the indexpath of current row
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//    gbl_savePrevIndexPath  = myIdxPath;
//    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
//
//    /* segueHomeToReportList
//    */
//    if ([segue.identifier isEqualToString:@"segueHomeToReportList"]) {
//        // UINavigationController *nc = segue.destinationViewController;
//        // UINavigationController *nc = segue.destinationViewController;
//        //  MAMB09_selectReportsTableViewController *myDestTableViewController = segue.destinationViewController;
//
//        // myDestTableViewController.fromHomeCurrentSelectionType = _mambCurrentSelectionType; // "group" or "person" or "pair"
//        // gbl_fromHomeCurrentSelectionType = _mambCurrentSelectionType; // "group" or "person" or "pair"
//        
//        //myDestTableViewController.fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"
//        //gbl_fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"
//        //gbl_fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"
//        gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
//
//    
//        if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
//            // NSLog(@"current  row 231=[%@]", [gbl_arrayGrp objectAtIndex:myIdxPath.row]);
//            //myDestTableViewController.fromHomeCurrentSelectionPSV = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//        }
//        if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
//            // NSLog(@"current  row 232=[%@]", [gbl_arrayPer objectAtIndex:myIdxPath.row]);
//            //myDestTableViewController.fromHomeCurrentSelectionPSV = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//            gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//        }
//        NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//        NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
//        NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//        NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//
//
//        
//        // this infinite loops on performseg s
//        // Because background threads are not prioritized and will wait a very long time
//        // before you see results, unlike the mainthread, which is high priority for the system.
//        //
//        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
//        //
////        ntrn("calling dispatch home to rptlist !!!!!!!!!!!!!!!!!!!!!");
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [self performSegueWithIdentifier:@"segueHomeToReportList" sender:self];
////        });
////        ntrn("calling dispatch home to rptlist !!!!!!!!!!!!!!!!!!!!!");
//
//    } /* segueHomeToReportList */
//


//        tab2ViewController *destViewController = segue.destinationViewController;
//        UIView *destView = destViewController.view;
//        destViewController.selectionName = @"alarms";
//
//        [sender setEnabled:NO];




//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"alarmSegue"]) {
//
//
//        CATransition transition = [CATransition animation];
//        transition.duration = 0.5;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionPush;
//        transition.subtype = direction;
//        [self.view.layer addAnimation:transition forKey:kCATransition];
//
//        tab2ViewController *destViewController = segue.destinationViewController;
//        UIView *destView = destViewController.view;
//        destViewController.selectionName = @"alarms";
//
//        [sender setEnabled:NO];
//
//         }
//     }
//
//



    // from prepareForSegue 
    //
    //    if ([segue.identifier isEqualToString:@"seguehomeToAddChange"]) {
    //
    //
    //        CATransition *myTransition = [CATransition animation];
    //        myTransition.duration = 0.5;
    //        myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //        myTransition.type = kCATransitionPush;
    ////        myTransition.subtype = direction;
    //        myTransition.subtype = kCATransitionFromBottom;
    //  NSLog(@"myTransition=%@",myTransition);
    //
    ////        [self.view.layer addAnimation:myTransition forKey: kCATransition];
    ////        [self.view.layer addAnimation:myTransition forKey: @"myTransition"];
    ////        [self.view.layer addAnimation:myTransition forKey: kCATransitionFromBottom];
    ////        [self.view.layer addAnimation:myTransition forKey: kCATransitionPush];
    //
    ////        tab2ViewController *destViewController = segue.destinationViewController;
    ////        UIView *destView = destViewController.view;
    ////        destViewController.selectionName = @"alarms";
    //
    //
    //
    ////   UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    ////   UIViewController *destinationController = (UIViewController*)[self destinationViewController];                    
    //
    //    // Get the new view controller using [segue destinationViewController]
    //
    //   UIViewController *sourceViewController  =  [segue sourceViewController];
    //   UIViewController *destinationController =  [segue destinationViewController];
    //  NSLog(@"sourceViewController  =%@",sourceViewController  );
    //  NSLog(@"destinationController =%@",destinationController );
    //    [sourceViewController.navigationController.view.layer addAnimation: myTransition
    //                                                                forKey: kCATransition];
    ////    [sourceViewController.navigationController pushViewController: destinationController animated: NO];    
    //     
    //
    //        [sender setEnabled:NO];
    //
    //    }
    //

//    gbl_tapped_CellRow_inYellowGroupList = 0;   // 1=y,0=n
//    gbl_tapped_Right_i_inYellowGroupList = 0;   // "i"
//
//    if (   [gbl_homeUseMODE           isEqualToString: @"edit mode" ]     // = yellow
//        && [gbl_fromHomeCurrentEntity isEqualToString: @"group"]      )   // = group list
//    { 
//        gbl_tapped_CellRow_inYellowGroupList = 1;   // 1=y,0=n
//        gbl_tapped_Right_i_inYellowGroupList = 0;   // "i"
//    } 

//  NSLog(@"gbl_tapped_CellRow_inYellowGroupList =[%ld]",(long)gbl_tapped_CellRow_inYellowGroupList );
//  NSLog(@"gbl_tapped_Right_i_inYellowGroupList =[%ld]",(long)gbl_tapped_Right_i_inYellowGroupList );


//    gbl_tapped_CellRow_inYellowGroupList = 0;   // 1=y,0=n
//    gbl_tapped_Right_i_inYellowGroupList = 0;   // "i"
//
//    if (   [gbl_homeUseMODE           isEqualToString: @"edit mode" ]     // = yellow
//        && [gbl_fromHomeCurrentEntity isEqualToString: @"group"]      )   // = group list
//    { 
//        gbl_tapped_CellRow_inYellowGroupList = 0;   // 1=y,0=n
//        gbl_tapped_Right_i_inYellowGroupList = 1;   // "i"
//    } 
//  NSLog(@"gbl_tapped_CellRow_inYellowGroupList =[%ld]",(long)gbl_tapped_CellRow_inYellowGroupList );
//  NSLog(@"gbl_tapped_Right_i_inYellowGroupList =[%ld]",(long)gbl_tapped_Right_i_inYellowGroupList );
//


//
//NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//[style setAlignment:NSTextAlignmentCenter];
////[style setLineBreakMode:NSLineBreakByWordWrapping];
//UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
////UIFont *font2 = [UIFont fontWithName:@"HelveticaNeue-Light"  size:20.0f];
//NSDictionary *dict1 = @{
////        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
//                  NSFontAttributeName: font1,
//        NSParagraphStyleAttributeName: style
//    }; // Added line
////NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
////                        NSFontAttributeName:font2,
////                        NSParagraphStyleAttributeName:style}; // Added line
//
//NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
////[attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"LINE 1\n"    attributes:dict1]];
//[attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Edit"    attributes:dict1]];
////[attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"line 2"      attributes:dict2]];
////[self.resolveButton setAttributedTitle:attString forState:UIControlStateNormal];
//[self.editButtonItem setAttributedTitle: attString   forState: UIControlStateNormal];  // nno such selector
////[[self.resolveButton titleLabel] setNumberOfLines:0];
////[[self.resolveButton titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
//
//




// this jumps if ([gbl_homeUseMODE isEqualToString: @"regular mode"])
//            {
//                cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
//                cell.indentationLevel =  6;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
//            }

//        cell.contentView.autoresizingMask  = UIViewAutoresizingFlexibleRightMargin;  // allow right margin to shrink

//        [cell.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [cell.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        cell.textLabel.autoresizingMask  = nil;



//        cell.textLabel.autoresizingMask  = UIViewAutoresizingFlexibleWidth;      
//        cell.contentView.autoresizingMask  = UIViewAutoresizingFlexibleWidth;      


//@property(nonatomic) UIEdgeInsets separatorInset
//typedef struct { CGFloat top, left , bottom, right ; } UIEdgeInsets;
//UIEdgeInsets UIEdgeInsetsMake ( CGFloat top, CGFloat left, CGFloat bottom, CGFloat right );


//        cell.textLabel.autoresizingMask  = UIViewAutoresizingFlexibleRightMargin;
         //[customView setAutoresizingMask: UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight];

//        cell.textLabel.autoresizingMask  = UIViewAutoresizingFlexibleLeftMargin |
//             UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
//        cell.contentView.autoresizingMask  = UIViewAutoresizingFlexibleLeftMargin |
//             UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;

//        cell.autoresizingMask  = UIViewAutoresizingFlexibleRightMargin;  // allow right margin to shrink
//        cell.autoresizingMask  = nil;

//        self.tableView.autoresizingMask  = UIViewAutoresizingFlexibleRightMargin;  // allow right margin to shrink
//        cell.contentView.autoresizingMask  = UIViewAutoresizingFlexibleRightMargin;  // allow right margin to shrink
//        cell.autoresizingMask  = UIViewAutoresizingFlexibleRightMargin;  // allow right margin to shrink

        // This will make a UI Element stay centered since it will NOT be hugging any one side.
        //

//        cell.textLabel.autoresizingMask  =
//            UIViewAutoresizingNone;      
//        self.tableView.autoresizingMask  = 
//            UIViewAutoresizingNone;      
//        cell.contentView.autoresizingMask  = 
//            UIViewAutoresizingNone;      
//        cell.autoresizingMask  = 
//            UIViewAutoresizingNone;      
//

//            UIViewAutoresizingFlexibleLeftMargin;      
//            UIViewAutoresizingFlexibleBottomMargin    | 
//            UIViewAutoresizingFlexibleRightMargin     | 
//            UIViewAutoresizingFlexibleTopMargin

//        cell.autoresizingMask     = UIViewAutoresizingFlexibleRightMargin;
//        cell.hidesAccessoryWhenEditing = NO;

//        cell.shouldIndentWhileEditing = NO;


        // set cell.accessoryType         (depends on gbl_homeUseMode - editing or not)
        // set cell.editingAccessoryType
        //
//        [cell addSubview: lblCellText ];

//        if ([gbl_homeUseMODE isEqualToString: @"regular mode"]) {
//            cell.accessoryType        = gbl_home_cell_AccessoryType;           // home mode edit    with tap giving record details
//            cell.editingAccessoryType = gbl_home_cell_editingAccessoryType;    // home mode edit    with tap giving record details
//
//            // The accessoryView property has priority over the accessoryType property.
//            // If you set the accessoryView to nil, you'll see the accessory button again.
//            cell.accessoryView        = nil; 
//        }
//        if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) {
//            cell.accessoryView        = UITableViewCellAccessoryDetailDisclosureButton;
//        }
//


//
//    // highlight correct entity in seg control at top
//    //
//    //
//    NSString  *nameOfGrpOrPer;
//    NSInteger idxGrpOrPer;
//    NSArray *arrayGrpOrper;
//    idxGrpOrPer = -1;   // zero-based idx
//    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
//
//        _segEntityOutlet.selectedSegmentIndex = 0;
//
//        for (id eltGrp in gbl_arrayGrp) { // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
//          idxGrpOrPer = idxGrpOrPer + 1;
//          //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
//          //NSLog(@"eltGrp=%@", eltGrp);
//          NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
//          arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
//          nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//
//          if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedGroup]) {
//            break;
//          }
//        } // search thru gbl_arrayGrp
//        //NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);
//
//        // get the indexpath of row num idxGrpOrPer in tableview
//        NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
////tn();trn("SCROLL 111111111111111111111111111111111111111111111111111111111");
//
//        // select the row in UITableView
//        // This puts in the light grey "highlight" indicating selection
//        [self.tableView selectRowAtIndexPath: foundIndexPath 
//                                    animated: YES
//                              scrollPosition: UITableViewScrollPositionNone];
//        //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
//        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                  animated: YES];
//    }
//    //if ([_mambCurrentEntity isEqualToString:@"person"]) 
//    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
//
//        _segEntityOutlet.selectedSegmentIndex = 1;
//
//        NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//        
//        do { // highlight gbl_lastSelectedPerson row in tableview
//
//            for (id eltPer in gbl_arrayPer) {  // find index of gbl_lastSelectedPerson (like "~Dave") in gbl_arrayPer
//                idxGrpOrPer = idxGrpOrPer + 1; 
////              NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
////              NSLog(@"eltPer=%@", eltPer);
//
//              NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
//              arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
//              nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//
//              if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
//                break;
//              }
//            } // search thru gbl_arrayPer
////        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);
//
//            // get the indexpath of row num idxGrpOrPer in tableview
//            NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
////        NSLog(@"foundIndexPath=%@",foundIndexPath);
////        NSLog(@"foundIndexPath.row=%ld",(long)foundIndexPath.row);
//
//
//            // select the row in UITableView
//            // This puts in the light grey "highlight" indicating selection
//            [self.tableView selectRowAtIndexPath: foundIndexPath 
//                                        animated: YES
//                                  scrollPosition: UITableViewScrollPositionMiddle];
////                                  scrollPosition: UITableViewScrollPositionNone];
//            //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
//            [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                              animated: YES];
//
//        }  while (FALSE);  // END highlight lastEntity row in tableview
//
//    }
//    // end of   highlight correct entity in seg control at top
//

//    // make label for cell text
//    //
//    UILabel *lblCellText = [[UILabel alloc] init];
//        lblCellText.numberOfLines = 1;
//        lblCellText.font          = [UIFont boldSystemFontOfSize: 17.0];
//        lblCellText.text          = nameOfGrpOrPer;
//
//    lblCellText.backgroundColor = [UIColor whiteColor];
//
//    [lblCellText sizeToFit];


          // move to appdel .m as   gbl_myDisclosureIndicatorLabel   did not work
          // try move to viewDidLoad .m as   lcl_myDisclosureIndicatorLabel     DID work
          //
// try move to viewDidLoad .m as   lcl_myDisclosureIndicatorLabel   
//        // UILabel for the disclosure indicator, ">",  for tappable cells
//        //
//            NSString *myDisclosureIndicatorBGcolorName; 
//            NSString *myDisclosureIndicatorText; 
//            UIColor  *colorOfGroupReportArrow; 
//            UIFont   *myDisclosureIndicatorFont; 
//
//            myDisclosureIndicatorText = @">"; 
////            colorOfGroupReportArrow   = [UIColor blackColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor darkGrayColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor grayColor];                 // blue background
//            colorOfGroupReportArrow   = [UIColor lightGrayColor];                 // blue background
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 24.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 20.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     boldSystemFontOfSize: 24.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont     boldSystemFontOfSize: 20.0f]; // make not bold
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"Menlo-bold" size:  24.0]; // no good
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"ArialRoundedMTBold" size:  24.0];
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"HelveticaNeue-ThinItalic" size:  24.0];
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"IowanOldStyle-Bold" size:  24.0];
//            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0]; // good
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Wide" size:  24.0]; // bad
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"SanFranciscoDisplay-Thin" size:  24.0]; 
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"SanFranciscoRounded-Bold" size:  16.0]; 
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"TimesNewRomanPS-BoldMT" size:  24.0]; // good
////              myDisclosureIndicatorFont = [UIFont fontWithName: @"Superclarendon-Bold" size:  24.0]; // good
////              myDisclosureIndicatorFont = [UIFont fontWithName: @"SnellRoundhand-Bold" size:  24.0]; // good
////              myDisclosureIndicatorFont = [UIFont fontWithName: @"AvenirNextCondensed-Heavy" size:  24.0]; // good
//
//
//
//
//            NSAttributedString *myNewCellAttributedText3 = [
//                [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
//                                               attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
//                                                               NSForegroundColorAttributeName: colorOfGroupReportArrow                }
//            ];
//
//            UILabel *myDisclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
//            myDisclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
//            myDisclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 
//        //
//        // end of  UILabel for the disclosure indicator, ">",  for tappable cells
//


//
//// this works for getting the current date from internet
//  NSLog(@"start getting date real");
//
//NSMutableURLRequest *myrequest = [[NSMutableURLRequest alloc]
//                                initWithURL:[NSURL URLWithString:@"http://google.com" ]];
//[myrequest setHTTPMethod:@"GET"];
//NSHTTPURLResponse *myhttpResponse = nil;
//[NSURLConnection sendSynchronousRequest:myrequest returningResponse:&myhttpResponse error:nil];
//NSString *mydateString = [[myhttpResponse allHeaderFields] objectForKey:@"Date"];
////NSDate *gooCurrentDate = [NSDate dateWithNaturalLanguageString:dateString locale:NSLocale.currentLocale];
////  NSLog(@"gooCurrentDate =[%@]",gooCurrentDate );
//  NSLog(@"mydateString =[%@]",mydateString );
//
//
//


//
//// below gets this :  App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure.
////                    Temporary exceptions can be configured via your app's Info.plist file.
////
//NSURLSession *session = [NSURLSession sharedSession];
//[[session   dataTaskWithURL: [NSURL URLWithString:@"https://google.com" ]
//          completionHandler: ^(NSData        *mydata,
//                               NSURLResponse *response,
//                               NSError       *error     ) {
//            // handle response
////  NSLog(@"mydata=[%@]",mydata);
//   NSString *mydatastring = [[NSString alloc] initWithData: mydata   encoding: NSUTF8StringEncoding] ;
//  NSLog(@"mydatastring =[%@]",mydatastring );
//    NSString *yourStr= [NSString stringWithUTF8String: [mydata bytes]];
//  NSLog(@"yourStr=[%@]",yourStr);
////NSString *mydateString = [mydata  objectForKey:@"Date"];
////  NSLog(@"mydateString =[%@]",mydateString );
//
////        NSString *mydateString = [[myhttpResponse allHeaderFields] objectForKey:@"Date"];
//
//  }] resume];
//
//



//
////static void SocketReadCallback(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info)
//void readSockData()
//    // Called by the CFSocket read callback to actually read and process data 
//    // from the socket.
//{
//tn();
//  NSLog(@"in readSockData ");
//kin(newsock);
//    int                     err;
//    int                     sock;
//    struct sockaddr_storage addr;
//    socklen_t               addrLen;
//    uint8_t                 buffer[512];
//    ssize_t                 bytesRead;
//    
////    sock = CFSocketGetNative(self->_cfSocket);
////    sock = CFSocketGetNative(cfSocket);
////    sock = cfSocket;
////    assert(sock >= 0);
//    
//    addrLen = sizeof(addr);
//
////dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////    bytesRead = recvfrom(sock, buffer, sizeof(buffer), 0, (struct sockaddr *) &addr, &addrLen);
////    bytesRead = recv((int)cfSocket, buffer, sizeof(buffer), 0);
//    bytesRead = recv((int)newsock, buffer, sizeof(buffer), 0);
////});
//  NSLog(@"bytesRead =[%ld]",bytesRead );
//
//    if (bytesRead < 0) {
//        err = errno;
//  NSLog(@"bytes < 0");
//    } else if (bytesRead == 0) {
//  NSLog(@"bytes  ==  0");
//    } else {
//        NSData *    dataObj;
////        NSData *    addrObj;
// 
//        err = 0;
// 
//        dataObj = [NSData dataWithBytes: buffer length: (NSUInteger) bytesRead ];
//  NSLog(@"dataObj =[%@]",dataObj );
//
////<.>
////NSUInteger len = [dataObj length];
////Byte *byteData = (Byte*)malloc(len + 8);
////memcpy(byteData, [data bytes], len);
////
////<.>
////
//  NSLog(@"dataObj =[%@]",dataObj );
//
//NSString* newStr = [[NSString alloc] initWithData: dataObj encoding:NSUTF8StringEncoding];
//  NSLog(@"newStr =[%@]",newStr );
//
//
////        assert(dataObj != nil);
////        addrObj = [NSData dataWithBytes: &addr  length: addrLen  ];
////        assert(addrObj != nil);
// 
//        // Tell the delegate about the data.
//        
////        if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(echo:didReceiveData:fromAddress:)] ) {
////            [self.delegate echo:self didReceiveData:dataObj fromAddress:addrObj];
////        }
// 
//        // Echo the data back to the sender.
// 
////        if (self.isServer) {
////            [self sendData:dataObj toAddress:addrObj];
////        }
//    }
//
//
//    
//} // readSockData
//
//


//
//- (void)stream:(NSStream *)stream handleEvent: (NSStreamEvent)eventCode
//{
//  NSLog(@"in handleEvent!");
//  NSLog(@"eventCode=[%ld]",eventCode);
//
//NSNumber *myec = [NSNumber numberWithInt:eventCode];
//
//  NSLog(@"=myec[%@]",myec);
//
//
//switch (eventCode){
//
//nbn(11);
//    case NSStreamEventErrorOccurred:
//        NSLog(@"ErrorOccurred");
//        break;
//    case NSStreamEventEndEncountered:
//        NSLog(@"EndEncountered");
//        break;
//    case NSStreamEventNone:
//        NSLog(@"None");
//        break;
//    case NSStreamEventHasBytesAvailable:
//        NSLog(@"HasBytesAvaible");
////        var buffer = [UInt8](count: 1024, repeatedValue: 0)
////        if ( aStream == inputstream){
//
////            while (inputstream.hasBytesAvailable){
////                int len = inputstream.read(&buffer, maxLength: buffer.count) 
////                if(len > 0){
////                    var output = NSString(bytes: &buffer, length: buffer.count, encoding: NSUTF8StringEncoding) 
////                    if (output != ""){
////                        NSLog(@"server said: %@", output!)
////                    }
////                }
////
////            } 
////        }
//        break;
////    case NSStreamEventAllZeros:
////        NSLog(@"allZeros");
////        break;
//    case NSStreamEventOpenCompleted:
//        NSLog(@"OpenCompleted");
//        break;
//    case NSStreamEventHasSpaceAvailable:
//        NSLog(@"HasSpaceAvailable");
//        break;
//nbn(14);
//}
//
//nbn(15);
// 
//    switch(eventCode) {
//        case NSStreamEventHasBytesAvailable:
//        {
//  NSLog(@"in NSStreamEventHasBytesAvailable!");
//            if(!gbl_data) {
//                gbl_data = [NSMutableData data] ;
//            }
//            uint8_t buf[1024];
////            unsigned int len = 0;
//            long len = 0;
//            len = [(NSInputStream *)stream read:buf maxLength:1024];
//            if(len) {
//                [gbl_data appendBytes:(const void *)buf length:len];
//  NSLog(@"gbl_data =[%@]",gbl_data );
//                // bytesRead is an instance variable of type NSNumber.
////                [gbl_bytesRead setIntValue:[gbl_bytesRead intValue] + len];
//            } else {
//                NSLog(@"no buffer!");
//            }
//            break;
//        }
//        case NSStreamEventEndEncountered:
//        {
//  NSLog(@"in NSStreamEventEndEncountered!");
//            [stream close];
//            [stream removeFromRunLoop: [NSRunLoop currentRunLoop]
//                              forMode: NSDefaultRunLoopMode];
////            [stream release];
//            stream = nil; // stream is ivar, so reinit it
//            break;
//        }
//
//        // continued
//    }
//nbn(20);
//} // end of  (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode
//


//
//// <.> getaddrinfo man page    http://linux.die.net/man/3/getaddrinfo
//// struct addrinfo {
////     int              ai_flags;
////     int              ai_family;
////     int              ai_socktype;
////     int              ai_protocol;
////     socklen_t        ai_addrlen;
////     struct sockaddr *ai_addr;
////     char            *ai_canonname;
////     struct addrinfo *ai_next;
//// };
//// 
//// int getaddrinfo(const char *node, const char *service,
////                 const struct addrinfo *hints,
////                 struct addrinfo **res);
//// 
//// return  Value
//// 
//// getaddrinfo() returns 0 if it succeeds, or one of the following nonzero error codes:
//// 
//// EAI_ADDRFAMILY
//// The specified network host does not have any network addresses in the requested address family.
//// EAI_AGAIN
//// The name server returned a temporary failure indication. Try again later.
//// EAI_BADFLAGS
//// hints.ai_flags contains invalid flags; or, hints.ai_flags included AI_CANONNAME and name was NULL.
//// EAI_FAIL
//// The name server returned a permanent failure indication.
//// EAI_FAMILY
//// The requested address family is not supported.
//// EAI_MEMORY
//// Out of memory.
//// EAI_NODATA
//// The specified network host exists, but does not have any network addresses defined.
//// EAI_NONAME
//// The node or service is not known; or both node and service are NULL; or AI_NUMERICSERV was specified in hints.ai_flags and service was not a numeric port-number string.
//// EAI_SERVICE
//// The requested service is not available for the requested socket type. It may be available through another socket type. For example, this error could occur if service was "shell" (a service only available on stream sockets), and either hints.ai_protocol was IPPROTO_UDP, or hints.ai_socktype was SOCK_DGRAM; or the error could occur if service was not NULL, and hints.ai_socktype was SOCK_RAW (a socket type that does not support the concept of services).
//// EAI_SOCKTYPE
//// The requested socket type is not supported. This could occur, for example, if hints.ai_socktype and hints.ai_protocol are inconsistent (e.g., SOCK_DGRAM and IPPROTO_TCP, respectively).
//// EAI_SYSTEM
//// Other system error, check errno for details.
//// The gai_strerror() function translates these error codes to a human readable string, suitable for error reporting.
//// Files
//// /etc/gai.conf
//// 
////int
////main(int argc, char *argv[])
////{
//tn();
//  NSLog(@" start // <.> getaddrinfo man page    http://linux.die.net/man/3/getaddrinfo ");
//    struct addrinfo hints;
//    struct addrinfo *result, *rp;
//    int sfd, s, j;
//    size_t len;
//    ssize_t nread;
//    char buf[1024], ksnbuf[1024];;
//
////    if (argc < 3) {
////        fprintf(stderr, "Usage: %s host port msg...\n", argv[0]);
////        exit(EXIT_FAILURE);
////    }
//
//   /* Obtain address(es) matching host/port */
//
//    memset(&hints, 0, sizeof(struct addrinfo));
////    hints.ai_family = AF_UNSPEC;    /* Allow IPv4 or IPv6 */
//    hints.ai_family   = AF_INET;
//    hints.ai_socktype = SOCK_DGRAM; /* Datagram socket */
//    hints.ai_flags    = 0;
//    hints.ai_protocol = 0;          /* Any protocol */
//
////    s = getaddrinfo(argv[1], argv[2], &hints, &result);
////    s = getaddrinfo("time.nist.gov", "13", &hints, &result);
////    s = getaddrinfo("time.nist.gov", "daytime", &hints, &result);
////    s = getaddrinfo("time.nist.gov", "13", &hints, &result);
////    s = getaddrinfo("//https:/time-c.nist.gov", "13", &hints, &result);
////    s = getaddrinfo("129.6.15.29", "13", &hints, &result);
////    s = getaddrinfo("time.nist.gov", "13", &hints, &result);
//    s = getaddrinfo("129.6.15.29", "13", &hints, &result);
//tmn("result->ai_addr->sa_data", result->ai_addr->sa_data, 14);
//
//    if (s != 0) {
//        sprintf(ksnbuf, "getaddrinfo error: %s\n", gai_strerror(s));
//ksn(ksnbuf);
//    }
//
//   // getaddrinfo() returns a list of address structures.
//   //  Try each address until we successfully connect(2).
//   //  If socket(2) (or connect(2)) fails, we (close the socket
//   //  and) try the next address.
//   //
//   for (rp = result; rp != NULL; rp = rp->ai_next) {
//nbn(98);
//int __block retval4;
//       sfd = socket(rp->ai_family, rp->ai_socktype , rp->ai_protocol );
//kin(sfd);
//kin(rp->ai_socktype );
//kin(rp->ai_protocol );
//       if (sfd == -1) continue;
//
//rp->ai_protocol = 13;
//kin(rp->ai_protocol );
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//       retval4 = connect(sfd, rp->ai_addr, rp->ai_addrlen);
//});
//kin(retval4);
//       if (retval4 != -1) break;                  /* Success */
//
//
////       close(sfd);
//    }
//
//   if (rp == NULL) { ksn("Could not connect   no address succeeded\n"); } /* No address succeeded */
//
//   freeaddrinfo(result);           /* No longer needed */
//
//   // Send remaining command-line arguments as separate
//   //  datagrams, and read responses from server 
////   for (j = 3; j < argc; j++) {
////        len = strlen(argv[j]) + 1; /* +1 for terminating null byte */
////
////       if (len + 1 > 1024) { ksn( "Ignoring long message in argument %d\n", j); }
////
////       if (write(sfd, argv[j], len) != len) { ksn( "partial/failed write\n"); }
////
////       nread = read(sfd, buf, 1024);
////       if (nread == -1) { perror("read"); }
////        sprintf(ksnbuf, "Received %ld bytes: %s\n", (long) nread, buf);
////ksn(ksnbuf)
////tr("received buf ="); ksn(buf);
////    }
//    // send only 1 msg
//        len = strlen("") + 1; /* +1 for terminating null byte */
//kin(len);
//int retval5; retval5 = 999;
//       retval5 = write(sfd, "", len);
//kin(retval5);
//       if (retval5 != len) { ksn( "partial/failed write\n"); }
//nbn(100);
//
//
//       nread = read(sfd, buf, 1024);
//nbn(101);
//       if (nread == -1) { perror("read"); }
//       sprintf(ksnbuf, "Received %ld bytes: %s\n", (long) nread, buf);
//ksn(ksnbuf);
//tr("received buf ="); ksn(buf);
//
////} // main
//// <.>  end of   getaddrinfo man page    http://linux.die.net/man/3/getaddrinfo
//
//


//
////<.> udpclient.c     http://www.cs.cmu.edu/afs/cs/academic/class/15213-f99/www/class26/udpclient.c
//tn();
//  NSLog(@"start UDPclient!!");
//  //int main(int argc, char **argv) {
//    int sockfd, portno, n;
//    int serverlen;
//    struct sockaddr_in serveraddr;
//    struct hostent *server;
//    char *hostname;
//    char buf[BUFSIZE];
//
////    hostname = argv[1];
////    portno = atoi(argv[2]);
////    hostname = "ntp1.glb.nist.gov";
////    hostname = "http://www.time.gov/";
////    hostname = "time.nist.gov";
////    hostname = "time-a.nist.gov";
////    hostname = "http://www.time.gov/daytime";
//    hostname = "www.time.gov";
//    portno   = 13;
//nbn(100);
//ksn(hostname);
//kin(portno);
//    /* socket: create the socket */
//    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
//    if (sockfd < 0) perror("ERROR opening socket");
//
//    /* gethostbyname: get the server's DNS entry */
////    server = gethostbyname(hostname);
////    server = gethostbyname(hostname);
//    server = getservbyport(portno);
//    if (server == NULL) {
//        fprintf(stderr,"ERROR, no such host as %s\n", hostname);
//        exit(0);
//    }
//
//    /* build the server's Internet address */
//    bzero((char *) &serveraddr, sizeof(serveraddr));
//    serveraddr.sin_family = AF_INET;
//    bcopy((char *)server->h_addr,   (char *) &serveraddr.sin_addr.s_addr, server->h_length );
//    serveraddr.sin_port = htons(portno);
//nbn(101);
//
//    /* get a message from the user */
//    strcpy(buf, "hey23");
//
//    /* send the message to the server */
//    serverlen = sizeof(serveraddr);
//    n = sendto(sockfd, buf, strlen(buf), 0, &serveraddr, serverlen);
//    if (n < 0) 
//      perror("ERROR in sendto");
//    
//    /* print the server's reply */
//    n = recvfrom(sockfd, buf, strlen(buf), 0, &serveraddr, &serverlen);
//    if (n < 0) perror("ERROR in recvfrom");
//tr("returned from server=["); ksn(buf);tn();
//  //} // main
////<.> end udpclient.c
//
//


//CFReadStreamRef readStream;
//    CFWriteStreamRef writeStream;
////    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.1.90", 23, &readStream, &writeStream); //192.168.1.90 is the server address, 23 is standard telnet port
//    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"ntp1.glb.nist.gov", 13, &readStream, &writeStream); //192.168.1.90 is the server address, 23 is standard telnet port
//    inputStream = (__bridge NSInputStream *)readStream;
//    outputStream = (__bridge NSOutputStream *)writeStream;
//
//    [inputStream setDelegate:self];
//    [outputStream setDelegate:self];
//
//    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//
//    [inputStream open];
//    [outputStream open];
//
//NSData *readdata = [[NSData alloc] initWithData:[@"hey" dataUsingEncoding:NSASCIIStringEncoding]]; //is ASCIIStringEncoding what I want?
//
//NSData *data = [[NSData alloc] initWithData:[@"hey" dataUsingEncoding:NSASCIIStringEncoding]]; //is ASCIIStringEncoding what I want?
//[outputStream write:[data bytes] maxLength:[data length]];
//NSLog(@"Sent message to server: %@", message);
//



//
// // Create Socket
//  NSLog(@"create socket ");
//int Handle = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
//if (Handle <=0){
//    printf("Failed to create socket\n");
//}
//
//NSString    *hostName;
//NSData      *hostAddress;
//NSUInteger  port;
//
//hostName = @"time.nist.gov";
//port     = 13;
//
//CFHostRef   cfHost;
////CFSocketRef cfSocket;
//
//cfHost = CFHostCreateWithName(NULL, (__bridge CFStringRef) hostName);
//kin(cfHost);
//
////        CFHostSetClient(self->_cfHost, HostResolveCallback, &context);
//
//CFHostScheduleWithRunLoop(cfHost, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
//
////        success = CFHostStartInfoResolution(self->_cfHost, kCFHostAddresses, &streamError);
////        if (success) {
////            self.hostName = hostName;
////            self.port = port;
////            // ... continue in HostResolveCallback
////        } else {
////            [self stopWithStreamError:streamError];
////       }
//
////    - (BOOL)setupSocketConnectedToAddress:(NSData *)address port:(NSUInteger)port error:(NSError **)errorPtr
//int                     err;
//int                     junk;
//int                     sock;
//const CFSocketContext   context = { 0, (__bridge void *)(self), NULL, NULL, NULL };
//CFRunLoopSourceRef      rls;
//
//
//        // Create the UDP socket itself.
//        
//        err = 0;
//        sock = socket(AF_INET, SOCK_DGRAM, 0);
//nbn(1);
//kin(sock);
//        if (sock < 0) {
//nbn(2);
//            err = errno;
//        }
//
//        struct sockaddr_in      addr;
//        memset(&addr, 0, sizeof(addr));
//
////        [address getBytes:&addr length:[hostAddress length]];
//        
//        addr.sin_family = AF_INET;
//        addr.sin_port   = htons(port);
//        err = connect(sock, (const struct sockaddr *) &addr, sizeof(addr));
//tr("err1=");kin(err);
//kin(sock);
//
//        // From now on we want the socket in non-blocking mode to prevent any unexpected 
//        // blocking of the main thread.  None of the above should block for any meaningful 
//        // amount of time.
//            int flags;
//            flags = fcntl(sock, F_GETFL);
//            err = fcntl(sock, F_SETFL, flags | O_NONBLOCK);
//tr("err2=");kin(err);
//kin(sock);
//            if (err < 0) {
//                NSLog(@"could not set to nonblocking");
//            }
//        
//
//        // Wrap the socket in a CFSocket that's scheduled on the runloop.
//nbn(3);
////        if (err == 0) {
////nbn(4);
//////            cfSocket = CFSocketCreateWithNative(NULL, sock, kCFSocketReadCallBack, SocketReadCallback, &context);
////            cfSocket = CFSocketCreateWithNative(NULL, sock, kCFSocketReadCallBack, readSockData, &context);
//// 
////            // The socket will now take care of cleaning up our file descriptor.
//// 
//////            assert( CFSocketGetSocketFlags(cfSocket) & kCFSocketCloseOnInvalidate );
////            sock = -1;
//// 
////            rls = CFSocketCreateRunLoopSource(NULL, cfSocket, 0);
////            assert(rls != NULL);
////            
////            CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);
////            
////            CFRelease(rls);
////        }
////
//        
//nbn(5);
//
////    int                     err;
////    int                     sock;
//    ssize_t                 bytesWritten;
//    const struct sockaddr * addrPtr;
//    socklen_t               addrLen;
//
//NSString* sendstr = @"teststring";
//NSData* senddata = [sendstr dataUsingEncoding:NSUTF8StringEncoding];
//
////    bytesWritten = sendto(sock, [senddata bytes], [senddata length], 0, addrPtr, addrLen);
//    bytesWritten = send(sock, "hey", 4, 0);
//
//  NSLog(@"bytesWritten2=[%ld]",bytesWritten );
//
//newsock = sock;
//kin(sock);
//kin(newsock);
//  readSockData();
//nbn(6);
//
//




//<.>
//    NSString *urlStr = @"time.nist.gov";
//
//        NSURL *website = [NSURL URLWithString: urlStr];
//        if (!website) {
//            NSLog(@"%@ is not a valid URL", website);
//            return;
//        }
// 
//        CFReadStreamRef readStream;
//        CFWriteStreamRef writeStream;
////      CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)[website host], 13, &readStream, &writeStream);
//        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[website host], 13, &readStream, &writeStream);
//
//// Write something (the socket is not valid before you read or write):
//CFWriteStreamOpen(writeStream);
//CFWriteStreamWrite(writeStream, "Hello\n", 6);
////const UInt8 *mywritestuff = @[ @0xff ];
////CFWriteStreamWrite(writeStream, mywritestuff, 1);
//
//
//
//// Get the native socket handle:
//CFDataRef socketData = CFWriteStreamCopyProperty(writeStream, kCFStreamPropertySocketNativeHandle);
//CFSocketNativeHandle socket;
//CFDataGetBytes(socketData, CFRangeMake(0, sizeof(CFSocketNativeHandle)), (UInt8 *)&socket);
////CFDataGetBytes(socketData, CFRangeMake(0, 1023), (UInt8 *)&socket);
//CFSocketNativeHandle Handle = socket;
//<.>
//


//
//// Bind Socket
//struct sockaddr_in address;
//address.sin_family = AF_INET;
////address.sin_addr.s_addr = INADDR_ANY;
//
//
//unsigned char buf_in6_addr[sizeof(struct in6_addr)];
//
//int aretval;
//aretval = inet_pton(AF_INET, "time.nist.gov", buf_in6_addr);
////aretval = inet_pton(AF_INET, "//https:/google.com", buf_in6_addr);
//kin(aretval);
//if (aretval < 0){
//    printf("Failed to inet_pton\n");
//    perror("inet_pton");
//}
//
//kin(buf_in6_addr[0]);
//kin(buf_in6_addr[1]);
//kin(buf_in6_addr[2]);
//kin(buf_in6_addr[3]);
//kin(buf_in6_addr[4]);
//kin(buf_in6_addr[5]);
//kin(buf_in6_addr[6]);
//kin(buf_in6_addr[7]);
//kin(buf_in6_addr[8]);
//
//
//if (aretval == 1 ) {
//  trn("addr was converted");
//}
//
//
//address.sin_addr.s_addr = buf_in6_addr;
////address.sin_port = htons((unsigned short) 4966);
//address.sin_port = htons((unsigned short) 13);
//
//aretval = bind( Handle, (struct sockaddr *) &address, sizeof(struct sockaddr_in) );
//kin(aretval);
//if (aretval < 0){
//    printf("Failed to Bind\n");
//    perror("bind");
//}
//printf("Bind Done\n");
//
//// Set to non Blocking
////int NonBlocking = 1;
////if (fcntl(Handle, F_SETFL, O_NONBLOCK, NonBlocking) == -1){
////    printf("Faile to set nonblocking\n");
////}
//Boolean ContinueLoop = true;
//
//unsigned char Packet_Data[256];
//unsigned int Maximum_Packet_Size = sizeof(Packet_Data);
//
//struct sockaddr_in From_Address;
//socklen_t FromLength = sizeof(From_Address);
//
////while (ContinueLoop){
//    int Received_Bytes = recvfrom(Handle, (char *)Packet_Data, Maximum_Packet_Size, 0, (struct sockaddr *)&From_Address, &FromLength);
//
//    if (Received_Bytes > 0){
//      ContinueLoop = false;
//      printf("Got Data \n");
//    } else {
//      printf("DID  NOT got Data \n");
//    }
//
//ksn(Packet_Data);
////}//wend
//
//    close(Handle);
//
//



//<.>
//- (IBAction)searchForSite:(id)sender
//{
//    NSString *urlStr = [sender stringValue];
//    if (![urlStr isEqualToString:@""]) {
//        NSURL *website = [NSURL URLWithString:urlStr];
//        if (!website) {
//            NSLog(@"%@ is not a valid URL");
//            return;
//        }
// 
//        CFReadStreamRef readStream;
//        CFWriteStreamRef writeStream;
//        CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)[website host], 80, &readStream, &writeStream);
// 
//        NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
//        NSOutputStream *outputStream = (__bridge_transfer NSOutputStream *)writeStream;
//        [inputStream setDelegate:self];
//        [outputStream setDelegate:self];
//        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [inputStream open];
//        [outputStream open];
// 
//        /* Store a reference to the input and output streams so that
//           they don't go away.... */
//        ...
//    }
//}
//

//
//    NSString *urlStr = @"time.nist.gov";
//    if (![urlStr isEqualToString:@""]) {
//        NSURL *website = [NSURL URLWithString: urlStr];
//        if (!website) {
//            NSLog(@"%@ is not a valid URL", website);
//            return;
//        }
// 
//        CFReadStreamRef readStream;
//        CFWriteStreamRef writeStream;
////      CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)[website host], 13, &readStream, &writeStream);
//        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[website host], 13, &readStream, &writeStream);
//
//// Write something (the socket is not valid before you read or write):
//CFWriteStreamOpen(writeStream);
//CFWriteStreamWrite(writeStream, "Hello\n", 6);
////const UInt8 *mywritestuff = @[ @0xff ];
////CFWriteStreamWrite(writeStream, mywritestuff, 1);
//
//
//
//// Get the native socket handle:
//CFDataRef socketData = CFWriteStreamCopyProperty(writeStream, kCFStreamPropertySocketNativeHandle);
//CFSocketNativeHandle socket;
//CFDataGetBytes(socketData, CFRangeMake(0, sizeof(CFSocketNativeHandle)), (UInt8 *)&socket);
////CFDataGetBytes(socketData, CFRangeMake(0, 1023), (UInt8 *)&socket);
//
//char mydatebuf[1024];
//
//
////
//////NSData *myData = (NSData *)myCFDataRef; //  It's toll-free bridged, so you just have to cast it.
////NSData *myData = (__bridge NSData *)socketData; //  It's toll-free bridged, so you just have to cast it.
////  NSLog(@"myData =[%@]",myData );
//////NSString *mydatastring = [[[NSString alloc] initWithData: myData encoding:NSUTF8StringEncoding] autorelease];
////NSString *mydatastring = [[NSString alloc] initWithData: myData encoding:NSUTF8StringEncoding] ;
////  NSLog(@"mydatastring =[%@]xxx",mydatastring );
////
//
//




//
////      CFIndex CFReadStreamRead ( CFReadStreamRef stream, UInt8 *buffer, CFIndex bufferLength );
//        UInt8 myUIntBuf[1024];
//        CFIndex mycfindex;
//        mycfindex = 1024;
////        CFIndex CFReadStreamRead (readStream, myUInt8uf,  mycfindex );
//        CFIndex CFReadStreamRead ( CFReadStreamRef readStream, UInt8 *myUIntBuf, CFIndex mycfindex );
//// NSLog(@"myUIntBuf=[%@]",myUIntBuf);
//ksn(myUIntBuf);
//


//
//nbn(1);
////        NSURL *website = [NSURL URLWithString: @"time.gov"];
//        NSURL *website = [NSURL URLWithString: @"http://time.nist.gov"];
//        CFReadStreamRef  readStream;
//        CFWriteStreamRef writeStream;
////        CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)[website host], 80, &readStream, &writeStream);
//        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[website host], 13, &readStream, &writeStream);
//
//        NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
//        NSOutputStream *outputStream = (__bridge_transfer NSOutputStream *)writeStream;
//        [inputStream setDelegate:self];
//        [outputStream setDelegate:self];
//        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [inputStream open];
//        [outputStream open];
//
//nbn(10);
// 
//        /* Store a reference to the input and output streams so that
//           they don't go away.... */
////        ...
//
////<.>
//
//
//
////- (void)sendMessage: (NSString*) message{ //called when the user interacts with UISwitches, is supposed to send message to server
//NSData *data = [[NSData alloc] initWithData:[@"x" dataUsingEncoding:NSASCIIStringEncoding]]; 
//[outputStream write:[data bytes] maxLength:[data length]];
//NSLog(@"Sent message to server: ");
////}
//
//  NSLog(@"gbl_data=[%@]",gbl_data);
//
//
////NSInteger result;
////uint8_t buffer[1024]; // BUFFER_LEN can be any positive integer
////  NSLog(@"inputStream=[%@]",inputStream);
////while((result = [inputStream read:buffer maxLength:1024]) != 0) {
////    if(result > 0) {
////        // buffer contains result bytes of data to be handled
////  NSLog(@"result =[%ld]",result);
////    } else {
////        // The stream had an error. You can get an NSError object using [iStream streamError]
////  NSLog(@" // The stream had an error. You can get an NSError object using [iStream streamError] ");
////        break;
////    }
////}
////  NSLog(@"result2=[%ld]",result);
////  NSLog(@"buffer=[%@]",buffer);
////
//
//
//
//
//
//
//
//
//    // add a method (processDoubleTap) to run on double tap
//    //
//    gbl_doubleTapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processDoubleTap: )
//    ];
//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
//    gbl_doubleTapGestureRecognizer.delaysTouchesBegan = YES;       // for uitableview
//    [self.tableView addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//
//
////    gbl_lastClick = [[[NSDate alloc] init] timeIntervalSince1970];
//
////    WWW width=[240.930176]
////    MMM width=[217.023926]
////
////CGSize siz = [@"WWWWWWWWWWWWWWW" sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
////  NSLog(@"WWW width=[%f]",siz.width);
////       siz = [@"MMMMMMMMMMMMMMM" sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
////  NSLog(@"MMM width=[%f]",siz.width);
////
//
//
//


// try to reduce load time of first cal yr report   
//
//UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
//webView.delegate = self;   
//
//
//    [self.webView setUserInteractionEnabled:NO];
//    [self.webView loadHTMLString:finalString baseURL:nil];
//
//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 1024,768)];
//    NSString *url=@"http://www.google.com";
//    NSURL *nsurl=[NSURL URLWithString:url];
//    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
//    [webview loadRequest:nsrequest];
//    [self.view addSubview:webview];
//
//

//nbn(1);
////    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
//nbn(2);
////    NSString *stringForHTML = @"X";
////    [webview loadHTMLString: stringForHTML   baseURL: nil];
//    [webview loadHTMLString: [NSString stringWithFormat:@"<html><body>X</body></html>"]  baseURL: nil];
//nbn(3);
//    [self.view addSubview:webview];
//nbn(5);
//

//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
//    NSURLRequest *nsrequest=[NSURLRequest requestWithURL: nil];
//    [webview loadRequest: nsrequest];


//   UIWebView *webview =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
//   NSString *someHTML = [webview stringByEvaluatingJavaScriptFromString:@""];   

////<.> end daytime tries here


