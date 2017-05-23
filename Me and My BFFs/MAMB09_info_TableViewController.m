//
//  MAMB09_info_TableViewController.m
//  Me&myBFFs
//
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
//

#import "MAMB09_info_TableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals   ppp  rrr  sss

@interface MAMB09_info_TableViewController ()

@end




// use these globals to put up the right help file / info screen
//
//                [gbl_currentMenuPlusReportCode isEqualToString: @"HOME"        ]  
//             && [gbl_homeUseMODE               isEqualToString: @"report mode" ]
//             && [gbl_homeEditingState          isEqualToString: @"add"         ]  // home screen in brown report mode and "+" hit




NSString *myMostTitle; // for Most ... reports
NSString *myMostWhat;  // like "Passionate"
NSString *myBestTitle; // for Best ... reports
NSString *myBestWhat;  // like "Day"

NSString *myGoodBadText;  // for trait


@implementation MAMB09_info_TableViewController


- (void)didReceiveMemoryWarning {
    //    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)viewWillDisappear:(BOOL)animated {
tn();
     NSLog(@"in viewWillDisappear in info  !");

    [super viewWillDisappear:animated];

//  NSLog(@"gbl_justLookedAtInfoScreen  bef in ViewWillDisappear in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );
    gbl_justLookedAtInfoScreen = 1;
//  NSLog(@"gbl_justLookedAtInfoScreen  aft in ViewWillDisappear in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );

    // check if gbl_ExampleData_show has changed, and
    // if so,  write out gbl_arrayGrp to save it
    //
  NSLog(@"gbl_ExampleData_show_entering =[%@]",gbl_ExampleData_show_entering );
  NSLog(@"gbl_ExampleData_show          =[%@]",gbl_ExampleData_show );



    // these can be different because gbl_ExampleData_show  has been updated by user switch
    //
    gbl_ExampleData_show_switchChanged = 0;   // 1=yes  OR  0=no
    if ( ! [gbl_ExampleData_show_entering isEqualToString: gbl_ExampleData_show ])   // home screen for app (startup screen)
    {
        gbl_ExampleData_show_switchChanged = 1;   // 1=yes  OR  0=no

  NSLog(@"write updated gbl_arrayGrp to file");
         // get #allpeople record
         // update ExampleData_show fld  (fld #3 base 1)
         // write gbl_arrayGrp to file
    
        NSString  *PSVthatWasFound;
//        NSString  *prefixStr;
        NSInteger  arrayIdx;
        NSString  *myStrToUpdate;
        NSString  *myupdatedStr1;

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

        NSString *prefixStr9 = [NSString stringWithFormat: @"%@|",gbl_nameOfGrpHavingAllPeopleIhaveAdded ];  // notice '|'
  NSLog(@"prefixStr9            =%@",prefixStr9 );

        // get the PSV of  AllPeople~ in gbl_arrayGrp
        PSVthatWasFound = NULL;
        arrayIdx = 0;
        for (NSString *element in gbl_arrayGrp) {
  NSLog(@"element =[%@]",element );

            if ([element hasPrefix: prefixStr9]) {
                PSVthatWasFound = element;
                break;
            }
            arrayIdx = arrayIdx + 1;
        }
  NSLog(@"PSVthatWasFound       =%@",PSVthatWasFound );

        if (PSVthatWasFound != NULL) {

            myStrToUpdate = PSVthatWasFound;
  NSLog(@"myStrToUpdate         =%@",myStrToUpdate );
  NSLog(@"arrayIdx              =%ld",(long)arrayIdx);
  NSLog(@"gbl1arrayGrp[arrayIdx]=%@",gbl_arrayGrp[arrayIdx]);
tn();
            myupdatedStr1 = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                     delimitedBy: (NSString *) @"|"
                                        updateOneBasedElementNum: (NSInteger)  3                     // show eg data flag
                                                  withThisString: (NSString *) gbl_ExampleData_show ];
  NSLog(@"myupdatedStr1          =%@",myupdatedStr1 );

            // update #allpeople record containing new data  in memory array gbl_arrayGrp 
            //
  NSLog(@"gbl4arrayGrp[arrayIdx]=%@",gbl_arrayGrp[arrayIdx]);
            [gbl_arrayGrp replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr1];  // <<<<<<<<<<<<<<<<---------
  NSLog(@"gbl2arrayGrp[arrayIdx]=%@",gbl_arrayGrp[arrayIdx]);


            // write updated gbl_arrayGrp to file
            //
  NSLog(@"gbl_arrayGrp=[%@]",gbl_arrayGrp);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"group"]; // write new array data to file
  NSLog(@"write updated gbl_arrayGrp to file");

        } // if found #allpeople record
    } // if gbl_ExampleData_show has change 


} // viewWillDisappear



- (void)viewDidLoad {
    [super viewDidLoad];
    
    fopen_fpdb_for_debug();

tn(); NSLog(@"in INFO   viewDidLoad!");
    

//tn();trn("--qx--- in INFO viewdidAppear----------------");
//  NSLog(@"gbl_userSpecifiedPersonName  =[%@]",gbl_userSpecifiedPersonName  );
//  NSLog(@"gbl_userSpecifiedCity        =[%@]",gbl_userSpecifiedCity        );
//  NSLog(@"gbl_userSpecifiedProv        =[%@]",gbl_userSpecifiedProv        );
//  NSLog(@"gbl_userSpecifiedCoun        =[%@]",gbl_userSpecifiedCoun        );
//  NSLog(@"gbl_selectedBirthInfo        =[%@]",gbl_selectedBirthInfo        );
//  NSLog(@"gbl_DisplayName              =[%@]",gbl_DisplayName );
//  NSLog(@"gbl_DisplayDate              =[%@]",gbl_DisplayDate );
//  NSLog(@"gbl_DisplayCity              =[%@]",gbl_DisplayCity );
//  NSLog(@"gbl_DisplayProv              =[%@]",gbl_DisplayProv );
//  NSLog(@"gbl_DisplayCoun              =[%@]",gbl_DisplayCoun );
//  NSLog(@"gbl_enteredCity              =[%@]",gbl_enteredCity );
//  NSLog(@"gbl_enteredProv              =[%@]",gbl_enteredProv );
//  NSLog(@"gbl_enteredCoun              =[%@]",gbl_enteredCoun );
//trn("-------------------------------------------");
//  NSLog(@"gbl_fromHomeCurrentSelectionPSV    = [%@]",gbl_fromHomeCurrentSelectionPSV);
//  NSLog(@"gbl_justEnteredAddChangeView       = [%ld]",(long)gbl_justEnteredAddChangeView);
//  NSLog(@"gbl_myCitySoFar                    = [%@]",gbl_myCitySoFar );
//  NSLog(@"gbl_lastSelectedGroup              = [%@]",gbl_lastSelectedGroup);
//  NSLog(@"gbl_lastSelectedPerson             = [%@]",gbl_lastSelectedPerson);
//  NSLog(@"gbl_lastSelectedPersonBeforeChange = [%@]",gbl_lastSelectedPersonBeforeChange);
//  NSLog(@"gbl_lastSelectedGroupBeforeChange  = [%@]",gbl_lastSelectedGroupBeforeChange);
//  NSLog(@"gbl_rollerLast_yyyy                = [%@]",gbl_rollerLast_yyyy);
//  NSLog(@"gbl_rollerLast_mth                 = [%@]",gbl_rollerLast_mth);
//  NSLog(@"gbl_rollerLast_dd                  = [%@]",gbl_rollerLast_dd);
//  NSLog(@"gbl_rollerBirthInfo                = [%@]",gbl_rollerBirthInfo);
//trn("-------------------------------------------"); tn();
//



    gbl_ExampleData_show_entering = gbl_ExampleData_show;  // save entering value

//  NSLog(@"gbl_justLookedAtInfoScreen  bef in ViewDidLoad in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );
    gbl_justLookedAtInfoScreen = 1;
//  NSLog(@"gbl_justLookedAtInfoScreen  aft in ViewDidLoad in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );


trn("in INFO   viewDidLoad!");
    
  NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);

  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);      // any of the above 14 RPTs
  NSLog(@"gbl_PSVtappedPersonA_inPair=%@",gbl_PSVtappedPersonA_inPair);      // hompbm,homgbm,pbmco,gbmco
  NSLog(@"gbl_PSVtappedPersonB_inPair=%@",gbl_PSVtappedPersonB_inPair);      // same
//  NSLog(@"gbl_TBLRPTS1_PSV_personA=%@",gbl_TBLRPTS1_PSV_personA);            // of pair
//  NSLog(@"gbl_TBLRPTS1_PSV_personB=%@",gbl_TBLRPTS1_PSV_personB);            // of pair
//  NSLog(@"gbl_TBLRPTS1_PSV_personJust1=%@",gbl_TBLRPTS1_PSV_personJust1);    // for single person reports
//  NSLog(@"gbl_TBLRPTS1_NAME_personA=%@",gbl_TBLRPTS1_NAME_personA);          // of pair
//  NSLog(@"gbl_TBLRPTS1_NAME_personB=%@",gbl_TBLRPTS1_NAME_personB);          // of pair
    self.navigationController.toolbarHidden = YES;
//  NSLog(@"gbl_TBLRPTS1_NAMEx_personJust1=%@",gbl_TBLRPTS1_NAME_personJust1);  // for single person reports
tn();

    
    //    self.navigationController.toolbar.hidden = YES;


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


    //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m


    // set up custom image for "back"  (blueleft chevron)
    //
    // http://stackoverflow.com/questions/18912638/custom-image-for-uinavigation-back-button-in-ios-7
    //    UIImage *backBtn = [UIImage imageNamed:@"iconRightArrowBlue_66"];
    //    UIImage *backBtn = gbl_chevronLeft;
    UIImage *backBtn = [UIImage imageNamed:@"iconChevronLeft_66.png"];
    //    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];   NO  blue square
    //    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAutomatic];
    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];

    UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
//    myNavBarLabel.textColor     = [UIColor greenColor];

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

        self.navigationItem.backBarButtonItem.title=@"";

//        [[self navigationItem] setTitle: nil];  // moving this from the bottom of dispatch_async block to top solved the problem of nav bar title stuttering from left to right (about 1 sec)   why does it work?
//       self.navigationItem.titleView = nil;


        self.navigationController.navigationBar.backIndicatorImage = backBtn;
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;

//    myNavBarLabel.textColor     = [UIColor blackColor];
//    myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
//    myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
//        self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL


        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; // remove separator lines between cells
        // Removing extra separator lines for empty rows in UITableView
        self.tableView.tableFooterView = [[UIView alloc] init];               // remove separator lines below last cell



        //self.tableView.backgroundColor = gbl_colo_cHed;   // WORKS
        self.tableView.backgroundColor = gbl_color_cBgr;   // WORKS


        // When I am navigating back & forth, i see a dark shadow
        // on the right side of navigation bar at top. 
        // It feels rough and distracting. How can I get rid of it?
        //
        self.navigationController.navigationBar.translucent = NO; 
        //
        //http://stackoverflow.com/questions/22413193/dark-shadow-on-navigation-bar-during-segue-transition-after-upgrading-to-xcode-5
    });

    // gbl_currentMenuPlusReportCode decides what info text to put  (set on SELRPT TAP, most/best row TAP, HOME enter)



//    UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
//    myNavBarLabel.textColor     = [UIColor blackColor];
//    myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
//    myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
//


  
    // HOME screen EDITING help   // home screen for app (startup screen)
    //
        //  ----------------------------     --------------------------
        //        HOME DATA                       HOME USES
        //  ----------------------------     --------------------------
        //    gbl_fromHomeCurrentEntity          gbl_homeUseMODE      
        //
        //     "person"                      "edit mode"   (yellow bg) 
        //     "group"                       "report mode" (brown  bg)                          
        //  ----------------------------     ---------------------------
        //
        //  ------------------------------------------------------------
        //         HOME TRANSFER ROUTES to EDITING STATES
        //  ------------------------------------------------------------
        //          gbl_homeUseMODE               gbl_homeEditingState
        //
        //      "edit mode"   (yellow bg) ----->  "view or change"
        //      "edit mode"   (yellow bg) ----->  "add"
        //      "report mode" (brown  bg) ----->  "add"
        //   ----------------------------  -----------------------------
        //
    //

  NSLog(@"gbl_currentMenuPlusReportCode =[%@]",gbl_currentMenuPlusReportCode );
  NSLog(@"gbl_fromHomeCurrentEntity     =[%@]",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_homeUseMODE               =[%@]",gbl_homeUseMODE);
  NSLog(@"gbl_homeEditingState          =[%@]",gbl_homeEditingState);

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"HOME" ]  
        && [gbl_homeUseMODE               isEqualToString: @"report mode" ] ) 
    {
nbn(1);
        gbl_helpScreenDescription = @"HOME";

        myNavBarLabel.text                      = @"Me and my BFFS ";
        myNavBarLabel.adjustsFontSizeToFitWidth = YES;
        [myNavBarLabel sizeToFit];

        self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

    }  // "HOME" screen

    //  WHEN TO SHOW EDIT INFO
    //
    //    1.  add/change screen (always yellow)
    // or 2.  home screen in yellow edit mode
    // or 3.  home screen in brown report mode and "+" hit
    //
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"HOMEaddchange" ]      // add/change screen (always yellow)
        || (
                [gbl_currentMenuPlusReportCode isEqualToString: @"HOME"      ]  
             && [gbl_homeUseMODE               isEqualToString: @"edit mode" ]    // home screen in yellow edit mode
           )
