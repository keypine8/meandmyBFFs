//
//  MAMB09_viewHTMLViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-11-19.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

// #import "incocoa.h"

@interface MAMB09_viewHTMLViewController ()

@end

@implementation MAMB09_viewHTMLViewController

// UIWebView loads really slow (2 sec) the first time it loads after starting the App
// Therefore move the tableview highlight here
//
// -(void)webViewDidStartLoad:(UIWebView *)webView{
// }

// extern int gbl_num_elements_array_coun = sizeof(array_coun) / sizeof(array_coun[0]);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"in viewHTML viewDidLoad!");
    


    char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
    const char *my_psvc; // psv=pipe-separated values
    char my_psv[128];
    
    char csv_person_string[128], csv_person1_string[128], csv_person2_string[128];
    char person_name_for_filename[32], person1_name_for_filename[32], person2_name_for_filename[32];
    char stringBuffForTraitCSV[64];
    
    char  yyyy_todo[16], stringBuffForStressScore[64] ;
    const char *yyyy_todoC;
    int retval, retval2;

    char   html_file_name_browser[2048], html_file_name_webview[2048];
    NSString *Ohtml_file_name_browser, *Ohtml_file_name_webview;
    NSString *OpathToHTML_browser,     *OpathToHTML_webview;
    char     *pathToHTML_browser,      *pathToHTML_webview;
    
    NSURL *URLtoHTML;
    NSURLRequest *HTML_URLrequest;
    NSArray* tmpDirFiles;
    
    fopen_fpdb_for_debug();

    //NSLog(@"fromHomeCurrentSelectionPSV=%@",self.fromHomeCurrentSelectionPSV);            // PSV  for per or grp or pair of people
    NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);            // PSV  for per or grp or pair of people
    
    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);    // like "group" or "person" or "pair"
    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);                  // like "group" or "person"
    
    NSLog(@"gbl_fromSelRptRowPSV=%@", gbl_fromSelRptRowPSV);
    NSLog(@"fromSelRpt  gbl_fromSelRptRowString=%@",gbl_fromSelRptRowString);

    // e.g.  fromHomeCurrentSelectionPSV= @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States|"
    //
    // passed to mamb_report_personality() as "evelyn,2,28,1944,7,30,1,5,79.22"  5=timezonediff 79=long
    //
    //   later:  calc_chart(pINMN,pINDY,pINYR,pINHR,pINMU,pINAP,pINTZ,pINLN,pINLT);  (pINLT always 0.0)
    //<.>
    if ([gbl_fromSelRptRowString hasPrefix: @"Personality"]) {  // call Personality HTML report
        trn("in personality");
        
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        //     [[self navigationItem] setTitle: @"Personality of       "];
            [[self navigationItem] setTitle: @"Personality       "];
        });

        sfill(stringBuffForTraitCSV, 60, ' ');  // not used here in per, so blanks

        // NSString object to C
        //const char *my_psvc = [self.fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
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
        
        URLtoHTML = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
        
        gbl_pathToFileToBeEmailed = OpathToHTML_browser;
        
        // remove all "*.html" files from TMP directory before creating new one
        //
        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
                for (NSString *fil in tmpDirFiles) {
            NSLog(@"fil=%@",fil);
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
                                 stringBuffForTraitCSV);
        if (retval == 0) {
           
            // show all files in temp dir
            NSFileManager *manager = [NSFileManager defaultManager];
            NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
            for (NSString *s in fileList){
                NSLog(@"TEMP DIR %@", s);
            }
            
            
             /* here, go and look at html report */
             // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
             
             self.outletWebView.scalesPageToFit = YES;
             
             // place our URL in a URL Request
             HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML];
             
             // UIWebView is part of UIKit, so you should operate on the main thread.
             //
             // old= [self.outletWebView loadRequest: HTML_URLrequest];
             //
             dispatch_async(dispatch_get_main_queue(), ^(void){
                 [self.outletWebView loadRequest:HTML_URLrequest];
             });
        }

    } // Personality

    
    
    if ([gbl_fromSelRptRowString hasPrefix: @"Calendar Year"]) {  // call Calendar Year HTML report
        tn();trn("in calendar year!");
        
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        [[self navigationItem] setTitle: [NSString stringWithFormat: @"Calendar Year  %@  ", gbl_selectedYear]];
        // [[self navigationItem] setTitle: [NSString stringWithFormat: @"%@", gbl_selectedYear]];
        });

        sfill(stringBuffForStressScore, 60, ' ');
        
        // yyyy from the year picker
        // NSLog(@"gbl_selectedYear 3=%@",gbl_selectedYear);

        yyyy_todoC = [gbl_selectedYear cStringUsingEncoding:NSUTF8StringEncoding];
        strcpy(yyyy_todo, yyyy_todoC);
        // ksn(yyyy_todo);
        
        // NSLog(@"in view HTML for cal yr  gbl_arrayPer=%@",gbl_arrayPer);

        
        // NSString object to C
        //const char *my_psvc = [self.fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // psv=pipe-separated values
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
        
        // build csv arg for report function call
        //
        sprintf(csv_person_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
        
        // build HTML file name  TMP  Directory
        //
        strcpy(person_name_for_filename, psvName);
        scharswitch(person_name_for_filename, ' ', '_');
        sprintf(html_file_name_browser, "%syr%s_%s.html",          PREFIX_HTML_FILENAME, yyyy_todo, person_name_for_filename);
        sprintf(html_file_name_webview, "%syr%s_%s_webview.html",  PREFIX_HTML_FILENAME, yyyy_todo, person_name_for_filename);

//        Ohtml_file_name = [NSString stringWithUTF8String:html_file_name ];
//        OpathToHTML = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name];
//        pathToHTML = (char *) [OpathToHTML cStringUsingEncoding:NSUTF8StringEncoding];
//        /* for use in WebView */
//        URLtoHTML = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name]];
    
        
        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
        
        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];
        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
        
        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
        
        URLtoHTML = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
        
        gbl_pathToFileToBeEmailed = OpathToHTML_browser;

        
        // remove all "*.html" files from TMP directory before creating new one
        //
        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
        
        for (NSString *fil in tmpDirFiles) {
            NSLog(@"file to DELETE=%@",fil);
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
        retval2 = mamb_BIGreport_year_in_the_life (    // big html for non webview
                                               pathToHTML_browser,
                                               csv_person_string,
                                               yyyy_todo,
                                               "",          /* char *instructions,    like  "return only year stress score" */
                                               stringBuffForStressScore   /* char *stringBuffForStressScore */
                                               );
        if (retval == 0 && retval2 == 0) {

            /* here, go and look at html report */
            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
            //        NSURLRequest *HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML];
            //        self.outletWebView.scalesPageToFit = YES;
            //        [self.outletWebView loadRequest: HTML_URLrequest];
            
            /* here, go and look at html report */
            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
            
            self.outletWebView.scalesPageToFit = YES;
            
            // place our URL in a URL Request
            HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML];
            
            // UIWebView is part of UIKit, so you should operate on the main thread.
            //
            // old= [self.outletWebView loadRequest: HTML_URLrequest];
            //
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.outletWebView loadRequest:HTML_URLrequest];
            });
        }
    } // Calendar Year

    //<.>
    
    if ([gbl_fromSelRptRowString hasPrefix: @"Compatibility Paired with"]) {  // call Calendar Year HTML report
        tn();trn("in Compatibility Potential!");
        
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [[self navigationItem] setTitle: @"Compatibility Potential\011"];
        });

        do { // assemble person1 CSV
            my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C
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
            
            strcpy(person1_name_for_filename, psvName);
            scharswitch(person1_name_for_filename, ' ', '_');

            //ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
            //ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
            
            // get longitude and timezone hoursDiff from Greenwich
            // by looking up psvCity, psvProv, psvCountry
            //
            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
            
            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
            
            // build csv arg for report function call
            //
            sprintf(csv_person1_string, "%s,%s,%s,%s,%s,%s,%s,%s,%s",
                    psvName,psvMth,psvDay,psvYear,psvHour,psvMin,psvAmPm,psvHoursDiff,psvLongitude);
            ksn(csv_person1_string);tn();

        } while (NO);  // assemble person1 CSV   (do only once)
        
        do { // assemble person2 CSV
            my_psvc = [gbl_fromSelRptRowPSV cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C
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
            
            //  ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
            //ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
            
            // get longitude and timezone hoursDiff from Greenwich
            // by looking up psvCity, psvProv, psvCountry
            //
            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
            
            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
            
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
//        URLtoHTML = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name]];
        
    
        
        gbl_html_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser ];   // for later sending as email attachment
        
        Ohtml_file_name_browser = [NSString stringWithUTF8String:html_file_name_browser];
        OpathToHTML_browser     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser];
        pathToHTML_browser      = (char *) [OpathToHTML_browser cStringUsingEncoding:NSUTF8StringEncoding];
        
        Ohtml_file_name_webview = [NSString stringWithUTF8String:html_file_name_webview ];
        OpathToHTML_webview     = [NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview];
        pathToHTML_webview      = (char *) [OpathToHTML_webview cStringUsingEncoding:NSUTF8StringEncoding];
    
        URLtoHTML = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_webview]];
        
        //URLtoHTML = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: Ohtml_file_name_browser]];  // for test
        //ksn(pathToHTML_browser);
        
        gbl_pathToFileToBeEmailed = OpathToHTML_browser;


        // remove all "*.html" files from TMP directory before creating new one
        //
        tmpDirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
        NSLog(@"tmpDirFiles.count=%lu",(unsigned long)tmpDirFiles.count);
        
        for (NSString *fil in tmpDirFiles) {
            NSLog(@"file to DELETE=%@",fil);
            if ([fil hasSuffix: @"html"]) {
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error:NULL];
            }
        }
        
        
        tn();trn("doing compatibility potential c call ");
        
        ks(html_file_name_webview);
        
        retval = mamb_report_just_2_people(
                                           pathToHTML_browser,
                                           pathToHTML_webview,
                                           csv_person1_string,
                                           csv_person2_string
                                           );

        //tn();trn("returned from HTML creation");
        //ksn(html_file_name);
        if (retval == 0) {
            
            // show all files in temp dir
            NSFileManager *manager = [NSFileManager defaultManager];
            NSArray *fileList = [manager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
            for (NSString *s in fileList){
                NSLog(@"TEMP DIR %@", s);
            }

            /* here, go and look at html report */
            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
            //        NSURLRequest *HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML];
            //        self.outletWebView.scalesPageToFit = YES;
            //        [self.outletWebView loadRequest: HTML_URLrequest];
            
            /* here, go and look at html report */
            // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];  // ?clean for re-use
            
            self.outletWebView.scalesPageToFit = YES;
            
            // place our URL in a URL Request
            HTML_URLrequest = [[NSURLRequest alloc] initWithURL: URLtoHTML];
            
            // UIWebView is part of UIKit, so you should operate on the main thread.
            //
            // old= [self.outletWebView loadRequest: HTML_URLrequest];
            //
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.outletWebView loadRequest:HTML_URLrequest];
            }
                           );
        }
    } // Compatibility Potential
    
    
} // viewDidLoad

