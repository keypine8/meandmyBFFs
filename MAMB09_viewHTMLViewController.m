//
//  MAMB09_viewHTMLViewController.m
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

#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals    nnn

// #import "incocoa.h" xxxxx


@interface MAMB09_viewHTMLViewController ()

@end


@implementation MAMB09_viewHTMLViewController


- (void)viewDidLayoutSubviews {  // fill whole screen, no top/leftside gaps  in  webview  THIS WORKED
    NSLog(@"in viewHTML viewDidLayoutSubviews!");
    // http://stackoverflow.com/questions/18552416/uiwebview-full-screen-size
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

        // fill whole screen, no top/leftside gaps  in  webview  THIS WORKED
        self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);  // this worked


//        // put the Toolbar onto bottom of what color view
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.view addSubview: gbl_toolbarForwBack ];
//        });


//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]) { // what color
//        self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0);
//    } else {
//        self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }

} // end of viewDidLayoutSubviews 




// SOMEHOW, THIS TAKES AWAY SCRAMBLED HTML IN CAL YR WHEN ZOOMING IN WITH PINCH
//
//  UIWebView disable zooming when scalesPageToFit is ON
// http://stackoverflow.com/questions/9062195/uiwebview-disable-zooming-when-scalespagetofit-is-on 
//
// You can use this:
// webview.scrollView.delegate = self;   in viewDidLoad
//
// This  option is better and full-proof. First logic could fail in future SDKs.
//
-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
    return nil;
}


//
//// The copy:, cut:, delete:, paste:, select:, and selectAll: methods   this list is ACTION LIST
//// are invoked when users tap the corresponding command
//// in the menu managed by the UIMenuController shared instance.
////
//- (BOOL)canPerformAction: (SEL)action
//              withSender: (id)sender
//{
////  NSLog(@"canPerformAction=!");
//    return NO;
//
////    BOOL retvalue;
////  
////    if (action == @selector(cut:  ) ) return NO;
////    if (action == @selector(copy: ) ) return NO;
////    if (action == @selector(paste:) ) return NO;
////
////    retvalue = [super canPerformAction:action withSender:sender];
////    return retvalue;
//}
//


- (void)webViewDidFinishLoad:(UIWebView *)webView {   // want to disable cut, copy, paste etc...

  NSLog(@"webViewDidFinishLoad !");
    // want to disable cut, copy, paste etc...
    //
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"]; // Disable selection
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"]; // Disable callout

    [webView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"]; // Disable selection
    [webView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"]; // Disable callout
} // end of webViewDidFinishLoad



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"in viewHTML viewDidLoad!");

    self.outletWebView.delegate = self; // in viewDidLoad





    // want to disable cut, copy, paste etc...
//    self.outletWebView.delegate = self; // in viewDidLoad

    // self.outletWebView.userInteractionEnabled = NO;  // cannot even scroll
//<.>
//    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
//                                             selector: @selector(myMenuWillBeShown)
//                                                 name: UIMenuControllerWillShowMenuNotification   // <<<====----
//                                               object: nil
//    ];
//
//
//-(void)myMenuWillBeShown  // NSNotification  for DISABLE showing of select/paste/cut etc (flashes a bit, but only the 1st time)
//{
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    [menu setMenuVisible: NO];
//    [menu performSelector: @selector(setMenuVisible:)
//               withObject: [NSNumber numberWithBool: NO]
////               afterDelay: 0.1
//               afterDelay: 0.0
//    ]; //also tried 0 as interval both look quite similar
//} // end of myMenuWillBeShown  
//<.>
//

    // want to disable cut, copy, paste etc...
    //
// did not work
//    NSString * jsCallBack = @"window.getSelection().removeAllRanges();";    
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString: jsCallBack];


// did not work here,    try in webViewDidFinishLoad
//    // want to disable cut, copy, paste etc...
//    //
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"]; // Disable selection
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"]; // Disable callout



    // http://stackoverflow.com/questions/18912638/custom-image-for-uinavigation-back-button-in-ios-7
//        UIImage *backBtn = [UIImage imageNamed:@"iconRightArrowBlue_66"];
    //UIImage *backBtn = gbl_chevronLeft;
    UIImage *backBtn = [UIImage imageNamed:@"iconChevronLeft_66"];

    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.backBarButtonItem.title=@"x";
    self.navigationController.navigationBar.backIndicatorImage = backBtn;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;




//            dispatch_async(dispatch_get_main_queue(), ^(void){
//    [self.outletWebView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // 1st time still slow
//            });

//    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
//                [self.outletWebView loadRequest:HTML_URLrequest];
//    [self.outletWebView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // 1st time still slow

//   [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];

// try to reduce load time of first cal yr report    did not work


    gbl_viewHTML_ShouldAddToNavBar = 1; // init to prevent  multiple programatic adds of nav bar items


    // When I am navigating back & forth, i see a dark shadow
    // on the right side of navigation bar at top. 
    // It feels rough and distracting. How can I get rid of it?
    //

  NSLog(@"self.navigationController.navigationBar.translucent=%c",self.navigationController.navigationBar.translucent);
    self.navigationController.navigationBar.translucent = NO; 

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        [self.navigationController.navigationBar setTranslucent: NO];
    });

  NSLog(@"self.navigationController.navigationBar.translucent=%c",self.navigationController.navigationBar.translucent);
    //
    //http://stackoverflow.com/questions/22413193/dark-shadow-on-navigation-bar-during-segue-transition-after-upgrading-to-xcode-5



    gbl_shouldUseDelayOnBackwardForeward = 0;   // use no delay for fast presentation on initial user viewing

    // set gbl_lastSelectedDayLimit;  
    //
    // yyyymmdd  Maximum future lookahead is to the end of the
    //           calendar year after the current calendar year.
    //
//        // get the current year
//        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time
//
//    // NSDateComponents *dateComponents = [gregorian components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
//    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear)
//                                                    fromDate: [NSDate date]];
//        gbl_currentYearInt  = [dateComponents year];
//        gbl_currentMonthInt = [dateComponents month];
//        gbl_currentDayInt   = [dateComponents day];
        // above set elsewhere now



        // this is for pressing "Next Day" button on what color is today
        //
        // gbl_lastSelectedDayLimit = [NSString stringWithFormat: @"%4ld1231", (long)gbl_currentYearInt + 1];

        gbl_lastSelectedDayLimit = [NSString stringWithFormat: @"%4ld1231", (long)gbl_currentYearInt + gbl_num_yrs_past_current_yr];



//  NSLog(@"gbl_lastSelectedDayLimit =%@",gbl_lastSelectedDayLimit );
    //



    //   char *gbl_grp_CSVs[gbl_MAX_persons + 16]; // for filling array of group member data


//  char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
    const char *my_psvc; // psv=pipe-separated values
//    char my_psv[128];
    
    char csv_person_string[128]; // csv_person1_string[128], csv_person2_string[128];
    char person_name_for_filename[32]; // person1_name_for_filename[32], person2_name_for_filename[32];
    //   char group_name_for_filename[32];
//    char myStringBuffForTraitCSV[64];
    
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
    
    fopen_fpdb_for_debug();

    // used to select what to do
    NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);

    // used for input PSVs
    NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);            // PSV  for per or grp or pair of people
    NSLog(@"gbl_fromSelSecondPersonPSV=%@",gbl_fromSelSecondPersonPSV);

  NSLog(@"gbl_PSVtappedPersonA_inPair=%@",gbl_PSVtappedPersonA_inPair);
  NSLog(@"gbl_PSVtappedPersonB_inPair=%@",gbl_PSVtappedPersonB_inPair);
  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);


    // GET input person PSVs    THESE ARE ALL THE 21 PLACES A PERSON IS SELECTED FOR A REPORT
    //
    //      this, viewHTML, does not take any group name input
    //     (group reports are displayed in   MAMB09viewTBLRPTs_1_TableViewController.m  and  MAMB09viewTBLRPTs_2_TableViewController.m
    //
    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]  // from second person select
    ) {
        gbl_viewHTML_PSV_personA  = gbl_fromHomeCurrentSelectionPSV;
        gbl_viewHTML_NAME_personA = [gbl_viewHTML_PSV_personA componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

        gbl_viewHTML_PSV_personB  = gbl_fromSelSecondPersonPSV;         // from select second person screen
        gbl_viewHTML_NAME_personB = [gbl_viewHTML_PSV_personB componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

    } else if (
          [gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"] 
       || [gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]  
       || [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]  
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]    // "hompbm" is not handled here (TBLRPTS_1)
    ) {
        gbl_viewHTML_PSV_personJust1  = gbl_fromHomeCurrentSelectionPSV;    // from select person on home screen
        gbl_viewHTML_NAME_personJust1 = [gbl_viewHTML_PSV_personJust1 componentsSeparatedByString:@"|"][0]; // get 1st field (zero-based)

    } else if (
           [gbl_currentMenuPlusReportCode isEqualToString: @"pbmco"]   // pco chosen for selected pair in grpone 
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbmco"]   // pco chosen for selected pair in grpall 

    ) {
        gbl_viewHTML_PSV_personA  = gbl_PSVtappedPersonA_inPair;
        gbl_viewHTML_NAME_personA = [gbl_viewHTML_PSV_personA componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

        gbl_viewHTML_PSV_personB  = gbl_PSVtappedPersonB_inPair;        
        gbl_viewHTML_NAME_personB = [gbl_viewHTML_PSV_personB componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

    } else if ( 
           [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]  // from a tap in grpone, then sel rpt
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]    // "pbm2bm" is not handled here (TBLRPTS_2)
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]  // from a tap in grpall, then sel rpt
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm"]    // "gbm1bm" is not handled here (TBLRPTS_2)
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm"]    // "gbm2bm" is not handled here (TBLRPTS_2)

        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmappe"]  // from a tap in Most xxx in group
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmeppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmrppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmpppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gmdppe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbypcy"]  // from a tap in Best xxx in group
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]

//
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]  // from a tap in Most xxx in group
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]  // from a tap in Best xxx in group
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]
//

    ) {
        gbl_viewHTML_PSV_personJust1  = gbl_PSVtappedPerson_fromGRP;
        gbl_viewHTML_NAME_personJust1 = [gbl_viewHTML_PSV_personJust1 componentsSeparatedByString:@"|"][0]; // get field #1 (zero-based)

    } else if ( [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]   // from second person select
    ) {
nbn(91);
  NSLog(@"gbl_viewHTML_PSV_personJust1y=%@",gbl_viewHTML_PSV_personJust1);
  NSLog(@"gbl_viewHTML_NAME_personJust1y=%@",gbl_viewHTML_NAME_personJust1);
  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);

        gbl_viewHTML_PSV_personJust1 = gbl_PSVtappedPerson_fromGRP;
        gbl_viewHTML_NAME_personJust1 = [gbl_PSVtappedPerson_fromGRP componentsSeparatedByString:@"|"][0]; // get field #1 (name) (zero-based)

  NSLog(@"gbl_viewHTML_PSV_personJust1y_2=%@",gbl_viewHTML_PSV_personJust1);
  NSLog(@"gbl_viewHTML_NAME_personJust1_2_ y=%@",gbl_viewHTML_NAME_personJust1);

        // do nothing because gbl_viewHTML_PSV_personJust1 and gbl_viewHTML_NAME_personJust1 are already set in tblrpts1


    } else {  // SHOULD NOT HAPPEN
       NSLog(@"view HTML should not happen");
    }
  nbn(92);
  NSLog(@"gbl_viewHTML_PSV_personAx=%@",gbl_viewHTML_PSV_personA);
  NSLog(@"gbl_viewHTML_NAME_personAx=%@",gbl_viewHTML_NAME_personA);
  NSLog(@"gbl_viewHTML_PSV_personBx=%@",gbl_viewHTML_PSV_personB);
  NSLog(@"gbl_viewHTML_NAME_personBx=%@",gbl_viewHTML_NAME_personB);
  NSLog(@"gbl_viewHTML_PSV_personJust1x=%@",gbl_viewHTML_PSV_personJust1);
  NSLog(@"gbl_viewHTML_NAME_personJust1x=%@",gbl_viewHTML_NAME_personJust1);



    // e.g.  fromHomeCurrentSelectionPSV= @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States|"
    //
    // passed to mamb_report_personality() as "evelyn,2,28,1944,7,30,1,5,79.22"  5=timezonediff 79=long
    //
    //   later:  calc_chart(pINMN,pINDY,pINYR,pINHR,pINMU,pINAP,pINTZ,pINLN,pINLT);  (pINLT always 0.0)
    //
    //if ([gbl_fromSelRptRowString hasPrefix: @"Personality"])    // call Personality HTML report


    // old   if ([gbl_currentMenuPlusReportCode isEqualToString: @"homppe"])

    // here we take advantage of the fact that all personality reports 
    // have gbl_currentMenuPlusReportCode which ends in "pe"
    //

