//
//  MAMB09_selYearViewController.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-11-27.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>

NSMutableArray *yearsToPickFrom;  /* for pickerYearInLife */


@interface MAMB09_selYearViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>;

// now in gbl_fromHomeCurrentSelectionPSV
//@property (strong, nonatomic) NSString *fromHomeCurrentSelectionPSV;     // CSV  for per or grp or pair of people

//@property (strong, nonatomic) NSString *fromHomeCurrentSelectionType; // like "group" or "person" or "pair"
//@property (strong, nonatomic) NSString *fromHomeCurrentEntity;        // like "group" or "person" or "groupmember"
//// @property (strong, nonatomic) NSString *fromUserSecondPerson;         // CSV  for per or grp or pair of people
//
//@property (nonatomic)         NSInteger fromSelRptRowNumber;  // row in tableView
//@property (strong, nonatomic) NSString *fromSelRptRowString;  // like "Personality"
//
//@property (strong, nonatomic) NSString *selectedYear;           // from selYearViewController  yyyy
//@property (strong, nonatomic) NSString *selectedPersonFromAll;  // from selPersonFromAllViewController
//@property (strong, nonatomic) NSString *selectedGroup;          // from selGroupViewController
//@property (strong, nonatomic) NSString *selectedDay ;           // from selDayViewController  yyyymmdd
//@property (strong, nonatomic) NSString *selectedPersonFromPair; // from selPersonFromPairViewController


//@property (weak, nonatomic) IBOutlet UIPickerView *outletToPickerYear;
@property (weak, nonatomic) IBOutlet UIPickerView *outletYearPicker;
//
// The UIPicker has an outlet, so
// NOW we can reference that Picker View element
// from code in the ViewController using “self.picker”.

// @property (weak, nonatomic) IBOutlet UIPickerView *outletToYearPicker;
@property (weak, nonatomic) IBOutlet UITextField *outletPickedYear;
@property (weak, nonatomic) IBOutlet UILabel     *outletPersonName;


@end
