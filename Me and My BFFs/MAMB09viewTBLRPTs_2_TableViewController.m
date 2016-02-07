//
//  MAMB09viewTBLRPTs_2_TableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-02-26.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import "MAMB09viewTBLRPTs_2_TableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals



@interface MAMB09viewTBLRPTs_2_TableViewController ()

@end


    // is this now visible throughout  MAMB09viewTBLRPTs_2_TableViewController  
    //
    char group_report_input_birthinfo_CSVs_B[250 * 64];  // [250 * fixed length of 64]
    int  group_report_input_birthinfo_idx_b;
    char group_report_output_PSVs_B[333 * 64];           // [333 * fixed length of 64]
    int  group_report_output_idx_B;


@implementation MAMB09viewTBLRPTs_2_TableViewController


- (void)viewDidLoad
{

    [super viewDidLoad];

    NSLog(@"in TBLRPT 2   viewDidLoad!");
    fopen_fpdb_for_debug();
trn("in TBLRPT 2   viewDidLoad!");


tn(); NSLog(@"in TBLRPTS 2   viewDidLoad!");
  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);      // any of the above 14 RPTs
  NSLog(@"gbl_PSVtappedPersonA_inPair=%@",gbl_PSVtappedPersonA_inPair);      // hompbm,homgbm,pbmco,gbmco
  NSLog(@"gbl_PSVtappedPersonB_inPair=%@",gbl_PSVtappedPersonB_inPair);      // same

  NSLog(@"gbl_TBLRPTS1_PSV_personA=%@",gbl_TBLRPTS1_PSV_personA);            // of pair
  NSLog(@"gbl_TBLRPTS1_PSV_personB=%@",gbl_TBLRPTS1_PSV_personB);            // of pair
  NSLog(@"gbl_TBLRPTS1_PSV_personJust1=%@",gbl_TBLRPTS1_PSV_personJust1);    // for single person reports
  NSLog(@"gbl_TBLRPTS1_NAME_personA=%@",gbl_TBLRPTS1_NAME_personA);          // of pair
  NSLog(@"gbl_TBLRPTS1_NAME_personB=%@",gbl_TBLRPTS1_NAME_personB);          // of pair
  NSLog(@"gbl_TBLRPTS1_NAME_personJust1=%@",gbl_TBLRPTS1_NAME_personJust1);  // for single person reports

  NSLog(@"gbl_TBLRPTS2_PSV_personA=%@",gbl_TBLRPTS2_PSV_personA);            // of pair
  NSLog(@"gbl_TBLRPTS2_PSV_personB=%@",gbl_TBLRPTS2_PSV_personB);            // of pair
  NSLog(@"gbl_TBLRPTS2_PSV_personJust1=%@",gbl_TBLRPTS2_PSV_personJust1);    // for single person reports
  NSLog(@"gbl_TBLRPTS2_NAME_personA=%@",gbl_TBLRPTS2_NAME_personA);          // of pair
  NSLog(@"gbl_TBLRPTS2_NAME_personB=%@",gbl_TBLRPTS2_NAME_personB);          // of pair
  NSLog(@"gbl_TBLRPTS2_NAME_personJust1=%@",gbl_TBLRPTS2_NAME_personJust1);  // for single person reports
tn();
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


     MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m



    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; // remove separator lines between cells

    //self.tableView.backgroundColor = gbl_color_cHed;   // WORKS
    self.tableView.backgroundColor = gbl_color_cBgr;   // WORKS


//
////[self.navigationController.navigationBar setBarTintColor:[UIColor greenColor]];
//[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//[self.navigationController.navigationBar setTranslucent: NO];
//


    gbl_tblrpts2_ShouldAddToNavBar = 1; // init to prevent  multiple programatic adds of nav bar items


    int retval;


//<.>
    // add Navigation Bar right buttons, if not added alread
    //
nbn(501);
  NSLog(@"gbl_currentMenuPrefixFromMatchRpt =[%@]",gbl_currentMenuPrefixFromMatchRpt );
  NSLog(@"gbl_lastSelectedPerson =[%@]",gbl_lastSelectedPerson );
  NSLog(@"gbl_currentMenuPlusReportCode=[%@]",gbl_currentMenuPlusReportCode);
  NSLog(@"gbl_tblrpts2_ShouldAddToNavBar=[%ld]",(long)gbl_tblrpts2_ShouldAddToNavBar);

    NSString *myNavBarTitle;
    if (gbl_tblrpts2_ShouldAddToNavBar == 1) { // init to prevent  multiple programatic adds of nav bar items

        gbl_tblrpts2_ShouldAddToNavBar  = 0;   // do not do this again

        // you have to add the info button in interface builder by hand,
        // then you can add  Share button below with   rightBarButtonItems arrayByAddingObject: shareButton];
        //
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                                                                     target: self
                                                                                     action: @selector(shareButtonAction:)];


        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

//        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
//                                                                                         target: self
//                                                                                         action: nil];
//


        if (   [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"]       // My Best Match in Group
            || [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"] )     //    Best Match in Group
        {   // all BEST MATCH ... reports
            myNavBarTitle = @"Best Match";
        }
        if ([gbl_currentMenuPlusReportCode       hasSuffix: @"pe"]) {       // + personality
            myNavBarTitle = @"Personality";
            // 2-LINE TITLE for Personality  in LABEL  myNavBarLabel      
            //
            UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
            NSString *myNavBar2lineTitle;
            myNavBarLabel.numberOfLines = 2;

            myNavBarLabel.font = [UIFont boldSystemFontOfSize: 14.0];
//            myNavBarLabel.font = [UIFont boldSystemFontOfSize: 12.0];

            myNavBarLabel.textColor     = [UIColor blackColor];
            myNavBarLabel.textAlignment = NSTextAlignmentCenter; 

            NSString *personNameOfJustTapped;
            personNameOfJustTapped = [gbl_PSVtappedPerson_fromGRP componentsSeparatedByString:@"|"][0]; // get field #1 (name) (zero-based)

            myNavBar2lineTitle          = [NSString stringWithFormat:  @"%@\n%@", myNavBarTitle, personNameOfJustTapped ];  // set earlier
            myNavBarLabel.text          = myNavBar2lineTitle;

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
// in tblrpts 2, share button is there already from tblrpts 1, i guess
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
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
//                self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];  // 2. of 2
                self.navigationController.navigationBar.backgroundColor = gbl_colorNavBarBG;  // 2. of 2
                //
                // end of  How to hide iOS7 UINavigationBar 1px bottom line

//                [[self navigationItem] setTitle: myNavBarTitle];
//                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
            });                                   
            //
            // 2-LINE TITLE for Personality

        } //  per

        if ([gbl_currentMenuPlusReportCode       hasSuffix: @"co"]) {       // grpof2

            // e.g.
            // gbl_PSVtappedPersonA_inPair=~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||
            // gbl_PSVtappedPersonB_inPair=~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||
            //
            gbl_TBLRPTS2_PSV_personA = gbl_PSVtappedPersonA_inPair;
            gbl_TBLRPTS2_PSV_personB = gbl_PSVtappedPersonB_inPair;
            gbl_TBLRPTS2_NAME_personA = [gbl_TBLRPTS2_PSV_personA  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 
            gbl_TBLRPTS2_NAME_personB = [gbl_TBLRPTS2_PSV_personB  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based

            // 2-LINE TITLE for comp  in LABEL  myNavBarLabel      
            //
            UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
            NSString *myNavBar2lineTitle;
            myNavBarLabel.numberOfLines = 2;

            myNavBarLabel.font = [UIFont boldSystemFontOfSize: 14.0];

            myNavBarLabel.textColor     = [UIColor blackColor];
            myNavBarLabel.textAlignment = NSTextAlignmentCenter; 

            myNavBar2lineTitle          = [NSString stringWithFormat:  @"%@\n%@",
                gbl_TBLRPTS2_NAME_personA, 
                gbl_TBLRPTS2_NAME_personB
            ]; 
            myNavBarLabel.text          = myNavBar2lineTitle;

            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
// in tblrpts 2, share button is there already from tblrpts 1, i guess
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
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
//                self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];  // 2. of 2
                self.navigationController.navigationBar.backgroundColor = gbl_colorNavBarBG;  // 2. of 2
                //
                // end of  How to hide iOS7 UINavigationBar 1px bottom line

//                [[self navigationItem] setTitle: myNavBarTitle];
//                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
            });                                   
            //
            // 2-LINE TITLE for comp
        }  // comp 



  NSLog(@"myNavBarTitle =[%@]",myNavBarTitle );



        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myFlexibleSpace ];
            //


            // How to hide iOS7 UINavigationBar 1px bottom line
            // 
            // you can make the background a solid color by setting backgroundImage to [UIImage new]
            // and assigning navigationBar.backgroundColor to the color you like.
            // (when you  do this,  translucent becomes = NO)  that's OK
            //  http://stackoverflow.com/questions/19226965/how-to-hide-ios7-uinavigationbar-1px-bottom-line/
            [self.navigationController.navigationBar setBackgroundImage: [UIImage new]
                                                         forBarPosition: UIBarPositionAny
                                                             barMetrics: UIBarMetricsDefault];
            //
            [self.navigationController.navigationBar setShadowImage: [UIImage new]];
            //
//            self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
            self.navigationController.navigationBar.backgroundColor = gbl_colorNavBarBG;  // 2. of 2
            //
            // end of  How to hide iOS7 UINavigationBar 1px bottom line

            [self.navigationController.navigationBar setTranslucent:NO];
            [[self navigationItem] setTitle: myNavBarTitle];
        });                                   

    } // end of add Navigation Bar right buttons

