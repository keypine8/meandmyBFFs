//
//  MAMB09_selYearViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-11-27.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09_selYearViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


@implementation MAMB09_selYearViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();
    trn("in viewDidLoad in MAMB09_selYearViewController ");

    self.outletYearPicker.delegate = self;
    self.outletYearPicker.dataSource = self;
    
//    self.view.backgroundColor = gbl_colorSelParamForReports;
    if ([gbl_lastSelectionType isEqualToString:@"person"]) [self.view setBackgroundColor: gbl_colorHomeBG_per];
    if ([gbl_lastSelectionType isEqualToString:@"group" ]) [self.view setBackgroundColor: gbl_colorHomeBG_grp];
    // self.outletYearPicker.backgroundColor = [UIColor whiteColor];
    

    // set up navigation bar  right button  "Report >"
    //
//        UIImage *myImage = [[UIImage imageNamed: @"ReportArrow_14.png"]
//                         imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];
//        UIBarButtonItem *_goToReportButton = [[UIBarButtonItem alloc]initWithImage: myImage
//                                                                             style: UIBarButtonItemStylePlain 
//                                                                            target: self 
//                                                                            action: @selector(actionDoReport)];
//        self.navigationItem.rightBarButtonItem = _goToReportButton;
//

    // set up navigation bar  right button  ">" in image format
    // UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_029.png"]
    // UIImage *myImage = [[UIImage imageNamed: @"iconLeftArrowBlue_66"]
    //                     imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

//        UIImage *myImage = [[UIImage imageNamed: @"forwardArrow_01.png"]
//        UIImage *myImage = [UIImage imageNamed: @"forwardArrow_01.png" inBundle: nil compatibleWithTraitCollection: nil ];


//    UIImage *myImage = [[UIImage imageNamed: @"iconLeftArrowBlue_66"]
    UIImage *myImage = [[UIImage imageNamed: @"iconChevronRight_66"]
                     imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal ];

//    UIBarButtonItem *_goToReportButton = [[UIBarButtonItem alloc]initWithImage: gbl_chevronRight
    UIBarButtonItem *_goToReportButton = [[UIBarButtonItem alloc]initWithImage: myImage
                                                                         style: UIBarButtonItemStylePlain 
                                                                        target: self 
                                                                        action: @selector(actionDoReport)];



//    [[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(15, 15) forBarMetrics:UIBarMetricsDefault];


//      UIImageView *myImageView = [[UIImageView alloc] initWithImage: myImage] ;
//
//      UIBarButtonItem *_goToReportButton = [[UIBarButtonItem alloc] initWithCustomView: myImageView];
//      CGRect myrect = myImageView.frame;
//      CGFloat y_value;
//      y_value           = [myImageView frame].origin.y ;
//      myrect.origin.y   = y_value + 20.0;
//      myImageView.frame = myrect;


    // set up label for  self.navigationItem.titleView 
    //
//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

    UILabel *mySelDate_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];


    NSString *myNavBar2lineTitle;
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"] ) { // calendar year
        myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nSelect year", gbl_lastSelectedPerson ];
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"] ) { // best year
        myNavBar2lineTitle  = [NSString stringWithFormat:  @"%@\nSelect year", gbl_lastSelectedGroup ];
    }

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
//        [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, 0, -8.0, 0)];  // too  low
//        [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, 0,  8.0, 0)];  // too  high
//        [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, 0, -4.0, 0)];  // bit  low
        [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, 0, -2.0, 0)];  //

    });


    
    do {    // populate array yearsToPickFrom for uiPickerView and init picker and calendar year text field
        
        // get the current year
        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time
        //        NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear)
                                                        fromDate:[NSDate date]  ];

        
        gbl_currentYearInt = [dateComponents year];
        // NSString *yearStr = [@(gbl_currentYear) stringValue];  // convert integer to NSString
        
        // get the year of birth to start  from   gbl_fromHomeCurrentSelectionPSV 


        // NSArray *psvArray = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];


        //NSString *psvYearOfBirth    = psvArray[3];

        // name now in nav bar title
        //        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        //            self.outletPersonName.text       = psvArray[0];
        //        });
        //
        
        //NSInteger yearOfBirthInt = [psvYearOfBirth intValue];  // convert NSString to integer
        
        // for the picker, set yearsToPickFrom str array
        //
        [yearsToPickFrom removeAllObjects];
        yearsToPickFrom   = [[NSMutableArray alloc] init];
        
        //for (NSInteger pickyr = yearOfBirthInt; pickyr <=  gbl_currentYearInt + 1; pickyr++)   // only allow to go to next calendar year
        for (NSInteger pickyr = gbl_earliestYear; pickyr <=  gbl_currentYearInt + 1; pickyr++) {  // only allow to go to next calendar year
            [yearsToPickFrom addObject: [@(pickyr) stringValue] ];
        }
        //NSLog(@"yearsToPickFrom.count=%lu",(unsigned long)yearsToPickFrom.count);
        
        
        // INIT  CALENDAR YEAR text field
        //
        // 1.  set the year-picked field to remembered year picked, unless
        // there is no remembered value because there isn't one yet or else at App start
        //
        // 2.  set the Picker's selected field to the same year
        //

        // get remembered year, if present
        //
        //NSString *psvRememberedYear = psvArray[10];  // know remembered year is 11th element