tn();
  NSLog(@"gbl_currentMenuPlusReportCode in VIEW HTML=%@",gbl_currentMenuPlusReportCode);


//<.>  this report (per) is now tblrpts_1
//    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] // per rpt gmappe,gmeppe,gmrppe,gmpppe,gmdppe homppe pbm1pe,pbm2pe gbm1pe,gbm2pe
////        || [gbl_currentMenuPlusReportCode hasPrefix: @"homgm"]   // personality report  homgma,homgme,homgmr,homgmp,homgmd
//    ) {
//        trn("in personality");
//        
//
//
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [[self navigationItem] setTitle: @"Personality       "];
////        });
////
//
////        // TWO-LINE NAV BAR TITLE
////        //
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////
////            UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
////            mySelRptB_Label.numberOfLines = 2;
////            mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 16.0];
////            mySelRptB_Label.textColor     = [UIColor blackColor];
////            mySelRptB_Label.textAlignment = NSTextAlignmentCenter; 
////            mySelRptB_Label.text          = [NSString stringWithFormat:  @"Personality of\n%@", gbl_lastSelectedPerson ];
////            // mySelRptB_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
////            self.navigationItem.titleView = mySelRptB_Label;
////
////            UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];  // 3rd arg is horizontal length
////            UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView: spaceView];
////            self.navigationItem.rightBarButtonItem = mySpacerForTitle;
////            [self.navigationController.navigationBar setTranslucent:NO];
////
////            //        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
////            //        myInvisibleButton.backgroundColor = [UIColor clearColor];
////            //        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];
////            //        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerNavItem];
////        });
////
//
//
//nbn(111);
//    // When I am navigating back & forth, i see a dark shadow
//    // on the right side of navigation bar at top. 
//    // It feels rough and distracting. How can I get rid of it?
//    //
//    self.navigationController.navigationBar.translucent = NO; 
//    //
//    //http://stackoverflow.com/questions/22413193/dark-shadow-on-navigation-bar-during-segue-transition-after-upgrading-to-xcode-5
//
//
//
//
//        sfill(myStringBuffForTraitCSV, 60, ' ');  // not used here in per, so blanks
//
//        // NSString object to C
//        //const char *my_psvc = [self.fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
////        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for personality
//        my_psvc = [gbl_viewHTML_PSV_personJust1 cStringUsingEncoding:NSUTF8StringEncoding];  // for personality
//
//        strcpy(my_psv, my_psvc);
//        ksn(my_psv);
//        
//        strcpy(psvName, csv_get_field(my_psv, "|", 1));
//        strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
//        strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
//        strcpy(psvYear, csv_get_field(my_psv, "|", 4));
//        strcpy(psvHour, csv_get_field(my_psv, "|", 5));
//        strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
//        strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
//        strcpy(psvCity, csv_get_field(my_psv, "|", 8));
//        strcpy(psvProv, csv_get_field(my_psv, "|", 9));
//        strcpy(psvCountry, csv_get_field(my_psv, "|", 10));
//        ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
//        ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
//        
//        // get longitude and timezone hoursDiff from Greenwich
//        // by looking up psvCity, psvProv, psvCountry
//        //
//        seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
//        
//        strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
//        strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
//        
//        // set gbl for email
//        ksn(psvName);
//        gbl_person_name =  [NSString stringWithUTF8String:psvName ];
//
//        // build csv arg for report function call
//        //
//        sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
//        ksn(csv_person_string);tn();
//        
//        
//        // build HTML file name  in TMP  Directory
//        //
//        strcpy(person_name_for_filename, psvName);
//        scharswitch(person_name_for_filename, ' ', '_');
//        sprintf(html_file_name_browser, "%sper_%s.html",         PREFIX_HTML_FILENAME, person_name_for_filename);
//        sprintf(html_file_name_webview, "%sper_%s_webview.html", PREFIX_HTML_FILENAME, person_name_for_filename);
//        
//        
//        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
//        gbl_html_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];   // for later viewing in webview
//
//
//        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
//        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
//        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
//        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
//        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
//        
//        gbl_pathToFileToBeEmailed = OpathToHTML_browser;
//        
//        // remove all "*.html" files from TMP directory before creating new one
//        //
//        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
////        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
//                for (NSString *fil in tmpDirFiles) {
////            NSLog(@"fil=%@",fil);
//            if ([fil hasSuffix: @"html"]) {
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
//            }
//        }
//   
//        
////        tn();trn("2 HTMLs !!!!!!!!!!!!!!!!!!!!");
////        nksn(html_file_name_browser); ksn( html_file_name_webview);
////        NSLog(@"Ohtml_file_name_browser=%@",Ohtml_file_name_browser);
////        NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);
////        nksn(pathToHTML_browser); ksn(pathToHTML_webview);
//
//        
//        retval = mamb_report_personality(     /* in perdoc.o */
//                                pathToHTML_webview,
//                                pathToHTML_browser,
//                                csv_person_string,
//                                "",  /* could be "return only csv with all trait scores",  instructions */
//                                /* this instruction arg is now ignored, because arg next, */
//                                /* stringBuffForTraitCSV, is ALWAYS populated with trait scores */
//                                 myStringBuffForTraitCSV);
//
//
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
//        }
//
//    }  //  [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] // personality report
//
//<.>  this report (per) is now tblrpts_1
    
    
    //if ([gbl_fromSelRptRowString hasPrefix: @"Calendar Year"])    // call Calendar Year HTML report
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"])
    if (   [gbl_currentMenuPlusReportCode hasSuffix:       @"cy"]        // calendar year report  hompcy or gbypcy
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]    // calendar year report
    ) {   
        tn();trn("in calendar year!");
        

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle:  @"Calendar Year    "];
//            [[self navigationItem] setTitle:  @"Calendar Year"];
            [[self navigationItem] setTitle:  @" "];  // this fixes title in info screen being too far right (not centered)
        });

        sfill(stringBuffForStressScore, 60, ' ');
        
        yyyy_todoC = [gbl_lastSelectedYear cStringUsingEncoding:NSUTF8StringEncoding];
        strcpy(yyyy_todo, yyyy_todoC);
        // ksn(yyyy_todo);
        
// NSLog(@"in view HTML for cal yr  gbl_arrayPer=%@",gbl_arrayPer);

        
        // NSString object to C
//        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for calendar year
        my_psvc = [gbl_viewHTML_PSV_personJust1 cStringUsingEncoding:NSUTF8StringEncoding];  // for personality

        char my_psv[128];
        strcpy(my_psv, my_psvc);
        

        // ksn(my_psv);
        
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
        ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
        ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
        
        // get longitude and timezone hoursDiff from Greenwich
        // by looking up psvCity, psvProv, psvCountry
        //
        seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
        
        strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
        strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
        
        // set gbl for email
        gbl_person_name =  [NSString stringWithUTF8String:psvName ];

        // build csv arg for report function call
        //
        sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);

        
        // build HTML file name  in  TMP  Directory
        //
        strcpy(person_name_for_filename, psvName);
        scharswitch(person_name_for_filename, ' ', '_');
        sprintf(html_file_name_browser, "%syr%s_%s.html",          PREFIX_HTML_FILENAME, yyyy_todo, person_name_for_filename);
        sprintf(html_file_name_webview, "%syr%s_%s_webview.html",  PREFIX_HTML_FILENAME, yyyy_todo, person_name_for_filename);

//        Ohtml_file_name = [NSString stringWithUTF8String:html_file_name ];
//        OpathToHTML = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name];
//        pathToHTML = (char *) [OpathToHTML cStringUsingEncoding:NSUTF8StringEncoding];
//        /* for use in WebView */
//        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name]];
    
        
        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
        
        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
        
        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
        
ksn(pathToHTML_webview      );
        //URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser]];
        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
        URLtoHTML_forEmailing = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser]];



// test sending webview by email
        //gbl_pathToFileToBeEmailed = OpathToHTML_browser;
        //gbl_pathToFileToBeEmailed = OpathToHTML_webview;

        gbl_pathToFileToBeEmailed = OpathToHTML_browser; // NSString email file named *.html  with no "webview" in it

//NSLog(@"gbl_pathToFileToBeEmailed=%@",gbl_pathToFileToBeEmailed);
//NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);

        
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

    
        tn();trn("doing calendar year call ...");  ks(html_file_name_webview);
       
        retval = mamb_report_year_in_the_life (    /* in futdoc.o */
                                               pathToHTML_webview,
                                               csv_person_string,
                                               yyyy_todo,
                                               "",          /* char *instructions,    like  "return only year stress score" */
                                               stringBuffForStressScore   /* char *stringBuffForStressScore */
                                               );


//<.> beg wait for inner_html  bug fix   ended up not using big graph

        //
        //  SECOND CALL for BIG html   (this has one html  jan->dec in one graph instead of 2 - jan-jun and jul-dec )
        //

        retval2 = 0;
//         retval2 = mamb_BIGreport_year_in_the_life (    // big html for non webview
//                                                pathToHTML_browser,
//                                                csv_person_string,
//                                                yyyy_todo,
//                                                "",          /* char *instructions,    like  "return only year stress score" */
//                                                stringBuffForStressScore   /* char *stringBuffForStressScore */
//                                                );
        //   copy  *webview.html to  *html  until bug is fixed on inner_html
        //
        NSFileManager* sharedFM2 = [NSFileManager defaultManager];
        NSError *err03;
        [sharedFM2 copyItemAtURL:URLtoHTML_forWebview
                           toURL:URLtoHTML_forEmailing
                           error:&err03];
        if (err03) { NSLog(@"cp *webview.html to *.html %@", err03); }
//<.> end wait for bug fix




//  get all the html lines into a NSString and a NSArray

//            NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
            NSString* myHTML_FileContents    = [NSString stringWithContentsOfFile: OpathToHTML_webview
                                                                         encoding: NSUTF8StringEncoding
                                                                            error: nil];
//            NSArray *htmllines = [fileContents componentsSeparatedByCharactersInSet: newlineCharSet];




