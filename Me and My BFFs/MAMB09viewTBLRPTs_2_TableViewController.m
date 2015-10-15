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
tn();
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


     MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m



    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; // remove separator lines between cells

    //self.tableView.backgroundColor = gbl_color_cHed;   // WORKS
    self.tableView.backgroundColor = gbl_color_cBgr;   // WORKS


    gbl_tblrpts2_ShouldAddToNavBar = 1; // init to prevent  multiple programatic adds of nav bar items


    int retval;


//<.>
    // add Navigation Bar right buttons, if not added alread
    //
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
            self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
            //
            // end of  How to hide iOS7 UINavigationBar 1px bottom line

            [self.navigationController.navigationBar setTranslucent:NO];
            [[self navigationItem] setTitle: myNavBarTitle];
        });                                   

    } // end of add Navigation Bar right buttons

//<.>




// TODO



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
        char *my_mamb_csv_arr[gbl_maxGrpBirthinfoCSVs];
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

// TODO

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
    
    return (group_report_output_idx_B + 1 + 3); // + 3 for 3 bottom cells
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

    cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 12.0];

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

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            cell.textLabel.font          = myFont;
            cell.textLabel.numberOfLines = 7; 
            cell.accessoryView           = myInvisibleButton;               // no right arrow on column labels
            cell.userInteractionEnabled  = NO;
//            cell.textLabel.text          = @"                                    \n     Note: a GOOD RELATIONSHIP           \n     must have two things:               \n     1. compatibility potential          \n     2. both sides must show             \n        positive personality traits      \n                                         ";
//            cell.textLabel.text          = @"                                    \n     Note: a GOOD RELATIONSHIP           \n            needs two things:            \n     1. compatibility potential          \n     2. both sides show positive         \n        personality traits               \n                                         ";
//            cell.textLabel.text          = @"                                                  \n     Note: a GOOD RELATIONSHIP needs 2 things:    \n  1. compatibility potential                      \n  2. both sides show positive personality traits  \n                                                  ";
//            cell.textLabel.text          = @"                                    \n     Note: a GOOD RELATIONSHIP           \n        needs two things                 \n     1. compatibility potential          \n     2. both sides show positive         \n        personality traits               \n                                         ";
            cell.textLabel.text          = @"                                    \n        a GOOD RELATIONSHIP            \n        usually has 2 things             \n     1. compatibility potential          \n     2. both sides show positive         \n        personality traits               \n                                         ";

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
            cell.textLabel.numberOfLines  = 1; 
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
//  NSLog(@"in heightForRowAtIndexPath 1");
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
    if (indexPath.row == 1) return 15.0;  // col hdr 1
    if (indexPath.row == 2) return 15.0;  // col hdr 2
 
    if (indexPath.row == group_report_output_idx_B + 1) return 15.0 * 7;  // ftr 1
    if (indexPath.row == group_report_output_idx_B + 2) return 15.0 ;     // ftr 2
    if (indexPath.row == group_report_output_idx_B + 3) return 20.0 ;     // ftr 3

    return 32.0;

}  // ---------------------------------------------------------------------------------------------------------------------


// how to set the section header cell height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  // --------------------------------
{
    // the only report MAMB09viewTBLRPTs_2_TableViewController.m does is grpone with kingpin being a member of the group
    //
    return 34.0;   // MY Best Match in Group ...   2 lines
}  // ---------------------------------------------------------------------------------------------------------------------

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
  NSLog(@"in viewForHeaderInSection  in tblrpts 2");
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
}