//        || (
//                [gbl_currentMenuPlusReportCode isEqualToString: @"HOME"        ]  
//             && [gbl_homeUseMODE               isEqualToString: @"report mode" ]
//             && [gbl_homeEditingState          isEqualToString: @"add"         ]  // home screen in brown report mode and "+" hit
//           )
      )
    {
        if ([gbl_fromHomeCurrentEntity  isEqualToString: @"group" ])
        {
            gbl_helpScreenDescription = @"HOMEaddchangeGROUP";

//            myNavBarLabel.text                      = @"Edit Group";
            myNavBarLabel.text                      = @"Edit Groups";
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];

            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        }

        if ([gbl_fromHomeCurrentEntity  isEqualToString: @"person" ])
        {
            gbl_helpScreenDescription = @"HOMEaddchangePERSON";

//            myNavBarLabel.text                      = @"Edit Person";
            myNavBarLabel.text                      = @"Edit People";
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];

            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        }

    }

    if (gbl_justPressedChangeGroupName == 1) {

        gbl_justPressedChangeGroupName  = 0;
        gbl_helpScreenDescription = @"addchangeGroupName"; 
//<.>
    }




    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"]    // calendar year
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbypcy"] 
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]    //  from best year
    ) {
        
        gbl_helpScreenDescription = @"calendar year";

        // try to fix title on right side
        //
//        CGRect frame    = CGRectMake(0, 0, 0, 44);
//        UILabel *Tlabel = [[UILabel alloc]initWithFrame:frame];
//        Tlabel.text     = @"Long-term Stress Levels";
//        [Tlabel sizeToFit];

//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
             

//           [[self navigationItem] setTitle: @"Long-term Stress Levels"];
           myNavBarLabel.text          =  @"Long-term Stress Levels";
           myNavBarLabel.adjustsFontSizeToFitWidth = YES;
           [myNavBarLabel sizeToFit];
           self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

//             self.navigationItem.titleView = Tlabel;
//self.navigationController.navigationBar.topItem.backBarButtonItem = nil;

        self.navigationItem.backBarButtonItem.title=@"";
    }


    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]    // my best match (grpone)
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]    // my best match (grpone)

      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]    // my best match (grpone)
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]    // my best match (grpone)

      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]    //    best match (grpall)
    ) {
        gbl_helpScreenDescription = @"best match";
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//           [[self navigationItem] setTitle: @"#################"];
           myNavBarLabel.text          =  @"Best match";
           myNavBarLabel.adjustsFontSizeToFitWidth = YES;
           [myNavBarLabel sizeToFit];
           self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

        });
    }


    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]    // what color is the day?
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]    // what color is the day?
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]    // what color is the day? from best day
    ) {
        gbl_helpScreenDescription = @"what color";
//        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: @"Short-term Stress Levels"];
nbn(88);
           myNavBarLabel.text          =  @"Short-term Stress Levels";
           myNavBarLabel.adjustsFontSizeToFitWidth = YES;
           [myNavBarLabel sizeToFit];
           self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

//        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]   // Personality

        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]   // Personality

        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]   // Personality

        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmappe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmeppe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmrppe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmpppe"]   // Personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmdppe"]   // Personality
    ) {
        gbl_helpScreenDescription = @"personality";
        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: @"Personality"];
            myNavBarLabel.text          =  @"Personality";
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];
            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]   // compatibility just 2 people
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbmco"]   // compatibility just 2 people
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbmco"]   // compatibility just 2 people
    ) {
        gbl_helpScreenDescription = @"just 2";
        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: @"Compatibility Potential"];
            myNavBarLabel.text          =  @"Compatibility Potential";
//    myNavBarLabel.textColor     = [UIColor cyanColor];
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];

//            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
//            dispatch_async(dispatch_get_main_queue(), ^{  
//self.navigationItem.rightBarButtonItems = self.navigationItem.rightBarButtonItems;
//self.navigationItem.leftBarButtonItems  = self.navigationItem.leftBarButtonItems;
                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
//            });

        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
    ) {
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Assertive";
            myMostWhat                = @"Assertive";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Emotional";
            myMostWhat                = @"Emotional";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Restless";
            myMostWhat                = @"Restless";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Passionate";
            myMostWhat                = @"Passionate";
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
        ) {
            gbl_helpScreenDescription = @"most reports";
            myMostTitle               = @"Most Down-to-earth";
            myMostWhat                = @"Down-to-earth";
        }

        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: myMostTitle];  // like Most Passionate in Swim Team
            myNavBarLabel.text          =  myMostTitle;
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];
            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

        });
    } // all Most reports


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]   // Best Year
    ) {
        gbl_helpScreenDescription = @"best year";
        myMostTitle               = @"Best Year in Group";
        myMostWhat                = @"Best Year";

        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: myMostTitle];  // like Most Passionate in Swim Team
            myNavBarLabel.text          =  myMostTitle;
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];
            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

        });
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]   // Best Day
    ) {
        gbl_helpScreenDescription = @"best day";
        myMostTitle               = @"Best Day in Group";
        myMostWhat                = @"Best Day";

        dispatch_async( dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: myMostTitle];  // like Most Passionate in Swim Team
            myNavBarLabel.text          =  myMostTitle;
            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];
            self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        });
    }

} // viewDidLoad



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  NSLog(@"gbl_justLookedAtInfoScreen  bef in cellForRow in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );
    gbl_justLookedAtInfoScreen = 1;
//  NSLog(@"gbl_justLookedAtInfoScreen  aft in cellForRow in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );

    
//  NSLog(@"in IINFO   cellForRowAtIndexPath!");
//  NSLog(@"indexPath.row=%ld",indexPath.row);

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"view_info_CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CellIdentifier];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: CellIdentifier];
    }

//    UIImage *myImageWhatColor        = [UIImage  imageNamed: @"whatColor_info2.png" inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageWhatColor        = [UIImage  imageNamed: @"whatColor_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageScore            = [UIImage  imageNamed: @"score_info2.png"       inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings2       = [UIImage  imageNamed: @"twoThings_info.png"  inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info3.png"      inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info2.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageWillpower        = [UIImage  imageNamed: @"willpower_info2.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info6.png"      inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info8.png"      inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImagePersonality      = [UIImage  imageNamed: @"person_info10.png"      inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info3.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info9.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories5.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_6.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info10.png" inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info11.png" inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info10.png" inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageCategories3      = [UIImage  imageNamed: @"categories3_info14.png" inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info5.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info8.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info9.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageTwoThings        = [UIImage  imageNamed: @"twoThings_info9b.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//  NSLog(@"myImageTwoThings        =[%@]",myImageTwoThings        );
//    UIImage *myImageWillpower        = [UIImage  imageNamed: @"willpower_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageWillpower        = [UIImage  imageNamed: @"willpower_info5.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageWillpower        = [UIImage  imageNamed: @"willpower_info6.png"   inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myImageDestiny          = [UIImage  imageNamed: @"overcomDestiny_info2.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageDestiny          = [UIImage  imageNamed: @"overComDestiny_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageDestiny          = [UIImage  imageNamed: @"overComDestiny_info5.png"   inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageDestiny          = [UIImage  imageNamed: @"overComDestiny_info6.png"   inBundle: nil compatibleWithTraitCollection: nil ];
    UIImage *myImageDestiny          = [UIImage  imageNamed: @"overComDestiny_info3.png"   inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myImageTraits           = [UIImage  imageNamed: @"overcomTraits_info2.png"    inBundle: nil compatibleWithTraitCollection: nil ];
//    UIImage *myImageTraits           = [UIImage  imageNamed: @"overcomTraits_info3.png"    inBundle: nil compatibleWithTraitCollection: nil ];

//    UIImage *myIconmamb           = [UIImage  imageNamed: @"icon_mamb09_0064.png"    inBundle: nil compatibleWithTraitCollection: nil ];



//    UIFont *myFont       = [UIFont fontWithName: @"Menlo-bold" size: 12.0];
//    UIFont *myFont        = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 13.0];
//    UIFont *myFontForText = [UIFont boldSystemFontOfSize: 15.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 15.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo" size: 14.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 13.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo" size: 13.0];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 13.2];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 12.8];
//    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 12.0];
    UIFont *myFontForText = [UIFont fontWithName: @"Menlo-bold" size: 12.5];

//    UIFont *myFontOnSide = [UIFont fontWithName: @"Menlo"      size: 10.0];
//    UIFont *myFontOnSide = [UIFont fontWithName: @"Menlo-bold" size: 10.0];
//    UIFont *myFontOnSide = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
//    UIFont *myFontOnSide  = [UIFont fontWithName: @"Menlo-bold" size: 12.0];
//    UIFont *myFontOnSide  = [UIFont fontWithName: @"Menlo-bold" size: 13.0];
//    UIFont *myFontOnSide  = [UIFont fontWithName: @"Menlo" size: 13.0];
    UIFont *myFontOnSide  = [UIFont fontWithName: @"Menlo-bold" size: 12.0];


//    UIFont *myTitleFont  = [UIFont fontWithName: @"Menlo-bold" size: 13.1];
//    UIFont *myTitleFont  = [UIFont fontWithName: @"Menlo-bold" size: 14.5];
//    UIFont *myTitleFont   = [UIFont fontWithName: @"Menlo-bold" size: 15.5];
    UIFont *myTitleFont   = [UIFont fontWithName: @"Menlo-bold" size: 17.0];

//    UIFont *myDisclaimerFont= [UIFont fontWithName: @"Menlo-bold" size:  8.0];
    UIFont *myDisclaimerFont= [UIFont fontWithName: @"Menlo-bold" size:  9.0];

    UIFont *myFontForSwitch  = [UIFont fontWithName: @"Menlo-bold" size: 16.0];



    //
    // For instance let's say your app supports iPhones > 4s, so iPhone: 4s, 5, 5s, 6 and 6plus.
    // Make sure to make launch-images which have the following dimensions:
    //         iPhone4s    =  640 ×  960
    //         iPhone5, 5s =  640 × 1136
    //         iPhone6     =  750 x 1334
    //         iPhone6plus = 1242 x 2208
    //
    CGFloat myScreenWidth; //  myFontSize;  // determine font size
    myScreenWidth = self.view.bounds.size.width;

    if (        myScreenWidth >= 414.0)                                          // 6+ and 6s+  and bigger
    {
        myFontForText    = [UIFont fontWithName: @"Menlo-bold" size: 12.5];
        myFontOnSide     = [UIFont fontWithName: @"Menlo-bold" size: 12.0];
        myTitleFont      = [UIFont fontWithName: @"Menlo-bold" size: 17.0];
        myDisclaimerFont = [UIFont fontWithName: @"Menlo-bold" size: 12.0];
        myFontForSwitch  = [UIFont fontWithName: @"Menlo-bold" size: 16.0];
    }
    else if (   myScreenWidth  < 414.0                                          // 6 and 6s
             && myScreenWidth  > 320.0)   
    {
        myFontForText    = [UIFont fontWithName: @"Menlo-bold" size: 11.5];
        myFontOnSide     = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
        myTitleFont      = [UIFont fontWithName: @"Menlo-bold" size: 16.0];
        myDisclaimerFont = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
        myFontForSwitch  = [UIFont fontWithName: @"Menlo-bold" size: 15.0];
    }
    else if (   myScreenWidth <= 320.0)                                          //  5s and 5 and 4s and smaller
    {
        myFontForText    = [UIFont fontWithName: @"Menlo-bold" size: 10.5];
        myFontOnSide     = [UIFont fontWithName: @"Menlo-bold" size: 10.0];
        myTitleFont      = [UIFont fontWithName: @"Menlo-bold" size: 15.0];
        myDisclaimerFont = [UIFont fontWithName: @"Menlo-bold" size:  9.0];
        myFontForSwitch  = [UIFont fontWithName: @"Menlo-bold" size: 14.0];
    }



    NSString *myTextLabelTextAddOn;  // depends on report

    // =================================================================================================================================
    // house of cards rules look like this:
    //   if there is an image, have text = some string (not = nil)
    //                cell.textLabel.text          = @" ";
    //                cell.imageView.image = myImageDestiny;
    //   on spacer cells have this:
    //                cell.textLabel.text          = nil;
    //                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
    //                cell.backgroundView          = nil ;
    //
    if (  [gbl_helpScreenDescription isEqualToString: @"calendar year"] )
    {
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.textLabel.attributedText = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {
            NSString *myIntroString;

//            myIntroString = [NSString stringWithFormat: 
//                @"The two 6-month Graphs show the overall stress level for %@ on every second day in %ld.", 
//                    gbl_viewHTML_NAME_personJust1,
//                    (long)gbl_currentYearInt
//            ]; //   not          (long)gbl_currentYearInt];
//
//            myIntroString = [NSString stringWithFormat: 
//                @"The two 6-month Graphs show the overall stress level for %@ on every second day in the year selected.", 
//                    gbl_viewHTML_NAME_personJust1
//            ]; 
//
            myIntroString =
              @"The two 6-month Graphs show the overall stress level for the selected person on every second day in the selected year."; 

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== intro text for FUT
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = myIntroString;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for quick start guide 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Quick Start Guide";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 4) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for quick start guide
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Look for times when the graph goes below the red \"STRESS\" line into the red zones.  When the graph stays in the red zones for a few weeks or months, then it is more likely to be a stressful time.\n\nThe bottom of the graph has the months of the year marked.\n\nWhen the graph goes up into the green zones it means more peaceful times are likely.\n";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for score info 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Labels inside the Graph";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {
            NSString *text_cGr2 = @" GREAT  ";
            NSString *text_cGre = @" GOOD   ";
            NSString *text_cNeu = @"          neutral gray area (no label)     ";
            NSString *text_cRed = @" STRESS ";
            NSString *text_cRe2 = @" OMG    ";

            NSString *allLabelExplaintext = [NSString stringWithFormat:
//              @" %@  very peaceful\n %@  peaceful\n %@\n %@  stressful\n %@  very stressful\n\n  Stressful and very stressful zones are colored red because stress is generally considered challenging.\n\n  The green zones are the opposite of stress.  Notice that the opposite of stressful is peaceful.\n\nIf your graph goes way up into the green zones, it generally does not mean fantastic excitement with kaleidiscopic fireworks.  Green means serene, calm, restful, tranquil.",
              @" %@  very peaceful\n %@  peaceful\n %@\n %@  stressful\n %@  very stressful\n\nThe stressful and very stressful zones are colored red.\n\nThe green zones are the opposite of stressful.  Notice that the opposite of stressful is peaceful.\n\nIf your graph goes way up into the green zones, it seldom means fantastic excitement with fireworks.  Green is usually serene, calm, restful, tranquil.",
                text_cGr2,
                text_cGre,
                text_cNeu,
                text_cRed,
                text_cRe2 
            ];

//  NSLog(@"allLabelExplaintext =%@",allLabelExplaintext );
//  NSLog(@"text_cGr2=%@",text_cGr2);

            // Define needed attributes for the entire allLabelExplaintext 
            NSDictionary *myNeededAttribs = @{
//                                      NSForegroundColorAttributeName: self.label.textColor,
//                                      NSBackgroundColorAttributeName: cell.textLabel.attributedText
//                                      NSBackgroundColorAttributeName: cell.textLabel.textColor
                                      NSFontAttributeName: cell.textLabel.font,
                                      NSBackgroundColorAttributeName: cell.textLabel.backgroundColor
                                      };

            NSMutableAttributedString *myAttributedTextLabelExplain = 
                [[NSMutableAttributedString alloc] initWithString: allLabelExplaintext
                                                       attributes: myNeededAttribs     ];

//  NSLog(@"myAttributedTextLabelExplain #1 =%@",myAttributedTextLabelExplain );

            // set text attributes on appropriate substring text inside myAttributedTextLabelExplain 
            // * Notice that usage of rangeOfString here may cause some bugs - I use it here only for demonstration
            //
            //       e.g.   range: NSMakeRange(0,9)  ];          // offset, length
            // 
            NSRange range_whole = NSMakeRange(0, allLabelExplaintext.length);
            NSRange range_cGr2 = [allLabelExplaintext rangeOfString: text_cGr2];
            NSRange range_cGre = [allLabelExplaintext rangeOfString: text_cGre];
            NSRange range_cNeu = [allLabelExplaintext rangeOfString: text_cNeu];
            NSRange range_cRed = [allLabelExplaintext rangeOfString: text_cRed];
            NSRange range_cRe2 = [allLabelExplaintext rangeOfString: text_cRe2];

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cBgr 
                                                 range: range_whole       ];

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cGr2 
                                                 range: range_cGr2        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFontForText 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cGre 
                                                 range: range_cGre        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFontForText 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cNeu 
                                                 range: range_cNeu        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFontForText 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cRed 
                                                 range: range_cRed        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFontForText 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length

            [myAttributedTextLabelExplain addAttribute: NSBackgroundColorAttributeName 
                                                 value: gbl_color_cRe2 
                                                 range: range_cRe2        ];          // offset, length
            [myAttributedTextLabelExplain addAttribute: NSFontAttributeName
                                                 value: myFontForText 
                                                 range: NSMakeRange(0, myAttributedTextLabelExplain.length)  ];  // offset, length


//  NSLog(@"myAttributedTextLabelExplain #2 =%@",myAttributedTextLabelExplain );


//  NSLog(@"myAttributedTextLabelExplain #7 =%@",myAttributedTextLabelExplain );

            // BEWARE: the order and what is here is a fragile house of cards    DO NOT CHANGE ANYTHING
            //
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for label explain
                cell.textLabel.textColor      = [UIColor blackColor];
                cell.userInteractionEnabled   = NO;
                cell.textLabel.font           = myFontForText;
                cell.backgroundColor          = gbl_color_cBgr;
                cell.textLabel.numberOfLines  = 0;
//                cell.textLabel.numberOfLines  = 25;
//                cell.textLabel.text           = allLabelExplaintext; // for test
                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedTextLabelExplain;
                cell.imageView.image          = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView           = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }


        if (indexPath.row == 7) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 8) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for time frame influences
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Time Frame Influences";
                cell.textLabel.text          = @"Time Frame Hills and Valleys";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 9) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for time frame influences
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"A starting date and ending date tell when the inluence for that time frame is working.  The influence will be favorable or challenging.\n\nChallenging influences look like a valley or letter \"u\" on the graph.\nFrom the start of the time frame the influence gradually falls down to it's lowest point at the middle of the time frame.  From there, it gradually rises up until it reaches the end of the time frame.\n\nFavorable influences look like a hill or letter \"n\" on the graph.\nFrom the beginning of the time frame the influence gradually rises up to it's highest point at the middle of the time frame.  From there, it gradually falls down until it reaches the end of the time frame.";
//                cell.textLabel.text          = @"A starting date and ending date tell when the inluence for that time frame is working.  The influence will be favorable or challenging.\n\nChallenging influences look like a valley on the graph.\nFrom the start of the time frame the graph gradually falls down to it's lowest point at the middle of the time frame.  From there, the graph gradually rises up until it reaches the end of the time frame.\n\nFavorable influences look like a hill on the graph.\nFrom the beginning of the time frame the graph gradually rises up to it's highest point at the middle of the time frame.  From there, the graph gradually falls down until it reaches the end of the time frame.";
                cell.textLabel.text          = @"A starting date and ending date tell when the influence for that time frame is working.  The influence is favorable or challenging.\n\nA time frame with a favorable influence looks like a hill on the graph.\n\nA time frame with a challenging influence looks like a valley on the graph.\n";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 10) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 11) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The 1 to 99 Score for the Whole Year";
                cell.textLabel.text          = @"Year Summary Score";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 12) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for year summary score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"A score from 1 to 99 is calculated from the amount of time spent in the green zones and red zones over the whole year.\n\nThe score tells how favorable or challenging the year overall is.\n\nChallenging times can be tough. However, because we have free will, even challenging times can be bettered by will power.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 13) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