// old way (hard code)
//        NSString *myRemPSV   = gbl_arrayPerRem[gbl_fromHomeCurrentSelectionArrayIdx];
//        NSArray  *myRemArray = [myRemPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
//        NSString *psvRememberedYear = myRemArray[2];  // year is field # 3 one-based
//
        NSString *psvRememberedYear;
        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
        psvRememberedYear = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"person"
                                                                havingName: (NSString *) gbl_fromHomeCurrentEntityName 
                                                      fromRememberCategory: (NSString *) @"year"  ];


        NSLog(@"gbl_fromHomeCurrentEntityName =%@",gbl_fromHomeCurrentEntityName );
        NSLog(@"psvRememberedYear=%@", psvRememberedYear);


        if (psvRememberedYear == NULL || [psvRememberedYear intValue] == 0) {
            gbl_lastSelectedYear           = [@(gbl_currentYearInt) stringValue];
//  NSLog(@"gbl_colorDIfor_home=[%@]",gbl_colorDIfor_home);

            dispatch_async(dispatch_get_main_queue(), ^{
                    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
                        NSMutableAttributedString *myAttrYear;
                        myAttrYear = [[NSMutableAttributedString alloc] initWithString:  [@(gbl_currentYearInt) stringValue]
                            attributes : @{
                //                  NSParagraphStyleAttributeName : myParagraphStyle,
                //                   NSBackgroundColorAttributeName : gbl_color_cRed,
                //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                               NSForegroundColorAttributeName : [UIColor grayColor],
                                          NSFontAttributeName : [UIFont boldSystemFontOfSize: 36.0]
                            }
                        ];
                        self.outletYearSelected.attributedText = myAttrYear;
                    }
                    if ([gbl_lastSelectionType isEqualToString:@"group" ]) {
                        NSMutableAttributedString *myAttrYear;
                        myAttrYear = [[NSMutableAttributedString alloc] initWithString:   [@(gbl_currentYearInt) stringValue]
                            attributes : @{
                //                  NSParagraphStyleAttributeName : myParagraphStyle,
                //                   NSBackgroundColorAttributeName : gbl_color_cRed,
                //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                               NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                          NSFontAttributeName : [UIFont boldSystemFontOfSize: 36.0]
                            }
                        ];
                        self.outletYearSelected.attributedText = myAttrYear;
                    }

                // self.outletPickedYear.text = [@(gbl_currentYearInt) stringValue];
//                self.outletYearSelected.text = [@(gbl_currentYearInt) stringValue];
//                self.outletYearSelected.textColor = gbl_colorDIfor_home;
//                [self.outletYearSelected setTextColor: gbl_colorDIfor_home];
            });
        } else {   
//            gbl_lastSelectedYear           = psvRememberedYear;
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>

                if ([gbl_lastSelectionType isEqualToString:@"person"]) {
                    NSMutableAttributedString *myAttrYear;
                    myAttrYear = [[NSMutableAttributedString alloc] initWithString: psvRememberedYear
                        attributes : @{
            //                  NSParagraphStyleAttributeName : myParagraphStyle,
            //                   NSBackgroundColorAttributeName : gbl_color_cRed,
            //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                           NSForegroundColorAttributeName : [UIColor grayColor],
                                      NSFontAttributeName : [UIFont boldSystemFontOfSize: 36.0]
                        }
                    ];
                    self.outletYearSelected.attributedText = myAttrYear;
                }
                if ([gbl_lastSelectionType isEqualToString:@"group" ]) {
                    NSMutableAttributedString *myAttrYear;
                    myAttrYear = [[NSMutableAttributedString alloc] initWithString: psvRememberedYear
                        attributes : @{
            //                  NSParagraphStyleAttributeName : myParagraphStyle,
            //                   NSBackgroundColorAttributeName : gbl_color_cRed,
            //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                           NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                      NSFontAttributeName : [UIFont boldSystemFontOfSize: 36.0]
                        }
                    ];
                    self.outletYearSelected.attributedText = myAttrYear;
                }

//                self.outletYearSelected.text = psvRememberedYear;
//                self.outletYearSelected.textColor = gbl_colorDIfor_home;
            });
        }
        
        // INIT  PICKER
        // in picker set the roller to gbl_lastSelectedYear
        // find out the rownumber of gbl_lastSelectedYear in yearToPickFrom
        //
        NSInteger myIndex = [yearsToPickFrom indexOfObject: gbl_lastSelectedYear];
        if (myIndex == NSNotFound) {
            // second last elt should be current year
            myIndex = yearsToPickFrom.count - 2;
        }
        // This is how you manually SET(!!) a selection!
        [self.outletYearPicker selectRow:myIndex inComponent:0 animated:YES];

    } while( false);  // populate array yearsToPickFrom for uiPickerView

    
    //NSLog(@"_selYearfromHomeCurrentSelection=%@",self.fromHomeCurrentSelectionPSV);            // CSV  for per or grp or pair of people
    NSLog(@"_selYearfromHomeCurrentSelection=%@",gbl_fromHomeCurrentSelectionPSV);            // CSV  for per or grp or pair of people
    
    NSLog(@"_selYear gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);    // like "group" or "person" or "pair"
    NSLog(@"_selYear gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);                  // like "group" or "person"

    // Use table view disclosure indicator style for uibutton ios
    // http://stackoverflow.com/questions/13836606/use-table-view-disclosure-indicator-style-for-uibutton-ios
    // This can be done entirely with code by placing a UITableViewCell with the
    // disclosure indicator within a UIButton:
    //    nb(10);
    //    UITableViewCell *disclosure = [[UITableViewCell alloc] init];
    //    nb(11);
    //
    //    [_buttonDoReport addSubview:disclosure];
    //    nb(12);
    //
    //    disclosure.frame = _buttonDoReport.bounds;
    //    disclosure.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    disclosure.userInteractionEnabled = NO;
    
} // end of viewDidLoad 



- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
NSLog(@"in viewDidAppear()");
} // end of viewDidAppear



- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"selyear viewWillAppear");

    // disable text field for year always
    //
    // If you use the above code, then if you navigate to another view
    // (detailed view) and come back then also the textField will be disabled.    

    //[textfield setEnable:NO];
    // self.outletPickedYear.enabled = NO;
    self.outletYearSelected.enabled = NO;
    
}


-(bool) anySubViewScrolling: (UIView*)view
{
  NSLog(@"in anySubViewScrolling !!");
    if( [ view isKindOfClass:[ UIScrollView class ] ] ) {
        UIScrollView* scroll_view = (UIScrollView*) view;
        if( scroll_view.dragging || scroll_view.decelerating ) return true;
    }

    for( UIView *sub_view in [ view subviews ] ) {
        if( [ self anySubViewScrolling:sub_view ] ) return true;
    }
    return false;
}



//- (IBAction)actionDoReport:(id)sender {    // take  the global report specs and do ViewHTML
- (void)actionDoReport {    // take  the global report specs and do ViewHTML
    
    NSLog(@"in actionDoReport!");


    // if the pickerview is scrolling right now, return
    //
    BOOL aSubViewIsScrolling;
//    aSubViewIsScrolling = [self anySubViewScrolling: self.view ];
    aSubViewIsScrolling = [self anySubViewScrolling: self.outletYearPicker ];


  NSLog(@"aSubViewIsScrolling =[%ld]",(long)aSubViewIsScrolling );
    if(aSubViewIsScrolling == YES) return;



    // The report param selection has been made just now, so save it.
    //
    // get selected person's name
    //NSArray *myPSVarr = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];

    NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"]  // calendar year
    ) {
        [myappDelegate mamb_beginIgnoringInteractionEvents ];

        // gbl_lastSelectedYear is 1. remembered year (above) 2. default current year (above) or 3. didSelect year (spinner)
        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                          havingName: (NSString *) gbl_lastSelectedPerson
            updatingRememberCategory: (NSString *) @"year"
                          usingValue: (NSString *) gbl_lastSelectedYear
        ];

        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueSelYearToViewHTML" sender:self];
        });
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]  // best year
    ) {
        [myappDelegate mamb_beginIgnoringInteractionEvents ];

        // gbl_lastSelectedYear is 1. remembered year (above) 2. default current year (above) or 3. didSelect year (spinner)
        MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                          havingName: (NSString *) gbl_lastSelectedPerson
            updatingRememberCategory: (NSString *) @"year"
                          usingValue: (NSString *) gbl_lastSelectedYear
        ];

        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueSelYearToViewTBLRPT1" sender:self];
        });
    }

} // actionDoReport