//
//  // 20160126   no more title in webview, so do not need this
//
//       do { // remove <title> in webview html file
//
//            // remove <title> in webview html file    (because using same html for webview and browser (for now) )
//            // <pre class="myTitle">2015 ~Aiden 89012f45 </pre>
//            // remove line beginning with    <pre class="myTitle">
//            // (title is now in uiwebview nav bar title)
//            //
//            NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
//            NSString* fileContents    = [NSString stringWithContentsOfFile: OpathToHTML_webview
//                                                                  encoding: NSUTF8StringEncoding
//                                                                     error: nil];
//            NSArray *htmllines = [fileContents componentsSeparatedByCharactersInSet: newlineCharSet];
//
////
//////<.>  for test
////int printnextline;
////printnextline = 0;
////for (NSString *myline in htmllines ) {
////    // log if contains STRESS, print  + line after
////    NSString *findme = @"STRESS";
////    if ([myline containsString: findme]  ||  printnextline == 1) {
////        if (printnextline == 1)
////        {
////            printnextline  = 0;
////            NSLog(@"myline=[%@]",myline);
////        } else {
////            printnextline  = 1;
////            NSLog(@"myline=[%@]",myline);
////        }
////    }
////}
//////<.>  for test
////
////
//
//
//            NSMutableArray *htmllinesMut = [NSMutableArray arrayWithArray: htmllines ];
//
//
//            // NSMutableArray rearranges the indexes after adding or removing an object,
//            // so if we start with index 0, we'll be guaranteed an index out of bounds exception
//            // if even one object is removed during the iteration.
//            // So, we have to start from the back of the array, and
//            // only remove objects that have lower indexes than every index we've checked so far.
//            // http://stackoverflow.com/questions/19107905/removing-an-item-from-an-array-in-objective-c
//            NSInteger numlins = [htmllinesMut count];
//            NSString *currlin;
//tn();nbn(899);
//            for (NSInteger myidx = (numlins - 1); myidx >= 0; myidx--) {
//               currlin = htmllinesMut[myidx];
//               if ([currlin hasPrefix: @"<pre class=\"myTitle\">"] ) {
//    //                [htmllinesMut removeObjectAtIndex: myidx];
//tn();nbn(900);
//                    [htmllinesMut replaceObjectAtIndex:  myidx   withObject: @"<pre><br></pre>" ];
//                }
//            }
//
//            [gbl_sharedFM removeItemAtURL: URLtoHTML_forWebview error:&err03];
//
//            // Write array back  (overwrite original html file)
//
//            NSString *myarr2str = [htmllinesMut componentsJoinedByString:@"\n"];
//
//    //        [htmllinesMut writeToFile: OpathToHTML_webview atomically: YES];
//            [myarr2str writeToFile: OpathToHTML_webview atomically: YES
//                                                                  encoding: NSUTF8StringEncoding
//                                                                     error: nil
//            ];
//
//
//    //- (BOOL)writeToFile:(NSString *)path
//    //         atomically:(BOOL)useAuxiliaryFile
//    //           encoding:(NSStringEncoding)enc
//    //              error:(NSError **)error
//    //
//
//    //- (BOOL)writeToFile:(NSString *)path
//    //         atomically:(BOOL)useAuxiliaryFile
//    //           encoding:(NSStringEncoding)enc
//    //              error:(NSError **)error
//    //
//    //
//       } while (0); // end of remove <title> in webview html file
//  // 20160126   no more title in webview
//
//

        //  for test   show all files in temp dir
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
        for (NSString *s in fileList){
            NSLog(@"TEMP DIR %@", s);
        }
        

        
        if (retval == 0 && retval2 == 0) {


            /* here, go and look at html report */
            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
            //        NSURLRequest *HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
            //        self.outletWebView.scalesPageToFit = YES;
            //        [self.outletWebView loadRequest: HTML_URLrequest];
            
            /* here, go and look at html report */
            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
            
            self.outletWebView.scalesPageToFit = YES;
            
            // I was having the same problem. I found a property on the UIWebView
            // that allows you to turn off the data detectors.
            //
            self.outletWebView.dataDetectorTypes = UIDataDetectorTypeNone;
            
            // place our URL in a URL Request
            HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
            
            // UIWebView is part of UIKit, so you should operate on the main thread.
            //
            // old= [self.outletWebView ldoadRequest: HTML_URLrequest];
            //

            //            dispatch_async(dispatch_get_main_queue(), ^(void){
            //                [self.outletWebView loadRequest:HTML_URLrequest];
            //            });

            // loadRequest above   BUT,      DON’T USE THIS METHOD  (see below)
            // https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWebView_Class/#//apple_ref/occ/instm/UIWebView/loadHTMLString:baseURL:
            //
            // - (void)loadRequest:(NSURLRequest *)request
            // Parameters   request	A URL request identifying the location of the content to load.
            // Discussion     DON’T USE THIS METHOD     to load local HTML files; instead, use loadHTMLString:baseURL:.
            // To stop this load, use the stopLoading method.
            // To see whether the receiver is done loading the content, use the loading property.
            //

            // from     https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWebView_Class/
            //
            // - (void)loadHTMLString: (NSString *)string
            //                baseURL: (NSURL *)baseURL
            // Parameters
            //     string	The content for the main page.
            //     baseURL	The base URL for the content.
            // Discussion
            //     To help you avoid being vulnerable to security attacks, BE SURE TO USE THIS METHOD TO LOAD LOCAL HTML FILES.
            //     Don’t use loadRequest:.
            //
nbn(901);
            dispatch_async(dispatch_get_main_queue(), ^(void){
//              [self.outletWebView  loadRequest: HTML_URLrequest ];
                [self.outletWebView  loadHTMLString: myHTML_FileContents  baseURL: nil];

// did not work
//nbn(902);
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"]; // Disable selection
//    [self.outletWebView  stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"]; // Disable callout

            });
nbn(903);

        }  // show cal yr html

    }  // [gbl_currentMenuPlusReportCode hasSuffix: @"cy"] // calendar year report

    

    //if ([gbl_fromSelRptRowString hasPrefix: @"What Color"])    // call Calendar Day HTML report, now called "What Color is Today?"
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]) 
    if ([gbl_currentMenuPlusReportCode hasSuffix: @"wc"]  // what color report  hompwc or gbdpwc
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]    // what color report  
    ) {
//        tn();trn("in What Color is Today    (calendar day)!");
        tn();trn("in What Color is This Day    (calendar day)!");


        //  save start day stuff
        //
            gbl_lastSelectedDaySaved = gbl_lastSelectedDay;  // SAVE START DAY         (for "Start" button)

                                                             // SAVE format  "Jun_05"  (for startDay button label)
            NSString *my_Obj_dd   = [gbl_lastSelectedDay substringWithRange: NSMakeRange(6,2)];
            NSString *my_Obj_mm   = [gbl_lastSelectedDay substringWithRange: NSMakeRange(4,2)];
            //NSString *my_Obj_yyyy = [gbl_lastSelectedDay substringWithRange: NSMakeRange(0,4)];
            NSInteger tmp_MM_int  = [my_Obj_mm intValue];  // convert NSString to integer
            NSArray  *myArrayOf3letterMonths      = [[NSArray alloc]
                initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];

            gbl_myStartButtonLabel = [NSString stringWithFormat: @"%@_%@",
                                      myArrayOf3letterMonths[tmp_MM_int - 1], my_Obj_dd ];
//            gbl_lastSelectedDayFormattedForEmail = [NSString stringWithFormat: @"%@ %@, %@",
//                                      myArrayOf3letterMonths[tmp_MM_int - 1], my_Obj_dd, my_Obj_yyyy];
        //
        // end of  save start day stuff




//        // for turning off touches during calc
//        UITapGestureRecognizer *myTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self
//                                                                                                 action: @selector(myHandleTapFrom:) ];
//        [myToolbar addGestureRecognizer: myTapGestureRecognizer];
//        myTapGestureRecognizer.delegate = self;
//
//



        //sfill(stringBuffForStressScore, 60, ' ');
        
        yyyymmdd_todoC = [gbl_lastSelectedDay cStringUsingEncoding:NSUTF8StringEncoding];
        strcpy(yyyymmdd_todo, yyyymmdd_todoC);
        
        // NSString object to C
//        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for what color/calendar day
        my_psvc = [gbl_viewHTML_PSV_personJust1 cStringUsingEncoding:NSUTF8StringEncoding];  // for personality

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
        //ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
        //ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
        
        // get longitude and timezone hoursDiff from Greenwich
        // by looking up psvCity, psvProv, psvCountry
        //
        seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
        
        strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
        strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));


        // nav bar title using name of person
        //
        [[self navigationItem] setTitle:  @" "];  // this fixes title in info screen being too far right (not centered)
//        NSString *myNameForTitleOnNavBar = [NSString stringWithUTF8String: psvName ];  // convert c string to NSString
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle: myNameForTitleOnNavBar ];
//        });


        
        // set gbl for email
        gbl_person_name =  [NSString stringWithUTF8String:psvName ];

        // build csv arg for report function call
        //
        sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);

        

        // build HTML file name  in  TMP  Directory    dy=day , Calendar Day (old name) new=what color is today?
        //
        strcpy(person_name_for_filename, psvName);
        scharswitch(person_name_for_filename, ' ', '_');

        sprintf(html_file_name_browser, "%sdy%s_%s.html",         PREFIX_HTML_FILENAME, yyyymmdd_todo, person_name_for_filename);
        sprintf(html_file_name_webview, "%sdy%s_%s_webview.html", PREFIX_HTML_FILENAME, yyyymmdd_todo, person_name_for_filename);

        
        Ohtml_file_name_browser = [NSString stringWithUTF8String: html_file_name_browser ];
        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding: NSUTF8StringEncoding];
        
        Ohtml_file_name_webview = [NSString stringWithUTF8String: html_file_name_webview ];
        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent:  Ohtml_file_name_webview];

        gbl_OpathToHTML_webview = OpathToHTML_webview;  // for what color load

        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding: NSUTF8StringEncoding];


        URLtoHTML_forWebview  = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
        URLtoHTML_forEmailing = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser]];

        gbl_URLtoHTML_forWebview  = URLtoHTML_forWebview;
        gbl_URLtoHTML_forEmailing = URLtoHTML_forEmailing;



        // for shareButtonAction

        gbl_html_file_name_browser = [NSString stringWithUTF8String: html_file_name_browser ];   // for later sending as email attachment

        gbl_pathToFileToBeEmailed  = OpathToHTML_browser; // NSString email file named *.html  with no "webview" in it
        gbl_pathToFileToBeEmailed_B  = OpathToHTML_browser; // NSString email file named *.html  with no "webview" in it  (SAME PATH  for  tblrpts b)
//NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);
        NSLog(@"in viewdidload  viewhtml gbl_pathToFileToBeEmailed=%@",gbl_pathToFileToBeEmailed);
        


        // method  makeAndViewHTMLforWhatColorRpt  uses these gbl
        //
        strcpy(gbl_Cbuf_for_csv_person         , csv_person_string);
        strcpy(gbl_Cbuf_for_pathToHTML_webview , pathToHTML_webview);
        gbl_URLtoHTML_forWebview = URLtoHTML_forWebview;
        // plus   gbl_lastSelectedDay    (giving yyyymmdd)
        //        gbl_URLtoHTML_forWebview
        //        gbl_URLtoHTML_forEmailing
        //

//tn();trn("BEFORE calling makeAndViewHTMLforWhatColorRpt!");
        [self makeAndViewHTMLforWhatColorRpt];
//tn();trn("AFTER  calling makeAndViewHTMLforWhatColorRpt!");



    }  // [gbl_currentMenuPlusReportCode hasSuffix: @"wc"] // what color report (calendar day)

} // viewDidLoad


- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear() in view HTML");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
NSLog(@"in viewDidAppear()");
} // end of viewDidAppear




// ==============   start of email stuff  ================================================================================
// ==============   start of email stuff  ================================================================================

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
  NSLog(@"in viewWillAppear! in view HTML");