//                cell.backgroundColor         = [UIColor blueColor];
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 14) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;


//                cell.textLabel.text          = nil;
//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
                cell.textLabel.text          = @" ";
                cell.imageView.image = myImageDestiny ;
                cell.backgroundView          = nil ;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 15) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
//                cell.backgroundColor         = [UIColor cyanColor];
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 16) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }
              // end of calendar year


//"
//
//The Labels on the Graph
//
//
//GREAT   very peaceful
//GOOD    peaceful
//neutral grey area (no label)
//STRESS  stressful
//OMG     very stressful
//
//Stressful and very stressful zones are colored red because stress is generally considered negative.
//The green zones are the opposite of Stress.
//Notice that the opposite of stressful is peaceful.
//If your graph goes way up into the green zones, it generally does not mean
//fantastic excitement with kaleidiscopic fireworks. 
//Green means serene, calm, restful, tranquil.  Think yoga meditation.
//
//
//The Important Periods
//
//Each period has a date range when the inluence for the period is in effect.
//The influence will be favorable or challenging.  
//
//On the graph, favorable influences look like a hill or letter "n".  
//From the beginning of the date range
//the influence gradually rises up
//to the highest point at the middle of the date range.
//From there, the influence gradually falls down
//until it reaches the end of the date range.
//
//On the graph, challenging influences look like a valley or letter "u".  
//From the start of the date range
//the influence gradually falls down
//to the lowest point at the middle of the date range.
//From there, the influence gradually rises up
//until it reaches the end of the date range.
//
//the 1 to 99 "score" for the year
//
//";
//
//
//        UIFont *currentFont       = cell.textLabel.font;
//        UIFont *currentFontBolded = [myappDelegate boldFontWithFont: (UIFont *) currentFont];
////  NSLog(@"currentFontBolded =%@",currentFontBolded );
//
//        //myNewCellText                = @"    This report is for entertainment purposes only.  ";
//        NSAttributedString *myNewCellAttributedText2 = [
//            [NSAttributedString alloc] initWithString:  @"       This report is for entertainment purposes only.  "
//                                           attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
//                                                           NSForegroundColorAttributeName: [UIColor redColor]               }
//        ];
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            cell.textLabel.font           = currentFontBolded;
//            cell.textLabel.numberOfLines  = 1; 
//            cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
//            cell.userInteractionEnabled   = NO;
//            cell.textLabel.attributedText = myNewCellAttributedText2;
//        });
//
//        return cell;
//
//    }  // end of 3 of 3 FOOTER CELLS
//
//
    } // end of "calendar year"


    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"best match"] )   // my best match (grpone)  plus best match (grpall)
    {
nbn(100);
        if (indexPath.row == 0) {                              // <===  preamble
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"The scores in this report measure Compatibility Potential: how likely two people can form a good relationship, assuming both people also show mostly positive personality traits.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for score info 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Scores in Group Reports";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 4) {                          // score image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"All group Reports are ranked by Score\n\nScores go from 1 to 99\n\nA score of 88 is higher than 88% of all scores in the world\n\nA score of 11 is higher than 11% of all scores in the world \n\nEach score is called a Percentile Rank\n\nHighest 25% are green\nLowest  25% are red";

                cell.imageView.image         = myImageScore;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 5) {

nbn(100);
//            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]
//            ){   // my best match (grpone)
//
//                myTextLabelTextAddOn = [NSString stringWithFormat: 
//                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
////                    gbl_lastSelectedPerson, gbl_lastSelectedGroup, gbl_lastSelectedPerson];
//                    gbl_TBLRPTS1_NAME_personJust1, gbl_lastSelectedGroup, gbl_TBLRPTS1_NAME_personJust1];
////  NSLog(@"gbl_TBLRPTS1_PSV_personJust1=%@",gbl_TBLRPTS1_PSV_personJust1);
//
//


//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]    // my best match (grpone)
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]    // my best match (grpone)
//
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]    // my best match (grpone)
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]    // my best match (grpone)
//
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]    //    best match (grpall)
//    ) 
//


//            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
                   if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
            ) {   // my best match (grpone)  FROM home > choose person > choose RPT best match in grp > choose group
                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
                    gbl_TBLRPTS1_NAME_personJust1, gbl_lastSelectedGroup, gbl_TBLRPTS1_NAME_personJust1];

            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]
            ) {   //    best match (grpall)  FROM home > choose group > choose RPT best match
                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match in Group %@\", each score measures the compatibility potential for two people who are members of the group.",
                     gbl_lastSelectedGroup];

            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]
            ) {   // my best match (grpone) FROM home > choose grp > choose RPT best match > TAP pair > choose RPT best match for A in same group

                NSString *myPersonA_name;
                myPersonA_name = [gbl_PSVtappedPersonA_inPair componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
                    myPersonA_name , gbl_lastSelectedGroup, myPersonA_name ];

            } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]
                       || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]
            ) {   // my best match (grpone) FROM home > TAP grp > SELRPT best match >                  TAP pair > SELRPT best match for B in same grp
                  // my best match (grpone) FROM home > TAP per > SELRPT best match in grp > TAP grp > TAP pair > SELRPT best match for B in same grp
                NSString *myPersonB_name;
                myPersonB_name = [gbl_PSVtappedPersonB_inPair componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

                myTextLabelTextAddOn = [NSString stringWithFormat: 
                    @"\n\nFor this report, \"Best Match for %@ in Group %@\", each score measures the compatibility potential for %@ and one person from the group.",
                    myPersonB_name , gbl_lastSelectedGroup, myPersonB_name ];


            } else {
                myTextLabelTextAddOn = @" ";
            }

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          =  myTextLabelTextAddOn;
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 7) {                                // <=== title for Complexity info 
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Relationships are Complex";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 8) {                              // <===  complexity #1
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility score if one of the two people (or both) have bad personality traits.";
                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility potential score if one of the two people (or both) have challenging personality traits.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 9) {                            // <=== two things image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageTwoThings] ;
                cell.imageView.image         = myImageTwoThings;
                cell.backgroundView          = nil;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 11) {                         // <===  complexity #2
            dispatch_async(dispatch_get_main_queue(), ^{        
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  Habits are extremely difficult to overcome, but it can be done.";
                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  Overcoming habits is very hard, but possible.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 12) {                            // <=== willpower image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageWillpower] ;
                cell.imageView.image = myImageWillpower;
                cell.backgroundView          = nil ;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 13) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 14) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }


    } // end of "best match"


    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"just 2"] )   // "Compatibility Paired with ..." or "Compatibility Potential"
    {
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 1) {                          // preamble
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Compatiblity Potential is how likely two people can form a good relationship-  assuming both people also show mostly positive personality traits.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for score info 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Compatibility Potential Score";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 4) {                          // score image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"\nScores go from 1 to 99\n\nA score of 88 is higher than 88% of all scores in the world\n\nA score of 11 is higher than 11% of all scores in the world \n\nEach score is called a Percentile Rank\n\nHighest 25% are green\nLowest  25% are red";

                cell.imageView.image         = myImageScore;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {                              // <===  complexity #1
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility score if one of the two people (or both) have bad personality traits.";

//                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility potential score if one of the two people (or both) have challenging personality traits.";
                cell.textLabel.text          = @"The Compatibility Potential score for two people takes into account many influences between the two.  But, within each person, good personality traits are assumed.\n\nThe potential of a good relationship can be ruined despite a high compatibility potential score if one of the two people (or both) have challenging personality traits.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 7) {                            // <=== two things image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";

//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageTwoThings] ;
                cell.imageView.image = myImageTwoThings;
                cell.backgroundView          = nil ;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 8) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 9) {                         // <===  complexity #2
            dispatch_async(dispatch_get_main_queue(), ^{        
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"HOWEVER, because we have free will, even bad personality traits can be overcome by intense will power.  It is extremely difficult to overcome bad habits, but it can be done.";
//                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  It is extremely difficult to overcome habits, but it can be done.";
                cell.textLabel.text          = @"HOWEVER, because we have free will, even challenging personality traits can be overcome by intense will power.  Overcoming habits is very hard, but possible.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {                            // <=== willpower image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageWillpower] ;
                cell.imageView.image = myImageWillpower;
                cell.backgroundView          = nil ;


                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 11) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 12) {                                // <=== title for 3 categories  3 fun categories
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The 3 Fun Categories";
//                cell.textLabel.text          = @"Three Relationship Categories";
                cell.textLabel.text          = @"3 Relationship Categories";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 13) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 14) {                              // <===  text #1 for 3 categories
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Out of the many factors making up the Compatibility Potential Score, these 3 categories are fun to look at separately.";

                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 15) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 16) {                            // <=== 3 categories image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = nil;
//                cell.textLabel.text          = @"xxxxx";
//                cell.textLabel.text          = @" ";
                cell.textLabel.text          = @"example";

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageCategories3] ;
                cell.imageView.image         = myImageCategories3;
                cell.backgroundView          = nil;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 17) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 18) {                              // <===  text #2 for 3 categories
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

//                cell.textLabel.text          = @"The \"Closeness\" category is useful because it shows the natural ease of liking the other person in a comfortable way.\n\nThe 2 \"Point of view\" categories occasionally show that one of the two people sees the relationship as being very favorable but the other person sees it as very challenging.";
cell.textLabel.text          = @"The \"Closeness\" category is useful because it shows the natural ease of liking the other person in a comfortable way.\n\nThe 2 \"Point of view\" categories occasionally show that one of the two people sees the relationship as being very favorable but the other person sees it as very challenging.\n\nA good sign of compatibility potential in a category is when favorable green plus signs (++) cover a full line or more.\n\nA good sign of compatibility potential in a category is when it has double the length of the favorable green ++ compared to the challenging red --.";

                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }
        if (indexPath.row == 19) {                           // <=== space 
            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 20) {                                // <=== title for Complexity info 
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Relationships are Complex";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 21) {                           // <=== 

            // CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
            // NSLog(@"currentScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
            // NSLog(@"currentScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
            //
//            CGSize myTextSize = [@"WWW4"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            CGSize myTextSize = [@""  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeIndent =  myTextSize.width;
  NSLog(@"mySizeIndent =[%f]",mySizeIndent );

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
//@"The Compatibility Potential number from 1 to 99 gives an overall score for the relationship.\n\nIt's a very hard job to combine all the influences affecting a relationship to get an overall picture.\n\n  \u2022 the Compatibility Potential score\n  \u2022 the 3 relationship categories\n  \u2022 all the relationship influences\n  \u2022 the personality report has all the personality influences for each of the 2 people\n\nRelationships are complex."
//@"The Compatibility Potential number from 1 to 99 gives an overall score for the relationship.\n\nIt's a very hard job to combine all the influences affecting a relationship to get an overall picture.\n\nRelationships are complex."
@"It's a very hard job to combine all the influences affecting a relationship to get an overall picture.\n\nRelationships are complex."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];



            dispatch_async(dispatch_get_main_queue(), ^{  
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"The compatibility details on the bottom give a LOT of detail.  It's hard work to combine the differing influences into an overall picture.\n\nIn doing his integration you have\n  - the 3 categories\n  - details at the bottom\n  - a personality report for each\n    of the 2 people\n\nA lot of the integration is done for you in the compatibility Potential score from 1 to 99.";

//This is why consulting astrologers can make a living meeting with people for an hour to sort everything out
//                cell.textLabel.text          = @"The Compatibility Potential number from 1 to 99 gives an overall score for the relationship.\n\nIt's a very hard job to combine all the influences affecting a relationship to get an overall picture.\n\nThis report has\n  - the Compatibility Potential score\n  - the 3 relationship categories\n  - the description of relationship influences\n\nThe personality report has\n  - descriptions of personality influences\n    for each of the 2 people\n\nRelationships are complex.";
//                cell.textLabel.text          = @"The Compatibility Potential number from 1 to 99 gives an overall score for the relationship.\n\nIt's a very hard job to combine all the influences affecting a relationship to get an overall picture.\n\nThis report has\n  - the Compatibility Potential score\n  - the 3 relationship categories\n  - all the relationship influences\n\nThe personality report has\n  - all the personality influences\n    for each of the 2 people\n\nRelationships are complex.";



                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;



                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 22) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }

    } // end of "just 2"



 

    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"what color"]  )  // pwc wc
    {

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"What Color is the Day?\n\nUse this report to check out today and yesterday and the next few days.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;


            });
            return cell;
        }
        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"The score measures stress levels on this day for this person.\n\nA day with a lower score, say below 10, is likely to be more stressful, whereas a day with a high score, like above 90, is likely to be more peaceful.";