//<.>




    // run personality report
    // load new personality TBLRPT  report data into array URLtoHTML_forWebview;
    //
    if ( [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] )  //  personality
    {

//            // try to get rid of tbl position in middle on startup
//nbn(351);
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                [self.tableView reloadData]; // self.view is the table view if self is its controller
//           });

        self.automaticallyAdjustsScrollViewInsets = NO;


        char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
        char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
        const char *my_psvc; // psv=pipe-separated values
        char my_psv[128];
        
        char csv_person_string[128], csv_person1_string[128], csv_person2_string[128];
        char person_name_for_filename[32], person1_name_for_filename[32], person2_name_for_filename[32];
        char myStringBuffForTraitCSV[64];
        
        char  yyyy_todo[16], yyyymmdd_todo[16], stringBuffForStressScore[64] ;
        const char *yyyy_todoC;
        const char *yyyymmdd_todoC;
        int retval, retval2;

        char   html_file_name_browser[2048], html_file_name_webview[2048];
        NSString *Ohtml_file_name_browser, *Ohtml_file_name_webview;
        NSString *OpathToHTML_browser,     *OpathToHTML_webview;
        char     *pathToHTML_browser,      *pathToHTML_webview;
        
        NSURL *URLtoHTML_forWebview;
        NSURL *URLtoHTML_forEmailing;
        NSURLRequest *HTML_URLrequest;
        NSArray* tmpDirFiles;
    


        sfill(myStringBuffForTraitCSV, 60, ' ');  // not used here in per, so blanks

            // NSString object to C
            //const char *my_psvc = [self.fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
    //        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for personality
    //        my_psvc = [gbl_viewHTML_PSV_personJust1 cStringUsingEncoding:NSUTF8StringEncoding];  // for personality

           // wrong my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for personality

            my_psvc = [gbl_PSVtappedPerson_fromGRP  cStringUsingEncoding: NSUTF8StringEncoding];  // for personality

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
            
            // set gbl for email   and title for per
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

//            gbl_pathToFileToBeEmailed = OpathToHTML_browser;
            gbl_pathToFileToBeEmailed_B= OpathToHTML_browser;
            
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

           
nbn(101);
        // gbl_perDataLines;  // used in tblrpts_1 (read in from webview . html file)
        NSString *perDataStr = [NSString stringWithContentsOfURL: URLtoHTML_forWebview  encoding: NSUTF8StringEncoding  error: nil];
        gbl_perDataLines     = [perDataStr componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
  NSLog(@"gbl_perDataLines.count    =[%ld]",gbl_perDataLines.count    );

// Log all data in gbl_perDataLines file array contents    for test 
for (id eltTst in gbl_perDataLines) { NSLog(@"    gbl_per=%@", eltTst); }

        return;


    } // end of if   [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] // home + personality


    // 1. run compatibility report
    // 2. load new grpof2 TBLRPT  report data into array URLtoHTML_forWebview;
    //
    if ( [gbl_currentMenuPlusReportCode hasSuffix: @"co"] )  //  compatibility   grpof2
    {
  NSLog(@" RUNNING  compatibility   grpof2 ");

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


            my_psvc = [gbl_TBLRPTS2_PSV_personA cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA

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
            my_psvc = [gbl_TBLRPTS2_PSV_personB cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA

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



        // 2. load new grpof2 TBLRPT  report data into array URLtoHTML_forWebview;

        // set gbl_perDataLines;  // used in tblrpts_1 (read in from webview . html file)
        //
        // URLtoHTML_forWebview  (a ".html" file) actually has data lines to be used for uitableview version
        //
        NSString *compDataStr = [NSString stringWithContentsOfURL: URLtoHTML_forWebview  encoding: NSUTF8StringEncoding  error: nil];
        gbl_compDataLines     = [compDataStr componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
  NSLog(@"gbl_compDataLines.count    =[%ld]",gbl_compDataLines.count    );

// Log all data in gbl_compDataLines file array contents    for test <.>
for (id eltTst in gbl_compDataLines) { NSLog(@"    gbl_comp=%@", eltTst); }


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


        return;


    } // end of new compatibility   grpof2   in tblrpts_2





//<.> start of GUTS of ViewDidLoad (called only once) moved to ViewDidAppear (called each time becomes visible)
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


//    char csv_person_string[128];
//    char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
//    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
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

    NSArray* tmpDirFiles;
    
    // all BEST MATCH ... reports  ======================================================================================
    // all BEST MATCH ... reports  ======================================================================================
    //
//tn();trn("HEY!");
//  NSLog(@"gbl_currentMenuPrefixFromMatchRpt =%@",gbl_currentMenuPrefixFromMatchRpt );
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//tn();trn("HEY!");
//
    if (   [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"]       // My Best Match in Group
        || [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"] )     //    Best Match in Group
    {   // all BEST MATCH ... reports
//        tn();trn("in REPORT  all BEST MATCH ... reports !");

        //        NSString myTitleForTableview;

        NSString *myKingpinPerson_B;
        NSString *myKingpinCSV_NSString;
        const char *C_CONST_myKingpinPerson_B;   // for get c string
        char        C_myKingpinPerson_B[64];     // for get c string

        // determine the NSString CSV   of the kingpin person (or @"") for this match report
        // in gbl_selectedCellPersonAname   depending on exact report selected
        // in gbl_selectedCellPersonBname   depending on exact report selected
        //

        // in pair reports (Best Match ...) blanks go to '_' to make pairs more readable when a name has a blank in it
        //

        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group ...
           myKingpinPerson_B       = @"";
           myKingpinCSV_NSString = @"";
        }
        if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]) {    // My Best Match in Group ...
           myKingpinPerson_B       = gbl_selectedCellPersonAname;  
           myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson_B]; 
        }
        if ([gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]) {    // My Best Match in Group ...
           myKingpinPerson_B       = gbl_selectedCellPersonBname;  
           myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson_B]; 
        }
        if ([gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]) {    // My Best Match in Group ...
//           myKingpinPerson_B       = gbl_nonKingpinPerson;                     // xTODO  gbl_nameOf_NonKingpin_Person
           myKingpinPerson_B       = gbl_selectedCellPersonBname;  
           myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: (NSString *) myKingpinPerson_B]; 
        }
        
       gbl_kingpinPersonName_B = myKingpinPerson_B;
//
//tn();
//  NSLog(@"myKingpinPerson_B=%@",myKingpinPerson_B);
//  NSLog(@"myKingpinCSV_NSString =%@",myKingpinCSV_NSString );
//tn();
//


        if (myKingpinCSV_NSString == nil) {
            NSLog(@"Could not find person record for person name=%@",myKingpinPerson_B);
            NSLog(@"using ~Abigail ");
            myKingpinCSV_NSString = [myappDelegate getCSVforPersonName: @"~Abibail"]; 
        }

        /* get C string for NSString myKingpinPerson_B
        */

        if ([myKingpinPerson_B isEqualToString: @""]  ||  myKingpinPerson_B == nil) {    // My Best Match in Group ...
            strcpy(C_myKingpinPerson_B, "no person");
        } else {
            C_CONST_myKingpinPerson_B = myKingpinPerson_B.UTF8String;   // for grpone
            strcpy(C_myKingpinPerson_B, C_CONST_myKingpinPerson_B);
        }
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: @"Best Match"];
//        });
//
//

        
//    NSLog(@"gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
//    NSLog(@"gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );
//

        // build HTML file name  in TMP  Directory  (html_file_name_browser);
        //
        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group ...

            strcpy(group_name_for_filename, tmp_grp_name );  
            scharswitch(group_name_for_filename, ' ', '_');
            sprintf(html_file_name_browser, "%sgrpall_%s.html", PREFIX_HTML_FILENAME, group_name_for_filename);

        } else {   // MY  Best Match in Group ...  (grpone)

            strcpy(person_name_for_filename, C_myKingpinPerson_B);
            scharswitch(person_name_for_filename, ' ', '_');

            strcpy(group_name_for_filename, tmp_grp_name );  
            scharswitch(group_name_for_filename, ' ', '_');

            sprintf(html_file_name_browser, "%sgrpone_%s_%s.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
        }
// sprintf(html_file_name_webview, "%sgrpone_%s_%swebview.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
        
        
        gbl_html_file_name_browser_B = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
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
        
        gbl_pathToFileToBeEmailed_B = OpathToHTML_browser;
        
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





        // get a NSString CSV for each member of the group into NSArray gbl_grp_CSVs_B
        // but possibly excluding  one person who is kingpin of grpone report "MY Best Match in Group ..." 
        //
//tn();trn("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//  NSLog(@"myKingpinPerson_B  =%@",myKingpinPerson_B  );
//tn();trn("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//

        gbl_kingpinIsInGroup_B =
            [myappDelegate getNSArrayOfCSVsForGroup: (NSString *)  gbl_lastSelectedGroup    // get into NSArray gbl_grp_CSVs_B
                            excludingThisPersonName: (NSString *)  myKingpinPerson_B  // non-empty string means "my best match ..."
                    puttingIntoArrayWithDescription: (NSString *)  @"gbl_grp_CSVs_B"        // destination array "" or "_B"
        ];

//NSLog(@"gbl_kingpinIsInGroup_B =%ld",gbl_kingpinIsInGroup_B );

//NSLog(@"gbl_grp_CSVs_B =%@",gbl_grp_CSVs_B ); // for test see all grp CSVs
//kin((int)gbl_grp_CSVs_B.count);


            // here we can store the number of pairs ranked  in  gbl_numPairsRanked (for column header size calc)
            //
            if ([myKingpinPerson_B isEqualToString: @""]  ||  myKingpinPerson_B == nil) {    // Best Match in Group ...
                gbl_numPairsRanked = ( gbl_grp_CSVs_B.count * (gbl_grp_CSVs_B.count - 1)) / 2;  // for grpall
            } else {
                gbl_numPairsRanked = gbl_grp_CSVs_B.count;   // (getNSArrayOfCSVsForGroup subtracts one if kingpin is in group)
            }

//                //   - determine  if kingpin is in group
//                //
//                gbl_kingpinIsInGroup_B = 0;
//                NSString *prefixStr = [NSString stringWithFormat: @"%@|", myKingpinPerson_B];
//  NSLog(@"prefixStr =%@",prefixStr );
//                for (NSString *element in gbl_grp_CSVs_B) {
//  NSLog(@"element =%@",element );
//                    if ([element hasPrefix: prefixStr]) {
//                        gbl_kingpinIsInGroup_B = 1;
//                        break;
//                    }
//                }
//tn();tr("one");kin((int)gbl_kingpinIsInGroup_B );
//                if ( gbl_kingpinIsInGroup_B == 0) gbl_numPairsRanked = gbl_grp_CSVs_B.count;
//                if ( gbl_kingpinIsInGroup_B == 1) gbl_numPairsRanked = gbl_grp_CSVs_B.count - 1;
//
//kin((int)gbl_numPairsRanked);
//



        //
        // convert  NSArray gbl_grp_CSVs_B (one NSString CSV for each member of the group)
        // into     a C array of strings for the C report function call mamb_report_person_in_group() -  my_mamb_csv_arr
        //
        //     char group_report_input_birthinfo_CSVs_B[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
        //
        // avoid malloc by this char buffer  to hold max lines of fixed length
        // char group_report_input_birthinfo_CSVs_B[gbl_maxGrpBirthinfoCSVs * gbl_maxLenBirthinfoCSV];  // [250 * fixed length of 64]
        // int  group_report_input_birthinfo_idx_b;
        //
//        char *my_mamb_csv_arr[gbl_maxGrpBirthinfoCSVs];
        char *my_mamb_csv_arr[gbl_MAX_personsInGroup];

        int num_input_csvs;
        num_input_csvs = (int)gbl_grp_CSVs_B.count;
        group_report_input_birthinfo_idx_b =  -1;  // zero-based  init

        for(int i = 0; i < num_input_csvs; i++) {  

          NSString *s      = gbl_grp_CSVs_B[i];     //get a NSString
          const char *cstr = s.UTF8String;        //get cstring

          // index of next spot in buffer
          group_report_input_birthinfo_idx_b = group_report_input_birthinfo_idx_b + 1; 

          // get ptr to next 64-byte slot in buffer
          char *my_ptr_in_buff;
          my_ptr_in_buff = group_report_input_birthinfo_CSVs_B + group_report_input_birthinfo_idx_b * gbl_maxLenBirthinfoCSV;

          // copy cstr into that spot
          strcpy(my_ptr_in_buff, cstr); 

          // put ptr to that spot into c array of strings
          my_mamb_csv_arr[group_report_input_birthinfo_idx_b] = my_ptr_in_buff;
        }

//for (int kkk=0; kkk <= num_input_csvs -1; kkk++) {
//tn();ki(kkk);ks(my_mamb_csv_arr[kkk]); }

        

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
        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    // Best Match in Group ...  this is grpall


        } else {       // *MY*  Best Match in Group ...  this is grpone

//tn();
//  NSLog(@"myKingpinCSV_NSString=%@",myKingpinCSV_NSString);
//tn();
//
            // get kingpin CSV  for C call
                // NSString object to C
//                my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
                my_psvc = [myKingpinCSV_NSString cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
                char my_psv[128];
                strcpy(my_psv, my_psvc); // my_psv like this    _my_psv=[~Sister1,2,31,1988,0,30,1,8,118.15]__
//ksn(my_psv);
                char csv_kingpin[128];
                strcpy(csv_kingpin, my_psv);

            // end of  get kingpin CSV  for C call


//tn();trn("cocoa input csv  input csv  input csv  input csv  input csv  input csv  ");
//ksn(csv_kingpin);
//for (int i=0; i <= num_input_csvs; i++) { ksn(my_mamb_csv_arr[i]); }
//tn();trn("cocoa input csv  input csv  input csv  input csv  input csv  input csv  ");
//tn();
//
//
//tn();trn("HERE  doing person in group ... in tblrpts 2222222"); ks(html_file_name_browser);
//


            // Now call  grpone   report function in grpdoc.c
            //
//            lblSection0.text = [NSString stringWithFormat: @"for   %@\nin Group   %@",gbl_kingpinPersonName_B , gbl_lastSelectedGroup];
//
            tn();trn("in TBLRPT 1  calling  mamb_report_person_in_group() ..."); 

            retval = mamb_report_person_in_group(  /* in grpdoc.o */
              pathToHTML_browser,          // path to html_file
              tmp_grp_name,                // group_name */
              my_mamb_csv_arr,             // from   group_report_input_birthinfo_CSVs_B
              num_input_csvs,              // num_persons_in_grp xxzz
              csv_kingpin,                 // csv_compare_everyone_with,
              group_report_output_PSVs_B,    // array of chars holding output report data
              &group_report_output_idx_B,    // ptr to int having last index written
              (int)gbl_kingpinIsInGroup_B
            );

//tn();trn("in TBLRPT 1  returned from  mamb_report_person_in_group() ...");
//kin(retval);
//
            if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}



            // now that we have group_report_output_PSVs_B, grab all BG color for all tableview cells
            // and put into   NSArray *gbl_array_cellBGcolorName_B;
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

            [gbl_array_cellBGcolorName_B removeAllObjects];               // empty array for BG colors for these new cells
            [gbl_array_cellPersonAname_B removeAllObjects];               // empty array for personA   for these new cells
            [gbl_array_cellPersonBname_B removeAllObjects];               // empty array for personB   for these new cells

            gbl_array_cellBGcolorName_B = [[NSMutableArray alloc] init];  // init  array for BG colors for these new cells
            gbl_array_cellPersonAname_B = [[NSMutableArray alloc] init];  // init  array
            gbl_array_cellPersonBname_B = [[NSMutableArray alloc] init];  // init  array 

//tn();kin(group_report_output_idx_B);

            NSString *myHedColor = @"cHed";

            for (int i=0; i <= group_report_output_idx_B + 3; i++) {  // group_report_output_idx_B = last index written

                if (i == group_report_output_idx_B + 1) {
                   [gbl_array_cellBGcolorName_B addObject: myHedColor];  //  footer line 1  // add the BG colors of the 3 footer cells
                   continue;
                }
                if (i == group_report_output_idx_B + 2) {
                   [gbl_array_cellBGcolorName_B addObject: myHedColor];  //  footer line 2
                   continue;
                }
                if (i == group_report_output_idx_B + 3) {
                   [gbl_array_cellBGcolorName_B addObject: myHedColor];  //  footer line 3
                   continue;
                }
                strcpy(my_buff, group_report_output_PSVs_B  +  i * (int)gbl_maxLenRptLinePSV);  // 128   get ROW   get ROW   get ROW  get ROW
//tn();ki(i);ks(my_buff);

                myCellContentsPSV     = [NSMutableString stringWithUTF8String: my_buff];  // convert c string to NSString
                tmpArray3             = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];

                curr_cellBGcolorName = tmpArray3[0];
                curr_cellPersonAnameTMP = tmpArray3[2];
                curr_cellPersonBnameTMP = tmpArray3[3];
//tn();  NSLog(@"curr_cellPersonAname  =%@",curr_cellPersonAname  );
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

                [gbl_array_cellBGcolorName_B addObject: curr_cellBGcolorName]; 
                [gbl_array_cellPersonAname_B addObject: curr_cellPersonAname];
                [gbl_array_cellPersonBname_B addObject: curr_cellPersonBname];
            }

        } // grpone


