//
//  MAMB09_selDateViewController2.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-02-08.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>

NSMutableArray *yearsToPickFrom2;  /* for pickerYearInLife */


@interface MAMB09_selDateViewController2 : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel      *outletToSelecteDate;
@property (weak, nonatomic) IBOutlet UIPickerView *outletFor_YMD_picker;
@property (weak, nonatomic) IBOutlet UILabel      *outletPersonName;

@property (strong, nonatomic)          NSArray        *arrayMonths;
@property (strong, nonatomic)          NSMutableArray *arrayDaysOfMonth;
@property (strong, nonatomic)          NSMutableArray *arrayYears;

@end