//                cell.textLabel.text          = @"The score measures stress levels on this day for this person.\n\nFor example, a day with a lower score in the red zones is likely to be more stressful, whereas a day with a higher score in the green zones is likely to be more peaceful.";
                cell.textLabel.text          = @"The score measures stress levels on this day for this person.\n\nA day with a lower score in the red zones is more likely to have stressful times, whereas a day with a higher score in the green zones is more likely to have peaceful times.";

                cell.imageView.image = myImageWhatColor;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"The stress level score in this report is calculated from very short-term influences whose effects last just a few hours or a day or two.\n\nFar more important is the \"Calendar Year\" report where the influences are much stronger and they can last for many weeks or even months.";
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;

                cell.imageView.image = myImageDestiny ;
                cell.backgroundView          = nil ;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  6) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }

    } // end of "what color"


    // =================================================================================================================================
    if (  [gbl_helpScreenDescription isEqualToString: @"personality"] )
    {

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {                                // <=== size of traits
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Size of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 2) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          =  @"Each TRAIT is a general catgegory of interest in a person.\n\nEach SCORE for a trait measures \"how much\" of that trait the person has.\n\nA really low score or really high score is neither good nor bad.  The score just measures how much of that trait the person has.";
                cell.textLabel.text          =  @"Each TRAIT is a general catgegory of interest in a person.\n\nEach SCORE for a trait measures \"how much\" of that trait the person has.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world\n\nA really low score or really high score is neither favorable nor challenging. That's why the scores are not shown with green and red colors because those colors mean favorable and challenging.";
//
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"e.g.";
                cell.textLabel.text          = @"example";

                cell.imageView.image = myImagePersonality;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
//@"\u2022 Down-to-earth\n     stable, practical, ambitious\n\u2022 Passionate\n     intense, enthusiastic, relentless\n\u2022 Emotional\n     protective, sensitive, possessive\n\u2022 Restless\n     versatile, independent, changeable\n\u2022 Assertive\n     competitive, authoritative, outspoken"
@"  \u2022 Down-to-earth\n    stable, practical, ambitious\n  \u2022 Passionate\n    intense, enthusiastic, relentless\n  \u2022 Emotional\n    protective, sensitive, possessive\n  \u2022 Restless    \n    versatile, independent, changeable\n  \u2022 Assertive\n    competitive, authoritative, outspoken"

                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText ;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

//                cell.textLabel.text          = @"Down-to-earth\n     stable, practical, ambitious\nPassionate\n     intense, enthusiastic, relentless\nEmotional\n     protective, sensitive, possessive\nRestless\n     versatile, independent, changeable\nAssertive\n     competitive, authoritative, outspoken";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
//        if (indexPath.row == 5) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.textLabel.font          = myFont;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//
//                cell.textLabel.text          = [NSString stringWithFormat: 
//                    @"To compare %@'s highest score of %@ in \"%@\" against all people in a group, go to a group %@ is in and look at the report \"Most %@\".",
//                    gbl_viewHTML_NAME_personJust1,
//                    gbl_highestTraitScore,             // this goes in INFO for personality
//                    gbl_highestTraitScoreDescription,  // this goes in INFO for personality
//                    gbl_viewHTML_NAME_personJust1,
//                    gbl_highestTraitScoreDescription   // this goes in INFO for personality
//                ];
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//
//        if (indexPath.row == 6) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
//                cell.textLabel.font          = myFont;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
////                cell.textLabel.text          = @"Scores go from 1 to 99\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world\nEach score is called a Percentile Rank";
//                cell.textLabel.text          = @"Scores go from 1 to 99\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world";
//                cell.imageView.image         = nil;
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 6) {                                // <=== title for quality of traits
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"Quality of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 7) {                                // text for quality
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText ;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"The text below the table of traits gives favorable and challenging influences.\n\nBUT, a person can use FREE WILL to act on traits and change them.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

//        if (indexPath.row == 8) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
//                cell.textLabel.font          = myFontForText;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = nil;
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//
//
        if (indexPath.row == 8) {                            // <=== overcome traits image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";

//                cell.imageView.image = myImageTraits;
                cell.imageView.image         = myImageWillpower;
                cell.backgroundView          = nil ;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 10) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            });
            return cell;
        }

    } // end of "personality"


    if (  [gbl_helpScreenDescription isEqualToString: @"most reports"] )
    {   // all Most ... in Group ... reports

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 1) {                                // <=== title for how much
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Size of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 2) {


            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = [NSString stringWithFormat: @"This %@ report measures the \"size\" of the trait %@ within each person.\n\nEach SCORE measures \"how much\" of the trait %@ the person has.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88%% of all scores in the world\nA score of 11 is higher than 11%% of all scores in the world\n\nA really low score or really high score is neither favorable nor challenging. That's why the scores are not shown with the colors green/red because those colors mean favorable/challenging.",
                    myMostTitle, myMostWhat, myMostWhat
                ];
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 3) {                                // <=== title for quality of traits
            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Quality of Personality Traits";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 4) {                                // <=== reference to Personality report
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = @"The Personality report for each person gives you the \"quality\" of the personality traits of that person.\n\nIn the Personality report look at the text below the table.  This is where favorable and challenging influences are.";
                cell.textLabel.text          = @"Tap on a person to get their Personality Report.  This report gives you the \"quality\" of the personality traits of that person.\n\nIn the Personality report look at the text below the table.  This is where favorable and challenging influences are.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 6) {                                // <=== title for quality of traits

            NSString *myTraitTitle;
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
            ) {
                     myTraitTitle = @"Assertive";
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
            ) {
                     myTraitTitle = @"Emotional";

            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
            ) {
                     myTraitTitle = @"Restless";
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
            ) {
                     myTraitTitle = @"Passionate";
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
            ) {
                     myTraitTitle = @"Down-to-earth";
            }

            dispatch_async(dispatch_get_main_queue(), ^{      
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = myTraitTitle;
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

            });
            return cell;
        }

        if (indexPath.row == 7) {

            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // Most Assertive Person in Group
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of the trait \"%@\" is a domineering approach or hot-tempered behavior.\n\nA favorable expression of the trait \"%@\" is acting as a good leader and speaking up against injustices. ", myMostWhat , myMostWhat ];
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // Most Emotional
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of the trait \"%@\" is extreme sensitivity or being too impressionable.\n\nA favorable expression of the trait \"%@\" is alertness to other's feelings and protecting those less fortunate. ", myMostWhat , myMostWhat ];

            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // Most Restless 
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of the trait \"%@\" is a scattered approach and changeableness.\n\nA favorable expression of the trait \"%@\" is independence and versatility.", myMostWhat , myMostWhat ];
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // Most Passionate
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of the trait \"%@\" is overpowering intensity or holding grudges.\n\nA favorable expression of the trait \"%@\" is an enthusiastic attitude or doing a job with passion.", myMostWhat , myMostWhat ];
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // Most Down-to-earth
            ) {
                myGoodBadText = [NSString stringWithFormat: @"A challenging expression of the trait \"%@\" is rigidity and an uncompromising approach.\n\nA favorable expression of the trait \"%@\" is stability and a practical approach. ", myMostWhat , myMostWhat ];
            }

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontForText;
                ;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = myGoodBadText;
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 8) {                            // <=== overcome traits image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";
                cell.imageView.image         = myImageWillpower;
                cell.backgroundView          = nil ;

                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  10) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }
    }   // all Most ... in Group ... reports


    if (  [gbl_helpScreenDescription isEqualToString: @"best year"] )
    {   // all Most ... in Group ... reports

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Year Summary Score";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

                cell.textLabel.text          = @"The score tells how favorable or challenging the year overall is.\n\nA score is given for each person for the year.  The Calendar Year graph for the person is looked at. The amount of time that person spent in the green favorable zones and red challenging zones of the graph over the whole year determines the score.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88% of all scores in the world\nA score of 11 is higher than 11% of all scores in the world.\n\nChallenging times can be tough. However, because we have free will, even challenging times can be bettered by will power.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.text          = @" ";

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
                cell.imageView.image = myImageDestiny ;
                cell.backgroundView          = nil ;

            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  6) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }

    } // end of gbl_helpScreenDescription   "best year"


    if (  [gbl_helpScreenDescription isEqualToString: @"best day"] )
    { 

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Score for the Day";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 2) {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  for whole year score
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

                cell.textLabel.text          = [NSString stringWithFormat: @"The score measures stress levels on this day for each person person in group %@.\n\nA day with a lower score in the red zones is more likely to have stressful times, whereas a day with a higher score in the green zones is more likely to have peaceful times.\n\nScores go from 1 to 99.\nA score of 88 is higher than 88%% of all scores in the world\nA score of 11 is higher than 11%% of all scores in the world.\n\nThe stress level score in this report is calculated from very short-term influences whose effects last just a few hours or a day or two.\n\nFar more important is the \"Calendar Year\" report where the influences are much stronger and they can last for many weeks or even months.", gbl_lastSelectedGroup];

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row == 4) {                            // <=== overcome destiny image
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.textColor     = [UIColor blackColor]; // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.userInteractionEnabled  = NO;                   // black textcolor HAS TO BE FIRST, then cell.userInteractionEnabled = NO;
                cell.textLabel.font          = myFontOnSide;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;   // 0 means unlimited number of lines
//                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//                cell.textLabel.text          = nil;
                cell.textLabel.text          = @" ";

//                cell.imageView.image         = nil;
//                cell.backgroundView = [[UIImageView alloc] initWithImage: myImageDestiny] ;
                cell.imageView.image = myImageDestiny ;
                cell.backgroundView          = nil ;

            });
            return cell;
        }

        if (indexPath.row == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
            return cell;
        }
        if (indexPath.row ==  6) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"This report is for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

            });
            return cell;
        }

    } // end of gbl_helpScreenDescription   "best day"



    if ([gbl_helpScreenDescription isEqualToString: @"HOMEaddchangePERSON"] )
    { 
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                  // <=== title for 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Adding a Person";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  Add Person
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"There are 3 fields: name, birth city and birth date.  Tap in each field to enter information for it.  When you are done entering all the information, tap \"Done\".";
                cell.textLabel.text          = @"There are 3 fields: name, birth city and birth date.  Tap in each field to enter information for it.  When you are done entering all the information, tap \"Save\".";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 4) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Personal privacy
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"PERSONAL PRIVACY";
                cell.textLabel.text          = @"Personal Privacy";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 5) {

            // CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
            // NSLog(@"currentScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
            // NSLog(@"currentScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
            //
//            CGSize myTextSize = [@"WWW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            CGSize myTextSize = [@""  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo

            float  mySizeIndent =  myTextSize.width;
  NSLog(@"mySizeIndent =[%f]",mySizeIndent );

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeIndent;


//            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
//                initWithString:
////@"When you tap \"Done\" you get a choice of two Kinds of Save.\n\n1. \"Regular Save\"\n   This lets you or anyone go back in this app and look at and change the Birth City and Birth Date.\n\n2. \"Hide Birth Information Save\"\n   This is for when you want personal privacy for the new person at all times.  When you use this save choice, it means NOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n   That means, if you want to look at the birth information in the future, you need to write it down somewhere safe outside this app.\n\n\n   FURTHERMORE, whenever birth information goes outside this app, the Hide Birth Information mode is used:\n \u2022 when you share people or groups\n \u2022 when you do a full backup\n \u2022 when the app saves data for its own use"
////@"   When you tap \"Done\" you get a choice of two Kinds of Save.\n\n1. \"Regular Save\"\n   This lets you or anyone go back in this app and look at and change the Birth City and Birth Date.\n\n2. \"Hide Birth Information Save\"\n   This is for when you want personal privacy for the new person at all times.  When you use this save choice, it means NOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n   That means, if you want to look at the birth information in the future, you need to write it down somewhere safe outside this app.\n\n\n   FURTHERMORE, whenever birth information goes outside this app, the Hide Birth Information mode is used:\n   \u2022 when you share people or groups\n   \u2022 when you do a full backup\n   \u2022 when the app saves data for its own use"
//@"   When you tap \"Done\" you get a choice of two Kinds of Save.\n\n1. \"Regular Save\"\n   This kind of save lets you or anyone go back in this app and look at and change the Birth City and Birth Date.\n\n2. \"Hide Birth Information Save\"\n   This kind of save is for when you want personal privacy for the new person at all times.\n\n   NOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n   That means, if you want to look at the birth information in the future, you need to write it down somewhere safe outside this app.\n\n   FURTHERMORE, whenever birth information goes outside this app, the Hide Birth Information mode is always used:\n   \u2022 when you share people or groups\n   \u2022 when you do a full backup\n   \u2022 when the app saves data for its own use"
//                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
//            ];
//

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
//@"   When you tap \"Done\" you immediately get personal privacy for the new person\'s birth information at all times.\n\n   NOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n   That means, if you want to look at the birth information in the future, you need to save it somewhere safe outside this app.\n\n   FURTHERMORE, whenever birth information goes outside this running app, the birth information cannot be looked at:\n   \u2022 when you do a full backup\n   \u2022 when the app saves data for its own use"
//@"   When you tap \"Done\" you immediately get personal privacy for the new person\'s birth information at all times.\n\n   NOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n   That means, if you want to look at the birth information in the future, you need to save it somewhere safe outside this app."
//@"When you tap \"Done\" you immediately get personal privacy for the new person\'s birth information at all times.\n\nNOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\nThat means, if you want to look at the birth information in the future, you need to save it somewhere safe outside this app.\n\nWhen you add birth information for a new person, you need their permission to do so."
@"When you tap \"Save\" you immediately get personal privacy for the new person\'s birth information.\n\nNOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\nThat means, if you want to look at the birth information in the future, you need to save it somewhere safe outside this app.\n\nWhen you add birth information for a new person, you need their permission to do so."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];





            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for  Personal privacy
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"When you tap \"Done\" you get a choice of two Kinds of Save.\n\n     1. \"Regular Save\"\nThis lets you or anyone go back in this app and look at and change the Birth City and Birth Date.\n\n     2. \"No Look, No Change Save\"\nThis is for when you want personal privacy for the person at all times.  When you use this save choice, it means NOBODY, neither you nor the device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\nThat means, if you want to look at the personal information in the future, you need to write it down somewhere safe outside this app.\n\nWhenever personal information goes outside this app running in memory, the No Look, No Change mode is used:\n\n  - whenever you share people or groups\n  - whenever you do a full backup\n  - whenever the app saves information\n    for its own use.";


                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;


                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 7) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Person Name
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Person Name";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 8) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for person name
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Characters you can use in the person name:\n\n   abc defghijklmnopqrstuvwxyz\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nMaximum number of characters is 15.";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 10) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for  place of birth
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Birth City or Town";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 11) {