// implement methods for  <UIPickerViewDataSource, UIPickerViewDelegate>
//
// The number of columns of data in picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  //req'd
{
    //NSLog(@"picker in numberOfComponentsInPickerView!");
    
    return 1;
}

// The number of rows of data in picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  // req'd
{
    //NSLog(@"picker in numberOfRowsInComponent!");
    //NSLog(@"yearsToPickFrom.count=%lu",(unsigned long)yearsToPickFrom.count);
    
    return yearsToPickFrom.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component   // opt
{
    // NSLog(@"picker in titleForRow!");
    [[pickerView.subviews objectAtIndex:1] setBackgroundColor: gbl_colorDIfor_home];  // selection indicator lines
    [[pickerView.subviews objectAtIndex:2] setBackgroundColor: gbl_colorDIfor_home];
    
    return [yearsToPickFrom objectAtIndex: row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component   // opt
{
    // tn();tn();trn("??????");
    // NSLog(@"in didSelectRow in Year Picker!");
    
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    // NSLog(@"row=%ld",row);
    // NSLog(@"component=%ld",component);
    
    //   NSLog(@"[_outletToYearPicker selectedRowInComponent:0]=%ld",(long)[_outletToYearPicker selectedRowInComponent:0]);
    
    gbl_lastSelectedYear = [self pickerView: _outletYearPicker
                                titleForRow: [_outletYearPicker selectedRowInComponent: 0]
                               forComponent: 0
    ];
    
    // self.outletPickedYear.text = gbl_lastSelectedYear;

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//        self.outletYearSelected.text      = gbl_lastSelectedYear;
//        self.outletYearSelected.textColor = gbl_colorDIfor_home;


        if ([gbl_lastSelectionType isEqualToString:@"person"]) {
            NSMutableAttributedString *myAttrYear;
            myAttrYear = [[NSMutableAttributedString alloc] initWithString: gbl_lastSelectedYear
                attributes : @{
    //                  NSParagraphStyleAttributeName : myParagraphStyle,
    //                   NSBackgroundColorAttributeName : gbl_color_cRed,
    //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                   NSForegroundColorAttributeName : [UIColor grayColor],
                              NSFontAttributeName : [UIFont boldSystemFontOfSize: 36.0]
                }
            ];
            self.outletYearSelected.attributedText = myAttrYear;
        }
        if ([gbl_lastSelectionType isEqualToString:@"group" ]) {
            NSMutableAttributedString *myAttrYear;
            myAttrYear = [[NSMutableAttributedString alloc] initWithString: gbl_lastSelectedYear
                attributes : @{
    //                  NSParagraphStyleAttributeName : myParagraphStyle,
    //                   NSBackgroundColorAttributeName : gbl_color_cRed,
    //               NSForegroundColorAttributeName : gbl_colorDIfor_home,
                   NSForegroundColorAttributeName : [UIColor darkGrayColor],
                              NSFontAttributeName : [UIFont boldSystemFontOfSize: 36.0]
                }
            ];
            self.outletYearSelected.attributedText = myAttrYear;
        }

    });


//    // now, in gbl_arrayPer , update array idx gbl_fromHomeCurrentSelectionArrayIdx with the  new Remembered Year
//    //
//    // update delimited string  for saving selection in remember fields
//    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
//    NSString *myStrToUpdate = gbl_arrayPer[gbl_fromHomeCurrentSelectionArrayIdx];
//    NSString *myupdatedStr =
//    [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
//                             delimitedBy: (NSString *) @"|"
//                updateOneBasedElementNum: (NSInteger)  11
//                          withThisString: (NSString *) @"not locked"
//     ];
//    gbl_arrayPer[gbl_fromHomeCurrentSelectionArrayIdx] = myupdatedStr;
//    while (FALSE);
//
//    
////    NSArray *psvArray = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
////    NSMutableArray * psvMutableArray= [NSMutableArray arrayWithArray: psvArray];
////    psvMutableArray[10] = gbl_lastSelectedYear;  // know remembered year is 11th element
////    NSString *updatedPSV = [psvMutableArray componentsJoinedByString: @"|"];
//
//    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//        [gbl_arrayPer replaceObjectAtIndex: gbl_fromHomeCurrentSelectionArrayIdx
//                                withObject: myupdatedStr
//        ];
//    });
//
//    gbl_fromHomeCurrentSelectionPSV = myupdatedStr;

} // didSelectRow


//
// end of implement methods for  <UIPickerViewDataSource, UIPickerViewDelegate>



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


@end
