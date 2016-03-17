//
//  MAMB09_selDateViewController2.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-02-08.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

// WEIRD  had to ADD CONSTRAINTS to prevent label and pickerview from centering after
//          doing a best match in group    // NOTE: SAME THING in MAMB09_selYearViewController2.m
// from this : https://developer.apple.com/library/ios/recipes/xcode_help-IB_auto_layout/chapters/add_constraints-control_drag.html
//
        // Control-drag vertically to set a vertical constraint,
        // and Control-drag horizontally to set a horizontal constraint.
        // To add constraints along both axes, Control-drag diagonally.
        // When a constraint can be added between the item you’re dragging from
        // and the item you're dragging to, the destination item becomes highlighted in blue.
        // 
        //Choose a constraint from the shortcut menu that appears. Clicking a constraint dismisses the shortcut menu.
        // 
        // ALWAYS PICK THIS MENU ITEM ===>   "top space to top layout guide"
//
// END oF   WEIRD  had to add constraints to prevent label and pickerview from centering after


#import "MAMB09_selDateViewController2.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


@implementation MAMB09_selDateViewController2


- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();
    trn("in viewDidLoad in MAMB09_selYearDATEController   seldate    seldate    seldate    seldate   seldate  ");
  NSLog(@"gbl_currentMenuPlusReportCode=%@",gbl_currentMenuPlusReportCode);


//    self.view.backgroundColor = gbl_colorSelParamForReports;
    if ([gbl_lastSelectionType isEqualToString:@"person"]) [self.view setBackgroundColor: gbl_colorHomeBG_per];
    if ([gbl_lastSelectionType isEqualToString:@"group" ]) [self.view setBackgroundColor: gbl_colorHomeBG_grp];


    self.outletFor_YMD_picker.delegate   = self;
    self.outletFor_YMD_picker.dataSource = self;
    

//
//// try to reduce size of pickerview
////    CGSize pickerSize = [pickerView sizeThatFits:CGSizeZero];
//    CGSize pickerSize = [self.outletFor_YMD_picker sizeThatFits: CGSizeZero];
//
////    UIView *pickerTransformView = [[UIView alloc] init];  
////    UIView *pickerTransformView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 55, 44)];  // 3rd arg is horizontal length
//
//    UIView *pickerTransformView;
////    pickerTransformView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, pickerSize.width, pickerSize.height)];
//    pickerTransformView = [[UIView alloc] initWithFrame: CGRectMake(50.0f, 600.0f, pickerSize.width, pickerSize.height)];
//    pickerTransformView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
//
////    [pickerTransformView addSubview: pickerView];
////    [self.view addSubview: pickerTransformView];
////    [self.outletFor_YMD_picker addSubView: pickerTransformView  ];
//
//    [pickerTransformView addSubview: self.outletFor_YMD_picker ];
//    [self.view addSubview: pickerTransformView];
//





    //UIBarButtonItem *_goToReportButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ReportArrow_06.png"] 

//    UIBarButtonItem *_goToReportButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"rounded_rectB_144"] 
//    UIBarButtonItem *_goToReportButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ReportArrow_09.png"] 
    //UIImage *myImage = [[UIImage imageNamed: @"ReportArrow_09.png"]
    //UIImage *myImage = [[UIImage imageNamed: @"rounded_rectB_144.png"]
    //UIImage *myImage = [[UIImage imageNamed: @"ReportArrow_11.png"]
    //UIImage *myImage = [[UIImage imageNamed: @"ReportArrow_12.png"]

    // set up navigation bar  right button  "Report >"
    //
//        UIImage *myImage = [[UIImage imageNamed: @"ReportArrow_14.png"]
//                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];
//        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_64.png"]
//        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_96.png"]
//        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_80.png"]


 
    // UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_029.png"]
    // UIImage *myImage = [[UIImage imageNamed: @"iconLeftArrowBlue_66"]
    //                     imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

// for test
//        UIImage *myImage = [[UIImage imageNamed: @"iconPlusAddGreenBig_66.png"]
//        UIImage *myImage = [[UIImage imageNamed: @"iconMinusDelRedBig_66.png"]
//                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

//                         imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];

////        UIImage *myImage = [[UIImage imageNamed: @"iconMinusDel_66.png"]
////                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];
//                         imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
//
//        // put UIImage in a UIImageView and adjust color with tintColor
//        UIImageView *myImageView = [[UIImageView alloc]initWithImage: myImage];
//        myImageView.tintColor = [UIColor blueColor];
//
////        myImage.tintColor = [UIColor greenColor];  // all green
//
//

//        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_01.png"]
//        UIImage *myImage = [UIImage imageNamed: @"forwardArrow_01.png" inBundle: nil compatibleWithTraitCollection: nil ];

