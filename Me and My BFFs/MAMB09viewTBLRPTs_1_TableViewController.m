//
//  MAMB09viewTBLRPTs_1_TableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-02-26.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import "MAMB09viewTBLRPTs_1_TableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


@interface MAMB09viewTBLRPTs_1_TableViewController ()

@end

//
//    // buffer for C string input birthinfo CSVs    (length 64)     (for ALL GROUP REPORTS)
//    //
//    char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
//    int  group_report_input_birthinfo_idx;
//
//    // buffer for C string output report line PSVs (length 64)     (for ALL GROUP REPORTS)
//    //
//    char group_report_output_PSVs[gbl_maxGrpRptLines * gbl_maxLenRptLinePSV];                  // [333 * fixed length of 64]
//    int  group_report_output_idx;
//
    // is this now visible throughout  MAMB09viewTBLRPTs_1_TableViewController  ?
    //
    char group_report_input_birthinfo_CSVs[250 * 64];  // [250 * fixed length of 64]
    int  group_report_input_birthinfo_idx;
    char group_report_output_PSVs[333 * 64];           // [333 * fixed length of 64]
    int  group_report_output_idx;


@implementation MAMB09viewTBLRPTs_1_TableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();
    NSLog(@"in TBLRPT_1 viewDidLoad!");
    
  NSLog(@"self.view.bounds.size.width   =[%f]",self.view.bounds.size.width   );
  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );
//self.view.bounds.size.height  
    // Uncomment the following line to preserve selection between presentations.
//         self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


  NSLog(@" 1 gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
  NSLog(@"gbl_fromHomeCurrentSelectionPSV=[%@]",gbl_fromHomeCurrentSelectionPSV);






    // -------------------------------------------------------------------------------------------------------------------------
    // MAMB09viewTBLRPTs_1_TableViewController.m 
    // -------------------------------------------------------------------------------------------------------------------------
    //     - displays  9 RPTs  hompbm,homgbm, homgma,homgme,homgmr,homgmp,homgmd homgby,homgbd
    //     - displays 11 RPTs  hompbm,homgbm, homgma,homgme,homgmr,homgmp,homgmd homgby,homgbd ,homppe, hompco
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
    //      so, in viewWillAppear()  (check it out), when the user returns, we have to re-set  gbl_currentMenuPlusReportCode
    //
    //      this is 16+9=25 reports   FYI, the other 4 reports are  hompcy,homppe,hompco,hompwc
    //      this is 16+9=25 reports   FYI, the other 4 reports are  hompcy,              hompwc
    // -------------------------------------------------------------------------------------------------------------------------





//        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]  // Most Assertive
//            || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgme"]  // Most Emotional
//            || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmr"]  // Most Restless
//            || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmp"]  // Most Passionate
//            || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmd"]  // Most Down-to-earth
//        ) { 
//    ////        [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLineEtched]; // keep   separator lines between cells
//            [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine]; // keep   separator lines between cells
//    
//         } else {
//             [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone]; // remove separator lines between cells
//         }
//
    //
    // 20150602  decided to keep no separator and alternate light green / really light green
    //
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone]; // remove separator lines between cells
    //  20150604 abandon



    //self.tableView.backgroundColor = gbl_color_cHed;   // WORKS
    self.tableView.backgroundColor = gbl_color_cBgr;   // WORKS



    gbl_tblrpts1_ShouldAddToNavBar = 1; // init to prevent  multiple programatic adds of nav bar items


    do {  // set PSV and NAME values

        // grpall  1 rpts   g  homg*
        // most    5 rpts   g  homg*
        // best    2 rpts   g  homg*

nbn(650);
        // grpone  all *MY* BEST MATCH ... reports  PLUS all table reports AFTER THAT in navigation <-------------
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]  // grpone  My Best Match in Group ... grpone
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ]  // grpone  My Best Match in Group ... grpone
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"homppe"]  // home    personality
        ) {
            gbl_TBLRPTS1_PSV_personJust1  = gbl_fromHomeCurrentSelectionPSV;    // from select person on home screen
            gbl_TBLRPTS1_NAME_personJust1 = [gbl_TBLRPTS1_PSV_personJust1 componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)


        // grpall all BEST MATCH ... reports  PLUS all table reports AFTER THAT in navigation <-------------
        } else if (
               [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ] // grpall  Best Match in Group ...
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ] // grpall  Best Match in Group ... 
        ) {
            ;  // no single person for this report

        } else if ( 
               [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]  // most
            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"] 
            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"] 
            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"] 

            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]  // best
            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]
        ) {
            gbl_TBLRPTS1_PSV_personJust1  = gbl_PSVtappedPerson_fromGRP;
            gbl_TBLRPTS1_NAME_personJust1 = [gbl_TBLRPTS1_PSV_personJust1 componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

        } else if (
                [gbl_currentMenuPlusReportCode      hasPrefix: @"hompco"]  // home    grpof2
        ) {
            gbl_TBLRPTS1_PSV_personA  = gbl_fromHomeCurrentSelectionPSV;
            gbl_TBLRPTS1_NAME_personA = [gbl_TBLRPTS1_PSV_personA componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

            gbl_TBLRPTS1_PSV_personB  = gbl_fromSelSecondPersonPSV;         // from select second person screen
            gbl_TBLRPTS1_NAME_personB = [gbl_TBLRPTS1_PSV_personB componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)
        }
  NSLog(@"gbl_TBLRPTS1_PSV_personA  =[%@]",gbl_TBLRPTS1_PSV_personA  );
  NSLog(@"gbl_TBLRPTS1_PSV_personB  =[%@]",gbl_TBLRPTS1_PSV_personB  );

    } while (false); // set PSV and NAME values


} // end of  viewDidLoad  in TBLRPT_1



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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//  NSLog(@"in numberOfSectionsInTableView");

    // Return the number of sections.

     //return 2;
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
NSLog(@"in numberOfRowsInSection in tblrpts 1");
    // Return the number of rows in the section.

    NSInteger retint;
    retint = 1; // default

    if (      [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] ) {  //  new personality TBLRPT  report
        retint = gbl_perDataLines.count;

    } else if ( [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] ) {  //  new compatibility TBLRPT  report
        retint = gbl_compDataLines.count;

    } else {

        // this might work for all 9 reports
        retint = group_report_output_idx + 1 + 3; // + 3 for 3 bottom cells
    }

  NSLog(@"retint=[%ld]",retint);

    return retint;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
tn();  NSLog(@"in cellForRowAtIndexPath in tblrpts 1 ");ki((int)indexPath.row);
    int myidx;
    char my_tmp_str[128];
    NSString *myCellContentsPSV;
    NSCharacterSet *mySeparators;
    NSArray  *tmpArray;
    NSString *myOriginalCellText;
    NSInteger myOriginalCellTextLen;

    NSString           *myNewCellText;
//    NSAttributedString *myNewCellAttributedText; 

//    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 12.0];
//    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 20.0];
//    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 16.0];

    UIFont *myFont_16  = [UIFont fontWithName: @"Menlo" size: 16.0];
//    UIFont *myFont_14  = [UIFont fontWithName: @"Menlo" size: 14.0];
    UIFont *myFont_12  = [UIFont fontWithName: @"Menlo" size: 12.0];
//    UIFont *myFont_11b = [UIFont fontWithName: @"Menlo-bold" size: 11.0];


    NSInteger numFillSpacesInColHeaders;
    NSInteger numCharsForRankNumsOnLeft;

    numFillSpacesInColHeaders = 0;
    numCharsForRankNumsOnLeft = 0;
    myOriginalCellTextLen     = 0;


    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:// forIndexPath:indexPath];
    // Configure the cell...
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"viewTBLRPTs_1_CellIdentifier";
    



    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: nil];  // try no re-use at all
//    UITableViewCell *cell;
//    cell = nil;


    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //  int rkheight = cell.frame.size.height ;   // is = 44
    //  kin(rkheight);
    //