//    [self.navigationController.navigationBar.layer removeAllAnimations];  // stop the nav bar title stutter l to r


//    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction
//                                                                                 target: self
//                                                                                 action: @selector(shareButtonAction:)  ];
//
////    self.navigationItem.rightBarButtonItem = shareButton;
//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
//
////    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 44)];  // 3rd arg is length
//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//    //self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject: mySpacerForTitle];
//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//

    // you have to add the info button in interface builder by hand,
    // then you can add  Share button below with   rightBarButtonItems arrayByAddingObject: shareButton];
    //
    UIBarButtonItem *shareButton  = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                                         target: self
                                                         action: @selector(shareButtonAction:)];
    // label for  self.navigationItem.titleView 
    UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

    // add Navigation Bar right buttons, if not added already-  plus title text
    //
    if (gbl_viewHTML_ShouldAddToNavBar == 1) { // init to prevent  multiple programatic adds of nav bar items
        gbl_viewHTML_ShouldAddToNavBar  = 0;   // do not do this again

        // set nav bar title text
        //
        NSString *myNavBar2lineTitle;
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"])   // @"Calendar Year"

//        if (   [gbl_currentMenuPlusReportCode hasSuffix: @"cy"]              // @"Calendar Year"
        if (   [gbl_currentMenuPlusReportCode hasSuffix: @"hompcy"]              // @"Calendar Year" from home hompcy
        ) {
            if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
            ) {
                myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nStress Levels in Year %@", 
                                       gbl_viewHTML_NAME_personJust1, gbl_lastSelectedYear ];
            }
            else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                     && self.view.bounds.size.width  > 320.0
            ) {
                myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nStress Levels in Year %@", 
                                       gbl_viewHTML_NAME_personJust1, gbl_lastSelectedYear ];
            }
            else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
            ) {
                myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nStress Levels %@",
                                       gbl_viewHTML_NAME_personJust1, gbl_lastSelectedYear ];
            }

        }
//        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]    // calendar year report from best year
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbypcy"]    // calendar year report from best year
            || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]    // calendar year report from best year
        ) {
            myNavBar2lineTitle  = [NSString stringWithFormat:  @"Year %@\n for %@", 
                                   gbl_lastSelectedYear, gbl_viewHTML_NAME_personJust1 ];
        }

//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"homppe"]) 
//        if ([gbl_currentMenuPlusReportCode hasSuffix: @"pe"])    // personality
            if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] // gmappe,gmeppe,gmrppe,gmpppe,gmdppe homppe pbm1pe,pbm2pe gbm1pe,gbm2pe
//            || [gbl_currentMenuPlusReportCode hasPrefix: @"homgm"]   // personality report  homgma,homgme,homgmr,homgmp,homgmd
        ) {
            //myNavBar2lineTitle  = [NSString stringWithFormat:  @"Personality of\n%@", gbl_lastSelectedPerson ];
            myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nPersonality", gbl_viewHTML_NAME_personJust1 ];
        }
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"])   // @"Compatibility Potential"
        if ([gbl_currentMenuPlusReportCode hasSuffix: @"co"]) {  //   @"Compatibility Potential"
            myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\n& %@", 
//                                   gbl_lastSelectedPerson, gbl_lastSelectedSecondPerson ];
                                   gbl_viewHTML_NAME_personA, gbl_viewHTML_NAME_personB ];
        }


//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"])   // @"what color is the  day?"
//        if (   [gbl_currentMenuPlusReportCode hasSuffix: @"wc"]              // @"what color is the  day?"
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]      // @"what color is the  day?" from home
        ) {
//            myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\n%@", 
//                                   gbl_viewHTML_NAME_personJust1, gbl_lastSelectedDayFormattedForEmail ];
            myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@", 
                                   gbl_viewHTML_NAME_personJust1       ];
        }
//        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]    // what color report from best year
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]    // what color report from best year
        ) {
            myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nfor %@", 
                                   gbl_lastSelectedDayFormattedForEmail, gbl_viewHTML_NAME_personJust1];
        }

        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]      // @"what color is the  day?" from home
        ) {
            mySelRptB_Label.numberOfLines = 1;
        } else {
            mySelRptB_Label.numberOfLines = 2;
        }
//        mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 16.0];
//        mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 14.0];
        mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 17.0];
        mySelRptB_Label.textColor     = [UIColor blackColor];
        mySelRptB_Label.textAlignment = NSTextAlignmentCenter; 
        mySelRptB_Label.text          = myNavBar2lineTitle;
        mySelRptB_Label.adjustsFontSizeToFitWidth = YES;
        [mySelRptB_Label sizeToFit];
        


        // TWO-LINE NAV BAR TITLE
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
            self.navigationItem.titleView           = mySelRptB_Label; // mySelRptB_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
        });

    } // end of add Navigation Bar right buttons (once only)


    //  old       if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) { 
    //                // title "Compatibility Potential" does not fit any more with addition of i for INFO on right nav bar
    //                // therefore, make font smaller:
    //                //
    //                NSDictionary *navbarTitleTextAttributes = [ NSDictionary dictionaryWithObjectsAndKeys:
    //                    [UIColor blackColor]                                 ,  NSForegroundColorAttributeName,
    //                    [UIFont fontWithName:@"HelveticaNeueBold" size: 17.0],  NSFontAttributeName,
    //                    nil
    //                ];
    //                [self.navigationController.navigationBar setTitleTextAttributes: navbarTitleTextAttributes];
    //            }
    //

    // for hompwc  "what color is the day?",
    // use 3 buttons in a toolbar on bottom of screen to go back/today/fore 
    //
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]) 
//    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"wc"]               // what color report
    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"hompwc"]               // what color report from home
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]     // what color from group Best day  rpt   
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbdpwc"]     // what color from group Best day  rpt   
    ) {
    
        UIBarButtonItem *prevDay = [[UIBarButtonItem alloc]initWithTitle: @"Backward"
                                                                   style: UIBarButtonItemStylePlain
                                                                //style: UIBarButtonItemStyleBordered
                                                                  target: self
                                                                  action: @selector(pressedPrevDay)];

        // for startDay button label, use like  "Jun_05"
        //UIBarButtonItem *startDay = [[UIBarButtonItem alloc]initWithTitle: @"Start"
        UIBarButtonItem *startDay = [[UIBarButtonItem alloc]initWithTitle: gbl_myStartButtonLabel 
                                                                   style: UIBarButtonItemStylePlain
                                                                  target: self
                                                                  action: @selector(pressedStartDay)];

        UIBarButtonItem *nextDay = [[UIBarButtonItem alloc]initWithTitle: @"Forward"
                                                                   style: UIBarButtonItemStylePlain
                                                                  target: self
                                                                  action: @selector(pressedNextDay)];

        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                                         target: self
                                                                                         action: nil];
        // create a Toolbar
//        UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
//        UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];


//        gbl_toolbarForwBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];

    float my_screen_height;
    float my_status_bar_height;
    float my_nav_bar_height;
    float my_toolbar_height;

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
    my_screen_height = currentScreenWidthHeight.height;

    CGSize myStatusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    my_status_bar_height   = MIN(myStatusBarSize.width, myStatusBarSize.height);

    my_nav_bar_height    =  self.navigationController.navigationBar.frame.size.height;


//  NSLog(@"cu33entScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
//  NSLog(@"cu33entScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
  NSLog(@"my_screen_height                  =%f",my_screen_height );
  NSLog(@"my_status_bar_height              =%f",my_status_bar_height   );
  NSLog(@"my_nav_bar_height                 =%f",my_nav_bar_height    );
//  NSLog(@"my_toolbar_height                 =%f",my_toolbar_height );

    my_toolbar_height = 44.0;

    float y_value_of_toolbar; 
//    y_value_of_toolbar  = currentScreenWidthHeight.height - 44.0;
//    y_value_of_toolbar  = 400.0;
//    y_value_of_toolbar  = 436.0;
//    y_value_of_toolbar  = 480.0;
//    y_value_of_toolbar  = 472.0;// too low
//    y_value_of_toolbar  = 464.0; // very close
//    y_value_of_toolbar  = 458.0; // too high
//    y_value_of_toolbar  = 456.0; // too high
//    y_value_of_toolbar  = 459.0; // too high
//    y_value_of_toolbar  = 460.0; // very close   exact
    y_value_of_toolbar  = my_screen_height  - my_status_bar_height  - my_nav_bar_height - my_toolbar_height;
  NSLog(@"y_value_of_toolbar  =%f",y_value_of_toolbar  );


    gbl_toolbarForwBack = [[UIToolbar alloc] initWithFrame:CGRectMake(
        0.0,
//            currentScreenWidthHeight.height - 44,
//        100.0,
        y_value_of_toolbar, 
        currentScreenWidthHeight.width,
        44.0)];


//<.>
//439://      gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [cell frame].size.width -20, [cell frame].size.height)];
//906:// CGRect pickerFrame = CGRectMake(0.0, viewFrame.size.height-pickerHeight, viewFrame.size.width, pickerHeight);
//28:    self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//<.>

        // make array of buttons for the Toolbar
        NSArray *myButtonArray =  [NSArray arrayWithObjects:
            myFlexibleSpace, prevDay, myFlexibleSpace, startDay, myFlexibleSpace, nextDay, myFlexibleSpace, nil
        ]; 

        // put the array of buttons in the Toolbar
        [gbl_toolbarForwBack setItems: myButtonArray   animated: NO];
nbn(29);
        // put the Toolbar onto bottom of what color view
        dispatch_async(dispatch_get_main_queue(), ^(void){
//             self.navigationController.toolbar.hidden = YES;
            [self.view addSubview: gbl_toolbarForwBack ];

//            [self.navigationController.view addSubview: gbl_toolbarForwBack ];  // this worked  but in info, it stayed  also allows too fast
//             self.navigationController.toolbar.hidden = NO;
//            [self.navigationController.toolbar setItems: myButtonArray ]; 
//            self.navigationController.toolbar.items = myButtonArray; 
//             self.navigationController.toolbar.hidden = NO

        });

//    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"])     // @"what color is the  day?" from home
//    {
////        [self.navigationController  setToolbarHidden:NO];
//nbn(71);
//    [webView reload];
//
//    }

    } // for what color report add Backward / Forward on bottom of screen

} // end of   viewWillAppear