// how to set cell background color
//
- (void)tableView:(UITableView *)tableView willDisplayCell: (UITableViewCell *)cell
                                         forRowAtIndexPath: (NSIndexPath *)indexPath 
{
//  NSLog(@"in willDisplayCell");
    //cell.backgroundColor = [UIColor colorWithRed:(116/255.0) green:(167/255.0) blue:(179/255.0) alpha:1.0];

    NSString *thisCellBGcolorName; 
    thisCellBGcolorName = gbl_array_cellBGcolorName_B[indexPath.row];   // array set in  viewDidLoad
//  NSLog(@"thisCellBGcolorName =%@",thisCellBGcolorName );

//    gbl_cre2Flag = 0;
//nbn(200);        
//tn();trn("befor set");kin(gbl_cre2Flag );
//b(201);        
//        if ( [thisCellBGcolorName isEqualToString: @"cRe2"] )  {
//b(202);        
//            gbl_cre2Flag = 1;
//        }
//b(203);        
//tn();trn("after set");kin(gbl_cre2Flag );
//


    dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line

        if ( [thisCellBGcolorName isEqualToString: @"cHed"] )  cell.backgroundColor = gbl_color_cHed;

        if ( [thisCellBGcolorName isEqualToString: @"cGr2"] )  cell.backgroundColor = gbl_color_cGr2;
        if ( [thisCellBGcolorName isEqualToString: @"cGre"] )  cell.backgroundColor = gbl_color_cGre;
        if ( [thisCellBGcolorName isEqualToString: @"cNeu"] )  cell.backgroundColor = gbl_color_cNeu;
        if ( [thisCellBGcolorName isEqualToString: @"cRed"] )  cell.backgroundColor = gbl_color_cRed;
        if ( [thisCellBGcolorName isEqualToString: @"cRe2"] )  cell.backgroundColor = gbl_color_cRe2;
        if ( [thisCellBGcolorName isEqualToString: @"cBgr"] )  cell.backgroundColor = gbl_color_cBgr;
    });
}


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

  if (self.isBeingDismissed || self.isMovingFromParentViewController) {

      // Handle the case of being dismissed or popped.
      //
      gbl_selectedRownumTBLRPT_2 = -1; // FLAG to not highlight menu row on first entering selrpts_B
  }
}


-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"in TBLRPTs 2  viewWillAppear!");

    [super viewWillAppear: animated];


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
            || [gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"])      //    Best Match in Group
        {   // all BEST MATCH ... reports
            myNavBarTitle = @"Best Match";
        }


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
     
    // Determine the file name and extension
    // NSArray *filepart = [gbl_pathToFileToBeEmailed_B componentsSeparatedByString:@"."];
    NSArray *fileparts = [gbl_pathToFileToBeEmailed_B componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"./"]];
    
    NSString *baseFilename = [fileparts objectAtIndex: (fileparts.count -2)] ;  // count -1 is last in array
    NSString *extension    = [fileparts lastObject];
    NSString *filenameForAttachment = [NSString stringWithFormat: @"%@.%@", baseFilename, extension];
    
    // Get the resource path and read the file using NSData
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *HTMLfileData = [NSData dataWithContentsOfFile: gbl_pathToFileToBeEmailed_B ];
//NSLog(@"gbl_pathToFileToBeEmailed_B =%@",gbl_pathToFileToBeEmailed_B );
//NSLog(@"HTMLfileData.length=%lu",(unsigned long)HTMLfileData.length);


    NSString *emailTitle = [NSString stringWithFormat: @"%@  from Me and my BFFs", filenameForAttachment];

    NSString *myEmailMessage;
    
    myEmailMessage = @"tester";
    NSLog(@"myEmailMessage=%@",myEmailMessage);
    NSLog(@"extension=%@",extension);


    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"]) {    // My Best Match in Group
        NSLog(@"gbl_person_name=%@",gbl_person_name);
        NSLog(@"myEmailMessage=%@",myEmailMessage);

        myEmailMessage = [NSString stringWithFormat: @"\n\"Best Match for %@  in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
           gbl_lastSelectedPerson,
           gbl_lastSelectedGroup
        ];
        NSLog(@"myEmailMessage=%@",myEmailMessage);
    }
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"]) {    // Best Match in Group
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
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {


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