//nbn(300);
    if ( [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] )  // -----------------------------------------------
    {  //  new personality TBLRPT  report
bn(301);
  NSLog(@"indexPath.row =[%ld]",indexPath.row );
  NSLog(@"gbl_perDataLines[indexPath.row]  [%@]",gbl_perDataLines[indexPath.row]  );


        // fixes   bg color of white on left and right
        //    [[UIScrollView appearance] setBackgroundColor: gbl_color_cBgr ];  does not work
        UIView *aBackgroundView = [[UIView alloc] initWithFrame:CGRectZero] ;
        aBackgroundView.backgroundColor = gbl_color_cBgr ;
        cell.backgroundView = aBackgroundView;


//        UIFont *myPerFont        = [UIFont fontWithName: @"Menlo" size: 12.0];
        UIFont *myPerFont;
        UIFont *perFont_16  = [UIFont fontWithName: @"Menlo" size: 16.0];
        UIFont *perFont_14  = [UIFont fontWithName: @"Menlo" size: 14.0];
        UIFont *perFont_12  = [UIFont fontWithName: @"Menlo" size: 12.0];
        UIFont *perFont_11b = [UIFont fontWithName: @"Menlo-bold" size: 11.0];
        
        NSCharacterSet *mySeps;
        NSArray        *tmparr;
        UIColor  *mybgcolor;
        UIColor  *mytextcolor;
        NSString *mycode;
        NSString *mylin;
        NSTextAlignment myalign;
        NSInteger       mynumlines;
        BOOL            myadjust;

        mybgcolor         = [UIColor redColor];
        myalign           = NSTextAlignmentLeft;  // default
        mynumlines        = 1;                    // default
        myadjust          = YES;                  // default
        mytextcolor       = [UIColor greenColor]; // default

        mySeps    = [NSCharacterSet characterSetWithCharactersInString:  @"|"];

        mylin     = gbl_perDataLines[indexPath.row];  

        tmparr    = [mylin componentsSeparatedByCharactersInSet: mySeps];
        if (tmparr.count > 1) {
            mycode    = tmparr[0];
            mylin     = tmparr[1];
        }
  NSLog(@"mylin=[%@]",mylin);

//gbl_color_cNeu 
//gbl_color_cBgr 
//gbl_color_cHed
        if ( [mycode isEqualToString: @"fill"] ) {
bn(3011);
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myPerFont         = perFont_16;

            if ( [mylin isEqualToString: @"filler line #1 at top"] ) {
bn(3012);
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before table head"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"after table head"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before table foot"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"after table foot"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before para"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellPER = 12;;
            }
            else if ( [mylin isEqualToString: @"before willpower"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellPER = 24;
            }
            else if ( [mylin isEqualToString: @"in willpower at beg"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"in willpower at end"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before produced by"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellPER = 16;
            }
            else if ( [mylin isEqualToString: @"before entertainment"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellPER = 4;
            }
        }
        if ( [mycode isEqualToString: @"head"] ) {
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            gbl_heightCellPER = 16;
//            gbl_heightCellPER = 20;
            gbl_heightCellPER = 16;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
//            myPerFont         = perFont_16;
            myPerFont         = perFont_14;
        }
        if ( [mycode isEqualToString: @"foot"] ) {
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            gbl_heightCellPER = 16;
            gbl_heightCellPER = 16;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
//            myPerFont         = perFont_16;
            myPerFont         = perFont_14;
        }
        if ( [mycode isEqualToString: @"tabl"] ) {
            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cNeu ;
//            mybgcolor         = gbl_color_cGre ;
//            gbl_heightCellPER = 24;
            gbl_heightCellPER = 20;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
            myPerFont         = perFont_16;
        }
        if ( [mycode isEqualToString: @"para"] ) {
            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
//            gbl_heightCellPER = 16;
//            gbl_heightCellPER = 20;
            gbl_heightCellPER = 18;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myPerFont         = perFont_16;
        }
        if ( [mycode isEqualToString: @"will"] ) {
            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
            gbl_heightCellPER = 16;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
            myPerFont         = perFont_16;
        }
        if ( [mycode isEqualToString: @"prod"] ) {
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
            gbl_heightCellPER = 16;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
            myPerFont         = perFont_12;
        }
        if ( [mycode isEqualToString: @"purp"] ) {
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
            gbl_heightCellPER = 16;
            myadjust          = YES;
            mytextcolor       = [UIColor redColor];
            myPerFont         = perFont_11b;
        }


        dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
            cell.textLabel.text                      = mylin;   // --------------------------------------------------
            cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
//            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textAlignment             = myalign;

            cell.userInteractionEnabled              = NO;

            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
//            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

//            cell.accessoryView                       = myDisclosureIndicatorLabel;
//            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryType                       = UITableViewCellAccessoryNone;

            cell.textLabel.numberOfLines             = mynumlines; 
            cell.textLabel.textColor                 = mytextcolor;
            cell.textLabel.font                      = myPerFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.backgroundColor           = mybgcolor;
//                cell.contentView.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
        });

bn(302);
        return cell;

    }  // end of new personality TBLRPT  report
//bn(303);




    //  new compatibility TBLRPT  report   $$$$$$$ in cellforrowataindexpath $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    //
//nbn(600);
    if ( [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] )
    { 
//       gbl_compIsInHowBig = 0;   // DEFAULT setting

            UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            [UIButton buttonWithType: UIButtonTypeCustom];
            myInvisibleButton.backgroundColor = [UIColor clearColor];

//bn(601);
//  NSLog(@"indexPath.row =[%ld]",indexPath.row );
//  NSLog(@"gbl_compDataLines[indexPath.row]  [%@]",gbl_compDataLines[indexPath.row]  );

    // Set the UIScrollView's frame to be the tableViewCell's bounds (or frame, I never remember off the top of my head):
     //scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//     self.tableView = [[UIScrollView alloc] initWithFrame:self.bounds];
//     self.tableView = [[UIScrollView alloc] initWithFrame: cell.bounds];
//And setting [scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight]; will allow scrollView to resize when its container resizes and also allows its contents to be resized.
//     [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
//     [cell setAutoresizingMask:UIViewAutoresizingFlexibleHeight];


        // fixes   bg color of white on left and right
        //    [[UIScrollView appearance] setBackgroundColor: gbl_color_cBgr ];  does not work
        UIView *aBackgroundView = [[UIView alloc] initWithFrame:CGRectZero] ;
        aBackgroundView.backgroundColor = gbl_color_cBgr ;
        cell.backgroundView = aBackgroundView;


        UIFont *myCompFont;

        UIFont *compFont_16 ;
        UIFont *compFont_14 ;
        UIFont *compFont_12 ;
        UIFont *compFont_11b;

        // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
        //                                 // 6s  = 667.0 x 375  and 6
        //                                 // 5s  = 568.0 x 320  and 5 
        //                                 // 4s  = 480.0 x 320  and 5 
        //
        //  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );
        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
//            compFont_16  = [UIFont fontWithName: @"Menlo" size: 16.0];
//            compFont_14  = [UIFont fontWithName: @"Menlo" size: 14.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size: 12.0];
//            compFont_11b = [UIFont fontWithName: @"Menlo-bold" size: 11.0];


            compFont_16  = [UIFont fontWithName: @"Menlo" size: 16.0];

            compFont_14  = [UIFont fontWithName: @"Menlo" size: 14.0];
//            compFont_14  = [UIFont fontWithName: @"Menlo" size: 10.0];
//              compFont_14  = [UIFont fontWithName: @"Menlo" size: 13.0]; // too big still
//              compFont_14  = [UIFont fontWithName: @"Menlo" size: 12.5]; // too big still
//            compFont_14  = [UIFont fontWithName: @"Menlo" size: 12.0];

            compFont_12  = [UIFont fontWithName: @"Menlo" size: 12.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size: 11.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size:  9.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size: 14.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size: 13.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size: 15.0];

            compFont_11b = [UIFont fontWithName: @"Menlo-bold" size: 11.0];

        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            compFont_16  = [UIFont fontWithName: @"Menlo" size: 14.0];
            compFont_14  = [UIFont fontWithName: @"Menlo" size: 12.0];
            compFont_12  = [UIFont fontWithName: @"Menlo" size: 10.0];
            compFont_11b = [UIFont fontWithName: @"Menlo-bold" size: 10.0];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
//            compFont_16  = [UIFont fontWithName: @"Menlo" size: 12.0];
//            compFont_14  = [UIFont fontWithName: @"Menlo" size: 10.0];
//            compFont_12  = [UIFont fontWithName: @"Menlo" size:  8.0];
//            compFont_11b = [UIFont fontWithName: @"Menlo-bold" size:  10.0];
            compFont_16  = [UIFont fontWithName: @"Menlo" size: 13.0];
            compFont_14  = [UIFont fontWithName: @"Menlo" size: 11.0];
            compFont_12  = [UIFont fontWithName: @"Menlo" size:  9.0];
            compFont_11b = [UIFont fontWithName: @"Menlo-bold" size:  9.0];
        }

        
        NSCharacterSet *mySeps;
        NSArray        *tmparr;
        UIColor  *mybgcolor;
        UIColor  *mybgcolorfortableline;
        UIColor  *mytextcolor;
        NSString *mycode;
        NSString *mycode2;
        NSString *myscore;
        NSString *myspace;
//        NSString *mypersonA;
//        NSString *mypersonB;
        NSString *mylin;
        NSString *mywrk;
//        NSString *mylin3;
        NSTextAlignment myalign;
        NSInteger       mynumlines;
        BOOL            myadjust;

//        UIColor *mybgcolortouse;

        mybgcolor         = [UIColor redColor];
        myalign           = NSTextAlignmentLeft;  // default
        mynumlines        = 1;                    // default
        myadjust          = YES;                  // default
        mytextcolor       = [UIColor greenColor]; // default

        mySeps    = [NSCharacterSet characterSetWithCharactersInString:  @"|"];

 tn();
  NSLog(@"mywrk=[%@]",mywrk);
        mywrk     = gbl_compDataLines[indexPath.row];  

        tmparr    = [mywrk  componentsSeparatedByCharactersInSet: mySeps];
        if (tmparr.count > 1) {
            mycode    = tmparr[0];
            mylin     = tmparr[1];
        }
 NSLog(@"mycode=[%@]",mycode);
 NSLog(@"mylin=[%@]",mylin);

//gbl_color_cNeu 
//gbl_color_cBgr 
//gbl_color_cHed
        if ( [mycode isEqualToString: @"fill"] ) {
            gbl_areInCompatibilityTable = 0;
bn(6011);
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_16;

            if ( [mylin isEqualToString: @"filler line #1 at top"] ) {
bn(6012);
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 18;
            }
            else if ( [mylin isEqualToString: @"before table head"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
                mybgcolor         = gbl_color_cNeu ;
                gbl_heightCellCOMP = 8;
            }
            else if ( [mylin isEqualToString: @"after table head"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellCOMP = 8;
            }
//            else if ( [mylin isEqualToString: @"before table foot"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellCOMP = 8;
//            }
            else if ( [mylin isEqualToString: @"after table foot"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cNeu ;
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellCOMP = 8;
            }
            else if ( [mylin isEqualToString: @"filler before how big"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 24;
            }
            else if ( [mylin isEqualToString: @"before how big header"] ) {
//                gbl_compIsInHowBig = 1;
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cNeu ;
                gbl_heightCellCOMP = 3;
            }

            // lin=[fill|after how big header]__
            // lin=[fill|after personal stars]__
            // lin=[fill|after personA ptofview]__
            // lin=[fill|after personB ptofview]__
            // lin=[fill|after howbigftr]__
            // lin=[fill|filler after how big]__
            // lin=[fill|filler before paras]__
            // 
            else if ( [mylin isEqualToString: @"after how big header"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cNeu ;
//                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 8;
            }
            else if (   [mylin isEqualToString: @"after personal stars"]
                     || [mylin isEqualToString: @"after personA ptofview"]
            ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cBgr ;
//                mybgcolor         = gbl_color_cNeu ;
                gbl_heightCellCOMP =  8;
            }
            else if (   [mylin isEqualToString: @"after personB ptofview"]
            ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cBgr ;
//                mybgcolor         = gbl_color_cNeu ;
                gbl_heightCellCOMP =  8;
            }
            else if ( [mylin isEqualToString: @"after howbigftr"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cNeu ;
                mybgcolor         = gbl_color_cHed ;
                gbl_heightCellCOMP =  4;
            }
            else if ( [mylin isEqualToString: @"filler after how big"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 8;
            }
            else if ( [mylin isEqualToString: @"filler before paras"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 2;
            }


            else if ( [mylin isEqualToString: @"before para"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
//                gbl_heightCellCOMP = 16;
                gbl_heightCellCOMP = 12;
            }

            // lin=[fill|before goodrelationship]__
            // lin=[fill|in goodrelationship at beg]__
            // lin=[fill|in goodrelationship at end]__
            //
            else if ( [mylin isEqualToString: @"before goodrelationship"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
//                mybgcolor         = [UIColor blueColor];
                gbl_heightCellCOMP = 12;
            }
            else if ( [mylin isEqualToString: @"in goodrelationship at beg"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
//                mybgcolor         = gbl_color_cNeu ;
                gbl_heightCellCOMP = 12;
            }
            else if ( [mylin isEqualToString: @"in goodrelationship at end"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cRed ;
//                mybgcolor         = [UIColor blackColor];
                gbl_heightCellCOMP = 4;
            }


            else if ( [mylin isEqualToString: @"before produced by"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 12;
            }
            else if ( [mylin isEqualToString: @"before entertainment"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                gbl_heightCellCOMP = 4;
            }
        }
        //
         //  new compatibility TBLRPT  report   $$$$$$$$$$$$$$$$$$$$$$$$
        //

        // input for table  at the top of rpt
        //
        // lin=[fill|filler line #1 at top]__
        // lin=[head|space above hdr line]__
        // lin=[head|Compatibility]__
        // lin=[head|space above hdr line]__
        // lin=[head|    Potential]__
//        // lin=[head|space below hdr line]__

        // lin=[tabl|label@90@space above]__
        // lin=[tabl|label@90@filler]__
        // lin=[tabl|label@90@space below]__
        // lin=[tabl|label@75@space above]__
        // lin=[tabl|label@75@filler]__
        // lin=[tabl|label@75@space below]__
        // lin=[tabl|label@50@space above]__
        // lin=[tabl|label@50@filler]__
        // lin=[tabl|label@50@space below]__
        // lin=[tabl|pair@26@space above@x]__
        // lin=[tabl|pair@26@~Emma@~Anya]__
        // lin=[tabl|pair@26@space below@x]__
        // lin=[tabl|label@25@space above]__
        // lin=[tabl|label@25@filler]__
        // lin=[tabl|label@25@space below]__
        // lin=[tabl|label@10@space above]__
        // lin=[tabl|label@10@filler]__
        // lin=[tabl|label@10@space below]__

        // lin=[fill|filler before how big]__
        //

        if ( [mycode isEqualToString: @"head"] )
        {                                                  // comp top table header
            gbl_areInCompatibilityTable = 1;

  NSLog(@"in HEADER");
  NSLog(@"mycode=[%@]",mycode);
  NSLog(@"mylin =[%@]",mylin);
  NSLog(@"gbl_heightCellCOMP =[%ld]",(long)gbl_heightCellCOMP );
  NSLog(@"gbl_topTableWidth=[%ld]",gbl_topTableWidth);

            
  NSLog(@"mylin hdr=[%@]",mylin);
            NSInteger thisIsHeaderSpace;
            if ([mylin hasPrefix: @"space "]) {
nbn(50);
                gbl_heightForCompTable = 2.0;
                thisIsHeaderSpace      = 1;
               mylin = @" ";
            } else {
//                gbl_heightForCompTable = 18.0;
                gbl_heightForCompTable = 16.0;
                thisIsHeaderSpace      = 0;
            }


            // FORMAT the HEADER line
            //    there are long and short lines depending on the 2 name lengths
            //
            if (gbl_pairPersonA.length + gbl_pairPersonB.length > gbl_ThresholdshortTblLineLen) {
                gbltmpstr = [NSString stringWithFormat: @"|%@%@ |",
                    [@"" stringByPaddingToLength: gbl_topTableWidth - mylin.length - 11 + 1 // 11 = like "  Not Good "
                                      withString: @" "
                                 startingAtIndex: 0
                    ] ,
                    mylin 
                ];
//                gbl_heightCellCOMP = 18;
  NSLog(@"gbltmpstr 111  =[%@]",gbltmpstr );
            } else {
                gbltmpstr = [NSString stringWithFormat: @"|%@%@ |",
                    [@"" stringByPaddingToLength: gbl_topTableWidth - mylin.length
                                      withString: @" "
                                 startingAtIndex: 0
                    ] ,
                    mylin 
                ];
//                gbl_heightCellCOMP = 18;
  NSLog(@"gbltmpstr 222  =[%@]",gbltmpstr );
            }


            mylin             = gbltmpstr;


//  NSLog(@"mylin with pipes=[%@]",mylin);
//  NSLog(@"mylin.length =[%ld]",(long)mylin.length );
//           gbltmpint = (long)mylin.length ;

//           gbltmpint = mylin.length ;  // WEIRD   MAGIC   has to be  here for right length of first hdr line

            myalign           = NSTextAlignmentCenter;
//            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
            mybgcolorfortableline = gbl_color_cHed ;
//            gbl_heightCellPER = 16;
//            gbl_heightCellCOMP = 20;
//            gbl_heightCellCOMP = 24;
//            gbl_heightCellCOMP = 30;
//            gbl_heightCellCOMP = 13.8;
//            gbl_heightCellCOMP = 18;


            myadjust          = YES;
//            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_14;

            // NOTE: this is copied from "tabl|"
            NSMutableAttributedString *myAttrString;    // for cell text
//            NSMutableAttributedString *myAttrSpace;     // for cell text
//            NSString                  *myStringNoAttr;  // for work string


//            myAttrString  = [[NSMutableAttributedString alloc] initWithString: mylin ];


//#define FONT_SIZE 20
//#define FONT_HELVETICA @"Helvetica-Light"
//#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.4f]
//NSString*myNSString = @"This is my string.\nIt goes to a second line.";                

NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
               paragraphStyle.alignment = NSTextAlignmentCenter;
//             paragraphStyle.lineSpacing = FONT_SIZE/2;
//             paragraphStyle.lineSpacing = -5;

//                     UIFont * labelFont = [UIFont fontWithName:Menlo size: 16.0];
//                   UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
//                       NSShadow *shadow = [[NSShadow alloc] init];
//                 [shadow setShadowColor : BLACK_SHADOW];
//                [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
//            [shadow setShadowBlurRadius : 1 ];

//NSAttributedString *labelText = [[NSAttributedString alloc] initWithString :  myNSString
//       *myAttrString = [[NSAttributedString alloc] initWithString : mylin   // myNSString
       myAttrString = [[NSMutableAttributedString alloc] initWithString : mylin   // myNSString
           attributes : @{
               NSParagraphStyleAttributeName : paragraphStyle,
//                         NSFontAttributeName : compFont_16 
                         NSFontAttributeName : compFont_14 
//               NSBaselineOffsetAttributeName : @-1.0
           }
       ];
//                 NSKernAttributeName : @2.0,
//                 NSFontAttributeName : labelFont
//      NSForegroundColorAttributeName : labelColor,
//              NSShadowAttributeName : shadow





            [myAttrString addAttribute: NSBackgroundColorAttributeName value: gbl_color_cHed
                                                                       range: NSMakeRange(0, myAttrString.length)];



//            [myAttrString addAttribute: NSForegroundColorAttributeName value: mybgcolorfortableline  // [UIColor redColor]
            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr 
                                                                       range: NSMakeRange(0,1)];
            [myAttrString addAttribute: NSBackgroundColorAttributeName value: gbl_color_cBgr
                                                                       range: NSMakeRange(0,1)];

//            [myAttrString addAttribute: NSForegroundColorAttributeName value: [UIColor redColor]   // for test
//                                                                       range: NSMakeRange(0,1)];
//            [myAttrString addAttribute: NSBackgroundColorAttributeName value: [UIColor greenColor] // for test
//                                                                       range: NSMakeRange(0,1)];


            [myAttrString addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor]
                                                                       range: NSMakeRange(1,myAttrString.length - 2)];


//            [myAttrString addAttribute: NSForegroundColorAttributeName value: mybgcolorfortableline  //[UIColor redColor]
            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr  // [UIColor redColor]
                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];
            [myAttrString addAttribute: NSBackgroundColorAttributeName value: gbl_color_cBgr
                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];

//            [myAttrString addAttribute: NSForegroundColorAttributeName value: [UIColor redColor]   // for test
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];
//            [myAttrString addAttribute: NSBackgroundColorAttributeName value: [UIColor greenColor]   // for test
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];

  NSLog(@"myAttrString =[%@]",[myAttrString string]);


//            UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//            [UIButton buttonWithType: UIButtonTypeCustom];
//            myInvisibleButton.backgroundColor = [UIColor clearColor];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  comp  table header
//                cell.textLabel.text                      = mylin;  // plain text not used
//                cell.textLabel.attributedText            = myAttrString;  // order matters- pipes appear if this line is here
//                cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
//                cell.textLabel.adjustsFontSizeToFitWidth = NO;
                cell.textLabel.textAlignment             = NSTextAlignmentCenter;
                cell.userInteractionEnabled              = NO;
//              cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
                cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
//                cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
                cell.accessoryType                       = UITableViewCellAccessoryNone;
                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.font                      = myCompFont;
                cell.textLabel.adjustsFontSizeToFitWidth = NO;
                cell.textLabel.backgroundColor           = mybgcolor;
                cell.textLabel.attributedText            = myAttrString;  // order matters- pipes DO NOT appear if this line is here
                cell.imageView.image                     = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView                      = nil ;
            });

            CGRect rect = [ myAttrString boundingRectWithSize: CGSizeMake(300, 10000)
                                                      options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                      options:NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesFontLeading
                                                      context: nil
            ];

            if (thisIsHeaderSpace  == 0) {
               gbl_heightForCompTable = rect.size.height;  // found NO  "space" in myspace NSString
            }
  NSLog(@"HEIGHT for tbl hdr=[%f]",gbl_heightForCompTable );

            return cell;   //     special case cell      special case       special case       special case      special case   

        }  // table header


        if ( [mycode isEqualToString: @"foot"] ) {
            gbl_areInCompatibilityTable = 0;
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            gbl_heightCellPER = 16;
            gbl_heightCellCOMP = 18;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_16;
        }

        if ( [mycode isEqualToString: @"tabl"] ) {
            gbl_areInCompatibilityTable = 1;


//            myalign           = NSTextAlignmentLeft;
            myalign           = NSTextAlignmentCenter;
//            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            //            gbl_heightCellPER = 24;
//            gbl_heightCellCOMP = 20;
//            gbl_heightCellCOMP = 24;
//            gbl_heightCellCOMP = 44;
//            gbl_heightCellCOMP = 13.8;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
//            myCompFont         = compFont_16;
            myCompFont         = compFont_14;
            mybgcolor         = gbl_color_cBgr ;
            
            tmparr    = [mylin  componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:  @"@"]]; 
            mycode2 = @" ";
            myscore = @"00";
            myspace = @" ";
            if (tmparr.count >= 2) {
                mycode2   = tmparr[0];
                myscore   = tmparr[1];
                myspace   = tmparr[2];
            }
  NSLog(@"mycode2=[%@]",mycode2);
  NSLog(@"myscore=[%@]",myscore);
  NSLog(@"myspace=[%@]",myspace);


            // lin=[tabl|label@90@space above]__
            // lin=[tabl|label@90@filler]__
            // lin=[tabl|label@90@space below]__
            // lin=[tabl|label@75@space above]__
            // lin=[tabl|label@75@filler]__
            // lin=[tabl|label@75@space below]__
            // lin=[tabl|pair@26@space above@x]__
            // lin=[tabl|pair@26@~Emma@~Anya]__
            // lin=[tabl|pair@26@space below@x]__
            // lin=[tabl|label@25@space below]__
            // lin=[tabl|label@10@space above]__
            // lin=[tabl|label@10@filler]__
            // lin=[tabl|label@10@space below]__
            //
            // lin=[fill|filler before how big]__
            if ( [mycode2 isEqualToString: @"label"] ) {

                // FORMAT the line
                //    there are long and short lines depending on the 2 name lengths
                //
                if (gbl_pairPersonA.length + gbl_pairPersonB.length <= gbl_ThresholdshortTblLineLen) { // SHORT line here
                    // SHORT line here

  NSLog(@"1line is short");
                    if( [myscore isEqualToString: @"90"] ) {
                        mybgcolorfortableline = gbl_color_cGr2;

                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr          = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr          = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr          = @"90  Great    ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
  NSLog(@"gbltmpstr              =[%@]",gbltmpstr          );
  NSLog(@"gbl_heightForCompTable =[%f]",gbl_heightForCompTable );

                    if( [myscore isEqualToString: @"75"] ) {
                        mybgcolorfortableline = gbl_color_cGre;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"75  Good     ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }

//                    if( [myscore isEqualToString: @"50"] ) { mybgcolorfortableline = gbl_color_cNeu; gbltmpstr = @"50  Average  ";}
                    if( [myscore isEqualToString: @"50"] ) {
                        mybgcolorfortableline = gbl_color_cNeu;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"50  Average  ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }

                    if( [myscore isEqualToString: @"25"] ) {
                        mybgcolorfortableline = gbl_color_cRed;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"25  Not Good ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
                    if( [myscore isEqualToString: @"10"] ) {
                        mybgcolorfortableline = gbl_color_cRe2;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"10  OMG      ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }

                    mylin = [NSString stringWithFormat:@"|%@%@|",
                        [@"" stringByPaddingToLength: gbl_topTableNamesWidth       withString: @" " startingAtIndex: 0],
                        gbltmpstr
                    ];
                    gbl_heightCellCOMP = 18;

  NSLog(@"[mylin s length]=[%ld]",[mylin length]);


                } else { // LONG  line here
  NSLog(@"2line is long ");

                    // if( [myscore isEqualToString: @"90"] ) { mybgcolorfortableline = gbl_color_cGr2; gbltmpstr = @"   Great  90 ";}
                    // if( [myscore isEqualToString: @"75"] ) { mybgcolorfortableline = gbl_color_cGre; gbltmpstr = @"    Good  75 ";}
                    // if( [myscore isEqualToString: @"50"] ) { mybgcolorfortableline = gbl_color_cNeu; gbltmpstr = @" Average  50 ";}
                    // if( [myscore isEqualToString: @"25"] ) { mybgcolorfortableline = gbl_color_cRed; gbltmpstr = @"Not Good  25 ";}
                    // if( [myscore isEqualToString: @"10"] ) { mybgcolorfortableline = gbl_color_cRe2; gbltmpstr = @"     OMG  10 ";}

                    if( [myscore isEqualToString: @"90"] ) {
                        mybgcolorfortableline = gbl_color_cGr2;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"   Great  90 ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
                    if( [myscore isEqualToString: @"75"] ) {
                        mybgcolorfortableline = gbl_color_cGre;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"    Good  75 ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
                    if( [myscore isEqualToString: @"50"] ) {
                        mybgcolorfortableline = gbl_color_cNeu;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @" Average  50 ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
                    if( [myscore isEqualToString: @"25"] ) {
                        mybgcolorfortableline = gbl_color_cRed;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"Not Good  25 ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
                    if( [myscore isEqualToString: @"10"] ) {
                        mybgcolorfortableline = gbl_color_cRe2;
                        if (      [myspace isEqualToString: @"space above"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  2.0;
                        }
                        else if ( [myspace isEqualToString: @"space below"] ) {
                            gbltmpstr              = @"             ";
                            gbl_heightForCompTable =  3.0;
                        } else {
                            gbltmpstr              = @"     OMG  10 ";
                            gbl_heightForCompTable = 18.0;
                        }
                    }
                    mylin = [NSString stringWithFormat:@"|%@%@|",
                        [@"" stringByPaddingToLength: gbl_topTableNamesWidth + 1 - 11 withString: @" " startingAtIndex: 0], // 11="  Not Good "
                        gbltmpstr
                    ];
                    gbl_heightCellCOMP = 18;

                } // end   LONG  line here

  NSLog(@"[mylin l length]=[%ld]",[mylin length]);
            } // if ( [mycode2 isEqualToString: @"label"] )


            // lin=[tabl|pair@26@space above@x]__
            // lin=[tabl|pair@26@~Emma@~Anya]__
            // lin=[tabl|pair@26@space below@x]__
            if ( [mycode2 isEqualToString: @"pair"] ) {

                // set mylin string
                //
                if( [myspace hasPrefix: @"space "] ) {
                    if (gbl_pairPersonA.length + gbl_pairPersonB.length <= gbl_ThresholdshortTblLineLen) { // SHORT line here
  NSLog(@"3line is short ");
                        mylin = [NSString stringWithFormat:@"|%@%@|",
                            [@"" stringByPaddingToLength: gbl_topTableNamesWidth       withString: @" " startingAtIndex: 0],
                            gbltmpstr
                        ];

                    } else { // LONG line here
  NSLog(@"4line is long ");
                        mylin = [NSString stringWithFormat:@"|%@%@|",
                            [@"" stringByPaddingToLength: gbl_topTableNamesWidth + 1 - 11 withString: @" " startingAtIndex: 0], // 11 is "  Not Good "
                            gbltmpstr
                        ];
                    }

                } else {
  NSLog(@"else ");
                    mylin = gbl_topTablePairLine;
                }
  NSLog(@"[mylin space length]=[%ld]",[mylin length]);
  NSLog(@"mylin=[%@]",mylin);
  NSLog(@"gbltmpstr=[%@]",gbltmpstr);


                if ( [myspace isEqualToString: @"space above"] ) {
                     gbltmpstr              = @"             ";
                    // gbltmpstr is set above
                    gbl_heightForCompTable =  2.0;
//                    gbl_heightForCompTable =  20.0;  for test
  NSLog(@"mylin a =[%@]",mylin);
                }
                if ( [myspace isEqualToString: @"space below"] ) {
                     gbltmpstr              = @"             ";
                    // gbltmpstr is set above
                    gbl_heightForCompTable =  3.0;
//                    gbl_heightForCompTable =  20.0;  for test
  NSLog(@"mylin b =[%@]",mylin);
                } 

                if (   [myspace isEqualToString: @"space above"]
                    || [myspace isEqualToString: @"space below"]
                ) {
                    if (gbl_pairPersonA.length + gbl_pairPersonB.length <= gbl_ThresholdshortTblLineLen) { // SHORT line here
  NSLog(@"10line is short ");
                        mylin = [NSString stringWithFormat:@"|%@%@|",
                            [@"" stringByPaddingToLength: gbl_topTableNamesWidth       withString: @" " startingAtIndex: 0],
                            gbltmpstr
                        ];

                    } else { // LONG line here
  NSLog(@"11Iline is long ");
                        mylin = [NSString stringWithFormat:@"|%@%@|",
                            [@"" stringByPaddingToLength: gbl_topTableNamesWidth + 1 - 11 withString: @" " startingAtIndex: 0], // 11 is "  Not Good "
                            gbltmpstr
                        ];
                    }
                }


                int sco;
                sco = [myscore intValue];  // nsstring to int
                if( sco >= 90    )  mybgcolorfortableline = gbl_color_cGr2;

                if( sco <  90 &&
                    sco >= 75    )  mybgcolorfortableline = gbl_color_cGre;
                if( sco <  75 &&
                    sco >  25    )  mybgcolorfortableline = gbl_color_cNeu;
                if( sco <= 25 &&
                    sco >  10    )  mybgcolorfortableline = gbl_color_cRed;

                if( sco <= 10    )  mybgcolorfortableline = gbl_color_cRe2;
            }

            // NOTE: this is copied from "tabl|"
            NSMutableAttributedString *myAttrString;    // for cell text
//            NSMutableAttributedString *myAttrSpace;     // for cell text
//            NSString                  *myStringNoAttr;  // for work string


//            myAttrString  = [[NSMutableAttributedString alloc] initWithString: mylin ];


//#define FONT_SIZE 20
//#define FONT_HELVETICA @"Helvetica-Light"
//#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.4f]
//NSString*myNSString = @"This is my string.\nIt goes to a second line.";                

NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
               paragraphStyle.alignment = NSTextAlignmentCenter;
//               paragraphStyle.alignment = NSTextAlignmentLeft;
//             paragraphStyle.lineSpacing = FONT_SIZE/2;
//             paragraphStyle.lineSpacing = -5;

//                     UIFont * labelFont = [UIFont fontWithName:Menlo size: 16.0];
//                   UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
//                       NSShadow *shadow = [[NSShadow alloc] init];
//                 [shadow setShadowColor : BLACK_SHADOW];
//                [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
//            [shadow setShadowBlurRadius : 1 ];

//NSAttributedString *labelText = [[NSAttributedString alloc] initWithString :  myNSString
//       *myAttrString = [[NSAttributedString alloc] initWithString : mylin   // myNSString
       myAttrString = [[NSMutableAttributedString alloc] initWithString : mylin   // myNSString
           attributes : @{
               NSParagraphStyleAttributeName : paragraphStyle,
//                         NSFontAttributeName : compFont_16 
                         NSFontAttributeName : compFont_14 
//               NSBaselineOffsetAttributeName : @-1.0
           }
       ];
//                 NSKernAttributeName : @2.0,
//                 NSFontAttributeName : labelFont
//      NSForegroundColorAttributeName : labelColor,
//              NSShadowAttributeName : shadow



//            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr
            [myAttrString addAttribute: NSBackgroundColorAttributeName value: mybgcolorfortableline
                                                                       range: NSMakeRange(0, myAttrString.length)];


//            [myAttrString addAttribute: NSForegroundColorAttributeName value: mybgcolorfortableline  // [UIColor redColor]
            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr
                                                                       range: NSMakeRange(0,1)];
            [myAttrString addAttribute: NSBackgroundColorAttributeName value: gbl_color_cBgr
                                                                       range: NSMakeRange(0,1)];

//            [myAttrString addAttribute: NSForegroundColorAttributeName value: [UIColor redColor]  // for test
//                                                                       range: NSMakeRange(0,1)];
//            [myAttrString addAttribute: NSBackgroundColorAttributeName value: [UIColor greenColor]  // for test
//                                                                       range: NSMakeRange(0,1)];

            [myAttrString addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor]
                                                                       range: NSMakeRange(1,myAttrString.length - 2)];

//            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];
//            [myAttrString addAttribute: NSBackgroundColorAttributeName value: gbl_color_cBgr
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];

            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr   // foreground
                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];
            [myAttrString addAttribute: NSBackgroundColorAttributeName value: gbl_color_cBgr   // background
                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];

//            [myAttrString addAttribute: NSForegroundColorAttributeName value: mybgcolorfortableline  //[UIColor redColor]
//            [myAttrString addAttribute: NSForegroundColorAttributeName value: gbl_color_cBgr  // [UIColor redColor]
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];


//            [myAttrString addAttribute: NSForegroundColorAttributeName value: [UIColor redColor]   // for test
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];
//            [myAttrString addAttribute: NSBackgroundColorAttributeName value: [UIColor greenColor]   // for test
//                                                                       range: NSMakeRange(myAttrString.length - 1, 1)];


            UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            [UIButton buttonWithType: UIButtonTypeCustom];
            myInvisibleButton.backgroundColor = [UIColor clearColor];

            CGRect rect;

            dispatch_async(dispatch_get_main_queue(), ^{               // <===  comp pair
                // do not set text
                cell.textLabel.textAlignment             = NSTextAlignmentCenter;
                cell.userInteractionEnabled              = NO;
//                cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
                cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
                cell.accessoryType                       = UITableViewCellAccessoryNone;
                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.textColor       = mytextcolor;
                cell.textLabel.font                      = myCompFont;
                cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
                cell.textLabel.backgroundColor           = mybgcolor;
                cell.textLabel.attributedText            = myAttrString;
                cell.imageView.image                     = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
                cell.backgroundView                      = nil ;

            });
            //<.> gold below, but above workd
            //            dispatch_async(dispatch_get_main_queue(), ^{            // <===  comp fall thru
            //                cell.textLabel.text                      = mylin;   // --------------------------------------------------
            //                cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
            //                cell.textLabel.textAlignment             = myalign;
            //                cell.userInteractionEnabled              = NO;
            //                cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
            //                cell.accessoryType                       = UITableViewCellAccessoryNone;
            //                cell.textLabel.numberOfLines             = 1; 
            //                cell.textLabel.textColor                 = mytextcolor;
            //                cell.textLabel.font                      = myCompFont;
            //                cell.textLabel.adjustsFontSizeToFitWidth = NO;
            //                cell.textLabel.backgroundColor           = mybgcolor;
            //            });
            //<.>
            //

                   rect = [ myAttrString boundingRectWithSize: CGSizeMake(300, 10000)
//                                                      options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                      options:NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesFontLeading
                                                      options:NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesDeviceMetrics  // these give NO grey lines (notice booboo)
                                                      context: nil
            ];

  NSLog(@"hey hey=[%@]",myspace);
            if ([myspace rangeOfString:@"space"].location == NSNotFound) {

//                gbl_heightForCompTable = myAttrString.size.height;  // found NO  "space" in myspace NSString
                gbl_heightForCompTable = rect.size.height;  // found NO  "space" in myspace NSString

  NSLog(@"gbl_heightForCompTable =[%f]",gbl_heightForCompTable );
//                gbl_heightForCompTable = ceil(myAttrString.size.height);  // found NO  "space" in myspace NSString
//  NSLog(@"gbl_heightForCompTable =[%f]",gbl_heightForCompTable );
            } else {
                ;   // gbl_heightForCompTable  already set        NSLog(@"string does not contain bla");
            }
kdn(gbl_heightForCompTable );

  NSLog(@"end of tabl|     ");



            return cell;   //     special case cell      special case       special case       special case      special case   

        } // end of "tabl|"


        // "how big" section   input data
        //
        // lin=[fill|filler before how big]__
        // lin=[fill|before how big header]__
        // lin=[howbighdr| HOW BIG]__
        // lin=[howbighdr| are the   favorable influences    +++++  ]__
        // lin=[howbighdr| and the   chalenging influences   -----  ]__
        // lin=[howbighdr| in the 3 categories below]__
        // lin=[fill|after how big header]__
        // lin=[catlabel| CLOSENESS ]__
        // lin=[stars|        easy ++++++++++++++++++++++++++++++                                                 ]__
        // lin=[stars|   difficult ----------                                                                     ]__
        // lin=[fill|after personal stars]__
        // lin=[catlabel| FROM ~EMMA's POINT OF VIEW ]__
        // lin=[stars|        easy +++++++++++++++++++++++++++++++++                                              ]__
        // lin=[stars|   difficult ----------------------------------------------------                           ]__
        // lin=[fill|after personA ptofview]__
        // lin=[catlabel| FROM ~ANYA's POINT OF VIEW ]__
        // lin=[stars|        easy +++++++++++++++++++++++++++++                                                  ]__
        // lin=[stars|   difficult --------------------------------------------------------------                 ]__
        // lin=[fill|after personB ptofview]__
        // lin=[howbigftr| good indicators are a full line of pluses]__
        // lin=[howbigftr| and double the pluses compared to minues ]__
        // lin=[fill|after howbigftr]__
        // lin=[fill|filler after how big]__
        // lin=[fill|filler before paras]__
        //
        if (   [mycode isEqualToString: @"howbighdr"]
        ) {
            gbl_areInCompatibilityTable = 0;

            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            mybgcolor         = gbl_color_cNeu ;
            gbl_heightCellCOMP = 18;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
//            myCompFont         = myFont_14;
            myCompFont         = compFont_14;
nbn(20); trn(" in howbighdr");
  NSLog(@"mylin=[%@]",mylin);

            NSInteger areInPlusesLine;
            areInPlusesLine = 0;
            NSInteger areInMinusesLine;
            areInMinusesLine = 0;
  NSLog(@"areInPlusesLine   =[%ld]",areInPlusesLine  );
  NSLog(@"areInMinusesLine  =[%ld]",areInMinusesLine  );

            const char *cString = [mylin UTF8String];

//            if (   [mylin rangeOfString: @"+++"   options: NSCaseInsensitiveSearch ].location == NSNotFound) areInMinusesLine = 1;
//            if (   [mylin rangeOfString: @"qqq"   options: NSCaseInsensitiveSearch ].location == NSNotFound) areInPlusesLine  = 1;
//            if (   [mylin rangeOfString: @"+++"   options: NSLiteralSearch ].location == NSNotFound) 
            if (strstr(cString, "+++") != NULL )  areInPlusesLine  = 1;
            if (strstr(cString, "---") != NULL )  areInMinusesLine = 1;

  NSLog(@"areInPlusesLine   =[%ld]",areInPlusesLine  );
  NSLog(@"areInMinusesLine  =[%ld]",areInMinusesLine  );

        if (areInPlusesLine  == 1) mybgcolor         = gbl_color_cGre ;
        if (areInMinusesLine == 1) mybgcolor         = gbl_color_cRed ;


//<.>  attrstr apple bug in ios 8 prevents this
//        if (areInPlusesLine == 1)
//        {   // here we have +++ line
//nbn(22);
//nbn(221);
//                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//                paragraphStyle.alignment = NSTextAlignmentLeft;
//
////  NSLog(@"mylin=[%@]",mylin);
////  mylin   = [NSString stringWithFormat:@"%@\n ", mylin]; //  assign  assign  assign  assign  assign  assign assign 
////  NSLog(@"mylin=[%@]",mylin);
//                gbl_attrStrWrk_11 = [[NSMutableAttributedString alloc] initWithString : mylin   // myNSString
//                   attributes : @{
//                       NSParagraphStyleAttributeName : paragraphStyle,
//                                  NSFontAttributeName: myFont_14,
//                       NSForegroundColorAttributeName: [UIColor blackColor]
////                       ,
////                       NSBackgroundColorAttributeName: gbl_color_cHed
//                   }
//                ];
//NSLog(@"gbl_attrStrWrk_11 =[%@]",[gbl_attrStrWrk_11 string]);
//
//
//                // BUG  
//                // Seems on iOS 8.0 (12A365) NSMutableAttributedString sometimes will not be displayed correctly.
//                // The problem obviously occurs when the range of the attribute does not start at the beginning of the text
//                // (and if there is no other attribute starting at the beginning of the text).
//                // BUG  
//                // 
//                // [text addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:(NSRange){0,text.length}]; // ***FIX ***
//                // 
////                [gbl_attrStrWrk_11 addAttribute: NSBackgroundColorAttributeName value: [UIColor clearColor]
////                                                                            range: NSMakeRange(0, 10)
////                ];
////                [gbl_attrStrWrk_11 addAttribute: NSBackgroundColorAttributeName value:  [UIColor clearColor]
//////                                                                            range: NSMakeRange(0, gbl_attrStrWrk_11.length)
////                                                                            range: (NSRange){0,gbl_attrStrWrk_11.length}   //Fix
////                ];
////                [gbl_attrStrWrk_11 addAttribute: NSBackgroundColorAttributeName value: gbl_color_cGre
//
////                                                                                range: NSMakeRange(10, 10)
////                ];
//
////                [gbl_attrStrWrk_11 addAttribute: NSBackgroundColorAttributeName value: gbl_color_cHed
////                                                                                range: (NSRange){0,gbl_attrStrWrk_11.length}]; // ***FIX ***
//
//
//
//                [gbl_attrStrWrk_11 addAttribute: NSBackgroundColorAttributeName value: gbl_color_cGre
//                                                                                range: NSMakeRange(10, 31)
//                ];
//
//// new approach    did not work
////    NSString *subStr = [mylin substringWithRange:NSMakeRange(10, 31)];
////  NSLog(@"subStr =[%@]",subStr );
////    gbl_attrStrWrk_12 = [[NSMutableAttributedString alloc] initWithString : subStr ];  // myNSString
////    [gbl_attrStrWrk_12 addAttribute: NSBackgroundColorAttributeName value: gbl_color_cGre  // color whole string
////                                                                    range: NSMakeRange(0, [gbl_attrStrWrk_12 length] )
////    ];
//////    [gbl_attrStrWrk_11 replaceCharactersInRange: NSMakeRange(5, [replace length]) withAttributedString:replace];
////    // put colored string in orig
////    [gbl_attrStrWrk_11 replaceCharactersInRange: NSMakeRange(10, 31) withAttributedString: gbl_attrStrWrk_12 ];
////
//
//
//
//NSLog(@"gbl_attrStrWrk_11 =[%@]",[gbl_attrStrWrk_11 string]);
//NSLog(@"gbl_attrStrWrk_11 =[%@]",gbl_attrStrWrk_11);
//
//                UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
//                [UIButton buttonWithType: UIButtonTypeCustom];
//                myInvisibleButton.backgroundColor = [UIColor clearColor];
//
//                dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////                    cell.textLabel.font            = myFont_12;
//                    // cell.textLabel.numberOfLines = 5;
////                    cell.accessoryView             = myInvisibleButton;               // no right arrow on column labels
//                    cell.userInteractionEnabled    = NO;
////                    cell.textLabel.textAlignment   = NSTextAlignmentCenter;
//                    cell.textLabel.textAlignment   = NSTextAlignmentLeft;
//                    cell.textLabel.textColor       = mytextcolor;
//                    cell.textLabel.attributedText  = gbl_attrStrWrk_11;
//                    cell.textLabel.numberOfLines   = 7; 
//                    cell.textLabel.backgroundColor = mybgcolor;
//                    cell.textLabel.font            = myFont_12;
//              });
//
//nbn(23);
//NSLog(@"cell=[%@]",cell);
//                return cell;   //     special case cell      special case       special case       special case      special case   
//            } // here we have +++ 
////<.>
//



        } // howbighdr    end of if (   [mycode isEqualToString: @"howbighdr"]


        if (   [mycode isEqualToString: @"howbigftr"] ) {
            gbl_areInCompatibilityTable = 0;

            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            mybgcolor         = gbl_color_cNeu ;
            gbl_heightCellCOMP = 18;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_14;

        }
        if ( [mycode isEqualToString: @"catlabel"] ) {
            gbl_areInCompatibilityTable = 0;

            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            mybgcolor         = gbl_color_cBgr ;
//            mybgcolor         = gbl_color_cNeu ;
            gbl_heightCellCOMP = 18;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_14;
        }


        if ( [mycode isEqualToString: @"stars"] )  // start stars
        {   // start stars


            gbl_areInCompatibilityTable = 0;

            UIColor *myRedGreenColor;

            // convert num stars to int
            //
            NSInteger n = [mylin integerValue];   // max is 77

  NSLog(@"=n[%ld]",(long)n);

            if (n > 0) {   // put plus signs

                n = (n * 40) / 77; // convert 1 -> 77 to 1 -> 40
//                n = (n * 50) / 77; // convert 1 -> 77 to 1 -> 50
                if (n < 1.0) n = 1;
                gbl_starsNSInteger = n;

  NSLog(@"=n[%ld]",(long)n);

                NSString *myPlusSigns = 
                    [@"" stringByPaddingToLength: n
                                      withString: @"+"
                                 startingAtIndex: 0
                    ]
                ;
                gbl_starsNSString = myPlusSigns;
//                mylin             = myPlusSigns;            
//                mylin = [NSString stringWithFormat:@"    %@", myPlusSigns ];
                mylin = [NSString stringWithFormat:@"%@", myPlusSigns ];
                myRedGreenColor = gbl_color_cGre ;

            } else if (n < 0) {   // put minus signs

                n = (n * -1 * 40) / 77; // convert -1 -> -77 to 1 -> 40
//                n = (n * -1 * 50) / 77; // convert -1 -> -77 to 1 -> 50
                if (n < 1.0) n = 1;
                gbl_starsNSInteger = n;
  NSLog(@"=n[%ld]",(long)n);

                NSString *myMinusSigns = 
                    [@"" stringByPaddingToLength: n
                                      withString: @"-"
                                 startingAtIndex: 0
                    ]
                ;
                gbl_starsNSString = myMinusSigns;
//                mylin             = myPlusSigns;            
//                mylin = [NSString stringWithFormat:@"    %@", myMinusSigns ];
                mylin = [NSString stringWithFormat:@"%@", myMinusSigns ];
                myRedGreenColor = gbl_color_cRed ;
            } else {
                // defaults
                mylin     = @"x";
                myRedGreenColor = gbl_color_cHed ;
            }

            gbl_starsWhiteSpaces = 
                [@"" stringByPaddingToLength: 40 - gbl_starsNSInteger
                                  withString: @" "
                             startingAtIndex: 0
                ]
            ;

  NSLog(@"mylin before print             =[%@]",       mylin);
  NSLog(@"gbl_starsNSInteger             =[%ld]",(long)gbl_starsNSInteger);
  NSLog(@"gbl_starsNSString              =[%@]",       gbl_starsNSString);
  NSLog(@"gbl_starsWhiteSpaces           =[%@]",       gbl_starsWhiteSpaces );



            mytextcolor       = [UIColor blackColor];
            mybgcolor         = gbl_color_cHed;
            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
//            gbl_heightCellCOMP = 18;
//            gbl_heightCellCOMP = 15;  // get pipes to join
//            gbl_heightCellCOMP = 10;  // get pipes to join
//            gbl_heightCellCOMP = 13;  // get pipes to join
//            gbl_heightCellCOMP = 12;  // get pipes to join
            gbl_heightCellCOMP = 11;  // get pipes to join
            myadjust          = NO;
//            myCompFont         = compFont_14;
            myCompFont         = compFont_12;

            // you can simply calculate UILabel width for string size,try this simple code for set UILabel size
            // Single line, no wrapping;

//            // CGSize expectedLabelSize = [mylin sizeWithFont: compFont_14];  // you get width,height in expectedLabelSize; DEPRECATED
//            CGSize expectedLabelSize = [mylin sizeWithAttributes:              // you get width,height in expectedLabelSize;
//                                                                               // expectedLabelSize.width ,expectedLabelSize.height
//                @{ NSFontAttributeName: compFont_14 }
//            ];
//            // Values are fractional -- you should take the ceilf to get equivalent values
//            CGSize adjustedSize = CGSizeMake(ceilf(expectedLabelSize.width), ceilf(expectedLabelSize.height));

//<.>
//@Pedroinpeace You would use boundingRectWithSize:options:attributes:context: instead, passing in CGSizeMake(250.0f, CGFLOAT_MAX) in most cases. – Incyc Dec 18 '13 at 16:07 
//<.>

     
//          CGRect rect0 = CGRectZero;
//          CGRect rect1 = CGRectZero;
//          CGRect rect21 = CGRectZero;

//            // add label for left left margin   -----  about 2 chars----------------------------------------========================
//            //
////            CGRect rect0 = [@"123" boundingRectWithSize: CGSizeMake(300, 10000)
//            CGRect rect0 = [@"+++" boundingRectWithSize: CGSizeMake(300, 10000)
//                                                       options: NSStringDrawingUsesLineFragmentOrigin
//                                                    attributes: @{ NSFontAttributeName: compFont_12 }
//                                                       context: nil
//            ];
//            CGRect lFrame0 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
//                0,
//                0,
////                expectedLabelSize.width + 10.0,
//                ceilf(rect0.size.width),
//                ceilf(rect0.size.height)
//            );
//
//            UILabel* label0 = [[UILabel alloc] initWithFrame: lFrame0];
//            label0.text            = @"  "; // spaces
//            label0.font            = compFont_12;
//            label0.backgroundColor = gbl_color_cBgr;
////            label0.backgroundColor = [UIColor orangeColor];
//            //            label0.layer.borderColor = [UIColor redColor].CGColor;
//            label0.numberOfLines   = 0;
//            label0.textAlignment   = NSTextAlignmentLeft;
//            label0.maskView        = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//tn();tr("leftl wid=");kin( ceilf(rect0.size.width));
//     tr("leftl hei=");kin( ceilf(rect0.size.height));
//
//

//
//            // add label for left margin   ---------------------------------------------------------------========================
//            //
//            //       options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//            //       options: NSStringDrawingUsesDeviceMetrics 
//            CGRect rect1 = [@"4567890" boundingRectWithSize: CGSizeMake(300, 10000)
//                                                    options: NSStringDrawingUsesLineFragmentOrigin
//                                                 attributes: @{ NSFontAttributeName: compFont_12 }
//                                                    context: nil
//            ];
//tn();tr("leftm wid=");kin( ceilf(rect1.size.width));
//     tr("leftm hei=");kin( ceilf(rect1.size.height));
//
//            //  NSLog(@"compFont_12.lineHeight=[%f]",compFont_12.lineHeight);
//            //  NSLog(@"compFont_12.ascender  =[%f]",compFont_12.ascender);
//            //  NSLog(@"compFont_12.descender =[%f]",compFont_12.descender);
//            //  NSLog(@"compFont_12.capHeight =[%f]",compFont_12.capHeight);
//            //  NSLog(@"compFont_12.xHeight   =[%f]",compFont_12.xHeight);
//
//
//            //NSFont *font = [NSFont fontWithName:@"Times New Roman" size:96.0];
//            //The line height of this font, if I would use it in an NSTextView is 111.0.
//            //NSLayoutManager *lm = [[NSLayoutManager alloc] init];
//            //NSLog(@"%f", [lm defaultLineHeightForFont:font]); // this is 111.0
//            //
//                //            NSLayoutManager *lm = [[NSLayoutManager alloc] init];
//                //NSLog(@"layout manager font height=[%f]", [lm defaultLineHeightForFont:  compFont_14 ] );
//
//
//            //            // Values are fractional -- you should take the ceilf to get equivalent values
//            //            CGSize adjustedSize = CGSizeMake(ceilf(expectedLabelSize.width), ceilf(expectedLabelSize.height));
//            //
//
//            CGRect lFrame1 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
//                ceilf(rect0.size.width),   // allow for left left margin width
//                0,
////                expectedLabelSize.width + 10.0,
//                ceilf(rect1.size.width),
//                ceilf(rect1.size.height)
//            );
//
//            UILabel* label1 = [[UILabel alloc] initWithFrame: lFrame1];
////            label1.text            = @"    "; // spaces
////            label1.text            = @"    |"; // spaces
////            label1.text            = @"          "; // spaces
//            label1.text            = @"        "; // spaces
////            label1.text            = @"oiwjefoijf"; // spaces
////            label1.text            = @""; // spaces
//            label1.font            = compFont_12;
////            label1.textColor       = gbl_color_cBgr;
////            label1.backgroundColor = gbl_color_cBgr;
////            label1.backgroundColor = [UIColor cyanColor];
//            label1.backgroundColor = gbl_color_cNeu;
//            label1.numberOfLines   = 0;
//            label1.textAlignment = NSTextAlignmentLeft;
//            label1.maskView                = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//
//            //            // for test, mk label visibile
//            //            label1.layer.borderWidth = 1.0;
//            //            label1.layer.borderColor = [UIColor redColor].CGColor;
//


            // add label for stars ---------------------------------------------------------------------------------------
            //

//old
//            CGRect rect2 = [mylin boundingRectWithSize: CGSizeMake(300, 10000)
////                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
////                                                 options: NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingUsesFontLeading
//                                                 options: NSStringDrawingUsesLineFragmentOrigin
//                                            attributes: @{ NSFontAttributeName: compFont_12 }
//                                               context: nil
//            ];




//<.>
//            CGRect rect2 = [gbl_starsNSString boundingRectWithSize: CGSizeMake(300, 10000)
//                                                           options: NSStringDrawingUsesLineFragmentOrigin
//                                                        attributes: @{ NSFontAttributeName: compFont_12 }
//                                                           context: nil
//            ];
//
//
//            CGRect lFrame2 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
////                0,
////                ceilf(rect1.size.width),
//                30,
//                0,
////                expectedLabelSize.width + 10.0,
////                ceilf(rect2.size.width),
////           widthAvailable = ceilf(self.view.bounds.size.width) - (ceilf(rect1.size.width) + ceilf(rect2.size.width)),
////                ceilf(self.view.bounds.size.width) - ceilf(rect0.size.width) - ceilf(rect1.size.width) - 18.0, // whole width minus left margin
////                ceilf(self.view.bounds.size.width) - ceilf(rect0.size.width) - ceilf(rect1.size.width)       , // whole width minus left margin
//
//                ceilf(rect2.size.width),
//                ceilf(rect2.size.height)
////                ceilf(rect2.size.height) + 10.0 // + 10 = uilabel border width * 2
//            );
////tn();tr("stars wid=");kin( ceilf(rect2.size.width));
////tn();tr("stars wid=");kin( ceilf(self.view.bounds.size.width) - ceilf(rect0.size.width) - ceilf(rect1.size.width) -18.0 );
//tn();tr("stars wid=");kin( ceilf(self.view.bounds.size.width) - ceilf(rect0.size.width) - ceilf(rect1.size.width)       );
//     tr("stars hei=");kin( ceilf(rect2.size.height));
//
//            gbl_heightCellCOMP = ceilf(rect2.size.height);  // set it here - consecutive star lines should touch
////            gbl_heightCellCOMP = gbl_heightCellCOMP + 10; // + 10 = uilabel border width * 2
//
//            UILabel* label2 = [[UILabel alloc] initWithFrame: lFrame2];
//
//            label2.text            = mylin;
//            label2.font            = compFont_12;
//            label2.backgroundColor = myRedGreenColor;
//            label2.numberOfLines   = 0;
//            label2.textAlignment = NSTextAlignmentLeft;
//            label2.maskView                = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//
////            label2.layer.borderWidth = 3.0;
//            label2.layer.borderWidth = 1.0;
////            label2.layer.borderColor = [UIColor redColor].CGColor;
//            label2.layer.borderColor =  myRedGreenColor.CGColor ;
//
//            [label2 sizeToFit];
//
////            [cell.contentView addSubview: label2];
//  NSLog(@"label2.text            =[%@]",label2.text            );
//
//

//
//            // get rect for a line containing max num of stars
//            //
//            NSString *starLineOfMaxSize;
//            starLineOfMaxSize = [@"" stringByPaddingToLength: 40 //  40 is  MAGIC  77 -> 40
//                                                  withString: @"+"
//                                             startingAtIndex: 0 ];
//
//            CGRect rect3 = [starLineOfMaxSize boundingRectWithSize: CGSizeMake(300, 10000)
//                                                           options: NSStringDrawingUsesLineFragmentOrigin
//                                                        attributes: @{ NSFontAttributeName: compFont_12 }
//                                                           context: nil
//            ];
//

//
//            // add white label for after stars ---------------------------------------------------------------------------------
//            //
////            CGRect lFrame21 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
////                //ceilf(rect0.size.width) + ceilf(rect1.size.width) + ceilf(rect2.size.width),   // left marg(2) + siz of stars
////                ceilf(rect1.size.width) + ceilf(rect2.size.width),   // left marg(2) + siz of stars
////                0,
////                ceilf(rect3.size.width) - ceilf(rect2.size.width ), // size of line with max stars - size of line with actual stars 
////                ceilf(rect2.size.height)
////            );
//            CGRect rect21 = [gbl_starsWhiteSpaces boundingRectWithSize: CGSizeMake(300, 10000)
//                                                              options: NSStringDrawingUsesLineFragmentOrigin
//                                                           attributes: @{ NSFontAttributeName: compFont_12 }
//                                                              context: nil
//            ];
//
//            CGRect lFrame21 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
//                 // ceilf(rect0.size.width) +   // allow for left left margin   WHY ??? exclude this, but it works
//                    ceilf(rect1.size.width) +   // and  left margin and 
//                    ceilf(rect2.size.width)     // and  stars width
//         + 30.0
//                ,
//                0,
//                ceilf(rect21.size.width),
//                ceilf(rect21.size.height)
//            );
//
//
//            UILabel* label21 = [[UILabel alloc] initWithFrame: lFrame21];
//            label21.text            = @" ";
//            label21.font            = compFont_12;
//            label21.backgroundColor = [UIColor whiteColor];
//            label21.numberOfLines   = 0;
//            label21.textAlignment   = NSTextAlignmentLeft;
//            label21.maskView        = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//



//
//            // add label for right margin  ---------------------------------------------------------------------
//            // the x  argument offset is left marg + max size of 77 chars
//            //
//            CGFloat fudgeAddonRightMargin = 5.0f;
//
//            CGRect lFrame3 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
////                ceilf(rect1.size.width) + ceilf(rect2.size.width),
////                ceilf(rect0.size.width) + ceilf(rect1.size.width) + ceilf(rect3.size.width),   // left marg(2) + max siz star line
////                ceilf(rect1.size.width) + ceilf(rect3.size.width),   // left marg(2) + max siz star line
//                 // ceilf(rect0.size.width) +   // allow for left left margin   WHY ??? exclude this, but it works
//            
//             // ceilf(rect0.size.width) +   // allow for left left margin   WHY ??? exclude this, but it works
//                ceilf(rect1.size.width) +
//                ceilf(rect2.size.width) + ceilf(rect21.size.width),
//                0,
////                ceilf(self.view.bounds.size.width) - (  ceilf(rect0.size.width) + ceilf(rect1.size.width) + ceilf(rect2.size.width)  ),
////                ceilf(self.view.bounds.size.width) - (  ceilf(rect1.size.width) + ceilf(rect2.size.width)  ),
////                ceilf(self.view.bounds.size.width) -
////                    (  ceilf(rect1.size.width) + ceilf(rect3.size.width) + ceilf(rect0.size.width )  ) 
////                    +  fudgeAddonRightMargin ,
//                ceilf(self.view.bounds.size.width) -
//                    (  ceilf(rect0.size.width) +
//                       ceilf(rect1.size.width) +
//                       ceilf(rect2.size.width) +
//                       ceilf(rect21.size.width ) 
//                    ) 
////                +  fudgeAddonRightMargin
//                ,
//                ceilf(rect2.size.height)
//            );
////tn();tr("ritem wid=");kin( ceilf(rect2.size.width));
//     tr("ritem hei=");kin( ceilf(rect2.size.height));
//
//            UILabel* label3 = [[UILabel alloc] initWithFrame: lFrame3];
//
//
////            label3.text            = @"1234567890|234";  // get 2...
////            label3.text            = @"1234567|";  // get
////            label3.text            = rStringShorter;
////            label3.text            = @"|";  // get
//            label3.text            = @" ";  // get
//            label3.font            = compFont_12;
////            label3.backgroundColor = gbl_color_cBgr;
//            label3.backgroundColor = gbl_color_cNeu;
////            label3.backgroundColor = [UIColor blueColor];
//            label3.numberOfLines   = 0;
//            label3.textAlignment = NSTextAlignmentLeft;
//            label3.maskView                = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//
//


//
//            // add label for right right margin  ===========  to "fill" the line     (avoid bleeding)  -----------------=================
//            //
//            CGFloat widthRightMargin;
//            widthRightMargin = (
//                     ceilf(self.view.bounds.size.width) - (  ceilf(rect1.size.width) + ceilf(rect3.size.width) + ceilf(rect0.size.width )  ) 
//                    +  fudgeAddonRightMargin
//            );
//
//            CGRect lFrame4 = CGRectMake(  // arg 1=x 2=y 3=width 4=height
//                ceilf(rect0.size.width) + ceilf(rect1.size.width) + ceilf(rect3.size.width)     // left marg(2) + max siz star line + right marg
//                    + widthRightMargin 
//                ,
//                0.0,
//                4.0,
////                ceilf(self.view.bounds.size.width) - (  ceilf(rect1.size.width) + ceilf(rect3.size.width) + ceilf(rect0.size.width )  ) 
////                    +  fudgeAddonRightMargin ,
//
//
//                ceilf(rect2.size.height)
//            );
//            UILabel* label4 = [[UILabel alloc] initWithFrame: lFrame4];
//            label4.text            = @" ";
//            label4.font            = compFont_12;
////            label4.backgroundColor = gbl_color_cBgr;
//            label4.backgroundColor = [UIColor purpleColor];
//            label4.numberOfLines   = 0;
//            label4.textAlignment   = NSTextAlignmentLeft;
//            label4.maskView        = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
//
//



//  NSLog(@"width left left          =[%f]", ceilf(rect0.size.width));
//  NSLog(@"width left margin        =[%f]", ceilf(rect1.size.width));
//  NSLog(@"width stars only         =[%f]", ceilf(rect2.size.width));
//  NSLog(@"width white space        =[%f]", ceilf(rect21.size.width));
////  NSLog(@"widthRightMargin         =[%f]",widthRightMargin);
//  NSLog(@"total                    =[%f]",
//             ceilf(rect0.size.width) +
//             ceilf(rect1.size.width) +
//             ceilf(rect3.size.width) );
//  NSLog(@"starLineOfMaxSize width  =[%f]", ceilf(rect3.size.width));
////widthRightMargin);
//  NSLog(@"   screen width          =[%f]",ceilf(self.view.bounds.size.width) );
//

        gbltmpstr = mylin;  // add 5 leading spaces
//        mylin = [NSString stringWithFormat:@"     |%@%@|",  
//        mylin = [NSString stringWithFormat:@"     %@%@",  
        mylin = [NSString stringWithFormat:@"     %@%@|",  
            gbltmpstr,
            [@"" stringByPaddingToLength: 40 - [gbltmpstr length]  withString: @" " startingAtIndex: 0]
        ];



        dispatch_async(dispatch_get_main_queue(), ^{            // <=== comp  stars
// old
////            cell.textLabel.text                      = mylin; 
////            cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
////            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            cell.textLabel.textAlignment             = myalign;
//
//            cell.userInteractionEnabled              = NO;
//
//            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
////            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
//
////            cell.accessoryView                       = myDisclosureIndicatorLabel;
////            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
//            cell.accessoryType                       = UITableViewCellAccessoryNone;
//
//            cell.textLabel.numberOfLines             = mynumlines; 
//            cell.textLabel.textColor                 = mytextcolor;
//            cell.textLabel.font                      = compFont_12;
////            cell.textLabel.adjustsFontSizeToFitWidth = YES;
//            cell.textLabel.backgroundColor           = mybgcolor;
////                cell.contentView.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
//

// new
//            [cell.contentView addSubview: label0];
//            [cell.contentView addSubview: label1];
//            [cell.contentView addSubview: label2];
//            [cell.contentView addSubview: label21];  // white space after stars
//            [cell.contentView addSubview: label3];

            cell.textLabel.text                      = mylin; 
//            cell.textLabel.text                      = nil;   // this prevents  text bleed
//            cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
            cell.textLabel.textAlignment             = myalign;
            cell.userInteractionEnabled              = NO;
//            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
            cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
            cell.accessoryType                       = UITableViewCellAccessoryNone;
//            cell.textLabel.numberOfLines             = 1; 
            cell.textLabel.numberOfLines             = 0; 
            cell.textLabel.textColor                 = mytextcolor;
            cell.textLabel.font                      = compFont_12;
            cell.textLabel.adjustsFontSizeToFitWidth = NO;
//            cell.textLabel.backgroundColor           = mybgcolor;
            cell.textLabel.backgroundColor           = myRedGreenColor;
//            cell.textLabel.attributedText            = myAttrString;  // order matters- pipes DO NOT appear if this line is here
            cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
            cell.backgroundView          = nil ;
        });
bn(802);
        return cell;


        }  // end of stars




        // example para lines
        //
        // lin=[howbigftr| Good indicators are a full line of +++ ]__
        // lin=[howbigftr| and double the +++ compared to  --- ]__
        // lin=[fill|after howbigftr]__
        // lin=[fill|filler after how big]__
        // lin=[fill|filler before paras]__
        // lin=[fill|before para]__
        // lin=[para|  There is a very good indication between ]__
        // lin=[para|  ~Olivia's sun and Mother Lastna's moon  ]__
        // lin=[para|  which is an excellent indicator of      ]__
        // lin=[para|  compatibility.                          ]__
        // lin=[redgreenline|13
        // ]__
        // lin=[fill|before para]__
        // lin=[para|  You could have a psychic link between   ]__
        // lin=[para|  you. Mother Lastna can bring creative   ]__
        // lin=[para|  imagination to ~Olivia.                 ]__
        // lin=[redgreenline|22
        // ]__
        //
        // lin=[fill|before goodrelationship]__
        //
        if ( [mycode isEqualToString: @"para"] ) {
            gbl_areInCompatibilityTable = 0;
            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
            gbl_heightCellCOMP = 18;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
//            myCompFont         = compFont_16;
            myCompFont         = compFont_14;

        } // end of "para|"


        // lin=[fill|before goodrelationship]__
        // lin=[fill|in goodrelationship at beg]__
        // lin=[goodrelationship|details in cocoa]__
        // lin=[fill|in goodrelationship at end]__
        // lin=[fill|before produced by]__
        // lin=[prod|produced by iPhone app Me and my BFFs]__
        // lin=[fill|before entertainment]__
        // lin=[purp|This report is for entertainment purposes only.]__
        //
        // _(end of mamb_report_just_2_people())__
        //
//<.>
//<.>
//        if ( [mycode isEqualToString: @"will"] ) {
//            myalign           = NSTextAlignmentLeft;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cHed ;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
//            myPerFont         = perFont_16;
//        }
//<.>
//<.>
//
        if ( [mycode isEqualToString: @"goodrelationship"] )
        {  // the text of this is in here, not in input

            gbl_areInCompatibilityTable = 0;

  NSLog(@" if ( [mycode isEqualToString: goodrelationship] )   // the text of this is in here, not in input ");

            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
//            myadjust          = YES;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_12;
//            gbl_heightCellCOMP = 18;
//            gbl_heightCellCOMP = 12;
            gbl_heightCellCOMP = 15;
        }

//            myalign           = NSTextAlignmentLeft;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cHed ;
//            gbl_heightCellCOMP = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
//            myCompFont         = compFont_12;
//
//                                                                         // ARE IN   new compatibility TBLRPT  report
//
//            // NOTE: this is copied from per
//
//
//            NSMutableAttributedString *myAttrString;    // for cell text
//            NSString                  *myStringNoAttr;  // for work string
//            NSString                  *myStringNoAttr2;  // for work string
//
////            myAttrString   = [[NSMutableAttributedString alloc] initWithString:  @"                             \n|   a GOOD RELATIONSHIP     |\n|   usually has 2 things    |\n|1. compatibility potential |\n|2. both sides show positive|\n|   personality traits      |\n                             "
////            ];
////            myStringNoAttr = [myAttrString  string];
////  NSLog(@"myStringNoAttr =[%@]",myStringNoAttr );
////
//            // find the pipes and make them invisible
////            // note: search myStringNoAttr, but make changes in myAttringString
////            //
////            // Setup what you're searching and what you want to find
////            NSString *toFind = @"|";
////            //
////            // Initialise the searching range to the whole string
////            NSRange searchRange = NSMakeRange(0, [myStringNoAttr length]);
////            do {
////                // Search for next occurrence
////                NSRange searchReturnRange = [myStringNoAttr  rangeOfString: toFind  options: 0  range: searchRange];
////                if (searchReturnRange.location != NSNotFound) {
////                    // If found, searchReturnRange contains the range of the current iteration
////
////                    [ myAttrString  addAttribute: NSForegroundColorAttributeName
////                                           value: gbl_color_cHed
////                                           range: NSMakeRange(searchReturnRange.location, 1)
////                    ];
////
////                    // Reset search range for next attempt to start after the current found range
////                    searchRange.location = searchReturnRange.location + searchReturnRange.length;
////                    searchRange.length = [myAttrString length] - searchRange.location;
////
////                } else {
////                    // If we didn't find it, we have no more occurrences
////                    break;
////                }
////            } while (1);
////
//
//            // find the pipes and make them invisible
//            myStringNoAttr2 = [myStringNoAttr stringByReplacingOccurrencesOfString: @"|"  withString: @" "];
//  NSLog(@"myStringNoAttr aftg =[%@]",myStringNoAttr );
//
//            mylin = myStringNoAttr;
//
//            UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//            [UIButton buttonWithType: UIButtonTypeCustom];
//            myInvisibleButton.backgroundColor = [UIColor clearColor];
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // comp <===  good relationship
////                cell.textLabel.attributedText            = myAttrString;
//                cell.textLabel.text                      = myStringNoAttr2;
//                cell.textLabel.textAlignment             = NSTextAlignmentCenter;
//                cell.userInteractionEnabled              = NO;
//                //cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
//                cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
//                cell.accessoryType                       = UITableViewCellAccessoryNone;
//                cell.textLabel.numberOfLines             = 5; 
//                // cell.textLabel.numberOfLines = 5;
////                cell.textLabel.numberOfLines   = 7; 
//                cell.textLabel.textColor                 = mytextcolor;
//                cell.textLabel.font                      = compFont_12;
//                cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
//                cell.textLabel.backgroundColor           = gbl_color_cHed;
//
//            });
//        return cell;   //     special case cell      special case       special case       special case      special case   
//


        if ( [mycode isEqualToString: @"prod"] ) {
            gbl_areInCompatibilityTable = 0;
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
//            mybgcolor         = [UIColor yellowColor];
//            gbl_heightCellCOMP = 16;
            gbl_heightCellCOMP = 18;
//            myadjust          = YES;
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_12;
        }
        if ( [mycode isEqualToString: @"purp"] ) {
            gbl_areInCompatibilityTable = 0;
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cBgr ;
//            mybgcolor         = [UIColor lightGrayColor];
//            gbl_heightCellCOMP = 16;
            gbl_heightCellCOMP = 18;
//            myadjust          = YES;
            myadjust          = NO;
            mytextcolor       = [UIColor redColor];

//            if (self.view.bounds.size.height  <= 320 ) myCompFont = compFont_10b;
//            else                                       myCompFont = compFont_11b;
            myCompFont = compFont_11b;
        }


        dispatch_async(dispatch_get_main_queue(), ^{            // <===  comp fall thru
            cell.textLabel.text                      = mylin;   // --------------------------------------------------
//            cell.textLabel.adjustsFontSizeToFitWidth = myadjust;
//            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textAlignment             = myalign;
            cell.userInteractionEnabled              = NO;
//            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
                cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
            cell.accessoryType                       = UITableViewCellAccessoryNone;
            cell.textLabel.numberOfLines             = 1; 
            cell.textLabel.textColor                 = mytextcolor;
            cell.textLabel.font                      = myCompFont;
            cell.textLabel.adjustsFontSizeToFitWidth = NO;
            cell.textLabel.backgroundColor           = mybgcolor;
//            cell.textLabel.attributedText            = nil;  // order matters- pipes DO NOT appear if this line is here
            cell.imageView.image         = nil;  // MUST be here to avoid old images being put in  on cell  re-draw
            cell.backgroundView          = nil ;
        });

//bn(602);
        return cell;

    }  // end of new compatibility TBLRPT  report
bn(603);

    // END of    new compatibility TBLRPT  report   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$





//    UIView *gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [cell frame].size.width, [cell frame].size.height)];
//    //[cellBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellBgView.png"]]];
//    //[gbl_myCellBgView setBackgroundColor:  gbl_color_cBGforSelected ];
//    //[gbl_myCellBgView setBackgroundColor:  [UIColor lightTextColor] ];
//    [gbl_myCellBgView setBackgroundColor:  [UIColor whiteColor] ];
//


//    gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [cell frame].size.width -20, [cell frame].size.height)];
//    gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, cell.frame.size.width -20, cell.frame.size.height)];

//    NSInteger myCellHighlightWidth = [cell frame].size.width -20; 
//kin((long)myCellHighlightWidth);
//    gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, myCellHighlightWidth, [cell frame].size.height)];

    cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)


    // get the Background Color for this cell
    //
    do {

        gbl_thisCellBackGroundColorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cHed"] )  gbl_thisCellBackGroundColor = gbl_color_cHed;
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cGr2"] )  gbl_thisCellBackGroundColor = gbl_color_cGr2;
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cGre"] )  gbl_thisCellBackGroundColor = gbl_color_cGre;
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cNeu"] )  gbl_thisCellBackGroundColor = gbl_color_cNeu;
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cRed"] )  gbl_thisCellBackGroundColor = gbl_color_cRed;
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cRe2"] )  gbl_thisCellBackGroundColor = gbl_color_cRe2;
        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cBgr"] )  gbl_thisCellBackGroundColor = gbl_color_cBgr;
    } while (FALSE);


//
//    // keeps highlighted row highlighted (see above gbl_scrollViewIsDragging  )
//    if( gbl_scrollViewIsDragging && [[tableView indexPathForSelectedRow] isEqual:indexPath]) {
//        [cell setHighlighted:YES animated:NO];
//    }
//


// silly
//    if (cell.selected) { // Maintain selected state
//        [self.tableView selectRowAtIndexPath: indexPath   // puts highlight on remembered row
//                                    animated: YES
//                              scrollPosition: UITableViewScrollPositionNone];
//    }
//    else {              // Maintain deselected state
//        [self.tableView deselectRowAtIndexPath: indexPath
//                                      animated: NO];
//    }
//




// ALL of THIS   is for  GRPONE and GRPALL (approx 650 lines)
//
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]  // grpone  My Best Match in Group ... grpone
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ]  // grpone  My Best Match in Group ... grpone
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ] // grpall  Best Match in Group ...
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ] // grpall  Best Match in Group ... 
    ) { // ALL of THIS   is for  GRPONE and GRPALL (approx 650 lines)


        // Configure the cell...

        //cell.textLabel.text = @"test TBLRPT1   cell text";

        // invisible button for taking away the disclosure indicator
        //
//    UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [UIButton buttonWithType: UIButtonTypeCustom];
        myInvisibleButton.backgroundColor = [UIColor clearColor];


//tn();tr("row row row row row row row = ");NSLog(@"indexPath.row=%ld", indexPath.row);

//tn();kin(group_report_output_idx);


        // Grab cell data,  but only if indexPath.row is still in array (3 extra footer cells)
        //
        if (indexPath.row <= group_report_output_idx) {

            myidx = (int)indexPath.row;


            strcpy(my_tmp_str, group_report_output_PSVs  +  myidx * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  

//ksn(my_tmp_str);
            myCellContentsPSV     = [NSString stringWithUTF8String: my_tmp_str];  // convert c string to NSString
//NSLog(@"myCellContentsPSV =[%@]", myCellContentsPSV );
            mySeparators          = [NSCharacterSet characterSetWithCharactersInString:@"|"];
            tmpArray              = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];
//        gbl_cellBGcolorName   = tmpArray[0];
            myOriginalCellText    = tmpArray[1];
            myOriginalCellTextLen = myOriginalCellText.length;

//NSLog(@"myOriginalCellText    =%@",myOriginalCellText    );
//NSLog(@"myOriginalCellTextLen =%ld",myOriginalCellTextLen );


            // get the number of chars taken up by rank numbers on left (  gbl_numPairsRanked )
            //
//kin((int)gbl_numPairsRanked);
            if       (gbl_numPairsRanked  <      10) numCharsForRankNumsOnLeft =    1;
            else  if (gbl_numPairsRanked  <     100) numCharsForRankNumsOnLeft =    2;
            else  if (gbl_numPairsRanked  <    1000) numCharsForRankNumsOnLeft =    3;
            else  if (gbl_numPairsRanked  <   10000) numCharsForRankNumsOnLeft =    4;
            else  if (gbl_numPairsRanked  <  100000) numCharsForRankNumsOnLeft =    5;  // max ~ 30,000
//kin((int)numCharsForRankNumsOnLeft );

        }  // end of Grab cell data,  but only if indexPath.row is still in array (3 extra footer cells)



        if (indexPath.row ==  group_report_output_idx + 1)    // THIS   is for  GRPONE and GRPALL (approx 650 lines)
        {  // 1 of 3 FOOTER CELLS       goodrelationship
//trn("// 1 of 3 FOOTER CELLS");

                // ORIG cell.textLabel.text          = @"                                         \n        a GOOD RELATIONSHIP              \n        usually has 2 things             \n     1. compatibility potential          \n     2. both sides show positive         \n        personality traits               \n                                         ";

tn();nbn(333);
            NSMutableAttributedString *myAttrString;    // for cell text
            NSString                  *myStringNoAttr;  // for work string

            // NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"firstsecondthird"];
            // [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,5)];
            // [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,6)];
            // [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11,5)];

            // You need to set the NSForegroundColorAttributeName property as well.
            // 
            // Here's a complete list - in the Constants section:
            // 
            // NSString *const NSFontAttributeName;
            // NSString *const NSParagraphStyleAttributeName;
            // NSString *const NSForegroundColorAttributeName;
            // NSString *const NSBackgroundColorAttributeName;
            // NSString *const NSLigatureAttributeName;
            // NSString *const NSKernAttributeName;
            // NSString *const NSStrikethroughStyleAttributeName;
            // NSString *const NSUnderlineStyleAttributeName;
            // NSString *const NSStrokeColorAttributeName;
            // NSString *const NSStrokeWidthAttributeName;
            // NSString *const NSShadowAttributeName;
            // NSString *const NSVerticalGlyphFormAttributeName;
            //

            // "                             \
            // n    a GOOD RELATIONSHIP      \
            // n    usually has 2 things     \
            // n 1. compatibility potential  \
            // n|2. both sides show positive|\
            // n|   personality traits      |\
            // n                             ";
            //
            myAttrString   = [[NSMutableAttributedString alloc] initWithString:  @"                             \n|   a GOOD RELATIONSHIP     |\n|   usually has 2 things    |\n|1. compatibility potential |\n|2. both sides show positive|\n|   personality traits      |\n                             "
            ];
            myStringNoAttr = [myAttrString  string];

            // find the pipes and make them invisible
            // note: search myStringNoAttr, but make changes in myAttringString
            //
            ; 
//            NSMutableAttributedString *myReplacementString = [
//                [ NSAttributedString alloc] initWithString: @"|"
//                                                attributes: @{ NSBackgroundColorAttributeName: gbl_color_cBgr }
//            ];
//            [myAttrString stringByReplacingOccurrencesOfString: @"|"  withString: targetString];

            // Setup what you're searching and what you want to find
            NSString *toFind = @"|";

            // Initialise the searching range to the whole string
            NSRange searchRange = NSMakeRange(0, [myStringNoAttr length]);
//  NSLog(@"searchRange.location %lu%d](unsigned long)",searchRange.location );
//  NSLog(@"searchRange.length   %lu%d](unsigned long)",searchRange.length   );
            do {
                // Search for next occurrence
                NSRange searchReturnRange = [myStringNoAttr  rangeOfString: toFind  options: 0  range: searchRange];
//  NSLog(@"searchReturnRange.location %lu%d](unsigned long)",searchReturnRange.location );
//  NSLog(@"searchReturnRange.length   %lu%d](unsigned long)",searchReturnRange.length   );
                if (searchReturnRange.location != NSNotFound) {
                    // If found, searchReturnRange contains the range of the current iteration

                    // NOW DO SOMETHING WITH THE STRING / RANGE
//  for test          [ myAttrString  addAttribute: NSForegroundColorAttributeName
//                                           value: [UIColor redColor]
//                                           range: NSMakeRange(searchReturnRange.location, 1)
//                    ];
//
                    [ myAttrString  addAttribute: NSForegroundColorAttributeName
                                           value: gbl_color_cHed
                                           range: NSMakeRange(searchReturnRange.location, 1)
                    ];

                    // Reset search range for next attempt to start after the current found range
                    searchRange.location = searchReturnRange.location + searchReturnRange.length;
                    searchRange.length = [myAttrString length] - searchRange.location;
//  NSLog(@"searchRange.location2%lu%d](unsigned long)",searchRange.location );
//  NSLog(@"searchRange.length  2%lu%d](unsigned long)",searchRange.length   );
                } else {
                    // If we didn't find it, we have no more occurrences
                    break;
                }
            } while (1);



            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.font          = myFont_12;
//                cell.textLabel.numberOfLines = 5;
                cell.accessoryView           = myInvisibleButton;               // no right arrow on column labels
                cell.userInteractionEnabled  = NO;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;

//  ORIG          cell.textLabel.text          = @"                                         \n        a GOOD RELATIONSHIP              \n        usually has 2 things             \n     1. compatibility potential          \n     2. both sides show positive         \n        personality traits               \n                                         ";
                cell.textLabel.attributedText = myAttrString;

//                cell.textLabel.numberOfLines = 7; 
                cell.textLabel.numberOfLines = 1; 
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x

            });
            return cell;
        }  // end of 1 of 3 FOOTER CELLS


        else if (indexPath.row ==  group_report_output_idx + 2)
        {  // 2 of 3 FOOTER CELLS
//trn("// 2 of 3 FOOTER CELLS");

            //        myNewCellText                = @"     Produced by iPhone App Me and my BFFs   ";
            NSAttributedString *myNewCellAttributedText1 = [
                [NSAttributedString alloc] initWithString: @"        Produced by iPhone App Me and my BFFs   "
                                               attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f] }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.font           = myFont_16;
                cell.textLabel.numberOfLines  = 1; 
                cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
                cell.userInteractionEnabled   = NO;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.attributedText = myNewCellAttributedText1;
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
            });

            return cell;
        }  // end of 2 of 3 FOOTER CELLS

        else if (indexPath.row ==  group_report_output_idx + 3)
        {  // 3 of 3 FOOTER CELLS
//trn("// 3 of 3 FOOTER CELLS");

            // make same font bold
            //
            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
            UIFont *currentFont       = cell.textLabel.font;
            UIFont *currentFontBolded = [myappDelegate boldFontWithFont: (UIFont *) currentFont];
//  NSLog(@"currentFontBolded =%@",currentFontBolded );

            //myNewCellText                = @"    This report is for entertainment purposes only.  ";
            NSAttributedString *myNewCellAttributedText2 = [
                [NSAttributedString alloc] initWithString:  @"       This report is for entertainment purposes only.  "
                                               attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
                                                               NSForegroundColorAttributeName: [UIColor redColor]               }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.font           = currentFontBolded;
                cell.textLabel.numberOfLines  = 1; 
                cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
                cell.userInteractionEnabled   = NO;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.attributedText = myNewCellAttributedText2;
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
            });

            return cell;

        }  // end of 3 of 3 FOOTER CELLS


        else if (indexPath.row == 0) {  // COLUMN HEADERS   SPACER   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//tn();trn("in row 0  SPACER");
            // this is spacer row between 'for ... \n in Group ...'  and col headers
            //

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.accessoryType           = UITableViewCellAccessoryNone;
                cell.accessoryView           = myInvisibleButton;            // no right arrow on benchmark label
                cell.textLabel.numberOfLines = 1; 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.font          = myFont_16;
                cell.textLabel.text          = @" ";  // ------------------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled  = NO;                           // no selection highlighting
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
            });

            return cell;

        } // end of spacer row before col headers

        else if (indexPath.row == 1)
        {   // first header line    hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr
trn("in row = 1   1st hdr line");

            //  BIG JOB   get number of fill chars after "Compatibility" and before "Potential"
            //
            NSInteger numCharsPairHdr  = @"Pair of      ".length;
                      numCharsPairHdr  = @"Group Members".length;
                      numCharsPairHdr  = @"Person and   ".length;
                      numCharsPairHdr  = @"Group Member ".length;
            NSInteger numCharsScoreHdr = @"Compatibility".length;
                      numCharsScoreHdr = @"    Potential".length;


            // CASE 1 of 2 
            //   num pairs <= 99
            //   original line <= 45  [  1   ~Brother  ~Sister2   90            ]               size=41  SHORT
            //
            //   line up 'C' in Compatibility with first digit in score
            //
            //            [     Pair of              Compatibility]
            //            [     Group Members            Potential]
            //
            //            [                          90  Great    ]
            //            [ 1   ~Brother  ~Sister2   90           ]  <--  kingpin (first person line)
            //            [                          75  Very Good]
            //            [12   ~Brother  ~Sister1   65           ]
            //
            // CASE 2 of 2
            //   num pairs <= 9
            //   original line  > 45   [ 1   ~Aiden 89012345  Sister1 Lastnam   92            ] size=54  LONG
            //
            //   benchmark labels wrap to the inside
            //
            //   line up 'y' in Compatibility with second digit in score
            //
            //            [     Pair of                 Compatibility]
            //            [     Group Members               Potential]
            //
            //            [ 1   ~Aiden 89012345  Sister1 Lastnam   92] <--  kingpin
            //            [                                 Great  90]
            //            [                             Very Good  75]
            //            [12   ~Brother         ~Sister1          65]
            //

  NSLog(@"LL myOriginalCellText =[%@]",myOriginalCellText );

            // grab first line with a person   THAT IS-
            // grab first line not a benchmark label
            //


                for (int myidx = 3; myidx <= 9; myidx++) {  // now both grpone and grpall have   line with "top space" - legacy + hdr1 + hdr2 --- start with idx 3

//kin(myidx);
                    strcpy(my_tmp_str, group_report_output_PSVs  +  myidx * (int)gbl_maxLenRptLinePSV);  
//ks(my_tmp_str);

                    if (strstr(my_tmp_str, "90  Great")     != NULL 
                    ||  strstr(my_tmp_str, "75  Very Good") != NULL
                    ||  strstr(my_tmp_str, "50  Average")   != NULL 
                    ||  strstr(my_tmp_str, "25  Not Good")  != NULL 
                    ||  strstr(my_tmp_str, "10  OMG")       != NULL ) {
                        continue;
                    } else {
                        break;   // grab 1st string not a benchmark label
                    }
                }
                // end of grab first line with a person/addobj
            

ksn(my_tmp_str);
                NSString *myFirstData =  [NSString stringWithUTF8String: my_tmp_str];  // convert c string to NSString
                NSArray  *tmpArray2   = [myFirstData componentsSeparatedByCharactersInSet: mySeparators];  // delim= '|'

//  NSLog(@"myFirstData =%@",myFirstData );
//  NSLog(@"tmpArray2   =%@",tmpArray2   );
                NSString *myFirstPersonLine = tmpArray2[1];
  NSLog(@"myFirstPersonLine =%@",myFirstPersonLine );

                const char *tmp_c_CONST;                                                  // NSString object to C str
                char tmp_c_first_person_buff[128];                                        // NSString object to C str
                tmp_c_CONST = [myFirstPersonLine cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
                strcpy(tmp_c_first_person_buff, tmp_c_CONST);                             // NSString object to C str  because of const
//tn();ksn(tmp_c_first_person_buff);
            //
            // end of  grab first line with a person


            // for the rank number lines below, determine the number of left spaces to remove- gbl_numLeadingSpacesToRemove 
            // and still keep all the rank number
            //
            int mycharnum;
            mycharnum = 0; // one-based
            for (int mm=0; mm <= (int)strlen(tmp_c_first_person_buff) -1; mm++) {
                mycharnum = mycharnum + 1;
                if (tmp_c_first_person_buff[mm] == '1') break;  // find index of first '1'
            }
            gbl_numLeadingSpacesToRemove = mycharnum - numCharsForRankNumsOnLeft; // e.g. "00001" 1on=5 rank=2 remove=3  // for LONG
//kin((int)gbl_numLeadingSpacesToRemove );



//kin((int)myOriginalCellTextLen);

//  NSLog(@"gbl_numLeadingSpacesToRemove=%@",gbl_numLeadingSpacesToRemove);
//kin((int)gbl_numLeadingSpacesToRemove);

            if (myOriginalCellTextLen <= 45) 
            { // short LINE  FIRST HEADER LINE  CALC
                // - gbl_numLeadingSpacesToRemove   for spaces needing to be removed  
                // - 1                              for one space on right end
                gbl_myCellAdjustedTextLen = myOriginalCellTextLen -  1 - gbl_numLeadingSpacesToRemove;
            } // end of short LINE  FIRST HEADER LINE  CALC
            else {
                // - gbl_numLeadingSpacesToRemove   for spaces needing to be removed  
                // - 12                             for "  Very Good " wrapped to inside
                gbl_myCellAdjustedTextLen = myOriginalCellTextLen - 12 - gbl_numLeadingSpacesToRemove;
            }
//kin((int)gbl_myCellAdjustedTextLen);


            numFillSpacesInColHeaders =
                gbl_myCellAdjustedTextLen - numCharsForRankNumsOnLeft - 3 - numCharsPairHdr - numCharsScoreHdr; // 3 spaces

//kin((int)numFillSpacesInColHeaders );

            gbl_myCharsForRankNumsOnLeft = [@"" stringByPaddingToLength: numCharsForRankNumsOnLeft + 3 // 3 for spaces after ranknum
                                                             withString: @" "
//                                                             withString: @"L"
                                                        startingAtIndex: 0 ];
            gbl_myFillSpacesInColHeaders = [@"" stringByPaddingToLength: numFillSpacesInColHeaders 
                                                             withString: @" "
//                                                             withString: @"F"
                                                        startingAtIndex: 0 ];
//        NSLog(@"gbl_myCharsForRankNumsOnLeft =[%@]",gbl_myCharsForRankNumsOnLeft );
//        NSLog(@"gbl_myFillSpacesInColHeaders =[%@]",gbl_myFillSpacesInColHeaders );



            // for grpone, change column headers if kingpin ( compare_everyone_with ) is not in the group
            //
//tn();kin((int)gbl_numPairsRanked);
      NSLog(@"gbl_numPairsRanked =%ld",(long)gbl_numPairsRanked );
      NSLog(@"gbl_grp_CSVs.count =%ld",(unsigned long)gbl_grp_CSVs.count );
      NSLog(@"gbl_numPeopleInCurrentGroup=%ld",(long)gbl_numPeopleInCurrentGroup);
//tn();tr("TWO!!!");kin(gbl_kingpinIsInGroup );

            if (    gbl_numPairsRanked == gbl_numPeopleInCurrentGroup - 1        // kingpin is     in grp
                || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ]   // or Best Match in Group ... grpall
                || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ]   // or Best Match in Group ... grpall
            ) {
                myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",   //  assign  assign  assign  assign  assign  assign assign 
                    gbl_myCharsForRankNumsOnLeft, @"Pair of      ", gbl_myFillSpacesInColHeaders, @"Compatibility" ];
            }
            if (gbl_numPairsRanked == gbl_numPeopleInCurrentGroup    ) {  // kingpin is not in grp
                myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",   //  assign  assign  assign  assign  assign  assign assign 
                    gbl_myCharsForRankNumsOnLeft, @"Person and   ", gbl_myFillSpacesInColHeaders, @"Compatibility" ];
            }
      NSLog(@"myNewCellText   =%@",myNewCellText   );