//     UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_029.png"]
//     UIImage *myImage = [[UIImage imageNamed: @"iconLeftArrowBlue_66"]
     UIImage *myImage = [[UIImage imageNamed: @"iconChevronRight_66"]
                      imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

//        UIBarButtonItem *_goToReportButton = [[UIBarButtonItem alloc]initWithImage: gbl_chevronRight
        UIBarButtonItem *_goToReportButton = [[UIBarButtonItem alloc]initWithImage: myImage
                                                                             style: UIBarButtonItemStylePlain 
                                                                            target: self 
                                                                            action: @selector(actionGoToReport)];


//        self.navigationItem.rightBarButtonItem = _goToReportButton;  done below
    //
    // end of set up navigation bar  right button  "Report >"



    // set up label for  self.navigationItem.titleView 
    //
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

    UILabel *mySelDate_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

    NSString *myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nSelect Day", gbl_lastSelectedPerson ];

    mySelDate_Label.numberOfLines = 2;
//        mySelDate_Label.font          = [UIFont boldSystemFontOfSize: 16.0];
    mySelDate_Label.font          = [UIFont boldSystemFontOfSize: 14.0];
    mySelDate_Label.textColor     = [UIColor blackColor];
    mySelDate_Label.textAlignment = NSTextAlignmentCenter; 
    mySelDate_Label.text          = myNavBar2lineTitle;
    mySelDate_Label.adjustsFontSizeToFitWidth = YES;
    [mySelDate_Label sizeToFit];


    // TWO-LINE NAV BAR TITLE
    //
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        self.navigationItem.rightBarButtonItem = _goToReportButton;
        self.navigationItem.titleView           = mySelDate_Label; // mySelDate_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
        [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, 0, -2.0, 0)];  // lower > a bit
    });



    self.arrayMonths      = [[NSArray alloc]
        initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.arrayDaysOfMonth = [[NSMutableArray alloc]init];
    //self.arrayYears       = [[NSMutableArray alloc]init];
 
    for (int i = 1; i <= 31; i++) {
        [self.arrayDaysOfMonth addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    //NSLog(@"self.arrayMonths=%@",self.arrayMonths);




    // MOVED to viewWillAppear populate date-related stuff




// old using uidatepicker
//    [self.outletToDatePicker  addTarget:self
//                                 action:@selector(datePickerChanged:)
//                       forControlEvents:UIControlEventValueChanged];
//


} // viewDidLoad


- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()  in  selDate! ");


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
    // copied from viewDidLoad

    // populate date-related stuff   MOVED from  viewDidLoad
    do {    // populate array yearsToPickFrom2 for uiPickerView and init picker and init calendar year text field  (130 lines)
 


        // get the current yr, mn, da
        //

        // here ASSUME the current year, mth, day have been continuously updated by these
        //   1.  app startup
        //       - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
        //   2.  time change notification
        //    - (void) doStuffOnSignificantTimeChange   // for   UIApplicationSignificantTimeChangeNotification
        //
        // Both 1. and 2. call method gcy which updates current y,m,d  in allpeople record
        //
        // THEREFORE  rely on value in allpeople record, like this -
        gbl_currentYearInt  = [gbl_cy_currentAllPeople intValue];
        gbl_currentMonthInt = [gbl_cm_currentAllPeople intValue];
        gbl_currentDayInt   = [gbl_cd_currentAllPeople intValue];



//        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time
//       //         NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
//        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear)
//
//                                                        fromDate:[NSDate date]];
//        gbl_currentYearInt  = [dateComponents year];
//        gbl_currentMonthInt = [dateComponents month];
//        gbl_currentDayInt   = [dateComponents day];
//        //NSLog(@"gbl_currentYearInt  =%ld",(long)gbl_currentYearInt  );
//        //NSLog(@"gbl_currentMonthInt =%ld",(long)gbl_currentMonthInt );
//        //NSLog(@"gbl_currentDayInt   =%ld",(long)gbl_currentDayInt   );
        

//        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
//        [myappDelegate gcy ];  // get real current year , month, day

//
////        if (gbl_cy_apl == nil  &&  gbl_cy_goo == nil) {
//        if (gbl_cy_apl == nil) {
//            gbl_currentYearInt  = [gbl_cy_currentAllPeople intValue];
//            gbl_currentMonthInt = [gbl_cm_currentAllPeople intValue];
//            gbl_currentDayInt   = [gbl_cd_currentAllPeople intValue];
//
//        } else {
//            gbl_currentYearInt  = [gbl_cy_apl intValue];
//            gbl_currentMonthInt = [gbl_cm_apl intValue];
//            gbl_currentDayInt   = [gbl_cd_apl intValue];
//        }

//            if (gbl_cy_apl != nil) {
//            } else {
//                if (gbl_cy_goo != nil) {
//                    gbl_currentYearInt  = [gbl_cy_goo intValue];
//                    gbl_currentMonthInt = [gbl_cm_goo intValue];
//                    gbl_currentDayInt   = [gbl_cd_goo intValue];
//                }
//            }
//        }
        

        
        gbl_currentDay_yyyymmdd = [NSString stringWithFormat: @"%04ld%02ld%02ld",
                                       (long)gbl_currentYearInt,
                                       (long)gbl_currentMonthInt,
                                       (long)gbl_currentDayInt     ];

        
        



        NSArray *psvArray;
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]  ) {
//            NSArray *psvArray =
            psvArray =
              [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]  ) {
//            NSArray *psvArray =
            psvArray =
              [gbl_TBLRPTS1_PSV_personJust1 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        }

        // name now in nav bar title
        //        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        //            self.outletPersonName.text       = psvArray[0];
        //        });
        //
        
        NSString *psvMonthOfBirth = psvArray[1];
        NSString *psvDayOfBirth   = psvArray[2];
        NSString *psvYearOfBirth  = psvArray[3];

        gbl_intBirthYear       = [psvYearOfBirth intValue];  // convert NSString to integer
        gbl_intBirthMonth      = [psvMonthOfBirth intValue];
        gbl_intBirthDayOfMonth = [psvDayOfBirth intValue]; 
        //NSLog(@"gbl_intBirthYear       =%ld",(long)gbl_intBirthYear       );
        //NSLog(@"gbl_intBirthMonth      =%ld",(long)gbl_intBirthMonth      );
        //NSLog(@"gbl_intBirthDayOfMonth =%ld",(long)gbl_intBirthDayOfMonth );
        

        // for the picker, set yearsToPickFrom2 str array
        //
        [yearsToPickFrom2 removeAllObjects];
        yearsToPickFrom2   = [[NSMutableArray alloc] init];
        
        // not birthday (privacy)
        //for (NSInteger pickyr = gbl_intBirthYear; pickyr <=  gbl_currentYearInt + 1; pickyr++)   // only allow to go to next calendar year
        for (NSInteger pickyr = gbl_earliestYear; pickyr <=  gbl_currentYearInt + 1; pickyr++) {  // only allow to go to next calendar year
            [yearsToPickFrom2 addObject: [@(pickyr) stringValue] ];
        }
        //NSLog(@"yearsToPickFrom2.count=%lu",(unsigned long)yearsToPickFrom2.count);
        
        
        // INIT  outletToSelecteDate text field
        //
        // 1.  set the outletToSelecteDate field to one of
        //     a) remembered date picked, unless there is no remembered value
        //        because there isn't one yet or else at App start- in which case,
        //     b) use today's date
        //
        // 2.  set the Picker's selected row to a) or b)
        //

        // get remembered date, if present
        //
        NSString *psvRememberedDate;   // "yyyymmdd"

        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m


        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]  ) {
            psvRememberedDate = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"person"
                                                                    havingName: (NSString *) gbl_fromHomeCurrentEntityName 
                                                          fromRememberCategory: (NSString *) @"day"  ];
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]  ) {
            psvRememberedDate = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"group"
                                                                    havingName: (NSString *) gbl_lastSelectedGroup 
                                                          fromRememberCategory: (NSString *) @"day"  ];
        }


        NSLog(@"gbl_fromHomeCurrentEntityName =%@",gbl_fromHomeCurrentEntityName );
        NSLog(@"psvRememberedDate=%@", psvRememberedDate);


        // for initial date, get c integer forms for yyyy, mm, dd
        //