//            NSString *textWithYellowHighlight = @" Wheel > ";
            NSString *textWithYellowHighlight = gbl_titleForWheelButton;    //  gbl_titleForWheelButton = @"Wheel >";


            NSString *allTextBirthCityOrTown = [NSString stringWithFormat:
// @"Characters you can use in the place name:\n\n   abc defghijklmnopqrstuvwxyz-\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nType letters in the city name until the city you want appears in the city field.\n\nAs you type each letter, what you have typed so far appears in the title bar of the keyboard.\n\nAs a SHORTCUT, when there are fewer than 25 cities starting with the letters you have typed so far, a yellow button appears, %@ .  Tap that button to get a wheel you can spin to the city you want.\n\nIt's possible the city or town cannot be found.  In that case, type in a city nearby- especially a bigger city.",
// @"Characters you can use in the place name:\n\n   abc defghijklmnopqrstuvwxyz-\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nType letters in the city name until the city you want appears in the city field.\n\nAs you type each letter, the letters you have typed so far appear in the title bar of the keyboard.\n\nAs a SHORTCUT, when you type a letter and there are fewer than 25 cities starting with the letters you have typed so far, a yellow button appears, %@ .  Tap that button to get a wheel you can spin to the city you want.\n\nIt's possible the city or town cannot be found.  In that case, type in a city nearby- especially a bigger city.",
 @"Characters you can use in the place name:\n\n   abc defghijklmnopqrstuvwxyz-\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nType letters in the city name until the city you want appears in the city field.\n\nAs you type each letter, the letters you have typed so far appear right above the keyboard.\n\nAs a SHORTCUT, when you type a letter and there are fewer than 25 cities starting with the letters you have typed so far, a yellow button appears, %@ .  Tap that button to get a wheel you can spin to the city you want.\n\nIt's possible the city or town cannot be found.  In that case, type in a city nearby- especially a bigger city.",
                textWithYellowHighlight 
            ];

            // Define needed attributes for the entire allLabelExplaintext 
            NSDictionary *myNeededAttribs = @{
                                      NSFontAttributeName: cell.textLabel.font,
                                      NSBackgroundColorAttributeName: cell.textLabel.backgroundColor
                                      };

            NSMutableAttributedString *myAttributedTextBirthCityOrTown = 
                [[NSMutableAttributedString alloc] initWithString: allTextBirthCityOrTown 
                                                       attributes: myNeededAttribs     ];

  NSLog(@"myAttributedTextBirthCityOrTown #1 =%@",myAttributedTextBirthCityOrTown);

            // set text attributes on appropriate substring text inside myAttributedTextLabelExplain 
            // * Notice that usage of rangeOfString here may cause some bugs - I use it here only for demonstration
            //
            //       e.g.   range: NSMakeRange(0,9)  ];          // offset, length
            // 
            NSRange range_whole = NSMakeRange(0, allTextBirthCityOrTown .length);
            NSRange range_textWithYellowHighlight = [allTextBirthCityOrTown rangeOfString: textWithYellowHighlight ];
                

            [myAttributedTextBirthCityOrTown addAttribute: NSBackgroundColorAttributeName 
                                                    value: gbl_color_cBgr 
                                                    range: range_whole       ];

            [myAttributedTextBirthCityOrTown addAttribute: NSBackgroundColorAttributeName 
                                                    value: [UIColor yellowColor] 
                                                    range: range_textWithYellowHighlight ];          // offset, length

            [myAttributedTextBirthCityOrTown addAttribute: NSFontAttributeName
                                                    value: myFontForText 
                                                    range: NSMakeRange(0, myAttributedTextBirthCityOrTown.length)  ];  // offset, length



  NSLog(@"myAttributedTextBirthCityOrTown #2 =%@",myAttributedTextBirthCityOrTown);


//<.>
//            // BEWARE: the order and what is here is a fragile house of cards    DO NOT CHANGE ANYTHING
//            //
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for label explain
//                cell.textLabel.textColor      = [UIColor blackColor];
//                cell.userInteractionEnabled   = NO;
//                cell.textLabel.font           = myFontForText;
//                cell.backgroundColor          = gbl_color_cBgr;
//                cell.textLabel.numberOfLines  = 0;
////                cell.textLabel.numberOfLines  = 25;
////                cell.textLabel.text           = allLabelExplaintext; // for test
//                cell.textLabel.text           = @" "; // for test
//                cell.textLabel.attributedText = myAttributedTextLabelExplain;
//                cell.imageView.image          = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView           = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//<.>
//





            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for place of birth
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Characters you can use in the place name:\n\n   abc defghijklmnopqrstuvwxyz-\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nType letters in the city name until the city you want appears in the city field.\n\nAs you type each letter, the first city that starts with what you have typed so far appears in the city field.\n\nAs a SHORTCUT, when there are fewer than 25 cities starting with the letters you have typed so far, a yellow button appears - \"Wheel\".  Tap that button to get a wheel you can spin to the city you want.\n\nIt's possible the city or town cannot be found.  In that case, type in a city nearby- especially a bigger city.";
//                cell.textLabel.text          = @"Characters you can use in the place name:\n\n   abc defghijklmnopqrstuvwxyz-\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nType letters in the city name until the city you want appears in the city field.\n\nAs you type each letter, what you have typed so far appears in the title bar of the keyboard.\n\nAlso, the first city that starts with what you have typed so far appears in the city field.\n\nAs a SHORTCUT, when there are fewer than 25 cities starting with the letters you have typed so far, a yellow button appears - \"Wheel\".  Tap that button to get a wheel you can spin to the city you want.\n\nIt's possible the city or town cannot be found.  In that case, type in a city nearby- especially a bigger city.";



//                cell.textLabel.text          = @"Characters you can use in the place name:\n\n   abc defghijklmnopqrstuvwxyz-\n   ABC DEFGHIJKLMNOPQRSTUVWXYZ1234567890\n\nType letters in the city name until the city you want appears in the city field.\n\nAs you type each letter, what you have typed so far appears in the title bar of the keyboard.\n\nAs a SHORTCUT, when there are fewer than 25 cities starting with the letters you have typed so far, a yellow button appears - \"Wheel\".  Tap that button to get a wheel you can spin to the city you want.\n\nIt's possible the city or town cannot be found.  In that case, type in a city nearby- especially a bigger city.";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedTextBirthCityOrTown;


                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 12) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 13) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for  birth date and time
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Birth Date and Time";
                cell.textLabel.text          = @"Time of Day of Birth";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 14) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
//@"\u2022 You may not know the time of birth.  Don't worry about it.\n\u2022 If you have no idea of what the time was, just accept the default time of one minute past noon.\n\u2022 If you know the approximate time, enter your best guess.\n\u2022 If you know there was Daylight Saving Time in effect, then subtract an hour from the time."
//@"\u2022 You may not know the exact time of birth.  Don't worry about it.\n\u2022 If you have no idea of what the time was, just accept the default time of one minute past noon.\n\u2022 If you know the approximate time, enter your best guess.\n\u2022 If you know Daylight Saving Time was in effect, then subtract an hour from the time."
// do not use word "exact"  for time of birth
@"\u2022 You may not know the time of birth.  Don't worry about it.\n\u2022 If you have no idea of what the time was, just accept the default time of one minute past noon.\n\u2022 If you know the approximate time, enter your best guess.\n\u2022 If you know Daylight Saving Time was in effect, then subtract an hour from the time."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for birth date and time
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"You may not know the time of birth.  Don't worry about it.\n\nIf you have no idea of what the time was, just accept the default time of one minute past noon.\n\nIf you know the approximate time, enter your best guess.\n\nIf you know there was Daylight Saving Time in effect, then subtract an hour from the time.";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 15) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 16) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Delete Person
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Deleting a Person";
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 17) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
@"\u2022 Tap the round red \"-\" button on the left.\n\u2022 A red \"Delete\" button slides over from the right edge of the screen.\n\u2022 You can Cancel out here if you want.\n\u2022 Tap the red \"Delete\" button to CONFIRM you want to delete this person.\n\u2022 You can see the person disappearing from the people list.\n\u2022 There is no undelete."
// There is no undo."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for Delete group
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Tap red \"-\" button.\nA red \"Delete\" button slides over from the right edge of the screen.\nYou can Cancel out here if you want.\nTap the red \"Delete\" button to confirm you want to delete this group.\nYou can see the group disappearing from the group list.";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 18) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }



        if (indexPath.row ==  19) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"All reports are for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.accessoryView = nil;

            });
            return cell;
        }

    } // end of gbl_helpScreenDescription   @"HOMEaddchangePERSON";


    if ([gbl_helpScreenDescription isEqualToString: @"HOMEaddchangeGROUP"] )
    { 
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                  // <=== title for adding a group
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Adding a Group";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 2) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;
  NSLog(@"mySizeTwoCharsIndent =[%f]",mySizeTwoCharsIndent );

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
@"\u2022 Tap \"+\".\n\u2022 Tap the name field.\n\u2022 Type the name of the new group.\n\u2022 When you are done typing, tap \"Done\".\n\u2022 You can see the new group showing up in the group list."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text  Add Group
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Tap \"+\".\nTap the name field.\nType the name of the new group.\nYou can Cancel out here if you  want.\nWhen you are done typing, tap \"Done\".\nYou can see the new group showing up in the group list.";
//                cell.textLabel.text          = @"Tap \"+\".\nTap the name field.\nType the name of the new group.\nWhen you are done typing, tap \"Done\".\nYou can see the new group showing up in the group list.\n\nIf you want to add members,\nTap the new group name.\nTap the green \"+\".\nTap all the people you want to add.\nTap \"Done\".\nYou can see the new people appearing in the group.";
//                cell.textLabel.text          = @"Tap \"+\".\nTap the name field.\nType the name of the new group.\nWhen you are done typing, tap \"Done\".\nYou can see the new group showing up in the group list.";


                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;


                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 4) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Add Group Members
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Add New People to a Group";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 5) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
@"\u2022 Tap the group you want to add members to.\n\u2022 Tap the green \"+\".\n\u2022 Tap all the people you want to add.\n\u2022 You can Cancel out here if you want.\n\u2022 Tap \"Done\".\n\u2022 You can see the new people appearing in the group."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for Add group members
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"You have to be in home screen edit mode (yellow background) to add members to a group.  So if you are in report mode (brown background), tap the yellow Edit button.  The home screen turns into yellow edit mode.\n\nTap Groups.\nTap the group you want to add members to.\nTap the green \"+\".\nTap all the people you want to add.\nYou can Cancel out here if you want.\nTap \"Done\".\nYou can see the new people appearing in the group.";
//                cell.textLabel.text          = @"Tap the group you want to add members to.\nTap the green \"+\".\nTap all the people you want to add.\nYou can Cancel out here if you want.\nTap \"Done\".\nYou can see the new people appearing in the group.";


                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 7) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Delete Group Members
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Delete People from a Group";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 8) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
@"\u2022 Tap the group you want to delete members from.\n\u2022 Tap the red \"-\".\n\u2022 Tap all the people you want to delete.\n\u2022 Tap \"Done\".\n\u2022 You can see the selected people disappearing from the group.\n\u2022 There is no undelete."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for Delete group members
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"You have to be in home screen edit mode (yellow background) to delete members from a group.  So if you are in report mode (brown background), tap the yellow Edit button.  The screen turns into yellow edit mode.\n\nTap Groups.\nTap the group you want to delete members from.\nTap the red \"-\".\nTap all the people you want to delete.\nTap \"Done\".\nYou can see the selected people disappearing from the group.";
//                cell.textLabel.text          = @"Tap the group you want to delete members from.\nTap the red \"-\".\nTap all the people you want to delete.\nTap \"Done\".\nYou can see the selected people disappearing from the group.";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