//            cell.accessoryType           = UITableViewCellAccessoryNone;  // setting ignored if cell.accessoryView is set (not nil)
//            cell.userInteractionEnabled  = NO;                           // no selection highlighting
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.userInteractionEnabled              = YES;      // method just returns 
                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.font                      = myFont_16;
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.text                      = myNewCellText;  // ------------------------------------------------------------
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
            });
      
//  NSLog(@"HDR#1 cell.userInteractionEnabled  =%d",cell.userInteractionEnabled  );


//trn("  // end of first header line");
            return cell;
        }   // end of first header line


        else if (indexPath.row == 2)
        {  // COLUMN HEADER  second header line  xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//trn("  // 2nd header line");

            // for grpone, change column headers if kingpin ( compare_everyone_with ) is not in the group
            //
            if (    gbl_numPairsRanked == gbl_numPeopleInCurrentGroup - 1        // kingpin is     in grp
                || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ]   // or Best Match in Group ... grpall
                || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ]   // or Best Match in Group ... grpall
            ) {
                myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",
                    gbl_myCharsForRankNumsOnLeft, @"Group Members", gbl_myFillSpacesInColHeaders, @"    Potential"  ];
            }
            if (gbl_numPairsRanked == gbl_numPeopleInCurrentGroup    ) {  //  NO
                myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",
                    gbl_myCharsForRankNumsOnLeft, @"Group Member ", gbl_myFillSpacesInColHeaders, @"    Potential"  ];
            }


            // put info button on Nav Bar
            //        UIButton *myInfoButton =  [UIButton buttonWithType: UIButtonTypeInfoDark] ;
            //            UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
            //            cell.accessoryView                       = myInfoButton;            // no right arrow on benchmark label

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
                cell.userInteractionEnabled              = YES;      // action method just returns 
                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.font                      = myFont_16;
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.text                      = myNewCellText;  // ------------------------------------------------------------
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
            });