tn();
            int initYYYY,  initMM,  initDD;  // initMM and initDD are "one-based" real m and d values
            if (psvRememberedDate == NULL || [psvRememberedDate intValue] == 0) {

                initYYYY = (int) gbl_currentYearInt;   // use  today's date if no remembered date
kin(initYYYY);
                initMM   = (int) gbl_currentMonthInt;
                initDD   = (int) gbl_currentDayInt;
                gbl_lastSelectedDay         = [NSString stringWithFormat:@"%04ld%02ld%02ld",
                                                (long)gbl_currentYearInt,
                                                (long)gbl_currentMonthInt,
                                                (long)gbl_currentDayInt     ];  // yyyymmdd
            } else {   

                gbl_lastSelectedDay         =  psvRememberedDate;   // yyyymmdd
  NSLog(@"psvRememberedDate=[%@]",psvRememberedDate);
                NSString *lastSelectedYear  = [psvRememberedDate substringWithRange:NSMakeRange(0, 4)];
  NSLog(@"lastSelectedYear  =[%@]",lastSelectedYear  );
                NSString *lastSelectedMonth = [psvRememberedDate substringWithRange:NSMakeRange(4, 2)];
                NSString *lastSelectedDay   = [psvRememberedDate substringWithRange:NSMakeRange(6, 2)];
                initYYYY = [lastSelectedYear  intValue];
kin(initYYYY);
                initMM   = [lastSelectedMonth intValue];
                initDD   = [lastSelectedDay   intValue];

                //                NSLog(@"lastSelectedYear  =%@",lastSelectedYear  );
                //                NSLog(@"lastSelectedMonth =%@",lastSelectedMonth );
                //                NSLog(@"lastSelectedDay   =%@",lastSelectedDay   );
            }
            // initMM and initDD are "one-based" real m and d values


        const char *monthC_CONST;    
        monthC_CONST = [self.arrayMonths[initMM - 1] cStringUsingEncoding:NSUTF8StringEncoding];  // convert NSString to c string
        char   monthCstring[16];
        strcpy(monthCstring, monthC_CONST);                                                      // convert NSString to c string  fmt "Jan"


        // get day of week for screen
        //
        char *N3_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""};
        int my_day_of_week_idx;
        my_day_of_week_idx = day_of_week(initMM, initDD, initYYYY);

        char    cStringDateFormatted[64];
        sprintf(cStringDateFormatted, "%s  %s %02d, %04d",
            N3_day_of_week[my_day_of_week_idx],
            monthCstring,
            initDD,
            initYYYY);            // like "Wed  Dec 07,  1943"
        NSString *myInitDateFormatted =  [NSString stringWithUTF8String: cStringDateFormatted];  // convert c string to NSString
  NSLog(@"myInitDateFormatted =%@",myInitDateFormatted );
        gbl_lastSelectedDayFormattedForEmail = myInitDateFormatted;  // save for email format


        char    cStringDateFormatted2[64];
        sprintf(cStringDateFormatted2, "%s %02d, %04d",
            monthCstring,
            initDD,
            initYYYY);            // like "Dec 07,  1943"
        NSString *myInitDateFormatted2 =  [NSString stringWithUTF8String: cStringDateFormatted2];  // convert c string to NSString