//  NSLog(@"gbl_pathToFileToBeEmailed_B =%@",gbl_pathToFileToBeEmailed_B );




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





//        dispatch_async(dispatch_get_main_queue(), ^{                                // <=== 
//            [[self navigationItem] setTitle: @"Best Match"];
//        });
//



    }  // END of   all BEST MATCH ... reports  ======================================================================================

//<.> END  of GUTS of ViewDidLoad (called only once) moved to ViewDidAppear (called each time becomes visible)




} // end of  TBLRPT 2   viewDidLoad!");



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
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (        [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] )  { //  new personality TBLRPT  report

        return  gbl_perDataLines.count;

    } else if ( [gbl_currentMenuPlusReportCode hasSuffix: @"co"] ) { //  grpof2

        return  gbl_compDataLines.count;

    } else {
        return (group_report_output_idx_B + 1 + 3 + 1); // + 3 for 3 bottom cells
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSLog(@"in TBLRPT 2   cellForRowAtIndexPath!");ki((int)indexPath.row);


    // Configure the cell...

    int myidx;
    char my_tmp_str[128];
    NSString *myCellContentsPSV;
    NSCharacterSet *mySeparators;
    NSArray  *tmpArray;
    NSString *myOriginalCellText;
    NSInteger myOriginalCellTextLen;

    NSString           *myNewCellText;
//    NSAttributedString *myNewCellAttributedText; 

    NSInteger numFillSpacesInColHeaders;
    NSInteger numCharsForRankNumsOnLeft;

    numFillSpacesInColHeaders = 0;
    numCharsForRankNumsOnLeft = 0;
    myOriginalCellTextLen     = 0;

//  NSLog(@"in cellForRowAtIndexPath");ki((int)indexPath.row);

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:// forIndexPath:indexPath];
    // Configure the cell...
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"viewTBLRPTs_2_CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }



    if ( [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] )
    {  //  new personality TBLRPT  report
//bn(301);
//  NSLog(@"indexPath.row =[%ld]",indexPath.row );
//  NSLog(@"gbl_perDataLines[indexPath.row]  [%@]",gbl_perDataLines[indexPath.row]  );


        // fixes   bg color of white on left and right
        //    [[UIScrollView appearance] setBackgroundColor: gbl_color_cBgr ];  does not work
        UIView *aBackgroundView = [[UIView alloc] initWithFrame:CGRectZero] ;
        aBackgroundView.backgroundColor = gbl_color_cBgr ;
        cell.backgroundView = aBackgroundView;


//        UIFont *myPerFont        = [UIFont fontWithName: @"Menlo" size: 12.0];
//        UIFont *myPerFont;
//        UIFont *perFontNormal   = [UIFont fontWithName: @"Menlo" size: 14.0];

//        UIFont *perFontNormal   = [UIFont fontWithName: @"Menlo" size: 16.0];
//        UIFont *perFontSmaller  = [UIFont fontWithName: @"Menlo" size: 12.0];
//        UIFont *perFontSmallest = [UIFont fontWithName: @"Menlo-bold" size: 11.0];

        UIFont *myPerFont;
        UIFont *perFont_16  = [UIFont fontWithName: @"Menlo"      size: 16.0];
        UIFont *perFont_16b = [UIFont fontWithName: @"Menlo-bold" size: 16.0];
        UIFont *perFont_15b = [UIFont fontWithName: @"Menlo-bold" size: 15.0];
        UIFont *perFont_14  = [UIFont fontWithName: @"Menlo"      size: 14.0];
        UIFont *perFont_14b = [UIFont fontWithName: @"Menlo-bold" size: 14.0];
        UIFont *perFont_12  = [UIFont fontWithName: @"Menlo"      size: 12.0];
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
        NSString *colorFromCalc;

        mybgcolor         = [UIColor redColor]; // should not show up
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
        if (tmparr.count > 2) {
            colorFromCalc = tmparr[2];
        }
  NSLog(@"mylin=[%@]",mylin);


//<.> old
//        if ( [mycode isEqualToString: @"fill"] ) {
//            myalign           = NSTextAlignmentCenter;
//            mynumlines        = 1;    
//            myadjust          = NO;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontNormal;
//            myPerFont         = perFont_16;
//
//            if ( [mylin isEqualToString: @"filler line #1 at top"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cBgr ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"before table head"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"after table head"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"before table foot"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"after table foot"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"before para"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cBgr ;
////                gbl_heightCellPER = 16;
////                gbl_heightCellPER = 12;
//                gbl_heightCellPER = 15;
//            }
//            else if ( [mylin isEqualToString: @"before willpower"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cBgr ;
//                gbl_heightCellPER = 24;
//            }
//            else if ( [mylin isEqualToString: @"in willpower at beg"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"in willpower at end"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                gbl_heightCellPER = 8;
//            }
//            else if ( [mylin isEqualToString: @"before produced by"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cBgr ;
//                gbl_heightCellPER = 16;
//            }
//            else if ( [mylin isEqualToString: @"before entertainment"] ) {
//                mylin             = @" ";
//                mybgcolor         = gbl_color_cBgr ;
//                gbl_heightCellPER = 4;
//            }
//        }
//        if ( [mycode isEqualToString: @"head"] ) {
//            myalign           = NSTextAlignmentCenter;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cHed ;
////            gbl_heightCellPER = 16;
////            gbl_heightCellPER = 20;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontNormal;
//            myPerFont         = perFont_14;
//        }
//        if ( [mycode isEqualToString: @"foot"] ) {
//            myalign           = NSTextAlignmentCenter;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cHed ;
////            gbl_heightCellPER = 16;
////            gbl_heightCellPER = 18;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontNormal;
//            myPerFont         = perFont_14;
//        }
//        if ( [mycode isEqualToString: @"tabl"] ) {
//            myalign           = NSTextAlignmentLeft;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cNeu ;
////            gbl_heightCellPER = 24;
//            gbl_heightCellPER = 20;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontNormal;
//            myPerFont         = perFont_16;
//        }
//        if ( [mycode isEqualToString: @"para"] ) {
//            myalign           = NSTextAlignmentLeft;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cBgr ;
////            gbl_heightCellPER = 16;
////            gbl_heightCellPER = 20;
//            gbl_heightCellPER = 18;
//            myadjust          = NO;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontNormal;
//            myPerFont         = perFont_16;
//        }
//        if ( [mycode isEqualToString: @"will"] ) {
//            myalign           = NSTextAlignmentLeft;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cHed ;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontNormal;
//            myPerFont         = perFont_16;
//        }
//        if ( [mycode isEqualToString: @"prod"] ) {
//            myalign           = NSTextAlignmentCenter;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cBgr ;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFontSmaller;
//            myPerFont         = perFont_12;
//        }
//        if ( [mycode isEqualToString: @"purp"] ) {
//            myalign           = NSTextAlignmentCenter;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cBgr ;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor redColor];
////            myPerFont         = perFontSmallest;
//            myPerFont         = perFont_11b;
//        }
//<.> old


//<.> new
        if ( [mycode isEqualToString: @"fill"] ) {
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myPerFont         = perFont_16;

            if ( [mylin isEqualToString: @"filler line #1 at top"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
                mybgcolor         = [UIColor greenColor] ;
//                gbl_heightCellPER = 8;
//                gbl_heightCellPER = 24  ;
                gbl_heightCellPER = 16  ;
            }
            else if ( [mylin isEqualToString: @"before table head"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cPerGreen1;
                mybgcolor         = gbl_color_cAplDarkBlue;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"after table head1"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
                mybgcolor         = gbl_color_cAplDarkBlue;
                gbl_heightCellPER = 4;
            }
            else if ( [mylin isEqualToString: @"after table head2"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
                mybgcolor         = gbl_color_cPerGreen1;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before table foot1"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
                mybgcolor         = gbl_color_cPerGreen1;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before table foot2"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
                mybgcolor         = gbl_color_cAplDarkBlue;
                gbl_heightCellPER = 4;
            }
            else if ( [mylin isEqualToString: @"after table foot"] ) {
                mylin             = @" ";
//                mybgcolor         = gbl_color_cHed ;
                mybgcolor         = gbl_color_cAplDarkBlue;
                gbl_heightCellPER = 8;
            }
            else if ( [mylin isEqualToString: @"before para"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
//                gbl_heightCellPER = 12;
//                gbl_heightCellPER = 18;
                gbl_heightCellPER = 15;
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
//            myalign           = NSTextAlignmentCenter;
//            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cHed ;
////            gbl_heightCellPER = 16;
////            gbl_heightCellPER = 20;
//            gbl_heightCellPER = 16;
//            myadjust          = YES;
//            mytextcolor       = [UIColor blackColor];
////            myPerFont         = perFont_16;
//            myPerFont         = perFont_14;
//
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cAplDarkBlue ;
//            gbl_heightCellPER = 16;
//            gbl_heightCellPER = 20;
            gbl_heightCellPER = 16;
            gbl_heightCellPER = 17;
            myadjust          = YES;
            mytextcolor       = [UIColor whiteColor];
//            mytextcolor       = [UIColor cyanColor];
//            myPerFont         = perFont_16;
//            myPerFont         = perFont_14b;
            myPerFont         = perFont_16b;

        }
        if ( [mycode isEqualToString: @"foot"] ) {
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            mybgcolor         = gbl_color_cHed ;
            mybgcolor         = gbl_color_cAplDarkBlue ;
//            gbl_heightCellPER = 16;
            gbl_heightCellPER = 16;
            gbl_heightCellPER = 20;
            myadjust          = YES;
            mytextcolor       = [UIColor blackColor];
            mytextcolor       = [UIColor whiteColor];
//            myPerFont         = perFont_16;
//            myPerFont         = perFont_14b;
            myPerFont         = perFont_15b;
        }
        if ( [mycode isEqualToString: @"tabl"] ) {
            myalign           = NSTextAlignmentLeft;
            mynumlines        = 1;    
//            mybgcolor         = gbl_color_cNeu ;
//            mybgcolor         = gbl_color_cGre ;
//            if ( [colorFromCalc  isEqualToString: @"cPerGreen1" ]) mybgcolor = gbl_color_cGr2; // from perhtm data fld 3 
//            if ( [colorFromCalc  isEqualToString: @"cPerGreen2" ]) mybgcolor = gbl_color_cGre;
            if ( [colorFromCalc  isEqualToString: @"cPerGreen1" ]) mybgcolor = gbl_color_cPerGreen1; // from perhtm data fld 3 
            if ( [colorFromCalc  isEqualToString: @"cPerGreen2" ]) mybgcolor = gbl_color_cPerGreen2;


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


//<.> new

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

        return cell;

    }  // end of new personality TBLRPT  report




    //  new compatibility TBLRPT  report   $$$$$$$ in cellforrowataindexpath $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    //
    // if ( [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] )
    if ( [gbl_currentMenuPlusReportCode hasSuffix: @"co"] )
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

        mybgcolor         = [UIColor brownColor];
        myalign           = NSTextAlignmentLeft;  // default
        mynumlines        = 1;                    // default
        myadjust          = YES;                  // default
        mytextcolor       = [UIColor greenColor]; // default

        mySeps    = [NSCharacterSet characterSetWithCharactersInString:  @"|"];

 tn();
        mywrk     = gbl_compDataLines[indexPath.row];  
  NSLog(@"mywrk=[%@]",mywrk);

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
            myalign           = NSTextAlignmentCenter;
            mynumlines        = 1;    
            myadjust          = NO;
            mytextcolor       = [UIColor blackColor];
            myCompFont         = compFont_16;

            if ( [mylin isEqualToString: @"filler line #1 at top"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cBgr ;
//                mybgcolor         = [UIColor redColor];
                gbl_heightCellCOMP = 18;
            }
            else if ( [mylin isEqualToString: @"before table head"] ) {
                mylin             = @" ";
                mybgcolor         = gbl_color_cHed ;
//                mybgcolor         = gbl_color_cGre ;
//                mybgcolor         = gbl_color_cNeu ;
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
                mybgcolor         = [UIColor blueColor];
                gbl_heightForCompTable = 2.0;
                thisIsHeaderSpace      = 1;
               mylin = @" ";
            } else {
                mybgcolor         = [UIColor cyanColor];
//                gbl_heightForCompTable = 18.0;
//                gbl_heightForCompTable = 16.0;
                gbl_heightForCompTable = 2.0;
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
nbn(70);
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
nbn(75);
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
                    sco >  25    ) {
nbn(76);
                    mybgcolorfortableline = gbl_color_cNeu;
                }
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

    // END of    new compatibility TBLRPT  report   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$












    cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

//    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 12.0];
    UIFont *myFont        = [UIFont fontWithName: @"Menlo" size: 16.0];
    UIFont *myFontSmaller = [UIFont fontWithName: @"Menlo" size: 12.0];

    // invisible button for taking away the disclosure indicator
    //
//    UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    UIButton *myInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [UIButton buttonWithType: UIButtonTypeCustom];
    myInvisibleButton.backgroundColor = [UIColor clearColor];


    //tn();tr("row row row row row row row = ");NSLog(@"indexPath.row=%ld", indexPath.row);

//  NSLog(@"myCellContentsPSV =[%@]", myCellContentsPSV );
//tn();kin(group_report_output_idx_B);



    // Grab cell data,  but only if indexPath.row is still in array (3 extra footer cells)
    //
    if (indexPath.row <= group_report_output_idx_B) {

        myidx = (int)indexPath.row;
        strcpy(my_tmp_str, group_report_output_PSVs_B  +  myidx * (int)gbl_maxLenRptLinePSV);  // 64   get ROW   get ROW   get ROW  get ROW  
//ksn(my_tmp_str);
        myCellContentsPSV     = [NSString stringWithUTF8String: my_tmp_str];  // convert c string to NSString
        mySeparators          = [NSCharacterSet characterSetWithCharactersInString:@"|"];
        tmpArray              = [myCellContentsPSV componentsSeparatedByCharactersInSet: mySeparators];
//        gbl_cellBGcolorName   = tmpArray[0];
        myOriginalCellText    = tmpArray[1];
        myOriginalCellTextLen = myOriginalCellText.length;

//        NSLog(@"myOriginalCellText    =%@",myOriginalCellText    );
//        NSLog(@"myOriginalCellTextLen =%ld",myOriginalCellTextLen );


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




    if (indexPath.row ==  group_report_output_idx_B + 1)
    {  // 1 of 3 FOOTER CELLS

        NSMutableAttributedString *myAttrString;    // for cell text
        NSString                  *myStringNoAttr;  // for work string

        myAttrString   = [[NSMutableAttributedString alloc] initWithString:  @"                             \n|   a GOOD RELATIONSHIP     |\n|   usually has 2 things    |\n|1. compatibility potential |\n|2. both sides show positive|\n|   personality traits      |\n                             "
        ];
        myStringNoAttr = [myAttrString  string];

        // find the pipes and make them invisible
        // note: search myStringNoAttr, but make changes in myAttringString
        //
        // Setup what you're searching and what you want to find
        NSString *toFind = @"|";

        // Initialise the searching range to the whole string
        NSRange searchRange = NSMakeRange(0, [myStringNoAttr length]);
//  NSLog(@"searchRange.location =[%lu]",(unsigned long)searchRange.location );
//  NSLog(@"searchRange.length   =[%lu]",(unsigned long)searchRange.length   );
        do {
            // Search for next occurrence
            NSRange searchReturnRange = [myStringNoAttr  rangeOfString: toFind  options: 0  range: searchRange];
//  NSLog(@"searchReturnRange.location =[%lu]",(unsigned long)searchReturnRange.location );
//  NSLog(@"searchReturnRange.length   =[%lu]",(unsigned long)searchReturnRange.length   );
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
//  NSLog(@"searchRange.location2=[%lu]",(unsigned long)searchRange.location );
//  NSLog(@"searchRange.length  2=[%lu]",(unsigned long)searchRange.length   );
            } else {
                // If we didn't find it, we have no more occurrences
                break;
            }
        } while (1);



        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            cell.textLabel.font          = myFont;
            cell.textLabel.font          = myFontSmaller;
            cell.textLabel.numberOfLines = 7; 
            cell.accessoryView           = myInvisibleButton;               // no right arrow on column labels
            cell.userInteractionEnabled  = NO;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            cell.textLabel.text          = @"         hey                        \n        a GOOD RELATIONSHIP            \n        usually has 2 things             \n xxx 1. compatibility potential  yyyyy   \n     2. both sides show positive         \n        personality traits               \n                                         ";
            cell.textLabel.attributedText = myAttrString;
        });

        return cell;
    }  // end of 1 of 3 FOOTER CELLS


    else if (indexPath.row ==  group_report_output_idx_B + 2)
    {  // 2 of 3 FOOTER CELLS

        //        myNewCellText                = @"     Produced by iPhone App Me and my BFFs   ";
        NSAttributedString *myNewCellAttributedText1 = [
            [NSAttributedString alloc] initWithString: @"        Produced by iPhone App Me and my BFFs   "
                                           attributes: @{            NSFontAttributeName : [UIFont systemFontOfSize:11.0f] }
        ];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            cell.textLabel.font           = myFont;
//            cell.textLabel.numberOfLines  = 1; 
            cell.textLabel.numberOfLines  = 7; 
            cell.accessoryView            = myInvisibleButton;               // no right arrow on column labels
            cell.userInteractionEnabled   = NO;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.attributedText = myNewCellAttributedText1;
        });

        return cell;
    }  // end of 2 of 3 FOOTER CELLS

    else if (indexPath.row ==  group_report_output_idx_B + 3)
    {  // 3 of 3 FOOTER CELLS

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


        else if (indexPath.row ==  group_report_output_idx_B + 4)
        {  // 4 of 3 FOOTER CELLS
trn("// 4 of 3 FOOTER CELLS");
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                cell.accessoryType           = UITableViewCellAccessoryNone;
                cell.accessoryView           = myInvisibleButton;            // no right arrow on benchmark label
                cell.textLabel.numberOfLines = 1; 
                cell.textLabel.textColor     = [UIColor blackColor];
                cell.textLabel.font          = myFont;
                cell.textLabel.text          = @" ";  // ------------------------------------------------------------
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.userInteractionEnabled  = NO;                           // no selection highlighting
//                if ([gbl_currentMenuPlusReportCode hasPrefix: @"homgm"] )  cell.backgroundView =  nil;
            });

trn("// END   END    4 of 3 FOOTER CELLS");
            return cell;
        }  // 4 of 3 FOOTER CELLS


    else if (indexPath.row == 0) {  // COLUMN HEADERS   SPACER   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//tn();trn("in row 0  SPACER");
        // this is spacer row between 'for ... \n in Group ...'  and col headers
        //

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            cell.accessoryType           = UITableViewCellAccessoryNone;
            cell.accessoryView           = myInvisibleButton;            // no right arrow on benchmark label
            cell.textLabel.numberOfLines = 1; 
            cell.textLabel.textColor     = [UIColor blackColor];
            cell.textLabel.font          = myFont;
            cell.textLabel.text          = @" ";  // ------------------------------------------------------------
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.userInteractionEnabled  = NO;                           // no selection highlighting
        });

        return cell;

    } // end of spacer row before col headers

    else if (indexPath.row == 1)
    {   // first header line    hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr hdrhdr
//trn("in row = 1");

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

//  NSLog(@"LL myOriginalCellText =[%@]",myOriginalCellText );

        // grab first line with a person   THAT IS-
        // grab first line not a benchmark label
        //
            for (int myidx=3; myidx <= 9; myidx++) {

                strcpy(my_tmp_str, group_report_output_PSVs_B  +  myidx * (int)gbl_maxLenRptLinePSV);  

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
            // end of grab first line with a person


            NSString *myFirstData =  [NSString stringWithUTF8String: my_tmp_str];  // convert c string to NSString
            NSArray  *tmpArray2   = [myFirstData componentsSeparatedByCharactersInSet: mySeparators];  // delim= '|'
            NSString *myFirstHdrLine = tmpArray2[1];

            const char *tmp_c_CONST;                                                  // NSString object to C str
            char tmp_c_first_person_buff[128];                                        // NSString object to C str
            tmp_c_CONST = [myFirstHdrLine cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
            strcpy(tmp_c_first_person_buff, tmp_c_CONST);                             // NSString object to C str  because of const
            //tn();ksn(tmp_c_first_person_buff);
        //
        // end of  grab first line with a person


        // for the rank number lines below, determine the number of left spaces to remove- gbl_numLeadingSpacesToRemove_B 
        // and still keep all the rank number
        //
        int mycharnum;
        mycharnum = 0; // one-based
        for (int mm=0; mm <= (int)strlen(tmp_c_first_person_buff) -1; mm++) {
            mycharnum = mycharnum + 1;
            if (tmp_c_first_person_buff[mm] == '1') break;  // find index of first '1'
        }
        gbl_numLeadingSpacesToRemove_B = mycharnum - numCharsForRankNumsOnLeft; // e.g. "00001" 1on=5 rank=2 remove=3  // for LONG
//kin((int)gbl_numLeadingSpacesToRemove_B );



//  kin((int)myOriginalCellTextLen);

        if (myOriginalCellTextLen <= 45) 
        { // short LINE  FIRST HEADER LINE  CALC
            // - gbl_numLeadingSpacesToRemove_B   for spaces needing to be removed  
            // - 1                              for one space on right end
            gbl_myCellAdjustedTextLen_B = myOriginalCellTextLen -  1 - gbl_numLeadingSpacesToRemove_B;
        } // end of short LINE  FIRST HEADER LINE  CALC
        else {
            // - gbl_numLeadingSpacesToRemove_B   for spaces needing to be removed  
            // - 12                             for "  Very Good " wrapped to inside
            gbl_myCellAdjustedTextLen_B = myOriginalCellTextLen - 12 - gbl_numLeadingSpacesToRemove_B;
        }
//  kin((int)gbl_myCellAdjustedTextLen_B);


        numFillSpacesInColHeaders =
            gbl_myCellAdjustedTextLen_B - numCharsForRankNumsOnLeft - 3 - numCharsPairHdr - numCharsScoreHdr; // 3 spaces

//kin((int)numFillSpacesInColHeaders );

        gbl_myCharsForRankNumsOnLeft_B = [@"" stringByPaddingToLength: numCharsForRankNumsOnLeft + 3 // 3 for spaces after ranknum
                                                         withString: @" "
                                                    startingAtIndex: 0 ];
        gbl_myFillSpacesInColHeaders_B = [@"" stringByPaddingToLength: numFillSpacesInColHeaders 
                                                         withString: @" "
                                                    startingAtIndex: 0 ];
//        NSLog(@"gbl_myCharsForRankNumsOnLeft_B =[%@]",gbl_myCharsForRankNumsOnLeft_B );
//        NSLog(@"gbl_myFillSpacesInColHeaders_B =[%@]",gbl_myFillSpacesInColHeaders_B );



        // for grpone, change column headers if kingpin ( compare_everyone_with ) is not in the group
        //
//tn();kin((int)gbl_numPairsRanked);
//  NSLog(@"gbl_numPairsRanked =%ld",gbl_numPairsRanked );
//  NSLog(@"gbl_grp_CSVs_B.count =%ld",gbl_grp_CSVs_B.count );
//  NSLog(@"gbl_numPeopleInCurrentGroup=%ld",gbl_numPeopleInCurrentGroup);
//tn();tr("TWO!!!");kin(gbl_kingpinIsInGroup_B );

        if (gbl_numPairsRanked == gbl_numPeopleInCurrentGroup - 1) {  // YES
            myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",   //  assign  assign  assign  assign  assign  assign assign 
                gbl_myCharsForRankNumsOnLeft_B, @"Pair of      ", gbl_myFillSpacesInColHeaders_B, @"Compatibility" ];
        }
        if (gbl_numPairsRanked == gbl_numPeopleInCurrentGroup    ) {  //  NO
            myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",   //  assign  assign  assign  assign  assign  assign assign 
                gbl_myCharsForRankNumsOnLeft_B, @"Person and   ", gbl_myFillSpacesInColHeaders_B, @"Compatibility" ];

        }

//            cell.accessoryType           = UITableViewCellAccessoryNone;  // setting ignored if cell.accessoryView is set (not nil)
//            cell.userInteractionEnabled  = NO;                           // no selection highlighting
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
            cell.textLabel.textColor                 = [UIColor blackColor];
            cell.userInteractionEnabled              = YES;      // method just returns 
//            cell.userInteractionEnabled              = NO;  // b level rpts no selection                
            cell.textLabel.numberOfLines             = 1; 
            cell.textLabel.font                      = myFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.text                      = myNewCellText;  // ------------------------------------------------------------
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        });


  
//  NSLog(@"HDR#1 cell.userInteractionEnabled  =%d",cell.userInteractionEnabled  );


        return cell;
    }   // end of first header line


    else if (indexPath.row == 2)
    {  // COLUMN HEADER  second header line  xxxxxxxxxxxxxxxxxxxxxxxxxxxxx

//  NSLog(@"2 gbl_myCharsForRankNumsOnLeft_B =[%@]",gbl_myCharsForRankNumsOnLeft_B );
//  NSLog(@"2 gbl_myFillSpacesInColHeaders_B =[%@]",gbl_myFillSpacesInColHeaders_B );

//        cell.textLabel.numberOfLines = 1; 
//        //cell.accessoryType           = UITableViewCellAccessoryNone;
//        cell.accessoryView = myInvisibleButton;               // no right arrow on column labels
//        //[cell setUserInteractionEnabled: NO];
//        cell.userInteractionEnabled = NO;



        // for grpone, change column headers if kingpin ( compare_everyone_with ) is not in the group
        //
        if (gbl_numPairsRanked == gbl_numPeopleInCurrentGroup - 1) {  // YES
            myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",
                gbl_myCharsForRankNumsOnLeft_B, @"Group Members", gbl_myFillSpacesInColHeaders_B, @"    Potential"  ];
        }
        if (gbl_numPairsRanked == gbl_numPeopleInCurrentGroup    ) {  //  NO
            myNewCellText   = [NSString stringWithFormat:@"%@%@%@%@",
                gbl_myCharsForRankNumsOnLeft_B, @"Group Member ", gbl_myFillSpacesInColHeaders_B, @"    Potential"  ];
        }