//  NSLog(@"HDR#2 cell.userInteractionEnabled  =%d",cell.userInteractionEnabled  );

//trn(" end of // 2nd header line");
            return cell;
        }  // end of  COLUMN HEADER  second header line  xxxxxxxxxxxxxxxxxxxxxxxxxxxxx


        else if (myOriginalCellTextLen <= 45)
        {  // shorter data line
//trn("  // shorter data line");

            // short line, on right end,  remove 1 space  
            //
            NSString *myNewCellTextShort; 
            myNewCellTextShort = [myOriginalCellText substringWithRange:NSMakeRange(0, myOriginalCellTextLen - 1)]; // zero-based
//NSLog(@"myNewCellTextShort A =[%@]",myNewCellTextShort     );

            // short line, on left end, 
            // remove leading spaces which do not constitute part of space for rank number (
            //
            int mylen1 = (int)myNewCellTextShort.length;

            myNewCellText  = [myNewCellTextShort substringWithRange:
                NSMakeRange(gbl_numLeadingSpacesToRemove, mylen1 - gbl_numLeadingSpacesToRemove)]; // zero-based
//NSLog(@"myNewCellTextShort B =[%@]",myNewCellTextShort     );

//trn(" end of  // shorter data line");
        }   // end shorter data line


        else 
        {  //  long line, shorten by putting  benchmark labels on the inside like this:
//trn("  // long data line");

            //  replace these 2:
            // "  7   ~Aiden 89012345  ~Abigail 012345   53            "
            // "                                         90  Great     "
            //  with    these2:
            // "  7   ~Aiden 89012345  ~Abigail 012345   53"
            // "                                 Great   90"
            //

            NSInteger numLeadingSpaces;
            NSString *myLeadingSpaces;

            // 12 = "  Very Good "
            NSString *myNewCellTextTMP = [myOriginalCellText substringWithRange:NSMakeRange(0, myOriginalCellTextLen - 12)]; // zero-based

//NSLog(@"myNewCellTextTMP   3    =[%@]",myNewCellTextTMP   );

//        // remove last 12 chars from all lines  ( like "  Very Good " or all spaces )
//        // remove first 1 chars from all lines (if they have 2 leading spaces)
//        //
//        if ([myOriginalCellText hasPrefix: @"  "]) {
//        }
//        else {
//            myNewCellText  = [myOriginalCellText substringWithRange:NSMakeRange(0, myOriginalCellTextLen - 12 - 1)]; // zero-based
//        }
//

            // remove leading spaces which do not constitute part of space for rank number (
            //
            int mylen = (int)myNewCellTextTMP.length;
            myNewCellText  = [myNewCellTextTMP substringWithRange:
                NSMakeRange(gbl_numLeadingSpacesToRemove, mylen - gbl_numLeadingSpacesToRemove)]; // zero-based
//              NSMakeRange(gbl_numLeadingSpacesToRemove, mylen)]; // zero-based
//NSLog(@"myNewCellText      3B   =[%@]",myNewCellText      );



//      NSLog(@"myNewCellText1 =[%@]",myNewCellText  );




//  NSLog(@"myOriginalCellText 3    =[%@]",myOriginalCellText      );
              if ([myOriginalCellText hasSuffix: @"90  Great     "]) {
      //            numLeadingSpaces = myOriginalCellTextLen - 12 - 14;
//  trn("hey");
//  kin((int)gbl_myCellAdjustedTextLen);
                  numLeadingSpaces = gbl_myCellAdjustedTextLen - @"    Great  90".length ;

//        NSLog(@"numLeadingSpaces =%ld",(long)numLeadingSpaces );
                  myLeadingSpaces = @"";
//        NSLog(@"myLeadingSpaces1=[%@]",myLeadingSpaces );
                  myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                      withString: @" "
                                                 startingAtIndex: 0 ];

//        NSLog(@"myLeadingSpaces2=[%@]",myLeadingSpaces );
                  myNewCellText   = [NSString stringWithFormat:@"%@    Great  90", myLeadingSpaces];
//  NSLog(@"myNewCellText      5    =[%@]",myNewCellText      );
              }
              if ([myOriginalCellText hasSuffix: @"75  Very Good "]) {
                  numLeadingSpaces = gbl_myCellAdjustedTextLen - @"Very Good  75".length ;
                  myLeadingSpaces = @"";
                  myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                      withString: @" "
                                                 startingAtIndex: 0 ];
                  myNewCellText   = [NSString stringWithFormat:@"%@Very Good  75", myLeadingSpaces];
              }
              if ([myOriginalCellText hasSuffix: @"50  Average   "]) {
                  numLeadingSpaces = gbl_myCellAdjustedTextLen - @"  Average  50".length ;
                  myLeadingSpaces = @"";
                  myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                      withString: @" "
                                                 startingAtIndex: 0 ];
                  myNewCellText   = [NSString stringWithFormat:@"%@  Average  50", myLeadingSpaces];
              }
              if ([myOriginalCellText hasSuffix: @"25  Not Good  "]) {
                  numLeadingSpaces = gbl_myCellAdjustedTextLen - @" Not Good  25".length ;
                  myLeadingSpaces = @"";
                  myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                      withString: @" "
                                                 startingAtIndex: 0 ];
                  myNewCellText   = [NSString stringWithFormat:@"%@ Not Good  25", myLeadingSpaces];
              }
              if ([myOriginalCellText hasSuffix: @"10  OMG       "]) {
                  numLeadingSpaces = gbl_myCellAdjustedTextLen - @"      OMG  10".length ;
                  myLeadingSpaces = @"";
                  myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                      withString: @" "
                                                 startingAtIndex: 0 ];
                  myNewCellText   = [NSString stringWithFormat:@"%@      OMG  10", myLeadingSpaces];
              }

//trn(" end // long data line");
        }   // end of long line, shorten by putting  benchmark labels on the inside

        
        // make benchmark lines have invisible right arrow and disable interaction
        //
        int do_setup_for_benchmark_label_cell;
        do_setup_for_benchmark_label_cell = 0;

        if ([myNewCellText rangeOfString: @"90  Great"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Great  90"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else { do_setup_for_benchmark_label_cell = 1; }
        if ([myNewCellText rangeOfString: @"75  Very Good"
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Very Good  75"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else { do_setup_for_benchmark_label_cell = 1; }
        if ([myNewCellText rangeOfString: @"50  Average" 
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Average  50"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else { do_setup_for_benchmark_label_cell = 1; }
        if ([myNewCellText rangeOfString: @"25  Not Good" 
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Not Good  25"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else { do_setup_for_benchmark_label_cell = 1; }
        if ([myNewCellText rangeOfString: @"10  OMG"    
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"OMG  10"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else { do_setup_for_benchmark_label_cell = 1; }



        if (do_setup_for_benchmark_label_cell == 1) {
            //cell.accessoryType  is   IGNORED because accessoryView is set to (non-nil)


            dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled              = NO;                           // no selection highlighting
                cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 


                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.font                      = myFont_16; // for test font fit width
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
//                cell.contentView.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x

            });

        } else {

            // UILabel for the disclosure indicator, ">",  for tappable cells
            //
                NSString *myDisclosureIndicatorBGcolorName; 
                NSString *myDisclosureIndicatorText; 
                UIColor  *colorOfGroupReportArrow; 
                UIFont   *myDisclosureIndicatorFont; 

                myDisclosureIndicatorText = @">"; 
//                myDisclosureIndicatorBGcolorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
//        NSLog(@"myDisclosureIndicatorBGcolorName =%@",myDisclosureIndicatorBGcolorName );
      
                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] ) {
                    colorOfGroupReportArrow   = [UIColor blackColor];                 // deepest red is pretty  dark
                    myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
                } else {
                    colorOfGroupReportArrow   = [UIColor  grayColor];
                    myDisclosureIndicatorFont = [UIFont boldSystemFontOfSize: 16.0f];
                }


                NSAttributedString *myNewCellAttributedText3 = [
                    [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
                                                   attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
                                                                   NSForegroundColorAttributeName: colorOfGroupReportArrow                }
                ];
//                                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize: 16.0f],

                UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
                myDisclosureIndicatorLabel.attributedText = myNewCellAttributedText3;



//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cHed"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cHed;
//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cGr2"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cGr2;
//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cGre"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cGre;
//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cNeu"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cNeu;
//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRed"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cRed;
//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cRe2;
//                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cBgr"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cBgr;
//
                myDisclosureIndicatorLabel.backgroundColor = gbl_thisCellBackGroundColor;  // see above


            //
            // end of  UILabel for the disclosure indicator, ">",  for tappable cells



            dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled              = YES;                  

//            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
//            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.accessoryView                       = myDisclosureIndicatorLabel;
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.font                      = myFont_16; // for test font fit width
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above
//                cell.contentView.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
            });
        }


        // set cell height to 32.0   see method heightForRowAtIndexPath  below


//  NSLog(@"cell=%@",cell);
//int r; r = (int)indexPath.row;
//tn();tr("MOST cell text for row===========================================");kin(r);
//  NSLog(@"myNewCellText=[%@]",myNewCellText);

        return cell;

    } // ALL of THIS   is for  GRPONE and GRPALL (approx 650 lines)
//
// ALL of THIS   is for  GRPONE and GRPALL (approx 650 lines)



// ALL of THIS   is for  MOST and BEST  group reports
//tn();trn("// ALL of THIS   is for  MOST and BEST  group reports");
//
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]  // Most Assertive
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgme"]  // Most Emotional
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmr"]  // Most Restless
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmp"]  // Most Passionate
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmd"]  // Most Down-to-earth
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgby"]  // Best Year
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgbd"]  // Best Day
    ) { //  ALL of THIS   is for  MOST and BEST  group reports

        // Configure the cell...

        //cell.textLabel.text = @"test TBLRPT1   cell text";


        // invisible button for taking away the disclosure indicator
        //
//    UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [UIButton buttonWithType: UIButtonTypeCustom];
        myInvisibleButton.backgroundColor = [UIColor clearColor];


        // Grab cell data,  but only if indexPath.row is still in array (3 extra footer cells)
        //
        if (indexPath.row <= group_report_output_idx) {

            myidx = (int)indexPath.row;


            strcpy(my_tmp_str, group_report_output_PSVs  +  myidx * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  

//ksn(my_tmp_str);
            myCellContentsPSV     = [NSString stringWithUTF8String: my_tmp_str];  // convert c string to NSString
//NSLog(@"myCellContentsPSV =[%@]", myCellContentsPSV );
            mySeparators          = [NSCharacterSet characterSetWithCharactersInString:@"|"];
            tmpArray              = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];
//        gbl_cellBGcolorName   = tmpArray[0];
            myOriginalCellText    = tmpArray[1];
            myOriginalCellTextLen = myOriginalCellText.length;

//NSLog(@"myOriginalCellText    =%@",myOriginalCellText    );
//NSLog(@"myOriginalCellTextLen =%ld",myOriginalCellTextLen );


            // get the number of chars taken up by rank numbers on left (  gbl_numPairsRanked )
            //
//kin((int)gbl_numPairsRanked);
            if       (gbl_numPairsRanked  <      10) numCharsForRankNumsOnLeft =    1;
            else  if (gbl_numPairsRanked  <     100) numCharsForRankNumsOnLeft =    2;
            else  if (gbl_numPairsRanked  <    1000) numCharsForRankNumsOnLeft =    3;
            else  if (gbl_numPairsRanked  <   10000) numCharsForRankNumsOnLeft =    4;
            else  if (gbl_numPairsRanked  <  100000) numCharsForRankNumsOnLeft =    5;  // max ~ 30,000
//kin((int)numCharsForRankNumsOnLeft );

        }  // end of Grab cell data,  but only if indexPath.row is still in array (3 extra footer cells)


        if (indexPath.row ==  group_report_output_idx + 1)
        {  // 1 of 3 FOOTER CELLS
//trn("// 1 of 3 FOOTER CELLS");


        // here we've printed the data lines in tableview, so turn off cell separator lines now   - does not work - does whole tbl
        // [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone]; // remove separator lines between cells from here down
        //[self.tableView setSeparatorColor:[UIColor myColor]];
//        [self.tableView setSeparatorColor: gbl_color_cHed];
//        [self.tableView setSeparatorColor:  [UIColor greenColor] ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.font          = myFont_12;
//                cell.textLabel.numberOfLines = 5;
                cell.accessoryView           = myInvisibleButton;               // no right arrow on column labels
                cell.userInteractionEnabled  = NO;


                if ([gbl_currentMenuPlusReportCode hasPrefix: @"homgm"]  // best day
                ) {
                    NSString *myMostWhat;
                    if      ([gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]) { myMostWhat = @"Assertive"; }
                    else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]) { myMostWhat = @"Emotional"; }
                    else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]) { myMostWhat = @"Restless"; }
                    else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]) { myMostWhat = @"Passionate"; }
                    else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]) { myMostWhat = @"Down-to-earth"; }

//<.>
                    cell.textLabel.text          = [NSString stringWithFormat: @"                                      \n  The score measures \"how much\"\n  of the trait %@\n  each person has.\n                                      ",
                        myMostWhat ];

                    cell.textLabel.numberOfLines = 5; 
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;


                } else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]  // best day
                ) {
                    cell.textLabel.text          = [NSString stringWithFormat: @"                                      \n  The score measures stress levels  \n  on  %@             \n  for each person in the group.    \n                                      ",
                        gbl_lastSelectedDayFormattedForEmail ];

                    cell.textLabel.numberOfLines = 5; 
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;

//"                                          \n
//x The score measures stress levels during  \n
//x the day for each person in the group.    \n\n
//x These are short-term influences lasting  \n
//x just a few hours or a day or two long.   \n
//x                                          \n"
//

//x                                   \n
//x The score measures stress levels  \n
//x on Mon, Jun 19, 2014              \n
//x for each person in the group.     \n\n
//x                                  x"
//



                } else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]  // best year
                ) {
                    cell.textLabel.text          = [NSString stringWithFormat: @"  The score for each person tells   \n  how favorable or how challenging  \n  the year %@ is for that person.   \n",
                        gbl_lastSelectedYear];

                    cell.textLabel.numberOfLines = 7; 
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                }


//"                                          \n
//x The score measures stress levels during  \n

//The score shows how much time the
//person spends in the green zones and 
//the red zones of the calendar year
//graph over the whole year.
//The score gives a general idea of how
//favorable or challenging the year is.
//
//x                                          \n
//x The score estimates how favorable or
//x The score suggests how favorable or
//x The score expresses how favorable or
//x The score shows how favorable or
//x The score affirms how favorable or how
//
//x The score reflects how long the person   \n
//x spends in the green zones and red zones  \n
//x in their graph for calendar year 2015.   \n
//x The score tells how favorable or how
//x challenging the year 2015 is overall.     
//

            });

            return cell;
        }  // end of 1 of 3 FOOTER CELLS


        else if (indexPath.row ==  group_report_output_idx + 2)
        {  // 2 of 3 FOOTER CELLS
//trn("// 2 of 3 FOOTER CELLS");

            //        myNewCellText                = @"     Produced by iPhone App Me and my BFFs   ";
            NSAttributedString *myNewCellAttributedText1 = [
                [NSAttributedString alloc] initWithString: @"        Produced by iPhone App Me and my BFFs   "
                                               attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f] }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.font           = myFont_16;
                cell.textLabel.numberOfLines  = 1; 
                cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
                cell.userInteractionEnabled   = NO;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.attributedText = myNewCellAttributedText1;
            });

            return cell;
        }  // end of 2 of 3 FOOTER CELLS

        else if (indexPath.row ==  group_report_output_idx + 3)
        {  // 3 of 3 FOOTER CELLS
//trn("// 3 of 3 FOOTER CELLS");

            // make same font bold
            //
            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
            UIFont *currentFont       = cell.textLabel.font;
            UIFont *currentFontBolded = [myappDelegate boldFontWithFont: (UIFont *) currentFont];
//  NSLog(@"currentFontBolded =%@",currentFontBolded );

            //myNewCellText                = @"    This report is for entertainment purposes only.  ";
            NSAttributedString *myNewCellAttributedText2 = [
                [NSAttributedString alloc] initWithString:  @"       This report is for entertainment purposes only.  "
                                               attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
                                                               NSForegroundColorAttributeName: [UIColor redColor]               }
            ];

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.textLabel.font           = currentFontBolded;
                cell.textLabel.numberOfLines  = 1; 
                cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
                cell.userInteractionEnabled   = NO;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.attributedText = myNewCellAttributedText2;
            });

            return cell;

        }  // end of 3 of 3 FOOTER CELLS

        else if (indexPath.row == 0) {  // COLUMN HEADERS   SPACER   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//tn();trn("in row 0  SPACER");
            // this is spacer row between 'for ... \n in Group ...'  and col headers
            //

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.accessoryType           = UITableViewCellAccessoryNone;
                cell.accessoryView           = myInvisibleButton;            // no right arrow on benchmark label
                cell.textLabel.numberOfLines = 1; 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.font          = myFont_16;
                cell.textLabel.text          = @" ";  // ------------------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled  = NO;                           // no selection highlighting
            });

            return cell;

        } // end of spacer row before col headers

        else if (indexPath.row == 1) {  // ONLY header line   (just 1)
//tn();trn("in row 0  SPACER");
            // this is spacer row between 'for ... \n in Group ...'  and col headers
            //

            NSString *myNewCellText_HDR; 
            myNewCellText_HDR = [myOriginalCellText substringWithRange:NSMakeRange(0, myOriginalCellTextLen - 1)]; // zero-based

            int mylen1 = (int)myNewCellText_HDR.length;

            myNewCellText  = [myNewCellText_HDR substringWithRange:
                NSMakeRange(gbl_numLeadingSpacesToRemove, mylen1 - gbl_numLeadingSpacesToRemove)]; // zero-based

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.userInteractionEnabled              = YES;      // method just returns 
                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.font                      = myFont_16;
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.text                      = myNewCellText;  // ------------------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            });
      
            return cell;

        } // end of spacer row before col headers

//        else if (indexPath.row == 2) {  // COLUMN HEADERS   SPACER   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
////tn();trn("in row 0  SPACER");
//            // this is spacer row between 'for ... \n in Group ...'  and col headers
//            //
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                cell.accessoryType           = UITableViewCellAccessoryNone;
//                cell.accessoryView           = myInvisibleButton;            // no right arrow on benchmark label
//                cell.textLabel.numberOfLines = 1; 
//                cell.textLabel.textColor     = [UIColor blackColor];
//                cell.textLabel.font          = myFont;
//                cell.textLabel.text          = @" ";  // ------------------------------------------------------------
//                cell.userInteractionEnabled  = NO;                           // no selection highlighting
//            });
//
//            return cell;
//
//        } // end of spacer row before col headers
//

        else {    // data line // shorter data line
//trn("  // shorter data line");

            // short line, on right end,  remove 1 space  
            //
            NSString *myNewCellTextShort; 
            myNewCellTextShort = [myOriginalCellText substringWithRange:NSMakeRange(0, myOriginalCellTextLen - 1)]; // zero-based
//NSLog(@"myNewCellTextShort A =[%@]",myNewCellTextShort     );

            // short line, on left end, 
            // remove leading spaces which do not constitute part of space for rank number (
            //
            int mylen1 = (int)myNewCellTextShort.length;

            myNewCellText  = [myNewCellTextShort substringWithRange:
                NSMakeRange(gbl_numLeadingSpacesToRemove, mylen1 - gbl_numLeadingSpacesToRemove)]; // zero-based
//NSLog(@"myNewCellTextShort B =[%@]",myNewCellTextShort     );

//trn(" end of  // shorter data line");
        }   // end shorter data line



            // THIS is for  MOST and BEST  group reports

        // make benchmark lines have invisible right arrow and disable interaction
        //
        int do_setup_for_benchmark_label_cell;
        do_setup_for_benchmark_label_cell = 0;

        NSRange   range_ofBenchmarkScoreAndLabel;
        NSMutableString *myNewCellText2 = [[NSMutableString alloc] init];

        if ([myNewCellText rangeOfString: @"90  Great"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Great  90"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else {
            do_setup_for_benchmark_label_cell = 1;
            
            range_ofBenchmarkScoreAndLabel = [myNewCellText rangeOfString: @"90  Great    "];
            [myNewCellText2 setString: myNewCellText];  // set mut str value to that of nsstring
            [myNewCellText2 replaceCharactersInRange: range_ofBenchmarkScoreAndLabel
                                          withString: @"90  Very High"];
        }
        if ([myNewCellText rangeOfString: @"75  Very Good"
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Very Good  75"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else {
            do_setup_for_benchmark_label_cell = 1;
            
            range_ofBenchmarkScoreAndLabel = [myNewCellText rangeOfString: @"75  Very Good"];
            [myNewCellText2 setString: myNewCellText];  // set mut str value to that of nsstring
            [myNewCellText2 replaceCharactersInRange: range_ofBenchmarkScoreAndLabel
                                          withString: @"75  High     "];
        }
        if ([myNewCellText rangeOfString: @"50  Average" 
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Average  50"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else {
            do_setup_for_benchmark_label_cell = 1;
            
            range_ofBenchmarkScoreAndLabel = [myNewCellText rangeOfString: @"50  Average  "];
            [myNewCellText2 setString: myNewCellText];  // set mut str value to that of nsstring
            [myNewCellText2 replaceCharactersInRange: range_ofBenchmarkScoreAndLabel
                                          withString: @"50  Average  "];
        }
        if ([myNewCellText rangeOfString: @"25  Not Good" 
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"Not Good  25"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else {
            do_setup_for_benchmark_label_cell = 1;
            
            range_ofBenchmarkScoreAndLabel = [myNewCellText rangeOfString: @"25  Not Good "];
            [myNewCellText2 setString: myNewCellText];  // set mut str value to that of nsstring
            [myNewCellText2 replaceCharactersInRange: range_ofBenchmarkScoreAndLabel
                                          withString: @"25  Low      "];
        }
        if ([myNewCellText rangeOfString: @"10  OMG"    
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
         && [myNewCellText rangeOfString: @"OMG  10"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
           ;
        } else {
            do_setup_for_benchmark_label_cell = 1;
            
            range_ofBenchmarkScoreAndLabel = [myNewCellText rangeOfString: @"10  OMG      "];
            [myNewCellText2 setString: myNewCellText];  // set mut str value to that of nsstring
            [myNewCellText2 replaceCharactersInRange: range_ofBenchmarkScoreAndLabel
                                          withString: @"10  Very Low "];
        }



        if (do_setup_for_benchmark_label_cell == 1) {
            //cell.accessoryType  is   IGNORED because accessoryView is set to (non-nil)


            dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
                cell.textLabel.text                      = myNewCellText2;  // --------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled              = NO;                           // no selection highlighting
                cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 

//if (cell.backgroundColor == gbl_color_cRe2) {
//            cell.textLabel.textColor                 = gbl_color_textRe2;
//} else {
//            cell.textLabel.textColor                 = [UIColor blackColor];
//}
//

                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.font                      = myFont_16;
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
            });

        } else {

            // UILabel for the disclosure indicator, ">",  for tappable cells
            //
                NSString *myDisclosureIndicatorBGcolorName; 
                NSString *myDisclosureIndicatorText; 
                UIColor  *colorOfGroupReportArrow; 
                UIFont   *myDisclosureIndicatorFont; 

                myDisclosureIndicatorText = @">"; 
                myDisclosureIndicatorBGcolorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
//        NSLog(@"myDisclosureIndicatorBGcolorName =%@",myDisclosureIndicatorBGcolorName );
      
                if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] ) {
                    colorOfGroupReportArrow   = [UIColor blackColor];                 // deepest red is pretty  dark
                    myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
                } else {
                    colorOfGroupReportArrow   = [UIColor  grayColor];
                    myDisclosureIndicatorFont = [UIFont boldSystemFontOfSize: 16.0f];
                }


                NSAttributedString *myNewCellAttributedText3 = [
                    [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
                                                   attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
                                                                   NSForegroundColorAttributeName: colorOfGroupReportArrow                }
                ];
//                                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize: 16.0f],

                UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
                myDisclosureIndicatorLabel.attributedText = myNewCellAttributedText3;


                if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]  // Most Assertive
                    || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgme"]  // Most Emotional
                    || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmr"]  // Most Restless
                    || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmp"]  // Most Passionate
                    || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmd"]  // Most Down-to-earth
                ) { 
                    // for "Most" is  all light green color
//                    if (indexPath.row % 2 == 0) myDisclosureIndicatorLabel.backgroundColor = gbl_color_cPerGreen4;
//                    if (indexPath.row % 2 == 1) myDisclosureIndicatorLabel.backgroundColor = gbl_color_cPerGreen3;
                     myDisclosureIndicatorLabel.backgroundColor = gbl_color_cPerGreen ;  // all the same color
                     gbl_thisCellBackGroundColor                = gbl_color_cPerGreen ;  // all the same color
                }

//                if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgby"]  // Best Year
//                    || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgbd"]  // Best Day
//                    || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgbd"]  // Best Day
//                )     // for "Best" use red/green color
                 else {
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cHed"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cHed;
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cGr2"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cGr2;
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cGre"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cGre;
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cNeu"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cNeu;
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRed"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cRed;
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cRe2;
//                    if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cBgr"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cBgr;
//
                    myDisclosureIndicatorLabel.backgroundColor = gbl_thisCellBackGroundColor;  // see above
                }
            //
            // end of  UILabel for the disclosure indicator, ">",  for tappable cells



            dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled              = YES;                  

//            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
//            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.accessoryView                       = myDisclosureIndicatorLabel;
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.font                      = myFont_16;
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above
            });
        }

//trn("// end of  tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath");

        // set cell height to 32.0   see method heightForRowAtIndexPath  below
        return cell;


    } //  ALL of THIS   is for  MOST and BEST  group reports
//
// ALL of THIS   is for  MOST and BEST  group reports


    return cell;

} // end of  TBLRPTs_1  cellForRowAtIndexPath: (NSIndexPath *)indexPath





// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
//  NSLog(@"in heightForRowAtIndexPath 1");
    // return customTableCellHeight;
//    return UITableViewAutomaticDimension;
//  NSLog(@"UITableViewAutomaticDimension=[%ld]",UITableViewAutomaticDimension);
//kdn(UITableViewAutomaticDimension);  // is = -1
 
    if ( [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]  //  new personality TBLRPT  report
    ) {

  NSLog(@"gbl_heightCellPER=[%ld]",(long)gbl_heightCellPER);
        return gbl_heightCellPER;  
    }
    if ( [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]  //  new personality TBLRPT  report
    ) {

//NSAttributedString *attrStr = ... // your attributed string
//CGFloat width = 300; // whatever your desired width is
//CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//


//      if ( gbl_heightForCompTable == 0) return 44.0;
//  NSLog(@"CELL HEIGHT!");
//  NSLog(@"gbl_areInCompatibilityTable =[%ld]",gbl_areInCompatibilityTable );
//  NSLog(@"gbl_heightForCompTable      =[%f]",gbl_heightForCompTable );
//  NSLog(@"gbl_heightCellCOMP          =[%ld]",gbl_heightCellCOMP);

        if (gbl_areInCompatibilityTable == 1)
        {

nb(40);kdn(gbl_heightForCompTable );
            if (gbl_heightForCompTable > 30.0) gbl_heightForCompTable =  gbl_heightForCompTable  /  2.0; // MAGIC FIX 15+15 on 6+, possibly 6 - fixes hdr
kdn(gbl_heightForCompTable );

  NSLog(@"return CELL HEIGHT 1 is [%f]", gbl_heightForCompTable );
            return (gbl_heightForCompTable ); 
        } else {
//  NSLog(@"return CELL HEIGHT 2 is [%ld]", (long)gbl_heightCellCOMP);
            return gbl_heightCellCOMP;  
        }

//      return (gbl_heightForCompTable / 2.0 );
          // 19.62 ?
//      return (gbl_heightForCompTable * 0.75 );
    }



    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // My Best Match in Group ... grpone
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ] //    Best Match in Group ... grpall
    ) {
        if (indexPath.row == 0) return 14.0;  // spacer
//        if (indexPath.row == 1) return 15.0;  // col hdr 1
//        if (indexPath.row == 2) return 15.0;  // col hdr 2
        if (indexPath.row == 1) return 18.0;  // col hdr 1
        if (indexPath.row == 2) return 21.0;  // col hdr 2
     
        if (indexPath.row == group_report_output_idx + 1) return 15.0 * 7;  // ftr 1
        if (indexPath.row == group_report_output_idx + 2) return 15.0 ;     // ftr 2
        if (indexPath.row == group_report_output_idx + 3) return 20.0 ;     // ftr 3

    } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs
               || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
               || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
               || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
               || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
    ) {
        if (indexPath.row == 0) return  8.0;  // spacer
        if (indexPath.row == 1) return 24.0;  // col hdr 1
        if (indexPath.row == 2) return 32.0;  // col hdr 2   ??
     
        if (indexPath.row == group_report_output_idx + 1) return  70.0 ;  // ftr 1
        if (indexPath.row == group_report_output_idx + 2) return  15.0 ;     // ftr 2   by
        if (indexPath.row == group_report_output_idx + 3) return  20.0 ;     // ftr 3   entertainment

    } else if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]      // group Best RPT  best year
    ) {
        if (indexPath.row == 0) return  8.0;  // spacer
        if (indexPath.row == 1) return 24.0;  // col hdr 1
        if (indexPath.row == 2) return 32.0;  // col hdr 2   ??
     
        if (indexPath.row == group_report_output_idx + 1) return 70.0 ;  // ftr 1
        if (indexPath.row == group_report_output_idx + 2) return 15.0 ;     // ftr 2   by
        if (indexPath.row == group_report_output_idx + 3) return 20.0 ;     // ftr 3   entertainment

    } else if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]      // group Best RPT  best day     
    ) {
        if (indexPath.row == 0) return  8.0;  // spacer
        if (indexPath.row == 1) return 24.0;  // col hdr 1
        if (indexPath.row == 2) return 32.0;  // col hdr 2   ??
     
//        if (indexPath.row == group_report_output_idx + 1) return 15.0 * 7;  // ftr 1
//        if (indexPath.row == group_report_output_idx + 1) return 15.0 * 8.0;  // ftr 1
//        if (indexPath.row == group_report_output_idx + 1) return 150.0 ;  // ftr 1
//        if (indexPath.row == group_report_output_idx + 1) return 200.0 ;  // ftr 1
        if (indexPath.row == group_report_output_idx + 1) return  75.0 ;  // ftr 1
        if (indexPath.row == group_report_output_idx + 2) return  15.0 ;     // ftr 2   by
        if (indexPath.row == group_report_output_idx + 3) return  20.0 ;     // ftr 3   entertainment
     }
    