tn();tr("date fmt  date fmt  date fmt  date fmt  date fmt  date fmt  date fmt  ");
  NSLog(@"myInitDateFormatted2 =%@",myInitDateFormatted2 );
        gbl_lastSelectedDayFormattedForTitle = myInitDateFormatted2;  // save for email format
  NSLog(@"gbl_lastSelectedDayFormattedForTitle =%@",gbl_lastSelectedDayFormattedForTitle );



        //        // Here is a short list of sample formats using ICU:
        //        // -------------------------------------------------------------------------
        //        // Pattern                           Result (in a particular locale)
        //        // -------------------------------------------------------------------------
        //        // yyyy.MM.dd G 'at' HH:mm:ss zzz    1996.07.10 AD at 15:08:56 PDT
        //        // EEE, MMM d, ''yy                  Wed, July 10, '96
        //        // h:mm a                            12:08 PM
        //        // hh 'o''clock' a, zzzz             12 o'clock PM, Pacific Daylight Time
        //        // K:mm a, z                         0:00 PM, PST
        //        // yyyyy.MMMM.dd GGG hh:mm aaa       01996.July.10 AD 12:08 PM
        //        // -------------------------------------------------------------------------
        //        // The format specifiers are quite straightforward, Y = year, M = month, etc.
        //        // Changing the number of specifiers for a field, changes the output.
        //        // For example, MMMM generates the full month name “November”,
        //        // MMM results in “Nov” and MM outputs “11”.
        //        // 
        //        NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
        //        [myFormatter setDateFormat:@"MMM dd, yyyy"];
        //        NSString *yearString = [myFormatter stringFromDate:[NSDate date]];
        //

        UIFont *myFontForDate;
        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            myFontForDate = [UIFont boldSystemFontOfSize: 30.0];
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            myFontForDate = [UIFont boldSystemFontOfSize: 24.0];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            myFontForDate = [UIFont boldSystemFontOfSize: 21.0];
        }


        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.outletToSelecteDate.text = myInitDateFormatted;

            if ([gbl_lastSelectionType isEqualToString:@"person"]) {
                NSMutableAttributedString *myAttrDate;
                myAttrDate = [[NSMutableAttributedString alloc] initWithString: myInitDateFormatted
                    attributes : @{
        //                  NSParagraphStyleAttributeName : myParagraphStyle,
        //                   NSBackgroundColorAttributeName : gbl_color_cRed,
        //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                       NSForegroundColorAttributeName : [UIColor grayColor],
//                                  NSFontAttributeName : [UIFont boldSystemFontOfSize: 30.0]
                                  NSFontAttributeName : myFontForDate
                    }
                ];
                self.outletToSelecteDate.attributedText = myAttrDate;
            }
            if ([gbl_lastSelectionType isEqualToString:@"group" ]) {
                NSMutableAttributedString *myAttrDate;
                myAttrDate = [[NSMutableAttributedString alloc] initWithString: myInitDateFormatted
                    attributes : @{
        //                  NSParagraphStyleAttributeName : myParagraphStyle,
        //                   NSBackgroundColorAttributeName : gbl_color_cRed,
        //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                       NSForegroundColorAttributeName : [UIColor darkGrayColor],
//                                  NSFontAttributeName : [UIFont boldSystemFontOfSize: 30.0]
                                  NSFontAttributeName : myFontForDate
                    }
                ];
                self.outletToSelecteDate.attributedText = myAttrDate;
            }

        });

        
        // 2. INIT  PICKER roller values
        //    in picker set the rollers to gbl_lastSelectedDay
        //    find out the rownumber of gbl_lastSelectedDay yyyymmdd  in yearToPickFrom2
        //
        NSInteger myIndex;
        myIndex = initMM - 1; // initMM and initDD are "one-based" real m and d values
        if (myIndex == NSNotFound) {
            // second last elt should be current year
            myIndex = 0;
        }
//        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 0 animated:YES]; // This is how you manually SET(!!) a selection!
        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!

        myIndex = initDD - 1; // initMM and initDD are "one-based" real m and d values
        if (myIndex == NSNotFound) {
            // second last elt should be current year
            myIndex = 0;
        }