-(void)shareButtonAction:(id)sender
{
    MFMailComposeViewController *myMailComposeViewController;

tn();    NSLog(@"in shareButtonAction!  in viewHTML   ");
    
    // Determine the file name and extension
    // NSArray *filepart = [gbl_pathToFileToBeEmailed componentsSeparatedByString:@"."];
    NSArray *fileparts = [gbl_pathToFileToBeEmailed componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"./"]];
    
    NSString *baseFilename = [fileparts objectAtIndex: (fileparts.count -2)] ;  // count -1 is last in array
    NSString *extension = [fileparts lastObject];
    NSString *filenameForAttachment = [NSString stringWithFormat: @"%@.%@", baseFilename, extension];
    
    // Get the resource path and read the file using NSData
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *HTMLfileData = [NSData dataWithContentsOfFile: gbl_pathToFileToBeEmailed ];
//NSLog(@"gbl_pathToFileToBeEmailed =%@",gbl_pathToFileToBeEmailed );
//NSLog(@"HTMLfileData.length=%lu",(unsigned long)HTMLfileData.length);


    NSString *emailTitle = [NSString stringWithFormat: @"%@  from Me and my BFFs", filenameForAttachment];

    NSString *myEmailMessage;
    
    myEmailMessage = @"-----";
    NSLog(@"myEmailMessage=%@",myEmailMessage);
    NSLog(@"extension=%@",extension);

    NSLog(@"gbl_person_name=%@",gbl_person_name);


    // NOTE:  changed all "homgmX" to gmXppe
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmappe"]) {  // Most ... group report
        myEmailMessage = [NSString stringWithFormat: @"\n\"Most Assertive Person in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_lastSelectedGroup ];
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmeppe"]) {  // Most ... group report
        myEmailMessage = [NSString stringWithFormat: @"\n\"Most Emotional Person in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_lastSelectedGroup ];
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmrppe"]) {  // Most ... group report
        myEmailMessage = [NSString stringWithFormat: @"\n\"Most Restless Person in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_lastSelectedGroup ];
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmpppe"]) {  // Most ... group report
        myEmailMessage = [NSString stringWithFormat: @"\n\"Most Passionate Person in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_lastSelectedGroup ];
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"gmdppe"]) {  // Most ... group report
        myEmailMessage = [NSString stringWithFormat: @"\n\"Most Down-to-earth Person in Group %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_lastSelectedGroup ];
    }

//
////    if ([gbl_currentMenuPlusReportCode hasSuffix: @"pe"])   // personality
////    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"]      // personality report
//    if (   [gbl_currentMenuPlusReportCode hasSuffix: @"pe"] // per rpt gmappe,gmeppe,gmrppe,gmpppe,gmdppe homppe pbm1pe,pbm2pe gbm1pe,gbm2pe
////        || [gbl_currentMenuPlusReportCode hasPrefix: @"homgm"]   // personality report  homgma,homgme,homgmr,homgmp,homgmd
//    ) {
//        myEmailMessage = [NSString stringWithFormat: @"\n\"Personality of %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_person_name ];
//    }
//    if ([gbl_currentMenuPlusReportCode hasSuffix: @"co"]) {  //   @"Compatibility Potential"  hompco, pbmco, gbmco
//        myEmailMessage = [NSString stringWithFormat: @"\"Compatibility Potential of %@ and %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_person_name, gbl_person_name2 ];
//    }
//
    if ([gbl_currentMenuPlusReportCode hasSuffix: @"cy"]) {  // @"Calendar Year"              hompcy and gbypcy
        myEmailMessage = [NSString stringWithFormat: @"\"Calendar Year %@ for %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.", gbl_lastSelectedYear, gbl_person_name
        ];
    }
    if ([gbl_currentMenuPlusReportCode hasSuffix: @"wc"]) {    // @"what color is the  day?"  hompwc and gbdpwc
        myEmailMessage = [NSString stringWithFormat: @"\"What Color is the Day? (%@) for %@\"\nis the attached report, which was done with iPhone App  Me and my BFFs.",
            gbl_lastSelectedDayFormattedForEmail,
            gbl_person_name
        ];
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
        });
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
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Cannot send email"
                                                                       message: @"Maybe email on this device is not set up."
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self presentViewController: alert  animated: YES  completion: nil   ];
        });
    }
} // shareButtonAction


- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{

    // AVOID this ERROR:
    // ios Attempting to load the view of a view controller while it is deallocating is not allowed and may result in undefined behavior
    //
    //   use    dispatch_async(dispatch_get_main_queue(), ^(void)
    //        around presentViewController
    //   BUT NOT  around   [self dismissViewControllerAnimated:YES completion:NULL];
    //

    if (error) {
//        UIAlertView *myalert = [[UIAlertView alloc] initWithTitle: @"An error happened"
//                                                          message: [error localizedDescription]
//                                                         delegate: nil
//                                                cancelButtonTitle: @"cancel"
//                                                otherButtonTitles: nil, nil];
//        [myalert show];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"An error happened"
                                                                       message: [error localizedDescription]
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
        } ];
        [alert addAction:  okButton];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self presentViewController: alert  animated: YES  completion: nil   ];
        });

        // [self dismissViewControllerAnimated:yes completion:<#^(void)completion#>];

//        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated: YES
                                     completion:NULL];
//        });
    }
    switch (result)
    {
        case MFMailComposeResultCancelled: {
NSLog(@"Mail cancelled");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail send was cancelled"
//                                                            message: @""
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail Send was Cancelled"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self presentViewController: alert  animated: YES  completion: nil   ];
            });

            break;
        }
        case MFMailComposeResultSaved: {
            NSLog(@"Mail saved");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail was saved"
//                                                            message: @""
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail was Saved"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self presentViewController: alert  animated: YES  completion: nil   ];
            });

            break;
        }
        case MFMailComposeResultSent: {
            NSLog(@"Mail sent");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail was sent"
//                                                            message: @""
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Mail was Sent"
                                                                           message: @""
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self presentViewController: alert  animated: YES  completion: nil   ];
            });


            break;
        }
        case MFMailComposeResultFailed: {
            NSLog(@"Mail send failure: %@", [error localizedDescription]);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Failure of mail send"
//                                                            message: [error localizedDescription]
//                                                           delegate: nil
//                                                  cancelButtonTitle: @"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Failure of Mail Send"
                                                                           message: [error localizedDescription]
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
NSLog(@"Ok button pressed");
            } ];
            [alert addAction:  okButton];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self presentViewController: alert  animated: YES  completion: nil   ];
            });

            break;
        }
        default: { break; }
    }
    
    // Close the Mail Interface
//    [self becomeFirstResponder];  // from http://stackoverflow.com/questions/14263690/need-help-dismissing-email-composer-screen-in-ios

    //[self dismissModalViewControllerAnimated:YES

    // AVOID this ERROR:
    // ios Attempting to load the view of a view controller while it is deallocating is not allowed and may result in undefined behavior
    //
    //   use    dispatch_async(dispatch_get_main_queue(), ^(void)
    //        around presentViewController
    //   BUT NOT  around   [self dismissViewControllerAnimated:YES completion:NULL];
    //
//    dispatch_async(dispatch_get_main_queue(), ^(void){
            [self dismissViewControllerAnimated:YES
                                     completion:NULL];
//    });

} //  didFinishWithResult:(MFMailComposeResult)result

// ==============   END of email stuff  ====================



//  e.g. below
//
//    if ([MFMailComposeViewController canSendMail])
//    {
//        if ([MFMailComposeViewController canSendMail])
//        {
//                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//                mail.mailComposeDelegate = self;
//                [mail setSubject:@"Sample Subject"];
//                [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
//                [mail setToRecipients:@[@"testingEmail@example.com"]];
//            
//                [self presentViewController:mail animated:YES completion:NULL];
//        }
//        else
//        {
//                NSLog(@"This device cannot send email");
//        }
//- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//    {
//        switch (result) {
//            case MFMailComposeResultSent:
//                NSLog(@"You sent the email.");
//                break;
//            case MFMailComposeResultSaved:
//                NSLog(@"You saved a draft of this email");
//                break;
//            case MFMailComposeResultCancelled:
//                NSLog(@"You cancelled sending this email.");
//                break;
//            case MFMailComposeResultFailed:
//                NSLog(@"Mail failed:  An error occurred when trying to compose this email");
//                break;
//            default:
//                NSLog(@"An error occurred when trying to compose this email");
//                break;
//        }
//        
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    }
//    
//    NSLog(@"share action");
//    - (void)emailExport:(NSString *)filePath
//    {
//        NSLog(@"Should send CSV = %@", [NSNumber numberWithBool:appDelegate.shouldSendCSV]);
//        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
//        picker.mailComposeDelegate = self;
//        
//        // Set the subject of email
//        [picker setSubject:@"My Billed Time Export"];
//        
//        // Add email addresses
//        // Notice three sections: "to" "cc" and "bcc"
//        
//        NSString *valueForEmail = [[NSUserDefaults standardUserDefaults] stringForKey:@"emailEntry"];
//        NSString *valueForCCEmail = [[NSUserDefaults standardUserDefaults] stringForKey:@"ccEmailEntry"];
//        if( valueForEmail == nil ||  [valueForEmail isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Please set an email address before sending a time entry!" message:@"You can change this address later from the settings menu of the application!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//            
//            return;
//        }
//        else {
//            [picker setToRecipients:[NSArray arrayWithObjects:valueForEmail, nil]];
//        }
//        
//        if(valueForCCEmail != nil || ![valueForCCEmail isEqualToString:@""])
//        {
//            [picker setCcRecipients:[NSArray arrayWithObjects:valueForCCEmail, nil]];
//        }
//        
//        // Fill out the email body text
//        NSString *emailBody = @"My Billed Time Export File.";
//        
//        // This is not an HTML formatted email
//        [picker setMessageBody:emailBody isHTML:NO];
//        
//        if (appDelegate.shouldSendCSV) {
//            
//            // Create NSData object from file
//            NSData *exportFileData = [NSData dataWithContentsOfFile:filePath];
//            
//            // Attach image data to the email
//            [picker addAttachmentData:exportFileData mimeType:@"text/csv" fileName:@"MyFile.csv"];
//        } else {UISegmentedControl
//            [picker setMessageBody:self.csvText isHTML:NO];
//        }
//        // Show email view  
//        [self presentModalViewController:picker animated:YES];
//        
//        // Release picker
//        [picker release];
//    }
//
//}



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




- (IBAction)pressedPrevDay
{
//    NSLog(@"pressedPrevDay");
    NSInteger num_days_to_add_or_subtract = -1;
    [self makeNew_gbl_lastSelectedDayByAdding: (NSInteger) num_days_to_add_or_subtract];

//tn();trn("in pressedPrevDay  BEFORE call to  makeAndViewHTMLforWhatColorRpt");
    [self makeAndViewHTMLforWhatColorRpt];
//tn();trn("in pressedPrevDay  AFTER  call to  makeAndViewHTMLforWhatColorRpt");

} // pressedPrevDay


- (IBAction)pressedStartDay
{
//    NSLog(@"pressedStartDay");
    NSInteger num_days_to_add_or_subtract = 999;  // 999   is magic flag to set the day to TODAY
    [self makeNew_gbl_lastSelectedDayByAdding: (NSInteger) num_days_to_add_or_subtract];

//tn();trn("in pressedStartDay  BEFORE call to  makeAndViewHTMLforWhatColorRpt");
    [self makeAndViewHTMLforWhatColorRpt];
//tn();trn("in pressedStartDay  AFTER  call to  makeAndViewHTMLforWhatColorRpt");

} // pressedStartDay


- (IBAction)pressedNextDay
{
//tn();    NSLog(@"in pressedNextDay");
    NSInteger num_days_to_add_or_subtract = 1;
    [self makeNew_gbl_lastSelectedDayByAdding: (NSInteger) num_days_to_add_or_subtract];

    // selected day LIMIT
    //
    // Maximum future lookahead
    // is to the end of 
    // the calendar year after
    // the current calendar year.
    //
//  NSLog(@"gbl_lastSelectedDay     =%@",gbl_lastSelectedDay );
//  NSLog(@"gbl_lastSelectedDayLimit=%@",gbl_lastSelectedDayLimit);

    NSComparisonResult compareResult = [gbl_lastSelectedDay compare: gbl_lastSelectedDayLimit];
    if (compareResult == NSOrderedDescending) {   // gbl_lastSelectedDay > gbl_lastSelectedDayLimit

//  NSLog(@"HIT LIMIT for FUT !!!");
        gbl_lastSelectedDay = gbl_lastSelectedDayLimit;
//  NSLog(@"gbl_lastSelectedDay     =%@",gbl_lastSelectedDay );
//  NSLog(@"gbl_lastSelectedDayLimit=%@",gbl_lastSelectedDayLimit);


        UIAlertController* alert =
            [UIAlertController alertControllerWithTitle: @"Maximum future lookahead"
//                                                message: @"is to the end of\nthe calendar year after\nthe current calendar year."
                                                message: @"is to the end of the calendar year\nafter the current calendar year."
                                         preferredStyle: UIAlertControllerStyleAlert ];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {}];
        [alert addAction: defaultAction];
        [self presentViewController:alert animated: YES completion: nil];

        return;
    }