//      else if ([gbl_currentMenuPlusReportCode hasPrefix: @"homgm"]  // best day
//    ) {
//        if (indexPath.row == 0) return  8.0;  // spacer
//        if (indexPath.row == 1) return 24.0;  // col hdr 1
//        if (indexPath.row == 2) return 32.0;  // col hdr 2   ??
//     
////        if (indexPath.row == group_report_output_idx + 1) return 15.0 * 7;  // ftr 1
////        if (indexPath.row == group_report_output_idx + 1) return 15.0 * 8.0;  // ftr 1
////        if (indexPath.row == group_report_output_idx + 1) return 150.0 ;  // ftr 1
////        if (indexPath.row == group_report_output_idx + 1) return 200.0 ;  // ftr 1
////
//        if (indexPath.row == group_report_output_idx + 1) return  25.0 ;  // ftr 1
//        if (indexPath.row == group_report_output_idx + 2) return  15.0 ;     // ftr 2   by
//        if (indexPath.row == group_report_output_idx + 3) return  20.0 ;     // ftr 3   entertainment
//    }
//
    
//    return 32.0;
//    return 44.0;   // standard height
//    return 38.0;
    return 35.0; 

}  // ---------------------------------------------------------------------------------------------------------------------



// how to set cell background color
//
// Alternate method to try later if below does not work:
//                         http://stackoverflow.com/questions/281515/how-to-customize-the-background-color-of-a-uitableviewcell
//
//      The best approach I've found so far is to
//      1. set a background view of the cell
//      2. and clear background of cell subviews.
//      Of course, this looks nice on tables with indexed style only, no matter with or without accessories.
//      
//      Here is a sample where cell's background is panted yellow:
//      
//      UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
//      backgroundView.backgroundColor = [ UIColor yellowColor ];
//      cell.backgroundView = backgroundView;
//      for ( UIView* view in cell.contentView.subviews ) 
//      {
//          view.backgroundColor = [ UIColor clearColor ];
//      }
//      
//
//<.>
//
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { ... }
// ***
//When this delegate method is called the color of the cell is controlled via the cell rather than the table view, as when you use:
// ***
//
//- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath { ... }
//
//
- (void)tableView:(UITableView *)tableView willDisplayCell: (UITableViewCell *)cell
                                         forRowAtIndexPath: (NSIndexPath *)indexPath 
{
//  NSLog(@"in willDisplayCell");
    //cell.backgroundColor = [UIColor colorWithRed:(116/255.0) green:(167/255.0) blue:(179/255.0) alpha:1.0];

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]  
    ) {
        return;
    }
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]  
    ) {
//        if (gbl_compIsInHowBig == 1) {
////            cell.backgroundColor = gbl_color_cNeu;
//            cell.backgroundColor = [UIColor cyanColor];
//        } else {
//        }
        cell.backgroundColor = gbl_color_cBgr;
        return;
    }

    NSString *thisCellBGcolorName; 

    thisCellBGcolorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
//  NSLog(@"thisCellBGcolorName =%@",thisCellBGcolorName );


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]  // Most Assertive
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgme"]  // Most Emotional
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmr"]  // Most Restless
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmp"]  // Most Passionate
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmd"]  // Most Down-to-earth
    ) { 
        dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
            if ( [thisCellBGcolorName isEqualToString: @"cHed"] )  cell.backgroundColor = gbl_color_cHed;
//            else if (indexPath.row % 2 == 0) cell.backgroundColor = gbl_color_cPerGreen4;   // for "Most" is  all light green color
//            else if (indexPath.row % 2 == 1) cell.backgroundColor = gbl_color_cPerGreen3;   // for "Most" is  all light green color
            else  cell.backgroundColor = gbl_color_cPerGreen;   // (same for every cell)  for "Most" is  all light green color
        });
    }

//    if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgby"]  // Best Year
//        || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgbd"]  // Best Day
//    )  
    else {
        // doubling the bg color got rid of 1 pixel vertical line

        dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line

            if ( [thisCellBGcolorName isEqualToString: @"cHed"] )  cell.textLabel.backgroundColor = gbl_color_cHed;

            if ( [thisCellBGcolorName isEqualToString: @"cGr2"] )  cell.textLabel.backgroundColor = gbl_color_cGr2;
            if ( [thisCellBGcolorName isEqualToString: @"cGre"] )  cell.textLabel.backgroundColor = gbl_color_cGre;
            if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )  cell.textLabel.backgroundColor = gbl_color_cNeu;
            if ( [thisCellBGcolorName isEqualToString: @"cRed"] )  cell.textLabel.backgroundColor = gbl_color_cRed;
            if ( [thisCellBGcolorName isEqualToString: @"cRe2"] )  cell.textLabel.backgroundColor = gbl_color_cRe2;

            if ( [thisCellBGcolorName isEqualToString: @"cBgr"] )  cell.textLabel.backgroundColor = gbl_color_cBgr;


            if ( [thisCellBGcolorName isEqualToString: @"cHed"] )  cell.backgroundColor = gbl_color_cHed;

            if ( [thisCellBGcolorName isEqualToString: @"cGr2"] )  cell.backgroundColor = gbl_color_cGr2;
            if ( [thisCellBGcolorName isEqualToString: @"cGre"] )  cell.backgroundColor = gbl_color_cGre;
            if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )  cell.backgroundColor = gbl_color_cNeu;
            if ( [thisCellBGcolorName isEqualToString: @"cRed"] )  cell.backgroundColor = gbl_color_cRed;
            if ( [thisCellBGcolorName isEqualToString: @"cRe2"] )  cell.backgroundColor = gbl_color_cRe2;

            if ( [thisCellBGcolorName isEqualToString: @"cBgr"] )  cell.backgroundColor = gbl_color_cBgr;


            if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )  cell.textLabel.backgroundColor   = gbl_color_cNeu;
            if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )  cell.backgroundColor             = gbl_color_cNeu;
//            if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )  cell.contentView.backgroundColor = gbl_color_cNeu;


        });
    }    // for "Best" use red/green color

} // end of   willDisplayCell




//- (void)tableView:(UITableView *)tableView willDisplayCell: (UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{ 
//tn();  NSLog(@"willDisplayCell !");
//    // get the Background Color for this cell
//    //
//    do {
//
//        gbl_thisCellBackGroundColorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cHed"] )  gbl_thisCellBackGroundColor = gbl_color_cHed;
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cGr2"] )  gbl_thisCellBackGroundColor = gbl_color_cGr2;
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cGre"] )  gbl_thisCellBackGroundColor = gbl_color_cGre;
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cNeu"] )  gbl_thisCellBackGroundColor = gbl_color_cNeu;
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cRed"] )  gbl_thisCellBackGroundColor = gbl_color_cRed;
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cRe2"] )  gbl_thisCellBackGroundColor = gbl_color_cRe2;
//        if ( [gbl_thisCellBackGroundColorName isEqualToString: @"cBgr"] )  gbl_thisCellBackGroundColor = gbl_color_cBgr;
//    } while (FALSE);
//
//    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//        cell.textLabel.backgroundColor           = gbl_thisCellBackGroundColor;  // see above x
//    });
//}
//



//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [self.tableView setBackgroundView:nil];
//    [self.tableView setBackgroundColor: gbl_colorReportsBG];
//    cell.backgroundColor = [UIColor clearColor];
//    
//}
//


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
////    if (section == 0) {
////        return  @" For1~Elijah89012345\nin Group ~My1Family12345";
////    }
////        return  @"For ~Elijah\nin Group ~My2Family";
////
//    return @"use label view";
//}
//

// how to set the section header cell height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  // --------------------------------
{
//  NSLog(@"in heightForHeaderInSection");


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]

        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]

        || [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
    ) {
        return 0.0;
    }

//    if ([gbl_kingpinPersonName isEqualToString: @""]  ||  gbl_kingpinPersonName == nil) {  
      if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ]        //    Best Match in Group ... grpall
          || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ]        //    Best Match in Group ... grpall
      ) {
          return 16.0;   //    Best Match in Group ...   1 line
      }
      if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm" ]        //    Best Match in Group ... grpall
          || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"    ]        //    Best Match in Group ... grpall
      ) {
//          return 42.0;   // MY Best Match in Group ...   2 lines
//          return 32.0;   // MY Best Match in Group ...   2 lines
//          return 35.0;   // MY Best Match in Group ...   2 lines
          return 34.0;   // MY Best Match in Group ...   2 lines
      }

      return 32.0;   //    default
    
} 

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
//tn();
//  NSLog(@"in viewForHeaderInSection  in tblrpts 1");
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//  NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@",gbl_currentMenuPrefixFromMatchRpt);
//  NSLog(@"gbl_lastSelPersonWasA =%@",gbl_lastSelPersonWasA );
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//  NSLog(@"gbl_kingpinPersonName=%@",gbl_kingpinPersonName);
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//tn();
//

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]

        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]

        || [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
    ) {
        return nil;
    }

    UIView *myReturnView;

    if (section == 0) {
        UILabel *lblSection0 = [[UILabel alloc] init];


//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

        // grpall all BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
                // gbl_PSVtappedPerson_grpall;     // gbm1pe,gbm2pe,gbm1bm,gbm2bm 
                // gbl_PSVtappedPerson_grpone;     // pbm1pe,pbm2pe,pbm2bm       
        //
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ]        //    Best Match in Group ... grpall
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ]        //    Best Match in Group ... grpall

        ) {
            lblSection0.numberOfLines = 1;
            lblSection0.font          = [UIFont boldSystemFontOfSize: 14.0];
            lblSection0.text = [NSString stringWithFormat: @"in Group   %@", gbl_lastSelectedGroup];

//             mySel2ndPer_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
//            lblSection0.layer.borderWidth = 1.0f;  // TEST VISIBLE LABEL  (works great)


        // grpone  all *MY* BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
        } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm" ] // My Best Match in Group ... grpone
                   || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"    ] // My Best Match in Group ... grpone

                // gbl_PSVtappedPerson_grpone;     // pbm1pe,pbm2pe,pbm2bm       
                // gbl_PSVtappedPerson_grpall;     // gbm1pe,gbm2pe,gbm1bm,gbm2bm 
        ) {
            lblSection0.numberOfLines = 2;
            lblSection0.font          = [UIFont boldSystemFontOfSize: 14.0];
            lblSection0.text = [NSString stringWithFormat: @"for   %@\nin Group   %@", gbl_kingpinPersonName, gbl_lastSelectedGroup];

//            lblSection0.layer.borderWidth = 1.0f;  // TEST VISIBLE LABEL  (works great)
        }

        else {
           lblSection0.text =  @" x01";  // should never happen
        }

        //        lblSection0.backgroundColor =  gbl_color_cHed;  
        //        lblSection0.backgroundColor = gbl_color_cAplTop;
        //        lblSection0.backgroundColor = [UIColor redColor];   for test
        lblSection0.backgroundColor = [UIColor whiteColor];

        [lblSection0 sizeToFit];

        // make same font bold
        //
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
        UIFont *currentFont       = lblSection0.font;
        UIFont *currentFontBolded = [myappDelegate boldFontWithFont: (UIFont *) currentFont];
        lblSection0.font          = currentFontBolded;


        lblSection0.textAlignment = NSTextAlignmentCenter;
        myReturnView = lblSection0;
    }

    return myReturnView;

}  // end of  viewForHeaderInSection





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

- (BOOL)tableView:(UITableView *)tableView  shouldHighlightRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
    ) {
        return NO;
    }

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // My Best Match in Group ... grpone
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ] //    Best Match in Group ... grpall
    ) {
        if (indexPath.row == 0 )                            return NO;   // no selection on header1 (sp)
        if (indexPath.row == 1 )                            return NO;   // no selection on header2
        if (indexPath.row == 2 )                            return NO;   // no selection on header3
        if (indexPath.row ==  group_report_output_idx + 1)  return NO;   // 1 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 2)  return NO;   // 2 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 3)  return NO;   // 3 of 3 FOOTER CELLS
    }

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]      // group Best RPTs
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]      
    ) {
        if (indexPath.row == 0 )                            return NO;   // no selection on header1 (sp)
        if (indexPath.row == 1 )                            return NO;   // no selection on header2
//        if (indexPath.row == 2 )                            return NO;   // no selection on header3  --> no hdr 2
        if (indexPath.row ==  group_report_output_idx + 1)  return NO;   // 1 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 2)  return NO;   // 2 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 3)  return NO;   // 3 of 3 FOOTER CELLS
    }
    
    return YES;
} 


- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
tn(); NSLog(@"in  TBLRPTS_1  willDeselectRowAtIndexPath!");
NSLog(@"indexPath.row=%ld",(long)indexPath.row);


//   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//   if ([cell isSelected]) { return nil; }
//     return indexPath;

    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    // 
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);
    
    // here we are deselecting "previously" selected row
    // and removing light grey highlight
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
//                                  animated: NO];
                                  animated: YES];
    return previouslyselectedIndexPath;
} // willDeselectRowAtIndexPath



// willSelectRowAtIndexPath message is sent to the UITableView Delegate
// after the user lifts their finger from a touch of a particular row
// and before didSelectRowAtIndexPath.
//
// willSelectRowAtIndexPath allows you to either confirm that the particular row can be selected,
// by returning the indexPath, or select a different row by providing an alternate indexPath.
//
// This method is only called if there is an existing selection when the user tries to select a different row.
// The delegate is sent this method for the previously selected row.
// You can use UITableViewCellSelectionStyleNone to disable the appearance of the cell highlight on touch-down.
//
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // NSLog(@"willSelectRowAtIndexPath!");

// use gbl
//    // this is the "previously" selected row now
//    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
//
//    // here deselect "previously" selected row
//    // and remove yellow highlight
//    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
//                                  animated: NO];
//

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] // home + personality
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"hompco"] // home + grpof2[
    ) {
        return nil;   // these are leaf reports, no row selection
    }

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // My Best Match in Group ... grpone
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ] //    Best Match in Group ... grpall
    ) {
        if (indexPath.row == 0 )                            return nil;  // no selection on header1 (sp)
        if (indexPath.row == 1 )                            return nil;  // no selection on header2
        if (indexPath.row == 2 )                            return nil;  // no selection on header3
        if (indexPath.row ==  group_report_output_idx + 1)  return nil;  // 1 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 2)  return nil;  // 2 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 3)  return nil;  // 3 of 3 FOOTER CELLS
    }
    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]      // group Best RPTs
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]      
    ) {
        if (indexPath.row == 0 )                            return nil;  // no selection on header1 (sp)
        if (indexPath.row == 1 )                            return nil;  // no selection on header2
//        if (indexPath.row == 2 )                            return nil;  // no selection on header3  ---> no hdr 2
        if (indexPath.row ==  group_report_output_idx + 1)  return nil;  // 1 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 2)  return nil;  // 2 of 3 FOOTER CELLS
        if (indexPath.row ==  group_report_output_idx + 3)  return nil;  // 3 of 3 FOOTER CELLS
    }

    return indexPath; // By default, allow row to be selected
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    NSLog(@"in didSelectRowAtIndexPath!  in TBLRPT_1 ");
    NSLog(@"indexpath.row=%ld",(long)indexPath.row);

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] // home + personality
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"hompco"] // home + grpof2[
    ) {
        return ;   // these are leaf reports, no row selection
    }
    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m

    gbl_TBLRPTS1_saveSelectedIndexPath = indexPath;  // for deselecting with animation when return to TBLRPTS1
NSLog(@"gbl_TBLRPTS1_saveSelectedIndexPath.row=%ld",(long)gbl_TBLRPTS1_saveSelectedIndexPath.row);
    
    if (indexPath.row == 0 ) return;   // no selection on header
    if (indexPath.row == 1 ) return;   // no selection on header

    if (indexPath.row == 2 ) {         // no selection on header
        if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
        ) {
            return; // these have 2-line headers, so no select here
        }
    }


    //    // **********   NO REMEMBERING WHICH REPORT WAS SELECTED  for a specific pair or person ********************
    //   ONLY REMEMBER the indexPath.row in this session   NOT names between sessions
    //
//    gbl_selectedRownumTBLRPT_1 = indexPath.row;  // for remembering row to highlight in tblrpt1

    //        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
    //                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
    //                         updatingRememberCategory: (NSString *) @"rptsel"
    //                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
    //        ];
    //



    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
//                                animated:NO
                                animated: YES
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: NO];
//    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
//                                  animated: NO];


    UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath]; // now you can use currcell.textLabel.text

    if ([currcell.textLabel.text rangeOfString: @"90  Great"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
     && [currcell.textLabel.text rangeOfString: @"Great  90"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
        ;
    } else { return; } // no selection on benchmark label row

    if ([currcell.textLabel.text rangeOfString: @"75  Very Good"
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
     && [currcell.textLabel.text rangeOfString: @"Very Good  75"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
        ;
    } else { return; } // no selection on benchmark label row

    if ([currcell.textLabel.text rangeOfString: @"50  Average" 
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
     && [currcell.textLabel.text rangeOfString: @"Average  50"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
        ;
    } else { return; } // no selection on benchmark label row

    if ([currcell.textLabel.text rangeOfString: @"25  Not Good" 
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
     && [currcell.textLabel.text rangeOfString: @"Not Good  25"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
        ;
    } else { return; } // no selection on benchmark label row

    if ([currcell.textLabel.text rangeOfString: @"10  OMG"    
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound
     && [currcell.textLabel.text rangeOfString: @"OMG  10"   
                                       options: NSCaseInsensitiveSearch ].location     == NSNotFound) {
        ;
    } else { return; } // no selection on benchmark label row


    //  set names for title in sel rpt B
    //

//NSLog(@"indexpath.row=%ld",(long)indexPath.row);

    gbl_selectedCellPersonAname = gbl_array_cellPersonAname[indexPath.row];  // for passing to sel rpt B title
    gbl_selectedCellPersonBname = gbl_array_cellPersonBname[indexPath.row];  // for passing to sel rpt B title
//  NSLog(@"gbl_selectedCellPersonAname =%@",gbl_selectedCellPersonAname );
//  NSLog(@"gbl_selectedCellPersonBname =%@",gbl_selectedCellPersonBname );

    //
    // save PSVs for viewHTML reports
    //
tn();trn("// save PSVs for viewHTML reports");
  NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);
    do {
        // MAMB09viewTBLRPTs_1_TableViewController.m  does 9 RPTs  hompbm,homgbm, homgma,homgme,homgmr,homgmp,homgmd homgby,homgbd
        //
        //NSString *gbl_PSVtappedPerson_grpone;  // pbm1pe,pbm2pe,pbm2bm
        //NSString *gbl_PSVtappedPerson_grpall;  // gbm1pe,gbm2pe,gbm1bm,gbm2bm
        //NSString *gbl_PSVtappedPerson_grpmost; // gmappe,gmeppe,gmrppe,gmpppe,gmdppe
        //NSString *gbl_PSVtappedPerson_grpbest; // gbypcy,gbdpwc
        //NSString *gbl_PSVtappedPersonA_inPair; // pbmco,gbmco
        //NSString *gbl_PSVtappedPersonB_inPair; // pbmco,gbmco
        //


        // grpone all *MY* BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
        // grpall all BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
        //
        if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
          ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // My Best Match in Group ... grpone
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
          ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ] //    Best Match in Group ... grpall
        ) {
            gbl_PSVtappedPersonA_inPair = [myappDelegate getPSVforPersonName: (NSString *) gbl_selectedCellPersonAname ]; 
            gbl_PSVtappedPersonB_inPair = [myappDelegate getPSVforPersonName: (NSString *) gbl_selectedCellPersonBname ]; 
        }

        if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]      // group Best RPTs
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]      
        ) {
            gbl_PSVtappedPerson_fromGRP = [myappDelegate getPSVforPersonName: (NSString *) gbl_selectedCellPersonAname ]; 
  NSLog(@" tblrpts 1  gbl_PSVtappedPerson_fromGRP =%@",gbl_PSVtappedPerson_fromGRP );
        }
    } while (false); // save PSVs for viewHTML reports



  NSLog(@"gbl_PSVtappedPerson_fromGRP =%@",gbl_PSVtappedPerson_fromGRP );

tn();trn("just tapped on row in TBLRPTS_1");
  NSLog(@"gbl_PSVtappedPersonA_inPair =%@",gbl_PSVtappedPersonA_inPair );
  NSLog(@"gbl_PSVtappedPersonB_inPair =%@",gbl_PSVtappedPersonB_inPair );
  NSLog(@"gbl_PSVtappedPerson_fromGRP =%@",gbl_PSVtappedPerson_fromGRP );
  NSLog(@"doing  segue   from TBLRPTS1 to   Select REPORTS B!");

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // My Best Match in Group ... grpone
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
      ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ] //    Best Match in Group ... grpall
    ) {
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueTBLRPT1toSELRPT_B" sender:self];
        });                                   
    }

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs  (tap here goes to gm?ppe in viewHTML)
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]

      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]      // group Best RPTs  (tap here goes to gbypcy in viewHTML)
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]      //                  (tap here goes to gbdpwc in viewHTML) 
    ) {

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueTBLRPT1_toViewHTML" sender:self];
        });                                   
    }


} // end of didSelectRowAtIndexPath




//How to check if a UIViewController is being dismissed/popped?
//  To know if your UIVIewController is being dismissed or popped,
//  you can ask your UIVIewController if it is being dismissed or being moved
//  from it’s parent UIVIewController. 
//
- (void)viewWillDisappear:(BOOL)animated {
     NSLog(@"in viewWillDisappear in TBLRPTs_1  !");

  [super viewWillDisappear:animated];

//  if (self.isBeingDismissed || self.isMovingFromParentViewController) {
//
//      // Handle the case of being dismissed or popped.
//      //
//      gbl_selectedRownumTBLRPT_1 = -1; // FLAG to not highlight menu row on first entering selrpts_B
//  }
//
} // viewWillDisappear


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    NSLog(@"in TBLRPTs 1  viewWillAppear!");
NSLog(@"gbl_TBLRPTS1_saveSelectedIndexPath.row=%ld",(long)gbl_TBLRPTS1_saveSelectedIndexPath.row);

    gbl_areInCompatibilityTable = 0;

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]    // home + personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
    ) {

            // try to get rid of tbl position in middle on startup
nbn(451);
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

//                [self.tableView reloadData]; // self.view is the table view if self is its controller // try to get rid of tbl position in middle on startup
//
////            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationAutomatic];
////            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationRight];
////            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationBottom];
////            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationMiddle];
//                [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]  
//                              withRowAnimation: UITableViewRowAnimationNone           // does a default unchangeable animation
//                ];
//
////            [table setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
////            [self.tableView setContentOffset:CGPointMake(0, 0)];
//
//
////            NSIndexPath *scrollToPath = [NSIndexPath indexPathForRow:0 inSection:0]; 
////            [self.tableView scrollToRowAtIndexPath:scrollToPath  atScrollPosition: UITableViewScrollPositionTop animated: YES];   
//
//

                if (gbl_justLookedAtInfoScreen == 0 )  {
                   // try to get rid of tbl position in middle on startup
       //            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
       //                [self.tableView reloadData]; // self.view is the table view if self is its controller
       //           });
       
       //            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationAutomatic];
       //            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationRight];
       //            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationBottom];
       //            [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]   withRowAnimation: UITableViewRowAnimationMiddle];
                    [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]  
                                                                 withRowAnimation: UITableViewRowAnimationNone // does a default unchangeable animation
                    ];
       
                } 
                if (gbl_justLookedAtInfoScreen == 1 )  {
                    gbl_justLookedAtInfoScreen = 0;  // no re-load
                }
           });
    }



//<.>
    //
    // add NAVIGATION BAR right buttons, if not added already   plus nav bar title
    //
    NSString *myNavBarTitle;
nbn(400);
    if (gbl_tblrpts1_ShouldAddToNavBar == 1) { // init to prevent  multiple programatic adds of nav bar items

nbn(401);
        gbl_tblrpts1_ShouldAddToNavBar  = 0;   // do not do this again

        // you have to add the info button in interface builder by hand,
        // then you can add  Share button below with   rightBarButtonItems arrayByAddingObject: shareButton];
        //
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                        target:self
                                        action:@selector(shareButtonAction:)];

        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];


//          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]  // My Best Match in Group ...  see tblrps_2 view
//          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]  // My Best Match in Group ...  see tblrps_2 view
//          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]  // My Best Match in Group ...  see tblrps_2 view
//        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm" ]  // My Best Match in Group ...
//            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ]  //    Best Match in Group ...
//            || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"    ]
//            || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ]

//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );



        // grpone all *MY* BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
        // grpall all BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
        //
        if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // My Best Match in Group ...
          ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // My Best Match in Group ... grpone
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] //    Best Match in Group ...
          ||  [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ] //    Best Match in Group ... grpall
        ) {
nbn(402);
                // gbl_PSVtappedPerson_grpall;     // gbm1pe,gbm2pe,gbm1bm,gbm2bm 
                // gbl_PSVtappedPerson_grpone;     // pbm1pe,pbm2pe,pbm2bm       
            myNavBarTitle = @"Best Match";

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
                [self.navigationController.navigationBar setTranslucent:NO];

                // How to hide iOS7 UINavigationBar 1px bottom line
                // 
                // you can make the background a solid color by
                // 1. setting backgroundImage to [UIImage new]
                // 2. assigning navigationBar.backgroundColor to the color you like.
                // (when you  do this,  translucent becomes = NO)  that's OK
                //  http://stackoverflow.com/questions/19226965/how-to-hide-ios7-uinavigationbar-1px-bottom-line/
                //
                [self.navigationController.navigationBar setBackgroundImage: [UIImage new]       // 1. of 2
                                                             forBarPosition: UIBarPositionAny
                                                                 barMetrics: UIBarMetricsDefault];
                //
                [self.navigationController.navigationBar setShadowImage: [UIImage new]];   
                //
                self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];  // 2. of 2
                //
                // end of  How to hide iOS7 UINavigationBar 1px bottom line


                [[self navigationItem] setTitle: myNavBarTitle];
            });                                   

        } else if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgm"    ]  // "Most" reports
                 || [gbl_currentMenuPlusReportCode       hasPrefix: @"homgb"    ]  // "Best" reports
                 || [gbl_currentMenuPlusReportCode       hasPrefix: @"homppe"]
                 || [gbl_currentMenuPlusReportCode       hasPrefix: @"hompco"]
        ) {
nbn(403);

            if      ([gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]) { myNavBarTitle = @"Most Assertive"; }
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]) { myNavBarTitle = @"Most Emotional"; }
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]) { myNavBarTitle = @"Most Restless"; }
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]) { myNavBarTitle = @"Most Passionate"; }
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]) { myNavBarTitle = @"Most Down-to-earth"; }

            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]) {
                myNavBarTitle = [NSString stringWithFormat: @"Best Year  %@", gbl_lastSelectedYear ];
            }
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]) {
                myNavBarTitle = [NSString stringWithFormat: @"Best Day  %@", gbl_lastSelectedDayFormattedForTitle ];
            }

            else if ([gbl_currentMenuPlusReportCode       hasPrefix: @"homppe"]) {// home + personality
nbn(404);
                myNavBarTitle = [NSString stringWithFormat: @"Personality"];
            }
            else if ([gbl_currentMenuPlusReportCode       hasPrefix: @"hompco"]) {// home + compatibility
nbn(4041);
                myNavBarTitle = [NSString stringWithFormat: @"Compatibility"]; //  not used
            }

            else {
                myNavBarTitle = @"x02";  // should never happen
            }

            UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
            NSString *myNavBar2lineTitle;
            myNavBarLabel.numberOfLines = 2;

            if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]) myNavBarLabel.font = [UIFont boldSystemFontOfSize: 12.0];
            else                                                            myNavBarLabel.font = [UIFont boldSystemFontOfSize: 14.0];

            myNavBarLabel.textColor     = [UIColor blackColor];
            myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
//            myNavBar2lineTitle = [NSString stringWithFormat:  @"%@\nin Group %@", myNavBarTitle, gbl_lastSelectedGroup ];

            if ([gbl_currentMenuPlusReportCode       hasPrefix: @"homppe"] // home + personality
            ) {
nbn(405);
                myNavBar2lineTitle = [NSString stringWithFormat:  @"%@\n%@", myNavBarTitle, gbl_lastSelectedPerson ];

            } else if ([gbl_currentMenuPlusReportCode       hasPrefix: @"hompco"]) {// home + compatibility

                myNavBar2lineTitle = [NSString stringWithFormat:  @"%@\n& %@",
                    gbl_TBLRPTS1_NAME_personA,
                    gbl_TBLRPTS1_NAME_personB
                ];

            } else {
                myNavBar2lineTitle = [NSString stringWithFormat:  @"%@\nin %@", myNavBarTitle, gbl_lastSelectedGroup ];
            }

            myNavBarLabel.text          = myNavBar2lineTitle;

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
                [self.navigationController.navigationBar setTranslucent:NO];

                // How to hide iOS7 UINavigationBar 1px bottom line
                // 
                // you can make the background a solid color by
                // 1. setting backgroundImage to [UIImage new]
                // 2. assigning navigationBar.backgroundColor to the color you like.
                // (when you  do this,  translucent becomes = NO)  that's OK
                //  http://stackoverflow.com/questions/19226965/how-to-hide-ios7-uinavigationbar-1px-bottom-line/
                //
                [self.navigationController.navigationBar setBackgroundImage: [UIImage new]       // 1. of 2
                                                             forBarPosition: UIBarPositionAny
                                                                 barMetrics: UIBarMetricsDefault];
                //
                [self.navigationController.navigationBar setShadowImage: [UIImage new]];   
                //
                self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];  // 2. of 2
                //
                // end of  How to hide iOS7 UINavigationBar 1px bottom line

//                [[self navigationItem] setTitle: myNavBarTitle];
//                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
            });                                   
nbn(406);
        }
nbn(407);

    } // end of add Navigation Bar right buttons
//<.>






    // run personality report
    // load new personality TBLRPT  report data from URLtoHTML_forWebview into array    gbl_perDataLines 
    //
    if ( [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] )  // home + personality
    {

//            // try to get rid of tbl position in middle on startup
//nbn(351);
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                [self.tableView reloadData]; // self.view is the table view if self is its controller
//           });
//
//        self.automaticallyAdjustsScrollViewInsets = NO;


        char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
        char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
        const char *my_psvc; // psv=pipe-separated values
        char my_psv[128];
        
        char csv_person_string[128]; // csv_person1_string[128]; // csv_person2_string[128];
        char person_name_for_filename[32]; // person1_name_for_filename[32], person2_name_for_filename[32];
        char myStringBuffForTraitCSV[64];
        
//        char  yyyy_todo[16];
//        char   yyyymmdd_todo[16], stringBuffForStressScore[64] ;
//        const char *yyyy_todoC;
//        const char *yyyymmdd_todoC;
        int retval; // retval2;

        char   html_file_name_browser[2048], html_file_name_webview[2048];
        NSString *Ohtml_file_name_browser, *Ohtml_file_name_webview;
        NSString *OpathToHTML_browser,     *OpathToHTML_webview;
        char     *pathToHTML_browser,      *pathToHTML_webview;
        
        NSURL *URLtoHTML_forWebview;
//        NSURL *URLtoHTML_forEmailing;
//        NSURLRequest *HTML_URLrequest;
        NSArray* tmpDirFiles;
    


        sfill(myStringBuffForTraitCSV, 60, ' ');  // not used here in per, so blanks

            // NSString object to C
            //const char *my_psvc = [self.fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
    //        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for personality
    //        my_psvc = [gbl_viewHTML_PSV_personJust1 cStringUsingEncoding:NSUTF8StringEncoding];  // for personality
            my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for personality

            strcpy(my_psv, my_psvc);
            ksn(my_psv);
            
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
            ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
            ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
            
            // get longitude and timezone hoursDiff from Greenwich
            // by looking up psvCity, psvProv, psvCountry
            //
            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
            
            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
            
            // set gbl for email
            ksn(psvName);
            gbl_person_name =  [NSString stringWithUTF8String:psvName ];

            // build csv arg for report function call
            //
            sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
            ksn(csv_person_string);tn();
            
            
            // build HTML file name  in TMP  Directory
            //
            strcpy(person_name_for_filename, psvName);
            scharswitch(person_name_for_filename, ' ', '_');
            sprintf(html_file_name_browser, "%sper_%s.html",         PREFIX_HTML_FILENAME, person_name_for_filename);
            sprintf(html_file_name_webview, "%sper_%s_webview.html", PREFIX_HTML_FILENAME, person_name_for_filename);
            
            
            gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
            gbl_html_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];   // for later viewing in webview


            Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
            OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
            pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
            
            Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
            OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
            pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];

  NSLog(@"Ohtml_file_name_webview=[%@]",Ohtml_file_name_webview);
            
            URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