//        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 2 animated:YES]; // This is how you manually SET(!!) a selection!

kin(initYYYY);
        NSString* myInitYear = [NSString stringWithFormat:@"%i", initYYYY];  // convert c int to NSString
  NSLog(@"myInitYear =[%@]",myInitYear );
        myIndex = [yearsToPickFrom2 indexOfObject: myInitYear];
  NSLog(@"myIndex =[%ld]",(long)myIndex );
        if (myIndex == NSNotFound) {
            // second last elt should be current year
            myIndex = yearsToPickFrom2.count - 2;
        }
  NSLog(@"myIndex =[%ld]",(long)myIndex );
//        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 2 animated:YES]; // This is how you manually SET(!!) a selection!
//        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 3 animated:YES]; // This is how you manually SET(!!) a selection!

nbn(4);
//        [self.outletFor_YMD_picker selectRow: 0 inComponent: 4 animated:YES]; // This is how you manually SET(!!) a selection!
//nbn(5);
        [self.outletFor_YMD_picker reloadAllComponents];

        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 3 animated:YES]; // This is how you manually SET(!!) a selection!


        // save initial settings for gbl_rollerLast_*
        //
        char cString_yyyy[16]; sprintf(cString_yyyy, "%04d", initYYYY);
        //char cString_mm[16];   sprintf(cString_mm,   "%04d", initMM);
        char cString_dd[16];   sprintf(cString_dd,   "%02d", initDD);

        gbl_rollerLast_yyyy = [NSString stringWithUTF8String: cString_yyyy];  // convert c string to NSString
        gbl_rollerLast_mth  = self.arrayMonths[initMM - 1];                   // initMM and initDD are "one-based" real m and d values
        gbl_rollerLast_dd   = [NSString stringWithUTF8String: cString_dd  ];  // convert c string to NSString
//NSLog(@"gbl_rollerLast_yyyy =%@",gbl_rollerLast_yyyy );
//NSLog(@"gbl_rollerLast_mth  =%@",gbl_rollerLast_mth  );
//NSLog(@"gbl_rollerLast_dd   =%@",gbl_rollerLast_dd   );



    } while( false);  // populate array yearsToPickFrom2 for uiPickerView

NSLog(@"in viewDidAppear()");
} // end of viewDidAppear



- (void)viewWillAppear:(BOOL)animated
{
    trn("in viewWillAppear in MAMB09_sel DATE Controller2 ");

    // disable text field for year always
    //
    // If you use the above code, then if you navigate to another view
    // (detailed view) and come back then also the textField will be disabled.    

    //[textfield setEnable:NO];
    // self.outletPickedYear.enabled = NO;
    self.outletToSelecteDate.enabled = NO;  // note sp err

}

#pragma mark -  @protocol UIPickerViewDataSource   @required

// returns the number of 'columns' to display
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
//    return 3;  // y m d
    return 5;  // y m d
} // numberOfComponentsInPickerView


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
//    if (component == 0) return self.arrayMonths.count;
//    if (component == 1) return self.arrayDaysOfMonth.count;
//    if (component == 2) return yearsToPickFrom2.count;
    
    if (component == 0) return 1;
    if (component == 1) return self.arrayMonths.count;
    if (component == 2) return self.arrayDaysOfMonth.count;
    if (component == 3) return yearsToPickFrom2.count;
    if (component == 4) return 1;
    return 0;
    //NSLog(@"yearsToPickFrom2.count;=%lu",(unsigned long)yearsToPickFrom2.count);
} // numberOfRowsInComponent

#pragma mark -   @end of  @protocol UIPickerViewDataSource   @required