//tn();trn("in pressedNextDay  BEFORE call to  makeAndViewHTMLforWhatColorRpt");
    [self makeAndViewHTMLforWhatColorRpt];
//tn();trn("in pressedNextDay  AFTER  call to  makeAndViewHTMLforWhatColorRpt");

} // pressedNextDay




- (IBAction)pressedInfoButton
{
  NSLog(@"in  pressedInfoButton!");

//        dispatch_async(dispatch_get_main_queue(), ^(void){
//    self.navigationController.toolbar.hidden = YES;
//        });

} // end of  pressedInfoButton



- (void) makeNew_gbl_lastSelectedDayByAdding:  (NSInteger) arg_num_days_to_add_or_subtract
{
    // need to add or subtract  arg num days to  gbl_lastSelectedDay   yyyymmdd

//NSLog(@"arg_num_days_to_add_or_subtract=%ld",(long)arg_num_days_to_add_or_subtract);

    if  (arg_num_days_to_add_or_subtract == 999) {   // 999   is magic flag to set the day to TODAY
        gbl_lastSelectedDay =  gbl_lastSelectedDaySaved;  // USE   START DAY (for "Start button") return;
        return;
    }

    // #ifdef PUT_BACK_COMMENTED_OUT_STUFF /****************************************/
    // * static int mytimes; mytimes++;
    // *   double dmn,ddy,dyr,dstep;
    // *     dstep = (double)(Eph_rec_every_x_days);
    // *     dmn = (double) Fut_start_mn;
    // *     ddy = (double) Fut_start_dy;
    // *     dyr = (double) Fut_start_yr;
    // * if (mytimes == 2 ) mk_new_date(&dmn,&ddy,&dyr,dstep+92*2-2);
    // * 
    // * for (iday_num=1; iday_num <= Num_eph_grh_pts; ++iday_num) {
    // * 
    // * fprintf(stderr,"%s|%d|%04d|%02d|%02d|%d|\n",  fEvent_name, iday_num,
    // *     (int)dyr,
    // *     (int)dmn,
    // *     (int)ddy,
    // *     *(Grhdata_bestday + (iday_num-1) )
    // * );
    // * 
    // *     mk_new_date(&dmn,&ddy,&dyr,dstep);
    // * }
    // #endif /* ifdef PUT_BACK_COMMENTED_OUT_STUFF ********************************/
    //
    //  e.g. #2
    //  mn = (double)Grh_beg_mn;  /* calc from_date from day_num */
    //  dy = (double)Grh_beg_dy;
    //  yr = (double)Grh_beg_yr;
    //  if(trn_plt == 6) day_num++;  /* this is a mystery. 6=mars */
    //    /* ^why does this old comment say 6=mars. new: it's ok (jsunpm) */
    //  step = (double)((day_num-1) * Eph_rec_every_x_days);
    //  mk_new_date(&mn,&dy,&yr,step);
    //  Rt[nat_plt].from_date.mn = (int)mn;
    //  Rt[nat_plt].from_date.dy = (int)dy;
    //  Rt[nat_plt].from_date.yr = (int)yr;
    //

    // 
    NSString *my_Obj_yyyy = [gbl_lastSelectedDay substringWithRange: NSMakeRange(0,4)];
    NSString *my_Obj_mm   = [gbl_lastSelectedDay substringWithRange: NSMakeRange(4,2)];
    NSString *my_Obj_dd   = [gbl_lastSelectedDay substringWithRange: NSMakeRange(6,2)];
//NSLog(@"my_Obj_yyyy =%@",my_Obj_yyyy );
//NSLog(@"my_Obj_mm   =%@",my_Obj_mm   );
//NSLog(@"my_Obj_dd   =%@",my_Obj_dd   );
//

    // exampl NSString to double:
    //NSString *value = [valuelist objectAtIndex:valuerow];
    //NSString *value2 = [valuelist2 objectAtIndex:valuerow2];
    //double cal = [value doubleValue] + ([value2 doubleValue] * 8) + 3;
    //NSString *message =[[NSString alloc] initWithFormat:@"%f",cal];
    //

    double mn, dy, yr, dstep;
    yr = [my_Obj_yyyy  doubleValue];
    mn = [my_Obj_mm    doubleValue];
    dy = [my_Obj_dd    doubleValue];
//NSLog(@"f yr=%f",yr);
//NSLog(@"f mn=%f",mn);
//NSLog(@"f dy=%f",dy);

    dstep = (double)arg_num_days_to_add_or_subtract;
//NSLog(@"f dstep=%f",dstep);

    mk_new_date(&mn, &dy, &yr, dstep);

//NSLog(@"new f yr=%f",yr);
//NSLog(@"new f mn=%f",mn);
//NSLog(@"new f dy=%f",dy);
//NSLog(@" before gbl_lastSelectedDay    =%@",gbl_lastSelectedDay    );

    gbl_lastSelectedDay = [[NSString alloc] initWithFormat:@"%04d%02d%02d", (int)yr, (int)mn, (int)dy];

//NSLog(@" after  gbl_lastSelectedDay    =%@",gbl_lastSelectedDay    );

} // makeNew_gbl_lastSelectedDay 





// method  makeAndViewHTMLforWhatColorRpt  uses these 4 GBLs  as  INPUT
//
//  1. strcpy(gbl_Cbuf_for_csv_person         , csv_person_string);
//  2. strcpy(gbl_Cbuf_for_pathToHTML_webview , pathToHTML_webview);
//  3. gbl_URLtoHTML_forWebview = URLtoHTML_forWebview;
//  4. plus   gbl_lastSelectedDay    (giving yyyymmdd)
//            gbl_URLtoHTML_forWebview
//            gbl_URLtoHTML_forEmailing
//
- (void) makeAndViewHTMLforWhatColorRpt
{
    NSArray* tmpDirFiles;
    int      retval; // retval2;
    char     stringBuffForStressScore[64] ;

    sfill(stringBuffForStressScore, 60, ' ');
//tn();NSLog(@"in makeAndViewHTMLforWhatColorRpt");

//    // put different nav bar title depending on date
//<.>gbl_lastSelectedDay
//<.>
//        // nav bar title
//        //
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [[self navigationItem] setTitle:  @"What Color is Today?"];
//        });
//<.>
//


    // remove all "*.html" files from TMP directory before creating new one
    //
    tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
//    NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
    for (NSString *fil in tmpDirFiles) {
//        NSLog(@"file to DELETE=%@",fil);
        if ([fil hasSuffix: @"html"]) {
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
        }
    }


    //tn();trn("BEFORE doing 2 calendar day call ...");
    //ks(html_file_name_browser);

    //    NOTE:    calenday Day  /  What Color is Today   has o_nly 1 html repor
    const char *arg_yyyymmdd_CONST;                                                       // NSString object to C str
    char arg_yyyymmdd_C[128];                                                             // NSString object to C str
    arg_yyyymmdd_CONST = [gbl_lastSelectedDay cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
    strcpy(arg_yyyymmdd_C, arg_yyyymmdd_CONST);                                           // NSString object to C str  // because of const
//ksn(gbl_Cbuf_for_pathToHTML_webview);
//ksn(gbl_Cbuf_for_csv_person);
//ksn(arg_yyyymmdd_C);

    retval = mamb_report_year_in_the_life (    /* in futdoc.o */
        gbl_Cbuf_for_pathToHTML_webview,  // let's try one html file (short report)
        gbl_Cbuf_for_csv_person,
        arg_yyyymmdd_C,
        "do day stress report and return stress score",  /* instructions */
        stringBuffForStressScore   /* char *stringBuffForStressScore */
    );
//;trn("AFTER  doing 2 calendar day call ...");
//
////NSLog(@"arg pathToHTML_browser=%s",pathToHTML_browser);
//NSLog(@"arg gbl_Cbuf_for_pathToHTML_webview=%s",gbl_Cbuf_for_pathToHTML_webview);
//NSLog(@"arg gbl_Cbuf_for_csv_person=%s",gbl_Cbuf_for_csv_person);
//NSLog(@"arg gbl_lastSelectedDay=%@",gbl_lastSelectedDay);
//kin(retval);


    //
    //  SECOND CALL for BIG html 
    //
//        retval2 = mamb_BIGreport_year_in_the_life (    // big html for non webview
//            gbl_Cbuf_for_pathToHTML_browser,
//            gbl_Cbuf_for_csv_person_string,
//            gbl_URLtoHTML_forWebview
//            gbl_URLtoHTML_forEmailing
//            gbl_lastSelectedDay,
//            "do day stress report and return stress score",  /* instructions */
//            stringBuffForStressScore   /* char *stringBuffForStressScore */
//        );
//
//<.>
        //
        //   copy  *webview.html to  *html  (using the same report)
        //
        NSFileManager* sharedFM2 = [NSFileManager defaultManager];
        NSError *err03;
        [sharedFM2 copyItemAtURL: gbl_URLtoHTML_forWebview
                           toURL: gbl_URLtoHTML_forEmailing
                           error: &err03];
        if (err03) { NSLog(@"err on cp *webview.html to *.html %@", err03); }



        // for test,  show all files in temp dir
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
        for (NSString *s in fileList){
            NSLog(@"TEMP DIR %@", s);
        }

//int   haveEmail    = [gbl_sharedFM fileExistsAtPath: gbl_pathToFileToBeEmailed ];
//NSLog(@"have email file=%d",haveEmail);


//<.>
        // for test,  show all files in temp dir
    
//        // for test,  log all contents of pathToHTML_webview in temp dir
//        NSString* mycontents = [NSString stringWithContentsOfFile: OpathToHTML_webview
//                                                         encoding: NSUTF8StringEncoding
//                                                            error: NULL];
//        NSLog(@"%@",mycontents);
//        // for test,  log all contents of pathToHTML_webview in temp dir
//
    

//<.>
//            NSString* myWhatColorHTML_FileContents = [NSString stringWithContentsOfFile: OpathToHTML_webview
//        
//        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
//        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
//        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
//        
//<.>
//

            //  get all the html lines into a NSString and a NSArray
            //
//            NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
            NSString* myWhatColorHTML_FileContents = [NSString stringWithContentsOfFile: gbl_OpathToHTML_webview
                                                                               encoding: NSUTF8StringEncoding
                                                                                  error: nil ];
//            NSArray *htmllines = [fileContents componentsSeparatedByCharactersInSet: newlineCharSet];




    //if (retval == 0 && retval2 == 0) 
    if (retval == 0) {                   // retval = mamb_report_year_in_the_life (    /* in futdoc.o */

        /* here, go and look at html report */
        
        self.outletWebView.scalesPageToFit = YES;
        
        // I was having the same problem. I found a property on the UIWebView
        // that allows you to turn off the data detectors.
        //
        self.outletWebView.dataDetectorTypes = UIDataDetectorTypeNone;

       
//        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] ==  NO) {  // suspend handling of touch-related events
//            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];     // typically call this before an animation or transitiion.
//  NSLog(@"ARE  IGnoring events");
//        }
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];
   

        // place our URL in a URL Request
        NSURLRequest *HTML_URLrequestForWhatColorReport;

        //        HTML_URLrequestForWhatColorReport =
        //            [[NSURLRequest alloc] initWithURL: gbl_URLtoHTML_forWebview]; // HTML_URLrequest  is declared at top of viewHTML .m
        //
        // Try ignoring the cache:
        HTML_URLrequestForWhatColorReport = [NSURLRequest requestWithURL: gbl_URLtoHTML_forWebview
                                                             cachePolicy: NSURLRequestReloadIgnoringCacheData
                                                         timeoutInterval: 0.0  ];

        // put up new report for new day  BUT
        // but, disable user interaction for "mytime"
        // to prevent machine-gun pounding on next or prev key
        //
        if (gbl_shouldUseDelayOnBackwardForeward == 1) {  // = 1 (0.5 sec  on what color update)
                                                          // = 0 (no delay on first show of screen)
            [self.view setUserInteractionEnabled: NO];                              // this works to disable user interaction for "mytime"

            int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
            dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);

            dispatch_after(mytime, dispatch_get_main_queue(), ^{                     // do after delay of  mytime
//                [self.outletWebView loadRequest: HTML_URLrequestForWhatColorReport];
                [self.outletWebView  loadHTMLString: myWhatColorHTML_FileContents  baseURL: nil];
                [self.view setUserInteractionEnabled: YES];                          // this works to disable user interaction for "mytime"
            });
        }

        if (gbl_shouldUseDelayOnBackwardForeward == 0) {  // = 1 (0.5 sec  on what color update)
                                                          // = 0 (no delay on first show of screen)

            dispatch_async(dispatch_get_main_queue(), ^(void){  // UIWebView is part of UIKit, so you should operate on the main thread.
//                [self.outletWebView loadRequest: HTML_URLrequestForWhatColorReport];
                [self.outletWebView  loadHTMLString: myWhatColorHTML_FileContents  baseURL: nil];
            });
        }                                                          

//        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) {  // re-enable handling of touch-related events
//            [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
//  NSLog(@"STOP IGnoring events");
//        }

        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds


        gbl_shouldUseDelayOnBackwardForeward = 1;   // only use no delay for fast presentation on initial user viewing
    }
