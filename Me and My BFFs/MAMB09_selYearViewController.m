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
    
    self.view.backgroundColor = gbl_colorSelParamForReports;
    // self.outletYearPicker.backgroundColor = [UIColor whiteColor];
    
    //_yearsToPickFrom = @[ @"1999", @"2000", @"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007", @"2008",  ];
    
    do {    // populate array yearsToPickFrom for uiPickerView and init picker and calendar year text field
        
        // get the current year
        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time
        NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
        gbl_currentYearInt = [dateComponents year];
        // NSString *yearStr = [@(gbl_currentYear) stringValue];  // convert integer to NSString
        
        // get the year of birth to start  from   gbl_fromHomeCurrentSelectionPSV 
        // get the year of birth to start  from   gbl_fromHomeRememberedPSV 


        NSArray *psvArray = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];


        NSString *psvYearOfBirth    = psvArray[3];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            self.outletPersonName.text       = psvArray[0];
        });
        
        NSInteger yearOfBirthInt = [psvYearOfBirth intValue];  // convert NSString to integer
        
        // for the picker, set yearsToPickFrom str array
        //
        [yearsToPickFrom removeAllObjects];
        yearsToPickFrom   = [[NSMutableArray alloc] init];
        
        for (NSInteger pickyr = yearOfBirthInt; pickyr <=  gbl_currentYearInt + 1; pickyr++) {  // only allow to go to next calendar year
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
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
                // self.outletPickedYear.text = [@(gbl_currentYearInt) stringValue];
                self.outletYearSelected.text = [@(gbl_currentYearInt) stringValue];
            });
        } else {   
            gbl_lastSelectedYear           = psvRememberedYear;
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
                //self.outletPickedYear.text = psvRememberedYear;
                self.outletYearSelected.text = psvRememberedYear;
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

- (IBAction)actionDoReport:(id)sender {    // take  the global report specs and do ViewHTML
    
    NSLog(@"in actionDoReport!");

    // The report param selection has been made just now, so save it.
    //
    // get selected person's name
    NSArray *myPSVarr = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];

    NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);

    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                      havingName: (NSString *) myPSVarr[0]
        updatingRememberCategory: (NSString *) @"year"
                      usingValue: (NSString *) gbl_lastSelectedYear
    ];

    
    
    //[yearsToPickFrom addObject: [@(pickyr) stringValue] ];

    
    // Because background threads are not prioritized and will wait a very long time
    // before you see results, unlike the mainthread, which is high priority for the system.
    //
    // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
    //
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
        [self performSegueWithIdentifier:@"segueSelYearToViewHTML" sender:self];
    });

}

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
                                titleForRow: [_outletYearPicker selectedRowInComponent:0]
                               forComponent: 0
    ];
    
    // self.outletPickedYear.text = gbl_lastSelectedYear;
    self.outletYearSelected.text = gbl_lastSelectedYear;


    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                      havingName: (NSString *) gbl_lastSelectedPerson
        updatingRememberCategory: (NSString *) @"year"
                      usingValue: (NSString *) gbl_lastSelectedYear
    ];



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




@end