#pragma mark -  @protocol UIPickerViewDelegate   @optional


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row
                                                   forComponent: (NSInteger)component
{
    NSString *titleForRowRetval;
    titleForRowRetval =  @"component not 0,1, or 2";


    [[pickerView.subviews objectAtIndex:1] setBackgroundColor: gbl_colorDIfor_home];  // selection indicator lines
    [[pickerView.subviews objectAtIndex:2] setBackgroundColor: gbl_colorDIfor_home];
    
//    trn("in titleForRow in MAMB09_sel DATE Controller2 ");ki(component);ki(row);
//NSLog(@"row=%ld",(long)row);
//NSLog(@"component=%ld",(long)component);
//
//    if (component == 0)  titleForRowRetval = [self.arrayMonths      objectAtIndex: row];
//    if (component == 1)  titleForRowRetval = [self.arrayDaysOfMonth objectAtIndex: row];
//    if (component == 2)  titleForRowRetval = [yearsToPickFrom2      objectAtIndex: row];

//    if (component == 0) return @"XX";
    if (component == 0) return @"  ";
    if (component == 1)  titleForRowRetval = [self.arrayMonths      objectAtIndex: row];
    if (component == 2)  titleForRowRetval = [self.arrayDaysOfMonth objectAtIndex: row];
    if (component == 3)  titleForRowRetval = [yearsToPickFrom2      objectAtIndex: row];
//    if (component == 4) return @"XW";
    if (component == 4) return @"  ";

//NSLog(@"titleForRowRetval=%@",titleForRowRetval);
    return titleForRowRetval;

} // titleForRow



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow: (NSInteger)row
                                                forComponent: (NSInteger)component
                                                 reusingView: (UIView *) arg_view
{
//  NSLog(@"in viewForRow !!  in PICKER ");
//  NSLog(@"in viewForRow !!  in PICKER    row=%ld",(long)row);
//  NSLog(@"in viewForRow !!  in PICKER compon=%ld",(long)component);

    [[pickerView.subviews objectAtIndex:1] setBackgroundColor: gbl_colorDIfor_home];  // selection indicator lines
    [[pickerView.subviews objectAtIndex:2] setBackgroundColor: gbl_colorDIfor_home];

    UILabel *retvalUILabel = (id) arg_view;

    if (!retvalUILabel) {
        retvalUILabel= [[UILabel alloc] initWithFrame: CGRectMake(
            0.0f,
            0.0f,
            [pickerView rowSizeForComponent: component].width,
            [pickerView rowSizeForComponent: component].height
            )
        ];
    }

//    retvalUILabel.font = [UIFont systemFontOfSize: 14];
//    retvalUILabel.font = [UIFont systemFontOfSize: 20];
//    retvalUILabel.font = [UIFont systemFontOfSize: 24];
    retvalUILabel.font = [UIFont systemFontOfSize: 21];

    if (component == 0)  retvalUILabel.text = @"  ";
    if (component == 1)  retvalUILabel.text = [self.arrayMonths       objectAtIndex: row];
    if (component == 2)  retvalUILabel.text = [self.arrayDaysOfMonth  objectAtIndex: row];
    if (component == 3)  retvalUILabel.text = [yearsToPickFrom2       objectAtIndex: row];
    if (component == 4)  retvalUILabel.text = @"  ";
//  NSLog(@"retvalUILabel.text =[%@]",retvalUILabel.text );

//
//     // for picker row:  attributed text in view (uilabel)
//     //
//
//     // define string for view
//     //
//     NSString *myStringForView;
//     myStringForView = retvalUILabel.text;
//
//
//    // Define needed attributes for the entire allLabelExplaintext 
//    NSDictionary *myNeededAttribs = @{
//        //   e.g.
//        ////                                      NSForegroundColorAttributeName: self.label.textColor,
//        ////                                      NSBackgroundColorAttributeName: cell.textLabel.attributedText
//        ////                                      NSBackgroundColorAttributeName: cell.textLabel.textColor
//        //                                      NSFontAttributeName: cell.textLabel.font,
//        //                                      NSBackgroundColorAttributeName: cell.textLabel.backgroundColor
//        //                                      };
//        //
//        //            NSMutableAttributedString *myAttributedTextLabelExplain = 
//        //                [[NSMutableAttributedString alloc] initWithString: allLabelExplaintext
//        //                                                       attributes: myNeededAttribs     ];
//        //
////                NSBackgroundColorAttributeName: retvalUILabel.attributedText.backgroundColor
////        NSBackgroundColorAttributeName: retvalUILabel.backgroundColor
//          NSFontAttributeName: retvalUILabel.font
//    };
//    // define attributed string
//    NSMutableAttributedString *myAttributedTextLabel = [
//        [ NSMutableAttributedString alloc ] initWithString: myStringForView
//                                                attributes: myNeededAttribs   
//    ];
//
//    // set value of  attributed string
//    [ myAttributedTextLabel addAttribute: NSBackgroundColorAttributeName 
////                                           value: [UIColor yellowColor]
//                                   value: gbl_colorEditingBG_current
//
//
//                                   range: NSMakeRange(1, gbl_myCitySoFar.length)  // offset, length
//    ];
//
//    // set value of attributedText property of retvalUILabel
//    retvalUILabel.attributedText = myAttributedTextLabel;
//


    return retvalUILabel;

} // viewForRow in  picker



- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row
                                               inComponent: (NSInteger)component
{
    trn("in didSelectRow in MAMB09_sel DATE Controller2 ");
//NSLog(@"row=%ld",(long)row);
//NSLog(@"component=%ld",(long)component);

    NSInteger myNewIndex;
    int daysinmonth[12]={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int rollerMM, rollerDD, rollerYYYY;

    // build gbl_lastSelectedDay  "yyyymmdd"  from  roller values
    //
        NSString *mm_format;   // like "01" instead of "Jan"

        // set mm value  (could be changed if component = 0)
        NSInteger indexInMths = [self.arrayMonths indexOfObject: gbl_rollerLast_mth];
        mm_format = [NSString stringWithFormat:@"%02d",  (int) (indexInMths + 1)];    // mm is one-base, arr idx is zero-based

//        if (component == 0) {
        if (component == 1) {
            gbl_rollerLast_mth  = [self pickerView:  self.outletFor_YMD_picker  // like "Jan"
//                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 0 ]
//                                      forComponent: 0  ];
                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 1 ]
                                      forComponent: 1  ];
            mm_format = [NSString stringWithFormat:@"%02d",  (int) (row + 1)];    // mm is one-base, row is zero-based
        }
        if (component == 2) {
            gbl_rollerLast_dd   = [self pickerView:  self.outletFor_YMD_picker 
                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 2 ]
                                      forComponent: 2  ];
        }
        if (component == 3) {
            gbl_rollerLast_yyyy = [self pickerView:  self.outletFor_YMD_picker
                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 3 ]
                                      forComponent: 3  ];
        }


        // FIX ROLLER POSITION DATA
        // here we have all the changed roller data
        //
        // 1) invalid day of month on rollers
        //    IF the day of the month is more than the number of days in that month and year
        //       FIX THE DAY OF THE MONTH, gbl_rollerLast_dd,  to the real last day of that month
        //

        /// NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO   (due to privacy on birthdate)
        // 2) roller date is before date of birth
        //    
        //
        do {
            rollerMM   = [mm_format           intValue];
            rollerDD   = [gbl_rollerLast_dd   intValue]; 
            rollerYYYY = [gbl_rollerLast_yyyy intValue]; 
            //nki(rollerMM); ki(rollerDD); ki(rollerYYYY);

            // 1)  invalid day of month on rollers  m d y
            if (rollerYYYY % 400 == 0 || (rollerYYYY % 100 != 0 && rollerYYYY % 4 == 0)) daysinmonth[1] = 29; // if leap year, make 29 days in february
            if (rollerDD > daysinmonth[rollerMM-1]) {
                rollerDD = daysinmonth[rollerMM-1]; // day of month too big, make equal to last day in that month and year
                gbl_rollerLast_dd = [NSString stringWithFormat:@"%02d", rollerDD];

                // set the changed value on the day  roller
                myNewIndex = rollerDD - 1;               // initMM and initDD are "one-based" real m and d values
//                [self.outletFor_YMD_picker selectRow:myNewIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
                [self.outletFor_YMD_picker selectRow:myNewIndex inComponent: 2 animated:YES]; // This is how you manually SET(!!) a selection!
            }

//            // 2) roller date  m d y  is before date of birth
//            if (rollerYYYY == gbl_intBirthYear  &&
//                rollerMM    < gbl_intBirthMonth )  {   // put mth and dd rollers to BIRTHDATE
//
//                // set the changed value on the mth  roller
//                myNewIndex = gbl_intBirthMonth - 1;               // initMM and initDD are "one-based" real m and d values
//                [self.outletFor_YMD_picker selectRow: myNewIndex inComponent: 0 animated:YES]; // This is how you manually SET(!!) a selection!
//
//                // set the changed value on the day  roller
//                myNewIndex = gbl_intBirthDayOfMonth - 1;               // initMM and initDD are "one-based" real m and d values
//                [self.outletFor_YMD_picker selectRow: myNewIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
//
//
//                gbl_rollerLast_mth = self.arrayMonths[gbl_intBirthMonth - 1];
//                gbl_rollerLast_dd  = [NSString stringWithFormat:@"%02ld", (long)gbl_intBirthDayOfMonth];
//            }
//            if (rollerYYYY == gbl_intBirthYear  &&
//                rollerMM   == gbl_intBirthMonth &&
//                rollerDD    < gbl_intBirthDayOfMonth )  {   // put dd roller to birthdate
//
//                // set the changed value on the day  roller
//                myNewIndex = gbl_intBirthDayOfMonth - 1;               // initMM and initDD are "one-based" real m and d values
//                //kin((int)myNewIndex);
//                [self.outletFor_YMD_picker selectRow: myNewIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
//
//                gbl_rollerLast_dd = [NSString stringWithFormat:@"%02ld", (long)gbl_intBirthDayOfMonth];
//            }
//

        } while (FALSE);   // FIX ROLLER POSITION DATA
         


        // for remember  data  // fmt "yyyymmdd"
        gbl_lastSelectedDay =  [NSString stringWithFormat:@"%@%@%@",  // fmt "yyyymmdd"
            gbl_rollerLast_yyyy,
            mm_format,
            gbl_rollerLast_dd    ];  // "yyyymmdd"
            //NSLog(@"gbl_lastSelectedDay =%@",gbl_lastSelectedDay );


        // get day of week for screen
        //
        //char *N3_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""};
        NSArray *array_3letterDaysOfWeek = [[NSArray alloc]
            initWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil];
        int my_day_of_week_idx;
        my_day_of_week_idx = day_of_week(rollerMM, rollerDD, rollerYYYY);  // mambutil.c

        // show  selected day field on screen
        NSString *myFormattedStr =  [NSString stringWithFormat:@"%@  %@ %@, %@",  // fmt " Mon Dec 25,  2016"
            array_3letterDaysOfWeek[my_day_of_week_idx],
            gbl_rollerLast_mth,
            gbl_rollerLast_dd,
            gbl_rollerLast_yyyy  ];

        gbl_lastSelectedDayFormattedForEmail = myFormattedStr;  // save for email format


        NSString *myFormattedStr2 =  [NSString stringWithFormat:@"%@ %@, %@",  // fmt "Dec 25,  2016"
            gbl_rollerLast_mth,
            gbl_rollerLast_dd,
            gbl_rollerLast_yyyy  ];
        gbl_lastSelectedDayFormattedForTitle = myFormattedStr2;  // save for title format in tblrpts1



        UIFont *myFontForDate;
        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            myFontForDate = [UIFont boldSystemFontOfSize: 30.0];
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            myFontForDate = [UIFont boldSystemFontOfSize: 24.0];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            myFontForDate = [UIFont boldSystemFontOfSize: 21.0];
        }


        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.outletToSelecteDate.text = myFormattedStr;

            if ([gbl_lastSelectionType isEqualToString:@"person"]) {
                NSMutableAttributedString *myAttrDate;
                myAttrDate = [[NSMutableAttributedString alloc] initWithString: myFormattedStr
                    attributes : @{
        //                  NSParagraphStyleAttributeName : myParagraphStyle,
        //                   NSBackgroundColorAttributeName : gbl_color_cRed,
        //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                       NSForegroundColorAttributeName : [UIColor grayColor],
//                                  NSFontAttributeName : [UIFont boldSystemFontOfSize: 30.0]
                                  NSFontAttributeName : myFontForDate
                    }
                ];
                self.outletToSelecteDate.attributedText = myAttrDate;
            }
            if ([gbl_lastSelectionType isEqualToString:@"group" ]) {
                NSMutableAttributedString *myAttrDate;
                myAttrDate = [[NSMutableAttributedString alloc] initWithString: myFormattedStr
                    attributes : @{
        //                  NSParagraphStyleAttributeName : myParagraphStyle,
        //                   NSBackgroundColorAttributeName : gbl_color_cRed,
        //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                       NSForegroundColorAttributeName : [UIColor darkGrayColor],
//                                  NSFontAttributeName : [UIFont boldSystemFontOfSize: 30.0]
                                  NSFontAttributeName : myFontForDate
                    }
                ];
                self.outletToSelecteDate.attributedText = myAttrDate;
            }

        });

} // didSelectRow