//        UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 12.0];
//            cell.accessoryType           = UITableViewCellAccessoryNone;
//            cell.userInteractionEnabled  = NO;                           /// no selection highlighting

        // put info button on Nav Bar
        //        UIButton *myInfoButton =  [UIButton buttonWithType: UIButtonTypeInfoDark] ;
        //            UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
        //            cell.accessoryView                       = myInfoButton;            // no right arrow on benchmark label

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
            cell.userInteractionEnabled              = YES;      // action method just returns 
//            cell.userInteractionEnabled              = NO;  // b level rpts no selection                
            cell.textLabel.numberOfLines             = 1; 
            cell.textLabel.textColor                 = [UIColor blackColor];
            cell.textLabel.font                      = myFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.textLabel.text                      = myNewCellText;  // ------------------------------------------------------------
        });

//  NSLog(@"HDR#2 cell.userInteractionEnabled  =%d",cell.userInteractionEnabled  );

        return cell;
    }  // end of  COLUMN HEADER  second header line  xxxxxxxxxxxxxxxxxxxxxxxxxxxxx


    else if (myOriginalCellTextLen <= 45)
    {  // shorter data line


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
            NSMakeRange(gbl_numLeadingSpacesToRemove_B, mylen1 - gbl_numLeadingSpacesToRemove_B)]; // zero-based