// sharing groups  share groups is commented out
//        if (indexPath.row == 10) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Share Groups
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
//                cell.textLabel.font          = myTitleFont;
//                cell.backgroundColor         = gbl_color_cHed;
//                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Share groups by email";
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//                cell.accessoryView = nil;
//            });
//            return cell;
//        }
//
//        if (indexPath.row == 11) {
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for Share groups
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
//                cell.textLabel.font          = myFontForText;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Tap on \"Share_groups_by_email\".\nDo this.\nDo this.\nDo this.\nDo this.\nDo this.\n ";
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//                cell.accessoryView = nil;
//            });
//            return cell;
//        }

        if (indexPath.row ==  9) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 10) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Delete Group
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Deleting a Group";
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 11) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
@"\u2022 Tap red \"-\" button on the left.\n\u2022 A red \"Delete\" button slides over from the right edge of the screen.\n\u2022 You can Cancel out here if you want.\n\u2022 Tap the red \"Delete\" button to CONFIRM you want to delete this group.\n\u2022 You can see the group disappearing from the group list.\n\u2022 There is no undelete."
// There is no undo."
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for Delete group
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Tap red \"-\" button.\nA red \"Delete\" button slides over from the right edge of the screen.\nYou can Cancel out here if you want.\nTap the red \"Delete\" button to confirm you want to delete this group.\nYou can see the group disappearing from the group list.";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 12 ) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }



        if (indexPath.row ==  13) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"All reports are for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.accessoryView = nil;

            });
            return cell;
        }

    } // end of gbl_helpScreenDescription   @"HOMEaddchangeGROUP";


    if (  [gbl_helpScreenDescription isEqualToString: @"HOME"] )
    { 

        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

//        if (indexPath.row == 1) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== home preamble
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
//                cell.textLabel.font          = myFont;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.textLabel.numberOfLines = 0;
//
////                cell.textLabel.text          = @" Gather \"Me and my BFFs\" together and have fun using this app.";
////                cell.textLabel.text          = @" \"Me and my BFFs\" get together and have fun using this app.";
//                cell.textLabel.text          = @" To have fun, get \"Me and my BFFs\" together and use this app.";
//                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//                cell.backgroundView          = nil ;
//                cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            });
//            return cell;
//        }
//

        if (indexPath.row == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{                                  // <=== title for brown home
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
//                cell.backgroundColor         = gbl_color_cHed;
//                cell.backgroundColor         = gbl_bgColor_blueDoneH;
//                cell.backgroundColor         = gbl_bgColor_brownDone;
                cell.backgroundColor         = gbl_colorHomeBG_per;
                cell.textLabel.numberOfLines = 0;
                //                cell.textLabel.text          = @"Blue Home is for Reports";
//                cell.textLabel.text          = @"Brown is for Reports";
//                cell.textLabel.text          = @"Brown Home is for Reports";
//                cell.textLabel.text          = @"Brown Home is for Astrology Reports";
//                cell.textLabel.text          = @"Brown Screen is for Reports";
                cell.textLabel.text          = @"Brown Home Screen is for Reports";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 2) {

            // CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
            // NSLog(@"currentScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
            // NSLog(@"currentScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
            //
            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;
  NSLog(@"mySizeTwoCharsIndent =[%f]",mySizeTwoCharsIndent );

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc] initWithString:
//@"\u2022 View reports for people and groups you have added.\n\u2022 Share reports by email."
@"\u2022 View astrology reports for people and groups you have added.\n\u2022 Share reports by email."
    attributes: @{NSParagraphStyleAttributeName: paragraphStyle}];


            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== brown text
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.backgroundColor         = gbl_bgColor_blueDone;
//                cell.backgroundColor         = gbl_bgColor_brownDone;
                cell.backgroundColor         = gbl_colorHomeBG_per;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Look at reports for all the people and groups you have entered.";
//                cell.textLabel.text          = @"Look at reports for all of your people and groups.";
//                cell.textLabel.text          = @"Look at reports for the people and groups you have added.";
//                cell.textLabel.text          = @"Look at reports for people and groups you have added.";
//                cell.textLabel.text          = @"View reports for people and groups you have added.";
//                cell.textLabel.text          = @"View reports for people and groups you have added.\nShare reports by email.";
//                cell.textLabel.text          = @"\u2022 View reports for people and groups you have added.\n\u2022 Share reports by email.";


                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;


                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 4) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for yellow home
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
//                cell.backgroundColor         = gbl_color_cHed;
//                cell.backgroundColor         = gbl_colorEditingBG;
                cell.backgroundColor         = gbl_bgColor_yellowEdit;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Yellow Home is for Editing";
//                cell.textLabel.text          = @"Yellow is for Maintenance";
//                cell.textLabel.text          = @"Yellow is for Editing";
//                cell.textLabel.text          = @"Yellow Home is for Editing";
                cell.textLabel.text          = @"Yellow Screen is for Editing";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 5) {

            // CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
            // NSLog(@"currentScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
            // NSLog(@"currentScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
            //
            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];
            float  mySizeTwoCharsIndent =  myTextSize.width;
  NSLog(@"mySizeTwoCharsIndent =[%f]",mySizeTwoCharsIndent );

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [ [NSAttributedString alloc] initWithString:
//            @"\u2022 Add people and groups and make changes to them.\n\u2022 Share people or groups by email.\n\u2022 Backup all your data to an email attachment."
//            @"\u2022 Add people and groups and make changes to them.\n\u2022 Share people or groups by email."
//            @"\u2022 Add new people and groups and make changes to them.\n\u2022 Share people or groups by email."
//            @"\u2022 Add new people and new groups and make changes to them.\n\u2022 Share people or groups by email."


// commented out the sharing of groups 
            @"\u2022 Add new people and new groups and make changes to them."



    attributes: @{NSParagraphStyleAttributeName: paragraphStyle}
            ];


            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== yellow text
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;



//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.backgroundColor         = gbl_colorEditingBG;
                cell.backgroundColor         = gbl_bgColor_yellowEdit;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Entering people and group information and changing stuff is done from the YELLOW home";
//                cell.textLabel.text          = @"Enter people and groups and make changes to them.\nShare people or groups by email.\nBackup all your data to an email attachment.";
//                cell.textLabel.text          = @"Enter people and groups and make changes to them.\nShare people or groups by email.\nBackup your people and groups to an email attachment.";
//                cell.textLabel.text          = @"\u2022 Enter people and groups and make changes to them.\n\u2022 Share people or groups by email.\n\u2022 Backup all your data to an email attachment.";


                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 6) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row ==  7) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for example data
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Example Data";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row ==  8) {
            dispatch_async(dispatch_get_main_queue(), ^{                                 // <=== text for example data 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Example people and groups have names starting with \"~\".\n\nThe example data lets you explore all the different reports and how the app works before you enter any new people or groups yourself.\n\nWhen you want to enter a new person go to the home screen.  You can tell the home screen because it has the black, red and yellow app icon on the top left.  Tap \"+\" beside it to add a new person.\n\nAfter a while, you might want to not see the example data.  Check the \"hide example data\" checkbox below.";
//                cell.textLabel.text          = @"Example people and groups have names starting with \"~\".\n\nThe example data lets you explore all the different reports and how the app works before you enter any new people or groups yourself.\n\nWhen you want to enter a new person go to the home screen.  You can tell the home screen because it has the app icon on the top left.  Tap \"+\" beside it to add a new person.\n\nAfter a while, you might want to not see the example data.  If so, tap the switch below to off.";
//                cell.textLabel.text          = @"Example people and groups have names starting with \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nWhen you want to add a new person or group, go back to the home screen.  You can tell the home screen because it has the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"Example people and groups have names starting with \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nWhen you want to add a new person or group, go back to the home screen.  You can tell the home screen by the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"Example people and groups have names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nWhen you want to add a new person or group, go back to the home screen.  You can tell the home screen by the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"Example people and groups have names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nWhen you want to add a new person or group, go back to the brown home screen.  You can tell the home screen by the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"You can tell example people and groups by a squiggle, \"~\" on their names.\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nWhen you want to add a new person or group, go back to the brown home screen.  You can tell the home screen by the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"You can tell example people and example groups by their names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nWhen you want to add a new person or group, go back to the brown home screen.  You can tell the home screen by the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"You can tell example people and example groups by their names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nTo add a new person or group, go back to the brown home screen.  You can tell the home screen by the app icon on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"You can tell example people and example groups by their names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nTo add a new person or group, go back to the brown home screen. The app icon is on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"Example people and example groups have names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nTo add a new person or group, go back to the brown home screen. The app icon is on the top left.  Tap \"+\" to add a new person or group.";
//                cell.textLabel.text          = @"Example people and example groups have names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or groups yourself.\n\nExample people and groups cannot be changed.\n\nTo add a new person or group, tap yellow \"Edit\" button  >  tap \"+\".";
                cell.textLabel.text          = @"Example people and example groups have names starting with a squiggle, \"~\".\n\nThe example data lets you explore all the different reports and see how the app works before you add any new people or new groups yourself.\n\nExample people and groups cannot be changed.\n\nTo add a new person, tap \"People\" > tap \"+\".\nTo add a new group , tap \"Groups\" > tap \"+\".";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        UISwitch *mySwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
//        [mySwitchView setOn: YES animated: NO];
        if ([gbl_ExampleData_show isEqualToString: @"yes" ]) [mySwitchView setOn: YES animated: YES];
        if ([gbl_ExampleData_show isEqualToString: @"no"  ]) [mySwitchView setOn: NO  animated: YES];
        mySwitchView.layer.borderWidth  = 2;
//        mySwitchView.layer.borderColor  = [UIColor whiteColor].CGColor;
//        mySwitchView.layer.borderColor  = [UIColor lightGrayColor].CGColor;
//        mySwitchView.layer.borderColor  = gbl_reallyLightGray.CGColor;
//        mySwitchView.layer.borderColor  = [UIColor brownColor].CGColor;
//        mySwitchView.layer.borderColor  = gbl_colorVlightBurly.CGColor;
//        mySwitchView.layer.borderColor  = [UIColor yellowColor].CGColor;
//        mySwitchView.layer.borderColor  = [UIColor blackColor].CGColor;
        mySwitchView.layer.borderColor  = [UIColor whiteColor].CGColor;


        mySwitchView.layer.cornerRadius = 16;

        [mySwitchView           addTarget: self
                                   action: @selector(showExampleDataSwitchChanged: )
                         forControlEvents: UIControlEventValueChanged
        ];
         
//        mySwitchView.enabled = YES;
//        [self showExampleDataSwitchChanged ];

//        myViewController.view.frame = CGRectMake(0, 100, myViewController.view.frame.size.width, myViewController.view.frame.size.height);  
//        mySwitchView.frame = CGRectMake(180, 10, cell.frame.size.width, cell.frame.size.height);  

        if (indexPath.row ==  9) {
            // go with defaults
//            if (mySwitchView.on == YES) {
//                [mySwitchView setThumbTintColor:[UIColor whiteColor]];     // circle in switch
//                [mySwitchView setOnTintColor:     [UIColor greenColor]]; // outline edges of sw
//            }
//            if (mySwitchView.on ==  NO) {
//                [mySwitchView setTintColor:     [UIColor lightGrayColor]]; // outline edges of sw
//                [mySwitchView setThumbTintColor:[UIColor lightGrayColor]]; // circle in switch
//
//                [mySwitchView setThumbTintColor:[UIColor whiteColor]];     // circle in switch
//                [mySwitchView setTintColor:     [UIColor darkGrayColor]]; // outline edges of sw
//                [mySwitchView setTintColor:     [UIColor redColor]]; // outline edges of sw
//            }

            NSString *switchPrompt;

                //    gbl_numRowsToTriggerIndexBar    = 90;
                //
                // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
                //                                 // 6s  = 667.0 x 375  and 6
                //                                 // 5s  = 568.0 x 320  and 5 
                //                                 // 4s  = 480.0 x 320  and 5 
                //
                //  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );


//                if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
//                ) {
////                    switchPrompt  = @"            Show Example Data";
//                    switchPrompt  = @"            Show Example Data\n           on the Home Screen";
//                }
//                else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
//                         && self.view.bounds.size.width  > 320.0
//                ) {
////                    switchPrompt  = @"           Show Example Data";
//                    switchPrompt  = @"           Show Example Data\n          on the Home Screen";
//                }
//                else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
//                ) {
////                    switchPrompt  = @"        Show Example Data";
//                    switchPrompt  = @"        Show Example Data\n       on the Home Screen";
//                }
//                else if (   self.view.bounds.size.width <= 320.0   // ??
//                ) {
//                    ;  // gbl_numRowsToTriggerIndexBar    = 33;
//                }
//
                if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
                ) {
                    switchPrompt  = @"            Show Example Data";
//                    switchPrompt  = @"            Show Example Data\n           on the Home Screen";
                }
                else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                         && self.view.bounds.size.width  > 320.0
                ) {
                    switchPrompt  = @"           Show Example Data";
//                    switchPrompt  = @"           Show Example Data\n          on the Home Screen";
                }
                else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
                ) {
                    switchPrompt  = @"        Show Example Data";
//                    switchPrompt  = @"        Show Example Data\n       on the Home Screen";
                }
                else if (   self.view.bounds.size.width <= 320.0   // ??
                ) {
                    ;  // gbl_numRowsToTriggerIndexBar    = 33;
                }


            dispatch_async(dispatch_get_main_queue(), ^{                           
                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.userInteractionEnabled  = NO;
                cell.userInteractionEnabled  = YES;
                cell.textLabel.font          = myTitleFont;

//                cell.backgroundColor         = gbl_color_cBgr;
//                cell.backgroundColor         = gbl_color_cHed;
//                cell.backgroundColor         = [UIColor lightGrayColor];

//                cell.backgroundColor         = gbl_bgColor_brownDone;
//                cell.backgroundColor         = gbl_color_cHed;
//                cell.backgroundColor         = gbl_color_cBgr;
                cell.backgroundColor         = gbl_bgColor_brownSwitch;

                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"      Show Example Data";
                cell.textLabel.text          = switchPrompt;
//                cell.textLabel.attributedText = nil;
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;

//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                cell.accessoryType = UITableViewCellAccessoryNone;

                cell.accessoryView = mySwitchView;
//                [cell addSubview: mySwitchView];


            });
            return cell;
        }