//        gbl_URLtoHTML_forWebview            

            gbl_pathToFileToBeEmailed = OpathToHTML_browser;
            
            // remove all "*.html" files from TMP directory before creating new one
            //
            tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    //        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
                    for (NSString *fil in tmpDirFiles) {
    //            NSLog(@"fil=%@",fil);
                if ([fil hasSuffix: @"html"]) {
                    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
                }
            }
       
    //        tn();trn("2 HTMLs !!!!!!!!!!!!!!!!!!!!");
    //        nksn(html_file_name_browser); ksn( html_file_name_webview);
    //        NSLog(@"Ohtml_file_name_browser=%@",Ohtml_file_name_browser);
    //        NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);
    //        nksn(pathToHTML_browser); ksn(pathToHTML_webview);

            
            retval = mamb_report_personality(     /* in perdoc.o */
                                    pathToHTML_webview,
                                    pathToHTML_browser,
                                    csv_person_string,
                                    "",  /* could be "return only csv with all trait scores",  instructions */
                                    /* this instruction arg is now ignored, because arg next, */
                                    /* stringBuffForTraitCSV, is ALWAYS populated with trait scores */
                                     myStringBuffForTraitCSV);

        // set gbl_perDataLines;  // used in tblrpts_1 (read in from webview . html file)
        //
        // URLtoHTML_forWebview  (a ".html" file) actually has data lines to be used for uitableview version
        //
        NSString *perDataStr = [NSString stringWithContentsOfURL: URLtoHTML_forWebview  encoding: NSUTF8StringEncoding  error: nil];
        gbl_perDataLines     = [perDataStr componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
  NSLog(@"gbl_perDataLines.count    =[%ld]",gbl_perDataLines.count    );

// Log all data in gbl_perDataLines file array contents    for test <.>
for (id eltTst in gbl_perDataLines) { NSLog(@"    gbl_per=%@", eltTst); }

    } // end of if   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] // home + personality




    // run grpof2 report
    // load new grpof2 TBLRPT  report data from URLtoHTML_forWebview into array gbl_compDataLines 
    //
    if ( [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] )  // grpof2 // compatibility report  (just 2)
    {
// TODO 

//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) 
//    if ([gbl_currentMenuPlusReportCode hasSuffix: @"co"])  // compatibility report  (just 2)
        tn();trn("in Compatibility Potential!");
        

        char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
        char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
        const char *my_psvc; // psv=pipe-separated values
        char my_psv[128];
        
//        char csv_person_string[128];
        char  csv_person1_string[128], csv_person2_string[128];
//        char person_name_for_filename[32];
        char  person1_name_for_filename[32], person2_name_for_filename[32];
//        char myStringBuffForTraitCSV[64];
        
//        char  yyyy_todo[16], yyyymmdd_todo[16], stringBuffForStressScore[64] ;
//        const char *yyyy_todoC;
//        const char *yyyymmdd_todoC;
        int retval; // retval2;

        char   html_file_name_browser[2048], html_file_name_webview[2048];
        NSString *Ohtml_file_name_browser, *Ohtml_file_name_webview;
        NSString *OpathToHTML_browser,     *OpathToHTML_webview;
        char     *pathToHTML_browser,      *pathToHTML_webview;
        
        NSURL *URLtoHTML_forWebview;
//        NSURL *URLtoHTML_forEmailing;    ?????????????
//        NSURLRequest *HTML_URLrequest;
        NSArray* tmpDirFiles;
    
        do { // assemble person1 CSV
//  NSLog(@"gbl_viewHTML_PSV_personA=%@",gbl_viewHTML_PSV_personA);

//            my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA
//            my_psvc = [gbl_viewHTML_PSV_personA cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA
            my_psvc = [gbl_TBLRPTS1_PSV_personA cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA

            strcpy(my_psv, my_psvc); // because of const
//ksn(my_psv);            
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
            
            strcpy(person1_name_for_filename, psvName);
            scharswitch(person1_name_for_filename, ' ', '_');

//ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
//ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
            
            // get longitude and timezone hoursDiff from Greenwich
            // by looking up psvCity, psvProv, psvCountry
            //
            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
//ksn(returnPSV);            
            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
//ksn(psvHoursDiff);
//ksn(psvLongitude);
            // set gbl for email
            gbl_person_name =  [NSString stringWithUTF8String:psvName ];
//  NSLog(@"gbl_person_name =%@",gbl_person_name );
            // build csv arg for report function call
            //
            sprintf(csv_person1_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
            ksn(csv_person1_string);tn();

        } while (NO);  // assemble person1 CSV   (do only once)
        
        do { // assemble person2 CSV
//            my_psvc = [gbl_fromSelSecondPersonPSV cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C  for pco/personB
//            my_psvc = [gbl_viewHTML_PSV_personB cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C  for pco/personB
            my_psvc = [gbl_TBLRPTS1_PSV_personB cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA

            strcpy(my_psv, my_psvc); // because of const
            
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
            
            strcpy(person2_name_for_filename, psvName);
            scharswitch(person2_name_for_filename, ' ', '_');
            
     
//ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
//ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
            
            // get longitude and timezone hoursDiff from Greenwich
            // by looking up psvCity, psvProv, psvCountry
            //
            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
            
            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
            
            // set gbl for email
            gbl_person_name2 =  [NSString stringWithUTF8String:psvName ];

            // build csv arg for report function call
            //
            sprintf(csv_person2_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
            ksn(csv_person2_string);tn();
            
        } while (NO);  // assemble person2 CSV   (do only once)

        // build HTML file name, path name, an URL in  TMP  Directory
        //
        sprintf(html_file_name_browser,
                "%sgrpof2_%s_%s.html", PREFIX_HTML_FILENAME, person1_name_for_filename, person2_name_for_filename);
        sprintf(html_file_name_webview,
                "%sgrpof2_%s_%s_webview.html", PREFIX_HTML_FILENAME, person1_name_for_filename, person2_name_for_filename);

//        Ohtml_file_name = [NSString stringWithUTF8String:html_file_name ];
//        OpathToHTML = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name];
//        pathToHTML = (char *) [OpathToHTML cStringUsingEncoding:NSUTF8StringEncoding];
//        /* for use in WebView */
//        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name]];
        
    
        
        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
        
        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser];
        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
        
        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
    
        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
        
        //URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser]];  // for test
        //ksn(pathToHTML_browser);
        
        gbl_pathToFileToBeEmailed = OpathToHTML_browser;


        // remove all "*.html" files from TMP directory before creating new one
        //
        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
//        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
        
        for (NSString *fil in tmpDirFiles) {
//            NSLog(@"file to DELETE=%@",fil);
            if ([fil hasSuffix: @"html"]) {
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
            }
        }
        
        
        tn();trn("doing compatibility potential c call   mamb_report_just_2_people");
        
        ks(html_file_name_webview);
        
        retval = mamb_report_just_2_people(
                                           pathToHTML_browser,
                                           pathToHTML_webview,
                                           csv_person1_string,
                                           csv_person2_string
                                           );

        tn();trn("returning from  compatibility potential c call   mamb_report_just_2_people");





        // set gbl_compDataLines;  // used in tblrpts_1 (read in from webview . html file)
        //
        //
        // URLtoHTML_forWebview  (a ".html" file) actually has data lines to be used for uitableview version
        //
        NSString *compDataStr = [NSString stringWithContentsOfURL: URLtoHTML_forWebview  encoding: NSUTF8StringEncoding  error: nil];
        gbl_compDataLines     = [compDataStr componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];

  NSLog(@"gbl_compDataLines.count    =[%ld]",gbl_compDataLines.count    );
//int kk;
//for (kk=0; kk <= 20; kk++)
//{tn();ki(kk);
//  NSLog(@"gbl_compDataLines[kk]=[%@]",gbl_compDataLines[kk]);
//}

// Log all data in gbl_compDataLines file array contents    for test <.>
//for (id eltTst in gbl_compDataLines) { NSLog(@"    gbl_comp=%@", eltTst); }


        // for CALCULATING the WIDTH of the Compatibility Potential table at the top
        // we need the size of the 2 names
        //
        // find the line    lin=[tabl|pair@26@~Emma@~Anya]
        //
        // max table line len is like:  |~Emma..~Anya..99.Not.Good|
        //   nam1 + 2 + nam2 + 11            5 2    5 2         11 
        //
        NSArray *tmpArray3;
        for (int iii = 0; iii <= gbl_compDataLines.count - 1; iii++) {

            if ([gbl_compDataLines[iii] hasPrefix: @"tabl|pair"]) {
                // _lin=[tabl|pair@space above@@]__
                // _lin=[tabl|pair@26@~Emma@~Anya]__
                // _lin=[tabl|pair@space below@@]__
                tmpArray3 = [gbl_compDataLines[iii] componentsSeparatedByCharactersInSet: 
                    [NSCharacterSet characterSetWithCharactersInString:@"@"]
                ];
                if (tmpArray3.count == 4) {
                    gbl_pairScore   = tmpArray3[1];
                    gbl_pairPersonA = tmpArray3[2];
                    gbl_pairPersonB = tmpArray3[3];

                    if ( [gbl_pairPersonA hasPrefix: @"space "]) continue;

                    gbl_topTableWidth = 1 + gbl_pairPersonA.length + 2 + gbl_pairPersonB.length + 2 + 11 + 1;  // 1= space
                    gbl_topTableNamesWidth = 1 + gbl_pairPersonA.length + 2 + gbl_pairPersonB.length + 2;  // 1= space

                    //    there are long and short lines depending on the 2 name lengths
                    //
                    if (gbl_pairPersonA.length + gbl_pairPersonB.length > gbl_ThresholdshortTblLineLen) {
                        gbl_topTablePairLine = [NSString stringWithFormat:  @"| %@  %@  %@ |", // NO 11 spaces at end
                            gbl_pairPersonA,
                            gbl_pairPersonB,
                            gbl_pairScore
                        ];
                    } else {
                        gbl_topTablePairLine = [NSString stringWithFormat:  @"| %@  %@  %@           |", // 11 spaces at end
                            gbl_pairPersonA,
                            gbl_pairPersonB,
                            gbl_pairScore
                        ];
                    }
                }
                break;
            }
        }
  NSLog(@"gbl_pairScore        =[%@]",gbl_pairScore   );
  NSLog(@"gbl_pairPersonA      =[%@]",gbl_pairPersonA );
  NSLog(@"gbl_pairPersonB      =[%@]",gbl_pairPersonB );
  NSLog(@"gbl_topTableWidth    =[%ld]",(long)gbl_topTableWidth );
  NSLog(@"gbl_topTablePairLine =[%@]",gbl_topTablePairLine );


    } // end of if   [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] // home + compatibility





    if( gbl_TBLRPTS1_saveSelectedIndexPath ) {  // THIS SIMULATES a SELECT animation followed by a DESELECT animation (it works)
//       [self.tableView   selectRowAtIndexPath: gbl_IdxPathSaved_SelPerson
//                                     animated: YES 
//                               scrollPosition: UITableViewScrollPositionNone];
//

//        [[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]] setHighlighted:YES];

//  NSLog(@"1000!");
        [[self.tableView cellForRowAtIndexPath: gbl_TBLRPTS1_saveSelectedIndexPath] setHighlighted: YES
                                                                                          animated: YES ];
//
//    dispatch_async(dispatch_get_main_queue(), ^{                         
////  NSLog(@"1001!");
//        [NSThread sleepForTimeInterval:0.5];   // <<=====   this WORKS  1/2 second
////  NSLog(@"1002!");
//    });                                   
//

        dispatch_async(dispatch_get_main_queue(), ^{                         
            usleep(500000); //   1/2 second //usleep(useconds_t useconds) microseconds
        });                                   


        [[self.tableView cellForRowAtIndexPath: gbl_TBLRPTS1_saveSelectedIndexPath] setHighlighted: NO
                                                                                          animated: YES ];
//  NSLog(@"1003!");
//        [cell setHighlighted:YES animated:NO];

//       [self.tableView deselectRowAtIndexPath: gbl_IdxPathSaved_SelPerson
//                                     animated: YES ];

        gbl_TBLRPTS1_saveSelectedIndexPath = nil;
    }




    // -------------------------------------------------------------------------------------------------------------------------
    // MAMB09viewTBLRPTs_1_TableViewController.m  displays 9 RPTs  hompbm,homgbm, homgma,homgme,homgmr,homgmp,homgmd homgby,homgbd
    //
    // NOTE that gbl_currentMenuPlusReportCode changes when the user views a report from any of these RPTs 
    //      so, in viewWillAppear(), when the user returns, we have to re-set  gbl_currentMenuPlusReportCode  (check it out)
    // -------------------------------------------------------------------------------------------------------------------------
//<.>
    do {   // re-set gbl_currentMenuPlusReportCode, if necessary

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
  NSLog(@"BEFORE RESET   gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

             if ([gbl_currentMenuPlusReportCode isEqualToString: @"pbmco" ]) gbl_currentMenuPlusReportCode = @"hompbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]) gbl_currentMenuPlusReportCode = @"hompbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]) gbl_currentMenuPlusReportCode = @"hompbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]) gbl_currentMenuPlusReportCode = @"hompbm";

        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbmco" ]) gbl_currentMenuPlusReportCode = @"homgbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]) gbl_currentMenuPlusReportCode = @"homgbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]) gbl_currentMenuPlusReportCode = @"homgbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]) gbl_currentMenuPlusReportCode = @"homgbm";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]) gbl_currentMenuPlusReportCode = @"homgbm";

        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmappe"]) gbl_currentMenuPlusReportCode = @"homgma";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmeppe"]) gbl_currentMenuPlusReportCode = @"homgme";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmrppe"]) gbl_currentMenuPlusReportCode = @"homgmr";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmpppe"]) gbl_currentMenuPlusReportCode = @"homgmp";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmdppe"]) gbl_currentMenuPlusReportCode = @"homgmd";

        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbypcy"]) gbl_currentMenuPlusReportCode = @"homgby";
        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]) gbl_currentMenuPlusReportCode = @"homgbd";


  NSLog(@"AFTER  RESET   gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

    } while (FALSE);   // re-set gbl_currentMenuPlusReportCode, if necessary




    char  yyyy_todo[16], yyyymmdd_todo[16], stringBuffForStressScore[64] ;
    const char *yyyy_todoC;
    const char *yyyymmdd_todoC;


//<.> old spot for add nar bar stuff





// ?  ?  ?
//StART  of GUTS of ViewDidLoad (called only once) moved to ViewWillAppear (called each time becomes visible)
//
//  viewDidLoad
//  Is called exactly once, when the view controller is first loaded into memory.
//  This is where you want to instantiate any instance variables and
//  build any views that live for the entire lifecycle of this view controller.
//  
//  viewDidAppear
//  Is called when the view is actually visible,
//  and can be called multiple times during the lifecycle of a View Controller
//  (example when a Modal View Controller is dismissed and the view becomes visible again)
//

    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
    int retval;

//    char csv_person_string[128];
//    char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
    const char *my_psvc; // psv=pipe-separated values
//    char my_psv[128];
    
    const char *tmp_grp_name_CONST;                                                         // NSString object to C str
    char tmp_grp_name[128];                                                                 // NSString object to C str
    tmp_grp_name_CONST = [gbl_lastSelectedGroup cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
    strcpy(tmp_grp_name, tmp_grp_name_CONST);                                               // NSString object to C str  because of const
    

    char person_name_for_filename[32];
    char group_name_for_filename[32]; 

    char   html_file_name_browser[2048];
    NSString *Ohtml_file_name_browser;
    NSString *OpathToHTML_browser;
    char     *pathToHTML_browser;

//    char   html_file_name_webview[2048];
//    NSString *Ohtml_file_name_webview;
//    NSString *OpathToHTML_webview;
//    char     *pathToHTML_webview;

    NSArray* tmpDirFiles;
    
    // all BEST MATCH ... reports  ======================================================================================
    // all BEST MATCH ... reports  ======================================================================================
    //
//tn();trn("before kingpin set");
//  NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@",gbl_currentMenuPrefixFromMatchRpt);
//  NSLog(@"gbl_lastSelPersonWasA =%@",gbl_lastSelPersonWasA );
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//  NSLog(@"gbl_kingpinPersonName=%@",gbl_kingpinPersonName);
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//  NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//  NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
//

//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]      // My Best Match in Group ...
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]      //    Best Match in Group ...
////      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]      // My Best Match in Group ...  see tblrps_2 view
////      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]      // My Best Match in Group ...
////      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]      // My Best Match in Group ...
//    )
//        // all BEST MATCH ... reports
//

            // all BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------
            //
nbn(200);
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm" ]  // My Best Match in Group ...
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"    ]  // My Best Match in Group ...
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ]  //    Best Match in Group ...
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ]  //    Best Match in Group ...

            // gbl_PSVtappedPerson_grpall;     // gbm1pe,gbm2pe,gbm1bm,gbm2bm 
            // gbl_PSVtappedPerson_grpone;     // pbm1pe,pbm2pe,pbm2bm       

    ) {   // all BEST MATCH ... reports  PLUS all reports AFTER THAT in navigation <-------------

nbn(201);
        tn();trn("in REPORT  all BEST MATCH ... reports !");

        //        NSString myTitleForTableview;

        NSString *myKingpinPerson;
        NSString *myKingpinCSV_NSString;
        const char *C_CONST_myKingpinPerson;   // for get c string
        char        C_myKingpinPerson[64];     // for get c string

        // determine the NSString CSV of the kingpin person (or @"") for this match report
        //
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]  // My Best Match in Group ...
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ]  // My Best Match in Group ...
        ) {
           myKingpinPerson       = gbl_lastSelectedPerson;
           myKingpinCSV_NSString = gbl_fromHomeCurrentSelectionPSV;
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]  // Best Match in Group ...
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ]  // Best Match in Group ...
        ) {
           myKingpinPerson       = @"";
           myKingpinCSV_NSString = @"";
        }

        gbl_kingpinPersonName = myKingpinPerson;

//myKingpinPerson       =  @"~Ava";
//myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
//NSLog(@" TEST 1  myKingpinCSV_NSString =%@",myKingpinCSV_NSString );
//myKingpinPerson       =  @"~Avaxxxxxxxx";
//myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
//NSLog(@" TEST 2  myKingpinCSV_NSString =%@",myKingpinCSV_NSString );
//

        if (myKingpinCSV_NSString == nil) {
            NSLog(@"Could not find person record for person name=%@",myKingpinPerson);
            NSLog(@"using ~Abigail ");
            myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: @"~Abibail"]; 
        }

        /* get C string for NSString myKingpinPerson
        */

        if ([myKingpinPerson isEqualToString: @""]  ||  myKingpinPerson == nil) {    // My Best Match in Group ...
            strcpy(C_myKingpinPerson, "no person");
        } else {
            C_CONST_myKingpinPerson = myKingpinPerson.UTF8String;   // for grpone
            strcpy(C_myKingpinPerson, C_CONST_myKingpinPerson);
        }

        
    NSLog(@"gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
    NSLog(@"gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );

        // build HTML file name  in TMP  Directory  (html_file_name_browser);
        //
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]  // Best Match in Group ...
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ]  // Best Match in Group ...
        ) {
            strcpy(group_name_for_filename, tmp_grp_name );  
            scharswitch(group_name_for_filename, ' ', '_');
            sprintf(html_file_name_browser, "%sgrpall_%s.html", PREFIX_HTML_FILENAME, group_name_for_filename);

        } 
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]  // My Best Match in Group ...
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ]  // My Best Match in Group ...
        ) {

            strcpy(person_name_for_filename, C_myKingpinPerson);
            scharswitch(person_name_for_filename, ' ', '_');

            strcpy(group_name_for_filename, tmp_grp_name );  
            scharswitch(group_name_for_filename, ' ', '_');

            sprintf(html_file_name_browser, "%sgrpone_%s_%s.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
        }
// sprintf(html_file_name_webview, "%sgrpone_%s_%swebview.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
        
        
        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
//        gbl_html_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];   // for later viewing in webview


        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
        
//        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
//        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
//        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
//
        
        gbl_pathToFileToBeEmailed = OpathToHTML_browser;
        
        // remove all "*.html" files from TMP directory before creating new one
        //
        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
        for (NSString *fil in tmpDirFiles) {
            NSLog(@"REMOVED THIS fil=%@",fil);
            if ([fil hasSuffix: @"html"]) {
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
            }
        }
   
        
        tn();trn("2 HTMLs !!!!!!!!!!!!!!!!!!!!");
//        nksn(html_file_name_browser); ksn( html_file_name_webview);
//        nksn(pathToHTML_browser); ksn(pathToHTML_webview);
//
        NSLog(@"Ohtml_file_name_browser=%@",Ohtml_file_name_browser);
        NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);




//  NSLog(@" 2 gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);

        // get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs
        // but possibly excluding  one person who is kingpin of grpone report "MY Best Match in Group ..." 
        //
        gbl_kingpinIsInGroup = [myappDelegate getNSArrayOfCSVsForGroup: (NSString *)  gbl_lastSelectedGroup  // get into NSArray gbl_grp_CSVs
                                               excludingThisPersonName: (NSString *)  myKingpinPerson        // non-empty string means grpone
                                       puttingIntoArrayWithDescription: (NSString *)  @"gbl_grp_CSVs"        // destination array "" or "_B"
        ];  



  NSLog(@"gbl_kingpinIsInGroup =%ld",(long)gbl_kingpinIsInGroup );
//NSLog(@"gbl_grp_CSVs =%@",gbl_grp_CSVs ); // for test see all grp CSVs
//kin((int)gbl_grp_CSVs.count);


            // here we can store the number of pairs ranked  in  gbl_numPairsRanked (for column header size calc)
            //
            if ([myKingpinPerson isEqualToString: @""]  ||  myKingpinPerson == nil) {    // Best Match in Group ...
                gbl_numPairsRanked = ( gbl_grp_CSVs.count * (gbl_grp_CSVs.count - 1)) / 2;  // for grpall
            } else {
                gbl_numPairsRanked = gbl_grp_CSVs.count;   // (getNSArrayOfCSVsForGroup subtracts one if kingpin is in group)
            }
  NSLog(@"gbl_numPairsRanked =%ld",(long)gbl_numPairsRanked );


        //
        // convert  NSArray gbl_grp_CSVs  (one NSString CSV for each member of the group)
        // into     a C array of strings for the C report function call mamb_report_person_in_group() -  my_mamb_csv_arr
        //
        //     char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
        //
        // avoid malloc by this char buffer  to hold max lines of fixed length
        // char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
        // int  group_report_input_birthinfo_idx;
        //
        char *my_mamb_csv_arr[gbl_maxGrpBirthinfoCSVs];
        int num_input_csvs;
        num_input_csvs = (int)gbl_grp_CSVs.count;
        group_report_input_birthinfo_idx =  -1;  // zero-based  init

        for(int i = 0; i < num_input_csvs; i++) {  

          NSString *s      = gbl_grp_CSVs[i];     //get a NSString
          const char *cstr = s.UTF8String;        //get cstring

          // index of next spot in buffer
          group_report_input_birthinfo_idx = group_report_input_birthinfo_idx + 1; 

          // get ptr to next 64-byte slot in buffer
          char *my_ptr_in_buff;
          my_ptr_in_buff = group_report_input_birthinfo_CSVs + group_report_input_birthinfo_idx * gbl_maxLenBirthinfoCSV;

          // copy cstr into that spot
          strcpy(my_ptr_in_buff, cstr); 

          // put ptr to that spot into c array of strings
          my_mamb_csv_arr[group_report_input_birthinfo_idx] = my_ptr_in_buff;
        }

//for (int kkk=0; kkk <= num_input_csvs -1; kkk++) {
//tn();ki(kkk);ks(my_mamb_csv_arr[kkk]); }
//

        

//        /* Now call report function in grpdoc.c
//        * 
//        *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
//        *  int out_rank_idx;  * pts to current line in out_rank_lines *
//        */
//        int out_rank_idx, retval;
//        out_rank_idx = 0;
//        retval = mamb_report_person_in_group(  /* in grpdoc.o */
//          html_file_name,      /* html_file_name */
//          group_name,          /* group_name */
//          mamb_csv_arr,        /* in_csv_person_arr[] */
//          num_in_grp,          /* num_persons_in_grp */
//          csv_compare_everyone_with,
//          out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
//          &out_rank_idx 
//        );
//
//        if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}
//
//


        // 1 different report invocation  for grpall (homgbm)
        // 4 different report invocations for grpone (hompbm, gbm1gm, gbm2bm, pbm2bm)
        //
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]       // Best Match in Group ...  this is grpall
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"   ]       // Best Match in Group ...  this is grpall

        ) { // grpall

//// TODO

//tn();trn("todo   GRPALL HERE pppppppppppppppppppppppppppppppppppppppppppp");
//  NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);


tn();trn("calling  mamb_report_whole_group() ...");
//ksn(pathToHTML_browser);
//ksn(tmp_grp_name);
//ksn(my_mamb_csv_arr[0]);
//ksn(my_mamb_csv_arr[1]);
//kin(num_input_csvs);
//tn();
//
            retval = mamb_report_whole_group(  /* in grpdoc.o */
              pathToHTML_browser,          // path to html_file
              tmp_grp_name,                // group_name */
              my_mamb_csv_arr,             // from   group_report_input_birthinfo_CSVs
              num_input_csvs,              // num_persons_in_grp xxzz
              "",  // instructions,  sprintf(instructions_for_top_bot, "top_this_many=|%d|bot_this_many=|%d|", top_this_many, bot_this_many);
              "",                  /* buffer for string_for_table_only  */
              group_report_output_PSVs,    // array of output report data
              &group_report_output_idx     // ptr to int having last index written
            );
//kin(retval);
//kin(group_report_output_idx);
//char my_tst_str[128];
//strcpy(my_tst_str, group_report_output_PSVs  +  0 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=0");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  1 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=1");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  2 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=2");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  3 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=3");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  4 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=4");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  5 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=5");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  6 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=6");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  7 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=7");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  8 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=8");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  9 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=9");ksn(my_tst_str);
//trn("in cocoa  returning from call of   mamb_report_whole_group() ...");
//tn();
//

            if (retval != 0) {tn(); trn("non-zero retval from mamb_report_whole_group()");}

        }

        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] // *MY*  Best Match in Group ...  this is grpone
            || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"   ] // *MY*  Best Match in Group ...  this is grpone
        ) { // grpone
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]
//                || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]

//
//NSString *gbl_PSVtappedPerson_grpone;  // pbm1pe,pbm2pe,pbm2bm
//NSString *gbl_PSVtappedPerson_grpall;  // gbm1pe,gbm2pe,gbm1bm,gbm2bm
//NSString *gbl_PSVtappedPerson_grpmost; // gmappe,gmeppe,gmrppe,gmpppe,gmdppe
//NSString *gbl_PSVtappedPerson_grpbest; // gbypcy,gbdpwc
//NSString *gbl_PSVtappedPersonA_inPair; // pbmco,gbmco
//NSString *gbl_PSVtappedPersonB_inPair; // pbmco,gbmco
//
//

            // get kingpin CSV  for C call
                // NSString object to C
                my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
                char my_psv[128];
                strcpy(my_psv, my_psvc);
                
                char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
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
                
                // get longitude and timezone hoursDiff from Greenwich
                // by looking up psvCity, psvProv, psvCountry
                //
                seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
                
                strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
                strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));

                // build csv arg for report function call
                //
                char csv_kingpin[128];
                sprintf(csv_kingpin, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                        psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
            // end of  get kingpin CSV  for C call
//ksn(csv_kingpin);



tn();trn("DOING person in group ... in tblrpts 111111"); ks(html_file_name_browser);
            // Now call  grpone   report function in grpdoc.c
            //
            tn();trn("in TBLRPT 1  calling  mamb_report_person_in_group() ..."); 
            retval = mamb_report_person_in_group(  /* in grpdoc.o */
              pathToHTML_browser,          // path to html_file
              tmp_grp_name,                // group_name */
              my_mamb_csv_arr,             // from   group_report_input_birthinfo_CSVs
              num_input_csvs,              // num_persons_in_grp xxzz
              csv_kingpin,                 // csv_compare_everyone_with,
              group_report_output_PSVs,    // array of output report data
              &group_report_output_idx,    // ptr to int having last index written
              (int)gbl_kingpinIsInGroup
            );

//kin(retval);
//kin(group_report_output_idx);
//char my_tst_str[128];
//strcpy(my_tst_str, group_report_output_PSVs  +  0 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=0");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  1 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=1");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  2 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=2");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  3 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=3");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  4 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=4");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  5 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=5");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  6 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=6");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  7 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=7");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  8 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=8");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  9 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("grpone group_report_output_PSVs  idx=9");ksn(my_tst_str);
//trn("in cocoa  returning from call of   grpone ...");
//tn();
//

//tn();trn("in TBLRPT 1  returned from  mamb_report_person_in_group() ...");
//ksn(pathToHTML_browser);
//ksn(tmp_grp_name);
//kin(num_input_csvs);
//ksn(csv_kingpin);
//kin(group_report_output_idx);
//kin(retval);
//
            if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}



//  [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[d[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
        } // grpone  NEW place


        do {  // populate  gbl_array_cellBGcolorName gbl_array_cellPersonAname gbl_array_cellPersonBname
//tn();trn("// populate  gbl_array_cellBGcolorName gbl_array_cellPersonAname gbl_array_cellPersonBname");

            // now that we have group_report_output_PSVs, grab all BG color for all tableview cells
            // and put into   NSArray *gbl_array_cellBGcolorName;
            //
            char my_buff[256];
            NSMutableString *myCellContentsPSV;
            NSArray  *tmpArray3;
            NSMutableString *curr_cellBGcolorName;
    //            NSMutableString *curr_cellPersonAname;
    //            NSMutableString *curr_cellPersonBname;
    //
            NSString *curr_cellPersonAnameTMP;
            NSString *curr_cellPersonBnameTMP;
            NSString *curr_cellPersonAname;
            NSString *curr_cellPersonBname;


            NSCharacterSet  *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];

            [gbl_array_cellBGcolorName removeAllObjects];               // empty array for BG colors for these new cells
            [gbl_array_cellPersonAname removeAllObjects];               // empty array for personA   for these new cells
            [gbl_array_cellPersonBname removeAllObjects];               // empty array for personB   for these new cells

            gbl_array_cellBGcolorName = [[NSMutableArray alloc] init];  // init  array for BG colors for these new cells
            gbl_array_cellPersonAname = [[NSMutableArray alloc] init];  // init  array
            gbl_array_cellPersonBname = [[NSMutableArray alloc] init];  // init  array 

    //tn();kin(group_report_output_idx);

            NSString *myHedColor = @"cHed";

            for (int i=0; i <= group_report_output_idx + 3; i++) {  // group_report_output_idx = last index written

                if (i == group_report_output_idx + 1) {
                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 1  // add the BG colors of the 3 footer cells
                   continue;
                }
                if (i == group_report_output_idx + 2) {
                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 2
                   continue;
                }
                if (i == group_report_output_idx + 3) {
                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 3
                   continue;
                }
                strcpy(my_buff, group_report_output_PSVs  +  i * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW
    //tn();ki(i);ks(my_buff);

                myCellContentsPSV     = [NSMutableString stringWithUTF8String: my_buff];  // convert c string to NSString
                tmpArray3             = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];

                curr_cellBGcolorName    = tmpArray3[0];
                curr_cellPersonAnameTMP = tmpArray3[2];
                curr_cellPersonBnameTMP = tmpArray3[3];

    //tn();  NSLog(@"curr_cellPersonAnameTMP =%@",curr_cellPersonAnameTMP );
    //  NSLog(@"curr_cellPersonBname  =%@",curr_cellPersonBname  );

    //                // replace '_' from pair names with ' '    (underscore only in cell in tableview)
    //                [curr_cellPersonAname replaceOccurrencesOfString: @"_"
    //                                                      withString: @" "
    //                                                         options: 0
    //                                                           range: NSMakeRange(0, curr_cellPersonAname.length)
    //                ];

                // in pair reports (Best Match ...) blanks go to '_' to make pairs more readable when a name has a blank in it
                curr_cellPersonAname = [curr_cellPersonAnameTMP stringByReplacingOccurrencesOfString: @"_"
                                                                                          withString: @" "];
                curr_cellPersonBname = [curr_cellPersonBnameTMP stringByReplacingOccurrencesOfString: @"_"
                                                                                          withString: @" "];

                [gbl_array_cellBGcolorName addObject: curr_cellBGcolorName]; 
                [gbl_array_cellPersonAname addObject: curr_cellPersonAname];
                [gbl_array_cellPersonBname addObject: curr_cellPersonBname];
            }
        } while (false);   // populate  gbl_array_cellBGcolorName gbl_array_cellPersonAname gbl_array_cellPersonBname


//        if (retval == 0) {
//           
//            // show all files in temp dir
//            NSFileManager *manager = [NSFileManager defaultManager];
//            NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
//            for (NSString *s in fileList){
//                NSLog(@"TEMP DIR %@", s);
//            }
//            
//            
//             /* here, go and look at html report */
//             // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
//             
//             self.outletWebView.scalesPageToFit = YES;
//             
//             // I was having the same problem. I found a property on the UIWebView
//             // that allows you to turn off the data detectors.
//             //
//             self.outletWebView.dataDetectorTypes = UIDataDetectorTypeNone;
//            
//             // place our URL in a URL Request
//             HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
//             
//             // UIWebView is part of UIKit, so you should operate on the main thread.
//             //
//             // old= [self.outletWebView loadRequest: HTML_URLrequest];
//             //
//             dispatch_async(dispatch_get_main_queue(), ^(void){
//                 [self.outletWebView loadRequest:HTML_URLrequest];
//             });
//        }
//

    }  // END of   all BEST MATCH ... reports  ======================================================================================