//NSLog(@"myNewCellTextShort B =[%@]",myNewCellTextShort     );


    }   // end shorter data line


    else 
    {  //  long line, shorten by putting  benchmark labels on the inside like this:

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
            NSMakeRange(gbl_numLeadingSpacesToRemove_B, mylen - gbl_numLeadingSpacesToRemove_B)]; // zero-based
//              NSMakeRange(gbl_numLeadingSpacesToRemove_B, mylen)]; // zero-based
//NSLog(@"myNewCellText      3B   =[%@]",myNewCellText      );



//      NSLog(@"myNewCellText1 =[%@]",myNewCellText  );




//  NSLog(@"myOriginalCellText 3    =[%@]",myOriginalCellText      );
          if ([myOriginalCellText hasSuffix: @"90  Great     "]) {
  //            numLeadingSpaces = myOriginalCellTextLen - 12 - 14;
//  trn("hey");
//  kin((int)gbl_myCellAdjustedTextLen_B);
              numLeadingSpaces = gbl_myCellAdjustedTextLen_B - @"    Great  90".length ;

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
              numLeadingSpaces = gbl_myCellAdjustedTextLen_B - @"Very Good  75".length ;
              myLeadingSpaces = @"";
              myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                  withString: @" "
                                             startingAtIndex: 0 ];
              myNewCellText   = [NSString stringWithFormat:@"%@Very Good  75", myLeadingSpaces];
          }
          if ([myOriginalCellText hasSuffix: @"50  Average   "]) {
              numLeadingSpaces = gbl_myCellAdjustedTextLen_B - @"  Average  50".length ;
              myLeadingSpaces = @"";
              myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                  withString: @" "
                                             startingAtIndex: 0 ];
              myNewCellText   = [NSString stringWithFormat:@"%@  Average  50", myLeadingSpaces];
          }
          if ([myOriginalCellText hasSuffix: @"25  Not Good  "]) {
              numLeadingSpaces = gbl_myCellAdjustedTextLen_B - @" Not Good  25".length ;
              myLeadingSpaces = @"";
              myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                  withString: @" "
                                             startingAtIndex: 0 ];
              myNewCellText   = [NSString stringWithFormat:@"%@ Not Good  25", myLeadingSpaces];
          }
          if ([myOriginalCellText hasSuffix: @"10  OMG       "]) {
              numLeadingSpaces = gbl_myCellAdjustedTextLen_B - @"      OMG  10".length ;
              myLeadingSpaces = @"";
              myLeadingSpaces = [@"" stringByPaddingToLength: numLeadingSpaces
                                                  withString: @" "
                                             startingAtIndex: 0 ];
              myNewCellText   = [NSString stringWithFormat:@"%@      OMG  10", myLeadingSpaces];
          }

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
            cell.textLabel.font                      = myFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        });

    } else {

//
//        // UILabel for the disclosure indicator, ">",  for tappable cells
//        //
//            NSString *myDisclosureIndicatorBGcolorName; 
//            NSString *myDisclosureIndicatorText; 
//            UIColor  *colorOfGroupReportArrow; 
//            UIFont   *myDisclosureIndicatorFont; 
//
//            myDisclosureIndicatorText = @">"; 
//            myDisclosureIndicatorBGcolorName = gbl_array_cellBGcolorName_B[indexPath.row];   // array set in  viewDidLoad
////        NSLog(@"myDisclosureIndicatorBGcolorName =%@",myDisclosureIndicatorBGcolorName );
//  
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] ) {
//                colorOfGroupReportArrow   = [UIColor blackColor];                 // deepest red is pretty  dark
//                myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
//            } else {
//                colorOfGroupReportArrow   = [UIColor  grayColor];
//                myDisclosureIndicatorFont = [UIFont boldSystemFontOfSize: 16.0f];
//            }
//
//
//            NSAttributedString *myNewCellAttributedText3 = [
//                [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
//                                               attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
//                                                               NSForegroundColorAttributeName: colorOfGroupReportArrow                }
//            ];
//
//            UILabel *myDisclosureIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
//            myDisclosureIndicatorLabel.attributedText = myNewCellAttributedText3;
//
//
//
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cHed"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cHed;
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cGr2"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cGr2;
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cGre"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cGre;
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cNeu"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cNeu;
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRed"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cRed;
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cRe2;
//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cBgr"] )  myDisclosureIndicatorLabel.backgroundColor = gbl_color_cBgr;
//        //
//        // end of  UILabel for the disclosure indicator, ">",  for tappable cells
//



        dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line
            cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.userInteractionEnabled              = YES;                  
            cell.userInteractionEnabled              = NO;  // b level rpts no selection                

//            cell.accessoryView                       = nil;   // use accessoryType setting   // have right arrow on column labels
//            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

//            cell.accessoryView                       = myDisclosureIndicatorLabel;
//            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView                       = myInvisibleButton;               // no right arrow on column labels
            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

            cell.textLabel.numberOfLines             = 1; 

//    if (gbl_cre2Flag == 1) {
//        cell.textLabel.textColor                 = [UIColor whiteColor]; 
//        gbl_cre2Flag = 0;
//nbn(300);
//    } else {
//nbn(301);
//        cell.textLabel.textColor                 = [UIColor blackColor];
//    }
//
            cell.textLabel.textColor                 = [UIColor blackColor];
            cell.textLabel.font                      = myFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        });
    }


    // set cell height to 32.0   see method heightForRowAtIndexPath  below

    return cell;

} // end of  tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath


// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
//  NSLog(@"in heightForRowAtIndexPath TBLRPT 2  ");
//  NSLog(@"gbl_heightCellPER=[%d]", (int)gbl_heightCellPER);


    if ( [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]  //  new personality TBLRPT  report
    ) {
        return gbl_heightCellPER;  
    }
    if ( [gbl_currentMenuPlusReportCode hasSuffix: @"co"]  //  new compatibility   grpof2
    ) {

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

//        return gbl_heightCellCOMP;  

    } // co


    // return customTableCellHeight;

    // if (indexPath.row == 0) return 66.0;
//    if (indexPath.row == 0) return 45.0;
//    if (indexPath.row == 0) return 30.0;
//    if (indexPath.row == 0) return 38.0;
//    if (indexPath.row == 0) return 55.0;

//    if (indexPath.row == 0) return 45.0;
//    if (indexPath.row == 0) return 20.0;
//    if (indexPath.row == 1) return 20.0;

//    if (indexPath.row == 0) return 15.0;
//    if (indexPath.row == 1) return 15.0;
    //if (indexPath.row == 0) return  7.0;  // spacer
    if (indexPath.row == 0) return 14.0;  // spacer
//        if (indexPath.row == 1) return 15.0;  // col hdr 1
//        if (indexPath.row == 2) return 15.0;  // col hdr 2
        if (indexPath.row == 1) return 18.0;  // col hdr 1
        if (indexPath.row == 2) return 21.0;  // col hdr 2
 
//    if (indexPath.row == group_report_output_idx_B + 1) return 15.0 * 7;  // ftr 1
//    if (indexPath.row == group_report_output_idx_B + 2) return 15.0 ;     // ftr 2
//    if (indexPath.row == group_report_output_idx_B + 3) return 20.0 ;     // ftr 3

    if (indexPath.row == group_report_output_idx_B + 1) return 15.0 * 7;  // ftr 1
    if (indexPath.row == group_report_output_idx_B + 2) return 30.0 ;     // ftr 2
    if (indexPath.row == group_report_output_idx_B + 3) return  8.0 ;     // ftr 3
    if (indexPath.row == group_report_output_idx_B + 4) return 16.0 ;     // end fill

    return 35.0;

}  // ---------------------------------------------------------------------------------------------------------------------

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
}