//NSLog(@"end of makeAndViewHTMLforWhatColorRpt ");

} // makeAndViewHTMLforWhatColorRpt


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // segueRptSelToViewHTML
}


@end



//  jumpy
//        // http://stackoverflow.com/questions/19204799/how-to-reduce-font-size-of-navigation-bar-title-in-ios-7
//        //UILabel *nav_titlelbl      = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.navigationItem.titleView.frame.size.width,40)];
//        UIFont *myFont = [UIFont boldSystemFontOfSize: 14.0f];
//
//        //UILabel *nav_titlelbl      = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0 ,40)];
//        UILabel *nav_titlelbl      = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 0.0 ,40.0)];
//        [nav_titlelbl setFont: myFont];
//        nav_titlelbl.text          = @"Compatibility Potential";
////        nav_titlelbl.textAlignment = NSTextAlignmentCenter;
//
//        dispatch_async( dispatch_get_main_queue(), ^{                                // <=== 
//            self.navigationItem.titleView = nav_titlelbl;
//        });
//


//        // SET UP  SEGMENTED CTRL IN NAV BAR   for next/prev  date
//        //
//        // use title in HTML instead of in Nav CTRl  big/small    media query 
//        //
//        // old    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//        //            [[self navigationItem] setTitle:  @"What Color is Today?"];
//        //        });
//        //
//            // e.g.
//            //UISegmentedControl *myNextPrev =
//            // [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Personnal", @"Department", @"Company", nil]];
//        //
//        UISegmentedControl *myNextPrevSeqmentedControl =
//            [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Prev", @"Next", nil]];
//        [myNextPrevSeqmentedControl sizeToFit];
//        self.navigationItem.titleView = myNextPrevSeqmentedControl ;
//        [myNextPrevSeqmentedControl addTarget: self
//                                       action: @selector(actionNextPrevSegmentedControlPressed)
//                             forControlEvents: UIControlEventValueChanged ];
//        //myNextPrevSeqmentedControl.selectedSegmentIndex = 1;  //  "Next" as default
//        // for deselecting use this line [<segmentcontrl> setSelectedSegmentIndex:UISegmentedControlNoSegment]
//        [myNextPrevSeqmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
//

//================================================
//UIToolbar with buttons in the nav bar
//try this 
//http://stackoverflow.com/questions/6249416/adding-more-than-two-button-on-the-navigationbar
//================================================
//
        //UIToolbar *tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 90.0f, 55.01f)];


//used to be in viewdidload
//// Automatically called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch.
//// return NO to prevent the gesture recognizer from seeing this touch
////
//- (BOOL) gestureRecognizer: (UIGestureRecognizer *)gestureRecognizer   shouldReceiveTouch: (UITouch *)touch {
//  NSLog(@"in gestureRecognizer! ");
//
//  NSLog(@"gbl_shouldReceiveTouches =%ld",(long)gbl_shouldReceiveTouches );
//    if (gbl_shouldReceiveTouches == 0) {
//tr("returned NO   do not receive touches");
//        return NO;
//    } else {
//tr("returned YES  do     receive touches");
//        return YES;
//    }
//}
//

  
//
//    
////<.>  this report (grpof2) is now in tblrpts_1    (changed from html to tableview)
////
////
////    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) 
//    if ([gbl_currentMenuPlusReportCode hasSuffix: @"co"])  // compatibility report  (just 2)
//    {
//        tn();trn("in Compatibility Potential!");
//        
////        // title does not fit any more with addition of i for INFO on right nav bar
////        //        dispatch_async(dispatch_get_main_queue(), ^{                                // <=== 
////        //            [[self navigationItem] setTitle: @"Compatibility Potential\011"];
////        //        });
////        //
////        // therefore, make font smaller:
////        //
////        dispatch_async( dispatch_get_main_queue(), ^{                                // <=== 
////            NSDictionary *navbarTitleTextAttributes = [ NSDictionary dictionaryWithObjectsAndKeys:
////                [UIColor blackColor]                                 ,  NSForegroundColorAttributeName,
////                [UIFont fontWithName:@"HelveticaNeueBold" size: 17.0],  NSFontAttributeName,
////                nil
////            ];
////            [self.navigationController.navigationBar setTitleTextAttributes: navbarTitleTextAttributes];
////
////            [[self navigationItem] setTitle: @"Compatibility Potential"];
////        });
////
//
//        do { // assemble person1 CSV
////  NSLog(@"gbl_viewHTML_PSV_personA=%@",gbl_viewHTML_PSV_personA);
//
////            my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA
//            my_psvc = [gbl_viewHTML_PSV_personA cStringUsingEncoding: NSUTF8StringEncoding]; // NSString object to C for pco/personA
//
//            strcpy(my_psv, my_psvc); // because of const
////ksn(my_psv);            
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
//            strcpy(person1_name_for_filename, psvName);
//            scharswitch(person1_name_for_filename, ' ', '_');
//
////ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
////ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
//            
//            // get longitude and timezone hoursDiff from Greenwich
//            // by looking up psvCity, psvProv, psvCountry
//            //
//            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
////ksn(returnPSV);            
//            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
//            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
////ksn(psvHoursDiff);
////ksn(psvLongitude);
//            // set gbl for email
//            gbl_person_name =  [NSString stringWithUTF8String:psvName ];
////  NSLog(@"gbl_person_name =%@",gbl_person_name );
//            // build csv arg for report function call
//            //
//            sprintf(csv_person1_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
//            ksn(csv_person1_string);tn();
//
//        } while (NO);  // assemble person1 CSV   (do only once)
//        
//        do { // assemble person2 CSV
////            my_psvc = [gbl_fromSelSecondPersonPSV cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C  for pco/personB
//            my_psvc = [gbl_viewHTML_PSV_personB cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C  for pco/personB
//
//            strcpy(my_psv, my_psvc); // because of const
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
//            strcpy(person2_name_for_filename, psvName);
//            scharswitch(person2_name_for_filename, ' ', '_');
//            
//     
////ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
////ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
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
//            gbl_person_name2 =  [NSString stringWithUTF8String:psvName ];
//
//            // build csv arg for report function call
//            //
//            sprintf(csv_person2_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
//            ksn(csv_person2_string);tn();
//            
//        } while (NO);  // assemble person2 CSV   (do only once)
//
//        // build HTML file name, path name, an URL in  TMP  Directory
//        //
//        sprintf(html_file_name_browser,
//                "%sgrpof2_%s_%s.html", PREFIX_HTML_FILENAME, person1_name_for_filename, person2_name_for_filename);
//        sprintf(html_file_name_webview,
//                "%sgrpof2_%s_%s_webview.html", PREFIX_HTML_FILENAME, person1_name_for_filename, person2_name_for_filename);
//
////        Ohtml_file_name = [NSString stringWithUTF8String:html_file_name ];
////        OpathToHTML = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name];
////        pathToHTML = (char *) [OpathToHTML cStringUsingEncoding:NSUTF8StringEncoding];
////        /* for use in WebView */
////        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name]];
//        
//    
//        
//        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
//        
//        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser];
//        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
//        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
//        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
//        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
//    
//        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
//        
//        //URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser]];  // for test
//        //ksn(pathToHTML_browser);
//        
//        gbl_pathToFileToBeEmailed = OpathToHTML_browser;
//
//
//        // remove all "*.html" files from TMP directory before creating new one
//        //
//        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
////        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
//        
//        for (NSString *fil in tmpDirFiles) {
////            NSLog(@"file to DELETE=%@",fil);
//            if ([fil hasSuffix: @"html"]) {
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
//            }
//        }
//        
//        
//        tn();trn("doing compatibility potential c call   mamb_report_just_2_people");
//        
//        ks(html_file_name_webview);
//        
//        retval = mamb_report_just_2_people(
//                                           pathToHTML_browser,
//                                           pathToHTML_webview,
//                                           csv_person1_string,
//                                           csv_person2_string
//                                           );
//
//        tn();trn("returning from  compatibility potential c call   mamb_report_just_2_people");
//
//



// now in tblrpts 1 (no webview show)
//        //tn();trn("returned from HTML creation");
//        //ksn(html_file_name);
//        if (retval == 0) {
//            
//            // show all files in temp dir
//            NSFileManager *manager = [NSFileManager defaultManager];
//            NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
//            for (NSString *s in fileList){
//                NSLog(@"TEMP DIR %@", s);
//            }
//
//            /* here, go and look at html report */
//            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
//            //        NSURLRequest *HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
//            //        self.outletWebView.scalesPageToFit = YES;
//            //        [self.outletWebView loadRequest: HTML_URLrequest];
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
//            // place our URL in a URL Request
//            HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML_forWebview];
//            
//            // UIWebView is part of UIKit, so you should operate on the main thread.
//            //
//            // old= [self.outletWebView loadRequest: HTML_URLrequest];
//            //
//            dispatch_async(dispatch_get_main_queue(), ^(void){
//                    [self.outletWebView loadRequest:HTML_URLrequest];
//                }
//            );
//        }
//
//    }  // [gbl_currentMenuPlusReportCode hasSuffix: @"co"]  // compatibility report  (just 2)
//