// END  of GUTS of ViewDidLoad (called only once) moved to ViewWillAppear (called each time becomes visible)

nbn(299);


        // reminder: this is in viewDidAppear

// ALL  MOST and BEST  group reports
//
  NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);
    char trait_name_for_C_call[64];

    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]      // group Best RPTs
      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]      
    ) { // ALL  MOST and BEST  group reports

        NSLog(@"MOST and BEST  gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );

nbn(500);
        do { // build HTML file name  in TMP  Directory  (html_file_name_browser);

            strcpy(group_name_for_filename, tmp_grp_name );  
            scharswitch(group_name_for_filename, ' ', '_');

            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"] ) {
                strcpy(trait_name_for_C_call, "assertive");
                sprintf(html_file_name_browser, "%sgrptra_%s_assertive.html",   PREFIX_HTML_FILENAME, group_name_for_filename);
            } 
            if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgme"] ) {
                strcpy(trait_name_for_C_call, "emotional");
                sprintf(html_file_name_browser, "%sgrptra_%s_emotional.html",   PREFIX_HTML_FILENAME, group_name_for_filename);
            } 
            if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmr"] ) {
                strcpy(trait_name_for_C_call, "restless");
                sprintf(html_file_name_browser, "%sgrptra_%s_restless.html",    PREFIX_HTML_FILENAME, group_name_for_filename);
            } 
            if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmp"] ) {
                strcpy(trait_name_for_C_call, "passionate");
                sprintf(html_file_name_browser, "%sgrptra_%s_passionate.html",  PREFIX_HTML_FILENAME, group_name_for_filename);
            } 
            if (   [gbl_currentMenuPlusReportCode       hasPrefix: @"homgmd"] ) {
                strcpy(trait_name_for_C_call, "down to earth");
                sprintf(html_file_name_browser, "%sgrptra_%s_downtoearth.html", PREFIX_HTML_FILENAME, group_name_for_filename);
            } 

            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]) {
                strcpy(trait_name_for_C_call, "best year");
                sprintf(html_file_name_browser, "%sgrpbyr_%s.html", PREFIX_HTML_FILENAME, group_name_for_filename);
            }

            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]) {
                strcpy(trait_name_for_C_call, "best day");
                sprintf(html_file_name_browser, "%sgrpbdy_%s.html", PREFIX_HTML_FILENAME, group_name_for_filename);
            }


            gbl_html_file_name_browser = [NSString stringWithUTF8String: html_file_name_browser ];   // for later sending as email attachment
  NSLog(@"gbl_html_file_name_browser =%@",gbl_html_file_name_browser );

            // for webview html file name change ".html" to "webview.html"
            //
//              strcpy(html_file_name_webview, html_file_name_browser);
//              NSString *mytmpNSString = [NSString stringWithUTF8String: html_file_name_webview ];
//            gbl_html_file_name_webview =                                               // for later viewing in webview
//                [mytmpNSString stringByReplacingOccurrencesOfString: @".html"          // for later viewing in webview
//                                                         withString: @"webview.html"];


            Ohtml_file_name_browser = [NSString stringWithUTF8String: html_file_name_browser ];
            OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
            pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding: NSUTF8StringEncoding];
ksn(pathToHTML_browser);
            
//            Ohtml_file_name_webview = gbl_html_file_name_webview ;
//            OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent:  Ohtml_file_name_webview];
//            pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding: NSUTF8StringEncoding];
            
//            URLtoHTML_forWebview = [NSURL fileURLWithPath: [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
    
            gbl_pathToFileToBeEmailed = OpathToHTML_browser;


        tn();trn("2 HTMLs !!!!!!!!!!!!!!!!!!!!");
//nksn(html_file_name_browser);
//        ksn( html_file_name_webview);
        NSLog(@"Ohtml_file_name_browser=%@",Ohtml_file_name_browser);
        NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);
//nksn(pathToHTML_browser);

//        NSLog(@"Ohtml_file_name_webview=%@",Ohtml_file_name_webview);
//        NSLog(@"OpathToHTML_webview=%@",OpathToHTML_webview);
//        ksn(pathToHTML_webview);

NSLog(@"gbl_pathToFileToBeEmailed=%@",gbl_pathToFileToBeEmailed);

        } while (false);  // build HTML file name  in TMP  Directory  (html_file_name_browser);

            
        
        // remove all "*.html" files from TMP directory before creating new one
        //
        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
        for (NSString *fil in tmpDirFiles) {
            NSLog(@"REMOVED THIS fil=%@",fil);
            if ([fil hasSuffix: @"html"]) {
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
            }
        }


        // get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs
        // but possibly excluding  one person who is kingpin of grpone report "MY Best Match in Group ..." 
        //
        gbl_kingpinIsInGroup = [myappDelegate getNSArrayOfCSVsForGroup: (NSString *)  gbl_lastSelectedGroup  // get into NSArray gbl_grp_CSVs
                                               excludingThisPersonName: (NSString *)  @""   // myKingpinPerson  non-empty string means grpone
                                       puttingIntoArrayWithDescription: (NSString *)  @"gbl_grp_CSVs"        // destination array "" or "_B"
        ];  


        //
        // convert  NSArray gbl_grp_CSVs  (one NSString CSV for each member of the group)
        // into     a C array of strings for the C report function call mamb_report_person_in_group() -  my_mamb_csv_arr
        //
        //     char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
        //
        // avoid malloc by this char buffer  to hold max lines of fixed length
        // char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
        // int  group_report_input_birthinfo_idx;
        //
        char *my_mamb_csv_arr[gbl_maxGrpBirthinfoCSVs];
        int num_input_csvs;
        num_input_csvs = (int)gbl_grp_CSVs.count;
        group_report_input_birthinfo_idx =  -1;  // zero-based  init

        for(int i = 0; i < num_input_csvs; i++) {  

          NSString *s      = gbl_grp_CSVs[i];     //get a NSString
          const char *cstr = s.UTF8String;        //get cstring

          // index of next spot in buffer
          group_report_input_birthinfo_idx = group_report_input_birthinfo_idx + 1; 

          // get ptr to next 64-byte slot in buffer
          char *my_ptr_in_buff;
          my_ptr_in_buff = group_report_input_birthinfo_CSVs + group_report_input_birthinfo_idx * gbl_maxLenBirthinfoCSV;

          // copy cstr into that spot
          strcpy(my_ptr_in_buff, cstr); 

          // put ptr to that spot into c array of strings
          my_mamb_csv_arr[group_report_input_birthinfo_idx] = my_ptr_in_buff;
        }

//for (int kkk=0; kkk <= num_input_csvs -1; kkk++) {
//tn();ki(kkk);ks(my_mamb_csv_arr[kkk]); }


        /* Now call report function in grpdoc.c
        * 
        *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
        *  int out_rank_idx;  * pts to current line in out_rank_lines *
        */

        /*   if (strcmp(trait_name, "assertive")     == 0)  fldnum = 1; * one-based *
        *   if (strcmp(trait_name, "emotional")     == 0)  fldnum = 2;
        *   if (strcmp(trait_name, "restless")      == 0)  fldnum = 3;
        *   if (strcmp(trait_name, "down to earth") == 0)  fldnum = 4;
        *   if (strcmp(trait_name, "passionate")    == 0)  fldnum = 5;
        *   if (strcmp(trait_name, "ups and downs") == 0)  fldnum = 6;  XXXXXX
        */

        /* Now call report function in grpdoc.c
        * 
        *  grpdoc.c populates array of report line data defined here.
        *
        *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
        *  int out_rank_idx;  * pts to current line in out_rank_lines *
        */

        if (  [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]      // group Most RPTs
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]      
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] 
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
          ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
        ) {    // ALL  MOST and BEST  group reports


tn();trn("calling  mamb_report_trait_rank() ...");
ksn(pathToHTML_browser);
ksn(tmp_grp_name);
ksn(my_mamb_csv_arr[0]);
ksn(my_mamb_csv_arr[1]);
kin(num_input_csvs);
tn();
            retval = mamb_report_trait_rank(  /* in grpdoc.o */
              pathToHTML_browser,     /* html_file_name */
              tmp_grp_name,           /* group_name */
              my_mamb_csv_arr,        /* in_csv_person_arr[] */
              num_input_csvs,         /* num_persons_in_grp */
              trait_name_for_C_call,  /* assertive, emotional, etc 6 of them, see above  */
              group_report_output_PSVs,    // array of output report data
              &group_report_output_idx     // ptr to int having last index written
            );

            tn();trn("finished doing  trait rank ...");  ks(pathToHTML_browser);
            if (retval != 0) {tn(); trn("non-zero retval from mamb_report_trait_rank()");}

         }  // ALL  MOST and BEST  group reports

         if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"] )    // group Best year rpt
         {
             sfill(stringBuffForStressScore, 60, ' ');
             
             yyyy_todoC = [gbl_lastSelectedYear cStringUsingEncoding:NSUTF8StringEncoding];
             strcpy(yyyy_todo, yyyy_todoC);

             /* Now call report function in grpdoc.c
             * 
             *  grpdoc.c populates array of report line data defined here.
             */
tn();trn("calling  mamb_report_best_year() ...");
ksn(pathToHTML_browser);
ksn(tmp_grp_name);
ksn(my_mamb_csv_arr[0]);
ksn(my_mamb_csv_arr[1]);
kin(num_input_csvs);
ksn(yyyy_todo);
tn();
             retval = mamb_report_best_year(  /* in grpdoc.o */
               pathToHTML_browser,     /* html_file_name */
               tmp_grp_name,           /* group_name */
               my_mamb_csv_arr,        /* in_csv_person_arr[] */
               num_input_csvs,         /* num_persons_in_grp */
               yyyy_todo,           /* calendar year */
//               out_group_report_PSVs,   /* array of output report data to pass to cocoa */
//               &out_group_report_idx       /* ptr to int having last index written */
               group_report_output_PSVs,    // array of output report data
               &group_report_output_idx     // ptr to int having last index written
             );

             if (retval != 0) {tn(); trn("non-zero retval from mamb_report_best_year()");}

         }    // group Best year rpt
      

         if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"] )    // group Best day  rpt   
         {
             yyyymmdd_todoC = [gbl_lastSelectedDay cStringUsingEncoding:NSUTF8StringEncoding];
             strcpy(yyyymmdd_todo, yyyymmdd_todoC);

             /* Now call report function in grpdoc.c
             * 
             *  grpdoc.c populates array of report line data defined here.
             */
tn();trn("calling  mamb_report_best_day() ...");
ksn(pathToHTML_browser);
ksn(tmp_grp_name);
ksn(my_mamb_csv_arr[0]);
ksn(my_mamb_csv_arr[1]);
kin(num_input_csvs);
ksn(yyyymmdd_todo);
tn();
             retval = mamb_report_best_day(  /* in grpdoc.o */
               pathToHTML_browser,     /* html_file_name */
               tmp_grp_name,           /* group_name */
               my_mamb_csv_arr,        /* in_csv_person_arr[] */
               num_input_csvs,         /* num_persons_in_grp */
               yyyymmdd_todo,           /* day to do */
//               out_group_report_PSVs,   /* array of output report data to pass to cocoa */
//               &out_group_report_idx       /* ptr to int having last index written */
               group_report_output_PSVs,    // array of output report data
               &group_report_output_idx     // ptr to int having last index written
             );

             if (retval != 0) {tn(); trn("non-zero retval from mamb_report_best_day ()");}

          }    // group Best day  rpt   


        //kin(retval);
kin(group_report_output_idx);
//char my_tst_str[128];
//strcpy(my_tst_str, group_report_output_PSVs  +  0 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=0");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  1 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=1");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  2 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=2");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  3 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=3");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  4 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=4");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  5 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=5");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  6 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=6");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  7 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=7");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  8 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=8");ksn(my_tst_str);
//strcpy(my_tst_str, group_report_output_PSVs  +  9 * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//tr("group_report_output_PSVs  idx=9");ksn(my_tst_str);
//trn("returning from call of   mamb_report_trait_rank() ...");
//tn();
//

       do { // now that we have group_report_output_PSVs, grab all BG color for all tableview cells
            // and put into   NSArray *gbl_array_cellBGcolorName;
            //
//tn();trn("doing color save !!!!!!!");
            char my_buff[256];
            NSMutableString *myCellContentsPSV;
            NSArray  *tmpArray3;
            NSMutableString *curr_cellBGcolorName;
//            NSMutableString *curr_cellPersonAname;
//            NSMutableString *curr_cellPersonBname;
//
            NSString *curr_cellPersonAnameTMP;
            NSString *curr_cellPersonBnameTMP;
            NSString *curr_cellPersonAname;
            NSString *curr_cellPersonBname;


            NSCharacterSet  *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];

            [gbl_array_cellBGcolorName removeAllObjects];               // empty array for BG colors for these new cells
            [gbl_array_cellPersonAname removeAllObjects];               // empty array for personA   for these new cells
            [gbl_array_cellPersonBname removeAllObjects];               // empty array for personB   for these new cells

            gbl_array_cellBGcolorName = [[NSMutableArray alloc] init];  // init  array for BG colors for these new cells
            gbl_array_cellPersonAname = [[NSMutableArray alloc] init];  // init  array
            gbl_array_cellPersonBname = [[NSMutableArray alloc] init];  // init  array 

//tn();kin(group_report_output_idx);

            NSString *myHedColor = @"cHed";

            for (int i=0; i <= group_report_output_idx + 3; i++) {  // group_report_output_idx = last index written

                if (i == group_report_output_idx + 1) {
                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 1  // add the BG colors of the 3 footer cells
                   continue;
                }
                if (i == group_report_output_idx + 2) {
                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 2
                   continue;
                }
                if (i == group_report_output_idx + 3) {
                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 3
                   continue;
                }
                strcpy(my_buff, group_report_output_PSVs  +  i * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW
tn();ki(i);ks(my_buff);

                myCellContentsPSV     = [NSMutableString stringWithUTF8String: my_buff];  // convert c string to NSString
                tmpArray3             = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];

                curr_cellBGcolorName = tmpArray3[0];
                curr_cellPersonAnameTMP = tmpArray3[2];
                curr_cellPersonBnameTMP = tmpArray3[3];

//tn();  NSLog(@"curr_cellPersonAnameTMP =%@",curr_cellPersonAnameTMP );
//  NSLog(@"curr_cellPersonBname  =%@",curr_cellPersonBname  );

//                // replace '_' from pair names with ' '    (underscore only in cell in tableview)
//                [curr_cellPersonAname replaceOccurrencesOfString: @"_"
//                                                      withString: @" "
//                                                         options: 0
//                                                           range: NSMakeRange(0, curr_cellPersonAname.length)
//                ];
//                [curr_cellPersonBname replaceOccurrencesOfString: @"_"
//                                                      withString: @" "
//                                                         options: 0
//                                                           range: NSMakeRange(0, curr_cellPersonBname.length)
//                ];
//

                curr_cellPersonAname = [curr_cellPersonAnameTMP stringByReplacingOccurrencesOfString: @"_"
                                                                                          withString: @" "];
                curr_cellPersonBname = [curr_cellPersonBnameTMP stringByReplacingOccurrencesOfString: @"_"
                                                                                          withString: @" "];



                // in pair reports (Best Match ...) blanks go to '_' to make pairs more readable when a name has a blank in it
                //


                [gbl_array_cellBGcolorName addObject: curr_cellBGcolorName]; 
                [gbl_array_cellPersonAname addObject: curr_cellPersonAname];
                [gbl_array_cellPersonBname addObject: curr_cellPersonBname];
            }
       } while(false);   // now that we have group_report_output_PSVs, grab all BG color for all tableview cells




    } // ALL  MOST and BEST  group reports
//
// ALL  MOST and BEST  group reports
nbn(599);

 
//    NSLog(@"in TBLRPTs 1 at end of  viewWillAppear!");

} // viewWillAppear



// ==============   start of email stuff  ====================  ??
-(IBAction)infoButtonAction:(id)sender
{
  NSLog(@"in   infoButtonAction!  in tblrpt #1");

} // end of  infoButtonAction

-(IBAction)shareButtonAction:(id)sender
{
    MFMailComposeViewController *myMailComposeViewController;

tn();    NSLog(@"in shareButtonAction!  in MAMB09viewTBLRPTs_1_TableViewController ");
    
    // Determine the file name and extension
    // NSArray *filepart = [gbl_pathToFileToBeEmailed componentsSeparatedByString:@"."];
    NSArray *fileparts = [gbl_pathToFileToBeEmailed componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"./"]];
    
    NSString *baseFilename = [fileparts objectAtIndex: (fileparts.count -2)] ;  // count -1 is last in array
    NSString *extension    = [fileparts lastObject];
    NSString *filenameForAttachment = [NSString stringWithFormat: @"%@.%@", baseFilename, extension];
    
    // Get the resource path and read the file using NSData
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *HTMLfileData = [NSData dataWithContentsOfFile: gbl_pathToFileToBeEmailed ];
//NSLog(@"gbl_pathToFileToBeEmailed =%@",gbl_pathToFileToBeEmailed );
//NSLog(@"HTMLfileData.length=%lu",(unsigned long)HTMLfileData.length);


    NSString *emailTitle = [NSString stringWithFormat: @"%@  from Me and my BFFs", filenameForAttachment];

    NSString *myEmailMessage;
    
    myEmailMessage = @"tester";
    NSLog(@"myEmailMessage=%@",myEmailMessage);
    NSLog(@"extension=%@",extension);


//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"])      // My Best Match in Group

    // grpone  all *MY* BEST MATCH ... reports  PLUS all table reports AFTER THAT in navigation <-------------
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm" ] // My Best Match in Group ... grpone
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"pbm"    ] // My Best Match in Group ... grpone  IS pbm2bm
    ) {
        NSLog(@"gbl_person_name=%@",gbl_person_name);
        NSLog(@"myEmailMessage=%@",myEmailMessage);

        myEmailMessage = [NSString stringWithFormat: @"\n\"Best Match for %@  in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
           gbl_lastSelectedPerson,
           gbl_lastSelectedGroup
        ];
        NSLog(@"myEmailMessage=%@",myEmailMessage);
    }


//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group

    // grpall all BEST MATCH ... reports  PLUS all table reports AFTER THAT in navigation <-------------
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm" ] //    Best Match in Group ... grpall
        || [gbl_currentMenuPlusReportCode       hasPrefix: @"gbm"    ] //    Best Match in Group ... grpall  are gbm1bm + gbm2bm 
    ) {
        NSLog(@"gbl_person_name=%@",gbl_person_name);
        NSLog(@"myEmailMessage=%@",myEmailMessage);

        myEmailMessage = [NSString stringWithFormat: @"\n\"Best Match in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
           gbl_lastSelectedGroup
        ];
        NSLog(@"myEmailMessage=%@",myEmailMessage);
    }

    
    //   NSArray *toRecipents = [NSArray arrayWithObject:@"ijfo@jldks.com"];
    NSArray *toRecipients = [NSArray arrayWithObjects:@"", nil];  //  user types it in


    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    if ([MFMailComposeViewController canSendMail])
    {
        myMailComposeViewController = [[MFMailComposeViewController alloc] init];

        NSLog(@"This device CAN send email");

         myMailComposeViewController.mailComposeDelegate = self;
        [myMailComposeViewController setSubject: emailTitle];
        [myMailComposeViewController setMessageBody: myEmailMessage
                                             isHTML: NO];
        [myMailComposeViewController setToRecipients: toRecipients];
        [myMailComposeViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [myMailComposeViewController addAttachmentData: HTMLfileData                // Add attachment
                                              mimeType: mimeType
                                              fileName: filenameForAttachment];
        
        // Present mail view controller on screen
        //
        //[self presentModalViewController:myMailComposeViewController animated:YES completion:NULL];


        dispatch_async(dispatch_get_main_queue(), ^(void){
                [self presentViewController: myMailComposeViewController animated:YES completion:NULL];
            }
        );
    }
    else
    {
//        NSLog(@"This device cannot send email");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cannot send email"
//                                                        message: @"Maybe email on this device is not set up."
//                                                       delegate: nil
//                                              cancelButtonTitle: @"OK"
//                                              otherButtonTitles: nil];
//        [alert show];
//
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Cannot send email"
                                                                       message: @"Maybe email on this device is not set up."
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];
    }
} // shareButtonAction


//- (void) mailComposeController:(MFMailComposeViewController *)controller
//           didFinishWithResult:(MFMailComposeResult)result
//                         error:(NSError *)error
//{
//    if (error) {
////        UIAlertView *myalert = [[UIAlertView alloc] initWithTitle: @"An error happened"
////                                                          message: [error localizedDescription]
////                                                         delegate: nil
////                                                cancelButtonTitle: @"cancel"
////                                                otherButtonTitles: nil, nil];
////        [myalert show];
////
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"An error happened"
//                                                                       message: [error localizedDescription]
//                                                                preferredStyle: UIAlertControllerStyleAlert  ];
//         
//        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
//                                                            style: UIAlertActionStyleDefault
//                                                          handler: ^(UIAlertAction * action) {
//            NSLog(@"Ok button pressed");
//        } ];
//         
//        [alert addAction:  okButton];
//
//        [self presentViewController: alert  animated: YES  completion: nil   ];
//
//        // [self dismissViewControllerAnimated:yes completion:<#^(void)completion#>];
//
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self dismissViewControllerAnimated: YES
//                                     completion:NULL];
//            }
//        );
//    }
//    switch (result)
//    {
//        case MFMailComposeResultCancelled: {
//            NSLog(@"Mail cancelled");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail send was cancelled"
//                                                            message: @""
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//            break;
//        }
//        case MFMailComposeResultSaved: {
//            NSLog(@"Mail saved");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail was saved"
//                                                            message: @""
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//            break;
//        }
//        case MFMailComposeResultSent: {
//            NSLog(@"Mail sent");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail was sent"
//                                                            message: @""
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//            break;
//        }
//        case MFMailComposeResultFailed: {
//            NSLog(@"Mail send failure: %@", [error localizedDescription]);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Failure of mail send"
//                                                            message: [error localizedDescription]
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//            break;
//        }
//        default: { break; }
//    }
//    
//    // Close the Mail Interface
////    [self becomeFirstResponder];  // from http://stackoverflow.com/questions/14263690/need-help-dismissing-email-composer-screen-in-ios
//
//    //[self dismissModalViewControllerAnimated:YES
//
//    dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self dismissViewControllerAnimated:YES
//                                     completion:NULL];
//        }
//    );
//
//} //  didFinishWithResult:(MFMailComposeResult)result
//
- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    if (error) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"An error happened"
                                                                       message: [error localizedDescription]
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
        } ];
        [alert addAction:  okButton];
        [self presentViewController: alert  animated: YES  completion: nil   ];

        // [self dismissViewControllerAnimated:yes completion:<#^(void)completion#>];

        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated: YES
                                     completion:NULL];
            }
        );
    }
    switch (result)
    {
        case MFMailComposeResultCancelled: {
NSLog(@"Mail cancelled");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail Send was Cancelled"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];

            break;
        }
        case MFMailComposeResultSaved: {
            NSLog(@"Mail saved");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail was Saved"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];

            break;
        }
        case MFMailComposeResultSent: {
            NSLog(@"Mail sent");
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail was Sent"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];


            break;
        }
        case MFMailComposeResultFailed: {
            NSLog(@"Mail send failure: %@", [error localizedDescription]);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Failure of Mail Send"
                                                                           message: [error localizedDescription]
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            [self presentViewController: alert  animated: YES  completion: nil   ];

            break;
        }
        default: { break; }
    }
    
    // Close the Mail Interface
//    [self becomeFirstResponder];  // from http://stackoverflow.com/questions/14263690/need-help-dismissing-email-composer-screen-in-ios

    //[self dismissModalViewControllerAnimated:YES

    dispatch_async(dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated:YES
                                     completion:NULL];
        }
    );

} //  didFinishWithResult:(MFMailComposeResult)result



// ==============   END of email stuff  ====================



//   maybe no
// A good way to update a table view when starting up or returning from another view
// is to add code like this to viewDidAppear:
//- (void)viewDidAppear:(BOOL)animated {
// NSLog(@"rootViewController: viewDidAppear");
// [super viewDidAppear:animated];
// [self.view reloadData]; // self.view is the table view if self is its controller
//}
//

- (void)viewDidAppear:(BOOL)animated
{
//     [super viewDidAppear];
    NSLog(@"in TBLRPTs 1  viewDidAppear!");

    [super viewDidAppear:animated];
//    [self.tableView reloadData];    // self.view is the table view if self is its controller


// try to get rid of tbl position in middle on startup
//nbn(320);
//    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
//    ) {
//nbn(321);
//        NSIndexPath *gotoindexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
//        if(gotoindexPath) {
//nbn(322);
////            [self.tableView selectRowAtIndexPath:gotoindexPath
////                                        animated:YES
////                                  scrollPosition:UITableViewScrollPositionNone];
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//
//                [self.tableView reloadData]; // self.view is the table view if self is its controller
//
////                [self.tableView scrollToRowAtIndexPath: gotoindexPath atScrollPosition: UITableViewScrollPositionTop animated: YES];
////        //        [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];
//
////                [self.tableView selectRowAtIndexPath: gotoindexPath
////                                            animated: YES
////                                      scrollPosition: UITableViewScrollPositionTop  
////                ];
////
////                [self.tableView scrollToRowAtIndexPath: gotoindexPath
////                                 atScrollPosition: UITableViewScrollPositionTop
////                                         animated: YES
////                ];
////
//           });
//        }
//
//        return;
//    }
//


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
    ) {
nbn(1);
        ;  // do not select any row
    } else {
        NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
        if(myIdxPath) {
            [self.tableView selectRowAtIndexPath:myIdxPath
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionNone];
        }
    }

    return;



} // end of viewDidAppear



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    NSLog(@"in TBLRPTs 1  prepareForSegue!");
  NSLog(@"segue.identifier =%@",segue.identifier );


  if ([segue.identifier isEqualToString: @"segueTBLRPT1_toINFO"]) {

      ; // DO NOT set the next gbl_currentMenuPlusReportCode  for info in the next report

  } 

  if ([segue.identifier isEqualToString: @"segueTBLRPT1_toViewHTML"]) {

        //
        // set the next gbl_currentMenuPlusReportCode  for info in the next report
        //

tn();trn("// set new gbl_currentMenuPlusReportCode    for info in next report");
  NSLog(@"leaving TBLRPTs_1 old gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);
        do {
            //             if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmappe"]) gbl_currentMenuPlusReportCode = @"homgma";
            //        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmeppe"]) gbl_currentMenuPlusReportCode = @"homgme";
            //        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmrppe"]) gbl_currentMenuPlusReportCode = @"homgmr";
            //        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmpppe"]) gbl_currentMenuPlusReportCode = @"homgmp";
            //        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmdppe"]) gbl_currentMenuPlusReportCode = @"homgmd";
            //
            //        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbypcy"]) gbl_currentMenuPlusReportCode = @"homgby";
            //        else if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]) gbl_currentMenuPlusReportCode = @"homgbd";
            //
                 if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]) gbl_currentMenuPlusReportCode = @"gmappe";
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]) gbl_currentMenuPlusReportCode = @"gmeppe";
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]) gbl_currentMenuPlusReportCode = @"gmrppe";
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]) gbl_currentMenuPlusReportCode = @"gmpppe";
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]) gbl_currentMenuPlusReportCode = @"gmdppe";

            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]) gbl_currentMenuPlusReportCode = @"gbypcy";
            else if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]) gbl_currentMenuPlusReportCode = @"gbdpwc";

        } while (false); // save PSVs for viewHTML reports
  NSLog(@"leaving TBLRPTs_1 new gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);

  } 

}


//
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?
//
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {


    if (group_report_output_idx <= gbl_numRowsToTurnOnIndexBar) return nil;


//    return[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
//    return[NSArray arrayWithObjects:@"--", @" ", @" ", @" ", @" ", @" ", @"GGG", @" ", @" ", @" ", @" ", @" ", @"-", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"XXX", @"Y", @"Z", @"--", nil];

    return[NSArray arrayWithObjects:
            @"--",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"20",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"40",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"60",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"80",
         @" ", @" ", @" ", @" ",  @" ", @" ",
            @"==", nil ];
  }

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle: (NSString *)title 
                                                                    atIndex: (NSInteger)index  {

  NSLog(@"sectionForSectionIndexTitle!");
//    NSInteger newRow = [self indexForFirstChar:title inArray:self.yourStringArray];
    NSInteger newRow;
    newRow = 0;

    //    if ([title isEqualToString:@"  "])    // does not work when title = "  "
    if ([title hasPrefix:@" "]) {
        NSArray *myVisibleRows = [tableView indexPathsForVisibleRows];
        NSIndexPath *myTopRow  = (NSIndexPath*)[myVisibleRows objectAtIndex:0];
        return myTopRow.row;
    }

    // no section index for these
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]   // home + personality
        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]   // home + compatibility
    ) {
        return 0;
    }


    // put up 20,40,60,80  scroll bar on right
    //
    //    if ([title isEqualToString:@"__"]) newRow = 0;
    if ([title isEqualToString:@"--"]) newRow = 0;
    if ([title isEqualToString:@"20"]) newRow = (int) ( (20.0 / 100.0) * (double)group_report_output_idx );
    if ([title isEqualToString:@"40"]) newRow = (int) ( (40.0 / 100.0) * (double)group_report_output_idx );
    if ([title isEqualToString:@"60"]) newRow = (int) ( (60.0 / 100.0) * (double)group_report_output_idx );
    if ([title isEqualToString:@"80"]) newRow = (int) ( (80.0 / 100.0) * (double)group_report_output_idx );
    if ([title isEqualToString:@"=="]) newRow =              group_report_output_idx - 1;
  NSLog(@"newRow =%ld",(long)newRow );

    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];


    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionTop animated: YES];
//        [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];
    });

    return index;
}


@end


// stuff

//NSRange myrange =  [cell.textLabel.text rangeOfString:@"90  Great"];
//  NSLog(@"myNewCellText=%@",myNewCellText);
//  NSLog(@"NSNotFound      =%lu",(unsigned long)NSNotFound);
//  NSLog(@"myrange.location=%lu",(unsigned long)myrange.location);
//  NSLog(@"myrange.length=%lu",(unsigned long)myrange.length);
//
//BOOL contains;
// NSCaseInsensitiveSearch - makes it case insensitive
//  if ([cell.textLabel.text rangeOfString:@"90  Great" options:NSCaseInsensitiveSearch].location == NSNotFound) {
//contains = NO;
//} else {
//contains = YES;
//}
//


    // FYI  multiple lines  by wrap
    //        [[cell textLabel] setNumberOfLines:0];
    //        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    //

//try gbls
//    // vars for column headers
//    NSString *myCharsForRankNumsOnLeft;
//    NSString *myFillSpacesInColHeaders;
//

//            // remove space on each end
//            myNewCellText  = [myOriginalCellText substringWithRange:NSMakeRange(1, myOriginalCellTextLen -1 - 1)]; // zero-based
//  NSLog(@"LL myNewCellText      =[%@]",myNewCellText  );
//
//

//            int last_char_was_a_nine, lineup_column;
//            last_char_was_a_nine = 0;
//            lineup_column = 0;
//
//            for (int i = (int)strlen(tmp_c_buff) - 1; i >= 0; i--) {   // look for " 9"  right to left
//                if (tmp_c_buff[i] == '9') {
//                    last_char_was_a_nine = 1;
//                    continue;
//                }
//                if (tmp_c_buff[i] == ' ' &&  last_char_was_a_nine == 1) {
//                    lineup_column = i + 1;  // lineup_column is one-based
//                    break;
//                }
//                last_char_was_a_nine = 0;
//            }
//    kin(lineup_column);
//

//
//        // if there are 2 spaces on the left, remove them  and remove one on right end
//        // if there  is 1 space  on the left, leave    it  and remove one on right end
//        //
//NSLog(@"myOriginalCellText 2    =[%@]",myOriginalCellText      );
//        if ([myOriginalCellText hasPrefix: @"  "]) {
//            myNewCellText  = [myOriginalCellText substringWithRange:NSMakeRange(2, myOriginalCellTextLen -1 - 1)]; // zero-based
//NSLog(@"myNewCellText      1    =[%@]",myNewCellText      );
//        } 
//        else {
//            myNewCellText  = [myOriginalCellText substringWithRange:NSMakeRange(0, myOriginalCellTextLen -1 - 1)]; // zero-based
//NSLog(@"myNewCellText      2    =[%@]",myNewCellText      );
//        }
//



//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

    //   cell.accessoryView          = myInvisibleButton;            // no right arrow on benchmark label
    //   cell.userInteractionEnabled = NO;                           // no selection highlighting
    //

//return NO;  // to eliminate bug  =  father/swim tap 14, then 10, 14 is bg=cHdr

    // [[cell textLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size: 16.5]];
    //
    // Menlo Bold 
    // Menlo Bold Italic 
    // Menlo Italic 
    // Menlo Regular 
    //
    //UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
    //UIFont *myFont = [UIFont fontWithName: @"Menlo Bold" size: 12.0];
    //UIFont *myFont = [UIFont fontWithName: @"Menlo-Bold" size: 12.0];
//    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 12.0];

