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


    self.outletFor_YMD_picker.delegate   = self;
    self.outletFor_YMD_picker.dataSource = self;
    
    self.view.backgroundColor = gbl_colorSelParamForReports;


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
        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_029.png"]
                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

//        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_01.png"]
//        UIImage *myImage = [UIImage imageNamed: @"forwardArrow_01.png" inBundle: nil compatibleWithTraitCollection: nil ];

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

    // TWO-LINE NAV BAR TITLE
    //
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        self.navigationItem.rightBarButtonItem = _goToReportButton;
        self.navigationItem.titleView           = mySelDate_Label; // mySelDate_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
    });





    self.arrayMonths      = [[NSArray alloc]
        initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.arrayDaysOfMonth = [[NSMutableArray alloc]init];
    //self.arrayYears       = [[NSMutableArray alloc]init];
 
    for (int i = 1; i <= 31; i++) {
        [self.arrayDaysOfMonth addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    //NSLog(@"self.arrayMonths=%@",self.arrayMonths);

    do {    // populate array yearsToPickFrom2 for uiPickerView and init picker and init calendar year text field  (130 lines)
 
        // get the current year
        //
        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time
       //         NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear)

                                                        fromDate:[NSDate date]];
        gbl_currentYearInt  = [dateComponents year];
        gbl_currentMonthInt = [dateComponents month];
        gbl_currentDayInt   = [dateComponents day];
        //NSLog(@"gbl_currentYearInt  =%ld",(long)gbl_currentYearInt  );
        //NSLog(@"gbl_currentMonthInt =%ld",(long)gbl_currentMonthInt );
        //NSLog(@"gbl_currentDayInt   =%ld",(long)gbl_currentDayInt   );
        
        
        gbl_currentDay_yyyymmdd = [NSString stringWithFormat:@"%04ld%02ld%02ld",
                                       (long)gbl_currentYearInt,
                                       (long)gbl_currentMonthInt,
                                       (long)gbl_currentDayInt     ];

        
        
        // get the date of birth  for starting point from   gbl_fromHomeCurrentSelectionPSV


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
            int initYYYY,  initMM,  initDD;  // initMM and initDD are "one-based" real m and d values
            if (psvRememberedDate == NULL || [psvRememberedDate intValue] == 0) {

                initYYYY = (int) gbl_currentYearInt;   // use  today's date if no remembered date
                initMM   = (int) gbl_currentMonthInt;
                initDD   = (int) gbl_currentDayInt;
                gbl_lastSelectedDay         = [NSString stringWithFormat:@"%04ld%02ld%02ld",
                                                (long)gbl_currentYearInt,
                                                (long)gbl_currentMonthInt,
                                                (long)gbl_currentDayInt     ];  // yyyymmdd
            } else {   

                gbl_lastSelectedDay         =  psvRememberedDate;   // yyyymmdd
                NSString *lastSelectedYear  = [psvRememberedDate substringWithRange:NSMakeRange(0, 4)];
                NSString *lastSelectedMonth = [psvRememberedDate substringWithRange:NSMakeRange(4, 2)];
                NSString *lastSelectedDay   = [psvRememberedDate substringWithRange:NSMakeRange(6, 2)];
                initYYYY = [lastSelectedYear  intValue];
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

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            self.outletToSelecteDate.text = myInitDateFormatted;
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
        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 0 animated:YES]; // This is how you manually SET(!!) a selection!

        myIndex = initDD - 1; // initMM and initDD are "one-based" real m and d values
        if (myIndex == NSNotFound) {
            // second last elt should be current year
            myIndex = 0;
        }
        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!


        NSString* myInitYear = [NSString stringWithFormat:@"%i", initYYYY];  // convert c int to NSString
        myIndex = [yearsToPickFrom2 indexOfObject: myInitYear];
        if (myIndex == NSNotFound) {
            // second last elt should be current year
            myIndex = yearsToPickFrom2.count - 2;
        }
        [self.outletFor_YMD_picker selectRow:myIndex inComponent: 2 animated:YES]; // This is how you manually SET(!!) a selection!


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




// old using uidatepicker
//    [self.outletToDatePicker  addTarget:self
//                                 action:@selector(datePickerChanged:)
//                       forControlEvents:UIControlEventValueChanged];
//


} // viewDidLoad

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
    return 3;  // y m d
} // numberOfComponentsInPickerView


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (component == 0) return self.arrayMonths.count;
    if (component == 1) return self.arrayDaysOfMonth.count;
    if (component == 2) return yearsToPickFrom2.count;
    
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

//    trn("in titleForRow in MAMB09_sel DATE Controller2 ");ki(component);ki(row);
//NSLog(@"row=%ld",(long)row);
//NSLog(@"component=%ld",(long)component);
//
    if (component == 0)  titleForRowRetval = [self.arrayMonths      objectAtIndex: row];
    if (component == 1)  titleForRowRetval = [self.arrayDaysOfMonth objectAtIndex: row];
    if (component == 2)  titleForRowRetval = [yearsToPickFrom2      objectAtIndex: row];

//NSLog(@"titleForRowRetval=%@",titleForRowRetval);
    return titleForRowRetval;

} // titleForRow


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

        if (component == 0) {
            gbl_rollerLast_mth  = [self pickerView:  self.outletFor_YMD_picker  // like "Jan"
                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 0 ]
                                      forComponent: 0  ];
            mm_format = [NSString stringWithFormat:@"%02d",  (int) (row + 1)];    // mm is one-base, row is zero-based
        }
        if (component == 1) {
            gbl_rollerLast_dd   = [self pickerView:  self.outletFor_YMD_picker 
                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 1 ]
                                      forComponent: 1  ];
        }
        if (component == 2) {
            gbl_rollerLast_yyyy = [self pickerView:  self.outletFor_YMD_picker
                                       titleForRow: [self.outletFor_YMD_picker  selectedRowInComponent: 2 ]
                                      forComponent: 2  ];
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
                [self.outletFor_YMD_picker selectRow:myNewIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
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



        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            self.outletToSelecteDate.text = myFormattedStr;
        });

} // didSelectRow


- (void) actionGoToReport
{
    NSLog(@"in actionGoToReport  in sel DATE");;

    // The report param selection has been made just now, so save it.
    //
    // get selected person's name
    //NSArray *myPSVarr = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];



//    NSArray *psvArray;
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]  ) {
        NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);

        // gbl_lastSelectedYear is 1. remembered year (above) 2. default current year (above) or 3. didSelect year (spinner)
        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
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


        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
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