-(bool) anySubViewScrolling: (UIView*)view
{
    //  NSLog(@"in anySubViewScrolling  in sel date !!");
    if( [ view isKindOfClass:[ UIScrollView class ] ] ) {
        UIScrollView* scroll_view = (UIScrollView*) view;
        if( scroll_view.dragging || scroll_view.decelerating ) return true;
    }

    for( UIView *sub_view in [ view subviews ] ) {
        if( [ self anySubViewScrolling:sub_view ] ) return true;
    }
    return false;
}



- (void) actionGoToReport
{
    NSLog(@"in actionGoToReport  in sel DATE");;


    // if the pickerview is scrolling right now, return
    //
    BOOL aSubViewIsScrolling;
//    aSubViewIsScrolling = [self anySubViewScrolling: self.view ];
//    aSubViewIsScrolling = [self anySubViewScrolling: pickerView ];
    aSubViewIsScrolling = [self anySubViewScrolling: self.outletFor_YMD_picker ];

  NSLog(@"aSubViewIsScrolling =[%ld]",(long)aSubViewIsScrolling );
    if(aSubViewIsScrolling == YES) return;



    // The report param selection has been made just now, so save it.
    //
    // get selected person's name
    //NSArray *myPSVarr = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]  ) {
        NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);


        [myappDelegate mamb_beginIgnoringInteractionEvents ];
   

        // gbl_lastSelectedYear is 1. remembered year (above) 2. default current year (above) or 3. didSelect year (spinner)

        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                          havingName: (NSString *) gbl_lastSelectedPerson
            updatingRememberCategory: (NSString *) @"day"
                          usingValue: (NSString *) gbl_lastSelectedDay
        ];
        
        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueSelDayToViewHTML" sender:self];
        });
    }
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]  ) {

//  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);  ?


        [myappDelegate mamb_beginIgnoringInteractionEvents ];


        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                          havingName: (NSString *) gbl_lastSelectedGroup
            updatingRememberCategory: (NSString *) @"day"
                          usingValue: (NSString *) gbl_lastSelectedDay
        ];
        
        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueSelDayToViewTBLRPT1" sender:self];
        });
    }


} // actionGoToReport


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


//
//// returns width of column and height of row for each component. 
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//} // widthForComponent
//
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//} // rowHeightForComponent
//
//
//// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
//// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
//// If you return back a different object, the old one will be released. the view will be centered in the row rect  
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
//                                                   forComponent:(NSInteger)component
//{
//} // titleForRow
//
//// attributed title is favored if both methods are implemented
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row
//                                                                       forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0)
//{
//} // attributedTitleForRow
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component
//                                                                             reusingView:(UIView *)view
//{
//} // viewForRow
//


#pragma mark -  @end of  @protocol UIPickerViewDelegate   @optional


@end


// old using uidatepicker
//- (void)datePickerChanged:(UIDatePicker *)datePicker
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
//    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
//    self.outletToSelecteDate.text = strDate;  // note sp err
//}
//