// how to set the section header cell height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  // --------------------------------
{
  NSLog(@"gbl_currentMenuPlusReportCode =[%@]",gbl_currentMenuPlusReportCode );
    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]  
    ) {
        return 0.0;
    }
    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"co"]  
    ) {
        // return 34.0;
        // return 0.0;
        return 0.01f;
    }

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]       // my Best Match in Group ... (personB)
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]       // my Best Match in Group ... (personB)
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]       // my Best Match in Group ... (personA)
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1bm"]       // my Best Match in Group ... (personA)
    ) {
        return 34.0;   // MY Best Match in Group ...   2 lines
    }

    // the only report MAMB09viewTBLRPTs_2_TableViewController.m does is grpone with kingpin being a member of the group
    //
    //return 34.0;  
    return 0.01f;   // should  not happen
}  // ---------------------------------------------------------------------------------------------------------------------



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
  NSLog(@"in viewForHeaderInSection  in tblrpts 2");

    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]  
        || [gbl_currentMenuPlusReportCode hasSuffix: @"co"]  
    ) {
        return nil;
    }


    UIView *myReturnView;

    if (section == 0) {
        UILabel *lblSection0 = [[UILabel alloc] init];
//
////        if ([gbl_kingpinPersonName isEqualToString: @""]  ||  gbl_kingpinPersonName == nil) {    //    Best Match in Group ...
//    //  if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]) {    //    Best Match in Group ...
//        if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"]) {    //    Best Match in Group
//            lblSection0.numberOfLines = 1;
//            lblSection0.text = [NSString stringWithFormat: @"in Group   %@", gbl_lastSelectedGroup];
//
//        }
//        if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"]) {    // My Best Match in Group
//            lblSection0.numberOfLines = 2;
////            lblSection0.text = [NSString stringWithFormat: @"for   %@\nin Group   %@", gbl_kingpinPersonName, gbl_lastSelectedGroup];
//            lblSection0.text = [NSString stringWithFormat: @"for   %@\nin Group   %@",gbl_kingpinPersonName_B , gbl_lastSelectedGroup];
//        }
//
        NSString *myGrponePersonName;
        if (       [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]) {    // my Best Match in Group ... (personA)
            myGrponePersonName = [gbl_PSVtappedPersonA_inPair componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

        } else if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]       // my Best Match in Group ... (personB)
                   || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]       // my Best Match in Group ... (personB)
        ) {
            myGrponePersonName = [gbl_PSVtappedPersonB_inPair componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

        } else {
            myGrponePersonName = @"x05"; // should never happen
        }

        // the only report MAMB09viewTBLRPTs_2_TableViewController.m does is grpone with kingpin being a member of the group
        //
        lblSection0.numberOfLines = 2;
        lblSection0.font          = [UIFont boldSystemFontOfSize: 14.0];
        lblSection0.text = [NSString stringWithFormat: @"for   %@\nin Group   %@", myGrponePersonName, gbl_lastSelectedGroup];

//            lblSection0.layer.borderWidth = 1.0f;  // TEST VISIBLE LABEL  (works great)


//lblSection0.backgroundColor =  gbl_color_cHed;  
//        lblSection0.backgroundColor = gbl_color_cAplTop;
        //        lblSection0.backgroundColor = [UIColor redColor];   for test
//        lblSection0.backgroundColor = [UIColor whiteColor];
        lblSection0.backgroundColor = gbl_colorNavBarBG;

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
}



// how to set cell background color
//
- (void)tableView:(UITableView *)tableView willDisplayCell: (UITableViewCell *)cell
                                         forRowAtIndexPath: (NSIndexPath *)indexPath 
{
//  NSLog(@"in willDisplayCell");

    NSString *thisCellBGcolorName; 

    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]  
    ) {
        return;
    }
    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"co"]  
    ) {
        cell.backgroundColor = gbl_color_cBgr;
        return;
    }


//
//    thisCellBGcolorName = gbl_array_cellBGcolorName_B[indexPath.row];   // array set in  viewDidLoad
////  NSLog(@"thisCellBGcolorName =%@",thisCellBGcolorName );
//

    if (indexPath.row  <=  gbl_array_cellBGcolorName.count -1 )  // is max idx number (0-based)
    {
//  NSLog(@"indexPath.row =[%ld]",(long)indexPath.row );
        thisCellBGcolorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
//  NSLog(@"thisCellBGcolorName =%@",thisCellBGcolorName );
    } else {

        cell.backgroundColor = gbl_color_cBgr;
//  NSLog(@"   RETURN  because no bg color");

        return;
    }


    dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line

        if ( [thisCellBGcolorName isEqualToString: @"cHed"] )  cell.backgroundColor = gbl_color_cHed;

        if ( [thisCellBGcolorName isEqualToString: @"cGr2"] )  cell.backgroundColor = gbl_color_cGr2;
        if ( [thisCellBGcolorName isEqualToString: @"cGre"] )  cell.backgroundColor = gbl_color_cGre;
        if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )
        {
nbn(77);
            cell.backgroundColor = gbl_color_cNeu;
        }
        if ( [thisCellBGcolorName isEqualToString: @"cRed"] )  cell.backgroundColor = gbl_color_cRed;
        if ( [thisCellBGcolorName isEqualToString: @"cRe2"] )  cell.backgroundColor = gbl_color_cRe2;
        if ( [thisCellBGcolorName isEqualToString: @"cBgr"] )  cell.backgroundColor = gbl_color_cBgr;

        if (indexPath.row ==  group_report_output_idx_B + 1) {  // 1 of 3 FOOTER CELLS
            cell.backgroundColor = gbl_color_cHed;
        }
        if (indexPath.row ==  group_report_output_idx_B + 2) {  // fill 1
            cell.backgroundColor = gbl_color_cBgr;
        }
        if (indexPath.row ==  group_report_output_idx_B + 3) {  // 2 of 3 FOOTER CELLS
            cell.backgroundColor = gbl_color_cBgr;
        }
        if (indexPath.row ==  group_report_output_idx_B + 4) {  // fill 2
            cell.backgroundColor = gbl_color_cBgr;
        }
        if (indexPath.row ==  group_report_output_idx_B + 5) {  // 3 of 3 FOOTER CELLS
            cell.backgroundColor = gbl_color_cBgr;
        } 
        if (indexPath.row  >  group_report_output_idx_B + 5) {  // 3 of 3 FOOTER CELLS
            cell.backgroundColor = gbl_color_cBgr;
        } 

    });

} //  willDisplayCell: (UITableViewCell *)cell



//- (void)layoutSubviews 
//{
//    // Otherwise the popover animation could leak into our cells on iOS 7 legacy mode.
//    [UIView performWithoutAnimation:^{
//        [super layoutSubviews];
//        _renderView.frame = self.bounds;
//    }];
//}
//

//- (void)viewDidLayoutSubviews {  // fill whole screen, no top/leftside gaps  in  webview  THIS WORKED
//    NSLog(@"in viewHTML viewDidLayoutSubviews!");
//    // http://stackoverflow.com/questions/18552416/uiwebview-full-screen-size
//    //webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//} // end of viewDidLayoutSubviews 
//

// ==============   start of email stuff  and other  ====================


//How to check if a UIViewController is being dismissed/popped?
//  To know if your UIVIewController is being dismissed or popped,
//  you can ask your UIVIewController if it is being dismissed or being moved
//  from it’s parent UIVIewController. 
//
- (void)viewWillDisappear:(BOOL)animated {
     NSLog(@"in viewWillDisappear in TBLRPTs_2 !");

    [super viewWillDisappear:animated];


    [[NSNotificationCenter defaultCenter] removeObserver: self
//                                                  name: UIDeviceOrientationDidChangeNotification
                                                    name: UIApplicationDidChangeStatusBarOrientationNotification
                                                  object: nil
    ];


  if (self.isBeingDismissed || self.isMovingFromParentViewController) {

      // Handle the case of being dismissed or popped.
      //
      gbl_selectedRownumTBLRPT_2 = -1; // FLAG to not highlight menu row on first entering selrpts_B
  }
}

- (void)didChangeOrientation:(NSNotification *)notification
{
tn();
  NSLog(@"in myDidChangeOrientation !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ");
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

//    if (UIInterfaceOrientationIsLandscape(orientation)) {
//        NSLog(@"Landscape");
//    }
//    else {
//        NSLog(@"Portrait");
//    }

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 0]  
                      withRowAnimation: UITableViewRowAnimationNone // does a default unchangeable animation
        ];
    });  // reload

} // end of myDidChangeOrientation


-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"in TBLRPTs 2  viewWillAppear!");

    [super viewWillAppear: animated];


  NSLog(@"HEYnotify 2");
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didChangeOrientation:)
                                                 name: UIApplicationDidChangeStatusBarOrientationNotification
                                               object: nil
    ];



    // this reload re-positions report with line 1 at top of screen
    //
    // do not need to do it if we just returned from info screen
    //
    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]    //  personality
        || [gbl_currentMenuPlusReportCode hasSuffix: @"co"] )  //  grpof 2
    {
//   20160127     took away use of   gbl_justLookedAtInfoScreen
//         if (gbl_justLookedAtInfoScreen == 0 )  { //   20160127     took away use of   gbl_justLookedAtInfoScreen
//            // try to get rid of tbl position in middle on startup //   20160127     took away use of   gbl_justLookedAtInfoScreen

dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
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
});  // reload

//   20160127     took away use of   gbl_justLookedAtInfoScreen
//         } 
//         if (gbl_justLookedAtInfoScreen == 1 )  {
//             gbl_justLookedAtInfoScreen = 0;  // no re-load
//         }
    }


    // for B level reports - no remembering for B level pairs EXCEPT remember rownum for returning to this row from on top)

    // Now  highlight the  remembered last row selection 
    // UNLESS this is entering this menu from "below"
    // OK to highlight if returning to this menu from "above"
    //
    if (gbl_selectedRownumTBLRPT_2 == -1)  // FLAG to not highlight menu row on first entering selrpts_B

    {
        ;  // do not hightlight any row

    } else {

        if (self.isBeingPresented || self.isMovingToParentViewController) {   // "first time" entering from below
            ;  // do not hightlight any row

        } else {

//NSLog(@"gbl_selectedRownumSelRpt_B=%ld", (long)gbl_selectedRownumSelRpt_B); // get indexpath for saved rownum 
            NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow: gbl_selectedRownumTBLRPT_2 
                                                          inSection: 0 ];

            [self.tableView selectRowAtIndexPath: myIndexPath   // puts highlight on remembered row
                                        animated: YES
                                  scrollPosition: UITableViewScrollPositionNone];
        }
     } // highlight saved row




//    [self.navigationController.navigationBar.layer removeAllAnimations];  // stop the nav bar title stutter l to r


//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    // add Navigation Bar right buttons
    //

    // you have to add the info button in interface builder by hand,
    // then you can add  Share button below with   rightBarButtonItems arrayByAddingObject: shareButton];
    //
    //    UIButton *infoButton =  [UIButton buttonWithType: UIButtonTypeInfoDark] ;
    //    self.navigationItem.rightBarButtonItem = infoButton;


//    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
//                                    initWithBarButtonSystemItem: UIBarButtonSystemItemAction
//                                    target:self
//                                    action:@selector(shareButtonAction:)];
////    self.navigationItem.rightBarButtonItem = shareButton;
//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
//
////    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 44)];  // 3rd arg is length
//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//    //self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject: mySpacerForTitle];
//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//

    // add Navigation Bar right buttons, if not added alread
    //
  NSLog(@"gbl_currentMenuPrefixFromMatchRpt =[%@]",gbl_currentMenuPrefixFromMatchRpt );
  NSLog(@"gbl_lastSelectedPerson =[%@]",gbl_lastSelectedPerson );
  NSLog(@"gbl_currentMenuPlusReportCode=[%@]",gbl_currentMenuPlusReportCode);
    NSString *myNavBarTitle;
    if (gbl_tblrpts2_ShouldAddToNavBar == 1) { // init to prevent  multiple programatic adds of nav bar items

        gbl_tblrpts2_ShouldAddToNavBar  = 0;   // do not do this again

        // you have to add the info button in interface builder by hand,
        // then you can add  Share button below with   rightBarButtonItems arrayByAddingObject: shareButton];
        //
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                                                                     target: self
                                                                                     action: @selector(shareButtonAction:)];


        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