//<.>
//        if (indexPath.row ==   15) return    50.0;  // check box for "Show Example Data"
//
//        if (indexPath.row ==   16) return    32.0;  // spacer
//        if (indexPath.row ==   17) return    30.0;  // title for #allpeople
//        if (indexPath.row ==   18) return   200.0;  // text  for #allpeople
//        if (indexPath.row ==   19) return    30.0;  // text for disclaimer
//<.>

        if (indexPath.row == 10) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== space 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 11) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for #allpeople
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"#allpeople Special Group";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 12) {


            CGSize myTextSize = [@""  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];
            float  mySizeTwoCharsIndent =  myTextSize.width;
  NSLog(@"mySizeTwoCharsIndent =[%f]",mySizeTwoCharsIndent );

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [ [NSAttributedString alloc] initWithString:
@"The special group #allpeople is a group that holds all the people you have added to Me and My BFFs.\n\nGroup #allpeople lets you quickly get a Best Match or other group report for every person you have added.\n\nPeople that you add or delete in the app are automatically added to or deleted from the group #allpeople."
                attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];



            dispatch_async(dispatch_get_main_queue(), ^{                                 // <=== text for #allpeople
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;

//
////                cell.textLabel.text          = @"The special group #allpeople is a group that holds all the people you have added to Me and My BFFs.\n\nA person that you add is automatically added to group #allpeople.\nA person that you delete is automatically removed from group #allpeople.\n\n Group #allpeople lets you quickly get a Best Match or other group report for everyone.";
////                cell.textLabel.text          = @"The special group #allpeople is a group that holds all the people you have added to Me and My BFFs.\n\nPeople that you add or delete from the app are automatically added or deleted from group #allpeople.\n\nGroup #allpeople lets you quickly get a Best Match or other group report for everyone.";
////                cell.textLabel.text          = @"The special group #allpeople is a group that holds all the people you have added to Me and My BFFs.\n\nPeople that you add or delete are automatically added to or deleted from group #allpeople.\n\nGroup #allpeople lets you quickly get a Best Match or other group report for every person you have added.";
////@"The special group #allpeople is a group that holds all the people you have added to Me and My BFFs.\n\nGroup #allpeople lets you quickly get a Best Match or other group report for every person you have added.\n\nPeople that you add or delete are automatically added to or deleted from group #allpeople.";
//                cell.textLabel.text          =
//@"The special group #allpeople is a group that holds all the people you have added to Me and My BFFs.\n\nGroup #allpeople lets you quickly get a Best Match or other group report for every person you have added.\n\nPeople that you add or delete in the app are automatically added to or deleted from group #allpeople.";
//
//



// when scrolled off screen  , text has indent 2 spaces
//                cell.textLabel.attributedText = @" ";
//                cell.textLabel.attributedText = nil;   



                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;




                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 13) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for report list
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Reports";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }



        if (indexPath.row == 14) {

            // CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
            // NSLog(@"currentScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
            // NSLog(@"currentScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
            //
            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
@"\u2022 Calendar Year stress levels\n\u2022 What Color is Today for Me?\n\u2022 Personality\n\u2022 Compatibility Potential of two people\n\u2022 Best Match for a Person in a Group\n\n\u2022 in a Group, Best Matched Pair\n\u2022 in a Group, Most Emotional Person\n\u2022 in a Group, Most Down-to-earth Person\n\u2022 in a Group, Most Passionate Person\n\u2022 in a Group, Most Assertive Person\n\u2022 in a Group, Most Restless Person"
                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];



            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== report list 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @" - Calendar Year stress levels\n - Personality\n - Compatibility Potential of two people\n - What Color is Today for Me?\n - Best Match for a Person in a Group\n\n - in a Group, Best Matched Pair\n - in a Group, Most Emotional Person\n - in a Group, Most Down-to-earth Person\n - in a Group, Most Passionate Person\n - in a Group, Most Assertive Person\n - in a Group, Most Restless Person";
//                cell.textLabel.text          = @" - Calendar Year stress levels\n - What Color is Today for Me?\n - Personality\n - Compatibility Potential of two people\n - Best Match for a Person in a Group\n\n - in a Group, Best Matched Pair\n - in a Group, Most Emotional Person\n - in a Group, Most Down-to-earth Person\n - in a Group, Most Passionate Person\n - in a Group, Most Assertive Person\n - in a Group, Most Restless Person";


                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;


                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


//<.>
//        if (indexPath.row ==   6) return    32.0;  // spacer
//
// 7       if (indexPath.row ==   13) return    30.0;  // title for Example Data
// 8       if (indexPath.row ==   14) return   200.0;  // text  for Example Data
// 9       if (indexPath.row ==   15) return    50.0;  // check box for "Show Example Data"
//
//10       if (indexPath.row ==   16) return    32.0;  // spacer
//11       if (indexPath.row ==   17) return    30.0;  // title for #allpeople
//12       if (indexPath.row ==   18) return   160.0;  // text  for #allpeople
//
//13       if (indexPath.row ==   9) return    30.0;  // title for report list
//14       if (indexPath.row ==   10) return   200.0;  // report  list
//
//15       if (indexPath.row ==   11) return    30.0;  // title for why not ?
//16       if (indexPath.row ==   12) return   120.0;  // text  for why not ?
//
//17      if (indexPath.row ==   7) return    30.0;  // title for do stuff
//18       if (indexPath.row ==   8) return   200.0;  // text  for do stuff
//
//        if (indexPath.row ==   19) return    30.0;  // text for disclaimer
//<.>
//
        if (indexPath.row == 15) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for do stuff
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"How to Do Stuff";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row == 16) {
            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:
//@"\u2022 To have fun, get \"Me and my BFFs\" together and use this app.\n\u2022 To send ANY REPORT as an email attachment, tap the Share icon (box with arrow coming out) when viewing the report\n\u2022 To email a Group to a BFF who has this app:  Home > Edit > Groups > tap the Share icon > tap on the groups you want to share\n\u2022 To import a Group someone has emailed you, open the email on the device where you have this app and tap and hold (long tap) on the email attachment.  A bunch of app icons come up.  Tap on the Me and my BFFs icon and the import begins."
//@"\u2022 To have fun, get \"Me and my BFFs\" together and use this app.\n\u2022 To send ANY REPORT as an email attachment, tap the Share icon (box with arrow coming out) when viewing the report\n\u2022 To email a Group to a BFF who has this app:  Home > Edit > Groups > tap the Share icon > tap on the groups you want to share\n\u2022 To import a Group someone has emailed you, open the email on the device where you have this app and tap and hold (long tap) on the email attachment."


// 20170514  remove mention of sharing groups  import ing groups exportin groups
@"\u2022 To have fun, get \"Me and my BFFs\" together and use this app.\n\u2022 To send ANY REPORT as an email attachment, tap the Share icon (box with arrow coming out) when viewing the report."



                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== do stuff text
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"To send ANY REPORT as an email attachment, tap \"Share\"\n\nTo email a Group to a BFF who has this app, go to the Group, then tap \"Share\"\n\nTo import a Group someone has emailed you, open the email on the device where you have this app, and tap and hold on the email attachment";
//                cell.textLabel.text          = @"To send ANY REPORT as an email attachment, tap \"Share\"\n\nTo email a Group to a BFF who has this app, go to the Group, then tap \"Share\"\n\nTo import a Group someone has emailed you, open the email on the device where you have this app.  Then tap and hold on the email attachment\n\nTo have fun, get \"Me and my BFFs\" together and use this app.";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }



        if (indexPath.row == 17) {
            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== title for Why Not ?
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myTitleFont;
                cell.backgroundColor         = gbl_color_cHed;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"Why Not ?";
                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }

        if (indexPath.row == 18) {

            CGSize myTextSize = [@"WW"  sizeWithAttributes: @{ NSFontAttributeName: myFontForText } ];  // menlo
            float  mySizeTwoCharsIndent =  myTextSize.width;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent               = mySizeTwoCharsIndent;

            NSAttributedString *myAttributedStr = [[NSAttributedString alloc]
                initWithString:

//@"\u2022 Study human factors on sports teams\n\u2022 Be a matchmaker by using the reports \"Best Match\" and \"Personality\"\n\u2022 Send questions and comments to QQQQQ@QQQQQ.com"
@"\u2022 Study human factors on sports teams\n\u2022 Be a matchmaker by using the reports \"Best Match\" and \"Personality\"\n\u2022 Send questions and comments to meandmybffs@funnestastrology.com"

                    attributes: @{ NSParagraphStyleAttributeName: paragraphStyle }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== text for why not
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myFontForText;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
//                cell.textLabel.text          = @"Study human factors on sports teams\n\nBe a matchmaker by using the reports \"Best Match\" and \"Personality\"\n\nSend questions and comments to QQQQQ@QQQQQ.com";

                cell.textLabel.text           = @" "; // for test
                cell.textLabel.attributedText = myAttributedStr;

                cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.accessoryView = nil;
            });
            return cell;
        }


        if (indexPath.row ==  19) {                           // <=== disclaimer 
            dispatch_async(dispatch_get_main_queue(), ^{  
//                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.textColor     = [UIColor redColor]; 
                cell.userInteractionEnabled  = NO;
                cell.textLabel.font          = myDisclaimerFont;
                cell.backgroundColor         = gbl_color_cBgr;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text          = @"All reports are for entertainment purposes only.";
                cell.imageView.image         = nil;
                cell.backgroundView          = nil ;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.accessoryView = nil;

            });
            return cell;
        }
    } // end of gbl_helpScreenDescription   "HOME"



    return cell;

} // end of  cellForRowAtIndexPath:(NSIndexPath *)indexPath


- (void) showExampleDataSwitchChanged: (id)sender {


    UISwitch* mySwitchControl = sender;
    NSLog( @"The switch is %@", mySwitchControl.on ? @"ON" : @"OFF" );

    if (mySwitchControl.on == YES) {

        gbl_ExampleData_show = @"yes";

//        [sender setThumbTintColor:[UIColor redColor]];
//        [sender setBackgroundColor:[UIColor cyanColor] ];
//        [sender setOnTintColor:[UIColor blackColor]];

//        [sender setThumbTintColor:[UIColor whiteColor]];
//        [sender setOnTintColor:     [UIColor greenColor]];   // outline of sw=0

//        [sender setBackgroundColor:[UIColor clearColor] ];
//        [sender setOnTintColor:[UIColor greenColor]];
    }
    if (mySwitchControl.on ==  NO) {

        gbl_ExampleData_show = @"no";

//        [sender setTintColor:[UIColor   cyanColor]];
//        [sender setThumbTintColor:[UIColor blueColor]];
//        [sender setBackgroundColor:[UIColor blackColor] ];

//        [sender setTintColor:[UIColor   lightGrayColor]];   // outline of sw=0
//        [sender setTintColor:[UIColor   blackColor]];   // outline of sw=0
//        [sender setThumbTintColor:[UIColor lightGrayColor]];

//        [sender setThumbTintColor:[UIColor whiteColor]];
//        [sender setTintColor:     [UIColor darkGrayColor]];   // outline of sw=0
//        [sender setTintColor:     [UIColor redColor]];   // outline of sw=0


//        [sender setThumbTintColor:[UIColor clearColor]];
//        [sender setBackgroundColor:[UIColor clearColor] ];

//        [sender setBackgroundColor:[UIColor redColor] ];
    }

} // showExampleDataSwitchChanged


// ---------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  // Return the number of rows in the section.
    //    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) {   return 3; } // my best match (grpone)

    if ([gbl_helpScreenDescription isEqualToString: @"most reports" ] ) { return 11; } 
    if ([gbl_helpScreenDescription isEqualToString: @"personality"  ] ) { return 11; } 
    if ([gbl_helpScreenDescription isEqualToString: @"best match"   ] ) { return 15; }  
    if ([gbl_helpScreenDescription isEqualToString: @"what color"   ] ) { return  7; }
    if ([gbl_helpScreenDescription isEqualToString: @"just 2"       ] ) { return 23; }  // compatibility just 2 people
    if ([gbl_helpScreenDescription isEqualToString: @"calendar year"] ) { return 17; } 
    if ([gbl_helpScreenDescription isEqualToString: @"best year"    ] ) { return  7; } 
    if ([gbl_helpScreenDescription isEqualToString: @"best day"     ] ) { return  7; } 
    if ([gbl_helpScreenDescription isEqualToString: @"HOME"         ] ) { return 20; } 

    if ([gbl_helpScreenDescription isEqualToString: @"HOMEaddchangeGROUP" ] ) { return  17; } 
    if ([gbl_helpScreenDescription isEqualToString: @"HOMEaddchangePERSON"] ) { return  20; } 
    return 1;
}

// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
//  NSLog(@"in heightForRowAtIndexPath  INFO ");

    if (   [gbl_helpScreenDescription isEqualToString: @"HOMEaddchangePERSON"] ) {

        if (indexPath.row ==   0) return    16.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for  add person
        if (indexPath.row ==   2) return    70.0;  // text  for add person

        if (indexPath.row ==   3) return    16.0;  // spacer
        if (indexPath.row ==   4) return    36.0;  // title for personal privacy
//        if (indexPath.row ==   5) return   400.0;  // text  for personal privacy
//        if (indexPath.row ==   5) return   180.0;  // text  for personal privacy
//        if (indexPath.row ==   5) return   200.0;  // text  for personal privacy
//        if (indexPath.row ==   5) return   215.0;  // text  for personal privacy
        if (indexPath.row ==   5) return   205.0;  // text  for personal privacy

        if (indexPath.row ==   6) return    16.0;  // spacer
        if (indexPath.row ==   7) return    30.0;  // title for person name
        if (indexPath.row ==   8) return   110.0;  // text  for person name

        if (indexPath.row ==   9) return    16.0;  // spacer
        if (indexPath.row ==  10) return    30.0;  // title for birth city
//        if (indexPath.row ==  11) return   310.0;  // text  for birth city
//        if (indexPath.row ==  11) return   325.0;  // text  for birth city
//        if (indexPath.row ==  11) return   290.0;  // text  for birth city
        if (indexPath.row ==  11) return   315.0;  // text  for birth city

        if (indexPath.row ==  12) return    16.0;  // spacer
        if (indexPath.row ==  13) return    30.0;  // title for birth date and time
        if (indexPath.row ==  14) return   135.0;  // text  for birth date and time

        if (indexPath.row ==  15) return    16.0;  // spacer
        if (indexPath.row ==  16) return    30.0;  // title for delete person
        if (indexPath.row ==  17) return   135.0;  // text  for delete person

        if (indexPath.row ==  18) return    12.0;  // spacer
        if (indexPath.row ==  19) return    30.0;  // text for disclaimer
    }


    if (   [gbl_helpScreenDescription isEqualToString: @"HOMEaddchangeGROUP"] ) {

        if (indexPath.row ==   0) return    16.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for  adding a group
        if (indexPath.row ==   2) return   105.0;  // text  for adding a group

//        if (indexPath.row ==   3) return    16.0;  // spacer
//        if (indexPath.row ==   3) return    12.0;  // spacer
        if (indexPath.row ==   3) return     8.0;  // spacer
        if (indexPath.row ==   4) return    30.0;  // title for add members
        if (indexPath.row ==   5) return   120.0;  // text  for add members

        if (indexPath.row ==   6) return    16.0;  // spacer
        if (indexPath.row ==   7) return    30.0;  // title for del members
        if (indexPath.row ==   8) return   110.0;  // text  for del members

//  sharing groups is commented out
//        if (indexPath.row ==   9) return    16.0;  // spacer
//        if (indexPath.row ==  10) return    30.0;  // title for share groups
//        if (indexPath.row ==  11) return   120.0;  // text  for share groups

        if (indexPath.row ==  9) return    16.0;  // spacer
        if (indexPath.row ==  10) return    30.0;  // title for delete group
        if (indexPath.row ==  11) return   135.0;  // text  for delete group

        if (indexPath.row ==  12) return    16.0;  // spacer
        if (indexPath.row ==  13) return    30.0;  // text for disclaimer
    }


    if (   [gbl_helpScreenDescription isEqualToString: @"HOME"] ) {

        if (indexPath.row ==   0) return    16.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for brown home
        if (indexPath.row ==   2) return    70.0;  // text  for brown
        if (indexPath.row ==   3) return    16.0;  // spacer
        if (indexPath.row ==   4) return    30.0;  // title for yellow home

// commenting out share groups
//        if (indexPath.row ==   5) return    72.0;  // text  for yellow
        if (indexPath.row ==   5) return    50.0;  // text  for yellow


        if (indexPath.row ==   6) return    32.0;  // spacer

        if (indexPath.row ==   7) return    30.0;  // title for Example Data
//        if (indexPath.row ==   8) return   225.0;  // text  for Example Data
//        if (indexPath.row ==   8) return   200;  // text  for Example Data
//        if (indexPath.row ==   8) return   180;  // text  for Example Data
//        if (indexPath.row ==   8) return   160;  // text  for Example Data
//        if (indexPath.row ==   8) return   170;  // text  for Example Data
        if (indexPath.row ==   8) return   180;  // text  for Example Data

//        if (indexPath.row ==   9) return    50.0;  // check box for "Show Example Data"
        if (indexPath.row ==   9) return    70.0;  // check box for "Show Example Data"

        if (indexPath.row ==   10) return    32.0;  // spacer
        if (indexPath.row ==   11) return    30.0;  // title for #allpeople
//        if (indexPath.row ==   12) return   160.0;  // text  for #allpeople
        if (indexPath.row ==   12) return   170.0;  // text  for #allpeople


        if (indexPath.row ==   13) return    30.0;  // title for report list
        if (indexPath.row ==   14) return   200.0;  // report  list

        if (indexPath.row ==   15) return    30.0;  // title for do stuff
//        if (indexPath.row ==   16) return   200.0;  // text  for do stuff
        if (indexPath.row ==   16) return   120.0;  // text  for do stuff

        if (indexPath.row ==   17) return    30.0;  // title for why not ?
        if (indexPath.row ==   18) return    90.0;  // text  for why not ?

        if (indexPath.row ==   19) return    30.0;  // text for disclaimer
    }
    if (   [gbl_helpScreenDescription isEqualToString: @"best day"] ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for Score for the Year
        if (indexPath.row ==   2) return   325.0;  // text  for Score for the Year
        if (indexPath.row ==   3) return     8.0;  // spacer
        if (indexPath.row ==   4) return    75.0;  // image for overcome destiny
        if (indexPath.row ==   5) return     8.0;  // spacer
        if (indexPath.row ==   6) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"best year"] ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
        if (indexPath.row ==   1) return    30.0;  // title for Score for the Year
        if (indexPath.row ==   2) return   290.0;  // text  for Score for the Year
        if (indexPath.row ==   3) return     8.0;  // spacer
        if (indexPath.row ==   4) return    75.0;  // image for overcome destiny
        if (indexPath.row ==   5) return     8.0;  // spacer
        if (indexPath.row ==   6) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"personality"] ) {

        if (indexPath.row ==  0) return     8.0;  // spacer
        if (indexPath.row ==  1) return    30.0;  // title for size of personality traits
//        if (indexPath.row ==  2) return   140.0;  // table preamble
        if (indexPath.row ==  2) return   250.0;  // table preamble
//        if (indexPath.row ==  3) return   175.0;  // table
        if (indexPath.row ==  3) return   210.0;  // table
        if (indexPath.row ==  4) return   165.0;  // 5 trait rundown
//        if (indexPath.row ==  5) return    75.0;  // check out Most ...  report
//        if (indexPath.row ==  6) return    80.0;  // 1 to 99 explain
        if (indexPath.row ==  5) return     8.0;  // spacer
        if (indexPath.row ==  6) return    30.0;  // title for quality of personality traits
        if (indexPath.row ==  7) return   100.0;  // text for quality
        if (indexPath.row ==  8) return     55.0;  // image willpower  for overcome traits
        if (indexPath.row ==  9) return     8.0;  // spacer
        if (indexPath.row == 10) return    20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"most reports"] ) {

        if (indexPath.row == 0) return     8.0;  // spacer
        if (indexPath.row == 1) return    30.0;  // title for size of traits
        if (indexPath.row == 2) return   265.0;  // score how much not good/bad
        if (indexPath.row == 3) return    30.0;  // title for quality of traits
        if (indexPath.row == 4) return   105.0;  // reference to Personality report
        if (indexPath.row == 5) return    20.0;  // spacer
        if (indexPath.row == 6) return    30.0;  // title for particular trait
        if (indexPath.row == 7) return   120.0;  // specific trait reference
        if (indexPath.row == 8) return    55.0;  // image willpower  for overcome traits
        if (indexPath.row == 9) return     8.0;  // spacer
        if (indexPath.row == 10) return   20.0;  // text for disclaimer
    }

    if (   [gbl_helpScreenDescription isEqualToString: @"calendar year"]  ) {
        if (indexPath.row ==   0) return     8.0;  // spacer
        if (indexPath.row ==   1) return    70.0;  // intro string
        if (indexPath.row ==   2) return     8.0;  // spacer

        if (indexPath.row ==   3) return    30.0;  // title for quick start guide
        if (indexPath.row ==   4) return   190.0;  // text  quick start guide

        if (indexPath.row ==   5) return    30.0;  // title for Labels inside the Graph
        if (indexPath.row ==   6) return   240.0;  // text  for Labels inside the Graph
        if (indexPath.row ==   7) return     8.0;  // spacer
        if (indexPath.row ==   8) return    30.0;  // title for Time Frame Influences
//        if (indexPath.row ==   7) return   250.0;  // text  for Time Frame Influences
        if (indexPath.row ==   9) return   150.0;  // text  for Time Frame Influences
        if (indexPath.row ==  10) return     8.0;  // spacer
        if (indexPath.row ==  11) return    30.0;  // title for Score for the Year
        if (indexPath.row ==  12) return   175.0;  // text  for Score for the Year
        if (indexPath.row ==  13) return     8.0;  // spacer

        if (indexPath.row ==  14) return    75.0;  // image for overcome destiny
//        if (indexPath.row ==  12) return    75.0;  // image for overcome destiny

        if (indexPath.row ==  15) return     8.0;  // spacer
        if (indexPath.row ==  16) return    20.0;  // text for disclaimer
        return 40;
    }
    if (   [gbl_helpScreenDescription isEqualToString: @"just 2"]  ) {

        if (indexPath.row ==  0) return     8.0;  // spacer
        if (indexPath.row ==  1) return    80.0;  // preamble
        if (indexPath.row ==  2) return    30.0;  // title for scores
        if (indexPath.row ==  3) return    16.0;  // spacer

        if (indexPath.row ==  4) return   225.0;  // space for label and score explain
//        if (indexPath.row ==  4) return   140.0;  //
//        if (indexPath.row ==  4) return   70.0;  // 

        if (indexPath.row ==  5) return    16.0;  // spacer
        if (indexPath.row ==  6) return   140.0;  // text for complexity #1
        if (indexPath.row ==  7) return    70.0;  // image two things
        if (indexPath.row ==  8) return     8.0;  // spacer

        if (indexPath.row ==  9) return    70.0;  // text for complexity #2
        if (indexPath.row == 10) return    55.0;  // image willpower  overcome trait
        if (indexPath.row == 11) return    24.0;  // spacer

        if (indexPath.row == 12) return    30.0;  // title for 3 categories    3 fun categories
        if (indexPath.row == 13) return    16.0;  // spacer

        if (indexPath.row == 14) return    45.0;  // text #1 for 3 categories

        if (indexPath.row == 15) return     8.0;  // spacer
//        if (indexPath.row == 16) return   320.0;  // image 3 categories
        if (indexPath.row == 16) return   200.0;  // image 3 categories

        if (indexPath.row == 17) return     1.0;  // spacer
//        if (indexPath.row == 18) return   130.0;  // text #2 for 3 categories
//        if (indexPath.row == 18) return   220.0;  // text #2 for 3 categories
//        if (indexPath.row == 18) return   250.0;  // text #2 for 3 categories
        if (indexPath.row == 18) return   260.0;  // text #2 for 3 categories


        if (indexPath.row == 19) return     16.0;  // spacer
        if (indexPath.row == 20) return    30.0;  // title for relationships are really complex
//        if (indexPath.row == 21) return   210.0;  // text for complexity part 2
//        if (indexPath.row == 21) return   225.0;  // text for complexity part 2
//        if (indexPath.row == 21) return   240.0;  // text for complexity part 2
//        if (indexPath.row == 21) return   270.0;  // text for complexity part 2
//        if (indexPath.row == 21) return   145.0;  // text for complexity part 2
//        if (indexPath.row == 21) return   120.0;  // text for complexity part 2
        if (indexPath.row == 21) return    95.0;  // text for complexity part 2
        if (indexPath.row == 22) return    20.0;  // text for disclaimer
    }
    // if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"])     // what color is the day?
    if (   [gbl_helpScreenDescription isEqualToString: @"what color"]  ) {

        if (indexPath.row == 0) return    90.0;  
        if (indexPath.row == 1) return   210.0;  
        if (indexPath.row == 2) return   120.0;  
        if (indexPath.row == 3) return     8.0;  // spacer
        if (indexPath.row == 4) return    75.0;  // image for overcome destiny
        if (indexPath.row == 5) return     8.0;  // spacer
        if (indexPath.row == 6) return    20.0;  // text for disclaimer
    }
    // if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] )    // my best match (grpone)
    if (   [gbl_helpScreenDescription isEqualToString: @"best match"]  ) {

        if (indexPath.row ==  0) return   100.0;  // text for preamble
        if (indexPath.row ==  1) return     8.0;  // spacer
        if (indexPath.row ==  2) return    30.0;  // title for scores
        if (indexPath.row ==  3) return    16.0;  // spacer
        if (indexPath.row ==  4) return   225.0;  // image
        if (indexPath.row ==  5) return   100.0;  // this report details
        if (indexPath.row ==  6) return     8.0;  // spacer
        if (indexPath.row ==  7) return    30.0;  // title for complexity
        if (indexPath.row ==  8) return   140.0;  // text for complexity #1
        if (indexPath.row ==  9) return    70.0;  // image two things
//        if (indexPath.row ==  9) return    100.0;  // image two things
        if (indexPath.row == 10) return     8.0;  // spacer
        if (indexPath.row == 11) return    70.0;  // text for complexity #2
        if (indexPath.row == 12) return    55.0;  // image willpower  overcome trait
        if (indexPath.row == 13) return    16.0;  // spacer
        if (indexPath.row == 14) return    20.0;  // text for disclaimer
    }
    return 200.0;  // default  (should neve happen)

}  // end of heightForRowAtIndexPath
// ---------------------------------------------------------------------------------------------------------------------


//  full example NSMutableAttributedString:  http://stackoverflow.com/questions/11031623/how-can-i-use-attributedtext-in-uilabel
//  (could not get this version to work)
//
//NSString *redText  = @"red text";
//NSString *greenText = @"green text";
//NSString *purpleBoldText = @"purple bold text";
//
//NSString *text = [NSString stringWithFormat:@"Here are %@, %@ and %@", 
//                  redText,  
//                  greenText,  
//                  purpleBoldText];
//
//// If attributed text is supported (iOS6+)
//if ([self.label respondsToSelector:@selector(setAttributedText:)]) {
//
//    // Define general attributes for the entire text
//    NSDictionary *attribs = @{
//                              NSForegroundColorAttributeName: self.label.textColor,
//                              NSFontAttributeName: self.label.font
//                              };
//    NSMutableAttributedString *attributedText = 
//        [[NSMutableAttributedString alloc] initWithString:text
//                                               attributes:attribs];
//
//    // Red text attributes
//    UIColor *redColor = [UIColor redColor];
//    NSRange redTextRange = [text rangeOfString:redText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:redColor}
//                            range:redTextRange];
//
//    // Green text attributes
//    UIColor *greenColor = [UIColor greenColor];
//    NSRange greenTextRange = [text rangeOfString:greenText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor}
//                            range:greenTextRange];
//
//    // Purple and bold text attributes
//    UIColor *purpleColor = [UIColor purpleColor];
//    UIFont *boldFont = [UIFont boldSystemFontOfSize:self.label.font.pointSize];
//    NSRange purpleBoldTextRange = [text rangeOfString:purpleBoldText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//    [attributedText setAttributes:@{NSForegroundColorAttributeName:purpleColor,
//                                    NSFontAttributeName:boldFont}
//                            range:purpleBoldTextRange];
//
//    self.label.attributedText = attributedText;
//




-(void) viewWillAppear:(BOOL)animated 
{
    NSLog(@"in INFO  viewWillAppear!");
    [super viewWillAppear: animated];

//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//    self.navigationItem.rightBarButtonItem = mySpacerForTitle;
//

//  NSLog(@"gbl_justLookedAtInfoScreen  bef in ViewWillAppear in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );
    gbl_justLookedAtInfoScreen = 1;
//  NSLog(@"gbl_justLookedAtInfoScreen  aft in ViewWillAppear in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );



    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  


//self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 
//[self.navigationController.navigationBar setHidden:YES];  

    // set up navigation bar  right button  with mamb icon
    //
        UIImage *myImage = [[UIImage imageNamed: @"rounded_MAMB09_029.png"]
                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

        UIBarButtonItem *myMAMBicon = [[UIBarButtonItem alloc]initWithImage: myImage
                                                                      style: UIBarButtonItemStylePlain 
                                                                     target: self 
                                                                     action: nil];
        [myMAMBicon setEnabled:NO];
//        myMAMBicon.userInteractionEnabled = NO;

//        [[self navigationItem] setTitle: myNavBarTitle];  // moving this from the bottom of dispatch_async block to top solved the problem of nav bar title stuttering from left to right (about 1 sec)   why does it work?
//        titleLabel.textAlignment = UITextAlignmentCenter
//        self.navigationItem.titleLabel.textAlignment = UITextAlignmentCenter;
//<.>

        self.navigationItem.rightBarButtonItem = myMAMBicon;

//
//        // try to fix title listing to right
//        if (    [gbl_currentMenuPlusReportCode isEqualToString: @"hompcy" ]
//            ||  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc" ] ) 
//        {
//            //   navigationItem.rightBarButtonItems = @[rightA, rightB]
//            self.navigationItem.rightBarButtonItems = @[gbl_flexibleSpace, gbl_flexibleSpace, gbl_flexibleSpace, myMAMBicon];
//        } else {
//            self.navigationItem.rightBarButtonItem = myMAMBicon;
//        }
//

        self.tableView.allowsSelection = NO;   // see shouldHighlightRowAtIndexPath just below
    });



//    NSLog(@"END OF  in INFO  viewWillAppear!");


} // end of   viewWillAppear


- (BOOL)tableView:(UITableView *)tableView  shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (void)viewDidAppear:(BOOL)animated

{
    //     [super viewDidAppear];
    NSLog(@"in INFO   viewDidAppear!");

//  NSLog(@"gbl_justLookedAtInfoScreen  bef in ViewDidAppear in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );
    gbl_justLookedAtInfoScreen = 1;
//  NSLog(@"gbl_justLookedAtInfoScreen  aft in ViewDidAppear in  INFO  =[%ld]",(long)gbl_justLookedAtInfoScreen );

}

@end


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//  p_fn_prtlin("    *trait");
//  p_fn_prtlin("");
//  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken");
//
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//
//  p_fn_prtlin("     Passionate    - intense, relentless, enthusiastic");
//  p_fn_prtlin("     Assertive     - competitive, authoritative, outspoken");
//  p_fn_prtlin("     Emotional     - protective, sensitive, possessive");
//  p_fn_prtlin("     Restless      - versatile, changeable, independent");
//Enter/  p_fn_prtlin("     Down-to-earth - stable, practical, ambitious");
//
//
//  p_fn_prtlin("     Ups and Downs - having very high ups ");
//  p_fn_prtlin("                     and very low downs in life ");
//  p_fn_prtlin("");
//  p_fn_prtlin("");
//  p_fn_prtlin("  Check out reports \"Most Assertive\", \"Most Emotional\" ...  ");
//  p_fn_prtlin("  which use trait scores to compare with other group members  ");
//  p_fn_prtlin("");

//