// put in ViewTBLRPTs_1_iewController
//
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"])      // My Best Match in Group ...
//        tn();trn("in REPORT  My Best Match in Group !");
//        
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//        //     [[self navigationItem] setTitle: @"Personality of       "];
//            //[[self navigationItem] setTitle: @"Best Match         ."];
//            //[[self navigationItem] setTitle: @".       Best Match       ."];
//            //[[self navigationItem] setTitle: @".                             Best Match                             ."];
//            //[[self navigationItem] setTitle: @"                              Best Match                             ."];
//            //[[self navigationItem] setTitle: @"Best Match                             ."];
//            //[[self navigationItem] setTitle: @"Best Match          ."];
////            [[self navigationItem] setTitle: @"Best Match          ."];
////              [[self navigationItem] setTitle: @"____________Best Match____________"];
//              //[[self navigationItem] setTitle: @"_____Match_____"];
//              //[[self navigationItem] setTitle: @"___Best Match___"];
//            //  [[self navigationItem] setTitle: @".  Best Match  ."];
////                [[self navigationItem] setTitle: @"Best  Match  For"];
//            [[self navigationItem] setTitle: @"Best  Match"];
//        });
//
////
//        sfill(myStringBuffForTraitCSV, 60, ' ');  // not used here in per, so blanks
//
//        // NSString object to C
//        //const char *my_psvc = [self.fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
//        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values 
//        strcpy(my_psv, my_psvc);
//        ksn(my_psv);
//        
//        strcpy(psvName, csv_get_field(my_psv, "|", 1));
//        strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
//        strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
//        strcpy(psvYear, csv_get_field(my_psv, "|", 4));
//        strcpy(psvHour, csv_get_field(my_psv, "|", 5));
//        strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
//        strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
//        strcpy(psvCity, csv_get_field(my_psv, "|", 8));
//        strcpy(psvProv, csv_get_field(my_psv, "|", 9));
//        strcpy(psvCountry, csv_get_field(my_psv, "|", 10));
//
//        ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
//        ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
//        
//        // get longitude and timezone hoursDiff from Greenwich
//        // by looking up psvCity, psvProv, psvCountry
//        //
//        seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
//        
//        strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
//        strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
//        
//        // set gbl for email
//        ksn(psvName);
//        gbl_person_name =  [NSString stringWithUTF8String:psvName ];
//
//        // build csv arg for report function call
//        //
//        sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
//                psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
//        ksn(csv_person_string);tn();
//        
//    NSLog(@"gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
//    NSLog(@"gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );
//
//        const char *tmp_grp_name_CONST;                                                       // NSString object to C str
//        char tmp_grp_name[128];                                                             // NSString object to C str
//        tmp_grp_name_CONST = [gbl_lastSelectedGroup cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
//        strcpy(tmp_grp_name, tmp_grp_name_CONST);                                           // NSString object to C str  // because of const
//        
//
//        // build HTML file name  in TMP  Directory
//        //
//        strcpy(person_name_for_filename, psvName);
//        scharswitch(person_name_for_filename, ' ', '_');
//        strcpy(group_name_for_filename, tmp_grp_name );  
//        scharswitch(group_name_for_filename, ' ', '_');
//
//        sprintf(html_file_name_browser, "%sgrpone_%s_%s.html",        PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
//        sprintf(html_file_name_webview, "%sgrpone_%s_%swebview.html", PREFIX_HTML_FILENAME, person_name_for_filename, group_name_for_filename);
//        
//        
//        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
//        gbl_html_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];   // for later viewing in webview
//
//
//        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
//        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
//        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
//        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
//        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        URLtoHTML_forWebview = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
//        
//        gbl_pathToFileToBeEmailed = OpathToHTML_browser;
//        
//        // remove all "*.html" files from TMP directory before creating new one
//        //
//        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
//        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
//        for (NSString *fil in tmpDirFiles) 
//            NSLog(@"REMOVED THIS fil=%@",fil);
//            if ([fil hasSuffix: @"html"]) {
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
//            }
//   
//        
//        tn();trn("2 HTMLs !!!!!!!!!!!!!!!!!!!!");
//        nksn(html_file_name_browser); ksn( html_file_name_webview);
//        nksn(pathToHTML_browser); ksn(pathToHTML_webview);
//        NSLog(@"Ohtml_file_name_browser=%@",Ohtml_file_name_browser);
//        NSLog(@"OpathToHTML_browser=%@",OpathToHTML_browser);
//
//        // get a C-string CSV for each member of the group into C array of C strings
//        //   but excluding  one person who is subject of grpone report "MY Best Match in Group ..." 
//        //
//        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
//
//        gbl_grp_CSVs = [myappDelegate getCarrayOfCSVsForGroup: (NSString *) gbl_lastSelectedGroup   // name has spaces
//                                      excludingThisPersonName: (NSString *) gbl_lastSelectedPerson  // non-empty string for groupOne report
//        ];
//        
////NSLog(@"gbl_grp_CSVs =%@",gbl_grp_CSVs );
//for (int kk = 0; kk <= gbl_grp_CSVs_idx; kk++) {
//ksn(gbl_grp_CSVs[kk]);
//}
//
//
////
////        retval = mamb_report_personality(     /* in perdoc.o */
////                                pathToHTML_webview,
////                                pathToHTML_browser,
////                                csv_person_string,
////                                "",  /* could be "return only csv with all trait scores",  instructions */
////                                /* this instruction arg is now ignored, because arg next, */
////                                /* myStringBuffForTraitCSV, is ALWAYS populated with trait scores */
////                                 myStringBuffForTraitCSV);
////
//
/////* ------------------------------------------- */
////#define CSV_ARRAY_MAX 512  
////char *mamb_csv_arr [CSV_ARRAY_MAX];
////int   mamb_csv_idx;
////int   mamb_csv_idx_max;
////void  mamb_csv_put(char *line, int length);
////void  mamb_csv_free(void); 
////int   is_first_mamb_csv_put;    /* 1=yes, 0=no */
////int   is_first_mamb_csv_get;    /* 1=yes, 0=no */
/////* ------------------------------------------- */
////
//
//
////
////      /* get all members of group into array 
////      *    mamb_csv_arr[mamb_csv_idx] = malloc(length + 1);
////      */
////
////      rpt5_person_in_group( 
////        group_name,
////        mamb_csv_arr,
////        num_in_grp,
////        csv_compare_everyone_with
////      );
////
////
////void rpt5_person_in_group( 
////  char *group_name,
////  char *mamb_csv_arr[],
////  int   num_in_grp,
////  char *csv_compare_everyone_with )
//// 
////  char html_file_name[256], person_name[32];
////  char group_buf[32];
////  int  retval, num_pairs_in_grp;
////
////  num_pairs_in_grp = (num_in_grp * (num_in_grp -1)) / 2;
////  char s_npig[8]; int size_NPIG;
////  sprintf(s_npig, "%d", num_pairs_in_grp);
////  size_NPIG = (int)strlen(s_npig);
////
////
////  strcpy(person_name, csv_get_field(csv_compare_everyone_with, ",", 1));
////  strcpy(group_buf, group_name);
////  scharswitch(group_buf, ' ', '_');
////  scharswitch(person_name, ' ', '_');
////  sprintf(html_file_name, "%s/%sgrpone_%s_%s.html",
////    dir_html_grpone, PREFIX_HTML_FILENAME, person_name, group_buf);
////
////  tn();trn("doing person in group ..."); ks(html_file_name);
////
////  /* Now call report function in grpdoc.c
////  * 
////  *  struct rank_report_line *out_rank_lines[MAX_IN_RANK_LINE_ARRAY];
////  *  int out_rank_idx;  * pts to current line in out_rank_lines *
////  */
////  out_rank_idx = 0;
////  retval = mamb_report_person_in_group(  /* in grpdoc.o */
////    html_file_name,      /* html_file_name */
////    group_name,          /* group_name */
////    mamb_csv_arr,        /* in_csv_person_arr[] */
////    num_in_grp,          /* num_persons_in_grp */
////    csv_compare_everyone_with,
////    out_rank_lines,      /* struct rank_report_line *out_rank_lines[]; */
////    &out_rank_idx 
////  );
////
////  if (retval != 0) {tn(); trn("non-zero retval from mamb_report_person_in_group()");}
////
////
////  /* here, display data in table in cocoa
////  */
////
////
////
////
////
//
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
//      //  @"hompbm"])     // My Best Match in Group ...
//
//


    
//    nb(100);
//    [self dismissViewControllerAnimated:YES   // this is share button view
//                             completion:NULL];
//    bn(101);

//
//        // put the Toolbar onto bottom of what color view
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.view addSubview: gbl_toolbarForwBack ];
//        });


//        // put the Toolbar onto bottom of what color view
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.view addSubview: gbl_toolbarForwBack ];
//        });

//nbn(28);
//        [self.outletWebView reload];




//- (void)webViewDidFinishLoad:(UIWebView *)theWebView
//{
//  NSLog(@"in webViewDidFinishLoad! in view HTML");
//
//        // put the Toolbar onto bottom of what color view
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.view addSubview: gbl_toolbarForwBack ];
//        });
//
////
//////  NSLog(@"self.navigationController.navigationBar.translucent=%c",self.navigationController.navigationBar.translucent);
////
////    self.navigationController.navigationBar.translucent = NO;   // webview showed up under nav bar, so this
////
////
//////    theWebView.scalesPageToFit = YES;
////
////  CGSize contentSize = theWebView.scrollView.contentSize;
////  CGSize viewSize    = theWebView.bounds.size;
////
////kdn(viewSize.width);
////kdn(contentSize.width);
////  float rw           = viewSize.width / contentSize.width;
////kdn(rw);tn();
////        rw           = contentSize.width / viewSize.width ;
////kdn(rw);tn();
////
//////  rw = 1.0;
////float rw;
////  rw = 1.33;  // left chopped
////kdn(rw);tn();
////
////  theWebView.scrollView.minimumZoomScale = rw;
////  theWebView.scrollView.maximumZoomScale = rw;
////  theWebView.scrollView.zoomScale        = rw;  
////
//////  [[theWebView scrollView] setContentInset:UIEdgeInsetsMake(64, 0, 44, 0)];
//////  [[theWebView scrollView] setContentInset:UIEdgeInsetsMake(100, 100, 200, 200)];
//////  [[theWebView scrollView] setContentInset:UIEdgeInsetsMake(0, 200, 0, 0)];
//////  [[theWebView scrollView] setContentInset:UIEdgeInsetsMake(0, 64, 0, 0)];
//////  [[theWebView scrollView] setContentInset:UIEdgeInsetsMake(0, 128, 0, 0)];
////
////  [[theWebView scrollView] setContentInset:UIEdgeInsetsMake( 600.0, 128.0, 0.0, 0.0)];  // top, left,bot,right
////
//////webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset;
////  theWebView.scrollView.scrollIndicatorInsets = theWebView.scrollView.contentInset;
////
////
//
//}
//

//<.>
//NSString *urlAddress = @"http://dl.dropbox.com/u/50941418/2-build.html";
//NSURL *url = [NSURL URLWithString:urlAddress];
//
//NSString *html = [NSString stringWithContentsOfURL:url encoding:[NSString defaultCStringEncoding] error:nil];
//NSRange range = [html rangeOfString:@"<body"];
//
//if(range.location != NSNotFound) {
//    // Adjust style for mobile
//    float inset = 40;
//    NSString *style = [NSString stringWithFormat:@"<style>div {max-width: %fpx;}</style>",
//        self.view.bounds.size.width - inset
//    ];
//    html = [NSString stringWithFormat:@"%@%@%@",
//        [html substringToIndex:range.location],
//        style,
//        [html substringFromIndex:range.location]
//   ];
//}
//
//[webView loadHTMLString:html baseURL:url];
//
//<.>
//


//
//- (BOOL)webView:(UIWebView*)wv
//shouldStartLoadWithRequest:(NSURLRequest*)request
//navigationType:(UIWebViewNavigationType)navigationType {
//
//NSString *tempURLString = request.URL.absoluteString;
//
//if([tempURLString rangeOfString:@"about:blank"].location == NSNotFound)
//{
//wv.scalesPageToFit = YES;
//}
//else
//{
//wv.scalesPageToFit = NO;
//}
//
////[loadingIndicator startAnimating];
//return YES;
//}
//
//


// -(void)webViewDidStartLoad:(UIWebView *)webView