//        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
//                                                                                         target: self
//                                                                                         action: nil];
//


        if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]      
        ) {
            myNavBarTitle = @"Personality";
        }

        if (   [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"]       // My Best Match in Group
            || [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"])      //    Best Match in Group
        {   // all BEST MATCH ... reports
            myNavBarTitle = @"Best Match";
        }

  NSLog(@"myNavBarTitle =[%@]",myNavBarTitle );

//    [UIView performWithoutAnimation:^{          // did not work
//    }];
//


        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

            [[self navigationItem] setTitle: myNavBarTitle];  // moving this from the bottom of dispatch_async block to top solved the problem of nav bar title stuttering from left to right (about 1 sec)   why does it work?

//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myFlexibleSpace ];

            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];

            [self.navigationController.navigationBar setTranslucent:NO];

            //


            // How to hide iOS7 UINavigationBar 1px bottom line
            // 
            // you can make the background a solid color by setting backgroundImage to [UIImage new]
            // and assigning navigationBar.backgroundColor to the color you like.
            // (when you  do this,  translucent becomes = NO)  that's OK
            //  http://stackoverflow.com/questions/19226965/how-to-hide-ios7-uinavigationbar-1px-bottom-line/
            [self.navigationController.navigationBar setBackgroundImage: [UIImage new]
                                                         forBarPosition: UIBarPositionAny
                                                             barMetrics: UIBarMetricsDefault];
            //
            [self.navigationController.navigationBar setShadowImage: [UIImage new]];
            //
            self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
            //
            // end of  How to hide iOS7 UINavigationBar 1px bottom line

//            [[self navigationItem] setTitle: myNavBarTitle];
        });                                   

    } // end of add Navigation Bar right buttons


} // viewWillAppear


-(IBAction)infoButtonAction:(id)sender
{
  NSLog(@"in   infoButtonAction!  in tblrpt #2");

} // end of  infoButtonAction


-(IBAction)shareButtonAction:(id)sender
{
    MFMailComposeViewController *myMailComposeViewController;

tn();    NSLog(@"in shareButtonAction!  in MAMB09viewTBLRPTs_2_TableViewController ");
  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=[%@]",gbl_currentMenuPrefixFromMatchRpt);
  NSLog(@"gbl_currentMenuPlusReportCode    =[%@]",gbl_currentMenuPlusReportCode);

    // Determine the file name and extension
    // NSArray *filepart = [gbl_pathToFileToBeEmailed_B componentsSeparatedByString:@"."];
    // 
  NSLog(@"gbl_pathToFileToBeEmailed_B =%@",gbl_pathToFileToBeEmailed_B );
    NSArray *fileparts = [gbl_pathToFileToBeEmailed_B componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"./"]];
    
    NSString *baseFilename = [fileparts objectAtIndex: (fileparts.count -2)] ;  // count -1 is last in array
    NSString *extension    = [fileparts lastObject];
    NSString *filenameForAttachment = [NSString stringWithFormat: @"%@.%@", baseFilename, extension];
    

    // Get the resource path and read the file using NSData
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *HTMLfileData = [NSData dataWithContentsOfFile: gbl_pathToFileToBeEmailed_B ];
//NSLog(@"HTMLfileData.length=%lu",(unsigned long)HTMLfileData.length);


    NSString *emailTitle = [NSString stringWithFormat: @"%@  from Me and my BFFs", filenameForAttachment];

    NSString *myEmailMessage;
    

    if ([gbl_currentMenuPlusReportCode hasSuffix: @"pe"]) {    // personality from level 2
        myEmailMessage = [NSString stringWithFormat: @"\n\"Personality for %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
            gbl_person_name
        ];
    }

    else if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"]) {    // My Best Match in Group
        NSLog(@"gbl_person_name=%@",gbl_person_name);
        NSLog(@"myEmailMessage=%@",myEmailMessage);

        myEmailMessage = [NSString stringWithFormat: @"\n\"Best Match for %@  in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
           gbl_lastSelectedPerson,
           gbl_lastSelectedGroup
        ];
        NSLog(@"myEmailMessage=%@",myEmailMessage);
    }

    else if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"]) {    // Best Match in Group
        NSLog(@"gbl_person_name=%@",gbl_person_name);
        NSLog(@"myEmailMessage=%@",myEmailMessage);

        myEmailMessage = [NSString stringWithFormat: @"\n\"Best Match in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
           gbl_lastSelectedGroup
        ];
        NSLog(@"myEmailMessage=%@",myEmailMessage);

    } else {
        // should not happen
        myEmailMessage = @"x06 should not happen";
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
//
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





// 
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
    NSLog(@"in TBLRPTs 2  viewDidAppear!");

//    [super viewDidAppear:animated];
//    [self.tableView reloadData]; // self.view is the table view if self is its controller

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
}


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
    return NO; // allow no row to be highlighted
} 

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil; // allow no row to be selected
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath // no selection, view only
{
    NSLog(@"in didSelectRowAtIndexPath!  in TBLRPT_2 ");
    

    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]  
        || [gbl_currentMenuPlusReportCode hasSuffix: @"co"]  
    ) {
        return ;   // these are leaf reports, no row selection
    }

    
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow]; // this is the "currently" selected row now
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: NO];


    //    // **********   NO REMEMBERING WHICH REPORT WAS SELECTED  for a specific pair or person ********************
    //   ONLY REMEMBER the indexPath.row in this session   NOT names between sessions
    //
    gbl_selectedRownumTBLRPT_2 = indexPath.row;  // for remembering row to highlight in tblrpt2

    //        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
    //                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
    //                         updatingRememberCategory: (NSString *) @"rptsel"
    //                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
    //        ];
    //

    return; 
} // end of didSelectRowAtIndexPath



//
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?

//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{


    if (group_report_output_idx_B <= gbl_numRowsToTurnOnIndexBar) return nil;

//    return[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
//    return[NSArray arrayWithObjects:@"--", @" ", @" ", @" ", @" ", @" ", @"GGG", @" ", @" ", @" ", @" ", @" ", @"-", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"XXX", @"Y", @"Z", @"--", nil];

    return[NSArray arrayWithObjects:
            @"__",
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

  } // sectionIndexTitlesForTableView


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle: (NSString *)title 
                                                                    atIndex: (NSInteger)index  {

  NSLog(@"sectionForSectionIndexTitle!");
//    NSInteger newRow = [self indexForFirstChar:title inArray:self.yourStringArray];
    NSInteger newRow;
    newRow = 0;

    // no section index for these
    if (   [gbl_currentMenuPlusReportCode       hasSuffix: @"pe"]    // personality
        || [gbl_currentMenuPlusReportCode       hasSuffix: @"co"]    // grpof2
    ) {
        return 0;
    }


    //    if ([title isEqualToString:@"  "])    // does not work when title = "  "
    if ([title hasPrefix:@" "]) {
        NSArray *myVisibleRows = [tableView indexPathsForVisibleRows];
        NSIndexPath *myTopRow  = (NSIndexPath*)[myVisibleRows objectAtIndex:0];
        return myTopRow.row;
    }



    if ([title isEqualToString:@"__"]) newRow = 0;
    if ([title isEqualToString:@"20"]) newRow = (int) ( (20.0 / 100.0) * (double)group_report_output_idx_B );
    if ([title isEqualToString:@"40"]) newRow = (int) ( (40.0 / 100.0) * (double)group_report_output_idx_B );
    if ([title isEqualToString:@"60"]) newRow = (int) ( (60.0 / 100.0) * (double)group_report_output_idx_B );
    if ([title isEqualToString:@"80"]) newRow = (int) ( (80.0 / 100.0) * (double)group_report_output_idx_B );
    if ([title isEqualToString:@"=="]) newRow =                                  group_report_output_idx_B - 1;
  NSLog(@"newRow =%ld",(long)newRow );

    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];


    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionTop animated: YES];
//        [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];
    });

    return index;
}




@end

//        // does not work    This property is ignored if leftBarButtonItem is not nil 
//        // set TITLE for NAVIGATION BAR
//        //
//        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(
//            50,
//            0,
//            self.navigationController.navigationBar.frame.size.width-100,
//            self.navigationController.navigationBar.frame.size.height
//        )];
//
////        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [titleLabel setTextAlignment:NSTextAlignmentCenter];
//        //[titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
//        [titleLabel setNumberOfLines:0];
//
//        //NSString *titleString = @"This is a\n multiline string";
//        NSString *titleString = myNavBarTitle;
//
//        [titleLabel setText:titleString];
//
//
//        [titleView addSubview:titleLabel];
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            //[self.navigationController.navigationItem setTitleView:titleView];
//            [self.navigationController.navigationItem setTitleView:titleView];
//        });
//


//                char my_sep[8];
//ksn(my_sep);
//                strcpy(my_sep, ",");   // fld sep for myKingpinCSV_NSString   is "," not "|"
//                char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
//                strcpy(psvName, csv_get_field(my_psv, my_sep, 1));
//                strcpy(psvMth,  csv_get_field(my_psv, my_sep, 2));
//                strcpy(psvDay,  csv_get_field(my_psv, my_sep, 3));
//                strcpy(psvYear, csv_get_field(my_psv, my_sep, 4));
//                strcpy(psvHour, csv_get_field(my_psv, my_sep, 5));
//                strcpy(psvMin,  csv_get_field(my_psv, my_sep, 6));
//                strcpy(psvAmPm, csv_get_field(my_psv, my_sep, 7));
//                strcpy(psvCity, csv_get_field(my_psv, my_sep, 8));
//                strcpy(psvProv, csv_get_field(my_psv, my_sep, 9));
//                strcpy(psvCountry, csv_get_field(my_psv, my_sep, 10));
//                
//
//tn();trn("cocoa input csv  input csv  input csv  input csv  input csv  input csv  ");
//                // get longitude and timezone hoursDiff from Greenwich
//                // by looking up psvCity, psvProv, psvCountry
//                //
//ksn(psvCity);
//ksn(psvProv);
//ksn(psvCountry);
//                seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
//ksn(returnPSV);                
//
//                strcpy(psvHoursDiff,  csv_get_field(returnPSV, my_sep, 1));
//                strcpy(psvLongitude,  csv_get_field(returnPSV, my_sep, 2));
//ksn(psvHoursDiff);
//ksn(psvLongitude);
//                // build csv arg for report function call
//                //
//                char csv_kingpin[128];
//                sprintf(csv_kingpin, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                        psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
//ksn(psvName); ksn(psvMth); ksn(psvDay);
//


        //<.>  from pe
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