// -(void)webViewDidStartLoad:(UIWebView *)webView{

// ==============   start of email stuff  ====================
- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                    target:self
                                    action:@selector(shareButtonAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

-(void)shareButtonAction:(id)sender
{
    NSLog(@"shareButtonAction!");
    
    // Determine the file name and extension
    // NSArray *filepart = [gbl_pathToFileToBeEmailed componentsSeparatedByString:@"."];
    NSArray *fileparts = [gbl_pathToFileToBeEmailed componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"./"]];
    
    NSString *baseFilename = [fileparts objectAtIndex: (fileparts.count -2)] ;  // count -1 is last in array
    NSString *extension = [fileparts lastObject];
    NSString *filenameForAttachment = [NSString stringWithFormat: @"%@.%@", baseFilename, extension];
    
    // Get the resource path and read the file using NSData
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *HTMLfileData = [NSData dataWithContentsOfFile:gbl_pathToFileToBeEmailed ];
    
    NSString *emailTitle = [NSString stringWithFormat: @"%@  from \"Me and my BFFs\"", filenameForAttachment];
    
    // NSString *myEmailMessage = @"Please see attached HTML file from Me and my BFFs,\nan iPhone App by Funnest Astrology Inc.\n\n\n\n\n--------------";
    // NSString *myEmailMessage = @"Please see attached report created with \n iPhone App \"Me and my BFFs\".\n\n\n\n\n--------------";
    // NSString *myEmailMessage = @"iPhone App \"Me and my BFFs\" created the attached report.\n\n\n\n\n--------------";
    // NSString *myEmailMessage = [NSString stringWithFormat: @"iPhone App \"Me and my BFFs\" created %@.%@", baseFilename, extension];
    NSString *myEmailMessage = [NSString stringWithFormat: @"\n\n\n\n\n----- iPhone App \"Me and my BFFs\" created %@.%@ -----", baseFilename, extension];
    
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
        MFMailComposeViewController *myMailComposeViewController = [[MFMailComposeViewController alloc] init];
        NSLog(@"This device CAN send email");

         myMailComposeViewController.mailComposeDelegate = self;
        [myMailComposeViewController setSubject:emailTitle];
        [myMailComposeViewController setMessageBody:myEmailMessage
                                             isHTML:NO];
        [myMailComposeViewController setToRecipients:toRecipients];
        [myMailComposeViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [myMailComposeViewController addAttachmentData: HTMLfileData                // Add attachment
                                              mimeType: mimeType
                                              fileName: filenameForAttachment];
        
        // Present mail view controller on screen
        [self presentViewController:myMailComposeViewController animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cannot send email"
                                                        message: @"Maybe email on this device is not set up."
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
} // shareButtonAction


- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    if (error) {
        UIAlertView *myalert = [[UIAlertView alloc] initWithTitle: @"An error happened"
                                                          message: [error localizedDescription]
                                                         delegate: nil
                                                cancelButtonTitle: @"cancel"
                                                otherButtonTitles: nil, nil];
        [myalert show];

        // [self dismissViewControllerAnimated:yes completion:<#^(void)completion#>];
        [self dismissViewControllerAnimated: YES
                                 completion:NULL];
    }
    switch (result)
    {
        case MFMailComposeResultCancelled: {
            NSLog(@"Mail cancelled");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail send was cancelled"
                                                            message: @""
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            break;
        }
        case MFMailComposeResultSaved: {
            NSLog(@"Mail saved");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail was saved"
                                                            message: @""
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            break;
        }
        case MFMailComposeResultSent: {
            NSLog(@"Mail sent");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mail was sent"
                                                            message: @""
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed: {
            NSLog(@"Mail send failure: %@", [error localizedDescription]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Failure of mail send"
                                                            message: [error localizedDescription]
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            break;
        }
        default: { break; }
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}
// ==============   END of email stuff  ====================


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
//    <.>
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
//        } else {
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
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The App received an Memory Warning"
                                                    message: @"The system has determined that the \namount of available memory is very low."
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // segueRptSelToViewHTML
}


@end