//
//    // As pointed above one way to modify an accessoryView is by adding your own UIImageView.
//    // However, in fact you can supply any object deriving from UIView.
//    // I would then recommend using a UILabel with an icon font (e.g. icomoon) instead of UIImageView.
//    // UILabel and an icon font allow for flexibility in both image, color and size.
//
////let font = UIFont(name: "icomoon", size: 16.0)
////let icon = "\u{e60f}"    
////let lbl = UILabel(frame: CGRectMake(0, 0, 20, 20))
//
//    UILabel *myDisclosureIndicatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
//
//    UIFont *myFont = [UIFont fontWithName: @"Menlo Bold" size: 12.0];
//
//lbl.font = font
//lbl.text = icon
//cell.accessoryView = lbl
//
//
//

        // UILabel for the disclosure indicator
        //
//            UIFont *myDisclosureIndicatorFont   = [UIFont fontWithName: @"Menlo Bold" size: 12.0];
//            UIFont *myDisclosureIndicatorFont   = [UIFont fontWithName: @"Menlo" size: 12.0];
//            UIFont *myDisclosureIndicatorFont   = [UIFont fontWithName: @"Menlo" size: 16.0];
//            UIFont *myDisclosureIndicatorFont   = [UIFont fontWithName: @"Menlo Bold" size: 16.0f];
        //    UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        //    UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 32)];
        //    myDisclosureIndicatorLabel.backgroundColor = [UIColor clearColor];
//            myDisclosureIndicatorLabel.backgroundColor = [UIColor grayColor];

//            myDisclosureIndicatorLabel.font            = myDisclosureIndicatorFont;
//        //    myDisclosureIndicatorLabel.text            = @" > ";
//            myDisclosureIndicatorLabel.text            = @">";
//

//                                           attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,

//            [navigationBar setBackgroundImage: [UIImage imageNamed:@"NavigationBarBackground"] 
            
//        // does not work    This property is ignored if leftBarButtonItem is not nil 
//        // set TITLE for NAVIGATION BAR
//        //
//        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(
//            50,
//            0,
//            self.navigationController.navigationBar.frame.size.width-100,
//            self.navigationController.navigationBar.frame.size.height
//        )K;
//
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
//        [titleLabel setTextAlignment:NSTextAlignmentCenter];
//        //[titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
//        [titleLabel setNumberOfLines:0];
//
//        //NSString *titleString = @"This is a\n multiline string";
//        NSString *titleString = @" For ~Elijah89012345\nin Group ~My1Family12345";
//
//        [titleLabel setText:titleString];
//
//        [titleView addSubview:titleLabel];
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            //[self.navigationController.navigationItem setTitleView:titleView];
//            [self.navigationController.navigationItem setTitleView:titleView];
//        });
//

//        UILabel *myNavTitle = [[UILabel alloc] init];    no work
//        myNavTitle.text =  @"Best Match";
//            [[self navigationItem] setTitleView: myNavTitle];
//


// 
////StART  of GUTS of ViewDidLoad (called only once) moved to ViewDidAppear (called each time becomes visible)
////
////  viewDidLoad
////  Is called exactly once, when the view controller is first loaded into memory.
////  This is where you want to instantiate any instance variables and
////  build any views that live for the entire lifecycle of this view controller.
////  
////  viewDidAppear
////  Is called when the view is actually visible,
////  and can be called multiple times during the lifecycle of a View Controller
////  (example when a Modal View Controller is dismissed and the view becomes visible again)
////
//
//    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
//    int retval;
//
////    char csv_person_string[128];
////    char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
//    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
//    const char *my_psvc; // psv=pipe-separated values
////    char my_psv[128];
//    
//    const char *tmp_grp_name_CONST;                                                         // NSString object to C str
//    char tmp_grp_name[128];                                                                 // NSString object to C str
//    tmp_grp_name_CONST = [gbl_lastSelectedGroup cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
//    strcpy(tmp_grp_name, tmp_grp_name_CONST);                                               // NSString object to C str  because of const
//    
//
//    char person_name_for_filename[32];
//    char group_name_for_filename[32]; 
//
//    char   html_file_name_browser[2048];
//    NSString *Ohtml_file_name_browser;
//    NSString *OpathToHTML_browser;
//    char     *pathToHTML_browser;
//
//    NSArray* tmpDirFiles;
//    
//    // all BEST MATCH ... reports  ======================================================================================
//    // all BEST MATCH ... reports  ======================================================================================
//    //
//tn();trn("before kingpin set");
//  NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@",gbl_currentMenuPrefixFromMatchRpt);
//  NSLog(@"gbl_lastSelPersonWasA =%@",gbl_lastSelPersonWasA );
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//  NSLog(@"gbl_kingpinPersonName=%@",gbl_kingpinPersonName);
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//  NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//  NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
//
//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]      // My Best Match in Group ...
//      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]      //    Best Match in Group ...
////      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]      // My Best Match in Group ...  see tblrps_2 view
////      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]      // My Best Match in Group ...
////      ||  [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]      // My Best Match in Group ...
//    )
//    {   // all BEST MATCH ... reports
//        tn();trn("in REPORT  all BEST MATCH ... reports !");
//
//        //        NSString myTitleForTableview;
//
//        NSString *myKingpinPerson;
//        NSString *myKingpinCSV_NSString;
//        const char *C_CONST_myKingpinPerson;   // for get c string
//        char        C_myKingpinPerson[64];     // for get c string
//
//        // determine the NSString CSV of the kingpin person (or @"") for this match report
//        //
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) {    // My Best Match in Group ...
//           myKingpinPerson       = gbl_lastSelectedPerson;
//           myKingpinCSV_NSString = gbl_fromHomeCurrentSelectionPSV;
//        }
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group ...
//           myKingpinPerson       = @"";
//           myKingpinCSV_NSString = @"";
//        }
//
//        //   NO  are in tblrpts_2
//        //        if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]) {    // My Best Match in Group ...
//        //           myKingpinPerson       = gbl_nameOfPerson_1_OfPair;                      // TODO  gbl_nameOfPerson_1_OfPair
//        //           myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
//        //        }
//        //        if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]) {    // My Best Match in Group ...
//        //           myKingpinPerson       = gbl_nameOfPerson_2_OfPair;                      // TODO  gbl_nameOfPerson_2_OfPair
//        //           myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
//        //        }
//        //        if ([gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]) {    // My Best Match in Group ...
//        //           myKingpinPerson       = gbl_nonKingpinPerson;                     // TODO  gbl_nameOf_NonKingpin_Person
//        //           myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
//        //        }
//        //
//        //
//        
//        gbl_kingpinPersonName = myKingpinPerson;
//
////myKingpinPerson       =  @"~Ava";
////myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
////NSLog(@" TEST 1  myKingpinCSV_NSString =%@",myKingpinCSV_NSString );
////myKingpinPerson       =  @"~Avaxxxxxxxx";
////myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson]; 
////NSLog(@" TEST 2  myKingpinCSV_NSString =%@",myKingpinCSV_NSString );
////
//
//        if (myKingpinCSV_NSString == nil) {
//            NSLog(@"Could not find person record for person name=%@",myKingpinPerson);
//            NSLog(@"using ~Abigail ");
//            myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: @"~Abibail"]; 
//        }
//
//        /* get C string for NSString myKingpinPerson
//        */
//
//        if ([myKingpinPerson isEqualToString: @""]  ||  myKingpinPerson == nil) {    // My Best Match in Group ...
//            strcpy(C_myKingpinPerson, "no person");
//        } else {
//            C_CONST_myKingpinPerson = myKingpinPerson.UTF8String;   // for grpone
//            strcpy(C_myKingpinPerson, C_CONST_myKingpinPerson);
//        }
////
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [[self navigationItem] setTitle: @"Best Match"];
////        });
////
////
//
//        
//    NSLog(@"gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
//    NSLog(@"gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );
//
//        // build HTML file name  in TMP  Directory  (html_file_name_browser);
//        //
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group ...
//
//            strcpy(group_name_for_filename, tmp_grp_name );  
//            scharswitch(group_name_for_filename, ' ', '_');
//            sprintf(html_file_name_browser, "%sgrpall_%s.html", PREFIX_HTML_FILENAME, group_name_for_filename);
//
//        } else {   // MY  Best Match in Group ...  (grpone)
//
//            strcpy(person_name_for_filename, C_myKingpinPerson);
//            scharswitch(person_name_for_filename, ' ', '_');
//
//            strcpy(group_name_for_filename, tmp_grp_name );  
//            scharswitch(group_name_for_filename, ' ', '_');
//
//            sprintf(html_file_name_browser, "%sgrpone_%s_%s.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
//        }
//// sprintf(html_file_name_webview, "%sgrpone_%s_%swebview.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
//        
//        
//        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
////        gbl_html_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];   // for later viewing in webview
//
//
//        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
//        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
//        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
//        
////        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
////        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
////        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
////        
////        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
////
//        
//        gbl_pathToFileToBeEmailed = OpathToHTML_browser;
//        
//        // remove all "*.html" files from TMP directory before creating new one
//        //
//        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
//        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
//        for (NSString *fil in tmpDirFiles) {
//            NSLog(@"REMOVED THIS fil=%@",fil);
//            if ([fil hasSuffix: @"html"]) {
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
//            }
//        }
//   
//        
//        tn();trn("2 HTMLs !!!!!!!!!!!!!!!!!!!!");
////        nksn(html_file_name_browser); ksn( html_file_name_webview);
////        nksn(pathToHTML_browser); ksn(pathToHTML_webview);
////
//        NSLog(@"Ohtml_file_name_browser=%@",Ohtml_file_name_browser);
//        NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);
//
//
//
//
//
//        // get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs
//        // but possibly excluding  one person who is kingpin of grpone report "MY Best Match in Group ..." 
//        //
//        gbl_kingpinIsInGroup = [myappDelegate getNSArrayOfCSVsForGroup: (NSString *) gbl_lastSelectedGroup    // get into NSArray gbl_grp_CSVs
//                                               excludingThisPersonName: (NSString *) myKingpinPerson      ];  // non-empty string means "my best match ..."
//
//NSLog(@"gbl_kingpinIsInGroup =%ld",gbl_kingpinIsInGroup );
////NSLog(@"gbl_grp_CSVs =%@",gbl_grp_CSVs ); // for test see all grp CSVs
////kin((int)gbl_grp_CSVs.count);
//
//
//            // here we can store the number of pairs ranked  in  gbl_numPairsRanked (for column header size calc)
//            //
//            if ([myKingpinPerson isEqualToString: @""]  ||  myKingpinPerson == nil) {    // Best Match in Group ...
//                gbl_numPairsRanked = ( gbl_grp_CSVs.count * (gbl_grp_CSVs.count - 1)) / 2;  // for grpall
//            } else {
//                gbl_numPairsRanked = gbl_grp_CSVs.count;   // (getNSArrayOfCSVsForGroup subtracts one if kingpin is in group)
//            }
//
////                //   - determine  if kingpin is in group
////                //
////                gbl_kingpinIsInGroup = 0;
////                NSString *prefixStr = [NSString stringWithFormat: @"%@|", myKingpinPerson];
////  NSLog(@"prefixStr =%@",prefixStr );
////                for (NSString *element in gbl_grp_CSVs) {
////  NSLog(@"element =%@",element );
////                    if ([element hasPrefix: prefixStr]) {
////                        gbl_kingpinIsInGroup = 1;
////                        break;
////                    }
////                }
////tn();tr("one");kin((int)gbl_kingpinIsInGroup );
////                if ( gbl_kingpinIsInGroup == 0) gbl_numPairsRanked = gbl_grp_CSVs.count;
////                if ( gbl_kingpinIsInGroup == 1) gbl_numPairsRanked = gbl_grp_CSVs.count - 1;
////
////kin((int)gbl_numPairsRanked);
////
//
//
//
//        //
//        // convert  NSArray gbl_grp_CSVs  (one NSString CSV for each member of the group)
//        // into     a C array of strings for the C report function call mamb_report_person_in_group() -  my_mamb_csv_arr
//        //
//        //     char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
//        //
//        // avoid malloc by this char buffer  to hold max lines of fixed length
//        // char group_report_input_birthinfo_CSVs[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
//        // int  group_report_input_birthinfo_idx;
//        //
//        char *my_mamb_csv_arr[gbl_maxGrpBirthinfoCSVs];
//        int num_input_csvs;
//        num_input_csvs = (int)gbl_grp_CSVs.count;
//        group_report_input_birthinfo_idx =  -1;  // zero-based  init
//
//        for(int i = 0; i < num_input_csvs; i++) {  
//
//          NSString *s      = gbl_grp_CSVs[i];     //get a NSString
//          const char *cstr = s.UTF8String;        //get cstring
//
//          // index of next spot in buffer
//          group_report_input_birthinfo_idx = group_report_input_birthinfo_idx + 1; 
//
//          // get ptr to next 64-byte slot in buffer
//          char *my_ptr_in_buff;
//          my_ptr_in_buff = group_report_input_birthinfo_CSVs + group_report_input_birthinfo_idx * gbl_maxLenBirthinfoCSV;
//
//          // copy cstr into that spot
//          strcpy(my_ptr_in_buff, cstr); 
//
//          // put ptr to that spot into c array of strings
//          my_mamb_csv_arr[group_report_input_birthinfo_idx] = my_ptr_in_buff;
//        }
//
//for (int kkk=0; kkk <= num_input_csvs -1; kkk++) {
//tn();ki(kkk);ks(my_mamb_csv_arr[kkk]); }
//
//        
//
////        /* Now call report function in grpdoc.c
////        * 
////        *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
////        *  int out_rank_idx;  * pts to current line in out_rank_lines *
////        */
////        int out_rank_idx, retval;
////        out_rank_idx = 0;
////        retval = mamb_report_person_in_group(  /* in grpdoc.o */
////          html_file_name,      /* html_file_name */
////          group_name,          /* group_name */
////          mamb_csv_arr,        /* in_csv_person_arr[] */
////          num_in_grp,          /* num_persons_in_grp */
////          csv_compare_everyone_with,
////          out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
////          &out_rank_idx 
////        );
////
////        if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}
////
////
//
//
//        // 1 different report invocation  for grpall (homgbm)
//        // 4 different report invocations for grpone (hompbm, gbm1gm, gbm2bm, pbm2bm)
//        //
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group ...  this is grpall
//
//// TODO
//
//        } else {       // *MY*  Best Match in Group ...  this is grpone
//
//            // get kingpin CSV  for C call
//                // NSString object to C
//                my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
//                char my_psv[128];
//                strcpy(my_psv, my_psvc);
//                
//                char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
//                strcpy(psvName, csv_get_field(my_psv, "|", 1));
//                strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
//                strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
//                strcpy(psvYear, csv_get_field(my_psv, "|", 4));
//                strcpy(psvHour, csv_get_field(my_psv, "|", 5));
//                strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
//                strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
//                strcpy(psvCity, csv_get_field(my_psv, "|", 8));
//                strcpy(psvProv, csv_get_field(my_psv, "|", 9));
//                strcpy(psvCountry, csv_get_field(my_psv, "|", 10));
//                
//                // get longitude and timezone hoursDiff from Greenwich
//                // by looking up psvCity, psvProv, psvCountry
//                //
//                seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
//                
//                strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
//                strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
//
//                // build csv arg for report function call
//                //
//                char csv_kingpin[128];
//                sprintf(csv_kingpin, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                        psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
//            // end of  get kingpin CSV  for C call
//ksn(csv_kingpin);
//
//
//
//tn();trn("HERE  doing person in group ..."); ks(html_file_name_browser);
//            // Now call  grpone   report function in grpdoc.c
//            //
//            tn();trn("in TBLRPT 1  calling  mamb_report_person_in_group() ..."); 
//            retval = mamb_report_person_in_group(  /* in grpdoc.o */
//              pathToHTML_browser,          // path to html_file
//              tmp_grp_name,                // group_name */
//              my_mamb_csv_arr,             // from   group_report_input_birthinfo_CSVs
//              num_input_csvs,              // num_persons_in_grp xxzz
//              csv_kingpin,                 // csv_compare_everyone_with,
//              group_report_output_PSVs,    // array of output report data
//              &group_report_output_idx,    // ptr to int having last index written
//              (int)gbl_kingpinIsInGroup
//            );
//
//tn();trn("in TBLRPT 1  returned from  mamb_report_person_in_group() ...");
//kin(retval);
//            if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}
//
//
//
//            // now that we have group_report_output_PSVs, grab all BG color for all tableview cells
//            // and put into   NSArray *gbl_array_cellBGcolorName;
//            //
//            char my_buff[256];
//            NSMutableString *myCellContentsPSV;
//            NSArray  *tmpArray3;
//            NSMutableString *curr_cellBGcolorName;
////            NSMutableString *curr_cellPersonAname;
////            NSMutableString *curr_cellPersonBname;
////
//            NSString *curr_cellPersonAnameTMP;
//            NSString *curr_cellPersonBnameTMP;
//            NSString *curr_cellPersonAname;
//            NSString *curr_cellPersonBname;
//
//
//            NSCharacterSet  *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
//
//            [gbl_array_cellBGcolorName removeAllObjects];               // empty array for BG colors for these new cells
//            [gbl_array_cellPersonAname removeAllObjects];               // empty array for personA   for these new cells
//            [gbl_array_cellPersonBname removeAllObjects];               // empty array for personB   for these new cells
//
//            gbl_array_cellBGcolorName = [[NSMutableArray alloc] init];  // init  array for BG colors for these new cells
//            gbl_array_cellPersonAname = [[NSMutableArray alloc] init];  // init  array
//            gbl_array_cellPersonBname = [[NSMutableArray alloc] init];  // init  array 
//
////tn();kin(group_report_output_idx);
//
//            NSString *myHedColor = @"cHed";
//
//            for (int i=0; i <= group_report_output_idx + 3; i++) {  // group_report_output_idx = last index written
//
//                if (i == group_report_output_idx + 1) {
//                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 1  // add the BG colors of the 3 footer cells
//                   continue;
//                }
//                if (i == group_report_output_idx + 2) {
//                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 2
//                   continue;
//                }
//                if (i == group_report_output_idx + 3) {
//                   [gbl_array_cellBGcolorName addObject: myHedColor];  //  footer line 3
//                   continue;
//                }
//                strcpy(my_buff, group_report_output_PSVs  +  i * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW
////tn();ki(i);ks(my_buff);
//
//                myCellContentsPSV     = [NSMutableString stringWithUTF8String: my_buff];  // convert c string to NSString
//                tmpArray3             = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];
//
//                curr_cellBGcolorName = tmpArray3[0];
//                curr_cellPersonAnameTMP = tmpArray3[2];
//                curr_cellPersonBnameTMP = tmpArray3[3];
//
////tn();  NSLog(@"curr_cellPersonAnameTMP =%@",curr_cellPersonAnameTMP );
////  NSLog(@"curr_cellPersonBname  =%@",curr_cellPersonBname  );
//
////                // replace '_' from pair names with ' '    (underscore only in cell in tableview)
////                [curr_cellPersonAname replaceOccurrencesOfString: @"_"
////                                                      withString: @" "
////                                                         options: 0
////                                                           range: NSMakeRange(0, curr_cellPersonAname.length)
////                ];
////                [curr_cellPersonBname replaceOccurrencesOfString: @"_"
////                                                      withString: @" "
////                                                         options: 0
////                                                           range: NSMakeRange(0, curr_cellPersonBname.length)
////                ];
////
//
//                curr_cellPersonAname = [curr_cellPersonAnameTMP stringByReplacingOccurrencesOfString: @"_"
//                                                                                          withString: @" "];
//                curr_cellPersonBname = [curr_cellPersonBnameTMP stringByReplacingOccurrencesOfString: @"_"
//                                                                                          withString: @" "];
//
//
//
//                // in pair reports (Best Match ...) blanks go to '_' to make pairs more readable when a name has a blank in it
//                //
//
//
//                [gbl_array_cellBGcolorName addObject: curr_cellBGcolorName]; 
//                [gbl_array_cellPersonAname addObject: curr_cellPersonAname];
//                [gbl_array_cellPersonBname addObject: curr_cellPersonBname];
//            }
//
//        } // grpone
//
//
////  NSLog(@"gbl_pathToFileToBeEmailed =%@",gbl_pathToFileToBeEmailed );
//
//
//
//
////        if (retval == 0) {
////           
////            // show all files in temp dir
////            NSFileManager *manager = [NSFileManager defaultManager];
////            NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
////            for (NSString *s in fileList){
////                NSLog(@"TEMP DIR %@", s);
////            }
////            
////            
////             /* here, go and look at html report */
////             // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
////             
////             self.outletWebView.scalesPageToFit = YES;
////             
////             // I was having the same problem. I found a property on the UIWebView
////             // that allows you to turn off the data detectors.
////             //
////             self.outletWebView.dataDetectorTypes = UIDataDetectorTypeNone;
////            
////             // place our URL in a URL Request
////             HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
////             
////             // UIWebView is part of UIKit, so you should operate on the main thread.
////             //
////             // old= [self.outletWebView loadRequest: HTML_URLrequest];
////             //
////             dispatch_async(dispatch_get_main_queue(), ^(void){
////                 [self.outletWebView loadRequest:HTML_URLrequest];
////             });
////        }
////
//
//
//
//
//
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <=== 
////            [[self navigationItem] setTitle: @"Best Match"];
////        });
////
//
//
//
//    }  // END of   all BEST MATCH ... reports  ======================================================================================
//
//
//// best day, best year
//
// // TODO    
// 
//// END  of GUTS of ViewDidLoad (called only once) moved to ViewDidAppear (called each time becomes visible)
// 
//



//
//    // for B level reports - no remembering for B level pairs EXCEPT remember rownum for returning to this row from on top)
//
//    // Now  highlight the  remembered last row selection 
//    // UNLESS this is entering this menu from "below"
//    // OK to highlight if returning to this menu from "above"
//    //
//    if (gbl_selectedRownumTBLRPT_1 == -1)  // FLAG to not highlight menu row on first entering selrpts_B
//
//    {
//        ;  // do not hightlight any row
//
//    } else {
//
//        if (self.isBeingPresented || self.isMovingToParentViewController) {   // "first time" entering from below
//            ;  // do not hightlight any row
//
//        } else {
//
////NSLog(@"gbl_selectedRownumSelRpt_B=%ld", (long)gbl_selectedRownumSelRpt_B); // get indexpath for saved rownum 
//            NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow: gbl_selectedRownumTBLRPT_1 
//                                                          inSection: 0 ];
//
//            [self.tableView selectRowAtIndexPath: myIndexPath   // puts highlight on remembered row
//                                        animated: YES
//                                  scrollPosition: UITableViewScrollPositionNone];
//        }
//     } // highlight saved row
//
//


//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollview {
//    gbl_scrollViewIsDragging = YES;
//
//    if( [self.tableView indexPathForSelectedRow] ) {
////        [[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]] setHighlighted:YES];
//
//        NSIndexPath *myTmpIndexPath     = [self.tableView indexPathForSelectedRow];
//        UITableViewCell *currcell       = [self.tableView cellForRowAtIndexPath: myTmpIndexPath]; // now you can use currcell.textLabel.text
//        currcell.selectedBackgroundView =  gbl_myCellBgView;
//
//    //      cell.selectedBackgroundView =  gbl_myCellBgView;
//    }
//}        // http://stackoverflow.com/questions/13275405/uitableview-selected-cell-doesnt-stay-selected-when-scrolled
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    gbl_scrollViewIsDragging = NO;
//
//    if( [self.tableView indexPathForSelectedRow] ) {
////        [[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]] setHighlighted:NO];
//        NSIndexPath *myTmpIndexPath     = [self.tableView indexPathForSelectedRow];
//        UITableViewCell *currcell       = [self.tableView cellForRowAtIndexPath: myTmpIndexPath]; // now you can use currcell.textLabel.text
//        currcell.selectedBackgroundView =  nil;
//    }
//}
//


        //<.>
        ////tn();ksn(myStringBuffForTraitCSV);tn();
        //
        //        // determine trait name that has the  highest score (for INFO for personality)
        //        // all trait scores are in  ( stringBuffForTraitCSV=[42,85,44,21,67,34] )
        //        //
        //        // _myStringBuffForTraitCSV=[78,1,55,84,90,79]__
        //        //
        //        NSString *myNSStringTraitCSV = [NSString stringWithUTF8String: myStringBuffForTraitCSV];  // convert c string to NSString
        ////  NSLog(@"myNSStringTraitCSV =%@",myNSStringTraitCSV );
        //        NSArray  *arrayOfScores      = [myNSStringTraitCSV componentsSeparatedByString:@","];
        ////  NSLog(@"arrayOfScores      =%@",arrayOfScores      );
        //        NSInteger thisScoreINT, thisScoreIndex;
        //        NSInteger highestTraitScore, highestTraitScoreIndex;
        //        highestTraitScore      = 0;
        //        highestTraitScoreIndex = 0;
        //        thisScoreINT           = 0;
        //        thisScoreIndex         = 0;
        //        NSString *thisScoreSTR;
        //
        //        for (thisScoreSTR in arrayOfScores) {
        ////  NSLog(@"thisScoreSTR =%@",thisScoreSTR );
        ////  NSLog(@"thisScoreINT =%ld",(long)thisScoreINT );
        //            thisScoreIndex = thisScoreIndex + 1;       // one-based
        //            thisScoreINT   = [thisScoreSTR intValue];  // convert NSString to integer
        //            if (thisScoreINT >  highestTraitScore) {
        //                highestTraitScore      = thisScoreINT;
        //                highestTraitScoreIndex = thisScoreIndex;
        ////  NSLog(@"highestTraitScore      =%ld",(long)highestTraitScore      );
        ////  NSLog(@"highestTraitScoreIndex =%ld",(long)highestTraitScoreIndex );
        //            }
        //        }
        //
        //        //  do_special_line(IDX_FOR_AGGRESSIVE);    1
        //        //  do_special_line(IDX_FOR_SENSITIVE);     2
        //        //  do_special_line(IDX_FOR_RESTLESS);      3
        //        //  do_special_line(IDX_FOR_DOWN_TO_EARTH); 4
        //        //  do_special_line(IDX_FOR_SEX_DRIVE);     5
        //        //  do_special_line(IDX_FOR_UPS_AND_DOWNS); 6  (removed)
        //        //
        //        gbl_highestTraitScore = [NSString stringWithFormat:@"%ld", (long)highestTraitScore ]; // convert NSInteger to NSString 
        //
        //        gbl_highestTraitScoreDescription = @" ";
        //        if (highestTraitScoreIndex == 1) gbl_highestTraitScoreDescription = @"Assertive";
        //        if (highestTraitScoreIndex == 2) gbl_highestTraitScoreDescription = @"Emotional";
        //        if (highestTraitScoreIndex == 3) gbl_highestTraitScoreDescription = @"Restless";
        //        if (highestTraitScoreIndex == 4) gbl_highestTraitScoreDescription = @"Down-to-earth";
        //        if (highestTraitScoreIndex == 5) gbl_highestTraitScoreDescription = @"Passionate";
        //        //  if (highestTraitScoreIndex == 6) gbl_highestTraitScoreDescription = @"Ups and Downs";
        //tn();ksn(myStringBuffForTraitCSV);
        //  NSLog(@"gbl_highestTraitScore=%@",gbl_highestTraitScore );
        //  NSLog(@"gbl_highestTraitScoreDescription=%@",gbl_highestTraitScoreDescription );
        //
        //
        //        if (retval == 0) {
        //           
        //            // show all files in temp dir
        //            NSFileManager *manager = [NSFileManager defaultManager];
        //            NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
        //            for (NSString *s in fileList){
        //                NSLog(@"TEMP DIR %@", s);
        //            }
        //            
        //            
        //            /* here, go and look at html report */
        //            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
        //            
        //            self.outletWebView.scalesPageToFit = YES;
        //            
        //            // I was having the same problem. I found a property on the UIWebView
        //            // that allows you to turn off the data detectors.
        //            //
        //            self.outletWebView.dataDetectorTypes = UIDataDetectorTypeNone;
        //
        //            // did not work // fill whole screen, no gaps   
        //            //             self.outletWebView.autoresizesSubviews = YES;
        //            //             self.outletWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        //            //
        //
        //            
        //             // place our URL in a URL Request
        //             HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
        //             
        //             // UIWebView is part of UIKit, so you should operate on the main thread.
        //             //
        //             // old= [self.outletWebView loadRequest: HTML_URLrequest];
        //             //
        //             dispatch_async(dispatch_get_main_queue(), ^(void){
        //                 [self.outletWebView loadRequest:HTML_URLrequest];
        //
        //                 // webView.delegate = self; // http://stackoverflow.com/questions/10666484/html-content-fit-in-uiwebview-without-zooming-out
        //                 self.outletWebView.delegate = self; // http://stackoverflow.com/questions/10666484/html-content-fit-in-uiwebview-without-zooming-out
        //
        //             });
        //        } // retval = 0
        //
        //<.> from viewHTML  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        //

//<.>
////            myAttrSpace   = [[NSMutableAttributedString alloc] initWithString: @"x"  ];
////            [ myAttrSpace   addAttribute: NSBackgroundColorAttributeName
////                                   value: gbl_color_cBgr 
////                                   range: NSMakeRange(0, 1)
////            ];
////            [ myAttrSpace   addAttribute: NSForegroundColorAttributeName
////                                   value: gbl_color_cBgr 
////                                   range: NSMakeRange(0, 1)
////            ];
//
//            myStringNoAttr = [myAttrString  string];
//
//            // find the pipes and make them invisible
//            // note: search myStringNoAttr, but make changes in myAttringString
//            //
//            // Setup what you're searching and what you want to find
//            NSString *toFind = @"|";
//            //
//            // Initialise the searching range to the whole string
//            NSRange searchRange = NSMakeRange(0, [myStringNoAttr length]);
//            do {
//                // Search for next occurrence
//                NSRange searchReturnRange = [myStringNoAttr  rangeOfString: toFind  options: 0  range: searchRange];
//                if (searchReturnRange.location != NSNotFound) {
//                    // If found, searchReturnRange contains the range of the current iteration
//nbn(111);
////                    [ myAttrString  addAttribute: NSForegroundColorAttributeName
////                                           value: gbl_color_cBgr 
////                                           range: NSMakeRange(searchReturnRange.location, 1)
////                    ];
//                    [myAttrString replaceCharactersInRange: NSMakeRange(searchReturnRange.location, 1) 
//                                      withAttributedString: myAttrSpace
//                    ];
//
//                    // Reset search range for next attempt to start after the current found range
//                    searchRange.location = searchReturnRange.location + searchReturnRange.length;
//                    searchRange.length = [myAttrString length] - searchRange.location;
//
//                } else {
//                    // If we didn't find it, we have no more occurrences
//                    break;
//                }
//            } while (1);
//<.>
//


//                   myAttrString2 = [[NSMutableAttributedString alloc] initWithString : mylin   // myNSString
////                       attributes : @{
////                           NSParagraphStyleAttributeName : paragraphStyle,
////                                     NSFontAttributeName : perFont14 
////                           //               NSBaselineOffsetAttributeName : @-1.0
////                       }
//
//                   ];
//                   // lin=[howbighdr| are the   favorable influences    +++++  ]__
//                   [myAttrString2 addAttribute: NSBackgroundColorAttributeName
//                                         value: gbl_color_cGr2
////                                         range: NSMakeRange(11, 32)];
//                                         range: NSMakeRange( 5, 10)];
//

//<.>
//            // NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"firstsecondthird"];
//            // [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,5)];
//            // [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,6)];
//            // [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11,5)];
//<.>



//            // here, for the label text, calculate how big a string fits
//            //  e.g.   "    |"
//            //  e.g.   "             |"
//            //  e.g.   "                       |"
//            //
//  NSLog(@"compFont_14.lineHeight=[%f]",compFont_12.lineHeight);
//           //  CGSize stringSize = [aString sizeWithAttributes:@{NSFontAttributeName:font}]; – RasTheDestroyer Sep 18 '14 at 0:26
//           NSString *rString;
//           NSString *rStringShorter;
//           CGFloat stringWidth;
//           CGFloat widthAvailable;
//
//           rString        = @"";
//           rStringShorter = @"";
//
//           widthAvailable = ceilf(self.view.bounds.size.width) - (ceilf(rect1.size.width) + ceilf(rect2.size.width)),
//
//           // make widthAvailable smaller by 2 chars (bigger r margin);
//           stringWidth = [@"xx" sizeWithAttributes: @{NSFontAttributeName: myFont_12}].width;
//           widthAvailable = widthAvailable - stringWidth;
//           if (widthAvailable < stringWidth) {
//               ;  // do not add a pipe for right margin for stars
//           } else {
//
//               rString = @"|";
//               while (1) {
//                   stringWidth = [rString sizeWithAttributes: @{NSFontAttributeName: myFont_12}].width;
//                   if (stringWidth > widthAvailable) {
//                       break;
//                   } else {
//                       // prepend another space onto   "  |"
//                       rString = [NSString stringWithFormat:@"y%@", rString];
//                   }
//               }
//               // here rString is too long
//               //
//               if (        [rString isEqualToString: @"|"] ) {
//                   rString = @"";
//               } else if ( [rString isEqualToString: @" |"] ) {
//                   rString = @"|";
//               } else {
//                   // remove 2 of the leading spaces
//                   rStringShorter = [rString substringWithRange: NSMakeRange(2, [rString length]-2)];
//               }
//           }
//
//  NSLog(@"sString       =[%@]",rString);
//  NSLog(@"sStringShorter=[%@]",rStringShorter);


//  NSLog(@"stringWidth =[%f]",stringWidth );

